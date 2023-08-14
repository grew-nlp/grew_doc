#!/usr/bin/env python3

import json
import base64
import pathlib
import re
import nbconvert

from nbconvert.exporters.markdown import MarkdownExporter
from traitlets.config import Config
from nbconvert.preprocessors import Preprocessor

DUPLICATE_NEWLINES_RE = re.compile(r"\n\n\n+", flags=re.MULTILINE)
ROOT_DIR = pathlib.Path(__file__).parent
POSTS_DIR = ROOT_DIR / "content" / "posts"

def remove_duplicate_newlines(content: str) -> str:
    return DUPLICATE_NEWLINES_RE.sub("\n\n", content)

def fix_image_links(content: str) -> str:
    # They come from nbconvert looking like '[image](...)', so just
    # remove the '' part
    return content.replace("", "")

def fix_front_matter(content: str) -> str:
    # Make front matter use --- instead of ```
    content = content.split("\n")
    code_fences = []
    for i in range(0, min(10, len(content))):
        if content[i].strip() == "```":
            code_fences.append(i)

    if len(code_fences) < 2:
        raise RuntimeError(
            f"front matter not found first 10 lines of  in '{notebook_path}'"
        )

    for line in code_fences[:2]:
        content[line] = content[line].replace("```", "---")

    return "\n".join(content)

class ExtractImages(Preprocessor):
    """Pull out images from notebook"""

    def preprocess(self, nb, resources):
        # Find all attachments
        attachments = []
        for cell in nb.cells:
            if "attachments" in cell:
                attachments.append(cell["attachments"])

        # Write out base64 images as files
        for attachment in attachments:
            for image_name, img_data in attachment.items():
                for img_type, base64_code in img_data.items():
                    if img_type == "image/png":
                        bytes = base64.b64decode(base64_code)
                        resources["outputs"][image_name] = bytes

        return nb, resources

if __name__ == "__main__":
    notebook_paths = POSTS_DIR.glob("*/*.ipynb")
    c = Config()
    c.RegexRemovePreprocessor.patterns = ["\s*\Z"]
    c.MarkdownExporter.preprocessors = [
        ExtractImages,
        "nbconvert.preprocessors.RegexRemovePreprocessor",
    ]
    exporter = nbconvert.MarkdownExporter(config=c)

    for notebook_path in notebook_paths:
        with open(notebook_path, "r") as f:
            data = json.load(f)

        # Export to markdown via nbconvert
        md_path = notebook_path.with_suffix(".md")
        md_content, resources = exporter.from_filename(str(notebook_path))

        # Write the images to disk
        for filename, content in resources["outputs"].items():
            with open(notebook_path.parent / filename, "wb") as f:
                f.write(content)

        # Run some processors over the text
        filters = [
            fix_image_links,
            fix_front_matter,
            remove_duplicate_newlines,
        ]

        for filter in filters:
            md_content = filter(md_content)

        # Write out the new content
        md_path = md_path.parent / "index.md"
        with open(md_path, "w") as f:
            f.write(md_content.strip() + "\n")
        print(f"Wrote {md_path}")


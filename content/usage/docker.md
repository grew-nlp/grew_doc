+++
title = "docker"
menu = "main"
Categories = ["Development","GoLang"]
Tags = ["Development","golang"]
Description = ""
date = "2018-04-25T16:59:27+02:00"

+++

# Docker installation

Put the following code in a file called `Dockerfile`.
```
FROM ocaml/opam:ubuntu

RUN sudo apt-get update \
		&& sudo apt-get upgrade --assume-yes \
		&& sudo apt-get install python3-pip --assume-yes

RUN opam remote add grew "http://opam.grew.fr" \
		&& opam install grew grewpy \
		&& pip3 install grew
```

Then, you can build the image with the command:

`docker build -t grew .`

And finally, run it with:

`docker run -it grew bash`

## Test

Inside a container (after the command `docker run -it grew bash`), run:

 * `python3`
 * `import grew`
 * `grew.init()`

You should have an output like:

```
connected to port: 8888
<subprocess.Popen object at 0x7ff507bc5208>
```

and **Grew** is ready to be used.
See [run Python library](../tuto) page for simple examples.

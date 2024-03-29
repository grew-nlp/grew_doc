#!/usr/bin/env python3
import sys
from utils import *

print ('========== [ping]')
ping ()

project_id = "__gst__package"
sample_id = "single"
sample_ids = f'["{sample_id}"]'
conll_file = "fr-ud-dev_00002.conllu"

print ('========== [eraseProject]')
print ('       ... project_id -> ' + project_id)
reply = send_request ('eraseProject', data={'project_id': project_id})
check_reply (reply, None)

print ('========== [newProject]')
print ('       ... project_id -> ' + project_id)
reply = send_request ('newProject', data={'project_id': project_id})
check_reply (reply, None)

print ('========== [newSamples]')
print ('       ... project_id -> ' + project_id)
print ('       ... sample_ids -> ' + sample_ids)
reply = send_request ('newSamples', data={'project_id': project_id, 'sample_ids': sample_ids })
check_reply (reply, None)

print ('========== [saveConll] ')
print ('       ... project_id -> ' + project_id)
print ('       ... sample_id -> ' + sample_id)
print ('       ... conll_file -> ' + conll_file)
with open(conll_file, 'rb') as f:
    reply = send_request (
        'saveConll',
        data = {'project_id': project_id, 'sample_id': sample_id },
        files={'conll_file': f},
    )
check_reply (reply, None)

sample_ids = "[\"single\"]"
user_ids = '{ "one": ["ud"] }'
rule1 = "rule r1 { pattern { X [upos=VERB] } commands { X.upos=V } }"
rule2 = "rule r2 { pattern { e: X -[subj]-> Y } commands { del_edge e; add_edge X -[SUBJ]-> Y } }"
package = "\n".join ([rule1, rule2])

print('========== [tryPacakge]')
print('       ... project_id -> %s' % project_id)
print('       ... sample_ids -> %s' % sample_ids)
print('       ... user_ids -> %s' % user_ids)
print('       ... package -> %s' % package)
reply = send_request(
    'tryPackage',
    data={'project_id': project_id, 'package': package, 'sample_ids': sample_ids, 'user_ids': user_ids}
)

with open("_build/output.conllu", "w") as outfile:
    outfile.write(reply["data"][0]["conll"])

reply["data"][0]["conll"] = "..."
with open("_build/output.json", "w") as outfile:
    outfile.write(json.dumps(reply["data"], indent = 4))



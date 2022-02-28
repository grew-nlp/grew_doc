#!/usr/bin/env python3
import sys
from utils import *

print ('========== [ping]')
ping ()

project_id = "__gst__package"
sample_id = "single"
conll_file = "fr-ud-dev_00002.conllu"
user_id = "ud"

print ('========== [eraseProject]')
print ('       ... project_id -> ' + project_id)
reply = send_request ('eraseProject', data={'project_id': project_id})
check_reply (reply, None)

print ('========== [newProject]')
print ('       ... project_id -> ' + project_id)
reply = send_request ('newProject', data={'project_id': project_id})
check_reply (reply, None)

print ('========== [newSample]')
print ('       ... project_id -> ' + project_id)
print ('       ... sample_id -> ' + sample_id)
reply = send_request ('newSample', data={'project_id': project_id, 'sample_id': sample_id })
check_reply (reply, None)

print ('========== [saveConll] ')
print ('       ... project_id -> ' + project_id)
print ('       ... sample_id -> ' + sample_id)
print ('       ... user_id -> ' + user_id)
print ('       ... conll_file -> ' + conll_file)
with open(conll_file, 'rb') as f:
    reply = send_request (
        'saveConll',
        data = {'project_id': project_id, 'sample_id': sample_id, 'user_id': user_id },
        files={'conll_file': f},
    )
check_reply (reply, None)

sample_ids = "[\"single\"]"
user_ids = "\"all\""
rule1 = "rule r1 { pattern { N [upos=VERB] } commands { N.upos=V } }"
rule2 = "rule r2 { pattern { e: N -[subj]-> M } commands { del_edge e; add_edge N -[SUBJ]-> M } }"
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



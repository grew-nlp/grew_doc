import requests

url = "http://count.grew.fr/count"

data={
'corpora': '''[
  "SUD_Arabic-PUD@2.15",
  "SUD_Chinese-PUD@2.15",
  "SUD_Czech-PUD@2.15",
  "SUD_English-PUD@2.15",
  "SUD_Finnish-PUD@2.15",
  "SUD_French-PUD@2.15",
  "SUD_German-PUD@2.15",
  "SUD_Hindi-PUD@2.15",
  "SUD_Icelandic-PUD@2.15",
  "SUD_Indonesian-PUD@2.15",
  "SUD_Italian-PUD@2.15",
  "SUD_Japanese-PUD@2.15",
  "SUD_Korean-PUD@2.15",
  "SUD_Polish-PUD@2.15",
  "SUD_Portuguese-PUD@2.15",
  "SUD_Russian-PUD@2.15",
  "SUD_Spanish-PUD@2.15",
  "SUD_Swedish-PUD@2.15",
  "SUD_Thai-PUD@2.15",
  "SUD_Turkish-PUD@2.15"
]
''',
'requests': '''{
  "sv": "pattern { V -[subj]-> S; S << V }",
  "vs": "pattern { V -[subj]-> S; V << S }"
}
'''}

# Set the config to "SUD"
requests.request("POST", f'{url}/set_config', data={'config': 'sud'})

response = requests.request("POST", url, data=data)
print(response.text, end="") # The `response.text` already contains a newline

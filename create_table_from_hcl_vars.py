import json
f = open('/tmp/json',) 
data = json.load(f)

for var, params in data['variable'].items():
    opt = "Mandatory"
    if "default" in params:
        opt = "Optional"
    desc = ""
    if "description" in params:
        desc = params['description']
    print("|{:<30}| {} | {} |".format(var, opt, desc))

import json

f = open("cmd.txt")

cmds = {}
for line in f:
    cmds[line.rstrip()] = True

f = open('cmd.json', 'w')
f.write(json.dumps(cmds))

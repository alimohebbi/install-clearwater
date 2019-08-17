from jinja2 import Environment, FileSystemLoader

ip_list = {}
with open("ip-list.txt") as f:
    for line in f:
        (key, val) = line.split()
        ip_list[key] = val

file_loader = FileSystemLoader(searchpath="./")
env = Environment(loader=file_loader)
template = env.get_template('hosts.j2')
output = template.render(ip=ip_list)

f = open("hosts", "w+")
f.write(output)
f.close()

template = env.get_template('playbook.yml.j2')
output = template.render(ip=ip_list)

f = open("playbook.yml", "w+")
f.write(output)
f.close()

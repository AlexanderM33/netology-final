[masters]
%{ for index, ip in master_nodes ~}
master${index+1} ansible_host=${ip} ansible_user=root
%{ endfor ~}

[workers]
%{ for index, ip in worker_nodes ~}
worker${index+1} ansible_host=${ip} ansible_user=root
%{ endfor ~}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
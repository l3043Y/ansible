```
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i ./truth_src.yml centos/centos7_post_installation.yml -vvv
ansible-playbook -i ./truth_src.yml centos/centos_minio_prerequisites.yml -vvv
ansible-playbook -i ./truth_src.yml idrac/get_sys_iv.yml -vvv

#gather facts
ansible -i ./truth_src.yml minio -m ansible.builtin.setup
ansible -i ./truth_src.yml minio -m ping
ansible -i ./truth_src.yml minio -m shell -a 'cat /etc/hosts'
ansible -i ./truth_src.yml minio -m shell -a 'lsblk -o name,mountpoint,label,size,uuid'
```

```
lsblk -o name,mountpoint,label,size,uuid
```
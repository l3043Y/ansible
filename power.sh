# ansible-playbook -i truth_src.yml idrac/lab-pd-power.yml -vvv
ansible-playbook -i truth_src.yml idrac/lab-pd-power.yml --extra-vars "command=$1" -vvv

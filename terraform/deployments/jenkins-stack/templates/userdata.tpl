#! /bin/bash

set -eux
sudo apt-get update
sudo apt install -y python3-pip
pip install ansible
git clone https://github.com/erion225/offline-challenge.git /home/ubuntu/offline-challenge
cd /home/ubuntu/offline-challenge/ansible
ansible-playbook -i env/hosts storage.yml -e "efs_id=${EFS_ID}" -e "mount_path=/jenkins"
ansible-playbook -i env/hosts docker.yml
ansible-playbook -i env/hosts jenkins.yml
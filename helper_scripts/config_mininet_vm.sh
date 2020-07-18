#!/bin/bash

echo "################################################"
echo "  Running Mininet_VM Setup (config_mininet_vm.sh)..."
echo "################################################"
echo -e "\n This script was written for ktr/mininet"
echo " Detected vagrant user is: $username"

# echo " ### Pushing Ansible Hosts File ###"
# mkdir -p /etc/ansible
# cat << EOT > /etc/ansible/hosts

# [mininet]
# mininet1 ansible_host=192.168.56.91 ansible_user=vagrant
# mininet2 ansible_host=192.168.56.92 ansible_user=vagrant
# mininet3 ansible_host=192.168.56.93 ansible_user=vagrant

# EOT

echo " ### Push Hosts File ###"
cat << EOT >> /etc/hosts

192.168.56.91 mininet1 
192.168.56.92 mininet2
192.168.56.93 mininet3

EOT

echo " ### Installing Stefano's software and configs###"
ping 8.8.8.8 -c2
if [ "$?" == "0" ]; then
  apt-get update -qy
  apt-get install vim -qy
  apt-get install byobu -qy
fi

# git config --global user.name "Stefano Maurina"
# git config --global user.email "stefano.maurina@pm.me"
# git config --global core.editor "vim"

# Setup SSH key authentication for ODL [Ubuntu 16.04 Desktop] 
cat << EOT >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDee1uZVFHxptB43LP8dSR5rNjqmPhuzwYbB1KgDTbssc7fha4lB9rDLSjuiAGWSM3iq1RHrpzED0uTMc9i0wawDmPb2TglELIrPXas2mpx5c/j7GnjypMAX3NhBimKq5jZRd+AmfE4Y1bTl0nKeWjucZDgwnpP1x6gcR2xGDZzy1HHAHDP0JvE8QCbxKq/SgMl7nXE+j1cvXxTy9sjF4OBLIKtdw7P/Qqkc3GfsgzKSgSNp/s/crmr5SJ7fv2s20nZCw81hgJZ3orNpPRsFFAtRbP6QnX4o8JQVyJAEVVlb0gQbyKuTDmZj/FFhq46SYqo5kUx0loaYns9dPmitfy5 stefano@Ubuntu-VirtualBox
EOT

echo "############################################"
echo "      DONE!"
echo "############################################"

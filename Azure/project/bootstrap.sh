#!/bin/bash
echo 'Ezcom!@#$1234' |passwd --stdin 'root'
echo 'Ezcom!@#$1234' |passwd --stdin 'ezadmin'
sudo hostnamectl set-hostname "${var.C_project_hostname[count.index]}"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
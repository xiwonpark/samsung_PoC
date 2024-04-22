resource "aws_instance" "A_Project" {
  ami   = lookup(var.ami, "RHEL79")
  count = length(var.A_project_ip)

  vpc_security_group_ids  = ["${var.sg}"]
  instance_type           = var.instance_type[1]
  subnet_id               = var.foundry_01_sn
  private_ip              = var.A_project_ip[count.index]
  disable_api_termination = true

# CMK로 ebs 암호화
  root_block_device {
    encrypted  = true
    kms_key_id = var.kms_key_id
    tags = {
      Name = "${var.A_project_hostname[count.index]}-vol"
    }
  }
# HT Option
  # cpu_options {
  #   core_count = 4
  #   threads_per_core = 1
  # }

  user_data = <<EOF
#!/bin/bash

# OS Setting
echo 'Ezcom!234' |passwd --stdin 'root'
echo 'Ezcom!234' |passwd --stdin 'centos'
sudo hostnamectl set-hostname "${var.A_project_hostname[count.index]}"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
EOF

  # tags = merge("${var.tags}", { Name = "${var.A_project_hostname[count.index]}" })
  tags = {
    Name = "${var.A_project_hostname[count.index]}"
  }
}
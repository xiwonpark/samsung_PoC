resource "aws_instance" "B_Project" {
  ami   = lookup("${var.ami}", "RHEL79")
  count = length(var.B_project_ip)

  vpc_security_group_ids  = ["${var.sg}"]
  instance_type           = var.instance_type[0]
  subnet_id               = var.memory_01_sn
  private_ip              = var.B_project_ip[count.index]
  disable_api_termination = true

  root_block_device {
    encrypted  = true
    kms_key_id = "arn:aws:kms:ap-northeast-2:644631683002:key/83a65b62-b1b9-40ae-9d6c-2a25a839bb02"
    tags = {
      Name = "${var.B_project_hostname[count.index]}-vol"
    }
  }

  # cpu_options {
  #   core_count = 4
  #   threads_per_core = 1
  # }
  user_data = <<EOF
#!/bin/bash

# OS Setting
echo 'Ezcom!234' |passwd --stdin 'root'
echo 'Ezcom!234' |passwd --stdin 'centos'
sudo hostnamectl set-hostname "${var.B_project_hostname[count.index]}"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
EOF

  # tags = merge("${var.tags}", { Name = "${var.B_project_hostname[count.index]}" })
  tags = {
    Name = "${var.B_project_hostname[count.index]}"
  }
}

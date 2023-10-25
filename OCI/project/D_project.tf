resource "oci_core_instance" "D_project" {
  count = length(var.D_project_ip)

  compartment_id      = var.compartment
  availability_domain = var.avail_domain
  display_name        = var.D_project_hostname[count.index]
  shape               = var.instance_type[1] # 인스턴스 유형 (사용하는 유형에 따라 변경)

  source_details {
    source_id   = lookup("${var.ami}", "CentOS7")
    source_type = "image"

    kms_key_id = var.kms_vault_key
  }

  create_vnic_details {
    private_ip = var.D_project_ip[count.index]
    subnet_id  = var.foundry_01_sn
  }

  # 인스턴스의 보안 리스트 및 태그 등 추가 설정이 가능합니다.
  freeform_tags = {
    Name = "${var.D_project_hostname[count.index]}"
  }

  metadata = {
    user_data = base64encode(<<-EOF
      #!/bin/bash

      # OS Setting
      echo 'Ezcom!234' | passwd --stdin 'root'
      echo 'Ezcom!234' | passwd --stdin 'centos'
      sudo hostnamectl set-hostname "${var.D_project_hostname[count.index]}"
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
      systemctl restart sshd
    EOF
    )
  }
}
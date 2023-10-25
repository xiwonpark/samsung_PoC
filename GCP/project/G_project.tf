resource "google_compute_instance" "G_Project" {
  name         = var.G_project_hostname[count.index]
  machine_type = var.instance_type[1]
  zone         = "asia-northeast3-a"
  count        = length(var.G_project_ip)

  // 방화벽(보안그룹) 설정
  tags = [var.firewall]

  //부팅 디스크 설정
  boot_disk {
    initialize_params {
      image = lookup(var.img, "debian11")
    }
    //kms로 암호화
    kms_key_self_link = var.kms
  }

  metadata_startup_script = <<-EOF
        #!/bin/bash

        # OS Setting
        echo 'Ezcom!234' |passwd --stdin 'root'
        echo 'Ezcom!234' |passwd --stdin 'centos'
        sudo hostnamectl set-hostname "${var.G_project_hostname[count.index]}"
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
        systemctl restart sshd
    EOF

  // 인스턴스 개별 라벨(태그) 설정
  labels = {
    name = "${var.G_project_hostname[count.index]}"
  }

  // API termination 방지
  #   deletion_protection = true


  // VPC network
  network_interface {
    network    = var.vpc
    subnetwork = var.sb01
    network_ip = var.G_project_ip[count.index]
  }

  // HT
  advanced_machine_features {
    threads_per_core   = 2
    visible_core_count = 2
  }

}


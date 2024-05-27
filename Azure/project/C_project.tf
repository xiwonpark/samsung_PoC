resource "azurerm_linux_virtual_machine" "C_Project" {
  count = length(var.C_project_ip) //선번장 파일 내의 ip수만큼 반복 실행 

  name                  = var.C_project_hostname[count.index]
  location              = var.location_kc
  resource_group_name   = var.poc_rg
  size                  = var.vm_size[2]
  network_interface_ids = [azurerm_network_interface.C_project_NIC[count.index].id]
  source_image_id       = lookup(var.image, "RHEL79") //가상머신 생성시 사용할 이미지 지정
  plan {
    publisher = "procomputers"
    product   = "redhat-7-9-gen2"
    name      = "redhat-7-9-gen2"
  }

  disable_password_authentication = false //비밀번호 인증 비활성화
  admin_username                  = "ezadmin"
  admin_password                  = "AzureTest2023!!"

  os_disk {
    name                 = "${var.C_project_hostname[count.index]}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

    disk_encryption_set_id = var.disk_encryption //os 디스크 암호화
  }

  tags = var.tags

  custom_data = filebase64("project/bootstrap.sh") //가상머신 부팅시 실행할 사용자 지정 스크립트
}

resource "azurerm_network_interface" "C_project_NIC" {
  count = length(var.C_project_ip)

  name                = "${var.C_project_hostname[count.index]}-nic"
  location            = var.location_kc
  resource_group_name = var.poc_rg

  ip_configuration {
    name                          = "${var.C_project_hostname[count.index]}-nic-config"
    subnet_id                     = var.memory_03_sn
    private_ip_address_allocation = "Static" // private ip 지정 
    private_ip_address            = var.C_project_ip[count.index]
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nic_sg" {
  count                     = length(var.C_project_ip)
  network_interface_id      = azurerm_network_interface.C_project_NIC[count.index].id
  network_security_group_id = var.nsg
}

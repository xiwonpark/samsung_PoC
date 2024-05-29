variable "memory_03_sn" {
  description = "10.230.142.0/24"
  type        = string
}

variable "poc_rg" {
  description = "RG Name"
  type        = string
}

variable "location_kc" {
  description = "Location - Korea Central"
  type        = string
}

variable "nsg" {
  description = "DEV NSG"
  type        = string
}

variable "disk_encryption" {
  description = "Disk Encryption ID"
  type        = string
}

variable "vm_size" {
  description = "VM Type For Memory"
  type        = list(any)
}

variable "C_project_ip" {
  type = list(any)
}

variable "C_project_hostname" {
  type = list(any)
}

variable "image" {
  description = "image map"
  type        = map(any)
}

variable "tags" {
  description = "default tags"
  type = map(any)
}

variable "admin_password" {
  type = string
}
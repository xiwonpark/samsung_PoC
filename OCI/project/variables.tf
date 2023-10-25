variable "name" {
  description = "name"
  type        = string
}

variable "foundry_01_sn" {
  description = "Foundry Subnet 01"
  type        = string
}


variable "instance_type" {
  description = "Instance Type For Foundry"
  type        = list(any)
}

variable "D_project_ip" {
  type = list(any)
}

variable "D_project_hostname" {
  type = list(any)
}

variable "ami" {
  description = "AMI map"
  type        = map(any)
}

variable "compartment" {
  description = "OCI Compartment ID"
  type        = string
}

variable "avail_domain" {
  description = "OCI Availability Domain"
  type        = string
}

variable "kms_vault" {
  description = "OCI Master Encryption Key Vault "
  type        = string
}

variable "kms_vault_key" {
  description = "OCI Master Encryption Key Vault "
  type        = string
}
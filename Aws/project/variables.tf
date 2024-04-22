variable "foundry_01_sn" {
  description = "10.230.130.0/24"
  type        = string
}

variable "sg" {
  description = "DEV SG"
  type        = string
}

variable "instance_type" {
  description = "Instance Type For Foundry"
  type        = list(any)
}

variable "A_project_ip" {
  type = list(any)
}

variable "A_project_hostname" {
  type = list(any)
}

variable "ami" {
  type = map(any)
}

variable "memory_01_sn" {
  type        = string
}

variable "memory_02_sn" {
  type        = string
}


variable "B_project_ip" {
  type = list(any)
}

variable "B_project_hostname" {
  type = list(any)
}

variable "kms_key_id" {
  type = string
}
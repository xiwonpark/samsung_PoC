variable "vpc" {
  type = string
}

variable "sb01" {
  type = string
}


variable "firewall" {
  type = string
}

variable "kms" {
  type = string
}

variable "img" {
  type = map(any)
}

variable "instance_type" {
  type = list(any)
}

variable "G_project_ip" {
  type = list(any)
}

variable "G_project_hostname" {
  type = list(any)
}

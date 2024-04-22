# provider source & version 정의
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

# provider & default tag 정의
provider "aws" {
  region = "ap-northeast-2"
  default_tags {
    tags = {
      ManagedByTerraform = "true"
      Creator            = "swpark"
      Email              = "swpark@ezcom.co.kr"
      Project            = "Hybrid-Cloud/PoC"
    }
  }
}

# backend 설정
terraform {
  backend "s3" {
    bucket         = "swtf-backend"
    key            = "aws/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tfstate-lock"
  }
}

# module 선언
module "aws" {
  source        = "./project"
  memory_01_sn  = "subnet-06720de8222957581" #pb-sn-01
  memory_02_sn  = "subnet-0dd1cef9ea0d7e29c" #pv-sn-01
  foundry_01_sn = "subnet-070c2cdfa6e9b6a93" #pv-sn-02
  sg            = "sg-0dc31a0fae01058c6" #sw-sg

  instance_type = ["t3.micro", "t3.medium", "t3.large", "t3.xlarge"]

  A_project_ip       = [for line in split("\n", file("./DNS/A_project_DNS.txt")) : split(" ", line)[0]]
  A_project_hostname = [for line in split("\n", file("./DNS/A_project_DNS.txt")) : split("   ", line)[1]]
  B_project_ip       = [for line in split("\n", file("./DNS/B_project_DNS.txt")) : split(" ", line)[0]]
  B_project_hostname = [for line in split("\n", file("./DNS/B_project_DNS.txt")) : split("   ", line)[1]]

  ami = {
    RHEL79 = "ami-09e2a570cb404b37e"
    RHEL83 = "ami-02ab944d7e31b1074"
  }

  kms_key_id = "arn:aws:kms:ap-northeast-2:644631683002:key/8ddf9d21-721b-43c0-9fb9-11f7ee5aec37"
}
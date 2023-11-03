# provider source & version 정의
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

# label에 대문자, .,  @ 등 특수문자 안 됨 그런데 _,-,한글 은 됨, key는 소문자로 시작 해야 함
# access key 지정시 export GOOGLE_APPLICATION_CREDENTIALS="FILE_PATH"
provider "google" {
  project = "top-virtue-398708"
  region  = "asia-northeast3"
  zone    = "asia-northeast3-a"
  default_labels = {
    managedbyterraform = "true"
    creator            = "swpark"
    # email              = "swpark@ezcom.co.kr"
    project = "poc"
  }
}

terraform {
  backend "s3" {
    bucket         = "swtf-tfstate-s3"
    key            = "test/gcp/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tfstate-lock"
  }
}

# kms 사용하려면 key에 역할별에서 cloudkms.cryptoKeyEncrypterDecrypter 역할을 compute engine 서비스 에이전트에 넣어줘야함 service-[project id]@compute-system.iam.gserviceaccount.com
# https://cloud.google.com/compute/docs/access/service-accounts?hl=ko
# 위 처럼 직접하거나 vm 만들기에서 디스크 암호화 에서 키 넣으면 나옴
module "gcp" {
  source   = "./project"
  vpc      = "projects/top-virtue-398708/global/networks/isin-vpc"
  sb01     = "https://www.googleapis.com/compute/v1/projects/top-virtue-398708/regions/asia-northeast3/subnetworks/isin-sb01"
  firewall = "isin-firewall"
  kms      = "projects/top-virtue-398708/locations/global/keyRings/sw-keyring/cryptoKeys/sw-key"
  img = {
    debian11 = "debian-cloud/debian-11"
    centos79 = "TEMP"
  }
  instance_type      = ["e2-standard-2", "e2-standard-4", "e2-medium", "e2-small"]
  G_project_ip       = [for line in split("\n", file("./DNS/G_project_DNS.txt")) : split(" ", line)[0]]
  G_project_hostname = [for line in split("\n", file("./DNS/G_project_DNS.txt")) : trimspace(split("   ", line)[1])]
}

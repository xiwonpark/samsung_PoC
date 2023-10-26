# 특정 version의 provider 사용 확인 필요
# 현재 hashicorp/oci 5.17.0 로 가지고 오고있음
# required_provider 구문을 사용하여 version을 특정하면 oracle/oci provider와 hashicorp/oci 2개 가지고 오며 error 발생 
provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaauqrkfl74wqvtk246iortv2zvcxpdvsimctuct66s2lcyraezgt4q"
  user_ocid        = "ocid1.user.oc1..aaaaaaaauc7zmus35qcmqaz67kzoypouparh2kkjob72dtlllrz6t3mm2xqq"
  fingerprint      = "75:54:6c:c7:ff:df:cb:a3:10:53:a5:57:97:f0:18:06"
  private_key_path = "./swpark@ezcom.co.kr_2023-10-25T01_02_11.595Z.pem"
  region           = "ap-seoul-1"
}

terraform {
  backend "s3" {
    bucket         = "swtf-tfstate-s3"
    key            = "samsung-poc/OCI/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tfstate-lock"
  }
}

module "oci" {
  source        = "./project"
  foundry_01_sn = "ocid1.subnet.oc1.ap-seoul-1.aaaaaaaaqlkbjvilzjoms2jqwpyq3wbcpgsgty2kk5uyluscq4oce4nysduq"
  compartment   = "ocid1.compartment.oc1..aaaaaaaab3ldf4ezsyp4meytyged3tpunmwh5b7jsdhrkjbbcztibbaa24da"
  avail_domain  = "aFbt:AP-SEOUL-1-AD-1"

  instance_type      = ["VM.Standard.E4.Flex", "VM.Standard2.1"]
  D_project_ip       = [for line in split("\n", file("./DNS/D_project.txt")) : split(" ", line)[0]]
  D_project_hostname = [for line in split("\n", file("./DNS/D_project.txt")) : split("   ", line)[1]]

  ami = {
    CentOS7 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavr3jv4gwj7rqpk64uxn4vdbr4o2327ftvtral7vv4moqmwjjobqq"
  }

# vault 생성시 Protection Mode : HSM, Algorithm : AES 로 생성
# vault 생성 후 root compartment의 policy에서 Allow service blockstorage to use keys in compartment [COMPARTMENT_NAME] 추가 필요
  kms_vault     = "ocid1.vault.oc1.ap-seoul-1.e5stq3cvaaemi.abuwgljryk2wabfwdelk4sijyvvumjsqfpss46mrkv7nlhkhkeqelfbvfb3a"
  kms_vault_key = "ocid1.key.oc1.ap-seoul-1.e5stq3cvaaemi.abuwgljrtk2z52cwsaerluadrzuhbawnbpklcyxpmh6kvprighrl3qwv2a4q"
}
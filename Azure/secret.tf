# 앱등록 - 디렉토리(테넌트)ID
variable "tenant_id" {
  default = "1b071189-0ecb-4f7a-b453-9457c489fdde"
  type    = string
}

# 구독 ID
variable "subscription_id" {
  default = "5e22e437-d178-4e96-b21e-2a21eaac3e1f"
  type    = string
}

# 앱등록 - 애플리케이션(클라이언트)ID
variable "client_id" {
  default = "e08002d2-2acb-44b5-8092-30d1e0d6eae0"
  type    = string
}

# 앱등록 - 인증서(키) 값
variable "client_secret" {
  default = "Yeq8Q~u3eq9QmQAT3_Bq~l~Mb~mQVN9fz43vibQ1"
  type    = string
}
# GCP

## 특이사항
1. access key는 gcp api에서 다운로드하고 환경변수 등록 export GOOGLE_APPLICATION_CREDENTIALS="FILE_PATH"
2. kms 사용하려면 key에 역할별에서 cloudkms.cryptoKeyEncrypterDecrypter 역할을 compute engine 서비스 에이전트에 넣어줘야함 service-[project id]@compute-system.iam.gserviceaccount.com
docs: https://cloud.google.com/compute/docs/access/service-accounts?hl=ko
# OCI

## 특이사항
1. private_key_path에 oci api에서 access key(pem)받아서 사용
2. vault 생성시 Protection Mode : HSM, Algorithm : AES 로 생성
3. vault 생성 후 root compartment의 policy에서 Allow service blockstorage to use keys in compartment [COMPARTMENT_NAME] 추가 필요
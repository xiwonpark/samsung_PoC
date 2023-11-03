# samsung_PoC

## Code Convention
### 0. Architecture
하기 배포/제거 process를 기준으로 작성되었습니다.
provider(CSP) -> project(배포 결재)

CSP별 1개의 maker.tf 파일을 가지며 해당 파일에서 backend, module(project)를 정의하여 배포/제거 합니다.

이는 Multi-Provider 를 사용하는 환경에서 근무자의 업무 효율을 높이며 CSP -> Project별 배포/제거 이력을 repository 및 backend의 tfstate 파일에 logging 하기 위해서입니다.

```
.
├── Aws
│   ├── DNS
│   │   ├── A_project_DNS.txt
│   │   └── B_project_DNS.txt
│   ├── maker.tf
│   ├── output.tf
│   └── project
│       ├── A_project.tf
│       ├── B_project.tf
│       ├── output.tf
│       └── variables.tf
├── Azure
│   ├── DNS
│   │   └── C_project_DNS.txt
│   ├── maker.tf
│   ├── output.tf
│   ├── project
│   │   ├── C_project.tf
│   │   ├── bootstrap.sh
│   │   ├── output.tf
│   │   └── variables.tf
│   └── secret.tf
├── GCP
│   ├── DNS
│   │   └── G_project_DNS.txt
│   ├── maker.tf
│   ├── output.tf
│   ├── project
│   │   ├── G_project.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── top-virtue-398708-68e38fe5efb8.json
├── OCI
│   ├── DNS
│   │   └── D_project.txt
│   ├── maker.tf
│   ├── output.tf
│   ├── project
│   │   ├── D_project.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── swpark@ezcom.co.kr_2023-10-25T01_02_11.595Z.pem
├── README.md
├── extract_data.py
├── parsing.txt
├── script_prd.py
└── script_stg.py

12 directories, 35 files
```

### 0. file
*.tf - terraform code
*.txt - text file
extract_data.py - tfstate의 특정 값을 기준으로 version 검색
script_stg.py - CI pipeline script
script_prd.py - CD pipeline script

### 1. tag
provider 별 필수 기본 태그를 지정합니다.
maker.tf 파일을 참고하세요.

### 2. backend
provider 별 backend를 지정합니다.
현재 s3 backend를 사용하고 있습니다.
maker.tf 파일을 참고하세요.

### 3. module
CSP를 module로 선언합니다.
해당 module 밑에서 project에 필요한 resource가 생성되며 이는 코드 재사용성을 높입니다.

## Hybrid Cloud IaC 도입 PoC - 배포/제거 process 개선안

본 PoC는 Hybrid Cloud 근무자의 업무 효율성 증진을 위한 DevOps향 IaC 도입 안으로 업무 효율성을 증진하고 기존 업무 Process를 개선하는데 목표를 두었습니다.

## IaC 적용 기대 값은 아래와 같습니다.

1. CSP – Project(배포 건) 별로 Instance 배포/제거 하며 현황 파악이 편리합니다.

2. 현 고객사 배포 결재 메일폼과 동일한 Code Architecture로 개발하였기에 고객사의 프로젝트 별 현황 파악 Data Sync에 적합합니다.

3. 신규 장비 DNS 등록 후 해당 인시던트 내용을 Copy&Paste하는 작업 만으로 배포가 이루어져 Human-Error를 방지합니다.

4. Back-End 및 DynamoDB Lock 설정으로 state file을 Managed Object Storage인 S3에 저장하여 state file 의 유실을 방지하고, 여러 사용자의 동시 사용으로 인한 state file의 변경을 방지합니다.

5. API Call을 받아 DynamoDB가 주체가 되어 S3에 보관 되어 있는 state file 의 업데이트가 이루어 집니다.

6. GitHub(Lab) PR&Merge를 통해 code 형상관리하고 Backend - S3 Versioning 을 통해 배포 형상관리를 합니다.

7. CI/CD Pipeline 도입으로 안정적이고 자동화된 시스템을 구축 합니다.

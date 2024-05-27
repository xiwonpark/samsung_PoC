import boto3

# S3 client 생성
client = boto3.client('s3')

# Version을 나열할 버킷 이름 및 프리픽스 지정, 찾을 특정 값 지정
bucket_name = "swtf-backend"
print(f"============================================================================")
print("Backend tfstate file에서 특정 값을 찾겠습니다.\n인자 값을 적어주세요.")
print("\nBucket Name = swtf-backend")
print("\nCSP를 적어주세요(aws,azure,gcp,oci): ")
prefix = input()
print("\n찾을 값을 적어주세요: ")
search_term = input()
print(f"============================================================================")

# Version 정보 가져오기
response = client.list_object_versions(
    Bucket=bucket_name,
    Prefix=(f"{prefix}")
)

# dict 생성
values = {}

# 변수 초기화
counter = 0

# Version ID 추출 및 출력
for version in response.get('Versions'):
    version_id = version['VersionId']
    version_key = version['Key']

    obj = client.get_object(
            Bucket=bucket_name,
            Key=version_key,
            VersionId=version_id
        )
    file_contents = obj['Body'].read().decode('utf-8')
    
    # 파일 내용에서 특정 값 찾기
    if search_term in file_contents:
        counter += 1
        print(f"Found '{search_term}' in '{prefix}' VersionID: {version_id}")
        values[version_id] = file_contents

# 특정 값을 찾았을 때 찾은 총 파일의 수
print(f"Found {counter} files")

# 특정 값을 못 찾았을 때
if counter == 0:
    print(f"'{search_term}' are not included in '{prefix}'")
    exit(0)

# 전체 저장
print(f"모든 파일을 저장할까요? (yes or no)")
answer = input()

if answer.lower() == 'yes':
    for id in values:
        filename = f"{id}"
        with open(filename, 'w') as file:
            file.write(values[id])
        print(values[id])
    print(f"모든 파일을 저장했습니다.")
    exit(0)


# yes일 시 파일로 저장
for id in values:
    print(f"VersionID: {id}를 저장할까요? (yes or no)")
    print(f"script를 종료하고 싶다면 'exit'를 입력해주세요")
    answer = input()

    if answer.lower() == 'exit':
        break
    elif answer.lower() == 'yes':
        filename = f"{id}"
        with open(filename, 'w') as file:
            file.write(values[id])
        print(values[id])
        print(f"파일 '{filename}'를 저장했습니다.")


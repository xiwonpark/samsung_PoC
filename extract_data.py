import boto3

# S3 client 생성
client = boto3.client('s3')

# Version을 나열할 버킷 이름 및 프리픽스 지정, 찾을 특정 값 지정
bucket_name = "swtf-tfstate-s3"
print(f"============================================================================")
print("Backend tfstate file에서 특정 값을 찾겠습니다.\n인자 값을 적어주세요.")
print("\nBucket Name = swtf-tfstate-s3")
print("\nCSP를 적어주세요(aws,azure,gcp,oci): ")
prefix = input()
print("\n찾을 값을 적어주세요: ")
search_term = input()
print(f"============================================================================")

# Version 정보 가져오기
response = client.list_object_versions(
    Bucket=bucket_name,
    Prefix=(f"test/{prefix}")
)

# bool 변수 선언
found = False

# Version ID 추출 및 출력
for version in response.get('Versions'):
    version_id = version['VersionId']

    # 해당 버전의 파일 가져오기
    obj = client.get_object(
        Bucket=bucket_name,
        Key=version['Key'],
        VersionId=version_id
    )

    # 파일 내용 읽기
    file_contents = obj['Body'].read().decode('utf-8')
    
    # 파일 내용에서 특정 값 찾기
    if search_term in file_contents:
        print(f"Found '{search_term}' in '{prefix}' VersionID: {version_id}")
        found = True

# 값이 없을 경우 처리
if not found:
    print(f"Can't found value in '{prefix}'")
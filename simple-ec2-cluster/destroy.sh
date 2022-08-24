# 디렉토리 변경
cd ./terraform

# ssh key variable설정
export TF_VAR_public_key=test

# key 삭제
rm -rf key key.pub

# 생성한 인스턴스 삭제
terraform destroy -auto-approve
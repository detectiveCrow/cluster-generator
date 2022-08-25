# 디렉토리 변경
cd ./terraform

# ssh key variable설정
export TF_VAR_public_key=test

# 임시파일 삭제
rm -rf key key.pub
rm -rf kube_hosts

# 생성한 인스턴스 삭제
terraform destroy -auto-approve

# 디렉토리 변경
cd ../ansible

# 임시파일 삭제
rm -rf join-command
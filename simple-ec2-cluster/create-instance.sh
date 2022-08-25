# 디렉토리 변경
cd ./terraform

# ssh key 생성
ssh-keygen -t rsa -b 4096 -f ./key -N ''

# ssh key variable로 설정
export TF_VAR_public_key=$(cat ./key.pub)

# 테라폼 Init
terraform init

# 인프라 구축을 위한 인스턴스 생성
terraform apply -auto-approve -lock=false

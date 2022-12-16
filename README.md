# aws-lightsail-xray-infra

## Prerequisites
- [AWS account](https://aws.amazon.com/resources/create-account/) and [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Terraform [CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Create Lightsail Instance
```sh
# make terraform.tfvars then edit input variables
cp terraform.tfvars.test.pipeline terraform.tfvars

# init
terraform init
# see execution plan
terraform plan -var-file terraform.tfvars
# execute
terraform apply -auto-approve -var-file terraform.tfvars
# cleanup
terraform destroy
```

## Upload key-pair
- Generate a new key-pair
```sh
ssh-keygen -t rsa
```
- Go to: [https://lightsail.aws.amazon.com/ls/webapp/account/keys](https://lightsail.aws.amazon.com/ls/webapp/account/keys)
- Upload SSH public key

## Install x-ui
```sh
# remote login
ssh -i /path/to/private-key.pem username@instance-ip
# root prompt
sudo -i
# install
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```

## Configure x-ui
- Go to: http://instance-ip/xui/inbounds
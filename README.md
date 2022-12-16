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
terraform plan
# execute
terraform apply -auto-approve
# cleanup
terraform destroy
```

## Install x-ui
[x-ui](https://github.com/vaxilu/x-ui)
```sh
# remote login
# use terraform's output for ssh_to_instance
sudo ssh -i instance_name_pkey.pem username@ip
# instance root prompt
sudo -i
# install then follow instructions
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```

## Configure x-ui

>出于安全考虑，安装/更新完成后需要强制修改端口与账户密码  
>确认是否继续?[y/n]:y  
>请设置您的账户名:your_username  
>您的账户名将设定为:your_username  
>请设置您的账户密码:your_password  
>您的账户密码将设定为:your_password  
>请设置面板访问端口:12345  
>您的面板访问端口将设定为:12345  
>确认设定,设定中  
>set username and password success  
>账户密码设定完成  
>set port 12345 success面板端口设定完成  

## Add Inbounds
- Get your instance-ip and port from previous steps
- Go to: http://instance-ip:port/xui/inbounds

## When IP is blocked
```sh
# destroy previous static IP
terraform destroy -target aws_lightsail_static_ip.ip
# attach a new IP
terraform apply -auto-approve -target aws_lightsail_static_ip_attachment.attachment
```
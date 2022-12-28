# aws-lightsail-xray-infra

## Prerequisites
- [AWS account](https://aws.amazon.com/resources/create-account/) and [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS admin user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
- [AWS configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- Terraform [CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Have your aws profile configured locally before proceeding.

## Create Lightsail Instance
### Get your terraform input ready.
```sh
# make terraform.tfvars then edit input variables
cp terraform.tfvars.test.pipeline terraform.tfvars
```
### Modify terraform.tfvars
#### Available regions
- US East (Ohio) (us-east-2)
- US East (N. Virginia) (us-east-1)
- US West (Oregon) (us-west-2)
- Asia Pacific (Mumbai) (ap-south-1)
- Asia Pacific (Seoul) (ap-northeast-2)
- Asia Pacific (Singapore) (ap-southeast-1)
- Asia Pacific (Tokyo) (ap-northeast-1)
- Canada (Central) (ca-central-1)
- EU (Frankfurt) (eu-central-1)
- EU (Ireland) (eu-west-1)
- EU (London) (eu-west-2)
- EU (Paris) (eu-west-3)
- EU (Stockholm) (eu-north-1)

Note that the smallest instance bundle is nano_2_0, but not all region have nano_2_0.

### Create
```sh
# init
terraform init
# see execution plan
terraform plan
# execute
terraform apply -auto-approve
```
### Clean up
```sh
terraform destroy
```

## Check Connectivity
Destroy & re-apply upon bad connectivity(see above).
```sh
nc -zv instance_ip 22
```

## Install [x-ui](https://github.com/vaxilu/x-ui)
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
Set username, password and port as prompted.
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
- Get your instance-ip and port from terraform outputs and x-ui configuration.
- Go to: http://instance-ip:port/xui/inbounds, login with created username/password.
- Add inbounds as needed.

## When Connectivity Fails
Switch new Static-IP
```sh
# destroy previous static IP
terraform destroy -target random_integer.id -target aws_lightsail_static_ip.ip --auto-approve
# attach a new IP
terraform apply -auto-approve -target aws_lightsail_static_ip_attachment.attachment
```
Or re-create new Instance
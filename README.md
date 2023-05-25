# Overview

A repo to explain the purpose of Terragrunt. The wordpress example is taken from: https://github.com/devbhusal/terraform-ec2-RDS-wordpress

## Instructions

### First Try Terraform Only

In the `Terraform_Only` folder create a private/public key pair:

```bash
ssh-keygen -f mykey-pair
sudo chmod 400 mykey-pair
```

Run Terraform commands

```bash
terraform init
terraform plan
terraform apply
```

### Finally Try Terragrunt

In the `Terragrunt` folder run the following command:


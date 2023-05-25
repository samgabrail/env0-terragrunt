remote_state {
  backend = "s3"
  config = {
    bucket         = "tekanaid-terragrunt-demo"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

inputs = {
  ami_id = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
}
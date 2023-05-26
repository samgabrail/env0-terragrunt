remote_state {
  backend = "s3"
  config = {
    bucket         = "tekanaid-terragrunt-demo"
    key            = "terragrunt/wordpress/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

inputs = {
  ami_id        = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  database_name = "wordpress_db"          // database name
  database_user = "wordpress_user"        //database username
  IsUbuntu          = true // true for ubuntu,false for linux 2  //boolean type
  PUBLIC_KEY_PATH  = "./mykey-pair.pub" // key name for ec2, make sure it is created before terrafomr apply
  PRIV_KEY_PATH    = "./mykey-pair"
  root_volume_size = 22
}

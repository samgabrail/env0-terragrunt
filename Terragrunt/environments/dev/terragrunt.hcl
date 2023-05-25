include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//wordpress"
}

inputs = {
  region                   = "us-east-1"
  environment              = "dev"
  vpc_cidr_block           = "10.0.0.0/16"
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  instance_type            = "t2.micro"
  db_instance_class        = "db.t2.micro"
  db_password              = "devpassword"
}
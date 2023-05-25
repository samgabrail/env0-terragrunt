include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//wordpress"
}

inputs = {
  region                   = "us-east-2"
  environment              = "prod"
  vpc_cidr_block           = "10.1.0.0/16"
  public_subnet_cidr_blocks = ["10.1.1.0/24", "10.1.2.0/24"]
  instance_type            = "t2.small"
  db_instance_class        = "db.t2.small"
  db_password              = "prodpassword"
}
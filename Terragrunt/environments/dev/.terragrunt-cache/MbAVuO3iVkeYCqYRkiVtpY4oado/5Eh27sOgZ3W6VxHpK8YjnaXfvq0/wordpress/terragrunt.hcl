include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//wordpress"
}

inputs = {
  // Password here will be used to create master db user.It should be chnaged later
  database_password = "dev-PassWord4-user" //password for user database
  region            = "us-east-1"
  // avaibility zone and their CIDR
  AZ1              = "us-east-1a"       // for EC2
  AZ2              = "us-east-1b"       //for RDS 
  AZ3              = "us-east-1c"       //for RDS
  VPC_cidr         = "10.0.0.0/16"      // VPC CIDR
  subnet1_cidr     = "10.0.1.0/24"      // Public Subnet for EC2
  subnet2_cidr     = "10.0.2.0/24"      //Private Subnet for RDS
  subnet3_cidr     = "10.0.3.0/24"      //Private subnet for RDS
  instance_type    = "t2.micro"    //type of instance
  instance_class   = "db.t2.micro" //type of RDS Instance
}
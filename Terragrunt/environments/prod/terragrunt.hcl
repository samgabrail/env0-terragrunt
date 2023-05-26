include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//wordpress"
}

inputs = {
  // Password here will be used to create master db user.It should be chnaged later
  database_password = "prod-PassWord4-user" //password for user database
  region            = "us-east-2"
  // avaibility zone and their CIDR
  AZ1             = "us-east-2a"       // for EC2
  AZ2             = "us-east-2b"       //for RDS 
  AZ3             = "us-east-2c"       //for RDS
  VPC_cidr        = "10.10.0.0/16"     // VPC CIDR
  subnet1_cidr    = "10.10.1.0/24"     // Public Subnet for EC2
  subnet2_cidr    = "10.10.2.0/24"     //Private Subnet for RDS
  subnet3_cidr    = "10.10.3.0/24"     //Private subnet for RDS
  instance_type   = "t2.small"    //type of instance
  instance_class  = "db.t2.small" //type of RDS Instance
}

terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket  = "openproject-bucket-backup"                                    # Replace with your unique S3 bucket name
    key     = "path/statefile/terraform.tfstate" # Path inside the bucket to store the state
    region  = "ap-south-1"                                              # Replace with your desired AWS region
    encrypt = true                                                     # Enable encryption of the state file

  }
}

# Store the terraform state file in S3
terraform {
  backend "s3" {
    bucket  = "akki573-terraform-state"
    key     = "main-multi-tier-app.tfstate"
    region  = "us-east-1"
   }
}

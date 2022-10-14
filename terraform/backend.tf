# terraform {
# backend "s3" {
# bucket = "ak-terraform-backend"
# key = "terraform.tfstate"
# region = "us-west-2"
# dynamodb_table = "ak-terraform-backend-table"
#   }
# }
terraform {
  backend "s3"{
    bucket = "hello-flask-github-action"
    # key = "terraform.tfstate"
    key = "LockID"
    region = "us-west-2"
    dynamodb_table = "hello-flask-github-action-table"
 
  }
}

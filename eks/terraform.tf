terraform {
  backend "s3" {
    bucket         = "rc-demo-tfstate"
    region         = "us-east-2"
    key            = "rc-demo.tfstate"
    dynamodb_table = "rc-demo"
  }
}
terraform {
  backend "s3" {
    bucket="narunas-atlantis-tf-state"
    key="terraform.tfstate"
    region="us-west-2"
  }
}

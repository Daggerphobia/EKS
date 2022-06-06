terraform {
    backend "s3" {
        bucket = "eks"
        key = "sample.state"
        region = "us-west-1"
    }
}

provider "aws" {
  region = var.region
}
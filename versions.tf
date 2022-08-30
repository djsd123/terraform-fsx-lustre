terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2"
    }
  }

  backend "s3" {
    acl     = "private"
    bucket  = "kel-pulumi-inf-state"
    encrypt = "true"
    key     = "terraform/fsx"
    region  = "eu-west-1"
    #    kms_key_id = ""
  }

  required_version = ">= 1.2.0, < 2.0.0"
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Terraform = true
      Repo      = "terraform-fsx-lustre"
    }
  }
}

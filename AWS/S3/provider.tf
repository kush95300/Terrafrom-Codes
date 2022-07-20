terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      user = "kaushal"
      env  = "dev"
    }
  }
}

terraform {
  cloud {
    organization = "searce-terraform"

    workspaces {
        tags = ["s3-test"]
        }
  }
}
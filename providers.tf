terraform {
  cloud {
    organization = "dragon-ws"

    workspaces {
      name = "gh-action-local-k8s"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


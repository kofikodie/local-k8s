variable "aws_region" {
  default = "eu-west-1"
}

variable "cluster-name" {
  default = "local-k8s"
  type    = string
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.17.0-eksbuild.1"
    }
  ]
}

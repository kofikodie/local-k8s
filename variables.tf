variable "aws_region" {
  default = "eu-west-1"
}

variable "cluster_name" {
  default = "local-k8s-karpenter"
  type    = string
}

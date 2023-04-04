variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "local-k8s-karpenter"
  type    = string
}

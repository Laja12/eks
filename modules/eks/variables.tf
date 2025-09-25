variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "EKS Kubernetes version"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the EKS cluster and node groups"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where EKS will be created"
}

variable "node_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS worker nodes"
}

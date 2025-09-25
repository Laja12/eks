resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn   # <- use cluster role here
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

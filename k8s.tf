data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]  # ensure EKS cluster is created first
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
  depends_on             = [module.eks]
}

# Apply your service.yaml
resource "kubernetes_manifest" "my_service" {
  manifest = yamldecode(file("${path.module}/k8s/service.yaml"))
}



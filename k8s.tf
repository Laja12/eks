data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]  # ensure EKS cluster is created first
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}


# Split YAMLs into separate files
resource "kubernetes_manifest" "my_app" {
  manifest = yamldecode(file("${path.module}/k8s/deployment.yaml"))
}

# Apply your service.yaml
resource "kubernetes_manifest" "my_service" {
  manifest = yamldecode(file("${path.module}/k8s/service.yaml"))
}



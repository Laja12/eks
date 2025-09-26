# Ensure Kubernetes provider is configured after EKS is ready
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

# Apply your deployment.yaml
resource "kubernetes_manifest" "my_app" {
  manifest = yamldecode(file("${path.module}/k8s/deployment.yaml"))
}
# Apply your service.yaml
resource "kubernetes_manifest" "my_service" {
  manifest = yamldecode(file("${path.module}/k8s/service.yaml"))
}



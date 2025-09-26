resource "null_resource" "wait_for_eks" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "echo EKS cluster is ready"
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

resource "kubernetes_manifest" "my_app" {
  manifest  = yamldecode(file("${path.module}/k8s/deployment.yaml"))
  depends_on = [null_resource.wait_for_eks]
}

resource "kubernetes_manifest" "my_service" {
  manifest  = yamldecode(file("${path.module}/k8s/service.yaml"))
  depends_on = [null_resource.wait_for_eks]
}

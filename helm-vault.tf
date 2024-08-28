######### CREATE VAULT NAMESPACE #################

resource "kubernetes_namespace" "vault" {
  metadata {
    annotations = {
      name = "vault"
    }
  name = "vault"
  }
}

######### DEPLOY VAULT HELM CHART #################

resource "helm_release" "vault" {
  name       = "vault" # vault-primary (for primary DR cluster) # vault-secondary (for secondary DR cluster)
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.28.1"
  namespace  = kubernetes_namespace.vault.id
  values = [
    templatefile("vault-autojoin-values.yaml", {
      kms_id = module.eks.kms_key_id,
      certificate_arn = module.acm.acm_certificate_arn,
      vault_dns = var.cert_san_2,
      aws_region = var.region
    })
  ]
  depends_on = [
    helm_release.aws-load-balancer-controller,
    helm_release.external-dns,
    module.acm,
    kubernetes_namespace.vault, 
    kubernetes_secret.vault-secret, 
    kubernetes_secret.eks-creds, 
    kubernetes_secret.vault-acm-cert
  ]
}

resource "helm_release" "external-dns" {
  name = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  namespace  = "kube-system"
  #version    = "1.14.5"

  values = [
    templatefile("external-dns-values.yaml", {
      external_dns_role_arn = aws_iam_role.external_dns_role.arn,
      node_selector         = var.node_selector,
      domain_name           = var.domain_name
    })
  ]

  depends_on = [
    module.eks.eks_managed_node_groups,
    aws_iam_role_policy_attachment.external_dns_role_attachment,
    helm_release.aws-load-balancer-controller
  ]

}
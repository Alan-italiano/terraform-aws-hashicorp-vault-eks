######### CREATE VAULT SECRETS (CERTS, LICENSE AND KMS) #################

data "template_file" "vault-aws-key" {
  template = "${file("vault-aws.key")}"
}

data "template_file" "vault-aws-crt" {
  template = "${file("vault-aws.crt")}"
}

data "template_file" "vault-aws-ca" {
  template = "${file("vault-aws.ca")}"
}

data "template_file" "vault-secret" {
  template = "${file("vault-lic.hclic")}"
}


resource "kubernetes_secret" "vault-secret" {
  metadata {
    name      = "vault-secret"
    namespace = "vault"
  }
  data = {
    license = data.template_file.vault-secret.template
  }
  type = "Opaque"
  depends_on = [kubernetes_namespace.vault]
}

resource "kubernetes_secret" "vault-acm-cert" {
  metadata {
    name      = "vault-acm-cert"
    namespace = "vault"
  }
  data = {
    "vault-aws.key" = data.template_file.vault-aws-key.template
    "vault-aws.crt" = data.template_file.vault-aws-crt.template
    "vault-aws.ca"  = data.template_file.vault-aws-ca.template
  }
  type = "Opaque"
  depends_on = [kubernetes_namespace.vault]
}

resource "kubernetes_secret" "eks-creds" {
  metadata {
    name      = "eks-creds"
    namespace = "vault"
  }
  data = {
    AWS_ACCESS_KEY_ID = ""
    AWS_SECRET_ACCESS_KEY = ""
  }
  type = "Opaque"
  depends_on = [kubernetes_namespace.vault]
}

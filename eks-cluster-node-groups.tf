locals {
  cluster_name = "vault-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 20.20.0" #"20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access           = true
  cluster_endpoint_private_access          = true
  enable_cluster_creator_admin_permissions = true

  kms_key_deletion_window_in_days = "7"
  
  cluster_addons = {
    aws-ebs-csi-driver = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }
    snapshot-controller = {
      service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
    }   
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = var.eks_ami_type

  }

  eks_managed_node_groups = {
    one = {
      name = var.eks_node_group_name_1

      instance_types = var.eks_instances_type_1
      capacity_type  = var.eks_capacity_type
      min_size     = 1
      max_size     = 4
      desired_size = 3
    }

    two = {
      name = var.eks_node_group_name_2

      instance_types = var.eks_instances_type_2
      capacity_type  = var.eks_capacity_type
      min_size     = 1
      max_size     = 4
      desired_size = 3
    }
  }
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2009
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

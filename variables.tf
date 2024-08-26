variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_s3_bucket" {
  description = "AWS S3 Bucket Name"
  type        = string
  default     = "vault-test-dev-qa-bucket"
}

variable "eks_node_group_name_1" {
  description = "EKS Node Group 1 Name"
  type        = string
  default     = "vault-node-group-1"
}

variable "eks_node_group_name_2" {
  description = "EKS Node Group 2 Name"
  type        = string
  default     = "vault-node-group-2"
}

variable "eks_ami_type" {
  description = "EKS Ami Type"
  type        = string
  default     = "AL2_ARM_64" # Ou AL2_x86_64
}

variable "eks_instances_type_1" {
  description = "EKS Instance Type"
  type        = string
  default     = "t4g.medium" # t4g series used for ARM64, t3 series used for x86_64
}

variable "eks_instances_type_2" {
  description = "EKS Instance Type"
  type        = string
  default     = "t4g.medium" # t4g series used for ARM64, t3 series used for x86_64
}

variable "eks_capacity_type" {
  description = "EKS Capacity Type"
  type        = string
  default     = "ON_DEMAND" # SPOT 
}

variable "node_selector" {
  description = "A map variable with nodeSelector labels applied when placing pods of the chart on the cluster."
  default     = {}
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
  default     = "lab-internal.com.br"
}

variable "route_53_zone_id" {
  description = "Route 53 Zone ID"
  type        = string
  default     = "ZONE_ID"
}

variable "cert_san_1" {
  description = "Domain Name 1"
  type        = string
  default     = "*.lab-internal.com.br"
}

variable "cert_san_2" {
  description = "Domain Name 2"
  type        = string
  default     = "vault.lab-internal.com.br"
}

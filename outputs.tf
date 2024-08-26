output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "kms_id" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.kms_key_id
}

output "s3_bucket" {
  description = "S3_Bucket"
  value       = aws_s3_bucket.vault.id
}

output "certificate_arn" {
  description = "ALB Certificate ARN"
  value       = module.acm.acm_certificate_arn
}
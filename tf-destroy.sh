#!/bin/bash


########################### Cluster Services Dependencies ###################################
tofu destroy -target helm_release.external-dns -auto-approve
tofu destroy -target helm_release.aws-load-balancer-controller -auto-approve
tofu destroy -target helm_release.vault -auto-approve
tofu destroy -target kubernetes_secret.eks-creds -auto-approve
tofu destroy -target kubernetes_secret.vault-acm-cert -auto-approve
tofu destroy -target kubernetes_secret.vault-secret -auto-approve
tofu destroy -target kubernetes_namespace.vault -auto-approve

tofu destroy -auto-approve

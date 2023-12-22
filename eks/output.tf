output "endpoint" {
  value = aws_eks_cluster.rcdemo-eks.endpoint
}

output "kubeconfig" {
  value = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.rcdemo-eks.id}"
}
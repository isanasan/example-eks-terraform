output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "target_group_id" {
  description = "The ID of the TargetGroup"
  value       = aws_lb_target_group.hoge_eks.id
}

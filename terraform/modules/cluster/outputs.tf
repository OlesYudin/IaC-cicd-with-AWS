# Output VPC CIDR
output "vpc_ip" {
  value = aws_vpc.vpc.cidr_block
}
# Output VPC id
output "vpc_id" {
  value = aws_vpc.vpc.id
}
# Ouput subnets id
output "subnets_id" {
  value = aws_subnet.private_subnet.*.id
}
# Output Public Elastic IP
output "eip_public_ip" {
  value = aws_eip.nat_eip.public_ip
}
# Output DNS name of ALB
output "alb_dns" {
  value = aws_lb.alb.dns_name
}
# Output name of task definition
output "task_definition_family" {
  value = aws_ecs_task_definition.task-definition.family
}
# Output name of ECS cluster
output "task_definition_cluster" {
  value = aws_ecs_cluster.ecs-cluster.name
}
# Output name of ECS service
output "task_definition_service" {
  value = aws_ecs_service.password-generator.name
}

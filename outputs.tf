output "resource_group_id" {
  description = "Resource group ID used by this learning environment."
  value       = local.resource_group_id
}

output "instance_ids" {
  description = "List of created ECS instance IDs."
  value       = try(module.ecs_instance[0].instance_ids, [])
}

output "instance_id" {
  description = "First ECS instance ID for the single-node lab."
  value       = try(module.ecs_instance[0].instance_ids[0], null)
}

output "private_ips" {
  description = "List of private IPs for created ECS instances."
  value       = try(module.ecs_instance[0].private_ips, [])
}

output "private_ip" {
  description = "Private IP of the first ECS instance."
  value       = try(module.ecs_instance[0].private_ips[0], null)
}

output "public_ips" {
  description = "List of public IPs for created ECS instances."
  value       = try(module.ecs_instance[0].public_ips, [])
}

output "public_ip" {
  description = "Public IP of the first ECS instance."
  value       = try(module.ecs_instance[0].public_ips[0], null)
}

output "security_group_id" {
  description = "Dedicated security group ID created for the ECS lab."
  value       = try(module.ecs_instance[0].security_group_id, null)
}

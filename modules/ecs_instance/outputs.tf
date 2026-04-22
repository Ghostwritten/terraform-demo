output "security_group_id" {
  description = "Security group ID created for this ECS lab."
  value       = alicloud_security_group.this.id
}

output "instance_ids" {
  description = "ECS instance IDs."
  value       = alicloud_instance.this[*].id
}

output "private_ips" {
  description = "Private IPs assigned to ECS instances."
  value       = alicloud_instance.this[*].private_ip
}

output "public_ips" {
  description = "Public IPs assigned to ECS instances."
  value       = alicloud_instance.this[*].public_ip
}

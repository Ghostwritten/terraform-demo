output "resource_group_id" {
  description = "Foundation resource group ID."
  value       = alicloud_resource_manager_resource_group.this.id
}

output "resource_group_name" {
  description = "Foundation resource group name."
  value       = alicloud_resource_manager_resource_group.this.resource_group_name
}

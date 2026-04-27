resource "alicloud_resource_manager_resource_group" "this" {
  display_name        = var.resource_group_name
  resource_group_name = var.resource_group_name
}

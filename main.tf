locals {
  resource_group_id = var.create_resource_group ? alicloud_resource_manager_resource_group.this[0].id : var.existing_resource_group_id

  ecs_user_data = <<-EOF
    #!/bin/bash
    yum install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Learning    = "true"
    },
    var.common_tags
  )
}

resource "alicloud_resource_manager_resource_group" "this" {
  count = var.create_resource_group ? 1 : 0

  display_name        = var.resource_group_name
  resource_group_name = var.resource_group_name
}

module "ecs_instance" {
  count = var.create_ecs ? 1 : 0

  source = "./modules/ecs_instance"

  resource_group_id    = local.resource_group_id
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  availability_zone    = var.availability_zone
  image_id             = var.image_id
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  bandwidth_out        = var.bandwidth_out
  instance_password    = var.instance_password
  vpc_id               = var.vpc_id
  vswitch_id           = var.vswitch_id
  instance_count       = var.instance_count
  ssh_cidrs            = var.ssh_cidrs
  http_cidrs           = var.http_cidrs
  enable_http_rule     = var.enable_http_rule
  enable_ssh_rule      = var.enable_ssh_rule
  user_data            = local.ecs_user_data
  tags                 = local.common_tags
}

check "resource_group_input" {
  assert {
    condition     = var.create_resource_group || var.existing_resource_group_id != ""
    error_message = "When create_resource_group is false, you must provide existing_resource_group_id."
  }
}

check "ecs_required_inputs" {
  assert {
    condition = !var.create_ecs || (
      var.vpc_id != "" &&
      var.vswitch_id != "" &&
      var.instance_password != ""
    )
    error_message = "When create_ecs is true, you must provide vpc_id, vswitch_id, and instance_password."
  }
}

check "single_instance_default" {
  assert {
    condition     = var.instance_count == 1 || var.enable_scale_lab
    error_message = "Set enable_scale_lab = true before creating more than one ECS instance."
  }
}

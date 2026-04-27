resource "alicloud_security_group" "this" {
  security_group_name = "${var.instance_name}-sg"
  vpc_id              = var.vpc_id
  description         = "Dedicated security group for the Terraform learning ECS lab."
}

resource "alicloud_security_group_rule" "ssh" {
  count = var.enable_ssh_rule ? length(var.ssh_cidrs) : 0

  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = var.ssh_cidrs[count.index]
}

resource "alicloud_security_group_rule" "http" {
  count = var.enable_http_rule ? length(var.http_cidrs) : 0

  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.this.id
  cidr_ip           = var.http_cidrs[count.index]
}

resource "alicloud_instance" "this" {
  count = var.instance_count

  instance_name = var.instance_count == 1 ? var.instance_name : format("%s-%02d", var.instance_name, count.index + 1)

  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  image_id          = var.image_id

  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size

  vswitch_id      = var.vswitch_id
  security_groups = [alicloud_security_group.this.id]

  internet_max_bandwidth_out = var.bandwidth_out
  password                   = var.instance_password
  resource_group_id          = var.resource_group_id
  user_data                  = var.user_data
  tags                       = var.tags
}

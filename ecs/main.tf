data "alicloud_images" "alinux" {
  owners      = "system"
  most_recent = true
  name_regex  = ".*Alibaba.*Linux.*"
}

locals {
  selected_image_id = try(data.alicloud_images.alinux.images[0].id, null)
}

resource "alicloud_instance" "demo" {
  instance_name     = "tf-demo-ecs"
  instance_type     = "ecs.c9i.large"
  availability_zone = "cn-hangzhou-b"

  image_id = local.selected_image_id

  system_disk_category       = "cloud_essd"
  system_disk_size           = 40
  vswitch_id                 = "vsw-bp1fd12ephv5gskixctys"
  security_groups            = ["sg-bp1ft576ohr29b383u6n"]
  internet_max_bandwidth_out = 1
}

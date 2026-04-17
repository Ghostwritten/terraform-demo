data "alicloud_images" "alinux" {
  name_regex  = "Alibaba Cloud Linux 3.*"
  most_recent = true
  owners      = "system"
}

resource "alicloud_instance" "demo" {
  instance_name     = "tf-demo-ecs"
  instance_type     = "ecs.c6.large"
  availability_zone = "cn-hangzhou-b"

  image_id = data.alicloud_images.alinux.images[0].id

  system_disk_category       = "cloud_efficiency"
  system_disk_size           = 20
  vswitch_id                 = "vsw-bp1fd12ephv5gskixctys"
  security_groups            = ["sg-bp1ft576ohr29b383u6n"]
  internet_max_bandwidth_out = 1

  password = "YourPassword123!"
}

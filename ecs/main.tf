terraform {
  required_version = ">= 1.5.0"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.114.0, < 2.0.0"
    }
  }
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_instance_types" "demo" {
  availability_zone = "cn-hangzhou-b"
  cpu_core_count    = 2
  memory_size       = 2
}

variable "password" {
  type      = string
  sensitive = true
}

resource "alicloud_instance" "demo" {
  instance_name = "tf-demo-ecs-mini"

  instance_type     = data.alicloud_instance_types.demo.instance_types[0].id
  availability_zone = "cn-hangzhou-b"

  image_id = "aliyun_3_x64_20G_alibase_20260326.vhd"

  system_disk_category = "cloud_efficiency"
  system_disk_size     = 20

  vswitch_id      = "vsw-bp1fd12ephv5gskixctys"
  security_groups = ["sg-bp1ft576ohr29b383u6n"]

  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 0

  password = var.password
}

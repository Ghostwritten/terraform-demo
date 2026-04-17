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

resource "alicloud_instance" "demo" {
  instance_name = "tf-demo-ecs"

  instance_type     = "ecs.c6.large"   # 推荐先用这个，稳定
  availability_zone = "cn-hangzhou-b"  # 必须和你的 vswitch 一致

  image_id = "aliyun_3_x64_20G_alibase_20260326.vhd"

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  vswitch_id      = "vsw-bp1fd12ephv5gskixctys"
  security_groups = ["sg-bp1ft576ohr29b383u6n"]

  internet_max_bandwidth_out = 1

  password = "YourPassw0rd123!"  # ⚠️ 改成你自己的
}

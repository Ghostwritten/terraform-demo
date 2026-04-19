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

variable "password" {
  type      = string
  sensitive = true
}

resource "alicloud_instance" "demo" {
  instance_name = "tf-demo-ecs-mini"

  instance_type     = "ecs.e-c1m1.large"
  availability_zone = "cn-hangzhou-b"

  image_id = "aliyun_3_x64_20G_alibase_20260326.vhd"

  # 对齐控制台里的 ESSD AutoPL 20GiB
  system_disk_category = "cloud_auto"
  system_disk_size     = 21

  vswitch_id      = "vsw-bp1fd12ephv5gskixctys"
  security_groups = ["sg-bp1ft576ohr29b383u6n"]

  # 控制台显示未分配公网 IP
  internet_max_bandwidth_out = 0

  password = var.password
}

output "instance_id" {  
value = alicloud_instance.demo.id  
}  
  
output "instance_name" {  
value = alicloud_instance.demo.instance_name  
}  
  
output "private_ip" {  
value = alicloud_instance.demo.private_ip  
}

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.0"
    }
  }
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_resource_manager_resource_group" "demo" {
  display_name = "tf-demo-group"
  name         = "tf-demo-group"
}

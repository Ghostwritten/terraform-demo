terraform {
  required_version = ">= 1.7.0"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.114.0, < 2.0.0"
    }
  }
}

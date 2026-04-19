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

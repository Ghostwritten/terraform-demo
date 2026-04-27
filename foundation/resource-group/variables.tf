variable "region" {
  type        = string
  description = "Alibaba Cloud region for the foundation resource group."
  default     = "cn-hangzhou"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the low-cost foundation resource group."
  default     = "tf-demo-foundation-rg"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the foundation resource group."
  default = {
    ManagedBy = "Terraform"
    Learning  = "true"
    Layer     = "foundation"
  }
}

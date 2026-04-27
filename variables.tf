variable "region" {
  type        = string
  description = "Alibaba Cloud region for this learning environment."
  default     = "cn-hangzhou"
}

variable "environment" {
  type        = string
  description = "Logical environment name used in naming and tags."
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Project prefix used in resource names."
  default     = "terraform-demo"
}

variable "create_resource_group" {
  type        = bool
  description = "Whether Terraform should create a dedicated resource group for this lab."
  default     = true
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name to create or reuse."
  default     = "tf-demo-learning-rg"
}

variable "existing_resource_group_id" {
  type        = string
  description = "Existing resource group ID to reuse when create_resource_group is false."
  default     = ""
}

variable "create_ecs" {
  type        = bool
  description = "Whether to create ECS resources for the lab."
  default     = false
}

variable "instance_name" {
  type        = string
  description = "Base name for ECS instances."
  default     = "tf-demo-ecs"
}

variable "instance_type" {
  type        = string
  description = "ECS instance type. Pick the cheapest class available in your region for practice."
  default     = "ecs.e-c1m1.large"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the ECS instance."
  default     = "cn-hangzhou-b"
}

variable "system_disk_category" {
  type        = string
  description = "System disk category for the ECS instance."
  default     = "cloud_auto"
}

variable "system_disk_size" {
  type        = number
  description = "System disk size in GiB."
  default     = 20

  validation {
    condition     = var.system_disk_size >= 20 && var.system_disk_size <= 200
    error_message = "system_disk_size must be between 20 and 200 GiB."
  }
}

variable "bandwidth_out" {
  type        = number
  description = "Public outbound bandwidth in Mbps. Use 0 to disable public IP allocation."
  default     = 0

  validation {
    condition     = var.bandwidth_out >= 0 && var.bandwidth_out <= 5
    error_message = "bandwidth_out must stay between 0 and 5 Mbps for this low-cost lab."
  }
}

variable "instance_password" {
  type        = string
  description = "Login password for the ECS instance. Prefer setting this in a non-committed tfvars file or environment variable."
  default     = ""
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID used by the ECS module."
  default     = ""
}

variable "vswitch_id" {
  type        = string
  description = "Existing vSwitch ID used by the ECS module."
  default     = ""
}

variable "image_id" {
  type        = string
  description = "Alibaba Cloud image ID for the ECS instance."
  default     = "aliyun_3_x64_20G_alibase_20260326.vhd"
}

variable "instance_count" {
  type        = number
  description = "Number of ECS instances to create for scale exercises."
  default     = 1

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 3
    error_message = "instance_count must be between 1 and 3."
  }
}

variable "enable_scale_lab" {
  type        = bool
  description = "Explicit switch to allow instance_count > 1 during the short-lived scale lab."
  default     = false
}

variable "ssh_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access SSH."
  default     = ["0.0.0.0/0"]
}

variable "http_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access HTTP."
  default     = ["0.0.0.0/0"]
}

variable "enable_http_rule" {
  type        = bool
  description = "Whether to open HTTP access on port 80."
  default     = true
}

variable "enable_ssh_rule" {
  type        = bool
  description = "Whether to open SSH access on port 22."
  default     = true
}

variable "common_tags" {
  type        = map(string)
  description = "Additional tags to apply to managed resources."
  default     = {}
}

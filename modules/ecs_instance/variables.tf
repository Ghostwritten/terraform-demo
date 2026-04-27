variable "resource_group_id" {
  type        = string
  description = "Resource group ID for ECS resources."
}

variable "instance_name" {
  type        = string
  description = "Base instance name."
}

variable "instance_type" {
  type        = string
  description = "ECS instance type."
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for instances."
}

variable "image_id" {
  type        = string
  description = "Image ID used to create the ECS instance."
}

variable "system_disk_category" {
  type        = string
  description = "System disk category."
}

variable "system_disk_size" {
  type        = number
  description = "System disk size in GiB."
}

variable "bandwidth_out" {
  type        = number
  description = "Public outbound bandwidth in Mbps."
}

variable "instance_password" {
  type        = string
  description = "Instance login password."
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID."
}

variable "vswitch_id" {
  type        = string
  description = "Existing vSwitch ID."
}

variable "instance_count" {
  type        = number
  description = "Number of ECS instances."
}

variable "ssh_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed for SSH ingress."
}

variable "http_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed for HTTP ingress."
}

variable "enable_http_rule" {
  type        = bool
  description = "Whether to create HTTP ingress rules."
}

variable "enable_ssh_rule" {
  type        = bool
  description = "Whether to create SSH ingress rules."
}

variable "user_data" {
  type        = string
  description = "Cloud-init or user data script to run at boot."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to managed resources."
  default     = {}
}

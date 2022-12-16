variable "aws_profile" {
  type        = string
  description = "AWS profile name"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region name"
  default     = "ap-southeast-1"
}

variable "instance_name" {
  type        = string
  description = "The Instance Name"
  default     = ""
}

variable "blueprint_id" {
  type        = string
  description = "The blueprint ID; More: aws lightsail get-blueprints"
  default     = "ubuntu_20_04"
}

variable "bundle_id" {
  type        = string
  description = "The instance bundle id; More: aws lightsail get-bundles"
  default     = "nano_2_0"
}
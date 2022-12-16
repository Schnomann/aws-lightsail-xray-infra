variable "aws_profile" {
  type        = string
  description = "AWS profile name"
  default     = "dev"
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

variable "available_zone" {
  type        = string
  description = "The Availability Zone in which to create your instance"
  default     = "ap-southeast-1a"
}

variable "bundle_id" {
  type        = string
  description = "The instance bundle id; More: aws lightsail get-bundles"
  default     = "nano_2_0"
}
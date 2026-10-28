variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used in resource names and tags"
  type        = string
  default     = "travelmemory"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Learner name or identifier"
  type        = string
  default     = "student"
}

variable "availability_zone" {
  description = "Optional availability zone. Leave blank to use the first available AZ."
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "web_instance_type" {
  description = "EC2 type for web server"
  type        = string
  default     = "t3.small"
}

variable "db_instance_type" {
  description = "EC2 type for database server"
  type        = string
  default     = "t3.micro"
}

variable "ssh_allowed_cidr" {
  description = "Your public IP in CIDR format, for example 203.0.113.10/32"
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_allowed_cidr, 0)) && var.ssh_allowed_cidr != "0.0.0.0/0"
    error_message = "ssh_allowed_cidr must be a valid CIDR and must not be 0.0.0.0/0."
  }
}

variable "public_key_path" {
  description = "Absolute path of the SSH public key on your laptop"
  type        = string
}

variable "private_key_path" {
  description = "Absolute path of the SSH private key on your laptop"
  type        = string
}
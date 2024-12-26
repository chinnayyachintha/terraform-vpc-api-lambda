# VPC Name
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

# CIDR Block for the VPC
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Availability Zones
variable "azs" {
  description = "List of Availability Zones to deploy subnets in"
  type        = list(string)
}

# Private Subnets CIDR Blocks
variable "pvt_subnets" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

# Public Subnets CIDR Blocks
variable "pub_subnets" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

# AWS Region
variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
}

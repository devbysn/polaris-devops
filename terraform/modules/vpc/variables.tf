variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "The availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "enable_nat_gw" {
  description = "Enable NAT Gateway"
  type        = bool
}

variable "single_nat_gw" {
  description = "Single NAT Gateway"
  type        = bool
}

variable "enable_dns_hosts" {
  description = "Enable DNS Hostnames"
  type        = bool
}

variable "name" {
  description = "Name prefix for VPC"
  type        = string
  default     = "demo-eks-vpc"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "azs" {
  description = "Optional list of AZs to use"
  type        = list(string)
  default     = []
}

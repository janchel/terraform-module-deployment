module "vpc" {
  source = "git::https://github.com/janchel/terraform-module-source.git//modules/vpc?ref=v1.0.0"

  name = var.name
  cidr = var.cidr

  azs = var.azs

  public_subnet_tags = {
    Type = "Public"
  }

  private_subnet_tags = {
    Type = "Private"
  }

  # Module applies a Name tag and merges these subnet tags per its implementation
}

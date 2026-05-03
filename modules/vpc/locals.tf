locals {
  public_subnets = [
    for idx, cidr in var.public_subnet_cidrs : {
      cidr = cidr
      az   = var.availability_zones[idx % length(var.availability_zones)]
      name = "public-${idx + 1}"
    }
  ]

  private_subnets = [
    for idx, cidr in var.private_subnet_cidrs : {
      cidr = cidr
      az   = var.availability_zones[idx % length(var.availability_zones)]
      name = "private-${idx + 1}"
    }
  ]
}
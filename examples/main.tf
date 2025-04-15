module "network" {
  source     = "github.com/andreswebs/terraform-aws-vpc"
  name       = var.network_name
  cidr_block = var.network_cidr_ipv4

  private_subnet_cidr_blocks = var.private_subnet_cidrs_ipv4
  public_subnet_cidr_blocks  = var.public_subnet_cidrs_ipv4

  az_indexes = "2,4,6"
}

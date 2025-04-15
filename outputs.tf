output "vpc" {
  description = "The `aws_vpc` resource"
  value       = aws_vpc.this
}

output "dhcp_options" {
  description = "The `aws_vpc_dhcp_options` resource"
  value       = try(aws_vpc_dhcp_options.this[0], null)
}

output "igw" {
  description = "The `aws_internet_gateway` resource"
  value       = try(aws_internet_gateway.this[0], null)
}

output "public_subnet" {
  description = "List of public `aws_subnet` resources"
  value       = aws_subnet.public
}

output "private_subnet" {
  description = "List of private `aws_subnet` resources"
  value       = aws_subnet.private
}

output "network_acl" {
  description = "Object containing the private and public `aws_network_acl` resources"
  value = {
    private = try(aws_network_acl.private[0], null)
    public  = try(aws_network_acl.public[0], null)
  }
}

output "nat_ip" {
  description = "List of `aws_eip` resources created the NAT Gateway(s)"
  value       = aws_eip.nat
}

output "nat_public_ip" {
  description = "List of public Elastic IPs assigned to the NAT Gateway(s)"
  value       = var.reuse_nat_ips ? var.external_nat_ips : aws_eip.nat[*].public_ip
}

output "nat" {
  description = "List of `aws_nat_gateway` resources"
  value       = aws_nat_gateway.this
}

output "azs" {
  description = "AZ names or IDs"
  value       = local.azs
}

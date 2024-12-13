resource "ibm_resource_group" "resource_group" {
  name = var.resource_group_name

}

resource "ibm_is_vpc" "vpc" {
  for_each = var.vpc

  name           = each.key
  resource_group = each.value.vpc_resource_group_id
  
  # address_prefix_management = "manual"
  tags = ["Name:${each.key}"]
}

# resource "ibm_is_vpc_address_prefix" "khaled" {
#   name = "address-prefix"
#   zone = "eu-de"
#   vpc  = var.vpc_id
#   cidr = "192.168.0.0/16"
# }


resource "ibm_is_vpc_routing_table" "khaled" {
  name = "khaled-routing-table"
  vpc  = var.vpc_id
}

resource "ibm_is_public_gateway" "gateway" {
  name = "khaled-gateway"
  vpc  = var.vpc_id
  zone = "us-south-1"

}

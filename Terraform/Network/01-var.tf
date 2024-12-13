
variable "resource_group_name" {
  type = string
}

variable "vpc" {

  type = map(object({
    vpc_resource_group_id = string
  }))

}

variable "subnet" {

  type = map(object({
    subnet_zone        = string
    subent_vpc_id      = string
    subnet_cider_block = string
    public_gateway     = string
  }))

}

variable "F_ip" {

  type = map(
    object({
      primary_network_interface_id = string
    })
  )

}

variable "ibmcloud_api_key" {}

variable "vpc_id" {}

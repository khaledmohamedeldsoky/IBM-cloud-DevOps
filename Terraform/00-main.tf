module "network" {
  source = "/home/ubuntu/DevOps/Terraform/Network"

  ibmcloud_api_key = var.ibmcloud_api_key

  resource_group_name = "khaled"

  vpc = {

    "vpc-khaled" = {
      vpc_resource_group_id = module.network.resource_group.id
    }

  }
  vpc_id = module.network.vpc["vpc-khaled"].id
  subnet = {

        # "public-subnet-mohsen" = {
    #   subnet_zone        = var.zone_eu_de
    #   subent_vpc_id      = module.network.vpc["vpc-khaled"].id
    #   subnet_cider_block = var.cider_block_192_168_3
    #   public_gateway     = false
    #   # routing_table      = module.network.routing_table["khaled"].routing_table
    # }

    "public-subnet-kube" = {
      subnet_zone        = var.zone_eu_de
      subent_vpc_id      = module.network.vpc["vpc-khaled"].id
      subnet_cider_block = var.cider_block_192_168_1
      public_gateway     = true
      # routing_table      = module.network.routing_table["khaled"].routing_table
    }

    "private-subnet-kube" = {
      subnet_zone        = var.zone_eu_de
      subent_vpc_id      = module.network.vpc["vpc-khaled"].id
      subnet_cider_block = var.cider_block_192_168_2
      public_gateway     = false
      # routing_table      = module.network.routing_table["khaled"].routing_table
    }




  }


  F_ip = {

    # mohsen = {
    #   primary_network_interface_id = module.compute.instance["instance-mohsen"].primary_network_interface[0].id
    # }

    master = {
      primary_network_interface_id = module.compute.instance["instance-master"].primary_network_interface[0].id
    }

  }

}


module "security" {
  source           = "/home/ubuntu/DevOps/Terraform/Security"
  ibmcloud_api_key = var.ibmcloud_api_key
  SG = {

    # "mohsen" = {
    #   vpc_id = module.network.vpc["vpc-khaled"].id
    # }

    "master" = {
      vpc_id = module.network.vpc["vpc-khaled"].id
    }

    "node" = {
      vpc_id = module.network.vpc["vpc-khaled"].id
    }


  }





  SGR_tcp = {
    for rule in local.all_rules : "${rule.group_name}_${rule.direction}_${rule.name}" => {
      group     = module.security.security_group["${rule.group_name}"].id
      direction = "${rule.direction}"
      remote    = "${rule.remote}"
      port_max  = "${rule.port_max}"
      port_min  = "${rule.port_min}"
    }
  }


  SGR_icmp = {

    # SGR_icmp_mohsen_inbound = {
    #   group     = module.security.security_group["mohsen"].id
    #   direction = var.direction_inbound
    #   remote    = var.remote_0
    # }

    SGR_icmp_master_inbound = {
      group     = module.security.security_group["master"].id
      direction = var.direction_inbound
      remote    = var.remote_0
    }

    SGR_icmp_node_inbound = {
      group     = module.security.security_group["node"].id
      direction = var.direction_inbound
      remote    = var.remote_0
    }

    #---------- outbound ----------#
    # SGR_icmp_mohsen_outbound = {
    #   group     = module.security.security_group["mohsen"].id
    #   direction = var.direction_outbound
    #   remote    = var.remote_0
    # }


    SGR_icmp_master_outbound = {
      group     = module.security.security_group["master"].id
      direction = var.direction_outbound
      remote    = var.remote_0
    }

    SGR_icmp_node_outbound = {
      group     = module.security.security_group["node"].id
      direction = var.direction_outbound
      remote    = var.remote_0
    }

  }

  ssh_key = {

    # mohsen = {
    #   path     = var.path_ssh_key_mohsen
    #   ssh_type = var.ssh_type_rsa
    # }

    master = {
      path     = var.path_ssh_key_master
      ssh_type = var.ssh_type_rsa
    }

    node = {
      path     = var.path_ssh_key_node
      ssh_type = var.ssh_type_rsa
    }


  }


}

module "compute" {
  source = "/home/ubuntu/DevOps/Terraform/Compute"

  ibmcloud_api_key = var.ibmcloud_api_key


  instance = {

    # "instance-mohsen" = {
    #   instance_vpc_id             = module.network.vpc["vpc-khaled"].id
    #   instance_profile            = var.profile_cpu8_ram32
    #   image                       = data.ibm_is_image.image_ubuntu.id
    #   instance_zone               = var.zone_eu_de
    #   instance_resource_group     = module.network.resource_group.id
    #   instance_keys               = module.security.ssh_key["mohsen"].id
    #   instance_subnet_id          = module.network.subnet["public-subnet-mohsen"].id
    #   instance_security_groups_id = module.security.security_group["mohsen"].id
    # }

    "instance-master" = {
      instance_vpc_id             = module.network.vpc["vpc-khaled"].id
      instance_profile            = var.profile_cpu2_ram8
      image                       = data.ibm_is_image.image_ubuntu.id
      instance_zone               = var.zone_eu_de
      instance_resource_group     = module.network.resource_group.id
      instance_keys               = module.security.ssh_key["master"].id
      instance_subnet_id          = module.network.subnet["public-subnet-kube"].id
      instance_security_groups_id = module.security.security_group["master"].id
    }

    "instance-node-1" = {
      instance_vpc_id             = module.network.vpc["vpc-khaled"].id
      instance_profile            = var.profile_cpu2_ram8
      image                       = data.ibm_is_image.image_ubuntu.id
      instance_zone               = var.zone_eu_de
      instance_resource_group     = module.network.resource_group.id
      instance_keys               = module.security.ssh_key["node"].id
      instance_subnet_id          = module.network.subnet["private-subnet-kube"].id
      instance_security_groups_id = module.security.security_group["node"].id
    }

    "instance-node-2" = {
      instance_vpc_id             = module.network.vpc["vpc-khaled"].id
      instance_profile            = var.profile_cpu2_ram8
      image                       = data.ibm_is_image.image_ubuntu.id
      instance_zone               = var.zone_eu_de
      instance_resource_group     = module.network.resource_group.id
      instance_keys               = module.security.ssh_key["node"].id
      instance_subnet_id          = module.network.subnet["private-subnet-kube"].id
      instance_security_groups_id = module.security.security_group["node"].id
    }

  }

}

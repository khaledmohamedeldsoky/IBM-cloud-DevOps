# ----------- Network ----------- #
zone_us_south = "us-south"
zone_eu_gb    = "eu-gb"
zone_eu_de    = "us-south-1"

ibmcloud_api_key = "EW3IW75-O6HzoGHwUqmayY9tDkP7fbQ4jr3dK8YnzT_C"

cider_block_192_168_1 = "10.240.0.0/24"
cider_block_192_168_2 = "10.240.1.0/24"
cider_block_192_168_3 = "10.240.2.0/24"

# ----------- Security ----------- #

direction_inbound  = "inbound"
direction_outbound = "outbound"

remote_0 = "0.0.0.0/0"

port_max_22 = "22"
port_min_22 = "22"

port_max_443 = "443"
port_min_443 = "443"

port_max_80 = "80"
port_min_80 = "80"

port_min_53 = "53"
port_max_53 = "53"

path_ssh_key_master = "/home/ubuntu/DevOps/Terraform/ssh_public_key/master.pub"
path_ssh_key_mohsen = "/home/ubuntu/DevOps/Terraform/ssh_public_key/mohsen.pub"
path_ssh_key_node   = "/home/ubuntu/DevOps/Terraform/ssh_public_key/node.pub"
ssh_type_rsa        = "rsa"


# ----------- Compute ----------- #
profile_cpu2_ram8  = "bx2-2x8"
profile_cpu8_ram32 = "bx2-8x32"

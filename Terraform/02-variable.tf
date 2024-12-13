# ----------- Network ----------- #
variable "ibmcloud_api_key" {}

variable "zone_eu_de" {}

variable "cider_block_192_168_1" {}
variable "cider_block_192_168_2" {}
variable "cider_block_192_168_3" {}

# ----------- Security ----------- #
variable "direction_inbound" {}
variable "direction_outbound" {}

variable "remote_0" {}

variable "port_max_22" {}
variable "port_min_22" {}
variable "port_max_443" {}
variable "port_min_443" {}
variable "port_max_80" {}
variable "port_min_80" {}
variable "port_max_53" {}
variable "port_min_53" {}

variable "path_ssh_key_master" {}
variable "path_ssh_key_mohsen" {}
variable "path_ssh_key_node" {}
variable "ssh_type_rsa" {}

# ----------- Compute ----------- #

variable "profile_cpu2_ram8" {}
variable "profile_cpu8_ram32" {}


# ----------- null_resource ----------- #

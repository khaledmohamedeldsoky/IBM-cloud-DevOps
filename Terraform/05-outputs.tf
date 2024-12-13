# -------- public ip 
output "ip" {
  value = data.ibm_is_floating_ip.public_ip_master.address
}

data "ibm_is_floating_ip" "public_ip_master" {
  name = "master"
}

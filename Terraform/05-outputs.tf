# -------- public ip 
output "ip" {
  value = data.ibm_is_floating_ip.public_ip_master.address

}

data "ibm_is_floating_ip" "public_ip_master" {
  name = "master"
  depends_on = [ module.compute ,
  null_resource.delay
  ]
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

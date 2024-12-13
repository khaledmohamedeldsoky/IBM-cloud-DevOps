output "instance" {
  value = { for instances in ibm_is_instance.instance : instances.name => {
    name                      = instances.name
    id                        = instances.id
    primary_network_interface = instances.primary_network_interface
  } }
}

resource "azurerm_virtual_network" "azure_vnet" {
  for_each            = var.virtual_network
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags

  dynamic "subnet" {
    for_each = each.value.subnet
    content {
      name             = subnet.value.subnet_name
      address_prefixes = subnet.value.address_prefixes
      security_group   = subnet.value.security_group
    }
  }

}



#  output "subid01" {
# value = {for sub , hub in azurerm_virtual_network.azure_vnet[each.key].subnet:sub => hub.id}
  
# }



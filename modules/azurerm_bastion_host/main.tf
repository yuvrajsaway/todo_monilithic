resource "azurerm_bastion_host" "bastion_host" {
  for_each            = var.bastion_host
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                 = ip_configuration.value.name
      subnet_id            = data.azurerm_subnet.subnet_id[each.key].id
      public_ip_address_id = data.azurerm_public_ip.public_ip_id[each.key].id
    }
  }
}


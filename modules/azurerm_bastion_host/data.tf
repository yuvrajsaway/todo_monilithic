data "azurerm_subnet" "subnet_id" {
  for_each             = var.bastion_host
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "public_ip_id" {
  for_each            = var.bastion_host
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

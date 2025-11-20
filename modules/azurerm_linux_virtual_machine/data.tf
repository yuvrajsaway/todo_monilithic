data "azurerm_network_interface" "data_nic" {
  for_each            = var.linux_virtual_machine
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "vmusername" {
  name         = "vmusername"
  key_vault_id = var.keyvault_id
}

data "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  key_vault_id = var.keyvault_id
}

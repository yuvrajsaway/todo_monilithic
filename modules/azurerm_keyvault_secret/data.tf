data "azurerm_key_vault" "key_vault" {
  for_each = var.kvsecret
  name                = each.value.keyvaultname
  resource_group_name = each.value.rg_name
}


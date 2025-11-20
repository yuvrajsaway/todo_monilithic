resource "azurerm_key_vault_secret" "kvsecret" {
  for_each = var.kvsecret
  name         = each.value.kvsecretname
  value        = each.value.kvsecretname_value
  key_vault_id = data.azurerm_key_vault.key_vault[each.key].id
}


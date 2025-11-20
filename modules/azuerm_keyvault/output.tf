output "keyvault_ids" {
  value = {
    for k, v in azurerm_key_vault.key_vault : k => v.id
  }
}
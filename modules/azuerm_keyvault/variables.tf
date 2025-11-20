variable "key_vault" {
  type = map(object({
    keyvaultname                = string
    location                    = string
    rg_name                     = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    tags = map(string)
  }))

}


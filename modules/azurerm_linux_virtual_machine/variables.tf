variable "linux_virtual_machine" {
  type = map(object({
    vm_name  = string
    location = string
    rg_name  = string
    size     = string
    nic_name = string
    tags     = optional(map(string))
    os_disk = map(object({
      caching              = string
      storage_account_type = string

    }))
    source_image_reference = map(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
  }))
  }))
}

variable "keyvault_id" {
  type = string
}

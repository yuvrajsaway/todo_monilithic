# ---------------------------------------------------------
# Resource Group Variables
# ---------------------------------------------------------
variable "resource_group" {
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

# ---------------------------------------------------------
# Network Security Group (NSG) Variables
# ---------------------------------------------------------
variable "network_security_group" {
  type = map(object({
    nsg_name             = string
    location             = string
    rg_name              = string
    subnet_name          = string
    virtual_network_name = string
    nic_name             = string
    tags                 = optional(map(string))

    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

# ---------------------------------------------------------
# Public IP Variables
# ---------------------------------------------------------
variable "public_ip" {
  type = map(object({
    pip_name          = string
    rg_name           = string
    location          = string
    allocation_method = string
    tags              = optional(map(string))
  }))
}


# ---------------------------------------------------------
# Bastion Host Variables
# ---------------------------------------------------------

variable "bastion_host" {
  type = map(object({
    bastion_name         = string
    rg_name              = string
    location             = string
    pip_name             = string
    subnet_name          = string
    virtual_network_name = string
    ip_configuration = map(object({
      name = string
    }))
  }))
}



# ---------------------------------------------------------
# Virtual Network (VNet + Subnets) Variables
# ---------------------------------------------------------
variable "virtual_network" {
  type = map(object({
    vnet_name     = string
    location      = string
    rg_name       = string
    address_space = list(string)
    dns_servers   = optional(list(string))
    managed_by    = optional(string)
    tags          = optional(map(string))

    subnet = map(object({
      subnet_name      = string
      address_prefixes = list(string)
      security_group   = optional(string)
    }))
  }))
}

# ---------------------------------------------------------
# Network Interface Card (NIC) Variables
# ---------------------------------------------------------
variable "nic" {
  type = map(object({
    nic_name             = string
    location             = string
    rg_name              = string
    subnet_name          = string
    virtual_network_name = string
    tags                 = optional(map(string))

    ip_configuration = map(object({
      name                          = string
      private_ip_address_allocation = string
    }))
  }))
}

# ---------------------------------------------------------
# Linux Virtual Machine Variables
# ---------------------------------------------------------
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

# ---------------------------------------------------------
# MSSQL server Variables
# ---------------------------------------------------------

variable "mssqlserver" {
  type = map(object({
    mssqlserver_name             = string
    rg_name                      = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
    minimum_tls_version          = string
    azured_login_username        = string
    object_id                    = string
    tags                         = map(string)
  }))
}

# ---------------------------------------------------------
# MSSQL DATABASE Variables
# ---------------------------------------------------------

variable "mssql_database" {
  type = map(object({
    db_name          = string
    mssqlserver_name = string
    rg_name          = string
    collation        = string
    license_type     = string
    max_size_gb      = number
    sku_name         = string
    enclave_type     = string
    tags             = map(string)

  }))

}

# ---------------------------------------------------------
# Keyvault Variables
# ---------------------------------------------------------

variable "key_vault" {
  type = map(object({
    keyvaultname                = string
    location                    = string
    rg_name                     = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    tags                        = map(string)
  }))

}

# ---------------------------------------------------------
# Keyvault Secret Variables
# ---------------------------------------------------------

variable "kvsecret" {
  type = map(object({
    kvsecretname       = string
    kvsecretname_value = string
    keyvaultname       = string
    rg_name            = string
  }))
}

# ---------------------------------------------------------
# load balancer Variables
# ---------------------------------------------------------

variable "load_balancer" {
  type = map(object({
    lb_name           = string
    location          = string
    rg_name           = string
    frontend_ip_conf  = string
    pip_name          = string
    backend_pool_name = string
    healthprobe_name  = string
    healthprobe_port  = number
    lb_rulename       = string
    protocol          = string
    frontend_port     = number
    backend_port      = number
  }))

}

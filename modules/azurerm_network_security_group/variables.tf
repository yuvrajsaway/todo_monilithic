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


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

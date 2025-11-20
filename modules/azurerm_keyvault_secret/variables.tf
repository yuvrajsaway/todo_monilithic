variable "kvsecret" {
  type = map(object({
    kvsecretname       = string
    kvsecretname_value = string
    keyvaultname       = string
    rg_name            = string

  }))

}

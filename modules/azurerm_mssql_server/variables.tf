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
    tags = map(string)
  }))
}

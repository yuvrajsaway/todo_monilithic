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

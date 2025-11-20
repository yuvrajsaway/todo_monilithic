data "azurerm_mssql_server" "mssql" {
  for_each = var.mssql_database
  name                = each.value.mssqlserver_name
  resource_group_name = each.value.rg_name
}
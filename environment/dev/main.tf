# ────────────────────────────────────────────────
# 1️⃣ 🌍 Create Azure Resource Group
# ────────────────────────────────────────────────
module "resource_group" {
  source         = "../../modules/azurerm_resource_group"
  resource_group = var.resource_group
}

# ────────────────────────────────────────────────
# 2️⃣ 🔐 Create Azure Key Vault
# ────────────────────────────────────────────────
module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../modules/azuerm_keyvault"
  key_vault  = var.key_vault
}

# ────────────────────────────────────────────────
# 3️⃣ 🔑 Create Key Vault Secrets
# ────────────────────────────────────────────────
module "kvsecret" {
  depends_on = [module.key_vault]
  source     = "../../modules/azurerm_keyvault_secret"
  kvsecret   = var.kvsecret
}

# ────────────────────────────────────────────────
# 4️⃣ 🌐 Create Virtual Network
# ────────────────────────────────────────────────
module "virtual_network" {
  depends_on      = [module.resource_group]
  source          = "../../modules/azurerm_virtual_network"
  virtual_network = var.virtual_network
}

# ────────────────────────────────────────────────
# 5️⃣ 🛡️ Create Network Security Group (NSG)
# ────────────────────────────────────────────────
module "network_security_group" {
  depends_on             = [module.virtual_network, module.resource_group]
  source                 = "../../modules/azurerm_network_security_group"
  network_security_group = var.network_security_group
}

# ────────────────────────────────────────────────
# 6️⃣ 🔌 Create Network Interface (NIC)
# ────────────────────────────────────────────────
module "network_interface" {
  depends_on = [
    module.virtual_network,
    module.resource_group
  ]
  source = "../../modules/azurerm_network_interface"
  nic    = var.nic
}

# ────────────────────────────────────────────────
# 7️⃣ 🌐 Create Public IP (for Bastion / VM)
# ────────────────────────────────────────────────
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  public_ip  = var.public_ip
}

# ────────────────────────────────────────────────
# 8️⃣ 🧱 Create Azure Bastion Host
# ────────────────────────────────────────────────
module "bastion_host" {
  depends_on = [
    module.public_ip,
    module.virtual_network,
    module.resource_group
  ]
  source       = "../../modules/azurerm_bastion_host"
  bastion_host = var.bastion_host
}

# ────────────────────────────────────────────────
# 9️⃣ 🐧 Create Linux Virtual Machine
# ────────────────────────────────────────────────
module "linux_virtual_machine" {
  depends_on = [
    module.resource_group,
    module.network_interface,
    module.network_interface,
    module.key_vault,
    module.kvsecret
  ]

  source                = "../../modules/azurerm_linux_virtual_machine"
  linux_virtual_machine = var.linux_virtual_machine

  keyvault_id = module.key_vault.keyvault_ids["keyvault01"]
}

# ────────────────────────────────────────────────
# 🔟 🗄️ Create MSSQL Server
# ────────────────────────────────────────────────
module "mssqlserver" {
  depends_on  = [module.resource_group]
  source      = "../../modules/azurerm_mssql_server"
  mssqlserver = var.mssqlserver
}

# ────────────────────────────────────────────────
# 1️⃣1️⃣ 🗄️ Create MSSQL Database
# ────────────────────────────────────────────────
module "mssql_database" {
  depends_on     = [module.mssqlserver]
  source         = "../../modules/azurerm_mssql_database"
  mssql_database = var.mssql_database
}

# ────────────────────────────────────────────────
# 1️⃣2️⃣ 🗄️ Create Load Balancer
# ────────────────────────────────────────────────
module "load_balancer" {
  depends_on    = [
    module.resource_group,
    module.public_ip,
    module.network_interface,   # NIC must exist before LB pool association
    module.linux_virtual_machine  # VM must exist before NIC association
  ]
  source        = "../../modules/aurerm_load_balancer"
  load_balancer = var.load_balancer
}

# ────────────────────────────────────────────────
# 1️⃣3️⃣ 🟦 Attach ONLY FRONTEND NICs to LB Backend Pool
# ────────────────────────────────────────────────
resource "azurerm_network_interface_backend_address_pool_association" "frontend_nics_to_lb" {
  depends_on = [ module.load_balancer, module.network_interface, module.linux_virtual_machine ]

  for_each = {
    for vm_key, vm_value in var.linux_virtual_machine :
    vm_key => vm_value
    if startswith(vm_key, "front")   # filter → only frontend VMs join LB
  }

  network_interface_id    = module.network_interface.nic_ids[each.value.nic_name]
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = module.load_balancer.backend_pool_ids["lb01"]
}


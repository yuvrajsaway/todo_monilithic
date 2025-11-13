# ────────────────────────────────────────────────
# 🌍 Create Azure Resource Group
# ────────────────────────────────────────────────
module "resource_group" {
  source         = "../../modules/azurerm_resource_group"
  resource_group = var.resource_group
}

# ────────────────────────────────────────────────
# 🌐 Create Virtual Network
# ────────────────────────────────────────────────
module "virtual_network" {
  depends_on     = [ module.resource_group ]
  source          = "../../modules/azurerm_virtual_network"
  virtual_network = var.virtual_network
}

# ────────────────────────────────────────────────
# 🔌 Create Network Interface (NIC)
# ────────────────────────────────────────────────
module "network_interface" {
  depends_on = [ module.virtual_network, module.resource_group ]
  source     = "../../modules/azurerm_network_interface"
  nic        = var.nic
}

# ────────────────────────────────────────────────
# 🛡️ Create Network Security Group (NSG)
# ────────────────────────────────────────────────
module "network_security_group" {
  depends_on = [ module.virtual_network, module.network_interface, module.resource_group ]
  source                 = "../../modules/azurerm_network_security_group"
  network_security_group = var.network_security_group
}

# ────────────────────────────────────────────────
# 🌐 Create Public IP for Bastion or VM
# ────────────────────────────────────────────────
module "public_ip" {
  depends_on = [ module.resource_group ]
  source     = "../../modules/azurerm_public_ip"
  public_ip  = var.public_ip
}

# ────────────────────────────────────────────────
# 🧱 Create Azure Bastion Host for Secure Access
# ────────────────────────────────────────────────
module "bastion_host" {
  depends_on   = [ module.public_ip, module.virtual_network, module.resource_group ]
  source       = "../../modules/azurerm_bastion_host"
  bastion_host = var.bastion_host
}

# ────────────────────────────────────────────────
# 🐧 Create Linux Virtual Machine
# ────────────────────────────────────────────────
module "linux_virtual_machine" {
  depends_on            = [ module.resource_group, module.network_interface ]
  source                = "../../modules/azurerm_linux_virtual_machine"
  linux_virtual_machine = var.linux_virtual_machine
}

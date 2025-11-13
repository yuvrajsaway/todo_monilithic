# ╔══════════════════════════════════════════════════╗
# 🌍 Azure Resource Group Configuration
# ╚══════════════════════════════════════════════════╝
resource_group = {
  rg1 = {
    rg_name    = "yuvi_devrg01"
    location   = "eastus"
    managed_by = "devlopment_team_a"
    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🛡️ Network Security Group Configuration
# ╚══════════════════════════════════════════════════╝
network_security_group = {
  frontnsg01 = {
    nsg_name             = "frontnsg01"
    location             = "eastus"
    rg_name              = "yuvi_devrg01"
    subnet_name          = "frontend_subnet01"
    virtual_network_name = "yuvi_vnet01"
    nic_name             = "nic01"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    security_rules = [{
      name                       = "security_rules01"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }]
  }
}

# ╔══════════════════════════════════════════════════╗
# 🌐 Public IP Configuration
# ╚══════════════════════════════════════════════════╝
public_ip = {
  bastion_pip = {
    pip_name          = "bastion_pip"
    rg_name           = "yuvi_devrg01"
    location          = "eastus"
    allocation_method = "Static"
    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🧱 Azure Bastion Host Configuration
# ╚══════════════════════════════════════════════════╝
bastion_host = {
  bastion_host = {
    bastion_name         = "yuvi_bastionhost01"
    rg_name              = "yuvi_devrg01"
    location             = "eastus"
    pip_name             = "bastion_pip"
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "yuvi_vnet01"

    ip_configuration = {
      ip_config01 = {
        name = "bastion_ipconfig01"
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🌐 Virtual Network and Subnet Configuration
# ╚══════════════════════════════════════════════════╝
virtual_network = {
  vnet01 = {
    vnet_name     = "yuvi_vnet01"
    location      = "eastus"
    rg_name       = "yuvi_devrg01"
    address_space = ["20.1.0.0/16"]
    dns_servers   = ["20.1.0.4", "20.1.0.5"]
    managed_by    = "devlopment_team_a"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    subnet = [
      {
        subnet_name      = "frontend_subnet01"
        address_prefixes = ["20.1.1.0/24"]
      },
      {
        subnet_name      = "backend_subnet01"
        address_prefixes = ["20.1.2.0/24"]
      },
      {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["20.1.3.0/24"]
      }
    ]
  }
}

# ╔══════════════════════════════════════════════════╗
# 🔌 Network Interface Configuration (NIC)
# ╚══════════════════════════════════════════════════╝
nic = {
  frontendnic01 = {
    nic_name             = "nic01"
    location             = "eastus"
    rg_name              = "yuvi_devrg01"
    subnet_name          = "frontend_subnet01"
    virtual_network_name = "yuvi_vnet01"
    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    ip_configuration = {
      ip_config01 = {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }

    backendnic01 = {
      nic_name             = "nic02"
      location             = "eastus"
      rg_name              = "yuvi_devrg01"
      subnet_name          = "frontend_subnet01"
      virtual_network_name = "yuvi_vnet01"
      tags = {
        Environment = "Dev"
        Owner       = "Team A"
      }

      ip_configuration = {
        ip_config02 = {
          name                          = "ipconfig1"
          private_ip_address_allocation = "Dynamic"
        }
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🐧 Linux Virtual Machine Configuration
# ╚══════════════════════════════════════════════════╝
linux_virtual_machine = {
  frontendvm01 = {
    vm_name  = "frontendvm01"
    location = "eastus"
    rg_name  = "yuvi_devrg01"
    size     = "Standard_B1s"
    nic_name = "nic01"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    os_disk = {
      os_disk01 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      source_image_reference01 = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }

  backendvm01 = {
    vm_name  = "backendvm01"
    location = "eastus"
    rg_name  = "yuvi_devrg01"
    size     = "Standard_B1s"
    nic_name = "nic02"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    os_disk = {
      os_disk01 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      source_image_reference01 = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🌍 Azure Resource Group
# ╚══════════════════════════════════════════════════╝
resource_group = {
  rg1 = {
    rg_name    = "yuvi_devrg01"
    location   = "central india"
    managed_by = "devlopment_team_a"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🔐 Key Vault
# ╚══════════════════════════════════════════════════╝
key_vault = {
  keyvault01 = {
    keyvaultname                = "yuvikeyvault01"
    location                    = "central india"
    rg_name                     = "yuvi_devrg01"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🔑 Key Vault Secrets
# ╚══════════════════════════════════════════════════╝
kvsecret = {
  secret01 = {
    keyvaultname       = "yuvikeyvault01"
    rg_name            = "yuvi_devrg01"
    kvsecretname       = "vmusername"
    kvsecretname_value = "dataram"
  }

  secret02 = {
    keyvaultname       = "yuvikeyvault01"
    rg_name            = "yuvi_devrg01"
    kvsecretname       = "vmpassword"
    kvsecretname_value = "P@$$w0rd@1234#"
  }
}

# ╔══════════════════════════════════════════════════╗
# 🌐 Virtual Network & Subnets
# ╚══════════════════════════════════════════════════╝
virtual_network = {
  vnet01 = {
    vnet_name     = "yuvi_vnet01"
    location      = "central india"
    rg_name       = "yuvi_devrg01"
    address_space = ["20.1.0.0/16"]
    dns_servers   = ["20.1.0.4", "20.1.0.5"]
    managed_by    = "devlopment_team_a"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    subnet = {
      sub01 = {
        subnet_name      = "frontend_subnet01"
        address_prefixes = ["20.1.1.0/24"]
      }

      sub02 = {
        subnet_name      = "backend_subnet01"
        address_prefixes = ["20.1.2.0/24"]
      }

      sub03 = {
        subnet_name      = "AzureBastionSubnet"
        address_prefixes = ["20.1.3.0/24"]
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🛡️ Network Security Group
# ╚══════════════════════════════════════════════════╝
network_security_group = {
  frontnsg01 = {
    nsg_name             = "frontnsg01"
    location             = "central india"
    rg_name              = "yuvi_devrg01"
    subnet_name          = "frontend_subnet01"
    virtual_network_name = "yuvi_vnet01"
    nic_name             = "front_nic01"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    security_rules = {
      nsg01 = {
        name                       = "security_rules01"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🌐 Public IPs
# ╚══════════════════════════════════════════════════╝
public_ip = {
  bastion_pip = {
    pip_name          = "bastion_pip"
    rg_name           = "yuvi_devrg01"
    location          = "central india"
    allocation_method = "Static"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }

  lb_pip = {
    pip_name          = "lb_pip"
    rg_name           = "yuvi_devrg01"
    location          = "central india"
    allocation_method = "Static"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🧱 Azure Bastion Host
# ╚══════════════════════════════════════════════════╝
bastion_host = {
  bastion_host = {
    bastion_name         = "yuvi_bastionhost01"
    rg_name              = "yuvi_devrg01"
    location             = "central india"
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
# 🔌 NICs (Frontend & Backend)
# ╚══════════════════════════════════════════════════╝
nic = {
  # NIC for Frontend VM 01
  front_nic01 = {
    nic_name             = "front_nic01"
    location             = "central india"
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
  }
  # NIC for Frontend VM 02
  front_nic02 = {
    nic_name             = "front_nic02"
    location             = "central india"
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
  }
  # NIC for Backend VM 01
  back_nic01 = {
    nic_name             = "back_nic01"
    location             = "central india"
    rg_name              = "yuvi_devrg01"
    subnet_name          = "backend_subnet01"
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

# ╔══════════════════════════════════════════════════╗
# 🖥️ Linux Virtual Machines
# ╚══════════════════════════════════════════════════╝
linux_virtual_machine = {
  # VM: Frontend VM 01
  frontendvm01 = {
    vm_name  = "frontendvm01"
    location = "central india"
    rg_name  = "yuvi_devrg01"
    size     = "Standard_B1s"
    nic_name = "front_nic01"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    os_disk = {
      disk01 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      img01 = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }
  # VM: Frontend VM 02
  frontendvm02 = {
    vm_name  = "frontendvm02"
    location = "central india"
    rg_name  = "yuvi_devrg01"
    size     = "Standard_B1s"
    nic_name = "front_nic02"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    os_disk = {
      disk01 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      img01 = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }
  # VM: Backend VM 01
  backendvm01 = {
    vm_name  = "backendvm01"
    location = "central india"
    rg_name  = "yuvi_devrg01"
    size     = "Standard_B1s"
    nic_name = "back_nic01"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }

    os_disk = {
      disk01 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      img01 = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🗄️ MSSQL Server
# ╚══════════════════════════════════════════════════╝
mssqlserver = {
  mssql01 = {
    mssqlserver_name             = "yuvi-mssqlserver01"
    rg_name                      = "yuvi_devrg01"
    location                     = "central india"
    version                      = "12.0"
    administrator_login          = "sqladminuser"
    administrator_login_password = "MssqlPass@1234"
    minimum_tls_version          = "1.2"
    azured_login_username        = "Yuvraj@praveendevops55outlook.onmicrosoft.com"
    object_id                    = "4f5467a3-5807-4abc-a907-8b9d8d8d2eda"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🗄️ MSSQL Database
# ╚══════════════════════════════════════════════════╝
mssql_database = {
  mssql_db01 = {
    db_name          = "yuvidb01"
    mssqlserver_name = "yuvi-mssqlserver01"
    rg_name          = "yuvi_devrg01"
    collation        = "SQL_Latin1_General_CP1_CI_AS"
    license_type     = "BasePrice"
    max_size_gb      = 2
    sku_name         = "S0"
    enclave_type     = "VBS"

    tags = {
      Environment = "Dev"
      Owner       = "Team A"
    }
  }
}

# ╔══════════════════════════════════════════════════╗
# 🐧 Load Balancer
# ╚══════════════════════════════════════════════════╝
load_balancer = {
  lb01 = {
    lb_name           = "yuvi_lb01"
    location          = "central india"
    rg_name           = "yuvi_devrg01"
    frontend_ip_conf  = "frontendConfig01"
    pip_name          = "lb_pip"
    backend_pool_name = "backendPool01"
    healthprobe_name  = "healthProbe01"
    healthprobe_port  = 80
    lb_rulename       = "lbRule01"
    protocol          = "Tcp"
    frontend_port     = 80
    backend_port      = 80
  }
}

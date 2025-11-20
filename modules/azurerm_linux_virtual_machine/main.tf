resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each                        = var.linux_virtual_machine
  name                            = each.value.vm_name
  location                        = each.value.location
  resource_group_name             = each.value.rg_name
  size                            = each.value.size
  disable_password_authentication = "false"
  admin_username                  = data.azurerm_key_vault_secret.vmusername.value
  admin_password                  = data.azurerm_key_vault_secret.vmusername.value
  network_interface_ids = [data.azurerm_network_interface.data_nic[each.key].id]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }

  dynamic "source_image_reference" {
   for_each = each.value.source_image_reference
   content {
    publisher = source_image_reference.value.publisher
    offer     = source_image_reference.value.offer
    sku       = source_image_reference.value.sku
    version   = source_image_reference.value.version
    }
  }


  # nginx install during VM build
  custom_data = base64encode(<<-EOF
              #!/bin/bash
              # Fix DNS resolution for Ubuntu
              mkdir -p /etc/systemd/resolved.conf.d
              cat <<EOT >/etc/systemd/resolved.conf.d/dns.conf
              [Resolve]
              DNS=8.8.8.8
              FallbackDNS=1.1.1.1
              EOT

              systemctl restart systemd-resolved
              # Install nginx
              apt-get update -y
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF
)

}



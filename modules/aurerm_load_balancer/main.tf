resource "azurerm_lb" "load_balancer" {
  for_each            = var.load_balancer
  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_conf
    public_ip_address_id = data.azurerm_public_ip.public_ip_id[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  for_each        = var.load_balancer
  loadbalancer_id = azurerm_lb.load_balancer[each.key].id
  name            = each.value.backend_pool_name
}

resource "azurerm_lb_probe" "probe" {
  for_each        = var.load_balancer
  loadbalancer_id = azurerm_lb.load_balancer[each.key].id
  name            = each.value.healthprobe_name
  port            = each.value.healthprobe_port
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.load_balancer
  loadbalancer_id                = azurerm_lb.load_balancer[each.key].id
  name                           = each.value.lb_rulename
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_conf
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}



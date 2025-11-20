variable "load_balancer" {
  type = map(object({
    lb_name           = string
    location          = string
    rg_name           = string
    frontend_ip_conf  = string
    pip_name          = string
    backend_pool_name = string
    healthprobe_name  = string
    healthprobe_port  = number
    lb_rulename       = string
    protocol          = string
    frontend_port     = number
    backend_port      = number
  }))

}

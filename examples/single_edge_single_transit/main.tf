module "branch1" {
  source  = "terraform-aviatrix-modules/mc-edge/aviatrix"
  version = "1.1.2"

  site_id = "branch1"

  edge_gws = {
    gw1 = {
      gw_name                 = "gw1",
      lan_interface_ip_prefix = "10.50.10.10/24",
      wan_default_gateway_ip  = "1.1.1.1"
      wan_interface_ip_prefix = "1.1.1.10/24"

      transit_gws = {
        transit1 = {
          name = "transit1",
          #attached = true
        },
      }
    }
  }
}

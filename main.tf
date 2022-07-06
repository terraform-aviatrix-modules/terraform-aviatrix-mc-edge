resource "aviatrix_edge_spoke" "default" {
  #Required
  gw_name                     = "edge-test"
  site_id                     = "site-123"
  management_interface_config = "Static"
  wan_interface_ip_prefix     = "10.60.0.0/24"
  wan_default_gateway_ip      = "10.60.0.0"
  lan_interface_ip_prefix     = "10.60.0.0/24"
  ztp_file_type               = "iso"
  ztp_file_download_path      = "/ztp/download/path"

  #Optional
  management_egress_ip_prefix            = ""
  enable_management_over_private_network = false
  enable_edge_active_standby             = false
  enable_edge_active_standby_preemptive  = false
  management_interface_ip_prefix         = ""
  management_default_gateway_ip          = ""
  dns_server_ip                          = ""
  secondary_dns_server_ip                = ""

  #Advanced options
  local_as_number                  = "65000"
  prepend_as_path                  = []
  enable_learned_cidrs_approval    = false
  approved_learned_cidrs           = []
  spoke_bgp_manual_advertise_cidrs = []
  enable_preserve_as_path          = false
  bgp_polling_time                 = ""
  bgp_hold_time                    = ""
  enable_edge_transitive_routing   = false
  enable_jumbo_frame               = false
  latitude                         = ""
  longitude                        = ""
  wan_public_ip                    = ""
}

resource "aviatrix_segmentation_network_domain_association" "default" {
  count                = aviatrix_edge_spoke.default.state == "Up" && length(var.network_domain) > 0 && var.attached ? 1 : 0
  transit_gateway_name = "transit-gw-name"
  network_domain_name  = "network-domain-name"
  attachment_name      = "attachment-name"
}

# Create an Aviatrix Edge as a Spoke Transit Attachment
resource "aviatrix_edge_spoke_transit_attachment" "default" {
  count           = aviatrix_edge_spoke.default.state == "Up" && length(var.network_domain) > 0 && var.attached ? 1 : 0
  spoke_gw_name   = "edge-as-a-spoke"
  transit_gw_name = "transit-gw"
}

resource "aviatrix_edge_spoke_external_device_conn" "default" {
  count             = var.lan_bgp ? 1 : 0
  site_id           = "site-abcd1234"
  connection_name   = "conn"
  gw_name           = "eaas"
  bgp_local_as_num  = "123"
  bgp_remote_as_num = "345"
  local_lan_ip      = "10.230.3.23"
  remote_lan_ip     = "10.0.60.1"
}

resource "aviatrix_edge_spoke" "default" {
  #Required
  gw_name                     = var.gw_name
  site_id                     = var.site_id
  management_interface_config = var.management_interface_config
  wan_interface_ip_prefix     = var.wan_interface_ip_prefix
  wan_default_gateway_ip      = var.wan_default_gateway_ip
  lan_interface_ip_prefix     = var.lan_interface_ip_prefix
  ztp_file_type               = var.ztp_file_type
  ztp_file_download_path      = local.ztp_file_download_path

  #Optional
  management_egress_ip_prefix            = var.management_egress_ip_prefix
  enable_management_over_private_network = var.enable_management_over_private_network
  enable_edge_active_standby             = var.enable_edge_active_standby
  enable_edge_active_standby_preemptive  = var.enable_edge_active_standby_preemptive
  management_interface_ip_prefix         = var.management_interface_ip_prefix
  management_default_gateway_ip          = var.management_default_gateway_ip
  dns_server_ip                          = var.dns_server_ip
  secondary_dns_server_ip                = var.secondary_dns_server_ip

  #Advanced options
  local_as_number                  = var.local_as_number
  prepend_as_path                  = var.prepend_as_path
  enable_learned_cidrs_approval    = var.enable_learned_cidrs_approval
  approved_learned_cidrs           = var.approved_learned_cidrs
  spoke_bgp_manual_advertise_cidrs = var.spoke_bgp_manual_advertise_cidrs
  enable_preserve_as_path          = var.enable_preserve_as_path
  bgp_polling_time                 = var.bgp_polling_time
  bgp_hold_time                    = var.bgp_hold_time
  enable_edge_transitive_routing   = var.enable_edge_transitive_routing
  enable_jumbo_frame               = var.enable_jumbo_frame
  latitude                         = var.latitude
  longitude                        = var.longitude
  wan_public_ip                    = var.wan_public_ip
}

resource "aviatrix_segmentation_network_domain_association" "default" {
  count                = length(var.network_domain) > 0 && var.attached ? 1 : 0
  transit_gateway_name = var.transit_gw
  network_domain_name  = var.network_domain
  attachment_name      = aviatrix_edge_spoke.default.gw_name

  lifecycle {
    precondition {
      condition     = aviatrix_edge_spoke.default.state == "up"
      error_message = "The edge gateway is not yet up."
    }
  }
}

resource "aviatrix_edge_spoke_transit_attachment" "default" {
  count           = var.attached ? 1 : 0
  spoke_gw_name   = aviatrix_edge_spoke.default.gw_name
  transit_gw_name = var.transit_gw

  lifecycle {
    precondition {
      condition     = aviatrix_edge_spoke.default.state == "up"
      error_message = "The edge gateway is not yet up."
    }
  }
}

resource "aviatrix_edge_spoke_external_device_conn" "default" {
  for_each = var.attached ? var.bgp_peers : {}

  site_id           = aviatrix_edge_spoke.default.site_id
  gw_name           = aviatrix_edge_spoke.default.gw_name
  connection_name   = each.value.connection_name
  bgp_local_as_num  = aviatrix_edge_spoke.default.local_as_number
  bgp_remote_as_num = each.value.bgp_remote_as_num
  local_lan_ip      = each.value.local_lan_ip
  remote_lan_ip     = each.value.remote_lan_ip

  lifecycle {
    precondition {
      condition     = aviatrix_edge_spoke.default.state == "up"
      error_message = "The edge gateway is not yet up."
    }
  }
}

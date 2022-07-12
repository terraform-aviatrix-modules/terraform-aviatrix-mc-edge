# terraform-aviatrix-mc-edge

### Description
Deploys an Aviatrix edge gateway and attaches it to the desired transit gateway and network segment

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | >= 1.2.0 | 6.8 | ~> 2.23.0

### Usage Example
```
module "edge1" {
  source  = "terraform-aviatrix-modules/mc-edge/aviatrix"
  version = "1.0.0"

  gw_name                 = "test"
  lan_interface_ip_prefix = "10.50.10.0/24"
  site_id                 = "home"
  #attached                = true
  transit_gws             = ["transit1", "transit2"]
  wan_default_gateway_ip  = "1.1.1.1"
  wan_interface_ip_prefix = "1.1.1.0/24"
}
```
On first apply, the ISO/Cloud-init gets created for deployiong the actual gateway. Once gateway deployment is complete, add `attached = true` to create the attachment to the transit gateway, any network segmentation domain as well as set up the BGP peers.

### Variables
The following variables are required:

key | value
:--- | :---
gw_name | Name for the edge gateway.
lan_interface_ip_prefix | LAN interface IP and subnet prefix.
site_id | Site ID for the spoke gateway.
transit_gws | A list of names of the transit gateways to attach this edge to. (Required when attached = true)
wan_default_gateway_ip | WAN default gateway IP.
wan_interface_ip_prefix | WAN interface IP and subnet prefix.

The following variables are optional:

key | default | value 
:---|:---|:---
approved_learned_cidrs | | A list of approved learned CIDRs.
attached | false | Set to true to attach it to the transit gateway after provisioning.
bgp_hold_time | | BGP hold time. Unit is in seconds.
bgp_peers | | Map of BGP peers to set up for this edge gateway.
bgp_polling_time | | BGP route polling time. Unit is in seconds.
dns_server_ip | | DNS server IP.
enable_edge_active_standby | | Switch to enable Edge Active-Standby mode.
enable_edge_active_standby_preemptive | | Switch to enable Preemptive Mode for Edge Active-Standby.
enable_edge_transitive_routing | | Switch to enable Edge transitive routing.
enable_jumbo_frame | | Switch to enable jumbo frame.
enable_learned_cidrs_approval | false | Switch to enable/disable CIDR approval for BGP Edge Gateway.
enable_management_over_private_network | | Switch to enable management over the private network.
enable_preserve_as_path | | Enable preserve as_path when advertising manual summary cidrs on BGP edge gateway.
latitude | | Edge gateway latitude.
local_as_number | | Configures the Aviatrix Edge Gateway ASN number.
local_as_number | | Configures the Aviatrix Edge Gateway ASN number.
longitude | | Edge gateway longitude.
management_default_gateway_ip | | Management default gateway IP.
management_egress_ip_prefix | | Management egress gateway IP and subnet prefix.
management_interface_config | "DHCP" | Management interface configuration.
management_interface_ip_prefix | | Management interface IP and subnet prefix.
network_domain | | Provide network domain name to which edge needs to be deployed. Transit gateway must be attached and have segmentation enabled.
prepend_as_path | | List of AS numbers to prepend gateway BGP AS_Path field. Valid only when local_as_number is set.
secondary_dns_server_ip | | Secondary DNS server IP.
spoke_bgp_manual_advertise_cidrs | | Intended CIDR list to be advertised to external BGP router.
wan_public_ip | | WAN public IP. Required for attaching connections over the Internet.
ztp_file_download_path | execution folder | The folder path where the ZTP file will be downloaded.
ztp_file_type | "iso" | ZTP file type. Valid values: "iso", "cloud-init".




### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>

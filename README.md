# terraform-aviatrix-mc-edge

### Description
Deploys an Aviatrix edge gateway and attaches it to the desired transit gateway and network segment

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | >= 1.1.0 | 6.8 | ~> 2.23.0

### Usage Example
```
module "edge1" {
  source  = "terraform-aviatrix-modules/mc-edge/aviatrix"
  version = "1.0.0"

}
```

### Variables
The following variables are required:

key | value
:--- | :---
gw_name | Name for the edge gateway.
lan_interface_ip_prefix | LAN interface IP and subnet prefix.
site_id | Site ID for the spoke gateway.
transit_gw | Name of the transit gateway to attach this edge to. (Not required when attached = false)
wan_default_gateway_ip | WAN default gateway IP.
wan_interface_ip_prefix | WAN interface IP and subnet prefix.



The following variables are optional:

key | default | value 
:---|:---|:---
management_interface_config | "DHCP" | Management interface configuration.
attached | true | Set to false if you don't want to attach edge to transit_gw.
ztp_file_type | "iso" | ZTP file type. Valid values: "iso", "cloud-init".
ztp_file_download_path | execution folder | The folder path where the ZTP file will be downloaded.
network_domain | | Provide network domain name to which edge needs to be deployed. Transit gateway must be attached and have segmentation enabled.
bgp_peers | | Map of BGP peers to set up for this edge gateway.
local_as_number | | Configures the Aviatrix Edge Gateway ASN number.
prepend_as_path | | List of AS numbers to prepend gateway BGP AS_Path field. Valid only when local_as_number is set.
enable_learned_cidrs_approval | false | Switch to enable/disable CIDR approval for BGP Edge Gateway.

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>

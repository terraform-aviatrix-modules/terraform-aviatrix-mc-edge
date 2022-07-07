variable "gw_name" {
  description = "Name for the edge gateway."
  type        = string

  validation {
    condition     = length(var.gw_name) <= 50
    error_message = "Name is too long. Max length is 50 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]*$", var.gw_name))
    error_message = "Only a-z, A-Z, 0-9 and hyphens and underscores are allowed."
  }
}

variable "site_id" {
  description = "Site ID for the spoke gateway."
  type        = string

  validation {
    condition     = length(var.site_id) <= 50
    error_message = "Name is too long. Max length is 50 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]*$", var.site_id))
    error_message = "Only a-z, A-Z, 0-9 and hyphens and underscores are allowed."
  }
}

variable "management_interface_config" {
  description = "Management interface configuration."
  type        = string
  default     = "DHCP"
  nullable    = false

  validation {
    condition     = contains(["dhcp", "static"], lower(var.management_interface_config))
    error_message = "Invalid management_interface_config type. Choose DHCP or Static."
  }
}

variable "wan_interface_ip_prefix" {
  description = "WAN interface IP and subnet prefix."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.wan_interface_ip_prefix))
    error_message = "This does not like a valid CIDR."
  }
}

variable "wan_default_gateway_ip" {
  description = "WAN default gateway IP."
  type        = string

  validation {
    condition     = can(cidrnetmask(format("%s/32", var.wan_default_gateway_ip)))
    error_message = "This does not like a valid IP."
  }
}

variable "lan_interface_ip_prefix" {
  description = "LAN interface IP and subnet prefix."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.lan_interface_ip_prefix))
    error_message = "This does not like a valid CIDR."
  }
}

variable "ztp_file_type" {
  description = "ZTP file type."
  type        = string
  default     = "iso"
  nullable    = false

  validation {
    condition     = contains(["iso", "cloud-init"], lower(var.ztp_file_type))
    error_message = "Invalid ztp_file_type type. Choose iso or cloud-init."
  }
}

variable "ztp_file_download_path" {
  description = "The folder path where the ZTP file will be downloaded."
  type        = string
  default     = ""
  nullable    = false

  validation {
    condition     = can(dirname(var.ztp_file_download_path))
    error_message = "Invalid ztp_file_download_path."
  }
}

variable "management_egress_ip_prefix" {
  description = "Management egress gateway IP and subnet prefix."
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(var.management_egress_ip_prefix)) || var.management_egress_ip_prefix == null
    error_message = "This does not like a valid CIDR."
  }
}




variable "management_interface_ip_prefix" {
  description = "Management interface IP and subnet prefix."
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(var.management_interface_ip_prefix)) || var.management_interface_ip_prefix == null
    error_message = "This does not like a valid CIDR."
  }
}

variable "management_default_gateway_ip" {
  description = "Management default gateway IP."
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(format("%s/32", var.management_default_gateway_ip))) || var.management_default_gateway_ip == null
    error_message = "This does not like a valid IP."
  }
}

variable "dns_server_ip" {
  description = "DNS server IP"
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(format("%s/32", var.dns_server_ip))) || var.dns_server_ip == null
    error_message = "This does not like a valid IP."
  }
}

variable "secondary_dns_server_ip" {
  description = "Secondary DNS server IP"
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(format("%s/32", var.secondary_dns_server_ip))) || var.secondary_dns_server_ip == null
    error_message = "This does not like a valid IP."
  }
}

variable "local_as_number" {
  description = "Configures the Aviatrix Edge Gateway ASN number."
  type        = number
  default     = null
}

variable "prepend_as_path" {
  description = "List of AS numbers to prepend gateway BGP AS_Path field. Valid only when local_as_number is set."
  type        = list(number)
  default     = null
}

variable "enable_learned_cidrs_approval" {
  description = "Switch to enable/disable CIDR approval for BGP Edge Gateway."
  type        = bool
  default     = false
  nullable    = false
}

variable "approved_learned_cidrs" {
  description = "A list of approved learned CIDRs."
  type        = list(string)
  default     = null
}

variable "spoke_bgp_manual_advertise_cidrs" {
  description = "Intended CIDR list to be advertised to external BGP router."
  type        = list(string)
  default     = null
}

variable "enable_preserve_as_path" {
  description = "Enable preserve as_path when advertising manual summary cidrs on BGP spoke gateway."
  type        = bool
  default     = null
}


variable "bgp_polling_time" {
  description = "BGP route polling time. Unit is in seconds."
  type        = number
  default     = null

  validation {
    condition     = var.bgp_polling_time != null ? (var.bgp_polling_time >= 10 && var.bgp_polling_time <= 50) : true
    error_message = "Invalid value. Must be in range 10-50."
  }
}

variable "bgp_hold_time" {
  description = "BGP hold time. Unit is in seconds."
  type        = number
  default     = null

  validation {
    condition     = var.bgp_hold_time != null ? (var.bgp_hold_time >= 12 && var.bgp_hold_time <= 360) : true
    error_message = "Invalid value. Must be in range 12-360."
  }
}

variable "latitude" {
  description = "Edge gateway latitude."
  type        = string
  default     = null

  validation {
    condition     = can(regex("^[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?),\\s*[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)$", var.latitude)) || var.latitude == null
    error_message = "This does not like a valid latitude."
  }
}

variable "longitude" {
  description = "Edge gateway longitude."
  type        = string
  default     = null

  validation {
    condition     = can(regex("^[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?),\\s*[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)$", var.longitude)) || var.longitude == null
    error_message = "This does not like a valid longitude."
  }
}

variable "wan_public_ip" {
  description = "WAN public IP. Required for attaching connections over the Internet."
  type        = string
  default     = null

  validation {
    condition     = can(cidrnetmask(format("%s/32", var.wan_public_ip))) || var.wan_public_ip == null
    error_message = "This does not like a valid IP."
  }
}

variable "bgp_peers" {
  description = "MAP of BGP peers to set up for this edge gateway."
  type        = map(any)
  default     = {}
}

variable "transit_gw" {
  description = "Name of the transit gateway to attach this edge to."
  type        = string
  default     = ""
  nullable    = false
}

variable "network_domain" {
  description = "Provide network domain name to which edge needs to be deployed. Transit gateway must be attached and have segmentation enabled."
  type        = string
  default     = ""
  nullable    = false
}

variable "attached" {
  description = "Set to false if you don't want to attach spoke to transit_gw."
  type        = bool
  default     = false
  nullable    = false
}

locals {
  ztp_file_download_path = var.ztp_file_download_path == "" ? path.root : var.ztp_file_download_path
}

terraform {
  required_providers {
    # aviatrix = {
    #   source = "aviatrixsystems/aviatrix"
    #   version = "~> 2.23.0"
    # }
    aviatrix = {
      source  = "aviatrix.com/aviatrix/aviatrix"
      version = "99.0.0"
    }
  }
  required_version = ">= 1.2.0"
}

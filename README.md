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
\<keyname> | \<description of value that should be provided in this variable>

The following variables are optional:

key | default | value 
:---|:---|:---
\<keyname> | \<default value> | \<description of value that should be provided in this variable>

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>

#all-resources
variable "region" {  
}

variable "compartment_id" {
}

#vcn
variable "vcn_display_name" {
    default = "vcn"
}

variable "vcn_cidr_blocks" {
    type = list(string)
    default = [ "10.0.0.0/16" ]
}

#Internet Gateway
variable "igw_displya_name" {
    default = "IGW"
}

#instance
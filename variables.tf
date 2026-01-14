#all-resources
variable "region" {  
}

variable "compartment_id" {
}

#vcn
variable "vcn_display_name" {
}

variable "vcn_cidr_blocks" {
    type = list(string)
}

#instance
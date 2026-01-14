#all-resources
variable "region" {
}

variable "compartment_id" {
}

#VCN
variable "vcn_display_name" {
    default = "VCN"
}

variable "vcn_cidr_blocks" {
    type = list(string)
    default = [ "10.0.0.0/16" ]
}

#Subnet
variable "subnet_cidr_block" {
    type = string
    default = "10.0.0.0/24"
}
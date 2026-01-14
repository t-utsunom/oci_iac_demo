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

#Instance
variable "instance_availability_domain" {
}

variable "instance_display_name" {
  default = "Instance"
}

variable "instance_shape" {
    default = "VM.Standard.E5.Flex"
}

variable "memory_in_gbs" {
    default = "8"
}

variable "ocpus" {
    default = "1"
}

variable "instance_source_details_instance_source_image_filter_details_operating_system" {
    default = "Oracle Linux"
}

variable "instance_source_details_instance_source_image_filter_details_operating_system_version" {
    default = "9"
}
resource "oci_core_vcn" "test_vcn" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
}
resource "oci_core_internet_gateway" "test_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    display_name = "IGW"
    vcn_id = oci_core_vcn.test_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.test_vcn.default_route_table_id

    #Required
    compartment_id = var.compartment_id

    #Optional
    route_rules {

        #Required
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }
}

resource "oci_core_default_security_list" "default_security_list" {
    #Required
    compartment_id = var.compartment_id
    manage_default_resource_id = oci_core_vcn.test_vcn.default_security_list_id

    #Optional
    ingress_security_rules {
        #Required
        protocol = "6"
        source = "0.0.0.0/0"

        tcp_options {
            #Optional
            max = 8080
            min = 8080
            }
    }
}

resource "oci_core_subnet" "test_subnet" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    cidr_block = var.subnet_cidr_block
    display_name = "Public_Subnet"
    route_table_id = oci_core_default_route_table.default_route_table.id
    security_list_ids = oci_core_default_security_list.default_security_list.id
}
/*
resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.instance_shape

    create_vnic_details {

        #Optional
        assign_ipv6ip = var.instance_create_vnic_details_assign_ipv6ip
        assign_public_ip = var.instance_create_vnic_details_assign_public_ip
        subnet_cidr = var.instance_create_vnic_details_subnet_cidr
        subnet_id = oci_core_subnet.test_subnet.id
    }
    display_name = var.instance_display_name
    shape = var.instance_shape
    shape_config {

        #Optional
        memory_in_gbs = var.instance_shape_config_memory_in_gbs
        ocpus = var.instance_shape_config_ocpus
    }
    source_details {
        #Required
        source_id = oci_core_image.test_image.id
        source_type = "image"

        #Optional
        boot_volume_size_in_gbs = var.instance_source_details_boot_volume_size_in_gbs
        boot_volume_vpus_per_gb = var.instance_source_details_boot_volume_vpus_per_gb
        instance_source_image_filter_details {
            #Required
            compartment_id = var.compartment_id

            #Optional
            defined_tags_filter = var.instance_source_details_instance_source_image_filter_details_defined_tags_filter
            operating_system = var.instance_source_details_instance_source_image_filter_details_operating_system
            operating_system_version = var.instance_source_details_instance_source_image_filter_details_operating_system_version
        }
    }
    preserve_boot_volume = false
    user_data = 
}
*/
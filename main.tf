resource "oci_core_vcn" "test_vcn" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    cidr_blocks = var.vcn_cidr_blocks
    display_name = var.vcn_display_name
}

/*
resource "oci_core_internet_gateway" "test_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    #enabled = var.internet_gateway_enabled
    route_table_id = oci_core_route_table.test_route_table.id
}

#VCN作成時のデフォルトでいいかも？GWとルール追加すればOK?
resource "oci_core_route_table" "test_route_table" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    display_name = var.route_table_display_name
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.test_internet_gateway.id

        #Optional
        cidr_block = var.route_table_route_rules_cidr_block
        description = var.route_table_route_rules_description
        destination = var.route_table_route_rules_destination
        destination_type = var.route_table_route_rules_destination_type
    }
}

#VCN作成時のデフォルトでいいかも？
resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    display_name = var.security_list_display_name
    egress_security_rules {
        #Required
        destination = var.security_list_egress_security_rules_destination
        protocol = var.security_list_egress_security_rules_protocol

        #Optional
        description = var.security_list_egress_security_rules_description
        destination_type = var.security_list_egress_security_rules_destination_type
        icmp_options {
            #Required
            type = var.security_list_egress_security_rules_icmp_options_type

            #Optional
            code = var.security_list_egress_security_rules_icmp_options_code
        }
        stateless = var.security_list_egress_security_rules_stateless
        tcp_options {

            #Optional
            max = var.security_list_egress_security_rules_tcp_options_destination_port_range_max
            min = var.security_list_egress_security_rules_tcp_options_destination_port_range_min
            source_port_range {
                #Required
                max = var.security_list_egress_security_rules_tcp_options_source_port_range_max
                min = var.security_list_egress_security_rules_tcp_options_source_port_range_min
            }
        }
        udp_options {

            #Optional
            max = var.security_list_egress_security_rules_udp_options_destination_port_range_max
            min = var.security_list_egress_security_rules_udp_options_destination_port_range_min
            source_port_range {
                #Required
                max = var.security_list_egress_security_rules_udp_options_source_port_range_max
                min = var.security_list_egress_security_rules_udp_options_source_port_range_min
            }
        }
    }
    freeform_tags = {"Department"= "Finance"}
    ingress_security_rules {
        #Required
        protocol = var.security_list_ingress_security_rules_protocol
        source = var.security_list_ingress_security_rules_source

        #Optional
        description = var.security_list_ingress_security_rules_description
        icmp_options {
            #Required
            type = var.security_list_ingress_security_rules_icmp_options_type

            #Optional
            code = var.security_list_ingress_security_rules_icmp_options_code
        }
        source_type = var.security_list_ingress_security_rules_source_type
        stateless = var.security_list_ingress_security_rules_stateless
        tcp_options {

            #Optional
            max = var.security_list_ingress_security_rules_tcp_options_destination_port_range_max
            min = var.security_list_ingress_security_rules_tcp_options_destination_port_range_min
            source_port_range {
                #Required
                max = var.security_list_ingress_security_rules_tcp_options_source_port_range_max
                min = var.security_list_ingress_security_rules_tcp_options_source_port_range_min
            }
        }
        udp_options {

            #Optional
            max = var.security_list_ingress_security_rules_udp_options_destination_port_range_max
            min = var.security_list_ingress_security_rules_udp_options_destination_port_range_min
            source_port_range {
                #Required
                max = var.security_list_ingress_security_rules_udp_options_source_port_range_max
                min = var.security_list_ingress_security_rules_udp_options_source_port_range_min
            }
        }
    }
}

resource "oci_core_subnet" "test_subnet" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    #Optional
    availability_domain = var.subnet_availability_domain
    cidr_block = var.subnet_cidr_block
    display_name = var.subnet_display_name
    ipv4cidr_blocks = var.subnet_ipv4cidr_blocks
    prohibit_internet_ingress = var.subnet_prohibit_internet_ingress
    prohibit_public_ip_on_vnic = var.subnet_prohibit_public_ip_on_vnic
    route_table_id = oci_core_route_table.test_route_table.id
    security_list_ids = var.subnet_security_list_ids
}

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
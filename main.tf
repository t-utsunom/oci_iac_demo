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
}

resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.instance_shape
    display_name = var.instance_display_name

    create_vnic_details {
        assign_public_ip = true
        subnet_cidr = var.subnet_cidr_block
        subnet_id = oci_core_subnet.test_subnet.id
    }

    shape_config {

        #Optional
        memory_in_gbs = var.instance_shape_config_memory_in_gbs
        ocpus = var.instance_shape_config_ocpus
    }
    source_details {
        #Required
        source_type = "image"

        instance_source_image_filter_details {
            #Required
            compartment_id = var.compartment_id

            #Optional
            operating_system = var.instance_source_details_instance_source_image_filter_details_operating_system
            operating_system_version = var.instance_source_details_instance_source_image_filter_details_operating_system_version
        }
    }
    preserve_boot_volume = false
    metadata = {
        user_data = base64encode(<<EOF
            #Nginxインストール
            sudo dnf install -y nginx

            # サンプルHTML作成
            sudo mkdir -p /usr/share/nginx/html
            echo '<!DOCTYPE html>
            <html>
            <head>
            <title>DemoPage</title>
            </head>
            <body>
            <h1>This is a demo page</h1>
            </body>
            </html>' | sudo tee /usr/share/nginx/html/demo.html

            #ポート8080用に設定ファイル編集（/etc/nginx/nginx.conf）
            sudo sed -i 's/listen       80;/listen       8080;/' /etc/nginx/nginx.conf

            #デフォルトでindexにdemo.htmlが含まれるよう編集
            sudo sed -i 's/index  index.html index.htm;/index  demo.html index.html index.htm;/' /etc/nginx/nginx.conf

            # nginx自動起動＆起動
            sudo systemctl enable nginx
            sudo systemctl restart nginx

            # firewalldを開放
            sudo firewall-cmd --permanent --add-port=8080/tcp
            sudo firewall-cmd --reload
            EOF
        )
    }
}
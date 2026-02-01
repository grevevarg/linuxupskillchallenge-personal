resource "oci_core_vcn" "vcn" {
  cidr_block     = local.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "linuxupskill-vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "subnet" {
  cidr_block        = local.subnet_cidr
  compartment_id   = var.compartment_ocid
  vcn_id           = oci_core_vcn.vcn.id
  route_table_id   = oci_core_route_table.rt.id
  prohibit_public_ip_on_vnic = false
}

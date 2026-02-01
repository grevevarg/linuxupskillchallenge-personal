locals {
  region             = "eu-stockholm-1"
  instance_shape     = "VM.Standard.E2.1.Micro"

  vcn_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

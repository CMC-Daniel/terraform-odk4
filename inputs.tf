#
#  See https://www.terraform.io/intro/getting-started/variables.html for more details.
#

#  Change these defaults to fit your needs!

variable "esxi_hostname" {
  default = ""
}

variable "esxi_hostport" {
  default = "22"
}

variable "esxi_hostssl" {
  default = "443"
}

variable "esxi_username" {
  default = ""
}

variable "esxi_password" {
  default = ""
}

variable "hostname_prefix" {
  type        = string
}

variable "virtual_network" {
  default = "VM Network"
}

variable "disk_store" {
  default = "datastore1"
}

variable "vm_hostname" {
  default = ""
}

variable "hostnames" {
  default = {
    "0" = "example1.org"
    "1" = "example2.net"
  }
}

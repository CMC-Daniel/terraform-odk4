#########################################
#  ESXI Provider host/login details
#########################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl  = var.esxi_hostssl
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest resource
#########################################

resource "esxi_portgroup" "OKD" {
  name = "OKD"
  vswitch = "vSwitch0"
  vlan = "25"
}

resource "esxi_guest" "PFSENSE" {
  count = 1
  guest_name = "${lower(format("%s-%s", var.hostname_prefix, "pfsense"))}"
  disk_store = var.disk_store
  boot_disk_size = 8

  memsize = "1024"
  numvcpus = 1
  
  power = "on"

  notes = "OKD4 Pfsense"
  
  guestos = "freeBSD12-64"
  virthwver = 17

  network_interfaces {
    virtual_network = var.virtual_network
  }

  network_interfaces {
    virtual_network = "OKD"
  }

  guest_startup_timeout  = 60
}

resource "esxi_guest" "SERVICES" {
  count = 1
  guest_name = "${lower(format("%s-%s", var.hostname_prefix, "services"))}"
  disk_store = var.disk_store
  boot_disk_size = 120

  memsize = "4096"
  numvcpus = 2
#  clone_from_vm = "rhel-7.9"
  
  power = "off"

  notes = "OKD4 Services VM"
  
  guestos = "centos8-64"
  virthwver = 17

  network_interfaces {
    virtual_network = var.virtual_network
  }

  network_interfaces {
    virtual_network = "OKD"
  }

  guest_startup_timeout  = 60
}

resource "esxi_guest" "BOOTSTRAP" {
  count = 1
  guest_name = "${lower(format("%s-%s", var.hostname_prefix, "bootstrap"))}"
  disk_store = var.disk_store
  boot_disk_size = 120

  memsize = "16384"
  numvcpus = 2
#  clone_from_vm = "rhel-7.9"
  
  power = "off"

  notes = "OKD4 Bootstrap VM"
  
  guestos = "coreos-64"
  virthwver = 17

  network_interfaces {
    virtual_network = "OKD"
  }

  guest_startup_timeout  = 60
}

resource "esxi_guest" "CONTROL" {
  count = 3
  guest_name = "${lower(format("%s-%s", var.hostname_prefix, "control-plane"))}-${format("%01d", count.index + 1)}"
  disk_store = "datastore2"
  boot_disk_size = 120

  memsize = "16384"
  numvcpus = 4
#  clone_from_vm = "rhel-7.9"
  
  power = "off"

  notes = "OKD4 Control Plane VM"
  
  guestos = "coreos-64"
  virthwver = 17

  network_interfaces {
    virtual_network = "OKD"
  }

  guest_startup_timeout  = 60
}

resource "esxi_guest" "COMPUTE" {
  count = 2
  guest_name = "${lower(format("%s-%s", var.hostname_prefix, "compute"))}-${format("%01d", count.index + 1)}"
  disk_store = var.disk_store
  boot_disk_size = 120

  memsize = "8192"
  numvcpus = 2
#  clone_from_vm = "rhel-7.9"
  
  power = "off"

  notes = "OKD4 Control Plane VM"
  
  guestos = "coreos-64"
  virthwver = 17

  network_interfaces {
    virtual_network = "OKD"
  }

  guest_startup_timeout = 60
}
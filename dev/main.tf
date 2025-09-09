module "rg" {
    source = "../module/azurerm_rg"

    resource_group_name = "rg-agra"
    location = "Central India"
}


module "vnet" {
  source = "../module/azurerm_vnet"
  depends_on = [ module.rg ]

  virtual_network_name = "vnet-agra"
  resource_group_name = "rg-agra"
  location = "Central India"
  address_space = ["10.0.0.0/16"]
  dns_servers = ["10.0.0.4", "10.0.0.5"]
}

module "subnet1" {
    source = "../module/azurerm_subnet"
    depends_on = [ module.rg, module.vnet ]

    subnet_name = "subnet1-agra"
    resource_group_name = "rg-agra"
    virtual_network_name = "vnet-agra"
    address_prefixes = ["10.0.1.0/24"]
}

module "subnet2" {
    source = "../module/azurerm_subnet"
    depends_on = [ module.rg, module.vnet ]

    subnet_name = "subnet2-agra"
    resource_group_name = "rg-agra"
    virtual_network_name = "vnet-agra"
    address_prefixes = ["10.0.2.0/24"]
}

module "vm1" {
  source = "../module/azurerm_vm"
  depends_on = [ module.rg, module.vnet, module.subnet1 ]

  azurerm_linux_virtual_machine = "vm1-agra"
  subnet_name = "subnet1-agra"
  virtual_network_name = "vnet-agra"
  resource_group_name = "rg-agra"
  azurerm_network_interface = "nic1-agra"
  location = "Central India"
  size = "Standard_F2"
  user_name = "admin_vm"
  admin_password = "Tata@2025"
}

module "vm2" {
  source = "../module/azurerm_vm"
  depends_on = [ module.rg, module.vnet, module.subnet2 ]

  azurerm_linux_virtual_machine = "vm2-agra"
  subnet_name = "subnet2-agra"
  virtual_network_name = "vnet-agra"
  resource_group_name = "rg-agra"
  azurerm_network_interface = "nic2-agra"
  location = "Central India"
  size = "Standard_F2"
  user_name = "admin_vm"
  admin_password = "Tata@2025"
}
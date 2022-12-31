resource "azurerm_resource_group" "grafana_azure" {
  name     = "grafana-resources"
  location = var.location
}

resource "azurerm_virtual_network" "grafana_network" {
  name                = "grafana-network"
  address_space       = var.network_ip_address
  location            = var.location
  resource_group_name = azurerm_resource_group.grafana_azure.name
}

resource "azurerm_subnet" "grafana_subnet" {
  name                 = "grafana-subnet"
  resource_group_name  = azurerm_resource_group.grafana_azure.name
  virtual_network_name = azurerm_virtual_network.grafana_network.name
  address_prefixes     = var.subnet_ip
}

resource "azurerm_public_ip" "grafana_public_ip" {
  name                = "grafana-public-ip"
  location            = azurerm_resource_group.grafana_azure.location
  resource_group_name = azurerm_resource_group.grafana_azure.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "grafana_network" {
  name                = "grafana-nic"
  location            = azurerm_resource_group.grafana_azure.location
  resource_group_name = azurerm_resource_group.grafana_azure.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grafana_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.grafana_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "grafana_vm" {
  name                  = "grafana-vm"
  resource_group_name   = azurerm_resource_group.grafana_azure.name
  location              = azurerm_resource_group.grafana_azure.location
  size                  = var.size
  admin_username        = "vstelmakh"
  custom_data           = filebase64(var.grafana)
  network_interface_ids = [
    azurerm_network_interface.grafana_network.id,
  ]

  admin_ssh_key {
    username   = "vstelmakh"
    public_key = file(var.ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2" 
    version   = "latest"
  }
}
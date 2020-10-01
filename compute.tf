
resource "azurerm_network_interface" "nic" {
    location = var.location
    name = "book-nic"
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name = "bookipconfig"
        subnet_id = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pip.id
    }
}

resource "azurerm_public_ip" "pip" {
    allocation_method = "Dynamic"
    location = var.location
    name = "book-ip"
    resource_group_name = azurerm_resource_group.rg.name
    domain_name_label = "bookdevopsify"
}

#Storage Account

resource "azurerm_storage_account" "stored" {
    account_replication_type = "LRS"
    account_tier = "Standard"
    location = var.location
    name = "bookstored"
    resource_group_name = azurerm_resource_group.rg.name

}
resource "azurerm_virtual_machine" "vm" {
    location = var.location
    name = "bookvmed"
    network_interface_ids = [azurerm_network_interface.nic.id]
    resource_group_name = azurerm_resource_group.rg.name
    vm_size = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"

    }
    storage_os_disk {
        create_option = "FromImage"
        name = "myosdisk1"
        caching = "ReadWrite"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        admin_password = "BigdataBoook#$123"
        admin_username = "flavins"
        computer_name = "VMBOOK"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
    boot_diagnostics {
        enabled = false
        storage_uri = azurerm_storage_account.stored.primary_blob_endpoint
    }
}

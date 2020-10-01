resource "azurerm_virtual_network" "vnet" {
    address_space = ["10.0.0.0/16"]
    location = "West Europe"
    name = "book-vnet"
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
    name = "book-subnet"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name
    address_prefixes = ["10.0.10.0/24"]

}

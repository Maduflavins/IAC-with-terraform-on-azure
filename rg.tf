resource "azurerm_resource_group" "rg" {
    location = "West Europe"
    name = "bookRg4"
    tags = {
        environment = "Terraform Azure"
    }

}

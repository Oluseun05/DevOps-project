resource "azurerm_linux_virtual_machine" "jenkins" {
  name                            = "${var.app_name}-jenkins-vm"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  size                            = var.jenkins_vm_size
  admin_username                  = var.jenkins_admin_username
  admin_password                  = var.jenkins_admin_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.jenkins.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 50
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(file("${path.module}/scripts/cloud-init.yaml"))

  tags = {
    environment = var.environment
    role        = "jenkins"
  }
}

# Create Public IP Address
resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

# Create Network Interface
resource "azurerm_network_interface" "this" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# Create Virtual Machine
resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.this.id]

  # Authentication
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = var.tags
}

# Optional: Create Data Disk
resource "azurerm_managed_disk" "data_disk" {
  count               = var.data_disk_size_gb > 0 ? 1 : 0
  name                = "${var.vm_name}-datadisk"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = var.data_disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  count               = var.data_disk_size_gb > 0 ? 1 : 0
  managed_disk_id     = azurerm_managed_disk.data_disk[0].id
  virtual_machine_id  = azurerm_linux_virtual_machine.this.id
  lun                 = 10
  caching             = var.data_disk_caching
}

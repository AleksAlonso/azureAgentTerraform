# Create Resource Group
rg_name = "modulo7-ado-agent"

# Create Virtual Network
vnet_name                     = "modulo7-ado-agent-vnet"
vnet_ip_address               = ["192.168.0.0/16"]
subnet_name_ado_agent         = "ado-agent-subnet"
subnet_name_ado_agent_address = "192.168.0.0/24"

# Key Vault
key_vault_name = "modulo7-ado22"

# Create Virtual Machine
vm_name               = "modulo7-ado-vm"
vm_private_ip_address = "192.168.0.4"
vm_pip_name           = "modulo7-ado-agent-pip"
vm_username           = "modulo7"
vm_osdisk_name        = "modulo7-ado-vm-osdisk"

# Network Security Group
nsg_name = "modulo7-ado-vm-nsg"

ado_token = "x7j23nzpo6j4hpum5wwl64qyojs64s6at64rsad3ihpo6pdhpj3a"
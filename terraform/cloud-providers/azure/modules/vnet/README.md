# Azure Virtual Network (VNet) Terraform Module

This Terraform module creates an Azure Virtual Network with support for private and public subnets, route tables, and automatic subnet-route table associations.

## Features

- **Enhanced Subnet Management**: Support for private and public subnet classification
- **Automatic Route Tables**: Creates dedicated route tables for private and public subnets
- **Flexible Route Configuration**: Customizable routes for each route table type
- **Subnet-Route Table Associations**: Automatic association of subnets with their respective route tables
- **Backward Compatibility**: Maintains compatibility with legacy subnet configurations
- **DDoS Protection**: Optional DDoS protection plan integration
- **Comprehensive Outputs**: Detailed outputs for all created resources

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Azure Virtual Network                    │
│                                                             │
│  ┌─────────────────┐              ┌─────────────────┐      │
│  │  Public Subnets │              │ Private Subnets │      │
│  │                 │              │                 │      │
│  │  • Subnet 1     │              │  • Subnet 1     │      │
│  │  • Subnet 2     │              │  • Subnet 2     │      │
│  │  • Subnet N     │              │  • Subnet N     │      │
│  └─────────────────┘              └─────────────────┘      │
│         │                                   │               │
│         ▼                                   ▼               │
│  ┌─────────────────┐              ┌─────────────────┐      │
│  │ Public Route    │              │ Private Route   │      │
│  │ Table           │              │ Table           │      │
│  │                 │              │                 │      │
│  │ • Internet      │              │ • Custom Routes │      │
│  │   Gateway       │              │ • VNet Local    │      │
│  │ • Custom Routes │              │ • NVA Routes    │      │
│  └─────────────────┘              └─────────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

## Usage Examples

### Basic Configuration

```hcl
module "vnet" {
  source = "./modules/vnet"

  vnet_name           = "my-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "my-resource-group"

  private_subnets = [
    {
      name             = "private-subnet-1"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "private-subnet-2"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]

  public_subnets = [
    {
      name             = "public-subnet-1"
      address_prefixes = ["10.0.10.0/24"]
    },
    {
      name             = "public-subnet-2"
      address_prefixes = ["10.0.11.0/24"]
    }
  ]

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Advanced Configuration with Custom Routes

```hcl
module "vnet_advanced" {
  source = "./modules/vnet"

  vnet_name           = "advanced-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "my-resource-group"

  # Private subnets configuration
  private_subnets = [
    {
      name             = "app-subnet"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "data-subnet"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]

  # Public subnets configuration
  public_subnets = [
    {
      name             = "web-subnet"
      address_prefixes = ["10.0.10.0/24"]
    }
  ]

  # Custom private routes
  private_routes = {
    to_onprem = {
      name                   = "to-onpremises"
      address_prefix         = "192.168.0.0/16"
      next_hop_type          = "VirtualNetworkGateway"
    },
    to_nva = {
      name                   = "to-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.100.4"
    }
  }

  # Custom public routes (defaults to internet gateway)
  public_routes = {
    internet = {
      name           = "default-internet"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    },
    internal = {
      name           = "internal-traffic"
      address_prefix = "10.0.0.0/16"
      next_hop_type  = "VnetLocal"
    }
  }

  # Route table configuration
  private_route_table_name = "app-private-rt"
  public_route_table_name  = "web-public-rt"
  
  # BGP route propagation
  disable_bgp_route_propagation = false

  # DDoS Protection
  enable_ddos_protection = true
  ddos_protection_plan_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/ddosProtectionPlans/xxx"

  tags = {
    Environment = "production"
    Project     = "advanced-networking"
    CostCenter  = "IT"
  }
}
```

### Legacy Compatibility Mode

```hcl
module "vnet_legacy" {
  source = "./modules/vnet"

  vnet_name           = "legacy-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "my-resource-group"

  # Legacy subnet configuration (still supported)
  subnets = [
    {
      name             = "legacy-subnet-1"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "legacy-subnet-2"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]

  # Disable route table creation for legacy mode
  create_private_route_table = false
  create_public_route_table  = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vnet_name | The name of the virtual network | `string` | n/a | yes |
| vnet_address_space | The address space for the virtual network | `list(string)` | n/a | yes |
| location | The Azure region where the resources will be deployed | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| tags | Tags to apply to the virtual network and associated resources | `map(string)` | `{}` | no |
| private_subnets | A list of private subnet configurations | `list(object)` | `[]` | no |
| public_subnets | A list of public subnet configurations | `list(object)` | `[]` | no |
| subnets | Legacy subnet configurations (DEPRECATED) | `list(object)` | `[]` | no |
| create_private_route_table | Whether to create a route table for private subnets | `bool` | `true` | no |
| create_public_route_table | Whether to create a route table for public subnets | `bool` | `true` | no |
| private_route_table_name | Name for the private route table | `string` | `null` | no |
| public_route_table_name | Name for the public route table | `string` | `null` | no |
| private_routes | A map of routes to add to the private route table | `map(object)` | `{}` | no |
| public_routes | A map of routes to add to the public route table | `map(object)` | `{internet = {...}}` | no |
| disable_bgp_route_propagation | Boolean flag for BGP route propagation | `bool` | `false` | no |
| associate_route_tables | Whether to automatically associate route tables | `bool` | `true` | no |
| enable_ddos_protection | Enable DDoS protection on the virtual network | `bool` | `false` | no |
| ddos_protection_plan_id | The ID of the DDoS protection plan | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| vnet_id | The ID of the virtual network |
| vnet_name | The name of the virtual network |
| vnet_address_space | The address space of the virtual network |
| private_subnet_ids | The IDs of the private subnets |
| public_subnet_ids | The IDs of the public subnets |
| private_route_table_id | The ID of the private route table |
| public_route_table_id | The ID of the public route table |
| network_summary | A summary of the created network resources |

## Route Types and Next Hops

### Supported Next Hop Types

- **Internet**: Routes traffic to the internet gateway
- **VnetLocal**: Routes traffic within the virtual network
- **VirtualNetworkGateway**: Routes traffic to a VPN or ExpressRoute gateway
- **VirtualAppliance**: Routes traffic to a network virtual appliance
- **None**: Drops the traffic

### Common Route Patterns

#### Private Subnet Routes
```hcl
private_routes = {
  # Route all traffic through a firewall NVA
  default_via_nva = {
    name                   = "default-via-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.100.4"
  },
  
  # Route on-premises traffic through VPN gateway
  onprem_traffic = {
    name           = "to-onpremises"
    address_prefix = "192.168.0.0/16"
    next_hop_type  = "VirtualNetworkGateway"
  }
}
```

#### Public Subnet Routes
```hcl
public_routes = {
  # Default internet route
  internet = {
    name           = "internet-access"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  },
  
  # Keep internal traffic local
  internal = {
    name           = "internal-traffic"
    address_prefix = "10.0.0.0/8"
    next_hop_type  = "VnetLocal"
  }
}
```

## Best Practices

1. **Subnet Planning**: Plan your subnet address spaces carefully to avoid overlaps
2. **Route Table Naming**: Use descriptive names that indicate the purpose and subnet type
3. **Security**: Use private subnets for resources that shouldn't have direct internet access
4. **Monitoring**: Enable diagnostic settings on route tables for troubleshooting
5. **Tags**: Apply consistent tags for cost management and resource organization

## Security Considerations

- Private subnets should route internet-bound traffic through a NAT Gateway or firewall
- Public subnets should have minimal direct internet exposure
- Use Network Security Groups (NSGs) in conjunction with route tables for defense in depth
- Regularly audit route table configurations for unwanted routes

## Migration Guide

### From Legacy Configuration
If you're currently using the legacy `subnets` variable, migrate to the new structure:

**Before:**
```hcl
subnets = [
  {
    name             = "subnet-1"
    address_prefixes = ["10.0.1.0/24"]
  }
]
```

**After:**
```hcl
private_subnets = [
  {
    name             = "private-subnet-1"
    address_prefixes = ["10.0.1.0/24"]
  }
]
```

## Troubleshooting

### Common Issues

1. **Route Conflicts**: Ensure routes don't conflict with existing system routes
2. **Next Hop Unreachable**: Verify that VirtualAppliance IP addresses are reachable
3. **BGP Propagation**: Check if `disable_bgp_route_propagation` should be enabled/disabled

### Validation Commands

```bash
# Check route table associations
az network route-table list --resource-group <rg-name>

# Verify subnet routes
az network route-table route list --resource-group <rg-name> --route-table-name <rt-name>

# Test connectivity
az network watcher next-hop --vm <vm-name> --resource-group <rg-name> --dest-ip <destination-ip>
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | >= 3.0 |

## License

This module is released under the MIT License. See LICENSE file for details.
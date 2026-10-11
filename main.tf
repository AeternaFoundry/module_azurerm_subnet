resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                                          = each.value.name
  resource_group_name                           = each.value.resource_group_name
  virtual_network_name                          = each.value.virtual_network_name
  address_prefixes                              = each.value.address_prefixes
  default_outbound_access_enabled               = each.value.default_outbound_access_enabled
  network_security_group_id_wo                  = each.value.network_security_group_id_wo
  network_security_group_id_wo_version          = each.value.network_security_group_id_wo_version
  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  route_table_id_wo                             = each.value.route_table_id_wo
  route_table_id_wo_version                     = each.value.route_table_id_wo_version
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids
  sharing_scope                                 = each.value.sharing_scope

  dynamic "delegation" {
    for_each = each.value.delegation != null ? each.value.delegation : []
    content {
      name = delegation.value.name
      service_delegation {
        actions = delegation.value.service_delegation.actions
        name    = delegation.value.service_delegation.name
      }
    }
  }

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? [each.value.ip_address_pool] : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  dynamic "service_endpoint" {
    for_each = each.value.service_endpoint != null ? each.value.service_endpoint : []
    content {
      network_identifier = service_endpoint.value.network_identifier
      service            = service_endpoint.value.service
    }
  }
}


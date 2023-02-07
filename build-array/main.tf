locals {
  allowed_services = [
    "audit-trail",
    "campaign",
    "engines",
    "enrichment",
    "metrics",
    "nxql",
    "services",
    "softwaremetering",
    "telemetry",
    "user-sid"
  ]

  auth_server_scopes_name = {
    "audit-trail"      = "service:audit-trail",
    "campaign"         = "service:campaign",
    "engines"          = "service:engines",
    "enrichment"       = "service:enrichment",
    "metrics"          = "service:metrics",
    "nxql"             = "service:nxql",
    "remoteaction"     = "service:remoteaction",
    "services"         = "service:services",
    "softwaremetering" = "service:softwaremetering",
    "telemetry"        = "service:telemetry",
    "user-sid"         = "service:user-sid"
  }

  customer_scope_name = "customer:fdv-okta-mig"

  scope_whitelist = [concat(data.null_data_source.allowed_scope_names.*.outputs.allowed_scopes, list(local.customer_scope_name))]

  // NEW

  allowed_scopes = [
    for service in local.allowed_services :
    lookup(local.auth_server_scopes_name, service)
  ]

  scope_whitelist_new = [concat(local.allowed_scopes, list(local.customer_scope_name))]

}


data "null_data_source" "allowed_scope_names" {
  count = length(local.allowed_services)
  inputs = {
    allowed_scopes = lookup(local.auth_server_scopes_name, local.allowed_services[count.index])
  }
}


output "scope_whitelist_legacy" {
  value = local.scope_whitelist
}

output "scope_whitelist_new" {
  value = local.scope_whitelist_new
}
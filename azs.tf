data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  available_azs = data.aws_availability_zones.available

  az_indexes_defined = var.az_indexes != "" && var.az_indexes != null

  az_index_strings = local.az_indexes_defined ? [for item in split(",", var.az_indexes) : item] : []

  az_ids = local.az_indexes_defined ? flatten([for idx_str in local.az_index_strings : [
    for az_id in local.available_azs.zone_ids : az_id if endswith(az_id, idx_str)
  ]]) : []

  az_indexes = local.az_indexes_defined ? [for az_id in local.az_ids : index(local.available_azs.zone_ids, az_id)] : []

  selected_azs = local.az_indexes_defined ? sort([
    for idx in local.az_indexes : element(local.available_azs.names, idx)
  ]) : slice(local.available_azs.names, 0, var.default_max_azs)

  azs = length(var.azs) == 0 ? local.selected_azs : var.azs
}

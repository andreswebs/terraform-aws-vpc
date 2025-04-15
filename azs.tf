data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  available_azs = data.aws_availability_zones.available

  az_index_strings = var.az_indexes == "" || var.az_indexes == null ? [] : [for item in split(",", var.az_indexes) : item]
  az_ids = var.az_indexes == "" || var.az_indexes == null ? [] : flatten([for idx_str in local.az_index_strings : [
    for az_id in local.available_azs.zone_ids : az_id if endswith(az_id, idx_str)
  ]])
  az_indexes = var.az_indexes == "" || var.az_indexes == null ? [] : [for az_id in local.az_ids : index(local.available_azs.zone_ids, az_id)]
  selected_azs = var.az_indexes == "" || var.az_indexes == null ? slice(local.available_azs.names, 0, 3) : sort([
    for idx in local.az_indexes : local.available_azs.names[idx]
  ])

  azs = length(var.azs) == 0 ? local.selected_azs : var.azs
}

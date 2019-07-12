#X# Note: failed to preserve comments during New LookML conversion
label: "Central Inventory System - DEVQA"

connection: "thelook"

include: "*.view"

# include: "turnrx_*.dashboard"

include: "explore.base_turnrx"

persist_for: "24 hours"

week_start_day: sunday

case_sensitive: no

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_turnrx_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}



explore: turnrx_store_drug_inventory_mvmnt_snapshot {
  extends: [turnrx_store_drug_inventory_mvmnt_snapshot_base]
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

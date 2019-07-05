label: "Absolute AR"

connection: "snowflake_absolute_ar"

# include all views in this project
include: "ar_*.view"

# include all views in this project
include: "store_state_location.view"

# include all dashboards in this project
include: "ar_*.dashboard"

# include the base lookml file if not a view file
include: "explore.base_dss"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

#ARL-41 - Making changes for testing purpose.
persist_with: ar_customer_cache_info

datagroup: ar_customer_cache_info {
  sql_trigger: SELECT MAX(ev.event_begin_date) FROM etl_manager.event ev INNER JOIN etl_manager.EVENT_JOB ej ON ev.event_id = ej.event_id WHERE ev.event_type = 'STAGE TO EDW ETL' AND ev.refresh_frequency = 'D' AND ej. job_name like 'JOB_AR_%' and ej. job_name not like 'JOB_ARS_%' ;;
  max_cache_age: "25 hours"
}

############################################################# This model is to analyze the Data Quality Issues in Enterprise Data Warehouse and PDX Source Systems ################
############################################################ This model should be used only when custom SQL is required to better analyze a DQ issue #############################

access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_absolute_ar_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

explore: ar_nhin_type {
  extends: [ar_nhin_type_base]
}

explore: ar_claim_to_contract_rate {
  extends: [ar_claim_to_contract_rate_base]
  # IMPORTANT - Row Level Security filter should not be removed for any reason
#   access_filter_fields: [ar_chain.chain_id]
  #[ERXLPS-1406] - Added Absolute AR Chain user attribute
  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }
}

explore: ar_store {
  extends: [ar_store_base]
  # IMPORTANT - Row Level Security filter should not be removed for any reason
#   access_filter_fields: [ar_chain.chain_id]
  #[ERXLPS-1406] - Added Absolute AR Chain user attribute
  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }
}

explore: ar_carrier_performance {
  extends: [ar_carrier_performance_base]
  # IMPORTANT - Row Level Security filter should not be removed for any reason
#   access_filter_fields: [ar_chain.chain_id]
  #[ERXLPS-1406] - Added Absolute AR Chain user attribute
  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }
}

explore: ar_network_analysis {
  extends: [ar_network_analysis_base]
# IMPORTANT - Row Level Security filter should not be removed for any reason
#[ERXLPS-1986][ERXDWPS-658] - Looker NAR deployment. Create US by migrating ERXDWPS-658 to ERXLPS-1986.
  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }
}

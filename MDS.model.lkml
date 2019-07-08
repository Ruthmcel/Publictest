label: "Manufacturer Data Services"

connection: "snowflake"

# include all the views
include: "*.view"

# include all the dashboards# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

# include the base lookml file if not a view file
include: "explore.base_dss"

# Caching Parameter
persist_for: "6 hours"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

#[ERXDWPS-8395] - Access grant added to hide TY/LY Analysis From Filter in MDS Model explore (from rx_tx view file).
#All other LY related measures are hidden using set exclusion. this_year_last_year_filter used in many dimensions and not able to exclude using set/exclusion dimension.
access_grant: can_view_rx_tx_ty_ly_filter {
  user_attribute: internal_or_external_user_group
  allowed_values: [ "none_allowed" ]
}

############################################################ Things to know in this model ######################################################################
#### Note: 1. All explores shown below are extended from explore.base_dss.lookml master file
#### Note: 2. This model will not include access_filter_fields so All customer data across this Model can be accessible
#### Note: 3. This model should not include any joins to Host entities as this model inherits all the explores, joins and views of the base_dss.lookml base file.
#################################################################################################################################################################


########################################################### Explores ############################################################################################
explore: looker_data_dictionary {
  fields: [
    ALL_FIELDS*,
    -looker_data_dictionary.customer_field_exclusion_list*]
  extends: [looker_data_dictionary_base]
  sql_always_where: model_name = 'MDS' and field_hidden = 'false' ;;
}

explore: master_code {
  extends: [master_code_base]
}

explore: store {
  extends: [store_base]
  fields: [ALL_FIELDS*,
           -store_file_date.explore_rx_file_date_4_12_candidate_list*, #[ERX-2203]
           -store_file_date_history.explore_rx_file_date_history_4_13_candidate_list* #[ERX-3527]
          ]
  # Joins MDS Store view for values that are source system 7 in EDW D_STORE table. This join is added to avoid exposing mds_store related fields in other Customer specific explore
  join: mds_store {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${mds_store.chain_id} and ${store.nhin_store_id} = ${mds_store.nhin_store_id} and ${mds_store.source_system_id} = 7 ;;
    relationship: one_to_one
  }
}

explore: mds_program {
  extends: [mds_program_base]
}

explore: mds_transaction {
  extends: [mds_transaction_base]
  fields: [ALL_FIELDS*,
            -tx_tp.genrx_prugen_tx_tp_balance_due_from_tp,
            -tx_tp.genrx_billing_method,
            -rx_tx.tx_tp_claim_amount,
            -rx_tx.100_percent_copay,
            -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*, #[ERXLPS-1756]
            -store.phone_number, -store.fax_number, #[ERXLPS-753]
            -rx_tx.exploredx_ty_ly_specific_entities_list*, #[ERXDWPS-8395]
            -store.dea_number #[ERXDWPS-9281]
            ]
}

################################################################################################################################################################

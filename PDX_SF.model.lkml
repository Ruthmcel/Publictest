#X# Note: failed to preserve comments during New LookML conversion

label: "Enterprise Decision Support System"

connection: "thelook"

include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

include: "explore.base_dss"
include: "explore.base_sales"
include: "explore.base_turnrx"

persist_for: "6 hours"

week_start_day: sunday

case_sensitive: no

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

#[ERXDWPS-8395] - Access grant added to expose TY/LY Analysis From Filter in Prescription Transaction and Third Party Claim explore.
access_grant: can_view_rx_tx_ty_ly_filter {
  user_attribute: internal_or_external_user_group
  allowed_values: [ "internal", "external" ]
}

explore: looker_data_dictionary {
  extends: [looker_data_dictionary_base]
}

explore: looker_warehouse_usage_history {
  extends: [looker_warehouse_usage_history_base]
}

explore: snowflake_warehouse_usage_history {
  extends: [snowflake_warehouse_usage_history_base]
}

explore: snowflake_account_usage_warehouse_metering_history {
  extends: [snowflake_account_usage_warehouse_metering_history_base]
}


explore: symmetric_node_status_snapshot {
  extends: [symmetric_node_status_snapshot_base]
}

explore: master_code {
  extends: [master_code_base]
}

explore: store {
  extends: [store_base]
  fields: [ALL_FIELDS*,
    -store_setting.explore_rx_store_setting_4_10_candidate_list*
  ]

  join: chain {
    type: inner
    sql_on: ${store.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5  AND ${store.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: prescriber {
  extends: [prescriber_base]
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.dea_number #[ERXDWPS-9281]
  ]

  join: chain {
    type: inner
    sql_on: ${prescriber.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: patient {
  extends: [patient_base]
  fields: [ALL_FIELDS*, -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-2329]
    -store.dea_number #[ERXDWPS-9281]
  ]

  join: chain {
    type: inner
    sql_on: ${patient.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

#ERXDWPS-5133 - Looker - Create Patient - Store Explore with STORE PATIENT as the driver

explore: eps_patient {
  extends: [eps_patient_base]
  fields: [ALL_FIELDS*, -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-2329]
    -store.dea_number #[ERXDWPS-9281]
  ]

  join: chain {
    type: inner
    sql_on: ${patient.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}


explore: rx_tx {
  fields: [
    ALL_FIELDS*,
    -rx_tx.chain_id,
    -rx_tx.nhin_store_id,
    -rx_tx.store_rx_tx_fill_count,
    -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]
  extends: [rx_tx_base]

  join: chain {
    type: inner
    sql_on: ${rx_tx.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: eps_workflow_order_entry_rx_tx {
  extends: [eps_workflow_order_entry_rx_tx_base]
  fields: [
    ALL_FIELDS*,
    -eps_task_history.count_demo_user_employee_number,
    -eps_task_history.task_history_demo_user_login,
    -eps_task_history.task_history_demo_user_employee_number,
    -eps_rx_tx.bi_demo_prescription_fill_duration,
    -eps_rx_tx.bi_demo_start,
    -eps_rx_tx.bi_demo_sum_fill_duration,
    -eps_rx_tx.bi_demo_avg_fill_duration,
    -eps_rx_tx.bi_demo_median_fill_duration,
    -eps_rx_tx.bi_demo_max_fill_duration,
    -eps_rx_tx.bi_demo_min_fill_duration,
    -eps_rx_tx.bi_demo_start_time,
    -eps_rx_tx.bi_demo_start_date,
    -eps_rx_tx.bi_demo_start_week,
    -eps_rx_tx.bi_demo_start_month,
    -eps_rx_tx.bi_demo_start_month_num,
    -eps_rx_tx.bi_demo_start_year,
    -eps_rx_tx.bi_demo_start_quarter,
    -eps_rx_tx.bi_demo_start_quarter_of_year,
    -eps_rx_tx.bi_demo_start_hour_of_day,
    -eps_rx_tx.bi_demo_start_time_of_day,
    -eps_rx_tx.bi_demo_start_hour2,
    -eps_rx_tx.bi_demo_start_minute15,
    -eps_rx_tx.bi_demo_start_day_of_week,
    -eps_rx_tx.bi_demo_start_week_of_year,
    -eps_rx_tx.bi_demo_start_day_of_week_index,
    -eps_rx_tx.bi_demo_start_day_of_month,
    -eps_rx_tx.bi_demo_is_on_time_fifteen,
    -eps_rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -eps_rx_tx.explore_rx_4_8_000_sf_deployment_candidate_list*,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -eps_task_history.bi_demo_on_site_alt_site,
    -eps_task_history.bi_demo_task_history_label_pharmacy_number,
    -store_drug.prescribed_drug_name,
    -eps_rx_tx.bi_demo_time_in_will_call,
    -eps_rx_tx.bi_demo_sum_time_in_will_call,
    -eps_rx_tx.bi_demo_avg_time_in_will_call,
    -eps_rx_tx.bi_demo_median_time_in_will_call,
    -eps_rx_tx.bi_demo_max_time_in_will_call,
    -eps_rx_tx.bi_demo_min_time_in_will_call,
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -prescriber.npi_number_deidentified,  #ERXLPS-1073
    -prescriber.dea_number_deidentified,  #ERXLPS-1073
    -prescriber.name_deidentified,         #ERXLPS-1073
    -eps_rx_tx.sum_acquisition_cost, #[ERXLPS-1283] Expose only in Inventory explore.
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -patient.rx_com_id_deidentified, #[ERXLPS-1430]
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -store_user_license.bi_demo_store_user_license_number, #[ERXLPS-2078]
    -eps_task_history.avg_task_time, #[ERXDWPS-5833]
    -eps_task_history.task_history_task_start_time, #[ERXDWPS-5833]
    -store_user_license_type.bi_demo_count, #[ERXDWPS-6425]
    -eps_task_history.max_task_history_source_timestamp, #[ERXDWPS-5833]
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    #[ERXDWPS-6802]
    -eps_order_entry.date_to_use_filter,
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales,
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*,
    -eps_order_entry.exploredx_eps_order_entry_analysis_cal_timeframes*,
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -store.dea_number #[ERXDWPS-9281]
  ]

  join: chain {
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-6569] - Copied DEVQA joins to Enterprise Model. Corrected join relationships. Currently exposing this information only in DEVQA and Enterprise Models.
  join: eps_workflow_transition {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_transition.chain_id} = ${eps_workflow_state.chain_id} AND ${eps_workflow_transition.nhin_store_id} = ${eps_workflow_state.nhin_store_id} AND ${eps_workflow_transition.workflow_transition_from_state_id} = ${eps_workflow_state.workflow_state_id} ;;
    relationship: one_to_many
  }

  join: eps_workflow_from_state {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_from_state.chain_id} = ${eps_workflow_transition.chain_id} AND ${eps_workflow_from_state.nhin_store_id} = ${eps_workflow_transition.nhin_store_id} AND ${eps_workflow_from_state.workflow_from_state_id} = ${eps_workflow_transition.workflow_transition_from_state_id} ;;
    relationship: many_to_one
  }

  join: eps_workflow_to_state {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_to_state.chain_id} = ${eps_workflow_transition.chain_id} AND ${eps_workflow_to_state.nhin_store_id} = ${eps_workflow_transition.nhin_store_id} AND ${eps_workflow_to_state.workflow_to_state_id} = ${eps_workflow_transition.workflow_transition_to_state_id} ;;
    relationship: many_to_one
  }

  join: eps_workflow_state_attribute {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_state_attribute.chain_id} = ${eps_workflow_state.chain_id} AND ${eps_workflow_state_attribute.nhin_store_id} = ${eps_workflow_state.nhin_store_id} AND ${eps_workflow_state_attribute.workflow_state_id} = ${eps_workflow_state.workflow_state_id} ;;
    relationship: one_to_many
  }

  join: eps_workflow_type {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_type.chain_id} = ${eps_workflow_state_attribute.chain_id} AND ${eps_workflow_type.nhin_store_id} = ${eps_workflow_state_attribute.nhin_store_id} AND ${eps_workflow_type.workflow_type_id} = ${eps_workflow_state_attribute.workflow_type_id} ;;
    relationship: many_to_one
  }
}

explore: sales {
  extends: [sales_base]
  fields: [
    ALL_FIELDS*,
    -sales.explore_rx_measure_4_10_candidate_list*,
    -patient.rx_com_id_deidentified,      #ERXLPS-1162
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store_patient_address_extension_hist.explore_patient_address_extension_hist_4_14_candidate_list*, #[ERX-3541][ERXLPS-1024][ERXLPS-2420]
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_drug_cost_type.store_drug_cost_type_deidentified, -store_drug_cost_type.store_drug_cost_type_description_deidentified, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-1625]
    -rx_tx_drug_cost_hist.explore_rx_drug_cost_hist_4_10_candidate_list*, #[ERXLPS-2295]
    -rx_tx_store_drug_cost_hist.explore_rx_store_drug_cost_hist_4_10_candidate_list*, #[ERXLPS-2295]
    -eps_patient.store_patient_pharmacy_number, #[ERXLPS-2329]
    -eps_patient.store_patient_count_central_patient_explore, #[ERXLPS-2329]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*,#[ERXLPS-2114]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list* #[ERXLPS-2114]
  ]

  join: chain {
    type: inner
    sql_on: ${sales.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: tx_tp {
  extends: [tx_tp_base]
  fields: [
    ALL_FIELDS*,
    -rx_tx.tx_tp_claim_amount,
    -rx_tx.100_percent_copay,
    -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -prescriber.npi_number_deidentified,     #ERXLPS-1162
    -prescriber.dea_number_deidentified,     #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]

  join: chain {
    type: inner
    sql_on: ${tx_tp.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: eps_tx_tp_transmit_queue {
  extends: [eps_tx_tp_transmit_queue_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_tx_tp.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -eps_tx_tp_transmit_queue.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -eps_tx_tp_response_detail.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp_response_detail_amount.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp_submit_detail.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp.explore_sales_specific_candidate_list*, #[ERXLPS-1020]
    -prescriber.npi_number_deidentified,     #ERXLPS-1162
    -prescriber.dea_number_deidentified,     #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]

  join: chain {
    type: inner
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: drug {
  extends: [drug_base]
  fields: [
    ALL_FIELDS*,
    -drug_short_third_party.explore_rx_drug_short_tp_4_12_candidate_list*, #[ERXLPS-1262]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -gpi.explore_dx_gpi_levels_candidate_list* #[ERXDWPS-1454]
  ]
}

explore: inventory {
  extends: [inventory_base]
  fields: [
    ALL_FIELDS*,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -store_drug_local_setting.sum_drug_local_setting_on_hand_demo,
    -eps_rx_tx.bi_demo_prescription_fill_duration,
    -eps_rx_tx.bi_demo_start,
    -eps_rx_tx.bi_demo_sum_fill_duration,
    -eps_rx_tx.bi_demo_avg_fill_duration,
    -eps_rx_tx.bi_demo_median_fill_duration,
    -eps_rx_tx.bi_demo_max_fill_duration,
    -eps_rx_tx.bi_demo_min_fill_duration,
    -eps_rx_tx.bi_demo_start_time,
    -eps_rx_tx.bi_demo_start_date,
    -eps_rx_tx.bi_demo_start_week,
    -eps_rx_tx.bi_demo_start_month,
    -eps_rx_tx.bi_demo_start_month_num,
    -eps_rx_tx.bi_demo_start_year,
    -eps_rx_tx.bi_demo_start_quarter,
    -eps_rx_tx.bi_demo_start_quarter_of_year,
    -eps_rx_tx.bi_demo_start_hour_of_day,
    -eps_rx_tx.bi_demo_start_time_of_day,
    -eps_rx_tx.bi_demo_start_hour2,
    -eps_rx_tx.bi_demo_start_minute15,
    -eps_rx_tx.bi_demo_start_day_of_week,
    -eps_rx_tx.bi_demo_start_week_of_year,
    -eps_rx_tx.bi_demo_start_day_of_week_index,
    -eps_rx_tx.bi_demo_start_day_of_month,
    -eps_rx_tx.bi_demo_is_on_time_fifteen,
    -eps_rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -eps_rx_tx.explore_rx_4_8_000_sf_deployment_candidate_list*,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -store_drug.prescribed_drug_name,
    #-store_drug_cost.explore_rx_store_drug_cost_4_10_candidate_list*,
    #-store_drug_cost_type.explore_rx_store_drug_cost_type_4_10_candidate_list*,
    #-store_drug_cost_pivot.explore_rx_store_drug_cost_pivot_4_10_candidate_list*,
    -eps_rx_tx.bi_demo_time_in_will_call,
    -eps_rx_tx.bi_demo_sum_time_in_will_call,
    -eps_rx_tx.bi_demo_avg_time_in_will_call,
    -eps_rx_tx.bi_demo_median_time_in_will_call,
    -eps_rx_tx.bi_demo_max_time_in_will_call,
    -eps_rx_tx.bi_demo_min_time_in_will_call,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -store_perpetual_inventory_tracking.explore_rx_store_perpetual_inventory_tracking_4_11_candidate_list*,
    -perpetual_adjustment_code.explore_rx_store_adjustment_code_4_11_candidate_list*,
    -drug.explore_rx_drug_4_11_candidate_list*,
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -drug_short_third_party.explore_rx_drug_short_tp_4_12_candidate_list*,
    -eps_rx_tx.gap_time_measures_candidate_list*, #[ERX-3514]
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_rx_tx.rx_tx_refill_source, #[ERXLPS-896] Removed from 4.6 set to expose in WF Explore. Added here to exclude from Inventory Explore.
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_drug_cost_type.store_drug_cost_type_deidentified, -store_drug_cost_type.store_drug_cost_type_description_deidentified, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_vendor.Store_vendor_name_deidentified, #[ERXLPS-1878]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -customer_host_drug.drug_deleted,-customer_host_drug_cost.deleted,-customer_host_drug_cost_type.cost_type_deleted,
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -customer_host_drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -customer_host_drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -customer_host_drug_cost.explore_rx_drug_cost_metadata_candidate_list*, #[ERXLPS-2114]
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter_input, #[ERX-6185]
    -gpi.explore_dx_gpi_levels_candidate_list*, #[ERXDWPS-1454]
    -customer_host_gpi.explore_dx_gpi_levels_candidate_list*, #[ERXDWPS-1454]
    -store_user_license.bi_demo_store_user_license_number, #[ERXDWPS-5731]
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]

  join: chain {
    type: inner
    sql_on: ${store_drug.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }

  join: customer_host_drug {
    from: drug
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${customer_host_drug.chain_id} AND ${store_drug.ndc} = ${customer_host_drug.drug_ndc} AND ${customer_host_drug.drug_source_system_id} = 0 AND ${customer_host_drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: customer_host_gpi {
    from: gpi
    view_label: "Host GPI"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${customer_host_gpi.chain_id} AND ${store_drug.gpi_identifier} = ${customer_host_gpi.gpi_identifier} AND ${customer_host_gpi.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: customer_host_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level1.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,2),'000000000000')  = ${customer_host_gpi_level1.gpi_identifier}
            AND ${customer_host_gpi_level1.gpi_level_custom} = 1
            AND ${customer_host_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level2.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,4),'0000000000')  = ${customer_host_gpi_level2.gpi_identifier}
            AND ${customer_host_gpi_level2.gpi_level_custom} = 2
            AND ${customer_host_gpi_level2.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level3.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,6),'00000000')  = ${customer_host_gpi_level3.gpi_identifier}
            AND ${customer_host_gpi_level3.gpi_level_custom} = 3
            AND ${customer_host_gpi_level3.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level4.chain_id}
            AND concat(substr(${customer_host_drug.drug_gpi},1,10),'0000')  = ${customer_host_gpi_level4.gpi_identifier}
            AND ${customer_host_gpi_level4.gpi_level_custom} = 4
            AND ${customer_host_gpi_level4.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: customer_host_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_gpi_level5.chain_id}
            AND ${customer_host_drug.drug_gpi} = ${customer_host_gpi_level5.gpi_identifier}
            AND ${customer_host_gpi_level5.gpi_level_custom} = 5
            AND ${customer_host_gpi_level5.source_system_id} = 0 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1925] - exposed drug_cost in inventory explore.
  join: customer_host_drug_cost {
    from: drug_cost
    view_label: "Host Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_drug_cost.chain_id} AND ${customer_host_drug.drug_ndc} = ${customer_host_drug_cost.ndc} AND ${customer_host_drug.drug_source_system_id} = 0 AND ${customer_host_drug_cost.source_system_id} = 0 AND ${customer_host_drug_cost.deleted_reference} = 'N' AND ${customer_host_drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${customer_host_drug_cost.region}) ;;
    relationship: one_to_many
  }

  join: customer_host_drug_cost_pivot {
    from: drug_cost_pivot
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${customer_host_drug.chain_id} = ${customer_host_drug_cost_pivot.chain_id} AND ${customer_host_drug.drug_ndc} = ${customer_host_drug_cost_pivot.ndc} AND ${customer_host_drug.drug_source_system_id} = 0 AND ${customer_host_drug_cost_pivot.source_system_id} = 0 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${customer_host_drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-2064] - Added drug_csot_type to Inventory explore.
  join: customer_host_drug_cost_type {
    from: drug_cost_type
    view_label: "Host Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${customer_host_drug_cost.chain_id} = ${customer_host_drug_cost_type.chain_id} AND ${customer_host_drug_cost.cost_type} = ${customer_host_drug_cost_type.cost_type} AND ${customer_host_drug_cost_type.source_system_id} = 0 AND ${customer_host_drug_cost.source_system_id} = 0 AND ${customer_host_drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

#[ERX-2874] added as a part of 4.12.000
  join: customer_host_drug_short_tp {
    from: drug_short_third_party
    view_label: "Host Drug Short TP"
    type: left_outer
    fields: [-customer_host_drug_short_tp.explore_rx_drug_short_tp_4_12_candidate_list*]
    sql_on: ${store_drug.chain_id}= ${customer_host_drug_short_tp.chain_id} AND ${store_drug.ndc} = ${customer_host_drug_short_tp.ndc} AND ${customer_host_drug_short_tp.source_system_id} = 0 ;;
    relationship: many_to_many
  }
}

explore: query_history {
  extends: [query_history_base]
}

#[ERXLPS-1212]
explore: compound {
  label: "Compound"
  extends: [compound_base]
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]

  join: chain {
    type: inner
    sql_on: ${store_compound.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

#[ERX-3542] new explore added as a part of 4.13.000
explore: epr_audit_access_log {
  label: "Audit Access Log"
  extends: [epr_audit_access_log_base]
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]
}

#[ERXLPS-1362]
explore: eps_prescriber_edi {
  label: "eScript"
  extends: [eps_prescriber_edi_base]
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.chain_id,
    -store_drug.prescribed_drug_name,
    -patient.rx_com_id_deidentified,        #ERXLPS-1162
    -prescriber.npi_number_deidentified,    #ERXLPS-1162
    -prescriber.dea_number_deidentified,    #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -eps_rx_tx.explore_sales_specific_candidate_list*,
    -eps_rx_tx.gap_time_measures_candidate_list*,
    -eps_rx.rx_number_deidentified,
    -eps_rx_tx.bi_demo_specific_candidate_list*,
    #-eps_rx_tx.is_on_time_filter,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -eps_rx_tx.is_on_time_fifteen,
    -eps_rx_tx.prescription_fill_duration,
    -eps_rx_tx.sum_fill_duration,
    -eps_rx_tx.avg_fill_duration,
    -eps_rx_tx.median_fill_duration,
    -eps_rx_tx.max_fill_duration,
    -eps_rx_tx.min_fill_duration,
    -eps_rx_tx.start,
    -eps_rx_tx.start_date,
    -eps_rx_tx.start_day_of_month,
    -eps_rx_tx.start_day_of_week,
    -eps_rx_tx.start_day_of_week_index,
    -eps_rx_tx.start_hour2,
    -eps_rx_tx.start_hour_of_day,
    -eps_rx_tx.start_minute15,
    -eps_rx_tx.start_month,
    -eps_rx_tx.start_month_num,
    -eps_rx_tx.start_quarter,
    -eps_rx_tx.start_quarter_of_year,
    -eps_rx_tx.start_time,
    -eps_rx_tx.start_time_of_day,
    -eps_rx_tx.start_week,
    -eps_rx_tx.start_week_of_year,
    -eps_rx_tx.start_year,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -eps_rx_tx.pharmacy_comparable_flag,
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_rx.exploredx_eps_rx_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]

  join: chain {
    type: inner
    sql_on: ${eps_prescriber_edi.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

explore: sales_epr {
  extends: [sales_epr_base]

  join: chain {
    type: inner
    sql_on: ${sales_epr.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 AND ${chain.chain_id} <> 119080 ;;
    relationship: many_to_one
  }
}

#[ERXLPS-4396]
explore: plan {
  extends: [plan_nhin_base]
  fields: [ALL_FIELDS*,
    -plan.plan_name_deindentified]
}

#[ERXDWPS-5511] Exposed PDX Classic Error Explore in Enterpise Model. Access filter did not add as it is exposed in Enterprise model. Please use access filters if it is exposed in Customer Model.
explore: json_error_data {
  extends: [json_error_data_base]
}

#[ERXLPS-5143]
explore: patient_activity_snapshot {
  extends: [patient_activity_snapshot_base]
}

#[ERXDWPS-5883] - Task History Explore.
explore: eps_task_history {
  extends: [eps_task_history_base]
  fields: [ALL_FIELDS*,
    -eps_task_history.count_demo_user_employee_number,
    -eps_task_history.task_history_demo_user_login,
    -eps_task_history.task_history_demo_user_employee_number,
    -eps_task_history.bi_demo_on_site_alt_site,
    -eps_task_history.bi_demo_task_history_label_pharmacy_number,
    -eps_task_history.task_history_action_date_filter,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.fax_number,
    -store.phone_number,
    -store.dea_number #[ERXDWPS-9281]
  ]
}

#[ERXDWPS-6425] - User Explore
#[ERXDWPS-6425] - Store Fax and Phone number excluded from User Explore to avoid joins with store_setting view. Please check with architects before you expose fax and phone number.
#[ERXDWPS-6800] - Exposed all elements from Pharmacy Central and Pharmacy Store Alignment which are currently exposed in Pharmacy Explore. As a standard we decided to expose all Pharmacy Central and Pharmacy Align information in explores where ever Pharmacy information exposed.
explore: store_user {
  extends: [store_user_base]
  fields: [ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store_last_filled.exist_in_store_alignment, #ERXDWPS-8224
    -store_user_license_type.bi_demo_count,
    -store_user_license.bi_demo_store_user_license_number,
    -store.dea_number #[ERXDWPS-9281]
  ]
}

explore: turnrx_store_drug_inventory_mvmnt_snapshot {
  extends: [turnrx_store_drug_inventory_mvmnt_snapshot_base]
}


explore: store_workflow_token_direct_stage_consumption {
  extends: [store_workflow_token_direct_stage_consumption_base]
}

#[ERXDWPS-6571]
explore: store_central_fill {
  extends: [store_central_fill_base]
#   hidden: yes #[ERXDWPS-9488] Exposed in Enterprise Model for QA testing.
  fields: [ALL_FIELDS*,
    -store_central_fill.central_fill_check_in_user_initials_deidentified,
    -store_central_fill.central_fill_fill_operator_deidentified,
    -store_central_fill.central_fill_fill_operator_employee_deidentified,
    -store_central_fill.central_fill_fill_operator_employee_initials_deidentified,
    -store.fax_number,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.phone_number,
    -eps_order_entry.exploredx_eps_order_entry_looker_default_timeframes*,
    -store_central_fill.exploredx_central_fill_looker_default_timeframes*,
    -eps_line_item.exploredx_eps_line_item_looker_default_timeframes*,
    -eps_rx.exploredx_eps_rx_looker_default_timeframes*,
    -eps_rx_tx.exploredx_eps_rx_tx_looker_default_timeframes*,
    -eps_rx_tx.explore_sales_specific_candidate_list*,
    -eps_rx_tx.bi_demo_prescription_fill_duration,
    -eps_rx_tx.bi_demo_start,
    -eps_rx_tx.bi_demo_sum_fill_duration,
    -eps_rx_tx.bi_demo_avg_fill_duration,
    -eps_rx_tx.bi_demo_median_fill_duration,
    -eps_rx_tx.bi_demo_max_fill_duration,
    -eps_rx_tx.bi_demo_min_fill_duration,
    -eps_rx_tx.bi_demo_start_time,
    -eps_rx_tx.bi_demo_start_date,
    -eps_rx_tx.bi_demo_start_week,
    -eps_rx_tx.bi_demo_start_month,
    -eps_rx_tx.bi_demo_start_month_num,
    -eps_rx_tx.bi_demo_start_year,
    -eps_rx_tx.bi_demo_start_quarter,
    -eps_rx_tx.bi_demo_start_quarter_of_year,
    -eps_rx_tx.bi_demo_start_hour_of_day,
    -eps_rx_tx.bi_demo_start_time_of_day,
    -eps_rx_tx.bi_demo_start_hour2,
    -eps_rx_tx.bi_demo_start_minute15,
    -eps_rx_tx.bi_demo_start_day_of_week,
    -eps_rx_tx.bi_demo_start_week_of_year,
    -eps_rx_tx.bi_demo_start_day_of_week_index,
    -eps_rx_tx.bi_demo_start_day_of_month,
    -eps_rx_tx.bi_demo_is_on_time_fifteen,
    -eps_rx_tx.source_task,
    -eps_rx_tx.target_task,
    -eps_rx.rx_number_deidentified,
    -eps_rx_tx.time_in_will_call,
    -eps_rx_tx.sum_time_in_will_call,
    -eps_rx_tx.avg_time_in_will_call,
    -eps_rx_tx.median_time_in_will_call,
    -eps_rx_tx.max_time_in_will_call,
    -eps_rx_tx.min_time_in_will_call,
    -eps_rx_tx.bi_demo_time_in_will_call,
    -eps_rx_tx.bi_demo_sum_time_in_will_call,
    -eps_rx_tx.bi_demo_avg_time_in_will_call,
    -eps_rx_tx.bi_demo_median_time_in_will_call,
    -eps_rx_tx.bi_demo_max_time_in_will_call,
    -eps_rx_tx.bi_demo_min_time_in_will_call,
    -eps_rx_tx.pharmacy_comparable_flag
  ]
}

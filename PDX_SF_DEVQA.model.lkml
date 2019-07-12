#X# Note: failed to preserve comments during New LookML conversion

label: "Enterprise Decision Support System - DEVQA"

#connection: "snowflake_qa" # [ERX-8034] Connection temporarily changed to QA
connection: "thelook" #[ERXDWPS-6368] Connection changed to production support


include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

include: "explore.base_dss"
include: "explore.base_sales"

persist_for: "6 hours"

week_start_day: monday

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
  fields: [
    ALL_FIELDS*,
    -looker_data_dictionary.customer_field_exclusion_list*]
  extends: [looker_data_dictionary_base]
  sql_always_where: model_name = 'PDX_SF_DEVQA' and field_hidden = 'false' ;;
}

explore: master_code {
  extends: [master_code_base]
}

# explore: report_calendar {
#   extends: [report_calendar_base]
# }

explore: store {
  fields: [
    ALL_FIELDS*
  ]
  extends: [store_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: prescriber {
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]
  extends: [prescriber_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: patient {
  extends: [patient_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-2329]
    -store.dea_number #[ERXDWPS-9281]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

#ERXDWPS-5133 - Looker - Create Patient - Store Explore with STORE PATIENT as the driver

explore: eps_patient {
  extends: [eps_patient_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-2329]
    -store.dea_number #[ERXDWPS-9281]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: rx_tx {
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -rx_tx.chain_id,
    -rx_tx.nhin_store_id,
    -rx_tx.store_rx_tx_fill_count,
    -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]
  extends: [rx_tx_base]

  #[ERXLPS-6395] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: eps_workflow_order_entry_rx_tx {
  extends: [eps_workflow_order_entry_rx_tx_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
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
    -eps_rx_tx.fill_count,
    -eps_task_history.count_demo_user_employee_number,
    -eps_task_history.task_history_demo_user_login,
    -eps_task_history.task_history_demo_user_employee_number,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
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
    #-eps_rx_tx.sum_acquisition_cost_qa, #[ERXLPS-1283] Expose only in Inventory explore.
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -patient.rx_com_id_deidentified, #[ERXLPS-1430]
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -store_user_license.bi_demo_store_user_license_number, #[ERXLPS-2078]
    -eps_task_history.avg_task_time, #[ERXDWPS-5833]
    -eps_task_history.task_history_task_start_time, #[ERXDWPS-5833]
    -store_user_license_type.bi_demo_count, #[ERXDWPS-6425]
    -eps_task_history.max_task_history_source_timestamp,
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    #[ERXDWPS-6802]
    -eps_order_entry.date_to_use_filter,
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales,
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*,
    -eps_order_entry.exploredx_eps_order_entry_analysis_cal_timeframes*,
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -store.dea_number #[ERXDWPS-9281]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

  #[ERX-6185]
  always_filter: {
    filters: {
      field: eps_rx_tx.active_archive_filter
      value: "Active Tables (Past 48 Complete Months Data)"
    }
  }

  join: eps_rx {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  #[NO JIRA US] - Created a new view with excluding change_billing_tx, admin_rebill, refill_too_soon scenarios. Added to only DEVQA model to perfom analyisis.
  join: eps_rx_refill_received_to_will_call {
    from: eps_rx_refill_received_to_will_call_qa
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx_refill_received_to_will_call.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx_refill_received_to_will_call.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx_refill_received_to_will_call.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_rx_refill_received_to_will_call.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

#[ERX-3940] : added this join to override join at explore level for testing performance related changes
  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXDWPS-6569] - Corrected join relationships. Currently exposing this information only in DEVQA and Enterprise Models.
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
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_drug.prescribed_drug_name,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
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
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

  access_filter: {
    field: chain.fiscal_chain_id
    user_attribute: allowed_fiscal_chain
  }

  #[ERXLPS-955] User attributes for division, region, district and store
  access_filter: {
    field: store_alignment.division_access_filter
    user_attribute: allowed_division
  }

  access_filter: {
    field: store_alignment.region_access_filter
    user_attribute: allowed_region
  }

  access_filter: {
    field: store_alignment.district_access_filter
    user_attribute: allowed_district
  }

  access_filter: {
    field: store_alignment.pharmacy_number_access_filter
    user_attribute: allowed_pharmacy_number
  }

  join: drug {
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${sales.chain_id} = ${drug.chain_id} AND ${sales.rx_tx_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "Host Drug"
    fields: [gpi_disease_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_disease_rnk} = 1 AND ${drug.drug_source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_disease_duration_cross_ref {
    from: gpi_disease_cross_ref
    view_label: "Host Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_duration_cross_ref.gpi} and ${gpi_disease_duration_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host Drug"
    fields: [gpi_identifier, gpi_description, gpi_level, gpi_level_variance_flag] #[ERXLPS-1065] Added gpi_level_variance_flag #[ERXLPS-1942] Removed medical_condition
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND  ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.source_system_id} = 0 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: drug_cost_pivot {
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug_cost_pivot.source_system_id} = 0 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-1065] - Added joins as part of Drug explore integration into Sales explore. Start here...
  join: drug_cost {
    view_label: "Host Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug_cost.source_system_id} = 0 AND ${drug_cost.deleted_reference} = 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many #[ERXLPS-1282] changed relationship from one_to_one to one_to_many
  }

  join: drug_cost_type {
    view_label: "Host Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost.source_system_id} = 0 AND ${drug_cost_type.source_system_id} = 0 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: drug_short_third_party {
    view_label: "Host Drug Short TP"
    type: left_outer
    sql_on: ${drug.chain_id}= ${drug_short_third_party.chain_id} AND ${drug.drug_ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 0 ;;
    relationship: one_to_many
  }
  #[ERXLPS-1065] - Added joins as part of Drug explore integration into Sales explore. End here...

  #[ERXLPS-1925]
  #[ERXLPS-2089] - Added the join at model level. This change has been made due to the view label name changed in base explore file. No logic changes made.
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "Host Vs. Pharmacy Drug"
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id} AND ${host_vs_pharmacy_comp.deleted_reference} = 'N' AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;; #[ERXLPS-2064]
    relationship: one_to_one
  }

  join: store_budget {
    view_label: "Prescription Transaction"
    type: left_outer
    relationship: many_to_one
    sql_on: ${store_budget.chain_id} = ${report_calendar_global.chain_id} AND ${report_calendar_global.report_date} = ${store_budget.report_date} AND ${store_budget.nhin_store_id} = ${sales.nhin_store_id} ;;
  }
}

explore: tx_tp {
  extends: [tx_tp_base]
  fields: [
    ALL_FIELDS*,
    -rx_tx.tx_tp_claim_amount,
    -rx_tx.100_percent_copay,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
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
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_tx_tp_transmit_queue.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -eps_tx_tp_response_detail.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp_response_detail_amount.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp_submit_detail.explore_sales_specific_candidate_list*, #[ERXLPS-726]
    -eps_tx_tp.explore_sales_specific_candidate_list*, #[ERXLPS-1020]
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: drug {
  label: "Drug"
  view_name: drug
  view_label: "Host Drug"
  #[ERXLPS-4355] - Added always where condition to filter only HOST information. Removed the conditions at join level.
  sql_always_where: drug.source_system_id = 0 ;;
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
  fields: [ALL_FIELDS*, #[ERXLPS-1617]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -gpi.explore_dx_gpi_levels_candidate_list* #[ERXDWPS-1454]
  ]
  description: "Displays information pertaining to Master Drug Information from Customer HOST. This explore does not include any store level drug information"

  join: chain {
    view_label: "Chain"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${drug.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host GPI"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.source_system_id} = 0 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1942] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "Host GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "Host GPI"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: drug_cost {
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 0 ;;
    relationship: one_to_many #[ERXLPS-1311] Corrected the relationship.
  }

  join: drug_cost_type {
    view_label: "Host Drug Cost Type"
    type: left_outer
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 0 ;;
    relationship: many_to_one
  }

#[ERX-2874] added as a part of 4.12.000
  join: drug_short_third_party {
    view_label: "Host Drug Short TP"
    type: left_outer
    sql_on: ${drug.chain_id}= ${drug_short_third_party.chain_id} AND ${drug.drug_ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 0 ;;
    relationship: one_to_many
  }

#ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker
  join: medispan_drug_cost_hist {
    view_label: "Medi-Span Drug Cost Hist"
    type: left_outer
    sql_on: ${drug.drug_ndc} = ${medispan_drug_cost_hist.ndc}
        AND ${medispan_drug_cost_hist.chain_id} = 3000
        AND ${medispan_drug_cost_hist.source_system_id} = 16
        AND ${medispan_drug_cost_hist.drug_cost_source_reference} = 'M';;
    relationship: one_to_many
  }
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
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.store_close_date,
    -store_alignment.pharmacy_open_date,
    -store_alignment.pharmacy_comparable_date,
    -store_alignment.pharmacy_comparable_flag,
    -store_alignment.store_open_date,
    -store_alignment.store_comparable_date,
    -store_alignment.store_comparable_flag,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -store_drug.prescribed_drug_name,
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
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -eps_rx_tx.gap_time_measures_candidate_list*, #[ERX-3514]
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -eps_rx_tx.rx_tx_refill_source, #[ERXLPS-896] Removed from 4.6 set to expose in WF Explore. Added here to exclude from Inventory Explore.
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store_drug_cost_type.store_drug_cost_type_deidentified, -store_drug_cost_type.store_drug_cost_type_description_deidentified, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_vendor.Store_vendor_name_deidentified, #[ERXLPS-1878]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter_input, #[ERX-6185]
    -store_user_license.bi_demo_store_user_license_number, #[ERXDWPS-5731]
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

  join: drug {
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${drug.chain_id} AND ${store_drug.ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host GPI"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-1942] removed medical_condition
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${gpi.chain_id} AND ${store_drug.gpi_identifier} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "Host GPI"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.source_system_id} = 0 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1925] - exposed drug_cost in inventory explore.
  join: drug_cost {
    view_label: "Host Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug_cost.source_system_id} = 0 AND ${drug_cost.deleted_reference} = 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many
  }

  join: drug_cost_pivot {
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug_cost_pivot.source_system_id} = 0 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-2064] - Added drug_csot_type to Inventory explore.
  join: drug_cost_type {
    view_label: "Host Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost.source_system_id} = 0 AND ${drug_cost_type.source_system_id} = 0 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join #[ERXLPS-2064]
    relationship: many_to_one
  }

#[ERX-2874] added as a part of 4.12.000
  join: drug_short_third_party {
    view_label: "Host Drug Short TP"
    type: left_outer
    sql_on: ${store_drug.chain_id}= ${drug_short_third_party.chain_id} AND ${store_drug.ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 0 ;;
    relationship: many_to_many
  }

# [ERX-3940] : added this join to override join at explore level for testing performance related changes
# ERXLPS-2216 - Updated relationship from many to one, to one to many between store_drug and eps_rx_tx
  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted} = 'N' AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  #[ERXLPS-1925]
  #[ERXLPS-2089] - Added the join at model level. This change has been made due to the view label name changed in base explore file. No logic changes made.
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "Host Vs. Pharmacy Drug"
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id} AND ${host_vs_pharmacy_comp.deleted_reference} = 'N' AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;; #[ERXLPS-2064]
    relationship: one_to_one
  }

  #[ERXLPS-2411] [ERXLPS-2564] - Moved join from base view to DEVQA Model.
  join: store_drug_mac {
    view_label: "Pharmacy Drug MAC"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_mac.chain_id} AND ${store_drug.nhin_store_id} = ${store_drug_mac.nhin_store_id} AND ${store_drug.drug_id} = to_char(cast(${store_drug_mac.drug_id} as number)) ;;
    relationship: one_to_many
  }
}

explore: xfer_logs {
  view_name: xfer_logs
}

explore: file_xfer_history {
  view_name: file_xfer_history
}

explore: corporate_calendar {
  extends: [corporate_calendar_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: etl_manager_event {
  label: "ETL/Data Load"
  view_label: "Event"

  always_filter: {
    filters: {
      field: event_begin_date
      value: "last 30 days"
    }

    filters: {
      field: status
      value: "Success"
    }

    filters: {
      field: load_type
      value: "Regular"
    }

    filters: {
      field: refresh_frequency
      value: "Daily,Hourly"
    }
  }

  description: "Displays information pertaining to ETL/job processing"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${etl_manager_event.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: etl_manager_event_job {
    view_label: "Event Job"
    type: left_outer
    sql_on: ${etl_manager_event.event_id} = ${etl_manager_event_job.event_id} ;;
    relationship: one_to_many
  }

  join: etl_manager_event_warehouse {
    view_label: "Event"
    type: left_outer
    sql_on: ${etl_manager_event.event_id} = ${etl_manager_event_warehouse.event_id} ;;
    relationship: one_to_one
  }

  join: etl_manager_event_job_log {
    view_label: "Event Job Log"
    type: left_outer
    sql_on: ${etl_manager_event_job.event_id} = ${etl_manager_event_job_log.event_id} AND ${etl_manager_event_job.job_name} = ${etl_manager_event_job_log.job_name} ;;
    relationship: one_to_many
  }

  join: etl_manager_event_job_error_log {
    view_label: "Event Job Error Log"
    type: left_outer
    sql_on: ${etl_manager_event_job.event_id} = ${etl_manager_event_job_error_log.event_id} AND ${etl_manager_event_job.job_name} = ${etl_manager_event_job_error_log.job_name} ;;
    relationship: one_to_many
  }
}

explore: table_structure_validation {
  extends: [table_structure_validation_base]
}

explore: sanity_job_count {
  extends: [sanity_job_count_base]
}

explore: noise_source_system {
  extends: [noise_source_system_base]
}

explore: dq_duplicates_in_edw_current_state {
  extends: [dq_duplicates_in_edw_current_state_base]
}

#[ERXDWPS-6571]
explore: store_central_fill {
  extends: [store_central_fill_base]
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

  #[ERXDWPS-6802]
  access_filter: {
    field: chain.fiscal_chain_id
    user_attribute: allowed_fiscal_chain
  }

  fields: [ALL_FIELDS*,
    -store_central_fill.central_fill_check_in_user_initials_deidentified,
    -store_central_fill.central_fill_fill_operator_deidentified,
    -store_central_fill.central_fill_fill_operator_employee_deidentified,
    -store_central_fill.central_fill_fill_operator_employee_initials_deidentified,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.fax_number,
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

explore: compound {
  label: "Compound"
  extends: [compound_base]
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]

  #{ERXLPS-6395] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

explore: query_history {
  label: "Snowflake Query History"
  extends: [query_history_base]
}

explore: image_cross_ref {
  label: "Image Cross Reference"
  extends: [image_cross_ref_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
  fields: [
    ALL_FIELDS*,
    -store.phone_number, -store.fax_number, #[ERXLPS-753]
    -store.dea_number #[ERXDWPS-9281]
  ]
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

explore: login_history {
  label: "Snowflake Login History"
  extends: [login_history_base]
}

explore: looker_explore {
  extends: [looker_explore_base]
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
    -eps_rx_tx.on_time,
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

  #{ERXLPS-6395] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

}


#[ERX-6443]
explore: json_error_data {
  extends: [json_error_data_base]
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}


#[TRX-3091]
explore: turnrx_inventory_store_kpi {
  view_name: turnrx_inventory_store_kpi
  label: "Pharmacy Inventory KPI"
  view_label: "Pharmacy Inventory KPI"
  description: "Pharmacy Inventory KPI"

  fields: [
    ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.dea_number #[ERXDWPS-9281]
  ]

  always_filter: {
    filters: {
      field: report_calendar_global.report_period_filter
      value: "Last 1 Years"
    }

    filters: {
      field: report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Year"
    }

    filters: {
      field: report_calendar_global.this_year_last_year_filter
      value: "No"
    }
  }

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      fiscal_chain_id,
      chain_filter
    ]
    type: inner
    sql_on: ${turnrx_inventory_store_kpi.chain_id} = ${chain.chain_id}
      AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    #fields: [store_number, store_name, deactivated_date, count, nhin_store_id]
    type: inner
    sql_on: ${turnrx_inventory_store_kpi.chain_id}      = ${store.chain_id}
        AND ${turnrx_inventory_store_kpi.nhin_store_id} = ${store.nhin_store_id}
        AND ${store.source_system_id} = 5
        AND ${store.store_client_version} is not null
        AND ${store.store_registration_status} = 'REGISTERED' ;;
    relationship: many_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id}      = ${store_alignment.chain_id}
      AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: report_calendar_global {
    type: inner
    sql_on: ${turnrx_inventory_store_kpi.chain_id}      = ${report_calendar_global.chain_id}
      AND ${turnrx_inventory_store_kpi.activity_date} = ${report_calendar_global.calendar_date}  ;;
    relationship: one_to_one
    fields: [global_calendar_candidate_list*]
  }

  join: timeframes {
    type: inner
    sql_on: ${report_calendar_global.chain_id}      = ${timeframes.chain_id}
      AND ${report_calendar_global.report_date}   = ${timeframes.calendar_date} ;;
    relationship: one_to_one
  }

  join: store_setting_phone_number_area_code {
    from: store_setting
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number_area_code {
    from: store_setting
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number {
    from: store_setting
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_phone_number {
    from: store_setting
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }
}

#[TRX-3091]
# explore: turnrx_inventory_store_kpi_qa {
#   view_name: turnrx_inventory_store_kpi
#   label: "Pharmacy Inventory KPI QA"
#   view_label: "Pharmacy Inventory KPI QA"
#   description: "Pharmacy Inventory KPI QA"
#
#   always_filter: {
#     filters: {
#       field: report_calendar_global.report_period_filter
#       value: "Last 1 Years"
#     }
#
#     filters: {
#       field: report_calendar_global.analysis_calendar_filter
#       value: "Fiscal - Year"
#     }
#
#     filters: {
#       field: report_calendar_global.this_year_last_year_filter
#       value: "No"
#     }
#   }
#
#   access_filter: {
#     field: chain.chain_id
#     user_attribute: allowed_turnrx_chain
#   }
#
#   join: chain {
#     view_label: "Pharmacy"
#     fields: [
#       chain_id,
#       chain_name,
#       master_chain_name,
#       chain_deactivated_date,
#       chain_open_or_closed
#     ]
#     type: inner
#     sql_on: ${turnrx_inventory_store_kpi.chain_id} = ${chain.chain_id}
#       AND ${chain.source_system_id} = 5 ;;
#     relationship: many_to_one
#   }
#
#   join: store {
#     view_label: "Pharmacy"
#     #fields: [store_number, store_name, deactivated_date, count, nhin_store_id]
#     type: inner
#     sql_on: ${turnrx_inventory_store_kpi.chain_id}      = ${store.chain_id}
#         AND ${turnrx_inventory_store_kpi.nhin_store_id} = ${store.nhin_store_id}
#         AND ${store.source_system_id} = 5
#         AND ${store.store_client_version} is not null
#         AND ${store.store_registration_status} = 'REGISTERED' ;;
#     relationship: many_to_one
#   }
#
#   join: store_alignment {
#     view_label: "Pharmacy"
#     type: left_outer
#     sql_on: ${store.chain_id}      = ${store_alignment.chain_id}
#       AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
#     relationship: one_to_one
#   }
#
#   join: report_calendar_global {
#     type: inner
#     sql_on: ${turnrx_inventory_store_kpi.chain_id}      = ${report_calendar_global.chain_id}
#       AND ${turnrx_inventory_store_kpi.activity_date} = ${report_calendar_global.calendar_date}  ;;
#     relationship: one_to_one
#     fields: [global_calendar_candidate_list*]
#   }
#
#   join: timeframes {
#     type: inner
#     sql_on: ${report_calendar_global.chain_id}      = ${timeframes.chain_id}
#       AND ${report_calendar_global.report_date}   = ${timeframes.calendar_date} ;;
#     relationship: one_to_one
#   }
#
#   join: store_setting_phone_number_area_code {
#     from: store_setting
#     view_label: "Pharmacy"
#     type: left_outer
#     sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
#     relationship: one_to_one
#     fields: [ ]
#   }
#
#   join: store_setting_fax_number_area_code {
#     from: store_setting
#     view_label: "Pharmacy"
#     type: left_outer
#     sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
#     relationship: one_to_one
#     fields: [ ]
#   }
#
#   join: store_setting_fax_number {
#     from: store_setting
#     view_label: "Pharmacy"
#     type: left_outer
#     sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
#     relationship: one_to_one
#     fields: [ ]
#   }
#
#   join: store_setting_phone_number {
#     from: store_setting
#     view_label: "Pharmacy"
#     type: left_outer
#     sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
#     relationship: one_to_one
#     fields: [ ]
#   }
# }
#
#[ERXLPS-4396]
explore: plan {
  extends: [plan_host_base]
  fields: [ALL_FIELDS*,
    -plan.plan_name_deindentified]

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

#[ERXLPS-5143]
explore: patient_activity_snapshot {
  extends: [patient_activity_snapshot_base]

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
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

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
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

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

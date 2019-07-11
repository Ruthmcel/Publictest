#X# Note: failed to preserve comments during New LookML conversion

label: "Customer Decision Support System"

connection: "snowflake"

include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

include: "explore.base_dss"
include: "explore.base_sales"

include: "edx_tmpl_chain*.dashboard" #[ERXDWPS-6087] - include all standard template dashboards.
include: "explore.base_turnrx"

idd

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

access_grant: can_view_workflow_token_explore {
  user_attribute: allowed_chain
  allowed_values: [ "128", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

#persist_for: "6 hours" #[ERXLPS-1739]

#[ERXLPS-1733] Added datagroup in customer model to run schedule/ad-hoc reports directly from database between 1AM- 8AM CST.
persist_with: customer_cache_info

datagroup: customer_cache_info {
  sql_trigger: SELECT MAX(event_begin_date) FROM etl_manager.event WHERE event_type = 'STAGE TO EDW ETL' AND refresh_frequency = 'D' ;;
  max_cache_age: "25 hours"
}

#[ERXDWPS-5983]
datagroup: customer_workflow_cache_info {
  sql_trigger: SELECT MAX(event_end_date) FROM etl_manager.event WHERE event_type = 'STAGE TO EDW ETL' ;;
  max_cache_age: "25 hours"
}

datagroup: customer_eps_stage_cache_info {
  sql_trigger: SELECT MAX(process_timestamp) FROM json_stage.symmetric_event_stage ;;
  max_cache_age: "25 hours"
}

week_start_day: sunday

case_sensitive: no

explore: store { 
}

explore: master_code {
}

explore: looker_data_dictionary {
  fields: [
          ALL_FIELDS*,
          -looker_data_dictionary.customer_field_exclusion_list*]
  extends: [looker_data_dictionary_base]
  sql_always_where: model_name = 'PDX_CUSTOMER_DSS' and field_hidden = 'false' ;;
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
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,       #ERXLPS-1162
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
       #[ERXLPS-6238] - Hide Prescription Transaction and Third Party Claim explorers from the Customer Decision Support Model
  fields: [
    ALL_FIELDS*,
    -rx_tx.chain_id,
    -rx_tx.nhin_store_id,
    -rx_tx.store_rx_tx_fill_count,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]
  extends: [rx_tx_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }

  join: drug {
    view_label: "Host Drug"
    fields: [
      drug_ndc,
      drug_ndc_9,
      drug_ndc_11_digit_format,
      drug_bin_storage_type,
      drug_category,
      drug_class,
      drug_ddid,
      drug_dosage_form,
      drug_full_generic_name,
      drug_full_name,
      drug_generic_name,
      drug_individual_container_pack,
      drug_integer_pack,
      drug_manufacturer,
      drug_brand_generic,
      drug_name,
      drug_schedule,
      drug_schedule_category,
      drug_strength,
      count
    ]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_CHAIN C LEFT OUTER JOIN EDW.D_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_CHAIN C LEFT OUTER JOIN EDW.D_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "Host GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 0 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "Host Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${gpi.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }
}

explore: eps_workflow_order_entry_rx_tx {
  extends: [eps_workflow_order_entry_rx_tx_base]
  #access_filter_fields: [chain.chain_id]

  # ERXDWPS-6276 Changes. Secure view logic moved to view and added as sql_always_filter.
  #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_order_entry.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
  #[ERXDWPS-2701] - Due to Looker limitation we are not able to add eps_line_item and eps_rx_tx chain_id user_attributes conditions using liquid varibles at model level. The feature will be available from Lookre 6.8 version. Please refer to the looker chat email attached in ERXDWPS-2701 US
  sql_always_where: ${store_to_store_alignment_secured_view.entity_type} IN ('STORE-ALIGNMENT')
    AND {% condition chain.chain_id %} ${eps_order_entry.chain_id} {% endcondition %} ;;

  #[ERXDWPS-5983]
  persist_with: customer_workflow_cache_info

  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
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

  fields: [
    ALL_FIELDS*,
    -eps_task_history.count_demo_user_employee_number,
    -eps_task_history.task_history_demo_user_login,
    -eps_task_history.task_history_demo_user_employee_number,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
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

  #[ERXDWPS-6276] Changes
  #[ERXDWPS-2701] - Secure view is joined with store view instead of explore driver view. The change made due to SF Optimizer issue (SF#38334). When sec_view joined with driver, it is performing cross join and causing perfomance issues.
  #[ERXDWPS-2701] - To avoid performance issues caused by SF optimizer we need to make sec view join with store view. This will pull store view joins into final SQL. But it should not cause huge performance issues as store view data is less.
  join: store_to_store_alignment_secured_view {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${store.chain_id} = ${store_to_store_alignment_secured_view.chain_id} AND ${store.nhin_store_id} = ${store_to_store_alignment_secured_view.nhin_store_id} ;;
    relationship: one_to_one
  }
}

explore: sales {
  extends: [sales_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_drug.prescribed_drug_name,
    -sales.explore_rx_measure_4_10_candidate_list*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store_patient_address_extension_hist.explore_patient_address_extension_hist_4_14_candidate_list*, #[ERX-3541][ERXLPS-1024][ERXLPS-2420]
    -patient.rx_com_id_deidentified,
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

  sql_always_where: ${store_to_store_alignment_secured_view.entity_type} IN ('STORE-ALIGNMENT');; # ERXDWPS-6276 Changes

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

  #[ERXLPS-1262] - Exposed all dimensions and measures from Drug, Drug_cost and Drug_cost_type.
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

  #[ERXDWPS-5064] - Join added to utlize new filter to schedule reports based on fiscal calendar start and end month/quarter/year.
  join: fiscal_calendar_grain {
    view_label: "Prescription Transaction"
    type: inner
    fields: [fiscal_calendar_schedule_filter]
    sql_on: ${sales.chain_id} = ${fiscal_calendar_grain.chain_id} AND ${fiscal_calendar_grain.model_name} = 'PDX_CUSTOMER_DSS' AND ${fiscal_calendar_grain.calendar_grain} = {% parameter fiscal_calendar_grain.fiscal_calendar_schedule_filter %} ;;
    relationship: many_to_one
  }
}

explore: tx_tp {
  hidden:  yes  #[ERXLPS-6238] - Hide Prescription Transaction and Third Party Claim explorers from the Customer Decision Support Model
  extends: [tx_tp_base]
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
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
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -rx_tx.explore_rx_4_6_000_sf_deployment_candidate_list*,
    -prescriber.npi_number_deidentified,     #ERXLPS-1162
    -prescriber.dea_number_deidentified,     #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -store.phone_number, -store.fax_number #[ERXLPS-753]
  ]

  join: drug {
    view_label: "Host Drug"
    fields: [
      drug_ndc,
      drug_ndc_9,
      drug_ndc_11_digit_format,
      drug_bin_storage_type,
      drug_category,
      drug_class,
      drug_ddid,
      drug_dosage_form,
      drug_full_generic_name,
      drug_full_name,
      drug_generic_name,
      drug_individual_container_pack,
      drug_integer_pack,
      drug_manufacturer,
      drug_brand_generic,
      drug_name,
      drug_schedule,
      drug_schedule_category,
      drug_strength
    ]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_CHAIN C LEFT OUTER JOIN EDW.D_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_CHAIN C LEFT OUTER JOIN EDW.D_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "Host GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 0 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "Host Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${gpi.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: plan {
    view_label: "Claim"
    type: left_outer
    sql_on: ${tx_tp.tx_tp_carrier_code} = ${plan.carrier_code} AND ${tx_tp.tx_tp_plan_code} = ${plan.plan_code} AND ${plan.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_PLAN C LEFT OUTER JOIN EDW.D_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
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
  fields: [ALL_FIELDS*, #[ERXLPS-1262]
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
    fields: [-drug_short_third_party.explore_rx_drug_short_tp_4_12_candidate_list*]
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
  #access_filter_fields: [chain.chain_id]
  #[ERXLPS-931] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
  fields: [
    ALL_FIELDS*,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -store_drug_local_setting.sum_drug_local_setting_on_hand_demo,
    -store_alignment.pharmacy_number,
    -store_alignment.store_number,
    -store_alignment.pharmacy_address,
    -store_alignment.pharmacy_city,
    -store_alignment.pharmacy_state,
    -store_alignment.pharmacy_time_zone,
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
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
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -eps_rx_tx.gap_time_measures_candidate_list*, #[ERX-3514]
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_drug_local_setting_hist.explore_rx_4_11_drug_local_setting_hist*, #[ERXLPS-1566]
    -eps_rx_tx_local_setting_hist.explore_rx_4_11_history_candidate_list*, #[ERXLPS-1566]
    -eps_rx_tx_local_setting_hist_at_fill.explore_rx_4_11_history_at_fill_candidate_list*, #[ERXLPS-1566]
    -store_drug_reorder_hist.explore_rx_4_11_drug_reorder_hist*, #[ERXLPS-1566]
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
    -gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -drug.explore_rx_drug_metadata_candidate_list*,
    -eps_rx_tx.active_archive_filter, #[ERX-6185]
    -eps_rx_tx.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist.active_archive_filter_input, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter, #[ERX-6185]
    -eps_rx_tx_local_setting_hist_at_fill.active_archive_filter_input, #[ERX-6185]
    -gpi.explore_dx_gpi_levels_candidate_list*, #[ERXDWPS-1454]
    -store_user_license.bi_demo_store_user_license_number, #[ERXDWPS-5731]
    -eps_rx_tx.exclude_eps_rx_tx_fields*,  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*, #[ERXDWPS-6802]
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]

  join: drug {
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${drug.chain_id} AND ${store_drug.ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host GPI"
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
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug_cost_pivot.source_system_id} = 0 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-2064] - Added drug_cost_type to Inventory explore.
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
    fields: [-drug_short_third_party.explore_rx_drug_short_tp_4_12_candidate_list*]
    sql_on: ${store_drug.chain_id}= ${drug_short_third_party.chain_id} AND ${store_drug.ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 0 ;;
    relationship: many_to_many
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
}

#[ERXLPS-1212]
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

  #{ERXLPS-6395] - Added Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
}

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

  sql_always_where: ${store_to_store_alignment_secured_view.entity_type} IN ('STORE-ALIGNMENT') ;; # ERXDWPS-6276 Changes

  #[ERXDWPS-8983] - Caching information added to task history explore.
  persist_with: customer_workflow_cache_info

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
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

  #[ERXDWPS-6276] Changes
  join: store_to_store_alignment_secured_view {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_task_history.chain_id} = ${store_to_store_alignment_secured_view.chain_id} AND ${eps_task_history.nhin_store_id} = ${store_to_store_alignment_secured_view.nhin_store_id} ;;
    relationship: many_to_one
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

explore: turnrx_store_drug_inventory_mvmnt_snapshot {
  extends: [turnrx_store_drug_inventory_mvmnt_snapshot_base]
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
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

#     #[ERXDWPS-9488] Exposed in Customer Model for QA testing.

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

explore: store_workflow_token_direct_stage_consumption {
  extends: [store_workflow_token_direct_stage_consumption_base]

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_chain
  }
  required_access_grants: [can_view_workflow_token_explore]
  persist_with: customer_eps_stage_cache_info
}



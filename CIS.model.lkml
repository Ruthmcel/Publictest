#X# Note: failed to preserve comments during New LookML conversion
label: "Central Inventory System"

connection: "thelook"

include: "*.view"

#TRX-3091 Changed to have TURNRX specific LookML dashboards only
include: "turnrx_*.dashboard"

include: "explore.base_dss"
include: "explore.base_sales"
include: "explore.base_turnrx"

#persist_for: "24 hours"
#ERXDWPS-6743 #TRX-4804 Added datagroups and changed persistence at MODEL and EXPLORE
persist_with: customer_cache_info

datagroup: customer_cache_info {
  sql_trigger: select max(event_end_date) from etl_manager.event where event_type = 'STAGE TO EDW ETL' and refresh_frequency = 'D' ;;
  max_cache_age: "25 hours"
}

datagroup: inventory_kpi_cache_info {
  sql_trigger: select max(event_end_date) from etl_manager.event where event_type = 'TURNRX_INVENTORY_KPI_GENERATION' and refresh_frequency = 'D' ;;
  max_cache_age: "25 hours"
}

datagroup: inventory_transfer_no_cache {
  sql_trigger: select max(event_end_date) from etl_manager.event where event_type like 'TURNRX_INVENTORY_TRANSFER%' ;;
  max_cache_age: "0 hours"
}

datagroup: inventory_transfer_cache {
  sql_trigger: select max(event_end_date) from etl_manager.event where event_type like 'TURNRX_INVENTORY_TRANSFER%' ;;
  max_cache_age: "25 hours"
}

week_start_day: sunday

case_sensitive: no

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_turnrx_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

explore: looker_data_dictionary {
  fields: [
    ALL_FIELDS*,
    -looker_data_dictionary.customer_field_exclusion_list*]
  extends: [looker_data_dictionary_base]
  sql_always_where: model_name = 'CIS' and field_hidden = 'false' ;;
}

explore: store {
  fields: [
    ALL_FIELDS*,
    -store_setting.explore_rx_store_setting_4_10_candidate_list*
  ]
  extends: [store_base]
#   access_filter_fields: [chain.chain_id]
  #[ERXLPS-1405] - Added TurnRx Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

explore: master_code {
  extends: [master_code_base]
}

explore: sales {
  extends: [sales_base]
  fields: [
    ALL_FIELDS*,
    -store_alignment.pharmacy_comparable_flag, #[ERXLPS_1452]
    -store_budget.looker_prod_1_6_009_deployment_budget_candidate_list*,
    -store_drug.prescribed_drug_name,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -sales.explore_rx_measure_4_10_candidate_list*,
    -patient.rx_com_id_deidentified,  #ERXLPS-1162
    -prescriber.npi_number_deidentified,  #ERXLPS-1162
    -prescriber.dea_number_deidentified,  #ERXLPS-1162
    -prescriber.name_deidentified,         #ERXLPS-1162
    -store_patient_address_extension_hist.explore_patient_address_extension_hist_4_14_candidate_list*, #[ERX-3541][ERXLPS-1024][ERXLPS-2420]
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
#   access_filter_fields: [chain.chain_id]
  #[ERXLPS-1405] - Added TurnRx Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }

  access_filter: {
    field: chain.fiscal_chain_id
    user_attribute: allowed_fiscal_chain
  }

  join: drug {
    view_label: "Host Drug"
    type: left_outer
    sql_on: ${sales.chain_id} = ${drug.chain_id} AND ${sales.rx_tx_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXLPS-1056] - Added gpi_disease_duration_cross_ref join to CIS Model
  join: gpi_disease_duration_cross_ref {
    from: gpi_disease_cross_ref
    view_label: "Host Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_duration_cross_ref.gpi} and ${gpi_disease_duration_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "Host Drug"
    fields: [gpi_disease_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_disease_rnk} = 1 AND ${drug.drug_source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Host Drug"
    fields: [gpi_identifier, gpi_description, gpi_level, gpi_level_variance_flag] #[ERXLPS-1065] - Added gpi_level_variance_flag #[ERXLPS-1942] Removed medical_condition
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
}

explore: drug {
  label: "Drug"
  view_name: drug
  view_label: "Host Drug"
  #[ERXLPS-4355] - Added always where condition to filter only HOST information. Removed the conditions at join level.
  sql_always_where: drug.source_system_id = 0 ;;
#   access_filter_fields: [chain.chain_id]
  #[ERXLPS-1405] - Added TurnRx Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
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
    fields: [-explore_rx_drug_short_tp_4_12_candidate_list*]
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
#   access_filter_fields: [chain.chain_id]
  #[ERXLPS-1405] - Added TurnRx Chain user attribute
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
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
    -drug.explore_rx_drug_metadata_candidate_list*, #[ERXLPS-2114]
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
    relationship: one_to_many #[ERXLPS-1311] Corrected the relationship.
  }

  join: drug_cost_pivot {
    view_label: "Host Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug.drug_source_system_id} = 0 AND ${drug_cost_pivot.source_system_id} = 0 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #[ERXLPS-2064] - Added drug_cost_type to Inventory explore
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

  #join: chain_store_inventory_turn {
  #  view_label: "Inventory Turns"
  #  type: left_outer
  #  sql_on: ${store_drug.chain_id} = ${chain_store_inventory_turn.chain_id} AND ${store_drug.nhin_store_id} = ${chain_store_inventory_turn.nhin_store_id} AND ${store_drug.drug_id} = ${chain_store_inventory_turn.rx_tx_drug_dispensed_id} ;;
  #  relationship: one_to_many
  #}
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
    user_attribute: allowed_turnrx_chain
  }
}

#[ERXLPS-4396]
explore: plan {
  extends: [plan_host_base]
  fields: [ALL_FIELDS*,
           -plan.plan_name_deindentified]

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

#TRX-3091
explore: turnrx_inventory_store_kpi {
  view_name: turnrx_inventory_store_kpi
  label: "Pharmacy Inventory KPI"
  view_label: "Pharmacy Inventory KPI"
  description: "Pharmacy Inventory KPI"
  persist_with: inventory_kpi_cache_info #ERXDWPS-6743 #TRX-4804

  always_filter: {
    filters: {
      field: report_calendar_global.report_period_filter
      value: "Last 13 Months"
    }

    filters: {
      field: report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Month"
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

  fields: [
    ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.dea_number #[ERXDWPS-9281]
  ]

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

explore: turnrx_store_drug_inventory_mvmnt_snapshot {
  extends: [turnrx_store_drug_inventory_mvmnt_snapshot_base]
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

# "TRX-5047" Changes made in turnrx_transfer_store_to_store_task explore should also be made in turnrx_transfer_store_to_store_task_no_cache
explore: turnrx_transfer_store_to_store_task {
  extends: [turnrx_transfer_store_to_store_task_base]
  persist_with: inventory_transfer_cache
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

# "TRX-5047" This explore should be used in cases where the data is not to be loaded from the cache.
# This explore should be kept hidden and be used only for building looks and dashboards.
explore: turnrx_transfer_store_to_store_task_no_cache {
  label: "Inventory Transfer Explore - NO CACHE"
  extends: [turnrx_transfer_store_to_store_task_base]
  persist_with: inventory_transfer_no_cache
  hidden: yes
  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_turnrx_chain
  }
}

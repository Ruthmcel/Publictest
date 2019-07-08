
#X# Note: failed to preserve comments during New LookML conversion

view: explore_base_dss_lookml {}


explore: report_calendar_base {
  extension: required
  label: "Report Calendar"
  view_label: "Report Calendar"
  view_name: report_calendar_global
  description: "Displays Report Calendar Global used in the Sales explore across different models"

  always_filter: {
    filters: {
      field: report_calendar_global.report_period_filter
      value: "Last 1 Month"
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

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count]
    type: inner
    sql_on: ${report_calendar_global.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }
}

explore: looker_warehouse_usage_history_base {
  extension: required
  label: "Looker Warehouse Usage History"
  view_label: "Looker Warehouse Usage History"
  view_name: looker_warehouse_usage_history
  description: "Displays Looker's Snowflake Warehouse Usage across all ExploreRx customer base"
}

explore: looker_data_dictionary_base {
  extension: required
  label: "Looker Data Dictionary"
  view_label: "Looker Data Dictionary"
  view_name: looker_data_dictionary
  description: "Displays metadata about fields built within the Looker Model and displays the fields in a digestible format that provides transparency about metric definitions. The definitions are based on dimensions and measures in the LookML model, including the data type, description of the metric, and the associated LookML sql parameter"
}

explore: symmetric_node_status_snapshot_base {
  extension: required
  label: "Symmetric Node Status"
  view_label: "Symmetric Node Status"
  view_name: symmetric_node_status_snapshot
  description: "Displays information about Symmetric node status. This view takes snapshot every 15 minutes"
}

explore: snowflake_warehouse_usage_history_base {
  extension: required
  label: "Snowflake Warehouse Usage History"
  view_label: "Snowflake Warehouse Usage History"
  view_name: snowflake_warehouse_usage_history
  description: "Displays Snowflake Warehouse Usage across all ExploreRx Warehouses"

  always_filter: {
    filters: {
      field: snowflake_warehouse_usage_history.warehouse_usage_date_time
      value: "Last 1 Month"
    }
  }
}

explore: snowflake_account_usage_warehouse_metering_history_base {
  extension: required
  label: "Snowflake Warehouse Credit Usage History"
  view_label: "Snowflake Warehouse Credit Usage History"
  view_name: snowflake_account_usage_warehouse_metering_history
  description: "Displays hourly credit usage for all the Snowflake Warehouses within a specified date range"

  always_filter: {
    filters: {
      field: snowflake_account_usage_warehouse_metering_history.start_time
      value: "Last 1 Month"
    }
  }
}

explore: master_code_base {
  extension: required
  label: "Master Code"
  view_label: "Master Code"
  view_name: master_code
  description: "Displays Values and Descriptions for data (explains the data) that resides in the Enterprise Data Warehouse (EDW). Provides Source system information for which the EDW table columns is sourced from."
}

explore: store_base {
  extension: required
  label: "Pharmacy"
  view_label: "Pharmacy - Central"
  fields:
  [ALL_FIELDS*,
    -store.chain_id,-chain.fiscal_chain_id
  ]
  description: "Displays information of the customer's individual store demographic information, registration status, client information, and communication information"

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${store.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5  AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} =5 ;;
    relationship: one_to_one
  }

  join: store_product_vendor {
    view_label: "Pharmacy Products"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_product_vendor.chain_id} AND ${store.nhin_store_id} = ${store_product_vendor.nhin_store_id} AND ${store_product_vendor.store_product_vendor_deleted} = 'N' AND ${store_product_vendor.source_system_id} = 5 ;;
    relationship: one_to_many
  }

  join: store_setting {
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting.chain_id} AND  ${store.nhin_store_id} = ${store_setting.nhin_store_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS_753] - Joins to get Pharmacy Phone Number and Fax Number from store_setting view
  join: store_setting_phone_number {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_phone_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

#[ERX-2203] added as a part of 4.12.000 for file_date fields
  join: store_file_date {
    view_label: "Pharmacy File Update"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_file_date.chain_id} AND  ${store.nhin_store_id} = ${store_file_date.nhin_store_id} ;;
    relationship: one_to_many
  }

#[ERX-3527] added as a part of 4.13.000 for file_date_history fields
  join: store_file_date_history {
    view_label: "Pharmacy File Update History"
    type: left_outer
    sql_on: ${store_file_date.chain_id} = ${store_file_date_history.chain_id} AND  ${store_file_date.nhin_store_id} = ${store_file_date_history.nhin_store_id} AND ${store_file_date.file_date_id} = ${store_file_date_history.file_date_id};;
    relationship: one_to_many
  }

  #[ERXLPS-1855] added to check if a store information exists in store_algnment table.
  join: store_last_filled {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_last_filled.chain_id} AND ${store.nhin_store_id} = ${store_last_filled.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  #[ERXLPS-6307] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }
}

explore: prescriber_base {
  extension: required
  view_name: prescriber
  sql_always_where: ${prescriber.deleted} = 'N' ;;
  fields: [ALL_FIELDS*, -prescriber.chain_id, -prescriber.nhin_store_id, -prescriber.prescriber_id, -prescriber.npi_number_deidentified, -prescriber.dea_number_deidentified, -prescriber.name_deidentified] #ERXLPS-1162
  description: "Displays information pertaining to the prescribing caregiver, i.e. Doctor, Physician's Assistant, Nurse Practitioner, etc."

  join: chain {
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${prescriber.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    view_label: "Pharmacy - Central"
    sql_on: ${prescriber.chain_id} = ${store.chain_id}  AND ${prescriber.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: us_zip_code {
    type: left_outer
    view_label: "Prescriber"
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} ;;
    relationship: many_to_one
  }
}

explore: patient_base {
  extension: required
  label: "Patient - Central"
  view_name: patient
  view_label: "Patient - Central"
  sql_always_where: ${patient.survivor_id} IS NULL AND ${patient.unmerged_date} IS NULL ;;
  fields: [ALL_FIELDS*,
    -patient.chain_id,
    -patient.updated_by_nhin_store_id,
    -patient.created_by_nhin_store_id,
    -prescriber.prescriber_id,
    -patient.rx_com_id_deidentified, #ERXLPS-1162
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified #[ERXLPS-2329]
  ]
  description: "Displays information pertaining to patients."

  join: chain {
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${patient.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    view_label: "Pharmacy - Central"
    sql_on: ${patient.chain_id} = ${store.chain_id}  AND ${patient.updated_by_nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N' AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: patient_phone {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_phone.chain_id} AND ${patient.rx_com_id} = ${patient_phone.rx_com_id} AND ${patient_phone.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_email {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_email.chain_id} AND ${patient.rx_com_id} = ${patient_email.rx_com_id} AND ${patient_email.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_mtm_eligibility {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_mtm_eligibility.chain_id} AND ${patient.rx_com_id} = ${patient_mtm_eligibility.rx_com_id} ;;
    relationship: one_to_many
  }

  join: patient_allergy {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_allergy.chain_id} AND ${patient.rx_com_id} = ${patient_allergy.rx_com_id} AND ${patient_allergy.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_disease {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_disease.chain_id} AND ${patient.rx_com_id} = ${patient_disease.rx_com_id} AND ${patient_disease.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_medical_condition {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_medical_condition.chain_id} AND ${patient.rx_com_id} = ${patient_medical_condition.rx_com_id} AND ${patient_medical_condition.deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-7476][ERXDWPS-7987] - New PDC US joins. Added condition to filter only latest snapshot date when latest_snapshot_filter is selected as Yes or not selected in reports. Used alias names to make sure existing reports do not break.
  join: patient_gpi_pdc {
    from: patient_pdc_summary_flatten
    view_label: "Patient PDC"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_gpi_pdc.chain_id} AND ${patient.rx_com_id} = ${patient_gpi_pdc.rx_com_id} AND (CASE WHEN {% parameter patient_gpi_pdc.latest_snapshot_filter %} = 'Yes' THEN ${patient_gpi_pdc.snapshot_date} = ${patient_gpi_pdc.latest_snapshot_date} ELSE 1 = 1 END)  ;;
    relationship: one_to_many
  }

  join: gpi_medical_condition_cross_ref {
    from: pdc_group
    view_label: "Patient PDC"
    type: left_outer
    fields: [medical_condition]
    sql_on: ${gpi_medical_condition_cross_ref.pdc_group_id} = ${patient_gpi_pdc.pdc_group_id} ;;
    relationship: many_to_one
  }

  join: bi_version_information {
    view_label: "Patient PDC Version"
    type: left_outer
    sql_on: ${patient_gpi_pdc.bi_version_id} = ${bi_version_information.bi_version_id} ;;
    relationship: many_to_one
  }
  #[ERXDWPS-7476][ERXDWPS-7987] - End

  #[ERXLPS-2329] - Ingtegration of Store Patient to Patient Central.
  join: eps_patient {
    view_label: "Patient - Store"
    type: left_outer
    #[ERXDWPS-1530][ERXDWPS-1532][ERXDWPS-5124] Removed source_system_id = 4 condition. Had a discussion with Kumaran and we need to expose EPS and Classic Patient info in Patient - Central explore.
    sql_on: ${patient.chain_id} = ${eps_patient.chain_id} AND ${patient.rx_com_id} = ${eps_patient.rx_com_id} ;;
    relationship: one_to_many
  }

  join: eps_patient_store {
    from: store
    view_label: "Patient - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${eps_patient_store.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: eps_patient_address_link {
    view_label: "Patient Address - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${eps_patient_address_link.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_address_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${eps_patient_address_link.patient_id}) AND ${eps_patient.source_system_id} = ${eps_patient_address_link.source_system_id} ;; #[ERXDWPS-5137]
    relationship: one_to_many
  }

  join: store_patient_address {
    view_label: "Patient Address - Store"
    type: left_outer
    sql_on: ${eps_patient_address_link.chain_id} = ${store_patient_address.chain_id} AND ${eps_patient_address_link.nhin_store_id} = ${store_patient_address.nhin_store_id} AND ${eps_patient_address_link.address_id} = ${store_patient_address.address_id} AND ${eps_patient_address_link.source_system_id} = ${store_patient_address.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_home_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_home_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_home_phone.nhin_store_id} AND ${store_patient_address.address_home_phone_id} = ${store_patient_home_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_home_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_work_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_work_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_work_phone.nhin_store_id} AND ${store_patient_address.address_work_phone_id} = ${store_patient_work_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_work_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_mobile_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${store_patient_mobile_phone.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_mobile_phone.nhin_store_id} AND ${eps_patient.patient_mobile_phone_id} = ${store_patient_mobile_phone.phone_id} AND ${eps_patient.source_system_id} = ${store_patient_mobile_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_zip_code {
    type: left_outer
    view_label: "Patient Address - Store"
    sql_on: ${store_patient_address.address_postal_code} = ${store_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: store_patient_disease {
    view_label: "Patient Disease - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_disease.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_disease.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_disease.patient_id} ;;
    relationship: one_to_many
  }

  join: store_patient_icd9 {
    from: store_icd9
    view_label: "Patient Disease - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_disease.chain_id} = ${store_patient_icd9.chain_id}
        AND ${store_patient_disease.nhin_store_id} = ${store_patient_icd9.nhin_store_id}
        AND ${store_patient_disease.store_patient_disease_icd9} = ${store_patient_icd9.store_icd9_code}
        AND ${store_patient_disease.store_patient_disease_icd9_type_reference} = ${store_patient_icd9.store_icd9_prefix_reference};;
    relationship: many_to_one
  }

  join: store_patient_email {
    view_label: "Patient Email - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_email.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_email.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_email.patient_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-2383] - Store Patient Card, PLAN and Diagnosis Details
  join: store_patient_tp_link {
    from: eps_tp_link
    view_label: "Patient Card - Store"
    fields: [sales_patient_tp_link_candidate_list*]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_tp_link.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_tp_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${store_patient_tp_link.patient_id}) AND ${eps_patient.source_system_id} = ${store_patient_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: one_to_many
  }

  join: store_patient_card {
    from: eps_card
    fields: [store_patient_card_candidate_list*]
    #fields: [-ALL_FIELDS*]
    view_label: "Patient Card - Store"
    type: left_outer
    sql_on: ${store_patient_tp_link.chain_id} = ${store_patient_card.chain_id} AND ${store_patient_tp_link.nhin_store_id} = ${store_patient_card.nhin_store_id} AND ${store_patient_tp_link.card_id} = ${store_patient_card.card_id} AND ${store_patient_tp_link.source_system_id} = ${store_patient_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: store_patient_plan {
    from: eps_plan
    fields: [explore_patient_plan_candidate_list*]
    view_label: "Patient Card Plan Detail - Store"
    type: left_outer
    sql_on: ${store_patient_card.chain_id} = ${store_patient_plan.chain_id} AND ${store_patient_card.nhin_store_id} = ${store_patient_plan.nhin_store_id} AND ${store_patient_card.plan_id} = ${store_patient_plan.plan_id} AND ${store_patient_card.source_system_id} = ${store_patient_plan.source_system_id} ;;  #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_plan_phone {
    from: eps_phone
    fields: [-ALL_FIELDS*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${store_patient_plan.chain_id} = ${eps_plan_phone.chain_id} AND ${store_patient_plan.nhin_store_id} = ${eps_plan_phone.nhin_store_id} AND to_char(${store_patient_plan.store_plan_phone_id}) = to_char(${eps_plan_phone.phone_id}) AND ${store_patient_plan.source_system_id} = ${eps_plan_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_patient_plan_candidate_list*]
    view_label: "Patient Card Plan Detail - Store"
    type: left_outer
    sql_on: ${store_patient_plan.chain_id} = ${store_patient_plan_transmit.chain_id} AND ${store_patient_plan.nhin_store_id} = ${store_patient_plan_transmit.nhin_store_id} AND ${store_patient_plan.plan_id} = ${store_patient_plan_transmit.plan_id} AND ${store_patient_plan.source_system_id} = ${store_patient_plan_transmit.source_system_id} AND ${store_patient_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: one_to_one #[ERXLPS-2383] - Updated the relationship to one_to_one.
  }

  join: store_patient_diagnosis {
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_diagnosis.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_diagnosis.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_diagnosis.patient_id} ;; #[ERXDWPS-5137] Removed to_char from eps_patient.patient_id.
    relationship: one_to_many
  }

  join: store_patient_icd10 {
    from: store_icd10
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_diagnosis.chain_id} = ${store_patient_icd10.chain_id}
        AND ${store_patient_diagnosis.nhin_store_id} = ${store_patient_icd10.nhin_store_id}
        AND ${store_patient_diagnosis.store_patient_diagnosis_icd10_code} = ${store_patient_icd10.store_icd10_code} ;;
    relationship: many_to_one
  }
}

#ERXDWPS-5133 - Looker - Create Patient - Store Explore with STORE PATIENT as the driver
explore: eps_patient_base {
  extension: required
  label: "Patient - Store"
  view_name: eps_patient
  view_label: "Patient - Store"
  fields: [ALL_FIELDS*,
    -patient.chain_id,
    -patient.updated_by_nhin_store_id,
    -patient.created_by_nhin_store_id,
    -prescriber.prescriber_id,
    -patient.rx_com_id_deidentified, #ERXLPS-1162
    -eps_patient.store_patient_count, #[ERXLPS-2329] - Excluding measures from eps_patient in Cetral Patient explore due to join made with non PK columns.
    -eps_patient.rx_com_id_deidentified #[ERXLPS-2329]
  ]
  description: "Displays information pertaining to store patients."

  join: chain {
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${eps_patient.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${eps_patient.chain_id} = ${store.chain_id}  AND ${eps_patient.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${eps_patient.chain_id} AND ${patient.rx_com_id} = ${eps_patient.rx_com_id} AND ${patient.survivor_id} IS NULL AND ${patient.unmerged_date} IS NULL;; #[ERXDWPS-5133] moved patient merge related conditions from sql_always_where to this join.
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N' AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: patient_phone {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_phone.chain_id} AND ${patient.rx_com_id} = ${patient_phone.rx_com_id} AND ${patient_phone.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_email {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_email.chain_id} AND ${patient.rx_com_id} = ${patient_email.rx_com_id} AND ${patient_email.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_mtm_eligibility {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_mtm_eligibility.chain_id} AND ${patient.rx_com_id} = ${patient_mtm_eligibility.rx_com_id} ;;
    relationship: one_to_many
  }

  join: patient_allergy {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_allergy.chain_id} AND ${patient.rx_com_id} = ${patient_allergy.rx_com_id} AND ${patient_allergy.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_disease {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_disease.chain_id} AND ${patient.rx_com_id} = ${patient_disease.rx_com_id} AND ${patient_disease.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_medical_condition {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_medical_condition.chain_id} AND ${patient.rx_com_id} = ${patient_medical_condition.rx_com_id} AND ${patient_medical_condition.deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-7476][ERXDWPS-7987] - New PDC US joins. Added condition to filter only latest snapshot date when latest_snapshot_filter is selected as Yes or not selected in reports. Used alias names to make sure existing reports do not break.
  join: patient_gpi_pdc {
    from: patient_pdc_summary_flatten
    view_label: "Patient PDC"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_gpi_pdc.chain_id} AND ${patient.rx_com_id} = ${patient_gpi_pdc.rx_com_id} AND (CASE WHEN {% parameter patient_gpi_pdc.latest_snapshot_filter %} = 'Yes' THEN ${patient_gpi_pdc.snapshot_date} = ${patient_gpi_pdc.latest_snapshot_date} ELSE 1 = 1 END)  ;;
    relationship: one_to_many
  }

  join: gpi_medical_condition_cross_ref {
    from: pdc_group
    view_label: "Patient PDC"
    type: left_outer
    fields: [medical_condition]
    sql_on: ${gpi_medical_condition_cross_ref.pdc_group_id} = ${patient_gpi_pdc.pdc_group_id} ;;
    relationship: many_to_one
  }

  join: bi_version_information {
    view_label: "Patient PDC Version"
    type: left_outer
    sql_on: ${patient_gpi_pdc.bi_version_id} = ${bi_version_information.bi_version_id} ;;
    relationship: many_to_one
  }
  #[ERXDWPS-7476][ERXDWPS-7987] - End

  join: eps_patient_store {
    from: store
    view_label: "Patient - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${eps_patient_store.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_store.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: eps_patient_address_link {
    view_label: "Patient Address - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${eps_patient_address_link.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_address_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${eps_patient_address_link.patient_id}) AND ${eps_patient.source_system_id} = ${eps_patient_address_link.source_system_id} ;; #[ERXDWPS-5137]
    relationship: one_to_many
  }

  join: store_patient_address {
    view_label: "Patient Address - Store"
    type: left_outer
    sql_on: ${eps_patient_address_link.chain_id} = ${store_patient_address.chain_id} AND ${eps_patient_address_link.nhin_store_id} = ${store_patient_address.nhin_store_id} AND ${eps_patient_address_link.address_id} = ${store_patient_address.address_id} AND ${eps_patient_address_link.source_system_id} = ${store_patient_address.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_home_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_home_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_home_phone.nhin_store_id} AND ${store_patient_address.address_home_phone_id} = ${store_patient_home_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_home_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_work_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_work_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_work_phone.nhin_store_id} AND ${store_patient_address.address_work_phone_id} = ${store_patient_work_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_work_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_mobile_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${store_patient_mobile_phone.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_mobile_phone.nhin_store_id} AND ${eps_patient.patient_mobile_phone_id} = ${store_patient_mobile_phone.phone_id} AND ${eps_patient.source_system_id} = ${store_patient_mobile_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_zip_code {
    type: left_outer
    view_label: "Patient Address - Store"
    sql_on: ${store_patient_address.address_postal_code} = ${store_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: store_patient_disease {
    view_label: "Patient Disease - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_disease.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_disease.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_disease.patient_id} ;;
    relationship: one_to_many
  }

  join: store_patient_icd9 {
    from: store_icd9
    view_label: "Patient Disease - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_disease.chain_id} = ${store_patient_icd9.chain_id}
        AND ${store_patient_disease.nhin_store_id} = ${store_patient_icd9.nhin_store_id}
        AND ${store_patient_disease.store_patient_disease_icd9} = ${store_patient_icd9.store_icd9_code}
        AND ${store_patient_disease.store_patient_disease_icd9_type_reference} = ${store_patient_icd9.store_icd9_prefix_reference};;
    relationship: many_to_one
  }

  join: store_patient_email {
    view_label: "Patient Email - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_email.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_email.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_email.patient_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-2383] - Store Patient Card, PLAN and Diagnosis Details
  join: store_patient_tp_link {
    from: eps_tp_link
    view_label: "Patient Card - Store"
    fields: [sales_patient_tp_link_candidate_list*]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_tp_link.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_tp_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${store_patient_tp_link.patient_id}) AND ${eps_patient.source_system_id} = ${store_patient_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: one_to_many
  }

  join: store_patient_card {
    from: eps_card
    fields: [store_patient_card_candidate_list*]
    #fields: [-ALL_FIELDS*]
    view_label: "Patient Card - Store"
    type: left_outer
    sql_on: ${store_patient_tp_link.chain_id} = ${store_patient_card.chain_id} AND ${store_patient_tp_link.nhin_store_id} = ${store_patient_card.nhin_store_id} AND ${store_patient_tp_link.card_id} = ${store_patient_card.card_id} AND ${store_patient_tp_link.source_system_id} = ${store_patient_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: store_patient_plan {
    from: eps_plan
    fields: [explore_patient_plan_candidate_list*]
    view_label: "Patient Card Plan Detail - Store"
    type: left_outer
    sql_on: ${store_patient_card.chain_id} = ${store_patient_plan.chain_id} AND ${store_patient_card.nhin_store_id} = ${store_patient_plan.nhin_store_id} AND ${store_patient_card.plan_id} = ${store_patient_plan.plan_id} AND ${store_patient_card.source_system_id} = ${store_patient_plan.source_system_id} ;;  #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_plan_phone {
    from: eps_phone
    fields: [-ALL_FIELDS*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${store_patient_plan.chain_id} = ${eps_plan_phone.chain_id} AND ${store_patient_plan.nhin_store_id} = ${eps_plan_phone.nhin_store_id} AND to_char(${store_patient_plan.store_plan_phone_id}) = to_char(${eps_plan_phone.phone_id}) AND ${store_patient_plan.source_system_id} = ${eps_plan_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_patient_plan_candidate_list*]
    view_label: "Patient Card Plan Detail - Store"
    type: left_outer
    sql_on: ${store_patient_plan.chain_id} = ${store_patient_plan_transmit.chain_id} AND ${store_patient_plan.nhin_store_id} = ${store_patient_plan_transmit.nhin_store_id} AND ${store_patient_plan.plan_id} = ${store_patient_plan_transmit.plan_id} AND ${store_patient_plan.source_system_id} = ${store_patient_plan_transmit.source_system_id} AND ${store_patient_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: one_to_one #[ERXLPS-2383] - Updated the relationship to one_to_one.
  }

  join: store_patient_diagnosis {
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_diagnosis.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_diagnosis.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_diagnosis.patient_id} ;; #[ERXDWPS-5137] Removed to_char from eps_patient.patient_id.
    relationship: one_to_many
  }

  join: store_patient_icd10 {
    from: store_icd10
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_diagnosis.chain_id} = ${store_patient_icd10.chain_id}
        AND ${store_patient_diagnosis.nhin_store_id} = ${store_patient_icd10.nhin_store_id}
        AND ${store_patient_diagnosis.store_patient_diagnosis_icd10_code} = ${store_patient_icd10.store_icd10_code} ;;
    relationship: many_to_one
  }
}

explore: rx_tx_base {
  extension: required
  label: "Prescription Transaction"
  view_label: "Prescription Transaction"

  always_filter: {
    filters: {
      field: sold_date_filter
      value: ""
    }

    filters: {
      field: filled_date_filter
      value: ""
    }

    filters: {
      field: reportable_sales_date_filter
      value: ""
    }

    filters: {
      field: this_year_last_year_filter
      value: "No"
    }
  }

  description: "Displays information pertaining to each dispensing of a prescription. Includes on active fill transactions"

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
    sql_on: ${rx_tx.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${rx_tx.chain_id} = ${store.chain_id} AND ${rx_tx.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [rx_com_id, patient_age, patient_age_tier, patient_birth_date, patient_count]
    type: inner
    sql_on: ${rx_tx.chain_id} = ${patient.chain_id} AND ${rx_tx.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: prescriber {
    type: left_outer
    sql_on: ${rx_tx.prescriber_id} = ${prescriber.id} AND ${rx_tx.chain_id} = ${prescriber.chain_id} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} AND prescriber.prescriber_deleted = 'N' ;;
    relationship: many_to_one
  }

  join: rx_tx_cred {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_cred.chain_id} AND ${rx_tx.rx_tx_id}= ${rx_tx_cred.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_diagnosis_code {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_diagnosis_code.chain_id} AND ${rx_tx.rx_tx_id} = ${rx_tx_diagnosis_code.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_lot_number {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_lot_number.chain_id} AND ${rx_tx.rx_tx_id} = ${rx_tx_lot_number.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_package_information {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_package_information.chain_id} AND ${rx_tx.rx_tx_id} = ${rx_tx_package_information.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: tx_tp_summary {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${tx_tp_summary.chain_id} AND ${rx_tx.rx_tx_id}= ${tx_tp_summary.rx_tx_id} ;;
    relationship: one_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
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
      count,
      drug_brand_generic_other #[ERXDWPS-5467]
    ]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: rpt_cal_this_year_last_year_filled {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_filled.calendar_date} = ${rx_tx.rpt_cal_filled_date} ;;
    relationship: one_to_one
  }

  join: rpt_cal_this_year_last_year_sold {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_sold.calendar_date} = ${rx_tx.rpt_cal_sold_date} ;;
    relationship: one_to_one
  }

  join: rpt_cal_this_year_last_year_report_sales {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_report_sales.calendar_date} = ${rx_tx.rpt_cal_reportable_sales_date} ;;
    relationship: one_to_one
  }
}

#[ERXDWPS-2701] - Explore driver changed from eps_rx_tx to eps_order_entry. source_system_id = 4 check removed from sql_always_where clause and added at eps_rx_tx view join.
#[ERXDWPS-2701] - Mandatory filter on eps_rx_tx.rx_tx_fill_location is not removed. With default of any value. The view will not be added in final SQL until the filter value changed to something.
#[ERXDWPS-2701] - Snowflake not executing the SQL the way how the joins are performed in explore. This is a SF issue and SF#38334 created to work on it. Until the issue fixes the following work arounds are applied.
#[ERXDWPS-2701] - chain_id access filter applied for eps_line_item and eps_rx_tx view joins. This will ensure table scans are performed only for the chains applied in filter/user attribute values.
explore: eps_workflow_order_entry_rx_tx_base {
  extension: required
  label: "Workflow/Task History & Order Entry"
  view_label: "Order Entry"
  view_name: eps_order_entry

  fields: [
    ALL_FIELDS*,
    -eps_task_history.count_demo_user_employee_number,
    -eps_task_history.task_history_demo_user_login,
    -eps_task_history.task_history_demo_user_employee_number,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -eps_rx_tx.explore_sales_specific_candidate_list*, #[ERXLPS-910]
    -store_drug.store_drug_price_code, #[ERXLPS-946] - price_code added only to sales and inventory explore.
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -eps_rx_tx.sum_acquisition_cost, #[ERXLPS-1283]
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -store_user_license.bi_demo_store_user_license_number, #[ERXLPS-2078]
    -eps_task_history.avg_task_time, #[ERXDWPS-5833]
    -eps_task_history.task_history_task_start_time, #[ERXDWPS-5833]
    -store_user_license_type.bi_demo_count, #[ERXDWPS-6425]
    #[ERXDWPS-6802]
    -eps_order_entry.rpt_cal_central_fill_completed_date,
    -eps_order_entry.date_to_use_filter,
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales,
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes*,
    -eps_order_entry.exploredx_eps_order_entry_analysis_cal_timeframes*,
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]
  description: "Displays information of every action performed for each workflow record, pertaining to each dispensing of a prescription along with Order Entry and its associated line item information. This explore is primarily used for Operational Reporting Purposes"

  always_filter: {
    #[ERX-3514] added to calculate gap time measures
    filters: {
      field: eps_rx_tx.rx_tx_fill_location
      value: ""
    }

    #[ERX-6185] uncomment the following to enable the filter
    #filters: {
    #  field: eps_rx_tx.active_archive_filter
    #  value: "Active Tables (Past 48 Complete Months Data)"
    #}

  }

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${store.chain_id} AND ${eps_order_entry.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  #[ERXDWPS-2701] - Updated WF Explore Driver to Order entry. Modified join conditions to eps_line_item and eps_rx_tx view joins.
  #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_line_item.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
  join: eps_line_item {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_order_entry.chain_id} = ${eps_line_item.chain_id} AND ${eps_order_entry.nhin_store_id} = ${eps_line_item.nhin_store_id} AND ${eps_order_entry.order_entry_id} = ${eps_line_item.order_entry_id} AND {% condition chain.chain_id %} ${eps_line_item.chain_id} {% endcondition %};;
    relationship: one_to_many
  }

  #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_rx_tx.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_line_item.chain_id} = ${eps_rx_tx.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_rx_tx.rx_tx_id} AND ${eps_rx_tx.source_system_id} = 4 AND {% condition chain.chain_id %} ${eps_rx_tx.chain_id} {% endcondition %} ;;
    relationship: one_to_one
  }

  join: eps_rx {
    fields: [explore_Workflow_taskhistory_candidate_list*] #[ERXLPS-1922]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  #[ERXLPS-1073]
  join: epr_rx_tx {
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  #[ERXLPS-6216] - joined pickup_type to workflow explore.
  join: store_pickup_type {
    view_label: "Order Entry"
    type: left_outer
    sql_on: ${eps_order_entry.chain_id} = ${store_pickup_type.chain_id} AND ${eps_order_entry.nhin_store_id} = ${store_pickup_type.nhin_store_id} AND ${eps_order_entry.order_entry_pickup_type_id_reference} = ${store_pickup_type.pickup_type_code} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-2701] - Changed join of eps_task_history_gap_time_per_transaction to use eps_line_item and added conditional filter against chain id. Update relationship to one_to_many (one line_item have multiple entries in task_history table).
  join: eps_task_history {
    view_label: "Task History"
    type: inner
    sql_on: ${eps_line_item.chain_id} = ${eps_task_history.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_task_history.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_task_history.line_item_id} AND {% condition chain.chain_id %} ${eps_task_history.chain_id} {% endcondition %} ;;
    relationship: one_to_many
  }

  join: eps_task_history_task_time {
    view_label: "Task History"
    type: inner
    sql_on: ${eps_task_history.chain_id} = ${eps_task_history_task_time.chain_id} AND ${eps_task_history.nhin_store_id} = ${eps_task_history_task_time.nhin_store_id} AND ${eps_task_history.task_history_id} = ${eps_task_history_task_time.task_history_id} ;;
    relationship: one_to_one
  }

  join: eps_task_history_rx_start_time {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_task_history_rx_start_time.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_task_history_rx_start_time.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_task_history_rx_start_time.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_task_history_rx_start_time.rx_tx_refill_number} ;;
    relationship: many_to_one
  }
  #[ERX-3514] added to calculate gap time measures
  #[ERXDWPS-2701] - Changed join of eps_task_history_gap_time_per_transaction to use eps_line_item.
  join: eps_task_history_gap_time_per_transaction {
    view_label: "Task History - Gap Time"
    type: left_outer
    sql_on: ${eps_line_item.chain_id} = ${eps_task_history_gap_time_per_transaction.chain_id} AND ${eps_line_item.nhin_store_id} = ${eps_task_history_gap_time_per_transaction.nhin_store_id} AND ${eps_line_item.line_item_id} = ${eps_task_history_gap_time_per_transaction.rx_tx_id} ;;
    relationship: one_to_one
  }

  #[ERX-3514] added to calculate gap time measures
  join: eps_task_history_gap_time_per_refill {
    view_label: "Task History - Gap Time"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_task_history_gap_time_per_refill.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_task_history_gap_time_per_refill.nhin_store_id}  AND ${eps_rx_tx.rx_id} = ${eps_task_history_gap_time_per_refill.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_task_history_gap_time_per_refill.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1073] - join with derived to view for script to skin requirement
  join: eps_rx_refill_received_to_will_call {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx_refill_received_to_will_call.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx_refill_received_to_will_call.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx_refill_received_to_will_call.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_rx_refill_received_to_will_call.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  #[ERX-3485] : added as a part of 4.13 for reject reason and reject reason cause
  #[ERXDWPS-2701] - Changed join of store_reject_reason to use eps_line_item.
  join:  store_reject_reason {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_line_item.chain_id} = ${store_reject_reason.chain_id} AND ${eps_line_item.nhin_store_id}= ${store_reject_reason.nhin_store_id} AND ${eps_line_item.line_item_id} = ${store_reject_reason.rx_tx_id}  ;;
    relationship: one_to_many
  }

  join:  store_reject_reason_cause {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${store_reject_reason.chain_id} = ${store_reject_reason_cause.chain_id} AND ${store_reject_reason.nhin_store_id}= ${store_reject_reason_cause.nhin_store_id} AND ${store_reject_reason.reject_reason_id} = ${store_reject_reason_cause.reject_reason_id}  ;;
    relationship: one_to_many
  }

  #Joined to eps_task_history view file as the explore is based out of Task History. This will ensure all the workflow states information pertaining to task history are covered.
  join: eps_workflow_state {
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${eps_workflow_state.chain_id} AND ${eps_task_history.nhin_store_id} = ${eps_workflow_state.nhin_store_id} AND ${eps_task_history.task_history_task_name} = ${eps_workflow_state.workflow_state_name} ;;
    relationship: many_to_one
    fields: [workflow_state_candidate_list*]
  }

  #[ERXDWPS-5990] - Exposing all columns from WF Token. Added liquid variable to dynamically choose workflow_token_deleted = N condition when user do not pull Workflow Token Deleted dimension into report.
  #[ERXDWPS-5990] - This logic is required to avoid impact on existing customer reports. Due to this dynamic join, all the existing reports will still pull current state information.
  #[ERXDWPS-5990] - Updated relation from one_to_one to one_to_many
  #[ERXDWPS-2701] - Changed join of eps_workflow_token to use eps_line_item.
  join: eps_workflow_token {
    view_label: "Workflow"
    type: left_outer
    fields: [explore_dx_workflow_token_candidate_list*]
    sql_on: ${eps_line_item.chain_id} = ${eps_workflow_token.chain_id}
            AND ${eps_line_item.nhin_store_id} = ${eps_workflow_token.nhin_store_id}
            AND ${eps_line_item.line_item_id} = ${eps_workflow_token.line_item_id}
            AND {% if eps_workflow_token.workflow_token_deleted._in_query %}
                1 = 1
                {% else %}
                ${eps_workflow_token.workflow_token_deleted_reference} = 'N'
                {% endif %} ;;
    relationship: one_to_many
  }

  join: eps_workflow_current_state {
    from: eps_workflow_state
    view_label: "Workflow"
    type: left_outer
    sql_on: ${eps_workflow_token.chain_id} = ${eps_workflow_current_state.chain_id} AND ${eps_workflow_token.nhin_store_id} = ${eps_workflow_current_state.nhin_store_id} AND ${eps_workflow_token.workflow_state_id} = ${eps_workflow_current_state.workflow_state_id} ;;
    relationship: many_to_one
    fields: [workflow_current_state_name]
  }

  #[ERXDWPS-2701] - Changed join of store_rx_tx_barcode_scan_current_state to use eps_line_item.
  join: store_rx_tx_barcode_scan_current_state {
    from: store_rx_tx_barcode_scan_history
    view_label: "Barcode Scan"
    type: left_outer
    sql_on: ${eps_line_item.chain_id} = ${store_rx_tx_barcode_scan_current_state.chain_id} AND ${eps_line_item.nhin_store_id} = ${store_rx_tx_barcode_scan_current_state.nhin_store_id} AND ${eps_line_item.line_item_id} = ${store_rx_tx_barcode_scan_current_state.rx_tx_id} AND ${store_rx_tx_barcode_scan_current_state.barcode_scan_rnk} = 1 ;;
    relationship: one_to_one
    fields: [barcode_scan_current_list*]
  }

  #[ERXDWPS-2701] - Changed join of store_rx_tx_barcode_scan_history to use eps_line_item.
  join: store_rx_tx_barcode_scan_history {
    view_label: "Barcode Scan"
    type: left_outer
    sql_on: ${eps_line_item.chain_id} = ${store_rx_tx_barcode_scan_history.chain_id} AND ${eps_line_item.nhin_store_id} = ${store_rx_tx_barcode_scan_history.nhin_store_id} AND ${eps_line_item.line_item_id} = ${store_rx_tx_barcode_scan_history.rx_tx_id} ;;
    relationship: one_to_many
    fields: [barcode_scan_history_list*]
  }

  join: eps_shipment {
    view_label: "Shipment"
    type: left_outer
    sql_on: ${eps_shipment.chain_id} = ${eps_rx_tx.chain_id} AND ${eps_shipment.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${eps_shipment.shipment_id} = ${eps_rx_tx.rx_tx_shipment_id} ;;
    relationship: many_to_one
  }

  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

#ERXLPS-1430 - Add Patient dimensions to Workflow Explore
  join: eps_patient {
    view_label: "Patient - Store"
    fields: [-ALL_FIELDS*]
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_patient.chain_id} AND ${eps_rx.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${eps_rx.rx_patient_id} = ${eps_patient.patient_id} AND ${eps_patient.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: patient {
    #fields: [-patient.rx_com_id_deidentified]
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  #[ERXLPS-6387]
  join: patient_phone {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_phone.chain_id} AND ${patient.rx_com_id} = ${patient_phone.rx_com_id} AND ${patient_phone.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_email {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_email.chain_id} AND ${patient.rx_com_id} = ${patient_email.rx_com_id} AND ${patient_email.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_mtm_eligibility {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_mtm_eligibility.chain_id} AND ${patient.rx_com_id} = ${patient_mtm_eligibility.rx_com_id} ;;
    relationship: one_to_many
  }

  join: patient_allergy {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_allergy.chain_id} AND ${patient.rx_com_id} = ${patient_allergy.rx_com_id} AND ${patient_allergy.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_disease {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_disease.chain_id} AND ${patient.rx_com_id} = ${patient_disease.rx_com_id} AND ${patient_disease.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: patient_medical_condition {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_medical_condition.chain_id} AND ${patient.rx_com_id} = ${patient_medical_condition.rx_com_id} AND ${patient_medical_condition.deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXLPS-2266][ERXLPS-2078] - Exposed all columns other than IDs and metadata columns from USER and GROUPS
  #[ERXLPS-1845] - Added deleted check in join.
  join: store_user {
    view_label: "User"
    type: left_outer
    sql_on: ${eps_task_history.chain_id} = ${store_user.chain_id} AND ${eps_task_history.nhin_store_id} = ${store_user.nhin_store_id} AND ${eps_task_history.task_history_user_login} = ${store_user.store_user_login} AND ${store_user.source_system_id} = 4 AND ${store_user.store_user_deleted_reference} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: store_user_group {
    view_label: "User"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_user.chain_id} = ${store_user_group.chain_id} AND ${store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${store_user.user_id} = ${store_user_group.user_id} AND ${store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
    relationship: many_to_many
  }

  join: store_group {
    view_label: "User"
    type: inner
    sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
    relationship: many_to_one
  }

  join: store_user_license {
    view_label: "User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_license.chain_id} AND ${store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${store_user.user_id} = ${store_user_license.user_id} AND ${store_user.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  #ERXDWPS-5156
  join: store_user_license_type {
    view_label: "User"
    type: left_outer
    sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
    relationship: one_to_many
  }
}

explore: tx_tp_base {
  extension: required
  label: "Third Party Claim"
  view_label: "Claim"
  sql_always_where: ${tx_tp.tp_deleted} = 'N' ;;

  always_filter: {
    filters: {
      field: tx_tp_paid_status
      value: ""
    }

    filters: {
      field: rx_tx.this_year_last_year_filter
      value: "No"
    }

    #[ERXDWPS-8395] - Added mandatory filters related to this_yerar_last_year_filter.
    filters: {
      field: rx_tx.sold_date_filter
      value: ""
    }

    filters: {
      field: rx_tx.filled_date_filter
      value: ""
    }

    filters: {
      field: rx_tx.reportable_sales_date_filter
      value: ""
    }
  }

  fields: [
    ALL_FIELDS*,
    -eps_tx_tp.tx_tp_balance_due_from_tp,
    -eps_tx_tp.tx_tp_write_off_amount,
    -eps_tx_tp.tx_tp_patient_final_copay,
    -eps_tx_tp.tx_tp_submit_type,
    -eps_tx_tp.tx_tp_final_price,
    -eps_ex_tp.tx_tp_balance_due_from_tp,
    -rx_tx.tx_tp_claim_amount,
    -rx_tx.100_percent_copay,
    -prescriber.npi_number_deidentified,     #ERXLPS-1162
    -prescriber.dea_number_deidentified,     #ERXLPS-1162
    -prescriber.name_deidentified          #ERXLPS-1162
  ]
  description: "Displays information pertaining to each claim of a prescription transaction. Prescription TY/LY Analysis (Yes/No) should be used in conjunction with Prescription Sold/Filled/ReportableSales Date 'Filter Only' filter when Yes-Sold/Yes-Filled/Yes-ReportableSales are selected for analysis. Default value for Prescription TY/LY Analysis (Yes/No) is No. Default value for Prescription Sold/Filled/ReportableSales Date 'Filter Only' are any value."

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
    sql_on: ${tx_tp.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${tx_tp.chain_id} = ${store.chain_id} AND ${tx_tp.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: rx_tx {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${rx_tx.chain_id} = ${tx_tp.chain_id} AND ${rx_tx.rx_tx_id}= ${tx_tp.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [rx_com_id, patient_age, patient_age_tier, patient_count]
    type: inner
    sql_on: ${rx_tx.chain_id} = ${patient.chain_id} AND ${rx_tx.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: prescriber {
    type: left_outer
    sql_on: ${rx_tx.prescriber_id} = ${prescriber.id} AND ${rx_tx.chain_id} = ${prescriber.chain_id} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} AND prescriber.prescriber_deleted = 'N' ;;
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
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
    sql_on: ${rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: plan {
    view_label: "Claim"
    type: left_outer
    fields: [plan_type, plan_type_reference] #[ERXLPS-4396] [ERXDWPS-6658] Added drill down dimension.
    sql_on: ${tx_tp.tx_tp_carrier_code} = ${plan.carrier_code} AND NVL(${tx_tp.tx_tp_plan_code},'X') = NVL(${plan.plan_code},'X') AND ${plan.source_system_id} = 6 AND ${plan.chain_id} = 3000  ;;
    relationship: many_to_one
  }

  join: rpt_cal_this_year_last_year_filled {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_filled.calendar_date} = ${rx_tx.rpt_cal_filled_date} ;;
    relationship: one_to_one
  }

  join: rpt_cal_this_year_last_year_sold {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_sold.calendar_date} = ${rx_tx.rpt_cal_sold_date} ;;
    relationship: one_to_one
  }

  join: rpt_cal_this_year_last_year_report_sales {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_report_sales.calendar_date} = ${rx_tx.rpt_cal_reportable_sales_date} ;;
    relationship: one_to_one
  }
}

explore: mds_program_base {
  extension: required
  label: "Programs & Documents"
  view_label: "Program"

  join: mds_document {
    view_label: "Document"
    type: left_outer
    sql_on: ${mds_program.program_code} = ${mds_document.program_code} AND ${mds_document.document_deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-8402][ERXDWPS-1677]
  join: mds_sponsor {
    view_label: "Program"
    type: inner
    sql_on: ${mds_program.sponsor_id} = ${mds_sponsor.sponsor_id} AND ${mds_sponsor.sponsor_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8526] - Removed fields: [vendor_name] restriction.
  join: vendor {
    view_label: "Program"
    type: inner
    sql_on: ${mds_sponsor.vendor_id} = ${vendor.vendor_id} AND ${vendor.vendor_source_system_id} = 7 ;; #[ERXDWPS-8402][ERXDWPS-1677]
    relationship: many_to_one
  }
}

explore: mds_transaction_base {
  extension: required
  label: "Prescription Transaction - Interventions & Dispensing"
  view_label: "Rx Tx Interventions"

  always_filter: {
    filters: {
      field: transaction_request_date
      value: "last 30 days"
    }

    filters: {
      field: mds_print_transaction.print_transaction_print_flag
      value: "Y"
    }
  }

  fields: [
    ALL_FIELDS*,
    -rx_tx.chain_id,
    -rx_tx.nhin_store_id,
    -rx_tx.store_rx_tx_fill_count,
    -rx_tx.will_call_picked_up_date_info*,
    -rx_tx.rx_tx_order_class,
    -rx_tx.rx_tx_order_type,
    -rx_tx.rx_tx_program_add,
    -rx_tx.rx_tx_specialty,
    -rx_tx.rx_tx_route_of_administration,
    -rx_tx.rx_tx_site_of_administration,
    "-rx_tx.rx_tx_print_drug_name -rx_tx_cred.tx_cred_user_initials",
    -rx_tx.rx_number,
    -rx_tx.group_code,
    -rx_tx.other_nhin_store_id,
    -rx_tx.pv_initials,
    -rx_tx.rph_counselling_initials,
    -rx_tx.tech_initials,
    -rx_tx.initials,
    -rx_tx.order_initials,
    -rx_tx.pv_initials,
    -rx_tx.rx_tx_print_drug_name,
    -rx_tx.new_rx_number,
    -rx_tx.old_rx_number,
    -rx_tx.cancel_reason,
    -rx_tx.tx_message,
    -rx_tx.tx_tp_claim_amount,
    -rx_tx.100_percent_copay,
    -rx_tx.rx_tx_fill_quantity,
    -rx_tx.rx_tx_price,
    -rx_tx.rx_tx_uc_price,
    -rx_tx.exploredx_ty_ly_specific_entities_list* #[ERXDWPS-8395]
  ]
  description: "Displays information pertaining to each intervention of a prescription. Includes information pertaining to Print Edits and Print On Demand requests."

  join: chain {
    view_label: "Pharmacy"
    fields: [chain_id, chain_name, chain_deactivated_date, chain_open_or_closed, chain_category]
    type: inner
    sql_on: ${mds_transaction.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${mds_transaction.chain_id} = ${store.chain_id} AND ${mds_transaction.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }


  join: mds_store {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${mds_store.chain_id} and ${store.nhin_store_id} = ${mds_store.nhin_store_id} and ${mds_store.source_system_id} = 7 ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: mds_print_transaction {
    view_label: "Rx Tx Interventions"
    type: inner
    sql_on: ${mds_transaction.transaction_id} = ${mds_print_transaction.transaction_id} ;;
    relationship: many_to_one
  }

  join: mds_print_transaction_duplicate_count {
    view_label: "Rx Tx Interventions"
    type: left_outer
    sql_on: ${mds_print_transaction.print_transaction_id} = ${mds_print_transaction_duplicate_count.print_transaction_distinct_id} ;;
    relationship: one_to_one
  }

  join: mds_program {
    view_label: "Program"
    type: inner
    sql_on: ${mds_print_transaction.program_code} = ${mds_program.program_code} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8402][ERXDWPS-1677]
  join: mds_sponsor {
    view_label: "Program"
    type: inner
    sql_on: ${mds_program.sponsor_id} = ${mds_sponsor.sponsor_id} AND ${mds_sponsor.sponsor_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8526] - Removed fields: [vendor_name] restriction.
  join: vendor {
    view_label: "Program"
    type: inner
    sql_on: ${mds_sponsor.vendor_id} = ${vendor.vendor_id} AND ${vendor.vendor_source_system_id} = 7 ;; #[ERXDWPS-8402][ERXDWPS-1677]
    relationship: many_to_one
  }

  join: mds_document {
    view_label: "Document"
    type: inner
    sql_on: ${mds_print_transaction.document_identifier} = ${mds_document.document_identifier} AND ${mds_print_transaction.program_code} = ${mds_document.program_code} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Rx Tx Interventions"
    type: left_outer
    sql_on: ${mds_transaction.transaction_patient_postal_code} = ${us_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: rx_tx {
    view_label: "Rx Tx Dispensing"
    type: left_outer
    sql_on: ${mds_transaction.chain_id} = ${rx_tx.chain_id} AND ${mds_transaction.rx_number} = ${rx_tx.rx_number} AND ${mds_transaction.tx_number}= ${rx_tx.tx_number} AND ${rx_tx.rx_deleted} = 'N' AND ${rx_tx.tx_deleted}  = 'N' AND ${rx_tx.tx_number} IS NOT NULL ;; #[ERXLPS-1285] chain_id condition added.
    relationship: many_to_one
  }

  #[ERXDWPS-8195] - drug join added to get rx_tx view dispensed drug info. drug_multi_source indicator is used rx_tc view file measures. Not exposing any drug info from this join.
  join: drug {
    view_label: "NHIN Drug"
    fields: [-ALL_FIELDS*]
    type: left_outer
    sql_on: ${rx_tx.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  ## [ERXLPS-1757] Add TX TP to MDS dispensing exploe to have BIN and PCN from the TX TP view
  join: tx_tp {
    view_label: "Claim"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${tx_tp.chain_id} AND ${rx_tx.rx_tx_id} = ${tx_tp.rx_tx_id}  ;;
    relationship: one_to_many
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [-ALL_FIELDS*]
    type: inner
    sql_on: ${rx_tx.chain_id} = ${patient.chain_id} AND ${rx_tx.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_cred {
    view_label: "Rx Tx Dispensing"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_cred.chain_id} AND ${rx_tx.rx_tx_id}= ${rx_tx_cred.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_diagnosis_code {
    view_label: "Rx Tx Dispensing"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_diagnosis_code.chain_id} AND ${rx_tx.rx_tx_id} = ${rx_tx_diagnosis_code.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: rx_tx_lot_number {
    view_label: "Rx Tx Dispensing"
    type: left_outer
    sql_on: ${rx_tx.chain_id} = ${rx_tx_lot_number.chain_id} AND ${rx_tx.rx_tx_id} = ${rx_tx_lot_number.rx_tx_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8195] join name changed from drug to mds_drug. New join drug is added. drug join is required to get drug info related to rx_tx transaction record.
  join: mds_drug {
    from: drug
    view_label: "NHIN Drug"
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
    sql_on: ${mds_transaction.ndc} = ${mds_drug.drug_ndc} AND ${mds_drug.drug_source_system_id} = 6 AND ${mds_drug.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN GPI"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${mds_transaction.gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 AND ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_candidate_list*]
    sql_on: ${gpi.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8195] - Added liquid variable condition to filter only TY records when TY/LY Analysis filter not added.
  join: rpt_cal_this_year_last_year_filled {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_filled.calendar_date} = ${rx_tx.rpt_cal_filled_date}
        AND {% if rx_tx.this_year_last_year_filter._in_query %}
            1 = 1
            {% else %}
            ${rpt_cal_this_year_last_year_filled.type} = 'TY'
            {% endif %} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-8195] - Added liquid variable condition to filter only TY records when TY/LY Analysis filter not added.
  join: rpt_cal_this_year_last_year_sold {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_sold.calendar_date} = ${rx_tx.rpt_cal_sold_date}
        AND {% if rx_tx.this_year_last_year_filter._in_query %}
            1 = 1
            {% else %}
            ${rpt_cal_this_year_last_year_sold.type} = 'TY'
            {% endif %} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-8195] - Added liquid variable condition to filter only TY records when TY/LY Analysis filter not added.
  join: rpt_cal_this_year_last_year_report_sales {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${rpt_cal_this_year_last_year_report_sales.calendar_date} = ${rx_tx.rpt_cal_reportable_sales_date}
        AND {% if rx_tx.this_year_last_year_filter._in_query %}
            1 = 1
            {% else %}
            ${rpt_cal_this_year_last_year_report_sales.type} = 'TY'
            {% endif %} ;;
    relationship: one_to_one
  }
}

explore: drug_base {
  extension: required
  label: "Drug"
  view_name: drug
  view_label: "NHIN Drug"
  description: "Displays information pertaining to Master Drug Information from NHIN. This explore does not include any store level drug information"
  #[ERXLPS-4355] - Added always where condition to filter only NHIN information. Removed the conditions at join level.
  sql_always_where: drug.source_system_id = 6 AND drug.chain_id = 3000 ;;
  fields: [ALL_FIELDS*, #[ERXLPS-1617]
    -gpi.medical_condition, #[ERXLPS-1942]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -gpi.explore_dx_gpi_levels_candidate_list* #[ERXDWPS-1454]
  ]

  #[ERXLPS-4355] - Added chain information to NHIN Drug Explores. This will help QA/User to see the chain info for NHIN.
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
    view_label: "NHIN GPI"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-1942] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "NHIN GPI"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN GPI"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: drug_cost {
    view_label: "NHIN Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 6 ;;
    relationship: one_to_many #[ERXLPS-1311] Corrected the relationship.
  }

  join: drug_cost_type {
    view_label: "NHIN Drug Cost Type"
    type: left_outer
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 6 ;;
    relationship: many_to_one
  }

#[ERX-2874] added as a part of 4.12.000
  join: drug_short_third_party {
    view_label: "NHIN Drug Short TP"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_short_third_party.chain_id} AND ${drug.drug_ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 6 ;;
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

explore: inventory_base {
  extension: required
  label: "Inventory"
  view_label: "Pharmacy Drug"
  view_name: store_drug
  sql_always_where: ${store_drug.source_system_id} = 4 AND ${store_drug.deleted_reference} = 'N' ;; #[ERXLPS-2064]
  fields: [
    ALL_FIELDS*,
    -eps_rx_tx.on_time,
    -eps_rx_tx.is_on_time,
    -eps_rx_tx.fill_count,
    -store_drug_local_setting.sum_drug_local_setting_on_hand_demo,
    -eps_rx_tx.rx_tx_fill_quantity,
    -eps_rx_tx.rx_tx_price,
    -eps_rx_tx.rx_tx_uc_price,
    -eps_rx_tx.sum_rx_tx_fill_quantity_at_fill, #[ERXLPS-1521]
    -store_drug_cost_type.store_drug_cost_type_deidentified, -store_drug_cost_type.store_drug_cost_type_description_deidentified, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -gpi.medical_condition, #[ERXLPS-1942]
    -store_vendor.Store_vendor_name_deidentified, #[ERXLPS-1878]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*, #[ERXLPS-2064] excluding metadata dimension from inventory explore.
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -gpi.explore_rx_gpi_metadata_candidate_list*, #[ERXLPS-2114]
    -gpi.explore_dx_gpi_levels_candidate_list*,
    -store_user_license.bi_demo_store_user_license_number, #[ERXDWPS-5731]
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_line_item.exploredx_eps_line_item_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]
  description: "Displays information pertaining to Pharmacy Drug and its associated Inventory, Purchase Order, Drug Orders, Reorders, Return And Adjustment and Drug Movement information"

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${store_drug.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${store_drug.chain_id} = ${store.chain_id} AND ${store_drug.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-1925]
  join: store_drug_cost_region {
    from:  store_setting
    view_label: "Pharmacy - Drug"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_drug_cost_region.chain_id} AND  ${store.nhin_store_id} = ${store_drug_cost_region.nhin_store_id} AND UPPER(${store_drug_cost_region.store_setting_name}) = 'STOREDESCRIPTION.DRUGREGION' ;;
    relationship: one_to_one
    fields: [ ] #[ERXLPS-6333] Excluding store setting columns exposed from this join.
  }

  #[ERXLPS-1925]
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "NHIN Vs. Pharmacy Drug" #[ERXLPS-2089] Renamed Host to NHIN. DEMO and Enterprise models are comparing NHIN vs Host.
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id}  AND ${host_vs_pharmacy_comp.deleted_reference} = 'N'  AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;;
    relationship: one_to_one
  }

  join: store_drug_local_setting {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_local_setting.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_local_setting.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_local_setting.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_local_setting.deleted} = 'N' ;;
    relationship: one_to_one
  }

  #[ERXLPS-946] - join with store_price_code to get Store drug price code information
  #[ERXLPS-2089] - View name renamed to store_drug_price_code. Removed from clause from join.
  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1942] - Join added to expose therapy class information from gpi_medical_condition_cross_ref view.
  join: gpi_medical_condition_cross_ref {
    view_label: "Pharmacy Drug"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${store_drug.source_system_id} = 4 AND ${store_drug.gpi_identifier} =  ${gpi_medical_condition_cross_ref.gpi};;
    relationship: many_to_many #many gpis in store_drug match with many gpis in gpi_medical_condition_cross_ref table.
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

# [ERX-2586] : join history tables to get snapshot date inventory at the end of the day
  join: store_drug_local_setting_hist {
    view_label: "Pharmacy Drug History"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_local_setting_hist.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_local_setting_hist.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_local_setting_hist.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_local_setting_hist.deleted} = 'N' ;;
    relationship: one_to_many
  }

# [ERXLPS-2217]: updated relationship from many to many
# [ERXLPS-2216 & 2217]: Applied to_char to fix unrecognized numeric value issue
  join: eps_rx_tx_local_setting_hist {
    from: eps_rx_tx
    view_label: "Pharmacy Drug History"
    type: left_outer
    fields: [explore_rx_4_11_history_candidate_list*]
    sql_on: ${store_drug_local_setting_hist.chain_id} = ${eps_rx_tx_local_setting_hist.chain_id} AND ${store_drug_local_setting_hist.nhin_store_id}= ${eps_rx_tx_local_setting_hist.nhin_store_id} AND to_char(${store_drug_local_setting_hist.drug_id}) = ${eps_rx_tx_local_setting_hist.rx_tx_drug_id_hist} AND ${store_drug_local_setting_hist.snapshot_date} = ${eps_rx_tx_local_setting_hist.rx_tx_will_call_picked_up_date} AND ${eps_rx_tx_local_setting_hist.source_system_id} = 4 ;;
    relationship: many_to_many
  }

# [ERXLPS-1521]
# [ERXLPS-2217]: updated relationship from many to many
  join: eps_rx_tx_local_setting_hist_at_fill {
    from: eps_rx_tx
    view_label: "Pharmacy Drug History"
    type: left_outer
    fields: [explore_rx_4_11_history_at_fill_candidate_list*]
    sql_on: ${store_drug_local_setting_hist.chain_id} = ${eps_rx_tx_local_setting_hist_at_fill.chain_id}
        AND ${store_drug_local_setting_hist.nhin_store_id}= ${eps_rx_tx_local_setting_hist_at_fill.nhin_store_id}
        AND ${store_drug_local_setting_hist.drug_id} = ${eps_rx_tx_local_setting_hist_at_fill.rx_tx_drug_id_hist}
        AND ${store_drug_local_setting_hist.snapshot_date} = ${eps_rx_tx_local_setting_hist_at_fill.rx_tx_fill_date}
        AND ${eps_rx_tx_local_setting_hist_at_fill.source_system_id} = 4 ;;
    relationship: many_to_many
  }

  join: store_drug_reorder_hist {
    view_label: "Pharmacy Drug History"
    type: left_outer
    sql_on: ${store_drug_local_setting_hist.chain_id} = ${store_drug_reorder_hist.chain_id} AND ${store_drug_local_setting_hist.nhin_store_id}= ${store_drug_reorder_hist.nhin_store_id} AND ${store_drug_local_setting_hist.drug_id} = ${store_drug_reorder_hist.drug_id}  AND ${store_drug_reorder_hist.deleted} = 'N' AND ${store_drug_local_setting_hist.snapshot_date} = ${store_drug_reorder_hist.snapshot_date};;
    relationship: one_to_one
  }

  join: store_return_and_adjustment {
    view_label: "Return And Adjustment"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_return_and_adjustment.chain_id} AND ${store_drug.nhin_store_id}= ${store_return_and_adjustment.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_return_and_adjustment.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_return_and_adjustment.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_adjustment_code {
    view_label: "Return And Adjustment Codes"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_adjustment_code.chain_id} AND ${store_return_and_adjustment.nhin_store_id}= ${store_adjustment_code.nhin_store_id} AND ${store_return_and_adjustment.adjustment_code_id} = ${store_adjustment_code.adjustment_code_id} AND ${store_return_and_adjustment.deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: store_adjustment_group {
    view_label: "Return And Adjustment Group"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_adjustment_group.chain_id} AND ${store_return_and_adjustment.nhin_store_id}= ${store_adjustment_group.nhin_store_id} AND ${store_return_and_adjustment.adjustment_group_id} = ${store_adjustment_group.adjustment_group_id} AND ${store_return_and_adjustment.deleted} = 'N' AND ${store_adjustment_group.deleted} = 'N' ;;
    relationship: many_to_many
  }

  #[ERXDWPS-5731]
  join: store_user {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_return_and_adjustment.chain_id} = ${store_user.chain_id}
        AND ${store_return_and_adjustment.nhin_store_id} = ${store_user.nhin_store_id}
        AND ${store_return_and_adjustment.return_and_adjustment_employee_number} = ${store_user.store_user_employee_number}
        AND ${store_return_and_adjustment.source_system_id} = ${store_user.source_system_id} ;;
    relationship: many_to_one
  }

  join: store_user_group {
    view_label: "Return And Adjustment User"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_user.chain_id} = ${store_user_group.chain_id} AND ${store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${store_user.user_id} = ${store_user_group.user_id} AND ${store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
    relationship: many_to_many
  }

  join: store_group {
    view_label: "Return And Adjustment User"
    type: inner
    sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
    relationship: many_to_one
  }

  join: store_user_license {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_user.chain_id} = ${store_user_license.chain_id} AND ${store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${store_user.user_id} = ${store_user_license.user_id} AND ${store_user.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  join: store_user_license_type {
    view_label: "Return And Adjustment User"
    type: left_outer
    sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
    relationship: one_to_many
  }

  join: store_perpetual_inventory_tracking {
    view_label: "Perpetual Tracking"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_perpetual_inventory_tracking.chain_id} AND ${store_drug.nhin_store_id}= ${store_perpetual_inventory_tracking.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_perpetual_inventory_tracking.drug_id}) AND ${store_drug.deleted} = 'N'  ;;
    relationship: one_to_many
  }

  join: perpetual_adjustment_code {
    from: store_adjustment_code
    view_label: "Perpetual Tracking"
    type: left_outer
    sql_on: ${store_perpetual_inventory_tracking.chain_id} = ${perpetual_adjustment_code.chain_id} AND ${store_perpetual_inventory_tracking.nhin_store_id}= ${perpetual_adjustment_code.nhin_store_id} AND ${store_perpetual_inventory_tracking.adjustment_code_id} = ${perpetual_adjustment_code.adjustment_code_id}  ;;
    relationship: many_to_one
  }

  join: store_drug_reorder {
    view_label: "Pharmacy Drug Reorder"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_reorder.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_reorder.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_reorder.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_reorder.deleted} = 'N' ;;
    relationship: one_to_many
  }

# ERXLPS-1912 Change
  join: store_drug_order {
    view_label: "Pharmacy Drug Order"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_order.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_order.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_order.drug_id}) AND ${store_drug.deleted} = 'N' AND ${store_drug_order.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_purchase_order {
    view_label: "Purchase Order"
    type: left_outer
    sql_on: ${store_drug_order.chain_id} = ${store_purchase_order.chain_id} AND ${store_drug_order.nhin_store_id}= ${store_purchase_order.nhin_store_id} AND ${store_drug_order.purchase_order_id} = ${store_purchase_order.purchase_order_id} AND ${store_drug_order.deleted} = 'N' AND ${store_purchase_order.deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1878] - Store_vendor added to inventory
  join: store_vendor {
    view_label: "Purchase Order"
    type: left_outer
    sql_on: ${store_purchase_order.chain_id} = ${store_vendor.chain_id} AND ${store_purchase_order.nhin_store_id} = ${store_vendor.nhin_store_id} AND ${store_purchase_order.vendor_id} = ${store_vendor.vendor_id} ;;
    relationship: many_to_one
  }

# ERXLPS-2216 - Updated relationship from many to one, to one to many between store_drug and eps_rx_tx
  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted} = 'N' AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: one_to_many
  }

  #[ERXLPS-1922] - Added eps_rx join to inventory explore and exposing only File Buy Date
  join: eps_rx {
    fields: [rx_file_buy_date,
      rx_file_buy_date_time,
      rx_file_buy_date_date,
      rx_file_buy_date_week,
      rx_file_buy_date_month,
      rx_file_buy_date_month_num,
      rx_file_buy_date_year,
      rx_file_buy_date_quarter,
      rx_file_buy_date_quarter_of_year,
      rx_file_buy_date_hour_of_day,
      rx_file_buy_date_time_of_day,
      rx_file_buy_date_hour2,
      rx_file_buy_date_minute15,
      rx_file_buy_date_day_of_week,
      rx_file_buy_date_week_of_year,
      rx_file_buy_date_day_of_week_index,
      rx_file_buy_date_day_of_month]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_task_history_rx_start_time {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_task_history_rx_start_time.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_task_history_rx_start_time.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_task_history_rx_start_time.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_task_history_rx_start_time.rx_tx_refill_number} ;;
    relationship: many_to_one
  }

  join: eps_line_item {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${eps_rx_tx.chain_id} = ${eps_line_item.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_line_item.nhin_store_id} AND ${eps_rx_tx.rx_tx_id} = ${eps_line_item.line_item_id} ;;
    relationship: one_to_one
  }

  join: drug {
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 AND ${drug.drug_deleted_reference} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1925] - Expose drug_cost view in inventory.
  join: drug_cost {
    view_label: "NHIN Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 6 AND ${drug_cost.chain_id} = 3000 AND ${drug_cost.deleted_reference} = 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many
  }

  #[ERXLPS-2064] - Added Drug Cost Type to Inventory explore
  join: drug_cost_type {
    view_label: "NHIN Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 6 AND ${drug_cost_type.chain_id} = 3000 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join
    relationship: many_to_one
  }

  join: gpi {
    view_label: "NHIN GPI"
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN GPI"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: drug_cost_pivot {
    view_label: "NHIN Drug Cost"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${drug_cost_pivot.ndc} AND ${drug_cost_pivot.source_system_id} = 6 AND ${drug_cost_pivot.chain_id} = 3000 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  #ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker
  join: medispan_drug_cost_pivot {
    view_label: "Medi-Span Drug Cost"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${medispan_drug_cost_pivot.ndc};;
    relationship: one_to_many
  }

#[ERX-2874] added as a part of 4.12.000
  join: drug_short_third_party {
    view_label: "NHIN Drug Short TP"
    type: left_outer
    sql_on: ${store_drug.ndc} = ${drug_short_third_party.ndc} AND ${drug_short_third_party.source_system_id} = 6 AND ${drug_short_third_party.chain_id} = 3000 ;;
    relationship: many_to_many
  }

  join: store_compound {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound.chain_id} = ${store_drug.chain_id}  AND ${store_compound.nhin_store_id} = ${store_drug.nhin_store_id} AND to_char(${store_compound.compound_id}) = ${store_drug.drug_id} AND ${store_compound.compound_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' AND ${store_compound_ingredient_tx.chain_id} = ${eps_rx_tx.chain_id} AND ${store_compound_ingredient_tx.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${store_compound_ingredient_tx.rx_tx_id} = ${eps_rx_tx.rx_tx_id} ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXLPS-1927] - Added store_drug_cost, store_drug_cost_type and store_drug_pivot view joins to DEMO Model inventory explore.
  #[ERXLPS-1254] - Corrected the relationship from one_to_one to one_to_many.
  join: store_drug_cost {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_cost.chain_id} AND ${store_drug.nhin_store_id} = ${store_drug_cost.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_cost.drug_id}) AND ${store_drug_cost.store_drug_cost_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: one_to_many
  }

  #[ERXLPS-1254] - Corrected the relationship from one_to_one to many_to_one. Revised the join condition.
  join: store_drug_cost_type {
    view_label: "Pharmacy Drug Cost Type"
    type: left_outer
    sql_on: ${store_drug_cost.chain_id} = ${store_drug_cost_type.chain_id} AND ${store_drug_cost.nhin_store_id} = ${store_drug_cost_type.nhin_store_id} AND ${store_drug_cost.drug_cost_type_id} = ${store_drug_cost_type.drug_cost_type_id} ;;
    relationship: many_to_one
  }

  join: store_drug_cost_pivot {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug_cost_pivot.chain_id} = ${store_drug.chain_id} AND ${store_drug_cost_pivot.nhin_store_id}= ${store_drug.nhin_store_id} AND to_char(${store_drug_cost_pivot.drug_id}) = ${store_drug.drug_id} ;;
    relationship: one_to_one
  }
}

explore: ar_nhin_type_base {
  view_name: ar_nhin_type
  extension: required
  label: "Master Code"
  view_label: "NHIN Types"
  fields: [ALL_FIELDS*]
  description: "Displays information of the common data-type definitions and their categories used within the AR system"
}

explore: ar_claim_to_contract_rate_base {
  view_name: ar_claim_to_contract_rate
  extension: required
  label: "Contract Rate"
  fields: [ALL_FIELDS*]
  description: "Displays contract rates applicable to claims"

  join: ar_contract_rate_pricing {
    type: left_outer
    sql_on: ${ar_claim_to_contract_rate.chain_id} = ${ar_contract_rate_pricing.chain_id} and ${ar_claim_to_contract_rate.contract_rate_id} = ${ar_contract_rate_pricing.contract_rate_id} and ${ar_contract_rate_pricing.contract_rate_pricing_deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: ar_chain {
    view_label: "Chain"
    type: inner
    fields: [chain_id, chain_name, chain_open_or_closed]
    sql_on: ${ar_claim_to_contract_rate.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }
}

explore: ar_store_base {
  extension: required
  label: "Pharmacy"
  view_label: "Pharmacy"
  fields: [ALL_FIELDS*, -ar_store.chain_id]
  description: "Displays information of the customer's individual store information, operating days information, and communication information"

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_store.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8  AND ${ar_store.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 8 ;;
    relationship: one_to_one
  }
}

explore: ar_carrier_performance_base {
  extension: required
  label: "Carrier Performance"
  view_label: " "
  view_name: ar_carrier_performance
  fields: [ALL_FIELDS*, -ar_store.chain_id]
  description: "Provides insights on Carrier and the various claims processed from different pharmacies to TP"

  always_filter: {
    filters: {
      field: store_filter
      value: ""
    }

    filters: {
      field: carrier_filter
      value: ""
    }

    filters: {
      field: plan_filter
      value: ""
    }

    filters: {
      field: group_filter
      value: ""
    }

    filters: {
      field: network_filter
      value: ""
    }

    filters: {
      field: bin_filter
      value: ""
    }

    filters: {
      field: pcn_filter
      value: ""
    }

    filters: {
      field: drug_name_filter
      value: ""
    }

    filters: {
      field: drug_ndc_filter
      value: ""
    }

    filters: {
      field: drug_gpi_filter
      value: ""
    }

    filters: {
      field: days_supply_filter
      value: ""
    }

    filters: {
      field: fill_date_filter
      value: ""
    }

    filters: {
      field: paid_amount_filter
      value: "Actual Payments"
    }

    filters: {
      field: include_split_bill_filter
      value: "NO"
    }

    filters: {
      field: exclude_zero_dollar_claim_filter
      value: "NO"
    }

    filters: {
      field: exclude_credit_returns_filter
      value: "YES"
    }

    filters: {
      field: brand_generic_filter
      value: "All"
    }
  }

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_carrier_performance.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_carrier_performance.chain_id} = ${ar_store.chain_id} AND ${ar_carrier_performance.nhin_store_id} = ${ar_store.nhin_store_id} AND ${ar_store.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 8 ;;
    relationship: one_to_one
  }
}

explore: ar_network_analysis_base {
  extension: required
  label: "Network Analysis"
  view_label: " "
  view_name: ar_network_analysis
  fields: [ALL_FIELDS*, -ar_store.chain_id]
  description: "Provides insights on Carrier and the various claims processed from different pharmacies to TP"

  always_filter: {
    filters: {
      field: store_filter
      value: ""
    }

    filters: {
      field: master_contract_filter
      value: ""

    }

    filters:  {
      field: rate_network_name_filter
      value: ""
    }

    filters:  {
      field: carrier_filter
      value: ""
    }

    filters:  {
      field: plan_filter
      value: ""
    }

    filters:  {
      field: group_filter
      value: ""
    }

    filters:  {
      field: fill_date_filter
      value: ""
    }

    filters:  {
      field: paid_amount_filter
      value: "Actual Payments"
    }

    filters:  {
      field:include_split_bill_filter
      value: "NO"
    }

    filters:  {
      field: exclude_zero_dollar_claim_filter
      value: "NO"
    }

    filters:  {
      field: include_copay_amount_in_tot_amt_paid
      value: "NO"
    }

    filters:  {
      field: detail_level_filter
      value: "Summary"
    }
  }

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_network_analysis.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_network_analysis.chain_id} = ${ar_store.chain_id} AND ${ar_network_analysis.nhin_id} = ${ar_store.nhin_store_id} AND ${ar_store.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 8 ;;
    relationship: one_to_one
  }
}

explore: corporate_calendar_base {
  extension: required
  view_name: calendar_standard
  label: "Corporate Calendar"
  view_label: "Standard Calendar"
  description: "Displays information pertaining to Customer's Fiscal Calendar and relative mapping to Standard Calendar"
  fields: [ALL_FIELDS*, -chain.count]

  always_filter: {
    filters: {
      field: calendar_date
      value: "last 10 days"
    }
  }

  join: calendar_fiscal {
    view_label: "Fiscal Calendar"
    type: inner
    sql_on: ${calendar_standard.calendar_date} = ${calendar_fiscal.calendar_date} ;;
    relationship: many_to_one
  }

  join: chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${calendar_fiscal.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }
}

explore: eps_tx_tp_transmit_queue_base {
  extension: required
  label: "Third Party Transmit Queue"
  description: "Displays information pertaining to Third Party Claim transactions, the submission of the Claim, and the response by the Third Party"
  view_label: "TP Transmit Queue"
  #[ERXLPS-1845] - Added deleted check.
  sql_always_where: ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_deleted_reference} = 'N' ;;
  fields: [ALL_FIELDS*, -eps_tx_tp_transmit_queue.explore_sales_specific_candidate_list*,
    -prescriber.npi_number_deidentified,     #ERXLPS-1162
    -prescriber.dea_number_deidentified,     #ERXLPS-1162
    -prescriber.name_deidentified,
    -eps_plan.bi_demo_store_plan_plan_name           #ERXLPS-1162
  ]

  always_filter: {
    filters: {
      field: eps_tx_tp_transmit_queue.tx_tp_transmit_queue_paid_status
      value: "PAID IN FULL"
    }

    filters: {
      field: eps_tx_tp_transmit_queue.tx_tp_transmit_queue_submission_date
      value: "last 30 days"
    }
  }

  join: eps_tx_tp_response_detail {
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_response_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_response_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_response_detail.tx_tp_response_detail_id} ;;
    relationship: one_to_one
  }

  join: eps_tx_tp_response_detail_amount {
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_response_detail_amount.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_response_detail_amount.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_response_detail_amount.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_submit_detail {
    view_label: "Submit Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_submit_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_submit_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_submit_detail.tx_tp_submit_detail_id} ;;
    relationship: one_to_one
  }

  join: eps_tx_tp {
    view_label: "Claim"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_id} = ${eps_tx_tp.tx_tp_id} AND ${eps_tx_tp.source_system_id} = 4 ;; #[ERXLPS-2384]
    relationship: many_to_one
  }

  join: eps_tp_link {
    fields: [eps_transmit_queue_card_menu_candidate_list*]
    view_label: "Card"
    type: left_outer
    sql_on: ${eps_tx_tp.chain_id} = ${eps_tp_link.chain_id} AND ${eps_tx_tp.nhin_store_id} = ${eps_tp_link.nhin_store_id} AND ${eps_tx_tp.tx_tp_patient_tp_link_id} = ${eps_tp_link.tp_link_id} AND ${eps_tx_tp.source_system_id} = ${eps_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: eps_card {
    fields: [eps_transmit_queue_card_menu_candidate_list*]
    view_label: "Card"
    type: left_outer
    sql_on: ${eps_tp_link.chain_id} = ${eps_card.chain_id} AND ${eps_tp_link.nhin_store_id} = ${eps_card.nhin_store_id} AND ${eps_tp_link.card_id} = ${eps_card.card_id} AND ${eps_tp_link.source_system_id} = ${eps_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: eps_plan {
    fields: [explore_sales_candidate_list*]
    view_label: "Plan"
    type: left_outer
    sql_on: ${eps_card.chain_id} = ${eps_plan.chain_id} AND ${eps_card.nhin_store_id} = ${eps_plan.nhin_store_id} AND ${eps_card.plan_id} = ${eps_plan.plan_id} AND ${eps_card.source_system_id} = ${eps_plan.source_system_id};; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_plan_transmit {
    fields: [explore_sales_candidate_list*]
    view_label: "Plan"
    type: left_outer
    sql_on: ${eps_plan.chain_id} = ${eps_plan_transmit.chain_id} AND ${eps_plan.nhin_store_id} = ${eps_plan_transmit.nhin_store_id} AND ${eps_plan.plan_id} = ${eps_plan_transmit.plan_id} AND ${eps_plan.source_system_id} = ${eps_plan_transmit.source_system_id} AND ${eps_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [chain_id, chain_name, master_chain_name, chain_deactivated_date, chain_open_or_closed]
    type: inner
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${store.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: eps_rx_tx {
    fields: [-ALL_FIELDS*, explore_tp_transmit_queue_candidate_list*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_tx_tp.chain_id} = ${eps_rx_tx.chain_id} AND ${eps_tx_tp.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${eps_tx_tp.rx_tx_id} = ${eps_rx_tx.rx_tx_id} AND ${eps_rx_tx.rx_tx_tx_deleted} = 'N' AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_rx {
    fields: [-ALL_FIELDS*, rx_number]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: epr_rx_tx {
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    fields: [rx_com_id, patient_age, patient_age_tier, patient_count, explore_dx_patient_age_tier_candidate_list*] #[ERXLPS-6239]
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${patient.chain_id} AND ${epr_rx_tx.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} AND ${prescriber.deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: store_drug {
    fields: [
      ndc,
      drug_ndc_9,
      drug_bin_storage_type,
      drug_therapeutic_class,
      drug_ddid,
      drug_dosage_form,
      drug_full_generic_name,
      drug_full_name,
      drug_generic_name,
      drug_packs_per_container,
      drug_pack,
      drug_brand_generic,
      drug_name,
      drug_schedule,
      drug_schedule_category,
      drug_strength,
      drug_brand_generic_other #[ERXDWPS-5467]
    ]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id} = ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Pharmacy Drug"
    fields: [gpi_identifier, gpi_description, gpi_level] #[ERXLPS-2058] Removed medical_condition
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${gpi.gpi_identifier} AND ${gpi.chain_id} IN ( SELECT DISTINCT CASE WHEN C.CHAIN_ID = D.CHAIN_ID THEN C.CHAIN_ID ELSE 3000 END FROM EDW.D_CHAIN C LEFT OUTER JOIN EDW.D_STORE_DRUG D ON C.CHAIN_ID = D.CHAIN_ID WHERE c.source_system_id = 5 AND {% condition chain.chain_id %} C.CHAIN_ID {% endcondition %} ) ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXLPS-2058] Join to expose Therapy Class information from EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF table.
  join: gpi_medical_condition_cross_ref {
    view_label: "Pharmacy Drug"
    type: left_outer
    fields: [gpi_medical_condition]
    sql_on: ${gpi.gpi_identifier} = ${gpi_medical_condition_cross_ref.gpi} ;;
    relationship: one_to_many
  }

  join: gpi_disease_cross_ref {
    view_label: "Pharmacy Drug"
    type: left_outer
    fields: [gpi_candidate_list*]
    sql_on: ${store_drug.gpi_identifier} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }
}

explore: table_structure_validation_base {
  view_name: table_structure_validation
  extension: required
  label: "Table Structure Validation"
  view_label: "Table Structure Validation"
  fields: [ALL_FIELDS*]
  description: "Compares DFMD vs Table Structure Validation"
}

explore: sanity_job_count_base {
  view_name: sanity_job_count
  extension: required
  label: "Sanity Job Count"
  view_label: "Sanity Job Count"
  fields: [ALL_FIELDS*]
  description: "Compares Source minus target and target minus source"
}

explore: noise_source_system_base {
  view_name: noise_source_system
  extension: required
  label: "Source System Noise"
  view_label: "Source System Noise"
  fields: [ALL_FIELDS*]
  description: "Displays noise at all source systems in BI"
}

explore: dq_duplicates_in_edw_current_state_base {
  view_name: dq_duplicates_in_edw_current_state
  extension: required
  label: "Duplicates in EDW Current State"
  view_label: "Duplicates in EDW tables"
  fields: [ALL_FIELDS*]
  description: "Duplicates in EDW Current State Table"
}

explore: compound_base {
  extension: required
  view_name: store_compound
  view_label: "Compound"
  sql_always_where: ${store_compound.compound_deleted} = 'N' ;;
  description: "Displays information pertaining to drug compounds"

  join: chain {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${store_compound.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    type: inner
    view_label: "Pharmacy - Central"
    sql_on: ${store_compound.chain_id} = ${store.chain_id}  AND ${store_compound.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

#[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }
}

explore: query_history_base {
  extension: required
  label: "Snowflake Query History"
  view_name: query_history
}

explore: image_cross_ref_base {
  extension: required
  label: "Image Cross Reference"
  view_name: image_cross_ref

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
    sql_on: ${image_cross_ref.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5  ;;
    relationship: many_to_one
  }

  join: store {
    type: left_outer
    view_label: "Pharmacy"
    sql_on: ${image_cross_ref.chain_id} = ${store.chain_id}  AND ${image_cross_ref.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }
}
#[ERX-3542] added new explore as a part of 4.13.000
explore: epr_audit_access_log_base {
  extension: required
  label: "Audit Access Log"
  description: "Displays information pertaining to EPR Audit Access logs"
  view_label: "Audit Access Log"

  always_filter: {
    filters: {
      field: audit_access_log_audit_date
      value: "last 7 days"
    }
  }

  join: epr_service_type {
    type: left_outer
    sql_on: ${epr_audit_access_log.service_id} = ${epr_service_type.service_id} ;;
    relationship: many_to_one
  }

  join: chain {
    type: inner
    view_label: "Pharmacy"
    sql_on: ${epr_audit_access_log.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5;;
    relationship: many_to_one
  }

  join: store {
    type: inner
    view_label: "Pharmacy"
    sql_on: ${epr_audit_access_log.chain_id} = ${store.chain_id} AND ${epr_audit_access_log.audit_access_log_nhin_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5;; #[ERXLPS-1285] - Added chain_id condition to store join in Audit Access Log.
    relationship: many_to_one
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }
}

explore: login_history_base {
  extension: required
  label: "Snowflake Query History"
  view_name: login_history
  description: "Displays information of login attempts by Snowflake users"
}

explore: looker_explore_base {
  extension:  required
  label: "ExploreRx Data Dictionary"
  view_name:  looker_explore
  view_label: "Explore"
  description: "Displays ExploreRx Data Dictionary"

  join: looker_model {
    view_label: "Model"
    type: inner
    sql_on: ${looker_explore.model_name} = ${looker_model.name} ;;
    relationship: many_to_one
  }

  join: looker_explore_field {
    view_label: "Field"
    type:  inner
    sql_on:  ${looker_explore.id} = ${looker_explore_field.explore_id} ;;
    relationship: one_to_many
  }
}

#[ERXLPS-1362]
explore: eps_prescriber_edi_base {
  extension:  required
  label: "eScript"
  view_name:  eps_prescriber_edi
  view_label: "eScript"
  description: "Displays information pertaining to eScripts"
  sql_always_where: ${prescriber_edi_message_type_filter} IN ('NEWRX','REFRES','ERROR','CANRX') ;;

  always_filter: {
    filters: {
      field: rx_tx_fill_status_filter
      value: "NEW PRESCRIPTION"
    }

    filters: {
      field: rx_tx_tx_status_filter
      value: "NORMAL"
    }

    filters: {
      field: escript_message_approval_status_filter
      value: "NEW PRESCRIPTION MESSAGE,REFILL RESPONSE MESSAGE APPROVED,REFILL RESPONSE MESSAGE APPROVED WITH CHANGES"
    }

    filters: {
      field: received_to_rpt_sales_duration
      value: ">0"
    }
  }

  fields: [
    ALL_FIELDS*,
    -store.chain_id,
    -store_drug.prescribed_drug_name,
    -patient.rx_com_id_deidentified,        #ERXLPS-1162
    -prescriber.npi_number_deidentified,    #ERXLPS-1162
    -prescriber.dea_number_deidentified,    #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    -store_drug.store_drug_cost_region, #[ERXLPS-1925]
    -eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales, #[ERXDWPS-6802]
    -eps_rx.exploredx_eps_rx_analysis_cal_timeframes, #[ERXDWPS-6802]
    -eps_rx_tx.exploredx_eps_rx_tx_analysis_cal_timeframes* #[ERXDWPS-6802]
  ]

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count]
    type: inner
    sql_on: ${eps_prescriber_edi.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${eps_prescriber_edi.chain_id} = ${store.chain_id} AND ${eps_prescriber_edi.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: eps_rx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_prescriber_edi.chain_id} = ${eps_rx.chain_id}
        AND ${eps_prescriber_edi.nhin_store_id} = ${eps_rx.nhin_store_id}
        AND ${eps_prescriber_edi.prescriber_edi_id} = ${eps_rx.rx_prescriber_edi_id}
        AND ${eps_rx.rx_number} IS NOT NULL
        AND ${eps_rx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_rx_tx {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_rx_tx.chain_id}
        AND ${eps_rx.nhin_store_id} = ${eps_rx_tx.nhin_store_id}
        AND ${eps_rx.rx_id} = ${eps_rx_tx.rx_id}
        AND ${eps_rx_tx.rx_tx_refill_number} = 0
        AND ${eps_rx_tx.source_system_id} = 4 ;;
    relationship: many_to_one
  }

  join: eps_patient {
    view_label: "Patient - Central"
    fields: [-ALL_FIELDS*]
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${eps_patient.chain_id} AND ${eps_rx.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${eps_rx.rx_patient_id} = ${eps_patient.patient_id} AND ${eps_patient.source_system_id} = 4;;
    relationship: many_to_one
  }

  join: patient {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many #[ERXLPS-910] Corrected the relationship
  }

  join: epr_rx_tx {
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${eps_rx.chain_id} = ${epr_rx_tx.chain_id} AND ${eps_rx.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${eps_rx.rx_number}= ${epr_rx_tx.rx_number} AND ${eps_rx_tx.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: one_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${eps_rx_tx.chain_id} AND ${store_drug.nhin_store_id}= ${eps_rx_tx.nhin_store_id} AND ${store_drug.drug_id} = ${eps_rx_tx.rx_tx_drug_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: store_drug_prescribed {
    from: store_drug
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug_prescribed.chain_id} = ${eps_rx.chain_id} AND ${store_drug_prescribed.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${store_drug_prescribed.drug_id} = ${eps_rx.rx_prescribed_drug_id} AND ${store_drug_prescribed.deleted_reference} = 'N' AND ${store_drug_prescribed.source_system_id} = 4 ;; #[ERXLPS-2064]
    relationship: many_to_one
    fields: [prescribed_drug_name]
  }

  #[ERXLPS-2089] - View name renamed to store_drug_price_code. Removed from clause from join.
  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.
}

explore: poc_prescriber_base {
  extension:  required
  label: "PRESCRIBER PREDICTIVE ANALYTICS"
  view_name:  poc_unique_prescriber
  view_label: "Prescriber"
  description: "Displays information pertaining to Prescriber"
  #sql_always_where: ${prescriber_edi_message_type_filter} IN ('NEWRX','REFRES','ERROR','CANRX') ;;

  fields: [
    ALL_FIELDS*
    #-store_drug.store_drug_cost_region #[ERXLPS-1925]
  ]

  join: poc_store_prescriber {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${poc_unique_prescriber.unique_prescriber_identifier} = ${poc_store_prescriber.unique_prescriber_identifier};;
    relationship: one_to_many
  }

  join: poc_eps_rx_tx {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${poc_store_prescriber.chain_id} = ${poc_eps_rx_tx.chain_id} AND ${poc_store_prescriber.nhin_store_id} = ${poc_eps_rx_tx.nhin_store_id} and ${poc_store_prescriber.prescriber_clinic_id} = ${poc_eps_rx_tx.Prescriber_clinic_link_id}  and ${poc_store_prescriber.unique_presc_row_num} = 1;;
    relationship: one_to_one
  }

  #join: poc_eps_rx {
  #  view_label: "Prescription"
  #  type: inner
  #  sql_on: ${poc_eps_rx.chain_id} = ${poc_eps_rx_tx.chain_id} AND ${poc_eps_rx.nhin_store_id} = ${poc_eps_rx_tx.nhin_store_id} and ${poc_eps_rx.rx_id} = ${poc_eps_rx_tx.rx_id} ;;
  #  relationship: one_to_many
  # }


}



explore: poc_drug_base {
  extension:  required
  label: "DRUG PREDICTIVE ANALYTICS"
  view_name:  poc_drug
  view_label: "Drug"
  description: "Displays information pertaining to Drug"
  #sql_always_where: ${prescriber_edi_message_type_filter} IN ('NEWRX','REFRES','ERROR','CANRX') ;;

  fields: [
    ALL_FIELDS*
    #-store_drug.store_drug_cost_region #[ERXLPS-1925]
  ]

  join: poc_drug_cost_hist {
    view_label: "Drug Cost Hist"
    type: inner
    sql_on: ${poc_drug.drug_ndc} = ${poc_drug_cost_hist.ndc} AND ${poc_drug.drug_row_num} = 1;;
    relationship: one_to_many
  }

  join: poc_drug_cost_type {
    view_label: "Drug Cost Hist Type"
    type: inner
    sql_on: ${poc_drug_cost_hist.cost_type} = ${poc_drug_cost_type.cost_type} AND ${poc_drug_cost_type.drug_cost_type_row_num} = 1;;
    relationship: many_to_one
  }
}

explore: poc_drug_predictited_base {
  extension:  required
  label: "DRUG PREDICTED RESULTS "
  view_name:  poc_drug_price_predicted
  view_label: "Drug"
  description: "Displays information pertaining to Drug"
  #sql_always_where: ${prescriber_edi_message_type_filter} IN ('NEWRX','REFRES','ERROR','CANRX') ;;

  fields: [
    ALL_FIELDS*
    #-store_drug.store_drug_cost_region #[ERXLPS-1925]
  ]

  join: poc_rx_tx_link {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${poc_drug_price_predicted.drug_ndc} = ${poc_rx_tx_link.rx_tx_dispensed_drug_ndc} ;;
    relationship: one_to_many
  }

  join: poc_eps_rx {
    view_label: "Prescription"
    type: inner
    sql_on: ${poc_eps_rx.chain_id} = ${poc_rx_tx_link.chain_id} AND ${poc_eps_rx.nhin_store_id} = ${poc_rx_tx_link.nhin_store_id} and ${poc_eps_rx.rx_id} = ${poc_rx_tx_link.rx_id} ;;
    relationship: many_to_one
  }

  join: poc_drug {
    view_label: "Drug"
    fields: [drug_name]
    type: inner
    sql_on: ${poc_drug_price_predicted.drug_ndc} = ${poc_drug.drug_ndc} and ${poc_drug.drug_row_num} = 1 ;;
    relationship: one_to_one
  }



}

explore: poc_dr_drug_training_base {
  extension:  required
  label: "DRUG Price Change - Training Data"
  view_name:  poc_dr_drug_training
  view_label: "Drug"
  description: "Displays information pertaining to Drug price change source data"
  fields: [ALL_FIELDS*]
}

explore: poc_dr_drug_prediction_base {
  extension:  required
  label: "DRUG Price Change - Prediction Data"
  view_name:  poc_dr_drug_prediction
  view_label: "Drug"
  description: "Displays information pertaining to Drug price change predictions"
  fields: [ALL_FIELDS*]
}

explore: poc_dr_drug_base {
  extension:  required
  label: "DRUG Price Change Prediction"
  view_name:  poc_dr_drug
  view_label: "Drug"
  description: "Displays information pertaining to Drug price change predictions. Data directly loaded into EDW table manually."
  fields: [ALL_FIELDS*]
}

explore: poc_dr_prescriber_base {
  extension:  required
  label: "PRESCRIBER SALES PREDICTION"
  view_name:  poc_dr_prescriber
  view_label: "Prescriber"
  description: "Displays information pertaining to Prescriber Sales"
  fields: [ALL_FIELDS*]

  join: poc_dr_prescriber_source {
    view_label: "Prescriber"
    type: inner
    sql_on: ${poc_dr_prescriber_source.prescriber_npi_number} = ${poc_dr_prescriber.prescriber_npi_number}
        and ${poc_dr_prescriber_source.prescriber_dea_number} = ${poc_dr_prescriber.prescriber_dea_number}
        and ${poc_dr_prescriber_source.prescriber_first_name} = ${poc_dr_prescriber.prescriber_first_name}
        and ${poc_dr_prescriber_source.prescriber_last_name} = ${poc_dr_prescriber.prescriber_last_name} ;;
    relationship: one_to_one
  }
}

explore: poc_dr_mtm_session_base {
  extension:  required
  label: "SESSION SUCCESS RATE"
  view_name:  poc_dr_mtm_session
  view_label: "Session Prediction"
  description: "Displays information pertaining to sessions"
  fields: [ALL_FIELDS*]

  join: poc_dr_mtm_session_source {
    view_label: "Session Source"
    type: inner
    sql_on: ${poc_dr_mtm_session_source.session_id} = ${poc_dr_mtm_session.session_id} ;;
    relationship: one_to_one
  }
}

######################################################################## Sales Analysis  ######################################################################################################
explore: sales_epr_base {
  extension: required
  view_name: sales_epr
  label: "Sales EPR"
  view_label: "Sales"
  description: "The Sales Analysis contains sales information for all cash and third party transactions that were sold, credit returned, or cancelled on the date(s) you specify. Includes all new, refill, and downtime prescriptions that has a reportable sales date. If the transaction was cancelled or credit returned, the report will display records for both the sale information and the credit/cancel information."

  fields: [
    ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment #ERXDWPS-8224
  ]

  always_filter: {
    filters: {
      field: history_filter
      value: "YES"
    }

    filters: {
      field: cash_filter
      value: "BOTH"
    }

    filters: {
      field: sales_date_filter
      value: "Last 1 Month"
    }

    filters: {
      field: date_to_use_filter
      value: "REPORTABLE SALES"
    }
  }

  join: chain {
    view_label: "Pharmacy"
    fields: [chain_id,chain_name,master_chain_name,chain_deactivated_date,chain_open_or_closed,count,fiscal_chain_id]
    type: inner
    sql_on: ${sales_epr.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy"
    fields: [nhin_store_id,store_number,store_name,store_server_time_zone,store_address_deleted_flag,support_notes,store_client_type,store_client_version,store_category,count,dea_number]
    type: inner
    sql_on: ${sales_epr.chain_id} = ${store.chain_id} AND ${sales_epr.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information. Added dea_number dimension to store join.
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

#[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy"
    fields: [store_contact_info_address,store_contact_info_address_line2,store_contact_info_city,store_contact_info_state]
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: drug {
    fields: [drug_ndc,drug_ndc_9,drug_ndc_11_digit_format,drug_bin_storage_type,drug_category,drug_class,drug_ddid,drug_dosage_form,drug_full_generic_name,drug_full_name,drug_generic_name,drug_individual_container_pack,drug_integer_pack,drug_manufacturer,drug_brand_generic,drug_name,drug_schedule,drug_schedule_category,drug_strength,count]
    type: left_outer
    sql_on: ${sales_epr.store_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 ;;
    relationship: many_to_one
  }

  join: gpi {
    view_label: "Drug"
    fields: [gpi_identifier,gpi_description,gpi_level]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 ;;
    relationship: many_to_one
  }
}

#[ERX-6443]
explore: json_error_data_base {
  extension: required
  view_name: json_error_data
  label: "PDX Classic Data Errors"
  view_label: "Data Error"
  description: "Data Error"
  sql_always_where:    ${json_error_data.source_system_name} = 'PDX'
                   --and ${json_error_data.loaded_in_edw_flag} = 'Yes' #[ERXDWPS-5511] - Removed this condition based on discussion with Kumaran. Removing this condition will shpw all errors (PK and Non PK) in explore report. We need to check with DEV team to understand why we added this condition.
                   and upper(${json_error_data.is_corrected_flag}) = case when upper({% parameter json_error_data.history_filter %}) = 'NO' then 'NO' else upper(${json_error_data.is_corrected_flag}) end  ;;

    always_filter: {
      filters: {
        field: history_filter
        value: "No"
      }

      filters: {
        field: source_timestamp_date
        value: "Last 1 Month"
      }
    }

    fields: [ALL_FIELDS*,
             -store.dea_number #[ERXDWPS-9281]
            ]

    join: chain {
      fields: [
        chain_id,
        chain_name,
        master_chain_name,
        chain_deactivated_date,
        chain_open_or_closed,
        count
      ]
      type: left_outer
      view_label: "Pharmacy - Central"
      sql_on: ${json_error_data.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
      relationship: many_to_one
    }

    join: store {
      type: left_outer
      view_label: "Pharmacy - Central"
      sql_on: ${json_error_data.chain_id} = ${store.chain_id}  AND ${json_error_data.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
      relationship: many_to_one
    }

    #[ERXLPS-6344] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
    join: store_contact_information {
      view_label: "Pharmacy - Central"
      type: left_outer
      sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
      relationship: one_to_one
    }

    join: store_setting_phone_number_area_code {
      from: store_setting
      view_label: "Pharmacy - Central"
      type: left_outer
      sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: store_setting_fax_number_area_code {
      from: store_setting
      view_label: "Pharmacy - Central"
      type: left_outer
      sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: store_setting_fax_number {
      from: store_setting
      view_label: "Pharmacy - Central"
      type: left_outer
      sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: store_setting_phone_number {
      from: store_setting
      view_label: "Pharmacy - Central"
      type: left_outer
      sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
      relationship: one_to_one
      fields: [ ]
    }

  }

#[ERXLPS-4396] - Plan Explore
  explore: plan_nhin_base {
    extension: required
    label: "Plan"
    view_name: plan
    view_label: "NHIN Plan"
    description: "Displays information pertaining to NHIN PLAN"
    fields: [ALL_FIELDS*]
    sql_always_where: plan.source_system_id = 6 AND plan.plan_deleted = 'N' ;;

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
      sql_on: ${plan.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
      relationship: many_to_one
    }
  }

#[ERXLPS-4396] - Plan Explore
  explore: plan_host_base {
    extension: required
    label: "Plan"
    view_name: plan
    view_label: "HOST Plan"
    description: "Displays information pertaining to HOST PLAN"
    fields: [ALL_FIELDS*]
    sql_always_where: plan.source_system_id = 0 AND plan.plan_deleted = 'N' ;;

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
      sql_on: ${plan.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
      relationship: many_to_one
    }
  }

  #[ERXLPS-5143] - Patient Activity Explore
  #If user selected Pharamcy Division/Region/District/State on the report then the report should pull STORE GRAIN Data.
  #If user selected Chain and RX_COM_ID on the report then the report should pull data from F_PATIENT_ACTIVITY_DETAIL_SNAPSHOT table - PATIENT_ACTIVITY_GRAIN_IDENTIFIER = CHAIN
  #If user selected Chain , NHIN_STORE_ID and RX_COM_ID on the report then the report should pull data from F_PATIENT_ACTIVITY_DETAIL_SNAPSHOT - PATIENT_ACTIVITY_GRAIN_IDENTIFIER = STORE
  #If user selected Chain_id on the report i.e. if it's chain level report then the report should pull data from F_PATIENT_ACTIVITY_SUMMARY_SNAPSHOT table - PATIENT_ACTIVITY_GRAIN_IDENTIFIER = CHAIN
  #If user selected Chain , NHIN_STORE_ID on the report then the report should pull data from F_PATIENT_ACTIVITY_SUMMARY_SNAPSHOT table - PATIENT_ACTIVITY_GRAIN_IDENTIFIER = STORE

  explore: patient_activity_snapshot_base {
    extension: required
    label: "Patient Activity"
    view_name: patient_activity_snapshot
    view_label: "Patient Activity - History"
    description: "Displays information pertaining to Patient Activity"
    fields: [ALL_FIELDS*]
    sql_always_where:
          {% if patient_activity_snapshot.period_begin_date._in_query or patient_activity_snapshot.period_begin_month._in_query %}
              {% if patient_activity_snapshot.patient_activity_pharmacy_division._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_region._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_distrinct._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_state._in_query
              %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif patient_activity_snapshot.rx_com_id._in_query and (store.nhin_store_id._in_query or store.store_number._in_query) %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif patient_activity_snapshot.rx_com_id._in_query %}
                ${patient_activity_snapshot.patient_activity_grain} = 'CHAIN'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif (store.nhin_store_id._in_query or store.store_number._in_query) %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% else %} --default is using chain
                ${patient_activity_snapshot.patient_activity_grain} = 'CHAIN'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% endif %}
          {% else %}
              {% if patient_activity_snapshot.patient_activity_pharmacy_division._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_region._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_distrinct._in_query
                  or patient_activity_snapshot.patient_activity_pharmacy_state._in_query
              %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif patient_activity_snapshot.rx_com_id._in_query and (store.nhin_store_id._in_query or store.store_number._in_query) %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif patient_activity_snapshot.rx_com_id._in_query %}
                ${patient_activity_snapshot.patient_activity_grain} = 'CHAIN'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% elsif (store.nhin_store_id._in_query or store.store_number._in_query) %}
                ${patient_activity_snapshot.patient_activity_grain} = 'STORE'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% else %} --default is using chain
                ${patient_activity_snapshot.patient_activity_grain} = 'CHAIN'
                AND ${activity_type} = 'SOLD'
                AND ${period_type} = 'FISCAL'
                AND ${period_grain} = 'MONTH'
              {% endif %}
              AND EXISTS (SELECT NULL FROM (SELECT CHAIN_ID, MAX(PERIOD) as MAX_PERIOD, MAX(PERIOD_BEGIN_DATE) AS MAX_PERIOD_BEGIN_DATE FROM EDW.F_PATIENT_ACTIVITY_SUMMARY_SNAPSHOT
                                              WHERE PATIENT_ACTIVITY_GRAIN = 'CHAIN'
                                                AND ACTIVITY_TYPE = 'SOLD'
                                                AND PERIOD_TYPE = 'FISCAL'
                                                AND PERIOD_GRAIN = 'MONTH'
                                              GROUP BY CHAIN_ID)
                            WHERE CHAIN_ID = ${patient_activity_snapshot.chain_id}
                              AND ACTIVITY_TYPE = ${patient_activity_snapshot.activity_type}
                              AND PERIOD_TYPE = ${patient_activity_snapshot.period_type}
                              AND PERIOD_GRAIN = ${patient_activity_snapshot.period_grain}
                              AND MAX_PERIOD = ${patient_activity_snapshot.period}
                              AND MAX_PERIOD_BEGIN_DATE = ${patient_activity_snapshot.period_begin_date}
                          )
          {% endif %}
      ;;

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
        sql_on: ${patient_activity_snapshot.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store {
        type: left_outer
        fields: [nhin_store_id,store_number]
        view_label: "Pharmacy - Central"
        sql_on: ${patient_activity_snapshot.chain_id} = ${store.chain_id}  AND ${patient_activity_snapshot.patient_activity_grain_identifier} = ${store.nhin_store_id} AND ${patient_activity_snapshot.patient_activity_grain} = 'STORE' AND ${store.source_system_id} = 5 ;;
        relationship: many_to_one
      }
    }

    #[ERXDWPS-5883] - Task History Explore.
    explore: eps_task_history_base {
      extension: required
      label: "Task History"
      view_name: eps_task_history
      view_label: "Task History"
      fields: [ALL_FIELDS*,
        -eps_task_history.count_demo_user_employee_number,
        -eps_task_history.task_history_demo_user_login,
        -eps_task_history.task_history_demo_user_employee_number,
        -eps_task_history.bi_demo_on_site_alt_site,
        -eps_task_history.bi_demo_task_history_label_pharmacy_number,
        -eps_task_history.task_history_action_date_filter,
        -store.fax_number,
        -store.phone_number
      ]
      description: "Displays information relating to the tasks associated with processing prescriptions within the EPS system."

      always_filter: {
        filters: {
          field: eps_task_history.task_history_action_current_date
          value: "Last 30 Days"
        }
      }

      join: chain {
        fields: [
          chain_id,
          chain_name,
          master_chain_name,
          chain_deactivated_date,
          chain_open_or_closed,
          count
        ]
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${eps_task_history.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store {
        type: left_outer
        view_label: "Pharmacy - Central"
        sql_on: ${eps_task_history.chain_id} = ${store.chain_id}  AND ${eps_task_history.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store_alignment {
        view_label: "Pharmacy - Store Alignment"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
        relationship: one_to_one
      }

      join: store_user {
        view_label: "User"
        type: left_outer
        sql_on: ${eps_task_history.chain_id} = ${store_user.chain_id} AND ${eps_task_history.nhin_store_id} = ${store_user.nhin_store_id} AND ${eps_task_history.task_history_user_login} = ${store_user.store_user_login} AND ${store_user.source_system_id} = 4 AND ${store_user.store_user_deleted_reference} = 'N' ;;
        relationship: many_to_one
      }

      join: task_history_task_start_listagg {
        view_label: "Task History"
        type: left_outer
        sql_on: ${eps_task_history.chain_id} = ${task_history_task_start_listagg.chain_id}
            AND ${eps_task_history.nhin_store_id} = ${task_history_task_start_listagg.nhin_store_id}
            AND ${eps_task_history.rx_tx_id} = ${task_history_task_start_listagg.rx_tx_id}
            AND ${eps_task_history.task_history_user_employee_number} = ${task_history_task_start_listagg.task_history_user_employee_number}
            AND ${eps_task_history.task_history_task_name} = ${task_history_task_start_listagg.task_history_task_name} ;;
        relationship: many_to_one
      }
    }

#[ERXDWPS-6425] - User Explore.
#[ERXDWPS-6425] - Store Fax and Phone number excluded from User Explore to avoid joins with store_setting view. Please check with architects before you expose fax and phone number.
#[ERXDWPS-6800] - Exposed all elements from Pharmacy Central and Pharmacy Store Alignment which are currently exposed in Pharmacy Explore. As a standard we decided to expose all Pharmacy Central and Pharmacy Align information in explores where ever Pharmacy information exposed.
    explore: store_user_base {
      extension: required
      label: "User"
      view_name: store_user
      view_label: "User"
      fields: [ALL_FIELDS*,
        #-store.fax_number,
        #-store.phone_number,
        -store_user_license_type.bi_demo_count,
        -store_user_license.bi_demo_store_user_license_number
      ]
      description: "Displays information pertaining to store users"

      join: chain {
        fields: [
          chain_id,
          chain_name,
          master_chain_name,
          chain_deactivated_date,
          chain_open_or_closed,
          count
        ]
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${store_user.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store {
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${store_user.chain_id} = ${store.chain_id}  AND ${store_user.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store_alignment {
        view_label: "Pharmacy - Store Alignment"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
        relationship: one_to_one
      }

      join: store_state_location {
        view_label: "Pharmacy - Central"
        type: left_outer
        sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} =5 ;;
        relationship: one_to_one
      }

      #[ERXLPS_753] - Joins to get Pharmacy Phone Number and Fax Number from store_setting view
      join: store_setting_phone_number {
        from: store_setting
        view_label: "Pharmacy - Store"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
        relationship: one_to_one
        fields: [ ]
      }

      join: store_setting_phone_number_area_code {
        from: store_setting
        view_label: "Pharmacy - Store"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
        relationship: one_to_one
        fields: [ ]
      }

      join: store_setting_fax_number {
        from: store_setting
        view_label: "Pharmacy - Store"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
        relationship: one_to_one
        fields: [ ]
      }

      join: store_setting_fax_number_area_code {
        from: store_setting
        view_label: "Pharmacy - Store"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
        relationship: one_to_one
        fields: [ ]
      }

      #[ERXLPS-1855] added to check if a store information exists in store_algnment table.
      join: store_last_filled {
        view_label: "Pharmacy - Central"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_last_filled.chain_id} AND ${store.nhin_store_id} = ${store_last_filled.nhin_store_id} AND ${store.source_system_id} = 5 ;;
        relationship: one_to_one
      }

      #[ERXLPS-6307] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
      join: store_contact_information {
        view_label: "Pharmacy - Central"
        type: left_outer
        sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
        relationship: one_to_one
      }

      join: store_user_group {
        view_label: "User"
        type: left_outer
        fields: [-ALL_FIELDS*]
        sql_on: ${store_user.chain_id} = ${store_user_group.chain_id} AND ${store_user.nhin_store_id} = ${store_user_group.nhin_store_id} AND ${store_user.user_id} = ${store_user_group.user_id} AND ${store_user.source_system_id} = 4 AND ${store_user_group.store_user_group_deleted_reference} = 'N' ;;
        relationship: many_to_many
      }

      join: store_group {
        view_label: "User"
        type: inner
        sql_on: ${store_user_group.chain_id} = ${store_group.chain_id} AND ${store_user_group.nhin_store_id} = ${store_group.nhin_store_id} AND ${store_user_group.group_id} = ${store_group.group_id} ;;
        relationship: many_to_one
      }

      join: store_user_license {
        view_label: "User License"
        type: left_outer
        sql_on: ${store_user.chain_id} = ${store_user_license.chain_id} AND ${store_user.nhin_store_id} = ${store_user_license.nhin_store_id} AND ${store_user.user_id} = ${store_user_license.user_id} AND ${store_user.source_system_id} = 4 ;;
        relationship: one_to_many
      }

      join: store_user_license_type {
        view_label: "User License"
        type: left_outer
        sql_on: ${store_user_license.chain_id} = ${store_user_license_type.chain_id} AND ${store_user_license.nhin_store_id} = ${store_user_license_type.nhin_store_id} AND ${store_user_license.user_license_type_id} = ${store_user_license_type.user_license_type_id} AND ${store_user_license.source_system_id} = ${store_user_license_type.source_system_id} ;;
        relationship: one_to_many
      }
    }

    #[ERXDWPS-6571] - Exposing Store Central Fill Explore.
    explore: store_central_fill_base {
      extension: required
      label: "Central Fill - Store"
      view_name: eps_order_entry
      view_label: "Order Entry"
      description: "Displays information related to Central fill of any prescription"

      fields: [ALL_FIELDS*,
        -store_central_fill.central_fill_check_in_user_initials_deidentified,
        -store_central_fill.central_fill_fill_operator_deidentified,
        -store_central_fill.central_fill_fill_operator_employee_deidentified,
        -store_central_fill.central_fill_fill_operator_employee_initials_deidentified,
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
        -eps_rx_tx.time_in_will_call
      ]

      sql_always_where: ${store_setting_hist_cf_enable_listagg.store_setting_name} = 'storeflags.central-fill.enabled' ;; #condition to ensure only valid transactions are considered for Central Fill explore.

      always_filter: {
        filters: {
          field: report_calendar_global.report_period_filter
          value: "Last 1 Month"
        }

        filters: {
          field: report_calendar_global.analysis_calendar_filter
          value: "Fiscal - Month"
        }

        filters: {
          field: report_calendar_global.this_year_last_year_filter
          value: "No"
        }

        filters: {
          field: date_to_use_filter
          value: "REPORTABLE SALES"
        }
      }

      join: chain {
        view_label: "Pharmacy - Central"
        fields: [
          chain_id,
          chain_name,
          master_chain_name,
          chain_deactivated_date,
          chain_open_or_closed,
          count,
          fiscal_chain_id,
          chain_filter
        ]
        type: inner
        sql_on: ${eps_order_entry.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store {
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${eps_order_entry.chain_id} = ${store.chain_id}  AND ${eps_order_entry.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      #[ERXDWPS-9281] - Pharmacy DEA Information
      join: store_setting_dea_number {
        from: store_setting_rank
        view_label: "Pharmacy - Central"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
        relationship: one_to_one
        fields: [ ]
      }

      join: store_setting_hist_cf_enable_listagg {
        view_label: "Prescription Transaction"
        type: inner
        sql_on: ${eps_rx_tx.chain_id} = ${store_setting_hist_cf_enable_listagg.chain_id}
            AND ${eps_rx_tx.nhin_store_id} = ${store_setting_hist_cf_enable_listagg.nhin_store_id}
            AND ${eps_rx_tx.source_system_id} = ${store_setting_hist_cf_enable_listagg.source_system_id}
            AND ${eps_rx_tx.store_setting_cf_enable_prior_tx_reportable_sales} = 'Y' ;;
        relationship: many_to_one
      }

      #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_line_item.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
      join: eps_line_item {
        view_label: "Prescription Transaction"
        type: inner
        sql_on: ${eps_order_entry.chain_id} = ${eps_line_item.chain_id}
            AND ${eps_order_entry.nhin_store_id} = ${eps_line_item.nhin_store_id}
            AND ${eps_order_entry.order_entry_id} = ${eps_line_item.order_entry_id}
            AND {% condition chain.chain_id %} ${eps_line_item.chain_id} {% endcondition %};;
        relationship: one_to_many
      }

      #[ERXDWPS-2701] - Due to SF optimizer issues SF#38334, chain_id access filter confition added for eps_rx_tx.chain_id column. This will make sure only chain releated partitions are scanned when SQL runs.
      join: eps_rx_tx {
        view_label: "Prescription Transaction"
        type: inner
        sql_on: ${eps_line_item.chain_id} = ${eps_rx_tx.chain_id}
            AND ${eps_line_item.nhin_store_id} = ${eps_rx_tx.nhin_store_id}
            AND ${eps_line_item.line_item_id} = ${eps_rx_tx.rx_tx_id}
            AND ${eps_rx_tx.source_system_id} = 4
            AND ${eps_rx_tx.is_active} = 'Y'
            AND ${eps_rx_tx.rx_tx_tx_deleted} = 'N'
            AND {% condition chain.chain_id %} ${eps_rx_tx.chain_id} {% endcondition %} ;;
        relationship: one_to_one
      }

      join: report_calendar_global {
        fields: [global_calendar_candidate_list*, report_period_filter]
        view_label: "Prescription Transaction"
        type: inner
        relationship: many_to_one
        sql_on: ${report_calendar_global.chain_id} = ${eps_order_entry.chain_id}
            AND ${report_calendar_global.calendar_date} = (case when {% parameter eps_order_entry.date_to_use_filter %} = 'ORDER ENTRY PROMISED' then ${eps_order_entry.rpt_cal_order_entry_promised_date}
                                                                when {% parameter eps_order_entry.date_to_use_filter %} = 'ORDER ENTRY REQUESTED DELIVERY' then ${eps_order_entry.rpt_cal_order_entry_requested_delivery_date}
                                                                when {% parameter eps_order_entry.date_to_use_filter %} = 'REPORTABLE SALES' then ${eps_rx_tx.rpt_cal_rx_tx_reportable_sales_date}
                                                                when {% parameter eps_order_entry.date_to_use_filter %} = 'SOLD' then ${eps_rx_tx.rpt_cal_sold_date}
                                                                when {% parameter eps_order_entry.date_to_use_filter %} = 'CENTRAL FILL COMPLETED' then ${store_central_fill.rpt_cal_central_fill_completed_date}
                                                           end
                                                          ) ;;
      }

      # store_drug joined to eps_rx_tx
      join: store_drug {
        type: inner
        view_label: "Pharmacy Drug"
        fields: [ndc,drug_name,gpi_identifier,drug_multi_source]
        sql_on: ${eps_rx_tx.chain_id} = ${store_drug.chain_id}
            AND ${eps_rx_tx.nhin_store_id} = ${store_drug.nhin_store_id}
            AND ${eps_rx_tx.source_system_id} = ${store_drug.source_system_id}
            AND ${eps_rx_tx.rx_tx_drug_id}=${store_drug.drug_id}
            AND ${store_drug.deleted_reference} = 'N';;
        relationship: many_to_one
      }

      join: store_alignment {
        view_label: "Pharmacy - Store Alignment"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_alignment.chain_id}
            AND ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
        relationship: one_to_one
      }

      join: eps_rx {
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${eps_rx_tx.chain_id} = ${eps_rx.chain_id} AND ${eps_rx_tx.nhin_store_id}= ${eps_rx.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_rx.rx_id} AND ${eps_rx.rx_deleted} = 'N' AND ${eps_rx.source_system_id} = 4 ;;
        relationship: many_to_one
      }

      join: eps_task_history_rx_start_time {
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${eps_rx_tx.chain_id} = ${eps_task_history_rx_start_time.chain_id} AND ${eps_rx_tx.nhin_store_id} = ${eps_task_history_rx_start_time.nhin_store_id} AND ${eps_rx_tx.rx_id} = ${eps_task_history_rx_start_time.rx_id} AND ${eps_rx_tx.rx_tx_refill_number} = ${eps_task_history_rx_start_time.rx_tx_refill_number} ;;
        relationship: many_to_one
      }

      #store_central_fill view left outer joined with eps_rx_tx view to get all the transactions available at store.
      join: store_central_fill {
        type: left_outer
        view_label: "Central Fill"
        sql_on: ${eps_rx_tx.chain_id} = ${store_central_fill.chain_id}
            AND ${eps_rx_tx.nhin_store_id} = ${store_central_fill.nhin_store_id}
            AND ${eps_rx_tx.rx_tx_id} = ${store_central_fill.central_fill_id}
            AND ${eps_rx_tx.source_system_id} = ${store_central_fill.source_system_id} ;;
        relationship: one_to_one
      }

      #[ERXLPS-6216] - joined pickup_type to workflow explore.
      join: store_pickup_type {
        view_label: "Order Entry"
        type: left_outer
        fields: [-ALL_FIELDS*] #Join needed to display "Order Entry Pickup Type" information from eps_order_entry view file.
        sql_on: ${eps_order_entry.chain_id} = ${store_pickup_type.chain_id}
            AND ${eps_order_entry.nhin_store_id} = ${store_pickup_type.nhin_store_id}
            AND ${eps_order_entry.order_entry_pickup_type_id_reference} = ${store_pickup_type.pickup_type_code} ;;
        relationship: many_to_one
      }

      join: store_package_information {
        type: left_outer
        view_label: "Central Fill"
        sql_on: ${store_central_fill.chain_id} = ${store_package_information.chain_id}
            AND ${store_central_fill.nhin_store_id} = ${store_package_information.nhin_store_id}
            AND ${store_central_fill.package_information_id} = ${store_package_information.store_package_information_id}
            AND ${store_central_fill.source_system_id} = ${store_package_information.source_system_id}  ;;
        relationship: many_to_one
      }

      join: store_central_fill_facility {
        type: inner
        view_label: "Central Fill"
        sql_on: ${store_central_fill.chain_id} = ${store_central_fill_facility.chain_id}
            AND ${store_central_fill.nhin_store_id} = ${store_central_fill_facility.nhin_store_id}
            AND ${store_central_fill.central_fill_facility_id} = ${store_central_fill_facility.store_central_fill_facility_id}
            AND ${store_central_fill.source_system_id} = ${store_central_fill_facility.source_system_id}  ;;
        relationship: many_to_one
      }

      join: store_central_fill_delivery_schedule {
        type: left_outer
        view_label: "Central Fill"
        sql_on: ${eps_rx_tx.chain_id} = ${store_central_fill_delivery_schedule.chain_id}
            AND ${eps_rx_tx.nhin_store_id} = ${store_central_fill_delivery_schedule.nhin_store_id}
            AND dayofweek(TO_DATE(${eps_rx_tx.rx_tx_reportable_sales_date},'YYYY-MM-DD')) = ${store_central_fill_delivery_schedule.store_central_fill_delivery_schedule_cut_off_day_of_week_reference}
            AND ${eps_rx_tx.source_system_id} = ${store_central_fill_delivery_schedule.source_system_id}  ;;
        relationship: many_to_many
      }

      join: store_central_fill_formulary_derived {
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${eps_rx_tx.chain_id} = ${store_central_fill_formulary_derived.chain_id}
            AND ${eps_rx_tx.nhin_store_id} = ${store_central_fill_formulary_derived.nhin_store_id}
            AND ${eps_rx_tx.rx_tx_id} = ${store_central_fill_formulary_derived.rx_tx_id}
            AND ${eps_rx_tx.source_system_id} = ${store_central_fill_formulary_derived.source_system_id} ;;
        relationship: one_to_one
      }

      join: rpt_sales_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ( (    ${rpt_sales_timeframes.calendar_date} =
                  ( CASE WHEN (    {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                               AND {% parameter eps_order_entry.date_to_use_filter %} = 'REPORTABLE SALES') THEN ${report_calendar_global.report_date}
                         ELSE ${eps_rx_tx.rpt_cal_rx_tx_reportable_sales_date} END)
                    AND ${rpt_sales_timeframes.chain_id} = ${eps_rx_tx.chain_id}
                  )
                )
           ;;
        relationship: many_to_one
      }

      join: sold_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ( (    ${sold_timeframes.calendar_date} =
                  ( CASE WHEN (     {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                                AND {% parameter eps_order_entry.date_to_use_filter %} = 'SOLD') THEN ${report_calendar_global.report_date}
                         ELSE ${eps_rx_tx.rpt_cal_sold_date} END )
                    AND ${sold_timeframes.chain_id} = ${eps_rx_tx.chain_id}
                  )
                )
           ;;
        relationship: many_to_one
      }

      join: oe_promised_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ( (    ${oe_promised_timeframes.calendar_date} =
                  ( CASE WHEN (     {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                                AND {% parameter eps_order_entry.date_to_use_filter %} = 'ORDER ENTRY PROMISED') THEN ${report_calendar_global.report_date}
                         ELSE ${eps_order_entry.rpt_cal_order_entry_promised_date} END )
                    AND ${oe_promised_timeframes.chain_id} = ${eps_order_entry.chain_id}
                  )
                )
           ;;
        relationship: many_to_one
      }

      join: oe_requested_delivery_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ( (    ${oe_requested_delivery_timeframes.calendar_date} =
                  ( CASE WHEN (     {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                                AND {% parameter eps_order_entry.date_to_use_filter %} = 'ORDER ENTRY REQUESTED DELIVERY') THEN ${report_calendar_global.report_date}
                         ELSE ${eps_order_entry.rpt_cal_order_entry_requested_delivery_date} END )
                    AND ${oe_requested_delivery_timeframes.chain_id} = ${eps_order_entry.chain_id}
                  )
                )
           ;;
        relationship: many_to_one
      }

      join: cf_completed_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ( (    ${cf_completed_timeframes.calendar_date} =
                  ( CASE WHEN (     {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                                AND {% parameter eps_order_entry.date_to_use_filter %} = 'CENTRAL FILL COMPLETED') THEN ${report_calendar_global.report_date}
                         ELSE ${store_central_fill.rpt_cal_central_fill_completed_date} END )
                    AND ${cf_completed_timeframes.chain_id} = ${store_central_fill.chain_id}
                  )
                )
           ;;
        relationship: many_to_one
      }

      join: oe_closed_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ${oe_closed_timeframes.calendar_date} = ${eps_order_entry.oe_closed_date} AND ${oe_closed_timeframes.chain_id} = ${eps_order_entry.chain_id} ;;
        relationship: many_to_one
      }

      join: oe_email_sent_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ${oe_email_sent_timeframes.calendar_date} = ${eps_order_entry.oe_email_sent_date} AND ${oe_email_sent_timeframes.chain_id} = ${eps_order_entry.chain_id} ;;
        relationship: many_to_one
      }

      join: oe_requested_ship_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ${oe_requested_ship_timeframes.calendar_date} = ${eps_order_entry.oe_requested_ship_date} AND ${oe_requested_ship_timeframes.chain_id} = ${eps_order_entry.chain_id} ;;
        relationship: many_to_one
      }

      join: oe_source_create_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ${oe_source_create_timeframes.calendar_date} = ${eps_order_entry.oe_source_create_date} AND ${oe_source_create_timeframes.chain_id} = ${eps_order_entry.chain_id} ;;
        relationship: many_to_one
      }

      join: oe_source_last_update_timeframes {
        from: timeframes
        view_label: "Order Entry"
        type: left_outer
        sql_on: ${oe_source_last_update_timeframes.calendar_date} = ${eps_order_entry.oe_source_last_update_date} AND ${oe_source_last_update_timeframes.chain_id} = ${eps_order_entry.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_accepted_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_accepted_timeframes.calendar_date} = ${store_central_fill.cf_accepted_date} AND ${cf_accepted_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_cancel_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_cancel_timeframes.calendar_date} = ${store_central_fill.cf_cancel_date} AND ${cf_cancel_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_check_in_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_check_in_timeframes.calendar_date} = ${store_central_fill.cf_check_in_date} AND ${cf_check_in_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_delivery_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_delivery_timeframes.calendar_date} = ${store_central_fill.cf_delivery_date} AND ${cf_delivery_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_dispensed_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_dispensed_timeframes.calendar_date} = ${store_central_fill.cf_dispensed_date} AND ${cf_dispensed_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_pick_up_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_pick_up_timeframes.calendar_date} = ${store_central_fill.cf_pick_up_date} AND ${cf_pick_up_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_status_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_status_timeframes.calendar_date} = ${store_central_fill.cf_status_date} AND ${cf_status_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_source_create_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_source_create_timeframes.calendar_date} = ${store_central_fill.cf_source_create_date} AND ${cf_source_create_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: cf_source_last_update_timeframes {
        from: timeframes
        view_label: "Central Fill"
        type: left_outer
        sql_on: ${cf_source_last_update_timeframes.calendar_date} = ${store_central_fill.cf_source_last_update_date} AND ${cf_source_last_update_timeframes.chain_id} = ${store_central_fill.chain_id} ;;
        relationship: many_to_one
      }

      join: li_bottle_label_printed_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_bottle_label_printed_timeframes.calendar_date} = ${eps_line_item.li_bottle_label_printed_date}
            AND ${li_bottle_label_printed_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_do_not_sell_after_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_do_not_sell_after_timeframes.calendar_date} = ${eps_line_item.li_do_not_sell_after_date}
            AND ${li_do_not_sell_after_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_fill_task_completed_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_fill_task_completed_timeframes.calendar_date} = ${eps_line_item.li_fill_task_completed_date}
            AND ${li_fill_task_completed_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_create_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_create_timeframes.calendar_date} = ${eps_line_item.li_create_date}
            AND ${li_create_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_ivr_last_poll_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_ivr_last_poll_timeframes.calendar_date} = ${eps_line_item.li_ivr_last_poll_date}
            AND ${li_ivr_last_poll_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_next_contact_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_next_contact_timeframes.calendar_date} = ${eps_line_item.li_next_contact_date}
            AND ${li_next_contact_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_out_of_stock_hold_until_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_out_of_stock_hold_until_timeframes.calendar_date} = ${eps_line_item.li_out_of_stock_hold_until_date}
            AND ${li_out_of_stock_hold_until_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_partial_fill_completion_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_partial_fill_completion_timeframes.calendar_date} = ${eps_line_item.li_partial_fill_completion_date}
            AND ${li_partial_fill_completion_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_payment_authorization_state_completion_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_payment_authorization_state_completion_timeframes.calendar_date} = ${eps_line_item.li_payment_authorization_state_completion_date}
            AND ${li_payment_authorization_state_completion_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_payment_settlement_state_completion_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_payment_settlement_state_completion_timeframes.calendar_date} = ${eps_line_item.li_payment_settlement_state_completion_date}
            AND ${li_payment_settlement_state_completion_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_rescheduled_process_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_rescheduled_process_timeframes.calendar_date} = ${eps_line_item.li_rescheduled_process_date}
            AND ${li_rescheduled_process_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: li_source_create_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${li_source_create_timeframes.calendar_date} = ${eps_line_item.li_source_create_date}
            AND ${li_source_create_timeframes.chain_id} = ${eps_line_item.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_merged_to_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_merged_to_cust_timeframes.calendar_date} = ${eps_rx.rx_merged_to_cust_date}
            AND ${rx_merged_to_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_autofill_enable_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_autofill_enable_cust_timeframes.calendar_date} = ${eps_rx.rx_autofill_enable_cust_date}
            AND ${rx_autofill_enable_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_received_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_received_cust_timeframes.calendar_date} = ${eps_rx.rx_received_cust_date}
            AND ${rx_received_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_file_buy_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_file_buy_cust_timeframes.calendar_date} = ${eps_rx.rx_file_buy_cust_date}
            AND ${rx_file_buy_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_last_refill_reminder_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_last_refill_reminder_cust_timeframes.calendar_date} = ${eps_rx.rx_last_refill_reminder_cust_date}
            AND ${rx_last_refill_reminder_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_short_fill_sent_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_short_fill_sent_cust_timeframes.calendar_date} = ${eps_rx.rx_short_fill_sent_cust_date}
            AND ${rx_short_fill_sent_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_chain_first_filled_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_chain_first_filled_cust_timeframes.calendar_date} = ${eps_rx.rx_chain_first_filled_cust_date}
            AND ${rx_chain_first_filled_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_expiration_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_expiration_cust_timeframes.calendar_date} = ${eps_rx.rx_expiration_cust_date}
            AND ${rx_expiration_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_first_filled_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_first_filled_cust_timeframes.calendar_date} = ${eps_rx.rx_first_filled_cust_date}
            AND ${rx_first_filled_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_original_written_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_original_written_cust_timeframes.calendar_date} = ${eps_rx.rx_original_written_cust_date}
            AND ${rx_original_written_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_start_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_start_cust_timeframes.calendar_date} = ${eps_rx.rx_start_cust_date}
            AND ${rx_start_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_sync_script_enrollment_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_sync_script_enrollment_cust_timeframes.calendar_date} = ${eps_rx.rx_sync_script_enrollment_cust_date}
            AND ${rx_sync_script_enrollment_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_source_create_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_source_create_cust_timeframes.calendar_date} = ${eps_rx.rx_source_create_cust_date}
            AND ${rx_source_create_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_other_store_last_filled_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_other_store_last_filled_cust_timeframes.calendar_date} = ${eps_rx.rx_other_store_last_filled_cust_date}
            AND ${rx_other_store_last_filled_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_autofill_due_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_autofill_due_cust_timeframes.calendar_date} = ${eps_rx.rx_autofill_due_cust_date}
            AND ${rx_autofill_due_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_written_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_written_cust_timeframes.calendar_date} = ${eps_rx.rx_written_cust_date}
            AND ${rx_written_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_stop_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_stop_cust_timeframes.calendar_date} = ${eps_rx.rx_stop_cust_date}
            AND ${rx_stop_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_follow_up_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_follow_up_cust_timeframes.calendar_date} = ${eps_rx.rx_follow_up_cust_date}
            AND ${rx_follow_up_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_source_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_source_cust_timeframes.calendar_date} = ${eps_rx.rx_source_cust_date}
            AND ${rx_source_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_alignment_start_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_alignment_start_cust_timeframes.calendar_date} = ${eps_rx.rx_alignment_start_cust_date}
            AND ${rx_alignment_start_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_sync_script_refused_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_sync_script_refused_cust_timeframes.calendar_date} = ${eps_rx.rx_sync_script_refused_cust_date}
            AND ${rx_sync_script_refused_cust_timeframes.chain_id} = ${eps_rx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_start_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_start_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_start_cust_date}
            AND ${rx_tx_start_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_fill_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_fill_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_fill_cust_date}
            AND ${rx_tx_fill_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_pos_sold_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_pos_sold_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_pos_sold_cust_date}
            AND ${rx_tx_pos_sold_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_returned_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_returned_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_returned_cust_date}
            AND ${rx_tx_returned_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_will_call_arrival_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_will_call_arrival_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_will_call_arrival_cust_date}
            AND ${rx_tx_will_call_arrival_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_custom_reported_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_custom_reported_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_custom_reported_cust_date}
            AND ${rx_tx_custom_reported_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_dob_override_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_dob_override_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_dob_override_cust_date}
            AND ${rx_tx_dob_override_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_last_epr_synch_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_last_epr_synch_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_last_epr_synch_cust_date}
            AND ${rx_tx_last_epr_synch_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_missing_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_missing_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_missing_cust_date}
            AND ${rx_tx_missing_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_pc_ready_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_pc_ready_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_pc_ready_cust_date}
            AND ${rx_tx_pc_ready_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_replace_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_replace_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_replace_cust_date}
            AND ${rx_tx_replace_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_return_to_stock_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_return_to_stock_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_return_to_stock_cust_date}
            AND ${rx_tx_return_to_stock_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_counseling_completion_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_counseling_completion_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_counseling_completion_cust_date}
            AND ${rx_tx_counseling_completion_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_network_plan_bill_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_network_plan_bill_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_network_plan_bill_cust_date}
            AND ${rx_tx_network_plan_bill_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_central_fill_cutoff_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_central_fill_cutoff_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_central_fill_cutoff_cust_date}
            AND ${rx_tx_central_fill_cutoff_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_drug_expiration_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_drug_expiration_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_drug_expiration_cust_date}
            AND ${rx_tx_drug_expiration_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_drug_image_start_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_drug_image_start_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_drug_image_start_cust_date}
            AND ${rx_tx_drug_image_start_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_follow_up_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_follow_up_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_follow_up_cust_date}
            AND ${rx_tx_follow_up_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_host_retrieval_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_host_retrieval_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_host_retrieval_cust_date}
            AND ${rx_tx_host_retrieval_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_photo_id_birth_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_photo_id_birth_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_photo_id_birth_cust_date}
            AND ${rx_tx_photo_id_birth_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_photo_id_expire_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_photo_id_expire_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_photo_id_expire_cust_date}
            AND ${rx_tx_photo_id_expire_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_stop_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_stop_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_stop_cust_date}
            AND ${rx_tx_stop_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_written_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_written_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_written_cust_date}
            AND ${rx_tx_written_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }

      join: rx_tx_source_create_cust_timeframes {
        from: timeframes
        view_label: "Prescription Transaction"
        type: left_outer
        sql_on: ${rx_tx_source_create_cust_timeframes.calendar_date} = ${eps_rx_tx.rx_tx_source_create_cust_date}
            AND ${rx_tx_source_create_cust_timeframes.chain_id} = ${eps_rx_tx.chain_id} ;;
        relationship: many_to_one
      }
    }

explore: store_workflow_token_direct_stage_consumption_base {
  extension: required
  label: "Workflow Token (Beta)"
  view_name: store_workflow_token_direct_stage_consumption
  view_label: "Workflow Token"
  description: "This Explore is focused on providing a central view of core tasks which can be performed from a central processing perspective to enable the user to focus on the pharmacies which are behind in their prescription processing work"
  fields: [ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.fax_number,
    -store.phone_number,
    -store.dea_number #[ERXDWPS-9281]
  ]

#   always_filter: {
#     filters: {
#       field: eps_task_history.task_history_action_current_date
#       value: "Last 30 Days"
#     }
#   }

      join: chain {
        fields: [
          chain_id,
          chain_name,
          master_chain_name,
          chain_deactivated_date,
          chain_open_or_closed,
          count
        ]
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${store_workflow_token_direct_stage_consumption.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store {
        type: inner
        view_label: "Pharmacy - Central"
        sql_on: ${store_workflow_token_direct_stage_consumption.chain_id} = ${store.chain_id}  AND ${store_workflow_token_direct_stage_consumption.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
        relationship: many_to_one
      }

      join: store_alignment {
        view_label: "Pharmacy - Store Alignment"
        type: left_outer
        sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
        relationship: one_to_one
      }
    }

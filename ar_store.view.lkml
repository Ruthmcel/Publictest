view: ar_store {
  label: "Store"
  sql_table_name: EDW.D_STORE ;;

  dimension: primary_key {
    # This field is not exposed but used in the view to avoid running into symmetric aggregate issue as chain+nhin_store_id requires uniqueness
    hidden: yes
    type: number
    description: "Identification number assigned to a store by NHIN, under each customer chain"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ;; #ERXLPS-1649

  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_last_update_user_identifier {
    label: "Pharmacy Last Update User Identifier"
    type: number
    description: "Pharmacy Last Update User Identifier"
    sql: ${TABLE}.STORE_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "####"
  }

  dimension: store_type_id {
    label: "Pharmacy Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_TYPE_ID ;;
  }

  dimension: store_ar_version_type_id {
    label: "Pharmacy AR Version Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_AR_VERSION_TYPE_ID ;;
  }

  dimension: store_product_type_id {
    label: "Pharmacy Product TYPE ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRODUCT_TYPE_ID ;;
  }

  dimension: store_eligibility_type_id {
    label: "Pharmacy Eligibility Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_ELIGIBILITY_TYPE_ID ;;
  }

  dimension: store_closed_day_type_id {
    label: "Pharmacy Closed Day Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CLOSED_DAY_TYPE_ID ;;
  }

  dimension: store_tax_id {
    label: "Pharmacy Tax ID"
    type: string
    description: "Tax ID number for the pharmacy store"
    hidden: yes
    sql: ${TABLE}.STORE_TAX_ID ;;
  }

  dimension: store_host_version_type_id {
    label: "Pharmacy Host Version Type ID"
    type: number
    description: "Version number of the file(s) sent from host to store"
    hidden: yes
    sql: ${TABLE}.STORE_HOST_VERSION_TYPE_ID ;;
  }

  dimension: store_dm_recv_type_id {
    label: "Pharmacy DM Received Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_DM_RECV_TYPE_ID ;;
  }

  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################

  dimension: chain_id {
    label: "Pharmacy Chain ID"
    type: number
    description: "Unique number assigned to PDX Inc. Accounting to identify a Chain or a Store"
    sql: ${TABLE}.CHAIN_ID ;;
    value_format: "####"
  }

  dimension: nhin_store_id {
    label: "Pharmacy NHIN Store ID"
    type: number
    description: "Identification number assigned to a store by NHIN, under each customer chain"
    sql: ${TABLE}.NHIN_STORE_ID ;;
    value_format: "####"
  }

  dimension: store_number {
    label: "Pharmacy Number"
    type: string
    description: "Pharmacy/Store number assigned by the customer that identifies the store within its chain"
    sql: ${TABLE}.STORE_NUMBER ;;
  }

  dimension: store_name {
    label: "Pharmacy Name"
    type: string
    description: "Name of the Pharmacy"
    sql: ${TABLE}.STORE_NAME ;;
  }

  dimension: store_client_type {
    label: "Pharmacy Client Type"
    type: string
    description: "Specifies the type of pharmacy client the store uses"
    sql: ${TABLE}.STORE_CLIENT_TYPE ;;
  }

  dimension: store_npi_number {
    label: "Pharmacy NPI Number"
    type: string
    description: "National Provider Identifier number assigned to the pharmacy"
    sql: ${TABLE}.STORE_NPI_NUMBER ;;
  }

  dimension: store_ncpdp_number {
    label: "Pharmacy NCPDP Number"
    type: string
    description: "National Council for Prescription Drug Programs (NCPDP) number assigned to the Pharmacy"
    sql: ${TABLE}.STORE_NCPDP_NUMBER ;;
  }

  dimension: store_id {
    hidden:  yes
    label: "Store ID"
    type: number
    description: "Unique ID number identifying a store record in the AR source system"
    sql: ${TABLE}.STORE_ID ;;
    value_format: "####"
  }

  dimension: store_region {
    label: "Pharmacy Region"
    type: number
    description: "Free format-field where stores for a chain can be grouped into Regions"
    sql: ${TABLE}.STORE_REGION ;;
  }

  dimension: store_district {
    label: "Pharmacy District"
    type: number
    description: "Free format-field where stores for a chain can be grouped into districts"
    sql: ${TABLE}.STORE_DISTRICT ;;
  }

  dimension: store_division {
    label: "Pharmacy Division"
    type: string
    description: "Division name of the store"
    sql: ${TABLE}.STORE_DIVISION ;;
  }

  dimension: store_dea_number {
    label: "Pharmacy DEA Number"
    type: string
    description: "DEA (Drug Enforcement Administration) number of this pharmacy store"
    sql: ${TABLE}.STORE_DEA_NUMBER ;;
  }

  dimension: store_state_license_number {
    label: "Pharmacy State License Number"
    type: string
    description: "State License number provided for this pharmacy store to operate legally in the state"
    sql: ${TABLE}.STORE_STATE_LICENSE_NUMBER ;;
  }

  dimension: store_city_license_number {
    label: "Pharmacy City License Number"
    type: string
    description: "City License number provided for this pharmacy store to operate legally in the city"
    sql: ${TABLE}.STORE_CITY_LICENSE_NUMBER ;;
  }

  dimension: store_comm_region {
    label: "Pharmacy Comm Region"
    type: number
    description: "Value used to organize customers into logical groups for purposes of pulling data from customers hosts"
    sql: ${TABLE}.STORE_COMM_REGION ;;
  }

  dimension: store_skip_missing_day_flag {
    label: "Pharmacy Skip Missing Day"
    type: yesno
    description: "Indicator that tells the AR system to skip missing day logic for this store"
    sql: ${TABLE}.STORE_SKIP_MISSING_DAY_FLAG ='Y' ;;
  }

  dimension: store_ar_activity_flag {
    label: "Pharmacy AR Activity"
    description: "Primary indicator for AR to tell if a store is active or not. This is a very important indicator"
    type: yesno
    sql: ${TABLE}.STORE_AR_ACTIVITY_FLAG ='Y' ;;
  }

  dimension: store_erx_flag {
    label: "Pharmacy ERX"
    type: yesno
    description: "Flag indicating that this store’s data comes from erx/Emdeon/Change Healthcare"
    sql: ${TABLE}.STORE_ERX_FLAG ='Y' ;;
  }

  dimension: store_use_rx_store_xref_flag {
    label: "Pharmacy Use RX Store XREF"
    type: yesno
    description: "Look up indicator to find the correct store to which a claim should be assigned while processing incoming sales data"
    sql: ${TABLE}.STORE_USE_RX_STORE_XREF_FLAG ='Y' ;;
  }

  dimension: store_exclude_checks_from_era_flag {
    label: "Pharmacy Exclude Checks From ERA"
    type: yesno
    description: "Indicator used by a process to indicate that this store is not eligible for the Create Checks from ERA process"
    sql: ${TABLE}.STORE_EXCLUDE_CHECKS_FROM_ERA_FLAG ='Y' ;;
  }

  dimension: store_controlled_substance_license_number {
    label: "Pharmacy Controlled Substance License Number"
    type: string
    description: "License number provided for this store to dispense controlled substances"
    sql: ${TABLE}.STORE_CONTROLLED_SUBSTANCE_LICENSE_NUMBER ;;
  }

  dimension: store_medicare_ptan_number_flu {
    label: "Pharmacy Medicare PTAN Number FLU"
    type: string
    description: "Medicare Provider Transaction Access Number for Flu"
    sql: ${TABLE}.STORE_MEDICARE_PTAN_NUMBER_FLU ;;
  }

  dimension: store_medicare_ptan_number_railroad_workers {
    label: "Pharmacy Medicare PTAN Number Railroad Workers"
    type: string
    description: "Medicare Provider Transaction Access Number for Railroad Workers & their families"
    sql: ${TABLE}.STORE_MEDICARE_PTAN_NUMBER_RAILROAD_WORKERS ;;
  }

  dimension: store_medicare_ptan_number_dmepos {
    label: "Pharmacy Medicare PTAN Number DMEPOS"
    type: string
    description: "Medicare Provider Transaction Access Number for DMEPOS (Durable Medical Equipment, Prosthetics, Orthotics, and Supplies)"
    sql: ${TABLE}.STORE_MEDICARE_PTAN_NUMBER_DMEPOS ;;
  }

  dimension: store_type {
    label: "Pharmacy Type"
    type: string
    description: "Indicates the type of store for the given customer/chain"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${store_type_id}) ;;
  }

  dimension: store_ar_version_type {
    label: "Pharmacy AR Version Type"
    type: string
    description: "Indicates the version of the PDX hstout(claims data feed) file"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${store_ar_version_type_id}) ;;
  }

  dimension: store_product_type {
    label: "Pharmacy Product TYPE"
    type: string
    description: "Indicates the type of pharmacy system that this store runs"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${store_product_type_id}) ;;
  }

  dimension: store_eligibility_type {
    label: "Pharmacy Eligibility Type"
    type: string
    description: "Indicates eligibility of the store. All types except ACTIVE indicate that the store is inactive"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${store_eligibility_type_id}) ;;
  }

  dimension: store_closed_day_type {
    label: "Pharmacy Closed Day Type"
    type: string
    description: "Indicates what day(s) of a week the pharmacy store is closed"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${store_closed_day_type_id}) ;;
  }

  ################################################################################################## End of Dimensions #########################################################################################

  ################################################################################################## Dimensions Group #########################################################################################
  dimension_group: store_open_date {
    label: "Pharmacy Open"
    type: time
    description: "Date that the pharmacy store was opened for operation"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_OPEN_DATE ;;
  }

  dimension_group: store_close_date {
    label: "Pharmacy Close"
    type: time
    description: "Date that the pharmacy store was closed for operation"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_CLOSE_DATE ;;
  }

  dimension_group: store_dea_expiration_date {
    label: "Pharmacy DEA Expiration"
    type: time
    description: "Date that the DEA number for this pharmacy store expires"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_DEA_EXPIRATION_DATE ;;
  }

  dimension_group: store_state_license_expiration_date {
    label: "Pharmacy State License Expiration"
    type: time
    description: "Date that the state license for this pharmacy store expires"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_STATE_LICENSE_EXPIRATION_DATE ;;
  }

  dimension_group: store_controlled_substance_license_expiration_date {
    label: "Pharmacy Controlled Substance License Expiration"
    type: time
    description: "Date that the controlled substance license for this pharmacy store expires"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_CONTROLLED_SUBSTANCE_LICENSE_EXPIRATION_DATE ;;
  }

  ################################################################################################## End of Dimensions Group#########################################################################################

  ################################################################################################## Measures ################################################################################################

  measure: count {
    label: "Pharmacy Count"
    type: count
    value_format: "#,##0"
    drill_fields: [nhin_store_id, store_number, store_name, ar_chain.chain_id, ar_chain.chain_name]
  }
}

################################################################################################## End of Measures ################################################################################################

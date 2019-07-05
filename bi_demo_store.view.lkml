view: bi_demo_store {
  # 03112016 - KR - This View is specificall used for BI Demo"
  # 03112016 - KR - All explore view in "CUSTOMER_DEMO" model will use chain_id & nhin_store_id to join to other transaction & child tables but bi_demo_chain_id & bi_demo_nhin_store_id will only be exposed to the demo customer model
  # 03112016 - KR - All mapping information is handled under REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING and only those chains residing in this table will be exposed due to inner join"
  # 03112016 - KR - Store Number, Store Name, NCPDP, NPI all reflects the same value as in bi_demo_nhin_store_id". This is handled using the VW_BI_DEMO_CHAIN_STORE_MAPPING view
  # 08222016 - KR - VW_BI_DEMO_CHAIN_STORE_MAPPING view replaced by derived_table as shown below. This gives felxibility for every member who has lookML access to look at the code
  # 08222016 - KR - Flattened BI Demo Store Information for better througput and faster ETL execution.

  sql_table_name: REPORT_TEMP.BI_DEMO_STORE ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: bi_demo_chain_id {
    type: number
    hidden: yes
    label: "Chain Id"
    sql: ${TABLE}.CHAIN_ID_BI_DEMO_MAPPING ;;
  }

  dimension: bi_demo_nhin_store_id {
    type: number
    label: "Pharmacy NHIN Store ID"
    description: "BI Demo Pharmacy"
    primary_key: yes
    sql: ${TABLE}.NHIN_STORE_ID_BI_DEMO_MAPPING ;;
  }

  dimension: store_id {
    hidden: yes
    type: number
    description: "Unique store id in ARS system. Auto-Assigned by the ARS system"
    sql: ${TABLE}.STORE_ID ;;
  }

  dimension: store_number {
    label: "Pharmacy Number (Central)"
    description: "Pharmacy/Store number assigned by the customer that identifies the store within its chain"
    sql: ${TABLE}.STORE_NUMBER ;;
  }

  dimension: store_name {
    label: "Pharmacy Name (Central)"
    description: "The name of the pharmacy/store"
    sql: ${TABLE}.STORE_NAME ;;
  }

  dimension: ncpdp_number {
    label: "Pharmacy NCPDP Number (Central)"
    description: "National Council for Prescription Drug Programs (NCPDP) number assigned to the Pharmacy"
    sql: ${TABLE}.STORE_NCPDP_NUMBER ;;
  }

  dimension: npi_number {
    label: "Pharmacy NPI Number (Central)"
    description: "National Provider Identifier number assigned to the pharmacy"
    sql: ${TABLE}.STORE_NPI_NUMBER ;;
  }

  dimension: store_client_type {
    label: "Pharmacy Client Type (Central)"
    description: "Specifies the type of pharmacy this record exists for"
    sql: ${TABLE}.STORE_CLIENT_TYPE ;;
  }

  dimension: store_client_version {
    label: "Pharmacy Client Version (Central)"
    description: "The current software version that the store's pharmacy application is using"
    sql: ${TABLE}.STORE_CLIENT_VERSION ;;
  }

  dimension: store_category {
    label: "Pharmacy Category (Central)"
    description: "Indicates the different buckets (Live-EPS, Live-PDX, Closed-EPR, Closed-ARS, Lookup-EPS, Lookup-PDX, Pending) a store falls-in "
    sql: ${TABLE}.STORE_CATEGORY ;;
    suggestions: [
      "Live-EPS",
      "Lookup-EPS",
      "Live-PDX",
      "Lookup-PDX",
      "Pending",
      "Unknown",
      "Non-EPR",
      "Closed-EPR",
      "Closed-ARS"
    ]
  }

  dimension_group: deactivated {
    label: "Pharmacy Deactivated (Central)"
    description: "Date/time indicating when this store record was deactivated"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.STORE_DEACTIVATED_DATE ;;
  }

  dimension: workflow_enabled_flag {
    label: "Pharmacy Workflow Enabled (Central)"
    description: "Flag indicating if this store is enabled for WORKFLOW"
    sql: ${TABLE}.STORE_WORKFLOW_ENABLED_FLAG ;;
  }

  dimension: store_address {
    label: "Pharmacy Address (Central)"
    hidden: yes
    description: "The first line of the store's address"
    sql: ${TABLE}.STORE_ADDRESS ;;
  }

  dimension: store_city {
    label: "Pharmacy City (Central)"
    sql: ${TABLE}.STORE_CITY ;;
  }

  dimension: store_state {
    label: "Pharmacy State (Central)"
    hidden: yes
    sql: ${TABLE}.STORE_STATE ;;
  }

  dimension: store_server_time_zone {
    label: "Pharmacy Time Zone (Central)"
    description: "Pharmacy Server timezone"
    sql: ${TABLE}.STORE_SERVER_TIME_ZONE ;;
  }

  dimension: store_address_deleted_flag {
    label: "Pharmacy Address Deleted Flag (Central)"
    hidden: yes
    description: "Y/N flag indicating whether or not the pharmacy has been marked as deleted"
    sql: ${TABLE}.STORE_ADDRESS_DELETED_FLAG ;;
  }

  dimension: store_registration_status {
    label: "Pharmacy Registration Status (Central)"
    description: "Registration Status of the pharmacy/store"
    sql: ${TABLE}.STORE_EPR_REGISTRATION_STATUS ;;
  }

  dimension: support_notes {
    label: "Pharmacy Support Notes (Central)"
    hidden: yes
    description: "Notes entered by the PDX support person"
    sql: ${TABLE}.STORE_SUPPORT_NOTES ;;
  }

  measure: count {
    label: "Pharmacy Count (Central)"
    type: count
    value_format: "#,##0"
    drill_fields: [store_information_drill_path*]
  }

#[ERXLPS-717]
  set: store_information_drill_path {
    fields: [
      nhin_store_id,
      store_number,
      store_name,
      rx_tx.count,
      store_client_type,
      store_client_version,
      store_category,
      store_address,
      store_city,
      store_state,
      workflow_enabled_flag,
      store_server_time_zone,
      store_registration_status
    ]
  }
}

view: ars_store_cs {
  label: "Pharmacy"
  sql_table_name: ARS.STORES ;;

  dimension: nhin_store_id {
    primary_key: yes
    label: "Pharmacy NHIN Store ID"
    type: number
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    sql: CAST(${TABLE}.NHINID AS NUMBER) ;;
  }

  dimension: store_id {
    hidden: yes
    type: number
    description: "Unique store id in ARS system. Auto-Assigned by the ARS system"
    sql: ${TABLE}.ID ;;
  }

  dimension: store_number {
    label: "Pharmacy Number"
    description: "Pharmacy/Store number assigned by the customer that identifies the store within its chain"
    type: string
    sql: ${TABLE}.STORE_NUMBER ;;
  }

  dimension: store_name {
    label: "Pharmacy Name"
    description: "The name of the pharmacy/store"
    type: string
    sql: UPPER(${TABLE}.NAME) ;;
  }

  dimension: ncpdp_number {
    label: "Pharmacy NCPDP Number"
    description: "National Council for Prescription Drug Programs (NCPDP) number assigned to the Pharmacy"
    type: string
    sql: ${TABLE}.NCPDP ;;
  }

  dimension: npi_number {
    label: "Pharmacy NPI Number"
    description: "National Provider Identifier number assigned to the pharmacy"
    type: string
    sql: ${TABLE}.NPI ;;
  }

  dimension: client_type {
    label: "Pharmacy Client Type"
    description: "Specifies the type of pharmacy this record exists for"
    type: string
    sql: ${TABLE}.CLIENT_TYPE ;;
  }

  dimension: client_version {
    label: "Pharmacy Client Version"
    description: "The current software version that the store's pharmacy application is using"
    type: string
    sql: ${TABLE}.CLIENT_VERSION ;;
  }

  dimension_group: deactivated_date {
    label: "Pharmacy Deactivated"
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
    sql: ${TABLE}.DEACTIVATED_DATE ;;
  }

  dimension: workflow_enabled_flag {
    label: "Pharmacy Workflow Enabled Flag"
    description: "Flag indicating if this store is enabled for WORKFLOW"
    type: string
    sql: ${TABLE}.WORKFLOW_ENABLED ;;
  }

  measure: count {
    label: "Pharmacy Count"
    type: count
    value_format: "#,##0"
    drill_fields: [
      nhin_store_id,
      store_number,
      store_name,
      client_type,
      client_version,
      workflow_enabled_flag,
      ncpdp_number,
      npi_number
    ]
  }
}

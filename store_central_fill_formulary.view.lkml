view: store_central_fill_formulary {
  label: "Store Central Fill Formulary"
  sql_table_name: EDW.D_STORE_CENTRAL_FILL_FORMULARY ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_central_fill_formulary_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN. EPS Table Name: CF_FORMULARY"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table Name: CF_FORMULARY"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_central_fill_formulary_id {
    label: "Store Central Fill Formulary Id"
    description: "Unique Id number identifying this record. EPS Table Name: CF_FORMULARY"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table Name: CF_FORMULARY"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: store_central_fill_formulary_effective {
    label: "Store Central Fill Formulary Effective"
    description: "Date a central fill formulary record becomes effective. EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_EFFECTIVE_DATE ;;
  }

  dimension_group: store_central_fill_formulary_deactivate {
    label: "Store Central Fill Formulary Deactivate"
    description: "Date a central fill formulary record was deactivated. EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_DEACTIVATE_DATE ;;
  }

  dimension: store_central_fill_formulary_type_reference {
    label: "Store Central Fill Formulary Type"
    description: "Type of formulary record, Store or Home Delivery (CF or Mail). M = Mail/Home Delivery C = Central Fill/Store Delivery. EPS Table Name: CF_FORMULARY"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_TYPE ;;
  }

  dimension: store_central_fill_formulary_type {
    label: "Store Central Fill Formulary Type"
    description: "Type of formulary record, Store or Home Delivery (CF or Mail). M = Mail/Home Delivery C = Central Fill/Store Delivery. EPS Table Name: CF_FORMULARY"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_ID IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_TYPE IS NULL THEN 'NULL - UNKNOWN' --NULL is one of the master code value in D_MASTER_CODE table.
              WHEN ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_TYPE = 'M' THEN 'M - MAIL/HOME DELIVERY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_TYPE = 'C' THEN 'C - CENTRAL FILL/ STORE DELIVERY'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: [
      "NULL - UNKNOWN",
      "M - MAIL/HOME DELIVERY",
      "C - CENTRAL FILL/ STORE DELIVERY"
    ]
    suggest_persist_for: "24 hours"
    drill_fields: [store_central_fill_formulary_type_reference]
  }

  dimension: store_central_fill_formulary_ndc {
    label: "Store Central Fill Formulary NDC"
    description: "National Drug Code used as an universal product identifier for human drugs. EPS Table Name: CF_FORMULARY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FORMULARY_NDC ;;
  }

  dimension_group: source_create {
    label: "Store Central Fill Formulary Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis. EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source {
    label: "Store Central Fill Formulary Source Update"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis.EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW. EPS Table Name: CF_FORMULARY"
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW. EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW. EPS Table Name: CF_FORMULARY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW. EPS Table Name: CF_FORMULARY"
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

############################################################ END OF DIMENSIONS ############################################################
}

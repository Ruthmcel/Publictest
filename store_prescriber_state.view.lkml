view: store_prescriber_state {
  label: "Store Prescriber State"
  sql_table_name: EDW.D_STORE_PRESCRIBER_STATE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_prescriber_state_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PRESCRIBER_STATE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PRESCRIBER_STATE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_prescriber_state_id {
    label: "Store Prescriber State Id"
    description: "Unique Id number identifying this record. EPS Table: PRESCRIBER_STATE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table: PRESCRIBER_STATE"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_prescriber_state_state {
    label: "Store Prescriber State State"
    description: "State or province code indicating the licensing state or province of a prescriber state record. EPS Table: PRESCRIBER_STATE"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_STATE ;;
  }

  dimension: store_prescriber_state_medicaid_number {
    label: "Store Prescriber State Medicaid Number"
    description: "Prescriber Medicaid ID number for a specific state. Prescriber will only have one Medicaid ID per state. EPS Table: PRESCRIBER_STATE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_MEDICAID_NUMBER ;;
  }

  dimension: store_prescriber_state_state_license_number {
    label: "Store Prescriber State State License Number"
    description: "Prescriber state license ID number for a specific state. EPS Table: PRESCRIBER_STATE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_STATE_LICENSE_NUMBER ;;
  }

  dimension_group: store_prescriber_state_deactivate {
    label: "Store Prescriber State Deactivate"
    description: "Date/Time that a prescriber state record was deactivated. EPS Table: PRESCRIBER_STATE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_DEACTIVATE_DATE ;;
  }

  dimension: store_prescriber_state_other_state_number {
    label: "Store Prescriber State Other State Number"
    description: "Currently only displayed in the UI when the state equals TX. This is used to store other state specific ID numbers a prescriber might have. EPS Table: PRESCRIBER_STATE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_STATE_OTHER_STATE_NUMBER ;;
  }

  dimension: store_prescriber_state_other_state_number_type {
    label: "Store Prescriber State Other State Number Type"
    description: "Describes the type of number entered in the other state number column. EPS Table: PRESCRIBER_STATE"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_STATE_OTHER_STATE_NUMBER_TYPE is null THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PRESCRIBER_STATE_OTHER_STATE_NUMBER_TYPE = '1' THEN '1 - TEXAS DPS'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_STATE_OTHER_STATE_NUMBER_TYPE)
         END ;;
  }

  dimension: store_prescriber_id {
    label: "Store Prescriber Id"
    description: "ID of the prescriber record associated with a prescriber state record. EPS Table: PRESCRIBER_STATE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Prescriber State Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: PRESCRIBER_STATE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Prescriber State Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PRESCRIBER_STATE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

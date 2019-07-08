view: store_prescriber_specialty_code {
  label: "Store Prescriber Specialty Code"
  sql_table_name: EDW.D_STORE_PRESCRIBER_SPECIALTY_CODE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_prescriber_specialty_code_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_prescriber_specialty_code_id {
    label: "Store Prescriber Specialty Code Id"
    description: "Unique Id number identifying this record. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_SPECIALTY_CODE_ID ;;
  }

  dimension: store_prescriber_specialty_code {
    label: "Store Prescriber Specialty Code"
    description: "Code representing the prescribers specialty. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_SPECIALTY_CODE ;;
  }

  dimension: store_prescriber_specialty_code_description {
    label: "Store Prescriber Specialty Code Description"
    description: "Brief description of the prescriber specialty. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_SPECIALTY_CODE_DESCRIPTION ;;
  }

  dimension_group: source_timestamp {
    label: "Store Prescriber Specialty Code Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PRESCRIBER_SPECIALTY_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

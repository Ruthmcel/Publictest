view: store_call_insurance {
  label: "Store Call Insurance"
  sql_table_name: EDW.F_STORE_CALL_INSURANCE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_insurance_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_INSURANCE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_INSURANCE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_insurance_id {
    label: "Store Call Insurance Id"
    description: "Unique ID number identifying a call insurance record. EPS Table: CALL_INSURANCE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_ID ;;
  }

  dimension: plan_id {
    label: "Plan Id"
    description: "Unique ID number identifying the plan record associated with the transaction being called on. EPS Table: CALL_INSURANCE"
    type: number
    hidden: yes
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: store_call_insurance_number_of_attempts {
    label: "Store Call Insurance Number Of Attempts"
    description: "Maximum number of attempts to make using preferred contact method before desisting entirely or making final attempt using alternative contact method e.g. email versus telephone. EPS Table: CALL_INSURANCE"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_NUMBER_OF_ATTEMPTS ;;
  }

  dimension: store_call_insurance_status {
    label: "Store Call Insurance Status"
    description: "Indicates status of this Call Insurance task. EPS Table: CALL_INSURANCE"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_STATUS ;;
  }

  dimension: store_call_insurance_message_to_insurance {
    label: "Store Call Insurance Message To Insurance"
    description: "Message for insurance company concerning this prescription. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_MESSAGE_TO_INSURANCE ;;
  }

  dimension: store_call_insurance_patient_last_name {
    label: "Store Call Insurance Patient Last Name"
    description: "Patient last name for the prescription being called on. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PATIENT_LAST_NAME ;;
  }

  dimension: store_call_insurance_patient_first_name {
    label: "Store Call Insurance Patient First Name"
    description: "Patient first name for the prescription being called on. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PATIENT_FIRST_NAME ;;
  }

  dimension: store_call_insurance_prescriber_last_name {
    label: "Store Call Insurance Prescriber Last Name"
    description: "Prescriber last name for the prescription record being called on. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_call_insurance_prescriber_first_name {
    label: "Store Call Insurance Prescriber First Name"
    description: "Prescriber first name for the prescription being called on. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_call_insurance_drug_name {
    label: "Store Call Insurance Drug Name"
    description: "Drug name for the prescription being called on. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_DRUG_NAME ;;
  }

  dimension: store_call_insurance_point_of_contact_name {
    label: "Store Call Insurance Point Of Contact Name"
    description: "POC (Point of Contact) name. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_POINT_OF_CONTACT_NAME ;;
  }

  dimension: store_call_insurance_message_from_insurance {
    label: "Store Call Insurance Message From Insurance"
    description: "Free format information from insurance company. EPS Table: CALL_INSURANCE"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_MESSAGE_FROM_INSURANCE ;;
  }

  dimension: store_call_insurance_source_type {
    label: "Store Call Insurance Source Type"
    description: "Place where the call insurance record was generated. EPS Table: CALL_INSURANCE"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_SOURCE_TYPE ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_call_insurance_point_of_contact_phone_id {
    label: "Store Call Insurance Point Of Contact Phone Id"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_POINT_OF_CONTACT_PHONE_ID ;;
  }

  dimension_group: store_call_insurance_completed {
    label: "Store Call Insurance Completed"
    description: "Date/Time the call insurance task was completed. EPS Table: CALL_INSURANCE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CALL_INSURANCE_COMPLETED_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Insurance Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_INSURANCE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

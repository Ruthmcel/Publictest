### This is a template and need review. Look for US with label Looker_view and Looker_exposein JIRA. All labels, descriptions, labels, Master_code Values needs review. Measures need to be added as per business requirements. Add source_table_name in the description. This comment should be removed once the view file is completed.#####
view: temp_store_call_insurance {
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
    description: "Identification number assinged to each customer chain by NHIN. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_insurance_id {
    label: "Store Call Insurance Id"
    description: "Unique ID number identifying a call insurance record. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_ID ;;
  }

  dimension: plan_id {
    label: "Plan Id"
    description: "Unique ID number identifying the plan record associated with the transaction being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: store_call_insurance_number_of_attempts {
    label: "Store Call Insurance Number Of Attempts"
    description: "Maximum number of attempts to make using preferred contact method (see PATIENT.CONTACT_PREF) before desisting entirely or making final attempt using alternative contact method e.g. email versus telephone. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_NUMBER_OF_ATTEMPTS ;;
  }

  dimension: store_call_insurance_status {
    label: "Store Call Insurance Status"
    description: "Indicates status of this Call Insurance task. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_STATUS ;;
  }

  dimension: store_call_insurance_message_to_insurance {
    label: "Store Call Insurance Message To Insurance"
    description: "Message for insurance company concerning this prescription. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_MESSAGE_TO_INSURANCE ;;
  }

  dimension: store_call_insurance_patient_last_name {
    label: "Store Call Insurance Patient Last Name"
    description: "Patient last name for the prescription being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PATIENT_LAST_NAME ;;
  }

  dimension: store_call_insurance_patient_first_name {
    label: "Store Call Insurance Patient First Name"
    description: "Patient first name for the prescription being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PATIENT_FIRST_NAME ;;
  }

  dimension: store_call_insurance_prescriber_last_name {
    label: "Store Call Insurance Prescriber Last Name"
    description: "Prescriber last name for the prescription record being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_call_insurance_prescriber_first_name {
    label: "Store Call Insurance Prescriber First Name"
    description: "Prescriber first name for the prescription being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_call_insurance_drug_name {
    label: "Store Call Insurance Drug Name"
    description: "Drug name for the prescription being called on. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_DRUG_NAME ;;
  }

  dimension: store_call_insurance_point_of_contact_name {
    label: "Store Call Insurance Point Of Contact Name"
    description: "POC (Point of Contact) name. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_POINT_OF_CONTACT_NAME ;;
  }

  dimension: store_call_insurance_message_from_insurance {
    label: "Store Call Insurance Message From Insurance"
    description: "Free format information from insurance company. [SOURCE_SYSTEM_TABLE_NAME]"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_MESSAGE_FROM_INSURANCE ;;
  }

  dimension: store_call_insurance_source_type {
    label: "Store Call Insurance Source Type"
    description: "place where the call insurance record was generated. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    sql: ${TABLE}.STORE_CALL_INSURANCE_SOURCE_TYPE ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "place where the call insurance record was generated. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_call_insurance_point_of_contact_phone_id {
    label: "Store Call Insurance Point Of Contact Phone Id"
    description: "foreign key to the phone table. For the phone number the user should use to call the insurance company. [SOURCE_SYSTEM_TABLE_NAME]"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_POINT_OF_CONTACT_PHONE_ID ;;
  }

  dimension_group: store_call_insurance_completed_date {
    label: "Store Call Insurance Completed Date"
    description: "Date the call insurance task was completed. [SOURCE_SYSTEM_TABLE_NAME]"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CALL_INSURANCE_COMPLETED_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time at which the record was last updated in the source application. [SOURCE_SYSTEM_TABLE_NAME]"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

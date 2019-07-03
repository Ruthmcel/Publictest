view: ar_transaction_patient {
  label: "Transaction Patient"
  sql_table_name: EDW.F_TRANSACTION_PATIENT ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id}||'@'||${transaction_id} ;;
  }

  dimension: chain_id {
    type: number
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_id {
    type: number
    label: "Claim ID"
    description: "Unique ID of the TRANSACTION_STATUS table record for this claim"
    hidden: yes
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: source_system_id {
    type: number
    label: "EDW Source System Identifier"
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: transaction_patient_address {
    label: "Patient Address Line 1"
    description: "Address Line 1 of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_ADDRESS ;;
  }

  dimension: transaction_patient_address_line2 {
    label: "Patient Address Line 2"
    description: "Address Line 2 of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_ADDRESS_LINE2 ;;
  }

  dimension: transaction_patient_city {
    label: "Patient City"
    description: "City of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_CITY ;;
  }

  dimension: transaction_patient_state {
    label: "Patient State"
    description: "State of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_STATE ;;
  }

  dimension: transaction_patient_zip_code {
    label: "Patient Zip Code"
    description: "Zip Code of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_ZIP_CODE ;;
  }

  dimension: transaction_patient_phone_number {
    label: "Patient Phone Number"
    description: "Phone number of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_PHONE_NUMBER ;;
  }

  dimension: transaction_patient_social_security_number {
    label: "Patient Social Security Number"
    description: "Social Security Number of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_SOCIAL_SECURITY_NUMBER ;;
  }

  dimension: transaction_patient_gender {
    label: "Patient Gender"
    description: "Gender of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_GENDER ;;
  }

  dimension: transaction_patient_medical_record_number {
    label: "Patient Medical Record Number"
    description: "Medical Record Number of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_MEDICAL_RECORD_NUMBER ;;
  }

  dimension: transaction_patient_marital_status {
    label: "Patient Marital Status"
    description: "Marital Status of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_MARITAL_STATUS ;;
  }

  dimension: transaction_patient_rx_com_id {
    label: " Patient Rx.com ID"
    description: "Rx.com ID of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_RX_COM_ID ;;
  }

  dimension: transaction_patient_medigap_identifier {
    label: "Patient Medigap ID"
    description: "Medigap ID of the patient for this claim"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_MEDIGAP_IDENTIFIER ;;
  }

  dimension_group: source_create_timestamp {
    type: time
    hidden:  yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    description: "Date and time the record was added to the AR database"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: transaction_patient_added_user_identifier {
    description: "User who added the record to the AR database"
    type: string
    hidden:  yes
    sql: ${TABLE}.TRANSACTION_PATIENT_ADDED_USER_IDENTIFIER ;;
  }

  dimension: transaction_patient_last_updated_user_identifier {
    type: string
    hidden:  yes
    description: "User that last updated the record"
    sql: ${TABLE}.TRANSACTION_PATIENT_LAST_UPDATED_USER_IDENTIFIER ;;
  }

  dimension: transaction_patient_deleted {
    type: string
    hidden:  yes
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table."
    sql: ${TABLE}.TRANSACTION_PATIENT_DELETED ;;
  }

  measure: state_count {
    type: count
    drill_fields: [transaction_patient_state]
    hidden: yes
  }
  measure: count_state_patient {
    type: count_distinct
    label: "State Patient Count"
    description: "State Patient count associated with claims. Use this measure along with state to get the correct results."
    sql: ${chain_id}||'@'||${transaction_id}||'@'||${transaction_patient_state} ;;
    value_format: "#,###"
    hidden: yes
  }

####################################### EDW Metadata Fields  ##############################################################################################################


  dimension: transaction_patient_lcr_id {
    type: number
    hidden:  yes
    label: "Audit Event LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.TRANSACTION_PATIENT_LCR_ID ;;
  }

  dimension_group: source_timestamp {
    hidden:  yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: event_id {
    type: number
    hidden:  yes
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden:  yes
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden:  yes
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

}

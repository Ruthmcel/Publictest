view: store_call_pharmacy {
  label: "Store Call Pharmacy"
  sql_table_name: EDW.F_STORE_CALL_PHARMACY ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_pharmacy_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_PHARMACY"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_PHARMACY"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_pharmacy_id {
    label: "Store Call Pharmacy Id"
    description: "Unique ID number identifying a call pharmacy record. EPS Table: CALL_PHARMACY"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PHARMACY_ID ;;
  }

  dimension: pharmacy_id {
    label: "Pharmacy Id"
    description: "Unique ID number identifying the PHARMACY record associated with the subject line item. EPS Table: CALL_PHARMACY"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_ID ;;
  }

  dimension: store_call_pharmacy_number_of_attempts {
    label: "Store Call Pharmacy Number Of Attempts"
    description: "Maximum number of attempts to make using preferred contact method before desisting entirely or making final attempt using alternative contact method e.g. email versus telephone. EPS Table: CALL_PHARMACY"
    type: number
    sql: ${TABLE}.STORE_CALL_PHARMACY_NUMBER_OF_ATTEMPTS ;;
  }

  dimension: store_call_pharmacy_status {
    label: "Store Call Pharmacy Status"
    description: "Indicates current status of this Call Pharmacy task. EPS Table: CALL_PHARMACY"
    type: number
    sql: ${TABLE}.STORE_CALL_PHARMACY_STATUS ;;
  }

  dimension: store_call_pharmacy_message_to_pharmacist {
    label: "Store Call Pharmacy Message To Pharmacist"
    description: "Message for pharmacist concerning this prescription transfer request. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_MESSAGE_TO_PHARMACIST ;;
  }

  dimension: store_call_pharmacy_patient_last_name {
    label: "Store Call Pharmacy Patient Last Name"
    description: "Last name of the patient for whom this transfer is being requested. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_PATIENT_LAST_NAME ;;
  }

  dimension: store_call_pharmacy_patient_first_name {
    label: "Store Call Pharmacy Patient First Name"
    description: "Last name of the patient for whom this transfer is being requested. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_PATIENT_FIRST_NAME ;;
  }

  dimension: store_call_pharmacy_prescriber_last_name {
    label: "Store Call Pharmacy Prescriber Last Name"
    description: "Last Name of prescriber Used. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_call_pharmacy_prescriber_first_name {
    label: "Store Call Pharmacy Prescriber First Name"
    description: "First Name of prescriber Used. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_call_pharmacy_call_back_last_name {
    label: "Store Call Pharmacy Call Back Last Name"
    description: "Pharmacy Call Back Last Name. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_CALL_BACK_LAST_NAME ;;
  }

  dimension: store_call_pharmacy_call_back_first_name {
    label: "Store Call Pharmacy Call Back First Name"
    description: "Pharmacy Call Back First Name. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_CALL_BACK_FIRST_NAME ;;
  }

  dimension: store_call_pharmacy_point_of_contact_name {
    label: "Store Call Pharmacy Point Of Contact Name"
    description: "POC (Point of Contact) name from the Pharmacy record. EPS Table: CALL_PHARMACY"
    type: string
    sql: ${TABLE}.STORE_CALL_PHARMACY_POINT_OF_CONTACT_NAME ;;
  }

  dimension: store_call_pharmacy_source_type {
    label: "Store Call Pharmacy Source Type"
    description: "Screen/Process that created the Call Pharmacy record. EPS Table: CALL_PHARMACY"
    type: number
    sql: ${TABLE}.STORE_CALL_PHARMACY_SOURCE_TYPE ;;
  }

  dimension: store_call_pharmacy_point_of_contact_phone_id {
    label: "Store Call Pharmacy Point Of Contact Phone Id"
    description: "foreign key to the ID of the phone record that displays for the user to call. EPS Table: CALL_PHARMACY"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PHARMACY_POINT_OF_CONTACT_PHONE_ID ;;
  }

  dimension_group: store_call_pharmacy_completed {
    label: "Store Call Pharmacy Completed"
    description: "Date/Time of pharmacy call was marked as completed. EPS Table: CALL_PHARMACY"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CALL_PHARMACY_COMPLETED_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Pharmacy Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_PHARMACY"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

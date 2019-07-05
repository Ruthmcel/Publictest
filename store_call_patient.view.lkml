view: store_call_patient {
  label: "Store Call Patient"
  sql_table_name: EDW.F_STORE_CALL_PATIENT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_patient_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_patient_id {
    label: "Store Call Patient Id"
    description: "Unique ID number identifying a call patient record. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PATIENT_ID ;;
  }

  dimension: store_call_patient_manual_call {
    label: "Store Call Patient Manual Call"
    description: "Indicates whether call task will be presented to a user to manually place the call or not. EPS Table: CALL_PATIENT"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PATIENT_MANUAL_CALL = '0' THEN '0 - NO'
              WHEN ${TABLE}.STORE_CALL_PATIENT_MANUAL_CALL = '1' THEN '1 - YES'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PATIENT_MANUAL_CALL)
         END ;;
  }

  dimension: store_call_patient_number_of_attempts {
    label: "Store Call Patient Number Of Attempts"
    description: "Maximum number of attempts to make using preferred contact method before desisting entirely or making final attempt using alternative contact method e.g. email versus telephone. EPS Table: CALL_PATIENT"
    type: number
    sql: ${TABLE}.STORE_CALL_PATIENT_NUMBER_OF_ATTEMPTS ;;
  }

  dimension: store_call_patient_status {
    label: "Store Call Patient Status"
    description: "Indicates status of this Call Patient task. EPS Table: CALL_PATIENT"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '0' THEN '0 - PENDING NOT YET CALLED'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '1' THEN '1 - LEFT MESSAGE AWAITING  REQUIRED REPLY'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '2' THEN '2 - MADE CONTACT AWAITING CALLBACK'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '3' THEN '3 - COMPLETE CALLED NO REPLY  REQUIRED'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '4' THEN '4 - COMPLETE MET MAXIMUM ATTEMPTS'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '5' THEN '5 - COMPLETE REQUIRE REPLY RECEIVED'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '6' THEN '6 - CANCELLED'
              WHEN ${TABLE}.STORE_CALL_PATIENT_STATUS = '7' THEN '7 - RESOLVED PENDING'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PATIENT_STATUS)
         END ;;
  }

  dimension: store_call_patient_message_to_patient {
    label: "Store Call Patient Message To Patient"
    description: "Message for patient concerning this prescription. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_MESSAGE_TO_PATIENT ;;
  }

  dimension: store_call_patient_last_name {
    label: "Store Call Patient Last Name"
    description: "Patient last name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_LAST_NAME ;;
  }

  dimension: store_call_patient_first_name {
    label: "Store Call Patient First Name"
    description: "Patient first name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_FIRST_NAME ;;
  }

  dimension: store_call_patient_prescriber_last_name {
    label: "Store Call Patient Prescriber Last Name"
    description: "Prescriber last name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_call_patient_prescriber_first_name {
    label: "Store Call Patient Prescriber First Name"
    description: "Prescriber first name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_call_patient_drug_name {
    label: "Store Call Patient Drug Name"
    description: "Drug name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_DRUG_NAME ;;
  }

  dimension: store_call_patient_poc_name {
    label: "Store Call Patient Poc Name"
    description: "Point of contact name. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_POC_NAME ;;
  }

  dimension: store_call_patient_message_from_patient {
    label: "Store Call Patient Message From Patient"
    description: "Information from patient. EPS Table: CALL_PATIENT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_MESSAGE_FROM_PATIENT ;;
  }

  dimension: store_call_patient_source_type {
    label: "Store Call Patient Source Type"
    description: "Screen/Process that created the Call Patient record. EPS Table: CALL_PATIENT"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '0' THEN '0 - REFILL DENIAL'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '1' THEN '1 - DATA ENTRY'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '2' THEN '2 - ORDER ENTRY'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '3' THEN '3 - PATIENT MAINTENANCE'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '4' THEN '4 - DATA VERIFICATION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '5' THEN '5 - DATE VERIFICATION2'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '6' THEN '6 - FILL'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '7' THEN '7 - PRODUCT VERIFICATION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '8' THEN '8 - MO PATIENT EXCEPTION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '9' THEN '9 - MANUAL CC CHARGE APPROVAL'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '10' THEN '10 - ESCRIPT DATA ENTRY'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '11' THEN '11 - RPH VERIFICATION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '12' THEN '12 - RX FILLING'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '13' THEN '13 - TP EXCEPTION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '14' THEN '14 - REFILL REQUEST'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '15' THEN '15 - NEW RX REQUEST'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '16' THEN '16 - TRANSFER'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '17' THEN '17 - ESCRIPT'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '18' THEN '18 - NEW REQUEST DENIAL'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '19' THEN '19 - PAYMENT AUTHORIZATION EXCEPTION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '20' THEN '20 - PAYMENT SETTLEMENT EXCEPTION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '21' THEN '21 - DOWNTIME TP EXCEPTION'
              WHEN ${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE = '22' THEN '22 - FULFILLMENT EXCEPTION'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PATIENT_SOURCE_TYPE)
         END ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "Transaction ID of the prescription being call for. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_call_patient_point_of_contact_phone_id {
    label: "Store Call Patient Point Of Contact Phone Id"
    description: "Unique ID number identifying a phone record associated with the call patient record. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PATIENT_POINT_OF_CONTACT_PHONE_ID ;;
  }

  dimension: mtm_patient_session_id {
    label: "Mtm Patient Session Id"
    description: "Unique ID number identifying MTM session associated with the Patient over the phone. EPS Table: CALL_PATIENT"
    type: number
    hidden: yes
    sql: ${TABLE}.MTM_PATIENT_SESSION_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Call Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: CALL_PATIENT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_PATIENT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

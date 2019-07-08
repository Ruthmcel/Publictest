view: store_call_patient_contact {
  label: "Store Call Patient Contact"
  sql_table_name: EDW.F_STORE_CALL_PATIENT_CONTACT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_patient_contact_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_PATIENT_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_PATIENT_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_patient_contact_id {
    label: "Store Call Patient Contact Id"
    description: "Unique ID number identifying a call patient contact record. EPS Table: CALL_PATIENT_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_ID ;;
  }

  dimension: store_call_patient_id {
    label: "Store Call Patient Id"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PATIENT_ID ;;
  }

  dimension: store_call_patient_contact_note {
    label: "Store Call Patient Contact Note"
    description: "Patient Contact Note. EPS Table: CALL_PATIENT_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_NOTE ;;
  }

  dimension: store_call_patient_contact_name {
    label: "Store Call Patient Contact Name"
    description: "Patient Contact Name. EPS Table: CALL_PATIENT_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_NAME ;;
  }

  dimension: store_call_patient_contact_method {
    label: "Store Call Patient Contact Method"
    description: "Patient Contact Method. EPS Table: CALL_PATIENT_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_METHOD ;;
  }

  dimension: store_call_patient_contact_phone_id {
    label: "Store Call Patient Contact Phone Id"
    description: "Patient Contact Phone Id. EPS Table: CALL_PATIENT_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_PHONE_ID ;;
  }

  dimension: store_call_patient_contact_caller_user_login {
    label: "Store Call Patient Contact Caller User Login"
    description: "Login code for the user that peformed this specific contact for the call patient record. EPS Table: CALL_PATIENT_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_CALLER_USER_LOGIN ;;
  }

  dimension: store_call_patient_contact_caller_employee_number {
    label: "Store Call Patient Contact Caller Employee Number"
    description: "Employee number of the user working on the task. EPS Table: CALL_PATIENT_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PATIENT_CONTACT_CALLER_EMPLOYEE_NUMBER ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Call Contact Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: CALL_PATIENT_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Contact Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_PATIENT_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

view: store_call_insurance_contact {
  label: "Store Call Insurance Contact"
  sql_table_name: EDW.F_STORE_CALL_INSURANCE_CONTACT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_insurance_contact_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_INSURANCE_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_INSURANCE_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_insurance_contact_id {
    label: "Store Call Insurance Contact Id"
    description: "Unique ID number identifying a call_insurance_contact record. EPS Table: CALL_INSURANCE_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_ID ;;
  }

  dimension: store_call_insurance_id {
    label: "Store Call Insurance Id"
    description: "Foreign key to associated call insurance record in CALL_INSURANCE table. EPS Table: CALL_INSURANCE_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_ID ;;
  }

  dimension: store_call_insurance_contact_note {
    label: "Store Call Insurance Contact Note"
    description: "Free format note for the user to make any notes about the interactions with the insurance company during this particular contact attempt. EPS Table: CALL_INSURANCE_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_NOTE ;;
  }

  dimension: store_call_insurance_contact_name {
    label: "Store Call Insurance Contact Name"
    description: "Name of the person at the insurance company that the user talked to. EPS Table: CALL_INSURANCE_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_NAME ;;
  }

  dimension: store_call_insurance_contact_phone_id {
    label: "Store Call Insurance Contact Phone Id"
    description: "Foreign key to the PHONE table for the phone number that was called for this contact record. EPS Table: CALL_INSURANCE_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_PHONE_ID ;;
  }

  dimension: store_call_insurance_contact_caller_user_login {
    label: "Store Call Insurance Contact Caller User Login"
    description: "Login code for the user that contacted the insurance. EPS Table: CALL_INSURANCE_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_CALLER_USER_LOGIN ;;
  }

  dimension: store_call_insurance_contact_caller_employee_number {
    label: "Store Call Insurance Contact Caller Employee Number"
    description: "Employee number of the user working on the task. EPS Table: CALL_INSURANCE_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_INSURANCE_CONTACT_CALLER_EMPLOYEE_NUMBER ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Call Insurance Contact Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: CALL_INSURANCE_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Insurance Contact Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_INSURANCE_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

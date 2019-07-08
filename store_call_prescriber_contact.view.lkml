view: store_call_prescriber_contact {
  label: "Store Call Prescriber Contact"
  sql_table_name: EDW.F_STORE_CALL_PRESCRIBER_CONTACT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_prescriber_contact_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_prescriber_contact_id {
    label: "Store Call Prescriber Contact Id"
    description: "Unique ID number identifying a prescriber record. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_ID ;;
  }

  dimension: store_call_prescriber_id {
    label: "Store Call Prescriber Id"
    description: "Foreign key to associated call prescriber record in CALL_PRESCRIBER table. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_ID ;;
  }

  dimension: store_call_prescriber_contact_method {
    label: "Store Call Prescriber Contact Method"
    description: "Method used to contact the prescriber. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD = 'F' THEN 'F - FAX'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD = 'P' THEN 'P - PHONE'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD = 'E' THEN 'E - ESCRIPT'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD = 'R' THEN 'R - RESCHEDULED'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD = 'X' THEN 'X - ERX FAX'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_METHOD)
         END ;;
  }

  dimension: store_call_prescriber_contact_call_task_note {
    label: "Store Call Prescriber Contact Call Task Note"
    description: "Prescriber Contact Call Task Note. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_CALL_TASK_NOTE ;;
  }

  dimension: store_call_prescriber_contact_caller_user_login {
    label: "Store Call Prescriber Contact Caller User Login"
    description: "Prescriber Contact Caller User Login. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_CALLER_USER_LOGIN ;;
  }

  dimension: store_call_prescriber_contact_point_of_contact_name {
    label: "Store Call Prescriber Contact Point Of Contact Name"
    description: "Point Of Contact Name. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_POINT_OF_CONTACT_NAME ;;
  }

  dimension: store_call_prescriber_contact_request_contact {
    label: "Store Call Prescriber Contact Request Contact"
    description: "Prescriber Request Contact. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_REQUEST_CONTACT ;;
  }

  dimension: phone_id {
    label: "Phone Id"
    type: number
    hidden: yes
    sql: ${TABLE}.PHONE_ID ;;
  }

  dimension: store_call_prescriber_contact_caller_employee_number {
    label: "Store Call Prescriber Contact Caller Employee Number"
    description: "Caller Employee Number. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CONTACT_CALLER_EMPLOYEE_NUMBER ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Call Prescriber Contact Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Prescriber Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_PRESCRIBER_CONTACT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

view: store_call_prescriber {
  label: "Store Call Prescriber"
  sql_table_name: EDW.F_STORE_CALL_PRESCRIBER ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_call_prescriber_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CALL_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CALL_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_call_prescriber_id {
    label: "Store Call Prescriber Id"
    description: "Unique ID number identifying a patient record. EPS Table: CALL_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_ID ;;
  }

  dimension: store_call_prescriber_approval_contact {
    label: "Store Call Prescriber Approval Contact"
    description: "Name of person from Prescribers office that notified the pharmacy of the refill approval. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_APPROVAL_CONTACT ;;
  }

  dimension: store_call_prescriber_approved_status {
    label: "Store Call Prescriber Approved Status"
    description: "Status of the request from the prescriber. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PRESCRIBER_APPROVED_STATUS = '0' THEN '0 - PENDING'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_APPROVED_STATUS = '1' THEN '1 - APPROVED'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_APPROVED_STATUS = '2' THEN '2 - DENIED'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PRESCRIBER_APPROVED_STATUS)
         END ;;
  }

  dimension: store_call_prescriber_status {
    label: "Store Call Prescriber Status"
    description: "Indicates the current status of this Call Prescriber task. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '0' THEN '0 - PENDING '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '1' THEN '1 - CONTACTED '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '2' THEN '2 - DENIED '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '3' THEN '3 - APPROVED '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '4' THEN '4 - FAX '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '5' THEN '5 - RESCHEDULED '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '6' THEN '6 - CHG. CLINIC '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '7' THEN '7 - RX CHANGED '
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_STATUS = '8' THEN '8 - ESCRIPT '
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PRESCRIBER_STATUS)
         END ;;
  }

  dimension: store_call_prescriber_fax_notes {
    label: "Store Call Prescriber Fax Notes"
    description: "Notes user entered during OE. These notes are sent to Prescriber on the fax refill request. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_FAX_NOTES ;;
  }

  dimension: store_call_prescriber_message_to_patient {
    label: "Store Call Prescriber Message To Patient"
    description: "Text of message for patient that the prescriber wants relayed to patient. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_MESSAGE_TO_PATIENT ;;
  }

  dimension: store_call_prescriber_last_name {
    label: "Store Call Prescriber Last Name"
    description: "Prescriber's last name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_call_prescriber_first_name {
    label: "Store Call Prescriber First Name"
    description: "Prescriber's first name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_call_prescriber_message_to_prescriber {
    label: "Store Call Prescriber Message To Prescriber"
    description: "Prescriber Message To Prescriber. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_MESSAGE_TO_PRESCRIBER ;;
  }

  dimension: store_call_prescriber_point_of_contact_name {
    label: "Store Call Prescriber Point Of Contact Name"
    description: "Prescriber POC (Point of Contact) name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_POINT_OF_CONTACT_NAME ;;
  }

  dimension: store_call_prescriber_callback_name {
    label: "Store Call Prescriber Callback Name"
    description: "Prescriber Callback Name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_CALLBACK_NAME ;;
  }

  dimension: store_call_prescriber_source_type {
    label: "Store Call Prescriber Source Type"
    description: "Prescriber Source Type. EPS Table: CALL_PRESCRIBER"
    type: number
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_SOURCE_TYPE ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_call_prescriber_is_exception {
    label: "Store Call Prescriber Is Exception"
    description: "Flag that indicates the call prescriber record was created as an exception from another task. EPS Table: CALL_PRESCRIBER"
    type: number
    sql: CASE WHEN ${TABLE}.STORE_CALL_PRESCRIBER_IS_EXCEPTION = '0' THEN '0 - No'
              WHEN ${TABLE}.STORE_CALL_PRESCRIBER_IS_EXCEPTION = '1' THEN '1 - Yes'
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PRESCRIBER_IS_EXCEPTION)
         END ;;
  }

  dimension: store_call_prescriber_point_of_contact_phone_id {
    label: "Store Call Prescriber Point Of Contact Phone Id"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_POINT_OF_CONTACT_PHONE_ID ;;
  }

  dimension: phone_id {
    label: "Phone Id"
    type: number
    hidden: yes
    sql: ${TABLE}.PHONE_ID ;;
  }

  dimension: store_call_prescriber_transaction_control_ref_num {
    label: "Store Call Prescriber Transaction Control Ref Num"
    description: "Prescriber Transaction Control Ref Num. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_TRANSACTION_CONTROL_REF_NUM ;;
  }

  dimension_group: store_call_prescriber_completed {
    label: "Store Call Prescriber Completed"
    description: "Prescriber Completed Date/Time. EPS Table: CALL_PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_COMPLETED_DATE ;;
  }

  dimension: store_call_prescriber_disallow_escript_retries_flag {
    label: "Store Call Prescriber Disallow Escript Retries Flag"
    description: "Prescriber Disallow Escript Retries Flag. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CALL_PRESCRIBER_DISALLOW_ESCRIPT_RETRIES_FLAG = 'N' THEN 'N - ESCRIPT RETRY '
              ELSE TO_CHAR(${TABLE}.STORE_CALL_PRESCRIBER_DISALLOW_ESCRIPT_RETRIES_FLAG)
         END ;;
  }

  dimension: store_call_prescriber_authorized_agent_last_name {
    label: "Store Call Prescriber Authorized Agent Last Name"
    description: "Prescriber Authorized Agent Last Name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_AUTHORIZED_AGENT_LAST_NAME ;;
  }

  dimension: store_call_prescriber_authorized_agent_first_name {
    label: "Store Call Prescriber Authorized Agent First Name"
    description: "Authorized Agent First Name. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_AUTHORIZED_AGENT_FIRST_NAME ;;
  }

  dimension: store_call_prescriber_authorized_agent_middle_initial {
    label: "Store Call Prescriber Authorized Agent Middle Initial"
    description: "Prescriber Authorized Agent Middle Initial. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_AUTHORIZED_AGENT_MIDDLE_INITIAL ;;
  }

  dimension_group: store_call_prescriber_refill_authorized  {
    label: "Store Call Prescriber Refill Authorized"
    description: "Prescriber Refill Authorized Date/Time. EPS Table: CALL_PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_REFILL_AUTHORIZED_DATE ;;
  }

  dimension: store_call_prescriber_refill_authorized_value {
    label: "Store Call Prescriber Refill Authorized"
    description: "Prescriber Refill Authorized. EPS Table: CALL_PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_CALL_PRESCRIBER_REFILL_AUTHORIZED ;;
  }

  dimension_group: source_timestamp {
    label: "Store Call Prescriber Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CALL_PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

view: ar_payment_event {
  label: "Payment Event"
  sql_table_name: EDW.F_PAYMENT_EVENT ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${payment_event_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: payment_event_id {
    label: "Payment Event ID"
    description: "Unique identifier linking this payment event to an Absolute AR event."
    type: number
    sql: ${TABLE}.PAYMENT_EVENT_ID ;;
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: nhin_check_number {
    label: "NHIN Check Number"
    description: "NHIN Check batch number"
    type: number
    sql: ${TABLE}.NHIN_CHECK_NUMBER ;;
    value_format: "######"
  }

  dimension: payment_event_processor_id {
    label: "Payment Event Processor ID"
    description: "Identifies the Third Party Processor carrier code"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_PROCESSOR_ID ;;
  }

  dimension: payment_event_rx_number {
    label: "Payment Event Rx Number"
    description: "Prescription (Rx) Number received on payment"
    type: number
    sql: ${TABLE}.PAYMENT_EVENT_RX_NUMBER ;;
  }

  dimension_group: payment_event_fill_date {
    label: "Payment Event Fill Date"
    description: "Fill Date (Date of Service)"
    type: time
    sql: ${TABLE}.PAYMENT_EVENT_FILL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: payment_event_carrier_internal_control_number {
    label: "Payment Event Carrier Internal Control Number"
    description: "Carrier Internal Control Number"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_CARRIER_INTERNAL_CONTROL_NUMBER ;;
  }

  dimension: payment_event_reject_code1 {
    label: "Payment Event Reject Code1"
    description: "First Reject Code"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_REJECT_CODE1 ;;
  }

  dimension: payment_event_reject_code2 {
    label: "Payment Event Reject Code2"
    description: "Second Reject Code"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_REJECT_CODE2 ;;
  }

  dimension: payment_event_reject_code3 {
    label: "Payment Event Reject Code3"
    description: "Third Reject Code"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_REJECT_CODE3 ;;
  }

  dimension: payment_event_how_received_type_id {
    label: "Payment Event How Received Type ID"
    description: "How the payment was received"
    type: number
    hidden: yes
    sql: ${TABLE}.PAYMENT_EVENT_HOW_RECEIVED_TYPE_ID ;;
  }

  dimension: payment_event_tape_number {
    label: "Payment Event Tape Number"
    description: "Electronic Remittance Advice Number"
    type: number
    sql: ${TABLE}.PAYMENT_EVENT_TAPE_NUMBER ;;
  }

  dimension: payment_event_reject_invoice_number {
    label: "Payment Event Reject Invoice Number"
    description: "Reject Invoice Number"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_REJECT_INVOICE_NUMBER ;;
  }

  dimension: payment_event_customer_batch_number {
    label: "Payment Event Customer Batch Number"
    description: "Customer Batch Number"
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_CUSTOMER_BATCH_NUMBER ;;
  }

  dimension: payment_event_user_added_identifier {
    label: "Payment Event User Added Identifier"
    description: "User that added this record to this table."
    type: number
    sql: ${TABLE}.PAYMENT_EVENT_USER_ADDED_IDENTIFIER ;;
  }

  dimension: payment_event_source_type_id {
    label: "Payment Event Source Type ID"
    description: "Payment Source"
    type: number
    hidden: yes
    sql: ${TABLE}.PAYMENT_EVENT_SOURCE_TYPE_ID ;;
  }

  dimension: deleted {
    label: "Payment Event Deleted"
    description: "Indicates if a record has been deleted in source."
    type: string
    sql: ${TABLE}.PAYMENT_EVENT_DELETED ;;
  }

  #################################################################################### Master code dimensions ############################################################################################################
  dimension: payment_event_how_received_type_id_mc {
    label: "Payment Event How Received Type"
    description: "How the payment was received"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.PAYMENT_EVENT_HOW_RECEIVED_TYPE_ID) ;;
    suggestions: [
      "CUSTOMER",
      "PAPER",
      "ELECTRONIC"
    ]
  }

  dimension: payment_event_source_type_id_mc {
    label: "Payment Event Source Type"
    description: "Payment Source"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.PAYMENT_EVENT_SOURCE_TYPE_ID) ;;
    suggestions: [
      "POSTING",
      "POSTING CORRECTION",
      "UNAPPLIED CASH",
      "POSTING - ICN MATCHING"
      ]
  }

  #################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Payment Event Tracking LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.PAYMENT_EVENT_TRACKING_LCR_ID ;;
  }

  dimension: event_id {
    hidden:  yes
    type: number
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: edw_insert_timestamp {
    hidden:  yes
    type: time
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    hidden:  yes
    type: time
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    hidden:  yes
    type: time
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

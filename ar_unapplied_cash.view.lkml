view: ar_unapplied_cash {
  view_label: "Unapplied Cash"
  sql_table_name: EDW.F_UNAPPLIED_CASH ;;


  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${unapplied_cash_id} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension_group: edw_insert_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_INSERT_TIMESTAMP" ;;
  }

  dimension_group: edw_last_update_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: event_id {
    type: number
    hidden: yes
    sql: ${TABLE}."EVENT_ID" ;;
  }

  dimension: load_type {
    type: string
    hidden: yes
    sql: ${TABLE}."LOAD_TYPE" ;;
  }

  dimension: nhin_check_number {
    type: string
    hidden: yes
    sql: ${TABLE}."NHIN_CHECK_NUMBER" ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}."NHIN_STORE_ID" ;;
  }

  dimension_group: source_create_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_CREATE_TIMESTAMP" ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_TIMESTAMP" ;;
  }

  dimension: unapplied_cash_added_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_ADDED_USER_IDENTIFIER" ;;
  }

  dimension: unapplied_cash_batch_number {
    label: "Unapplied Cash Batch Number"
    description: "Indicates the batch number"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_BATCH_NUMBER" ;;
  }

  dimension: unapplied_cash_carrier_internal_control_number {
    label: "Carrier Internal Control Number "
    description: "Indicates the Carrier Internal Control Number"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_CARRIER_INTERNAL_CONTROL_NUMBER" ;;
  }

  dimension: unapplied_cash_change_store_flag {
    label: "Change Store Flag"
    description: " Indicates the change store flag"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_CHANGE_STORE_FLAG" ;;
  }

  dimension_group: unapplied_cash_close {
    label: "Close"
    description: "Indicates the date of closure"
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
    sql: ${TABLE}."UNAPPLIED_CASH_CLOSE_DATE" ;;
  }

  dimension: unapplied_cash_close_type_id {
    label: "Close Type Id"
    description: "Indicates the type of closure"
    type: number
    hidden:yes
    sql: ${TABLE}."UNAPPLIED_CASH_CLOSE_TYPE_ID" ;;
  }

  dimension: unapplied_cash_close_type {
    label: "Close Type"
    description: "Indicates the type of closure"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${unapplied_cash_close_type_id}) ;;
  }

  dimension: unapplied_cash_counter {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_COUNTER" ;;
  }

  dimension: unapplied_cash_customer_batch_number {
    type: string
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_CUSTOMER_BATCH_NUMBER" ;;
  }

  dimension: unapplied_cash_customer_manual_close_batch_number {
    label: "Customer Manual Close Batch Number"
    description: " Batch number assigned to the write off"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_CUSTOMER_MANUAL_CLOSE_BATCH_NUMBER" ;;
  }

  dimension: unapplied_cash_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_DELETED" ;;
  }

  dimension_group: unapplied_cash_fill {
    label: "Fill"
    description: "Fill Date of the unapplied cash record"
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
    sql: ${TABLE}."UNAPPLIED_CASH_FILL_DATE" ;;
  }

  dimension: unapplied_cash_force_to_claim_id {
    label: "Force to Claim ID"
    description: "Indicates the claim ID the record was forced to"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_FORCE_TO_CLAIM_ID" ;;
  }

  dimension: unapplied_cash_how_received_id {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_HOW_RECEIVED_ID" ;;
  }

  dimension: unapplied_cash_id {
    label: "Unapplied Cash ID "
    description: "Identifying number for this Unapplied Cash record"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_ID" ;;
  }

  dimension: unapplied_cash_last_updated_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension: unapplied_cash_lcr_id {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_LCR_ID" ;;
  }

  dimension: unapplied_cash_patient_name {
    label: "Patient Name"
    description: " Indicates the name of the patient"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_PATIENT_NAME" ;;
  }

  dimension: unapplied_cash_plan_id {
    label: "Carrier Code"
    description: "Unique code used to identify the Third Party Carrier."
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_PLAN_ID" ;;
  }

  dimension: unapplied_cash_processor_id {
    type: string
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_PROCESSOR_ID" ;;
  }

  dimension: unapplied_cash_reject_code_1 {
    label: "EOB Code1"
    description: "EOB code received from the payer on the remittance advice"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_REJECT_CODE_1" ;;
  }

  dimension: unapplied_cash_reject_code_2 {
    label: "EOB Code2"
    description: "Second EOB code received from the payer on the remittance advice"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_REJECT_CODE_2" ;;
  }

  dimension: unapplied_cash_reject_code_3 {
    label: "EOB Code3"
    description: "Third EOB code received from the payer on the remittance advice"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_REJECT_CODE_3" ;;
  }

  dimension: unapplied_cash_reject_invoice_number {
    type: string
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_REJECT_INVOICE_NUMBER" ;;
  }

  dimension: unapplied_cash_rx_number {
    label: "Rx Number"
    description: "Prescription number of the unapplied cash  record"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_RX_NUMBER" ;;
    value_format: "0"
  }

  dimension: unapplied_cash_split_payment_flag {
    label: "Split Payment Flag"
    description: "Indicates if the payment was split"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_SPLIT_PAYMENT_FLAG" ;;
  }

  dimension: unapplied_cash_stage_id {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_STAGE_ID" ;;
  }

  dimension_group: unapplied_cash_status {
    label: "Status"
    description: " Indicates the date the status was set"
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
    sql: ${TABLE}."UNAPPLIED_CASH_STATUS_DATE" ;;
  }

  dimension: unapplied_cash_status_id {
    label: "Unapplied Cash Status Id"
    description: "Indicates the status of unapplied cash"
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_STATUS_ID" ;;
  }

  dimension: unapplied_cash_status {
    label: "Unapplied Cash Status"
    description: "Indicates the status of unapplied cash"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${unapplied_cash_status_id}) ;;
  }

  dimension: unapplied_cash_tape_number {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_TAPE_NUMBER" ;;
  }

  dimension: unapplied_cash_write_off_reason {
    label: "Write Off Reason"
    description: "Indicates the reason of the write off"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_WRITE_OFF_REASON" ;;
  }

  dimension_group: week_end {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."WEEK_END_DATE" ;;
  }

 ################################################################ Measures ####################################################################
 measure: sum_unapplied_cash_paid_amount {
    label: "Paid Amount "
    description: "Indicates the paid amount"
    type: sum
    sql: ${TABLE}."UNAPPLIED_CASH_PAID_AMOUNT" ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_unapplied_cash_copay_amount {
    label: "Copay Amount"
    description: "Indicates the amount of the copay"
    type: sum
    sql: ${TABLE}."UNAPPLIED_CASH_COPAY_AMOUNT" ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

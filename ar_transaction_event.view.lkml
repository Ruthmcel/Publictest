view: ar_transaction_event {
  label: "Transaction Event"
  sql_table_name: EDW.F_TRANSACTION_EVENT ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_event_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_event_id {
    label: "Transaction Event ID"
    description: "Unique ID number assigned for each claim event processed by Production Cycle in the Absolute system "
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_ID ;;
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: nhin_store_id {
    hidden:  yes
    label: "Nhin Store ID"
    description: "Unique ID Number assigned by NHIN accounting dept for each store"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_NHIN_STORE_ID ;;
  }

  dimension: plan_id {
    hidden:  yes
    label: "Plan ID"
    description: "Unique ID number of the CARRIER CODE and  PLAN CODE combination in AR system"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_PLAN_ID ;;
  }

  dimension: transaction_id {
    hidden:  yes
    label: "Transaction Event Transaction ID"
    description: "Unique ID number of the transaction associated with this claim"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_TRANSACTION_ID ;;
  }

  dimension: transaction_event_type_id {
    label: "Transaction Event Type ID"
    hidden: yes
    description: "Identifies the specific type of event"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_TYPE_ID ;;
  }

  dimension: transaction_event_stage_id {
    label: "Transaction Event Stage ID"
    description: "Unique ID number assigned for each claim event staged for processing in the Absolute system "
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_STAGE_ID ;;
  }

  dimension: transaction_event_claim_status_type_id {
    label: "Transaction Event Claim Status Type ID"
    description: "Indicates the current status (OPEN, RECONCILED, MANUAL CLOSE etc) of the transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_EVENT_CLAIM_STATUS_TYPE_ID ;;
  }

  dimension: transaction_event_claim_type_id {
    label: "Transaction Event Claim Type ID"
    description: "Indicates the type (OVERPAY, OPEN, PARTIAL PAY) of transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_EVENT_CLAIM_TYPE_ID ;;
  }

# dimension_group: transaction_event_week_end {
#     label: "Transaction Event Week End"
#     description: "NHIN weekend date in which this event was processed by Production Cycle"
#     type: time
#     sql: ${TABLE}.WEEK_END_DATE ;;
#     timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
#   }

  dimension: rpt_transaction_week_end_calendar_date {
    label: "Transaction Event Week End"
    description: "NHIN weekend date in which this event was processed by Production Cycle"
    type: date
    hidden: yes
    sql: ${rpt_transaction_week_end_timeframes.calendar_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_chain_id {
    label: "Transaction Event Week End Chain ID"
    description: "Transaction Event Week End Chain ID"
    type: number
    hidden: yes
    sql: ${rpt_transaction_week_end_timeframes.chain_id} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_calendar_owner_chain_id {
    label: "Transaction Event Week End Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rpt_transaction_week_end_timeframes.calendar_owner_chain_id} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_yesno {
    label: "Transaction Event Week End (Yes/No)"
    group_label: "Transaction Event Week End Date"
    description: "Yes/No flag indicating if this event was processed by Production Cycle Example output 'Yes'"
    type: string
    can_filter: yes

    case: {
      when: {
        sql: ${TABLE}.WEEK_END_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension_group: transaction_event_week_end {
    label: "Transaction Event Week End"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    can_filter: no
    timeframes: [date]
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

  dimension_group: transaction_event_week_end {
    label: "Transaction Event Week End"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    timeframes: [time]
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

# Seperated hour_of_day from time dimension to provide description with timeframe example.
  dimension_group: transaction_event_week_end {
    label: "Transaction Event Week End"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    timeframes: [hour_of_day]
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

  dimension: rpt_transaction_week_end_day_of_week {
    label: "Transaction Event Week End Day Of Week"
    description: "Transaction Event Week End Day Of Week Full Name. Example output 'Monday'"
    type: string
    sql: ${rpt_transaction_week_end_timeframes.day_of_week} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_day_of_month {
    label: "Transaction Event Week End Day Of Month"
    description: "Transaction Event Week End Day Of Month. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.day_of_month} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_week_of_year {
    label: "Transaction Event Week End Week Of Year"
    description: "Transaction Event Week End Week Of Year. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.week_of_year} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_month_num {
    label: "Transaction Event Week End Month Num"
    description: "Transaction Event Week End Month Of Year. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.month_num} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_month {
    label: "Transaction Event Week End Month"
    description: "Transaction Event Week End Month. Example output '2017-01'"
    type: string
    sql: ${rpt_transaction_week_end_timeframes.month} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_quarter_of_year {
    label: "Transaction Event Week End Quarter Of Year"
    description: "Transaction Event Week End Quarter Of Year. Example output 'Q1'"
    type: string
    sql: ${rpt_transaction_week_end_timeframes.quarter_of_year} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_quarter {
    label: "Transaction Event Week End Quarter"
    description: "Transaction Event Week End Quarter. Example output '2017-Q1'"
    type: string
    sql: ${rpt_transaction_week_end_timeframes.quarter} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_year {
    label: "Transaction Event Week End Year"
    description: "Transaction Event Week End Year. Example output '2017'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.year} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_day_of_week_index {
    label: "Transaction Event Week End day Of Week Index"
    description: "Transaction Event Week End Day Of Week Index. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.day_of_week_index} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_week_begin_date {
    label: "Transaction Event Week End Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Transaction Event Week End Week Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.week_begin_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_week_end_date {
    label: "Transaction Event Week End Week End Date"
    description: "Transaction Event Week End Week End Date. Example output '2017-01-19'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.week_end_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_week_of_quarter {
    label: "Transaction Event Week End Week Of Quarter"
    description: "Transaction Event Week End Week of Quarter. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.week_of_quarter} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_month_begin_date {
    label: "Transaction Event Week End Month Begin Date"
    description: "Transaction Event Week End Month Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.month_begin_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_month_end_date {
    label: "Transaction Event Week End Month End Date"
    description: "Transaction Event Week End Month End Date. Example output '2017-01-31'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.month_end_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_weeks_in_month {
    label: "Transaction Event Week End Weeks In Month"
    description: "Transaction Event Week End Weeks In Month. Example output '4'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.weeks_in_month} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_quarter_begin_date {
    label: "Transaction Event Week End Quarter Begin Date"
    description: "Transaction Event Week End Quarter Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.quarter_begin_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_quarter_end_date {
    label: "Transaction Event Week End Quarter End Date"
    description: "Transaction Event Week End Quarter End Date. Example output '2017-03-31'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.quarter_end_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_weeks_in_quarter {
    label: "Transaction Event Week End Weeks In Quarter"
    description: "Transaction Event Week End Weeks In Quarter. Example output '13'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.weeks_in_quarter} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_year_begin_date {
    label: "Transaction Event Week End Year Begin Date"
    description: "Transaction Event Week End Year Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.year_begin_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_year_end_date {
    label: "Transaction Event Week End Year End Date"
    description: "Transaction Event Week End Year End Date. Example output '2017-12-31'"
    type: date
    sql: ${rpt_transaction_week_end_timeframes.year_end_date} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_weeks_in_year {
    label: "Transaction Event Week End Weeks In Year"
    description: "Transaction Event Week End Weeks In Year. Example output '52'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.weeks_in_year} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_leap_year_flag {
    label: "Transaction Event Week End Leap Year Flag"
    description: "Transaction Event Week End Leap Year Flag. Example output 'N'"
    type: string
    sql: ${rpt_transaction_week_end_timeframes.leap_year_flag} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_day_of_quarter {
    label: "Transaction Event Week End Day Of Quarter"
    description: "Transaction Event Week End Day of Quarter. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.day_of_quarter} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension: rpt_transaction_week_end_day_of_year {
    label: "Transaction Event Week End Day Of Year"
    description: "Transaction Event Week End Day of Year. Example output '1'"
    type: number
    sql: ${rpt_transaction_week_end_timeframes.day_of_year} ;;
    group_label: "Transaction Event Week End Date"
  }

  dimension_group: transaction_event_status {
    label: "Transaction Event Status"
    description: "NHIN weekend date in which this event was processed by Production Cycle"
    type: time
    sql: ${TABLE}.TRANSACTION_EVENT_STATUS_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_event_last_update_user_identifier {
    label: "Transaction Event Last Update User Identifier"
    hidden: yes
    description: "User or process that last updated this event"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_LAST_UPDATE_USER_IDENTIFIER ;;
  }
  ################################################################################# Master code dimensions #######################################################################################################
  dimension: transaction_event_claim_type_id_mc {

    label: "Transaction Event Claim Type"
    description: "Indicates the type (OVERPAY, OPEN, PARTIAL PAY) of transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_EVENT_CLAIM_TYPE_ID) ;;
    suggestions: [
      "PAID IN FULL",
      "BANKRUPTCY",
      "CUSTOMER REQUEST",
      "OPEN NEW SALE",
      "PARTIAL PAY",
      "MANUAL WRITE OFF",
      "MANUAL SALES ADJ",
      "CREDIT RETURN",
      "WRITE OFF W/I LIMITS",
      "OVERPAY",
      "AUTO CLOSE",
      "REJECT",
      "RESUBMISSION",
      "LIABILITY",
      "CARRIER TAKEBACK",
      "OPEN WITH RESPONSE",]
  }

  dimension: transaction_event_claim_status_type_id_mc {
    label: "Transaction Event Claim Status Type"
    description: "Indicates the current status (OPEN, RECONCILED, MANUAL CLOSE etc) of the transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_EVENT_CLAIM_STATUS_TYPE_ID) ;;
    suggestions: [
      "OPEN",
      "RECONCILED",
      "CLM W/O ORIG SALES",
      "MANUAL CLOSE"]
  }

  dimension: transaction_event_type_id_mc {
    label: "Transaction Event Type"
    description: "Indicates the type Id of transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_EVENT_TYPE_ID) ;;
    suggestions: [
      "PAYMENT",
      "RE-OPEN",
      "WRITE-OFF",
      "SALES",
      "SUBMITTAL",
      "POSTING CORRECTION"]
  }

  dimension: transaction_event_last_update_user_identifier_mc {
    label: "Transaction Event Last Update User Identifier"
    description: "User or process that last updated this event"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_EVENT_LAST_UPDATE_USER_IDENTIFIER) ;;
    suggestions: [
      "OPEN",
      "RECONCILED",
      "RECONCILIATION"]
  }


  ################################################################################# Measures ################################################################################################################

  measure: sum_transaction_event_amount {
    label: "Transaction Event Amount"
    description: "Total amount of the event relevant to the event type"
    type: sum
    sql: ${TABLE}.TRANSACTION_EVENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Transaction Event LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.TRANSACTION_EVENT_LCR_ID ;;
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

view: ar_transaction_status {
  label: "Transaction Status"
  sql_table_name: EDW.F_TRANSACTION_STATUS ;;


  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_id} ;;
  }


  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_id {
    label: "Claim ID"
    description: "Unique Identification Number of the Transaction table"
    type: number
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    label: "NHIN Store ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_NHIN_STORE_ID ;;
  }

  dimension: plan_id {
    hidden: yes
    label: "Plan ID"
    description: "Unique Identification Number of the CARRIER PLAN table in AR system"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_PLAN_ID ;;
  }

  dimension: transaction_status_rx_number {
    label: "Rx Number"
    description: "Prescription Number of the claim/transaction"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_RX_NUMBER ;;
    value_format: "######"
  }

  dimension: transaction_status_six_rx_number {
    label: "Six Digit Rx Number"
    description: "Six Digit Prescription Number of the claim/transactions"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_SIX_RX_NUMBER ;;
    value_format: "######"
  }

  dimension_group: transaction_status_fill {
    label: "Fill"
    description: "Date the Prescription Transaction was filled"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_FILL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_status_refill_number {
    label: "Refill Number"
    description: "Prescription Transaction Refill Number"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_REFILL_NUMBER ;;
  }

  dimension: transaction_status_tx_number {
    label: "Tx Number"
    description: "Prescription Transaction Number"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_TX_NUMBER ;;
    value_format: "######"
  }

#   dimension_group: transaction_status_reportable_sales {
#     label: "Reportable Sales"
#     description: "Date the Prescription Transaction was adjudicated"
#     type: time
#     sql: ${TABLE}.TRANSACTION_STATUS_SOLD_DATE ;;
#     timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
#   }

  dimension: rpt_sales_calendar_date {
    label: "Reportable Sales"
    description: "Date the Prescription Transaction was adjudicated"
    type: date
    hidden: yes
    sql: ${rpt_sales_timeframes.calendar_date} ;;
    group_label: "Reportable Sales Date"
  }

#   dimension: rpt_sales_chain_id {
#     label: "Reportable Sales Chain ID"
#     description: "Reportable Sales Chain ID"
#     type: number
#     hidden: yes
#     sql: ${rpt_sales_timeframes.chain_id} ;;
#     group_label: "Reportable Sales Date"
#   }
#
#   dimension: rpt_sales_calendar_owner_chain_id {
#     label: "Reportable Sales Calendar Owner Chain ID"
#     description: "Calendar is of this Chain ID"
#     type: number
#     hidden: yes
#     sql: ${rpt_sales_timeframes.calendar_owner_chain_id} ;;
#     group_label: "Reportable Sales Date"
#   }

  dimension: rpt_sales_yesno {
    label: "Reportable Sales (Yes/No)"
    group_label: "Reportable Sales Date"
    description: "Yes/No flag indicating if a prescription has a Reportable Sales Date. Example output 'Yes'"
    type: string
    can_filter: yes

    case: {
      when: {
        sql: ${TABLE}.TRANSACTION_STATUS_SOLD_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension_group: reportable_sales {
    label: "Reportable Sales"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    can_filter: no
    timeframes: [date]
    sql: ${TABLE}.TRANSACTION_STATUS_SOLD_DATE ;;
  }

  dimension_group: reportable_sales {
    label: "Reportable Sales"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    timeframes: [time]
    sql: ${TABLE}.TRANSACTION_STATUS_SOLD_DATE ;;
  }

# Seperated hour_of_day from time dimension to provide description with timeframe example.
  dimension_group: reportable_sales {
    label: "Reportable Sales"
    description: "Date/Time when the Prescription Transaction was adjudicated"
    type: time
    timeframes: [hour_of_day]
    sql: ${TABLE}.TRANSACTION_STATUS_SOLD_DATE ;;
  }

  dimension: rpt_sales_day_of_week {
    label: "Reportable Sales Day Of Week"
    description: "Prescription Reportable Sales Day Of Week Full Name. Example output 'Monday'"
    type: string
    sql: ${rpt_sales_timeframes.day_of_week} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_month {
    label: "Reportable Sales Day Of Month"
    description: "Prescription Reportable Sales Day Of Month. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.day_of_month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_of_year {
    label: "Reportable Sales Week Of Year"
    description: "Prescription Reportable Sales Week Of Year. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.week_of_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_num {
    label: "Reportable Sales Month Num"
    description: "Prescription Reportable Sales Month Of Year. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.month_num} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month {
    label: "Reportable Sales Month"
    description: "Prescription Reportable Sales Month. Example output '2017-01'.  (based on calendar type)"
    type: string
    sql: ${rpt_sales_timeframes.month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_of_year {
    label: "Reportable Sales Quarter Of Year"
    description: "Prescription Reportable Sales Quarter Of Year. Example output 'Q1'.  (based on calendar type)"
    type: string
    sql: ${rpt_sales_timeframes.quarter_of_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter {
    label: "Reportable Sales Quarter"
    description: "Prescription Reportable Sales Quarter. Example output '2017-Q1'.  (based on calendar type)"
    type: string
    sql: ${rpt_sales_timeframes.quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year {
    label: "Reportable Sales Year"
    description: "Prescription Reportable Sales Year. Example output '2017'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_week_index {
    label: "Reportable Sales day Of Week Index"
    description: "Prescription Reportable Sales Day Of Week Index. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.day_of_week_index} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_begin_date {
    label: "Reportable Sales Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Reportable Sales Week Begin Date. Example output '2017-01-13'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.week_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_end_date {
    label: "Reportable Sales Week End Date"
    description: "Prescription Reportable Sales Week End Date. Example output '2017-01-19'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.week_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_of_quarter {
    label: "Reportable Sales Week Of Quarter"
    description: "Prescription Reportable Sales Week of Quarter. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.week_of_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_begin_date {
    label: "Reportable Sales Month Begin Date"
    description: "Prescription Reportable Sales Month Begin Date. Example output '2017-01-13'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.month_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_end_date {
    label: "Reportable Sales Month End Date"
    description: "Prescription Reportable Sales Month End Date. Example output '2017-01-31'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.month_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_month {
    label: "Reportable Sales Weeks In Month"
    description: "Prescription Reportable Sales Weeks In Month. Example output '4'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_begin_date {
    label: "Reportable Sales Quarter Begin Date"
    description: "Prescription Reportable Sales Quarter Begin Date. Example output '2017-01-13'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.quarter_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_end_date {
    label: "Reportable Sales Quarter End Date"
    description: "Prescription Reportable Sales Quarter End Date. Example output '2017-03-31'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.quarter_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_quarter {
    label: "Reportable Sales Weeks In Quarter"
    description: "Prescription Reportable Sales Weeks In Quarter. Example output '13'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year_begin_date {
    label: "Reportable Sales Year Begin Date"
    description: "Prescription Reportable Sales Year Begin Date. Example output '2017-01-13'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.year_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year_end_date {
    label: "Reportable Sales Year End Date"
    description: "Prescription Reportable Sales Year End Date. Example output '2017-12-31'.  (based on calendar type)"
    type: date
    sql: ${rpt_sales_timeframes.year_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_year {
    label: "Reportable Sales Weeks In Year"
    description: "Prescription Reportable Sales Weeks In Year. Example output '52'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_leap_year_flag {
    label: "Reportable Sales Leap Year Flag"
    description: "Prescription Reportable Sales Leap Year Flag. Example output 'N'.  (based on calendar type)"
    type: string
    sql: ${rpt_sales_timeframes.leap_year_flag} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_quarter {
    label: "Reportable Sales Day Of Quarter"
    description: "Prescription Reportable Sales Day of Quarter. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.day_of_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_year {
    label: "Reportable Sales Day Of Year"
    description: "Prescription Reportable Sales Day of Year. Example output '1'.  (based on calendar type)"
    type: number
    sql: ${rpt_sales_timeframes.day_of_year} ;;
    group_label: "Reportable Sales Date"
  }
  dimension: aging_days {
    label:  "Aging Days"
    description: "No. Of Days taken for a claim to age based on the current week end period and reportable sales"
    type: number
    sql: DATEDIFF(DAY,${reportable_sales_date}, ${ar_chain_last_week_end_date.production_cycle_last_week_end_date}) ;;
  }



  dimension: age_tier {
    label: "Aging Buckets"
    type: tier
    description: "Age distribution based on no of days"
    sql: ${aging_days} ;;
    tiers: [

      31,
      61,
      91,
      121,
      151,
      181,
      211,
      241,
      271,
      301,
      331,
      361,
      391,
      421
    ]
    style: integer
  }

  dimension_group: transaction_status_credit{
    label: "Credit"
    description: "Date the transaction was Credit Returned"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_CREDIT_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: transaction_status_close {
    label: "Close"
    description: "Close Date"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_CLOSE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: processor_id {
    label: "Processor ID/Payer Code"
    hidden:  yes
    description: "Payer Identifier"
    type: string
    sql: ${TABLE}.TRANSACTION_STATUS_PROCESSOR_ID ;;
  }

  dimension: transaction_status_split_bill_opt_type_id {
    label: "Split Bill Indicator"
    description: "Flag to determine if a claim is a split bill (i.e. paid by multiple payers)"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_STATUS_SPLIT_BILL_OPT_TYPE_ID ;;
  }

  dimension: transaction_status_id {
    label: "Recon Status"
    description: "Indicates the current status (OPEN, RECONCILED, MANUAL CLOSE etc) of the transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_STATUS_ID ;;
  }

  dimension: transaction_status_transaction_type_id {
    label: "Transaction Type Id"
    description: "Indicates the type Id of transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_STATUS_TRANSACTION_TYPE_ID ;;
  }

  dimension: transaction_status_transaction_type {
    label: "Transaction Type Desc"
    description: "Indicates the type description for (OVERPAY, OPEN, PARTIAL PAY, WRITE OFF W/I LIMITS, MANUAL WRITE OFF) of transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${transaction_status_transaction_type_id}) ;;
  }

  dimension_group: transaction_status_date {
    label: "Claim Status"
    description: "Claim Status Date"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: transaction_status_research_date {
    label: "Research"
    description: "Research Date"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_RESEARCH_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_status_days_in_receivable {
    label: "Days In Receivable"
    description: "The number of days in receivable"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_DAYS_IN_RECEIVABLE ;;
  }

  dimension: transaction_status_write_off_amount_indicator {
    label: "Write Off Amount Indicator"
    description: "Writeoff amount. Difference between the submitted amount and balance plus copay"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_WRITE_OFF_AMOUNT_INDICATOR ;;
  }

  dimension: transaction_status_patient_name {
    label: "Patient Name"
    description: "Patient Name on the Prescription Transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_STATUS_PATIENT_NAME ;;
  }

  dimension: transaction_status_transaction_location {
    label: "Transaction Location"
    hidden: yes
    description: "Transaction Location"
    type: number
    sql: ${TABLE}.TRANSACTION_STATUS_TRANSACTION_LOCATION ;;
    value_format: "######"
  }

  dimension_group: transaction_status_account_date {
    label: "Account"
    description: "Account Date"
    type: time
    sql: ${TABLE}.TRANSACTION_STATUS_ACCOUNT_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_status_deleted {
    label: "Transaction Status Deleted"
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table."
    type: string
    sql: ${TABLE}.TRANSACTION_STATUS_DELETED ;;
  }

#################################################################################### Master code dimensions ############################################################################################################

  dimension: transaction_status_transaction_type_id_mc {
    label: "Transaction Type"
    description: "Indicates the type of transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_STATUS_TRANSACTION_TYPE_ID) ;;
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
      "OVERPAY","AUTO CLOSE",
      "REJECT",
      "RESUBMISSION",
      "LIABILITY",
      "CARRIER TAKEBACK","OPEN WITH RESPONSE"]
  }

  dimension: transaction_status_split_bill_opt_type_id_mc {
    label: "Split Bill Indicator"
    description: "Flag to determine if a claim is a split bill (i.e. paid by multiple payers)"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_STATUS_SPLIT_BILL_OPT_TYPE_ID) ;;
    suggestions: [
      "NOT SPLIT",
      "PRIMARY CARRIER",
      "SECONDARY CARRIER",
      "TERTIARY CARRIER",
      "ERX SPLIT BILL",
      "QUATERNARY CARRIER",
      "QUINARY CARRIER",
      "SENARY CARRIER",
      "SEPTENARY CARRIER",
      "OCTONARY CARRIER",
      "NONARY CARRIER"]
  }

  dimension: transaction_status_id_mc {
    label: "Recon Status"
    description: "Indicates the current status (OPEN, RECONCILED, MANUAL CLOSE etc) of the transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_STATUS_ID) ;;
    suggestions: [
      "OPEN",
      "MANUAL CLOSE",
      "RECONCILED",
      "CLM W/O ORIG SALES",
      "DUPLICATE",
      "INVALID TX",
      "SALES != HST",
      "ZERO/NEGATIVE BAL",
      "RPH ERROR",
      "NON SUPPORTED CARRIER",
      "SKELETON CLAIM"]

  }
  dimension: transaction_status_transaction_location_mc {
    label: "Transaction Location Status"
    description: "Indicates the current status (OPEN, RECONCILED, MANUAL CLOSE etc) of the transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_STATUS_TRANSACTION_LOCATION) ;;
    suggestions: ["NHIN TX","SUSPENDED","NON SOLD TX","CLAIM"]

  }

#################################################################################### Measure  ##########################################################################################################################

  measure: sum_transaction_status_submit_amount {
    type: sum
    label: "Original Receivable Amount"
    description: "The original receivable amount as reported from the Third Party adjudication, reported from transaction status"
    sql: ${TABLE}.TRANSACTION_STATUS_SUBMIT_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: transaction_status_net_due_copay {
    label: "Original Receivable Amount & Copay"
    description: "The original receivable amount as reported from the Third Party adjudication, reported from transaction status, including the Copay (Calculation Used: Submit Amount + Copay)"
    type: number
    sql: ${sum_transaction_status_submit_amount} + ${ar_transaction_info.sum_transaction_info_copay_amount} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_status_amount_due {
    type: sum
    label: "Net Due"
    description: "Total Amount Due from Third Party, reported from transaction status"
    sql: ${TABLE}.TRANSACTION_STATUS_AMOUNT_DUE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: transaction_status_total_paid_amount_reference {
    hidden:  yes
    type: number
    label: "Paid Amount"
    description: "Total Amount Paid by Third Party"
    sql: NVL((${ar_transaction_info.transaction_info_copay_amount_reference}), 0) + (${TABLE}.TRANSACTION_STATUS_TOTAL_PAID_AMOUNT/100) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

   measure: sum_transaction_status_total_paid_amount {
    type: sum
    label: "TP Actual Paid Amount"
    description: "Total Actual Paid amount by the Third Party"
    sql: ${TABLE}.TRANSACTION_STATUS_TOTAL_PAID_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

   measure: sum_transaction_status_credit_amount {
    type: sum
    label: "Credit Amount"
    description: "Credit Amount for Credit Return claims"
    sql: ${TABLE}.TRANSACTION_STATUS_CREDIT_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

   measure: sum_transaction_status_close_amount {
    type: sum
    label: "Close Amount"
    description: "Extra Amount it would be in OverPay case. E.g $25 was closed by paying $40 so close amount would be $15"
    sql: ${TABLE}.TRANSACTION_STATUS_CLOSE_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: claim_count {
    label: "Claim Count"
    description: "Total Claims"
    type: number
    sql:  COUNT(DISTINCT(CONCAT(${TABLE}.CHAIN_ID, ${TABLE}.TRANSACTION_ID))) ;;
    value_format: "#,##0"
  }

  measure: avg_paid_amout {
    label: "Avg Paid Amount"
    description: "Average Paid Amount"
    type: number
    sql:  ${sum_transaction_status_total_paid_amount}/${claim_count} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: rx_count {
    label: "Rx Count"
    description: "Total Prescriptions"
    type: number
    sql:  COUNT(DISTINCT(${transaction_status_rx_number})) ;;
    value_format: "#,##0"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.TRANSACTION_STATUS_LCR_ID ;;
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

################################################################################### Templated Filters ###################################################################################

  filter: date_to_use_filter {
    label: "DATE TO USE"
    description: "The DATE TO USE field determines what DATE FIELD is used to aggregate data, based on the time window specified. Currently only REPORTABLE SALES & TRANSACTION EVENT WEEK END is used"
    type: string
    suggestions: ["REPORTABLE SALES","TRANSACTION EVENT WEEK END"]
    bypass_suggest_restrictions: yes
  }

################################################################################## Report Period Date (from TImeframs) ################################################################

  dimension_group: report {
    type: time
    label: "Report Period"
    timeframes: [date]
    description: "Report Period Date. Example output '2017-01-13'"
    sql: ${ar_report_calendar_global.report_date} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_day_of_week {
    label: "Report Period Day Of Week"
    description: "Report Period Day Of Week Full Name. Example output 'Monday'"
    type: string
    sql: ${report_period_timeframes.day_of_week} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_day_of_month {
    label: "Report Period Day Of Month"
    description: "Report Period Day Of Month. Example output '1'"
    type: number
    sql: ${report_period_timeframes.day_of_month} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_week_begin_date {
    label: "Report Period Week Begin Date" #[ERXLPS-2092]
    description: "Report Period Week Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${report_period_timeframes.week_begin_date} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_week_of_year {
    label: "Report Period Week Of Year"
    description: "Report Period Week Of Year. Example output '1'"
    type: number
    sql: ${report_period_timeframes.week_of_year} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_month_num {
    label: "Report Period Month Num"
    description: "Report Period Month Of Year. Example output '1'"
    type: number
    sql: ${report_period_timeframes.month_num} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_month {
    label: "Report Period Month"
    description: "Report Period Month. Example output '2017-01'"
    type: string
    sql: ${report_period_timeframes.month} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_year {
    label: "Report Period Year"
    description: "Report Period Year. Example output '2017'"
    type: number
    sql: ${report_period_timeframes.year} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_quarter_of_year {
    label: "Report Period Quarter Of Year"
    description: "Report Period Quarter Of Year. Example output 'Q1'"
    type: string
    sql: ${report_period_timeframes.quarter_of_year} ;;
    group_label: "Report Period Date"
  }

  dimension: report_period_quarter {
    label: "Report Period Quarter"
    description: "Report Period Quarter. Example output '2017-Q1'"
    type: string
    sql: ${report_period_timeframes.quarter} ;;
    group_label: "Report Period Date"
  }

  #[ERXLPS-1975]
  dimension: report_period_day_of_week_index {
    label: "Report Period Day Of Week Index"
    description: "Report Period Day Of Week Index. Example output '1'"
    type: number
    sql: ${report_period_timeframes.day_of_week_index} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_week_end_date {
    label: "Report Period Week End Date" #[ERXLPS-2092]
    description: "Report Period Week End Date. Example output '2017-01-19'"
    type: date
    sql: ${report_period_timeframes.week_end_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_week_of_quarter {
    label: "Report Period Week Of Quarter"
    description: "Report Period Week of Quarter. Example output '1'"
    type: number
    sql: ${report_period_timeframes.week_of_quarter} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_month_begin_date {
    label: "Report Period Month Begin Date"
    description: "Report Period Month Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${report_period_timeframes.month_begin_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_month_end_date {
    label: "Report Period Month End Date"
    description: "Report Period Month End Date. Example output '2017-01-31'"
    type: date
    sql: ${report_period_timeframes.month_end_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_weeks_in_month {
    label: "Report Period Weeks In Month"
    description: "Report Period Weeks In Month. Example output '4'"
    type: number
    sql: ${report_period_timeframes.weeks_in_month} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_quarter_begin_date {
    label: "Report Period Quarter Begin Date"
    description: "Report Period Quarter Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${report_period_timeframes.quarter_begin_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_periodquarter_end_date {
    label: "Report Period Quarter End Date"
    description: "Report Period Quarter End Date. Example output '2017-03-31'"
    type: date
    sql: ${report_period_timeframes.quarter_end_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_weeks_in_quarter {
    label: "Report Period Weeks In Quarter"
    description: "Report Period Weeks In Quarter. Example output '13'"
    type: number
    sql: ${report_period_timeframes.weeks_in_quarter} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_year_begin_date {
    label: "Report Period Year Begin Date"
    description: "Report Period Year Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${report_period_timeframes.year_begin_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_year_end_date {
    label: "Report Period Year End Date"
    description: "Report Period Year End Date. Example output '2017-12-31'"
    type: date
    sql: ${report_period_timeframes.year_end_date} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_weeks_in_year {
    label: "Report Period Weeks In Year"
    description: "Report Period Weeks In Year. Example output '52'"
    type: number
    sql: ${report_period_timeframes.weeks_in_year} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_leap_year_flag {
    label: "Report Period Leap Year Flag"
    description: "Report Period Leap Year Flag. Example output 'N'"
    type: string
    sql: ${report_period_timeframes.leap_year_flag} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_day_of_quarter {
    label: "Report Period Day Of Quarter"
    description: "Report Period Day of Quarter. Example output '1'"
    type: number
    sql: ${report_period_timeframes.day_of_quarter} ;;
    group_label: "Report Period Date"
  }


  dimension: report_period_day_of_year {
    label: "Report Period Day Of Year"
    description: "Report Period Day of Year. Example output '1'"
    type: number
    sql: ${report_period_timeframes.day_of_year} ;;
    group_label: "Report Period Date"
  }

  measure: average_aging_days {
    label: "Average Aging Days"
    description: "Average Aging Days"
    type: average
    sql:  ${aging_days} ;;
    value_format: "#,##0"
  }

  measure: highest_aging_day {
    label: "Highest Aging Day"
    description: "Highest Aging Day"
    type: max
    sql:  ${aging_days} ;;
    value_format: "#,##0"
  }

}

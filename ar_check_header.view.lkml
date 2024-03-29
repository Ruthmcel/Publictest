view: ar_check_header {
  label: "Check Header"
  sql_table_name: EDW.F_CHECK_HEADER ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_check_number} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_check_number {
    label: "NHIN Check Number"
    description: "Check Number generated by AR system"
    type: number
    sql: ${TABLE}.NHIN_CHECK_NUMBER ;;
    value_format: "######"
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: check_header_nhin_deposit_batch_id {
    label: "Check Header NHIN Deposit Batch ID"
    description: "Identification number of deposit batch"
    type: number
    sql: ${TABLE}.CHECK_HEADER_NHIN_DEPOSIT_BATCH_ID ;;
  }

  dimension: plan_id {
    hidden:  yes
    label: "Plan ID"
    description: "Identifies the Plan for which check is received"
    type: number
    sql: ${TABLE}.CHECK_HEADER_PLAN_ID ;;
  }

  dimension: check_header_check_number {
    label: "Check Header Check Number"
    description: "Check Number"
    type: string
    sql: ${TABLE}.CHECK_HEADER_CHECK_NUMBER ;;
  }

  dimension: processor_id {
    label: "NHIN Payer Code"
    description: "Absolute AR  assigned payer code indicating who sent the ERA"
    type: string
    sql: ${TABLE}.CHECK_HEADER_PROCESSOR_ID ;;
  }

  dimension_group: check_header_check {
    label: "Check Header Check"
    description: "Date when Check is issued as mentioned on check"
    type: time
    sql: ${TABLE}.CHECK_HEADER_CHECK_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: check_header_week_end {
    label: "Check Header Week End"
    description: "Date on which week ended"
    type: time
    sql: ${TABLE}.CHECK_HEADER_WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: check_header_customer_week_end {
    label: "Check Header Customer Week End"
    description: "Date on which Customer's week ended"
    type: time
    sql: ${TABLE}.CHECK_HEADER_CUSTOMER_WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: check_header_check_status_type_id {
    label: "Check Header Check Status Type ID"
    description: "Status of the check"
    type: number
    hidden: yes
    sql: ${TABLE}.CHECK_HEADER_CHECK_STATUS_TYPE_ID ;;
  }

  dimension: check_header_remittance_advice_number {
    label: "Check Header Remittance Advice Number"
    description: "Represents the ERA File that has been applied to the check"
    type: string
    sql: ${TABLE}.CHECK_HEADER_REMITTANCE_ADVICE_NUMBER ;;
  }

  dimension: check_header_american_banking_association_routing_number {
    label: "Check Header American Banking Association Routing Number"
    description: "American Banking Association/Routing number associated with the payment"
    type: string
    sql: ${TABLE}.CHECK_HEADER_AMERICAN_BANKING_ASSOCIATION_ROUTING_NUMBER ;;
  }

  dimension: check_header_bank_account_number {
    label: "Check Header Bank Account Number"
    description: "Account Number associated with the payment"
    type: string
    sql: ${TABLE}.CHECK_HEADER_BANK_ACCOUNT_NUMBER ;;
  }

  dimension: check_header_pre_post_flag {
    label: "Check Header Pre Post Flag"
    description: "Flag indicating if Pre-Post report has been executed for this check"
    type: string
    sql: ${TABLE}.CHECK_HEADER_PRE_POST_FLAG ;;
  }

  dimension: check_header_customer_batch_number {
    label: "Check Header Customer Batch Number"
    description: "Customer batch number"
    type: string
    sql: ${TABLE}.CHECK_HEADER_CUSTOMER_BATCH_NUMBER ;;
  }

  dimension: check_header_lock_box {
    label: "Check Header Lock Box"
    description: "Flag indicating if processed from Lock Box"
    type: string
    sql: ${TABLE}.CHECK_HEADER_LOCK_BOX ;;
  }

  dimension: check_header_ncpdp_number {
    label: "Check Header NCPDP Number"
    description: "Store Identifier associated with the payment"
    type: string
    sql: ${TABLE}.CHECK_HEADER_NCPDP_NUMBER ;;
  }

  dimension_group: check_header_automated_clearing {
    label: "Check Header Automated Clearing"
    description: "Date at which Automated Clearing House (ACH) sends this file"
    type: time
    sql: ${TABLE}.CHECK_HEADER_AUTOMATED_CLEARING_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: check_header_multi_check_flag {
    label: "Check Header Multi Check Flag"
    description: "Flag indicating if the check has been processed through multi-check"
    type: string
    sql: ${TABLE}.CHECK_HEADER_MULTI_CHECK_FLAG ;;
  }

  dimension: check_header_tape_number {
    label: "Check Header Tape Number"
    description: "ERA number, populated by Move Remittance process "
    type: number
    sql: ${TABLE}.CHECK_HEADER_TAPE_NUMBER ;;
    value_format: "0"
  }

  dimension: check_header_tape_filename {
    label: "Check Header Tape Filename"
    description: "ERA file name populated by Move Remittance process"
    type: string
    sql: ${TABLE}.CHECK_HEADER_TAPE_FILENAME ;;
  }

  dimension: check_header_how_received_type_id {
    label: "Check Header How Received Type ID"
    description: "NHIN_TYPE ID value that refers to the method how check is received"
    type: number
    hidden: yes
    sql: ${TABLE}.CHECK_HEADER_HOW_RECEIVED_TYPE_ID ;;
  }

  dimension: check_header_added_user_identifier {
    label: "Check Header Added User Identifier"
    description: "ID of the User which has added this check header information"
    type: number
    sql: ${TABLE}.CHECK_HEADER_ADDED_USER_IDENTIFIER ;;
    value_format: "0"
  }

  dimension: check_header_check_received_flag {
    label: "Check Header Check Received Flag"
    description: "Denotes if the customer has received an actual payment"
    type: string
    sql: ${TABLE}.CHECK_HEADER_CHECK_RECEIVED_FLAG ;;
  }

  dimension: check_header_original_filename {
    label: "Check Header Original Filename"
    description: "The Original filename of the electronic remittance advice that was used during posting payment details"
    type: string
    sql: ${TABLE}.CHECK_HEADER_ORIGINAL_FILENAME ;;
  }

  dimension: check_header_electronic_remittance_advice_sender_identifier {
    label: "Check Header Electronic Remittance Advice Sender Identifier"
    description: "The Sender ID from the electronic remittance advice that was used for posting payment details"
    type: string
    sql: ${TABLE}.CHECK_HEADER_ELECTRONIC_REMITTANCE_ADVICE_SENDER_IDENTIFIER ;;
  }

  dimension: check_header_electronic_remittance_advice_receiver_identifier {
    label: "Check Header Electronic Remittance Advice Receiver Identifier"
    description: "Receiver ID from the electronic remittance advice that was used for posting payment details"
    type: string
    sql: ${TABLE}.CHECK_HEADER_ELECTRONIC_REMITTANCE_ADVICE_RECEIVER_IDENTIFIER ;;
  }

  dimension: check_header_interchange_control_number {
    label: "Check Header Interchange Control Number"
    description: "Interchange Control Number from the electronic remittance advice"
    type: number
    sql: ${TABLE}.CHECK_HEADER_INTERCHANGE_CONTROL_NUMBER ;;
    value_format: "0"
  }

  dimension: check_header_payment_method {
    label: "Check Header Payment Method"
    description: "Payment Method from the electronic remittance advice"
    type: string
    sql: ${TABLE}.CHECK_HEADER_PAYMENT_METHOD ;;
  }

  dimension: check_header_payment_format {
    label: "Check Header Payment Format"
    description: "Payment Format from the electronic remittance advice"
    type: string
    sql: ${TABLE}.CHECK_HEADER_PAYMENT_FORMAT ;;
  }

  dimension: check_header_sender_aba_routing_number {
    label: "Check Header Sender ABA Routing Number"
    description: "ABA/Routing Number from the electronic remittance advice"
    type: string
    sql: ${TABLE}.CHECK_HEADER_SENDER_AMERICAN_BANKING_ASSOCIATION_ROUTING_NUMBER ;;
  }

  dimension: check_header_sender_account_number {
    label: "Check Header Sender Account Number"
    description: "Account Number from the electronic remittance advice"
    type: string
    sql: ${TABLE}.CHECK_HEADER_SENDER_ACCOUNT_NUMBER ;;
  }

  dimension: check_header_last_update_user_identifier {
    label: "Check Header Last Update User Identifier"
    description: "User Identification number, who last updated the Check header information"
    type: number
    sql: ${TABLE}.CHECK_HEADER_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "0"
  }

  dimension: deleted {
    label: "Check Header Deleted"
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table."
    type: string
    sql: ${TABLE}.CHECK_HEADER_DELETED ;;
  }

  ################################################################ Master code dimensions #####################################################
  dimension: check_header_check_status_type_id_mc {
    label: "Check Header Check Status Type"
    description: "Status of the check"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CHECK_HEADER_CHECK_STATUS_TYPE_ID) ;;
    suggestions: [
      "BALANCED",
      "UNBALANCED",
      "POSTED BALANCED"
    ]
  }

  dimension: check_header_how_received_type_id_mc {
    label: "Check Header How Received Type"
    description: "NHIN_TYPE ID value that refers to the method how check is received"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CHECK_HEADER_HOW_RECEIVED_TYPE_ID) ;;
    suggestions: [
      "CUSTOMER",
      "PAPER",
      "ELECTRONIC"
    ]
  }

  ################################################################ Measures ####################################################################

  measure: sum_check_header_check_amount {
    label: "Check Amount"
    description: "Total amount mentioned in the Check"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_CHECK_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_service_charge_amount {
    label: "Check Level Service Charge Amount"
    description: "Total service charge amount at the Check level"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_SERVICE_CHARGE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_adjustment_amount {
    label: "Check Level Adjustment Amount"
    description: "Total adjustment amount at the check level"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_provider_amount {
    label: "Provider Count"
    description: "Number of stores for which the Check is issued"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_PROVIDER_COUNT ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_check_header_unapplied_cash_amount {
    label: "Unapplied Cash Amount"
    description: "Total unapplied cash"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_TOTAL_UNAPPLIED_CASH_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_unapplied_write_off_amount {
    label: "Unapplied Cash Write Off Amount"
    description: "Total Unapplied cash write off"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_UNAPPLIED_WRITE_OFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_provider_level_service_charge_amount {
    label: "Provider Level Service Charge Amount"
    description: "Total provider level service charge amount"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_PROVIDER_LEVEL_SERVICE_CHARGE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_provider_level_adjustment_amount {
    label: "Provider Level Adjustment Amount"
    description: "Total provider level adjustment amount"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_PROVIDER_LEVEL_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_check_header_remittance_amount {
    label: "Remittance Amount"
    description: "Total amount of the check that was applied to claims during the production cycle"
    type: sum
    sql: ${TABLE}.CHECK_HEADER_TOTAL_REMITTANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Check Header LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.CHECK_HEADER_LCR_ID ;;
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
    view_label: "Payments"
    label: "DATE TO USE"
    description: "The DATE TO USE field determines what DATE FIELD is used to aggregate data, based on the time window specified. Currently only CHECK DATE, WEEKEND DATE & CUSTOMER WEEKEND DATE is used"
    type: string
    suggestions: ["CHECK DATE","CUSTOMER WEEKEND DATE","NHIN WEEKEND DATE", "UNAPPLIED CASH FILL DATE","UNAPPLIED CASH STATUS DATE"]
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
}

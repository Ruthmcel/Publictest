view: ar_audit_event {
  label: "Audit Event"
  sql_table_name: EDW.F_AUDIT_EVENT ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${audit_event_audit_event_id} ;;
  }

  dimension: chain_id {
    type: number
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: source_system_id {
    type: number
    label: "EDW Source System Identifier"
    description: "Unique ID number identifying an BI source system"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: audit_event_audit_event_id {
    type: string
    description: "Unique identification number of the Audit Event table"
    hidden:  yes
    sql: ${TABLE}."AUDIT_EVENT_AUDIT_EVENT_ID" ;;
  }

  dimension: audit_event_event_name {
    type: string
    label: "Audit Event Name"
    description: "The name assigned to this event record"
    sql: ${TABLE}."AUDIT_EVENT_EVENT_NAME" ;;
  }

  dimension: audit_event_event_type_id {
    type: number
    label: "Audit Event Type"
    hidden: yes
    description: "Identifies the type of audit"
    sql: ${TABLE}."AUDIT_EVENT_EVENT_TYPE_ID" ;;
  }

  dimension: audit_event_event_type {
    type: string
    label: "Audit Event Type"
    description: "Identifies the type of audit"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${audit_event_event_type_id}) ;;
  }

  dimension: audit_event_event_reason_type_id {
    type: number
    label: "Audit Event Reason"
    hidden: yes
    description: "Identifies the reason for this audit"
    sql: ${TABLE}."AUDIT_EVENT_EVENT_REASON_TYPE_ID" ;;
  }

  dimension: audit_event_event_reason_type {
    type: string
    label: "Audit Event Reason"
    description: "Identifies the reason for this audit"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${audit_event_event_reason_type_id}) ;;
  }

  dimension: audit_event_payer_code {
    type: string
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_PAYER_CODE" ;;
  }

  dimension: audit_event_bin_number {
    type: string
    label: "BIN"
    description: "BIN associated with this audit"
    sql: ${TABLE}."AUDIT_EVENT_BIN_NUMBER" ;;
  }

  dimension: audit_event_pcn_number {
    type: string
    label: "PCN"
    description: "PCN associated with this audit"
    sql: ${TABLE}."AUDIT_EVENT_PCN_NUMBER" ;;
  }

  dimension_group: audit_event_audit {
    type: time
    label: "Audit "
    description: "Date of the audit"
    sql: ${TABLE}."AUDIT_EVENT_AUDIT_DATE" ;;
  }

  dimension_group: audit_event_audit_due {
    type: time
    label: "Audit Due "
    description: "Date the audit is due"
    sql: ${TABLE}."AUDIT_EVENT_AUDIT_DUE_DATE" ;;
  }

  dimension: audit_event_reference_number {
    type: string
    label: "Reference Number"
    description: "Refernce number for the audit"
    sql: ${TABLE}."AUDIT_EVENT_REFERENCE_NUMBER" ;;
  }

  dimension_group: audit_event_start {
    type: time
    label: "Beginning "
    description: "Beginning date range for the audit"
    sql: ${TABLE}."AUDIT_EVENT_START_DATE" ;;
  }

  dimension_group: audit_event_end {
    type: time
    label: "Ending "
    description: "Ending date range for the audit"
    sql: ${TABLE}."AUDIT_EVENT_END_DATE" ;;
  }

  dimension: audit_event_drug_descriptor_qualifier_type_id {
    type: number
    label: "Drug Descriptor Qualifier"
    hidden: yes
    description: "Identifies the classification type of the Drug Descriptor"
    sql: ${TABLE}."AUDIT_EVENT_DRUG_DESCRIPTOR_QUALIFIER_TYPE_ID" ;;
  }

  dimension: audit_event_drug_descriptor_qualifier_type {
    type: string
    label: "Drug Descriptor Qualifier"
    description: "Identifies the classification type of the Drug Descriptor"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${audit_event_drug_descriptor_qualifier_type_id}) ;;
  }

  dimension: audit_event_drug_descriptor {
    type: string
    label: "Drug Descriptor"
    description: "NDC or GPI number assigned to the event record"
    sql: ${TABLE}."AUDIT_EVENT_DRUG_DESCRIPTOR" ;;
  }

  dimension: audit_event_item_description {
    type: string
    label: "Drug Description"
    description: "Description of the drug identified by the drug descriptor in this record"
    sql: ${TABLE}."AUDIT_EVENT_ITEM_DESCRIPTION" ;;
  }

  dimension: audit_event_brand_or_generic {
    type: number
    label: "Drug Brand/Generic"
    hidden: yes
    description: "Identifies if the drug is brand, generic or other"
    sql: ${TABLE}."AUDIT_EVENT_BRAND_OR_GENERIC" ;;
  }

  dimension: audit_event_brand_or_generic_desc {
    type: string
    label: "Drug Brand/Generic"
    description: "Identifies if the drug is brand, generic or other"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${audit_event_brand_or_generic}) ;;
  }

  dimension: audit_event_gross_audit_amount {
    type: number
    label: "Gross Audit Amount"
    description: "Amount being audited"
    sql: ${TABLE}."AUDIT_EVENT_GROSS_AUDIT_AMOUNT" ;;
  }

  dimension: audit_event_claim_count {
    type: number
    label: "Claim Count"
    description: "Number of claims included in the audit"
    sql: ${TABLE}."AUDIT_EVENT_CLAIM_COUNT" ;;
  }

  dimension_group: audit_event_follow_up {
    type: time
    label: "Follow up"
    description: "Next date to follow up on the audit"
    sql: ${TABLE}."AUDIT_EVENT_FOLLOW_UP_DATE" ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: audit_event_event_status_type_id {
    type: number
    label: "Audit Status"
    hidden: yes
    description: "Identifies the status of the audit"
    sql: ${TABLE}."AUDIT_EVENT_EVENT_STATUS_TYPE_ID" ;;
  }

  dimension: audit_event_event_status_type {
    type: string
    label: "Audit Status"
    description: "Identifies the status of the audit"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${audit_event_event_status_type_id}) ;;
  }

  dimension: audit_event_follow_up_email {
    type: string
    label: "Follow Up Email"
    description: "Email address for person's who need to received notifications of an added or updated record"
    sql: ${TABLE}."AUDIT_EVENT_FOLLOW_UP_EMAIL" ;;
  }

  dimension: audit_event_expected_audit_amount {
    type: number
    label: "Expected Audit Amount"
    description: "Amount expected to be recouped/recovered from the audit"
    sql: ${TABLE}."AUDIT_EVENT_EXPECTED_AUDIT_AMOUNT" ;;
  }

  dimension: audit_event_final_audit_amount {
    type: number
    label: "Final Audit Amount"
    description: "Final amount received when the audit is complete"
    sql: ${TABLE}."AUDIT_EVENT_FINAL_AUDIT_AMOUNT" ;;
  }

  dimension_group: audit_event_check {
    type: time
    label: "Check"
    description: "Date of the check"
    sql: ${TABLE}."AUDIT_EVENT_CHECK_DATE" ;;
  }

  dimension: audit_event_check_number {
    type: string
    label: "Check Number"
    description: "Check number presented on the check or eft"
    sql: ${TABLE}."AUDIT_EVENT_CHECK_NUMBER" ;;
  }

  dimension: audit_event_check_amount {
    type: number
    label: "Check Amount"
    description: "Amount of the check/eft"
    sql: ${TABLE}."AUDIT_EVENT_CHECK_AMOUNT" ;;
  }

  dimension: audit_event_added_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_ADDED_USER_IDENTIFIER" ;;
  }

  dimension_group: audit_event_added {
    type: time
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_ADDED_DATE" ;;
  }

  dimension: audit_event_last_updated_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension_group: audit_event_last_updated {
    type: time
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_LAST_UPDATED_DATE" ;;
  }

  dimension_group: audit_event_date_store_contacted {
    type: time
    label: "Date Store Contacted"
    description: "First date the store was contacted"
    sql: ${TABLE}."AUDIT_EVENT_DATE_STORE_CONTACTED" ;;
  }

  dimension_group: audit_event_second_date_store_contacted {
    type: time
    label: "Second Date Store Contacted"
    description: "Second date the store was contacted "
    sql: ${TABLE}."AUDIT_EVENT_SECOND_DATE_STORE_CONTACTED" ;;
  }

  dimension_group: audit_event_third_date_store_contacted {
    type: time
    label: "Third Date Store Contacted"
    description: "Third date the store was contacted "
    sql: ${TABLE}."AUDIT_EVENT_THIRD_DATE_STORE_CONTACTED" ;;
  }

  dimension: audit_event_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_DELETED" ;;
  }

  measure: count {
    type: count
    drill_fields: [audit_event_event_name]
  }
#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Audit Event LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.AUDIT_EVENT_LCR_ID ;;
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
    description: "The DATE TO USE field determines what DATE FIELD is used to aggregate data, based on the time window specified. Currently only AUDIT DATE, AUDIT DUE DATE & FOLLOW UP DATE is used"
    type: string
    suggestions: ["AUDIT DATE", "AUDIT DUE DATE", "FOLLOW UP DATE"]
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

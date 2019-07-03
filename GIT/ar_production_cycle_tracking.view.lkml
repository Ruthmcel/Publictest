view: ar_production_cycle_tracking {
  label: "Production Cycle Tracking"
  sql_table_name: EDW.F_PRODUCTION_CYCLE_TRACKING ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${production_cycle_week_end_date} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Unique ID number identifying a customer in the AR system."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: production_cycle_current_week_end_yes_no {
    label: "Current Week End"
    description: "Yes/No flag determining current week end of production cycle. The system runs a production cycle for each of the dates."
    type: yesno
    sql: ${TABLE}.WEEK_END_DATE  = ${ar_chain_last_week_end_date.production_cycle_last_week_end_date};;
  }

  dimension_group: production_cycle_week_end {
    label: "Week End"
    description: "Date on which the Production cycle week ends (end of accounting week). The system runs a production cycle for each of the dates."
    type: time
    sql: ${TABLE}.WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: production_cycle_tracking_deposit_week_begin {
    label: "Deposit Week Begin"
    description: "Beginning date for which deposits would be included in this week ending’s production cycle"
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_DEPOSIT_WEEK_BEGIN_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: production_cycle_tracking_deposit_week_end {
    label: "Deposit Week End"
    description: "Ending date for which deposits would be included in this week ending’s production cycle"
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_DEPOSIT_WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: production_cycle_tracking_customer_week_end {
    label: "Customer Week End"
    description: "Date on which Customer’s week ends (end of accounting week). The system runs a production cycle for each of the dates.  "
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_CUSTOMER_WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: production_cycle_tracking_end_of_period_flag {
    label: "End Of Period Flag"
    description: "Flag indicating if this is an End of Period week end date."
    type: string
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_END_OF_PERIOD_FLAG ;;
  }

  dimension_group: production_cycle_tracking_production_finish {
    label: "Production Finish"
    description: "Date/time the production cycle process finished"
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_PRODUCTION_FINISH_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: production_cycle_tracking_last_update_user_identifier {
    label: "Last Update User Identifier"
    description: "Identifier of the last user to update this record"
    type: number
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_LAST_UPDATE_USER_IDENTIFIER ;;
  }

  dimension_group: production_cycle_tracking_end_of_period_begin {
    label: "End Of Period Begin"
    description: "Date on which the Period begins. "
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_END_OF_PERIOD_BEGIN_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: production_cycle_tracking_purge {
    hidden: yes
    label: "Tracking Purge"
    description: "The Tracking Purge Date"
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_PURGE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: production_cycle_tracking_period_option_type_id {
    label: "Period Option Type ID"
    description: "Contains values that cross-reference to our NHIN TYPE table. Basically, global definitions that are shared among many tables and all customers within our database. Those values would translate to EOP (end of accounting Period), EOQ (end of quarter), EOY (End of Year)"
    type: number
    hidden: yes
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_PERIOD_OPTION_TYPE_ID ;;
  }

  dimension: deleted {
    label: "Production Cycle Deleted"
    description: "Indicates if a record has been deleted in source"
    type: string
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_DELETED ;;
  }

  #################################################################################### Master code dimensions #############################################################################################################
  dimension: production_cycle_tracking_period_option_type_id_mc {
    label: "Period Option Type"
    description: "Contains values that cross-reference to our NHIN TYPE table.  Basically global definitions that are shared among many tables and all customers within our database. Those values would translate to EOP (end of accounting Period), EOQ (end of quarter), EOY (End of Year)"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.PRODUCTION_CYCLE_TRACKING_PERIOD_OPTION_TYPE_ID) ;;
    suggestions: ["EOQ 1","EOQ 2","EOQ 3","EOQ 4","EOY","EOQ4/EOY"]
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.PRODUCTION_CYCLE_TRACKING_LCR_ID ;;
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
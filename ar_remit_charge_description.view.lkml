view: ar_remit_charge_description {
  label: "Remit Charge Description"
  sql_table_name: EDW.D_REMIT_CHARGE_DESCRIPTION ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${processor_id} ||'@'|| ${plb_code} ;;
  }

dimension: processor_id {
    label: "Payer Code"
    description: "Absolute AR code representing the payer"
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_PROCESSOR_ID ;;
  }

dimension: plb_code {
    label: "Provider Level Balance Code"
    description: "Remit charge code"
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_PROVIDER_LEVEL_BALANCE_CODE ;;
  }

dimension: source_system_ID {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number Identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

dimension: remit_charge_description_provider_level_balance_description {
    label: "Provider Level Balance Description"
    description: "Remit charge description assigned to this code"
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_PROVIDER_LEVEL_BALANCE_DESCRIPTION ;;
  }

dimension: remit_charge_description_added_user_Identifier {
    label: "Remit Charge Description Added User Identifier"
    description: "User that added this record to this table."
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_ADDED_USER_IDENTIFIER ;;
  }

dimension: remit_charge_description_last_update_user_Identifier {
    label: "Remit Charge Description Last Update User Identifier"
    description: "User that last updated this record in this table."
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_LAST_UPDATE_USER_IDENTIFIER ;;
  }

dimension: remit_charge_description_claim_adjustment_segment_code {
    label: "Remit Charge Description Claim Adjustment Segment Code"
    description: "Claim level response codes received from remittances that is used for detail level reporting of DIR fees."
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_CLAIM_ADJUSTMENT_SEGMENT_CODE ;;
  }

dimension: remit_charge_description_dir_fee_flag {
    label: "Remit Charge Description DIR Fee Flag"
    description: "Y/N DIR fee flag for this remit charge"
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_DIR_FEE_FLAG ;;
  }

dimension: remit_charge_description_fee_type_ID {
    label: "Remit Charge Description Fee Type ID"
    hidden: yes
    description: "Defines this charge as a service charge or an adjustment"
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_FEE_TYPE_ID ;;
  }

dimension_group: remit_charge_description_effective_start {
    label: "Remit Charge Description Effective Start"
    description: "Starting effective date for the Payer and remit charge record"
    type: time
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_EFFECTIVE_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

dimension_group: remit_charge_description_effective_end {
    label: "Remit Charge Description Effective End"
    description: "Ending effective date for the Payer and remit charge record"
    type: time
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_EFFECTIVE_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }


dimension: deleted {
    label: "Remit Charge Description Deleted"
    description: "Y/N flag indicating if a record has been deleted in source."
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_DELETED ;;
  }

################################################################################## Master code dimensions ################################################################################################
  dimension: remit_charge_description_fee_type_id_mc {
    label: "Remit Charge Description Fee Type"
    description: "Defines this charge as a service charge or an adjustment"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.REMIT_CHARGE_DESCRIPTION_FEE_TYPE_ID) ;;
    suggestions: ["SERVICE CHARGE","ADJUSTMENT"]
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Remit Charge Description LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.REMIT_CHARGE_DESCRIPTION_LCR_ID ;;
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

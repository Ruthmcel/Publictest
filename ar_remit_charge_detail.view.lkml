view: ar_remit_charge_detail {
  label: "Remit Charge Detail"
  sql_table_name: EDW.F_REMIT_CHARGE_DETAIL ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${remit_charge_detail_sequence_number} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: remit_charge_detail_sequence_number {
    label: "Remit Charge Detail Sequence Number"
    description: "Sequence number"
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_SEQUENCE_NUMBER ;;
    value_format: "0"
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
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: nhin_check_number {
    hidden:  yes
    label: "NHIN Check Number"
    description: "NHIN assigned check number"
    type: number
    sql: ${TABLE}.NHIN_CHECK_NUMBER ;;
  }

  dimension: plb_code {
  hidden:  yes
    label: "Remit Charge Detail Provider Level Balance Code"
    description: "Remit charge code received from remittances.  If a code is not given, NHIN will assign a default code."
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_CODE ;;
  }

  dimension: remit_charge_detail_provider_level_balance_description {
    label: "Remit Charge Detail Provider Level Balance Description"
    description: "Remit charge description assigned to the remit charge code."
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_DESCRIPTION ;;
  }

  dimension: remit_charge_detail_provider_level_balance_type_id {
    label: "Remit Charge Detail Provider Level Balance Type ID"
    description: "Defines this charge as a service charge or an adjustment"
    type: number
    hidden: yes
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_TYPE_ID ;;
  }

  dimension: remit_charge_detail_added_user_identifier {
    label: "Remit Charge Detail Added User Identifier"
    description: "User that added this record to this table."
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_ADDED_USER_IDENTIFIER ;;
  }

  dimension: remit_charge_detail_last_update_user_identifier {
    label: "Remit Charge Detail Last Update User Identifier"
    description: "User that last updated this record in this table."
    type: number
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_LAST_UPDATE_USER_IDENTIFIER ;;
  }

  dimension: deleted {
    hidden:  yes
    label: "Remit Charge Detail Deleted"
    description: "Indicates if a record has been deleted in source."
    type: string
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_DELETED ;;
  }

  ################################################################################## Master code dimensions ####################################################################################
  dimension: remit_charge_detail_provider_level_balance_type_id_mc {
    label: "Remit Charge Detail Provider Level Balance Type"
    description: "Defines this charge as a service charge or an adjustment"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_TYPE_ID) ;;
    suggestions: ["SERVICE CHARGE", "PAYMENT", "REVERSAL","ADJUSTMENT"]

  }

  ################################################################################# Measures ##################################################################################################

  measure: sum_remit_charge_detail_provider_level_balance_amount {
    label: "Remit Charge Amount"
    description: "Total remit charge amount received from remittances"
    type: sum
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_AMOUNT;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_dir_payment_amount {
    label: "DIR Remit Charge Payment Amount"
    description: "Total DIR remit charge payment amount received from remittances. This measure has a conditional check dependency on the 'Remit Charge Description DIR Fee Flag' = 'Y' "
    type: sum
    sql: CASE WHEN ${ar_remit_charge_description.remit_charge_description_dir_fee_flag} = 'Y' THEN ${TABLE}.REMIT_CHARGE_DETAIL_PROVIDER_LEVEL_BALANCE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Remit Charge Detail LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.REMIT_CHARGE_DETAIL_LCR_ID ;;
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
view: ar_write_off_event {
  label: "Write Off Event"
  sql_table_name: EDW.F_WRITE_OFF_EVENT ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${write_off_event_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: write_off_event_id {
    label: "Write Event ID"
    description: "Unique ID number assigned for each write off event processed by Production Cycle in the Absolute system "
    type: number
    sql: ${TABLE}.WRITE_OFF_EVENT_ID ;;
  }

  dimension: write_off_event_type_id {
    label: "Write Off Event Type Id"
    description: "Type ID indicating the type of write off"
    type: number
    hidden: yes
    sql: ${TABLE}.WRITE_OFF_EVENT_TYPE_ID ;;
  }

  dimension: write_off_event_type_desc {
    label: "Write Off Event Type Desc"
    description: "Indicates the write off event type description for (MANUAL SALES ADJ, MANUAL WRITE OFF, CLAIM WRITE OFF) of transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${write_off_event_type_id}) ;;
  }

  dimension: write_off_event_how_closed_type_id {
    label: "Write Off Event How Closed Type Id"
    description: "Type ID indicating the how this write off event was closed"
    type: number
    hidden: yes
    sql: ${TABLE}.WRITE_OFF_EVENT_HOW_CLOSED_TYPE_ID ;;
  }

  dimension: write_off_event_customer_manual_check_batch_number {
    label: "Write Off Event Customer Manual Check Batch Number"
    description: "Customer specific batch number"
    type: string
    sql: ${TABLE}.WRITE_OFF_EVENT_CUSTOMER_MANUAL_CHECK_BATCH_NUMBER ;;
  }

  dimension: write_off_event_manual_check_batch_number {
    label: "Write Off Event Manual Check Batch Number"
    description: "Manual batch number"
    type: number
    sql: ${TABLE}.WRITE_OFF_EVENT_MANUAL_CHECK_BATCH_NUMBER ;;
    value_format: "0"
  }

  dimension: write_off_event_reason {
    label: "Write Off Event Reason"
    description: "Reason/Category for this write off such as WO BAD DEBT, WO DUPLICATES, WO DUPS NO JE, etc"
    type: string
    sql: ${TABLE}.WRITE_OFF_EVENT_REASON ;;
  }

  dimension: write_off_event_added_user_identifier {
    label: "Write Off Event Added User Identifier"
    description: "User that added this record to this table."
    type: number
    sql: ${TABLE}.WRITE_OFF_EVENT_ADDED_USER_IDENTIFIER ;;
  value_format: "0"
  }

  ##################################################################### Master code dimensions #######################################################################
  dimension: write_off_event_how_closed_type_id_mc {
    label: "Write Off Event How Closed Type"
    description: "Type indicating how this write off event was closed"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.WRITE_OFF_EVENT_HOW_CLOSED_TYPE_ID) ;;
    suggestions: [
      "MANUAL",
      "BATCH"]
  }

  dimension: write_off_event_type_id_mc {
    label: "Write Off Event Type"
    description: "Type indicating the type of write off MC"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.WRITE_OFF_EVENT_TYPE_ID) ;;
    suggestions: [
      "MANUAL WRITE OFF",
      "MANUAL SALES ADJ",
      "CLAIM WRITE OFF"]
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Write Off Event LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.WRITE_OFF_EVENT_LCR_ID ;;
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

view: ar_audit_event_notes {
  label: "Audit Event Notes"
  sql_table_name: EDW.F_AUDIT_EVENT_NOTES ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${audit_event_notes_audit_event_id} ||'@'|| ${audit_event_notes_sequence_number} ;;
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

  dimension: audit_event_notes_audit_event_id {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_AUDIT_EVENT_ID" ;;
  }

  dimension: audit_event_notes_sequence_number {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_SEQUENCE_NUMBER" ;;
  }

  dimension: audit_event_notes_note {
    type: string
    label: "Note"
    description: "Note associated with the audit event record"
    sql: ${TABLE}."AUDIT_EVENT_NOTES_NOTE" ;;
  }

  dimension: audit_event_notes_added_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_ADDED_USER_IDENTIFIER" ;;
  }

  dimension_group: audit_event_notes_added_date {
    type: time
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_ADDED_DATE" ;;
  }

  dimension: audit_event_notes_last_updated_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension_group: audit_event_notes_last_updated_date {
    type: time
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_LAST_UPDATED_DATE" ;;
  }

  dimension: audit_event_notes_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}."AUDIT_EVENT_NOTES_DELETED" ;;
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: audit_event_notes_lcr_id {
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

}

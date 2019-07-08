view: ar_unapplied_cash_notes {
  view_label: "Unapplied Cash Notes"
  sql_table_name: EDW.F_UNAPPLIED_CASH_NOTES ;;

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension_group: edw_insert_timestamp {
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
    sql: ${TABLE}."EDW_INSERT_TIMESTAMP" ;;
  }

  dimension_group: edw_last_update_timestamp {
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
    sql: ${TABLE}."EDW_LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}."EVENT_ID" ;;
  }

  dimension: load_type {
    type: string
    sql: ${TABLE}."LOAD_TYPE" ;;
  }

  dimension_group: source_create_timestamp {
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
    sql: ${TABLE}."SOURCE_CREATE_TIMESTAMP" ;;
  }

  dimension: source_system_id {
    type: number
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

  dimension_group: source_timestamp {
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
    sql: ${TABLE}."SOURCE_TIMESTAMP" ;;
  }

  dimension: unapplied_cash_id {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_ID" ;;
  }

  dimension: unapplied_cash_note_added_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_ADDED_USER_IDENTIFIER" ;;
  }

  dimension: unapplied_cash_note_category_id {
    label: "Note Category"
    description: "Indicates the category assigned to the note (i.e. Remit Issue, Audit Issue)"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_CATEGORY_ID" ;;
  }

  dimension: unapplied_cash_note_deleted {
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_DELETED" ;;
  }

  dimension: unapplied_cash_note_last_updated_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension: unapplied_cash_note_lcr_id {
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_LCR_ID" ;;
  }

  dimension: unapplied_cash_note_progress_status_id {
    label: "Progress Status"
    description: "Indicates a measure of progress for the unapplied cash transaction (i.e. In Progress, Resolved)"
    type: number
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_PROGRESS_STATUS_ID" ;;
  }

  dimension: unapplied_cash_note_sequence_number {
    type: number
    hidden:yes
    sql: ${TABLE}."UNAPPLIED_CASH_NOTE_SEQUENCE_NUMBER" ;;
  }

  dimension: unapplied_cash_notes {
    label: "Unapplied Cash Note"
    description: "Unapplied Cash Note text"
    type: string
    sql: ${TABLE}."UNAPPLIED_CASH_NOTES" ;;
  }

  #measure: count {
  #type: count
  #drill_fields: []
  #}
}

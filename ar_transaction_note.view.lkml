view: ar_transaction_note {
  label: "Transaction Note"
  sql_table_name: EDW.F_TRANSACTION_NOTE ;;


  ############################### Dimensions (Primary & Foreign Keys) ########################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_id} ||'@'|| ${transaction_note_sequence_number} ;;
  }

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_id {
    hidden: yes
    label: "Transaction ID"
    type: number
    description: "Unique ID of the transaction associated with this claim. ID of the TRANSACTION_STATUS table record for this claim."
    sql: ${TABLE}.transaction_id ;;
    value_format: "####"
  }

  dimension: transaction_note_sequence_number {
    hidden:  yes
    label: "Transaction Note Sequence Number"
    type: number
    sql: ${TABLE}."TRANSACTION_NOTE_SEQUENCE_NUMBER" ;;
  }

  dimension: source_system_id {
    hidden: yes
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying a BI source system"
    sql: ${TABLE}.source_system_id ;;
  }


  dimension: transaction_note {
    label: "Research Note"
    type: string
    description: "Research note that is associated with the claim"
    sql: ${TABLE}."TRANSACTION_NOTE" ;;
  }

  dimension: transaction_note_category_type_id {
    label: "Research Note Category"
    type: number
    description: "Indicates the research note category"
    sql: ${TABLE}."TRANSACTION_NOTE_CATEGORY_TYPE_ID" ;;
  }

  dimension: transaction_note_progress_status_type_id {
    label: "Research Note Status"
    type: number
    description: "Indicates the status of the note"
    sql: ${TABLE}."TRANSACTION_NOTE_PROGRESS_STATUS_TYPE_ID" ;;
  }

  dimension: transaction_note_deleted {
    type: string
    hidden:  yes
    label: "Transaction Note Deleted"
    description: "Transaction Note Deleted"
    sql: ${TABLE}.TRANSACTION_NOTE_DELETED ;;
  }
}

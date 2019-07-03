view: ar_suspended_tx_info {
  sql_table_name: EDW.F_SUSPENDED_TX_INFO ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_id} ||'@'|| ${suspended_tx_info_sequence_number} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension_group: edw_insert_timestamp {
    type: time
    hidden: yes
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
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}."EVENT_ID" ;;
  }

  dimension: load_type {
    type: string
    hidden: yes
    sql: ${TABLE}."LOAD_TYPE" ;;
  }

  dimension_group: source_create_timestamp {
    type: time
    hidden: yes
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
    hidden: yes
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
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

  dimension: suspended_tx_info_carrier_code {
    label: "Carrier Code"
    description: " Carrier Code may be non NHIN"
    type: string
    sql: ${TABLE}."SUSPENDED_TX_INFO_CARRIER_CODE" ;;
  }

  dimension: suspended_tx_info_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_DELETED" ;;
  }

  dimension: suspended_tx_info_how_submitted_type_id {
    label: "Submission Method Id"
    description: "Indicates how the claim was submitted by the pharmacy"
    type: number
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_HOW_SUBMITTED_TYPE_ID" ;;
  }

  dimension: suspended_tx_info_how_submitted_type {
    label: "Submission Method"
    description: "Indicates how the claim was submitted by the pharmacy"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${suspended_tx_info_how_submitted_type_id}) ;;
  }

  dimension: suspended_tx_info_last_updated_user_identifier {
    type: number
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension: suspended_tx_info_lcr_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_LCR_ID" ;;
  }

  dimension: suspended_tx_info_plan_code {
    label: "Plan Code"
    description: "Plan Code may be non NHIN"
    type: string
    sql: ${TABLE}."SUSPENDED_TX_INFO_PLAN_CODE" ;;
  }

  dimension: suspended_tx_info_sequence_number {
    type: number
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_SEQUENCE_NUMBER" ;;
  }

  dimension: suspended_tx_info_suspended_detail_type {
    label: "Suspend Type Detail"
    description: "Further describes the suspend type"
    type: number
    sql: ${TABLE}."SUSPENDED_TX_INFO_SUSPENDED_DETAIL_TYPE" ;;
  }

  dimension: suspended_tx_info_suspended_type_id {
    label: "Suspend Type Id"
    description: "Reason claim was suspended"
    type: number
    hidden: yes
    sql: ${TABLE}."SUSPENDED_TX_INFO_SUSPENDED_TYPE_ID" ;;
  }

  dimension: suspended_tx_info_suspended_type{
    label: "Suspend Type"
    description: "Reason claim was suspended"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${suspended_tx_info_suspended_type_id}) ;;
  }

  dimension: transaction_id {
    type: number
    hidden: yes
    sql: ${TABLE}."TRANSACTION_ID" ;;
  }

}

view: poc_dr_mtm_session {
  sql_table_name: EDW.DR_MTM_SESSION_SUCCESS_RATE_PREDICTION ;;

  dimension: file_row_id {
    type: number
    description: "Unique identifier of a record with in a prediction file"
    label: "File Row ID"
    sql: ${TABLE}.FILE_ROW_ID ;;
  }

  dimension: primary_key {
    type: string
    description: "Unique identifier of a record"
    hidden: yes
    primary_key: yes
    sql: ${file_row_id}||'@'||${session_id} ;;
  }

  dimension: session_id {
    type: number
    description: "Session ID"
    label: "Session ID"
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension: session_success_rate {
    type: number
    description: "Session Success. Defined based on when the session compelted. If a session is completed with in 7 days, session considered as success."
    label: "Session Success Rate"
    sql: ${TABLE}.SESSION_SUCCESS_RATE ;;
    value_format: "00.00%"
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
    description: "EDW Insert Time"
    label: "EDW Insert Times"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  measure: avg_session_success_rate {
    type: average
    description: "Average Session Success. Defined based on when the session compelted. If a session is completed with in 7 days, session considered as success."
    label: "Avg Session Success Rate"
    sql: ${TABLE}.SESSION_SUCCESS_RATE ;;
    value_format: "00.00%"
  }
}

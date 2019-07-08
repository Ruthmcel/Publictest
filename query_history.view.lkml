view: query_history {
  sql_table_name: etl_manager.query_history ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${query_id} ;;
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: query_id {
    label: "Query Id"
    description: "The statement’s unique id"
    type: string
    sql: ${TABLE}.query_id ;;
  }

  dimension: query_text_short {
    label: "Query Text - Short"
    description: "Short Text of the SQL statement"
    type: string
    sql: substring(${TABLE}.query_text,1,100) ;;
  }

  dimension: query_text {
    label: "Query Text - Long"
    description: "Long Text of the SQL statement"
    type: string
    sql: ${TABLE}.query_text ;;
  }

  dimension: database_name {
    label: "Database Name"
    description: "Database that was in use at the time of the query"
    type: string
    sql: ${TABLE}.database_name ;;
  }

  dimension: schema_name {
    label: "Schema Name"
    description: "Schema that was in use at the time of the query"
    type: string
    sql: ${TABLE}.schema_name ;;
  }

  dimension: query_type {
    label: "Query Type"
    description: "DML, query, etc. If the query is currently running, or the query failed, then the query type may be UNKNOWN"
    type: string
    sql: ${TABLE}.query_type ;;
  }

  dimension: session_id {
    label: "Session Id"
    description: "Session that executed the statement"
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_name {
    label: "User Name"
    description: "User who issued the query"
    type: string
    sql: ${TABLE}.user_name ;;
  }

  dimension: role_name {
    label: "Role Name"
    description: "Role that was active in the session at the time of the query"
    type: string
    sql: ${TABLE}.role_name ;;
  }

  dimension: warehouse_name {
    label: "Warehouse Name"
    description: "Warehouse that the query executed on, if any"
    type: string
    sql: ${TABLE}.warehouse_name ;;
  }

  dimension: warehouse_size {
    label: "Warehouse Size"
    description: "Size of the warehouse when this statement executed"
    type: string
    sql: ${TABLE}.warehouse_size ;;
  }

  dimension: warehouse_type {
    label: "Warehouse Type"
    description: "Type of the warehouse when this statement executed"
    type: string
    sql: ${TABLE}.warehouse_type ;;
  }

  dimension: query_tag {
    label: "Query Tag"
    description: "Query tag set for this statement through the QUERY_TAG session parameter"
    type: string
    sql: ${TABLE}.query_tag ;;
  }

  dimension: execution_status {
    label: "Execution Status"
    description: "running, queued, blocked, success, error, incident, ..."
    type: string
    sql: ${TABLE}.execution_status ;;
  }

  dimension: error_code {
    label: "Error Code"
    description: "Error code, if the query returned an error"
    type: number
    sql: ${TABLE}.error_code ;;
  }

  dimension: error_message {
    label: "Error Message"
    description: "Error message, if the query returned an error"
    type: string
    sql: ${TABLE}.error_message ;;
  }

  dimension_group: start_time {
    label: "Start Time"
    description: "Date/Time on which Statement started"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension_group: end_time {
    label: "End Time"
    description: "Date/Time on which statement ended, or NULL if the statement is still running."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.end_time ;;
  }

  ######################################################################################################### Measures #############################################################################################################

  measure: total_elapsed_time {
    label: "Total Elapsed Time (in milliseconds)"
    description: "Elapsed time (in milliseconds)"
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.total_elapsed_time ;;
    value_format: "######"
  }

  measure: compilation_time {
    label: "Compilation Time (in milliseconds)"
    description: "Compilation time (in milliseconds)"
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.compilation_time ;;
    value_format: "######"
  }

  measure: execution_time {
    label: "Execution Time (in milliseconds)"
    description: "Execution time (in milliseconds)"
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.execution_time ;;
    value_format: "######"
  }

  measure: queued_provisioning_time {
    label: "Queued Provisioning Time (in milliseconds)"
    description: "Time (in milliseconds) spent in the warehouse queue, waiting for the warehouse servers to provision, due to warehouse creation, resume, or resize."
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.queued_provisioning_time ;;
    value_format: "######"
  }

  measure: queued_repair_time {
    label: "Queued Repair Time (in milliseconds)"
    description: "Time (in milliseconds) spent in the warehouse queue, waiting for servers in the warehouse to be repaired."
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.queued_repair_time ;;
    value_format: "######"
  }

  measure: queued_overload_time {
    label: "Queued Overload Time (in milliseconds)"
    description: "Time (in milliseconds) spent in the warehouse queue, due to the warehouse being overloaded by the current query workload."
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.queued_overload_time ;;
    value_format: "######"
  }

  measure: transaction_blocked_time {
    label: "Transaction Blocked Time (in milliseconds)"
    description: "Time (in milliseconds) spent blocked by a concurrent DML"
    group_label: "Measures in milliseconds"
    type: sum
    sql: ${TABLE}.transaction_blocked_time ;;
    value_format: "######"
  }

  ################## Measures in seconds ########################
  measure: total_elapsed_time_sec {
    label: "Total Elapsed Time (in seconds)"
    description: "Elapsed time (in seconds)"
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.total_elapsed_time/1000 ;;
    value_format: "######"
  }

  measure: compilation_time_sec {
    label: "Compilation Time (in seconds)"
    description: "Compilation time (in seconds)"
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.compilation_time/1000 ;;
    value_format: "######"
  }

  measure: execution_time_sec {
    label: "Execution Time (in seconds)"
    description: "Execution time (in seconds)"
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.execution_time/1000 ;;
    value_format: "######"
  }

  measure: queued_provisioning_time_sec {
    label: "Queued Provisioning Time (in seconds)"
    description: "Time (in seconds) spent in the warehouse queue, waiting for the warehouse servers to provision, due to warehouse creation, resume, or resize."
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.queued_provisioning_time/1000 ;;
    value_format: "######"
  }

  measure: queued_repair_time_sec {
    label: "Queued Repair Time (in seconds)"
    description: "Time (in seconds) spent in the warehouse queue, waiting for servers in the warehouse to be repaired."
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.queued_repair_time/1000 ;;
    value_format: "######"
  }

  measure: queued_overload_time_sec {
    label: "Queued Overload Time (in seconds)"
    description: "Time (in seconds) spent in the warehouse queue, due to the warehouse being overloaded by the current query workload."
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.queued_overload_time/1000 ;;
    value_format: "######"
  }

  measure: transaction_blocked_time_sec {
    label: "Transaction Blocked Time (in seconds)"
    description: "Time (in seconds) spent blocked by a concurrent DML"
    group_label: "Measures in seconds"
    type: sum
    sql: ${TABLE}.transaction_blocked_time/1000 ;;
    value_format: "######"
  }

  ################## Measures in minutes ########################
  measure: total_elapsed_time_min {
    label: "Total Elapsed Time (in minutes)"
    description: "Elapsed time (in minutes)"
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.total_elapsed_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: compilation_time_min {
    label: "Compilation Time (in minutes)"
    description: "Compilation time (in minutes)"
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.compilation_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: execution_time_min {
    label: "Execution Time (in minutes)"
    description: "Execution time (in minutes)"
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.execution_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: queued_provisioning_time_min {
    label: "Queued Provisioning Time (in minutes)"
    description: "Time (in minutes) spent in the warehouse queue, waiting for the warehouse servers to provision, due to warehouse creation, resume, or resize."
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.queued_provisioning_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: queued_repair_time_min {
    label: "Queued Repair Time (in minutes)"
    description: "Time (in minutes) spent in the warehouse queue, waiting for servers in the warehouse to be repaired."
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.queued_repair_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: queued_overload_time_min {
    label: "Queued Overload Time (in minutes)"
    description: "Time (in minutes) spent in the warehouse queue, due to the warehouse being overloaded by the current query workload."
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.queued_overload_time/1000/60 ;;
    value_format: "#,##0.00"
  }

  measure: transaction_blocked_time_min {
    label: "Transaction Blocked Time (in minutes)"
    description: "Time (in minutes) spent blocked by a concurrent DML"
    group_label: "Measures in minutes"
    type: sum
    sql: ${TABLE}.transaction_blocked_time/1000/60 ;;
    value_format: "#,##0.00"
  }
}

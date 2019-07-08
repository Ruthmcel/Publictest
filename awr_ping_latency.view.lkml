view: awr_ping_latency {
  label: "Ping Latency"
  sql_table_name: AWR_DATA.PING_LATENCY ;;
  # Notes:
  # 1. View file added as a part of ERXLPS-90 change

  dimension: unique_key {
    type: string
    label: "AWR Ping Latency Unique Key"
    hidden: yes
    description: "Unique number identifiying a Ping Latency in AWR"
    sql: ${awr_rpt_id} ||'@'|| ${source_instance} ||'@'|| ${target_instance} ;; #ERXLPS-1649
  }

  dimension: awr_rpt_id {
    type: number
    hidden: yes
    label: "AWR Report ID"
    description: "Unique number identifiying an Automatic Workload Repository for the Begin and End Snapshot"
    sql: ${TABLE}.AWR_RPT_ID ;;
  }

  dimension: source_instance {
    type: number
    label: "Source Instance"
    description: "Source instance is identified by an instance number on the database"
    sql: ${TABLE}.SOURCE_INSTANCE ;;
  }

  dimension: source_instance_name {
    type: string
    label: "Source Instance Name"
    description: "Source instance is identified by an instance name on the database"

    case: {
      when: {
        sql: ${TABLE}.SOURCE_INSTANCE = 4 ;;
        label: "NHIN04P"
      }

      when: {
        sql: ${TABLE}.SOURCE_INSTANCE = 5 ;;
        label: "NHIN05P"
      }

      when: {
        sql: ${TABLE}.SOURCE_INSTANCE = 6 ;;
        label: "NHIN06P"
      }

      when: {
        sql: ${TABLE}.SOURCE_INSTANCE = 7 ;;
        label: "NHIN07P"
      }
    }

    suggestions: ["NHIN04P", "NHIN05P", "NHIN06P", "NHIN07P"]
  }

  dimension: target_instance {
    type: number
    label: "Target Instance"
    description: "Target instance is identified by an instance number on the database"
    sql: ${TABLE}.TARGET_INSTANCE ;;
  }

  dimension: target_instance_name {
    type: string
    label: "Target Instance Name"
    description: "Target instance is identified by an instance name on the database"

    case: {
      when: {
        sql: ${TABLE}.TARGET_INSTANCE = 4 ;;
        label: "NHIN04P"
      }

      when: {
        sql: ${TABLE}.TARGET_INSTANCE = 5 ;;
        label: "NHIN05P"
      }

      when: {
        sql: ${TABLE}.TARGET_INSTANCE = 6 ;;
        label: "NHIN06P"
      }

      when: {
        sql: ${TABLE}.TARGET_INSTANCE = 7 ;;
        label: "NHIN07P"
      }
    }

    suggestions: ["NHIN04P", "NHIN05P", "NHIN06P", "NHIN07P"]
  }

  ####################################################################################################### Measures ####################################################################################################
  measure: count_ping_500b {
    label: "Ping Latency Count (500B)"
    description: "Total Ping Counts for message size of 500 bytes"
    type: sum
    sql: ${TABLE}.PING_COUNT_500B ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,###"
  }

  measure: count_ping_8k {
    label: "Ping Latency Count (8K)"
    description: "Total Ping Counts for message size of 8 Kilobytes"
    type: sum
    sql: ${TABLE}.PING_COUNT_8K ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,###"
  }

  measure: sum_ping_time_sec_500b {
    label: "Total Ping Latency Time In Seconds (500B)"
    description: "Total Ping latency in seconds of the roundtrip of a message from source to target instance for message size of 500 bytes"
    type: sum
    sql: ${TABLE}.PING_TIME_SEC_500B ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: sum_ping_time_sec_8k {
    label: "Total Ping Latency Time In Seconds (8K)"
    description: "Ping latency in seconds of the roundtrip of a message from source to target instance for message size of 8 kilobytes"
    type: sum
    sql: ${TABLE}.PING_TIME_SEC_8K ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: avg_ping_time_millisec_500b {
    label: "Avg Ping Latency Time In Milliseconds (500B)"
    description: "Average Ping latency in milliseconds of the roundtrip of a message from source to target instance for message size of 500 bytes"
    type: average
    sql: ${TABLE}.AVG_TIME_MS_500B ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_ping_time_millisec_8k {
    label: "Avg Ping Latency Time In Milliseconds (8K)"
    description: "Average Ping latency in milliseconds of the roundtrip of a message from source to target instance for message size of 8 kilobytes"
    type: average
    sql: ${TABLE}.AVG_TIME_MS_8K ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: stddev_ping_time_millisec_500b {
    label: "Std Dev Ping Latency Time In Milliseconds (500B)"
    description: "Standard Deviation Ping latency in milliseconds of the roundtrip of a message from source to target instance for message size of 500 bytes"
    type: number
    sql: STDDEV(${TABLE}.STDDEV_MS_500B) ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: stddev_ping_time_millisec_8k {
    label: "Std Dev  Ping Latency Time In Milliseconds (8K)"
    description: "Standard Deviation Ping latency in milliseconds of the roundtrip of a message from source to target instance for message size of 8 kilobytes"
    type: number
    sql: STDDEV(${TABLE}.STDDEV_MS_8K) ;;
    drill_fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.source_instance,
      awr_report.target_instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time
    ]
    value_format: "#,##0.0000 \" MSec\""
  }

  ####################################################################################################### End of Measures ####################################################################################################

  set: awr_io_static_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_ping_latency.source_instance,
      awr_ping_latency.source_instance_name,
      awr_ping_latency.target_instance,
      awr_ping_latency.target_instance_name,
      awr_report.start_snap_id,
      awr_report.end_snap_id,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_ping_latency.count_ping_500b,
      awr_ping_latency.count_ping_8k,
      awr_ping_latency.sum_ping_time_sec_500b,
      awr_ping_latency.sum_ping_time_sec_8k,
      awr_ping_latency.avg_ping_time_millisec_500b,
      awr_ping_latency.avg_ping_time_millisec_8k,
      awr_ping_latency.stddev_ping_time_millisec_500b,
      awr_ping_latency.stddev_ping_time_millisec_8k
    ]
  }
}

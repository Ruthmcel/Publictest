view: awr_foreground_wait_class {
  label: "Foreground Wait Class"
  sql_table_name: AWR_DATA.FOREGROUND_WAIT_CLASS ;;
  # Notes:
  # 1. View file added as a part of ERXLPS-90 change

  dimension: awr_rpt_id {
    type: number
    primary_key: yes
    hidden: yes
    label: "AWR Report ID"
    description: "Unique number identifiying an Automatic Workload Repository for the Begin and End Snapshot"
    sql: ${TABLE}.AWR_RPT_ID ;;
  }

  ####################################################################################################### Measures ####################################################################################################
  measure: user_io_pct {
    label: "User IO %"
    description: "Percentage of user IO (db file sequential read, db file scattered read, direct path read, direct path write etc)"
    type: average
    sql: ${TABLE}.USER_IO_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: system_io_pct {
    label: "System IO %"
    description: "Percentage of background process IO"
    type: average
    sql: ${TABLE}.SYS_IO_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: other_pct {
    label: "Other %"
    type: average
    sql: ${TABLE}.OTHER_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: application_pct {
    label: "Application %"
    description: "Percentage resulting from user application code (for example, lock waits caused by row level locking or explicit lock commands)"
    type: average
    sql: ${TABLE}.APPLICATION_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: commit_pct {
    label: "Commit %"
    description: "Percentage for redo log write confirmation after a commit"
    type: average
    sql: ${TABLE}.COMMIT_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: network_pct {
    label: "Network %"
    description: "Percentage for data to be sent over the network"
    type: average
    sql: ${TABLE}.NETWORK_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: concurrency_pct {
    label: "Concurrency %"
    description: "Percentage for internal database resources (for example, latches)"
    type: average
    sql: ${TABLE}.CONCURRENCY_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: configuration_pct {
    label: "Configuration %"
    description: "Percentage caused by inadequate configuration of database or instance resources (for example, undersized log file sizes, shared pool size etc)"
    type: average
    sql: ${TABLE}.CONFIGURATION_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: cluster_pct {
    label: "Cluster %"
    description: "Percentage for user IO (db file sequential read, db file scattered read, direct path read, direct path write etc)"
    type: average
    sql: ${TABLE}.CLUSTER_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  measure: db_cpu_pct {
    label: "Database CPU IO %"
    description: "Percentage for user IO (db file sequential read, db file scattered read, direct path read, direct path write etc)"
    type: average
    sql: ${TABLE}.DB_CPU_PCT ;;
    drill_fields: [awr_foreground_wait_class_detail*]
    value_format: "###0.00"
  }

  ####################################################################################################### End of Measures ######################################1##############################################################

  set: awr_foreground_wait_class_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_report.start_snap_id,
      awr_report.end_snap_id,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_foreground_wait_class.user_io_pct,
      awr_foreground_wait_class.system_io_pct,
      awr_foreground_wait_class.other_pct,
      awr_foreground_wait_class.application_pct,
      awr_foreground_wait_class.commit_pct,
      awr_foreground_wait_class.network_pct,
      awr_foreground_wait_class.concurrency_pct,
      awr_foreground_wait_class.configuration_pct,
      awr_foreground_wait_class.cluster_pct,
      awr_foreground_wait_class.db_cpu_pct
    ]
  }
}

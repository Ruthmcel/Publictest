view: awr_cpu_statistic {
  label: "CPU Statistics"
  sql_table_name: AWR_DATA.CPU_STATISTICS ;;
  # Notes:
  # 1. View file added as a part of ERXLPS-90 change

  dimension: unique_key {
    type: string
    label: "AWR Ping Latency Unique Key"
    hidden: yes
    description: "Unique number identifiying a Global Cache Enqueue in AWR"
    sql: ${awr_rpt_id} ||'@'|| ${instance} ;; #ERXLPS-1649
  }

  dimension: awr_rpt_id {
    type: number
    hidden: yes
    label: "AWR Report ID"
    description: "Unique number identifiying an Automatic Workload Repository for the Begin and End Snapshot"
    sql: ${TABLE}.AWR_RPT_ID ;;
  }

  dimension: instance {
    hidden: yes
    type: number
    label: "Database Instance"
    description: "Indentifies the node or instance number on the database"
    sql: ${TABLE}.INSTANCE ;;
  }

  dimension: number_of_cpu {
    label: "Number of CPU"
    type: number
    sql: ${TABLE}.NBR_CPUS ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "#,###"
  }

  dimension: number_of_cpu_cores {
    label: "Number of Cores (per CPU)"
    type: number
    sql: ${TABLE}.NBR_CPU_CORES ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "#,###"
  }

  ####################################################################################################### Measures ####################################################################################################

  measure: load_begin {
    label: "Load Begin"
    type: number
    sql: AVG(${TABLE}.LOAD_BEGIN) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "#,###"
  }

  measure: load_end {
    label: "Load End"
    type: number
    sql: AVG(${TABLE}.LOAD_END) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "#,###"
  }

  measure: cpu_busy_pct {
    label: "CPU Busy Time %"
    description: "Percentage of Time the CPU is busy"
    type: number
    sql: AVG(${TABLE}.CPU_PCT_BUSY) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "###0.00"
  }

  measure: cpu_idle_pct {
    label: "CPU Idle Time %"
    description: "Percentage of Time the CPU is Idle"
    type: number
    sql: AVG(${TABLE}.CPU_PCT_IDLE) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "###0.00"
  }

  measure: cpu_user_pct {
    label: "CPU User Time %"
    description: "Percentage of time spent on the processor running your program's code (or code in libraries)"
    type: number
    sql: AVG(${TABLE}.CPU_PCT_USER) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "###0.00"
  }

  measure: cpu_system_pct {
    label: "CPU System Time %"
    description: "Percentage of time spent running code in the operating system kernel on behalf of the application program"
    type: number
    sql: AVG(${TABLE}.CPU_PCT_SYS) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "###0.00"
  }

  measure: cpu_wio_pct {
    label: "CPU IO Wait Time %"
    description: "Percentage of Time the CPU has been waiting for I/O to complete"
    type: number
    sql: AVG(${TABLE}.CPU_PCT_WIO) ;;
    drill_fields: [awr_cpu_statistic_detail*]
    value_format: "###0.00"
  }

  ####################################################################################################### End of Measures ####################################################################################################

  set: awr_cpu_statistic_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_cpu_statistic.instance,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_cpu_statistic.number_of_cpu,
      awr_cpu_statistic.number_of_cpu_cores,
      awr_cpu_statistic.load_begin,
      awr_cpu_statistic.load_end,
      awr_cpu_statistic.cpu_busy_pct,
      awr_cpu_statistic.cpu_idle_pct,
      awr_cpu_statistic.cpu_user_pct,
      awr_cpu_statistic.cpu_system_pct,
      awr_cpu_statistic.cpu_wio_pct
    ]
  }
}

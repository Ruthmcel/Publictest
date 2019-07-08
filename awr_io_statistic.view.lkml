view: awr_io_statistic {
  label: "IO Statistics"
  sql_table_name: AWR_DATA.IO_STATISTICS ;;
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

  ####################################################################################################### Measures ####################################################################################################
  measure: avg_db_file_seq_read_ms {
    label: "Avg DB File Sequential Read (ms)"
    description: "Average Database File Sequential Read in Milliseconds. This wait event signifies that the user process is reading a buffer into the SGA buffer cache and is waiting for a physical I/O call to return. A sequential read is a single-block read. Single block I/Os are usually the result of using indexes"
    type: number
    sql: AVG(${TABLE}.AVG_DB_FILE_SEQ_READ_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_db_file_scattered_read_ms {
    label: "Avg DB File Scattered Read (ms)"
    description: "Average Database File Scattered Read in Milliseconds. This wait event signifies that the user process is reading buffers into the SGA buffer cache and is waiting for a physical I/O call to return. A db file scattered read issues a scattered read to read the data into multiple discontinuous memory locations. A scattered read is usually a multiblock read. It can occur for a fast full scan (of an index) in addition to a full table scan"
    type: number
    sql: AVG(${TABLE}.AVG_DB_FILE_SCATTERED_READ_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_direct_path_read_ms {
    label: "Avg Direct Path Read (ms)"
    description: "Average Direct Path Read in Milliseconds. This wait event represents an access path in which multiple Oracle blocks are read directly to the Oracle process memory without being read into the buffer cache in the Shared Global Area (SGA). This event is usually caused by scanning an entire table, index, table partition, or index partition during Parallel Query execution. DB File Sequential Read is the common wait event associated with disk I/O"
    type: number
    sql: AVG(${TABLE}.AVG_DIRECT_PATH_READ_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_db_file_parallel_write_ms {
    label: "Avg DB File Parallel Write (ms)"
    description: "Average Database File Parallel Write in Milliseconds. This wait event occurs when the process, typically DBWR, has issued multiple I/O requests in parallel to write dirty blocks from the buffer cache to disk, and is waiting for all requests to complete"
    type: number
    sql: AVG(${TABLE}.AVG_DB_FILE_PARALLEL_WRITE_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_log_file_sync_ms {
    label: "Avg Log File Sync (ms)"
    description: "Average Log File Sync in Milliseconds. This wait event represents the time the session is waiting for the log buffers to be written to disk"
    type: number
    sql: AVG(${TABLE}.AVG_LOG_FILE_SYNC_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_log_file_sequential_read_ms {
    label: "Avg Log File Sequential Read (ms)"
    description: "Average Log File Sequential Read in Milliseconds. This wait event indicates that the process is waiting for blocks to be read from the online redo log into memory"
    type: number
    sql: AVG(${TABLE}.AVG_LOG_FILE_SEQ_READ_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_log_file_parallel_write_ms {
    label: "Avg Log File Parallel Write (ms)"
    description: "Average Log File Parallel Write in Milliseconds. This wait event involves writing redo records to the redo log files from the log buffer"
    type: number
    sql: AVG(${TABLE}.AVG_LOG_PARALLEL_WRITE_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_ctl_file_sequential_read_ms {
    label: "Avg Ctl File Sequential Read (ms)"
    description: "Average Control File Sequential Read in Milliseconds. This event indicates the process is waiting for blocks to be read from a control file. It normally occur when the control files are placed on the same physical disk, causing read-write head contention at the disk level"
    type: number
    sql: AVG(${TABLE}.AVG_CTL_FILE_SEQ_READ_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_ctl_file_parallel_write_ms {
    label: "Avg Ctl File Parallel Write (ms)"
    description: "Average Control File Parallel Write in Milliseconds. This event occurs while the session is writing physical blocks to all control files"
    type: number
    sql: AVG(${TABLE}.AVG_CTL_FILE_PARALLEL_WRITE_MS) ;;
    drill_fields: [awr_io_static_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 18 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 30 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  ####################################################################################################### End of Measures ####################################################################################################


  set: awr_io_static_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_global_cache_enqueue.instance,
      awr_report.start_snap_id,
      awr_report.end_snap_id,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_io_statistic.avg_db_file_seq_read_ms,
      awr_io_statistic.avg_db_file_scattered_read_ms,
      awr_io_statistic.avg_direct_path_read_ms,
      awr_io_statistic.avg_db_file_parallel_write_ms,
      awr_io_statistic.avg_log_file_sync_ms,
      awr_io_statistic.avg_log_file_sequential_read_ms,
      awr_io_statistic.avg_log_file_parallel_write_ms,
      awr_io_statistic.avg_ctl_file_sequential_read_ms,
      awr_io_statistic.avg_ctl_file_parallel_write_ms
    ]
  }
}

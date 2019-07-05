view: awr_global_block {
  label: "Global Blocks"
  sql_table_name: AWR_DATA.GLOBAL_BLOCKS ;;
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
  measure: sum_gc_cr_blocks_rcvd {
    label: "Total GC CR Blocks Received"
    description: "Total number of Consistent Read blocks received from the remote instance over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.CR_BLOCKS_RCVD) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
  }

  measure: sum_gc_curr_blocks_rcvd {
    label: "Total GC CURR locks Received"
    description: "Total number of Current Read blocks received from the remote instance over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.CURRENT_BLOCKS_RCVD) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
  }

  measure: sum_gc_cr_blocks_sent {
    label: "Total GC CR Blocks Sent"
    description: "Total number of Consistent Read blocks sent to the remote instance over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.CR_BLOCKS_SENT) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
  }

  measure: sum_gc_curr_blocks_sent {
    label: "Total GC CURR Blocks Sent"
    description: "Total number of Current Read blocks sent to the remote instance over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.CURRENT_BLOCKS_SENT) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
  }

  measure: sum_gc_blocks_lost {
    label: "Total GC Blocks Lost"
    description: "Total number of blocks lost over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.BLOCKS_LOST) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
    html: {% if value < 50 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 75 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: sum_gc_blocks_failure {
    label: "Total GC Block Failures"
    description: "Total number of blocks failed over the hardware interconnect"
    type: number
    sql: SUM(${TABLE}.BLOCK_FAILURES) ;;
    drill_fields: [awr_global_block_detail*]
    value_format: "#,###"
    html: {% if value < 200 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 300 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  ####################################################################################################### End of Measures ##################################################

  set: awr_global_block_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_global_cache_enqueue.instance,
      awr_report.start_snap_id,
      awr_report.end_snap_id,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_global_cache_enqueue.avg_gc_get_time_millisec,
      awr_global_block.sum_gc_cr_blocks_sent,
      awr_global_block.sum_gc_cr_blocks_rcvd,
      awr_global_block.sum_gc_curr_blocks_sent,
      awr_global_block.sum_gc_curr_blocks_rcvd,
      awr_global_block.sum_gc_blocks_lost,
      awr_global_block.sum_gc_blocks_failure
    ]
  }
}

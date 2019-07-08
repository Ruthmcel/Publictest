view: awr_global_cache_enqueue {
  label: "Global Cache Enqueue"
  sql_table_name: AWR_DATA.GLOBAL_CACHE_ENQUEUE ;;
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
    type: number
    label: "Database Instance"
    description: "Indentifies the node or instance number on the database"
    sql: ${TABLE}.INSTANCE ;;
  }

  dimension: instance_name {
    type: string
    label: "Database Instance Name"
    description: "Indentifies the node or instance name on the database"

    case: {
      when: {
        sql: ${TABLE}.INSTANCE = 4 ;;
        label: "NHIN04P"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 5 ;;
        label: "NHIN05P"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 6 ;;
        label: "NHIN06P"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 7 ;;
        label: "NHIN07P"
      }
    }

    suggestions: ["NHIN04P", "NHIN05P", "NHIN06P", "NHIN07P"]
  }

  dimension: host {
    type: string
    label: "Host Name"
    description: "Indentifies the host name on the database"

    case: {
      when: {
        sql: ${TABLE}.INSTANCE = 4 ;;
        label: "FTW-DBX-CLST-01"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 5 ;;
        label: "FTW-DBX-CLST-02"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 6 ;;
        label: "DP-CSDB-01"
      }

      when: {
        sql: ${TABLE}.INSTANCE = 7 ;;
        label: "DP-CSDB-02"
      }
    }

    suggestions: ["FTW-DBX-CLST-01", "FTW-DBX-CLST-02", "DP-CSDB-01", "DP-CSDB-02"]
  }

  ####################################################################################################### Measures ####################################################################################################
  measure: avg_gc_get_time_millisec {
    label: "Avg GC enqueue get time (ms)"
    description: "Average Global Cache Enqueue Get Time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_GET_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
    html: {% if value < 2 %}
        <b><p style="background-color: #20D76C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% elsif value < 5 %}
        <b><p style="background-color: #e9b404; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% else %}
        <b><p style="background-color: #DC143C; font-size:100%; color: white; text-align:center; margin: 0; border-radius: 5px;"><a href="{{ link }}">{{ rendered_value }}</a></p></b>
      {% endif %}
      ;;
  }

  measure: avg_gc_cr_receive_time_millisec {
    label: "Avg GC CR block receive time (ms)"
    description: "Average Global Cache Consistent Read block receive time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CR_RECEIVE_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_cr_build_time_millisec {
    label: "Avg GC CR block build time (ms)"
    description: "Average Global Cache Consistent Read block build time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CR_BUILD_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_cr_sent_time_millisec {
    label: "Avg GC CR block send time (ms)"
    description: "Average Global Cache Consistent Read block send time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CR_SENT_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_cr_flush_time_millisec {
    label: "Avg GC CR block flush time (ms)"
    description: "Average Global Cache Consistent Read block flush time in Milliseconds. CR is the buffer state"
    type: number
    sql: AVG(${TABLE}.AVG_CR_FLUSH_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_curr_receive_time_millisec {
    label: "Avg GC CURR block receive time (ms)"
    description: "Average Global Cache Current Read block receive time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CURR_RECEIVE_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_curr_pin_time_millisec {
    label: "Avg GC CURR block pin time (ms)"
    description: "Average Global Cache Current Read block pin time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CURR_PIN_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_curr_send_time_millisec {
    label: "Avg GC CURR block send time (ms)"
    description: "Average Global Cache Current Read block send time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CURR_SEND_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  measure: avg_gc_curr_flush_time_millisec {
    label: "Avg GC CURR block flush time (ms)"
    description: "Average Global Cache Current Read block flush time in Milliseconds"
    type: number
    sql: AVG(${TABLE}.AVG_CURR_FLUSH_TIME_MS) ;;
    drill_fields: [awr_global_cache_enqueue_detail*]
    value_format: "#,##0.0000 \" MSec\""
  }

  ####################################################################################################### End of Measures ###############################################


  set: awr_global_cache_enqueue_detail {
    fields: [
      awr_report.awr_rpt_id,
      awr_report.database_id,
      awr_global_cache_enqueue.instance,
      awr_report.start_snap_id,
      awr_report.end_snap_id,
      awr_report.begin_interval_time,
      awr_report.end_interval_time,
      awr_global_cache_enqueue.avg_gc_get_time_millisec,
      awr_global_cache_enqueue.avg_gc_cr_sent_time_millisec,
      awr_global_cache_enqueue.avg_gc_cr_receive_time_millisec,
      awr_global_cache_enqueue.avg_gc_cr_build_time_millisec,
      awr_global_cache_enqueue.avg_gc_cr_flush_time_millisec,
      awr_global_cache_enqueue.avg_gc_curr_send_time_millisec,
      awr_global_cache_enqueue.avg_gc_curr_receive_time_millisec,
      awr_global_cache_enqueue.avg_gc_curr_pin_time_millisec,
      awr_global_cache_enqueue.avg_gc_curr_flush_time_millisec
    ]
  }
}

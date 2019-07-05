view: awr_report {
  label: "AWR Report"
  sql_table_name: AWR_DATA.AWR_REPORTS ;;
  # Notes:
  # 1. View file added as a part of ERXLPS-90 change

  dimension: awr_rpt_id {
    type: number
    primary_key: yes
    label: "AWR Report ID"
    description: "Unique number identifiying an Automatic Workload Repository for the Begin and End Snapshot"
    sql: ${TABLE}.AWR_RPT_ID ;;
  }

  ####################################################################################################### Dimensions ####################################################################################################

  dimension: database_id {
    type: number
    label: "AWR Database ID"
    description: "Database Identifier for which the AWR information was generated"
    sql: ${TABLE}.DBID ;;
  }

  dimension: instance_number {
    type: string
    label: "AWR Instance Number"
    description: "Presents the nodes or instances in a clustered database"
    sql: ${TABLE}.INSTANCE_NUMBERS ;;
  }

  dimension: start_snap_id {
    type: number
    label: "AWR Start Snapshot ID"
    sql: ${TABLE}.START_SNAP_ID ;;
  }

  dimension: end_snap_id {
    type: number
    label: "AWR End Snapshot ID"
    sql: ${TABLE}.END_SNAP_ID ;;
  }

  dimension: report_option {
    type: string
    label: "AWR Report Options"
    sql: ${TABLE}.RPT_OPTIONS ;;
  }

  ####################################################################################################### Dimensions - Date/Time ####################################################################################################
  dimension_group: begin_interval {
    label: "AWR Begin Interval"
    description: "The start date/time for which the AWR snapshot was generated"
    #     description: "The start date/time for which the AWR snapshot was generated. Display Value is in US/Central"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      hour,
      minute15,
      minute2,
      minute3
    ]
    #     sql: ${TABLE}.BEGIN_INTERVAL_TIME
    sql: FROM_TZ(CAST(${TABLE}.BEGIN_INTERVAL_TIME AS TIMESTAMP),'UTC') AT TIME ZONE 'US/Central' ;;
  }

  dimension_group: end_interval {
    label: "AWR End Interval"
    description: "The end date/time for which the AWR snapshot was generated. Display Value is in US/Central"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      hour,
      minute15,
      minute2,
      minute3
    ]
    #     sql: ${TABLE}.END_INTERVAL_TIME
    sql: FROM_TZ(CAST(${TABLE}.END_INTERVAL_TIME AS TIMESTAMP),'UTC') AT TIME ZONE 'US/Central' ;;
  }

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    label: "AWR Report Snapshot Count"
    description: "Total AWR Snapshots"
    type: number
    sql: count(*) ;;
    drill_fields: [awr_rpt_id, database_id, instance_number, begin_interval_time, end_interval_time]
    value_format: "#,###"
  }
}

####################################################################################################### End of Measures ####################################################################################################

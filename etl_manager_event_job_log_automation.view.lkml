view: etl_manager_event_job_log_automation {
  sql_table_name: ETL_MANAGER.EVENT_JOB_LOG_automation ;;

  dimension: event_id {
    hidden: yes
    description: "Primary key field that references the event id column in EVENT table under ETL_MANAGER schema"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: REPORT_NAME {
    hidden: yes
    description: "Name of the ETL job (in the master controller package) that processes data to the target table"
    sql: ${TABLE}.REPORT_NAME ;;
  }

  dimension: unique_key {
    primary_key: yes
    hidden: yes
    description: "Unique key for a Event Job Log"
    sql: ${event_id} ||'@'|| ${REPORT_NAME}  ;;
  }

  dimension: SOURCE_REPORT_COUNT {
    description: "SOURCE_REPORT_COUNT"
    sql: ${TABLE}.SOURCE_REPORT_COUNT ;;
  }

  dimension: TARGET_REPORT_COUNT {
    description: "TARGET_REPORT_COUNT"
    sql: ${TABLE}.TARGET_REPORT_COUNT ;;
  }

  dimension: REPORT_STATUS {
    description: "REPORT_STATUS"
    sql: ${TABLE}.REPORT_STATUS ;;
  }



}

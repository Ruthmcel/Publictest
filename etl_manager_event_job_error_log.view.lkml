view: etl_manager_event_job_error_log {
  sql_table_name: ETL_MANAGER.EVENT_JOB_ERROR_LOG ;;

  dimension: event_id {
    hidden: yes
    description: "Primary key field that references the event id column in EVENT table under ETL_MANAGER schema"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: job_name {
    hidden: yes
    description: "Name of the ETL job (in the master controller package) that processes data to the target table"
    sql: ${TABLE}.JOB_NAME ;;
  }

  dimension: unique_key {
    primary_key: yes
    hidden: yes
    description: "Unique key for a Event Job Error Log"
    sql: ${event_id} ||'@'|| ${job_name} ;; #ERXLPS-1649
  }

  dimension: error_message {
    label: "Job Error Message"
    description: "Captures the errors triggered during a job processing"
    sql: ${TABLE}.ERROR_MESSAGE ;;
  }

  dimension_group: error_date {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Job Error"
    description: "Job Error Capture date/time"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.ERROR_DATE) ;;
  }

  measure: count {
    label: "Error Count"
    type: count
    value_format: "#,##0"
  }
}

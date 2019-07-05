view: etl_manager_event_job_log {
  sql_table_name: ETL_MANAGER.EVENT_JOB_LOG ;;

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

  # ERXLPS-105 - Changes made to unique key
  # ERXLPS-1402 - Fixing Unique key violation error
  dimension: unique_key {
    primary_key: yes
    hidden: yes
    description: "Unique key for a Event Job Log"
    sql: ${event_id} ||'@'|| ${job_name} ||'@'|| ${log_message} ||'@'|| ${log_date_time} ;; #ERXLPS-1649
  }

  dimension: log_message {
    type: string
    label: "Job Log Message"
    description: "Captures the various logs (Total Records Processed, Active Events currently executing affecting the current job and how long the current job is wating to execute, etc)"
    sql: ${TABLE}.LOG_MESSAGE ;;
  }

  dimension_group: log_date {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Job Log"
    description: "Job Log Capture date/time"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.LOG_DATE) ;;
  }

  measure: records_processed {
    type: sum
    label: "Records Processed"
    description: "Total Records Processed for a specific job"
    sql: CAST(CASE WHEN ${log_message} LIKE '%=%' AND ( ( (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS INSERTED%') OR (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS UPDATED%') OR (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS LOADED%') ) AND UPPER(LOG_MESSAGE) NOT LIKE '%TOTAL RECORDS DELETED%' ) THEN TRIM(SUBSTR(${log_message},position('=',${log_message},0)+1)) ELSE NULL END AS NUMBER) ;;
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
  }

  measure: records_inserted {
    type: sum
    label: "Records Inserted"
    description: "Total Records Inserted for a specific job"
    sql: CAST(CASE WHEN ${log_message} LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS INSERTED%') THEN TRIM(SUBSTR(${log_message},position('=',${log_message},0)+1)) ELSE NULL END AS NUMBER) ;;
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
  }

  measure: records_updated {
    type: sum
    label: "Records Updated"
    description: "Total Records Updated for a specific job"
    sql: CAST(CASE WHEN ${log_message} LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS UPDATED%') THEN TRIM(SUBSTR(${log_message},position('=',${log_message},0)+1)) ELSE NULL END AS NUMBER) ;;
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
  }

  measure: records_deleted {
    type: sum
    label: "Records Deleted"
    description: "Total Records Deleted for a specific job"
    sql: CAST(CASE WHEN ${log_message} LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%TOTAL RECORDS DELETED%') THEN TRIM(SUBSTR(${log_message},position('=',${log_message},0)+1)) ELSE NULL END AS NUMBER) ;;
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
  }
}

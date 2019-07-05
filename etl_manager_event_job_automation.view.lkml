view: etl_manager_event_job_automation {
  sql_table_name: ETL_MANAGER.EVENT_JOB_AUTOMATION ;;

  dimension: event_id {
    hidden: yes
    description: "Primary key field that references the event id column in EVENT table under ETL_MANAGER schema"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: job_name {
    description: "Name of the ETL job (in the master controller package) that processes data to the target table"
    sql: ${TABLE}.JOB_NAME ;;
  }

  dimension: unique_key {
    primary_key: yes
    hidden: yes
    description: "Unique key for a Event Job"
    sql: ${event_id} ||'@'|| ${job_name} ;;
  }

  dimension_group: job_begin {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Job Begin"
    description: "Captures the begin date of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.JOB_BEGIN_DATE) ;;
  }

  dimension_group: job_end {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Job End"
    description: "Captures the end date of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.JOB_END_DATE) ;;
  }

  #   The below fields are no longer applicable in EVENT_JOB tables. This is because as a part of CHAIN REFRESH FREQUENCY, the below fields have been moved to EVENT_JOB_CHAIN table
  #   - dimension_group: process_data_begin_date
  #     type: time
  #     timeframes:
  #     label: "Job Process Data Begin"
  #     description: "Shows the processing begin date/time of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
  #     sql: ${TABLE}.PROCESS_DATA_BEGIN_DATE
  #
  #   - dimension_group: process_data_end_date
  #     type: time
  #     timeframes:
  #     label: "Job Process Data End"
  #     description: "Shows the processing begin date/time of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
  #     sql: ${TABLE}.PROCESS_DATA_END_DATE

  dimension: status {
    label: "Job Status"
    description: "A-Active, S-Success or F-Failure for all the ETL jobs"

    case: {
      when: {
        sql: ${TABLE}.STATUS = 'S' ;;
        label: "Success"
      }

      when: {
        sql: ${TABLE}.STATUS = 'A' ;;
        label: "Active"
      }

      when: {
        sql: ${TABLE}.STATUS = 'F' ;;
        label: "Failure"
      }
    }
  }

  measure: sum_job_process_time {
    type: sum
    label: "Job Processing Time"
    description: "Total time taken to process a job. It is the difference between job begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.JOB_BEGIN_DATE,${TABLE}.JOB_END_DATE) ;;
    value_format: "#,##0"
    html: {% if value >= 15 %}
        <b><div style="color: white; background-color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% elsif value >= 10 %}
        <b><div style="color: white; background-color: orange; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% else %}
        <b><div style="color: white; background-color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% endif %}
      ;;
  }

  measure: avg_job_process_time {
    type: average
    label: "Job Processing Time - Average"
    description: "Aveage time taken to process a job. It is the difference between job begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.JOB_BEGIN_DATE,${TABLE}.JOB_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: max_job_process_time {
    type: max
    label: "Job Processing Time - Max"
    description: "Maximum time taken to process a job. It is the difference between job begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.JOB_BEGIN_DATE,${TABLE}.JOB_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: min_job_process_time {
    type: min
    label: "Job Processing Time - Min"
    description: "Minimum time taken to process a job. It is the difference between job begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.JOB_BEGIN_DATE,${TABLE}.JOB_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: count {
    label: "Job Count"
    type: count
    value_format: "#,##0"
  }
}

view: etl_manager_event_job_chain {
  sql_table_name: ETL_MANAGER.EVENT_JOB_CHAIN ;;

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

  dimension: chain_id {
    type: number
    hidden:  yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: unique_key {
    primary_key: yes
    hidden: yes
    description: "Unique key for a Event Job"
    sql: ${event_id} ||'@'|| ${job_name} ||'@'|| ${chain_id};;
  }


  dimension_group: process_data_begin {
    type: time
    label: "Job Process Data Begin"
    description: "Shows the processing begin date/time of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.PROCESS_DATA_BEGIN_DATE) ;;
  }

  dimension_group: process_data_end {
    type: time
    label: "Job Process Data End"
    description: "Shows the processing end date/time of a job (JOB_EPR_RX_TX_EDW, JOB_HOST_DRUG_EDW, etc)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.PROCESS_DATA_END_DATE) ;;
  }

}

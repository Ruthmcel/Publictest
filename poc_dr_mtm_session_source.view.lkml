view: poc_dr_mtm_session_source {
  sql_table_name: EDW.DR_MTM_SESSION_SOURCE ;;

  dimension: chain_id {
    type: number
    hidden: yes
    description: "Unique identifier of a chain"
    label: "Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: chain_name {
    type: string
    description: "Chain Name"
    label: "Chain Name"
    sql: ${TABLE}.CHAIN_NAME ;;
  }

  dimension: primary_key {
    type: string
    description: "Unique identifier of a record"
    hidden: yes
    primary_key: yes
    sql: ${chain_id}||'@'||${program_id}||'@'||${session_id} ;;
  }

  dimension: program_id {
    type: number
    hidden:  yes
    description: "Program ID"
    label: "Program ID"
    sql: ${TABLE}.PROGRAM_ID ;;
  }

  dimension: program_name {
    type: string
    description: "Program Name"
    label: "Program Name"
    sql: ${TABLE}.PROGRAM_NAME ;;
  }

  dimension: number_of_questions {
    type: number
    description: "Number of Questions"
    label: "Number of Questions"
    sql: ${TABLE}.NUMBER_OF_QUESTIONS ;;
  }

  dimension: session_id {
    type: number
    description: "Session ID"
    label: "Session ID"
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension_group: session_issue {
    type: time
    timeframes: [date]
    description: "Session Issue Date"
    label: "Session Issue"
    sql: ${TABLE}.SESSION_ISSUE_DATE ;;
  }

  dimension_group: session_last_start {
    type: time
    timeframes: [date]
    description: "Session Last Start Date"
    label: "Session Last Start"
    sql: ${TABLE}.SESSION_LAST_START_DATE ;;
  }

  dimension_group: session_complete {
    type: time
    timeframes: [date]
    description: "Session Complete Date"
    label: "Session Complete"
    sql: ${TABLE}.SESSION_COMPLETE_DATE ;;
  }

  dimension: session_status {
    type: string
    description: "Session Status"
    label: "Session Status"
    sql: ${TABLE}.SESSION_STATUS ;;
  }

  dimension: patient_age {
    type: number
    description: "Patient Age"
    label: "Patient Age"
    sql: ${TABLE}.AGE ;;
  }

  dimension: patient_age_group {
    type: string
    description: "Patient Age Group"
    label: "Patient Age Group"
    sql: ${TABLE}.AGE_GROUP ;;
  }

  dimension: days_taken_to_compelte {
    type: number
    description: "Days taken to compelte survey."
    label: "Days Taken to Compelte"
    sql: ${TABLE}.DAYS_TAKEN_TO_COMPLETE_SURVEY ;;
  }

  dimension: completed_in_time {
    type: string
    hidden:  yes
    description: "Y/N Falg indicating whether the survey compelted with in timeline."
    label: "Completed in Time (Yes/No)"
    sql: ${TABLE}.COMPLETED_IN_TIME ;;
  }
}

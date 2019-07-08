view: etl_manager_event_automation {
  sql_table_name: ETL_MANAGER.EVENT_AUTOMATION ;;

  dimension: event_id {
    primary_key: yes
    description: "   Primary key field that references the event id column in EVENT table under ETL_MANAGER schema"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: chain_id {
    type: number
    description: "CHAIN ID is the NHIN assigned customer chain ID number. For majority of the customers to load all customer data into BI environment, BI team uses chain 99999 to process all chain data and 3000 to process NHIN DRUG related data"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension_group: event_begin {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Event Begin"
    description: "Captures the begin date of an event (STAGE TO EDW ETL, HOST CDC STAGE LOAD - NHIN/HOST)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.EVENT_BEGIN_DATE) ;;
  }

  dimension_group: event_end {
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    label: "Event End"
    description: "Captures the end date of an event (STAGE TO EDW ETL, HOST CDC STAGE LOAD - NHIN/HOST)"
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.EVENT_END_DATE) ;;
  }

  dimension: event_type {
    label: "Event Type"
    description: "Various ETL Event Types are STAGE TO EDW ETL, HOST CDC STAGE LOAD - NHIN and HOST"
    sql: ${TABLE}.EVENT_TYPE ;;
    suggestions: ["STAGE TO EDW ETL", "HOST CDC STAGE LOAD - NHIN", "HOST CDC STAGE LOAD - HOST"]
  }

  dimension: load_type {
    label: "Event Load Type"
    description: "Indicates the type of ETL load performed for a given event"

    case: {
      when: {
        sql: ${TABLE}.LOAD_TYPE = 'I' ;;
        label: "Initial"
      }

      when: {
        sql: ${TABLE}.LOAD_TYPE = 'R' ;;
        label: "Regular"
      }

      when: {
        sql: ${TABLE}.LOAD_TYPE = 'C' ;;
        label: "Correction/Recovery"
      }
    }
  }

  dimension: status {
    label: "Event Status"
    description: "A-Active, S-Success or F-Failure for all the ETL events"

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

  dimension: refresh_frequency {
    label: "Event Refresh Frequency"
    description: "D-Daily, H-Hourly (or) O-Ondeamnd frequency of execution of the various ETL jobs"

    case: {
      when: {
        sql: ${TABLE}.REFRESH_FREQUENCY = 'D' ;;
        label: "Daily"
      }

      when: {
        sql: ${TABLE}.REFRESH_FREQUENCY = 'H' ;;
        label: "Hourly"
      }

      when: {
        sql: ${TABLE}.REFRESH_FREQUENCY = 'O' ;;
        label: "On-Demand"
      }
    }
  }

  measure: sum_event_process_time {
    type: sum
    label: "Event Processing Time"
    description: "Total time taken to process a event. It is the difference between event begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.EVENT_BEGIN_DATE,${TABLE}.EVENT_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: avg_event_process_time {
    type: average
    label: "Event Processing Time - Average"
    description: "Average time taken to process a event. It is the difference between event begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.EVENT_BEGIN_DATE,${TABLE}.EVENT_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: max_event_process_time {
    type: max
    label: "Event Processing Time - Max"
    description: "Maximum time taken to process a event. It is the difference between event begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.EVENT_BEGIN_DATE,${TABLE}.EVENT_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: min_event_process_time {
    type: min
    label: "Event Processing Time - Min"
    description: "Minimum time taken to process a event. It is the difference between event begin and end timeframe, captured in minutes"
    sql: DATEDIFF(MINUTE,${TABLE}.EVENT_BEGIN_DATE,${TABLE}.EVENT_END_DATE) ;;
    value_format: "#,##0"
  }

  measure: count {
    label: "Event Count"
    type: count
    value_format: "#,##0"
  }
}

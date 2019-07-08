view: store_workflow_history {
  label: "Workflow History"
  sql_table_name: EDW.F_WORKFLOW_HISTORY ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${workflow_history_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: workflow_history_id {
    label: "Workflow History Id"
    description: "Unique ID number identifying a Workflow History record. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.WORKFLOW_HISTORY_ID ;;
  }

  dimension: workflow_state_id {
    label: "Workflow State Id"
    description: "Unique Stage ID that links this record to a specific WORKFLOW_STATE record. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.WORKFLOW_STATE_ID ;;
  }

  dimension: workflow_token_id {
    label: "Workflow Token Id"
    description: "Unique Token ID that links this record to a specific WORKFLOW_STATE record. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.WORKFLOW_TOKEN_ID ;;
  }

  dimension_group: workflow_history_action {
    label: "Workflow History Action"
    description: "Date/Time in which the token changed and was inserted into history. EPS Table: WORKFLOW_HISTORY"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.WORKFLOW_HISTORY_ACTION_DATE ;;
  }

  dimension: workflow_history_user_login {
    label: "Workflow History User Login"
    description: "Workflow History User Login. EPS Table: WORKFLOW_HISTORY"
    type: string
    sql: ${TABLE}.WORKFLOW_HISTORY_USER_LOGIN ;;
  }

  dimension: workflow_history_user_employee_number {
    label: "Workflow History User Employee Number"
    description: "Employee Number of the user performing the change. EPS Table: WORKFLOW_HISTORY"
    type: string
    sql: ${TABLE}.WORKFLOW_HISTORY_USER_EMPLOYEE_NUMBER ;;
  }

  dimension: workflow_history_action_type {
    label: "Workflow History Action"
    description: "Type of action that was performed. EPS Table: WORKFLOW_HISTORY"
    type: string
    sql: ${TABLE}.WORKFLOW_HISTORY_ACTION ;;
  }

  dimension: workflow_history_status {
    label: "Workflow History Status"
    description: "Status of transition,if applicable. EPS Table: WORKFLOW_HISTORY"
    type: string
    sql: ${TABLE}.WORKFLOW_HISTORY_STATUS ;;
  }

  dimension: workflow_history_workstation_name {
    label: "Workflow History Workstation Name"
    description: "Name of workstation that performed the action. EPS Table: WORKFLOW_HISTORY"
    type: string
    sql: ${TABLE}.WORKFLOW_HISTORY_WORKSTATION_NAME ;;
  }

  dimension: line_item_id {
    label: "Line Item Id"
    description: "Unique ID that links this record to a specific LINE_ITEM record. EPS Table: WORKFLOW_HISTORY"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Workflow History Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: WORKFLOW_HISTORY"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: workflow_history_action_date_yyyymmdd {
    label: "Workflow History Action Date Yyyymmdd"
    description: "Date in which the token changed and was inserted into history. EPS Table: WORKFLOW_HISTORY"
    type: date
    sql: ${TABLE}.WORKFLOW_HISTORY_ACTION_DATE_YYYYMMDD ;;
  }

  dimension_group: source_create_timestamp {
    label: "Workflow History Source Create"
    description: "This is the date and time that the record was created."
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

}

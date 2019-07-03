view: eps_workflow_token {
  sql_table_name: EDW.F_WORKFLOW_TOKEN ;;

  dimension: workflow_token_id {
    label: "Workflow Token ID"
    description: "Unique ID number identifying a workflow token record within a pharmacy chain"
    type: number
    sql: ${TABLE}.WORKFLOW_TOKEN_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_token_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: workflow_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_STATE_ID ;;
  }

  dimension: line_item_id {
    hidden: yes
    type: number
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

  dimension: tx_tp_id {
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: mtm_patient_session_id {
    hidden: yes
    type: number
    sql: ${TABLE}.MTM_PATIENT_SESSION_ID ;;
  }

  #[ERXDWPS-7341] SYNC Workflow Token EPS to EDW
  dimension: store_cycle_count_id {
    hidden: yes
    type: number
    sql: ${TABLE}.STORE_CYCLE_COUNT_ID ;;
  }

  #[ERXDWPS-7341] SYNC Workflow Token EPS to EDW
  dimension: patient_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PATIENT_ID ;;
  }
  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################
  dimension: workflow_token_checked_out_employee_number {
    label: "Workflow Token Checked Out Employee Number"
    description: "Employee number of the user performing checked out task"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_CHECKED_OUT_EMPLOYEE_NUMBER ;;
  }

  dimension: workflow_token_originating_employee_number {
    label: "Workflow Token Originating Employee Number"
    description: "Employee number of the user performing originating task"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_ORIGINATING_EMPLOYEE_NUMBER ;;
  }

  dimension: workflow_token_checked_out_login {
    label: "Workflow Token Checked Out Login"
    description: "Login information of the user performing checked out task"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_CHECKED_OUT_LOGIN ;;
  }

  dimension: workflow_token_originating_login {
    label: "Workflow Token Originating Login"
    description: "Login information of the user performing originating task"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_ORIGINATING_LOGIN ;;
  }

  dimension: workflow_token_required_role {
    label: "Workflow Token Role"
    description: "Role required for a user to perform tasks"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_REQUIRED_ROLE ;;
  }

  dimension: workflow_token_workstation_name {
    label: "Workflow Token Workstation Name"
    description: "Name of the workstation that performed the action"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_WORKSTATION_NAME ;;
  }

  dimension: workflow_token_scope {
    label: "Workflow Token Scope"
    description: "Defines which stores enrolled in alternate site are allowed to pick it up or are actively working on it"
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_SCOPE ;;
  }


  #[ERXDWPS-5990] - Exposed in WF Explore. Allowing user to choose whether to run current state report of history report by choosing this dimension.
  dimension: workflow_token_deleted {
    label: "Workflow Token Deleted"
    description: "Yes/No Flag indicating if the Workflow Token is current state (No) or history (Yes)."
    #hidden: yes [ERXDWPS-5990] - Exposed in WF Explore. Allowing user to choose whether to run current state report of history report by choosing this dimension.
    type: yesno
    sql: ${TABLE}.WORKFLOW_TOKEN_DELETED = 'Y' ;;
  }

  #[ERXLPS-658] - New dimension added for workflow_token_deleted
  dimension: workflow_token_deleted_reference {
    label: "Workflow Token Deleted"
    hidden: yes
    type: string
    sql: ${TABLE}.WORKFLOW_TOKEN_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: workflow_token_start {
    label: "Workflow Token Start"
    description: "Date/Time the transaction moved into the current workflow state."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.WORKFLOW_TOKEN_START_DATE ;;
  }

  dimension_group: workflow_token_hold_until {
    label: "Workflow Token Hold Until"
    description: "Date/Time that the workflow token will be on hold till."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: CASE WHEN TO_DATE(${TABLE}.WORKFLOW_TOKEN_HOLD_UNTIL_DATE) = TO_DATE('1969-12-31','YYYY-MM-DD') THEN NULL ELSE ${TABLE}.WORKFLOW_TOKEN_HOLD_UNTIL_DATE END ;;
  }

  dimension_group: workflow_token_grouping_delay {
    label: "Workflow Token Grouping Delay"
    description: "Date/Time set to a transaction to group the transactions with in an order. EPS detects an order needs to be grouped when more than one transaction is processed in an order, and sets the date in future to prevent any other user or process from working on the grouped item until the date has passed."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.WORKFLOW_TOKEN_GROUPING_DELAY_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################
  dimension: workflow_token_local_store_only {
    label: "Workflow Token Local Store Only"
    description: "Yes/No Flag indicating if the task can be worked only at local store/client"
    type: yesno
    sql: ${TABLE}.WORKFLOW_TOKEN_LOCAL_STORE_ONLY = 'Y' ;;
  }

  dimension: workflow_token_rx_conversion {
    label: "Workflow Token Rx Conversion"
    description: "Yes/No Flag indicating if the task entered into EPS through conversion, aka it originated from another system"
    type: yesno
    sql: ${TABLE}.WORKFLOW_TOKEN_RX_CONVERSION = 'Y' ;;
  }

  ################################################################################################## End of Dimensions #################################################################################################

  ################################################################################################## Obfuscated Dimensions #############################################################################################
  dimension: workflow_token_checked_out_employee_number_deidentified {
    label: "Workflow Token Checked Out Employee Number"
    description: "Employee number of the user performing checked out task"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_CHECKED_OUT_EMPLOYEE_NUMBER) ;;
  }

  dimension: workflow_token_originating_employee_number_deidentified {
    label: "Workflow Token Originating Employee Number"
    description: "Employee number of the user performing originating task"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_ORIGINATING_EMPLOYEE_NUMBER) ;;
  }

  dimension: workflow_token_checked_out_login_deidentified {
    label: "Workflow Token Checked Out Login"
    description: "Login information of the user performing checked out task"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_CHECKED_OUT_LOGIN) ;;
  }

  dimension: workflow_token_originating_login_deidentified {
    label: "Workflow Token Originating Login"
    description: "Login information of the user performing originating task"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_ORIGINATING_LOGIN) ;;
  }

  dimension: workflow_token_workstation_name_deidentified {
    label: "Workflow Token Workstation Name"
    description: "Name of the workstation that performed the action"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_WORKSTATION_NAME) ;;
  }

  dimension: workflow_token_scope_deidentified {
    label: "Workflow Token Scope"
    description: "Defines which stores enrolled in alternate site are allowed to pick it up or are actively working on it"
    type: string
    sql: SHA2(${TABLE}.WORKFLOW_TOKEN_SCOPE) ;;
  }

  ################################################################################################## End of Obfuscated Dimensions ######################################################################################

  ################################################################################################## Measure #################################################################################################
  measure: count {
    label: "Workflow Token Task Count"
    description: "Includes only prescriptions that are currently in progress and on-hold state. This measure can be used only along with 'Current Workflow State Name' dimension"
    type: count
    value_format: "#,##0"
    drill_fields: [
      chain.chain_name,
      store.store_number,
      store.store_name,
      eps_rx_tx.rx_tx_tx_number,
      eps_rx_tx.rx_tx_tx_status,
      eps_rx_tx.rx_tx_fill_status,
      eps_rx_tx.rx_tx_drug_dispensed,
      eps_workflow_token.workflow_token_scope,
      eps_workflow_token.workflow_token_required_role
    ]
  }

#[ERXDWPS-5989] - Meijer: Need to Expose Last Updated in Workflow and Task History Explore
  measure: max_workflow_token_source_timestamp {
    label: "Workflow Token Max Source Timestamp"
    description: "Latest activity date/time on Workflow Token record.This field is for reference only and should not be used for calculations."
    type: string
    can_filter: no
    sql: to_char(max(${TABLE}.SOURCE_TIMESTAMP), 'yyyy-mm-dd hh24:mi:ss') ;;
  }

  #[ERXDWPS-5990] - Created sets to refrence in DEMO Model and in other Models.
  set: explore_dx_workflow_token_candidate_list {
    fields: [
      workflow_token_id,
      workflow_token_checked_out_employee_number,
      workflow_token_originating_employee_number,
      workflow_token_checked_out_login,
      workflow_token_originating_login,
      workflow_token_required_role,
      workflow_token_workstation_name,
      workflow_token_scope,
      workflow_token_deleted,
      workflow_token_start,
      workflow_token_start_time,
      workflow_token_start_date,
      workflow_token_start_week,
      workflow_token_start_month,
      workflow_token_start_month_num,
      workflow_token_start_year,
      workflow_token_start_quarter,
      workflow_token_start_quarter_of_year,
      workflow_token_start_hour_of_day,
      workflow_token_start_time_of_day,
      workflow_token_start_hour2,
      workflow_token_start_minute15,
      workflow_token_start_day_of_week,
      workflow_token_start_week_of_year,
      workflow_token_start_day_of_week_index,
      workflow_token_start_day_of_month,
      workflow_token_hold_until,
      workflow_token_hold_until_time,
      workflow_token_hold_until_date,
      workflow_token_hold_until_week,
      workflow_token_hold_until_month,
      workflow_token_hold_until_month_num,
      workflow_token_hold_until_year,
      workflow_token_hold_until_quarter,
      workflow_token_hold_until_quarter_of_year,
      workflow_token_hold_until_hour_of_day,
      workflow_token_hold_until_time_of_day,
      workflow_token_hold_until_hour2,
      workflow_token_hold_until_minute15,
      workflow_token_hold_until_day_of_week,
      workflow_token_hold_until_week_of_year,
      workflow_token_hold_until_day_of_week_index,
      workflow_token_hold_until_day_of_month,
      workflow_token_grouping_delay,
      workflow_token_grouping_delay_time,
      workflow_token_grouping_delay_date,
      workflow_token_grouping_delay_week,
      workflow_token_grouping_delay_month,
      workflow_token_grouping_delay_month_num,
      workflow_token_grouping_delay_year,
      workflow_token_grouping_delay_quarter,
      workflow_token_grouping_delay_quarter_of_year,
      workflow_token_grouping_delay_hour_of_day,
      workflow_token_grouping_delay_time_of_day,
      workflow_token_grouping_delay_hour2,
      workflow_token_grouping_delay_minute15,
      workflow_token_grouping_delay_day_of_week,
      workflow_token_grouping_delay_week_of_year,
      workflow_token_grouping_delay_day_of_week_index,
      workflow_token_grouping_delay_day_of_month,
      workflow_token_local_store_only,
      workflow_token_rx_conversion,
      count,
      max_workflow_token_source_timestamp
    ]
  }

  set: explore_dx_workflow_token_bi_demo_candidate_list {
    fields: [
      workflow_token_id,
      workflow_token_checked_out_employee_number_deidentified,
      workflow_token_originating_employee_number_deidentified,
      workflow_token_checked_out_login_deidentified,
      workflow_token_originating_login_deidentified,
      workflow_token_required_role,
      workflow_token_workstation_name_deidentified,
      workflow_token_scope_deidentified,
      workflow_token_deleted,
      workflow_token_start,
      workflow_token_start_time,
      workflow_token_start_date,
      workflow_token_start_week,
      workflow_token_start_month,
      workflow_token_start_month_num,
      workflow_token_start_year,
      workflow_token_start_quarter,
      workflow_token_start_quarter_of_year,
      workflow_token_start_hour_of_day,
      workflow_token_start_time_of_day,
      workflow_token_start_hour2,
      workflow_token_start_minute15,
      workflow_token_start_day_of_week,
      workflow_token_start_week_of_year,
      workflow_token_start_day_of_week_index,
      workflow_token_start_day_of_month,
      workflow_token_hold_until,
      workflow_token_hold_until_time,
      workflow_token_hold_until_date,
      workflow_token_hold_until_week,
      workflow_token_hold_until_month,
      workflow_token_hold_until_month_num,
      workflow_token_hold_until_year,
      workflow_token_hold_until_quarter,
      workflow_token_hold_until_quarter_of_year,
      workflow_token_hold_until_hour_of_day,
      workflow_token_hold_until_time_of_day,
      workflow_token_hold_until_hour2,
      workflow_token_hold_until_minute15,
      workflow_token_hold_until_day_of_week,
      workflow_token_hold_until_week_of_year,
      workflow_token_hold_until_day_of_week_index,
      workflow_token_hold_until_day_of_month,
      workflow_token_grouping_delay,
      workflow_token_grouping_delay_time,
      workflow_token_grouping_delay_date,
      workflow_token_grouping_delay_week,
      workflow_token_grouping_delay_month,
      workflow_token_grouping_delay_month_num,
      workflow_token_grouping_delay_year,
      workflow_token_grouping_delay_quarter,
      workflow_token_grouping_delay_quarter_of_year,
      workflow_token_grouping_delay_hour_of_day,
      workflow_token_grouping_delay_time_of_day,
      workflow_token_grouping_delay_hour2,
      workflow_token_grouping_delay_minute15,
      workflow_token_grouping_delay_day_of_week,
      workflow_token_grouping_delay_week_of_year,
      workflow_token_grouping_delay_day_of_week_index,
      workflow_token_grouping_delay_day_of_month,
      workflow_token_local_store_only,
      workflow_token_rx_conversion,
      count,
      max_workflow_token_source_timestamp
    ]
  }
}

################################################################################################## End of Measure #################################################################################################

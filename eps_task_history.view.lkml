view: eps_task_history {
  #[ERX-6185]
  sql_table_name:
  {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
    {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
    {% if active_archive_filter_input_value == 'archive'  %}
      EDW.F_TASK_HISTORY_ARCHIVE
    {% else %}
      EDW.F_TASK_HISTORY
    {% endif %}
  {% else %}
    EDW.F_TASK_HISTORY
  {% endif %}
  ;;

  dimension: task_history_id {
    label: "Task History ID"
    description: "Unique ID number identifying a task history record within a pharmacy chain"
    type: number
    sql: ${TABLE}.TASK_HISTORY_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${task_history_id} ;; #ERXLPS-1649
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

  dimension: task_history_nhin_store_id {
    # Commenting back as this was exposed for an incident call to see the value from looker
    hidden: yes
    type: number
    sql: ${TABLE}.TASK_HISTORY_NHIN_STORE_ID ;;
  }

  dimension: line_item_id {
    hidden: yes
    type: number
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

  dimension: order_entry_id {
    hidden: yes
    type: number
    sql: ${TABLE}.ORDER_ENTRY_ID ;;
  }

  dimension: rx_tx_id {
    label: "Prescription Transaction ID"
    description: "Unique ID number identifying a transanction record within a pharmacy chain"
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: task_history_action_current {
    label: "Task Action"
    description: "Date/Time that the action was performed for any given task associated to a prescription transaction"
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
    sql: ${TABLE}.TASK_HISTORY_ACTION_DATE ;;
  }

  #   - dimension_group: task_history_action_previous
  #     label: 'Task Action Previous'
  #     description: "Date/Time that the previous action was performed for any given task associated to a prescription transaction"
  #     type: time
  #     timeframes: [time, date, week, month, month_num, year, quarter, quarter_of_year, yesno, hour_of_day, time_of_day, hour2, minute15, day_of_week, week_of_year, day_of_week_index, day_of_month]
  #     sql: ${TABLE}.TASK_HISTORY_ACTION_PREVIOUS_DATE

  #   - dimension: task_time
  #     description: "Time taken to perform a task. Value is displayed in Seconds. Calculation Used: Current Task Action Timestamp - Previous Task Action Timestamp, for the same task within a given prescription transanction under a pharmacy chain"
  #     type: number
  #     sql: DATEDIFF(SECOND,${task_history_action_previous_time},${task_history_action_current_time})

  dimension: task_history_task_name {
    label: "Task Name"
    description: "Authentication method by which the specific task was completed"
    type: string
    sql: UPPER(${TABLE}.TASK_HISTORY_TASK_NAME) ;;
    suggestions: [
      "ACS_COMPLETE",
      "ACS_FAIL",
      "ACS_HOLD",
      "ACS_RECEIVE",
      "ACS_REJECT",
      "ACS_XMIT",
      "ADMIN_REBILL",
      "BACKGROUND_ADJUDICATION",
      "BACKGROUND_AUTO_TRANSFER",
      "BACKGROUND_EXCEPTION",
      "BGSELECT",
      "CALL_INSURANCE",
      "CALL_PATIENT",
      "CALL_PHARMACY",
      "CALL_PRESCRIBER",
      "CASH_OR_ADJUDICATION_DECISION",
      "CF_EXCEPTION",
      "CF_RECEIVE",
      "CF_XMIT",
      "CHANGE_BILL_DECISION",
      "CHARGE_CC_DECISION",
      "CHECK_PARTIAL_FILL",
      "COB_REVIEW",
      "COB_REVIEW2",
      "DATA_ENTRY",
      "DATA_VERIFICATION",
      "DATA_VERIFICATION_CALL_PAT",
      "DATA_VERIFICATION_CALL_PRES",
      "DATA_VERIFICATION_DECISION",
      "DATA_VERIFICATION2",
      "DATA_VERIFICATION2_CALL_PAT",
      "DATA_VERIFICATION2_CALL_PRES",
      "DONE",
      "DOWNTIME_REJECT_STATE",
      "DUR",
      "DUR_DECISION",
      "DUR_DISPLAY",
      "ESCRIPT_DATA_ENTRY",
      "FILL",
      "FILL_DECISION",
      "FULFILLMENT_VERIFICATION",
      "IFILL_DECISION",
      "INVISIBLE_FILL",
      "MANUAL_CC_AUTH",
      "MO_PAYMENT_EXCEPTION",
      "NEW_ESCRIPT",
      "NEW_MTM",
      "ORDER_ENTRY",
      "ORDER_READY_CONTACT_DECISION",
      "OUTGOING_TRANSFER",
      "PATIENT_MAINTENANCE",
      "PAYMENTS_AUTH",
      "PAYMENTS_AUTH_DECISION",
      "PAYMENTS_AUTH_EXCEPTION",
      "PAYMENTS_SETTLEMENT",
      "PAYMENTS_SETTLEMENT_DECISION",
      "PAYMENTS_SETTLEMENT_EXCEPTION",
      "POS_CC_AUTH",
      "POST_PV_BG_ADJUDICATION",
      "POST_PV_REGROUP",
      "PRICING",
      "PRODUCT_VERIFICATION",
      "REFILL_DRUG_SELECTION",
      "REFILL_LOCATION_DECISION",
      "REFILL_PRICING",
      "REFILL_RXEDITS",
      "REVERSE_TRANSMIT_FAIL",
      "RF_ADJUST_QTY",
      "RF_TP_EXCEPTION",
      "ROBOTIC_FILL",
      "RPH_COUNSELING",
      "RPH_VERIFICATION_DECISION",
      "RX_FILLING",
      "RX_MODIFICATION",
      "RX_UPDATE_BEFORE_DV",
      "RX_UPDATE_CANCELLED",
      "RX_UPDATE_POST_DATAENTRY",
      "RX_UPDATE_POST_DOWNTIME",
      "RX_UPDATE_POST_SBMO",
      "RX_UPDATE_POST_UNDO_DE",
      "RX_UPDATE_POST_WILLCALL",
      "SBMO_SENT",
      "SBMO_XMIT",
      "TP_EXCEPTION",
      "TP_EXCEPTION2",
      "TX_MODIFICATION",
      "UNDO_ADJUDICATION",
      "UNDO_CASH_OR_ADJUDICATION_DECISION",
      "UNDO_DATA_ENTRY",
      "UNDO_DATA_VERIFICATION",
      "UNDO_DUR",
      "UNDO_DUR_DECISION",
      "UNDO_FILL",
      "UNDO_IFILL_DECISION",
      "UNDO_INVISIBLE_FILL",
      "UNDO_ORDER_ENTRY",
      "UNDO_PAYMENTS_AUTH",
      "UNDO_PAYMENTS_AUTH_DECISION",
      "UNDO_PRODUCT_VERIFICATION",
      "UNDO_REFILL_PRICING",
      "UNDO_RF_ADJUST_QTY",
      "UNDO_RX_FILLING",
      "UNSELL",
      "WILL_CALL",
      "WILLCALL_CONTACT"
    ]
  }

  dimension: task_history_task_action {
    label: "Task Action"
    description: "Action that was performed by the system or a user to create this task"
    type: string
    sql: UPPER(${TABLE}.TASK_HISTORY_TASK_ACTION) ;;
    suggestions: [
      "CHANGE_BILLING_TRANSMIT_START",
      "REVERSE_TRANSMIT_FAIL",
      "CHANGE_BILLING_FAILED_SELECT_NEW",
      "CHANGE_BILLING_FAILED_COMPLETE_NEW",
      "EDIT_TRANSMIT",
      "RETRANSMIT_TRANSMIT_START",
      "EDIT_REVERSE_OPTION",
      "EDIT_REVERSE",
      "RETRANSMIT_TRANSMIT_COMPLETE",
      "RETRANSMIT_REVERSE_START",
      "START ADJUDICATION",
      "START",
      "CHANGE_BILLING_REVERSE",
      "EDIT_TRANSMIT_COMPLETE",
      "CHANGE_BILLING_SUCCESSFUL_COMPLETE",
      "CHANGE_BILLING_FAILED_SELECT_ORIGINAL",
      "CHANGE_BILLING_REVERSE_FAILED",
      "RETRANSMIT_START",
      "CHANGE_BILLING_TRANSMIT_COB",
      "START PRICING",
      "ADMIN_REBILL_ERROR",
      "CHANGE_BILLING_ERROR",
      "CHANGE_BILLING_FAILED_COMPLETE_ORIGINAL",
      "EDIT_REVERSE_START",
      "EDIT_SUCCESS",
      "RETRANSMIT_TRANSMIT_FAILED",
      "COMPLETE ADJUDICATION",
      "COMPLETE PRICING",
      "COMPLETE MODIFICATION",
      "PUTBACK",
      "ADMIN_REBILL_TX",
      "CHANGE_BILLING_START",
      "CHANGE_BILLING_REVERSE_COMPLETE",
      "CHANGE_BILLING_TRANSMIT_COMPLETE",
      "EDIT_REVERSE_COMPLETE",
      "EDIT_REVERSE_WITHOUT_TRANSMIT",
      "UNSELL",
      "EDIT_TRANSMIT_FAILED",
      "CLAIM_OVERRIDE_START",
      "RETRANSMIT_SUCCESS",
      "PUTBACK_CHECKED_OUT_TASK",
      "EDIT_REVERSE_FAILED",
      "FILL_START",
      "GETNEXT",
      "CHANGE_BILLING_REVERSE_WITHOUT_TRANSMIT",
      "CHANGE_BILLING_TRANSMIT_FAILED",
      "EDIT_START",
      "EDIT_TRANSMIT_START",
      "RETRANSMIT_TRANSMIT",
      "COMPLETE",
      "CHANGE_BILLING_ACCEPT_NEW_BILLING",
      "CHANGE_BILLING_TRANSMIT",
      "CHANGE_BILLING_REVERSAL_START",
      "CLAIM_OVERRIDE_HOST_DATE_NULL",
      "CLAIM_OVERRIDE_COMPLETE",
      "CHANGE_BILLING_TX"
    ]
  }

  dimension: task_history_user_employee_number {
    label: "Task User Employee Number"
    description: "Employee Number of user performing the change"
    type: string
    sql: ${TABLE}.TASK_HISTORY_USER_EMPLOYEE_NUMBER ;;
  }

  dimension: task_history_demo_user_employee_number {
    label: "Task User Employee Number"
    description: "Employee Number of user performing the change"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(CONCAT(CONCAT(${TABLE}.CHAIN_ID,${TABLE}.NHIN_STORE_ID),${TABLE}.TASK_HISTORY_USER_EMPLOYEE_NUMBER)) ;;
  }

  dimension: task_history_user_login {
    label: "Task User Login"
    description: "Login of the user performing the change"
    type: string
    sql: ${TABLE}.TASK_HISTORY_USER_LOGIN ;;
  }

  dimension: task_history_demo_user_login {
    label: "Task User Login"
    description: "Login of the user performing the change"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(CONCAT(CONCAT(${TABLE}.CHAIN_ID,${TABLE}.NHIN_STORE_ID),${TABLE}.TASK_HISTORY_USER_LOGIN)) ;;
  }

  dimension: task_history_authentication_method {
    label: "Task Authentication Method"
    description: "Authentication method by which the specific task was completed"
    type: string
    sql: ${TABLE}.TASK_HISTORY_AUTHENTICATION_METHOD ;;
    suggestions: ["BIOMETRIC", "USER_PASSWORD"]
  }

  dimension: task_history_role {
    label: "Task Security Role"
    description: "The security role of the user that performed the task"
    type: string
    # upper not used as the data is stored in upper case in the source system
    sql: ${TABLE}.TASK_HISTORY_ROLE ;;
    suggestions: [
      "ADMIN",
      "BG",
      "CALL_INS",
      "CALL_PAT",
      "CALL_PHAR",
      "CALL_PRE",
      "DE",
      "DT_EX_TP",
      "DUR_DISPLAY",
      "DV",
      "ESCRIPT",
      "EX_BG",
      "EX_TP",
      "EX_TP5",
      "FILL",
      "OE",
      "OUTGOING_TRANSFER",
      "PAT_MAINT",
      "PUTBACK_CHECKED_OUT_TASK",
      "PV",
      "RPH_COUNSELING",
      "RSLV_DOWNTIME",
      "RX_FILLING",
      "TP_EXCEPTION_QUEUE",
      "UNKNOWN",
      "WC"
    ]
  }

  dimension: task_history_station_label {
    label: "Task Station Label"
    description: "The unique station ID assigned to each client workstation. This tracks the specific client that performed the action that created the task history record"
    type: string
    sql: ${TABLE}.TASK_HISTORY_STATION_LABEL ;;
  }

  dimension: task_history_status {
    label: "Task Status"
    description: "The transition status when a task is completed. Used to determine the task's  next step in workflow. For Example; If in adjudication, when the task is completed, it can go to either DV or tp_exception.  The status may be 'SUCCESS' in the event it is going to DV or 'REJECT' which might put it into tp_exception"
    type: string
    sql: UPPER(${TABLE}.TASK_HISTORY_STATUS) ;;
    suggestions: [
      "ADJUDICATION",
      "AUTOMATIC_TIMEOUT",
      "CALL_INS",
      "CALL_PAT",
      "CALL_PATIENT",
      "CALL_PRE",
      "CANCEL",
      "CANCEL_DATA_ENTRY",
      "CANCEL_DATA_VERIFICATION",
      "CANCEL_DUR_DISPLAY",
      "CANCEL_ESCRIPT_DATA_ENTRY",
      "CANCEL_FILL",
      "CANCEL_ON_FILE",
      "CANCEL_PRODUCT_VERIFICATION",
      "CANCEL_RX_FILLING",
      "COMPLETE",
      "COMPLETE - NO RX.COM ID",
      "COMPLETE_CALL_PRESCRIBER",
      "COMPLETE_DATA_ENTRY",
      "COMPLETE_DATA_VERIFICATION",
      "COMPLETE_DUR",
      "COMPLETE_DUR_DISPLAY",
      "COMPLETE_ESCRIPT_DATA_ENTRY",
      "COMPLETE_FILL",
      "COMPLETE_MANUAL",
      "COMPLETE_PAT_MAINTENANCE",
      "COMPLETE_PRICING",
      "COMPLETE_PRODUCT_VERIFICATION",
      "COMPLETE_REFILL_PRICING",
      "COMPLETE_RX_FILLING",
      "COMPLETE_TP_EXCEPTION",
      "COMPLETE_UNDO_RX_FILLING",
      "DONE",
      "EXCEPTION",
      "INVENTORY ADJUSTED",
      "KILL",
      "MOVE_TO_DATA_ENTRY",
      "MOVE_TO_DATA_VERIFICATION",
      "MOVE_TO_DUR_DISPLAY",
      "MOVE_TO_FILL",
      "MOVE_TO_PAT_MAINTENANCE",
      "MOVE_TO_REFILL_LOCATION_DECISION",
      "MOVE_TO_RX_FILLING",
      "MOVE_TO_RX_UPDATE",
      "MOVE_TO_TP",
      "ON_FILE_RX_FILLING",
      "OTHER",
      "REFILL_TOO_SOON",
      "REJECT",
      "REJECT_CHANGE_FILL",
      "REJECT_CHANGE_FILL_DONE",
      "REJECT_CHANGE_REFILL",
      "REJECT_DOWNTIME",
      "REJECT_DUR",
      "REJECT_NOTIFY_PATIENT",
      "REJECT_NOTIFY_PLAN",
      "REJECT_NOTIFY_PRESCRIBER",
      "REJECT_OUT_OF_STOCK",
      "REJECT_PRICING",
      "REJECT_REFILL_PRICING",
      "REJECT_REFILL_TOO_SOON",
      "REJECT_TP",
      "REJECTED",
      "REPLACE_MISSING",
      "REVERSE",
      "REVERSE_TRANSMIT_FAIL",
      "STARTUP_PUTBACK",
      "TP_EXCEPTION",
      "UNDO_IFILL",
      "UNSELL_ORDER"
    ]
  }

  dimension: workflow_completed_tasks {
    label: "Include Completed Tasks (Yes/No)"
    description: "Yes/No Flag indicating tasks that were completed in workflow. Yes includes all tasks with 'COMPLETE' or 'FINISH' task action but excludes status with a pattern match of 'REJECT', 'CANCEL','UNDO MOVE', 'NOTIFY', 'PUTBACK', 'AUTOMATIC TIMEOUT', 'OTHER', 'KILL', 'EXCEPTION', 'REVERSE', 'REPLACE MISSING'"

    case: {
      when: {
        sql: (${task_history_task_action} = 'COMPLETE' OR REGEXP_INSTR(${task_history_task_action}, 'FINISH') != 0 ) AND (${task_history_status} IS NULL OR (${task_history_status} NOT LIKE '%REJECT%' and ${task_history_status} NOT LIKE '%CANCEL%' AND ${task_history_status} NOT LIKE '%UNDO_MOVE%' and ${task_history_status} NOT LIKE '%NOTIFY_%'  and ${task_history_status} NOT LIKE'%PUTBACK%' AND ${task_history_status} NOT IN ('AUTOMATIC_TIMEOUT', 'OTHER', 'KILL', 'EXCEPTION', 'REVERSE', 'REPLACE_MISSING'))) ;;
        label: "YES"
      }

      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  ## [ERXLPS-202] - This will only work 100 % if the Store Alignment provided by the customer matches the format of the Store Number in the workstation name. The business team understands this and it is mentioned in the description.
  #[ERXDWPS-5883] - Updated tool tip.
  dimension: on_site_alt_site {
    label: "Workflow Task Completed On Site"
    description: "Flag indicating if task was performed locally. IMPORTANT: This flag only works 100 percent if the Pharmacy Number provided in the Store Alignment file, matches the format of the pharmacy number in the Pharmacy Workstation Configuration name."
    type: string
    sql: CASE WHEN upper(${TABLE}.TASK_HISTORY_TASK_NAME) IN ('ORDER_ENTRY','DATA_ENTRY','DATA_VERIFICATION','DATA_VERIFICATION_CALL_PRES','DATA_VERIFICATION2_CALL_PAT','DATA_VERIFICATION2', 'DATA_VERIFICATION2_CALL_PRES','DATA_VERIFICATION_CALL_PAT','CALL_PATIENT','CALL_PHARMACY','CALL_PRESCRIBER','COB_REVIEW', 'COB_REVIEW2','MANUAL_CC_AUTH','TP_EXCEPTION','TP_EXCEPTION2') THEN (CASE  WHEN ${TABLE}.TASK_HISTORY_STATION_LABEL LIKE '%' || ${store.store_number} || '%' THEN 'YES' WHEN ${TABLE}.TASK_HISTORY_STATION_LABEL NOT LIKE '%' || ${store.store_number} || '%' THEN 'NO' WHEN TASK_HISTORY_STATION_LABEL IS NULL THEN 'NULL WORKSTATION NAME' END) ELSE 'YES' END ;;
  }

  ## [ERXLPS-667] - Added to Demo model for Explore Rx Demo to customer - 4/11/2017
  #[ERXDWPS-5883] - Updated tool tip.
  dimension: bi_demo_on_site_alt_site {
    label: "Workflow Task Completed On Site"
    description: "Flag indicating if task was performed locally. IMPORTANT: This flag only works 100 percent if the Pharmacy Number provided in the Store Alignment file, matches the format of the pharmacy number in the Pharmacy Workstation Configuration name."
    type: string
    sql: CASE WHEN upper(${TABLE}.TASK_HISTORY_TASK_NAME) IN ('ORDER_ENTRY','DATA_ENTRY','DATA_VERIFICATION','DATA_VERIFICATION_CALL_PRES','DATA_VERIFICATION2_CALL_PAT','DATA_VERIFICATION2', 'DATA_VERIFICATION2_CALL_PRES','DATA_VERIFICATION_CALL_PAT','CALL_PATIENT','CALL_PHARMACY','CALL_PRESCRIBER','COB_REVIEW', 'COB_REVIEW2','MANUAL_CC_AUTH','TP_EXCEPTION','TP_EXCEPTION2') THEN (CASE  WHEN ${TABLE}.TASK_HISTORY_STATION_LABEL LIKE '%' || ${bi_demo_store.store_number} || '%' THEN 'YES' WHEN ${TABLE}.TASK_HISTORY_STATION_LABEL NOT LIKE '%' || ${bi_demo_store.store_number} || '%' THEN 'NO' WHEN TASK_HISTORY_STATION_LABEL IS NULL THEN 'NULL WORKSTATION NAME' END) ELSE 'YES' END ;;
  }

  ## [ERXLPS-667] - Added to Demo model for Explore Rx Demo to customer - 4/11/2017
  dimension: bi_demo_task_history_label_pharmacy_number {
    label: "Off Site Pharmacy Number"
    description: "The Pharmacy Number that processed the Alternate Off Site task. The Pharmacy number is determined by the number in the client workstation of the requesting Pharmacy"
    type: string
    #sql: SUBSTR(${TABLE}.TASK_HISTORY_STATION_LABEL, 1, 4) ;;
    sql: SHA2(${TABLE}.TASK_HISTORY_STATION_LABEL) ;; #[ERXDWPS-5883] Seeing 'Fred' key word on Looker reports in DEMO Model Task History and WF Explores. Added SHA256 for now. Will discuss with business team and make the changes if any required.
  }

  #[ERXDWPS-5883] - Modified type to yesno and updated sql logic.
  dimension: Human_Task {
    label: "Human Task"
    description: "Yes/No Flag indicating if the task was performed by a human or not(background user)"
    type: yesno
    sql: (CASE WHEN  (UPPER(${task_history_user_login}) in ('NOUSER','FILLWORKERMANAGER','PVWORKERMANAGER','WILLCALLWORKERMANAGER','IVRWORKER','OEINTERFACE','SYSTEM','POSMSGWORKER','ACSWORKERMANAGER','BGWORKERMANAGER','ESCRIPTRESPONSEWORKER') or  UPPER(${task_history_user_employee_number}) IN ('NOEMPLOYID','01229','01231','01233','01235','01227','01221','01223','01224','01222','01226' )) THEN 'No' ELSE 'Yes' END) = 'Yes' ;;
  }

  #[ERXDWPS-5883]
  dimension: task_history_task_start_time {
    label: "Task History Task Start Time - Derived"
    description: "Latest task start time (Derived) before the task_action_date. This dimension/measure should be used in conjuction with completion task."
    type: string
    hidden: yes
    sql: etl_manager.fn_get_value_as_of_date(${task_history_task_start_listagg.task_history_action_date_hist}, date_part(epoch_nanosecond, ${TABLE}.TASK_HISTORY_ACTION_DATE),'N')  ;;
  }

  dimension: task_history_task_time {
    label: "Task History Task Time in Sec"
    description: "Time taken for a task. This dimension should be used only for tasks which are completed to get the corrected results. Calculation Used: Task History Action Time - Task History Task Start Time - Derived."
    type: number
    hidden: yes
    sql: DATEDIFF(second, to_timestamp(${task_history_task_start_time}), ${TABLE}.TASK_HISTORY_ACTION_DATE) ;;
  }

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    label: "Task History Count"
    description: "Total number of Task"
    type: number
    sql: COUNT(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${task_history_id}) ;;
    value_format: "#,##0"
  }

  measure: count_user_employee_number {
    label: "Total User"
    description: "Total number of User"
    type: count_distinct
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${task_history_user_employee_number} ;;
  }

  measure: count_demo_user_employee_number {
    label: "Total User"
    description: "Total number of User"
    type: count_distinct
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${task_history_demo_user_employee_number} ;;
  }

  #[ERXDWPS-5883] - Added the measure in eps_task_history view to consider all tasks (task which have null task_time.) Adding this measure in task_histoty_task_start_list_agg view producing incorrect results by exclusing tasks with NULL times for average calculation.
  measure: avg_task_time {
    label: "Task History Task Time (in Sec) - Average"
    description: "Average Task History Task Time (in Sec). Calculation used: Task History Action Time - Task History Start Time (Derived). Task History Task Start is the latest start time of a task when more than one start task(getNext / manual_select / remote_select) exists."
    type: average
    sql_distinct_key: ${task_history_task_start_listagg.primary_key} ;;
    sql: nvl(${task_history_task_time},0) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

#[ERXDWPS-5989] - Meijer: Need to Expose Last Updated in Workflow and Task History Explore
  measure: max_task_history_source_timestamp {
    label: "Task History Max Source Timestamp"
    description: "Latest activity date/time on Task History record.This field is for reference only and should not be used for calculations."
    type: string
    can_filter: no
    sql: to_char(max(${TABLE}.SOURCE_TIMESTAMP), 'yyyy-mm-dd hh24:mi:ss') ;;
  }

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
  filter: task_history_action_date_filter {
    label: "Prescription Transaction Task Start"
    description: "Date/Time that the action was performed for any given task associated to a prescription transaction"
    type: date
  }
}

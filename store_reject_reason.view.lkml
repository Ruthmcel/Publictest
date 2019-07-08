view: store_reject_reason {
  label: "Reject Reason"
  sql_table_name: EDW.F_REJECT_REASON ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number. This field is EPS only!!!"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${reject_reason_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    type: number
    label: "Chain ID"
    hidden: yes
    description: "Identification number assigned to each customer chain by NHIN. This field is EPS only!!!"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Nhin Store ID"
    hidden: yes
    description: "NHIN account number which uniquely identifies the store with NHIN. This field is EPS only!!!"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. This field is EPS only!!!"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: reject_reason_id {
    type: number
    hidden: yes
    label: "Reject Reason Id"
    description: "Unique Identification Value for the Reject Reason record. This field is EPS only!!!"
    sql: ${TABLE}.REJECT_REASON_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    label: "Prescription Transaction ID"
    hidden: yes
    description: "Prescription Transaction ID of the Prescription associated with the reject reason record. This field is EPS only!!!"
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: reject_reason_workflow_token_id {
    type: number
    label: "Reject Reason Workflow Token ID"
    hidden: yes
    description: "Workflow record to which this rejection is associated. This field is EPS only!!!"
    sql: ${TABLE}.REJECT_REASON_WORKFLOW_TOKEN_ID ;;
  }


  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################

  dimension: reject_reason_text {
    type: string
    label: "Reject Reason Text"
    description: "Used to store the reject text displayed to a user when the exception task is displayed.. This field is EPS only!!!"
    sql: ${TABLE}.REJECT_REASON_TEXT ;;
  }

  dimension: reject_reason_workflow_state_name {
    type: string
    label: "Reject Reason Workflow State Name"
    description: "The workflow state that generated the reject, if the transaction was active in workflow at the time of record creation. . This field is EPS only!!!"
    sql: ${TABLE}.REJECT_REASON_WORKFLOW_STATE_NAME ;;
  }

  dimension: reject_reason_clear_task_flag {
    type: yesno
    label: "Reject Reason Clear Task"
    description: "Yes/No flag indicating if the appropriate action has been completed to allow the prescription transaction to continue forward in the workflow process. This field is EPS only!!!"
    sql: ${TABLE}.REJECT_REASON_CLEAR_TASK_FLAG ='Y' ;;
  }

  dimension: reject_reason_source_create_reference {
    label: "Reject Reason Added"
    description: "Date/Time reject reason record was added"
    hidden:  yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }


  ################################################################################################## End of Dimensions ################################################################################################

  ################################################################################################## SETS ################################################################################################

  set: explore_rx_reject_reason_4_13_candidate_list {
    fields: [
      reject_reason_text,
      reject_reason_workflow_state_name,
      reject_reason_clear_task_flag
    ]
  }

}

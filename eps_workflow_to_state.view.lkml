view: eps_workflow_to_state {
  sql_table_name: EDW.D_WORKFLOW_STATE ;;

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

  dimension: workflow_to_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_STATE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_to_state_id} ;; #ERXLPS-1649
  }

  dimension: workflow_to_state_name {
    label: "Workflow Transition To State Name"
    description: "Name of the workflow state that a task is moved to"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_NAME ;;
  }
}

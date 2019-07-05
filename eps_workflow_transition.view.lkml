view: eps_workflow_transition {
  sql_table_name: EDW.D_WORKFLOW_TRANSITION ;;

  dimension: workflow_transition_id {
    label: "Workflow Transition ID"
    description: "Unique ID number identifying a workflow transition record within a pharmacy chain"
    type: number
    sql: ${TABLE}.WORKFLOW_TRANSITION_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_transition_id} ;; #ERXLPS-1649
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

  dimension: workflow_transition_from_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_TRANSITION_FROM_STATE_ID ;;
  }

  dimension: workflow_transition_to_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_TRANSITION_TO_STATE_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################
  dimension: workflow_transition_name {
    label: "Workflow Transition Name"
    description: "Workflow transition name"
    type: string
    sql: ${TABLE}.WORKFLOW_TRANSITION_NAME ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: workflow_transition_server_mode {
    label: "Workflow Transition Server Mode"
    description: "Workflow transition server modes such as Workflow and Rapidfill"
    type: string

    case: {
      when: {
        sql: ${TABLE}.WORKFLOW_TRANSITION_SERVER_MODE = 'WF' ;;
        label: "Workflow"
      }

      when: {
        sql: ${TABLE}.WORKFLOW_TRANSITION_SERVER_MODE = 'RF' ;;
        label: "Rapid Fill"
      }

      when: {
        sql: true ;;
        label: "Both"
      }
    }
  }
}

################################################################################################## End of Dimensions #################################################################################################

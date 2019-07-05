view: eps_workflow_state_attribute {
  sql_table_name: EDW.D_WORKFLOW_STATE_ATTRIBUTE ;;

  dimension: workflow_state_attribute_id {
    label: "Workflow State Attribute ID"
    description: "Unique ID number identifying a workflow state attribute record within a pharmacy chain"
    type: number
    sql: ${TABLE}.WORKFLOW_STATE_ATTRIBUTE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_state_attribute_id} ;; #ERXLPS-1649
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

  dimension: workflow_type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_TYPE_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  dimension: workflow_state_sequence {
    label: "Workflow State Sequence"
    description: "Workflow state with a lower sequence value as a predecessor of a workflow state with a higher sequence value."
    hidden: yes
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_SEQUENCE ;;
  }

  dimension: workflow_state_bypass_sister_task_in_state {
    label: "Workflow State Bypass Sister Task In State"
    description: "Comma separated list of workflow state names"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_BYPASS_SISTER_TASK_IN_STATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################
  dimension: workflow_state_require_grouping {
    label: "Workflow State Require Grouping"
    description: "Yes/No Flag indicating if the grouping is required for workflow state"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_REQUIRE_GROUPING = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: workflow_state_order_split_code {
    label: "Workflow State Order Split Code"
    description: "Workflow State order split codes such as NoSplit, Split and Indeterm"
    type: string

    case: {
      when: {
        sql: ${TABLE}.WORKFLOW_STATE_ORDER_SPLIT_CODE = 'NOSPLIT' ;;
        label: "NO SPLIT"
      }

      when: {
        sql: ${TABLE}.WORKFLOW_STATE_ORDER_SPLIT_CODE = 'SPLIT' ;;
        label: "SPLIT"
      }

      when: {
        sql: ${TABLE}.WORKFLOW_STATE_ORDER_SPLIT_CODE = 'INDETERM' ;;
        label: "INDETERM"
      }

      when: {
        sql: true ;;
        label: "NONE"
      }
    }
  }
}

################################################################################################## End of Dimensions #################################################################################################

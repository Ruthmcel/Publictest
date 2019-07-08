view: eps_workflow_type {
  sql_table_name: EDW.D_WORKFLOW_TYPE ;;

  dimension: workflow_type_id {
    label: "Workflow Type ID"
    description: "Unique ID number identifying an workflow type record within a pharmacy chain"
    type: number
    sql: ${TABLE}.WORKFLOW_TYPE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_type_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: string
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: string
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: parent_workflow_type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PARENT_WORKFLOW_TYPE_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: workflow_type_code {
    label: "Workflow Type"
    description: "Includes Workflow (WF), Rapidfill (RF) and Specialty Workflow (SP_WF)"
    type: string

    case: {
      when: {
        sql: ${TABLE}.WORKFLOW_TYPE_CODE = 'WF' ;;
        label: "Workflow"
      }

      when: {
        sql: ${TABLE}.WORKFLOW_TYPE_CODE = 'RF' ;;
        label: "Rapidfill"
      }

      when: {
        sql: ${TABLE}.WORKFLOW_TYPE_CODE = 'SP_WF' ;;
        label: "Speciality Workflow"
      }

      when: {
        sql: true ;;
        label: "None"
      }
    }
  }
}

################################################################################################## End of Dimensions #################################################################################################

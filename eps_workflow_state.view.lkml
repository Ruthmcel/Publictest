view: eps_workflow_state {
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

  dimension: workflow_state_id {
    hidden: yes
    type: number
    sql: ${TABLE}.WORKFLOW_STATE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${workflow_state_id} ;; #ERXLPS-1649
  }

  dimension: workflow_state_name {
    label: "Workflow State Name"
    description: "Name of the workflow state that a task is moved to"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_NAME ;;
  }

  #[ERXLPS-658] - New dimension added to get current workflow state name of a prescription transaction
  dimension: workflow_current_state_name {
    label: "Current Workflow State Name"
    description: "Name of the current workflow state for prescriptions. This is used along with Task Count measure to get the details about current prescription count for each workflow state"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_NAME ;;
  }

  dimension: workflow_state_short_description {
    label: "Workflow State Short Description"
    description: "Short Description of the workflow state description"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_SHORT_DESCRIPTION ;;
  }

  dimension: workflow_state_description {
    label: "Workflow State Description"
    description: "Description of the workflow state which provides more detail as to the process"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_DESCRIPTION ;;
  }

  dimension: workflow_state_call_task {
    label: "Workflow State Call Task"
    description: "Yes/No Flag that indicates if this workflow state is a call task"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_CALL_TASK = 'Y' ;;
  }

  dimension: workflow_state_on_hand_adjusted_state {
    label: "Workflow State On Hand Adjusted State"
    description: "Yes/No Flag hat determines if the quantity of the drug for the prescription in this workflow state is decremented from pharmacy inventory or incremented to pharmacy inventory (After Fill (pills in the bottle), the quantity filled is decremented from the pharmacy's inventory of that NDC. However, if the Rx is rejected back from Fill or any workflow state beyond, the inventory will be incremented by the Fill amount"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_ON_HAND_ADJUSTED_STATE = 'Y' ;;
  }

  dimension: workflow_state_publish_to_alternate_site {
    label: "Workflow State Publish to Alternate Site"
    description: "Yes/No Flag that determines if a workflow state is published to the ECC as a task that can be worked by an alternate site"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_PUBLISH_TO_ALTERNATE_SITE = 'Y' ;;
  }

  dimension: workflow_state_quantity_allocated_state {
    label: "Workflow State Quantity Allocated State"
    description: "Yes/No Flag that determines if the quantity of the drug for the prescription in this workflow state is allocated"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_QUANTITY_ALLOCATED_STATE = 'Y' ;;
  }

  dimension: workflow_state_quantity_remaining_adjusted_state {
    label: "Workflow State Quantity Remaining Adjusted State"
    description: "Yes/No Flag that determines if the prescription's remaining quantity is adjusted by the fill amount"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_QUANTITY_REMAINING_ADJUSTED_STATE = 'Y' ;;
  }

  dimension: workflow_state_assignment_handler {
    label: "Workflow State Assignment Handler"
    description: "This field works with the REQUIRED_ROLE and references the assignment handler code which is used to determine which REQUIRED_ROLE should be assigned to the WORKFLOW_TOKEN record forthis workflow state"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_ASSIGNMENT_HANDLER ;;
  }

  dimension: workflow_state_data_assembler_name {
    label: "Workflow State Data Assembler Name"
    description: "This field determines the code section/method to use to move the RX to the specified state"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_DATA_ASSEMBLER_NAME ;;
  }

  dimension: workflow_state_decision_handler {
    label: "Workflow State Decision Handler"
    description: "This field determines the code section/method which makes a decision on to what state it can move"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_DECISION_HANDLER ;;
  }

  dimension: workflow_state_get_nextable {
    label: "Workflow State Get Nextable"
    description: "Yes/No Flag that determines if this task is a task that can be worked alternate site and does not require the prescription to be physically present"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_GET_NEXTABLE = 'Y' ;;
  }

  dimension: workflow_state_main_line_task {
    label: "Workflow State Main Line Task"
    description: "Yes/No Flag that determines if this task is a task is a main line task or No, if its a child task"
    type: yesno
    sql: ${TABLE}.WORKFLOW_STATE_MAIN_LINE_TASK = 'Y' ;;
  }

  dimension: workflow_state_incoming_listener {
    label: "Workflow State Incoming Listener"
    description: "This field indicates the listener method  which is used when an RX or token hits this state. Used to automatically send a message to for example central services/ mobile services to inform a patient that their prescription is ready"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_INCOMING_LISTENER ;;
  }

  dimension: workflow_state_required_role {
    label: "Workflow State Required Role"
    description: "This the required role name from the master ROLES table that a user's group must have in order for the user to work the task"
    type: string
    sql: ${TABLE}.WORKFLOW_STATE_REQUIRED_ROLE ;;
  }

  #[ERXLPS-658] - Hiding Workflow State Count measure. Exposing Workflow Token 'Task Count' Measure to end user.
  measure: count {
    label: "Workflow State Count"
    hidden: yes
    type: count
    value_format: "#,##0"
    drill_fields: [nhin_store_id, store.store_number, store.store_name, workflow_state_name, workflow_state_description]
  }

  #################################################################### Sets ######################################################################

  #[ERXLPS-658] - Set created to display workflow state view fields apart from workflow current state.
  set: workflow_state_candidate_list {
    fields: [
      workflow_state_name,
      workflow_state_short_description,
      workflow_state_description,
      workflow_state_call_task,
      workflow_state_on_hand_adjusted_state,
      workflow_state_publish_to_alternate_site,
      workflow_state_quantity_allocated_state,
      workflow_state_quantity_remaining_adjusted_state,
      workflow_state_assignment_handler,
      workflow_state_data_assembler_name,
      workflow_state_decision_handler,
      workflow_state_get_nextable,
      workflow_state_main_line_task,
      workflow_state_incoming_listener,
      workflow_state_required_role
    ]
  }
}

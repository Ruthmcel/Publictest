view: store_return_and_adjustment {
  sql_table_name: EDW.F_RETURN_AND_ADJUSTMENT ;;

  dimension: return_and_adjustment_id {
    type: number
    hidden: yes
    label: "Return And Adjustment ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${return_and_adjustment_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Return And Adjustment Chain ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Return And Adjustment NHIN STORE ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: adjustment_code_id {
    type: number
    label: "Return And Adjustment Code ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    hidden: yes
    sql: ${TABLE}.ADJUSTMENT_CODE_ID ;;
  }

  dimension: adjustment_group_id {
    type: number
    label: "Return And Adjustment Group ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    hidden: yes
    sql: ${TABLE}.ADJUSTMENT_GROUP_ID ;;
  }

  dimension: drug_id {
    type: number
    label: "Return And Adjustment Drug ID. EPS Table Name: RETURN_AND_ADJUSTMENT"
    hidden: yes
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXDWPS-5731]
  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: workflow_state_id {
    type: number
    hidden: yes
    sql: ${TABLE}.WORKFLOW_STATE_ID ;;
  }

  dimension: cycle_count_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CYCLE_COUNT_ID ;;
  }

  dimension: drug_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DRUG_ORDER_ID ;;
  }

  dimension: notes_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NOTES_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################

  dimension: return_and_adjustment_description {
    type: string
    label: "Return And Adjustment Description"
    description: "Explains why the drug is returned, destroyed, transferred in, or adjusted. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_DESCRIPTION ;;
  }

  dimension: return_and_adjustment_item_description {
    type: string
    label: "Return And Adjustment Item Description"
    description: "The name of the drug or item that the return_and_adjustment record is being created for. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_ITEM_DESCRIPTION ;;
  }

  dimension: return_and_adjustment_item_number {
    type: string
    label: "Return And Adjustment Item Number"
    description: "Drug item number for the inventory item. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_ITEM_NUMBER ;;
  }

  dimension: return_and_adjustment_ndc {
    type: string
    label: "Return And Adjustment NDC"
    description: "National Drug Identifier. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_NDC ;;
  }

  dimension: return_and_adjustment_nhin_batch_id {
    type: string
    label: "Return And Adjustment NHIN Batch ID"
    description: "NHIN Batch Identifier. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_NHIN_BATCH_ID ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Return And Adjustment Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the return and adjustment was deleted from the source system. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_DELETED ;;
  }

  #[ERXDWPS-5731]
  dimension: return_and_adjustment_employee_number {
    type: string
    hidden: yes #Exposed from store_user view
    label: "Return And Adjustment Employee Number"
    description: "Employee number who made the adjustment. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_EMPLOYEE_NUMBER ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################


  dimension_group: return_and_adjustment_applied_date {
    label: "Return And Adjustment Applied"
    description: "Date the system updated the onhand inventory amount from this record. EPS Table Name: RETURN_AND_ADJUSTMENT"
    type: time
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_APPLIED_DATE ;;
  }

  dimension_group: return_and_adjustment_deactivate_date {
    label: "Return And Adjustment Deactivated"
    description: "Date this record was deactivated. EPS Table Name: RETURN_AND_ADJUSTMENT"
    type: time
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_DEACTIVATE_DATE ;;
  }

  #[ERXDWPS-5731]
  dimension_group: return_and_adjustment_update {
    label: "Return And Adjustment Update"
    description: "Date this record was last updated. EPS Table Name: RETURN_AND_ADJUSTMENT"
    type: time
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_UPDATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis. EPS Table Name: RETURN_AND_ADJUSTMENT"
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: return_and_adjustment_added_by_inventory_count {
    label: "Return And Adjustment Added By Inventory Count"
    description: "Yes/No Flag indicating whether the Inventory Count Apply function created the record. EPS Table Name: RETURN_AND_ADJUSTMENT"
    type: yesno
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_ADDED_BY_INVENTORY_COUNT = 'Y' ;;
  }

  ####################################################################################################### End of Dimension ##########################################################################################################

  ####################################################################################################### Measures #################################################################################################################

  measure: count {
    label: "Total Return And Adjustments"
    type: count
    value_format: "#,##0"
  }

  measure: sum_return_and_adjustment_inventory_amount {
    type: sum
    label: "Total Return And Adjustment Inventory Quantity*"
    description: "Total number of units of the drug returned, destroyed, transferred, or adjusted. Column INVENTORY_AMOUNT in Store Database represents Inventory Quantity. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_INVENTORY_AMOUNT ;;
    value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2185] Corrected value_format and label name.
  }

  measure: sum_return_and_adjustment_total_cost {
    type: sum
    label: "Total Return And Adjustment Cost"
    description: "Total value of the inventory adjustment. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_TOTAL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXDWPS-5731]
  measure: sum_return_and_adjustment_unit_cost_amount {
    type: sum
    label: "Total Return And Adjustment Unit Cost"
    description: "Total Unit ACQ cost for the adjustment amount. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_return_and_adjustment_initial_on_hand_quantity {
    type: sum
    label: "Total Return And Adjustment Initial On Hand Quantity"
    description: "Initial on-hand quantity (before the adjustment) of the drug record in which an adjustment is being made. EPS Table Name: RETURN_AND_ADJUSTMENT"
    sql: ${TABLE}.RETURN_AND_ADJUSTMENT_INITIAL_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }
}

####################################################################################################### End of Measures #################################################################################################################

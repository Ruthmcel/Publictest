view: store_purchase_order {
  sql_table_name: EDW.F_PURCHASE_ORDER ;;

  dimension: purchase_order_id {
    type: number
    hidden: yes
    label: "Purchase Order ID"
    sql: ${TABLE}.PURCHASE_ORDER_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${purchase_order_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Purchase Order Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Purchase Order NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: vendor_id {
    type: number
    label: "Purchase Order Vendor ID"
    hidden: yes
    sql: ${TABLE}.VENDOR_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################

  dimension: purchase_order_acknowledgement_received_employee_number {
    type: string
    label: "Purchase Order Ack Received Employee Number"
    description: "Employee number of the user or process that received the acknowledgement"
    sql: ${TABLE}.PURCHASE_ORDER_ACKNOWLEDGEMENT_RECEIVED_EMPLOYEE_NUMBER ;;
  }

  dimension: purchase_order_applied_to_inventory_employee_number {
    type: string
    label: "Purchase Order Applied to Inventory Employee Number"
    description: "Employee number of the user or process that received the inventory and applied it"
    sql: ${TABLE}.PURCHASE_ORDER_APPLIED_TO_INVENTORY_EMPLOYEE_NUMBER ;;
  }

  dimension: purchase_order_transmit_employee_number {
    type: string
    label: "Purchase Order Transmit Employee Number"
    description: "Employee number of the user or process that transmitted or generated the 850 request file"
    sql: ${TABLE}.PURCHASE_ORDER_TRANSMIT_EMPLOYEE_NUMBER ;;
  }

  dimension: purchase_order_control_number {
    type: string
    label: "Purchase Order Control Number"
    description: "Concatenated store indentifier and sequence number"
    sql: ${TABLE}.PURCHASE_ORDER_CONTROL_NUMBER ;;
  }

  dimension: purchase_order_dea_tracking_number {
    type: string
    label: "Purchase Order DEA Tracking Number"
    description: "Tracking number associated with a  controlled substance (CSOS) order"
    sql: ${TABLE}.PURCHASE_ORDER_DEA_TRACKING_NUMBER ;;
  }

  dimension: purchase_order_number {
    type: string
    label: "Purchase Order Number"
    description: "Purchase order number assigned to the drug order"
    sql: ${TABLE}.PURCHASE_ORDER_NUMBER ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Purchase Order Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the purchase order was deleted from the source system"
    sql: ${TABLE}.PURCHASE_ORDER_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: purchase_order_acknowledgement_received {
    label: "Purchase Order Ack Received"
    description: "Date the 855 (Acknowledgement) was received"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_ACKNOWLEDGEMENT_RECEIVED_DATE ;;
  }

  dimension_group: purchase_order_received_856 {
    label: "Purchase Order Received 856"
    description: "Date the 856 for this purchase order record was received from the vendor"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_RECEIVED_856_DATE ;;
  }

  dimension_group: purchase_order_applied_to_inventory {
    label: "Purchase Order Applied to Inventory"
    description: "Date the order records were applied to inventory"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_APPLIED_TO_INVENTORY_DATE ;;
  }

  dimension_group: purchase_order_check_in {
    label: "Purchase Order Check In"
    description: "Date the order is designated as received and applied"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_CHECK_IN_DATE ;;
  }

  dimension_group: purchase_order_create {
    label: "Purchase Order Create"
    description: "Date this drug order was generated"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_CREATE_DATE ;;
  }

  dimension_group: purchase_order_deactivate {
    label: "Purchase Order Deactivate"
    description: "Date the Purchase Order is deactivated"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_DEACTIVATE_DATE ;;
  }

  dimension_group: purchase_order_submit {
    label: "Purchase Order Submit"
    description: "Date the order was submitted to the vendor"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_SUBMIT_DATE ;;
  }

  dimension_group: purchase_order_transmit {
    label: "Purchase Order Transmit"
    description: "Date the order was transmitted to the vendor"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_TRANSMIT_DATE ;;
  }

  dimension_group: purchase_order_ready {
    label: "Purchase Order Ready"
    description: "Date the order was marked as Ready"
    type: time
    sql: ${TABLE}.PURCHASE_ORDER_READY_DATE ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: purchase_order_type {
    type: string
    label: "Purchase Order Type"
    description: "Identifies the type (REGULAR, SCHEDULE II) of order"

    case: {
      when: {
        sql: ${TABLE}.PURCHASE_ORDER_TYPE = 'R' ;;
        label: "REGULAR"
      }

      when: {
        sql: ${TABLE}.PURCHASE_ORDER_TYPE = '2' ;;
        label: "SCHEDULE II"
      }
    }
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################
  measure: count {
    label: "Total Purchase Orders"
    type: count
    value_format: "#,##0"
  }
}

####################################################################################################### End of Measures #################################################################################################################

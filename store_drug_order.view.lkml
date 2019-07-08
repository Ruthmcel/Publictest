view: store_drug_order {
  sql_table_name: EDW.F_DRUG_ORDER ;;

  dimension: drug_order_id {
    type: number
    label: "Drug Order ID"
    description: "Unique ID number identifying a Drug Order record within a pharmacy chain"
    sql: ${TABLE}.DRUG_ORDER_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_order_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Drug Order Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Drug Order NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: drug_id {
    type: number
    hidden: yes
    label: "Drug Order Drug ID"
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: adjustment_code_id {
    type: number
    hidden: yes
    label: "Drug Order Adjustment Code ID"
    sql: ${TABLE}.ADJUSTMENT_CODE_ID ;;
  }

  dimension: drug_reorder_id {
    type: number
    hidden: yes
    label: "Drug Order Drug Reorder ID"
    sql: ${TABLE}.DRUG_REORDER_ID ;;
  }

  dimension: purchase_order_id {
    type: number
    hidden: yes
    label: "Drug Order Purchase Order ID"
    sql: ${TABLE}.PURCHASE_ORDER_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################
  dimension: drug_order_counter {
    type: number
    label: "Drug Order Counter"
    description: "Numeric value that represents the true count of the specified drug.  This value is incremented from 0 to n for each occurance of an NDC within the group of drug order records associated with a given purchase order"
    sql: ${TABLE}.DRUG_ORDER_COUNTER ;;
  }

  dimension: drug_order_item_number {
    type: string
    label: "Drug Order Item Number"
    description: "Reorder number used to order this drug from the vendor"
    sql: ${TABLE}.DRUG_ORDER_ITEM_NUMBER ;;
  }

  dimension: drug_order_sub_item_number {
    type: string
    label: "Drug Order Sub Item Number"
    description: "Item number of a substituted drug"
    sql: ${TABLE}.DRUG_ORDER_SUB_ITEM_NUMBER ;;
  }

  dimension: drug_order_ndc {
    type: string
    label: "Drug Order NDC"
    description: "National Drug Code Identifier"
    sql: ${TABLE}.DRUG_ORDER_NDC ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Drug Order Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug order was deleted from the source system"
    sql: ${TABLE}.DRUG_ORDER_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: drug_order_applied_to_inventory {
    label: "Drug Order Applied to Inventory"
    description: "Date the order records were applied to inventory"
    type: time
    sql: ${TABLE}.DRUG_ORDER_APPLIED_TO_INVENTORY_DATE ;;
  }

  dimension_group: drug_order_check_in {
    label: "Drug Order Check In"
    description: "Date the order was actually received and checked into inventory"
    type: time
    sql: ${TABLE}.DRUG_ORDER_CHECK_IN_DATE ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: drug_order_reason_code {
    type: string
    label: "Drug Order Reason Code"
    description: "Indicates a reason code for why an item is consisered an exception in an EDI 855 acknowledgement file"

    case: {
      when: {
        sql: ${TABLE}.DRUG_ORDER_REASON_CODE = '1' ;;
        label: "REJECTED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_REASON_CODE = '2' ;;
        label: "NOT INCLUDED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_REASON_CODE = '3' ;;
        label: "INVALID SUBSTITUTION ITEM"
      }

      when: {
        sql: true ;;
        label: "NONE"
      }
    }
  }

  dimension: drug_order_item_status {
    type: string
    label: "Drug Order Item Status"
    description: "Status code the supplier may transmit back to the pharmacy in a purchase order acknowledgment that determines the supplier's action (ACCEPTED, REJECTED, BACKORDERED) for the ordered item on the screen"

    case: {
      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IA' ;;
        label: "ACCEPTED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IB' ;;
        label: "BACKORDERED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IQ' ;;
        label: "QUANTITY CHANGED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IR' ;;
        label: "REJECTED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IS' ;;
        label: "SUBSTITUTION MADE"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS = 'IW' ;;
        label: "WAIVER REQUIRED"
      }

      when: {
        sql: ${TABLE}.DRUG_ORDER_ITEM_STATUS IS NULL ;;
        label: "NO RESPONSE RECEIVED"
      }
    }
  }

  dimension: drug_order_cost_received_difference {
    type: number
    # Used in templated Filter
    hidden: yes
    label: "Drug Order Cost Received Difference"
    description: "The difference between the Drug Order Cost Received and the Drug Order ACQ Cost in the store system at the time the acknowledgement was processed from the wholesaler. When the quantity received is 0, the cost difference is automatically calculated as 0"
    sql: CASE WHEN NVL(${TABLE}.DRUG_ORDER_COST_RECIEVED,0) > 0 THEN (${TABLE}.DRUG_ORDER_COST_RECIEVED - (${TABLE}.DRUG_ORDER_ACQUISITION_COST * (CASE WHEN NVL(${TABLE}.DRUG_ORDER_CONVERSION_FACTOR,0.0000) = 0.0000 THEN 1.0000 ELSE ${TABLE}.DRUG_ORDER_CONVERSION_FACTOR END))) ELSE 0 END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################
  measure: count {
    label: "Total Drug Orders"
    type: count
    value_format: "#,##0"
  }

  measure: sum_drug_order_conversion_factor {
    type: sum
    label: "Drug Order Conversion Factor"
    description: "Order quantity conversion factor the system uses to convert the ordered quantity to the quantity reported to the supplier"
    sql: ${TABLE}.DRUG_ORDER_CONVERSION_FACTOR ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_vendor_order_quantity {
    type: sum
    label: "Total Drug Order Vendor Order Factor"
    description: "Quantity that was actually ordered in the 850 with the conversion factor applied.  If the pack size is 100 and we order 1 pack, the order qty will be 100, but if the vendor views that as 1 unit, the conversion factor will be .01, and the vendor_order_qty wil be 1."
    sql: ${TABLE}.DRUG_ORDER_VENDOR_ORDER_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_vendor_received_quantity {
    type: sum
    label: "Total Drug Order Vendor Received Quantity"
    description: "Quantity of the drug received before applying the conversion factor to convert back to multiples of the pack size.  To determine the number of reorder units, the system first divides the reorder quantity by the pack size. Then, it divides the result by the conversion factor"
    sql: ${TABLE}.DRUG_ORDER_VENDOR_RECEIVED_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_vendor_acknowledgement_received_quantity {
    type: sum
    label: "Total Drug Order Vendor Ack Received Quantity"
    description: "Quantity that the vendor indicated would be shipped on the drug order acknowledgment before applying the conversion factor to convert back to multiples of the pack size.  f the pack size is 100 and we order 1 pack, the ack rec qty will be 100, but if the vendor views that as 1 unit, the conversion factor will be .01, and the vendor_ack_received_qty wil be 1"
    sql: ${TABLE}.DRUG_ORDER_VENDOR_ACKNOWLEDGEMENT_RECEIVED_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_acknowledgement_received_quantity {
    type: sum
    label: "Total Drug Order Ack Received Quantity"
    description: "Quantity that the vendor indicated would be shipped on the drug order acknowledgment"
    sql: ${TABLE}.DRUG_ORDER_ACKNOWLEDGEMENT_RECEIVED_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_quantity {
    type: sum
    label: "Total Drug Order Quantity"
    description: "Reorder quantity that corresponds to the Reorder QTY field of the drug's reorder parameters record. The entry in this field depends on the supplier designation. This is the quantity of drug inventory to be ordered from the supplier. The units must be a multiple of the units on the drug record. For example, if the Pack field on the drug record is 100, this field must be 100, 200, 300, etc.The user can however override the reorder qty with another qty. Also, the Up To Qty on the reorder record can cause this field to be greater than the order qty from the reorder parameter"
    sql: ${TABLE}.DRUG_ORDER_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_received_quantity {
    type: sum
    label: "Total Drug Order Received Quantity"
    description: "Quantity of the drug received. Initially reported by 855; may be adjusted manually for ACTUAL"
    sql: ${TABLE}.DRUG_ORDER_RECEIVED_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_unit_cost {
    type: sum
    label: "Total Drug Order Unit Cost"
    description: "Total unit cost for the drug being ordered at the time the order is created"
    sql: ${TABLE}.DRUG_ORDER_UNIT_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_order_acquisition_cost {
    type: sum
    label: "Total Drug Order ACQ Cost"
    description: "Total acquisition cost for the drug being ordered at the time the order is created"
    sql: ${TABLE}.DRUG_ORDER_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_order_cost_recieved {
    type: sum
    label: "Total Drug Order Cost Received"
    description: "Total acquisition cost for the drug being ordered. This cost may be updated with a new cost if the supplier returns the acquisition cost when receiving the order"
    sql: ${TABLE}.DRUG_ORDER_COST_RECIEVED ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_order_pack {
    type: sum
    label: "Total Drug Order Pack"
    description: "Total Pack size of the ordered drug"
    sql: ${TABLE}.DRUG_ORDER_PACK ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_order_cost_received_difference {
    type: sum
    label: "Total Drug Order Cost Received Difference"
    description: "The difference between the Drug Order Cost Received and the Drug Order ACQ Cost in the store system at the time the acknowledgement was processed from the wholesaler. When the quantity received is 0, the cost difference is automatically calculated as 0"
    sql: ${drug_order_cost_received_difference} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ####################################################################################################### End of Measures #################################################################################################################

  ##################################################################################### Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ##############################################
  filter: drug_order_cost_received_difference_filter {
    label: "Total Drug Order Cost Received Difference"
    description: "The difference between the Drug Order Cost Received and the Drug Order ACQ Cost in the store system at the time the acknowledgement was processed from the wholesaler. When the quantity received is 0, the cost difference is automatically calculated as 0"
    type: number
    sql: {% condition drug_order_cost_received_difference_filter %} ${drug_order_cost_received_difference} {% endcondition %}
      ;;
  }
}

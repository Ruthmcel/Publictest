view: turnrx_transfer_store_to_store_task {
  label: "Transfer Store To Store Task"
  sql_table_name: EDW.F_TRANSFER_STORE_TO_STORE_TASK ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${sending_store_id} || '@' || ${receiving_store_id} || '@' || ${transfer_drug_ndc} || '@' || ${event_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN."
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: sending_store_id {
    label: "Sending Store Identifier"
    description: "The NHIN_STORE_ID of the Sending store initiating the Transfer"
    type: number
    sql: ${TABLE}.SENDING_STORE_IDENTIFIER ;;
  }

  dimension: receiving_store_id {
    label: "Receiving Store Identifier"
    description: "The NHIN_STORE_ID of the store receiving the Transfer. The INVENTORY_ID of the Facility and Inventory that is receiving the Transfer. Facilities at SBMO are NOT unique by themselves. It is a combination of the Facility and the Inventory that creates a unique location and Formulary. "
    type: number
    sql: ${TABLE}.RECEIVING_STORE_IDENTIFIER ;;
  }

  dimension: transfer_drug_ndc {
    label: "Transfer Drug NDC"
    description: "The NDC of the drug for the suggested transfer"
    type: string
    sql: ${TABLE}.TRANSFER_DRUG_NDC ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    type: number
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: transfer_drug_gpi {
    label: "Transfer Drug GPI"
    description: "GPI of the drug for the suggested transfer"
    type: string
    sql: ${TABLE}.TRANSFER_DRUG_GPI ;;
  }

  dimension: sending_store_drug_reorder_order_point {
    label: "Sending Store Drug Reorder Order Point"
    description: "Order Point for Drug Reorder"
    type: number
    sql: ${TABLE}.SENDING_STORE_DRUG_REORDER_ORDER_POINT ;;
  }

  dimension: sending_store_transfer_initiated_reason {
    label: "Sending Store Transfer Initiated Reason"
    description: "The Reason that the Transfer was initiated in the Sending Store"
    type: string
    sql: ${TABLE}.SENDING_STORE_TRANSFER_INITIATED_REASON;;

  }

  dimension: sending_store_activity_period_lookback_days {
    label: "Sending Store Activity Period Lookback Days"
    description: "The Number of Days to Lookback from the current date, to determine the Sending Store Activity Period. "
    type: number
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_LOOKBACK_DAYS ;;
  }

  dimension_group: sending_store_activity_period_start_date {
    label: "Sending Store Activity Period Start"
    description: "The beginning date of the Activity Date Range"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_START_DATE ;;
  }

  dimension_group: sending_store_activity_period_end_date {
    label: "Sending Store Activity Period End"
    description: "The ending date of the Activity Date Range"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_END_DATE ;;
  }

  dimension_group: sending_store_drug_last_sold_date {
    label: "Sending Store Drug Last Sold"
    description: "The Last Sold Date of the Drug at the Sending Store"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SENDING_STORE_DRUG_LAST_SOLD_DATE ;;
  }

  dimension_group: sending_store_combined_last_sold_date {
    label: "Sending Store Combined Last Sold"
    description: "The Sending Store Last Sold Date for the Order Point Group. This is not specific to the Order Point NDC, it could be a Child record Last Sold Date"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SENDING_STORE_COMBINED_LAST_SOLD_DATE ;;
  }

  dimension_group: sending_store_drug_on_hand_minimum_create_date {
    label: "Sending Store Drug On Hand Minimum Create"
    description: "The Minimum Create Date at the Sending Store for On Hand Inventory. This Date represents the first occurrence of stock in the store. "
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SENDING_STORE_DRUG_ON_HAND_MINIMUM_CREATE_DATE ;;
  }

  dimension: sending_store_on_hand_overstock_flag {
    label: "Sending Store On Hand Overstock Flag"
    description: "Yes/No flag indicating if the On Hand quantity at the Sending store is Overstock"
    type: yesno
    sql: ${TABLE}.SENDING_STORE_ON_HAND_OVERSTOCK_FLAG = 'Y' ;;
  }

  dimension: sending_store_activity_period_partial_pack_sold_flag {
    label: "Sending Store Activity Period Partial Pack Sold Flag"
    description: "Yes/No Flag indicating if the Sending store has sold Partial Package quantities of the Drug"
    type: yesno
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_PARTIAL_PACK_SOLD_FLAG = 'Y' ;;
  }

  dimension: sending_store_starting_on_hand_quantity {
    label: "Sending Store Starting On Hand Quantity"
    description: "The current state, starting on hand quantity of the drug at the Sending Store prior to the Transfer"
    type: number
    sql: ${TABLE}.SENDING_STORE_STARTING_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: sending_store_combined_starting_on_hand_quantity {
    label: "Sending Store Combined Starting On Hand Quantity"
    description: "The current state, starting on hand quantity of the drug at the Sending Store prior to the Transfer"
    type: number
    sql: ${TABLE}.SENDING_STORE_COMBINED_STARTING_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: sending_store_allocated_quantity {
    label: "Sending Store Allocated Quantity"
    description: "The Sending store Allocated Quantity for an individual NDC"
    type: number
    sql: ${TABLE}.SENDING_STORE_ALLOCATED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: sending_store_combined_allocated_quantity {
    label: "Sending Store Combined Allocated Quantity"
    description: "The Sending Store 'Combined' Allocated Quantity for an individual NDC"
    type: number
    sql: ${TABLE}.SENDING_STORE_COMBINED_ALLOCATED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: sending_store_on_hand_fragmented_quantity {
    label: "Sending Store On Hand Fragmented Quantity"
    description: "The quantity of On Hand for a Drug that is Fragmented Inventory at the Sending Store"
    type: number
    sql: ${TABLE}.SENDING_STORE_ON_HAND_FRAGMENTED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: receiving_store_activity_period_lookback_days {
    label: "Receiving Store Activity Period Lookback Days"
    description: "The Number of Days to Lookback from the current date, to determine the Receiving Store Activity Period. "
    type: number
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_LOOKBACK_DAYS ;;
  }

  dimension_group: receiving_store_activity_period_start_date {
    label: "Receiving Store Activity Period Start"
    description: "The beginning date of the Activity Date Range"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_START_DATE ;;
  }

  dimension_group: receiving_store_activity_period_end_date {
    label: "Receiving Store Activity Period End"
    description: "The ending date of the Activity Date Range"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_END_DATE ;;
  }

  dimension_group: receiving_store_drug_last_sold_date {
    label: "Receiving Store Drug Last Sold"
    description: "The Last Sold Date of the Drug at the Receiving Store"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RECEIVING_STORE_DRUG_LAST_SOLD_DATE ;;
  }

  dimension_group: receiving_store_combined_last_sold_date {
    label: "Receiving Store Combined Last Sold"
    description: "The Receiving Store Last Sold Date for the Order Point Group. This is not specific to the Order Point NDC, it could be a Child record Last Sold Date"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RECEIVING_STORE_COMBINED_LAST_SOLD_DATE ;;
  }

  dimension: receiving_store_activity_period_partial_pack_sold_flag {
    label: "Receiving Store Activity Period Partial Pack Sold Flag"
    description: "Yes/No Flag indicating if the Receiving store has sold Partial Package quantities of the Drug"
    type: yesno
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_PARTIAL_PACK_SOLD_FLAG = 'Y';;
  }

  dimension: suggested_total_transfer_reason {
    label: "Suggested Total Transfer Reason"
    description: "The reason the Suggested Total Transfer quantity and cost were recommended"
    type: string
    sql: ${TABLE}.SUGGESTED_TOTAL_TRANSFER_REASON;;
  }

  dimension: suggested_sending_store_ending_on_hand_quantity {
    label: "Suggested Sending Store Ending On Hand Quantity"
    description: "The Sending Store resulting ending on hand quantity based on accepting and receiving the Suggested Total Transfer quantity"
    type: number
    sql: ${TABLE}.SUGGESTED_SENDING_STORE_ENDING_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: suggested_sending_store_combined_ending_on_hand_quantity {
    label: "Suggested Sending Store Combined Ending On Hand Quantity"
    description: "The Sending Store resulting Combined ending on hand quantity based on accepting and receiving the Suggested Total Transfer quantity"
    type: number
    sql: ${TABLE}.SUGGESTED_SENDING_STORE_COMBINED_ENDING_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: suggested_receiving_store_ending_on_hand_quantity {
    label: "Suggested Receiving Store Ending On Hand Quantity"
    description: "The Receiving Store resulting ending on hand quantity based on accepting and receiving the Suggested Total Transfer quantity"
    type: number
    sql: ${TABLE}.SUGGESTED_RECEIVING_STORE_ENDING_ON_HAND_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: distance_in_miles_between_stores {
    label: "Distance In Miles Between Stores"
    description: "The distance in miles between the Sending store and the Receiving store"
    type: number
    sql: ${TABLE}.DISTANCE_IN_MILES_BETWEEN_STORES;;
  }

  dimension: invoice_transfer_record_flag {
    label: "Invoice Transfer Record Flag"
    description: "Yes/No flag indicating if the transfer record was the 'Best' case transfer for this drug."
    type: yesno
    sql: ${TABLE}.INVOICE_TRANSFER_RECORD_FLAG = 'Y' ;;
  }

  dimension_group: edw_insert_timestamp {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension: invoice_number {
    label: "Invoice Number"
    description: "Invoice Number is a String concatenation of the (1) Transfer Type, (2) Chain ID, and (3) a Unique identifier that is a 7 digit number."
    type: string
    sql: ${TABLE}.INVOICE_NUMBER ;;
  }

  dimension: sending_store_transfer_drug_acquisition_cost {
    label: "Sending Store Transfer Drug Acquisition Cost"
    description: "Acquisition Cost of the drug for the suggested transfer"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_TRANSFER_DRUG_ACQUISITION_COST ;;
  }

  dimension: sending_store_transfer_drug_acquisition_unit_cost {
    label: "Sending Store Transfer Drug Acquisition Unit Cost"
    description: "Acquisition Unit Cost of the drug for the suggested transfer"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_TRANSFER_DRUG_ACQUISITION_UNIT_COST ;;
  }

  dimension: sending_store_transfer_drug_package_size {
    label: "Sending Store Transfer Drug Package Size"
    description: "Package Size of the drug for the suggested transfer"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_TRANSFER_DRUG_PACKAGE_SIZE ;;
  }

  dimension: sending_store_order_point_ndc_package_size {
    label: "Sending Store Order Point Ndc Package Size"
    description: "The Sending Store Package Size for the Parent Order Point NDC"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ORDER_POINT_NDC_PACKAGE_SIZE ;;
  }

  dimension: sending_store_transfer_drug_individual_container_pack {
    label: "Sending Store Transfer Drug Individual Container Pack"
    description: "Individual Container Pack of the drug for the suggested transfer"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_TRANSFER_DRUG_INDIVIDUAL_CONTAINER_PACK ;;
  }

  dimension: sending_store_combined_on_hand_fragmented_quantity {
    label: "Sending Store Combined On Hand Fragmented Quantity"
    description: "The Sending Store Fragmented Quantity for the Order Point group"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_COMBINED_ON_HAND_FRAGMENTED_QUANTITY ;;
  }

  dimension: sending_store_on_hand_overstock_quantity {
    label: "Sending Store On Hand Overstock Quantity"
    description: "The quantity of On Hand for a Drug that is Overstock at the Sending Store"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ON_HAND_OVERSTOCK_QUANTITY ;;
  }

  dimension: sending_store_combined_overstock_quantity {
    label: "Sending Store Combined Overstock Quantity"
    description: "The Sending Store Overstock Quantity for the Order Point group"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_COMBINED_OVERSTOCK_QUANTITY ;;
  }

  dimension: receiving_store_drug_package_size {
    label: "Receiving Store Drug Package Size"
    description: "The receiving Store Package Size for the NDC"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_DRUG_PACKAGE_SIZE ;;
  }

  dimension: receiving_store_order_point_ndc_package_size {
    label: "Receiving Store Order Point Ndc Package Size"
    description: "The Receiving Store Package Size for the Parent Order Point NDC"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_ORDER_POINT_NDC_PACKAGE_SIZE ;;
  }

  dimension: receiving_store_drug_reorder_order_point {
    label: "Receiving Store Drug Reorder Order Point"
    description: "Order Point for Drug Reorder"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_DRUG_REORDER_ORDER_POINT ;;
  }

  dimension: receiving_store_starting_on_hand_quantity {
    label: "Receiving Store Starting On Hand Quantity"
    description: "The current state, starting on hand quantity of the drug at the Receiving Store prior to the Transfer"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_STARTING_ON_HAND_QUANTITY ;;
  }

  dimension: receiving_store_combined_starting_on_hand_quantity {
    label: "Receiving Store Combined Starting On Hand Quantity"
    description: "The current state, starting on hand quantity of the drug at the Sending Store prior to the Transfer"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_COMBINED_STARTING_ON_HAND_QUANTITY ;;
  }

  dimension: receiving_store_allocated_quantity {
    label: "Receiving Store Allocated Quantity"
    description: "The Receiving Store Allocated Quantity for an individual NDC"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_ALLOCATED_QUANTITY ;;
  }

  dimension: receiving_store_combined_allocated_quantity {
    label: "Receiving Store Combined Allocated Quantity"
    description: "The Receiving Store 'Combined' Allocated Quantity for an individual NDC"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_COMBINED_ALLOCATED_QUANTITY ;;
  }

  dimension: receiving_store_drug_order_not_received_quantity {
    label: "Receiving Store Drug Order Not Received Quantity"
    description: "The quantity of units for a Drug that has an active order in progress, and the order has not yet been received. The Drug Order Quantity is summed."
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_DRUG_ORDER_NOT_RECEIVED_QUANTITY ;;
  }

  dimension: receiving_store_combined_drug_order_not_received_quantity {
    label: "Receiving Store Combined Drug Order Not Received Quantity"
    description: "For the Combined OPNDC Group; The quantity of units for a Drug that has an active order in progress, and the order has not yet been received. The Drug Order Quantity is summed."
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_COMBINED_DRUG_ORDER_NOT_RECEIVED_QUANTITY ;;
  }

  dimension: suggested_fragmented_transfer_quantity {
    label: "Suggested Fragmented Transfer Quantity"
    description: "The Suggested Partial Package Transfer quantity of On Hand based on the Sending store Available for Transfer quantity, and the Receiving stores on hand quantity, for Partial Package quantities"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SUGGESTED_FRAGMENTED_TRANSFER_QUANTITY ;;
  }

  dimension: suggested_overstock_transfer_quantity {
    label: "Suggested Overstock Transfer Quantity"
    description: "The Suggested Overstock Transfer quantity is the resulting quantity when the transfer amount resulted in Overstock at the Receiving store, and the available for transfer amount was modified. (Sending store Available for Transfer quantity + the Receiving stores on hand quantity)"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SUGGESTED_OVERSTOCK_TRANSFER_QUANTITY ;;
  }

  dimension: suggested_receiving_store_combined_ending_on_hand_quantity {
    label: "Suggested receiving store combined ending on hand quantity"
    description: "The Receiving Store resulting Combined ending on hand quantity based on accepting and receiving the Suggested Total Transfer quantity"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SUGGESTED_RECEIVING_STORE_COMBINED_ENDING_ON_HAND_QUANTITY ;;
  }


############################################################ END OF DIMENSIONS ############################################################

  measure: sending_store_activity_period_units_sold {
    label: "Sending Store Activity Period Units Sold"
    description: "The quantity of Drug Units Sold during the Sending Stores Activity Period"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_UNITS_SOLD ;;
  }

  measure: sending_store_activity_period_combined_units_sold {
    label: "Sending Store Activity Period Combined Units Sold"
    description: "The Sending Store Units Sold during the activity period for the Order Point group"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ACTIVITY_PERIOD_COMBINED_UNITS_SOLD ;;
  }

  measure: sending_store_on_hand_available_transfer_quantity {
    label: "Sending Store On Hand Available Transfer Quantity"
    description: "The Quantity of On Hand Inventory at the Sending Store that is available for Transfer. This is based on Dead Inventory, Overstock, and Fragmented Inventory conditions"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ON_HAND_AVAILABLE_TRANSFER_QUANTITY ;;
  }

  measure: sending_store_on_hand_available_transfer_cost {
    label: "Sending Store On Hand Available Transfer Cost"
    description: "The Cost of  the On Hand Inventory at the Sending Store that is available for Transfer. This is based on Dead Inventory, Overstock, and Fragmented Inventory conditions"
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.SENDING_STORE_ON_HAND_AVAILABLE_TRANSFER_COST ;;
  }

  measure: receiving_store_activity_period_units_sold {
    label: "Receiving Store Activity Period Units Sold"
    description: "The quantity of Drug Units Sold during the Receiving Stores Activity Period"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_UNITS_SOLD ;;
  }

  measure: receiving_store_activity_period_combined_units_sold {
    label: "Receiving Store Activity Period Combined Units Sold"
    description: "The Receiving Store Units Sold during the activity period for the Order Point group"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.RECEIVING_STORE_ACTIVITY_PERIOD_COMBINED_UNITS_SOLD ;;
  }

  measure: suggested_total_transfer_quantity {
    label: "Suggested Total Transfer Quantity"
    description: "The Suggested Total Transfer quantity of On Hand based on the Sending store Available for Transfer quantity, and the Receiving stores on hand quantity."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.SUGGESTED_TOTAL_TRANSFER_QUANTITY ;;
  }

  measure: suggested_total_transfer_cost {
    label: "Suggested Total Transfer Cost"
    description: "The Suggested Total Transfer cost of On Hand based on the Sending store Available for Transfer , and the Receiving stores on hand."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.SUGGESTED_TOTAL_TRANSFER_COST ;;
  }

  measure: count {
    label: "Total Suggested Transfer Drug Count"
    description: "Total count of unfiltered records suggested by a Transfer Event. This includes matched suggested Transfer possibilities by the Transfer Event that were not included on a Final Invoice due to Algorithm filtering."
    type: count
    value_format: "#,##0"
  }

  measure: sending_store_count {
    label: "Total Sending Stores"
    description: "Total count of the NHIN_STORE_ID initiating the transfer."
    type: count_distinct
    sql:  ${sending_store_id} ;;
    value_format: "#,##0"
  }

  measure: receiving_store_count {
    label: "Total Receiving Stores"
    description: "Total count of the NHIN_STORE_ID reveiving the transfer."
    type: count_distinct
    sql:  ${receiving_store_id} ;;
    value_format: "#,##0"
  }

############################################################ END OF MEASURES ############################################################

}

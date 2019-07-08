view: turnrx_transfer_task_event {
  label: "Transfer Task Event"
  sql_table_name: EDW.F_TRANSFER_TASK_EVENT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${group_code} || '@' || ${event_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: group_code {
    label: "Group Code"
    description: "Group code given to the store group by the user"
    type: string
    hidden: yes
    sql: ${TABLE}.GROUP_CODE ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

########################################################################################################################

  dimension: transfer_type {
    label: "Transfer Type"
    description: "Indicates which type of Transfer the event and group was for"
    type: string
    sql: ${TABLE}.TRANSFER_TYPE ;;
  }

  dimension: transfer_task_event_status {
    label: "Transfer Task Event Status"
    description: "The status of the Transfer Task Event based on Active Invoices sent to stores. If there are active Invoices in progress, the Transfer Task Event will remain active. If a Chain Admin runs the Transfer as a 'What If' and never sends the Invoices to the stores, a Transfer Event will 'Expire'. "
    type: string
    sql: CASE WHEN ${TABLE}.TRANSFER_TASK_EVENT_STATUS = 'A' THEN 'A - ACTIVE'
              WHEN ${TABLE}.TRANSFER_TASK_EVENT_STATUS = 'E' THEN 'E - EXPIRED'
              WHEN ${TABLE}.TRANSFER_TASK_EVENT_STATUS = 'C' THEN 'C - COMPLETED'
              ELSE TO_CHAR(${TABLE}.TRANSFER_TASK_EVENT_STATUS)
         END ;;
    suggestions: ["A - ACTIVE", "E - EXPIRED", "C - COMPLETED"]
  }

  dimension: transfer_task_event_sent_to_stores_flag {
    label: "Transfer Task Event Sent To Stores Flag"
    description: "Yes/No flag indicating if the results of the transfer event have been sent to stores. Transfer events can be scheduled as a 'What If' event, meaning, the results were not transmitted to pharmacies automatically, review was performed by a Chain Admin prior to sending Transfers to stores."
    type: yesno
    sql: ${TABLE}.TRANSFER_TASK_EVENT_SENT_TO_STORES_FLAG = 'Y' ;;
  }

  dimension_group: transfer_task_event_expiration_date {
    label: "Transfer Task Event Expiration"
    description: "Timestamp that will be utilized to disable the Transfer Event from being able to be sent to Stores. If the Transfer Task Event is not sent the Same Day, within 4 hours, it cannot be sent to stores. A new Transfer Task Event must be created through Task Settings."
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.TRANSFER_TASK_EVENT_EXPIRATION_DATE ;;
  }

  dimension_group: edw_insert_timestamp {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW"
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension: transfer_task_event_total_sending_stores_count {
    label: "Transfer Task Event Total Sending Stores Count"
    description: "The total count of Sending Stores that have Invoices to be sent to stores for the Transfer Task Event at grain (chain_id, group_code, event_id)"
    type: number
    value_format: "#,##0;(#,##0)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_SENDING_STORES_COUNT ;;
  }

  dimension: transfer_task_event_total_receiving_stores_count {
    label: "Transfer Task Event Total Receiving Stores Count"
    description: "The total count of Receiving Stores that have Invoices to be sent to stores for the Transfer Task Event at grain (chain_id, group_code, event_id)"
    type: number
    value_format: "#,##0;(#,##0)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_RECEIVING_STORES_COUNT ;;
  }

  dimension: transfer_task_event_total_invoice_count {
    label: "Transfer Task Event Total Invoice Count"
    description: "The total count of Invoices to be sent to stores for the Transfer Task Event"
    type: number
    value_format: "#,##0;(#,##0)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_INVOICE_COUNT ;;
  }

  dimension: transfer_task_event_total_drug_count {
    label: "Transfer Task Event Total Drug Count"
    description: "The total count of Drugs that belong to an Invoice to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "#,##0;(#,##0)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_DRUG_COUNT ;;
  }

  dimension: transfer_task_event_total_drug_unit_quantity {
    label: "Transfer Task Event Total Drug Unit Quantity"
    description: "The total count of Drug Units that belong to an Invoice to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_DRUG_UNIT_QUANTITY ;;
  }

  dimension: transfer_task_event_total_invoice_dollar_value {
    label: "Transfer Task Event Total Invoice Dollar Value"
    description: "The total Dollar Amount of Invoices to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_INVOICE_DOLLAR_VALUE ;;
  }

  dimension: transfer_task_event_total_dead_inventory_amount {
    label: "Transfer Task Event Total Dead Inventory Amount"
    description: "The total Dollar Amount of Dead Inventory identified and suggested as a Transfer Invoice to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_DEAD_INVENTORY_AMOUNT ;;
  }

  dimension: transfer_task_event_total_fragmented_inventory_amount {
    label: "Transfer Task Event Total Fragmented Inventory Amount"
    description: "The total Dollar Amount of Fragmented Inventory identified and suggested as a Transfer Invoice to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_FRAGMENTED_INVENTORY_AMOUNT ;;
  }

  dimension: transfer_task_event_total_overstock_inventory_amount {
    label: "Transfer Task Event Total Overstock Inventory Amount"
    description: "The total Dollar Amount of Overstock Inventory identified and suggested as a Transfer Invoice to be sent to stores, for the Transfer Task Event"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_TASK_EVENT_TOTAL_OVERSTOCK_INVENTORY_AMOUNT ;;
  }

############################################################ END OF DIMENSIONS ############################################################

  measure: count {
    label: "Total Transfer Event Count"
    description: "Total count of Transfer Events"
    type: count
    value_format: "#,##0"
  }

############################################################ END OF MEASURES ############################################################

}

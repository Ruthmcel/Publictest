view: turnrx_transfer_invoice {
  label: "Transfer Invoice"
  sql_table_name: EDW.F_TRANSFER_INVOICE ;;

  dimension: primary_key {
    description: "Unique Identification number."
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${invoice_number} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: invoice_number {
    label: "Invoice Number"
    description: "Invoice Number is a String concatenation of the (1) Transfer Type, (2) Chain ID, and (3) a Unique identifier that is a 7 digit number."
    type: string
    hidden: yes
    sql: ${TABLE}.INVOICE_NUMBER ;;
  }

#########################################################################################################################################

  dimension: sending_store_id {
    label: "Sending Store Identifier"
    description: "The identifier of the Sending Store for the Transfer Invoice."
    type: number
    sql: ${TABLE}.SENDING_STORE_IDENTIFIER ;;
  }

  dimension: receiving_store_id {
    label: "Receiving Store Identifier"
    description: "The identifier of the Receiving Store for the Transfer Invoice."
    type: number
    sql: ${TABLE}.RECEIVING_STORE_IDENTIFIER ;;
  }

  dimension: transfer_invoice_status {
    label: "Transfer Invoice Status"
    description: "The status of the Invoice based on actions by users in Turn Rx and Facilities / Pharmacies. Turn Rx will update the status as processing occurs."
    type: string
    sql: ${TABLE}.TRANSFER_INVOICE_STATUS ;;
    suggestions: ["PRE-APPROVAL", "PENDING", "SHIPPED", "DECLINED", "EXPIRED", "RECEIVED", "DISPUTED", "CANCELED", "RESOLVED"]
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW."
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
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
    description: "The time at which the record is updated to EDW."
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW."
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: transfer_invoice_sent_to_store_timestamp {
    label: "Transfer Invoice Sent To Store"
    description: "The timestamp of when the Transfer Invoice was sent to stores to be processed."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.TRANSFER_INVOICE_SENT_TO_STORE_TIMESTAMP ;;
  }

  dimension_group: transfer_invoice_sending_store_received_timestamp {
    label: "Transfer Invoice Sending Store Received"
    description: "The timestamp of when the Transfer Invoice was received by the Sending Store to be processed."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.TRANSFER_INVOICE_SENDING_STORE_RECEIVED_TIMESTAMP ;;
  }

  dimension_group: transfer_invoice_receiving_store_received_timestamp {
    label: "Transfer Invoice Receiving Store Received"
    description: "The timestamp of when the Transfer Invoice was received by the Receiving Store to be processed."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.TRANSFER_INVOICE_RECEIVING_STORE_RECEIVED_TIMESTAMP ;;
  }

  dimension_group: transfer_invoice_expiration_date {
    label: "Transfer Invoice Expiration"
    description: "The date of when the Transfer Invoice will expire. The Invoice would expire when the CURRENT_DATE is equal to the INVOICE_EXPIRATION_DATE INVOICE_EXPIRATION_DATE should be CURRENT_DATE () + 7 from each actionable event on the INVOICE up to the SHIPPED status. Once SHIPPED, the INVOICE cannot expire, it must be received or disputed."
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.TRANSFER_INVOICE_EXPIRATION_DATE ;;
  }

  dimension: transfer_invoice_adjustment_performed_by_role_flag {
    label: "Transfer Invoice Adjustment Performed By Role Flag"
    description: "The role that denied the Transfer Invoice."
    type: string
    sql: ${TABLE}.TRANSFER_INVOICE_ADJUSTMENT_PERFORMED_BY_ROLE_FLAG;;
  }

  dimension: transfer_adjustment_reason_id {
    label: "Transfer Adjustment Reason Id"
    description: "ID of the Adjustment Reason for Transfers."
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_ID ;;
  }

  dimension: transfer_invoice_total_active_drug_count {
    label: "Transfer Invoice Total Active Drug Count"
    description: "The total number of active or completed Drugs present on the Turn Rx Transfer Invoice"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_DRUG_COUNT ;;
  }

  dimension: transfer_invoice_total_active_drug_unit_quantity {
    label: "Transfer Invoice Total Active Drug Unit Quantity"
    description: "The total dollar quantity of active or completed drug units present on the Turn Rx Transfer Invoice"
    type: number
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_DRUG_UNIT_QUANTITY ;;
  }

  dimension: transfer_invoice_total_active_dollar_value {
    label: "Transfer Invoice Total Active Dollar Value"
    description: "The total dollar amount of active or completed drugs present on the Turn Rx Transfer Invoice"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_DOLLAR_VALUE ;;
  }

  dimension: transfer_invoice_total_active_dead_inventory_value {
    label: "Transfer Invoice Total Active Dead Inventory Value"
    description: "The total Dollar Amount of active and completed drugs present on the Turn Rx Transfer Invoice, for Dead Inventory identified Transfers"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_DEAD_INVENTORY_VALUE ;;
  }

  dimension: transfer_invoice_total_active_fragmented_inventory_value {
    label: "Transfer Invoice Total Active Fragmented Inventory Value"
    description: "The total Dollar Amount of active and completed drugs present on the Turn Rx Transfer Invoice, for Fragmented Inventory identified Transfers"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_FRAGMENTED_INVENTORY_VALUE ;;
  }

  dimension: transfer_invoice_total_active_overstock_inventory_value {
    label: "Transfer Invoice Total Active Overstock Inventory Value"
    description: "The total Dollar Amount of active and completed drugs present on the Turn Rx Transfer Invoice, for Overstock Inventory identified Transfers"
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_TOTAL_ACTIVE_OVERSTOCK_INVENTORY_VALUE ;;
  }

  ##TRX-5708 Week End date##
    dimension: edw_last_update_week_end_date {
    label: "EDW Last Update Week End Date"
    group_label: "Week End"
    description: "The Week end date at which the record is updated to EDW."
    hidden: no
    type: date
    sql:  dateadd('day', -1, last_day(to_date( dateadd('day', 1, ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP)), 'week')) ;;
  }

  ##TRX-5708  Week End date##
  dimension: transfer_invoice_receiving_store_received_week_end_date {
    label: "Transfer Invoice Receiving Store Received Week End Date"
    group_label: "Week End"
    description: "The week end date when the Transfer Invoice was received by the Receiving Store to be processed."
    hidden: no
    type: date
    sql:  dateadd('day', -1, last_day(to_date( dateadd('day', 1, ${TABLE}.TRANSFER_INVOICE_RECEIVING_STORE_RECEIVED_TIMESTAMP)), 'week')) ;;
  }

  dimension_group: transfer_invoice_ship_by {
    label: "Transfer Invoice Ship By"
    description: "The date when the Transfer Invoice will expire if it has not been processed and shipped."
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.TRANSFER_INVOICE_SHIP_BY_DATE ;;
  }
############################################################ END OF DIMENSIONS ############################################################

  measure: count {
    label: "Total Transfer Invoice Count"
    description: "Total count of Invoices created by a Transfer Event"
    type: count
    value_format: "#,##0"
  }
}

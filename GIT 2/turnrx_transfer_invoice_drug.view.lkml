view: turnrx_transfer_invoice_drug {
  label: "Transfer Invoice Drug"
  sql_table_name: EDW.F_TRANSFER_INVOICE_DRUG ;;

  dimension: primary_key {
    description: "Unique Identification number."
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${invoice_number} || '@' || ${transfer_drug_ndc} ;;
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
    sql: ${TABLE}.INVOICE_NUMBER ;;
  }

  dimension: transfer_drug_ndc {
    label: "Transfer Drug NDC"
    description: "The NDC of the drug for the suggested transfer"
    type: string
    sql: ${TABLE}.TRANSFER_DRUG_NDC ;;
  }

  dimension: transfer_invoice_drug_receiving_store_order_point_ndc {
    label: "Transfer Invoice Drug Receiving Store Order Point NDC"
    description: "The NDC of the drug for the suggested transfer"
    type: string
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_RECEIVING_STORE_ORDER_POINT_NDC ;;
  }

  dimension: transfer_invoice_drug_status {
    label: "Transfer Invoice Drug Status"
    description: "The status of the drug on a Transfer Invoice. This will drive whether it shows up in the UI or not. This is updated by the application if a user removes a drug from an Invoice, if an Invoice is completed, or if the Invoice as a whole is declined"
    type: string
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_STATUS;;
    suggestions: ["ACTIVE","COMPLETED", "DISPUTED", "EXPIRED", "RECEIVED","REMOVED"]
  }

  dimension: transfer_invoice_drug_adjustment_performed_by_role_flag {
    label: "Transfer Invoice Drug Adjustment Performed By Role Flag"
    description: "The role that denied / removed a Drug NDC from a Transfer Invoice, or denied / removed the entire Invoice."
    type: string
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTMENT_PERFORMED_BY_ROLE_FLAG;;
  }

  dimension_group: transfer_invoice_drug_adjustment_hold_until_date {
    label: "Transfer Invoice Drug Adjustment Hold Until"
    description: "The Date that the Drug is ineligible for Transfers until. Date is set based on adjustment reasons populated by the Turn Rx user processing the Transfer"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTMENT_HOLD_UNTIL_DATE ;;
  }

  dimension: transfer_adjustment_reason_id {
    label: "Transfer Adjustment Reason Id"
    description: "ID of the Adjustment Reason for Transfers"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_ID ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
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

############################################################ END OF DIMENSIONS ############################################################

  measure: transfer_invoice_drug_original_transfer_quantity {
    label: "Transfer Invoice Drug Original Transfer Quantity"
    description: "The original Transfer Quantity of the drug, populated by the Turn Rx Transfer Event, prior to any adjustments"
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ORIGINAL_TRANSFER_QUANTITY ;;
  }

  measure: transfer_invoice_drug_original_transfer_cost {
    label: "Transfer Invoice Drug Original Transfer Cost"
    description: "The original Transfer Cost of the drug, populated by the Turn Rx Transfer Event, prior to any adjustments"
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ORIGINAL_TRANSFER_COST ;;
  }

  measure: transfer_invoice_drug_manual_entered_on_hand_quantity {
    label: "Transfer Invoice Drug Manual Entered On Hand Quantity"
    description: "The Manually entered On Han Quantity of the Drug, populated by a user in Turn Rx during the Transfer process."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_MANUAL_ENTERED_ON_HAND_QUANTITY ;;
  }

  measure: transfer_invoice_drug_adjusted_transfer_quantity {
    label: "Transfer Invoice Drug Adjusted Transfer Quantity"
    description: "The Manually entered adjusted Transfer Quantity of the drug, populated by a user in Turn Rx during the Transfer process."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTED_TRANSFER_QUANTITY ;;
  }

  measure: transfer_invoice_drug_adjusted_transfer_cost {
    label: "Transfer Invoice Drug Adjusted Transfer Cost"
    description: "The adjusted Transfer cost due to a user adjusting the Transfer quantity."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTED_TRANSFER_COST ;;
  }

  measure: transfer_invoice_drug_disputed_transfer_quantity {
    label: "Transfer Invoice Drug disputed transfer quantity"
    description: "The quantity of DISPUTED Transfers units of the drug, calculated based on the populated Transfer Quantity by a user in Turn Rx during the Transfer process at the Receiving Store ONLY. "
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_DISPUTED_TRANSFER_QUANTITY ;;
  }

  measure: transfer_invoice_drug_disputed_transfer_cost {
    label: "Transfer Invoice Drug disputed Transfer Cost"
    description: "The Disputed Transfer cost due to a user adjusting the Transfer quantity at the Receiving store ONLY."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.TRANSFER_INVOICE_DRUG_DISPUTED_TRANSFER_COST ;;
  }

############################################################ END OF MEASURES ############################################################

  measure: count {
    label: "Total Transfer Invoice Drug Count"
    description: "Total count of drug records suggested by a Transfer Event, and included on a Transfer Invoice due to being chosen by the Transfer Algorithm logic."
    type: count
    value_format: "#,##0"
  }

#TRX-5754
  measure: total_transfer_invoice_drug_dollar_amount {
    label: "Total Transfer Invoice Drug Dollar Amount"
    description: "The current state total dollar amount of the transfer drug, including any adjustments."
    type: sum
    sql: NVL(${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTED_TRANSFER_COST, ${TABLE}.TRANSFER_INVOICE_DRUG_ORIGINAL_TRANSFER_COST) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: total_transfer_invoice_drug_quantity {
    label: "Total Transfer Invoice Drug Quantity"
    description: "The current state total quantity of the transfer drug in units, including any adjustments."
    type: sum
    sql: NVL(${TABLE}.TRANSFER_INVOICE_DRUG_ADJUSTED_TRANSFER_QUANTITY, ${TABLE}.TRANSFER_INVOICE_DRUG_ORIGINAL_TRANSFER_QUANTITY) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

}

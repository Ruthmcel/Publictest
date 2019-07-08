#ERXLPS-2789

view: store_rx_tx_credit {
  label: "Prescription Transaction Credit"
  sql_table_name: EDW.F_STORE_RX_TX_CREDIT ;;

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    label: "Prescription Transaction ID"
    description: "Unique Id number identifying this record"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_rx_tx_credit_unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ;;
  }
  ######################## END OF PK/FK REFRENCES ########################


  dimension: store_rx_tx_credit_original_tx_number {
    label: "Prescription Credit Original Transaction Number "
    type: string
    description: "Transaction number of original transaction being credited/New transaction number created. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_TX_NUMBER ;;
  }

  dimension: store_rx_tx_credit_returned_date {
    label: "Transaction Credit Returned"
    type: date
    hidden: yes
    description: "Date/Time of transaction credit returned. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_RETURNED_DATE ;;
  }

  dimension: store_rx_tx_credit_returned_time {
    label: "Transaction Credit Returned"
    type: date_time
    hidden: yes
    description: "Time of transaction credit returned. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_RETURNED_TIME ;;
  }

  dimension: store_rx_tx_credit_initials {
    label: "Prescription Transaction Credit Initials"
    type: string
    description: "Initials of user doing the credit return. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_INITIALS ;;
  }

  dimension: store_rx_tx_credit_original_quantity {
    label: "Prescription Transaction Credit Original Quantity"
    type: number
    description: "Prescription credited original quantity. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_QUANTITY ;;
  }

  dimension: store_rx_tx_credit_original_price_amount {
    label: "Prescription Transaction Credit Original Price"
    type: number
    description: "Prescription credited original price amount. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_PRICE_AMOUNT ;;

  }

  dimension: store_rx_tx_credit_reversed_date {
    label: "Store Prescription Transaction Credit Reversal"
    type: date
    description: "Date the claim reversal was transmitted and accepted. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_REVERSED_DATE ;;
  }

  dimension: store_rx_tx_credit_initiator_flag {
    label: "Store Transaction Credit Initiator Flag"
    type: string
    description: "Yes/No Flag indicating credit being created via pharmacy or nursing home. PDX Classic Table: TXCRD"
    sql: CASE  WHEN ${TABLE}.STORE_RX_TX_CREDIT_INITIATOR_FLAG = 'N' THEN 'CREDITED VIA NURSING HOME'
               WHEN ${TABLE}.STORE_RX_TX_CREDIT_INITIATOR_FLAG = 'Y' THEN 'CREDITED VIA PHARMACY'
         END;;
  }

  dimension: store_rx_tx_credit_deleted_flag {
    label: "Store Transaction Credit Deleted Flag"
    type: string
    description: "Yes/No Flag indicating transaction credit being deleted. PDX Classic Table: TXCRD"
    sql: CASE  WHEN ${TABLE}.STORE_RX_TX_CREDIT_DELETED_FLAG = 'N' THEN 'TRANSACTION CREDIT NOT DELETED'
               WHEN ${TABLE}.STORE_RX_TX_CREDIT_DELETED_FLAG = 'Y' THEN 'TRANSACTION CREDIT DELETED'
         END;;
  }

  dimension: store_rx_tx_credit_original_discount_amount {
    label: "Prescription Transaction Credited Original Discount Amount"
    type: number
    description: "Prescription transaction credited original discount amount. PDX Classic Table: TXCRD"
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_DISCOUNT_AMOUNT ;;
  }

  dimension: store_rx_tx_credit_submitted_to_prescription_monitoring_program {
    label: "Store Transaction Credit Submitted to PMP"
    type: string
    description: "Y/N Flag indicating Transaction Credit to PMP: PDX Classic Table: TXCRD"
    sql: CASE WHEN ${TABLE}.STORE_RX_TX_CREDIT_SUBMITTED_TO_PRESCRIPTION_MONITORING_PROGRAM = 'N' THEN 'TRANSACTION CREDIT IGNORED'
              WHEN ${TABLE}.STORE_RX_TX_CREDIT_SUBMITTED_TO_PRESCRIPTION_MONITORING_PROGRAM = 'Y' THEN 'TRANSACTION CREDIT SUBMITTED'
              WHEN ${TABLE}.STORE_RX_TX_CREDIT_SUBMITTED_TO_PRESCRIPTION_MONITORING_PROGRAM is null THEN 'TRANSACTION CREDIT NOT SUBMITTED'
              ELSE ${TABLE}.STORE_RX_TX_CREDIT_SUBMITTED_TO_PRESCRIPTION_MONITORING_PROGRAM --Added else condition to display DB value if master code values are not available.
         END;;
  }
  #   - dimension: returned_date
  #     sql: ${TABLE}.RX_TX_CRED_RETURNED_DATE

  dimension_group: store_rx_tx_credit_returned_timestamp {
    label: "Prescription Credit Returned"
    description: "Date/Time the transaction was credit returned"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.STORE_RX_TX_CREDIT_RETURNED_TIMESTAMP ;;
  }

  ######################## END OF DIMENSIONS ########################

  measure: rx_tx_cred_count {
    label: "Prescription Credit Returns Count"
    type: count
    value_format: "#,##0"
  }

  measure: sum_original_price {
    label: "Prescription Credit Returned Original Amount"
    type: sum
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_PRICE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_original_price {
    label: "Prescription Credit Returned Original Amount - Average"
    type: average
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_PRICE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_original_qty {
    label: "Prescription Credit Returned Original Qty"
    type: sum
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: avg_original_qty {
    label: "Prescription Credit Returned Original Qty - Average"
    type: average
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_QUANTITY ;;
    value_format: "#,##0.00"
  }
  measure: sum_original_discount_amount {
    label: "Prescription Credit Returned Original Discount Amount"
    type: sum
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_DISCOUNT_AMOUNT;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: avg_original_discount_amount {
    label: "Prescription Credit Returned Original Discount Amount - Average"
    type: average
    sql: ${TABLE}.STORE_RX_TX_CREDIT_ORIGINAL_DISCOUNT_AMOUNT;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

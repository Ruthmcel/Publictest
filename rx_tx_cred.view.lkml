view: rx_tx_cred {
  sql_table_name: EDW.F_RX_TX_CRED ;;

  dimension: chain_id {
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    sql: ${TABLE}.NHIN_ID ;;
  }

  dimension: rx_tx_cred_id {
    hidden: yes
    sql: ${TABLE}.RX_TX_CRED_ID ;;
  }

  dimension: rx_tx_cred_unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${rx_tx_cred_id} ;; #ERXLPS-1649
  }

  dimension: rx_tx_id {
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_tx_cred_deleted {
    hidden: yes
    sql: ${TABLE}.RX_TX_CRED_DELETED ;;
  }

  dimension: tx_cred_user_initials {
    label: "Prescription TX Cred User Initials"
    description: "Initials of the user that preformed the credit return"
    sql: ${TABLE}.RX_TX_CRED_INITIALS ;;
  }

  dimension: original_tx_number {
    label: "Prescription Original TX Number"
    description: "Original TX number of the prescription before the credit return was performed"
    sql: ${TABLE}.RX_TX_CRED_ORIGINAL_TX_NUMBER ;;
  }

  #   - dimension: returned_date
  #     sql: ${TABLE}.RX_TX_CRED_RETURNED_DATE

  dimension_group: returned {
    label: "Prescription Credit Returned"
    description: "Date the transaction was credit returned"
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
    sql: ${TABLE}.RX_TX_CRED_RETURNED_DATE ;;
  }

  #   - dimension: reversed_date
  #     sql: ${TABLE}.RX_TX_CRED_REVERSED_DATE

  dimension_group: reversed {
    label: "Prescription Credit Reversed"
    description: "Date the transaction was reversed"
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
    sql: ${TABLE}.RX_TX_CRED_REVERSED_DATE ;;
  }

  dimension: credit_flag {
    label: "Prescription Credit Flag"
    description: "Prescription Transaction Credit Return Module"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_CRED_RX_CREDIT_FLAG = 'Y' ;;
        label: "Pharmacy"
      }

      when: {
        sql: true ;;
        label: "Nursing Home"
      }
    }

    alpha_sort: no
    sql: ${TABLE}.RX_TX_CRED_RX_CREDIT_FLAG ;;
  }

  measure: rx_tx_cred_count {
    label: "Prescription Credit Returns Count"
    type: count
    value_format: "#,##0"
  }

  measure: sum_original_price {
    label: "Prescription Credit Returned Original Amount"
    type: sum
    sql: ${TABLE}.RX_TX_CRED_ORIGINAL_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_original_price {
    label: "Prescription Credit Returned Original Amount - Average"
    type: average
    sql: ${TABLE}.RX_TX_CRED_ORIGINAL_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_original_qty {
    label: "Prescription Credit Returned Original Qty"
    type: sum
    sql: ${TABLE}.RX_TX_CRED_ORIGINAL_QTY ;;
    value_format: "#,##0.00"
  }

  measure: avg_original_qty {
    label: "Prescription Credit Returned Original Qty - Average"
    type: average
    sql: ${TABLE}.RX_TX_CRED_ORIGINAL_QTY ;;
    value_format: "#,##0.00"
  }
}

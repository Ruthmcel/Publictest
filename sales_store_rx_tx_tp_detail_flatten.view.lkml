view: sales_store_rx_tx_tp_detail_flatten {
  sql_table_name: EDW.F_STORE_RX_TX_TP_DETAIL_FLATTEN ;;

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  #[ERXDWPS-6197] - source_system_id not added to PK. But the table has only EPS data. So added source_system_id to PK dimension and in joins.
  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id} ||'@'||${source_system_id} ;;
  }

  dimension: primary_tx_tp_response_detail_group_identifier {
    label: "Primary Payer Response Detail Group Identifier"
    description: "Primary Payer Response Detail Group ID returned from the insurance processor, assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PRIMARY_TX_TP_RESPONSE_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: primary_tx_tp_submit_detail_group_identifier {
    label: "Primary Payer Submit Detail Group Identifier"
    description: "Primary Payer Submit Detail Group ID assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PRIMARY_TX_TP_SUBMIT_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: secondary_tx_tp_response_detail_group_identifier {
    label: "Secondary Payer Response Detail Group Identifier"
    description: "Secondary Payer Response Detail Group ID returned from the insurance processor, assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.SECONDARY_TX_TP_RESPONSE_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: secondary_tx_tp_submit_detail_group_identifier {
    label: "Secondary Payer Submit Detail Group Identifier"
    description: "Secondary Payer Submit Detail Group ID assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.SECONDARY_TX_TP_SUBMIT_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: tertiary_tx_tp_response_detail_group_identifier {
    label: "Tertiary Payer Response Detail Group Identifier"
    description: "Tertiary Payer Response Detail Group ID returned from the insurance processor, assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TERTIARY_TX_TP_RESPONSE_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: tertiary_tx_tp_submit_detail_group_identifier {
    label: "Tertiary Payer Submit Detail Group Identifier"
    description: "Tertiary Payer Submit Detail Group ID assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TERTIARY_TX_TP_SUBMIT_DETAIL_GROUP_IDENTIFIER ;;
  }

  measure: sum_primary_tx_tp_response_detail_dispensing_fee_paid {
    label: "Primary Payer Response Detail Dispensing Fee Paid"
    description: "Primary Payer Response Detail Dispensing fee paid included in the 'Total Amount Paid' (509-F9) of transmit queue current record. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.PRIMARY_TX_TP_RESPONSE_DETAIL_DISPENSING_FEE_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_secondary_tx_tp_response_detail_dispensing_fee_paid {
    label: "Secondary Payer Response Detail Dispensing Fee Paid"
    description: "Secondary Payer Response Detail Dispensing fee paid included in the 'Total Amount Paid' (509-F9) of transmit queue current record. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.SECONDARY_TX_TP_RESPONSE_DETAIL_DISPENSING_FEE_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tertiary_tx_tp_response_detail_dispensing_fee_paid {
    label: "Tertiary Payer Response Detail Dispensing Fee Paid"
    description: "Tertiary Payer Response Detail Dispensing fee paid included in the 'Total Amount Paid' (509-F9) of transmit queue current record. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TERTIARY_TX_TP_RESPONSE_DETAIL_DISPENSING_FEE_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

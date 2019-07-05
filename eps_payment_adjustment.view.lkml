view: eps_payment_adjustment {
  label: "Payment adjustment"
  sql_table_name: EDW.F_PAYMENT_ADJUSTMENT ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${payment_adjustment_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    type: number
    label: "Chain ID"
    hidden: yes
    description: "Identification number assinged to each customer chain by NHIN."
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Nhin Store ID"
    hidden: yes
    description: "NHIN account number which uniquely identifies the store with NHIN."
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: payment_adjustment_id {
    type: number
    label: "Payment Adjustment ID"
    hidden: yes
    description: "Unique ID number identifying a Payment adjustment record."
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system."
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: payment_id {
    type: number
    label: "Payment ID"
    hidden: yes
    description: "Unique ID that links this record to a specific PAYMENT record."
    sql: ${TABLE}.PAYMENT_ID ;;
  }


  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################

  dimension: payment_adjustment_type {
    label: "Payment Adjustment Type"
    description: "Payment adjustment transaction type"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_ADJUSTMENT_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_ADJUSTMENT_TYPE') ;;
    suggestions: [
      "RETURN",
      "REVERSAL"
    ]
  }

  dimension: payment_adjustment_status {
    label: "Payment Adjustment Status"
    description: "Status of the payment adjustment"
    type: string
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_STATUS ;;
  }

  dimension_group: payment_adjustment_transmit {
    label: "Payment Adjustment Transmit"
    description: "Date/Time adjustment was transmitted to payment processor"
    type: time
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_TRANSMIT_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: payment_adjustment_response_code {
    label: "Payment Adjustment Response Code"
    description: "Response code received from payment processor"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_ADJUSTMENT_RESPONSE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_ADJUSTMENT_RESPONSE_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "APPROVED",
      "PARTIAL APPROVAL",
      "DECLINE",
      "EXPIRED CARD",
      "DUPLICATE APPROVED",
      "DUPLICATE",
      "PICK UP CARD",
      "REFERRAL/CALL ISSUER",
      "BALANCE NOT AVAILABLE",
      "NOT DEFINED",
      "INVALID DATA",
      "INVALID ACCOUNT",
      "INVALID REQUEST",
      "AUTHORIZATION FAILED",
      "NOT ALLOWED",
      "OUT OF BALANCE",
      "COMMUNICATION ERROR",
      "HOST ERROR",
      "ERROR"
    ]

  }

  dimension: payment_adjustment_response_message {
    label: "Payment Adjustment Response Message"
    description: "Response message received from payment processor"
    type: string
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_RESPONSE_MESSAGE ;;
  }

  measure: sum_payment_adjustment_amount {
    label: "Total Payment Adjustment Amount"
    description: "Total amount of the payment which was adjusted (reversed or returned)"
    type: sum
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: payment_adjustment_transaction_identifier {
    label: "Payment Adjustment Transaction Identifier"
    description: "Transaction id received from payment processor"
    type: string
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_TRANSACTION_IDENTIFIER ;;
  }

  dimension: payment_adjustment_approval_number {
    label: "Payment Adjustment Approval Number"
    description: "Approval number received from payment processor"
    type: string
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_APPROVAL_NUMBER ;;
  }

  dimension_group: payment_adjustment_settlement_send_pos {
    label: "Payment Adjustment Settlement Send Pos"
    description: "Date/Time when the transaction was marked as settled"
    type: time
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_SETTLEMENT_SEND_POS_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: payment_adjustment_settle {
    label: "Payment Adjustment Settle"
    description: "Date/Time financial agency settled the transaction"
    type: time
    sql: ${TABLE}.PAYMENT_ADJUSTMENT_SETTLE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: electronic_memo_id {
    label: "Electronic Memo Id"
    description: "Unique ID that links this record to a specific ELECTRONIC_MEMO record."
    hidden: yes
    type: number
    sql: ${TABLE}.ELECTRONIC_MEMO_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Payment adjustment Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis."
    hidden: yes
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  set: explore_rx_payment_adjustment_4_13_candidate_list {
    fields: [
      payment_adjustment_type,
      payment_adjustment_status,
      payment_adjustment_transmit_time,
      payment_adjustment_transmit_date,
      payment_adjustment_transmit_week,
      payment_adjustment_transmit_month,
      payment_adjustment_transmit_month_num,
      payment_adjustment_transmit_year,
      payment_adjustment_transmit_quarter,
      payment_adjustment_transmit_quarter_of_year,
      payment_adjustment_transmit,
      payment_adjustment_transmit_hour_of_day,
      payment_adjustment_transmit_time_of_day,
      payment_adjustment_transmit_hour2,
      payment_adjustment_transmit_minute15,
      payment_adjustment_transmit_day_of_week,
      payment_adjustment_transmit_day_of_month,
      payment_adjustment_response_code,
      payment_adjustment_response_message,
      sum_payment_adjustment_amount,
      payment_adjustment_transaction_identifier,
      payment_adjustment_approval_number,
      payment_adjustment_settlement_send_pos_time,
      payment_adjustment_settlement_send_pos_date,
      payment_adjustment_settlement_send_pos_week,
      payment_adjustment_settlement_send_pos_month,
      payment_adjustment_settlement_send_pos_month_num,
      payment_adjustment_settlement_send_pos_year,
      payment_adjustment_settlement_send_pos_quarter,
      payment_adjustment_settlement_send_pos_quarter_of_year,
      payment_adjustment_settlement_send_pos,
      payment_adjustment_settlement_send_pos_hour_of_day,
      payment_adjustment_settlement_send_pos_time_of_day,
      payment_adjustment_settlement_send_pos_hour2,
      payment_adjustment_settlement_send_pos_minute15,
      payment_adjustment_settlement_send_pos_day_of_week,
      payment_adjustment_settlement_send_pos_day_of_month,
      payment_adjustment_settle_time,
      payment_adjustment_settle_date,
      payment_adjustment_settle_week,
      payment_adjustment_settle_month,
      payment_adjustment_settle_month_num,
      payment_adjustment_settle_year,
      payment_adjustment_settle_quarter,
      payment_adjustment_settle_quarter_of_year,
      payment_adjustment_settle,
      payment_adjustment_settle_hour_of_day,
      payment_adjustment_settle_time_of_day,
      payment_adjustment_settle_hour2,
      payment_adjustment_settle_minute15,
      payment_adjustment_settle_day_of_week,
      payment_adjustment_settle_day_of_month
    ]
  }
}

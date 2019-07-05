view: eps_payment {
  label: "Payment"
  sql_table_name: EDW.F_PAYMENT ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${payment_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: payment_id {
    label: "Payment Id"
    description: "Unique Identification Value assigned for each PAYMENT record inserted into PAYMENT table"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: payment_type {
    label: "Payment Type"
    description: "Type of payment: credit card, cash, etc."
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_TYPE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "CHECK",
      "CREDIT CARD",
      "A/R",
      "MONEY ORDER",
      "CASHIER''S CHECK",
      "CASH"
    ]
  }

  dimension: payment_card_type {
    label: "Payment Card Type"
    description: "Type of credit card used for the payment"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_CARD_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_CARD_TYPE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "MASTER CARD (MC)",
      "VISA (VS)",
      "AMERICAN EXPRESS (AX)",
      "DISCOVER/NOVUS (NS)",
      "PRIVATE LABEL (PL)",
      "DINER''S CLUB (DC)",
      "MASTER CARD HSA",
      "VISA HSA"
    ]
  }

  dimension: payment_transmission_number {
    label: "Payment Transmission Number"
    description: "Unique transmission ID"
    type: string
    sql: ${TABLE}.PAYMENT_TRANSMISSION_NUMBER ;;
  }

  measure: sum_payment_amount {
    label: "Total Payment Amount"
    description: "Total amount charge to the credit card account in dollars and cents"
    type: sum
    sql: ${TABLE}.PAYMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_payment_tax_amount {
    label: "Total Payment Tax Amount"
    description: "Total tax charge to this credit card in this payment"
    type: sum
    sql: ${TABLE}.PAYMENT_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: payment_settle {
    label: "Payment Settle"
    description: "Date/Time the financial agency settled the transaction"
    type: time
    sql: ${TABLE}.PAYMENT_SETTLE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: payment_response_code {
    label: "Payment Response Code"
    description: "Code returned by payment engine declaring outcome of credit card payment request"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_RESPONSE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_RESPONSE_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "APPROVED",
      "REFERRAL",
      "CEILING",
      "DECLINED",
      "EXPIRED CARD",
      "NETWORK TIMEOUT",
      "FAILURE",
      "ERROR"
    ]
  }

  dimension: payment_response_message {
    label: "Payment Response Message"
    description: "Text message returned by payment engine with Response Code indicating outcome of credit card payment request"
    type: string
    sql: ${TABLE}.PAYMENT_RESPONSE_MESSAGE ;;
  }

  dimension: payment_authorization_code {
    label: "Payment Authorization Code"
    description: "Payment engine authorization code"
    type: string
    sql: ${TABLE}.PAYMENT_AUTHORIZATION_CODE ;;
  }

  measure: sum_payment_maximum_amount {
    label: "Payment Maximum Amount"
    description: "Total of the maximum amount  which can be charged to a particular credit card"
    type: sum
    sql: ${TABLE}.PAYMENT_MAXIMUM_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: payment_pre_authorization {
    label: "Payment Pre Authorization"
    description: "Date/Time EPS receives success response for credit card authorization request."
    type: time
    sql: ${TABLE}.PAYMENT_PRE_AUTHORIZATION_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: payment_check_number {
    label: "Payment Check Number"
    description: "Number of the check used for payment if payment type is check (or) Number of the money order used for payment if payment type is money order"
    type: string
    sql: ${TABLE}.PAYMENT_CHECK_NUMBER ;;
  }

  measure: sum_payment_authorized_amount {
    label: "Total Payment Authorized Amount"
    description: "Total amount for which EPS sends Credit Card Authorization request."
    type: sum
    sql: ${TABLE}.PAYMENT_AUTHORIZED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: payment_approval_number {
    label: "Payment Approval Number"
    description: "Issuer assigned approval number received in Credit Card Authorization response"
    type: string
    sql: ${TABLE}.PAYMENT_APPROVAL_NUMBER ;;
  }

  dimension: payment_authorization_transaction_id {
    label: "Payment Authorization Transaction Id"
    description: "Transaction id received from payment processor in Credit Card Authorization response"
    type: string
    sql: ${TABLE}.PAYMENT_AUTHORIZATION_TRANSACTION_ID ;;
  }

  dimension: payment_settlement_response_code {
    label: "Payment Settlement Response Code"
    description: "Response code received from payment processor in Credit Card Authorization Completion response"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_SETTLEMENT_RESPONSE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_SETTLEMENT_RESPONSE_CODE') ;;
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

  dimension: payment_settlement_response_message {
    label: "Payment Settlement Response Message"
    description: "Response message received from payment processor in Credit Card Authorization Completion response"
    type: string
    sql: ${TABLE}.PAYMENT_SETTLEMENT_RESPONSE_MESSAGE ;;
  }

  measure: sum_payment_settlement_amount {
    label: "Total Payment Settlement Amount"
    description: "Total amount for which EPS sends Credit Card Authorization Completion"
    type: sum
    sql: ${TABLE}.PAYMENT_SETTLEMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: payment_settlement_transaction_id {
    label: "Payment Settlement Transaction Id"
    description: "Transaction id received from payment processor for Credit Card Authorization Completion response"
    type: string
    sql: ${TABLE}.PAYMENT_SETTLEMENT_TRANSACTION_ID ;;
  }

  dimension: payment_settlement_approval_number {
    label: "Payment Settlement Approval Number"
    description: "Approval number received from payment processor for Credit Card Authorization Completion response"
    type: string
    sql: ${TABLE}.PAYMENT_SETTLEMENT_APPROVAL_NUMBER ;;
  }

  dimension: payment_writeoff_status {
    label: "Payment Writeoff Status"
    description: "The write off status of a payment when there is an amount still pending after settlement;  the payment requires management approval to write off the payment amount. "
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_WRITEOFF_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_WRITEOFF_STATUS') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PENDING",
      "APPROVED",
      "DECLINED"
    ]
  }

  dimension: payment_write_off_manager_employee_number {
    label: "Payment Write Off Manager Employee Number"
    description: "Employee number of the manager approving/denying a write-off payment"
    type: string
    sql: ${TABLE}.PAYMENT_WRITE_OFF_MANAGER_EMPLOYEE_NUMBER ;;
  }

  dimension_group: payment_settlement_send_pos {
    label: "Payment Settlement Send"
    description: "Date/Time when the transaction was marked as settled"
    type: time
    sql: ${TABLE}.PAYMENT_SETTLEMENT_SEND_POS_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: credit_card_id {
    label: "Credit Card Id"
    description: "CREDIT_CARD record."
    type: number
    hidden: yes
    sql: ${TABLE}.CREDIT_CARD_ID ;;
  }

  dimension: payment_type_id {
    label: "Payment Type Id"
    description: "Unique ID that links this record to a specific PAYMENT_TYPE record."
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_TYPE_ID ;;
  }

  dimension: payment_group_id {
    label: "Payment Group Id"
    description: "FK to the PAYMENT_GROUP record"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_GROUP_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Payment Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  set: explore_rx_payment_4_13_candidate_list {
    fields: [
      payment_type,
      payment_card_type,
      payment_transmission_number,
      sum_payment_amount,
      sum_payment_tax_amount,
      payment_settle_time,
      payment_settle_date,
      payment_settle_week,
      payment_settle_month,
      payment_settle_month_num,
      payment_settle_year,
      payment_settle_quarter,
      payment_settle_quarter_of_year,
      payment_settle,
      payment_settle_hour_of_day,
      payment_settle_time_of_day,
      payment_settle_hour2,
      payment_settle_minute15,
      payment_settle_day_of_week,
      payment_settle_day_of_month,
      payment_response_code,
      payment_response_message,
      payment_authorization_code,
      sum_payment_maximum_amount,
      payment_pre_authorization_time,
      payment_pre_authorization_date,
      payment_pre_authorization_week,
      payment_pre_authorization_month,
      payment_pre_authorization_month_num,
      payment_pre_authorization_year,
      payment_pre_authorization_quarter,
      payment_pre_authorization_quarter_of_year,
      payment_pre_authorization,
      payment_pre_authorization_hour_of_day,
      payment_pre_authorization_time_of_day,
      payment_pre_authorization_hour2,
      payment_pre_authorization_minute15,
      payment_pre_authorization_day_of_week,
      payment_pre_authorization_day_of_month,
      payment_check_number,
      sum_payment_authorized_amount,
      payment_approval_number,
      payment_authorization_transaction_id,
      payment_settlement_response_code,
      payment_settlement_response_message,
      sum_payment_settlement_amount,
      payment_settlement_transaction_id,
      payment_settlement_approval_number,
      payment_writeoff_status,
      payment_write_off_manager_employee_number,
      payment_settlement_send_pos_time,
      payment_settlement_send_pos_date,
      payment_settlement_send_pos_week,
      payment_settlement_send_pos_month,
      payment_settlement_send_pos_month_num,
      payment_settlement_send_pos_year,
      payment_settlement_send_pos_quarter,
      payment_settlement_send_pos_quarter_of_year,
      payment_settlement_send_pos,
      payment_settlement_send_pos_hour_of_day,
      payment_settlement_send_pos_time_of_day,
      payment_settlement_send_pos_hour2,
      payment_settlement_send_pos_minute15,
      payment_settlement_send_pos_day_of_week,
      payment_settlement_send_pos_day_of_month,
      credit_card_id
    ]
  }
}

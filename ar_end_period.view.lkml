view: ar_end_period {
  sql_table_name: EDW.F_END_PERIOD ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${week_end_date} ||'@'|| ${plan_id};;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension_group: week_end {
    description: "Date on which the Production cycle week ends (end of accounting week). The system runs a production cycle for each of the dates."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

  dimension: plan_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.END_PERIOD_PLAN_ID ;;
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: end_period_date_opened {
    label: "End Period Date Opened"
    description: "Date period opened"
    type: time
    sql: ${TABLE}.END_PERIOD_DATE_OPENED ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: end_period_date_closed {
    label: "End Period Date Closed"
    description: "Date period closed"
    type: time
    sql: ${TABLE}.END_PERIOD_DATE_CLOSED ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: end_period_carrier_code {
    label: "End Period Carrier Code"
    description: "Carrier Code"
    type: string
    sql: ${TABLE}.END_PERIOD_CARRIER_CODE ;;
  }

  dimension: end_period_plan_code {
    label: "End Period Plan Code"
    description: "Plan Code"
    type: string
    sql: ${TABLE}.END_PERIOD_PLAN_CODE ;;
  }

  ########################################################################################### Measures ##############################################################################################
  measure: sum_end_period_submitted_amount {
    label: "Submitted Amount"
    description: "Total submit amount of current week claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_SUBMITTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_submitted_amount {
    label: "Prior Submitted Amount"
    description: "Total prior submit amount of prior claims processed during the production cycle. (Sold date is prior to current week)"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_SUBMITTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prescription_count {
    label: "Prescription Count"
    description: "Number of current week claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRESCRIPTION_COUNT ;;
    value_format: "#,##0"
  }

  measure: sum_end_period_prior_prescription_count {
    label: "Prior Prescription Count"
    description: "Number of prior week claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_PRESCRIPTION_COUNT ;;
    value_format: "#,##0"
  }

  measure: sum_end_period_credit_amount {
    label: "Credit Amount"
    description: "Total credit amount of current week credit returned claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_CREDIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_credit_amount {
    label: "Prior Credit Amount"
    description: "Total prior credit amount of prior credit returned claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_CREDIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_number_of_credits {
    label: "Number Of Credits"
    description: "Number of current week credit returned claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_NUMBER_OF_CREDITS ;;
    value_format: "#,##0"
  }

  measure: sum_end_period_prior_number_of_credits {
    label: "Prior Number Of Credits"
    description: "Number of prior week credit returned claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_NUMBER_OF_CREDITS ;;
  }

  measure: sum_end_period_acquisition_cost_amount {
    label: "Acquisition Cost Amount"
    description: "Total Acquisition cost of current week claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_ACQUISITION_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_acquisition_cost_amount {
    label: "Prior Acquisition Cost Amount"
    description: "Total Acquisition Cost of prior week claims processed during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_ACQUISITION_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_paid_amount {
    label: "Paid Amount"
    description: "Total Paid amount applied to claims during the  production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAID_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_amount {
    label: "Open Amount"
    description: "Total Amount of Open aging"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_service_charge_amount {
    label: "Service Charge Amount"
    description: "Total Service Charge amount of checks posted during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_SERVICE_CHARGE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_open_amount {
    label: "Payment On Open Amount"
    description: "Total Amount of payments applied to Open claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_OPEN_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_adjustment_amount {
    label: "Adjustment Amount"
    description: "Total Adjustment amount of checks posted during the production cycle"
    type: sum
    sql: ${TABLE}.END_PERIOD_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_writeoff_amount {
    label: "Writeoff Amount"
    description: "Write Off total"
    type: sum
    sql: ${TABLE}.END_PERIOD_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_previous_reconciliation_writeoff_amount {
    label: "Previous Reconciliation Writeoff Amount"
    description: "Total Amount of payments received on claims that had been previously written off"
    type: sum
    sql: ${TABLE}.END_PERIOD_PREVIOUS_RECONCILIATION_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_partial_pay_amount {
    label: "Partial Pay Amount"
    description: "Total Partial Pay total"
    type: sum
    sql: ${TABLE}.END_PERIOD_PARTIAL_PAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_reconciliation_amount {
    label: "Reconciliation Amount"
    description: "Total Reconciled amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_RECONCILIATION_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_reject_amount {
    label: "Reject Amount"
    description: "Total Reject amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_REJECT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_reject_amount {
    label: "Payment On Reject Amount"
    description: "Total Amount of payments received on previously rejected claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_REJECT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_manual_writeoff_amount {
    label: "Manual Writeoff Amount"
    description: "Total Manual Write Off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_MANUAL_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_manual_writeoff_offset_amount {
    label: "Prior Manual Writeoff Offset Amount"
    description: "Total Offset amount on previously written off claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_MANUAL_WRITEOFF_OFFSET_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_manual_writeoff_amount {
    label: "Payment On Manual Writeoff Amount"
    description: "Total Payment amount received for claims previously written off"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_MANUAL_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_manual_adjustment_amount {
    label: "Manual Adjustment Amount"
    description: "Total Manual Sales Adjustment amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_MANUAL_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_manual_sales_adjustment_offset_amount {
    label: "Prior Manual Sales Adjustment Offset Amount"
    description: "Total Offset amount on previously sales adjusted claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_MANUAL_SALES_ADJUSTMENT_OFFSET_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_manual_sales_adjustment_amount {
    label: "Payment On Manual Sales Adjustment Amount"
    description: "Total Payment amount received for claims previously sales adjusted"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_MANUAL_SALES_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_manual_overpay_writeoff_amount {
    label: "Manual Overpay Writeoff Amount"
    description: "Total Overpay Write Off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_MANUAL_OVERPAY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_bankruptcy_writeoff_amount {
    label: "Bankruptcy Writeoff Amount"
    description: "Total bankruptcy write off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_BANKRUPTCY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_customer_requested_writeoff_amount {
    label: "Customer Requested Writeoff Amount"
    description: "Total Customer request write off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_CUSTOMER_REQUESTED_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_pc_adjustment_amount {
    label: "PC Adjustment Amount"
    description: "Total Posting Error Correction amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_PC_ADJUSTMENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_liability_writeoff_amount {
    label: "Liability Writeoff Amount"
    description: "Total Liability Write off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_LIABILITY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_liability_offset_amount {
    label: "Prior Liability Offset Amount"
    description: "Total Offset amount on previously Liability Write Off claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_LIABILITY_OFFSET_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_writeoff_within_limit_amount {
    label: "Writeoff Within Limit Amount"
    description: "Total Write Off Within Limits amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_WRITEOFF_WITHIN_LIMIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_writeoff_within_limit_offset_amount {
    label: "Prior Writeoff Within Limit Offset Amount"
    description: "Total Offset amount on previously Write Off within Limit claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_WRITEOFF_WITHIN_LIMIT_OFFSET_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_auto_close_amount {
    label: "Auto Close Amount"
    description: "Total Auto Close amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_AUTO_CLOSE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_auto_close_offset_amount {
    label: "Prior Auto Close Offset Amount"
    description: "Total Offset amount on previously written off to Auto Close claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_AUTO_CLOSE_OFFSET_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_overpay_amount {
    label: "Overpay Amount"
    description: "Total Overpay amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_OVERPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_overpay_amount {
    label: "Prior Overpay Amount"
    description: "Total Amount of claims that were previously in Overpay "
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_OVERPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_aging_amount {
    label: "Aging Amount"
    description: "Total of Aging. Includes Open, Reject, Partial Pay, Carrier Takebacks and Liabilities"
    type: sum
    sql: ${TABLE}.END_PERIOD_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_carrier_trial_balance_amount {
    label: "Carrier Trial Balance Amount"
    description: "Total Carrier Takeback amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_CARRIER_TRIAL_BALANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_carrier_trial_balance_amount {
    label: "Prior Carrier Trial Balance Amount"
    description: "Total Amount of previously written off Carrier Takebacks"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_CARRIER_TRIAL_BALANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_carrier_trial_balance_amount {
    label: "Payment On Carrier Trial Balance Amount"
    description: "Total Payment amount received for claims previously in Carrier Takeback status"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_CARRIER_TRIAL_BALANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_unapplied_cash_amount {
    label: "Unapplied Cash Amount"
    description: "Total Unapplied Cash amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_UNAPPLIED_CASH_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_unapplied_cash_close_amount {
    label: "Unapplied Cash Close Amount"
    description: "Total Unapplied Cash close amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_UNAPPLIED_CASH_CLOSE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_unapplied_cash_writeoff_amount {
    label: "Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_unapplied_cash_aging_amount {
    label: "Unapplied Cash Aging Amount"
    description: "Total Amount for all open Unapplied Cash"
    type: sum
    sql: ${TABLE}.END_PERIOD_UNAPPLIED_CASH_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_to_nhin_amount {
    label: "Prior To NHIN Amount"
    description: "Total Prior to NHIN Unapplied Cash amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_TO_NHIN_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_after_nhin_amount {
    label: "After NHIN Amount"
    description: "Total After NHIN Unapplied Cash amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_AFTER_NHIN_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_suspended_amount {
    label: "Open Suspended Amount"
    description: "Total Open suspended amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_SUSPENDED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_closed_suspended_amount {
    label: "Closed Suspended Amount"
    description: "Total Closed suspended amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_CLOSED_SUSPENDED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_writeoff_suspended_amount {
    label: "Writeoff Suspended Amount"
    description: "Total Writeoff suspended amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_WRITEOFF_SUSPENDED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_days_in_receivable {
    label: "Days In Receivable"
    description: "The number of days in receivable"
    type: sum
    sql: ${TABLE}.END_PERIOD_DAYS_IN_RECEIVABLE ;;
    value_format: "#,##0"
  }

  measure: sum_end_period_prior_manual_overpay_writeoff_amount {
    label: "Prior Manual Overpay Writeoff Amount"
    description: "Total Manual overpay amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_MANUAL_OVERPAY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_bankruptcy_writeoff_amount {
    label: "Prior Bankruptcy Writeoff Amount"
    description: "Total Offset amount on previous Bankruptcy write off claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_BANKRUPTCY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_bankruptcy_amount {
    label: "Payment On Bankruptcy Amount"
    description: "Total Payment amount received for claims previously written off to Bankruptcy"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_BANKRUPTCY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_customer_requested_amount {
    label: "Payment On Customer Requested Amount"
    description: "Total Payment amount received for claims previously written off to Customer Request"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_CUSTOMER_REQUESTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_overpay_within_limit_amount {
    label: "Overpay Within Limit Amount"
    description: "Total Overpay Write Off within limit amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_OVERPAY_WITHIN_LIMIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_overpay_within_limit_amount {
    label: "Prior Overpay Within Limit Amount"
    description: "Total Amount of previously Overpay Write Off within limit claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_OVERPAY_WITHIN_LIMIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_overpay_writeoff_amount {
    label: "Prior Overpay Writeoff Amount"
    description: "Total Amount of previously Overpay Write Off claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_OVERPAY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_overpay_writeoff_amount {
    label: "Overpay Writeoff Amount"
    description: "Total Overpay Writeoff Amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_OVERPAY_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_partial_writeoff_amount {
    label: "Prior Partial Writeoff Amount"
    description: "Total Amount of previously written off partially paid claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_PARTIAL_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_partial_writeoff_amount {
    label: "Partial Writeoff Amount"
    description: "Total Partial Pay write off amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_PARTIAL_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_payment_on_partial_amount {
    label: "Payment On Partial Amount"
    description: "Total Payment amount received for claims previously in Partial Pay status"
    type: sum
    sql: ${TABLE}.END_PERIOD_PAYMENT_ON_PARTIAL_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_prior_customer_requested_amount {
    label: "Prior Customer Requested Amount"
    description: "Total Offset amount on previously written off to Customer Request claims"
    type: sum
    sql: ${TABLE}.END_PERIOD_PRIOR_CUSTOMER_REQUESTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_usual_and_customary_price_amount {
    label: "Usual And Customary Price Amount"
    description: "Total Usual and Customary price"
    type: sum
    sql: ${TABLE}.END_PERIOD_USUAL_AND_CUSTOMARY_PRICE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_third_party_submitted_amount {
    label: "Third Party Submitted Amount"
    description: "Total Third Party Submit Amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_THIRD_PARTY_SUBMITTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_unapplied_cash_pos_amount {
    label: "Unapplied Cash POS Amount"
    description: "Total Non-Sold Tx Payments in Unapplied Cash"
    type: sum
    sql: ${TABLE}.END_PERIOD_UNAPPLIED_CASH_POS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_pos_sales_amount {
    label: "POS Sales Amount"
    description: "Total Non-Sold claim amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_POS_SALES_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_year_to_date_overpay_amount {
    label: "Year To Date Overpay Amount"
    description: "Total Historical Overpay Amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_YEAR_TO_DATE_OVERPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_90_aging_amount {
    label: "Open 90 Aging Amount"
    description: "Total Aging over 90 Days"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_90_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_120_aging_amount {
    label: "Open 120 Aging Amount"
    description: "Total Aging over 120 days"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_120_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_takebacks_unapplied_cash_writeoff_amount {
    label: "Takebacks Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Takebacks"
    type: sum
    sql: ${TABLE}.END_PERIOD_TAKEBACKS_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_credit_returns_unapplied_cash_writeoff_amount {
    label: "Credit Returns Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Credit Return"
    type: sum
    sql: ${TABLE}.END_PERIOD_CREDIT_RETURNS_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_store_adjustment_unapplied_cash_writeoff_amount {
    label: "Store Adjustment Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Store Adjusted Write Off"
    type: sum
    sql: ${TABLE}.END_PERIOD_STORE_ADJUSTMENT_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_non_pharmacy_payment_unapplied_cash_writeoff_amount {
    label: "Non Pharmacy Payment Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Non Pharmacy Payment"
    type: sum
    sql: ${TABLE}.END_PERIOD_NON_PHARMACY_PAYMENT_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_service_charges_unapplied_cash_writeoff_amount {
    label: "Service Charges Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Service Charges"
    type: sum
    sql: ${TABLE}.END_PERIOD_SERVICE_CHARGES_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_suspendeded_tax_unapplied_cash_writeoff_amount {
    label: "Suspended Tax Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Suspended Tx"
    type: sum
    sql: ${TABLE}.END_PERIOD_SUSPENDEDED_TAX_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_select_amount_unapplied_cash_writeoff_amount {
    label: "Select Amount Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Select Amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_SELECT_AMOUNT_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_zero_dollar_payment_unapplied_cash_writeoff_amount {
    label: "Zero Dollar Payment Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Zero Dollar Payment"
    type: sum
    sql: ${TABLE}.END_PERIOD_ZERO_DOLLAR_PAYMENT_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_bank_correction_unapplied_cash_writeoff_amount {
    label: "Bank Correction Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Bank Correction"
    type: sum
    sql: ${TABLE}.END_PERIOD_BANK_CORRECTION_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_deposit_correction_unapplied_cash_writeoff_amount {
    label: "Deposit Correction Unapplied Cash Writeoff Amount"
    description: "Total Unapplied Cash Write Off  amount for the close type of Deposit Correction"
    type: sum
    sql: ${TABLE}.END_PERIOD_DEPOSIT_CORRECTION_UNAPPLIED_CASH_WRITEOFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_30_aging_amount {
    label: "Open 30 Aging Amount"
    description: "Total Aging over 30 Days"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_30_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_60_aging_amount {
    label: "Open 60 Aging Amount"
    description: "Total Aging over 60 Days"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_60_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_open_180_aging_amount {
    label: "Open 180 Aging Amount"
    description: "Total Aging over 180 Days"
    type: sum
    sql: ${TABLE}.END_PERIOD_OPEN_180_AGING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_liability_amount {
    label: "Liability Amount"
    description: "Total Liability Amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_LIABILITY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_posted_amount {
    label: "Posted Amount"
    description: "Total Posted amount"
    type: sum
    sql: ${TABLE}.END_PERIOD_POSTED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_end_period_specified_remit_charges_amount {
    label: "Specified Remit Charges Amount"
    description: "Total Specified Remit Charges (DIR)"
    type: sum
    sql: ${TABLE}.END_PERIOD_SPECIFIED_REMIT_CHARGES_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "End Period LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.END_PERIOD_LCR_ID ;;
  }

  dimension: event_id {
    hidden:  yes
    type: number
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: edw_insert_timestamp {
    hidden:  yes
    type: time
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    hidden:  yes
    type: time
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    hidden:  yes
    type: time
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

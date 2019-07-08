view: tx_tp {
  sql_table_name: EDW.F_TX_TP ;;

  dimension: tx_tp_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: unique_key {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################
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

  dimension: tx_tp_counter_value {
    type: number
    # used for joining with eps_tx_tp view file to pick the appropriate record from epr.
    hidden: yes
    label: "Claim Billing Sequence"
    description: "Value indicating if a transaction third party record is for the primary, secondary, tertiary, etc."
    sql: ${TABLE}.TX_TP_COUNTER ;;
  }

  #################################################################################################### Dimensions #####################################################################################################
  dimension: tp_deleted {
    label: "Claim Deleted"
    # deleted fields are not exposed to the explore but are used in the join conditions to ensure soft deleted records in application/EDW are not picked up
    hidden: yes
    sql: ${TABLE}.TX_TP_DELETED ;;
  }

  dimension: tx_tp_carrier_code {
    type: string
    group_label: "Plan"
    label: "Carrier Code"
    description: "Unique code used to identify a Third Party Carrier on the claim"
    sql: ${TABLE}.TX_TP_CARRIER_CODE ;;
  }

  dimension: tx_tp_plan_code {
    type: string
    group_label: "Plan"
    label: "Plan Code"
    description: "Unique code used to identify a Third Party Plan on the claim"
    sql: ${TABLE}.TX_TP_PLAN_CODE ;;
  }

  dimension: tx_tp_plan_group_code {
    type: string
    group_label: "Plan"
    label: "Plan Group Code"
    description: "Unique code used to identify a Third Party Plan Group on the claim"
    sql: ${TABLE}.TX_TP_PLAN_GROUP_CODE ;;
  }

  dimension: tx_tp_plan_bin {
    type: string
    group_label: "Plan"
    label: "Plan BIN"
    description: "Stores the Third Party Bank Identification Number (BIN) on the claim"
    sql: ${TABLE}.TX_TP_PLAN_BIN ;;
  }

  dimension: tx_tp_plan_pcn {
    type: string
    group_label: "Plan"
    label: "Plan PCN"
    description: "Stores the Third Party Processor Control Number (PCN) on the claim"
    sql: ${TABLE}.TX_TP_PLAN_PCN ;;
  }

  dimension: tx_tp_plan_bin_pcn {
    label: "Plan BIN/PCN"
    description: "Concatenated value of BIN (Bank Identification Number) and PCN (Processor Control Number)"
    type: string
    sql: CASE WHEN ${tx_tp_plan_bin} IS NULL AND ${tx_tp_plan_pcn} IS NULL THEN NULL ELSE CONCAT(CONCAT(NVL(REGEXP_REPLACE(${tx_tp_plan_bin}, '[[:space:]]*',''),''), '-'),NVL(REGEXP_REPLACE(${tx_tp_plan_pcn}, '[[:space:]]*',''),'')) END ;;
  }

  dimension: tx_tp_plan_name {
    type: string
    group_label: "Plan"
    label: "Plan Name"
    description: "Name of the Third Party Plan on the claim"
    sql: ${TABLE}.TX_TP_PLAN_NAME ;;
  }

  dimension: tx_tp_queue_number {
    type: number
    label: "Claim TP Queue Number"
    description: "Third party transmit claim number (from Transmit Claims Queue)"
    sql: ${TABLE}.TX_TP_QUEUE_NUMBER ;;
  }

  #################################################################################################### DATE/TIME fields ###############################################################################################
  dimension_group: tx_tp_denial {
    label: "Claim Denial"
    description: "Date a claim was denied by the third party"
    type: time
    #X# Invalid LookML inside "dimension_group": {"timeframes":null}
    sql: ${TABLE}.TX_TP_DENIAL_DATE ;;
  }

  #################################################################################################### YES/NO ############################################################################################################

  dimension: tx_tp_copay_override_flag {
    type: yesno
    label: "Claim Copay Override Flag"
    description: "Yes/No Flag indicating if a copay override was performed"
    sql: NVL(${TABLE}.TX_TP_COPAY_OVERRIDE_FLAG,'N') = 'Y' ;;
  }

  dimension: tx_tp_reversal_flag {
    type: yesno
    label: "Claim Reversal Flag"
    description: "Yes/No Flag that indicates whether a Claim Reversal has been transmitted"
    sql: NVL(${TABLE}.TX_TP_REVERSAL_FLAG,'N') = 'Y' ;;
  }

  dimension: tx_tp_split_bill_flag {
    type: yesno
    label: "Claim Split Bill Flag"
    description: "Yes/No Flag indicating if the transaction was split billed"
    sql: ${TABLE}.TX_TP_SPLIT_BILL_FLAG = 'Y' ;;
  }

  #################################################################################################### SQL CASE (SUGGESTIONS) ###############################################################################################
  dimension: tx_tp_counter {
    type: string
    label: "Claim Billing Sequence"
    description: "Value indicating if a transaction third party record is for the primary, secondary, tertiary, etc."

    case: {
      when: {
        sql: NVL(${TABLE}.TX_TP_COUNTER,0) = 0 ;;
        label: "PRIMARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 1 ;;
        label: "SECONDARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 2 ;;
        label: "TERTIARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 3 ;;
        label: "QUATERNARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 4 ;;
        label: "QUINARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 5 ;;
        label: "SENARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 6 ;;
        label: "SEPTENARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 7 ;;
        label: "OCTONARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_COUNTER = 8 ;;
        label: "NONARY"
      }
    }
  }

  dimension: tx_tp_submit_status {
    type: string
    label: "Claim Submission Status"
    description: "Record needs to be submitted and Record has been submitted"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_STATUS = 'Y' ;;
        label: "NEEDS TO BE SUBMITTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_STATUS = 'S' ;;
        label: "SUBMITTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_STATUS = 'N' ;;
        label: "NO ACTION"
      }
    }
  }

  dimension: tx_tp_submit_type {
    type: string
    label: "Claim Submission Type"
    description: "Standard ,Rebill , Credit returned, Downtime and needs to transmitted and Downtime but has been transmitted "

    case: {
      when: {
        sql: NVL(${TABLE}.TX_TP_SUBMIT_TYPE,'S') = 'S' ;;
        label: "STANDARD TRANSACTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_TYPE = 'R' ;;
        label: "REBILL TRANSACTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_TYPE = 'C' ;;
        label: "CREDIT RETURNED"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_TYPE = 'D' ;;
        label: "DOWNTIME TRANSACTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_TYPE = 'L' ;;
        label: "DOWNTIME BUT TRANSMITTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_TYPE = 'P' ;;
        label: "PENDING"
      }
    }
  }

  dimension: tx_tp_how_submit {
    type: string
    label: "Claim Submission Method"
    description: "Paper, Transmit and Electronic batch"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'P' ;;
        label: "PAPER"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'T' ;;
        label: "TRANSMIT"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'E' ;;
        label: "ELECTRONIC BATCH"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'D' ;;
        label: "DISK"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'H' ;;
        label: "HOST"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT = 'H' ;;
        label: "MANUAL"
      }

      when: {
        sql: ${TABLE}.TX_TP_HOW_SUBMIT IS NULL ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_accounting_status {
    type: string
    label: "Claim Accounting Status"
    description: "Open, Closed and Manual"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_ACCOUNTING_STATUS = 'O' ;;
        label: "OPEN"
      }

      when: {
        sql: ${TABLE}.TX_TP_ACCOUNTING_STATUS = 'C' ;;
        label: "CLOSED"
      }

      when: {
        sql: ${TABLE}.TX_TP_ACCOUNTING_STATUS = 'M' ;;
        label: "MANUAL"
      }
    }
  }

  dimension: tx_tp_paid_status {
    type: string
    label: "Claim Paid Status"
    description: "Paid Status for this claim"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS  = 1 ;;
        label: "PAID"
      }

      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS = 2 ;;
        label: "PARTIALLY PAID"
      }

      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS = 3 ;;
        label: "REJECT"
      }

      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS = 4 ;;
        label: "CREDIT"
      }

      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS = 5 ;;
        label: "LOW PAY"
      }

      when: {
        sql: ${TABLE}.TX_TP_PAID_STATUS = 6 ;;
        label: "DUPLICATE OF PAID CLAIM"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 0 ;;
        label: "NO PAYMENT STATUS"
      }
    }
  }

  #     This dimension is specifically created for GenRx
  dimension: genrx_billing_method {
    required_access_grants: [can_view_genrx_specific_fields]
    type: string
    label: "GenRx Billing Method"
    description: "Billing Method specifically used for GenRx"

    case: {
      when: {
        sql: ( (${tx_tp_carrier_code} = UPPER('CASH') OR ${tx_tp_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 AND ${TABLE}.TX_TP_FINAL_COPAY > 0 ) ;;
        label: "CASH $25"
      }

      when: {
        sql: (${tx_tp_carrier_code} <> UPPER('CASH') AND ${tx_tp_carrier_code} <> UPPER('PRUG') AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 ) ;;
        label: "COMMERCIAL"
      }

      when: {
        sql: (${tx_tp_carrier_code} <> UPPER('CASH') AND ${tx_tp_carrier_code} <> UPPER('PRUG') AND NVL(${TABLE}.TX_TP_COUNTER,0) > 0 ) ;;
        label: "COMMERCIAL-NONPRIMARY"
      }

      when: {
        sql: ( (${tx_tp_carrier_code} = UPPER('CASH') OR ${tx_tp_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 AND ${TABLE}.TX_TP_FINAL_COPAY = 0 ) ;;
        label: "FREE"
      }

      when: {
        sql: ( (${tx_tp_carrier_code} = UPPER('CASH') OR ${tx_tp_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) > 0 ) ;;
        label: "PRUG-NONPRIMARY"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: tx_tp_tx_type {
    type: string
    label: "Claim Transaction Type"
    description: "Record created by Rx fill, Phone doctor, Credit, Other, Tp queue, NH batch, Tx correction and DUR Rx"
    sql: ${TABLE}.TX_TP_TX_TYPE ;;
  }

  dimension: tx_tp_patient_final_copay {
    # referenced under the templated filters for filtering on the WHERE Instead of HAVING clause
    hidden: yes
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: number
    sql: ${TABLE}.TX_TP_FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: tx_tp_balance_due_from_tp {
    # referenced under the templated filters for filtering on the WHERE Instead of HAVING clause
    hidden: yes
    label: "TP Balance Due"
    description: "Amount due from Third Party. If status is closed, implies writeoff"
    type: number
    sql: ${TABLE}.TX_TP_BALANCE_DUE_FROM_TP;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #   ERXLPS-77 Changes

  ################################################################################################## End of Dimensions #################################################################################################

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ###################################################
  filter: tx_tp_patient_final_copay_filter {
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: number
    sql: {% condition tx_tp_patient_final_copay_filter %} ${tx_tp_patient_final_copay} {% endcondition %}
      ;;
  }

  #   ERXLPS-77 Changes
  filter: tx_tp_balance_due_from_tp_filter {
    label: "TP Balance Due"
    description: "Amount due from Third Party. If status is closed, implies writeoff"
    type: number
    sql: {% condition tx_tp_balance_due_from_tp_filter %} ${tx_tp_balance_due_from_tp} {% endcondition %}
      ;;
  }

  #####################################################################################################################################################################################################################

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    # as this is exposed from from tx_tp_summary view
    hidden: yes
    label: "Claim Count"
    type: count
    value_format: "#,##0"
  }

  #     drill_fields: [claim_detail*]

  measure: sum_tx_tp_other_amount {
    label: "Claim Other Amount"
    type: sum
    sql: ${TABLE}.TX_TP_OTHER_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     drill_fields: [claim_detail*]

  measure: sum_tx_tp_submit_amount {
    label: "Claim Submit Amount"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     drill_fields: [claim_detail*]

  measure: sum_tx_tp_paid_amount {
    label: "Claim Paid Amount"
    type: sum
    sql: ${TABLE}.TX_TP_PAID_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     drill_fields: [claim_detail*]

  measure: sum_tx_tp_patient_final_copay {
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_write_off_amount {
    label: "Claim TP Write Off Amount"
    description: "Difference between submitted amount and balance plus copay"
    type: sum
    sql: ${TABLE}.TX_TP_WRITE_OFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_price {
    label: "Claim TP Final Price"
    description: "Final prescription transaction price for this third party"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_PRICE  ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_balance_due_from_tp {
    label: "TP Balance Due"
    description: "Amount due from Third Party. If status is closed, implies writeoff"
    type: sum
    sql: ${TABLE}.TX_TP_BALANCE_DUE_FROM_TP  ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: genrx_prugen_tx_tp_balance_due_from_tp {
    required_access_grants: [can_view_genrx_specific_fields]
    label: "GenRx Prugen Balance Due"
    description: "Amount due from Prugen. Calculation Used: Billing Method = 'FREE' then Total Claim TP Balance Due, if Billing Method = 'COMMERCIAL' or 'COMMERCIAL-NONPRIMARY' then Total Patient Final Copay, If Billing Method = 'CASH $25' then Total Claim TP Balance Due, if Billing Method = 'PRUG-NONPRIMARY' then Total Claim TP Balance Due"
    type: sum
    sql: CASE WHEN ${genrx_billing_method} IN ('FREE','CASH $25','PRUG-NONPRIMARY') THEN ${TABLE}.TX_TP_BALANCE_DUE_FROM_TP WHEN ${genrx_billing_method} IN ('COMMERCIAL','COMMERCIAL-NONPRIMARY') THEN ${TABLE}.TX_TP_FINAL_COPAY END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_cost {
    label: "Claim TP Final Cost"
    description: "Prescription Transaction cost for this third party"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_tax {
    label: "Claim TP Tax"
    description: "Prescription Transaction tax for this third party"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_compound_fee {
    label: "Claim TP Compound Fee"
    description: "Prescription Transaction Compound Preparation amount for this third party"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_incentive_fee {
    label: "Claim TP Incentive Fee"
    description: "Incentive Fee that is submitted by the Pharmacy"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_INCENTIVE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_final_upcharge {
    label: "Claim TP Final Upcharge"
    description: "Prescription Transaction tax for this third party"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_UPCHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tx_tp_received_amount {
    label: "Claim TP Received Amount"
    description: "Amount that has been received from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_AMOUNT_COLLECTED_FROM_TP ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

#   sets:
#    claim_detail:
#    - tx_tp_carrier_code
#    - tx_tp_plan_code
#    - tx_tp_plan_group_code
#    - tx_tp_plan_name
#    - tx_tp_plan_bin
#    - tx_tp_plan_pcn
#    - count
#    - sum_tx_tp_submit_amount
#    - sum_tx_tp_paid_amount

view: sales_tx_tp {
 # 0926207  - Enabling Persistence Derived table to build SALES_TX_TP after every ETL load
 # [ERXLPS-1517] - PDT Implementation Changes
 # [ERXLPS-2258] - Modified logic for the 'TX_TP_COPAY_OVERRIDE_AMOUNT' object. Changed 'NVL(TX_TP_RECEIVED_COPAY,0)' TO 'NVL(TX_TP_OVERRIDDEN_COPAY_AMOUNT,0)'
 # [ERXLPS-2380] - Updated tx_tp_first_counter logic to consider non-rejected claims first.
 # [ERXDWPS-1639] - Updated derived SQL logic to calculate Net Sales at transaction level
 # [ERXDWPS-6492] - Added new derived column/dimension to calculate maximum tax for trasaction across the claims. EPS uses tax with highest dollar amount across the calims and update RX_TX table. Corrrect logic for SUMMARY reports is to Consider maximum tax to calculate net sales.
 # [ERXDWPS-6429] - Updated the logic for TX_SUMMARY_NET_SALES to consider MAX_TX_TP_FINAL_TAX value. This column/dimension is used to filter tx net sales.
  derived_table: {
    sql:  SELECT *
                 , SUM(TX_TP_BALANCE_DUE_FROM_TP + TX_TP_LAST_COUNTER_FINAL_COPAY - MAX_TX_TP_FINAL_TAX) OVER(PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID) AS TX_SUMMARY_NET_SALES
            FROM (
                  SELECT
                    CHAIN_ID,
                    NHIN_STORE_ID,
                    RX_TX_ID,
                    TX_TP_ID,
                    TX_TP_COUNTER,
                    ROW_NUMBER() OVER (PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID ORDER BY NVL(TX_TP_COUNTER,-1) ASC) TX_TP_FIRST_COUNTER,
                    TX_TP_PATIENT_TP_LINK_ID,
                    TX_TP_PAID_STATUS,
                    NVL(TX_TP_WRITE_OFF_AMOUNT,0) AS TX_TP_WRITE_OFF_AMOUNT,
                    NVL(TX_TP_BALANCE_DUE_FROM_TP,0) AS TX_TP_BALANCE_DUE_FROM_TP,
                    NVL(TX_TP_FINAL_PRICE,0) AS TX_TP_FINAL_PRICE,
                    NVL(TX_TP_FINAL_COPAY,0) AS TX_TP_FINAL_COPAY,
                    NVL(TX_TP_FINAL_TAX,0) AS TX_TP_FINAL_TAX, --[ERXLPS-806]
                    NVL(CASE WHEN NVL(TX_TP_COPAY_OVERRIDE_FLAG,'N') = 'Y' THEN NVL(TX_TP_FINAL_COPAY,0) - NVL(TX_TP_OVERRIDDEN_COPAY_AMOUNT,0) END,0) AS TX_TP_COPAY_OVERRIDE_AMOUNT,
                    NVL(CASE
                       WHEN ROW_NUMBER() OVER (PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID ORDER BY NVL(TX_TP_COUNTER,-1) DESC) = 1 THEN TX_TP_FINAL_COPAY
                    END,0) AS TX_TP_LAST_COUNTER_FINAL_COPAY, -- Will be populated only for the final payor based on the max counter for the claims associated to single prescription transaction
                    NVL(MAX(CASE WHEN TX_TP_COUNTER = 0 THEN TX_TP_PAID_STATUS END) OVER(PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID),-1) TX_TP_PRIMARY_PAID_STATUS, --[ERXLPS-746]
                    NVL(MAX(CASE WHEN TX_TP_COUNTER = 1 THEN TX_TP_PAID_STATUS END) OVER(PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID),-1) TX_TP_SECONDARY_PAID_STATUS, --[ERXLPS-746]
                    NVL(MAX(CASE WHEN TX_TP_COUNTER = 2 THEN TX_TP_PAID_STATUS END) OVER(PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID),-1) TX_TP_TERTIARY_PAID_STATUS, --[ERXLPS-746]
                    CASE WHEN ROW_NUMBER() OVER (PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID ORDER BY NVL(TX_TP_COUNTER,-1) ASC) = 1
                         THEN MAX(NVL(TX_TP_FINAL_TAX,0)) OVER(PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID)
                         ELSE 0
                    END MAX_TX_TP_FINAL_TAX, --ERXDWPS-6492
                    TX_TP_OTHER_COVERAGE_CODE, --[ERXLPS-310]
                    TX_TP_COPAY_OVERRIDE_FLAG, --[ERXLPS-876]
                    TX_TP_OVERRIDDEN_COPAY_AMOUNT, --[ERXLPS-876]
                    SOURCE_SYSTEM_ID -- [ERXLPS-2211]
                    FROM EDW.F_TX_TP_LINK
                    WHERE ( (TX_TP_PAID_STATUS IN (1, 2, 3, 4, 5) OR TX_TP_SUBMIT_TYPE = 'D')  -- added status 3 to match SASD logic, however, do not agree this status should live on tx_tp record
                            OR
                            (SOURCE_SYSTEM_ID = 11 AND TX_TP_PAID_STATUS = 0 and TX_TP_TRANSMIT_QUEUE_ID IS NULL) --[ERXDWPS-5357] Consider paper claims from classic stores
                          )
                    AND TX_TP_INACTIVE = 'N'
                    --AND SOURCE_SYSTEM_ID = 4 --[ERXLPS-2384]
                  )
            ORDER BY CHAIN_ID, NHIN_STORE_ID, RX_TX_ID;;
    sql_trigger_value: SELECT MAX(EDW_LAST_UPDATE_TIMESTAMP) FROM EDW.F_TX_TP_LINK;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${tx_tp_id} ;; #ERXLPS-1649
  }

  ####################################################################################### Foreign Key ##########################################################################
  dimension: chain_id {
    type: number
    hidden: yes
    # primary key in source
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: tx_tp_patient_tp_link_id {
    type: string #[ERXDWPS-1532]
    hidden: yes
    sql: ${TABLE}.TX_TP_PATIENT_TP_LINK_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ####################################################################################### End of Foreign Key ##########################################################################

  ####################################################################################### Dimensions ##########################################################################
  dimension: tx_tp_counter {
    #group_label: "Claim"
    type: number
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    sql: ${TABLE}.TX_TP_COUNTER ;;
  }

  dimension: tx_tp_first_counter {
    #group_label: "Claim"
    type: number
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    sql: ${TABLE}.TX_TP_FIRST_COUNTER ;;
  }

  dimension: last_counter_final_copay {
    label: "Final Copay of Last Payor"
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
    type: number
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_LAST_COUNTER_FINAL_COPAY * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_LAST_COUNTER_FINAL_COPAY) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: final_copay {
    label: "Final Copay"
    #group_label: "Claim"
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    description: "Third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
    type: number
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_FINAL_COPAY * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_FINAL_COPAY) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: final_price {
    label: "Final Price"
    #group_label: "Claim"
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    description: "Final Price of third party"
    type: number
    #     sql: ${TABLE}.TX_TP_FINAL_PRICE
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_FINAL_PRICE * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_FINAL_PRICE) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-876] - Modified label and description from Overridden to Override
  dimension: copay_override_amount {
    label: "Copay Override Amount"
    #group_label: "Claim"
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    description: "Copay Override Amount. Calculation Used: Final Copay - Overridden Copay Amount of TP"
    type: number
    #     sql: ${TABLE}.TX_TP_FINAL_PRICE
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_COPAY_OVERRIDE_AMOUNT * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_COPAY_OVERRIDE_AMOUNT) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-876] - New dimension added for Copay Overridden Amount
  dimension: copay_overridden_amount {
    label: "Copay Overridden Amount (PRIOR to Override)"
    #group_label: "Claim"
    # this field is directly referenced in the sales view file, to avoid breaking existing Sales Reports
    hidden: yes
    description: "Total original copay amount, which is populated if the user overrides the copay with a new amount"
    type: number
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_OVERRIDDEN_COPAY_AMOUNT * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_OVERRIDDEN_COPAY_AMOUNT) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-876]  New dimension Copay Override Flag added.
  ## [ERXLPS-2258] - Added check on the Overridden Copay Amount to ensure Override was performed, see EPS Defect EPSD-1727. EPS stores the FINAL_COPAY in the OVERRIDDEN_COPAY_AMOUNT at the time of an override, it is possible that the flag was set and no override was performed.
  dimension: copay_override_flag {
    label: "Copay Override (Yes/No)"
    #group_label: "Claim"
    description: "Yes/No Flag indicating if copay was override. Flag Value is YES when the database object is YES, and the OVERRIDDEN_COPAY_AMOUNT is NOT NULL"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_COPAY_OVERRIDE_FLAG = 'Y' AND ${TABLE}.TX_TP_OVERRIDDEN_COPAY_AMOUNT IS NOT NULL THEN 'Yes'ELSE 'No' END ;;
    suggestions: [
      "Yes",
      "No"
    ]
  }

  dimension: tx_tp_counter_description {
    label: "Billing Sequence"
    #group_label: "Claim"
    description: "Value indicating if a transaction third party record is for the primary, secondary, tertiary, etc."
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_COUNTER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_COUNTER') ;;
    #[ERXLPS-2603]
    sql: CASE WHEN ${TABLE}.TX_TP_COUNTER = 0 THEN 'PRIMARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 1 THEN 'SECONDARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 2 THEN 'TERTIARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 3 THEN 'QUATERNARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 4 THEN 'QUINARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 5 THEN 'SENARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 6 THEN 'SEPTENARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 7 THEN 'OCTONARY'
              WHEN ${TABLE}.TX_TP_COUNTER = 8 THEN 'NONARY'
              WHEN ${TABLE}.TX_TP_COUNTER IS NULL AND ${TABLE}.TX_TP_ID IS NOT NULL THEN 'NOT DEFINED' --[ERXLPS-2603] null value master code changed to NOT DEFINED
              ELSE TO_CHAR(${TABLE}.TX_TP_COUNTER)
         END ;;
    suggestions: [
      "PRIMARY",
      "SECONDARY",
      "TERTIARY",
      "QUATERNARY",
      "QUINARY",
      "SENARY",
      "SEPTENARY",
      "OCTONARY",
      "NONARY",
      "NOT DEFINED"
    ]
  }

  dimension: write_off {
    label: "Write Off Amount"
    #group_label: "Claim"
    description: "Difference between the submitted amount and the received balance plus the patient copay"
    type: number
    # referenced in sales view files to avoid running into non unique collision error
    hidden: yes
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_WRITE_OFF_AMOUNT * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_WRITE_OFF_AMOUNT) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  dimension: net_due {
    label: "Balance Due from TP"
    #group_label: "Claim"
    description: "Amount owed by a third party"
    type: number
    # referenced in sales view files to avoid running into non unique collision error
    hidden: yes
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_BALANCE_DUE_FROM_TP * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_BALANCE_DUE_FROM_TP) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  #[ERXLPS-806] final_tax is added to calculate tax at claim level.
  #[ERXDWPS-6492] - Updated final_tax logic to consider MAX_TX_TP_FINAL_TAX for SUMMARY.
  dimension: final_tax {
    label: "Final Tax"
    #group_label: "Claim"
    description: "Final transaction third party tax"
    type: number
    # referenced in sales view files to avoid running into non unique collision error
    hidden: yes
    sql: CASE WHEN {% condition sales.sales_rxtx_payor_summary_detail_analysis %} 'SUMMARY' {% endcondition %} AND  ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.MAX_TX_TP_FINAL_TAX * -1)
              WHEN {% condition sales.sales_rxtx_payor_summary_detail_analysis %} 'SUMMARY' {% endcondition %} AND  ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.MAX_TX_TP_FINAL_TAX)
              WHEN {% condition sales.sales_rxtx_payor_summary_detail_analysis %} 'DETAIL' {% endcondition %} AND ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_TP_FINAL_TAX * -1)
              WHEN {% condition sales.sales_rxtx_payor_summary_detail_analysis %} 'DETAIL' {% endcondition %} AND ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_TP_FINAL_TAX)
         END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: count_tx_tp {
    label: "Total Claims"
    #group_label: "Claim"
    type: number #[ERXDWPS-6268]
    description: "Total Claim Volume"
    sql: count(DISTINCT(${TABLE}.CHAIN_ID ||'@'|| ${TABLE}.NHIN_STORE_ID ||'@'|| ${TABLE}.RX_TX_ID ||'@'|| ${TABLE}.TX_TP_ID)) ;; #ERXLPS-1649
    value_format: "#,##0"
  }

  ################################################################################### ERXLPS-645 - GenRx Missing Dimensions/Measures adding to Sales Explore #################################################################################

  #[ERXLPS-645] Used direct column from Derived table instead of dimension inheritance for TX_TP_FINAL_COPAY for performance improvement.
  #     This dimension is specifically created for GenRx
  dimension: genrx_billing_method {
    required_access_grants: [can_view_genrx_specific_fields]
    type: string
    label: "GenRx Billing Method"
    description: "Billing Method specifically used for GenRx."

    case: {
      when: {
        sql: (${eps_plan.store_plan_carrier_code} = UPPER('CASH') OR ${eps_plan.store_plan_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 AND ${TABLE}.TX_TP_FINAL_COPAY > 0 ;;
        label: "CASH $25"
      }

      when: {
        sql: (${eps_plan.store_plan_carrier_code} <> UPPER('CASH') AND ${eps_plan.store_plan_carrier_code} <> UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 ;;
        label: "COMMERCIAL"
      }

      when: {
        sql: (${eps_plan.store_plan_carrier_code} <> UPPER('CASH') AND ${eps_plan.store_plan_carrier_code} <> UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) > 0 ;;
        label: "COMMERCIAL-NONPRIMARY"
      }

      when: {
        sql: (${eps_plan.store_plan_carrier_code} = UPPER('CASH') OR ${eps_plan.store_plan_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) = 0 AND ${TABLE}.TX_TP_FINAL_COPAY = 0 ;;
        label: "FREE"
      }

      when: {
        sql: (${eps_plan.store_plan_carrier_code} = UPPER('CASH') OR ${eps_plan.store_plan_carrier_code} = UPPER('PRUG')) AND NVL(${TABLE}.TX_TP_COUNTER,0) > 0 ;;
        label: "PRUG-NONPRIMARY"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  #[ERXLPS-645] Added all the master codes available for TX_TP_PAID_STATUS for consistency
  dimension: tx_tp_paid_status {
    type: string
    label: "Claim Paid Status"
    description: "Paid Status for this claim such as Paid, Partially Paid, Reject, Credit etc."

    case: {
      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0)  = 1 ;;
        label: "PAID"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 2 ;;
        label: "PARTIALLY PAID"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 3 ;;
        label: "REJECT"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 4 ;;
        label: "CREDIT"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 5 ;;
        label: "LOW PAY"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 6 ;;
        label: "DUPLICATE OF PAID CLAIM"
      }

      when: {
        sql: NVL(${TABLE}.TX_TP_PAID_STATUS,0) = 0 ;;
        label: "NO PAYMENT STATUS"
      }
    }
  }

  #[ERXLPS-746] Added Primary/Secondary/tertiary payment status dimensions for filtering. Start...
  #[ERXLPS-820] Added ${TABLE} for column names to avoid column ambigous errors.
  dimension: tx_tp_primary_paid_status {
    label: "Claim Primary Payment Status"
    #group_label: "Claim"
    description: "Indicates payment status of the primary payer such as Paid, Credit, Reject and No Status"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_PRIMARY_PAID_STATUS IN (1,2,5,6) THEN 'PAID' WHEN ${TABLE}.TX_TP_PRIMARY_PAID_STATUS IN (4) THEN 'CREDIT' WHEN ${TABLE}.TX_TP_PRIMARY_PAID_STATUS IN (3) THEN 'REJECT' ELSE 'NO STATUS' END ;;
    suggestions: ["PAID", "CREDIT", "REJECT", "NO STATUS"]
  }

  dimension: tx_tp_secondary_paid_status {
    label: "Claim Secondary Payment Status"
    #group_label: "Claim"
    description: "Indicates payment status of the secondary payer such as Paid, Credit, Reject and No Status"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_SECONDARY_PAID_STATUS IN (1,2,5,6) THEN 'PAID' WHEN ${TABLE}.TX_TP_SECONDARY_PAID_STATUS IN (4) THEN 'CREDIT' WHEN ${TABLE}.TX_TP_SECONDARY_PAID_STATUS IN (3) THEN 'REJECT' ELSE 'NO STATUS' END ;;
    suggestions: ["PAID", "CREDIT", "REJECT", "NO STATUS"]
  }

  dimension: tx_tp_tertiary_paid_status {
    label: "Claim Tertiary Payment Status"
    #group_label: "Claim"
    description: "Indicates payment status of the tertiary payer such as Paid, Credit, Reject and No Status"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_TERTIARY_PAID_STATUS IN (1,2,5,6) THEN 'PAID' WHEN ${TABLE}.TX_TP_TERTIARY_PAID_STATUS IN (4) THEN 'CREDIT' WHEN ${TABLE}.TX_TP_TERTIARY_PAID_STATUS IN (3) THEN 'REJECT' ELSE 'NO STATUS' END ;;
    suggestions: ["PAID", "CREDIT", "REJECT", "NO STATUS"]
  }

  #[ERXLPS-746] Added Primary/Secondary/teritiary payment status dimensions for filtering. End...

  #[ERXLPS-310] Added new dimension for Other Coverage Code
  dimension: tx_tp_other_coverage_code {
    label: "Claim Other Coverage"
    #group_label: "Claim"
    description: "Other third party coverages (NCPDP Field 308-C8) which are submitted in the Request Claim Segment"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE IS NULL ;;
        label: "NOT SPECIFIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '1' ;;
        label: "1 - NO OTHER COVERAGE"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '2' ;;
        label: "2 - OTHER COVERAGE PAYMENT COLLECTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '3' ;;
        label: "3 - OTHER COVERAGE BILLED CLAIM NOT COVERED"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '4' ;;
        label: "4 - OTHER COVERAGE PAYMENT NOT COLLECTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '5' ;;
        label: "5 - MANAGED CARE PLAN DENIAL"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '6' ;;
        label: "6 - DENIED NOT PARTICIPATING PROVIDER"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '7' ;;
        label: "7 - NOT IN EFFECT ON DOS"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_COVERAGE_CODE = '8' ;;
        label: "8 - PATIENT FINANCIAL RESPONSIBILITY"
      }
    }
    suggestions: [
      "NOT SPECIFIED",
      "1 - NO OTHER COVERAGE",
      "2 - OTHER COVERAGE PAYMENT COLLECTED",
      "3 - OTHER COVERAGE BILLED CLAIM NOT COVERED",
      "4 - OTHER COVERAGE PAYMENT NOT COLLECTED",
      "5 - MANAGED CARE PLAN DENIAL",
      "6 - DENIED NOT PARTICIPATING PROVIDER",
      "7 - NOT IN EFFECT ON DOS",
      "8 - PATIENT FINANCIAL RESPONSIBILITY"
    ]
  }

  #[ERXDWPS-1639] - New dimensions for tx values
  dimension: tx_net_sales {
    label: "Third Party Tx Net Sales"
    description: "Third party transaction net sales."
    type: number
    hidden: yes
    sql: CASE WHEN ${sales.financial_category} IN ('T/P - CREDIT','CASH - CREDIT') THEN (${TABLE}.TX_SUMMARY_NET_SALES * -1) WHEN ${sales.financial_category} IN ('T/P - FILLED','CASH - FILLED') THEN (${TABLE}.TX_SUMMARY_NET_SALES) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

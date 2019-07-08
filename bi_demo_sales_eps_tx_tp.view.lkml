view: bi_demo_sales_eps_tx_tp {
  # [ERXLPS-1020] - Modified "Claim TP" to "Claim" for all dimensions and meaures labels for standardization.
  # [ERXLPS-1020] - New view with sales_eps_rx created for eps_rx.
  # sales view sold_flg, adjudicated_flg and report_calendar_global.type added along with transmit_queue column to unique_key to produce correct results fr sales measures.

  sql_table_name: EDW.F_TX_TP_LINK ;;

  dimension: tx_tp_id {
    type: number
    hidden: yes
    label: "Return And Adjustment ID"
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Third Party Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Third Party NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
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

  dimension: tx_tp_prior_authorization_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_PRIOR_AUTHORIZATION_ID ;;
  }

  dimension: tx_tp_workers_comp_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_WORKERS_COMP_ID ;;
  }

  dimension: tx_tp_copay_override_notes_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_COPAY_OVERRIDE_NOTES_ID ;;
  }

  dimension: tx_tp_prescriber_id_number {
    label: "Claim Prescriber ID Number"
    hidden: yes
    type: string
    sql: ${TABLE}.TX_TP_PRESCRIBER_ID_NUMBER ;;
  }

  dimension: tx_tp_denial_reference {
    hidden: yes
    label: "Claim Denial"
    description: "Date/Time a claim was denied by the third party"
    sql: ${TABLE}.TX_TP_DENIAL_DATE ;;
  }

  #[ERXLPS-2384]
  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################
  dimension: tx_tp_counter {
    type: number
    # this field is referenced in tx_tp view file and displayed based on the availability of TX_TP record from EPR
    hidden: yes
    sql: ${TABLE}.TX_TP_COUNTER ;;
  }

  dimension: tx_tp_paid_status {
    type: string
    # this field is referenced in tx_tp view file and displayed based on the availability of TX_TP record from EPR
    hidden: yes
    sql: ${TABLE}.TX_TP_PAID_STATUS ;;
  }

  dimension: tx_tp_submit_type {
    type: string
    # this field is referenced in tx_tp view file and displayed based on the availability of TX_TP record from EPR
    hidden: yes
    sql: ${TABLE}.TX_TP_SUBMIT_TYPE ;;
  }

  # ideally a dimension field is not named as dimension but this is a exception as there was a measure with the same name but with type: number defined.
  dimension: tx_tp_patient_final_copay_dimension {
    # referenced under the templated filters for filtering on the WHERE Instead of HAVING clause
    hidden: yes
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: number
    sql: ${TABLE}.TX_TP_FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # ideally a dimension field is not named as dimension but this is a exception as there was a measure with the same name but with type: number defined.
  dimension: tx_tp_balance_due_from_tp_dimension {
    # referenced under the templated filters for filtering on the WHERE Instead of HAVING clause
    hidden: yes
    label: "Claim Due From TP"
    description: "Total Amount owed by a third party"
    type: number
    sql: ${TABLE}.TX_TP_BALANCE_DUE_FROM_TP ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # ideally a dimension field is not named as dimension but this is a exception as there was a measure with the same name but with type: number defined.
  dimension: tx_tp_write_off_amount_dimension {
    hidden: yes
    label: "Claim Write Off Amount"
    description: "Difference between the submitted amount and the received balance plus the patient copay"
    type: number
    sql: ${TABLE}.TX_TP_WRITE_OFF_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # ideally a dimension field is not named as dimension but this is a exception as there was a measure with the same name but with type: number defined.
  dimension: tx_tp_final_price_dimension {
    hidden: yes
    label: "Claim Final Price"
    description: "Final transaction third party price"
    type: number
    sql: ${TABLE}.TX_TP_FINAL_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: tx_tp_basis_of_calculation_coinsurance {
    label: "Claim Basis Of Calculation Coinsurance"
    description: "Code indicating how the Coinsurance reimbursement amount was calculated for Patient Pay Amount (505-F5)"
    type: string
    sql: ${TABLE}.TX_TP_BASIS_OF_CALCULATION_COINSURANCE ;;
  }

  dimension: tx_tp_cob_reviewed_flag {
    label: "Claim COB Reviewed Flag"
    description: "Flag indicating if the Coordination of Benefits screens has been reviewed for a Transaction Third party record"
    type: string
    sql: ${TABLE}.TX_TP_COB_REVIEWED_FLAG ;;
  }

  dimension: tx_tp_network_reimburse_identifier {
    label: "Claim Network Reimburse Identifier"
    description: "Identifies the network, for the covered member, used to calculate the reimbursement to the pharmacy"
    type: string
    sql: ${TABLE}.TX_TP_NETWORK_REIMBURSE_IDENTIFIER ;;
  }

  dimension: tx_tp_original_counter {
    label: "Claim Original Counter"
    description: "Used by the application to keep track of which TX_TP was originally used to bill for a TX"
    type: number
    sql: ${TABLE}.TX_TP_ORIGINAL_COUNTER ;;
    value_format: "#,##0"
  }

  dimension: tx_tp_place_of_service {
    label: "Claim Place Of Service"
    description: "Code identifying the place where a drug or service is dispensed or administered"
    type: string
    sql: ${TABLE}.TX_TP_PLACE_OF_SERVICE ;;
  }

  dimension: tx_tp_procedure_modifier_code {
    label: "Claim Procedure Modifier Code"
    description: "Specifically done to match the D.0 fields being sent in EPS adjudication"
    type: string
    sql: ${TABLE}.TX_TP_PROCEDURE_MODIFIER_CODE ;;
  }

  dimension: tx_tp_reference_number {
    label: "Claim Reference Number"
    description: "Third party authorization number"
    type: string
    sql: ${TABLE}.TX_TP_REFERENCE_NUMBER ;;
  }

  dimension: tx_tp_send_other_rejects {
    label: "Claim Send Other Rejects"
    type: string
    sql: ${TABLE}.TX_TP_SEND_OTHER_REJECTS ;;
  }

  dimension: tx_tp_tp_flag1 {
    label: "Claim Flag1"
    description: "Miscellaneous third party flag number 1"
    type: string
    sql: ${TABLE}.TX_TP_TP_FLAG1 ;;
  }

  dimension: tx_tp_tp_flag2 {
    label: "Claim Flag2"
    description: "Miscellaneous third party flag number 2"
    type: string
    sql: ${TABLE}.TX_TP_TP_FLAG2 ;;
  }

  dimension: tx_tp_transmitted_ndc {
    label: "Claim Transmitted NDC"
    description: "NDC that was used to transmit to the TP Processer"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMITTED_NDC ;;
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################
  dimension: tx_tp_inactive {
    label: "Claim Inactive"
    description: "Inactive flag which is set when a transaction third party record is cancelled or billing is changed prior to being adjudicated"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_INACTIVE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_INACTIVE') ;;
    suggestions: ["INACTIVE", "ACTIVE"]
  }

  dimension: tx_tp_accounting_status {
    label: "Claim Accounting Status"
    description: "Flag indicating the reconciliation status of a transaction third party record"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_ACCOUNTING_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_ACCOUNTING_STATUS') ;;
    suggestions: ["NOT SPECIFIED", "OPEN", "CLOSED", "MANUAL"]
  }

  dimension: tx_tp_adjudicate_flag {
    label: "Claim Adjudicate Flag"
    description: "Flag indicating if a Canadian transaction third party record should be submitted for adjudication"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_ADJUDICATE_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_ADJUDICATE_FLAG') ;;
    suggestions: ["DO NOT SUBMIT", "YES SUBMIT"]
  }

  dimension: tx_tp_bill_with_ndc_flag {
    label: "Claim Bill With NDC Flag"
    description: "Flag indicating if a transaction third party record will be submitted to the third party with the drug NDC or the drug third party code"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_BILL_WITH_NDC_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_BILL_WITH_NDC_FLAG') ;;
    suggestions: ["SUBMIT NDC", "SUBMIT TP CODE"]
  }

  dimension: tx_tp_claim_override {
    label: "Claim Override Flag"
    description: "Yes/No Flag indicating if the claim has been overriden"
    type: yesno
    sql: ${TABLE}.TX_TP_CLAIM_OVERRIDE = 'Y' ;;
  }

  ## [ERXLPS-2258] - Added check on the Overridden Copay Amount to ensure Override was performed, see EPS Defect EPSD-1727. EPS stores the FINAL_COPAY in the OVERRIDDEN_COPAY_AMOUNT at the time of an override, it is possible that the flag was set and no override was performed.
  dimension: tx_tp_copay_override_flag {
    label: "Claim Copay Override Flag"
    description: "Flag indicating if a copay override was performed. Flag Value is YES when the database object is YES, and the OVERRIDDEN_COPAY_AMOUNT is NOT NULL"
    type: yesno
    sql: ${TABLE}.TX_TP_COPAY_OVERRIDE_FLAG = 'Y' AND ${TABLE}.TX_TP_OVERRIDDEN_COPAY_AMOUNT IS NOT NULL ;;
  }

  dimension: tx_tp_copay_override_reason {
    label: "Claim Copay Override Reason"
    description: "Copay Override Reason"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_COPAY_OVERRIDE_REASON AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_COPAY_OVERRIDE_REASON') ;;
    suggestions: [
      "NOT SPECIFIED",
      "OTHER",
      "MATCH COMPETITOR PRICE",
      "MATCH PRICE QUOTE",
      "MATCH PREVIOUS FILL PRICE",
      "PRICING ERROR"
    ]
  }

  dimension: tx_tp_delay_reason_code {
    label: "Claim Delay Reason"
    description: "Reason that submission of the transactions has been delayed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DELAY_REASON_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DELAY_REASON_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "ELIGIBILITY UNKNOWN",
      "LITIGATION",
      "AUTHORIZATION DELAYS",
      "DELAY IN CERTIFYING PROVIDER",
      "DELAY IN BILLING FORMS",
      "DELAY IN DELIVERY",
      "THIRD PARTY DELAY",
      "DELAY IN ELIGIBILITY",
      "REJECTED UNRELATED TO BILLING",
      "ADMINISTRATION DELAY",
      "OTHER",
      "RECEIVED LATE",
      "SUBSTANTIAL FIRE DAMAGE",
      "THEFT SABOTAGE BY EMPLOYEE"
    ]
  }

  dimension: tx_tp_effort_level {
    label: "Claim Effort Level"
    description: "NCPDP level of effort code"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_EFFORT_LEVEL AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_EFFORT_LEVEL') ;;
    suggestions: [
      "NOT SPECIFIED",
      "LEVEL 1",
      "LEVEL 2",
      "LEVEL 3",
      "LEVEL 4",
      "LEVEL 5"
    ]
  }

  dimension: tx_tp_how_submit {
    label: "Claim Submission Method"
    description: "Flag indicating how a transaction third party record will be submitted to a third party"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_HOW_SUBMIT AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_HOW_SUBMIT') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PAPER",
      "TRANSMIT",
      "ELECTRONIC BATCH",
      "DISK",
      "HOST",
      "MANUAL"
    ]
  }

  dimension: tx_tp_manual_copay {
    label: "Claim Manual Copay"
    description: "Yes/No flag indicating, During TP downtime this flag is set to Y when the CoPay is overriden and taken manually"
    type: yesno
    sql: ${TABLE}.TX_TP_MANUAL_COPAY = 'Y' ;;
  }

  dimension: tx_tp_original_submit_type {
    label: "Claim Original Submit Type"
    description: "Original submission type of a transaction third party record before it was reversed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_ORIGINAL_SUBMIT_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_ORIGINAL_SUBMIT_TYPE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "STANDARD TRANSACTION",
      "REBILL TRANSACTION",
      "TRANSACTION WAS CREDIT RETURNED",
      "DOWNTIME - NEEDS TO TRANSMITTED",
      "DOWNTIME - HAS BEEN TRANSMITTED"
    ]
  }

  dimension: tx_tp_other_amount_claimed_qualifier_1 {
    label: "Claim Other Amount Claimed Qualifier 1"
    description: "Other Amount Claimed Submitted Qualifier for the first  Other Amount Claimed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_1') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "OTHER"
    ]
  }

  dimension: tx_tp_other_amount_claimed_qualifier_2 {
    label: "Claim Other Amount Claimed Qualifier 2"
    description: "Other Amount Claimed Submitted Qualifier for the second Other Amount Claimed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_2') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "OTHER"
    ]
  }

  dimension: tx_tp_other_amount_claimed_qualifier_3 {
    label: "Claim Other Amount Claimed Qualifier 3"
    description: "Other Amount Claimed Submitted Qualifier for the third Other Amount Claimed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_OTHER_AMOUNT_CLAIMED_QUALIFIER_3') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "OTHER"
    ]
  }

  dimension: tx_tp_other_coverage_code {
    label: "Claim Other Coverage"
    description: "Defines other third party coverages (NCPDP Field 308-C8) which is submitted in the Request Claim Segment. See NCPDP dictionary for valid values. The current 'Other' field on the Patient_TP_Link should only be used to tell the system to use the 'Other Insurance' Pricing & Copay values"
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

  dimension: tx_tp_pharmacy_service_type {
    label: "Claim Pharmacy Service Type"
    description: "Type of service being performed by a pharmacy when different contractual terms exist between a payer and the pharmacy, or when benefits are based upon the type of service performed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_PHARMACY_SERVICE_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_PHARMACY_SERVICE_TYPE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "COMMUNITY/RETAIL PHARMACY",
      "COMPOUNDING PHARMACY",
      "HOME INFUSION THERAPY PROVIDER",
      "INSTITUTIONAL PHARMACY",
      "LONG TERM CARE PHARMACY",
      "MAIL ORDER PHARMACY",
      "MANAGED CARE ORGANIZATION",
      "SPECIALTY CARE PHARMACY",
      "OTHER"
    ]
  }

  dimension: tx_tp_reversal_flag {
    label: "Claim Reversal Flag"
    description: "Yes/No Flag indicating if a transaction third party record was reversed"
    type: yesno
    sql: ${TABLE}.TX_TP_REVERSAL_FLAG = 'Y' ;;
  }

  dimension: tx_tp_save_dur_for_refill_flag {
    label: "Claim Save DUR For Refill Flag"
    description: "Flag indicating if the DUR codes should be stored and used on every refill transaction of a prescription"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SAVE_DUR_FOR_REFILL_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SAVE_DUR_FOR_REFILL_FLAG') ;;
    suggestions: ["DO NOT SAVE", "YES SAVE DUR"]
  }

  dimension: tx_tp_service_level {
    label: "Claim Service Level"
    description: "NCPDP level of service code"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SERVICE_LEVEL AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SERVICE_LEVEL') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PATIENT COUNSEL",
      "HOME DELIVERY",
      "EMERGENCY",
      "24 HOUR SERVICE",
      "COUNSEL GENERIC",
      "IN-HOME SERVICE"
    ]
  }

  dimension: tx_tp_specialty_prior_auth_eligible {
    label: "Claim Speciality Prior Auth Eligible"
    description: "Flag that is set when a transaction is determined to be eligible for specialty  prior authorization services"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SPECIALTY_PRIOR_AUTH_ELIGIBLE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SPECIALTY_PRIOR_AUTH_ELIGIBLE') ;;
    suggestions: ["NOT ELIGIBLE", "YES IS ELIGIBLE"]
  }

  dimension: tx_tp_split_bill_flag {
    label: "Claim Split Bill Flag"
    description: "Flag indicating if the transaction associated with a transaction third party record was split billed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SPLIT_BILL_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SPLIT_BILL_FLAG') ;;
    suggestions: ["NOT SPLIT BILLED", "SPLIT BILLED"]
  }

  dimension: tx_tp_submit_status {
    label: "Claim Submission Status"
    description: "Flag indicating if a transaction third party record should be billed to the third party"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_STATUS') ;;
    suggestions: ["NOT SPECIFIED", "YES NEEDS SUBMITTAL", "SUBMITTED", "NO ACTION REQUIRED"]
  }

  #[ERXDWPS-8513]
  dimension: tx_tp_tp_daw_reference {
    label: "Claim DAW"
    description: "Transaction dispense as written code"
    type: string
    hidden: yes
    sql: ${TABLE}.TX_TP_TP_DAW ;;
  }

  #[ERXDWPS-8513] - Updated sql logic with CASE WHEN statement to avoid SF internal error. Updated logic with value - description and drill option added.
  dimension: tx_tp_tp_daw {
    label: "Claim DAW"
    description: "Transaction dispense as written code"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_ID IS NULL THEN 'N/A'
              WHEN ${TABLE}.TX_TP_ID IS NOT NULL AND ${TABLE}.TX_TP_TP_DAW IS NULL THEN 'NULL - UNKNOWN' --NULL is one of the master code value in D_MASTER_CODE table.
              WHEN ${TABLE}.TX_TP_TP_DAW = '0' THEN '0 - NOT SPECIFIED'
              WHEN ${TABLE}.TX_TP_TP_DAW = '1' THEN '1 - SUB NOT ALLOWED BY PRESCRIBER'
              WHEN ${TABLE}.TX_TP_TP_DAW = '2' THEN '2 - SUB ALLOWED - PATIENT REQUESTED'
              WHEN ${TABLE}.TX_TP_TP_DAW = '3' THEN '3 - SUB ALLOWED - PHARMACIST SELECTED'
              WHEN ${TABLE}.TX_TP_TP_DAW = '4' THEN '4 - SUB ALLOWED - GENERIC NOT IN STOCK'
              WHEN ${TABLE}.TX_TP_TP_DAW = '5' THEN '5 - SUB ALLOWED - BRAND DRUG AS GENERIC'
              WHEN ${TABLE}.TX_TP_TP_DAW = '6' THEN '6 - OVERRIDE'
              WHEN ${TABLE}.TX_TP_TP_DAW = '7' THEN '7 - SUB NOT ALLOWED - BRAND DRUG BY LAW'
              WHEN ${TABLE}.TX_TP_TP_DAW = '8' THEN '8 - SUB ALLOWED - GENERIC NOT AVAILABLE'
              WHEN ${TABLE}.TX_TP_TP_DAW = '9' THEN '9 - OTHER'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: [
      "NULL - UNKNOWN",
      "0 - NOT SPECIFIED",
      "1 - SUB NOT ALLOWED BY PRESCRIBER",
      "2 - SUB ALLOWED - PATIENT REQUESTED",
      "3 - SUB ALLOWED - PHARMACIST SELECTED",
      "4 - SUB ALLOWED - GENERIC NOT IN STOCK",
      "5 - SUB ALLOWED - BRAND DRUG AS GENERIC",
      "6 - OVERRIDE",
      "7 - SUB NOT ALLOWED - BRAND DRUG BY LAW",
      "8 - SUB ALLOWED - GENERIC NOT AVAILABLE",
      "9 - OTHER"
    ]
    suggest_persist_for: "24 hours"
    drill_fields: [tx_tp_tp_daw_reference]
  }

  dimension: tx_tp_unbalanced_pricing_segment {
    label: "Claim Unbalanced Pricing Segment"
    description: "Indicates that the third party returned values in the Pricing segment that do not balance to the NCPDP pricing formula"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_UNBALANCED_PRICING_SEGMENT AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_UNBALANCED_PRICING_SEGMENT') ;;
    suggestions: ["PRICING FORMULA IS BALANCED", "PRICING FORMULA IS UNBALANCED"]
  }

  #[ERXLPS-1020] - New dimension added as part of TP Claim integration
  dimension: tx_tp_submit_type_desc {
    type: string
    label: "Claim Submission Type"
    description: "Standard ,Rebill , Credit returned, Downtime and needs to transmitted and Downtime but has been transmitted "
    sql: CASE WHEN ${TABLE}.TX_TP_SUBMIT_TYPE IS NULL THEN 'STANDARD TRANSACTION'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'S' THEN 'STANDARD TRANSACTION'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'R' THEN 'REBILL TRANSACTION'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'C' THEN 'CREDIT RETURNED'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'D' THEN 'DOWNTIME TRANSACTION'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'L' THEN 'DOWNTIME BUT TRANSMITTED'
    WHEN ${TABLE}.TX_TP_SUBMIT_TYPE = 'P' THEN 'PENDING'
    ELSE ${TABLE}.TX_TP_SUBMIT_TYPE
    END ;;
    suggestions: [
      "STANDARD TRANSACTION",
      "REBILL TRANSACTION",
      "CREDIT RETURNED",
      "DOWNTIME TRANSACTION",
      "DOWNTIME BUT TRANSMITTED",
      "PENDING"
    ]
  }

  #[ERXDWPS-7255] - Sync EPS TX_TP to EDW  | Start
  dimension: tx_tp_originating_evoucher {
    label: "Claim Originating Evoucher"
    description: "Yes/No flag that indicates if the third party record is associated with an eVoucher claim. This is a flag on the TX_TP from which the eVoucher was created"
    type: yesno
    sql: ${TABLE}.TX_TP_ORIGINATING_EVOUCHER_FLAG = 'Y' ;;
  }

  dimension: tx_tp_evoucher {
    label: "Claim Evoucher"
    description: "Yes/No flag that indicates if the third party record is an eVoucher record"
    type: yesno
    sql: ${TABLE}.TX_TP_EVOUCHER_FLAG = 'Y' ;;
  }

  dimension: tx_tp_daw_source_reference {
    label: "Claim DAW Source"
    description: "Derived value indicating how the TP DAW was set"
    type: string
    hidden: yes
    sql: ${TABLE}.TX_TP_DAW_SOURCE ;;
  }

  dimension: tx_tp_daw_source {
    label: "Claim DAW Source"
    description: "Derived value indicating how the TP DAW was set"
    type: string
    sql: CASE WHEN ${TABLE}.TX_TP_DAW_SOURCE IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.TX_TP_DAW_SOURCE = 'BLANK' THEN 'BLANK - NOT SPECIFIED'
              WHEN ${TABLE}.TX_TP_DAW_SOURCE = 'MN' THEN 'MN - MANUALLY SELECTED DAW'
              WHEN ${TABLE}.TX_TP_DAW_SOURCE = 'TP' THEN 'TP - DEFAULT TP DAW'
              WHEN ${TABLE}.TX_TP_DAW_SOURCE = 'TX' THEN 'TX - NCPDP DAW TP'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN","BLANK - NOT SPECIFIED","MN - MANUALLY SELECTED DAW","TP - DEFAULT TP DAW","TX - NCPDP DAW TP"]
    suggest_persist_for: "24 hours"
    drill_fields: [tx_tp_daw_source_reference]
  }
  #[ERXDWPS-7255] - Sync EPS TX_TP to EDW  | End

  ################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

  ########################################################################################################## Date/Time Dimensions #############################################################################################
  dimension_group: tx_tp_denial_date {
    label: "Claim Denial"
    description: "Date/Time a claim was denied by the third party"
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
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TX_TP_DENIAL_DATE ;;
  }

  dimension_group: tx_tp_fill_override_date {
    label: "Claim Fill Override"
    description: "Fill Date that gets transmited to the third party"
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
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TX_TP_FILL_OVERRIDE_DATE ;;
  }

  dimension_group: tx_tp_prior_auth_request_sent_date {
    label: "Claim Prior Auth Request Sent"
    description: "Date that a prior authorization request was sent to a third party service provider"
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
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TX_TP_PRIOR_AUTH_REQUEST_SENT_DATE ;;
  }

  dimension_group: tx_tp_reversal_date {
    label: "Claim Reversal"
    description: "Date/Time claim reversal was sent to the Third Party"
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
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TX_TP_REVERSAL_DATE ;;
  }

  ################################################################################################### End of Date/Time Dimensions #############################################################################################

  ####################################################################################################### Measures #################################################################################################################
  measure: count {
    # as this is exposed from from tx_tp view
    hidden: yes
    label: "Claim Count"
    type: count
    value_format: "#,##0"
  }

  measure: tx_tp_patient_final_copay {
    label: "Claim Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: number
    sql: SUM(${TABLE}.TX_TP_FINAL_COPAY) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_write_off_amount {
    label: "Claim Write Off Amount"
    description: "Difference between the submitted amount and the received balance plus the patient copay"
    type: number
    sql: SUM(${TABLE}.TX_TP_WRITE_OFF_AMOUNT) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_price {
    label: "Claim Final Price"
    description: "Final transaction third party price"
    type: number
    sql: SUM(${TABLE}.TX_TP_FINAL_PRICE) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_balance_due_from_tp {
    label: "Claim Amount Due From TP"
    description: "Total Amount owed by a third party"
    type: number
    sql: SUM(${TABLE}.TX_TP_BALANCE_DUE_FROM_TP) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_amount_collected_from_tp {
    label: "Claim Amount Collected From Third Party"
    type: sum
    sql: ${TABLE}.TX_TP_AMOUNT_COLLECTED_FROM_TP ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_coinsurance_amount {
    label: "Claim Coinsurance Amonut"
    description: "Total amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to a per prescription coinsurance"
    type: sum
    sql: ${TABLE}.TX_TP_COINSURANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_copay_subtotal {
    label: "Claim Copay Subtotal"
    description: "Total amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to a per prescription copay"
    type: sum
    sql: ${TABLE}.TX_TP_COPAY_SUBTOTAL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_coverage_gap_amount {
    label: "Claim Coverage Gap Amount"
    description: "Total Amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the patient being in the coverage gap"
    type: sum
    sql: ${TABLE}.TX_TP_COVERAGE_GAP_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_patient_deductible_amount {
    label: "Claim Patient Deductible Amount"
    description: "Total amount to be collected from a patient that is included in Patient Pay Amount (505-F5) that is applied to a periodic deductible"
    type: sum
    sql: ${TABLE}.TX_TP_PATIENT_DEDUCTIBLE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # information contract amount field. Used as dimension
  measure: tx_tp_dispensing_fee_contract_amount {
    label: "Claim Dispensing Fee Contract Amount"
    description: "Informational field used when Other Payer-Patient Responsibility Amount (352-NQ) or Patient Pay Amount (505-F5) is used for reimbursement"
    type: sum
    sql: ${TABLE}.TX_TP_DISPENSING_FEE_CONTRACT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_estimated_generic_savings_amount {
    label: "Claim Estimated Generic Savings Amount"
    type: sum
    sql: ${TABLE}.TX_TP_ESTIMATED_GENERIC_SAVINGS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_exceed_benefit {
    label: "Claim Exceed Benefit"
    description: "Sub-total of exceeded benefit returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_EXCEED_BENEFIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_compound_fee {
    label: "Claim Final Compound Fee"
    description: "Total final transaction third party compounding fee"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_cost {
    label: "Claim Final Cost"
    description: "Final transaction third party cost"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_incentive_fee {
    label: "Claim Final Incentive Fee"
    description: "Total final transaction third party incentive fee"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_INCENTIVE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_tax {
    label: "Claim Final Tax"
    description: "Total final transaction third party tax"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_final_upcharge {
    label: "Claim Final Upcharge"
    description: "Total final transaction third party upcharge"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_UPCHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_ingredient_cost_contract_amount {
    label: "Claim Ingredient Cost Contract Amount"
    description: "Informational field used when Other Payer-Patient Responsibility Amount (352-NQ) or Patient Pay Amount (505-F5) is used for reimbursement"
    type: sum
    sql: ${TABLE}.TX_TP_INGREDIENT_COST_CONTRACT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_other_amount_claimed_1 {
    label: "Claim Other Amount Claimed 1"
    description: "Other Amount Claimed Submitted Qualifier for the first  Other Amount Claimed"
    type: sum
    sql: ${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_1 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_other_amount_claimed_2 {
    label: "Claim Other Amount Claimed 2"
    description: "Other Amount Claimed Submitted Qualifier for the second Other Amount Claimed"
    type: sum
    sql: ${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_2 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_other_amount_claimed_3 {
    label: "Claim Other Amount Claimed 3"
    description: "Other Amount Claimed Submitted Qualifier for the third Other Amount Claimed"
    type: sum
    sql: ${TABLE}.TX_TP_OTHER_AMOUNT_CLAIMED_3 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_other_insurance_amount {
    label: "Claim Other Insurance Amount"
    description: "Total amount paid by another third party"
    type: sum
    sql: ${TABLE}.TX_TP_OTHER_INSURANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_overridden_copay_amount {
    label: "Claim Overridden Copay Amount (PRIOR to Override)"
    description: "Total original copay amount, which is populated if the user overrides the copay with a new amount"
    type: sum
    sql: ${TABLE}.TX_TP_OVERRIDDEN_COPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_patient_sales_tax_amount {
    label: "Claim Patient Sales Tax Amount"
    description: "Patient sales tax responsibility"
    type: sum
    sql: ${TABLE}.TX_TP_PATIENT_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_plan_funded_assistance_amount {
    label: "Claim Plan Funded Assistance Amount"
    description: "The amount from the health plan-funded assistance account for the patient that was applied to reduce Patient Pay Amount (505-F5)"
    type: sum
    sql: ${TABLE}.TX_TP_PLAN_FUNDED_ASSISTANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_plan_sales_tax_amount {
    label: "Claim Plan Sales Tax Amount"
    description: "Amount from the health plan-funded assistance account for the patient that was applied to reduce Patient Pay Amount (505-F5)"
    type: sum
    sql: ${TABLE}.TX_TP_PLAN_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_processor_fee_amount {
    label: "Claim Processor Fee Amount"
    description: "Amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the processing fee imposed by the processor"
    type: sum
    sql: ${TABLE}.TX_TP_PROCESSOR_FEE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_prod_selection_brand_non_preference_amount {
    label: "Claim Prod Selection Brand Non Preference Amount"
    description: "Amount to be collected from the patient that is included in Patient Pay Amount  (505-F5) that is due to the patient's selection of a Brand Non-Preferred Formulary product"
    type: sum
    sql: ${TABLE}.TX_TP_PROD_SELECTION_BRAND_NON_PREFERENCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_product_selection_brand_amount {
    label: "Claim Product Selection Brand Amount"
    description: "Amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the patient's selection of a Brand product"
    type: sum
    sql: ${TABLE}.TX_TP_PRODUCT_SELECTION_BRAND_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_product_selection_non_preference_amount {
    label: "Claim Product Selection Non Preference Amount"
    description: "Amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the patient's selection of a Non-Preferred Formulary product"
    type: sum
    sql: ${TABLE}.TX_TP_PRODUCT_SELECTION_NON_PREFERENCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_provider_network_selection_amount {
    label: "Claim Provider Network Slection Amount"
    description: "Amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the patient's provider network selection"
    type: sum
    sql: ${TABLE}.TX_TP_PROVIDER_NETWORK_SELECTION_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_amount {
    label: "Claim Received Amount"
    description: "Total amount returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_compound_fee {
    label: "Claim Received Compound Fee"
    description: "Total Compounding fee returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_copay {
    label: "Claim Received Copay"
    description: "Total Patient copay returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_cost {
    label: "Claim Received Cost"
    description: "Total cost returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_dispensing_fee {
    label: "Claim Received Dispensing Fee"
    description: "Total dispensing fee returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_DISPENSING_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_incentive_fee {
    label: "Claim Received Incentive Fee"
    description: "Total incentirve fee returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_INCENTIVE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_price {
    label: "Claim Received Price"
    description: "Total price returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_professional_service_fee {
    label: "Claim Received Professional Service Fee"
    description: "Total professional service fee returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_PROFESSIONAL_SERVICE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_tax {
    label: "Claim Received Tax"
    description: "Tax returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_received_upcharge {
    label: "Claim Received upcharge"
    description: "Total upcharge returned from the third party"
    type: sum
    sql: ${TABLE}.TX_TP_RECEIVED_UPCHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_spending_account_remaining_amount {
    label: "Claim Spending Account Remaining Amount"
    description: "The balance from the patient's spending account after this transaction was applied"
    type: sum
    sql: ${TABLE}.TX_TP_SPENDING_ACCOUNT_REMAINING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_amount {
    label: "Claim Submit Amount"
    description: "Total expected third party pay amount submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_compound_fee {
    label: "Claim Submit Compound Fee"
    description: "Total compounding fee submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_copay {
    label: "Claim Submit Copay"
    description: "Total Patient copay submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_cost {
    label: "Claim Submit Cost"
    description: "Total Transaction cost submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_dispensing_fee {
    label: "Claim Submit Dispensing Fee"
    description: "Total Dispensing fee submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DISPENSING_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_incentive {
    label: "Claim Submit Incentive"
    description: "Total Incentive fee submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_INCENTIVE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_price {
    label: "Claim Submit Price"
    description: "Total Transaction price submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_professional_service_fee {
    label: "Claim Submit Processing Service Fee"
    description: "Total Professional service fee submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_PROFESSIONAL_SERVICE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_tax {
    label: "Claim Submit Tax"
    description: "Transaction tax submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_times {
    label: "Claim Submit Times"
    description: "Total number of times a transaction third party record has been submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_TIMES ;;
    value_format: "#,##0"
  }

  measure: tx_tp_submit_upcharge {
    label: "Claim Submit Upcharge"
    description: "Total Transaction upcharge submitted to the third party"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_UPCHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_tax_in_copay {
    label: "Claim Tax In Copay"
    description: "Total amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to sales tax paid"
    type: sum
    sql: ${TABLE}.TX_TP_TAX_IN_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_tp_paid_amount {
    label: "Claim Paid Amount"
    description: "Total amount paid or to be paid by the third party"
    type: sum
    sql: ${TABLE}.TX_TP_TP_PAID_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_tp_returned_copay {
    label: "Claim Returned Copay"
    description: "Total actual Copay returned from Third Party"
    type: sum
    sql: ${TABLE}.TX_TP_TP_RETURNED_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1020] - New measures added for sales explore
  measure: sum_sales_tx_tp_tp_paid_amount {
    label: "Claim Paid Amount"
    description: "Total amount paid or to be paid by the third party"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_TP_PAID_AMOUNT END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_amount {
    label: "Claim Submit Amount"
    description: "Total expected third party pay amount submitted to the third party"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_SUBMIT_AMOUNT END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_final_compound_fee {
    label: "Claim Compound Fee"
    description: "Total final transaction third party compounding fee"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_FINAL_COMPOUND_FEE END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_final_cost {
    label: "Claim Final Cost"
    description: "Final transaction third party cost"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_FINAL_COST END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_final_upcharge {
    label: "Claim Final Upcharge"
    description: "Total final transaction third party upcharge"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_FINAL_UPCHARGE END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_final_incentive_fee {
    label: "Claim Incentive Fee"
    description: "Total final transaction third party incentive fee"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_FINAL_INCENTIVE_FEE END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_amount_collected_from_tp {
    label: "Claim Received Amount"
    description: "Amount that has been received from third party"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_AMOUNT_COLLECTED_FROM_TP END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_other_insurance_amount {
    label: "Claim Other Amount"
    description: "Total amount paid by another third party"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_OTHER_INSURANCE_AMOUNT END ;;
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ####################################################################################### Sets ##################################################################

  set: explore_rx_4_6_000_sf_deployment_candidate_list {
    fields: [
      tx_tp_accounting_status,
      tx_tp_adjudicate_flag,
      tx_tp_amount_collected_from_tp,
      tx_tp_basis_of_calculation_coinsurance,
      tx_tp_bill_with_ndc_flag,
      tx_tp_claim_override,
      tx_tp_cob_reviewed_flag,
      tx_tp_coinsurance_amount,
      tx_tp_copay_override_flag,
      tx_tp_copay_override_reason,
      tx_tp_copay_subtotal,
      tx_tp_coverage_gap_amount,
      tx_tp_patient_deductible_amount,
      tx_tp_delay_reason_code,
      tx_tp_denial_date_date,
      tx_tp_denial_date_day_of_month,
      tx_tp_denial_date_day_of_week,
      tx_tp_denial_date_day_of_week_index,
      tx_tp_denial_date_hour_of_day,
      tx_tp_denial_date_hour2,
      tx_tp_denial_date_minute15,
      tx_tp_denial_date_month,
      tx_tp_denial_date_month_num,
      tx_tp_denial_date_quarter,
      tx_tp_denial_date_quarter_of_year,
      tx_tp_denial_date_time,
      tx_tp_denial_date_time_of_day,
      tx_tp_denial_date_week,
      tx_tp_denial_date_week_of_year,
      tx_tp_denial_date_year,
      tx_tp_denial_date,
      tx_tp_dispensing_fee_contract_amount,
      tx_tp_effort_level,
      tx_tp_estimated_generic_savings_amount,
      tx_tp_exceed_benefit,
      tx_tp_fill_override_date_date,
      tx_tp_fill_override_date_day_of_month,
      tx_tp_fill_override_date_day_of_week,
      tx_tp_fill_override_date_day_of_week_index,
      tx_tp_fill_override_date_hour_of_day,
      tx_tp_fill_override_date_hour2,
      tx_tp_fill_override_date_minute15,
      tx_tp_fill_override_date_month,
      tx_tp_fill_override_date_month_num,
      tx_tp_fill_override_date_quarter,
      tx_tp_fill_override_date_quarter_of_year,
      tx_tp_fill_override_date_time,
      tx_tp_fill_override_date_time_of_day,
      tx_tp_fill_override_date_week,
      tx_tp_fill_override_date_week_of_year,
      tx_tp_fill_override_date_year,
      tx_tp_fill_override_date,
      tx_tp_final_compound_fee,
      tx_tp_final_cost,
      tx_tp_final_incentive_fee,
      tx_tp_final_tax,
      tx_tp_final_upcharge,
      tx_tp_how_submit,
      tx_tp_ingredient_cost_contract_amount,
      tx_tp_manual_copay,
      tx_tp_network_reimburse_identifier,
      tx_tp_original_counter,
      tx_tp_original_submit_type,
      tx_tp_other_amount_claimed_1,
      tx_tp_other_amount_claimed_2,
      tx_tp_other_amount_claimed_3,
      tx_tp_other_amount_claimed_qualifier_1,
      tx_tp_other_amount_claimed_qualifier_2,
      tx_tp_other_amount_claimed_qualifier_3,
      tx_tp_other_coverage_code,
      tx_tp_other_insurance_amount,
      tx_tp_overridden_copay_amount,
      tx_tp_patient_sales_tax_amount,
      tx_tp_pharmacy_service_type,
      tx_tp_place_of_service,
      tx_tp_plan_funded_assistance_amount,
      tx_tp_plan_sales_tax_amount,
      tx_tp_prescriber_id_number,
      tx_tp_prior_auth_request_sent_date_date,
      tx_tp_prior_auth_request_sent_date_day_of_month,
      tx_tp_prior_auth_request_sent_date_day_of_week,
      tx_tp_prior_auth_request_sent_date_day_of_week_index,
      tx_tp_prior_auth_request_sent_date_hour_of_day,
      tx_tp_prior_auth_request_sent_date_hour2,
      tx_tp_prior_auth_request_sent_date_minute15,
      tx_tp_prior_auth_request_sent_date_month,
      tx_tp_prior_auth_request_sent_date_month_num,
      tx_tp_prior_auth_request_sent_date_quarter,
      tx_tp_prior_auth_request_sent_date_quarter_of_year,
      tx_tp_prior_auth_request_sent_date_time,
      tx_tp_prior_auth_request_sent_date_time_of_day,
      tx_tp_prior_auth_request_sent_date_week,
      tx_tp_prior_auth_request_sent_date_week_of_year,
      tx_tp_prior_auth_request_sent_date_year,
      tx_tp_prior_auth_request_sent_date,
      tx_tp_procedure_modifier_code,
      tx_tp_processor_fee_amount,
      tx_tp_prod_selection_brand_non_preference_amount,
      tx_tp_product_selection_brand_amount,
      tx_tp_product_selection_non_preference_amount,
      tx_tp_provider_network_selection_amount,
      tx_tp_received_amount,
      tx_tp_received_compound_fee,
      tx_tp_received_copay,
      tx_tp_received_cost,
      tx_tp_received_dispensing_fee,
      tx_tp_received_incentive_fee,
      tx_tp_received_price,
      tx_tp_received_professional_service_fee,
      tx_tp_received_tax,
      tx_tp_received_upcharge,
      tx_tp_reference_number,
      tx_tp_reversal_date_date,
      tx_tp_reversal_date_day_of_month,
      tx_tp_reversal_date_day_of_week,
      tx_tp_reversal_date_day_of_week_index,
      tx_tp_reversal_date_hour_of_day,
      tx_tp_reversal_date_hour2,
      tx_tp_reversal_date_minute15,
      tx_tp_reversal_date_month,
      tx_tp_reversal_date_month_num,
      tx_tp_reversal_date_quarter,
      tx_tp_reversal_date_quarter_of_year,
      tx_tp_reversal_date_time,
      tx_tp_reversal_date_time_of_day,
      tx_tp_reversal_date_week,
      tx_tp_reversal_date_week_of_year,
      tx_tp_reversal_date_year,
      tx_tp_reversal_date,
      tx_tp_reversal_flag,
      tx_tp_save_dur_for_refill_flag,
      tx_tp_send_other_rejects,
      tx_tp_service_level,
      tx_tp_specialty_prior_auth_eligible,
      tx_tp_spending_account_remaining_amount,
      tx_tp_split_bill_flag,
      tx_tp_submit_amount,
      tx_tp_submit_compound_fee,
      tx_tp_submit_copay,
      tx_tp_submit_cost,
      tx_tp_submit_dispensing_fee,
      tx_tp_submit_incentive,
      tx_tp_submit_price,
      tx_tp_submit_professional_service_fee,
      tx_tp_submit_status,
      tx_tp_submit_tax,
      tx_tp_submit_times,
      tx_tp_submit_upcharge,
      tx_tp_tax_in_copay,
      tx_tp_tp_daw,
      tx_tp_tp_flag1,
      tx_tp_tp_flag2,
      tx_tp_tp_paid_amount,
      tx_tp_tp_returned_copay,
      tx_tp_transmitted_ndc,
      tx_tp_unbalanced_pricing_segment
    ]
  }

  #[ERXLPS-1020] New set created for dimensions only to include in sales explore
  # [ERXLPS-2258] - Added 'tx_tp_copay_override_reason' dimension to the list of fields being exposed via dimension candidate list
  set: sales_tx_tp_dimension_candidate_list {
    fields: [
      tx_tp_accounting_status,
      tx_tp_reversal_flag,
      tx_tp_split_bill_flag,
      tx_tp_how_submit,
      tx_tp_submit_status,
      tx_tp_submit_type_desc,
      tx_tp_copay_override_reason,
      tx_tp_originating_evoucher,
      tx_tp_evoucher,
      tx_tp_daw_source
    ]
  }

  #[ERXLPS-726] New set created to exclude sales specific measures from other explores
  set: explore_sales_specific_candidate_list {
    fields: [
      sum_sales_tx_tp_tp_paid_amount,
      sum_sales_tx_tp_submit_amount,
      sum_sales_tx_tp_final_compound_fee,
      sum_sales_tx_tp_final_cost,
      sum_sales_tx_tp_final_upcharge,
      sum_sales_tx_tp_final_incentive_fee,
      sum_sales_tx_tp_amount_collected_from_tp,
      sum_sales_tx_tp_other_insurance_amount
    ]
  }
}

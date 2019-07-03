view: sales_eps_tx_tp_transmit_queue {
  # [ERXLPS-1020] - New view with sales_eps_tx_tp_transmit_queue created for eps_tx_tp_transmit_queue.
  # sales view sold_flg, adjudicated_flg and report_calendar_global.type added along with transmit_queue column to unique_key to produce correct results fr sales measures.
  # [ERXDWPS-7020] - Removed unused date dimensions and measures created for other than sales explore. This view is specifically created for Sales Explore and not referenced in any other explores.
  sql_table_name: EDW.F_TX_TP_TRANSMIT_QUEUE ;;

  dimension: tx_tp_transmit_queue_id {
    type: number
    hidden: yes
    label: "Transmit Queue ID"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    #[ERXLPS-652 ]Added tx_tp_id to UK. This is required now as we are integrating TP Transmit Queue into Sales explore. This will make sure sum_distinct is applied correctly while using measures from different measures.
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_id} ||'@'|| ${tx_tp_transmit_queue_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Transmit Queue Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Transmit Queue NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_id {
    label: "ID"
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_ID ;;
  }

  ########################################################################################### End of Foreign Key References #####################################################################################################

  ######################################################################################################### Dimension ############################################################################################################
  dimension: tx_tp_transmit_queue_reference_number {
    label: "Transmit Queue Reference Number"
    description: "Number assigned by the processor to identify an authorized transaction. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_REFERENCE_NUMBER ;;
  }

  dimension: tx_tp_transmit_queue_response_text {
    label: "Transmit Queue Response Text"
    description: "Reject reason codes and message text returned from the third party. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_RESPONSE_TEXT ;;
  }

  dimension: tx_tp_transmit_queue_help_desk_phone {
    label: "Transmit Queue Help Desk Phone"
    description: "Help desk phone number. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_HELP_DESK_PHONE ;;
  }

  dimension: tx_tp_transmit_queue_pct_tax_dispense_basis_code {
    label: "Transmit Queue PCT Tax Dispense Basis Code"
    description: "Claim TP Transmit Queue PCT Tax Dispense Basis Code. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PCT_TAX_DISPENSE_BASIS_CODE ;;
  }

  dimension: tx_tp_transmit_queue_product_qualifier {
    label: "Transmit Queue Product Qualifier"
    description: "Code indicating the type of product ID submitted to the third party. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PRODUCT_QUALIFIER ;;
  }

  dimension: tx_tp_transmit_queue_claim_template_id {
    label: "Transmit Queue Claim Template Identifier"
    description: "Code of the claim format used to transmit a third party transmit queue record. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_CLAIM_TEMPLATE_ID ;;
  }

  dimension: tx_tp_transmit_queue_intermediary_auth_id {
    label: "Transmit Queue Intermediary Auth Identifier"
    description: "Value indicating intermediary authorization occurred. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_INTERMEDIARY_AUTH_ID ;;
  }

  dimension: tx_tp_transmit_queue_response_plan_id {
    hidden: yes
    label: "Transmit Queue Response Plan ID"
    description: "Plan ID returned from the third party. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_RESPONSE_PLAN_ID ;;
  }

  dimension: tx_tp_transmit_queue_response_payer_id {
    label: "Transmit Queue Response Payer Identifier"
    description: "ID of the payer. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_RESPONSE_PAYER_ID ;;
  }

  dimension: tx_tp_transmit_queue_plan_transmit_bin_number {
    label: "Transmit Queue Plan Transmit BIN Number"
    description: "ANSI BIN number for claim transmittals. This field is EPS only!!!"
    type: string #[ERXLPS-1178]
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PLAN_TRANSMIT_BIN_NUMBER ;;
  }

  dimension: tx_tp_transmit_queue_plan_pcn_number {
    label: "Transmit Queue Plan PCN Number"
    description: "Processor control number for claim transmittals. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PLAN_PCN_NUMBER ;;
  }

  dimension: tx_tp_transmit_queue_procedure_modifier_code {
    label: "Transmit Queue Procedure Modifier Code"
    description: "Identifies special circumstances related to the performance of the service. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PROCEDURE_MODIFIER_CODE ;;
  }

  dimension: tx_tp_transmit_queue_original_prescribed_ndc {
    label: "Transmit Queue Original Prescribed NDC"
    description: "NDC of the prescribed drug. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ORIGINAL_PRESCRIBED_NDC ;;
  }

  #[ERXDWPS-7020] - Dispensing Fee dimensions are added to expose in sales explore.
  dimension: tx_tp_transmit_queue_submit_dispensing_fee {
    label: "Transmit Queue Submit Dispensing Fee"
    view_label: "TP Transmit Queue"
    description: "Dispensing fee submitted to the third party. The calculation for dispensing fee submitted is: rxPrice (brand or generic) - baseCost - upCharge - compoundFee. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.tx_tp_transmit_queue_submit_dispensing_fee ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: tx_tp_transmit_queue_received_dispensing_fee {
    label: "Transmit Queue Received Dispensing Fee"
    view_label: "TP Transmit Queue"
    description: "Professional service returned from the third party. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.tx_tp_transmit_queue_received_dispensing_fee ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################
  dimension: tx_tp_transmit_queue_status {
    label: "Transmit Queue Status"
    description: "Status of transmit queue record. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_STATUS') ;;
    suggestions: [
      "NOT SPECIFIED",
      "WAITING",
      "SENDING",
      "RECEIVED",
      "COMPLETE",
      "SEND CREDIT",
      "CREDIT",
      "DOWNTIME",
      "PENDING CONTRACTS",
      "PENDING COMPLETION FILL",
      "CANCELED",
      "NOT TRANSMITTED"
    ]
  }

  dimension: tx_tp_transmit_queue_paid_status {
    label: "Transmit Queue Paid Status"
    description: "Payment response returned from the third party processor. This field is EPS only!!!"
    type: string
    #[ERXLPS-2456] - Update sql logic to populate master code values only for TPTQ records. Not for all NULL records. There could be NULL output due to left outer join made.
    sql: CASE WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS IS NULL AND ${tx_tp_transmit_queue_id} IS NOT NULL THEN 'NO RESPONSE RECEIVED'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 0 THEN 'NO RESPONSE RECEIVED'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 1 THEN 'PAID IN FULL'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 2 THEN 'PARTLY PAID'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 3 THEN 'REJECT'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 4 THEN 'CREDIT'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 5 THEN 'LOW PAY'
              WHEN ${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS = 6 THEN 'DUPLICATE OF PAID CLAIM'
              ELSE TO_CHAR(${TABLE}.TX_TP_TRANSMIT_QUEUE_PAID_STATUS) --Added else condition to display DB value if master code values are not available.
         END ;;
    suggestions: [
      "NO RESPONSE RECEIVED",
      "PAID IN FULL",
      "PARTLY PAID",
      "REJECT",
      "CREDIT",
      "LOW PAY",
      "DUPLICATE OF PAID CLAIM",
      "UNKNOWN"
    ]
  }

  dimension: tx_tp_transmit_queue_claim_format_type {
    label: "Transmit Queue Claim Format Type"
    description: "Value indicating the process responsible for originating a third party transmit queue record. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_CLAIM_FORMAT_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_CLAIM_FORMAT_TYPE') ;;
    suggestions: [
      "CLAIM TRANSMIT DETAIL SCREEN",
      "PRESCRIPTION FILLING",
      "PHONE DOCTOR",
      "CREDIT",
      "OTHER",
      "THIRD PARTY QUEUE",
      "NURSING HOME BATCH",
      "TRANSACTION CORRECTION",
      "DUR PRESCRIPTION"
    ]
  }

  dimension: tx_tp_transmit_queue_alternate_protocol_flag {
    label: "Transmit Queue Alternate Protocol Flag"
    description: "Yes/No Flag indicating if a third party transmit queue record was transmitted using the alternate protocol defined on the insurance plan record. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ALTERNATE_PROTOCOL_FLAG = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_duplicate_flag {
    label: "Transmit Queue Duplicate Flag"
    description: "Yes/No Flag indicating if the third party returned a duplicate response for this claim. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_DUPLICATE_FLAG = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_downtime_flag {
    label: "Transmit Queue Downtime Flag"
    description: "Yes/No Flag indicating the process responsible for originating a third party transmit queue record. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_DOWNTIME_FLAG = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_print_british_columbia_label {
    label: "Transmit Queue Print British Columbia Label"
    description: "Yes/No Flag indicating if a label should be printed for British Columbia claims. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_PRINT_BRITISH_COLUMBIA_LABEL = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_other_amount_claimed_qual_1 {
    label: "Transmit Queue Other Amount Claimed Qual 1"
    description: "Identify the additional incurred cost claimed in  Other Amount Claimed Submitted  (48 -H9). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_1') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "COMPOUND PREPARATION COST SUBMITTED",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_basis_of_paid_amount {
    label: "Transmit Queue Basis Of Paid Amount"
    description: "Basis third party used to calculate the returned paid amount. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_BASIS_OF_PAID_AMOUNT AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_BASIS_OF_PAID_AMOUNT') ;;
    suggestions: [
      "NOT SPECIFIED",
      "INGREDIENT COST PAID AS SUBMITTED",
      "INGREDIENT COST REDUCED TO AWP PRICING",
      "INGREDIENT COST REDUCED TO AWP LESS X% PRICING",
      "USUAL AND CUSTOMARY PAID AS SUBMITTED",
      "PAID LOWER OF INGREDIENT COST PLUS FEES VERSUS USUAL AND CUSTOMARY",
      "MAC PRICING INGREDIENT COST PAID",
      "MAC PRICING INGREDIENT COST REDUCED TO MAC",
      "CONTRACT PRICING",
      "ACQUISITION PRICING",
      "ASP (AVERAGE SALES PRICE)",
      "AMP (AVERAGE MANUFACTURER PRICE)",
      "340B/DISPROPORTIONATE SHARE/PUBLIC HEALTH SERVICE PRICING",
      "WAC (WHOLESALE ACQUISITION COST)",
      "OTHER PAYER-PATIENT RESPONSIBILITY AMOUNT",
      "PATIENT PAY AMOUNT",
      "COUPON PAYMENT",
      "SPECIAL PATIENT REIMBURSEMENT",
      "DIRECT PRICE (DP)",
      "STATE FEE SCHEDULE (SFS) REIMBURSEMENT",
      "NATIONAL AVERAGE DRUG ACQUISITION COST (NADAC)",
      "STATE AVERAGE ACQUISITION COST (AAC)"
    ]
  }

  dimension: tx_tp_transmit_queue_tax_recalc_flag {
    label: "Transmit Queue Tax Recalc Flag"
    description: "Yes/No Flag indicating if the tax was re-calculated using information returned from the third party. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_TAX_RECALC_FLAG = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_change_date_flag {
    label: "Transmit Queue Change Date Flag"
    description: "Yes/No Flag indicating if the user was asked if the date on a third party transmit queue record should be changed when transmitting a third party transmit queue record on a date other than the creation date. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_CHANGE_DATE_FLAG = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_fee_basis_code {
    label: "Transmit Queue Fee Basis"
    description: "Indicates how the dispensing fee paid amount was determined. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_FEE_BASIS_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_FEE_BASIS_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "QUANTITY DISPENSED",
      "QUANTITY INTENDED TO BE DISPENSED",
      "USUAL AND CUSTOMARY/PRORATED",
      "WAIVED DUE TO PARTIAL FILL",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_copay_basis_code {
    label: "Transmit Queue Copay Basis"
    description: "Indicates how the patient copay amount was determined. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_COPAY_BASIS_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_COPAY_BASIS_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "QUANTITY DISPENSED",
      "QUANTITY INTENDED TO BE DISPENSED",
      "USUAL AND CUSTOMARY/PRORATED",
      "WAIVED DUE TO PARTIAL FILL",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_flat_tax_basis_code {
    label: "Transmit Queue Flat Tax Basis"
    description: "Indicates how the flat sales tax amount paid was determined. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_FLAT_TAX_BASIS_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_FLAT_TAX_BASIS_CODE') ;;
    suggestions: ["NOT SPECIFIED ", "QUANTITY DISPENSED", "QUANTITY INTENDED TO BE DISPENSED"]
  }

  dimension: tx_tp_transmit_queue_pct_tax_amount_basis_code {
    label: "Transmit Queue PCT Tax Amount Basis"
    description: "Indicates how the reimbursement amount was calculated for  Percentage Sales Tax Amount Paid  (559-AX). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_PCT_TAX_AMOUNT_BASIS_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_PCT_TAX_AMOUNT_BASIS_CODE') ;;
    suggestions: ["NOT SPECIFIED", "QUANTITY DISPENSED", "QUANTITY INTENDED TO BE DISPENSED"]
  }

  dimension: tx_tp_transmit_queue_intermediary_auth_type {
    label: "Transmit Queue Intermediary Auth Type"
    description: "Indicates that authorization occurred for intermediary processing. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_INTERMEDIARY_AUTH_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_INTERMEDIARY_AUTH_TYPE') ;;
    suggestions: ["NOT SPECIFIED", "INTERMEDIARY AUTHORIZATION", "OTHER OVERRIDE"]
  }

  dimension: tx_tp_transmit_queue_other_amount_claimed_qual_2 {
    label: "Transmit Queue Other Amount Claimed Qual 2"
    description: "Identify the additional incurred cost claimed in  Other Amount Claimed Submitted  (48 -H9). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_2') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "COMPOUND PREPARATION COST SUBMITTED",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_other_amount_claimed_qual_3 {
    label: "Transmit Queue Other Amount Claimed Qual 3"
    description: "identify the additional incurred cost claimed in  Other Amount Claimed Submitted  (48 -H9). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_OTHER_AMOUNT_CLAIMED_QUAL_3') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "COMPOUND PREPARATION COST SUBMITTED",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_how_processed {
    label: "Transmit Queue How Processed"
    description: "How processor processed claim. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_HOW_PROCESSED AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_HOW_PROCESSED') ;;
    suggestions: ["CAPTURE", "ELIGIBLE", "DUPLICATE", "NORMAL"]
  }

  dimension: tx_tp_transmit_queue_response_payer_id_qual {
    label: "Transmit Queue Response Payer ID Qual"
    description: "The type of payer ID. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_TRANSMIT_QUEUE_RESPONSE_PAYER_ID_QUAL AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_TRANSMIT_QUEUE_RESPONSE_PAYER_ID_QUAL') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PAYER ID",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "BANK INFORMATION NUMBER (BIN)",
      "NATIONAL ASSOCIATION OF INSURANCE COMMISSIONERS (NAIC)",
      "OTHER"
    ]
  }

  dimension: tx_tp_transmit_queue_current_record {
    label: "Transmit Queue Current Record"
    description: "The most recent TP_TRANSMIT_QUEUE record for this claim. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_CURRENT_RECORD = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_change_billing_reversal_reject {
    label: "Transmit Queue Change Billing Reversal Reject"
    description: "Yes/No Flag to indicate if the reversal was rejected during a billing change. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_CHANGE_BILLING_REVERSAL_REJECT = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_claim_override {
    label: "Transmit Queue Claim Override"
    description: "Yes/No Flag indicating if the claim has been overridden by a user. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_CLAIM_OVERRIDE = 'Y' ;;
  }

  dimension: tx_tp_transmit_queue_deleted {
    label: "Transmit Queue Deleted"
    description: "Indicates if the record has been inserted/updated/deleted in the source table. This field is EPS only!!!"
    hidden: yes
    type: yesno
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_DELETED = 'Y' ;;
  }

  #[ERXLPS-1845] - Reference dimension added to use in joins.
  dimension: tx_tp_transmit_queue_deleted_reference {
    label: "Transmit Queue Deleted"
    description: "Y/N Flag indicating soft delete of record in the source table. This field is EPS only!!!"
    hidden: yes
    type: string
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_DELETED ;;
  }

  ########################################################################################################## reference dates used in other explores (currently used in sales )#############################################################################################
  ###### reference dates does not have any type as the type is defined in other explores....
  ###### the below objects are used as references in other view files....
  ### [ERXLPS-652]
  dimension: tx_tp_transmit_queue_submission_reference {
    hidden: yes
    label: "Transmit Queue Submission"
    description: "Date/Time a third party transmit queue record was submitted to the third party. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_SUBMISSION_DATE ;;
  }

  dimension: tx_tp_transmit_queue_response_reference {
    hidden: yes
    label: "Transmit Queue Response"
    description: "Date/Time a response for a  third party transmit queue record was received from  the third party. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_RESPONSE_DATE ;;
  }

  dimension: tx_tp_transmit_queue_original_submit_reference {
    hidden: yes
    label: "Transmit Queue Original Submit"
    description: "Date/Time a third party transmit queue record was originally submitted to the third party. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ORIGINAL_SUBMIT_DATE ;;
  }

  dimension: tx_tp_transmit_queue_fill_override_reference {
    hidden: yes
    label: "Transmit Queue Fill Override"
    description: "Fill date used when transmitting the claim. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_FILL_OVERRIDE_DATE ;;
  }

  #[ERXLPS-652] Creating dimensions to reference in othe views.
  dimension: tx_tp_transmit_queue_submit_price_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_SUBMIT_PRICE ;;
  }

  dimension: tx_tp_transmit_queue_received_price_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_RECEIVED_PRICE ;;
  }

  #[ERXDWPS-7167] - Request for new Dimensions (Total Days Supply, Received Copay)
  dimension: sales_tx_tp_transmit_queue_received_copay {
    label: "Transmit Queue Received Copay"
    view_label: "TP Transmit Queue"
    description: "Copay returned from the third party. This field is EPS only!!!"
    type: number
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_copay END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ############################################################################################################### Measures #################################################################################################
  #[ERXLPS-910] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sum_sales_tx_tp_transmit_queue_number_of_rejects {
    label: "Transmit Queue Number Of Rejects"
    view_label: "TP Transmit Queue"
    description: "Total number of reject codes returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_number_of_rejects END ;;
    value_format: "#,##0"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_price {
    label: "Transmit Queue Submit Price"
    view_label: "TP Transmit Queue"
    description: "Prescription price submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_price END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_cost {
    label: "Transmit Queue Submit Cost"
    view_label: "TP Transmit Queue"
    description: "Prescription cost submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_cost END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_tax {
    label: "Transmit Queue Tax Amount"
    view_label: "TP Transmit Queue"
    description: "Prescription tax amount submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_tax END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_amount {
    label: "Transmit Queue Submit Amount"
    view_label: "TP Transmit Queue"
    description: "Expected insurance pay amount submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_copay {
    label: "Transmit Queue Submit Copay"
    view_label: "TP Transmit Queue"
    description: "Expected patient copay amount submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_copay END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_upcharge {
    label: "Transmit Queue Submit Upcharge"
    view_label: "TP Transmit Queue"
    description: "Prescription upcharge submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_upcharge END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_compound_fee {
    label: "Transmit Queue Submit Compound Fee"
    view_label: "TP Transmit Queue"
    description: "Compounding fee submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_compound_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_incentive {
    label: "Transmit Queue Submit Incentive"
    view_label: "TP Transmit Queue"
    description: "Incentive fee submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_incentive END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_prof_service_fee {
    label: "Transmit Queue Submit Prof Service Fee"
    view_label: "TP Transmit Queue"
    description: "Professional service fee submitted to the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_prof_service_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_submit_dispensing_fee {
    label: "Transmit Queue Submit Dispensing Fee"
    view_label: "TP Transmit Queue"
    description: "Dispensing fee submitted to the third party. The calculation for dispensing fee submitted is: rxPrice (brand or generic) - baseCost - upCharge - compoundFee. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_submit_dispensing_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_other_amount_claimed_1 {
    label: "Transmit Queue Other Amount Claimed 1"
    view_label: "TP Transmit Queue"
    description: "First amount representing the additional incurred costs for a dispensed prescription or service. You can submit up to 3. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_other_amount_claimed_1 END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_price {
    label: "Transmit Queue Received Price"
    view_label: "TP Transmit Queue"
    description: "Price returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_price END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_cost {
    label: "Transmit Queue Received Cost"
    view_label: "TP Transmit Queue"
    description: "Cost returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_cost END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_tax {
    label: "Transmit Queue Received Tax"
    view_label: "TP Transmit Queue"
    description: "Tax returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_tax END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_amount {
    label: "Transmit Queue Received Amount"
    view_label: "TP Transmit Queue"
    description: "Insurance paid amount returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_copay {
    label: "Transmit Queue Received Copay"
    view_label: "TP Transmit Queue"
    description: "Copay returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_copay END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_upcharge {
    label: "Transmit Queue Received Upcharge"
    view_label: "TP Transmit Queue"
    description: "Upcharge returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_upcharge END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_compound_fee {
    label: "Transmit Queue Received Compound Fee"
    view_label: "TP Transmit Queue"
    description: "Compound fee returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_compound_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_incentive_fee {
    label: "Transmit Queue Received Incentive Fee"
    view_label: "TP Transmit Queue"
    description: "Incentive fee returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_incentive_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_prof_service_fee {
    label: "Transmit Queue Recived Prof Service Fee"
    view_label: "TP Transmit Queue"
    description: "Professional service returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_prof_service_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_received_dispensing_fee {
    label: "Transmit Queue Received Dispensing Fee"
    view_label: "TP Transmit Queue"
    description: "Professional service returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_received_dispensing_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_price {
    label: "Transmit Queue Final Price"
    view_label: "TP Transmit Queue"
    description: "Re-calculated prescription price. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_price END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_cost {
    label: "Transmit Queue Final Cost"
    view_label: "TP Transmit Queue"
    description: "Re-calculated prescription cost. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_cost END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_tax {
    label: "Transmit Queue Final Tax"
    view_label: "TP Transmit Queue"
    description: "Re-calculated prescription tax. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_tax END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_copay {
    label: "Transmit Queue Final Copay"
    view_label: "TP Transmit Queue"
    description: "Re-calculated patient copay. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_copay END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_upcharge {
    label: "Transmit Queue Final Upcharge"
    view_label: "TP Transmit Queue"
    description: "Re-calculated prescription upcharge. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_upcharge END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_compound_fee {
    label: "Transmit Queue Final Compound Fee"
    view_label: "TP Transmit Queue"
    description: "Re-calculated compounding fee. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_compound_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_final_incentive_fee {
    label: "Transmit Queue Final Incentive Fee"
    view_label: "TP Transmit Queue"
    description: "Re-calculated incentive fee. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_final_incentive_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_canadian_total_fees_received {
    label: "Transmit Queue Canadian Total Fees Received"
    view_label: "TP Transmit Queue"
    description: "Claim TP Transmit Queue Canadian Total Fees Received. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_canadian_total_fees_received END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_tp_paid_amount {
    label: "Transmit Queue TP Paid Amount"
    view_label: "TP Transmit Queue"
    description: "Amount paid by the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_tp_paid_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_balance_due_from_tp {
    label: "Transmit Queue Balance Due From TP"
    view_label: "TP Transmit Queue"
    description: "Amount due from third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_balance_due_from_tp END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_accum_deductible {
    label: "Transmit Queue Accum Deductible"
    view_label: "TP Transmit Queue"
    description: "Accumulated deductible returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_accum_deductible END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_deductible_subtotal {
    label: "Transmit Queue Deductible Subtotal"
    view_label: "TP Transmit Queue"
    description: "Deductible sub-total amount received from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_deductible_subtotal END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_copay_subtotal {
    label: "Transmit Queue Copay Subtotal"
    view_label: "TP Transmit Queue"
    description: "Copay sub-total received from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_copay_subtotal END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_drug_select_amount {
    label: "Transmit Queue Drug Select Amount"
    view_label: "TP Transmit Queue"
    description: "Drug selection sub-total received from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_drug_select_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_exceed_benefit {
    label: "Transmit Queue Exceed Benefit"
    view_label: "TP Transmit Queue"
    description: "Sub-total of exceeded benefit returned from the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_exceed_benefit END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_tax_in_copay {
    label: "Transmit Queue Tax In Copay"
    view_label: "TP Transmit Queue"
    description: "Amount of tax included in the copay amount. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_tax_in_copay END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_flat_tax_amount_paid {
    label: "Transmit Queue Flat Tax Amount Paid"
    view_label: "TP Transmit Queue"
    description: "Flat tax amount paid by the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_flat_tax_amount_paid END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_remaining_benefit {
    label: "Transmit Queue Remaining Benefit"
    view_label: "TP Transmit Queue"
    description: "Amount remaining in a patient/family plan with a periodic maximum benefit. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_remaining_benefit END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_remaining_deductible {
    label: "Transmit Queue Remaining Deductible"
    view_label: "TP Transmit Queue"
    description: "Amount not met by the patient/family in the deductible plan. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_remaining_deductible END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_other_amount_claimed_2 {
    label: "Transmit Queue Other Amount Claimed 2"
    view_label: "TP Transmit Queue"
    description: "Second amount representing the additional incurred costs for a dispensed prescription or service. You can submit up to 3. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_other_amount_claimed_2 END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_other_amount_claimed_3 {
    label: "Transmit Queue Other Amount Claimed 3"
    view_label: "TP Transmit Queue"
    description: "Third amount representing the additional incurred costs for a dispensed prescription or service. You can submit up to 3. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_other_amount_claimed_3 END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_other_payer_amt_recognized {
    label: "Transmit Queue Other Payer Amt Recognized"
    view_label: "TP Transmit Queue"
    description: "Total amount recognized by the processor of any payment from another source. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_other_payer_amt_recognized END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_num_downtime_attempts {
    label: "Transmit Queue Num Downtime Attempts"
    view_label: "TP Transmit Queue"
    description: "Number of time the background adjudication process has attempted to send this claim. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_num_downtime_attempts END ;;
    value_format: "#,##0"
  }

  measure: sum_sales_tx_tp_transmit_queue_pct_tax_amount_paid {
    label: "Transmit Queue Sales Tax Amount Paid"
    view_label: "TP Transmit Queue"
    description: "Percentage sales tax amount paid by the third party. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_pct_tax_amount_paid END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_transmit_queue_pct_tax_rate_paid {
    label: "Transmit Queue Percent Tax Rate"
    view_label: "TP Transmit Queue"
    description: "Sales tax rate percentage used to calculate the percentage sales tax amount paid. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_transmit_queue_pct_tax_rate_paid END ;;
    value_format: "0.00\"%\""
  }
}

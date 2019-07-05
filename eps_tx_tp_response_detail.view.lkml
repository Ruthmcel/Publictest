view: eps_tx_tp_response_detail {
  sql_table_name: EDW.F_TX_TP_RESPONSE_DETAIL ;;

  dimension: tx_tp_response_detail_id {
    type: number
    hidden: yes
    label: "Claim TP Response Detail ID"
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_response_detail_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Claim TP Response Detail Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Claim TP Response Detail NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  ########################################################################################### End of Foreign Key References #####################################################################################################

  ######################################################################################################### Dimension ############################################################################################################

  dimension: tx_tp_response_detail_version_number {
    label: "Response Detail Version Number"
    description: "Code uniquely identifying the transmission syntax and corresponding Data Dictionary. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_VERSION_NUMBER ;;
  }

  dimension: tx_tp_response_detail_service_provider_indentifier {
    label: "Response Detail Service Provider Identifier"
    description: "ID assigned to a pharmacy or provider. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_SERVICE_PROVIDER_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_message {
    label: "Response Detail Message"
    description: "Free form message. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_MESSAGE ;;
  }

  dimension: tx_tp_response_detail_authorization_number {
    label: "Response Detail Authorization Number"
    description: "Number assigned by the processor to identify an authorized transaction. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_AUTHORIZATION_NUMBER ;;
  }

  measure: tx_tp_response_detail_percent_sales_tax_amount {
    label: "Response Detail Sales Tax Amount"
    description: "Total amount of percentage sales tax paid which is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_percent_sales_tax_rate {
    label: "Response Detail Percent Sales Tax"
    description: "Percentage sales tax rate used to calculate 'Percentage Sales Tax Amount Paid' (559-AX). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_RATE ;;
    value_format: "00.00\"%\""
  }

  dimension: tx_tp_response_detail_group_identifier {
    label: "Response Detail Group Identifier"
    description: "ID returned from the insurance processor, assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_plan_identifier {
    label: "Response Detail Plan Identifier"
    description: "Assigned by the processor to identify a set of parameters, benefit, or coverage criteria used to adjudicate a claim. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PLAN_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_network_reimbursement_identifier {
    label: "Response Detail Network Reimbursement Identifier"
    description: "Field defined by the processor. It identifies the network, for the covered member, used to calculate the reimbursement to the pharmacy. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_NETWORK_REIMBURSEMENT_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_payer_identifier {
    label: "Response Detail Payer Identifier"
    description: "ID of the payer. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PAYER_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_cardholder_identifier {
    label: "Response Detail Cardholder Identifier"
    description: "Insurance ID assigned to the cardholder or identification number used by the plan. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_CARDHOLDER_IDENTIFIER ;;
  }

  dimension: tx_tp_response_detail_medicaid_id_number {
    label: "Response Detail Medicaid ID Number"
    description: "A unique member identification number assigned by the Medicaid Agency. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_MEDICAID_ID_NUMBER ;;
  }

  dimension: tx_tp_response_detail_medicaid_agency_number {
    label: "Response Detail Medicaid Agency Number"
    description: "Number assigned by processor to identify the individual Medicaid Agency or representative. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_MEDICAID_AGENCY_NUMBER ;;
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: tx_tp_response_detail_transaction_code {
    label: "Response Detail Transaction Code"
    description: "Code identifying the type of transaction. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_TRANSACTION_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_TRANSACTION_CODE') ;;
    suggestions: [
      "BILLING",
      "REVERSAL",
      "REBILL",
      "CONTROLLED SUBSTANCE REPORTING",
      "CONTROLLED SUBSTANCE REPORTING REVERSAL",
      "CONTROLLED SUBSTANCE REPORTING REBILL",
      "PREDETERMINATION OF BENEFITS",
      "ELIGIBILITY VERIFICATION",
      "INFORMATION REPORTING",
      "INFORMATION REPORTING REVERSAL",
      "INFORMATION REPORTING REBILL",
      "P.A. REQUEST AND BILLING",
      "P.A. REVERSAL",
      "P.A. INQUIRY",
      "P.A. REQUEST ONLY",
      "SERVICE BILLING",
      "SERVICE REVERSAL",
      "SERVICE REBILL"
    ]
  }

  dimension: tx_tp_response_detail_transmit_status {
    label: "Response Detail Transmit Status"
    description: "Code indicating the status of the transmission. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_TRANSMIT_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_TRANSMIT_STATUS') ;;
    suggestions: ["ACCEPTED", "REJECTED"]
  }

  dimension: tx_tp_response_detail_service_provider_id_qualifier {
    label: "Response Detail Service Provider ID Qualifier"
    description: "Code qualifying the 'Service Provider ID' (201-B1). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_SERVICE_PROVIDER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_SERVICE_PROVIDER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PROVIDER IDENTIFIER (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UNIQUE PHYSICIAN/PRACTITIONER IDENTIFICATION NUMBER",
      "NCPDP PROVIDER IDENTIFICATION NUMBER",
      "STATE LICENSE",
      "CIVILIAN HEALTH AND MEDICAL PROGRAM OF THE UNIFORMED SERVICES",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DRUG ENFORCEMENT ADMINISTRATION (DEA) NUMBER",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "HCID (HC IDEA)",
      "COMBAT METHAMPHETAMINE EPIDEMIC ACT (CMEA) CERTIFICATE ID",
      "OTHER"
    ]
  }

  dimension: tx_tp_response_detail_transaction_status {
    label: "Response Detail Transaction Status"
    description: "Code indicating the status of the transaction. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_TRANSACTION_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_TRANSACTION_STATUS') ;;
    suggestions: ["NOT SPECIFIED", "PAYER/PLAN NOT RESPONSIBLE FOR TAX", "NOT TAX EXEMPT", "PATIENT IS TAX EXEMPT", "PAYER/PLAN AND PATIENT ARE TAX EXEMPT"]
  }

  dimension: tx_tp_response_detail_tax_exempt_indicator {
    label: "Response Detail Tax Exempt Indicator"
    description: "Indicates whether the payer and/or the patient is exempt from taxes. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR IS NULL ;;
        label: "NOT SPECIFIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR = 1 ;;
        label: "PAYER/PLAN NOT RESPONSIBLE FOR TAX"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR = 2 ;;
        label: "NOT TAX EXEMPT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR = 3 ;;
        label: "PATIENT IS TAX EXEMPT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR = 4 ;;
        label: "PAYER/PLAN AND PATIENT ARE TAX EXEMPT"
      }
    }
  }

  # Replaced Master code subquery with SQL case because of Internal Incident Error on SF side #6961. Need to revert back when issue get fixed.
  #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION)
  #        FROM EDW.D_MASTER_CODE MC
  #       WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR AS VARCHAR),'NULL')
  #      AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_TAX_EXEMPT_INDICATOR')
  #suggestions: []

  dimension: tx_tp_response_detail_precent_sales_tax_basis {
    label: "Response Detail Percent Sales Tax Basis"
    description: "Indicates the percentage sales tax paid basis. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_BASIS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_BASIS') ;;
    suggestions: ["NOT SPECIFIED", "GROSS AMOUNT DUE", "INGREDIENT COST", "INGREDIENT COST + DISPENSING FEE"]
  }

  dimension: tx_tp_response_detail_basis_of_calculation {
    label: "Response Detail Basis Of Calculation"
    description: "Indicates how the Coinsurance reimbursement amount was calculated for 'Patient Pay Amount' (505-F5). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_BASIS_OF_CALCULATION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_BASIS_OF_CALCULATION') ;;
    suggestions: [
      "NOT SPECIFIED",
      "QUANTITY DISPENSED",
      "QUANTITY INTENDED TO BE DISPENSED",
      "USUAL AND CUSTOMARY/PRORATED",
      "WAIVED DUE TO PARTIAL FILL",
      "OTHER"
    ]
  }

  dimension: tx_tp_response_detail_reimbursement_determination_basis {
    label: "Response Detail Reimbursement Determination Basis"
    description: "identify how the reimbursement amount was calculated for 'Ingredient Cost Paid' (506-F6). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_REIMBURSEMENT_DETERMINATION_BASIS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_REIMBURSEMENT_DETERMINATION_BASIS') ;;
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
      "AVERAGE SALES PRICE",
      "AVERAGE MANUFACTURER PRICE",
      "340B/DISPROPORTIONATE SHARE/PUBLIC HEALTH SERVICE PRICING",
      "WAC (WHOLESALE ACQUISITION COST)",
      "OTHER PAYER-PATIENT RESPONSIBILITY AMOUNT",
      "PATIENT PAY AMOUNT",
      "COUPON PAYMENT",
      "SPECIAL PATIENT REIMBURSEMENT",
      "DIRECT PRICE",
      "STATE FEE SCHEDULE (SFS) REIMBURSEMENT",
      "NATIONAL AVERAGE DRUG ACQUISITION COST",
      "STATE AVERAGE ACQUISITION COST"
    ]
  }

  dimension: tx_tp_response_detail_payer_to_qualifier {
    label: "Response Detail Payer ID Qualifier"
    description: "indicates the type of payer ID. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_PAYER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_PAYER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PAYER IDENTIFIER MANDATED UNDER HIPAA",
      "HEALTH INDUSTRY NUMBER",
      "BANK INFORMATION NUMBER",
      "NATIONAL ASSOCIATION OF INSURANCE COMMISSIONERS",
      "OTHER- DIFFERENT FROM THOSE IMPLIED OR SPECIFIED."
    ]
  }

  ########################################################################################################## Date/Time Dimensions #############################################################################################

  dimension_group: tx_tp_response_detail_date_of_service {
    label: "Response Detail Service"
    description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
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
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_DATE_OF_SERVICE ;;
  }

  #[ERXLPS-726] Date reference dimension for sales explore
  dimension: tx_tp_response_detail_service_reference {
    hidden: yes
    label: "Response Detail Service"
    description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_DATE_OF_SERVICE ;;
  }

  ################################################################################################### End of Date/Time Dimensions #############################################################################################

  ############################################################################################################### Measures #################################################################################################

  measure: tx_tp_response_detail_periodic_deductible_amount {
    label: "Response Detail Periodic Deductible Amount"
    description: "Total amount to be collected from a patient that is included in 'Patient Pay Amount' (505-F5) that is applied to a periodic deductible. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PERIODIC_DEDUCTIBLE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_copay_amount {
    label: "Response Detail Copay Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to a per prescription copay. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_COPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_coinsurance_amount {
    label: "Response Detail Coinsurance Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to a per prescription coinsurance. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_COINSURANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_exceed_period_benefit_maximum_amount {
    label: "Response Detail Exceed Period Benefit Maximum Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient exceeding a periodic benefit maximum. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_EXCEED_PERIOD_BENEFIT_MAXIMUM_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_processor_amount_fee {
    label: "Response Detail Processor Amount Fee"
    description: "Total amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the processing fee imposed by the processor. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PROCESSOR_AMOUNT_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_tax_amount {
    label: "Response Detail Attributed Tax Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to sales tax paid. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_pns_amount {
    label: "Response Detail Attributed PNS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's provider network selection. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PNS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_ps_brand_amount {
    label: "Response Detail Attributed PS Brand Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Brand product. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_BRAND_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_ps_npfs_amount {
    label: "Response Detail Attributed PS NPFS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Non-Preferred Formulary product. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_NPFS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_ps_bnpfs_amount {
    label: "Response Detail Attributed PS BNPFS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Brand Non-Preferred Formulary product. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_BNPFS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_attributed_coverage_gap_amount {
    label: "Response Detail Attributed Coverage Gap Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient being in the coverage gap (for example Medicare Part D Coverage Gap). A coverage gap is defined as the period or amount during which the previous coverage ends and before an additional coverage begins. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_COVERAGE_GAP_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_hp_fund_assistance_amount {
    label: "Response Detail HP Fund Assistance Amount"
    description: "Total amount from the health plan-funded assistance account for the patient that was applied to reduce Patient Pay Amount (505-F5). This amount is used in Healthcare Reimbursement Account (HRA) benefits only. This field is always a negative amount or zero. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_HP_FUND_ASSISTANCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_patient_pay_amount {
    label: "Response Detail Patient Pay Amount"
    description: "Total amount that is calculated by the processor and returned to the pharmacy as the TOTAL amount to be paid by the patient to the pharmacy. The patient's total cost share, including copayments, amounts applied to deductible, over maximum amounts, penalties, etc. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PATIENT_PAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_ingredient_amount {
    label: "Response Detail Ingredient Amount"
    description: "Informational field used when Other Payer-Patient Responsibility Amount (352-NQ) or Patient Pay Amount (505-F5) is used for reimbursement. Amount is equal to contracted or reimbursable amount for product being dispensed. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_INGREDIENT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_dispensing_fee_paid {
    label: "Response Detail Dispensing Fee Paid"
    description: "Dispensing fee paid included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_DISPENSING_FEE_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_professional_service_fee_paid {
    label: "Response Detail Professional Serivce Fee Paid"
    description: "Professional Service fee paid included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PROFESSIONAL_SERVICE_FEE_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_incentive_fee_paid_amount {
    label: "Response Detail Incentive Fee Paid"
    description: "Total amount represents the contractually agreed upon incentive fee paid for specific services rendered. Amount is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_INCENTIVE_FEE_PAID_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_flat_sales_tax_amount {
    label: "Response Detail Flat Sales Tax Amount"
    description: "Total flat sales tax paid which is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_FLAT_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_payer_recognized_amount {
    label: "Response Detail Payer Recognized Amount"
    description: "Total amount recognized by the processor of any payment from another source. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PAYER_RECOGNIZED_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_total_amount_paid {
    label: "Response Detail Total Amount Paid"
    description: "Total amount to be paid by the claims processor (i.e. pharmacy receivable). Represents a sum of 'Ingredient Cost Paid' (506-F6), 'Dispensing Fee Paid' (507-F7), 'Flat Sales Tax Amount Paid' (558-AW), 'Percentage Sales Tax Amount Paid' (559-AX), 'Incentive Amount Paid' (521-FL), 'Professional Service Fee Paid' (562-J1), 'Other Amount Paid' (565-J4), less 'Patient Pay Amount' (505-F5) and 'Other Payer Amount Recognized' (566-J5). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_TOTAL_AMOUNT_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_patient_sales_tax {
    label: "Response Detail Patient Sales Tax"
    description: "Patient sales tax responsibility. This field is not a component of the Patient Pay Amount (505-F5) formula. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PATIENT_SALES_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_plan_sales_tax {
    label: "Response Detail Plan Sales Tax"
    description: "Plan sales tax responsibility. This field is not a component of the Patient Pay Amount (505-F5) formula. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_PLAN_SALES_TAX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_accumulated_deductible_amount {
    label: "Response Detail Accumulated Deductible Amount"
    description: "Total amount in dollars met by the patient/family in a deductible plan. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ACCUMULATED_DEDUCTIBLE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_remaining_deductible_amount {
    label: "Response Detail Remaining Deductible Amount"
    description: "Total amount not met by the patient/family in the deductible plan. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_REMAINING_DEDUCTIBLE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_remaining_benefit_amount {
    label: "Response Detail Remaining Benefit Amount"
    description: "Total amount remaining in a patient/family plan with a periodic maximum benefit. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_REMAINING_BENEFIT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_estimated_generic_savings_amount {
    label: "Response Detail Estimated Generic Savings Amount"
    description: "The amount, not included in the Total Amount Paid (509-F9), that the patient would have saved if they had chosen the generic drug instead of the brand drug. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ESTIMATED_GENERIC_SAVINGS_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_response_detail_spending_account_remaining_amount {
    label: "Response Detail Spending Account Remaining Amount"
    description: "The balance from the patient's spending account after this transaction was applied. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_SPENDING_ACCOUNT_REMAINING_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-726] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sum_sales_tx_tp_response_detail_percent_sales_tax_amount {
    label: "Response Detail Sales Tax Amount"
    description: "Total amount of percentage sales tax paid which is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_percent_sales_tax_rate {
    label: "Response Detail Percent Sales Tax"
    description: "Percentage sales tax rate used to calculate 'Percentage Sales Tax Amount Paid' (559-AX). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PERCENT_SALES_TAX_RATE END ;;
    value_format: "00.00\"%\""
  }

  measure: sum_sales_tx_tp_response_detail_periodic_deductible_amount {
    label: "Response Detail Periodic Deductible Amount"
    description: "Total amount to be collected from a patient that is included in 'Patient Pay Amount' (505-F5) that is applied to a periodic deductible. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PERIODIC_DEDUCTIBLE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_copay_amount {
    label: "Response Detail Copay Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to a per prescription copay. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_COPAY_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_coinsurance_amount {
    label: "Response Detail Coinsurance Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to a per prescription coinsurance. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_COINSURANCE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_exceed_period_benefit_maximum_amount {
    label: "Response Detail Exceed Period Benefit Maximum Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient exceeding a periodic benefit maximum. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_EXCEED_PERIOD_BENEFIT_MAXIMUM_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_processor_amount_fee {
    label: "Response Detail Processor Amount Fee"
    description: "Total amount to be collected from the patient that is included in Patient Pay Amount (505-F5) that is due to the processing fee imposed by the processor. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PROCESSOR_AMOUNT_FEE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_tax_amount {
    label: "Response Detail Attributed Tax Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to sales tax paid. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_TAX_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_pns_amount {
    label: "Response Detail Attributed PNS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's provider network selection. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PNS_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_ps_brand_amount {
    label: "Response Detail Attributed PS Brand Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Brand product. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_BRAND_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_ps_npfs_amount {
    label: "Response Detail Attributed PS NPFS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Non-Preferred Formulary product. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_NPFS_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_ps_bnpfs_amount {
    label: "Response Detail Attributed PS BNPFS Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient's selection of a Brand Non-Preferred Formulary product. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_PS_BNPFS_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_attributed_coverage_gap_amount {
    label: "Response Detail Attributed Coverage Gap Amount"
    description: "Total amount to be collected from the patient that is included in 'Patient Pay Amount' (505-F5) that is due to the patient being in the coverage gap (for example Medicare Part D Coverage Gap). A coverage gap is defined as the period or amount during which the previous coverage ends and before an additional coverage begins. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ATTRIBUTED_COVERAGE_GAP_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_hp_fund_assistance_amount {
    label: "Response Detail HP Fund Assistance Amount"
    description: "Total amount from the health plan-funded assistance account for the patient that was applied to reduce Patient Pay Amount (505-F5). This amount is used in Healthcare Reimbursement Account (HRA) benefits only. This field is always a negative amount or zero. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_HP_FUND_ASSISTANCE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_patient_pay_amount {
    label: "Response Detail Patient Pay Amount"
    description: "Total amount that is calculated by the processor and returned to the pharmacy as the TOTAL amount to be paid by the patient to the pharmacy. The patient's total cost share, including copayments, amounts applied to deductible, over maximum amounts, penalties, etc. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PATIENT_PAY_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_ingredient_amount {
    label: "Response Detail Ingredient Amount"
    description: "Informational field used when Other Payer-Patient Responsibility Amount (352-NQ) or Patient Pay Amount (505-F5) is used for reimbursement. Amount is equal to contracted or reimbursable amount for product being dispensed. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_INGREDIENT_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_dispensing_fee_paid {
    label: "Response Detail Dispensing Fee Paid"
    description: "Dispensing fee paid included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_DISPENSING_FEE_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_professional_service_fee_paid {
    label: "Response Detail Professional Serivce Fee Paid"
    description: "Professional Service fee paid included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PROFESSIONAL_SERVICE_FEE_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_incentive_fee_paid_amount {
    label: "Response Detail Incentive Fee Paid"
    description: "Total amount represents the contractually agreed upon incentive fee paid for specific services rendered. Amount is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_INCENTIVE_FEE_PAID_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_flat_sales_tax_amount {
    label: "Response Detail Flat Sales Tax Amount"
    description: "Total flat sales tax paid which is included in the 'Total Amount Paid' (509-F9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_FLAT_SALES_TAX_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_payer_recognized_amount {
    label: "Response Detail Payer Recognized Amount"
    description: "Total amount recognized by the processor of any payment from another source. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PAYER_RECOGNIZED_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_total_amount_paid {
    label: "Response Detail Total Amount Paid"
    description: "Total amount to be paid by the claims processor (i.e. pharmacy receivable). Represents a sum of 'Ingredient Cost Paid' (506-F6), 'Dispensing Fee Paid' (507-F7), 'Flat Sales Tax Amount Paid' (558-AW), 'Percentage Sales Tax Amount Paid' (559-AX), 'Incentive Amount Paid' (521-FL), 'Professional Service Fee Paid' (562-J1), 'Other Amount Paid' (565-J4), less 'Patient Pay Amount' (505-F5) and 'Other Payer Amount Recognized' (566-J5). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_TOTAL_AMOUNT_PAID END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_patient_sales_tax {
    label: "Response Detail Patient Sales Tax"
    description: "Patient sales tax responsibility. This field is not a component of the Patient Pay Amount (505-F5) formula. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PATIENT_SALES_TAX END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_plan_sales_tax {
    label: "Response Detail Plan Sales Tax"
    description: "Plan sales tax responsibility. This field is not a component of the Patient Pay Amount (505-F5) formula. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_PLAN_SALES_TAX END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_accumulated_deductible_amount {
    label: "Response Detail Accumulated Deductible Amount"
    description: "Total amount in dollars met by the patient/family in a deductible plan. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ACCUMULATED_DEDUCTIBLE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_remaining_deductible_amount {
    label: "Response Detail Remaining Deductible Amount"
    description: "Total amount not met by the patient/family in the deductible plan. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_REMAINING_DEDUCTIBLE_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_remaining_benefit_amount {
    label: "Response Detail Remaining Benefit Amount"
    description: "Total amount remaining in a patient/family plan with a periodic maximum benefit. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_REMAINING_BENEFIT_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_estimated_generic_savings_amount {
    label: "Response Detail Estimated Generic Savings Amount"
    description: "The amount, not included in the Total Amount Paid (509-F9), that the patient would have saved if they had chosen the generic drug instead of the brand drug. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_ESTIMATED_GENERIC_SAVINGS_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_response_detail_spending_account_remaining_amount {
    label: "Response Detail Spending Account Remaining Amount"
    description: "The balance from the patient's spending account after this transaction was applied. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_SPENDING_ACCOUNT_REMAINING_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

############################################################################ Sets ############################################################
  #[ERXLPS-726] New set created for dimensions only to include in sales explore
  set: sales_tx_tp_response_detial_dimension_candidate_list {
    fields: [
      tx_tp_response_detail_version_number,
      tx_tp_response_detail_service_provider_indentifier,
      tx_tp_response_detail_message,
      tx_tp_response_detail_authorization_number,
      tx_tp_response_detail_group_identifier,
      tx_tp_response_detail_plan_identifier,
      tx_tp_response_detail_network_reimbursement_identifier,
      tx_tp_response_detail_payer_identifier,
      tx_tp_response_detail_cardholder_identifier,
      tx_tp_response_detail_medicaid_id_number,
      tx_tp_response_detail_medicaid_agency_number,
      tx_tp_response_detail_transaction_code,
      tx_tp_response_detail_transmit_status,
      tx_tp_response_detail_service_provider_id_qualifier,
      tx_tp_response_detail_transaction_status,
      tx_tp_response_detail_tax_exempt_indicator,
      tx_tp_response_detail_precent_sales_tax_basis,
      tx_tp_response_detail_basis_of_calculation,
      tx_tp_response_detail_reimbursement_determination_basis,
      tx_tp_response_detail_payer_to_qualifier
    ]
  }

  #[ERXLPS-726] New set created to exclude sales specific measures from other explores
  set: explore_sales_specific_candidate_list {
    fields: [
      sum_sales_tx_tp_response_detail_percent_sales_tax_amount,
      sum_sales_tx_tp_response_detail_percent_sales_tax_rate,
      sum_sales_tx_tp_response_detail_periodic_deductible_amount,
      sum_sales_tx_tp_response_detail_copay_amount,
      sum_sales_tx_tp_response_detail_coinsurance_amount,
      sum_sales_tx_tp_response_detail_exceed_period_benefit_maximum_amount,
      sum_sales_tx_tp_response_detail_processor_amount_fee,
      sum_sales_tx_tp_response_detail_attributed_tax_amount,
      sum_sales_tx_tp_response_detail_attributed_pns_amount,
      sum_sales_tx_tp_response_detail_attributed_ps_brand_amount,
      sum_sales_tx_tp_response_detail_attributed_ps_npfs_amount,
      sum_sales_tx_tp_response_detail_attributed_ps_bnpfs_amount,
      sum_sales_tx_tp_response_detail_attributed_coverage_gap_amount,
      sum_sales_tx_tp_response_detail_hp_fund_assistance_amount,
      sum_sales_tx_tp_response_detail_patient_pay_amount,
      sum_sales_tx_tp_response_detail_ingredient_amount,
      sum_sales_tx_tp_response_detail_dispensing_fee_paid,
      sum_sales_tx_tp_response_detail_professional_service_fee_paid,
      sum_sales_tx_tp_response_detail_incentive_fee_paid_amount,
      sum_sales_tx_tp_response_detail_flat_sales_tax_amount,
      sum_sales_tx_tp_response_detail_payer_recognized_amount,
      sum_sales_tx_tp_response_detail_total_amount_paid,
      sum_sales_tx_tp_response_detail_patient_sales_tax,
      sum_sales_tx_tp_response_detail_plan_sales_tax,
      sum_sales_tx_tp_response_detail_accumulated_deductible_amount,
      sum_sales_tx_tp_response_detail_remaining_deductible_amount,
      sum_sales_tx_tp_response_detail_remaining_benefit_amount,
      sum_sales_tx_tp_response_detail_estimated_generic_savings_amount,
      sum_sales_tx_tp_response_detail_spending_account_remaining_amount
    ]
  }
}

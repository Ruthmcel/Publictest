view: ar_transaction_info {
  label: "Transaction Info"
  sql_table_name: EDW.F_TRANSACTION_INFO ;;



  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_id} ;;
  }


  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_id {
    hidden:  yes
    label: "Transaction ID"
    description: "Unique Identification Number of the Transaction table"
    type: number
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: transaction_info_group_code {
    label: "Group Code"
    description: "Third party plan group code"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_GROUP_CODE ;;
  }

  dimension: transaction_info_drug_brand_generic_reference {
    hidden:  yes
    label: "Drug BRAND/GENERIC"
    type: string
    sql: ${drug.drug_brand_generic} ;;
  }

  dimension: transaction_info_patient_identifier {
    label: "Patient Identifier"
    description: "ID of the patient"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_IDENTIFIER ;;
  }

  dimension: transaction_info_card_number {
    label: "Card Number"
    description: "Identification number on the insurance card"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_CARD_NUMBER ;;
  }

  dimension: transaction_info_card_name {
    label: "Card Name"
    description: "Name of the cardholder on the insurance card"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_CARD_NAME ;;
  }

  dimension: drug_ndc {
    label: "Drug NDC"
    description: "NDC of the drug used for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DRUG_NDC ;;
  }

  dimension: transaction_info_drug_name {
    label: "Drug Name"
    description: "Name of the drug used for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DRUG_NAME ;;
  }

  dimension: transaction_info_credit_return_tx_number {
    label: "Credit Return Tx Number"
    description: "Transaction number of the credit returned transaction"
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_CREDIT_RETURN_TX_NUMBER ;;
    value_format: "######"
  }

  dimension: transaction_info_tp_reference_number {
    label: "TP Reference Number"
    description: "Reference number returned in the third party response"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_TP_REFERENCE_NUMBER ;;
  }

  dimension: transaction_info_price_code {
    label: "Price Code"
    description: "Price code used to price this prescription transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRICE_CODE ;;
  }


  dimension: transaction_info_patient_name {
    label: "Patient Name"
    description: "Full name of the patient, reported from transaction info"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_NAME ;;
  }

  dimension_group: transaction_info_birth_date {
    label: "Patient Birth Date"
    description: "Date of birth of the patient for this transaction"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_BIRTH_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_other_coverage_code {
    label: "Other Coverage Code"
    description: "Code indicating whether or not the patient has other insurance coverage."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_OTHER_COVERAGE_CODE ;;
  }

  dimension: transaction_info_generic_code {
    label: "Drug Generic Code"
    description: "Flag that indicates drug source, reported from transaction info"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_GENERIC_CODE ;;
  }

  dimension: transaction_info_bin_number {
    label: "BIN Number"
    description: "BIN number to which claim was transmitted for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_BIN_NUMBER ;;
  }

  dimension: transaction_info_pcn_number {
    label: "PCN Number"
    description: "Processor control number used for claim transmittal for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PCN_NUMBER ;;
  }

  dimension: transaction_info_bin_pcn_number {
    label: "BIN-PCN Number"
    description: "Concatenated value of BIN and PCN to allow for filtering specific BIN-PCN values. Concatenated values include a hyphen; example 001234-MEDPCN."
    type: string
    sql: CASE WHEN ${transaction_info_bin_number} IS NULL AND ${transaction_info_pcn_number} IS NULL THEN NULL ELSE CONCAT(CONCAT(NVL(REGEXP_REPLACE(${transaction_info_bin_number}, '[[:space:]]*',''),''), '-'),NVL(REGEXP_REPLACE(${transaction_info_pcn_number}, '[[:space:]]*',''),'')) END ;;
  }


  dimension: transaction_info_prescriber_identifier {
    label: "Prescriber Identifier"
    description: "ID of the prescriber for this prescription transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRESCRIBER_IDENTIFIER ;;
  }

  dimension: transaction_info_prescriber_last_name {
    label: "Prescriber Last Name"
    description: "Last name of the prescriber for this prescription transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRESCRIBER_LAST_NAME ;;
  }

  dimension: transaction_info_prescriber_first_name {
    label: "Prescriber First Name"
    description: "First name of the prescriber for this prescription transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: transaction_info_compound_code_flag {
    label: "Compound Code Flag"
    description: "Flag column indicating if the drug dispensed is a compounded drug or not"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_COMPOUND_CODE_FLAG ;;
  }

  dimension: transaction_info_daw {
    label: "DAW Code"
    description: "Third party dispensed as written flag that indicates which DAW code was assigned during data entry. "
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DAW ;;
  }

  dimension: transaction_info_patient_group {
    label: "Patient Group Code"
    description: "Group code for this patient for processing or reports"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_GROUP ;;
  }

  dimension: transaction_info_drug_group {
    label: "Drug Group Code"
    description: "Group code for the drug used (for processing or reporting)"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DRUG_GROUP ;;
  }

  dimension: transaction_info_doctor_code {
    label: "Doctor Code"
    description: "Doctor Code for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DOCTOR_CODE ;;
    }

    dimension: transaction_info_icd9 {
    label: "ICD9 Code"
    description: "ICD9 Code selected during data entry for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_ICD9 ;;
  }

  dimension: transaction_info_drug_state_code {
    label: "Drug State Code"
    description: "Drug State Code"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DRUG_STATE_CODE ;;
  }

  dimension_group: transaction_info_injury_date {
    label: "Injury"
    description: "Date of injury"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_INJURY_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_basis_of_reimbursement {
    label: "Basis Of Reimbursement"
    description: "Basis of Reimbursement Determination.  This tells us how the TP decided to pay this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_BASIS_OF_REIMBURSEMENT ;;
  }

  #[ERXDWPS-5779]ARND-11448] - Standard MAC Incorrect - was 'Y' changed to 'N'
  dimension: transaction_info_standard_mac {
    label: "Standard MAC"
    description: "Standard maximum allowable cost."
    type: yesno
    sql: ${transaction_info_basis_of_reimbursement} IN ('6','7','06','07')
         AND ${paid_at_uc_price_yesno} = 'N' ;;
  }

  dimension: transaction_info_network_reimbursement_id {
    label: "Network Reimbursement ID"
    description: "This is a field that some TPs send back in the online adjudication response.  It can be tied back to a CONTRACT_RATE record"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_NETWORK_REIMBURSEMENT_ID ;;
  }

  dimension: transaction_info_tp_reference_number_reverse {
    label: "TP Reference Number Reversal"
    description: "Third party reference number returned in the response from the third party when the claim for this transaction is reversed"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_TP_REFERENCE_NUMBER_REVERSE ;;
  }

  dimension_group: transaction_info_written_date {
    label: "Written"
    description: "Date this prescription transaction was written"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_WRITTEN_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: transaction_info_first_filled_date {
    label: "First Filled"
    description: "Date of the original fill for the prescription"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_FIRST_FILLED_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_refills_authorized {
    label: "Refills Authorized"
    description: "Number of refills authorized for this prescription"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_REFILLS_AUTHORIZED ;;
  }

  dimension: transaction_info_rx_origin {
    label: "Rx Origin"
    description: "Indicates the origin of the prescription"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RX_ORIGIN ;;
  }

  dimension: transaction_info_rx_group {
    label: "Rx Group Code"
    description: "Group code for this prescription for use in processing or reporting"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RX_GROUP ;;
  }

  dimension: transaction_info_days_supply_basis {
    label: "Days Supply Basis"
    description: "Bases for which days supply is calculated"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DAYS_SUPPLY_BASIS ;;
  }

  dimension: transaction_info_unit_dose_flag {
    label: "Unit Dose Flag"
    description: "Flag that determines if this drug is a unit dose drug."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_UNIT_DOSE_FLAG ;;
  }

  dimension: transaction_info_rph_initials {
    label: "RPH Initials"
    description: "Initials of the pharmacist on record"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RPH_INITIALS ;;
  }

  dimension: transaction_info_rph_name {
    label: "RPH Name"
    description: "Name of the pharmacist"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RPH_NAME ;;
  }

  dimension: transaction_info_prior_auth_code {
    label: "Prior Auth Code"
    description: "Flag that indicates what type of prior authorization this record represents"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRIOR_AUTH_CODE ;;
  }

  dimension: transaction_info_tp_flag_1 {
    label: "TP Flag 1"
    description: "Miscellaneous third party flag number 1"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_TP_FLAG_1 ;;
  }

  dimension: transaction_info_tp_flag_2 {
    label: "TP Flag 2"
    description: "Miscellaneous third party flag number 2"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_TP_FLAG_2 ;;
  }

  dimension: transaction_info_copay_override_flag {
    label: "Copay Override Flag"
    description: "Flag indicating if a copay override was performed"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_COPAY_OVERRIDE_FLAG ;;
  }

  dimension_group: transaction_info_denial_date {
    label: "Claim Denial"
    description: "Date the claim was denied by the third party"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_DENIAL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_store_paid_indicator {
    label: "Pharmacy Paid Indicator"
    description: "Store Paid Indicator for this transaction"
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_STORE_PAID_INDICATOR ;;
    }

    dimension: transaction_info_store_part_pay {
    label: "Pharmacy Partially Paid"
    description: "Pharmacy Partially paid for this transaction"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_STORE_PART_PAY ;;
    }

    dimension: transaction_info_prior_auth_number {
    label: "Prior Auth Number"
    description: "Priori Authorization Number"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PRIOR_AUTH_NUMBER ;;
  }

  dimension: transaction_info_place_of_service {
    label: "Place Of Service Code"
    description: "Code identifying the place where a drug or service is dispensed or administered."
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_PLACE_OF_SERVICE ;;
  }

  dimension: transaction_info_dur_service_code {
    label: "DUR Service Code"
    description: "Code identifying pharmacist intervention when a conflict code has been identified or service has been rendered"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DUR_SERVICE_CODE ;;
  }

  dimension: transaction_info_dur_reason_code {
    label: "DUR Reason Code"
    description: "Code identifying the type of utilization conflict detected by the prescriber or the pharmacist or the reason for the pharmacist's professional service."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DUR_REASON_CODE ;;
  }

  dimension: transaction_info_dur_result_code {
    label: "DUR Result Code"
    description: "Action taken by a pharmacist or prescriber in response to a conflict or the result of a pharmacist's professional service."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DUR_RESULT_CODE ;;
  }

  dimension: transaction_info_store_sd_maint_flag {
    label: "Pharmacy SD Maintenance Flag"
    description: "Pharmacy SD Maintenance Flag"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_STORE_SD_MAINT_FLAG ;;
    }

    dimension: transaction_info_store_sd_mac_flag {
    label: "Pharmacy SD MAC Flag"
    description: "Pharmacy SD MAC Flag"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_STORE_SD_MAC_FLAG ;;
    }

    dimension: transaction_info_store_nurse_home_flag {
    label: "Pharmacy Nurse Home Flag"
    description: "Pharmacy Nurse Home Flag"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_STORE_NURSE_HOME_FLAG ;;
    }

    dimension: transaction_info_eligibility_override {
    label: "Eligibility Override Code"
    description: "Code indicating that the pharmacist is clarifying eligibility for a patient"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_ELIGIBILITY_OVERRIDE ;;
  }

  dimension: transaction_info_relationship_code {
    label: "Relationship Code"
    description: "Patient relationship code indicating patient's relationship to cardholder"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RELATIONSHIP_CODE ;;
  }

  dimension: transaction_info_store_other_insurance_flag {
    label: "Pharmacy Other Insurance Flag"
    description: "Pharmacy Other Insurance Flag"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_STORE_OTHER_INSURANCE_FLAG ;;
    }

    dimension: transaction_info_dependent_number {
    label: "Child Code"
    description: "Dependent number or child code"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DEPENDENT_NUMBER ;;
  }

  dimension: transaction_info_patient_location {
    label: "Patient Location"
    description: "Location of the patient when receiving pharmacy services"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_LOCATION ;;
  }

  dimension_group: transaction_info_card_effective_date {
    label: "Card Effective"
    description: "Date the card becomes effective, reported from transaction info"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_CARD_EFFECTIVE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: transaction_info_card_end_date {
    label: "Card End"
    description: "Date the card expires"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_CARD_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_received_plan_number {
    label: "Received Plan Number"
    description: "Received Plan Number for this transaction, reported from transaction info"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_RECEIVED_PLAN_NUMBER ;;
    }

    dimension_group: transaction_info_will_call_picked_up_date {
    label: "Will Call Picked Up"
    description: "Date/Time that a prescription was sold out of Will Call by a User or a POS system"
    type: time
    sql: ${TABLE}.TRANSACTION_INFO_WILL_CALL_PICKED_UP_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: transaction_info_store_plan_type {
    label: "Pharmacy Plan Type"
    description: "Pharmacy Plan Type"
    hidden:  yes
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_STORE_PLAN_TYPE ;;
    value_format: "######"
    }

    dimension: transaction_info_patient_nursing_home_flag {
    label: "Patient Nursing Home Flag"
    description: "Flag indicating if patient is considered a nursing home patient"
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_NURSING_HOME_FLAG ;;
  }

  dimension: transaction_info_approved_message_code_1 {
    label: "Approved Message Code 1"
    description: "Message code1, on an approved claim/service, communicating the need for an additional follow-up."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_APPROVED_MESSAGE_CODE_1 ;;
  }

  dimension: transaction_info_approved_message_code_2 {
    label: "Approved Message Code 2"
    description: "Message code2, on an approved claim/service, communicating the need for an additional follow-up."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_APPROVED_MESSAGE_CODE_2 ;;
  }

  dimension: transaction_info_approved_message_code_3 {
    label: "Approved Message Code 3"
    description: "Message code3, on an approved claim/service, communicating the need for an additional follow-up."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_APPROVED_MESSAGE_CODE_3 ;;
  }

  dimension: transaction_info_approved_message_code_4 {
    label: "Approved Message Code 4"
    description: "Message code4, on an approved claim/service, communicating the need for an additional follow-up."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_APPROVED_MESSAGE_CODE_4 ;;
  }

  dimension: transaction_info_approved_message_code_5 {
    label: "Approved Message Code 5"
    description: "Message code5, on an approved claim/service, communicating the need for an additional follow-up."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_APPROVED_MESSAGE_CODE_5 ;;
  }

  dimension: transaction_info_deleted {
    hidden:  yes
    label: "Deleted"
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table."
    type: string
    sql: ${TABLE}.TRANSACTION_INFO_DELETED ;;
  }

  #[ERXLPS-6279] - Reference dimensions created to use in other dimnesion/measure calculations.
  dimension: transaction_info_uc_price_reference {
    label: "U&C Price"
    description: "Total Usual and Customary price of the drug filled for this transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_INFO_UC_PRICE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
#################################################################################### Master code dimensions ############################################################################################################


  dimension: transaction_info_store_paid_indicator_mc {
    label: "Pharmacy Paid Indicator"
    description: "Store Paid Indicator for this transaction"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_INFO_STORE_PAID_INDICATOR) ;;
    suggestions: ["OPEN", "MANUAL CLOSE", "RECONCILED","CLM W/O ORIG SALES"]
  }

  dimension: transaction_info_place_of_service_mc {
    label: "Place Of Service Code"
    description: "Code identifying the place where a drug or service is dispensed or administered."
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_INFO_PLACE_OF_SERVICE) ;;
    suggestions: ["MANUAL CLOSE", "RECONCILED","CLM W/O ORIG SALES","PAID IN FULL","BANKRUPTCY","CUSTOMER REQUEST","OPEN NEW SALE","PARTIAL PAY","MANUAL SALES ADJ","OVERPAY","AUTO CLOSE","RESUBMISSION",
      "PAPER","ELECTRONIC","POST CORRECTION","DISK","PAPER","TAPE","STANDARD HSTOUT","MISSING NON-PDX DATA","TOTAL #TX IN SALES_AUDIT_TOTAL <5"]
  }

  dimension: transaction_info_store_plan_type_mc {
    label: "Pharmacy Plan Type"
    description: "Pharmacy Plan Type"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.TRANSACTION_INFO_STORE_PLAN_TYPE) ;;
    suggestions: ["NOT SPECIFIED", "PRIVATE","MEDICAID","MEDICARE PART B","MEDICARE PART D","WORK COMP","OPEN NEW SALE","OTHER FED PLAN","OTHER ST PLAN","CASH","OTHER BENEFIT","HMO",
      "MFA","ADAP","DME"]
  }

#################################################################################### Measure  ##########################################################################################################################

  measure: sum_transaction_info_dispensed_quantity {
    label: "Dispensed Quantity"
    description: "Total Quantity of the drug dispensed"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_DISPENSED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: transaction_info_acquisition_cost {
    label: "Acquisition Cost"
    description: "Total Acquisition cost of the drug used for this transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSACTION_INFO_ACQUISITION_COST/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_acquisition_cost {
    label: "Acquisition Cost"
    description: "Total Acquisition cost of the drug used for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_ACQUISITION_COST/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_cost {
    label: "Tx Cost"
    description: "Total Cost for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_COST/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_rx_price {
    label: "Rx Price"
    description: "Total Price of the transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_RX_PRICE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_tax_amount {
    label: "Tax Amount"
    description: "Total Tax amount calculated for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_TAX_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_uc_price {
    label: "U&C Price"
    description: "Total Usual and Customary price of the drug filled for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_UC_PRICE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: transaction_info_copay_amount_reference {
    hidden:  yes
    label: "Copay Amount"
    description: "Total Amount in copay to be collected from the patient"
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_COPAY_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_copay_amount {
    label: "Copay Amount"
    description: "Total Amount in copay to be collected from the patient"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_COPAY_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_tp_submit_amount {
    label: "TP Submit Amount"
    description: "Total Expected third party amount submitted to the third party"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_TP_SUBMIT_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_drug_awp {
    label: "Drug AWP"
    description: "Total Average wholesale price of  the drug used for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_DRUG_AWP/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_writeoff_amount {
    label: "Rx System Write Off Amount"
    description: "Total Writeoff amount (COB) as determined on the Rx filling system. Difference between the submitted amount and balance plus copay"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_WRITEOFF_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: transaction_info_days_supply_dim {
    label: "Days Supply"
    description: "Total number of days supply of the transaction in one filling as dispensed"
    type: number
    sql: ${TABLE}.TRANSACTION_INFO_DAYS_SUPPLY ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: transaction_info_days_supply_commercial {
    label: "Commercial Days Supply Buckets"
    description: "Days supply bucket of scripts for general commercial or retail contract rates; i.e. Days Supply <= 83 is 'Regular Day', Days Supply > 83 is 'Extended Day')"
    type: string
    sql: CASE WHEN ${TABLE}.TRANSACTION_INFO_DAYS_SUPPLY <= 83 THEN 'REGULAR DAY' ELSE 'EXTENDED DAY' END ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: transaction_info_days_supply_med_d {
    label: "Med D Days Supply Buckets"
    description: "Days supply bucket of scripts for general Med D; i.e. Days Supply <= 83 is 'Regular Day', Days Supply > 83 is 'Extended Day')"
    type: string
    sql: CASE WHEN ${TABLE}.TRANSACTION_INFO_DAYS_SUPPLY <= 34 THEN 'REGULAR DAY' ELSE 'EXTENDED DAY' END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_transaction_info_days_supply {
    label: "Days Supply"
    description: "Total number of days supply of the medication in one filling as dispensed"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_DAYS_SUPPLY ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: transaction_info_dispensing_fee_paid_reference {
    hidden:  yes
    label: "Dispensing Fee Paid"
    description: "Total Amount the TP indicated that they will pay as a dispensing fee"
    type: number
    sql: (CASE
          WHEN (${TABLE}.TRANSACTION_INFO_DISPENSING_FEE_PAID/100) >= 0 THEN (${TABLE}.TRANSACTION_INFO_DISPENSING_FEE_PAID/100)
          WHEN (${TABLE}.TRANSACTION_INFO_COST/100) <= 0 THEN NULL
          ELSE ((${TABLE}.TRANSACTION_INFO_RX_PRICE/100) - (${TABLE}.TRANSACTION_INFO_COST/100))
        END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_dispensing_fee_paid {
    label: "Dispensing Fee Paid"
    description: "Total Amount the TP indicated that they will pay as a dispensing fee"
    type: sum
    sql: ${transaction_info_dispensing_fee_paid_reference} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_patient_tax_amount {
    label: "Patient Tax Amount"
    description: "Total amount of sales tax that the TP indicated should be paid by the patient"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_PATIENT_TAX_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_plan_tax_amount {
    label: "Plan Tax Amount"
    description: "Total amount of sales tax that the TP indicated should be paid by the Insurance Plan"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_PLAN_TAX_AMOUNT/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: transaction_info_ingredient_cost_paid_reference {
    hidden:  yes
    label: "Ingredient Cost Paid"
    description: "Total Amount the TP indicated that they will pay towards ingredient cost"
    type: number
    sql: (CASE
          WHEN (${TABLE}.TRANSACTION_INFO_INGREDIENT_COST_PAID/100) >= 0 THEN (${TABLE}.TRANSACTION_INFO_INGREDIENT_COST_PAID/100)
          WHEN (${TABLE}.TRANSACTION_INFO_COST/100) <= 0 THEN NULL
          ELSE (${ar_transaction_status.transaction_status_total_paid_amount_reference} - ((${TABLE}.TRANSACTION_INFO_RX_PRICE/100) - (${TABLE}.TRANSACTION_INFO_COST/100)) - (${TABLE}.TRANSACTION_INFO_TAX_AMOUNT/100))
        END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: transaction_info_ingredient_cost_paid_per_unit_reference {
    hidden:  yes
    label: "Ingredient Cost Paid Per Unit"
    description: "Total Amount the TP indicated that they will pay towards ingredient cost based on Decimal Qty of drug units dispensed towards ingredient cost"
    type: number
    sql: COALESCE(${transaction_info_ingredient_cost_paid_reference} / NULLIF((${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY),0), 0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_ingredient_cost_paid {
    label: "Ingredient Cost Paid"
    description: "Total Amount the TP indicated that they will pay towards ingredient cost"
    type: sum
    sql: ${transaction_info_ingredient_cost_paid_reference} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: transaction_info_ingredient_cost_paid_per_unit {
    label: "Ingredient Cost Paid Per Unit"
    description: "Total Amount the TP indicated that they will pay towards ingredient cost based on Decimal Qty of drug units dispensed towards ingredient cost"
    type: sum
    sql: ${transaction_info_ingredient_cost_paid_per_unit_reference} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: effective_rate {
    label: "Effective Rate"
    description: "The TP Effective Rate. Calculation Used: {(sum of Pharmacy Drug AWP price - sum of Ingredient Cost Paid)/sum of Pharmacy Drug AWP Price}*100"
    type: number
    sql: ((${sum_awp_price} - ${sum_transaction_info_ingredient_cost_paid}) / NULLIF(${sum_awp_price}, 0))  ;;
    value_format: "00.00%"
  }

  measure: dispense_rate {
    label: "Dispense Rate %"
    description: "{Total count of claims for selected dimension/Total claim count}"
    type: percent_of_total
    sql:${ar_transaction_status.claim_count} ;;
    value_format: "0.00\%"
  }

  #[ERXLPS-6279] - Exposed in explore to allow userd to perform filtering and adding to reports.
  dimension: total_revenue_reference {
    #hidden: yes
    label: "Revenue"
    description:  "Revenue for Claim (Calc used: Ingredient Cost Paid + Dispensing Fee paid)"
    type: number
    sql: (NVL(${transaction_info_ingredient_cost_paid_reference},0) + NVL(${transaction_info_dispensing_fee_paid_reference},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # TotalRevenue = TotalDispFees + TotalICP
  measure: sum_revenue {
    label: "Total Revenue"
    description:  "Total Revenue for Claim (Calc used: Ingredient Cost Paid + Dispensing Fee paid)"
    type: sum
    sql: ${total_revenue_reference} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # Avg. Sales Price = TotalRevenue/ No. of RXs Dispensed
  measure: sum_revenue_per_rx {
    label: "Avg Total Revenue (per claim)" # Avg. Sales Price
    description:  "The average Total Revenue per Claim (Calc used: Total Revenue / Claim Count)"
    type: number
    sql: ((${sum_revenue})/NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # TotalGrossProfit = (copay + tx status tot paid amt) - TotalAcqCost
  measure: sum_gross_profit {
    label: "Gross Profit $ Actual Payments"
    description: "Gross Profit calculation: ('TP Actual Paid Amount' + 'Copay') - 'Acquisition Cost'"
    type: number
    sql: ( (NVL(${ar_transaction_info.sum_transaction_info_copay_amount}, 0) + NVL(${ar_transaction_status.sum_transaction_status_total_paid_amount}, 0)) - NVL(${sum_transaction_info_acquisition_cost}, 0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_gross_profit_per_rx {
    label: "Avg Gross Profit $ (per claim) Actual Payments"
    description: "Avg Gross Profit calculation: (('TP Actual Paid Amount' + 'Copay') - 'Acquisition Cost') / Claim Count"
    type: number
    sql: ((${sum_gross_profit})/NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_gross_profit_percentage {
    label: "Gross Margin % Actual Payments"
    description: "Gross Margin % calculation: ('Gross Profit $ Actual Payments' / ('TP Actual Paid Amount' + 'Copay'))"
    type: number
    sql: ((${sum_gross_profit})/NULLIF(NVL(${ar_transaction_info.sum_transaction_info_copay_amount}, 0) + NVL(${ar_transaction_status.sum_transaction_status_total_paid_amount}, 0),0)) ;;
    value_format: "00.00%"
  }

###### Gross Profit based on Original Receivable Amount

  # TotalGrossProfit = (copay + tx status sub amt) - TotalAcqCost
  measure: sum_gross_profit_sub_amount {
    label: "Gross Profit $ Original Receivable Amount"
    description: "Gross Profit calculation: ('TP Submit Amount' + 'Copay') - 'Acquisition Cost'"
    type: number
    sql: ( (NVL(${ar_transaction_info.sum_transaction_info_copay_amount}, 0) + NVL(${ar_transaction_status.sum_transaction_status_submit_amount}, 0)) - NVL(${sum_transaction_info_acquisition_cost}, 0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_gross_profit_per_rx_sub_amount {
    label: "Avg Gross Profit $ (per claim) Original Receivable Amount"
    description: "Avg Gross Profit calculation: (('TP Submit Amount' + 'Copay') - 'Acquisition Cost') / Claim Count"
    type: number
    sql: ((${sum_gross_profit_sub_amount})/NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # TotalGrossProfitPerc = (TotalGrossProfit / (copay + tx status sub amt)) * 100
  measure: sum_gross_profit_percentage_sub_amount {
    label: "Gross Margin % Original Receivable Amount"
    description: "Gross Margin % calculation: ('Gross Profit $ Original Receivable Amount' / ('TP Submit Amount' + 'Copay'))"
    type: number
    sql: ((${sum_gross_profit_sub_amount})/NULLIF(NVL(${ar_transaction_info.sum_transaction_info_copay_amount}, 0) + NVL(${ar_transaction_status.sum_transaction_status_submit_amount}, 0),0)) ;;
    value_format: "00.00%"
  }

  #[ERXLPS-6279] - Dimension created for Gross Profit $ Contract.
  dimension: gross_profit_contract {
    label: "Gross Profit $ Contract"
    description: "Gross Profit calculation: ('Total Revenue' - 'Acquisition Cost')"
    type: number
    sql: ( (NVL(${total_revenue_reference}, 0)) - NVL(${transaction_info_acquisition_cost}, 0) ) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # Contract Gross Profit.
  #[ERXLPS-6279] - Removed calculation and referenced gross_profit_contract dimension.
  measure: sum_gross_profit_contract {
    label: "Gross Profit $ Contract"
    description: "Gross Profit calculation: ('Total Revenue' - 'Acquisition Cost')"
    type: sum
    sql: ${gross_profit_contract} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-6279] - New measure added for Avg Gross Profit $ COntract Per Patient
  measure: avg_gross_profit_contract_per_patient {
    label: "Avg Gross Profit $ (per Patient) Contract"
    description: "Avg Gross Profit $ Contract per Patient calculation: (('Total Revenue' - 'Acquisition Cost') / Store Patient Count)"
    type: number
    sql: ((${sum_gross_profit_contract})/NULLIF(${count_store_patient},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_gross_profit_contract_per_claim {
    label: "Avg Gross Profit $ (per claim) Contract"
    description: "Avg Gross Profit calculation: (('Total Revenue' - 'Acquisition Cost') / Claim Count)"
    type: number
    sql: ((${sum_gross_profit_contract})/NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_gross_profit_percentage_contract {
    label: "Gross Margin % Contract"
    description: "Gross Margin % calculation: ('Gross Profit $ Contract' / 'Total Revenue')"
    type: number
    sql: ((${sum_gross_profit_contract})/NULLIF(${sum_revenue},0)) ;;
    value_format: "00.00%"
  }

  dimension: awp_price_reference {
    hidden:  yes
    label: "AWP Price"
    description: "Average Wholesale Price"
    type: number
    sql: (CASE
          WHEN (${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) <= 0 OR
            (${ar_drug_cost_hist_awp.drug_cost_unit_price_reference}) IS NULL OR
            (${ar_drug_cost_hist_awp.drug_cost_unit_price_reference}) <= 0 THEN NULL
          WHEN ROUND(((${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) * (${ar_drug_cost_hist_awp.drug_cost_unit_price_reference})), 2) = 0 THEN .01
          ELSE ROUND(((${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) * (${ar_drug_cost_hist_awp.drug_cost_unit_price_reference})), 2)
        END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ## Added Unique Key to resolve the Non Unique errors that were being thrown for reports, and resolve NULL calculations
  measure: sum_awp_price {
    label: "AWP Price"
    description: "Average Wholesale Price"
    type: sum_distinct
    sql: ${awp_price_reference} ;;
    sql_distinct_key:  ${unique_key} || '@' || ${ar_drug_cost_hist_awp.unique_key} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: wac_price_reference {
    hidden:  yes
    label: "WAC Price"
    description: "WAC Price"
    type: number
    sql: (CASE
          WHEN (${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) <= 0 OR
            (${ar_drug_cost_hist_wac.drug_cost_unit_price_reference}) IS NULL OR
            (${ar_drug_cost_hist_wac.drug_cost_unit_price_reference}) <= 0 THEN NULL
          WHEN ROUND(((${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) * (${ar_drug_cost_hist_wac.drug_cost_unit_price_reference})), 2) = 0 THEN .01
          ELSE ROUND(((${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY) * (${ar_drug_cost_hist_wac.drug_cost_unit_price_reference})), 2)
        END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ## Added Unique Key to resolve the Non Unique errors that were being thrown for reports, and resolve NULL calculations
  measure: sum_wac_price {
    label: "WAC Price"
    description: "WAC Price"
    type: sum_distinct
    sql: ${wac_price_reference} ;;
    sql_distinct_key:  ${unique_key} || '@' || ${ar_drug_cost_hist_wac.unique_key} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: dir_claim_count_reference {
    hidden: yes
    type: number
    sql: 1 ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_dir_claim_count {
    hidden: yes
    type: sum
    sql: ${dir_claim_count_reference} ;;
    value_format: "#,##0;(#,##0)"
  }

# DIRFeeType  Percentage/FlatFeeAmt   AdjustmentBase                      DIR Fee Calculation  (Overall DIR Adjustment $ value)
# Flat Fee      $1.00                 Total Paid Amount (CPR field)       Flat fee per claim * number of claims = Overall DIR Adjustment
# Percentage    2%                    Ingredient Cost (CPR field)         <Ing Cost Paid> * 0.02 per claim; then sum this value to get the Overall DIR Adjustment
# Percentage    2%                    Total Paid Amount (CPR field)       <Total Paid Amt (CPR field)> * 0.02 per claim; then sum this value to get the Overall DIR Adjustment
# Percentage    2%                    AWP on Fill Date                    <AWP Price (CPR field)> * 0.02 per claim; then sum this value to get the Overall DIR Adjustment
# Percentage    2%                    WAC on Fill Date                    <WAC Price (CPR field)>* 0.02 per claim; then sum this value to get the Overall DIR Adjustment

  dimension:  dir_accural_amount {
    label:  "DIR Accrual Amount"
    description: "DIR Accrual Amount based on contract and Non Contract DIR Fee Types, Flat Amounts, Flags and Percentages, as per the Contract Rate File Cabinet"
    type: number
    sql: (CASE
            /* EXCLUDE Claims Paid at U&C and Non Contract Rate table specifies to exclude */
          WHEN ${ar_non_contract_rate_dir.comments} = 'EXCLUDE CLAIMS PAID AT U&C' AND ${paid_at_uc_price_yesno} = 'Y' THEN NULL
          WHEN ${ar_non_contract_rate_dir.comments} = 'WHERE DISPENSE FEE EQUALS 0.35' AND ROUND(${transaction_info_dispensing_fee_paid_reference}, 2) <> 0.35 THEN NULL
            /* Claims Without Contract Using Non Contract Rate DIR  ** PLACING NON CONTRACT FIRST TO UTILIZE FIRST WHEREVER POSSIBLE ** */
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20201 THEN ${ar_transaction_info.dir_claim_count_reference} * ${ar_non_contract_rate_dir.dir_flat_fee_amt}
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20202 AND ${ar_non_contract_rate_dir.adj_base_type_id} = 20301 THEN ${ar_transaction_info.transaction_info_ingredient_cost_paid_reference} * ${ar_non_contract_rate_dir.dir_pct_reference}
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20202 AND ${ar_non_contract_rate_dir.adj_base_type_id} = 20302 THEN ${ar_transaction_status.transaction_status_total_paid_amount_reference} * ${ar_non_contract_rate_dir.dir_pct_reference}
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20202 AND ${ar_non_contract_rate_dir.adj_base_type_id} = 20303 THEN ${ar_transaction_info.awp_price_reference} * ${ar_non_contract_rate_dir.dir_pct_reference}
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20202 AND ${ar_non_contract_rate_dir.adj_base_type_id} = 20304 THEN ${ar_transaction_info.wac_price_reference} * ${ar_non_contract_rate_dir.dir_pct_reference}
            /* TRUE UP Calculation */
          WHEN ${ar_non_contract_rate_dir.dir_fee_type} = 20205 AND ${ar_non_contract_rate_dir.adj_base_type_id} = 20303 THEN ${ar_transaction_info.transaction_info_ingredient_cost_paid_reference} - ( ${ar_transaction_info.awp_price_reference} - (${ar_transaction_info.awp_price_reference} * ${ar_non_contract_rate_dir.dir_pct_reference}))
            /* Claims With Contract Using Contract Rate DIR */
          WHEN ${ar_contract_rate_dir_latest.dir_fee_type} = 20201 THEN ${ar_transaction_info.dir_claim_count_reference} * ${ar_contract_rate_dir_latest.dir_flat_fee_amt}
          WHEN ${ar_contract_rate_dir_latest.dir_fee_type} = 20202 AND ${ar_contract_rate_dir_latest.adj_base_type_id} = 20301 THEN ${ar_transaction_info.transaction_info_ingredient_cost_paid_reference} * ${ar_contract_rate_dir_latest.dir_pct_reference}
          WHEN ${ar_contract_rate_dir_latest.dir_fee_type} = 20202 AND ${ar_contract_rate_dir_latest.adj_base_type_id} = 20302 THEN ${ar_transaction_status.transaction_status_total_paid_amount_reference} * ${ar_contract_rate_dir_latest.dir_pct_reference}
          WHEN ${ar_contract_rate_dir_latest.dir_fee_type} = 20202 AND ${ar_contract_rate_dir_latest.adj_base_type_id} = 20303 THEN ${ar_transaction_info.awp_price_reference} * ${ar_contract_rate_dir_latest.dir_pct_reference}
          WHEN ${ar_contract_rate_dir_latest.dir_fee_type} = 20202 AND ${ar_contract_rate_dir_latest.adj_base_type_id} = 20304 THEN ${ar_transaction_info.wac_price_reference} * ${ar_contract_rate_dir_latest.dir_pct_reference}
          END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_dir_accruals_amount {
    label: "DIR Accrual Amount"
    description: "DIR Accrual Amount based on Contract and Non Contract DIR Fee Types, Flat Amounts, Flags and Percentages, as per the Contract Rate File Cabinet"
    type: sum
    sql: ${dir_accural_amount} ;;
#     sql_distinct_key: ${chain_id} ||'@'|| ${transaction_id} || '@' || ${transaction_info_bin_number} ||'@'|| ${transaction_info_pcn_number} ||'@'|| ${transaction_info_group_code}||'@'|| ${drug.ar_drug_brand_generic} || '@' || ${transaction_info_days_supply_dim} || '@' || ${transaction_info_network_reimbursement_id} ;; # ERXDWPS-6327 Changes
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: total_revenue_after_dir_reference {
    hidden: yes
    label: "Total Revenue After DIR"
    description: "The total revenue after the DIR Fee Accrual calculation is applied (Total Revenue - DIR Accrual)"
    type: number
    sql: ${total_revenue_reference}-${dir_accural_amount} ;;
  }

  measure: sum_total_revenue_after_dir {
    label: "Total Revenue After DIR"
    description: "The total revenue after the DIR Fee Accrual calculation is applied (Total Revenue - DIR Accrual)"
    type: sum
    sql: ${total_revenue_after_dir_reference} ;;
  }

  measure: sum_gross_profit_after_dir {
    label: "Gross Profit After DIR"
    description: "The Gross Profit after the DIR Fee Accrual calculation is applied (Total Revenue After DIR - Acquisition Cost)"
    type: number
    sql: ${sum_total_revenue_after_dir} - ${sum_transaction_info_acquisition_cost} ;;
  }

  dimension: paid_below_acq_cost_yesno {
    label: "Paid Below Acquisition Cost"
    description: "Y/N flag if a claim was paid below acquisition cost (Calc used: Total Revenue vs. ACQ Price)"
    type: string
    sql: CASE WHEN (${total_revenue_reference} < NVL((${TABLE}.TRANSACTION_INFO_ACQUISITION_COST/100),0)) THEN 'Y' ELSE 'N' END ;;
  }

  #[ERXLPS-6279] - SQL logic updated.
  dimension: paid_at_uc_price_yesno {
    label: "Paid At U&C Price"
    description: "Y/N flag if a claim was paid at U&C price (Calc used: Ingredient Cost vs. U&C Price OR Total Revenue vs. U&C Price)"
    type: string
    #sql: CASE WHEN ((${transaction_info_ingredient_cost_paid_reference} < NVL((${TABLE}.TRANSACTION_INFO_UC_PRICE/100),0)) OR (${total_revenue_reference} < NVL((${TABLE}.TRANSACTION_INFO_UC_PRICE/100),0))) THEN 'Y' ELSE 'N' END ;;
    sql: CASE WHEN ${transaction_info_basis_of_reimbursement} in ('4','04') THEN 'Y'
              WHEN ${total_revenue_reference} = ${transaction_info_uc_price_reference} THEN 'Y'
              WHEN ${transaction_info_ingredient_cost_paid_reference} = ${transaction_info_uc_price_reference} THEN 'Y'
              ELSE 'N'
         END ;;
  }

  #[ERXLPS-6279] - Dimension added to utilize in reports and filters.
  dimension: tot_paid_below_acq_cost {
    label: "Revenue below ACQ Cost"
    description: "Revenue below ACQ Cost (Calc used: Paid Below ACQ = Y, SUM (Total Revenue - ACQ Cost))"
    type: number
    sql: CASE WHEN ${paid_below_acq_cost_yesno} = 'Y' THEN (NVL((${total_revenue_reference}),0) - NVL((${TABLE}.TRANSACTION_INFO_ACQUISITION_COST/100),0)) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_tot_paid_below_acq_cost {
    label: "Total Revenue below ACQ Cost"
    description: "Total Revenue below ACQ Cost (Calc used: Paid Below ACQ = Y, SUM (Total Revenue - ACQ Cost))"
    type: sum
    sql: CASE WHEN ${paid_below_acq_cost_yesno} = 'Y' THEN (NVL((${total_revenue_reference}),0) - NVL((${TABLE}.TRANSACTION_INFO_ACQUISITION_COST/100),0)) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: claim_count_paid_below_acq_cost {
    label: "Total Claims Paid Below ACQ Cost"
    description: "Total Claims Paid Below ACQ Cost (Calc used: Paid Below ACQ = Y, Count Transaction ID)"
    type: number
    sql: COUNT(DISTINCT(CASE WHEN ${paid_below_acq_cost_yesno} = 'Y' THEN ${TABLE}.TRANSACTION_ID END)) ;;
    value_format: "#,##0"
  }

  measure: pct_paid_below_acq_cost {
    label: "% Paid Below ACQ Cost"
    description: "The percentage of claim counts paid below ACQ Cost"
    type: number
    sql: ${claim_count_paid_below_acq_cost}/(NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "00.00%"
  }

  measure: sum_tot_paid_at_uc_price {
    label: "Total Revenue for U&C Paid Claims"
    description: "Total Revenue for U&C Paid Claims (Calc used: Paid at U&C = Y, SUM (Total Revenue))"
    type: sum
    sql: CASE WHEN ${paid_at_uc_price_yesno} = 'Y' THEN ${total_revenue_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: claim_count_paid_at_uc_price {
    label: "Total Claims Paid At UC Price"
    description: "Total Claims Paid At UC Price (Calc used: Paid at U&C = Y, Count Transaction ID)"
    type: number
    sql: COUNT(DISTINCT(CASE WHEN ${paid_at_uc_price_yesno} = 'Y' THEN ${TABLE}.TRANSACTION_ID END)) ;;
    value_format: "#,##0"
  }

  measure: pct_paid_at_uc_price {
    label: "% Paid At UC Price"
    description: "The percentage of claim counts paid at U&C Price"
    type: number
    sql: ${claim_count_paid_at_uc_price}/(NULLIF(${ar_transaction_status.claim_count},0)) ;;
    value_format: "00.00%"
  }

  measure: sum_transaction_info_tx_decimal_quantity {
    label: "Tx Decimal Quantity"
    description: "Total decimal quantity of drug units dispensed for this transaction"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_TX_DECIMAL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_transaction_info_received_copay {
    label: "Received Copay"
    description: "Total copay originally returned by the TP.  The user has the ability to change the ‘final’ copay (which is the copay we have historically dealt with).  "
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_RECEIVED_COPAY/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_rx_order_quantity {
    label: "Rx Order Quantity"
    description: "Total Ordered quantity for the prescription"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_RX_ORDER_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_transaction_info_number_of_times_submit {
    label: "Number Of Times Submitted"
    description: "Total number of times a transaction third party record has been submitted to the third party"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_NUMBER_OF_TIMES_SUBMIT/100 ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_transaction_info_gross_amount_due {
    label: "Gross Amount Due"
    description: "Total price claimed from all sources"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_GROSS_AMOUNT_DUE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_transaction_info_dispensing_fee_submitted {
    label: "Dispensing Fee Submitted"
    description: "Total Dispensing fee submitted by the pharmacy"
    type: sum
    sql: ${TABLE}.TRANSACTION_INFO_DISPENSING_FEE_SUBMITTED/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-6279] - New measures added for awp_discount.
  measure: sum_awp_discount {
    label: "AWP Discount"
    description: "Average Wholesale Price discount. Calc Used: (AWP Price - Ingredient Cost Paid)/AWP Price."
    type: number
    sql: (${sum_awp_price} - ${sum_transaction_info_ingredient_cost_paid}) / NULLIF(${sum_awp_price},0) ;;
    value_format: "00.00%"
  }

  #[ERXLPS-6279] - New measures added for store patient count. Ideally we should have transaction_patient table count. Currently we do not source transaction_patient table to EDW.
  measure: count_store_patient {
    type: count_distinct
    label: "Store Patient Count"
    description: "Store Patient count associated with claims. Use this measure along with store number to get the correct results."
    sql: ${chain_id}||'@'||${ar_transaction_status.nhin_store_id}||'@'||${transaction_info_patient_identifier} ;;
    value_format: "#,###"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.TRANSACTION_INFO_LCR_ID ;;
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

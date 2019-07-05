view: eps_tx_tp_submit_detail {
  sql_table_name: EDW.F_TX_TP_SUBMIT_DETAIL ;;

  dimension: tx_tp_submit_detail_id {
    type: number
    hidden: yes
    label: "Submit Detail ID"
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_submit_detail_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Submit Detail Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Submit Detail NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  ########################################################################################### End of Foreign Key References #####################################################################################################

  ######################################################################################################### Dimension ############################################################################################################

  dimension: tx_tp_submit_detail_bin_number {
    label: "Submit Detail BIN Number"
    description: "Card Issuer ID or Bank ID Number used for network routing.  i.e. Bin number to which the claim was transmitted. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_BIN_NUMBER ;;
    value_format: "######"
  }

  dimension: tx_tp_submit_detail_version_number {
    label: "Submit Version Number"
    description: "Code uniquely identifying the transmission syntax and corresponding Data Dictionary. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_VERSION_NUMBER ;;
  }

  dimension: tx_tp_submit_detail_processor_control_number {
    label: "Submit Detail Processor Control Number"
    description: "Processor Control Number assigned by the processor. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PROCESSOR_CONTROL_NUMBER ;;
  }

  dimension: tx_tp_submit_detail_service_provider_identifier {
    label: "Submit Detail Service Provider Identifier"
    description: "ID assigned to a pharmacy or provider. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SERVICE_PROVIDER_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_patient_first_name {
    label: "Submit Detail Patient First Name"
    description: "Patient's first name. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_FIRST_NAME ;;
  }

  dimension: tx_tp_submit_detail_patient_last_name {
    label: "Submit Detail Patient Last Name"
    description: "Patient's last name. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_LAST_NAME ;;
  }

  dimension: tx_tp_submit_detail_pharmacy_provider_identifier {
    label: "Submit Detail Pharmacy Provider Identifier"
    description: "Unique ID assigned to the person responsible for the dispensing of the prescription or provision of the service. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PHARMACY_PROVIDER_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_prescriber_identifier {
    label: "Submit Detail Prescriber Identifier"
    description: "ID assigned to the prescriber. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PRESCRIBER_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_cardholder_identifier {
    label: "Submit Detail Cardholder Identifier"
    description: "Insurance ID assigned to the cardholder or identification number used by the plan. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_CARDHOLDER_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_cardholder_first_name {
    label: "Submit Detail Cardholder First Name"
    description: "Cardholder's first name. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_CARDHOLDER_FIRST_NAME ;;
  }

  dimension: tx_tp_submit_detail_cardholder_last_name {
    label: "Submit Detail Cardholder Last Name"
    description: "Cardholder's Last Name. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_CARDHOLDER_LAST_NAME ;;
  }

  dimension: tx_tp_submit_detail_person_code {
    label: "Submit Detail Person Code"
    description: "Code assigned to a specific person within a family. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PERSON_CODE ;;
  }

  dimension: tx_tp_submit_detail_home_plan {
    label: "Submit Detail Home Plan"
    description: "Code identifying the Blue Cross or Blue Shield plan ID which indicates where the member's coverage has been designated. Usually where the member lives or purchased their coverage. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_HOME_PLAN ;;
  }

  dimension: tx_tp_submit_detail_plan_identifier {
    label: "Submit Detail Plan Identifier"
    description: "Assigned by the processor to identify a set of parameters, benefit, or coverage criteria used to adjudicate a claim. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PLAN_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_group_identifier {
    label: "Submit Detail Group Identifier"
    description: "ID assigned to the cardholder group or employer group. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_GROUP_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_workers_comp_employer_name {
    label: "Submit Detail Workers Comp Employer Name"
    description: "Complete name of employer. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_WORKERS_COMP_EMPLOYER_NAME ;;
  }

  dimension: tx_tp_submit_detail_product_identifier {
    label: "Submit Detail Product Identifier"
    description: "ID of the product dispensed or service provided. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PRODUCT_IDENTIFIER ;;
  }

  dimension: tx_tp_submit_detail_prior_auth_number {
    label: "Submit Detail Prior Auth Number"
    description: "Number submitted by the provider to identify the prior authorization. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PRIOR_AUTH_NUMBER ;;
  }

  measure: tx_tp_submit_detail_percent_sales_tax_amount {
    label: "Submit Detail Sales Tax Amount"
    description: "Percentage sales tax submitted. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_detail_percent_sales_tax_rate {
    label: "Submit Detail Percent Sales Tax"
    description: "Percentage sales tax rate used to calculate 'Percentage Sales Tax Amount Submitted' (482-GE). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_RATE ;;
    value_format: "00.00\"%\""
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: tx_tp_submit_detail_transaction_code {
    label: "Submit Detail Transaction"
    description: "Indicates the type of transaction. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_TRANSACTION_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_TRANSACTION_CODE') ;;
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

  dimension: tx_tp_submit_detail_service_provider_id_qualifier {
    label: "Submit Detail Service Provider ID Qualifer"
    description: "Service Provider. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_SERVICE_PROVIDER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_SERVICE_PROVIDER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PROVIDER IDENTIFIER",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UNIQUE PHYSICIAN ID",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER",
      "FEDERAL TAX ID",
      "DEA NUMBER",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "HC IDEA",
      "CMEA CERTIFICATE ID",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_place_of_service {
    label: "Submit Detail Place Of service"
    description: "Place where a drug or service is dispensed or administered. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PLACE_OF_SERVICE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PLACE_OF_SERVICE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PHARMACY",
      "SCHOOL",
      "HOMELESS SHELTER",
      "INDIAN HEALTH FREE-STANDING",
      "INDIAN HEALTH PROVIDER-BASED",
      "TRIBAL 638 FREE-STANDING",
      "TRIBAL 638 PROVIDER-BASED",
      "PRISON/CORRECTIONAL",
      "OFFICE",
      "HOME",
      "ASSISTED LIVING FACILITY",
      "GROUP HOME",
      "MOBILE UNIT",
      "TEMPORARY LODGING",
      "WALK-IN RETAIL HEALTH CLINIC",
      "PLACE OF EMPLOYMENT-WORKSITE",
      "URGENT CARE FACILITY",
      "INPATIENT HOSPITAL",
      "OUTPATIENT HOSPITAL",
      "EMERGENCY ROOM - HOSPITAL",
      "AMBULATORY SURGICAL CENTER",
      "BIRTHING CENTER",
      "MILITARY TREATMENT FACILITY",
      "SKILLED NURSING FACILITY",
      "NURSING FACILITY",
      "CUSTODIAL CARE FACILITY",
      "HOSPICE",
      "AMBULANCE - LAND",
      "AMBULANCE - AIR OR WATER",
      "INDEPENDENT CLINIC",
      "FEDERALLY QUALIFIED HEALTH CENTER",
      "INPATIENT PSYCHIATRIC FACILITY",
      "PSYCHIATRIC FACILITY",
      "COMMUNITY MENTAL HEALTH CENTER",
      "MENTALLY RETARDED CARE",
      "RESIDENTIAL SUBSTANCE ABUSE",
      "PSYCHIATRIC RESIDENTIAL TREATMENT",
      "NON-RESIDENTIAL SUBSTANCE ABUSE",
      "MASS IMMUNIZATION CENTER",
      "COMPREHENSIVE INPATIENT REHAB",
      "COMPREHENSIVE OUTPATIENT REHAB",
      "END-STAGE RENAL DISEASE",
      "PUBLIC HEALTH CLINIC",
      "RURAL HEALTH CLINIC",
      "INDEPENDENT LABORATORY",
      "OTHER PLACE OF SERVICE"
    ]
  }

  dimension: tx_tp_submit_detail_patient_pregnancy_flag {
    label: "Submit Detail Patient Pregnancy Flag"
    description: "Indicates if the patient is pregnant or not-pregnant. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_PREGNANCY_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PATIENT_PREGNANCY_FLAG') ;;
    suggestions: ["NOT PREGNANT", "PREGNANT"]
  }

  dimension: tx_tp_submit_detail_patient_residence {
    label: "Submit Detail Patient Residence"
    description: "Patient's place of residence. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_RESIDENCE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PATIENT_RESIDENCE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "HOME - PRIVATE RESIDENCE",
      "SKILLED NURSING FACILITY",
      "NURSING FACILITY",
      "ASSISTED LIVING FACILITY",
      "CUSTODIAL CARE FACILITY",
      "GROUP HOME",
      "INPATIENT PSYCHIATRIC",
      "PSYCHIATRIC -PARTIAL HOSPITALIZATION",
      "MENTALLY RETARDED",
      "RESIDENTIAL SUBSTANCE ABUSE",
      "HOSPICE",
      "PSYCHIATRIC RESIDENTIAL TREATMENT",
      "COMPREHENSIVE INPATIENT REHABILITATION",
      "HOMELESS SHELTER",
      "CORRECTIONAL INSTITUTION"
    ]
  }

  dimension: tx_tp_submit_detail_pharmacy_provider_id_qualifier {
    label: "Submit Detail Pharmacy Provider ID Qualifier"
    description: "Code qualifying the Provider ID. (444-E9).  (Pharmacy Provider ID ). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PHARMACY_PROVIDER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PHARMACY_PROVIDER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DEA",
      "STATE LICENSE",
      "SSN NUMBER",
      "NAME",
      "NATIONAL PROVIDER ID",
      "HEALTH INDUSTRY NUMBER",
      "STATE ISSUED ID",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_prescriber_id_qualifier {
    label: "Submit Detail Prescriber ID Qualifier"
    description: "Code qualifying the Prescriber ID. (444-E9).  (Pharmacy Prescriber ID ). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PRESCRIBER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PRESCRIBER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PROVIDER ID",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UNIQUE PHYSICIAN ID",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER",
      "FEDERAL TAX ID",
      "DEA NUMBER",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "HC IDEA",
      "FOREIGN PRESCRIBER ID",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_patient_relation_code {
    label: "Submit Detail Patient Relation"
    description: "Relationship of patient to cardholder. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_RELATION_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PATIENT_RELATION_CODE') ;;
    suggestions: ["NOT SPECIFIED", "CARDHOLDER", "SPOUSE", "CHILD", "OTHER"]
  }

  dimension: tx_tp_submit_detail_eligible_clarification_code {
    label: "Submit Detail Eligible Clarification"
    description: "Indicating that the pharmacy is clarifying eligibility for a patient. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_ELIGIBLE_CLARIFICATION_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_ELIGIBLE_CLARIFICATION_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NO OVERRIDE",
      "OVERRIDE",
      "FULL TIME STUDENT",
      "DISABLED DEPENDENT",
      "DEPENDENT PARENT",
      "SIGNIFICANT OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_product_id_qualifier {
    label: "Submit Detail Product ID Qualifer"
    description: "Qualifying the value in 'Product/Service ID' (437-D7). This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PRODUCT_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PRODUCT_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "UNIVERSAL PRODUCT CODE",
      "HEALTH RELATED ITEM",
      "NATIONAL DRUG CODE",
      "HIBCC",
      "DEPARTMENT OF DEFENSE",
      "(DUR/PPS)",
      "COMMON PROCEDURE TERM",
      "HCPCS",
      "PPAC",
      "NAPPI",
      "GTIN",
      "DRUG IDENTIFICATION NUMBER",
      "FIRST DATABANK FORMULATION ID (GCN)",
      "FIRST DATABANK MEDICATION NAME ID",
      "FIRST DATABANK ROUTED MEDICATION ID",
      "FIRST DATABANK ROUTED DOSAGE FORM ID",
      "FIRST DATABANK MEDICATION ID (FDB MEDID)",
      "GCN_SEQ_NO",
      "FIRST DATABANK INGREDIENT LIST ID",
      "UNIVERSAL PRODUCT NUMBER (UPN)",
      "REPRESENTATIVE NATIONAL DRUG CODE (NDC)",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_other_coverage_code {
    label: "Submit Detail Other Coverage"
    description: "Indicates whether or not the patient has other insurance coverage. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_OTHER_COVERAGE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_OTHER_COVERAGE_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NOT SPECIFIED BY PATIENT",
      "NO OTHER COVERAGE",
      "OTHER COVERAGE EXISTS PAYMENT RECEIVED",
      "OTHER COVERAGE BILLED CLAIM NOT COVERED",
      "OTHER COVERAGE EXISTS PAYMENT NOT COLLECTED",
      "MANAGED CARE PLAN DENIAL",
      "OTHER COVERAGE DENIED",
      "OTHER COVERAGE EXISTS NOT IN DOS",
      "PATIENT FINANCIAL RESPONSIBILITY ONLY"
    ]
  }

  dimension: tx_tp_submit_detail_pharmacy_service_type {
    label: "Submit Detail Pharmacy Service Type"
    description: "The type of service being performed by a pharmacy when different contractual terms exist between a payer and the pharmacy, or when benefits are based upon the type of service performed. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PHARMACY_SERVICE_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PHARMACY_SERVICE_TYPE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "COMMUNITY/RETAIL PHARMACY",
      "COMPOUNDING PHARMACY",
      "HOME INFUSION THERAPY PROVIDER",
      "INSTITUTIONAL PHARMACY",
      "LONG TERM CARE PHARMACY",
      "MAIL ORDER PHARMACY",
      "MANAGED CARE ORGANIZATION PHARMACY",
      "SPECIALTY CARE PHARMACY",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_level_of_service {
    label: "Submit Detail Level Of Service"
    description: " indicating the type of service the provider rendered. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_LEVEL_OF_SERVICE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_LEVEL_OF_SERVICE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PATIENT CONSULTATION",
      "HOME DELIVERY",
      "EMERGENCY",
      "24 HOUR SERVICE",
      "PATIENT CONSULTATION",
      "IN-HOME SERVICE"
    ]
  }

  dimension: tx_tp_submit_detail_prior_auth_type_code {
    label: "Submit Detail Prior Auth Type"
    description: "Clarifying the Prior Authorization Number Submitted. (462-EV) or benefit/plan exemption. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PRIOR_AUTH_TYPE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PRIOR_AUTH_TYPE_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NOT SPECIFIED",
      "PRIOR AUTHORIZATION",
      "MEDICAL CERTIFICATION",
      "EPSDT",
      "EXEMPTION FROM COPAY",
      "EXEMPTION FROM RX",
      "FAMILY PLANNING INDICATOR",
      "TANF",
      "PAYER DEFINED EXEMPTION",
      "EMERGENCY PREPAREDNESS"
    ]
  }

  dimension: tx_tp_submit_detail_basis_of_cost_determination {
    label: "Submit Detail Basis Of Cost Determination"
    description: "indicates the method by which 'Ingredient Cost Submitted' (Field 49-D9) was calculated. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_BASIS_OF_COST_DETERMINATION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_BASIS_OF_COST_DETERMINATION') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DEFAULT",
      "AVERAGE WHOLESALE PRICE",
      "LOCAL WHOLESALER",
      "DIRECT",
      "ESTIMATED ACQUISITION COST",
      "ACQUISITION",
      "MAXIMUM ALLOWABLE COST",
      "USUAL AND CUSTOMARY",
      "340B",
      "OTHER",
      "AVERAGE SALES PRICE",
      "AVERAGE MANUFACTURER PRICE",
      "WHOLESALE ACQUISITION COST",
      "SPECIAL PATIENT PRICING",
      "COST BASIS ON UNREPORTABLE QUANTITIES"
    ]
  }

  dimension: tx_tp_submit_detail_percent_sales_tax_basis {
    label: "Submit Detail Percent Sales Tax Basis"
    description: "Indicates the basis for percentage sales tax. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_BASIS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_BASIS') ;;
    suggestions: ["NOT SPECIFIED", "INGREDIENT COST", "INGREDIENT COST & DISPENSING FEE"]
  }

  #################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################


  ########################################################################################################## Date/Time Dimensions #############################################################################################

  dimension_group: tx_tp_submit_detail_date_of_service {
    label: "Submit Detail Service"
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
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_DATE_OF_SERVICE ;;
  }

  dimension_group: tx_tp_submit_detail_patient_dob {
    label: "Submit Detail Patient Birth"
    description: "Patients date of birth. This field is EPS only!!!"
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
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_DOB ;;
  }

  dimension_group: tx_tp_submit_detail_workers_comp_date_of_injury {
    label: "Submit Detail Workers Comp Injury"
    description: "Date on which the injury occurred. This field is EPS only!!!"
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
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_WORKERS_COMP_DATE_OF_INJURY ;;
  }

  #[ERXLPS-726] Date reference dimension for sales explore
  dimension: tx_tp_submit_detail_service_reference {
    hidden: yes
    label: "Submit Detail Service"
    description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_DATE_OF_SERVICE ;;
  }

  dimension: tx_tp_submit_detail_patient_birth_reference {
    hidden: yes
    label: "Submit Detail Patient Birth"
    description: "Patients date of birth. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_DOB ;;
  }

  dimension: tx_tp_submit_detail_workers_comp_injury_reference {
    hidden: yes
    label: "Submit Detail Workers Comp Injury"
    description: "Date on which the injury occurred. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_WORKERS_COMP_DATE_OF_INJURY ;;
  }

  ################################################################################################### End of Date/Time Dimensions #############################################################################################

  ############################################################################################################### Measures #################################################################################################

  measure: tx_tp_submit_detail_quantity_dispensed {
    label: "Submit Detail Quantity Dispensed"
    description: "Quantity dispensed expressed in metric decimal units. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_QUANTITY_DISPENSED ;;
    value_format: "#,##0.00"
  }

  measure: tx_tp_submit_detail_days_supply {
    label: "Submit Detail Days Supply"
    description: "Estimated number of days the prescription will last. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_DAYS_SUPPLY ;;
    value_format: "#,##0.00"
  }

  measure: tx_tp_submit_detail_uc_charge {
    label: "Submit Detail UC Charge"
    description: "Total amount charged cash customers for the prescription exclusive of sales tax or other amounts claimed. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_UC_CHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_detail_gross_amount_fee {
    label: "Submit Detail Gross Amount Due"
    description: "Total price claimed from all sources. For prescription claim request, field represents a sum of Ingredient Cost Submitted (49-D9), Dispensing Fee Submitted (412-DC), Flat Sales Tax Amount Submitted (481-HA), Percentage Sales Tax Amount Submitted (482-GE), Incentive Amount Submitted (438-E3), Other Amount Claimed (48-H9). For service claim request, field represents a sum of Professional Services Fee Submitted (477-BE), Flat Sales Tax Amount Submitted (481-HA), Percentage Sales Tax Amount Submitted (482-GE), Other Amount Claimed (48-H9). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_GROSS_AMOUNT_DUE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_detail_ingredient_cost {
    label: "Submit Detail Ingredient Cost"
    description: "Submitted product component cost of the dispensed prescription. This amount is included in the 'Gross Amount Due' (430-DU). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_INGREDIENT_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_detail_patient_paid_amount {
    label: "Submit Detail Patient Paid Amount"
    description: "Total amount the pharmacy received from the patient for the prescription dispensed. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_PAID_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_submit_detail_flat_sales_tax_amount {
    label: "Submit Detail Flat Sales Tax Amount"
    description: "Flat sales tax submitted for prescription. This amount is included in the 'Gross Amount Due' (430-DU). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_FLAT_SALES_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-726]
  measure: sum_sales_tx_tp_submit_detail_percent_sales_tax_amount {

    label: "Submit Detail Sales Tax Amount"
    description: "Percentage sales tax submitted. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_detail_percent_sales_tax_rate {
    label: "Submit Detail Percent Sales Tax"
    description: "Percentage sales tax rate used to calculate 'Percentage Sales Tax Amount Submitted' (482-GE). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_PERCENT_SALES_TAX_RATE END ;;
    value_format: "00.00\"%\""
  }

  measure: sum_sales_tx_tp_submit_detail_quantity_dispensed {
    label: "Submit Detail Quantity Dispensed"
    description: "Quantity dispensed expressed in metric decimal units. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_QUANTITY_DISPENSED END ;;
    value_format: "#,##0.00"
  }

  measure: sum_sales_tx_tp_submit_detail_days_supply {
    label: "Submit Detail Days Supply"
    description: "Estimated number of days the prescription will last. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_DAYS_SUPPLY END ;;
    value_format: "#,##0.00"
  }

  measure: sum_sales_tx_tp_submit_detail_uc_charge {
    label: "Submit Detail UC Charge"
    description: "Total amount charged cash customers for the prescription exclusive of sales tax or other amounts claimed. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_UC_CHARGE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_detail_gross_amount_fee {
    label: "Submit Detail Gross Amount Due"
    description: "Total price claimed from all sources. For prescription claim request, field represents a sum of Ingredient Cost Submitted (49-D9), Dispensing Fee Submitted (412-DC), Flat Sales Tax Amount Submitted (481-HA), Percentage Sales Tax Amount Submitted (482-GE), Incentive Amount Submitted (438-E3), Other Amount Claimed (48-H9). For service claim request, field represents a sum of Professional Services Fee Submitted (477-BE), Flat Sales Tax Amount Submitted (481-HA), Percentage Sales Tax Amount Submitted (482-GE), Other Amount Claimed (48-H9). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_GROSS_AMOUNT_DUE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_detail_ingredient_cost {
    label: "Submit Detail Ingredient Cost"
    description: "Submitted product component cost of the dispensed prescription. This amount is included in the 'Gross Amount Due' (430-DU). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_INGREDIENT_COST END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_detail_patient_paid_amount {
    label: "Submit Detail Patient Paid Amount"
    description: "Total amount the pharmacy received from the patient for the prescription dispensed. This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_PATIENT_PAID_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_tx_tp_submit_detail_flat_sales_tax_amount {
    label: "Submit Detail Flat Sales Tax Amount"
    description: "Flat sales tax submitted for prescription. This amount is included in the 'Gross Amount Due' (430-DU). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_SUBMIT_DETAIL_FLAT_SALES_TAX_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

############################################################################ Sets ############################################################
  #[ERXLPS-726] New set created for dimensions only to include in sales explore
  set: sales_tx_tp_submit_detial_dimension_candidate_list {
    fields: [
      tx_tp_submit_detail_bin_number,
      tx_tp_submit_detail_version_number,
      tx_tp_submit_detail_processor_control_number,
      tx_tp_submit_detail_service_provider_identifier,
      tx_tp_submit_detail_patient_first_name,
      tx_tp_submit_detail_patient_last_name,
      tx_tp_submit_detail_pharmacy_provider_identifier,
      tx_tp_submit_detail_prescriber_identifier,
      tx_tp_submit_detail_cardholder_identifier,
      tx_tp_submit_detail_cardholder_first_name,
      tx_tp_submit_detail_cardholder_last_name,
      tx_tp_submit_detail_person_code,
      tx_tp_submit_detail_home_plan,
      tx_tp_submit_detail_plan_identifier,
      tx_tp_submit_detail_group_identifier,
      tx_tp_submit_detail_workers_comp_employer_name,
      tx_tp_submit_detail_product_identifier,
      tx_tp_submit_detail_prior_auth_number,
      tx_tp_submit_detail_transaction_code,
      tx_tp_submit_detail_service_provider_id_qualifier,
      tx_tp_submit_detail_place_of_service,
      tx_tp_submit_detail_patient_pregnancy_flag,
      tx_tp_submit_detail_patient_residence,
      tx_tp_submit_detail_pharmacy_provider_id_qualifier,
      tx_tp_submit_detail_prescriber_id_qualifier,
      tx_tp_submit_detail_patient_relation_code,
      tx_tp_submit_detail_eligible_clarification_code,
      tx_tp_submit_detail_product_id_qualifier,
      tx_tp_submit_detail_other_coverage_code,
      tx_tp_submit_detail_pharmacy_service_type,
      tx_tp_submit_detail_level_of_service,
      tx_tp_submit_detail_prior_auth_type_code,
      tx_tp_submit_detail_basis_of_cost_determination,
      tx_tp_submit_detail_percent_sales_tax_basis
    ]
  }

  #[ERXLPS-726] New set created to exclude sales specific measures from other explores
  set: explore_sales_specific_candidate_list {
    fields: [
      sum_sales_tx_tp_submit_detail_percent_sales_tax_amount,
      sum_sales_tx_tp_submit_detail_percent_sales_tax_rate,
      sum_sales_tx_tp_submit_detail_quantity_dispensed,
      sum_sales_tx_tp_submit_detail_days_supply,
      sum_sales_tx_tp_submit_detail_uc_charge,
      sum_sales_tx_tp_submit_detail_gross_amount_fee,
      sum_sales_tx_tp_submit_detail_ingredient_cost,
      sum_sales_tx_tp_submit_detail_patient_paid_amount,
      sum_sales_tx_tp_submit_detail_flat_sales_tax_amount
    ]
  }
}

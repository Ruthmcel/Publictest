view: eps_plan {
  label: "Plan"
  sql_table_name: EDW.D_STORE_PLAN ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${plan_id} ||'@'|| ${source_system_id} ;; #ERXLPS-1649 #ERXDWPS-5124
  }

  ######################################################### Primary / Foreign Key References #########################################################
  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: plan_id {
    label: "Plan ID"
    description: "Plan ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_plan_therapeutic_mac_carrier_id {
    label: "Plan Therapeutic Mac Carrier ID"
    description: "Carrier code of the insurance record whose therapeutic MAC records should be used for a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_CARRIER_ID ;;
  }

  dimension: store_plan_default_prescriber_id {
    label: "Plan Default Prescriber ID"
    description: "Default prescriber ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_DEFAULT_PRESCRIBER_ID ;;
  }

  dimension: store_plan_software_vendor_id {
    label: "Plan Software Vendor ID"
    description: "Software vendor certification ID number for NCPDP 5.1. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_SOFTWARE_VENDOR_ID ;;
  }

  dimension: store_plan_drug_cost_type_id {
    label: "Plan Drug Cost Type ID"
    description: "Cost base to be used by pricing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_DRUG_COST_TYPE_ID ;;
  }

  dimension: store_plan_basecost_id {
    label: "Plan Basecost ID"
    description: "ID of the Cost record to be used in calculating base cost. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_BASECOST_ID ;;
  }

  dimension: store_plan_tax_id {
    label: "Plan Tax ID"
    description: "Default Tax code to be used for this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TAX_ID ;;
  }

  dimension: store_plan_provider_id {
    label: "Plan Provider ID"
    description: "Provider ID that the plan recognizes this store by. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_PROVIDER_ID ;;
  }

  dimension: store_plan_alternate_drug_cost_type_id {
    label: "Plan Alternate Drug Cost Type ID"
    description: "Alternate cost base to be used for this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_ALTERNATE_DRUG_COST_TYPE_ID ;;
  }

  dimension: store_plan_submitter_id {
    label: "Plan Submitter ID"
    description: "Older ID that some plans use to indentify stores. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_SUBMITTER_ID ;;
  }

  dimension: store_plan_uc_fee_id {
    label: "Plan UC Fee ID"
    description: "Price Code used for Usual and Customary price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_UC_FEE_ID ;;
  }

  dimension: store_plan_phone_id {
    label: "Plan Phone ID"
    description: "Help Desk Phone Number. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_PHONE_ID ;;
  }

  dimension: store_plan_fax_phone_id {
    label: "Plan Fax Phone ID"
    description: "Unique ID of the Phone record that for the plan's fax number. Foreign Key to the phone table. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_FAX_PHONE_ID ;;
  }

  #[ERXLPS-934] - Store_plan_plan_type_reference dimension created to reference in sales.cash_bill_flag dimension. This is required as currently SF doesn't support sub-queires in where clause. Once SF fixes SF#8384 bug, store_plan_plan_type_reference can be replaced with store_plan_plan_type dimension.
  dimension: store_plan_plan_type_reference {
    label: "Plan Type"
    description: "Type of plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_PLAN_TYPE ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: store_plan_carrier_code {
    label: "Claim Plan Carrier Code"
    description: "Claim Carrier Code. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARRIER_CODE ;;
  }

  dimension: store_plan_plan {
    label: "Claim Plan Code"
    description: "Claim Plan Code. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN ;;
  }

  #[ERXLPS-6270] - Commented Plan Group Code from eps_plan view. EPS Data Dictionary says this column is depricated and do not have any data in EDW column.
  #dimension: store_plan_group_code {
  #  label: "Claim Plan Group Code"
  #  description: "Claim Plan Group Code. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
  #  type: string
  #  sql: ${TABLE}.STORE_PLAN_GROUP_CODE ;;
  #}

  dimension: store_plan_plan_name {
    label: "Claim Plan Name"
    description: "Claim Plan Name. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_NAME ;;
  }

  dimension: bi_demo_store_plan_plan_name {
    label: "Claim Plan Name"
    description: "Claim Plan Name. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: concat(concat('BI DEMO - ',ABS(hash(${store_plan_plan_name}))),' - PLAN') ;;
  }

  dimension: store_plan_eligible_flag {
    label: "Claim Plan Eligible Flag"
    description: "Indicates wheather a plan is eligible for third party activity. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ELIGIBLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ELIGIBLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG IS NULL THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'N' THEN 'HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'Y' THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'C' THEN 'CONVERTED'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'W' THEN 'WARNING'
              ELSE ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG
         END ;;
    suggestions: ["HARD HALT", "WARNING", "CONVERTED", "ELIGIBLE"]
  }

  dimension: store_plan_tp_error_override_flag {
    label: "Claim Plan TP Error Override Flag"
    description: "Indicates if third party errors can be overridden. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TP_ERROR_OVERRIDE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'N' THEN 'DO NOT ALLOW'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'Y' THEN 'ALLOW OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'P' THEN 'ALLOW WITH PRIOR AUTH NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'Q' THEN 'ALLOW WITH PRIOR AUTH CODE'
              ELSE ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG
         END ;;
    suggestions: ["ALLOW OVERRIDE", "DO NOT ALLOW", "ALLOW WITH PRIOR AUTH NUMBER / CODE", "ALLOW WITH PRIOR AUTH CODE"]
  }

  dimension: store_plan_price_override_flag {
    label: "Claim Plan Price Override Flag"
    description: "Indicates if the pharmacist can override price and/or copay while filling a prescription for this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRICE_OVERRIDE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG IS NULL THEN 'OVERRIDE ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'C' THEN 'OVERRIDE PRICE ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'P' THEN 'OVERRIDE COPAY ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'B' THEN 'OVERRIDE NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG
         END ;;
    suggestions: ["OVERRIDE ALLOWED", "OVERRIDE COPAY ALLOWED", "OVERRIDE PRICE ALLOWED", "OVERRIDE NOT ALLOWED"]
  }

  dimension: store_plan_format_card {
    label: "Claim Plan Format Card"
    description: "Format Card. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_FORMAT_CARD ;;
  }

  dimension: store_plan_check_card_flag {
    label: "Claim Plan Check Card Flag"
    description: "Flag determining if card number length should be verified when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_CHECK_CARD_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_CHECK_CARD_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'W' THEN 'VERIFY CARD NUMBER WARNING'
              WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'N' THEN 'DO NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'Y' THEN 'VERIFY CARD NUMBER HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG
         END ;;
    suggestions: ["VERIFY CARD NUMBER HARD HALT", "VERIFY CARD NUMBER WARNING", "DO NOT CHECK"]
  }

  dimension: store_plan_format_group {
    label: "Claim Plan Format Group"
    description: "Group number format. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_FORMAT_GROUP ;;
  }

  dimension: store_plan_check_group_flag {
    label: "Claim Plan Check Group Flag"
    description: "Flag determining if group number length should be verified when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_CHECK_GROUP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'Y' THEN 'VERIFY GROUP NUMBER HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'N' THEN 'DO NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'W' THEN 'VERIFY GROUP NUMBER WARNING'
              ELSE ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG
         END ;;
    suggestions: ["VERIFY GROUP NUMBER HARD HALT", "VERIFY GROUP NUMBER WARNING", "DO NOT CHECK"]
  }

  dimension: store_plan_require_group_flag {
    label: "Claim Plan Require Group Flag"
    description: "Flag indicating if a group number is required when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_GROUP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'W' THEN 'GROUP NUMBER REQUIRED WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'Y' THEN 'GROUP NUMBER REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG
         END ;;
    suggestions: ["GROUP NUMBER REQUIRED HARD HALT", "GROUP NUMBER REQUIRED WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_gender_flag {
    label: "Claim Plan Gender Flag"
    description: "Flag indicating if a plan record requires the patient's gender when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_GENDER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_GENDER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'W' THEN 'GROUP NUMBER REQUIRED WARNING'
              WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'Y' THEN 'GROUP NUMBER REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_GENDER_FLAG
         END ;;
    suggestions: ["REQUIRE PATIENT GENDER HARD HALT", "REQUIRE PATIENT GENDER WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_require_birth_flag {
    label: "Claim Plan Require Birth Flag"
    description: "Flag indicating if a plan record requires the patient's birth date when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_BIRTH_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'W' THEN 'REQUIRE DOB WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'Y' THEN 'REQUIRE DOB HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG
         END ;;
    suggestions: ["REQUIRE DOB HARD HALT", "REQUIRE DOB WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_require_address_flag {
    label: "Claim Plan Require Address Flag"
    description: "Flag indicating if a plan record requires the patient's address when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_ADDRESS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'W' THEN 'REQUIRE ADDRESS WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'Y' THEN 'REQUIRE ADDRESS HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG
         END ;;
    suggestions: ["REQUIRE ADDRESS HARD HALT", "REQUIRE ADDRESS WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_injury_flag {
    label: "Claim Plan Injury Flag"
    description: "Flag indicating if a plan record requires an injury date on worker's compensation records when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_INJURY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_INJURY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'W' THEN 'REQUIRE INJURY DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'Y' THEN 'REQUIRE INJURY DATE HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_INJURY_FLAG
         END ;;
    suggestions: ["REQUIRE INJURY DATE HARD HALT", "REQUIRE INJURY DATE WARNING", "NOT REQUIRED"]
  }

  #[ERXLPS-2253] - Modified logic with CASE WHEN statements to bypass SF known issue with co-related subquery error in where clause.
  dimension: store_plan_plan_type {
    #ERXLPS-185 - Fixed label name from Plan Plan Type to Plan Type
    label: "Claim Plan Type"
    description: "Claim Type of plan. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '1' THEN 'PRIVATE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '2' THEN 'STATE MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '3' THEN 'FEDERAL MEDICARE PART B'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '4' THEN 'FEDERAL MEDICARE PART D'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '5' THEN 'WORKERS COMPENSATION'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '6' THEN 'OTHER FEDERAL'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '7' THEN 'OTHER NON-MEDICAID STATE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '8' THEN 'CASH PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '9' THEN 'OTHER BENEFIT TYPE PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '10' THEN 'HMO'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '11' THEN 'MEDICAL FINANCIAL ASSISTANCE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '12' THEN 'HIGH-DEDUCTIBLE HEALTH PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '13' THEN 'AIDS DRUG ASSISTANCE PROGRAM PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '14' THEN 'STATE FORMULARY'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '15' THEN 'COLLEGE STUDENT'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '16' THEN 'CLINICALLY ADMINISTERED DRUGS'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '17' THEN 'DURABLE MEDICAL EQUIPMENT'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '18' THEN 'HEALTH INSURANCE EXCHANGE'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "PRIVATE",
      "STATE MEDICAID",
      "FEDERAL MEDICARE PART B",
      "FEDERAL MEDICARE PART D",
      "WORKERS COMPENSATION",
      "OTHER FEDERAL",
      "OTHER NON-MEDICAID STATE",
      "CASH PLAN",
      "OTHER BENEFIT TYPE PLAN",
      "HMO",
      "MEDICAL FINANCIAL ASSISTANCE",
      "HIGH-DEDUCTIBLE HEALTH PLAN",
      "AIDS DRUG ASSISTANCE PROGRAM PLAN",
      "STATE FORMULARY",
      "COLLEGE STUDENT",
      "CLINICALLY ADMINISTERED DRUGS",
      "DURABLE MEDICAL EQUIPMENT",
      "HEALTH INSURANCE EXCHANGE"
    ]
  }

  dimension: store_plan_require_patient_relationship_flag {
    label: "Claim Plan Require Patient Relationship Flag"
    description: "Flag indicating if a plan record requires a relationship code to be entered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'W' THEN 'WARNING RELATION TO PATIENT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'Y' THEN 'REQUIRES RELATION TO PATIENT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG
         END ;;
    suggestions: ["REQUIRES RELATION TO PATIENT", "NOT REQUIRED", "WARNING RELATION TO PATIENT"]
  }

  dimension: store_plan_no_dependent_flag {
    label: "Claim Plan No Dependent Flag"
    description: "Flag indicating if a plan record does not allow dependent coverage. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NO_DEPENDENT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'Y' THEN 'NOT ALLOWED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'W' THEN 'NOT ALLOWED WARNING'
              WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'N' THEN 'ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG
         END ;;
    suggestions: ["NOT ALLOWED HARD HALT", "NOT ALLOWED WARNING", "ALLOWED"]
  }

  dimension: store_plan_age_halt_flag {
    label: "Claim Plan Age Halt Flag"
    description: "Flag indicating the action that should occur when a patient age does not fall within any age boundaries as set by a drug, plan, third party or therapeutic restriction record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_AGE_HALT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_AGE_HALT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'Q' THEN 'HARD HALT REQUIRE PA FLAG'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / FLAG'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'Y' THEN 'HARD HALT FILLING'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'W' THEN 'WARNING'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'N' THEN 'NO ACTION TAKEN' --[ERXLPS-2383] - Added only at looker layer. Need to add in master code table.
              ELSE ${TABLE}.STORE_PLAN_AGE_HALT_FLAG
         END ;;
    suggestions: ["HARD HALT REQUIRE PA NUMBER / FLAG", "HARD HALT REQUIRE PA FLAG", "WARNING", "HARD HALT FILLING"]
  }

  dimension: store_plan_depend_age {
    label: "Claim Plan Depend Age"
    description: "Maximum age for dependent children. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DEPEND_AGE ;;
  }

  dimension: store_plan_student_age {
    label: "Claim Plan Student Age"
    description: "Maximum age for dependents that are considered students. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_STUDENT_AGE ;;
  }

  dimension: store_plan_adc_age {
    label: "Claim Plan Adc Age"
    description: "Maximum age at which ADC pricing and copay should be applied. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_ADC_AGE ;;
  }

  dimension: store_plan_require_coverage_code {
    label: "Claim Plan Require Coverage Code"
    description: "Flag indicating if a plan record requires a coverage code when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_COVERAGE_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'Y' THEN 'REQUIRE COVERAGE CODE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'W' THEN 'REQUIRE COVERAGE CODE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE
         END ;;
    suggestions: ["REQUIRE COVERAGE CODE HARD HALT", "REQUIRE COVERAGE CODE WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_require_card_begin_date_flag {
    label: "Claim Plan Require Card Begin Date Flag"
    description: "Flag indicating if a plan record requires an effective card date to be entered when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'W' THEN 'REQUIRE EFFECTIVE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'Y' THEN 'REQUIRE EFFECTIVE DATE HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE EFFECTIVE DATE HARD HALT", "REQUIRE EFFECTIVE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: store_plan_require_card_end_date_flag {
    label: "Claim Plan Require Card End Date Flag"
    description: "Flag indicating if a plan record requires an expiration card date to be entered when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'W' THEN 'REQUIRE EXPIRATION DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'Y' THEN 'REQUIRE EXPIRATION DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE EXPIRATION DATE HARD HALT", "REQUIRE EXPIRATION DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: store_plan_desi3_flag {
    label: "Claim Plan Desi3 Flag"
    description: "PLAN_DESI3 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 3 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI3_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI3_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_DESI3_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: store_plan_desi4_flag {
    label: "Claim Plan Desi4 Flag"
    description: "PLAN_DESI4 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 4 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI4_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI4_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              ELSE ${TABLE}.STORE_PLAN_DESI4_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: store_plan_desi5_flag {
    label: "Claim Plan Desi5 Flag"
    description: "PLAN_DESI5 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 5 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI5_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI5_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_DESI5_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: store_plan_restrict_otc_flag {
    label: "Claim Plan Restrict OTC Flag"
    description: "Flag that determines if the system hard halts or only shows a warning on the Check Rx Messages screen when you try to fill a prescription with an over-the-counter drug (Schedule 8) when billing to a third party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_RESTRICT_OTC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'Q' THEN 'HARD HALT ALLOW PA OR TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'P' THEN 'HARD HALT ALLOW PA OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'T' THEN 'HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'U' THEN 'HARD HALT ALLOW PA OVERRIDE NOT TP'
              ELSE ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG
         END ;;
    suggestions: [
      "HARD HALT ALLOW TP OVERRIDE",
      "WARNING ALLOW TP OVERRIDE",
      "HARD HALT NOT ALLOWED TO BE FILLED",
      "WARNING ALLOW FILLING",
      "NO ACTION",
      "HARD HALT ALLOW PA OVERRIDE",
      "HARD HALT ALLOW PA OR TP OVERRIDE",
      "HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP",
      "HARD HALT ALLOW PA OVERRIDE NOT TP"
    ]
  }

  dimension: store_plan_injectable_flag {
    label: "Claim Plan Injectable Flag"
    description: "PLAN_INJECTABLE is a flag that determines if the third party pays for an injectable drug (as set up on the Drug File screen). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_INJECTABLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_INJECTABLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'T' THEN 'HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'U' THEN 'HARD HALT ALLOW PA OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'Q' THEN 'HARD HALT ALLOW PA OR TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'P' THEN 'HARD HALT ALLOW PA OVERRIDE'
              ELSE ${TABLE}.STORE_PLAN_INJECTABLE_FLAG
         END ;;
    suggestions: [
      "HARD HALT ALLOW TP OVERRIDE",
      "WARNING ALLOW TP OVERRIDE",
      "HARD HALT NOT ALLOWED TO BE FILLED",
      "WARNING ALLOW FILLING",
      "NO ACTION",
      "HARD HALT ALLOW PA OVERRIDE",
      "HARD HALT ALLOW PA OR TP OVERRIDE",
      "HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP",
      "HARD HALT ALLOW PA OVERRIDE NOT TP"
    ]
  }

  dimension: store_plan_drug_tp_date_flag {
    label: "Claim Plan Drug TP Date Flag"
    description: "PLAN_TP_DATE_RANGE is a flag determining the action that should occur when a drug third party coverage date is out of range. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_TP_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG = 'Y' THEN 'HARD HALT NOT ALLOW TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG = 'W' THEN 'WARNING ALLOW TO BE FILLED'
              ELSE ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG
         END ;;
    suggestions: ["HARD HALT NOT ALLOW TO BE FILLED", "WARNING ALLOW TO BE FILLED"]
  }

  dimension: store_plan_therapeutic_maintenance_flag {
    label: "Claim Plan Therapeutic Maintenance Flag"
    description: "PLAN_THERAPEUTIC_MAINTENANCE is a flag determining which therapeutic maintenance flag should be used for a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG IS NULL THEN 'USE THERAPEUTIC RESTRICTION'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'S' THEN 'USE THERAPEUTIC RESTRICTION MATCH TP'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'Y' THEN 'USE THERAPEUTIC HIERARCHY NON-BLANK MAINT FLAG'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'N' THEN 'USE DRUG THIRD PARTY RECORD'
              ELSE ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG
         END ;;
    suggestions: ["USE THERAPEUTIC RESTRICTION", "USE THERAPEUTIC HIERARCHY NON-BLANK MAINT FLAG", "USE THERAPEUTIC RESTRICTION MATCH TP", "USE DRUG THIRD PARTY RECORD"]
  }

  dimension: store_plan_therapeutic_mac_flag {
    label: "Claim Plan Therapeutic MAC Flag"
    description: "PLAN THERAPEUTIC MAC is a flag determining which therapeutic MAC record the system uses when determining the maximum allowable cost for a third party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_THERAPEUTIC_MAC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG IS NULL THEN 'USE FIRST THERAPEUTIC MAC RECORD'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG = 'S' THEN 'USE THERAPEUTIC MAC MATCHES TP'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG = 'N' THEN 'USE DRUG THIRD PARTY RECORD'
              ELSE ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG
         END ;;
    suggestions: ["USE FIRST THERAPEUTIC MAC RECORD", "USE THERAPEUTIC MAC MATCHES TP", "USE DRUG THIRD PARTY RECORD"]
  }

  dimension: store_plan_require_drug_tp_flag {
    label: "Claim Plan Require Drug TP Flag"
    description: "Flag indicating if a plan requires a drug third party record and the action to take if a drug third party record is required but is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'Q' THEN 'REQUIRED HARD HALT PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'P' THEN 'REQUIRED HARD HALT PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT", "REQUIRED WARNING ALLOW FILL", "REQUIRED HARD HALT PA NUMBER / CODE", "REQUIRED HARD HALT PRIOR AUTH CODE", "NOT REQUIRED"]
  }

  dimension: store_plan_host_drug_tp_flag {
    label: "Claim Plan Host Drug TP Flag"
    description: "Flag indicating if a plan requires a Host supported drug third party record and the action to take if a Host supported drug third party record is required but is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_HOST_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_ignore_default_drug_tp_flag {
    label: "Claim Plan Ignore Default Drug TP Flag"
    description: "Flag determining if the system checks the edits on the default drug third party record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'G' THEN 'IGNORES WHEN GENERIC DRUG'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'M' THEN 'IGNORES WHEN MAINT FLAG IS Y'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'N' THEN 'DEFUALT DRUG TP'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'B' THEN 'IGNORES WHEN MAINT FLAG IS Y OR GENERIC'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'Y' THEN 'IGNORES DEFAULT DRUG TP'
              ELSE ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG
         END ;;
    suggestions: ["IGNORES DEFAULT DRUG TP", "IGNORES WHEN MAINT FLAG IS Y", "IGNORES WHEN GENERIC DRUG", "IGNORES WHEN MAINT FLAG IS Y OR GENERIC", "DEFUALT DRUG TP"]
  }

  dimension: store_plan_drug_tp_code {
    label: "Claim Plan Drug TP Code"
    description: "Flag determining if a drug third party code is required when adding or updating a drug third party record and the action to take if a drug third party code is required but one is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_TP_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_TP_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_DRUG_TP_CODE
         END ;;
    suggestions: ["REQUIRED HARD HALT UPDATE NOT ALLOWED", "REQUIRED WARNING ALLOW UPDATE", "NOT REQUIRED"]
  }

  dimension: store_plan_require_vendor_tp_flag {
    label: "Claim Plan Require Vendor TP Flag"
    description: "Flag determining if a vendor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_VENDOR_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_phone_flag {
    label: "Claim Plan Require Prescriber Phone Flag"
    description: "Flag determining if a doctor telephone number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_tp_flag {
    label: "Claim Plan Require Prescriber TP Flag"
    description: "Flag determining if a doctor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_refill_halt_type {
    label: "Claim Plan Refill Halt Type"
    description: "Flag determining the action that should occur when a refill edit fails. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REFILL_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REFILL_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'Y' THEN 'HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NOT REQUIRED"]
  }

  dimension: store_plan_both_refill_edits_flag {
    label: "Claim Plan Both Refill Edits"
    description: "Yes/No Flag indicating if the system checks maximum number of refills and refills expiration by reading through a patient's transaction profile. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BOTH_REFILL_EDITS_FLAG = 'Y' ;;
  }

  dimension: store_plan_set_expire_flag {
    label: "Claim Plan Set Expire"
    description: "Yes/No Flag indicating how a prescription expiration date is calculated. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SET_EXPIRE_FLAG = 'Y' ;;
  }

  dimension: store_plan_set_max_flag {
    label: "Claim Plan Set Max"
    description: "Yes/No Flag indicating if the number of refills allowed is corrected to the maximum allowed if more than the maximum number of refills is entered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SET_MAX_FLAG = 'Y' ;;
  }

  dimension: store_plan_refill_days_limit {
    label: "Claim Plan Refill Days Limit"
    description: "Maximum number of days a prescription can be refilled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_REFILL_DAYS_LIMIT ;;
  }

  dimension: store_plan_maximum_number_refills {
    label: "Claim Plan Maximum Number Refills"
    description: "Maximum number of refills allowed by a plan on all drugs except schedule 3, 4 and 5. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_NUMBER_REFILLS ;;
  }

  dimension: store_plan_schedule_number_refill {
    label: "Claim Plan Schedule Number Refill"
    description: "Maximum number of refills allowed by a plan on schedule 3, 4 and 5 drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_SCHEDULE_NUMBER_REFILL ;;
  }

  dimension: store_plan_number_days {
    label: "Claim Plan Number Days"
    description: "Number of days before a prescription may be refilled again. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_DAYS ;;
  }

  dimension: store_plan_percent_days {
    label: "Claim Plan Percent Days"
    description: "Percentage of days supply that must pass before a prescription may be refilled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_PERCENT_DAYS ;;
  }

  dimension: store_plan_disallow_quantity_changes_flag {
    label: "Claim Plan Disallow Quantity Changes"
    description: "Yes/No Flag indicating if quantity changes on refills are disallowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_QUANTITY_CHANGES_FLAG = 'Y' ;;
  }

  dimension: store_plan_quantity_halt_type {
    label: "Claim Plan Quantity Halt Type"
    description: "Flag determining the action that should occur if dispensing limits are exceeded. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_QUANTITY_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'Y' THEN 'HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NO ACTION"]
  }

  dimension: store_plan_pass_both_regular_limits_flag {
    label: "Claim Plan Pass Both Regular Limits Flag"
    description: "Flag determining if non-maintenance prescription must pass one or both dispensing limit checks in order to be filled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG IS NULL THEN 'NOT CHECKED'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG = 'N' THEN 'PASS ONE CHECK'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG = 'Y' THEN 'PASS BOTH CHECKS'
              ELSE ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG
        END ;;
    suggestions: ["NOT CHECKED", "PASS BOTH CHECKS", "PASS ONE CHECK"]
  }

  dimension: store_plan_pass_both_maintenance_limits_flag {
    label: "Claim Plan Pass Both Maintenance Limits Flag"
    description: "Flag determining if maintenance prescription must pass one or both dispensing limit checks in order to be filled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG IS NULL THEN 'NOT CHECKED'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG = 'N' THEN 'PASS ONE CHECK'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG = 'Y' THEN 'PASS BOTH CHECKS'
              ELSE ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG
         END ;;
    suggestions: ["NOT CHECKED", "PASS BOTH CHECKS", "PASS ONE CHECK"]
  }

  dimension: store_plan_quantity_limit_type {
    label: "Claim Plan Quantity Limit Type"
    description: "Flag determining if dispensing limits are based on units or doses. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #[ERXLPS-2383] CASE WHEN logic added with master codes. Currently this column do not added to EDW.D_MASTER_CODE table. We need to add them to master code table.
    sql: CASE WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE = '0' THEN 'UNITS'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE = '1' THEN 'DOSES'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE)
         END ;;
    suggestions: ["NOT SPECIFIED", "UNITS", "DOSES"]
  }

  dimension: store_plan_maximum_days_supply {
    label: "Claim Plan Maximum Days Supply"
    description: "Maximum days supply allowed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_DAYS_SUPPLY ;;
  }

  dimension: store_plan_minimum_days_supply {
    label: "Claim Plan Minimum Days Supply"
    description: "Minimum days supply allowed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_DAYS_SUPPLY ;;
  }

  dimension: store_plan_max_maintenance_days_supply {
    label: "Claim Plan Max Maintenance Days Supply"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAX_MAINTENANCE_DAYS_SUPPLY ;;
  }

  dimension: store_plan_minimum_maintenance_days_supply {
    label: "Claim Plan Minimum Maintenance Days Supply"
    description: "Minimum days supply allowed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_MAINTENANCE_DAYS_SUPPLY ;;
  }

  dimension: store_plan_maximum_ml_packs {
    label: "Claim Plan Maximum ML Packs"
    description: "Flag determining if number of packs dispensed is limited for liquid drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAXIMUM_ML_PACKS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS IS NULL THEN 'NOT LIMITED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '1' THEN 'LIMIT ONE PACK'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '2' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '3' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '4' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '5' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '6' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '7' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '8' THEN 'LIMIT TO PACKS ENTERED'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS)
         END ;;
    suggestions: [
      "NOT LIMITED",
      "LIMIT ONE PACK",
      "LIMIT TO PACKS ENTERED"
    ]
  }

  dimension: store_plan_maximum_single_packs {
    label: "Claim Plan Maximum Single Packs"
    description: "Yes/No Flag indicating if the single pack flag on the drug third party record is checked. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_SINGLE_PACKS = 'Y' ;;
  }

  dimension: store_plan_maximum_gram_packs {
    label: "Claim Plan Maximum Gram Packs"
    description: "Flag determining if number of packs dispensed is limited for gram unit drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAXIMUM_GRAM_PACKS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS IS NULL THEN 'NOT LIMITED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '1' THEN 'LIMIT ONE PACK'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '2' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '3' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '4' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '5' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '6' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '7' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '8' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '9' THEN 'LIMIT TO PACKS ENTERED'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS)
         END ;;
    suggestions: [
      "NOT LIMITED",
      "LIMIT ONE PACK",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED",
      "LIMIT TO PACKS ENTERED"
    ]
  }

  dimension: store_plan_initial_fill_max_days {
    label: "Claim Plan Initial Fill Max Days"
    description: "Maximum days supply allowed on the initial fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_INITIAL_FILL_MAX_DAYS ;;
  }

  dimension: store_plan_round_up_flag {
    label: "Claim Plan Round Up"
    description: "Yes/No Flag indicating if calculated days supply should be rounded up or down. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ROUND_UP_FLAG = 'Y' ;;
  }

  dimension: store_plan_max_halt_code {
    label: "Claim Plan Max Halt Code"
    description: "Flag indicating the action that should occur when the prescription being filled exceeds the maximum dollar amount or number of refills allowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAX_HALT_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAX_HALT_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'Y' THEN 'HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              ELSE ${TABLE}.STORE_PLAN_MAX_HALT_CODE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NO ACTION"]
  }

  dimension: store_plan_number_override_flag {
    label: "Claim Plan Number Override"
    description: "Yes/No Flag indicating what value should be used in determining the prescription limit allowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NUMBER_OVERRIDE_FLAG = 'Y' ;;
  }

  dimension: store_plan_number_rx_dependecy {
    label: "Claim Plan Number Rx Dependecy"
    description: "Number of prescription fills allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_RX_DEPENDECY ;;
  }

  dimension: store_plan_require_generic_flag {
    label: "Claim Plan Require Generic Flag"
    description: "Flag determining use of linked substitute drug should be forced unless overridden by a DAW. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_GENERIC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'N' THEN 'DO NOT FORCE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'Y' THEN 'FORCE USE OF LINK'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'W' THEN 'LINKED SUBSTITUTE IS REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG
         END ;;
    suggestions: ["FORCE USE OF LINK", "LINKED SUBSTITUTE IS REQUIRED", "DO NOT FORCE"]
  }

  dimension: store_plan_require_daw_flag {
    label: "Claim Plan Require DAW Flag"
    description: "Flag determining if a DAW code is required when dispensing a brand drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DAW_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'W' THEN 'REQUIRED - WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'Y' THEN 'REQUIRED - HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT", "REQUIRED - WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prior_auth_number_flag {
    label: "Claim Plan Require Prior Auth Number Flag"
    description: "Flag determining if a prior authorization number is  required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT", "REQUIRED - WARNING", "NOT REQUIRED"]
  }

  dimension: store_plan_low_cost_flag {
    label: "Claim Plan Low Cost"
    description: "Yes/No Flag indicating if the prescription cost should be calculated using both the primary and alternate cost bases and then use the lower of the two costs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_LOW_COST_FLAG = 'Y' ;;
  }

  dimension: store_plan_use_discount_flag {
    label: "Claim Plan use Discount Flag"
    description: "Flag determining when a patient's usual discount should be applied. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_USE_DISCOUNT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'Y' THEN 'ALWAYS USE'
              WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'U' THEN 'USE ONLY VIA PRICE CODE'
              WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'N' THEN 'NEVER USE'
              ELSE ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG
         END ;;
    suggestions: ["ALWAYS USE", "USE ONLY VIA PRICE CODE", "NEVER USE"]
  }

  dimension: store_plan_cost_percent {
    label: "Claim Plan Cost Percent"
    description: "Percentage of cost to override cost base. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_COST_PERCENT ;;
    value_format: "00.00\"%\""
  }

  dimension: store_plan_maximum_allowable_cost_flag {
    label: "Claim Plan Maximum Allowable Cost"
    description: "Flag determining the cost used for a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ALLOWABLE_COST_FLAG = 'Y' ;;
  }

  dimension: store_plan_ignore_mac_flag {
    label: "Claim Plan Ignore MAC Flag"
    description: "Flag determining if MAC pricing is ignored. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_IGNORE_MAC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'Y' THEN 'IGNORE MAC PRICING UNLESS DAW IS 1'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'N' THEN 'USE MAC PRICING'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'A' THEN 'IGNORE MAC PRICING UNLESS DAW IS 0 OR 6'
              ELSE ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG
         END ;;
    suggestions: ["IGNORE MAC PRICING UNLESS DAW IS 1", "IGNORE MAC PRICING UNLESS DAW IS 0 OR 6", "USE MAC PRICING"]
  }

  dimension: store_plan_generic_fee_calculation_type {
    label: "Claim Plan Generic Fee Calculation Type"
    description: "Yes/No Flag indicating how the generic fee is calculated when dispensing a generic drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_GENERIC_FEE_CALCULATION_TYPE = 'Y' ;;
  }

  dimension: store_plan_taxable_flag {
    label: "Claim Plan Taxable Flag"
    description: "Flag determining if tax should be calculated. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TAXABLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TAXABLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'N' THEN 'DO NOT CALCULATE'
              WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'P' THEN 'CALCULATE IF PRICE CODE'
              WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'Y' THEN 'ALWAYS CALCULATE'
              ELSE ${TABLE}.STORE_PLAN_TAXABLE_FLAG
         END ;;
    suggestions: ["ALWAYS CALCULATE ", "CALCULATE IF PRICE CODE", "DO NOT CALCULATE"]
  }

  dimension: store_plan_transmit_excludes_tax_flag {
    label: "Claim Plan Transmit Excludes Tax"
    description: "Yes/No Flag indicating how the tax amount received from a third party is handled when a 100% copay is received. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_EXCLUDES_TAX_FLAG = 'Y' ;;
  }

  dimension: store_plan_compare_uc_flag {
    label: "Claim Plan Compare UC Flag"
    description: "Flag determining if the third party prescription price is compared to the usual and customary cash price with the lesser price being used to price the prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COMPARE_UC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COMPARE_UC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'Y' THEN 'USE LOWER PRICE'
              WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'D' THEN 'INCLUDE DISCOUNT USE LOWER PRICE'
              WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'N' THEN 'DO NOT COMPARE'
              ELSE ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG
         END ;;
    suggestions: ["USE LOWER PRICE", "INCLUDE DISCOUNT USE LOWER PRICE", "DO NOT COMPARE"]
  }

  dimension: store_plan_uc_price_flag {
    label: "Claim Plan UC Price"
    description: "Yes/No Flag indicating if fees are added to the usual and customary price in order to determine the third party price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_UC_PRICE_FLAG = 'Y' ;;
  }

  dimension: store_plan_base_sig_dose_flag {
    label: "Claim Plan Base Sig Dose"
    description: "Yes/No Flag indicating if the value on which to base a unit dose fee. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BASE_SIG_DOSE_FLAG = 'Y' ;;
  }

  measure: store_plan_bubble {
    label: "Claim Plan Bubble"
    description: "Unit dose fee amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_BUBBLE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_plan_add_compound_flag {
    label: "Claim Plan Add Compound Flag"
    description: "Flag determining how a compound fee is handled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ADD_COMPOUND_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'U' THEN 'FEE ADDED AND UPCHARGE'
              WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'Y' THEN 'FEE ADDED'
              WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'N' THEN 'FEE NOT ADDED'
              ELSE ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG
         END ;;
    suggestions: ["FEE ADDED", "FEE ADDED AND UPCHARGE", "FEE NOT ADDED"]
  }

  dimension: store_plan_copay_basis {
    label: "Claim Plan Copay Basis"
    description: "Determines whether the Copay should be calculated from the Base Cost, U&C Price, or Rx Price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COPAY_BASIS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COPAY_BASIS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'C' THEN 'BASE COST'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'U' THEN 'U C PRICE'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'P' THEN 'RX PRICE'
              ELSE ${TABLE}.STORE_PLAN_COPAY_BASIS
         END ;;
    suggestions: ["NOT SPECIFIED", "BASE COST", "U C PRICE", "RX PRICE"]
  }

  dimension: store_plan_total_dependable_flag {
    label: "Claim Plan Total Dependable"
    description: "Yes/No Flag indicating if the reimbursement and deductible are totaled on the patient third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TOTAL_DEPENDABLE_FLAG = 'Y' ;;
  }

  dimension: store_plan_how_max_flag {
    label: "Claim Plan How Max"
    description: "Yes/No Flag indicating if the value on which to base the maximum reimbursement amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_HOW_MAX_FLAG = 'Y' ;;
  }

  dimension: store_plan_copay_flag {
    label: "Claim Plan Copay Flag"
    description: "Flag indicating if copay amount is included in the maximum reimbursement amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COPAY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COPAY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG IS NULL THEN 'DOES NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG = 'N' THEN 'EXCLUDE COPAY'
              WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG = 'Y' THEN 'INCLUDES COPAY'
              ELSE ${TABLE}.STORE_PLAN_COPAY_FLAG
         END ;;
    suggestions: ["DOES NOT CHECK", "INCLUDES COPAY", "EXCLUDE COPAY"]
  }

  dimension: store_plan_split_copay_flag {
    label: "Claim Plan Split Copay"
    description: "Yes/No Flag indicating if a plan pays 100% of the primary third party copay when plan is billed as a split bill. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SPLIT_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_plan_price_compare_flag {
    label: "Claim Plan Price Compare Flag"
    description: "Flag indicating the action to take if the copay is greater than the third party price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRICE_COMPARE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'N' THEN 'LOWER COPAY'
              WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'Y' THEN 'RAISE PRICE TO COPAY'
              WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'D' THEN 'IF NOT TRANSMIT RAISE PRICE'
              ELSE ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG
         END ;;
    suggestions: ["RAISE PRICE TO COPAY", "IF NOT TRANSMIT RAISE PRICE", "LOWER COPAY"]
  }

  dimension: store_plan_copay_uc_compare_flag {
    label: "Claim Plan Copay UC Compare"
    description: "Yes/No Flag indicating if copay is compared to the usual and customary price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_COPAY_UC_COMPARE_FLAG = 'Y' ;;
  }

  dimension: store_plan_cash_bill_flag {
    label: "Claim Plan Cash Bill"
    description: "Yes/No Flag indicating if a prescription is treated as a third party prescription or a cash prescription when the prescription amount equals the copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CASH_BILL_FLAG = 'Y' ;;
  }

  dimension: store_plan_adc_first_flag {
    label: "Claim Plan Adc First"
    description: "Yes/No Flag indicating if ADC copays and discounts are assigned before compound or over the counter copays and discounts. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ADC_FIRST_FLAG = 'Y' ;;
  }

  dimension: store_plan_otc_accumulator_flag {
    label: "Claim Plan OTC Accumulator"
    description: "Yes/No Flag indicating if over the counter copays are excluded from patient third party accumulators. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_OTC_ACCUMULATOR_FLAG = 'Y' ;;
  }

  dimension: store_plan_disable_cardholder_copay_flag {
    label: "Claim Plan Disable Cardholder Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a cardholder record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_CARDHOLDER_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_plan_disable_drug_tp_copay_flag {
    label: "Claim Plan Disable Drug TP Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a drug third party  record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_DRUG_TP_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_plan_disable_therapuetic_restriction_copay_flag {
    label: "Claim Plan Disable Therapuetic Restriction Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a therapeutic restriction record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_THERAPUETIC_RESTRICTION_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_plan_sig_on_file_flag {
    label: "Claim Plan Sig On File Flag"
    description: "Flag indicating the value that should print on the patient signature line when printing third party claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_SIG_ON_FILE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG IS NULL THEN 'SIGNATURE FIELD BLANK'
              WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG = '1' THEN '1 IN THE SIGNATURE FIELD'
              WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG = '2' THEN 'SIG ON FILE IN FIELD'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG)
         END ;;
    suggestions: ["SIGNATURE FIELD BLANK", "1 IN THE SIGNATURE FIELD", "SIG ON FILE IN FIELD"]
  }

  dimension: store_plan_pharmacy_transmit_id_type {
    label: "Claim Plan Pharmacy Transmit ID Type"
    description: "Code indicating the value to be used for the pharmacy identification number when processing third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE IS NULL THEN 'PROVIDER NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '1' THEN 'PROVIDER NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '2' THEN 'TRANSMITTAL ID NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '3' THEN 'NCPDP STORE NUMBER'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE)
         END ;;
    suggestions: ["PROVIDER NUMBER", "TRANSMITTAL ID NUMBER", "NCPDP STORE NUMBER"]
  }

  dimension: store_plan_print_dependent_number_flag {
    label: "Claim Plan Print Dependent Number Flag"
    description: "Flag determining if the dependent number prints on universal claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'Y' THEN 'PRINTS DEPENDENT NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'N' THEN 'DOES NOT PRINT DEPENDENT NUMBER' --Corrected the value based on data dictionary. EDW.D_MASTER_CODE table do not have correct description. [ERXDWPS-1432]
              WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'T' THEN 'APPENDS DEPENDENT NUMBER' --Corrected the value based on data dictionary. EDW.D_MASTER_CODE table do not have correct description. [ERXDWPS-1432]
              ELSE ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG
         END ;;
    suggestions: ["PRINTS DEPENDENT NUMBER", "DOES NOT PRINT DEPENDENT NUMBER", "APPENDS DEPENDENT NUMBER"]
  }

  dimension: store_plan_total_by_flag {
    label: "Claim Plan Total by Flag"
    description: "Flag determining how totals are printed on universal claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TOTAL_BY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TOTAL_BY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG IS NULL THEN 'DOES NOT USE TOTAL BY'
              WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG = '1' THEN 'TOTALS BY CARRIER'
              WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG = '2' THEN 'PLAN BASIS TOTAL'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_TOTAL_BY_FLAG)
         END ;;
    suggestions: ["DOES NOT USE TOTAL BY", "TOTALS BY CARRIER", "PLAN BASIS TOTAL"]
  }

  dimension: store_plan_sort_by_flag {
    label: "Claim Plan Sort by Flag"
    description: "Flag determining how claims are sorted when printing claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_SORT_BY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_SORT_BY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '1' THEN 'TRANSACTION NUMBER'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '2' THEN 'PRESCRIPTION NUMBER'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '3' THEN 'PATIENT NAME'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_SORT_BY_FLAG)
         END ;;
    suggestions: ["TRANSACTION NUMBER", "PRESCRIPTION NUMBER", "PATIENT NAME", "NOT SPECIFIED"]
  }

  dimension: store_plan_split_flag {
    label: "Claim Plan Split"
    description: "Yes/No Flag indicating if a plan record is eligible for use as a split bill plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SPLIT_FLAG = 'Y' ;;
  }

  dimension: store_plan_nhin_process_code {
    label: "Claim Plan NHIN Process Code"
    description: "Flag indicating if NHIN processes claims for a plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NHIN_PROCESS_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'N' THEN 'DOES NOT PROCESS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'B' THEN 'SUBMITS AND RECONCILES CLAMS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'R' THEN 'RECONCILES CLAIMS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'S' THEN 'SUBMITS CLAIMS'
              ELSE ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE
         END ;;
    suggestions: ["SUBMITS CLAIMS", "RECONCILES CLAIMS", "SUBMITS AND RECONCILES CLAMS", "DOES NOT PROCESS"]
  }

  dimension: store_plan_transfer_to_account_flag {
    label: "Claim Plan Transfer to Account"
    description: "Yes/No Flag indicating if the difference between the submitted amount and paid amount is transferred to the store account. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSFER_TO_ACCOUNT_FLAG = 'Y' ;;
  }

  dimension: store_plan_print_balance_flag {
    label: "Claim Plan Print Balance"
    description: "Yes/No Flag indicating if claims may be re-submitted. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PRINT_BALANCE_FLAG = 'Y' ;;
  }

  dimension: store_plan_number_rebill {
    label: "Claim Plan Number Rebill"
    description: "Number of times a plan allows a claim to be re-billed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_REBILL ;;
  }

  dimension: store_plan_basis {
    label: "Claim Plan Basis"
    description: "Drug cost basis. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_BASIS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_BASIS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_BASIS IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '1' THEN 'AWP-DEFAULT'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '2' THEN 'THE LOCAL WHOLESALER'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '3' THEN 'DIRECT'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '4' THEN 'ESTIMATED ACQ'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '5' THEN 'ACQUISITION'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '6' THEN 'MAC'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '7' THEN 'USUAL AND CUSTOMARY'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '8' THEN '340B'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '9' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '10' THEN 'ASP'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '11' THEN 'AMP'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '12' THEN 'WAC'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '13' THEN 'SPECIAL'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '14' THEN 'UNREPORTABLE QTY'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_BASIS)
         END ;;
    suggestions: [
      "UNDETERMINED",
      "AWP-DEFAULT",
      "THE LOCAL WHOLESALER",
      "DIRECT",
      "ESTIMATED ACQ",
      "ACQUISITION",
      "MAC",
      "USUAL AND CUSTOMARY",
      "340B",
      "OTHER",
      "ASP",
      "AMP",
      "WAC",
      "SPECIAL",
      "UNREPORTABLE QTY",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_allow_change_price_flag {
    label: "Claim Plan Allow Change Price Flag"
    description: "Flag determining if the Change Price screen is automatically displayed after claim transmission and if the price of a claim is allowed to be changed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG IS NULL THEN 'MAY NOT BE CHANGED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'R' THEN 'MAY ONLY BE RAISED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'S' THEN 'RAISED UP TO THE AMOUNT SUBMITTED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'Y' THEN 'MAY BE CHANGED'
              ELSE ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG
         END ;;
    suggestions: ["MAY NOT BE CHANGED", "MAY BE CHANGED", "MAY ONLY BE RAISED", "RAISED UP TO THE AMOUNT SUBMITTED"]
  }

  dimension: store_plan_transmit_31_flag {
    label: "Claim Plan Transmit 31"
    description: "Yes/No Flag indicating if NCPDP 31 type transmissions may be re-submitted during Rx Correction. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_31_FLAG = 'Y' ;;
  }

  dimension: store_plan_service_flag {
    label: "Claim Plan Service"
    description: "Yes/No Flag indicating if a plan supports cognitive services. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SERVICE_FLAG = 'Y' ;;
  }

  dimension: store_plan_no_paper_flag {
    label: "Claim Plan No Paper Flag"
    description: "Flag indicating if a plan allows paper billing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NO_PAPER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NO_PAPER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'N' THEN 'ALLOW PAPER BILLING'
              WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'W' THEN 'WARN PAPER BILLING NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'Y' THEN 'PAPER BILLING NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_NO_PAPER_FLAG
         END ;;
    suggestions: ["PAPER BILLING NOT ALLOWED", "WARN PAPER BILLING NOT ALLOWED", "ALLOW PAPER BILLING"]
  }

  dimension: store_plan_compound_paper_flag {
    label: "Claim Plan Compound Paper"
    description: "Yes/No Flag indicating if a plan allows compounds to be billed on paper for transmitted claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_COMPOUND_PAPER_FLAG = 'Y' ;;
  }

  dimension: store_plan_card_layout_help_1 {
    label: "Claim Plan Card Layout Help 1"
    description: "CARD_LAYOUT_HELP_1 stores the first line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_1 ;;
  }

  dimension: store_plan_card_layout_help_2 {
    label: "Claim Plan Card Layout Help 2"
    description: "CARD_LAYOUT_HELP_2 stores the 2nd line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_2 ;;
  }

  dimension: store_plan_card_layout_help_3 {
    label: "Claim Plan Card Layout Help 3"
    description: "CARD_LAYOUT_HELP_3 stores the 3rd line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_3 ;;
  }

  dimension: store_plan_card_layout_help_4 {
    label: "Claim Plan Card Layout Help 4"
    description: "CARD_LAYOUT_HELP_4 stores the 4th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_4 ;;
  }

  dimension: store_plan_card_layout_help_5 {
    label: "Claim Plan Card Layout Help 5"
    description: "CARD_LAYOUT_HELP_5 stores the 5th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_5 ;;
  }

  dimension: store_plan_card_layout_help_6 {
    label: "Claim Plan Card Layout Help 6"
    description: "CARD_LAYOUT_HELP_6 stores the 6th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_6 ;;
  }

  dimension: store_plan_plan_text {
    label: "Claim Plan Plan Text"
    description: "Additional insurance plan information and help text. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_TEXT ;;
  }

  dimension: store_plan_contact {
    label: "Claim Plan Contact"
    description: "Help desk contact name or department. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CONTACT ;;
  }

  dimension_group: store_plan_begin_coverage_date {
    label: "Claim Plan Begin Coverage"
    description: "BEGIN_COVERAGE_DATE stores the date when the third party plan is effective. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_BEGIN_COVERAGE_DATE ;;
  }

  dimension_group: store_plan_end_coverage_date {
    label: "Claim Plan End Coverage"
    description: "END_COVERAGE_DATE is the date when the third party plan expires. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_END_COVERAGE_DATE ;;
  }

  dimension: store_plan_require_patient_tp_begin_date_flag {
    label: "Claim Plan Require Patient TP Begin Date Flag"
    description: "REQ_PATIENT_TP_BEGIN_DATE is a flag indicating if a beginning patient third party coverage date is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'Y' THEN 'REQUIRE DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'W' THEN 'REQUIRE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE DATE HARD HALT", "REQUIRE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: store_plan_require_patient_tp_end_date_flag {
    label: "Claim Plan Require Patient TP End Date Flag"
    description: "REQ_PATIENT_TP_END_DATE is a flag indicating if an ending patient third party coverage date is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'Y' THEN 'REQUIRE DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'W' THEN 'REQUIRE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE DATE HARD HALT", "REQUIRE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: store_plan_state_formulary_last {
    label: "Claim Plan State Formulary Last"
    description: "STATE_FORMLUARY_LAST stores the last drug third party state formulary update. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE_FORMULARY_LAST ;;
  }

  dimension: store_plan_no_compound_daw_flag {
    label: "Claim Plan No Compound DAW"
    description: "Yes/No Flag indicating if compounds should be excluded from DAW checks. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NO_COMPOUND_DAW_FLAG = 'Y' ;;
  }

  dimension: store_plan_pharmacy_provider_id_qualifier {
    label: "Claim Plan Pharmacy Provider ID Qualifier"
    description: "Service provider ID qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '99' THEN 'OTHER'
              ELSE ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER
         END ;;
    suggestions: [
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_pharmacist_id_qualifier {
    label: "Claim Plan Pharmacist ID Qualifier"
    description: "Pharmacist ID Qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACIST_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '01' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '02' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '03' THEN 'SS NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '04' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '05' THEN 'NPI'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '06' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '07' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '99' THEN 'OTHER'
              ELSE ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER
         END ;;
    suggestions: [
      "DEA",
      "STATE LICENSE",
      "SS NUMBER",
      "NAME",
      "NPI",
      "HIN",
      "STATE ISSUED",
      "OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_prescriber_transmit_id_qualifier {
    label: "Claim Plan Prescriber Transmit ID Qualifier"
    description: "Physician ID Qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '81' THEN 'SASK MEDICAL PRACT'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '82' THEN 'SASK PHARMACIST'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '83' THEN 'SASK HEALTH MED SRV'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER
         END ;;
    suggestions: [
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "SASK MEDICAL PRACT",
      "SASK PHARMACIST",
      "SASK HEALTH MED SRV",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_non_complete_flag {
    label: "Claim Plan Non Complete Flag"
    description: "Flag indicating how non-completed claims should be handled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NON_COMPLETE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'S' THEN = 'DISPLAYS ON SUBMIT REJECT'
              WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'W' THEN = 'WARNING ON FILLING SCREEN'
              WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'N' THEN = 'NOTHING INDICATED'
              ELSE ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG
         END ;;
    suggestions: ["DISPLAYS ON SUBMIT REJECT", "WARNING ON FILLING SCREEN", "NOTHING INDICATED"]
  }

  dimension: store_plan_low_based_acquisition_flag {
    label: "Claim Plan Low Based Acquisition"
    description: "Yes/No Flag indicating if the acquisition cost or the submitted price should be used when determining low payment status. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_LOW_BASED_ACQUISITION_FLAG = 'Y' ;;
  }

  dimension: store_plan_prescriber_paper_alt_id_type {
    label: "Claim Plan Prescriber Paper Alt ID Type"
    description: "Flag indicating the value to use for the alternate doctor ID if the primary ID is blank. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '1' THEN 'DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '2' THEN 'STATE/PROVINCE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '3' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '4' THEN 'T/P ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '5' THEN 'ALTERNATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '6' THEN 'NAME AND DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '7' THEN 'NAME AND STATE/PROV ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '8' THEN 'NAME AND T/P ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '9' THEN 'NAME AND ALTERNATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'A' THEN 'DOCTOR T/P FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'B' THEN 'NAME AND DOCTOR T/P FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'C' THEN 'DEA NUMBER MINUS FIRST 2 CHARACTERS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'D' THEN 'T/P ID (DEA IF T/P ID IS BLANK)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'E' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'F' THEN 'NAME AND HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'G' THEN 'SPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'H' THEN 'NAME AND SPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'I' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'J' THEN 'NAME AND UPIN'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE
         END ;;
    suggestions: [
      "DEA NUMBER",
      "STATE/PROVINCE ID",
      "NAME",
      "T/P ID",
      "ALTERNATE ID",
      "NAME AND DEA NUMBER",
      "NAME AND STATE/PROV ID",
      "NAME AND T/P ID",
      "NAME AND ALTERNATE ID",
      "DOCTOR T/P FILE ID",
      "NAME AND DOCTOR T/P FILE ID",
      "DEA NUMBER MINUS FIRST 2 CHARACTERS",
      "T/P ID (DEA IF T/P ID IS BLANK)",
      "HIN",
      "NAME AND HIN",
      "SPIN",
      "NAME AND SPIN",
      "UPIN",
      "NAME AND UPIN",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_prescriber_transmit_alt_id_qualifier {
    label: "Claim Plan Prescriber Transmit Alt ID Qualifier"
    description: "Alternate prescriber ID qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ALT_ID_QUALIFIER ;;
  }

  dimension: store_plan_auto_denial_flag {
    label: "Claim Plan Auto Denial"
    description: "Yes/No Flag indicating if the denial date should be auto-populated when split billing a transaction to a plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_AUTO_DENIAL_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_dependent_number_halt_type {
    label: "Claim Plan Require Dependent Number Halt Type"
    description: "Flag indicating the action to occur if the edit requiring a dependent number fails. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'Y' THEN 'HARD HALT DO NOT ALLOW UPDATE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'W' THEN 'WARNING ALLOW UPDATE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT DO NOT ALLOW UPDATE", "WARNING ALLOW UPDATE", "NO ACTION"]
  }

  dimension: store_plan_require_dependent_number_flag {
    label: "Claim Plan Require Dependent Number Flag"
    description: "Flag determining if a dependent number is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'A' THEN 'ALWAYS REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'Y' THEN 'REQUIRED IF CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG
         END ;;
    suggestions: ["ALWAYS REQUIRED", "REQUIRED IF CODE", "NOT REQUIRED"]
  }

  dimension: store_plan_ignore_tax_flag {
    label: "Claim Plan Ignore Tax"
    description: "Yes/No Flag indicating if the tax is omitted from the price when the price equals the copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_IGNORE_TAX_FLAG = 'Y' ;;
  }

  dimension: store_plan_card_help {
    label: "Claim Plan Card Help"
    description: "Help information for card record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_HELP ;;
  }

  dimension: store_plan_plan_select_help {
    label: "Claim Plan Plan Select Help"
    description: "Help information specific to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_SELECT_HELP ;;
  }

  dimension: store_plan_require_prescriber_dea_number_flag {
    label: "Claim Plan Require Prescriber DEA Number Flag"
    description: "Flag indicating if the doctor's DEA number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_state_id_flag {
    label: "Claim Plan Require Prescriber State ID Flag"
    description: "Flag indicating if the doctor's state ID number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_tp_number_flag {
    label: "Claim Plan Require Prescriber TP Number Flag"
    description: "Flag indicating if the doctor's third party number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_ptp_number_flag {
    label: "Claim Plan Require Prescriber PTP Number Flag"
    description: "Flag indicating if the doctor's third party number from the doctor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prescriber_alternate_number_flag {
    label: "Claim Plan Require Prescriber Alternate Number Flag"
    description: "Flag indicating if the doctor's alternate third party number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_require_prior_auth_type_flag {
    label: "Claim Plan Require Prior Auth Type Flag"
    description: "Flag determining if a prior authorization type is  required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_batch_claim_format {
    label: "Claim Plan Batch Claim Format"
    description: "This is the batch or paper claim form to use. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_BATCH_CLAIM_FORMAT ;;
  }

  dimension: store_plan_display_extra_info_page_flag {
    label: "Claim Plan Display Extra Info Page Flag"
    description: "Forces the Third Party info page to be displayed during Data Entry. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'Y' THEN 'ALWAYS DISPLAY'
              WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'S' THEN 'DISPLAY WITH CLAIM'
              WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'N' THEN 'DISPLAY NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG
         END ;;
    suggestions: ["ALWAYS DISPLAY", "DISPLAY WITH CLAIM", "DISPLAY NOT REQUIRED"]
  }

  dimension: store_plan_prescriber_paper_id_type {
    label: "Claim Plan Prescriber Paper ID Type"
    description: "Prescriber ID to use for paper/batch billing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '1' THEN 'DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '2' THEN 'STATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '3' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '4' THEN 'TP ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '5' THEN 'ALT ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '6' THEN 'NAME AND DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '7' THEN 'NAME AND STATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '8' THEN 'NAME AND TP ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '9' THEN 'NAME AND ALT ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'A' THEN 'DOC TP FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'B' THEN 'NAME AND DOC TP FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'C' THEN 'DEA LESS FIRST 2 CHAR'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'D' THEN 'TP ID OR DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'E' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'F' THEN 'NAME AND HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'G' THEN 'HCID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'H' THEN 'NAME AND HCID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'I' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'J' THEN 'NAME AND UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'K' THEN '1ST 9 OF DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'L' THEN 'NPI'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE
         END ;;
    suggestions: [
      "DEA NUMBER",
      "STATE ID",
      "NAME",
      "TP ID",
      "ALT ID",
      "NAME AND DEA NUMBER",
      "NAME AND STATE ID",
      "NAME AND TP ID",
      "NAME AND ALT ID",
      "DOC TP FILE ID",
      "NAME AND DOC TP FILE ID",
      "DEA LESS FIRST 2 CHAR",
      "TP ID OR DEA NUMBER",
      "HIN",
      "NAME AND HIN",
      "HCID_ID",
      "NAME AND HCID_ID",
      "UPIN",
      "NAME AND UPIN",
      "1ST 9 OF DEA NUMBER",
      "NPI",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_drug_id_type {
    label: "Claim Plan Drug ID Type"
    description: "Determines which Drug Identifier will be transmitted to this Third Party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '1' THEN 'NDC'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '2' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '3' THEN 'NDC AND NAME'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '4' THEN 'T/P CODE'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '5' THEN 'T/P CODE OR NDC'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '6' THEN 'T/P CODE OR NDC (DASHES)'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '7' THEN 'T/P CODE OR NDC (SPACES)'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_DRUG_ID_TYPE)
         END ;;
    suggestions: [
      "NDC",
      "NAME",
      "NDC AND NAME",
      "T/P CODE",
      "T/P CODE OR NDC",
      "T/P CODE OR NDC (DASHES)",
      "T/P CODE OR NDC (SPACES)",
      "NOT SPECIFIED"
    ]
  }

  dimension: store_plan_pharmacist_name {
    label: "Claim Plan Pharmacist Name"
    description: "Represents how to submit the pharmacist signature to submit on batch & paper claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PHARMACIST_NAME ;;
  }

  dimension: store_plan_reversal_days {
    label: "Claim Plan Reversal Days"
    description: "Represents the number of days after submission of the claim in which to reverse the claim on-line. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_REVERSAL_DAYS ;;
  }

  dimension_group: store_plan_last_host_update_date {
    label: "Claim Plan Last Host Update"
    description: "Date that this record was last updated on host. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_HOST_UPDATE_DATE ;;
  }

  dimension_group: store_plan_last_nhin_update_date {
    label: "Claim Plan Last NHIN Update"
    description: "Date this record was last updated by NHIN. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_NHIN_UPDATE_DATE ;;
  }

  dimension_group: store_plan_last_used_date {
    label: "Claim Plan Last Used"
    description: "Date this Plan record was last used. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_USED_DATE ;;
  }

  dimension: store_plan_allow_reference_pricing_flag {
    label: "Claim Plan Allow Reference Pricing"
    description: "Yes/No Flag indicating whether to Allow Reference Prcing flag. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_REFERENCE_PRICING_FLAG = 'Y' ;;
  }

  dimension: store_plan_pad_icd9_code {
    label: "Claim Plan Pad Icd9 Code"
    description: "Yes/No Flag indicating if system pads the ICD-9 with zeros when submitting an NCPDP claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PAD_ICD9_CODE = 'Y' ;;
  }

  dimension: store_plan_check_eligibility_flag {
    label: "Claim Plan Check Eligibility"
    description: "Yes/No Flag indicating if eligibility request sent prior to normal claim billing request. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CHECK_ELIGIBILITY_FLAG = 'Y' ;;
  }

  dimension: store_plan_allow_partial_fill_flag {
    label: "Claim Plan Allow Partial Fill"
    description: "Yes/No Flag indicating if the Plan allows NCPDP Partial Fills. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_PARTIAL_FILL_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_rx_origin_flag {
    label: "Claim Plan Require Rx Origin Flag"
    description: "Flag that determines if plan requires this field for NCPDP claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG IS NULL THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'Y' THEN 'REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'W' THEN 'WARN ORIGIN NOT SENT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG
         END ;;
    suggestions: ["NOT REQUIRED", "REQUIRED", "WARN ORIGIN NOT SENT", "NOT REQUIRED"]
  }

  dimension_group: store_plan_do_not_submit_until {
    label: "Claim Plan Do Not Submit Until"
    description: "Date that contracts should be in place for this plan, for this store. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_DO_NOT_SUBMIT_UNTIL ;;
  }

  dimension: store_plan_disallow_autofill_flag {
    label: "Claim Plan Disallow Autofill"
    description: "Yes/No Flag indicating whether system is allowed to automatically refill prescriptions under this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_AUTOFILL_FLAG = 'Y' ;;
  }

  dimension: store_plan_mail_required_flag {
    label: "Claim Plan Mail Required"
    description: "Yes/No Flag indicating if the Mail order required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAIL_REQUIRED_FLAG = 'Y' ;;
  }

  dimension: store_plan_state {
    label: "Claim Plan State"
    description: "Claim Plan State. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE ;;
  }

  dimension: store_plan_alternate_state {
    label: "Claim Plan Alternate State"
    description: "Plan Alternate State. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_ALTERNATE_STATE ;;
  }

  dimension: store_plan_mail_days_supply {
    label: "Claim Plan Mail Days Supply"
    description: "Prescription refill quantity expressed in days supply to be delivered by mail order. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAIL_DAYS_SUPPLY ;;
  }

  dimension: store_plan_block_other_coverage_code_flag {
    label: "Claim Plan Block Other Coverage Code"
    description: "Yes/No Flag indicating whether to Block Other Coverage Code from auto populating. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BLOCK_OTHER_COVERAGE_CODE_FLAG = 'Y' ;;
  }

  dimension: store_plan_host_transmit_flag {
    label: "Claim Plan Host Transmit"
    description: "Yes/No Flag indicating if the plan is to be submitted to Host. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_HOST_TRANSMIT_FLAG = 'Y' ;;
  }

  dimension: store_plan_no_otc_daw_flag {
    label: "Claim Plan No OTC DAW"
    description: "Yes/No Flag indicating whether to Exclude OTC Products from DAW checking. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NO_OTC_DAW_FLAG = 'Y' ;;
  }

  dimension: store_plan_adjudicate_flag {
    label: "Claim Plan Adjudicate"
    description: "Yes/No Flag indicating whether the plan is for CANADA only. Determines if this plan will be transmitted. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ADJUDICATE_FLAG = 'Y' ;;
  }

  dimension: store_plan_disallow_workers_comp_flag {
    label: "Claim Plan Disallow Workers Comp"
    description: "Yes/No Flag indicating if plan disallows a Workers Comp record from being added to any TP_LINK that is linked to this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_WORKERS_COMP_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_split_intervention_flag {
    label: "Claim Plan Require Split Intervention"
    description: "Yes/No Flag indicating if the system needs to prompt the user for review/input before submitting to a secondary/tertiary plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_REQUIRE_SPLIT_INTERVENTION_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_patient_location_flag {
    label: "Claim Plan Require Patient Location Flag"
    description: "This is a plan edit that governs whether or not the plan requires Patient Location to be set on a Patient Tp Link. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'Y' THEN 'REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'W' THEN 'WARNING - ALLOW FILL'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG
         END ;;
    suggestions: ["REQUIRED", "NOT REQUIRED", "WARNING - ALLOW FILL"]
  }

  dimension: store_plan_use_submit_amount_split_bill_flag {
    label: "Claim Plan use Submit Amount Split Bill Flag"
    description: "Flag that determines the value sent in split claims for fields 409-D9 (Ingredient Cost Submitted) and 430-DV (Gross Amount Due). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG = 'Y' THEN 'SEND SUBMITTED COST'
              WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG = 'N' THEN 'CALCULATED'
              ELSE ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG
         END ;;
    suggestions: ["NOT SPECIFIED", "SEND SUBMITTED COST", "CALCULATED"]
  }

  dimension: store_plan_send_deductible_copay_flag {
    label: "Claim Plan Send Deductible Copay"
    description: "Yes/No Flag indicatingif the plan will provide the ability to send the Amount Attributed to Deductible and Amount of Copay in the HC and DV fields if these amounts are returned by the primary payer. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_DEDUCTIBLE_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_plan_previous_pharmacy_provider_id_qualifier {
    label: "Claim Plan Previous Pharmacy Provider ID Qualifier"
    description: "Flag that determines which pharmacy provider ID to send for reversals. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '81' THEN 'SASK MEDICAL PRACT'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '82' THEN 'SASK PHARMACIST'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '83' THEN 'SASK HEALTH MED SRV'
              ELSE ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "SASK MEDICAL PRACT",
      "SASK PHARMACIST",
      "SASK HEALTH MED SRV"
    ]
  }

  dimension_group: store_plan_previous_pharmacy_provider_id_date {
    label: "Claim Plan Previous Pharmacy Provider Identifier"
    description: "Date used to determine if the system will send the previous pharmacy provider id. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_DATE ;;
  }

  dimension: store_plan_require_form_serial_number_flag {
    label: "Claim Plan Require Form Serial Number Flag"
    description: "Flag that determines if the plan requires the prescription serial number to be entered for all prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'Y' THEN 'HARD HALT  NEW ONLY'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'W' THEN 'WARNING   ALL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'A' THEN 'HARD HALT ALL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'N' THEN 'USE DISPENSING RULES'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG
         END ;;
    suggestions: ["NOT SPECIFIED", "HARD HALT  NEW ONLY", "WARNING   ALL", "HARD HALT ALL", "USE DISPENSING RULES"]
  }

  dimension: store_plan_disallow_faxed_rx_requests_flag {
    label: "Claim Plan Disallow Faxed Rx Requests"
    description: "Yes/No Flag indicating id the plan does not allow faxed Rx requests. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_FAXED_RX_REQUESTS_FLAG = 'Y' ;;
  }

  dimension: store_plan_minimum_patient_age {
    label: "Claim Plan Minimum Patient Age"
    description: "Minimum age of the patient allowed by the plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE ;;
  }

  dimension: store_plan_minimum_patient_age_halt_type {
    label: "Claim Plan Minimum Patient Age Halt Type"
    description: "Flag indicating the action that should occur when a patient age is below the minium age required by the plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE IS NULL THEN 'NO EDIT DISPLAYED'
              WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE = 'W' THEN 'DISPLAYS EDIT MESSAGE'
              WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE = 'Y' THEN 'NO EDIT DISPLAYED'
              ELSE ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE
         END ;;
    suggestions: ["NO EDIT DISPLAYED", "DISPLAYS EDIT MESSAGE", "NO EDIT DISPLAYED"]
  }

  dimension: store_plan_disallow_subsequent_billing_flag {
    label: "Claim Plan Disallow Subsequent Billing"
    description: "Yes/No Flag indicating if the billing flag will prevent other plans from being billed once this plan is used in a billing sequence. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_SUBSEQUENT_BILLING_FLAG = 'Y' ;;
  }

  dimension: store_plan_check_other_coverage_codes_flag {
    label: "Claim Plan Check Other Coverage Codes"
    description: "Yes/No Flag indicating if other alternate other coverage codes exist and the application will check to see if it should send an alternated code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CHECK_OTHER_COVERAGE_CODES_FLAG = 'Y' ;;
  }

  dimension: store_plan_days_from_written_schedule_3_5 {
    label: "Claim Plan Days From Written Schedule 3-5"
    description: "This field is used to define the number of days the Rx written by a prescriber is valid for a prescription of schedule 3-5. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DAYS_FROM_WRITTEN_SCHEDULE_3_5 ;;
  }

  dimension: store_plan_days_from_written_non_schedule {
    label: "Claim Plan Days From Written Non Schedule"
    description: "This field is used to define the number of days the Rx written by a prescriber is valid for a prescription with a legend or OTC drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DAYS_FROM_WRITTEN_NON_SCHEDULE ;;
  }

  dimension: store_plan_require_pickup_relation_flag {
    label: "Claim Plan Require Pickup Relation Flag"
    description: "Plan flag that indicates if the plan requires what the relationship of the patient is to the person picking up the Rx. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: store_plan_default_prescriber_id_qualifier {
    label: "Claim Plan Default Prescriber ID Qualifier"
    description: "Qualifier associated with the Default Prescriber ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_DEFAULT_PRESCRIBER_ID_QUALIFIER ;;
  }

  dimension: store_plan_assignment_not_accepted_flag {
    label: "Claim Plan Assignment Not Accepted"
    description: "Yes/No Flag indicating whether the provider accepts assignment. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ASSIGNMENT_NOT_ACCEPTED_FLAG = 'Y' ;;
  }

  dimension: store_plan_allow_assignment_choice_flag {
    label: "Claim Plan Allow Assignment Choice"
    description: "Yes/No Flag indicating if the plan allows the patient to choose whether to assign benefits to the provider. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_ASSIGNMENT_CHOICE_FLAG = 'Y' ;;
  }

  dimension: store_plan_send_both_cob_amounts_flag {
    label: "Claim Plan Send Both COB Amounts"
    description: "Yes/No Flag indicating if the plan requires both the Other Payer Amount Paid and Other Payer Patient Responsibility loops in the COB/Other Payments segment of a split-billed claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_BOTH_COB_AMOUNTS_FLAG = 'Y' ;;
  }

  dimension: store_plan_place_of_service {
    label: "Claim Plan Place Of Service"
    description: "Stores the place where a drug or service is dispensed or administered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLACE_OF_SERVICE ;;
  }

  dimension: store_plan_residence {
    label: "Claim Plan Residence"
    description: "Stores the code identifying the patient’s place of residence (KP EPS only). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '1' THEN 'HOME'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '3' THEN 'NURSING FACILITY'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '4' THEN 'ASSISTED LIVING FACILITY'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '6' THEN 'GROUP HOME'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '9' THEN 'INTERMEDIATE CARE FACILITY/MENTALLY RETARDED'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '11' THEN 'HOSPICE'
              ELSE ${TABLE}.STORE_PLAN_RESIDENCE
         END ;;
    suggestions: ["NOT SPECIFIED", "HOME", "NURSING FACILITY", "ASSISTED LIVING FACILITY", "GROUP HOME", "INTERMEDIATE CARE FACILITY/MENTALLY RETARDED", "HOSPICE"]
  }

  dimension: store_plan_send_only_patient_pay_amount_flag {
    label: "Claim Plan Send Only Patient Pay Amount"
    description: "Yes/No Flag indicating if the plan requires only the Patient Pay Amount (505-F5) as reported by previous payer to be sent in  the Other Payer Patient Responsibility loop in the COB segement. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_ONLY_PATIENT_PAY_AMOUNT_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_prescriber_npi_number {
    label: "Claim Plan Require Prescriber NPI Number"
    description: "Yes/No Flag indicating if the third party plan requires the doctor’s NPI number. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_NPI_NUMBER = 'Y' ;;
  }

  dimension: store_plan_pharmacy_service_type {
    label: "Claim Plan Pharmacy Service Type"
    description: "Stores the NCPDP pharmacy service type code (147-U7 Pharmacy Service Type field) that indicates the type of service being performed by the pharmacy. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PHARMACY_SERVICE_TYPE ;;
  }

  dimension: store_plan_disallow_direct_marketing_flag {
    label: "Claim Plan Disallow Direct Marketing"
    description: "Yes/No Flag indicating if this insurance plan allows or disallows direct marketing to a patient covered by this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_DIRECT_MARKETING_FLAG = 'Y' ;;
  }

  dimension: store_plan_require_patient_residence_flag {
    label: "Claim Plan Require Patient Residence"
    description: "Yes/No Flag indicating if the plan requires a residence type for the patient. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'Y' THEN 'REQUIRE PATIENT RESIDENCE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'W' THEN 'REQUIRE PATIENT RESIDENCE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'N' THEN 'PATIENT RESIDENCE NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG
         END ;;
    suggestions: ["REQUIRE PATIENT RESIDENCE HARD HALT", "REQUIRE PATIENT RESIDENCE WARNING", "PATIENT RESIDENCE NOT REQUIRED"]
  }

  dimension: store_plan_pickup_signature_not_required_flag {
    label: "Claim Plan Pickup Signature Not Required"
    description: "Yes/No Flag that marks the transaction as 'Y' Yes, it needs, or 'N', No it does not need a pickup signature due to the plan setting at the time it was sold. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PICKUP_SIGNATURE_NOT_REQUIRED_FLAG = 'Y' ;;
  }

  dimension: store_plan_no_incentives {
    label: "Claim Plan No Incentives"
    description: "Indicates if there are incentives. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_NO_INCENTIVES ;;
  }

  dimension: store_plan_use_price_code_and_plan_fees_flag {
    label: "Claim Plan use Price Code and Plan Fees"
    description: "Yes/No Flag indicating if the fees and markups from both the Price Code and the Plan should be used when calculating the price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_USE_PRICE_CODE_AND_PLAN_FEES_FLAG = 'Y' ;;
  }

  dimension: store_plan_use_drug_price_code_flag {
    label: "Claim Plan use Drug Price Code"
    description: "Yes/No Flag indicating if pricing should use the Price Code on the drug record when pricing a prescription using this plan. If there is no Price Code on the drug record, then the current pricing logic in Third Party Pricing is applied to find the Price Code to be used. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_USE_DRUG_PRICE_CODE_FLAG = 'Y' ;;
  }

  dimension: store_plan_discount_plan {
    label: "Claim Plan Discount Plan"
    description: "Discount Plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_DISCOUNT_PLAN ;;
  }

  dimension: store_plan_group_validation {
    label: "Claim Plan Group Validation"
    description: "Group Validation. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_GROUP_VALIDATION ;;
  }

  dimension: store_plan_coupon_plan {
    label: "Claim Plan Coupon Plan"
    description: "Coupon Plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_COUPON_PLAN ;;
  }

  #[ERXLPS-1618]
  dimension: store_plan_phone_number {
    label: "Claim Plan Phone Number"
    description: "Claim Plan Phone Number. Three digit area code, and seven digit phone number respectively. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${eps_plan_phone.phone_number} ;;
  }

  #[ERXLPS-820] New dimensions created to display prescription transaction primary payer details across all claims.
  dimension: store_plan_carrier_code_primary {
    label: "Primary Payer Plan Carrier Code"
    description: "Primary Payer Carrier Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARRIER_CODE ;;
  }

  dimension: store_plan_plan_primary {
    label: "Primary Payer Plan Code"
    description: "Primary Payer Plan Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN ;;
  }

  #[ERXLPS-6270] - Commented Plan Group Code from eps_plan view. EPS Data Dictionary says this column is depricated and do not have any data in EDW column.
  #dimension: store_plan_group_code_primary {
  #  label: "Primary Payer Plan Group Code"
  #  description: "Primary Payer Plan Group Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
  #  type: string
  #  sql: ${TABLE}.STORE_PLAN_GROUP_CODE ;;
  #}

  dimension: store_plan_plan_name_primary {
    label: "Primary Payer Plan Name"
    description: "Primary Payer Plan Name. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_NAME ;;
  }

  dimension: bi_demo_store_plan_plan_name_primary {
    label: "Primary Payer Plan Name"
    description: "Primary Payer Plan Name. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: concat(concat('BI DEMO - ',ABS(hash(${store_plan_plan_name_primary}))),' - PLAN') ;;
  }

  #[ERXLPS-1618]
  dimension: store_plan_state_primary {
    label: "Primary Payer Plan State"
    description: "Primary Payer Plan State. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE ;;
  }

  dimension: store_plan_phone_number_primary {
    label: "Primary Payer Plan Phone Number"
    description: "Primary Payer Plan Phone Number. Three digit area code, and seven digit phone number respectively. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${primary_payer_plan_phone.phone_number} ;;
  }

  #[ERXLPS-1618] New dimensions created to display prescription transaction secondary payer details across all claims.
  dimension: store_plan_carrier_code_secondary {
    label: "Secondary Payer Plan Carrier Code"
    description: "Secondary Payer Carrier Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARRIER_CODE ;;
  }

  dimension: store_plan_plan_secondary {
    label: "Secondary Payer Plan Code"
    description: "Secondary Payer Plan Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN ;;
  }

  #[ERXLPS-6270] - Commented Plan Group Code from eps_plan view. EPS Data Dictionary says this column is depricated and do not have any data in EDW column.
  #dimension: store_plan_group_code_secondary {
  #  label: "Secondary Payer Plan Group Code"
  #  description: "Secondary Payer Plan Group Code. EPS Table Name: PLAN, PDX Table Name: PLAN"
  #  type: string
  #  sql: ${TABLE}.STORE_PLAN_GROUP_CODE ;;
  #}

  dimension: store_plan_plan_name_secondary {
    label: "Secondary Payer Plan Name"
    description: "Secondary Payer Plan Name. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_NAME ;;
  }

  dimension: bi_demo_store_plan_plan_name_secondary {
    label: "Secondary Payer Plan Name"
    description: "Secondary Payer Plan Name. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: concat(concat('BI DEMO - ',ABS(hash(${store_plan_plan_name_secondary}))),' - PLAN') ;;
  }


  dimension: store_plan_state_secondary {
    label: "Secondary Payer Plan State"
    description: "Secondary Payer Plan State. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE ;;
  }

  dimension: store_plan_phone_number_secondary {
    label: "Secondary Payer Plan Phone Number"
    description: "Secondary Payer Plan Phone Number. Three digit area code, and seven digit phone number respectively. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${secondary_payer_plan_phone.phone_number} ;;
  }

  #################################################################### End Dimensions ################################################################

  #################################################################### measures and templated filters ####################################################################

  dimension: store_plan_maximum_quantity {
    label: "Claim Plan Maximum Quantity"
    description: "Maximum quantity that can be dispensed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_QUANTITY ;;
  }

  measure: sum_store_plan_maximum_quantity {
    label: "Claim Plan Maximum Quantity"
    description: "Maximum quantity that can be dispensed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_QUANTITY ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_maximum_quantity_filter {
    label: "Plan Maximum Quantity"
    description: "Maximum quantity that can be dispensed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_maximum_quantity_filter %} ${store_plan_maximum_quantity} {% endcondition %}
      ;;
  }

  dimension: store_plan_max_quantity_maintenance {
    label: "Claim Plan Max Quantity Maintenance"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAX_QUANTITY_MAINTENANCE ;;
  }

  measure: sum_store_plan_max_quantity_maintenance {
    label: "Claim Plan Max Quantity Maintenance"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_QUANTITY_MAINTENANCE ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_max_quantity_maintenance_filter {
    label: "Plan Max Quantity Maintenance"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_max_quantity_maintenance_filter %} ${store_plan_max_quantity_maintenance} {% endcondition %}
      ;;
  }

  dimension: store_plan_maximum_ml_quantity {
    label: "Claim Plan Maximum ML Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_QUANTITY ;;
  }

  measure: sum_store_plan_maximum_ml_quantity {
    label: "Claim Plan Maximum ML Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_QUANTITY ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_maximum_ml_quantity_filter {
    label: "Plan Maximum ML Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_maximum_ml_quantity_filter %} ${store_plan_maximum_ml_quantity} {% endcondition %}
      ;;
  }

  dimension: store_plan_maximum_ml_maintenance_quantity {
    label: "Claim Plan Maximum ML Maintenance Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_MAINTENANCE_QUANTITY ;;
  }

  measure: sum_store_plan_maximum_ml_maintenance_quantity {
    label: "Claim Plan Maximum ML Maintenance Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_MAINTENANCE_QUANTITY ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_maximum_ml_maintenance_quantity_filter {
    label: "Plan Maximum ML Maintenance Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_maximum_ml_maintenance_quantity_filter %} ${store_plan_maximum_ml_maintenance_quantity} {% endcondition %}
      ;;
  }

  dimension: store_plan_maximum_gram_quantity {
    label: "Claim Plan Maximum Gram Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_QUANTITY ;;
  }

  measure: sum_store_plan_maximum_gram_quantity {
    label: "Claim Plan Maximum Gram Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_QUANTITY ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_maximum_gram_quantity_filter {
    label: "Plan Maximum Gram Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_maximum_gram_quantity_filter %} ${store_plan_maximum_gram_quantity} {% endcondition %}
      ;;
  }

  dimension: store_plan_maximum_gram_maintenance_quantity {
    label: "Claim Plan Maximum Gram Maintenance Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_MAINTENANCE_QUANTITY ;;
  }

  measure: sum_store_plan_maximum_gram_maintenance_quantity {
    label: "Claim Plan Maximum Gram Maintenance Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_MAINTENANCE_QUANTITY ;;
    value_format: "#,##0.00"
  }

  filter: store_plan_maximum_gram_maintenance_quantity_filter {
    label: "Plan Maximum Gram Maintenance Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_maximum_gram_maintenance_quantity_filter %} ${store_plan_maximum_gram_maintenance_quantity} {% endcondition %}
      ;;
  }

  dimension: store_plan_max_dollar_dependecy {
    label: "Claim Plan Max Dollar Dependecy"
    description: "Maximum dollar amount allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_DEPENDECY ;;
  }

  measure: sum_store_plan_max_dollar_dependecy {
    label: "Claim Plan Max Dollar Dependecy"
    description: "Maximum dollar amount allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_DEPENDECY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_max_dollar_dependecy_filter {
    label: "Plan Max Dollar Dependecy"
    description: "Maximum dollar amount allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_max_dollar_dependecy_filter %} ${store_plan_max_dollar_dependecy} {% endcondition %}
      ;;
  }

  dimension: store_plan_max_dollar_rx {
    label: "Claim Plan Max Dollar Rx"
    description: "Maximum dollar amount allowed on a single fill of a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_RX ;;
  }

  measure: sum_store_plan_max_dollar_rx {
    label: "Claim Plan Max Dollar Rx"
    description: "Maximum dollar amount allowed on a single fill of a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_RX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_max_dollar_rx_filter {
    label: "Plan Max Dollar Rx"
    description: "Maximum dollar amount allowed on a single fill of a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_max_dollar_rx_filter %} ${store_plan_max_dollar_rx} {% endcondition %}
      ;;
  }

  dimension: store_plan_max_dollar_card {
    label: "Plan Max Dollar Card"
    description: "Maximum dollar amount allowed by a card record for a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_CARD ;;
  }

  measure: sum_store_plan_max_dollar_card {
    label: "Plan Max Dollar Card"
    description: "Maximum dollar amount allowed by a card record for a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_CARD ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_max_dollar_card_filter {
    label: "Plan Max Dollar Card"
    description: "Maximum dollar amount allowed by a card record for a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_max_dollar_card_filter %} ${store_plan_max_dollar_card} {% endcondition %}
      ;;
  }

  dimension: store_plan_compound_rate {
    label: "Claim Plan Compound Rate"
    description: "Per minute rate fee added to a compound prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_COMPOUND_RATE ;;
  }

  measure: sum_store_plan_compound_rate {
    label: "Claim Plan Compound Rate"
    description: "Per minute rate fee added to a compound prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_COMPOUND_RATE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_compound_rate_filter {
    label: "Plan Compound Rate"
    description: "Per minute rate fee added to a compound prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_compound_rate_filter %} ${store_plan_compound_rate} {% endcondition %}
      ;;
  }

  dimension: store_plan_difference_amount {
    label: "Claim Plan Difference Amount"
    description: "Difference amount percentage added to copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_DIFFERENCE_AMOUNT ;;
  }

  measure: sum_store_plan_difference_amount {
    label: "Claim Plan Difference Amount"
    description: "Difference amount percentage added to copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_DIFFERENCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_difference_amount_filter {
    label: "Plan Difference Amount"
    description: "Difference amount percentage added to copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_difference_amount_filter %} ${store_plan_difference_amount} {% endcondition %}
      ;;
  }

  dimension: store_plan_copay_dollar_limit {
    label: "Claim Plan Copay Dollar Limit"
    description: "Total copay amount allowed to be charged to a cardholder. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_COPAY_DOLLAR_LIMIT ;;
  }

  measure: sum_store_plan_copay_dollar_limit {
    label: "Claim Plan Copay Dollar Limit"
    description: "Total copay amount allowed to be charged to a cardholder. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_COPAY_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_copay_dollar_limit_filter {
    label: "Plan Copay Dollar Limit"
    description: "Total copay amount allowed to be charged to a cardholder. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_copay_dollar_limit_filter %} ${store_plan_copay_dollar_limit} {% endcondition %}
      ;;
  }

  dimension: store_plan_max_reimburse {
    label: "Claim Plan Max Reimburse"
    description: "Maximum amount reimbursed by carrier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_MAX_REIMBURSE ;;
  }

  measure: sum_store_plan_max_reimburse {
    label: "Claim Plan Max Reimburse"
    description: "Maximum amount reimbursed by carrier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_REIMBURSE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_max_reimburse_filter {
    label: "Plan Max Reimburse"
    description: "Maximum amount reimbursed by carrier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_max_reimburse_filter %} ${store_plan_max_reimburse} {% endcondition %}
      ;;
  }

  dimension: store_plan_recon_dollar {
    label: "Claim Plan Recon Dollar"
    description: "If low payment, max allowable $ difference before creating TP EXCEPTION. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_RECON_DOLLAR ;;
  }

  measure: sum_store_plan_recon_dollar {
    label: "Claim Plan Recon Dollar"
    description: "If low payment, max allowable $ difference before creating TP EXCEPTION. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_RECON_DOLLAR ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  filter: store_plan_recon_dollar_filter {
    label: "Plan Recon Dollar"
    description: "If low payment, max allowable $ difference before creating TP EXCEPTION. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_recon_dollar_filter %} ${store_plan_recon_dollar} {% endcondition %}
      ;;
  }

  dimension: store_plan_recon_percent {
    label: "Claim Plan Recon Percent"
    description: "Maximum allowable percentage before  claim is considered a low pay claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_RECON_PERCENT ;;
  }

  dimension: sum_store_plan_recon_percent {
    label: "Claim Plan Recon Percent"
    description: "Maximum allowable percentage before  claim is considered a low pay claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_RECON_PERCENT ;;
    value_format: "00.00\"%\""
  }

  filter: store_plan_recon_percent_filter {
    label: "Plan Recon Percent"
    description: "Maximum allowable percentage before  claim is considered a low pay claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: {% condition store_plan_recon_percent_filter %} ${store_plan_recon_percent} {% endcondition %}
      ;;
  }

  #[ERXLPS-2383] - Duplicate set of dimensions created to expose Patient Plan information. Label name starts with Patient Plan ****
  #[ERXLPS-1438]
  dimension: patient_plan_carrier_code {
    label: "Patient Plan Carrier Code"
    description: "Patient Plan Carrier Code. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARRIER_CODE ;;
  }

  dimension: patient_plan_plan_name {
    label: "Patient Plan Name"
    description: "Patient Plan Name. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_NAME ;;
  }

  dimension: bi_demo_patient_plan_plan_name {
    label: "Patient Plan Name"
    description: "Patient Plan Name. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: concat(concat('BI DEMO - ',ABS(hash(${patient_plan_plan_name}))),' - PLAN') ;;
  }

  #[ERXLPS-2383] - Second set of dimensions created for PLAN view. One with lable name of Claim Plan *** to show plan information associated with Claim. Another set created with label name of Patient Plan **** to show the Plan information associated with Patient.
  dimension: patient_plan_plan {
    label: "Patient Plan Code"
    description: "Claim Plan Code. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN ;;
  }

  #[ERXLPS-6270] - Commented Plan Group Code from eps_plan view. EPS Data Dictionary says this column is depricated and do not have any data in EDW column.
  #dimension: patient_plan_group_code {
  #  label: "Patient Plan Group Code"
  #  description: "Claim Plan Group Code. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
  #  type: string
  #  sql: ${TABLE}.STORE_PLAN_GROUP_CODE ;;
  #

  dimension: patient_plan_eligible_flag {
    label: "Patient Plan Eligible Flag"
    description: "Indicates wheather a plan is eligible for third party activity. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ELIGIBLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ELIGIBLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG IS NULL THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'N' THEN 'HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'Y' THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'C' THEN 'CONVERTED'
              WHEN ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG = 'W' THEN 'WARNING'
              ELSE ${TABLE}.STORE_PLAN_ELIGIBLE_FLAG
         END ;;
    suggestions: ["HARD HALT", "WARNING", "CONVERTED", "ELIGIBLE"]
  }

  dimension: patient_plan_tp_error_override_flag {
    label: "Patient Plan TP Error Override Flag"
    description: "Indicates if third party errors can be overridden. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TP_ERROR_OVERRIDE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'N' THEN 'DO NOT ALLOW'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'Y' THEN 'ALLOW OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'P' THEN 'ALLOW WITH PRIOR AUTH NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG = 'Q' THEN 'ALLOW WITH PRIOR AUTH CODE'
              ELSE ${TABLE}.STORE_PLAN_TP_ERROR_OVERRIDE_FLAG
         END ;;
    suggestions: ["ALLOW OVERRIDE", "DO NOT ALLOW", "ALLOW WITH PRIOR AUTH NUMBER / CODE", "ALLOW WITH PRIOR AUTH CODE"]
  }

  dimension: patient_plan_price_override_flag {
    label: "Patient Plan Price Override Flag"
    description: "Indicates if the pharmacist can override price and/or copay while filling a prescription for this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRICE_OVERRIDE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG IS NULL THEN 'OVERRIDE ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'C' THEN 'OVERRIDE PRICE ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'P' THEN 'OVERRIDE COPAY ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG = 'B' THEN 'OVERRIDE NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_PRICE_OVERRIDE_FLAG
         END ;;
    suggestions: ["OVERRIDE ALLOWED", "OVERRIDE COPAY ALLOWED", "OVERRIDE PRICE ALLOWED", "OVERRIDE NOT ALLOWED"]
  }

  dimension: patient_plan_format_card {
    label: "Patient Plan Format Card"
    description: "Format Card. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_FORMAT_CARD ;;
  }

  dimension: patient_plan_check_card_flag {
    label: "Patient Plan Check Card Flag"
    description: "Flag determining if card number length should be verified when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_CHECK_CARD_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_CHECK_CARD_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'W' THEN 'VERIFY CARD NUMBER WARNING'
              WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'N' THEN 'DO NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG = 'Y' THEN 'VERIFY CARD NUMBER HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_CHECK_CARD_FLAG
         END ;;
    suggestions: ["VERIFY CARD NUMBER HARD HALT", "VERIFY CARD NUMBER WARNING", "DO NOT CHECK"]
  }

  dimension: patient_plan_format_group {
    label: "Patient Plan Format Group"
    description: "Group number format. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_FORMAT_GROUP ;;
  }

  dimension: patient_plan_check_group_flag {
    label: "Patient Plan Check Group Flag"
    description: "Flag determining if group number length should be verified when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_CHECK_GROUP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'Y' THEN 'VERIFY GROUP NUMBER HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'N' THEN 'DO NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG = 'W' THEN 'VERIFY GROUP NUMBER WARNING'
              ELSE ${TABLE}.STORE_PLAN_CHECK_GROUP_FLAG
         END ;;
    suggestions: ["VERIFY GROUP NUMBER HARD HALT", "VERIFY GROUP NUMBER WARNING", "DO NOT CHECK"]
  }

  dimension: patient_plan_require_group_flag {
    label: "Patient Plan Require Group Flag"
    description: "Flag indicating if a group number is required when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_GROUP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'W' THEN 'GROUP NUMBER REQUIRED WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'Y' THEN 'GROUP NUMBER REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_GROUP_FLAG
         END ;;
    suggestions: ["GROUP NUMBER REQUIRED HARD HALT", "GROUP NUMBER REQUIRED WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_gender_flag {
    label: "Patient Plan Gender Flag"
    description: "Flag indicating if a plan record requires the patient's gender when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_GENDER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_GENDER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'W' THEN 'GROUP NUMBER REQUIRED WARNING'
              WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'Y' THEN 'GROUP NUMBER REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_GENDER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_GENDER_FLAG
         END ;;
    suggestions: ["REQUIRE PATIENT GENDER HARD HALT", "REQUIRE PATIENT GENDER WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_birth_flag {
    label: "Patient Plan Require Birth Flag"
    description: "Flag indicating if a plan record requires the patient's birth date when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_BIRTH_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'W' THEN 'REQUIRE DOB WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG = 'Y' THEN 'REQUIRE DOB HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_BIRTH_FLAG
         END ;;
    suggestions: ["REQUIRE DOB HARD HALT", "REQUIRE DOB WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_address_flag {
    label: "Patient Plan Require Address Flag"
    description: "Flag indicating if a plan record requires the patient's address when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_ADDRESS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'W' THEN 'REQUIRE ADDRESS WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG = 'Y' THEN 'REQUIRE ADDRESS HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_ADDRESS_FLAG
         END ;;
    suggestions: ["REQUIRE ADDRESS HARD HALT", "REQUIRE ADDRESS WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_injury_flag {
    label: "Patient Plan Injury Flag"
    description: "Flag indicating if a plan record requires an injury date on worker's compensation records when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_INJURY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_INJURY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'W' THEN 'REQUIRE INJURY DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_INJURY_FLAG = 'Y' THEN 'REQUIRE INJURY DATE HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_INJURY_FLAG
         END ;;
    suggestions: ["REQUIRE INJURY DATE HARD HALT", "REQUIRE INJURY DATE WARNING", "NOT REQUIRED"]
  }

  #[ERXLPS-2253] - Modified logic with CASE WHEN statements to bypass SF known issue with co-related subquery error in where clause.
  dimension: patient_plan_plan_type {
    #ERXLPS-185 - Fixed label name from Plan Plan Type to Plan Type
    label: "Patient Plan Type"
    description: "Claim Type of plan. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '1' THEN 'PRIVATE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '2' THEN 'STATE MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '3' THEN 'FEDERAL MEDICARE PART B'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '4' THEN 'FEDERAL MEDICARE PART D'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '5' THEN 'WORKERS COMPENSATION'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '6' THEN 'OTHER FEDERAL'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '7' THEN 'OTHER NON-MEDICAID STATE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '8' THEN 'CASH PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '9' THEN 'OTHER BENEFIT TYPE PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '10' THEN 'HMO'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '11' THEN 'MEDICAL FINANCIAL ASSISTANCE'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '12' THEN 'HIGH-DEDUCTIBLE HEALTH PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '13' THEN 'AIDS DRUG ASSISTANCE PROGRAM PLAN'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '14' THEN 'STATE FORMULARY'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '15' THEN 'COLLEGE STUDENT'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '16' THEN 'CLINICALLY ADMINISTERED DRUGS'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '17' THEN 'DURABLE MEDICAL EQUIPMENT'
              WHEN ${TABLE}.STORE_PLAN_PLAN_TYPE = '18' THEN 'HEALTH INSURANCE EXCHANGE'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "PRIVATE",
      "STATE MEDICAID",
      "FEDERAL MEDICARE PART B",
      "FEDERAL MEDICARE PART D",
      "WORKERS COMPENSATION",
      "OTHER FEDERAL",
      "OTHER NON-MEDICAID STATE",
      "CASH PLAN",
      "OTHER BENEFIT TYPE PLAN",
      "HMO",
      "MEDICAL FINANCIAL ASSISTANCE",
      "HIGH-DEDUCTIBLE HEALTH PLAN",
      "AIDS DRUG ASSISTANCE PROGRAM PLAN",
      "STATE FORMULARY",
      "COLLEGE STUDENT",
      "CLINICALLY ADMINISTERED DRUGS",
      "DURABLE MEDICAL EQUIPMENT",
      "HEALTH INSURANCE EXCHANGE"
    ]
  }

  dimension: patient_plan_require_patient_relationship_flag {
    label: "Patient Plan Require Patient Relationship Flag"
    description: "Flag indicating if a plan record requires a relationship code to be entered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'W' THEN 'WARNING RELATION TO PATIENT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG = 'Y' THEN 'REQUIRES RELATION TO PATIENT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RELATIONSHIP_FLAG
         END ;;
    suggestions: ["REQUIRES RELATION TO PATIENT", "NOT REQUIRED", "WARNING RELATION TO PATIENT"]
  }

  dimension: patient_plan_no_dependent_flag {
    label: "Patient Plan No Dependent Flag"
    description: "Flag indicating if a plan record does not allow dependent coverage. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NO_DEPENDENT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'Y' THEN 'NOT ALLOWED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'W' THEN 'NOT ALLOWED WARNING'
              WHEN ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG = 'N' THEN 'ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_NO_DEPENDENT_FLAG
         END ;;
    suggestions: ["NOT ALLOWED HARD HALT", "NOT ALLOWED WARNING", "ALLOWED"]
  }

  dimension: patient_plan_age_halt_flag {
    label: "Patient Plan Age Halt Flag"
    description: "Flag indicating the action that should occur when a patient age does not fall within any age boundaries as set by a drug, plan, third party or therapeutic restriction record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_AGE_HALT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_AGE_HALT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'Q' THEN 'HARD HALT REQUIRE PA FLAG'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / FLAG'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'Y' THEN 'HARD HALT FILLING'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'W' THEN 'WARNING'
              WHEN ${TABLE}.STORE_PLAN_AGE_HALT_FLAG = 'N' THEN 'NO ACTION TAKEN' --[ERXLPS-2383] - Added only at looker layer. Need to add in master code table.
              ELSE ${TABLE}.STORE_PLAN_AGE_HALT_FLAG
         END ;;
    suggestions: ["HARD HALT REQUIRE PA NUMBER / FLAG", "HARD HALT REQUIRE PA FLAG", "WARNING", "HARD HALT FILLING", "NO ACTION TAKEN"]
  }

  dimension: patient_plan_depend_age {
    label: "Patient Plan Depend Age"
    description: "Maximum age for dependent children. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DEPEND_AGE ;;
  }

  dimension: patient_plan_student_age {
    label: "Patient Plan Student Age"
    description: "Maximum age for dependents that are considered students. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_STUDENT_AGE ;;
  }

  dimension: patient_plan_adc_age {
    label: "Patient Plan ADC Age"
    description: "Maximum age at which ADC pricing and copay should be applied. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_ADC_AGE ;;
  }

  dimension: patient_plan_require_coverage_code {
    label: "Patient Plan Require Coverage Code"
    description: "Flag indicating if a plan record requires a coverage code when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_COVERAGE_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'Y' THEN 'REQUIRE COVERAGE CODE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'W' THEN 'REQUIRE COVERAGE CODE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_COVERAGE_CODE
         END ;;
    suggestions: ["REQUIRE COVERAGE CODE HARD HALT", "REQUIRE COVERAGE CODE WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_card_begin_date_flag {
    label: "Patient Plan Require Card Begin Date Flag"
    description: "Flag indicating if a plan record requires an effective card date to be entered when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'W' THEN 'REQUIRE EFFECTIVE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG = 'Y' THEN 'REQUIRE EFFECTIVE DATE HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_CARD_BEGIN_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE EFFECTIVE DATE HARD HALT", "REQUIRE EFFECTIVE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_card_end_date_flag {
    label: "Patient Plan Require Card End Date Flag"
    description: "Flag indicating if a plan record requires an expiration card date to be entered when adding or updating third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'W' THEN 'REQUIRE EXPIRATION DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'Y' THEN 'REQUIRE EXPIRATION DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_CARD_END_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE EXPIRATION DATE HARD HALT", "REQUIRE EXPIRATION DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: patient_plan_desi3_flag {
    label: "Patient Plan Desi3 Flag"
    description: "PLAN_DESI3 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 3 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI3_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI3_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI3_FLAG = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_DESI3_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: patient_plan_desi4_flag {
    label: "Patient Plan Desi4 Flag"
    description: "PLAN_DESI4 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 4 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI4_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI4_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI4_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              ELSE ${TABLE}.STORE_PLAN_DESI4_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: patient_plan_desi5_flag {
    label: "Patient Plan Desi5 Flag"
    description: "PLAN_DESI5 is a flag that determines if the system hard halts or only shows a warning when trying to fill a prescription with a Class 5 DESI drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DESI5_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DESI5_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DESI5_FLAG = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_DESI5_FLAG
         END ;;
    suggestions: ["HARD HALT ALLOW TP OVERRIDE", "WARNING ALLOW TP OVERRIDE", "HARD HALT NOT ALLOWED TO BE FILLED", "WARNING ALLOW FILLING", "NO ACTION"]
  }

  dimension: patient_plan_restrict_otc_flag {
    label: "Patient Plan Restrict OTC Flag"
    description: "Flag that determines if the system hard halts or only shows a warning on the Check Rx Messages screen when you try to fill a prescription with an over-the-counter drug (Schedule 8) when billing to a third party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_RESTRICT_OTC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'Q' THEN 'HARD HALT ALLOW PA OR TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'P' THEN 'HARD HALT ALLOW PA OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'T' THEN 'HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG = 'U' THEN 'HARD HALT ALLOW PA OVERRIDE NOT TP'
              ELSE ${TABLE}.STORE_PLAN_RESTRICT_OTC_FLAG
         END ;;
    suggestions: [
      "HARD HALT ALLOW TP OVERRIDE",
      "WARNING ALLOW TP OVERRIDE",
      "HARD HALT NOT ALLOWED TO BE FILLED",
      "WARNING ALLOW FILLING",
      "NO ACTION",
      "HARD HALT ALLOW PA OVERRIDE",
      "HARD HALT ALLOW PA OR TP OVERRIDE",
      "HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP",
      "HARD HALT ALLOW PA OVERRIDE NOT TP"
    ]
  }

  dimension: patient_plan_injectable_flag {
    label: "Patient Plan Injectable Flag"
    description: "PLAN_INJECTABLE is a flag that determines if the third party pays for an injectable drug (as set up on the Drug File screen). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_INJECTABLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_INJECTABLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'W' THEN 'WARNING ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'Y' THEN 'HARD HALT ALLOW TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'S' THEN 'WARNING ALLOW FILLING'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'R' THEN 'HARD HALT NOT ALLOWED TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'T' THEN 'HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'U' THEN 'HARD HALT ALLOW PA OVERRIDE NOT TP'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'Q' THEN 'HARD HALT ALLOW PA OR TP OVERRIDE'
              WHEN ${TABLE}.STORE_PLAN_INJECTABLE_FLAG = 'P' THEN 'HARD HALT ALLOW PA OVERRIDE'
              ELSE ${TABLE}.STORE_PLAN_INJECTABLE_FLAG
         END ;;
    suggestions: [
      "HARD HALT ALLOW TP OVERRIDE",
      "WARNING ALLOW TP OVERRIDE",
      "HARD HALT NOT ALLOWED TO BE FILLED",
      "WARNING ALLOW FILLING",
      "NO ACTION",
      "HARD HALT ALLOW PA OVERRIDE",
      "HARD HALT ALLOW PA OR TP OVERRIDE",
      "HARD HALT ALLOW PA NUMBER OVERRIDE NOT TP",
      "HARD HALT ALLOW PA OVERRIDE NOT TP"
    ]
  }

  dimension: patient_plan_drug_tp_date_flag {
    label: "Patient Plan Drug TP Date Flag"
    description: "PLAN_TP_DATE_RANGE is a flag determining the action that should occur when a drug third party coverage date is out of range. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_TP_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG = 'Y' THEN 'HARD HALT NOT ALLOW TO BE FILLED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG = 'W' THEN 'WARNING ALLOW TO BE FILLED'
              ELSE ${TABLE}.STORE_PLAN_DRUG_TP_DATE_FLAG
         END ;;
    suggestions: ["HARD HALT NOT ALLOW TO BE FILLED", "WARNING ALLOW TO BE FILLED"]
  }

  dimension: patient_plan_therapeutic_maintenance_flag {
    label: "Patient Plan Therapeutic Maintenance Flag"
    description: "PLAN_THERAPEUTIC_MAINTENANCE is a flag determining which therapeutic maintenance flag should be used for a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG IS NULL THEN 'USE THERAPEUTIC RESTRICTION'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'S' THEN 'USE THERAPEUTIC RESTRICTION MATCH TP'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'Y' THEN 'USE THERAPEUTIC HIERARCHY NON-BLANK MAINT FLAG'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG = 'N' THEN 'USE DRUG THIRD PARTY RECORD'
              ELSE ${TABLE}.STORE_PLAN_THERAPEUTIC_MAINTENANCE_FLAG
         END ;;
    suggestions: ["USE THERAPEUTIC RESTRICTION", "USE THERAPEUTIC HIERARCHY NON-BLANK MAINT FLAG", "USE THERAPEUTIC RESTRICTION MATCH TP", "USE DRUG THIRD PARTY RECORD"]
  }

  dimension: patient_plan_therapeutic_mac_flag {
    label: "Patient Plan Therapeutic MAC Flag"
    description: "PLAN THERAPEUTIC MAC is a flag determining which therapeutic MAC record the system uses when determining the maximum allowable cost for a third party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_THERAPEUTIC_MAC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG IS NULL THEN 'USE FIRST THERAPEUTIC MAC RECORD'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG = 'S' THEN 'USE THERAPEUTIC MAC MATCHES TP'
              WHEN ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG = 'N' THEN 'USE DRUG THIRD PARTY RECORD'
              ELSE ${TABLE}.STORE_PLAN_THERAPEUTIC_MAC_FLAG
         END ;;
    suggestions: ["USE FIRST THERAPEUTIC MAC RECORD", "USE THERAPEUTIC MAC MATCHES TP", "USE DRUG THIRD PARTY RECORD"]
  }

  dimension: patient_plan_require_drug_tp_flag {
    label: "Patient Plan Require Drug TP Flag"
    description: "Flag indicating if a plan requires a drug third party record and the action to take if a drug third party record is required but is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'Q' THEN 'REQUIRED HARD HALT PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'P' THEN 'REQUIRED HARD HALT PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DRUG_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT", "REQUIRED WARNING ALLOW FILL", "REQUIRED HARD HALT PA NUMBER / CODE", "REQUIRED HARD HALT PRIOR AUTH CODE", "NOT REQUIRED"]
  }

  dimension: patient_plan_host_drug_tp_flag {
    label: "Patient Plan Host Drug TP Flag"
    description: "Flag indicating if a plan requires a Host supported drug third party record and the action to take if a Host supported drug third party record is required but is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_HOST_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_HOST_DRUG_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_ignore_default_drug_tp_flag {
    label: "Patient Plan Ignore Default Drug TP Flag"
    description: "Flag determining if the system checks the edits on the default drug third party record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'G' THEN 'IGNORES WHEN GENERIC DRUG'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'M' THEN 'IGNORES WHEN MAINT FLAG IS Y'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'N' THEN 'DEFUALT DRUG TP'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'B' THEN 'IGNORES WHEN MAINT FLAG IS Y OR GENERIC'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG = 'Y' THEN 'IGNORES DEFAULT DRUG TP'
              ELSE ${TABLE}.STORE_PLAN_IGNORE_DEFAULT_DRUG_TP_FLAG
         END ;;
    suggestions: ["IGNORES DEFAULT DRUG TP", "IGNORES WHEN MAINT FLAG IS Y", "IGNORES WHEN GENERIC DRUG", "IGNORES WHEN MAINT FLAG IS Y OR GENERIC", "DEFUALT DRUG TP"]
  }

  dimension: patient_plan_drug_tp_code {
    label: "Patient Plan Drug TP Code"
    description: "Flag determining if a drug third party code is required when adding or updating a drug third party record and the action to take if a drug third party code is required but one is not found. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_TP_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_TP_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_DRUG_TP_CODE = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_DRUG_TP_CODE
         END ;;
    suggestions: ["REQUIRED HARD HALT UPDATE NOT ALLOWED", "REQUIRED WARNING ALLOW UPDATE", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_vendor_tp_flag {
    label: "Patient Plan Require Vendor TP Flag"
    description: "Flag determining if a vendor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_VENDOR_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_VENDOR_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_phone_flag {
    label: "Patient Plan Require Prescriber Phone Flag"
    description: "Flag determining if a doctor telephone number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PHONE_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_tp_flag {
    label: "Patient Plan Require Prescriber TP Flag"
    description: "Flag determining if a doctor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'W' THEN 'REQUIRED WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG = 'Y' THEN 'REQUIRED HARD HALT - NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_FLAG
         END ;;
    suggestions: ["REQUIRED HARD HALT - NOT ALLOWED", "REQUIRED WARNING ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_refill_halt_type {
    label: "Patient Plan Refill Halt Type"
    description: "Flag determining the action that should occur when a refill edit fails. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REFILL_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REFILL_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE = 'Y' THEN 'HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_REFILL_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NOT REQUIRED"]
  }

  dimension: patient_plan_both_refill_edits_flag {
    label: "Patient Plan Both Refill Edits"
    description: "Yes/No Flag indicating if the system checks maximum number of refills and refills expiration by reading through a patient's transaction profile. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BOTH_REFILL_EDITS_FLAG = 'Y' ;;
  }

  dimension: patient_plan_set_expire_flag {
    label: "Patient Plan Set Expire"
    description: "Yes/No Flag indicating how a prescription expiration date is calculated. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SET_EXPIRE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_set_max_flag {
    label: "Patient Plan Set Max"
    description: "Yes/No Flag indicating if the number of refills allowed is corrected to the maximum allowed if more than the maximum number of refills is entered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SET_MAX_FLAG = 'Y' ;;
  }

  dimension: patient_plan_refill_days_limit {
    label: "Patient Plan Refill Days Limit"
    description: "Maximum number of days a prescription can be refilled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_REFILL_DAYS_LIMIT ;;
  }

  dimension: patient_plan_maximum_number_refills {
    label: "Patient Plan Maximum Number Refills"
    description: "Maximum number of refills allowed by a plan on all drugs except schedule 3, 4 and 5. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_NUMBER_REFILLS ;;
  }

  dimension: patient_plan_schedule_number_refill {
    label: "Patient Plan Schedule Number Refill"
    description: "Maximum number of refills allowed by a plan on schedule 3, 4 and 5 drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_SCHEDULE_NUMBER_REFILL ;;
  }

  dimension: patient_plan_number_days {
    label: "Patient Plan Number Days"
    description: "Number of days before a prescription may be refilled again. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_DAYS ;;
  }

  dimension: patient_plan_percent_days {
    label: "Patient Plan Percent Days"
    description: "Percentage of days supply that must pass before a prescription may be refilled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_PERCENT_DAYS ;;
  }

  dimension: patient_plan_disallow_quantity_changes_flag {
    label: "Patient Plan Disallow Quantity Changes"
    description: "Yes/No Flag indicating if quantity changes on refills are disallowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_QUANTITY_CHANGES_FLAG = 'Y' ;;
  }

  dimension: patient_plan_quantity_halt_type {
    label: "Patient Plan Quantity Halt Type"
    description: "Flag determining the action that should occur if dispensing limits are exceeded. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_QUANTITY_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE = 'Y' THEN 'HARD HALT'
              ELSE ${TABLE}.STORE_PLAN_QUANTITY_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NO ACTION"]
  }

  dimension: patient_plan_pass_both_regular_limits_flag {
    label: "Patient Plan Pass Both Regular Limits Flag"
    description: "Flag determining if non-maintenance prescription must pass one or both dispensing limit checks in order to be filled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG IS NULL THEN 'NOT CHECKED'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG = 'N' THEN 'PASS ONE CHECK'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG = 'Y' THEN 'PASS BOTH CHECKS'
              ELSE ${TABLE}.STORE_PLAN_PASS_BOTH_REGULAR_LIMITS_FLAG
        END ;;
    suggestions: ["NOT CHECKED", "PASS BOTH CHECKS", "PASS ONE CHECK"]
  }

  dimension: patient_plan_pass_both_maintenance_limits_flag {
    label: "Patient Plan Pass Both Maintenance Limits Flag"
    description: "Flag determining if maintenance prescription must pass one or both dispensing limit checks in order to be filled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG IS NULL THEN 'NOT CHECKED'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG = 'N' THEN 'PASS ONE CHECK'
              WHEN ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG = 'Y' THEN 'PASS BOTH CHECKS'
              ELSE ${TABLE}.STORE_PLAN_PASS_BOTH_MAINTENANCE_LIMITS_FLAG
         END ;;
    suggestions: ["NOT CHECKED", "PASS BOTH CHECKS", "PASS ONE CHECK"]
  }

  dimension: patient_plan_quantity_limit_type {
    label: "Patient Plan Quantity Limit Type"
    description: "Flag determining if dispensing limits are based on units or doses. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #[ERXLPS-2383] CASE WHEN logic added with master codes. Currently this column do not added to EDW.D_MASTER_CODE table. We need to add them to master code table.
    sql: CASE WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE = '0' THEN 'UNITS'
              WHEN ${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE = '1' THEN 'DOSES'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_QUANTITY_LIMIT_TYPE)
         END ;;
    suggestions: ["NOT SPECIFIED", "UNITS", "DOSES"]
  }

  dimension: patient_plan_maximum_days_supply {
    label: "Patient Plan Maximum Days Supply"
    description: "Maximum days supply allowed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_DAYS_SUPPLY ;;
  }

  dimension: patient_plan_minimum_days_supply {
    label: "Patient Plan Minimum Days Supply"
    description: "Minimum days supply allowed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_DAYS_SUPPLY ;;
  }

  dimension: patient_plan_max_maintenance_days_supply {
    label: "Patient Plan Max Maintenance Days Supply"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAX_MAINTENANCE_DAYS_SUPPLY ;;
  }

  dimension: patient_plan_minimum_maintenance_days_supply {
    label: "Patient Plan Minimum Maintenance Days Supply"
    description: "Minimum days supply allowed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_MAINTENANCE_DAYS_SUPPLY ;;
  }

  dimension: patient_plan_maximum_ml_packs {
    label: "Patient Plan Maximum ML Packs"
    description: "Flag determining if number of packs dispensed is limited for liquid drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAXIMUM_ML_PACKS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS IS NULL THEN 'NOT LIMITED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '1' THEN 'LIMIT ONE PACK'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '2' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '3' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '4' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '5' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '6' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '7' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS = '8' THEN 'LIMIT TO PACKS ENTERED'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_MAXIMUM_ML_PACKS)
         END ;;
    suggestions: [
      "NOT LIMITED",
      "LIMIT ONE PACK",
      "LIMIT TO PACKS ENTERED"
    ]
  }

  dimension: patient_plan_maximum_single_packs {
    label: "Patient Plan Maximum Single Packs"
    description: "Yes/No Flag indicating if the single pack flag on the drug third party record is checked. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_SINGLE_PACKS = 'Y' ;;
  }

  dimension: patient_plan_maximum_gram_packs {
    label: "Patient Plan Maximum Gram Packs"
    description: "Flag determining if number of packs dispensed is limited for gram unit drugs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAXIMUM_GRAM_PACKS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS IS NULL THEN 'NOT LIMITED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '1' THEN 'LIMIT ONE PACK'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '2' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '3' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '4' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '5' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '6' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '7' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '8' THEN 'LIMIT TO PACKS ENTERED'
              WHEN ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS = '9' THEN 'LIMIT TO PACKS ENTERED'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_MAXIMUM_GRAM_PACKS)
         END ;;
    suggestions: [
      "NOT LIMITED",
      "LIMIT ONE PACK",
      "LIMIT TO PACKS ENTERED"
    ]
  }

  dimension: patient_plan_initial_fill_max_days {
    label: "Patient Plan Initial Fill Max Days"
    description: "Maximum days supply allowed on the initial fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_INITIAL_FILL_MAX_DAYS ;;
  }

  dimension: patient_plan_round_up_flag {
    label: "Patient Plan Round Up"
    description: "Yes/No Flag indicating if calculated days supply should be rounded up or down. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ROUND_UP_FLAG = 'Y' ;;
  }

  dimension: patient_plan_max_halt_code {
    label: "Patient Plan Max Halt Code"
    description: "Flag indicating the action that should occur when the prescription being filled exceeds the maximum dollar amount or number of refills allowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MAX_HALT_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MAX_HALT_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'W' THEN 'WARNING ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'P' THEN 'HARD HALT REQUIRE PA NUMBER / CODE'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'N' THEN 'NO ACTION'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'Y' THEN 'HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_MAX_HALT_CODE = 'Q' THEN 'HARD HALT REQUIRE PRIOR AUTH CODE'
              ELSE ${TABLE}.STORE_PLAN_MAX_HALT_CODE
         END ;;
    suggestions: ["HARD HALT", "WARNING ALLOW FILL", "HARD HALT REQUIRE PA NUMBER / CODE", "HARD HALT REQUIRE PRIOR AUTH CODE", "NO ACTION"]
  }

  dimension: patient_plan_number_override_flag {
    label: "Patient Plan Number Override"
    description: "Yes/No Flag indicating what value should be used in determining the prescription limit allowed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NUMBER_OVERRIDE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_number_rx_dependecy {
    label: "Patient Plan Number Rx Dependecy"
    description: "Number of prescription fills allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_RX_DEPENDECY ;;
  }

  dimension: patient_plan_require_generic_flag {
    label: "Patient Plan Require Generic Flag"
    description: "Flag determining use of linked substitute drug should be forced unless overridden by a DAW. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_GENERIC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'N' THEN 'DO NOT FORCE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'Y' THEN 'FORCE USE OF LINK'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG = 'W' THEN 'LINKED SUBSTITUTE IS REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_GENERIC_FLAG
         END ;;
    suggestions: ["FORCE USE OF LINK", "LINKED SUBSTITUTE IS REQUIRED", "DO NOT FORCE"]
  }

  dimension: patient_plan_require_daw_flag {
    label: "Patient Plan Require DAW Flag"
    description: "Flag determining if a DAW code is required when dispensing a brand drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DAW_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'W' THEN 'REQUIRED - WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'Y' THEN 'REQUIRED - HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DAW_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT", "REQUIRED - WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prior_auth_number_flag {
    label: "Patient Plan Require Prior Auth Number Flag"
    description: "Flag determining if a prior authorization number is  required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT", "REQUIRED - WARNING", "NOT REQUIRED"]
  }

  dimension: patient_plan_low_cost_flag {
    label: "Patient Plan Low Cost Flag"
    description: "Yes/No Flag indicating if the prescription cost should be calculated using both the primary and alternate cost bases and then use the lower of the two costs. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_LOW_COST_FLAG = 'Y' ;;
  }

  dimension: patient_plan_use_discount_flag {
    label: "Patient Plan use Discount Flag"
    description: "Flag determining when a patient's usual discount should be applied. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_USE_DISCOUNT_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'Y' THEN 'ALWAYS USE'
              WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'U' THEN 'USE ONLY VIA PRICE CODE'
              WHEN ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG = 'N' THEN 'NEVER USE'
              ELSE ${TABLE}.STORE_PLAN_USE_DISCOUNT_FLAG
         END ;;
    suggestions: ["ALWAYS USE", "USE ONLY VIA PRICE CODE", "NEVER USE"]
  }

  dimension: patient_plan_cost_percent {
    label: "Patient Plan Cost Percent"
    description: "Percentage of cost to override cost base. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_COST_PERCENT ;;
    value_format: "00.00\"%\""
  }

  dimension: patient_plan_maximum_allowable_cost_flag {
    label: "Patient Plan Maximum Allowable Cost"
    description: "Flag determining the cost used for a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ALLOWABLE_COST_FLAG = 'Y' ;;
  }

  dimension: patient_plan_ignore_mac_flag {
    label: "Patient Plan Ignore MAC Flag"
    description: "Flag determining if MAC pricing is ignored. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_IGNORE_MAC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'Y' THEN 'IGNORE MAC PRICING UNLESS DAW IS 1'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'N' THEN 'USE MAC PRICING'
              WHEN ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG = 'A' THEN 'IGNORE MAC PRICING UNLESS DAW IS 0 OR 6'
              ELSE ${TABLE}.STORE_PLAN_IGNORE_MAC_FLAG
         END ;;
    suggestions: ["IGNORE MAC PRICING UNLESS DAW IS 1", "IGNORE MAC PRICING UNLESS DAW IS 0 OR 6", "USE MAC PRICING"]
  }

  dimension: patient_plan_generic_fee_calculation_type {
    label: "Patient Plan Generic Fee Calculation Type"
    description: "Yes/No Flag indicating how the generic fee is calculated when dispensing a generic drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_GENERIC_FEE_CALCULATION_TYPE = 'Y' ;;
  }

  dimension: patient_plan_taxable_flag {
    label: "Patient Plan Taxable Flag"
    description: "Flag determining if tax should be calculated. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TAXABLE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TAXABLE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'N' THEN 'DO NOT CALCULATE'
              WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'P' THEN 'CALCULATE IF PRICE CODE'
              WHEN ${TABLE}.STORE_PLAN_TAXABLE_FLAG = 'Y' THEN 'ALWAYS CALCULATE'
              ELSE ${TABLE}.STORE_PLAN_TAXABLE_FLAG
         END ;;
    suggestions: ["ALWAYS CALCULATE ", "CALCULATE IF PRICE CODE", "DO NOT CALCULATE"]
  }

  dimension: patient_plan_transmit_excludes_tax_flag {
    label: "Patient Plan Transmit Excludes Tax"
    description: "Yes/No Flag indicating how the tax amount received from a third party is handled when a 100% copay is received. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_EXCLUDES_TAX_FLAG = 'Y' ;;
  }

  dimension: patient_plan_compare_uc_flag {
    label: "Patient Plan Compare UC Flag"
    description: "Flag determining if the third party prescription price is compared to the usual and customary cash price with the lesser price being used to price the prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COMPARE_UC_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COMPARE_UC_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'Y' THEN 'USE LOWER PRICE'
              WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'D' THEN 'INCLUDE DISCOUNT USE LOWER PRICE'
              WHEN ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG = 'N' THEN 'DO NOT COMPARE'
              ELSE ${TABLE}.STORE_PLAN_COMPARE_UC_FLAG
         END ;;
    suggestions: ["USE LOWER PRICE", "INCLUDE DISCOUNT USE LOWER PRICE", "DO NOT COMPARE"]
  }

  dimension: patient_plan_uc_price_flag {
    label: "Patient Plan UC Price"
    description: "Yes/No Flag indicating if fees are added to the usual and customary price in order to determine the third party price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_UC_PRICE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_base_sig_dose_flag {
    label: "Patient Plan Base Sig Dose"
    description: "Yes/No Flag indicating the value on which to base a unit dose fee. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BASE_SIG_DOSE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_add_compound_flag {
    label: "Patient Plan Add Compound Flag"
    description: "Flag determining how a compound fee is handled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ADD_COMPOUND_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'U' THEN 'FEE ADDED AND UPCHARGE'
              WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'Y' THEN 'FEE ADDED'
              WHEN ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG = 'N' THEN 'FEE NOT ADDED'
              ELSE ${TABLE}.STORE_PLAN_ADD_COMPOUND_FLAG
         END ;;
    suggestions: ["FEE ADDED", "FEE ADDED AND UPCHARGE", "FEE NOT ADDED"]
  }

  dimension: patient_plan_copay_basis {
    label: "Patient Plan Copay Basis"
    description: "Determines whether the Copay should be calculated from the Base Cost, U&C Price, or Rx Price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COPAY_BASIS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COPAY_BASIS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'C' THEN 'BASE COST'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'U' THEN 'U C PRICE'
              WHEN ${TABLE}.STORE_PLAN_COPAY_BASIS = 'P' THEN 'RX PRICE'
              ELSE ${TABLE}.STORE_PLAN_COPAY_BASIS
         END ;;
    suggestions: ["NOT SPECIFIED", "BASE COST", "U C PRICE", "RX PRICE"]
  }

  dimension: patient_plan_total_dependable_flag {
    label: "Patient Plan Total Dependable"
    description: "Yes/No Flag indicating if the reimbursement and deductible are totaled on the patient third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TOTAL_DEPENDABLE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_how_max_flag {
    label: "Patient Plan How Max"
    description: "Yes/No Flag indicating if the value on which to base the maximum reimbursement amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_HOW_MAX_FLAG = 'Y' ;;
  }

  dimension: patient_plan_copay_flag {
    label: "Patient Plan Copay Flag"
    description: "Yes/No Flag indicating if copay amount is included in the maximum reimbursement amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_COPAY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_COPAY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG IS NULL THEN 'DOES NOT CHECK'
              WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG = 'N' THEN 'EXCLUDE COPAY'
              WHEN ${TABLE}.STORE_PLAN_COPAY_FLAG = 'Y' THEN 'INCLUDES COPAY'
              ELSE ${TABLE}.STORE_PLAN_COPAY_FLAG
         END ;;
    suggestions: ["DOES NOT CHECK", "INCLUDES COPAY", "EXCLUDE COPAY"]
  }

  dimension: patient_plan_split_copay_flag {
    label: "Patient Plan Split Copay"
    description: "Yes/No Flag indicating if a plan pays 100% of the primary third party copay when plan is billed as a split bill. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SPLIT_COPAY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_price_compare_flag {
    label: "Patient Plan Price Compare Flag"
    description: "Flag indicating the action to take if the copay is greater than the third party price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRICE_COMPARE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'N' THEN 'LOWER COPAY'
              WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'Y' THEN 'RAISE PRICE TO COPAY'
              WHEN ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG = 'D' THEN 'IF NOT TRANSMIT RAISE PRICE'
              ELSE ${TABLE}.STORE_PLAN_PRICE_COMPARE_FLAG
         END ;;
    suggestions: ["RAISE PRICE TO COPAY", "IF NOT TRANSMIT RAISE PRICE", "LOWER COPAY"]
  }

  dimension: patient_plan_copay_uc_compare_flag {
    label: "Patient Plan Copay UC Compare"
    description: "Yes/No Flag indicating if copay is compared to the usual and customary price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_COPAY_UC_COMPARE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_cash_bill_flag {
    label: "Patient Plan Cash Bill"
    description: "Yes/No Flag indicating if a prescription is treated as a third party prescription or a cash prescription when the prescription amount equals the copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CASH_BILL_FLAG = 'Y' ;;
  }

  dimension: patient_plan_adc_first_flag {
    label: "Patient Plan ADC First"
    description: "Yes/No Flag indicating if ADC copays and discounts are assigned before compound or over the counter copays and discounts. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ADC_FIRST_FLAG = 'Y' ;;
  }

  dimension: patient_plan_otc_accumulator_flag {
    label: "Patient Plan OTC Accumulator"
    description: "Yes/No Flag indicating if over the counter copays are excluded from patient third party accumulators. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_OTC_ACCUMULATOR_FLAG = 'Y' ;;
  }

  dimension: patient_plan_disable_cardholder_copay_flag {
    label: "Patient Plan Disable Cardholder Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a cardholder record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_CARDHOLDER_COPAY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_disable_drug_tp_copay_flag {
    label: "Patient Plan Disable Drug TP Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a drug third party  record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_DRUG_TP_COPAY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_disable_therapuetic_restriction_copay_flag {
    label: "Patient Plan Disable Therapuetic Restriction Copay"
    description: "Yes/No Flag indicating if copay information is allowed to be entered on a therapeutic restriction record linked to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISABLE_THERAPUETIC_RESTRICTION_COPAY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_sig_on_file_flag {
    label: "Patient Plan Sig On File Flag"
    description: "Flag indicating the value that should print on the patient signature line when printing third party claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_SIG_ON_FILE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG IS NULL THEN 'SIGNATURE FIELD BLANK'
              WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG = '1' THEN '1 IN THE SIGNATURE FIELD'
              WHEN ${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG = '2' THEN 'SIG ON FILE IN FIELD'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_SIG_ON_FILE_FLAG)
         END ;;
    suggestions: ["SIGNATURE FIELD BLANK", "1 IN THE SIGNATURE FIELD", "SIG ON FILE IN FIELD"]
  }

  dimension: patient_plan_pharmacy_transmit_id_type {
    label: "Patient Plan Pharmacy Transmit ID Type"
    description: "Code indicating the value to be used for the pharmacy identification number when processing third party information. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE IS NULL THEN 'PROVIDER NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '1' THEN 'PROVIDER NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '2' THEN 'TRANSMITTAL ID NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE = '3' THEN 'NCPDP STORE NUMBER'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_PHARMACY_TRANSMIT_ID_TYPE)
         END ;;
    suggestions: ["PROVIDER NUMBER", "TRANSMITTAL ID NUMBER", "NCPDP STORE NUMBER"]
  }

  dimension: patient_plan_print_dependent_number_flag {
    label: "Patient Plan Print Dependent Number Flag"
    description: "Flag determining if the dependent number prints on universal claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'Y' THEN 'PRINTS DEPENDENT NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'N' THEN 'DOES NOT PRINT DEPENDENT NUMBER' --Corrected the value based on data dictionary. EDW.D_MASTER_CODE table do not have correct description.
              WHEN ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG = 'T' THEN 'APPENDS DEPENDENT NUMBER' --Corrected the value based on data dictionary. EDW.D_MASTER_CODE table do not have correct description.              ELSE ${TABLE}.STORE_PLAN_PRINT_DEPENDENT_NUMBER_FLAG
         END ;;
    suggestions: ["PRINTS DEPENDENT NUMBER", "DOES NOT PRINT DEPENDENT NUMBER", "APPENDS DEPENDENT NUMBER"]
  }

  dimension: patient_plan_total_by_flag {
    label: "Patient Plan Total by Flag"
    description: "Flag determining how totals are printed on universal claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_TOTAL_BY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_TOTAL_BY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG IS NULL THEN 'DOES NOT USE TOTAL BY'
              WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG = '1' THEN 'TOTALS BY CARRIER'
              WHEN ${TABLE}.STORE_PLAN_TOTAL_BY_FLAG = '2' THEN 'PLAN BASIS TOTAL'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_TOTAL_BY_FLAG)
         END ;;
    suggestions: ["DOES NOT USE TOTAL BY", "TOTALS BY CARRIER", "PLAN BASIS TOTAL"]
  }

  dimension: patient_plan_sort_by_flag {
    label: "Patient Plan Sort by Flag"
    description: "Flag determining how claims are sorted when printing claim forms. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_SORT_BY_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_SORT_BY_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '1' THEN 'TRANSACTION NUMBER'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '2' THEN 'PRESCRIPTION NUMBER'
              WHEN ${TABLE}.STORE_PLAN_SORT_BY_FLAG = '3' THEN 'PATIENT NAME'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_SORT_BY_FLAG)
         END ;;
    suggestions: ["TRANSACTION NUMBER", "PRESCRIPTION NUMBER", "PATIENT NAME", "NOT SPECIFIED"]
  }

  dimension: patient_plan_split_flag {
    label: "Patient Plan Split"
    description: "Yes/No Flag indicating if a plan record is eligible for use as a split bill plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SPLIT_FLAG = 'Y' ;;
  }

  dimension: patient_plan_nhin_process_code {
    label: "Patient Plan NHIN Process Code"
    description: "Flag indicating if NHIN processes claims for a plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NHIN_PROCESS_CODE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'N' THEN 'DOES NOT PROCESS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'B' THEN 'SUBMITS AND RECONCILES CLAMS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'R' THEN 'RECONCILES CLAIMS'
              WHEN ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE = 'S' THEN 'SUBMITS CLAIMS'
              ELSE ${TABLE}.STORE_PLAN_NHIN_PROCESS_CODE
         END ;;
    suggestions: ["SUBMITS CLAIMS", "RECONCILES CLAIMS", "SUBMITS AND RECONCILES CLAMS", "DOES NOT PROCESS"]
  }

  dimension: patient_plan_transfer_to_account_flag {
    label: "Patient Plan Transfer to Account"
    description: "Yes/No Flag indicating if the difference between the submitted amount and paid amount is transferred to the store account. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSFER_TO_ACCOUNT_FLAG = 'Y' ;;
  }

  dimension: patient_plan_print_balance_flag {
    label: "Patient Plan Print Balance"
    description: "Yes/No Flag indicating if claims may be re-submitted. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PRINT_BALANCE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_number_rebill {
    label: "Patient Plan Number Rebill"
    description: "Number of times a plan allows a claim to be re-billed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_NUMBER_REBILL ;;
  }

  dimension: patient_plan_basis {
    label: "Patient Plan Basis"
    description: "Drug cost basis. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_BASIS),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_BASIS') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_BASIS IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '1' THEN 'AWP-DEFAULT'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '2' THEN 'THE LOCAL WHOLESALER'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '3' THEN 'DIRECT'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '4' THEN 'ESTIMATED ACQ'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '5' THEN 'ACQUISITION'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '6' THEN 'MAC'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '7' THEN 'USUAL AND CUSTOMARY'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '8' THEN '340B'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '9' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '10' THEN 'ASP'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '11' THEN 'AMP'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '12' THEN 'WAC'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '13' THEN 'SPECIAL'
              WHEN ${TABLE}.STORE_PLAN_BASIS = '14' THEN 'UNREPORTABLE QTY'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_BASIS)
         END ;;
    suggestions: [
      "UNDETERMINED",
      "AWP-DEFAULT",
      "THE LOCAL WHOLESALER",
      "DIRECT",
      "ESTIMATED ACQ",
      "ACQUISITION",
      "MAC",
      "USUAL AND CUSTOMARY",
      "340B",
      "OTHER",
      "ASP",
      "AMP",
      "WAC",
      "SPECIAL",
      "UNREPORTABLE QTY",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_allow_change_price_flag {
    label: "Patient Plan Allow Change Price Flag"
    description: "Flag determining if the Change Price screen is automatically displayed after claim transmission and if the price of a claim is allowed to be changed. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG IS NULL THEN 'MAY NOT BE CHANGED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'R' THEN 'MAY ONLY BE RAISED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'S' THEN 'RAISED UP TO THE AMOUNT SUBMITTED'
              WHEN ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG = 'Y' THEN 'MAY BE CHANGED'
              ELSE ${TABLE}.STORE_PLAN_ALLOW_CHANGE_PRICE_FLAG
         END ;;
    suggestions: ["MAY NOT BE CHANGED", "MAY BE CHANGED", "MAY ONLY BE RAISED", "RAISED UP TO THE AMOUNT SUBMITTED"]
  }

  dimension: patient_plan_transmit_31_flag {
    label: "Patient Plan Transmit 31"
    description: "Yes/No Flag indicating if NCPDP 31 type transmissions may be re-submitted during Rx Correction. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_31_FLAG = 'Y' ;;
  }

  dimension: patient_plan_service_flag {
    label: "Patient Plan Service"
    description: "Yes/No Flag indicating if a plan supports cognitive services. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SERVICE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_no_paper_flag {
    label: "Patient Plan No Paper Flag"
    description: "Flag indicating if a plan allows paper billing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NO_PAPER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NO_PAPER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'N' THEN 'ALLOW PAPER BILLING'
              WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'W' THEN 'WARN PAPER BILLING NOT ALLOWED'
              WHEN ${TABLE}.STORE_PLAN_NO_PAPER_FLAG = 'Y' THEN 'PAPER BILLING NOT ALLOWED'
              ELSE ${TABLE}.STORE_PLAN_NO_PAPER_FLAG
         END ;;
    suggestions: ["PAPER BILLING NOT ALLOWED", "WARN PAPER BILLING NOT ALLOWED", "ALLOW PAPER BILLING"]
  }

  dimension: patient_plan_compound_paper_flag {
    label: "Patient Plan Compound Paper"
    description: "Yes/No Flag indicating if a plan allows compounds to be billed on paper for transmitted claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_COMPOUND_PAPER_FLAG = 'Y' ;;
  }

  dimension: patient_plan_card_layout_help_1 {
    label: "Patient Plan Card Layout Help 1"
    description: "CARD_LAYOUT_HELP_1 stores the first line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_1 ;;
  }

  dimension: patient_plan_card_layout_help_2 {
    label: "Patient Plan Card Layout Help 2"
    description: "CARD_LAYOUT_HELP_2 stores the 2nd line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_2 ;;
  }

  dimension: patient_plan_card_layout_help_3 {
    label: "Patient Plan Card Layout Help 3"
    description: "CARD_LAYOUT_HELP_3 stores the 3rd line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_3 ;;
  }

  dimension: patient_plan_card_layout_help_4 {
    label: "Patient Plan Card Layout Help 4"
    description: "CARD_LAYOUT_HELP_4 stores the 4th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_4 ;;
  }

  dimension: patient_plan_card_layout_help_5 {
    label: "Patient Plan Card Layout Help 5"
    description: "CARD_LAYOUT_HELP_5 stores the 5th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_5 ;;
  }

  dimension: patient_plan_card_layout_help_6 {
    label: "Patient Plan Card Layout Help 6"
    description: "CARD_LAYOUT_HELP_6 stores the 6th line of help text that displays in the Card Layout Help section of the Plan Help screen. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_LAYOUT_HELP_6 ;;
  }

  dimension: patient_plan_plan_text {
    label: "Patient Plan Plan Text"
    description: "Additional insurance plan information and help text. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_TEXT ;;
  }

  dimension: patient_plan_contact {
    label: "Patient Plan Contact"
    description: "Help desk contact name or department. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CONTACT ;;
  }

  dimension_group: patient_plan_begin_coverage {
    label: "Patient Plan Begin Coverage"
    description: "BEGIN_COVERAGE_DATE stores the date when the third party plan is effective. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_BEGIN_COVERAGE_DATE ;;
  }

  dimension_group: patient_plan_end_coverage {
    label: "Patient Plan End Coverage"
    description: "END_COVERAGE_DATE is the date when the third party plan expires. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_END_COVERAGE_DATE ;;
  }

  dimension: patient_plan_require_patient_tp_begin_date_flag {
    label: "Patient Plan Require Patient TP Begin Date Flag"
    description: "REQ_PATIENT_TP_BEGIN_DATE is a flag indicating if a beginning patient third party coverage date is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'Y' THEN 'REQUIRE DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'W' THEN 'REQUIRE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_BEGIN_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE DATE HARD HALT", "REQUIRE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_patient_tp_end_date_flag {
    label: "Patient Plan Require Patient TP End Date Flag"
    description: "REQ_PATIENT_TP_END_DATE is a flag indicating if an ending patient third party coverage date is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'Y' THEN 'REQUIRE DATE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'W' THEN 'REQUIRE DATE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'I' THEN 'IGNORE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_TP_END_DATE_FLAG
         END ;;
    suggestions: ["REQUIRE DATE HARD HALT", "REQUIRE DATE WARNING", "IGNORE", "NOT REQUIRED"]
  }

  dimension: patient_plan_state_formulary_last {
    label: "Patient Plan State Formulary Last"
    description: "STATE_FORMLUARY_LAST stores the last drug third party state formulary update. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE_FORMULARY_LAST ;;
  }

  dimension: patient_plan_no_compound_daw_flag {
    label: "Patient Plan No Compound DAW"
    description: "Flag indicating if compounds should be excluded from DAW checks. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NO_COMPOUND_DAW_FLAG = 'Y' ;;
  }

  dimension: patient_plan_pharmacy_provider_id_qualifier {
    label: "Patient Plan Pharmacy Provider ID Qualifier"
    description: "Service provider ID qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER = '99' THEN 'OTHER'
              ELSE ${TABLE}.STORE_PLAN_PHARMACY_PROVIDER_ID_QUALIFIER
         END ;;
    suggestions: [
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_pharmacist_id_qualifier {
    label: "Patient Plan Pharmacist ID Qualifier"
    description: "Pharmacist ID Qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PHARMACIST_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '01' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '02' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '03' THEN 'SS NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '04' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '05' THEN 'NPI'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '06' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '07' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER = '99' THEN 'OTHER'
              ELSE ${TABLE}.STORE_PLAN_PHARMACIST_ID_QUALIFIER
         END ;;
    suggestions: [
      "DEA",
      "STATE LICENSE",
      "SS NUMBER",
      "NAME",
      "NPI",
      "HIN",
      "STATE ISSUED",
      "OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_prescriber_transmit_id_qualifier {
    label: "Patient Plan Prescriber Transmit ID Qualifier"
    description: "Physician ID Qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '81' THEN 'SASK MEDICAL PRACT'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '82' THEN 'SASK PHARMACIST'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER = '83' THEN 'SASK HEALTH MED SRV'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ID_QUALIFIER
         END ;;
    suggestions: [
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "SASK MEDICAL PRACT",
      "SASK PHARMACIST",
      "SASK HEALTH MED SRV",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_non_complete_flag {
    label: "Patient Plan Non Complete Flag"
    description: "Flag indicating how non-completed claims should be handled. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_NON_COMPLETE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'S' THEN 'DISPLAYS ON SUBMIT REJECT'
              WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'W' THEN 'WARNING ON FILLING SCREEN'
              WHEN ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG = 'N' THEN 'NOTHING INDICATED'
              ELSE ${TABLE}.STORE_PLAN_NON_COMPLETE_FLAG
         END ;;
    suggestions: ["DISPLAYS ON SUBMIT REJECT", "WARNING ON FILLING SCREEN", "NOTHING INDICATED"]
  }

  dimension: patient_plan_low_based_acquisition_flag {
    label: "Patient Plan Low Based Acquisition"
    description: "Yes/No Flag indicating if the acquisition cost or the submitted price should be used when determining low payment status. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_LOW_BASED_ACQUISITION_FLAG = 'Y' ;;
  }

  dimension: patient_plan_prescriber_paper_alt_id_type {
    label: "Patient Plan Prescriber Paper Alt ID Type"
    description: "Flag indicating the value to use for the alternate doctor ID if the primary ID is blank. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '1' THEN 'DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '2' THEN 'STATE/PROVINCE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '3' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '4' THEN 'T/P ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '5' THEN 'ALTERNATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '6' THEN 'NAME AND DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '7' THEN 'NAME AND STATE/PROV ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '8' THEN 'NAME AND T/P ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = '9' THEN 'NAME AND ALTERNATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'A' THEN 'DOCTOR T/P FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'B' THEN 'NAME AND DOCTOR T/P FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'C' THEN 'DEA NUMBER MINUS FIRST 2 CHARACTERS'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'D' THEN 'T/P ID (DEA IF T/P ID IS BLANK)'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'E' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'F' THEN 'NAME AND HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'G' THEN 'SPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'H' THEN 'NAME AND SPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'I' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE = 'J' THEN 'NAME AND UPIN'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ALT_ID_TYPE
         END ;;
    suggestions: [
      "DEA NUMBER",
      "STATE/PROVINCE ID",
      "NAME",
      "T/P ID",
      "ALTERNATE ID",
      "NAME AND DEA NUMBER",
      "NAME AND STATE/PROV ID",
      "NAME AND T/P ID",
      "NAME AND ALTERNATE ID",
      "DOCTOR T/P FILE ID",
      "NAME AND DOCTOR T/P FILE ID",
      "DEA NUMBER MINUS FIRST 2 CHARACTERS",
      "T/P ID (DEA IF T/P ID IS BLANK)",
      "HIN",
      "NAME AND HIN",
      "SPIN",
      "NAME AND SPIN",
      "UPIN",
      "NAME AND UPIN",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_default_prescriber_id_qualifier {
    label: "Patient Plan Default Prescriber ID Qualifier"
    description: "Qualifier associated with the Default Prescriber ID. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_DEFAULT_PRESCRIBER_ID_QUALIFIER ;;
  }

  dimension: patient_plan_auto_denial_flag {
    label: "Patient Plan Auto Denial"
    description: "Yes/No Flag indicating if the denial date should be auto-populated when split billing a transaction to a plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_AUTO_DENIAL_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_dependent_number_halt_type {
    label: "Patient Plan Require Dependent Number Halt Type"
    description: "Yes/No Flag indicating the action to occur if the edit requiring a dependent number fails. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'Y' THEN 'HARD HALT DO NOT ALLOW UPDATE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'W' THEN 'WARNING ALLOW UPDATE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE = 'N' THEN 'NO ACTION'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_HALT_TYPE
         END ;;
    suggestions: ["HARD HALT DO NOT ALLOW UPDATE", "WARNING ALLOW UPDATE", "NO ACTION"]
  }

  dimension: patient_plan_require_dependent_number_flag {
    label: "Patient Plan Require Dependent Number Flag"
    description: "Flag determining if a dependent number is required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'A' THEN 'ALWAYS REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'Y' THEN 'REQUIRED IF CODE'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_DEPENDENT_NUMBER_FLAG
         END ;;
    suggestions: ["ALWAYS REQUIRED", "REQUIRED IF CODE", "NOT REQUIRED"]
  }

  dimension: patient_plan_ignore_tax_flag {
    label: "Patient Plan Ignore Tax"
    description: "Yes/No Flag indicating if the tax is omitted from the price when the price equals the copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_IGNORE_TAX_FLAG = 'Y' ;;
  }

  dimension: patient_plan_card_help {
    label: "Patient Plan Card Help"
    description: "Help information for card record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_CARD_HELP ;;
  }

  dimension: patient_plan_plan_select_help {
    label: "Patient Plan Plan Select Help"
    description: "Help information specific to a plan record. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLAN_SELECT_HELP ;;
  }

  dimension: patient_plan_require_prescriber_dea_number_flag {
    label: "Patient Plan Require Prescriber DEA Number Flag"
    description: "Flag indicating if the doctor's DEA number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_DEA_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_state_id_flag {
    label: "Patient Plan Require Prescriber State ID Flag"
    description: "Flag indicating if the doctor's state ID number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_STATE_ID_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_tp_number_flag {
    label: "Patient Plan Require Prescriber TP Number Flag"
    description: "Flag indicating if the doctor's third party number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_TP_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_ptp_number_flag {
    label: "Patient Plan Require Prescriber PTP Number Flag"
    description: "Flag indicating if the doctor's third party number from the doctor third party record is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_PTP_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prescriber_alternate_number_flag {
    label: "Patient Plan Require Prescriber Alternate Number Flag"
    description: "Flag indicating if the doctor's alternate third party number is required when filling prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_ALTERNATE_NUMBER_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_require_prior_auth_type_flag {
    label: "Patient Plan Require Prior Auth Type Flag"
    description: "Flag determining if a prior authorization type is  required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PRIOR_AUTH_TYPE_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_batch_claim_format {
    label: "Patient Plan Batch Claim Format"
    description: "This is the batch or paper claim form to use. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_BATCH_CLAIM_FORMAT ;;
  }

  dimension: patient_plan_display_extra_info_page_flag {
    label: "Patient Plan Display Extra Info Page Flag"
    description: "Forces the Third Party info page to be displayed during Data Entry. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'Y' THEN 'ALWAYS DISPLAY'
              WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'S' THEN 'DISPLAY WITH CLAIM'
              WHEN ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG = 'N' THEN 'DISPLAY NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_DISPLAY_EXTRA_INFO_PAGE_FLAG
         END ;;
    suggestions: ["ALWAYS DISPLAY", "DISPLAY WITH CLAIM", "DISPLAY NOT REQUIRED"]
  }

  dimension: patient_plan_prescriber_paper_id_type {
    label: "Patient Plan Prescriber Paper ID Type"
    description: "Prescriber ID to use for paper/batch billing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '1' THEN 'DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '2' THEN 'STATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '3' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '4' THEN 'TP ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '5' THEN 'ALT ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '6' THEN 'NAME AND DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '7' THEN 'NAME AND STATE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '8' THEN 'NAME AND TP ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = '9' THEN 'NAME AND ALT ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'A' THEN 'DOC TP FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'B' THEN 'NAME AND DOC TP FILE ID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'C' THEN 'DEA LESS FIRST 2 CHAR'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'D' THEN 'TP ID OR DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'E' THEN 'HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'F' THEN 'NAME AND HIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'G' THEN 'HCID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'H' THEN 'NAME AND HCID'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'I' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'J' THEN 'NAME AND UPIN'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'K' THEN '1ST 9 OF DEA NUMBER'
              WHEN ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE = 'L' THEN 'NPI'
              ELSE ${TABLE}.STORE_PLAN_PRESCRIBER_PAPER_ID_TYPE
         END ;;
    suggestions: [
      "DEA NUMBER",
      "STATE ID",
      "NAME",
      "TP ID",
      "ALT ID",
      "NAME AND DEA NUMBER",
      "NAME AND STATE ID",
      "NAME AND TP ID",
      "NAME AND ALT ID",
      "DOC TP FILE ID",
      "NAME AND DOC TP FILE ID",
      "DEA LESS FIRST 2 CHAR",
      "TP ID OR DEA NUMBER",
      "HIN",
      "NAME AND HIN",
      "HCID_ID",
      "NAME AND HCID_ID",
      "UPIN",
      "NAME AND UPIN",
      "1ST 9 OF DEA NUMBER",
      "NPI",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_drug_id_type {
    label: "Patient Plan Drug ID Type"
    description: "Determines which Drug Identifier will be transmitted to this Third Party. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_DRUG_ID_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_DRUG_ID_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '1' THEN 'NDC'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '2' THEN 'NAME'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '3' THEN 'NDC AND NAME'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '4' THEN 'T/P CODE'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '5' THEN 'T/P CODE OR NDC'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '6' THEN 'T/P CODE OR NDC (DASHES)'
              WHEN ${TABLE}.STORE_PLAN_DRUG_ID_TYPE = '7' THEN 'T/P CODE OR NDC (SPACES)'
              ELSE TO_CHAR(${TABLE}.STORE_PLAN_DRUG_ID_TYPE)
         END ;;
    suggestions: [
      "NDC",
      "NAME",
      "NDC AND NAME",
      "T/P CODE",
      "T/P CODE OR NDC",
      "T/P CODE OR NDC (DASHES)",
      "T/P CODE OR NDC (SPACES)",
      "NOT SPECIFIED"
    ]
  }

  dimension: patient_plan_pharmacist_name {
    label: "Patient Plan Pharmacist Name"
    description: "Represents how to submit the pharmacist signature to submit on batch & paper claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PHARMACIST_NAME ;;
  }

  dimension: patient_plan_reversal_days {
    label: "Patient Plan Reversal Days"
    description: "Represents the number of days after submission of the claim in which to reverse the claim on-line. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_REVERSAL_DAYS ;;
  }

  dimension_group: patient_plan_last_host_update {
    label: "Patient Plan Last Host Update"
    description: "Date that this record was last updated on host. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_HOST_UPDATE_DATE ;;
  }

  dimension_group: patient_plan_last_nhin_update {
    label: "Patient Plan Last NHIN Update"
    description: "Date this record was last updated by NHIN. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_NHIN_UPDATE_DATE ;;
  }

  dimension_group: patient_plan_last_used {
    label: "Patient Plan Last Used"
    description: "Date this Plan record was last used. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_LAST_USED_DATE ;;
  }

  dimension: patient_plan_allow_reference_pricing_flag {
    label: "Patient Plan Allow Reference Pricing"
    description: "Yes/No Flag indicating whether to Allow Reference Prcing. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_REFERENCE_PRICING_FLAG = 'Y' ;;
  }

  dimension: patient_plan_pad_icd9_code {
    label: "Patient Plan Pad ICD9 Code"
    description: "Yes/No Flag indicating if system pads the ICD-9 with zeros when submitting an NCPDP claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PAD_ICD9_CODE = 'Y' ;;
  }

  dimension: patient_plan_check_eligibility_flag {
    label: "Patient Plan Check Eligibility"
    description: "Yes/No Flag indicating if eligibility request sent prior to normal claim billing request. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CHECK_ELIGIBILITY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_allow_partial_fill_flag {
    label: "Patient Plan Allow Partial Fill"
    description: "Yes/No Flag indicating if Plan allows NCPDP Partial Fills. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_PARTIAL_FILL_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_rx_origin_flag {
    label: "Patient Plan Require Rx Origin Flag"
    description: "Flag that determines if plan requires this field for NCPDP claims. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG IS NULL THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'Y' THEN 'REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'W' THEN 'WARN ORIGIN NOT SENT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_RX_ORIGIN_FLAG
         END ;;
    suggestions: ["NOT REQUIRED", "REQUIRED", "WARN ORIGIN NOT SENT", "NOT REQUIRED"]
  }

  dimension_group: patient_plan_do_not_submit_until {
    label: "Patient Plan Do Not Submit Until"
    description: "Date that contracts should be in place for this plan, for this store. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_DO_NOT_SUBMIT_UNTIL ;;
  }

  dimension: patient_plan_disallow_autofill_flag {
    label: "Patient Plan Disallow Autofill"
    description: "Yes/No Flag indicating whether system is allowed to automatically refill prescriptions under this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_AUTOFILL_FLAG = 'Y' ;;
  }

  dimension: patient_plan_mail_required_flag {
    label: "Patient Plan Mail Required"
    description: "Yes/No Flag indicating if Mail order required. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_MAIL_REQUIRED_FLAG = 'Y' ;;
  }

  dimension: patient_plan_state {
    label: "Patient Plan State"
    description: "Claim Plan State. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_STATE ;;
  }

  dimension: patient_plan_alternate_state {
    label: "Patient Plan Alternate State"
    description: "Plan Alternate State. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_ALTERNATE_STATE ;;
  }

  dimension: patient_plan_mail_days_supply {
    label: "Patient Plan Mail Days Supply"
    description: "Prescription refill quantity expressed in days supply to be delivered by mail order. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MAIL_DAYS_SUPPLY ;;
  }

  dimension: patient_plan_block_other_coverage_code_flag {
    label: "Patient Plan Block Other Coverage Code Flag"
    description: "Yes/No Flag indicating whether to Block Other Coverage Code from auto populating. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_BLOCK_OTHER_COVERAGE_CODE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_host_transmit_flag {
    label: "Patient Plan Host Transmit"
    description: "Yes/No Flag indicating if the plan is to be submitted to Host. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_HOST_TRANSMIT_FLAG = 'Y' ;;
  }

  dimension: patient_plan_no_otc_daw_flag {
    label: "Patient Plan No OTC DAW"
    description: "Yes/No Flag indicating whether to Exclude OTC Products from DAW checking. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_NO_OTC_DAW_FLAG = 'Y' ;;
  }

  dimension: patient_plan_adjudicate_flag {
    label: "Patient Plan Adjudicate"
    description: "Yes/No Flag indicating if This is for CANADA only. Determines if this plan will be transmitted. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ADJUDICATE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_disallow_workers_comp_flag {
    label: "Patient Plan Disallow Workers Comp"
    description: "Yes/No Flag indicating if plan disallows a Workers Comp record from being added to any TP_LINK that is linked to this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_WORKERS_COMP_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_split_intervention_flag {
    label: "Patient Plan Require Split Intervention"
    description: "Yes/No Flag indicating if the system needs to prompt the user for review/input before submitting to a secondary/tertiary plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_REQUIRE_SPLIT_INTERVENTION_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_patient_location_flag {
    label: "Patient Plan Require Patient Location Flag"
    description: "This is a plan edit that governs whether or not the plan requires Patient Location to be set on a Patient Tp Link. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'Y' THEN 'REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'N' THEN 'NOT REQUIRED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG = 'W' THEN 'WARNING - ALLOW FILL'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_LOCATION_FLAG
         END ;;
    suggestions: ["REQUIRED", "NOT REQUIRED", "WARNING - ALLOW FILL"]
  }

  dimension: patient_plan_use_submit_amount_split_bill_flag {
    label: "Patient Plan use Submit Amount Split Bill Flag"
    description: "Flag that determines the value sent in split claims for fields 409-D9 (Ingredient Cost Submitted) and 430-DV (Gross Amount Due). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG = 'Y' THEN 'SEND SUBMITTED COST'
              WHEN ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG = 'N' THEN 'CALCULATED'
              ELSE ${TABLE}.STORE_PLAN_USE_SUBMIT_AMOUNT_SPLIT_BILL_FLAG
         END ;;
    suggestions: ["NOT SPECIFIED", "SEND SUBMITTED COST", "CALCULATED"]
  }

  dimension: patient_plan_send_deductible_copay_flag {
    label: "Patient Plan Send Deductible Copay"
    description: "Yes/No Flag indicating the ability to send the Amount Attributed to Deductible and Amount of Copay in the HC and DV fields if these amounts are returned by the primary payer. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_DEDUCTIBLE_COPAY_FLAG = 'Y' ;;
  }

  dimension: patient_plan_previous_pharmacy_provider_id_qualifier {
    label: "Patient Plan Previous Pharmacy Provider ID Qualifier"
    description: "Flag that determines which pharmacy provider ID to send for reversals. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '01' THEN 'NATIONAL PROVIDER ID (NPI)'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '02' THEN 'BLUE CROSS'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '03' THEN 'BLUE SHIELD'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '04' THEN 'MEDICARE'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '05' THEN 'MEDICAID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '06' THEN 'UPIN'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '07' THEN 'NCPDP PROVIDER ID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '08' THEN 'STATE LICENSE'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '09' THEN 'CHAMPUS'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '10' THEN 'HEALTH INDUSTRY NUMBER (HIN)'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '11' THEN 'FEDERAL TAX ID'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '12' THEN 'DEA'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '13' THEN 'STATE ISSUED'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '14' THEN 'PLAN SPECIFIC'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '81' THEN 'SASK MEDICAL PRACT'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '82' THEN 'SASK PHARMACIST'
              WHEN ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER = '83' THEN 'SASK HEALTH MED SRV'
              ELSE ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_QUALIFIER
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NATIONAL PROVIDER ID (NPI)",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "NCPDP PROVIDER ID",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER (HIN)",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "OTHER",
      "SASK MEDICAL PRACT",
      "SASK PHARMACIST",
      "SASK HEALTH MED SRV"
    ]
  }

  dimension_group: patient_plan_previous_pharmacy_provider_id {
    label: "Patient Plan Previous Pharmacy Provider Identifier"
    description: "Date used to determine if the system will send the previous pharmacy provider id. EPS Table Name: PLAN, PDX Table Name: PLAN"
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
    sql: ${TABLE}.STORE_PLAN_PREVIOUS_PHARMACY_PROVIDER_ID_DATE ;;
  }

  dimension: patient_plan_require_form_serial_number_flag {
    label: "Patient Plan Require Form Serial Number Flag"
    description: "Flag that determines if the plan requires the prescription serial number to be entered for all prescriptions. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'Y' THEN 'HARD HALT  NEW ONLY'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'W' THEN 'WARNING   ALL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'A' THEN 'HARD HALT ALL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG = 'N' THEN 'USE DISPENSING RULES'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_FORM_SERIAL_NUMBER_FLAG
         END ;;
    suggestions: ["NOT SPECIFIED", "HARD HALT  NEW ONLY", "WARNING   ALL", "HARD HALT ALL", "USE DISPENSING RULES"]
  }

  dimension: patient_plan_disallow_faxed_rx_requests_flag {
    label: "Patient Plan Disallow Faxed Rx Requests"
    description: "Yes/No Flag indicating if the plan does not allow faxed Rx requests. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_FAXED_RX_REQUESTS_FLAG = 'Y' ;;
  }

  dimension: patient_plan_minimum_patient_age {
    label: "Patient Plan Minimum Patient Age"
    description: "Minimum age of the patient allowed by the plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE ;;
  }

  dimension: patient_plan_minimum_patient_age_halt_type {
    label: "Patient Plan Minimum Patient Age Halt Type"
    description: "Flag indicating the action that should occur when a patient age is below the minium age required by the plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE IS NULL THEN 'NO EDIT DISPLAYED'
              WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE = 'W' THEN 'DISPLAYS EDIT MESSAGE'
              WHEN ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE = 'Y' THEN 'NO EDIT DISPLAYED'
              ELSE ${TABLE}.STORE_PLAN_MINIMUM_PATIENT_AGE_HALT_TYPE
         END ;;
    suggestions: ["NO EDIT DISPLAYED", "DISPLAYS EDIT MESSAGE", "NO EDIT DISPLAYED"]
  }

  dimension: patient_plan_disallow_subsequent_billing_flag {
    label: "Patient Plan Disallow Subsequent Billing"
    description: "Yes/No Flag indicating if the billing flag will prevent other plans from being billed once this plan is used in a billing sequence. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_SUBSEQUENT_BILLING_FLAG = 'Y' ;;
  }

  dimension: patient_plan_check_other_coverage_codes_flag {
    label: "Patient Plan Check Other Coverage Codes"
    description: "Yes/No Flag indicating if other alternate other coverage codes exist and the application will check to see if it should send an alternated code. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_CHECK_OTHER_COVERAGE_CODES_FLAG = 'Y' ;;
  }

  dimension: patient_plan_days_from_written_schedule_3_5 {
    label: "Patient Plan Days From Written Schedule 3-5"
    description: "This field is used to define the number of days the Rx written by a prescriber is valid for a prescription of schedule 3-5. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DAYS_FROM_WRITTEN_SCHEDULE_3_5 ;;
  }

  dimension: patient_plan_days_from_written_non_schedule {
    label: "Patient Plan Days From Written Non Schedule"
    description: "This field is used to define the number of days the Rx written by a prescriber is valid for a prescription with a legend or OTC drug. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_DAYS_FROM_WRITTEN_NON_SCHEDULE ;;
  }

  dimension: patient_plan_require_pickup_relation_flag {
    label: "Patient Plan Require Pickup Relation Flag"
    description: "Plan flag that indicates if the plan requires what the relationship of the patient is to the person picking up the Rx. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(to_char(${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG') ;;
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'Y' THEN 'REQUIRED - HARD HALT - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'W' THEN 'REQUIRED - WARNING - ALLOW FILL'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG = 'N' THEN 'NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PICKUP_RELATION_FLAG
         END ;;
    suggestions: ["REQUIRED - HARD HALT - ALLOW FILL", "REQUIRED - WARNING - ALLOW FILL", "NOT REQUIRED"]
  }

  dimension: patient_plan_prescriber_transmit_alt_id_qualifier {
    label: "Patient Plan Prescriber Transmit Alt ID Qualifier"
    description: "Alternate prescriber ID qualifier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PRESCRIBER_TRANSMIT_ALT_ID_QUALIFIER ;;
  }

  dimension: patient_plan_assignment_not_accepted_flag {
    label: "Patient Plan Assignment Not Accepted"
    description: "Yes/No Flag indicating whether the provider accepts assignment. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ASSIGNMENT_NOT_ACCEPTED_FLAG = 'Y' ;;
  }

  dimension: patient_plan_allow_assignment_choice_flag {
    label: "Patient Plan Allow Assignment Choice"
    description: "Yes/No Flag indicating if the plan allows the patient to choose whether to assign benefits to the provider. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_ALLOW_ASSIGNMENT_CHOICE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_send_both_cob_amounts_flag {
    label: "Patient Plan Send Both COB Amounts"
    description: "Yes/No Flag indicating if the plan requires both the Other Payer Amount Paid and Other Payer Patient Responsibility loops in the COB/Other Payments segment of a split-billed claim. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_BOTH_COB_AMOUNTS_FLAG = 'Y' ;;
  }

  dimension: patient_plan_place_of_service {
    label: "Patient Plan Place Of Service"
    description: "Stores the place where a drug or service is dispensed or administered. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PLACE_OF_SERVICE ;;
  }

  dimension: patient_plan_residence {
    label: "Patient Plan Residence"
    description: "Stores the code identifying the patient’s place of residence (KP EPS only). EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '1' THEN 'HOME'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '3' THEN 'NURSING FACILITY'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '4' THEN 'ASSISTED LIVING FACILITY'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '6' THEN 'GROUP HOME'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '9' THEN 'INTERMEDIATE CARE FACILITY/MENTALLY RETARDED'
              WHEN ${TABLE}.STORE_PLAN_RESIDENCE = '11' THEN 'HOSPICE'
              ELSE ${TABLE}.STORE_PLAN_RESIDENCE
         END ;;
    suggestions: ["NOT SPECIFIED", "HOME", "NURSING FACILITY", "ASSISTED LIVING FACILITY", "GROUP HOME", "INTERMEDIATE CARE FACILITY/MENTALLY RETARDED", "HOSPICE"]
  }

  dimension: patient_plan_send_only_patient_pay_amount_flag {
    label: "Patient Plan Send Only Patient Pay Amount"
    description: "Yes/No Flag indicating if the plan requires only the Patient Pay Amount (505-F5) as reported by previous payer to be sent in  the Other Payer Patient Responsibility loop in the COB segement. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_SEND_ONLY_PATIENT_PAY_AMOUNT_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_prescriber_npi_number {
    label: "Patient Plan Require Prescriber NPI Number"
    description: "Yes/No Flagindicating if the third party plan requires the doctor’s NPI number. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_REQUIRE_PRESCRIBER_NPI_NUMBER = 'Y' ;;
  }

  dimension: patient_plan_pharmacy_service_type {
    label: "Patient Plan Pharmacy Service Type"
    description: "Stores the NCPDP pharmacy service type code (147-U7 Pharmacy Service Type field) that indicates the type of service being performed by the pharmacy. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_PHARMACY_SERVICE_TYPE ;;
  }

  dimension: patient_plan_disallow_direct_marketing_flag {
    label: "Patient Plan Disallow Direct Marketing"
    description: "Yes/No Flag indicating if this insurance plan allows or disallows direct marketing to a patient covered by this plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_DISALLOW_DIRECT_MARKETING_FLAG = 'Y' ;;
  }

  dimension: patient_plan_require_patient_residence_flag {
    label: "Patient Plan Require Patient Residence"
    description: "Flag indicating if the plan requires a residence type for the patient. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'Y' THEN 'REQUIRE PATIENT RESIDENCE HARD HALT'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'W' THEN 'REQUIRE PATIENT RESIDENCE WARNING'
              WHEN ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG = 'N' THEN 'PATIENT RESIDENCE NOT REQUIRED'
              ELSE ${TABLE}.STORE_PLAN_REQUIRE_PATIENT_RESIDENCE_FLAG
         END ;;
    suggestions: ["REQUIRE PATIENT RESIDENCE HARD HALT", "REQUIRE PATIENT RESIDENCE WARNING", "PATIENT RESIDENCE NOT REQUIRED"]
  }

  dimension: patient_plan_pickup_signature_not_required_flag {
    label: "Patient Plan Pickup Signature Not Required"
    description: "Yes/No Flag that marks the transaction as 'Y' Yes, it needs, or 'N', No it does not need a pickup signature due to the plan setting at the time it was sold. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_PICKUP_SIGNATURE_NOT_REQUIRED_FLAG = 'Y' ;;
  }

  dimension: patient_plan_no_incentives {
    label: "Patient Plan No Incentives"
    description: "Indicates if there are incentives. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_NO_INCENTIVES ;;
  }

  dimension: patient_plan_use_price_code_and_plan_fees_flag {
    label: "Patient Plan use Price Code and Plan Fees"
    description: "Yes/No Flag indicating if the fees and markups from both the Price Code and the Plan should be used when calculating the price. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_USE_PRICE_CODE_AND_PLAN_FEES_FLAG = 'Y' ;;
  }

  dimension: patient_plan_use_drug_price_code_flag {
    label: "Patient Plan use Drug Price Code"
    description: "Yes/No Flag indicating if pricing should use the Price Code on the drug record when pricing a prescription using this plan. If there is no Price Code on the drug record, then the current pricing logic in Third Party Pricing is applied to find the Price Code to be used. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: yesno
    sql: ${TABLE}.STORE_PLAN_USE_DRUG_PRICE_CODE_FLAG = 'Y' ;;
  }

  dimension: patient_plan_discount_plan {
    label: "Patient Plan Discount Plan"
    description: "Discount Plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_DISCOUNT_PLAN ;;
  }

  dimension: patient_plan_group_validation {
    label: "Patient Plan Group Validation"
    description: "Group Validation. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_GROUP_VALIDATION ;;
  }

  dimension: patient_plan_coupon_plan {
    label: "Patient Plan Coupon Plan"
    description: "Coupon Plan. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_COUPON_PLAN ;;
  }

  #[ERXLPS-1618]
  dimension: patient_plan_phone_number {
    label: "Patient Plan Phone Number"
    description: "Patient Plan Phone Number. Three digit area code, and seven digit phone number respectively. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: string
    sql: ${eps_plan_phone.phone_number} ;;
  }
  #################################################################### Duplicate set of measures with label name of Patient Plan ####################################
  measure: sum_patient_plan_maximum_quantity {
    label: "Patient Plan Maximum Quantity"
    description: "Maximum quantity that can be dispensed for one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_max_quantity_maintenance {
    label: "Patient Plan Max Quantity Maintenance"
    description: "Maximum days supply allowed for one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_QUANTITY_MAINTENANCE ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_maximum_ml_quantity {
    label: "Patient Plan Maximum ML Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_maximum_ml_maintenance_quantity {
    label: "Patient Plan Maximum ML Maintenance Quantity"
    description: "Maximum number of milliliters allowed to be dispensed on one fill of a liquid maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_ML_MAINTENANCE_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_maximum_gram_quantity {
    label: "Patient Plan Maximum Gram Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a non-maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_maximum_gram_maintenance_quantity {
    label: "Patient Plan Maximum Gram Maintenance Quantity"
    description: "Maximum number of grams allowed to be dispensed on one fill of a maintenance prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAXIMUM_GRAM_MAINTENANCE_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_patient_plan_max_dollar_dependecy {
    label: "Patient Plan Max Dollar Dependecy"
    description: "Maximum dollar amount allowed per patient during a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_DEPENDECY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_max_dollar_rx {
    label: "Patient Plan Max Dollar Rx"
    description: "Maximum dollar amount allowed on a single fill of a prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_RX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_max_dollar_card {
    label: "Patient Plan Max Dollar Card"
    description: "Maximum dollar amount allowed by a card record for a set time period. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_DOLLAR_CARD ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_bubble {
    label: "Patient Plan Bubble"
    description: "Unit dose fee amount. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_BUBBLE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_compound_rate {
    label: "Patient Plan Compound Rate"
    description: "Per minute rate fee added to a compound prescription. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_COMPOUND_RATE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_difference_amount {
    label: "Patient Plan Difference Amount"
    description: "Difference amount percentage added to copay. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_DIFFERENCE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_copay_dollar_limit {
    label: "Patient Plan Copay Dollar Limit"
    description: "Total copay amount allowed to be charged to a cardholder. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_COPAY_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_plan_max_reimburse {
    label: "Patient Plan Max Reimburse"
    description: "Maximum amount reimbursed by carrier. EPS Table Name: PLAN, PDX Table Name: PLAN"
    type: sum
    sql: ${TABLE}.STORE_PLAN_MAX_REIMBURSE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################## End measures and templated filters ##################################################################

  set: explore_sales_candidate_list {
    fields: [store_plan_carrier_code, store_plan_plan, store_plan_plan_name, store_plan_plan_type, store_plan_state] #[ERXLPS-1618]
  }

  set: explore_sales_primary_payer_candidate_list {
    fields: [store_plan_carrier_code_primary, store_plan_plan_primary, store_plan_plan_name_primary, store_plan_state_primary, store_plan_phone_number_primary] #[ERXLPS-1618]
  }

  set: explore_sales_secondary_payer_candidate_list {
    fields: [store_plan_carrier_code_secondary, store_plan_plan_secondary, store_plan_plan_name_secondary, store_plan_state_secondary, store_plan_phone_number_secondary] #[ERXLPS-1618]
  }

  #[ERXLPS-1438]
  set: explore_sales_patient_plan_candidate_list {
    fields: [patient_plan_carrier_code, patient_plan_plan_name]
  }

  # Bi Demo Sales Candidate list
  set: bi_demo_explore_sales_candidate_list {
    fields: [store_plan_carrier_code, store_plan_plan, bi_demo_store_plan_plan_name, store_plan_plan_type, store_plan_state] #[ERXLPS-1618]
  }

  set: bi_demo_explore_sales_primary_payer_candidate_list {
    fields: [store_plan_carrier_code_primary, store_plan_plan_primary, bi_demo_store_plan_plan_name_primary, store_plan_state_primary, store_plan_phone_number_primary] #[ERXLPS-1618]
  }

  set: bi_demo_explore_sales_secondary_payer_candidate_list {
    fields: [store_plan_carrier_code_secondary, store_plan_plan_secondary, bi_demo_store_plan_plan_name_secondary, store_plan_state_secondary, store_plan_phone_number_secondary] #[ERXLPS-1618]
  }

  #[ERXLPS-1438]
  set: bi_demo_explore_sales_patient_plan_candidate_list {
    fields: [patient_plan_carrier_code, bi_demo_patient_plan_plan_name]
  }

  #[ERXLPS-2383] - Set for patient plan list
  set: explore_patient_plan_candidate_list {
    fields: [
      patient_plan_carrier_code,
      patient_plan_plan,
      #patient_plan_group_code, #[ERXLPS-6270]
      patient_plan_plan_name,
      patient_plan_eligible_flag,
      patient_plan_tp_error_override_flag,
      patient_plan_price_override_flag,
      patient_plan_format_card,
      patient_plan_check_card_flag,
      patient_plan_format_group,
      patient_plan_check_group_flag,
      patient_plan_require_group_flag,
      patient_plan_gender_flag,
      patient_plan_require_birth_flag,
      patient_plan_require_address_flag,
      patient_plan_injury_flag,
      patient_plan_plan_type,
      patient_plan_require_patient_relationship_flag,
      patient_plan_no_dependent_flag,
      patient_plan_age_halt_flag,
      patient_plan_depend_age,
      patient_plan_student_age,
      patient_plan_adc_age,
      patient_plan_require_coverage_code,
      patient_plan_require_card_begin_date_flag,
      patient_plan_require_card_end_date_flag,
      patient_plan_desi3_flag,
      patient_plan_desi4_flag,
      patient_plan_desi5_flag,
      patient_plan_restrict_otc_flag,
      patient_plan_injectable_flag,
      patient_plan_drug_tp_date_flag,
      patient_plan_therapeutic_maintenance_flag,
      patient_plan_therapeutic_mac_flag,
      patient_plan_require_drug_tp_flag,
      patient_plan_host_drug_tp_flag,
      patient_plan_ignore_default_drug_tp_flag,
      patient_plan_drug_tp_code,
      patient_plan_require_vendor_tp_flag,
      patient_plan_require_prescriber_phone_flag,
      patient_plan_require_prescriber_tp_flag,
      patient_plan_refill_halt_type,
      patient_plan_both_refill_edits_flag,
      patient_plan_set_expire_flag,
      patient_plan_set_max_flag,
      patient_plan_refill_days_limit,
      patient_plan_maximum_number_refills,
      patient_plan_schedule_number_refill,
      patient_plan_number_days,
      patient_plan_percent_days,
      patient_plan_disallow_quantity_changes_flag,
      patient_plan_quantity_halt_type,
      patient_plan_pass_both_regular_limits_flag,
      patient_plan_pass_both_maintenance_limits_flag,
      patient_plan_quantity_limit_type,
      patient_plan_maximum_days_supply,
      patient_plan_minimum_days_supply,
      patient_plan_max_maintenance_days_supply,
      patient_plan_minimum_maintenance_days_supply,
      patient_plan_maximum_ml_packs,
      patient_plan_maximum_single_packs,
      patient_plan_maximum_gram_packs,
      patient_plan_initial_fill_max_days,
      patient_plan_round_up_flag,
      patient_plan_max_halt_code,
      patient_plan_number_override_flag,
      patient_plan_number_rx_dependecy,
      patient_plan_require_generic_flag,
      patient_plan_require_daw_flag,
      patient_plan_require_prior_auth_number_flag,
      patient_plan_low_cost_flag,
      patient_plan_use_discount_flag,
      patient_plan_cost_percent,
      patient_plan_maximum_allowable_cost_flag,
      patient_plan_ignore_mac_flag,
      patient_plan_generic_fee_calculation_type,
      patient_plan_taxable_flag,
      patient_plan_transmit_excludes_tax_flag,
      patient_plan_compare_uc_flag,
      patient_plan_uc_price_flag,
      patient_plan_base_sig_dose_flag,
      patient_plan_add_compound_flag,
      patient_plan_copay_basis,
      patient_plan_total_dependable_flag,
      patient_plan_how_max_flag,
      patient_plan_copay_flag,
      patient_plan_split_copay_flag,
      patient_plan_price_compare_flag,
      patient_plan_copay_uc_compare_flag,
      patient_plan_cash_bill_flag,
      patient_plan_adc_first_flag,
      patient_plan_otc_accumulator_flag,
      patient_plan_disable_cardholder_copay_flag,
      patient_plan_disable_drug_tp_copay_flag,
      patient_plan_disable_therapuetic_restriction_copay_flag,
      patient_plan_sig_on_file_flag,
      patient_plan_pharmacy_transmit_id_type,
      patient_plan_print_dependent_number_flag,
      patient_plan_total_by_flag,
      patient_plan_sort_by_flag,
      patient_plan_split_flag,
      patient_plan_nhin_process_code,
      patient_plan_transfer_to_account_flag,
      patient_plan_print_balance_flag,
      patient_plan_number_rebill,
      patient_plan_basis,
      patient_plan_allow_change_price_flag,
      patient_plan_transmit_31_flag,
      patient_plan_service_flag,
      patient_plan_no_paper_flag,
      patient_plan_compound_paper_flag,
      patient_plan_card_layout_help_1,
      patient_plan_card_layout_help_2,
      patient_plan_card_layout_help_3,
      patient_plan_card_layout_help_4,
      patient_plan_card_layout_help_5,
      patient_plan_card_layout_help_6,
      patient_plan_plan_text,
      patient_plan_contact,
      patient_plan_begin_coverage,
      patient_plan_begin_coverage_time,
      patient_plan_begin_coverage_date,
      patient_plan_begin_coverage_week,
      patient_plan_begin_coverage_month,
      patient_plan_begin_coverage_month_num,
      patient_plan_begin_coverage_year,
      patient_plan_begin_coverage_quarter,
      patient_plan_begin_coverage_quarter_of_year,
      patient_plan_begin_coverage_hour_of_day,
      patient_plan_begin_coverage_time_of_day,
      patient_plan_begin_coverage_hour2,
      patient_plan_begin_coverage_minute15,
      patient_plan_begin_coverage_day_of_week,
      patient_plan_begin_coverage_week_of_year,
      patient_plan_begin_coverage_day_of_week_index,
      patient_plan_begin_coverage_day_of_month,
      patient_plan_end_coverage,
      patient_plan_end_coverage_time,
      patient_plan_end_coverage_date,
      patient_plan_end_coverage_week,
      patient_plan_end_coverage_month,
      patient_plan_end_coverage_month_num,
      patient_plan_end_coverage_year,
      patient_plan_end_coverage_quarter,
      patient_plan_end_coverage_quarter_of_year,
      patient_plan_end_coverage_hour_of_day,
      patient_plan_end_coverage_time_of_day,
      patient_plan_end_coverage_hour2,
      patient_plan_end_coverage_minute15,
      patient_plan_end_coverage_day_of_week,
      patient_plan_end_coverage_week_of_year,
      patient_plan_end_coverage_day_of_week_index,
      patient_plan_end_coverage_day_of_month,
      patient_plan_require_patient_tp_begin_date_flag,
      patient_plan_require_patient_tp_end_date_flag,
      patient_plan_state_formulary_last,
      patient_plan_no_compound_daw_flag,
      patient_plan_pharmacy_provider_id_qualifier,
      patient_plan_pharmacist_id_qualifier,
      patient_plan_prescriber_transmit_id_qualifier,
      patient_plan_non_complete_flag,
      patient_plan_low_based_acquisition_flag,
      patient_plan_prescriber_paper_alt_id_type,
      patient_plan_default_prescriber_id_qualifier,
      patient_plan_auto_denial_flag,
      patient_plan_require_dependent_number_halt_type,
      patient_plan_require_dependent_number_flag,
      patient_plan_ignore_tax_flag,
      patient_plan_card_help,
      patient_plan_plan_select_help,
      patient_plan_require_prescriber_dea_number_flag,
      patient_plan_require_prescriber_state_id_flag,
      patient_plan_require_prescriber_tp_number_flag,
      patient_plan_require_prescriber_ptp_number_flag,
      patient_plan_require_prescriber_alternate_number_flag,
      patient_plan_require_prior_auth_type_flag,
      patient_plan_batch_claim_format,
      patient_plan_display_extra_info_page_flag,
      patient_plan_prescriber_paper_id_type,
      patient_plan_drug_id_type,
      patient_plan_pharmacist_name,
      patient_plan_reversal_days,
      patient_plan_last_host_update,
      patient_plan_last_host_update_time,
      patient_plan_last_host_update_date,
      patient_plan_last_host_update_week,
      patient_plan_last_host_update_month,
      patient_plan_last_host_update_month_num,
      patient_plan_last_host_update_year,
      patient_plan_last_host_update_quarter,
      patient_plan_last_host_update_quarter_of_year,
      patient_plan_last_host_update_hour_of_day,
      patient_plan_last_host_update_time_of_day,
      patient_plan_last_host_update_hour2,
      patient_plan_last_host_update_minute15,
      patient_plan_last_host_update_day_of_week,
      patient_plan_last_host_update_week_of_year,
      patient_plan_last_host_update_day_of_week_index,
      patient_plan_last_host_update_day_of_month,
      patient_plan_last_nhin_update,
      patient_plan_last_nhin_update_time,
      patient_plan_last_nhin_update_date,
      patient_plan_last_nhin_update_week,
      patient_plan_last_nhin_update_month,
      patient_plan_last_nhin_update_month_num,
      patient_plan_last_nhin_update_year,
      patient_plan_last_nhin_update_quarter,
      patient_plan_last_nhin_update_quarter_of_year,
      patient_plan_last_nhin_update_hour_of_day,
      patient_plan_last_nhin_update_time_of_day,
      patient_plan_last_nhin_update_hour2,
      patient_plan_last_nhin_update_minute15,
      patient_plan_last_nhin_update_day_of_week,
      patient_plan_last_nhin_update_week_of_year,
      patient_plan_last_nhin_update_day_of_week_index,
      patient_plan_last_nhin_update_day_of_month,
      patient_plan_last_used,
      patient_plan_last_used_time,
      patient_plan_last_used_date,
      patient_plan_last_used_week,
      patient_plan_last_used_month,
      patient_plan_last_used_month_num,
      patient_plan_last_used_year,
      patient_plan_last_used_quarter,
      patient_plan_last_used_quarter_of_year,
      patient_plan_last_used_hour_of_day,
      patient_plan_last_used_time_of_day,
      patient_plan_last_used_hour2,
      patient_plan_last_used_minute15,
      patient_plan_last_used_day_of_week,
      patient_plan_last_used_week_of_year,
      patient_plan_last_used_day_of_week_index,
      patient_plan_last_used_day_of_month,
      patient_plan_allow_reference_pricing_flag,
      patient_plan_pad_icd9_code,
      patient_plan_check_eligibility_flag,
      patient_plan_allow_partial_fill_flag,
      patient_plan_require_rx_origin_flag,
      patient_plan_do_not_submit_until,
      patient_plan_do_not_submit_until_time,
      patient_plan_do_not_submit_until_date,
      patient_plan_do_not_submit_until_week,
      patient_plan_do_not_submit_until_month,
      patient_plan_do_not_submit_until_month_num,
      patient_plan_do_not_submit_until_year,
      patient_plan_do_not_submit_until_quarter,
      patient_plan_do_not_submit_until_quarter_of_year,
      patient_plan_do_not_submit_until_hour_of_day,
      patient_plan_do_not_submit_until_time_of_day,
      patient_plan_do_not_submit_until_hour2,
      patient_plan_do_not_submit_until_minute15,
      patient_plan_do_not_submit_until_day_of_week,
      patient_plan_do_not_submit_until_week_of_year,
      patient_plan_do_not_submit_until_day_of_week_index,
      patient_plan_do_not_submit_until_day_of_month,
      patient_plan_disallow_autofill_flag,
      patient_plan_mail_required_flag,
      patient_plan_state,
      patient_plan_alternate_state,
      patient_plan_mail_days_supply,
      patient_plan_block_other_coverage_code_flag,
      patient_plan_host_transmit_flag,
      patient_plan_no_otc_daw_flag,
      patient_plan_adjudicate_flag,
      patient_plan_disallow_workers_comp_flag,
      patient_plan_require_split_intervention_flag,
      patient_plan_require_patient_location_flag,
      patient_plan_use_submit_amount_split_bill_flag,
      patient_plan_send_deductible_copay_flag,
      patient_plan_previous_pharmacy_provider_id_qualifier,
      patient_plan_previous_pharmacy_provider_id,
      patient_plan_previous_pharmacy_provider_id_time,
      patient_plan_previous_pharmacy_provider_id_date,
      patient_plan_previous_pharmacy_provider_id_week,
      patient_plan_previous_pharmacy_provider_id_month,
      patient_plan_previous_pharmacy_provider_id_month_num,
      patient_plan_previous_pharmacy_provider_id_year,
      patient_plan_previous_pharmacy_provider_id_quarter,
      patient_plan_previous_pharmacy_provider_id_quarter_of_year,
      patient_plan_previous_pharmacy_provider_id_hour_of_day,
      patient_plan_previous_pharmacy_provider_id_time_of_day,
      patient_plan_previous_pharmacy_provider_id_hour2,
      patient_plan_previous_pharmacy_provider_id_minute15,
      patient_plan_previous_pharmacy_provider_id_day_of_week,
      patient_plan_previous_pharmacy_provider_id_week_of_year,
      patient_plan_previous_pharmacy_provider_id_day_of_week_index,
      patient_plan_previous_pharmacy_provider_id_day_of_month,
      patient_plan_require_form_serial_number_flag,
      patient_plan_disallow_faxed_rx_requests_flag,
      patient_plan_minimum_patient_age,
      patient_plan_minimum_patient_age_halt_type,
      patient_plan_disallow_subsequent_billing_flag,
      patient_plan_check_other_coverage_codes_flag,
      patient_plan_days_from_written_schedule_3_5,
      patient_plan_days_from_written_non_schedule,
      patient_plan_require_pickup_relation_flag,
      patient_plan_prescriber_transmit_alt_id_qualifier,
      patient_plan_assignment_not_accepted_flag,
      patient_plan_allow_assignment_choice_flag,
      patient_plan_send_both_cob_amounts_flag,
      patient_plan_place_of_service,
      patient_plan_residence,
      patient_plan_send_only_patient_pay_amount_flag,
      patient_plan_require_prescriber_npi_number,
      patient_plan_pharmacy_service_type,
      patient_plan_disallow_direct_marketing_flag,
      patient_plan_require_patient_residence_flag,
      patient_plan_pickup_signature_not_required_flag,
      patient_plan_no_incentives,
      patient_plan_use_price_code_and_plan_fees_flag,
      patient_plan_use_drug_price_code_flag,
      patient_plan_discount_plan,
      patient_plan_group_validation,
      patient_plan_coupon_plan,
      patient_plan_phone_number,
      sum_patient_plan_maximum_quantity,
      sum_patient_plan_max_quantity_maintenance,
      sum_patient_plan_maximum_ml_quantity,
      sum_patient_plan_maximum_ml_maintenance_quantity,
      sum_patient_plan_maximum_gram_quantity,
      sum_patient_plan_maximum_gram_maintenance_quantity,
      sum_patient_plan_max_dollar_dependecy,
      sum_patient_plan_max_dollar_rx,
      sum_patient_plan_max_dollar_card,
      sum_patient_plan_bubble,
      sum_patient_plan_compound_rate,
      sum_patient_plan_difference_amount,
      sum_patient_plan_copay_dollar_limit,
      sum_patient_plan_max_reimburse
    ]
  }
}

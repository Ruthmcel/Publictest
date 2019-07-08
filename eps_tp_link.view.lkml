view: eps_tp_link {
  label: "Third Party Link"
  sql_table_name: EDW.D_STORE_TP_LINK ;;

  dimension: primary_key {
    hidden: yes
    type: string #[ERXLPS2383] Corrected datatype
    description: "Unique Identification number. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tp_link_id} ||'@'|| ${source_system_id} ;; #ERXLPS-1649 #[ERXDWPS-1532]
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    type: number
    label: "Chain ID"
    hidden: yes
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Nhin Store ID"
    hidden: yes
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tp_link_id {
    type: string #[ERXDWPS-1532]
    label: "Third Party Link ID"
    hidden: yes
    description: "Unique ID number identifying a patient third party link record. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.TP_LINK_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: card_id {
    type: string #[ERXDWPS-1532]
    label: "Card ID"
    hidden: yes
    description: "Cardholder ID of the Cardholder record associated with a patient third party link record. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.CARD_ID ;;
  }

  dimension: employer_id {
    type: number
    label: "Employer Identifier"
    description: "Employer ID of the Employer record associated with a patient third party link record. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    hidden: yes
    sql: ${TABLE}.EMPLOYER_ID ;;
  }

  dimension: notes_id {
    type: number
    label: "Notes Identifier"
    description: "Notes ID of the Notes record associated with a patient third party link record. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    hidden: yes
    sql: ${TABLE}.NOTES_ID ;;
  }

  dimension: patient_id {
    type: string #[ERXDWPS-1532]
    label: "Patient Identifier"
    description: "Patient record. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################
  #[ERXLPS-1438] - Modified sql logic to show the table column value instead of master code table value. Master code has only 3 values but db has more levels to show.
  dimension: store_tp_link_level_no {
    type: number
    label: "Claim Card Level Number"
    description: "Third party billing priority for a patient’s third party link ‘Card’ record. This priority is associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql:  ${TABLE}.STORE_TP_LINK_LEVEL_NO ;;
    value_format: "0"
    #suggestions: ["PRIMARY", "SECONDARY", "TERTIARY"]
  }

  #[ERXLPS-1438] - Added new dimension billing sequence with case when logic.
  dimension: store_tp_link_billing_seq {
    type: string
    label: "Claim Card Billing Sequence"
    description: "Third party billing sequence, based on the ‘Claim Card Level Number’ dimension, that displays the level number as Primary, Secondary, Tertiary, or Others. This priority is associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 1 THEN 'PRIMARY'
              WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 2 THEN 'SECONDARY'
              WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 3 THEN 'TERTIARY'
              ELSE 'OTHER'
         END ;;
    suggestions: ["PRIMARY", "SECONDARY", "TERTIARY", "OTHER"]
  }

  dimension: store_tp_link_relation {
    type: string
    label: "Claim Card Dependent Relation"
    description: "Dependent Relationship code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_RELATION,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_RELATION') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_RELATION = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '1' THEN 'NOT SPECIFIED(US), CARDHOLDER (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '2' THEN 'CARDHOLDER/SELF(US), SPOUSE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '3' THEN 'SPOUSE(US), CHILD UNDERAGE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '4' THEN 'CHILD(US), CHILD OVERAGE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '5' THEN 'OTHER(US), DISABLED DEPENDENT (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '9' THEN 'DEPENDENT STUDENT (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION IS NULL THEN 'NOT KNOWN (CANADA)'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NOT SPECIFIED(US), CARDHOLDER (CANADA)",
      "CARDHOLDER/SELF(US), SPOUSE (CANADA)",
      "SPOUSE(US), CHILD UNDERAGE (CANADA)",
      "CHILD(US), CHILD OVERAGE (CANADA)",
      "OTHER(US), DISABLED DEPENDENT (CANADA)",
      "DEPENDENT STUDENT (CANADA)",
      "NOT KNOWN (CANADA)",
      "OTHER"
    ]
  }

  dimension: store_tp_link_child {
    type: string
    label: "Claim Card Dependent Code"
    description: "Indicates if the use of the card is for the cardholder, spouse, or a Dependent member of the card holder. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_CHILD,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_CHILD') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_CHILD = '001' THEN 'CARDHOLDER'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '002' THEN 'SPOUSE'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '003' THEN 'DEPENDENT1 OR OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '004' THEN 'DEPENDENT2 OR OTHER'
              ELSE 'OTHER'
         END ;;
    suggestions: ["CARDHOLDER", "SPOUSE", "DEPENDENT1 OR OTHER", "DEPENDENT2 OR OTHER", "OTHER"]
  }

  dimension: store_tp_link_student {
    type: yesno
    label: "Claim Card Student Dependent"
    description: "Yes/No Flag indicating if this record is for a dependent who is a student. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_STUDENT = 'Y' ;;
  }

  dimension: store_tp_link_adc {
    type: yesno
    label: "Claim Card ADC"
    description: "Yes/No Flag indicating if patient is eligible for ADC benefits. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ADC ='Y' ;;
  }

  dimension: store_tp_link_nursing_home {
    type: yesno
    label: "Claim Card Nursing Home Patient"
    description: "Yes/No Flag indicating if patient is considered a nursing home patient under this third party link record. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_NURSING_HOME ='Y' ;;
  }

  dimension: store_tp_link_senior_citizen {
    type: yesno
    label: "Claim Card Senior Citizen"
    description: "Yes/No Flag indicating if patient is considered a senior citizen under this third party link record. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_SENIOR_CITIZEN ='Y' ;;
  }

  dimension: store_tp_link_apply_other_pricing_and_copay {
    type: yesno
    label: "Claim Card Apply Other Pricing And Copay"
    description: "Yes/No Flag indicating if the pricing logic takes other insurance pricing & fees into account. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_APPLY_OTHER_PRICING_AND_COPAY ='Y' ;;
  }

  dimension: store_tp_link_location {
    type: string
    label: "Claim Patient Location"
    description: "Code identifying the location type where the patient receives the product or service. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_LOCATION,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_LOCATION') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_LOCATION IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '00' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '01' THEN 'HOME'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '02' THEN 'INTERMEDIATE CARE (5.1), SKILLED NURSING FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '03' THEN 'NURSING HOME'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '04' THEN 'LONG TERM/EXTENDED CARE (5.1), ASSISTED LIVING FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '05' THEN 'REST HOME (5.1), CUSTODIAL CARE FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '06' THEN 'BOARDING HOME (5.1), GROUP HOME (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '07' THEN 'SKILLED CARE FACILITY (5.1), INPATIENT PSYCHIATRIC FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '08' THEN 'SUB-ACUTE CARE FACILITY (5.1), PSYCHIATRIC FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '09' THEN 'ACUTE CARE FACILITY (5.1), INTERMEDIATE CARE FACILITY/MENTALLY RETARDED (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '10' THEN 'OUTPATIENT (5.1), RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '11' THEN 'HOSPICE'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '12' THEN 'END STAGE RENAL FACILITY'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "HOME",
      "INTERMEDIATE CARE (5.1), SKILLED NURSING FACILITY (D.0)",
      "NURSING HOME",
      "LONG TERM/EXTENDED CARE (5.1), ASSISTED LIVING FACILITY (D.0)",
      "REST HOME (5.1), CUSTODIAL CARE FACILITY (D.0)",
      "BOARDING HOME (5.1), GROUP HOME (D.0)",
      "SKILLED CARE FACILITY (5.1), INPATIENT PSYCHIATRIC FACILITY (D.0)",
      "SUB-ACUTE CARE FACILITY (5.1), PSYCHIATRIC FACILITY (D.0)",
      "ACUTE CARE FACILITY (5.1), INTERMEDIATE CARE FACILITY/MENTALLY RETARDED (D.0)",
      "OUTPATIENT (5.1), RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY (D.0)",
      "HOSPICE",
      "END STAGE RENAL FACILITY",
      "OTHER"
    ]
  }

  dimension: store_tp_link_special {
    type: string
    label: "Claim Card Special Benefits Code"
    description: "Special benefits code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_SPECIAL ;;
  }

  dimension: store_tp_link_series {
    type: string
    label: "Claim Card Series Code"
    description: "Series code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_SERIES,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_SERIES') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_SERIES IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'S' THEN 'SINGLE'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'F' THEN 'FAMILY'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'X' THEN 'RETIRED'
              ELSE 'OTHER'
         END ;;
    suggestions: ["NOT SPECIFIED", "SINGLE", "FAMILY", "RETIRED","OTHER"]
  }

  dimension: store_tp_link_eligible {
    type: string
    label: "Claim Card Eligible When Filling Prescriptions"
    description: "Flag indicating if a patient third party link record is eligible to use when filling prescriptions. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ELIGIBLE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ELIGIBLE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE IS NULL THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'N' THEN 'NOT ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'W' THEN 'WARN AS NOT ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'Y' THEN 'THIRD PARTY RECORD IS ELIGIBLE'
              ELSE 'OTHER'
         END ;;
    suggestions: ["ELIGIBLE", "NOT ELIGIBLE", "WARN AS NOT ELIGIBLE", "THIRD PARTY RECORD IS ELIGIBLE", "OTHER"]
  }

  dimension: store_tp_link_blue_cross_home {
    type: string
    label: "Claim Card Blue Cross Home Plan Identification Code"
    description: "Blue Cross home plan identification code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BLUE_CROSS_HOME ;;
  }

  dimension: store_tp_link_clinic {
    type: string
    label: "Claim Card Clinic Identifier"
    description: "Identification assigned to patient's clinic. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CLINIC ;;
  }

  dimension: store_tp_link_eligibility_override {
    type: string
    label: "Claim Card Eligibility Override Or Clarification Code"
    description: "Eligibility override or clarification code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ELIGIBILITY_OVERRIDE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '1' THEN 'NO OVERRIDE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '2' THEN 'OVERRIDE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '3' THEN 'FULL TIME STUDENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '4' THEN 'DISABLED DEPENDENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '5' THEN 'DEPENDENT PARENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '6' THEN 'SIGNIFICANT OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = 'E' THEN 'EMPLOYED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = 'P' THEN 'PART TIME STUDENT'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NO OVERRIDE",
      "OVERRIDE",
      "FULL TIME STUDENT",
      "DISABLED DEPENDENT",
      "DEPENDENT PARENT",
      "SIGNIFICANT OTHER",
      "EMPLOYED",
      "PART TIME STUDENT",
      "OTHER"
    ]
  }

  dimension: store_tp_link_patient_signature {
    type: string
    label: "Claim Patient Signature"
    description: "Patient signature code. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_PATIENT_SIGNATURE ;;
  }

  dimension: store_tp_link_coupon {
    type: yesno
    label: "Claim Card Coupon"
    description: "Yes/No Flag indicating if a patient third party link record is a coupon. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_FLAG ='Y' ;;
  }

  dimension: store_tp_link_alternate_cardholder_num {
    type: string
    label: "Claim Card Alternate Cardholder Identifier"
    description: "Alternate Cardholder ID. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM ;;
  }

  dimension: store_tp_link_copied_during_rx_merge {
    type: yesno
    label: "Claim Card Copied During Rx Merge"
    description: "Yes/No Flag indicating if a TP link record has been copied from another patient during a single Rx merge. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COPIED_DURING_RX_MERGE = 'Y' ;;
  }

  dimension: store_tp_link_coupon_type {
    type: string
    label: "Claim Card Coupon Type"
    description: "Indicates if the record is a discount coupon, if it is for a free medication, or something else. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # NULL option is not available in D_MASTER_CODE table. Added NULL logic to display as NOT SPECIFIED.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_COUPON_TYPE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_COUPON_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '01' THEN 'PRICE DISCOUNT'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '02' THEN 'FREE PRODUCT'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '99' THEN 'OTHER'
         END ;;
    suggestions: ["PRICE DISCOUNT", "FREE PRODUCT", "OTHER", "NOT SPECIFIED"]
  }

  dimension: store_tp_link_coupon_number {
    type: string
    label: "Claim Card Coupon Number"
    description: "Unique serial number assigned to the prescription coupon. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_NUMBER ;;
  }

  measure: store_tp_link_coupon_value_amount {
    type: sum
    label: "Claim Card Coupon Value Amount"
    description: "Dollar amount of the coupon. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_VALUE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_tp_link_medicaid_indicator {
    type: string
    label: "Claim Card Medicaid Indicator"
    description: "Two character State Postal Code indicating the state where Medicaid coverage exists. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_MEDICAID_INDICATOR ;;
  }

  dimension: store_tp_link_medicaid_identifier {
    type: string
    label: "Claim Card Medicaid Identifier"
    description: "A unique member identification number assigned by the Medicaid Agency. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_MEDICAID_IDENTIFIER ;;
  }

  dimension: store_tp_link_cms_part_d_qualified_facility {
    type: yesno
    label: "Claim Card CMS Part D Benefit"
    description: "Indicates that the patient resides in a facility that qualifies for the CMS Part D benefit. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CMS_PART_D_QUALIFIED_FACILITY = 'Y' ;;
  }

  dimension: store_tp_link_alternate_cardholder_num_qual {
    type: string
    label: "Claim Card Alternate Cardholder Identifier Code"
    description: "Code identifying the alternate cardholder ID. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column. Reamining values from DB with no CASE WHEN display NULL.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL') ;;
    #[ERXDWPS-1532] Removed Home from CASE WHEN and corrected SSN  value to 01
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '01' THEN 'SOCIAL SECURITY NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '1J' THEN 'FACILITY ID NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '02' THEN 'DRIVER\'S LICENSE NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '03' THEN 'U.S. MILITARY ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '04' THEN 'NON-SSN-BASED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '05' THEN 'SSN-BASED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '06' THEN 'MEDICAID ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '07' THEN 'STATE ISSUED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '08' THEN 'PASSPORT ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '09' THEN 'MEDICARE HIC'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '10' THEN 'EMPLOYER ASSIGNED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '11' THEN 'PAYER/PBM ASSIGNED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '12' THEN 'ALIEN NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '13' THEN 'GOVERNMENT STUDENT VISA NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '14' THEN 'INDIAN TRIBAL ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = 'EA' THEN 'MEDICAL RECORD IDENTIFICATION NUMBER (EHR)'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "SOCIAL SECURITY NUMBER",
      "FACILITY ID NUMBER",
      "DRIVER'S LICENSE NUMBER",
      "U.S. MILITARY ID",
      "NON-SSN-BASED",
      "SSN-BASED",
      "MEDICAID ID",
      "STATE ISSUED ID",
      "PASSPORT ID",
      "MEDICARE HIC",
      "EMPLOYER ASSIGNED ID",
      "PAYER/PBM ASSIGNED ID",
      "ALIEN NUMBER",
      "GOVERNMENT STUDENT VISA NUMBER",
      "INDIAN TRIBAL ID",
      "OTHER",
      "MEDICAL RECORD IDENTIFICATION NUMBER (EHR)"
    ]
  }

  dimension: store_tp_link_residence {
    type: string
    label: "Claim Card Residence Code"
    description: "Code identifying the location type where the patient resides. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_RESIDENCE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_RESIDENCE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '00' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '01' THEN 'HOME'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '02' THEN 'SKILLED NURSING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '03' THEN 'NURSING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '4' THEN 'ASSISTED LIVING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '5' THEN 'CUSTODIAL CARE FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '6' THEN 'GROUP HOME'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '7' THEN 'INPATIENT PSYCHIATRIC FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '8' THEN 'PSYCHIATRIC FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '9' THEN 'INTERMEDIATE CARE FACILITY FOR MENTALLY RETARDED INDIVIDUALS'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '10' THEN 'RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '11' THEN 'HOSPICE'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '12' THEN 'PSYCHIATRIC RESIDENTIAL TREATMENT FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '13' THEN 'COMPREHENSIVE INPATIENT REHABILITATION FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '14' THEN 'HOMELESS SHELTER'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '15' THEN 'CORRECTIONAL INSTITUTION'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "HOME",
      "SKILLED NURSING FACILITY",
      "NURSING FACILITY",
      "ASSISTED LIVING FACILITY",
      "CUSTODIAL CARE FACILITY",
      "GROUP HOME",
      "INPATIENT PSYCHIATRIC FACILITY",
      "PSYCHIATRIC FACILITY",
      "INTERMEDIATE CARE FACILITY FOR MENTALLY RETARDED INDIVIDUALS",
      "RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY",
      "HOSPICE",
      "PSYCHIATRIC RESIDENTIAL TREATMENT FACILITY",
      "COMPREHENSIVE INPATIENT REHABILITATION FACILITY",
      "HOMELESS SHELTER",
      "CORRECTIONAL INSTITUTION",
      "OTHER"
    ]
  }

  dimension: store_tp_link_benefits_not_assigned {
    type: yesno
    label: "Claim Card Benefits Not Assigned"
    description: "Yes/No Flag indicating whether the patient has chosen not to assign benefits to the provider. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BENEFITS_NOT_ASSIGNED = 'Y' ;;
  }

  dimension: store_tp_link_discount {
    type: yesno
    label: "Claim Discount Card"
    description: "Yes/No Flag indicating whether the plan is a discount card for the patient. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DISCOUNT_FLAG = 'Y' ;;
  }

  dimension: store_tp_link_card_description {
    type: string
    label: "Claim Card Description"
    description: "Text description of a card. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CARD_DESCRIPTION ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: store_tp_link_card_description_deidentified {
    type: string
    label: "Claim Card Description"
    description: "Text description of a card. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_TP_LINK_CARD_DESCRIPTION) ;;
  }

  ################################################################################################## End of Dimensions ################################################################################################

  ################################################################################################## Date/Time Dimension ################################################################################################

  dimension_group: store_tp_link_begin {
    type: time
    label: "Claim Card Effective"
    description: "Date this patient third party link record became effective. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BEGIN_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: store_tp_link_end {
    type: time
    label: "Claim Card Expiry"
    description: "Date this patient third party link record expires. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_END_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: store_tp_link_eligibility_change {
    type: time
    label: "Claim Card TP Eligibility Change"
    description: "Date the eligibility status on a patient third party link record changes. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ELIGIBILITY_CHANGE_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: store_tp_link_tp_birth {
    type: time
    label: "Claim Card Patient Birth"
    description: "Patient's date of birth as known by the third party processor. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_TP_BIRTH_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: store_tp_link_deactivate {
    type: time
    label: "Claim Card Deactivation"
    description: "Date record was deactivated. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DEACTIVATE_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: store_tp_link_store_last_used {
    type: time
    label: "Claim Card Last Used"
    description: "Date a patient third party link record was last used. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_STORE_LAST_USED_DATE ;;
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
      day_of_month
    ]
  }

  ################################################################################################## End of Date/Time Dimensions ################################################################################################

  ########################################################################################################## reference dates used in other explores (currently used in sales )#############################################################################################
  ###### reference dates does not have any type as the type is defined in other explores....
  ###### the below objects are used as references in other view files....
  ### [ERXLPS-699]
  dimension: store_tp_link_begin_reference {
    hidden: yes
    label: "Claim Card Effective"
    description: "Date this patient third party link record become effective. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BEGIN_DATE ;;
  }

  dimension: store_tp_link_store_last_used_reference {
    hidden: yes
    label: "Claim Card Last Used"
    description: "Date a patient third party link record was last used. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_STORE_LAST_USED_DATE ;;
  }

  ################################################################################################## Measures ################################################################################################
  measure: store_tp_link_dollar_tx {
    type: sum
    label: "Transactions Dollar Amount"
    description: "Total dollar amount of all transactions filled using a patient third party information record. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DOLLAR_TX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_tp_link_number_tx {
    type: sum
    label: "Transactions Filled"
    description: "Total number of transactions filled using a patient third party link record. This information is for a patient’s third party link ‘Card’ record associated with the transaction, but is set in the patient’s profile. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_NUMBER_TX ;;
    value_format: "#,##0"
  }


  #################################################################################### ERXPLPS-1438 New set of dimensions for Patient card ##################################################################
  #[ERXLPS-2383] - Comments added. We have exposed level no from tp_link table which provides the label of card. Also added another dimension patient_tp_link_billing_seq to show the master code values.
  dimension: patient_card_tp_link_level_no {
    type: number
    label: "Patient Card Level Number"
    description: "Third party billing priority for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql:  ${TABLE}.STORE_TP_LINK_LEVEL_NO ;;
    value_format: "0"
    #suggestions: ["PRIMARY", "SECONDARY", "TERTIARY"]
  }

  #[ERXLPS-1438] - Added new dimension billing sequence with case when logic.
  dimension: patient_tp_link_billing_seq {
    type: string
    label: "Patient Card Billing Sequence"
    description: "Third party billing sequence, based on the ‘Patient Card Level Number’ dimension, that displays the level number as Primary, Secondary, Tertiary, or Others. This priority is set in the patient’s profile and may, or may not, be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 1 THEN 'PRIMARY'
              WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 2 THEN 'SECONDARY'
              WHEN ${TABLE}.STORE_TP_LINK_LEVEL_NO = 3 THEN 'TERTIARY'
              ELSE 'OTHER'
         END ;;
    suggestions: ["PRIMARY", "SECONDARY", "TERTIARY", "OTHER"]
  }

  dimension: patient_tp_link_relation {
    type: string
    label: "Patient Card Dependent Relation"
    description: "Dependent relationship code for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_RELATION,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_RELATION') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_RELATION = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '1' THEN 'NOT SPECIFIED(US), CARDHOLDER (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '2' THEN 'CARDHOLDER/SELF(US), SPOUSE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '3' THEN 'SPOUSE(US), CHILD UNDERAGE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '4' THEN 'CHILD(US), CHILD OVERAGE (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '5' THEN 'OTHER(US), DISABLED DEPENDENT (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION = '9' THEN 'DEPENDENT STUDENT (CANADA)'
              WHEN ${TABLE}.STORE_TP_LINK_RELATION IS NULL THEN 'NOT KNOWN (CANADA)'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NOT SPECIFIED(US), CARDHOLDER (CANADA)",
      "CARDHOLDER/SELF(US), SPOUSE (CANADA)",
      "SPOUSE(US), CHILD UNDERAGE (CANADA)",
      "CHILD(US), CHILD OVERAGE (CANADA)",
      "OTHER(US), DISABLED DEPENDENT (CANADA)",
      "DEPENDENT STUDENT (CANADA)",
      "NOT KNOWN (CANADA)",
      "OTHER"
    ]
  }

  dimension: patient_card_tp_link_child {
    type: string
    label: "Patient Card Dependent Code"
    description: "Indicates if the use of the card is for the cardholder, spouse, or a Dependent member of the card holder. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_CHILD,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_CHILD') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_CHILD = '001' THEN 'CARDHOLDER'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '002' THEN 'SPOUSE'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '003' THEN 'DEPENDENT1 OR OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_CHILD = '004' THEN 'DEPENDENT2 OR OTHER'
              ELSE 'OTHER'
         END ;;
    suggestions: ["CARDHOLDER", "SPOUSE", "DEPENDENT1 OR OTHER", "DEPENDENT2 OR OTHER", "OTHER"]
  }

  dimension: patient_tp_link_student {
    type: yesno
    label: "Patient Card Student Dependent"
    description: "Flag indicating if this record is for a dependent who is a student. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_STUDENT = 'Y' ;;
  }

  dimension: patient_tp_link_adc {
    type: yesno
    label: "Patient Card ADC"
    description: "Yes/No Flag indicating if patient is eligible for ADC benefits. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ADC ='Y' ;;
  }

  dimension: patient_tp_link_nursing_home {
    type: yesno
    label: "Patient Card Nursing Home Patient"
    description: "Yes/No Flag indicating if patient is considered a nursing home patient for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_NURSING_HOME ='Y' ;;
  }

  dimension: patient_tp_link_senior_citizen {
    type: yesno
    label: "Patient Card Senior Citizen"
    description: "Yes/No Flag indicating if patient is considered a senior citizen for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_SENIOR_CITIZEN ='Y' ;;
  }

  dimension: patient_tp_link_apply_other_pricing_and_copay {
    type: yesno
    label: "Patient Card Apply Other Pricing And Copay"
    description: "Yes/No Flag indicating if the pricing logic takes other insurance pricing & fees into account. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_APPLY_OTHER_PRICING_AND_COPAY ='Y' ;;
  }

  dimension: patient_tp_link_location {
    type: string
    label: "Patient Location"
    description: "Location type where the patient receives the product or service. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_LOCATION,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_LOCATION') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_LOCATION IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '00' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '01' THEN 'HOME'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '02' THEN 'INTERMEDIATE CARE (5.1), SKILLED NURSING FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '03' THEN 'NURSING HOME'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '04' THEN 'LONG TERM/EXTENDED CARE (5.1), ASSISTED LIVING FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '05' THEN 'REST HOME (5.1), CUSTODIAL CARE FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '06' THEN 'BOARDING HOME (5.1), GROUP HOME (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '07' THEN 'SKILLED CARE FACILITY (5.1), INPATIENT PSYCHIATRIC FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '08' THEN 'SUB-ACUTE CARE FACILITY (5.1), PSYCHIATRIC FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '09' THEN 'ACUTE CARE FACILITY (5.1), INTERMEDIATE CARE FACILITY/MENTALLY RETARDED (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '10' THEN 'OUTPATIENT (5.1), RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY (D.0)'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '11' THEN 'HOSPICE'
              WHEN ${TABLE}.STORE_TP_LINK_LOCATION = '12' THEN 'END STAGE RENAL FACILITY'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "HOME",
      "INTERMEDIATE CARE (5.1), SKILLED NURSING FACILITY (D.0)",
      "NURSING HOME",
      "LONG TERM/EXTENDED CARE (5.1), ASSISTED LIVING FACILITY (D.0)",
      "REST HOME (5.1), CUSTODIAL CARE FACILITY (D.0)",
      "BOARDING HOME (5.1), GROUP HOME (D.0)",
      "SKILLED CARE FACILITY (5.1), INPATIENT PSYCHIATRIC FACILITY (D.0)",
      "SUB-ACUTE CARE FACILITY (5.1), PSYCHIATRIC FACILITY (D.0)",
      "ACUTE CARE FACILITY (5.1), INTERMEDIATE CARE FACILITY/MENTALLY RETARDED (D.0)",
      "OUTPATIENT (5.1), RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY (D.0)",
      "HOSPICE",
      "END STAGE RENAL FACILITY",
      "OTHER"
    ]
  }

  dimension: patient_tp_link_special {
    type: string
    label: "Patient Card Special Benefits Code"
    description: "Special benefits code. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_SPECIAL ;;
  }

  dimension: patient_tp_link_series {
    type: string
    label: "Patient Card Series Code"
    description: "Series code. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_SERIES,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_SERIES') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_SERIES IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'S' THEN 'SINGLE'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'F' THEN 'FAMILY'
              WHEN ${TABLE}.STORE_TP_LINK_SERIES = 'X' THEN 'RETIRED'
              ELSE 'OTHER'
         END ;;
    suggestions: ["NOT SPECIFIED", "SINGLE", "FAMILY", "RETIRED","OTHER"]
  }

  dimension: patient_tp_link_eligible {
    type: string
    label: "Patient Card Eligible When Filling Prescriptions"
    description: "Flag indicating if a patient third party link record is eligible to use when filling prescriptions. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ELIGIBLE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ELIGIBLE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE IS NULL THEN 'ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'N' THEN 'NOT ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'W' THEN 'WARN AS NOT ELIGIBLE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBLE = 'Y' THEN 'THIRD PARTY RECORD IS ELIGIBLE'
              ELSE 'OTHER'
         END ;;
    suggestions: ["ELIGIBLE", "NOT ELIGIBLE", "WARN AS NOT ELIGIBLE", "THIRD PARTY RECORD IS ELIGIBLE", "OTHER"]
  }

  dimension: patient_tp_link_blue_cross_home {
    type: string
    label: "Patient Card Blue Cross Home Plan Identification Code"
    description: "Blue Cross home plan identification code. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BLUE_CROSS_HOME ;;
  }

  dimension: patient_tp_link_clinic {
    type: string
    label: "Patient Card Clinic Identifier"
    description: "Identification assigned to patient's clinic. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CLINIC ;;
  }

  dimension: patient_tp_link_eligibility_override {
    type: string
    label: "Patient Card Eligibility Override Or Clarification Code"
    description: "Eligibility override or clarification code. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ELIGIBILITY_OVERRIDE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '1' THEN 'NO OVERRIDE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '2' THEN 'OVERRIDE'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '3' THEN 'FULL TIME STUDENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '4' THEN 'DISABLED DEPENDENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '5' THEN 'DEPENDENT PARENT'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = '6' THEN 'SIGNIFICANT OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = 'E' THEN 'EMPLOYED'
              WHEN ${TABLE}.STORE_TP_LINK_ELIGIBILITY_OVERRIDE = 'P' THEN 'PART TIME STUDENT'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "NO OVERRIDE",
      "OVERRIDE",
      "FULL TIME STUDENT",
      "DISABLED DEPENDENT",
      "DEPENDENT PARENT",
      "SIGNIFICANT OTHER",
      "EMPLOYED",
      "PART TIME STUDENT",
      "OTHER"
    ]
  }

  dimension: patient_tp_link_patient_signature {
    type: string
    label: "Patient Signature"
    description: "Patient signature code. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_PATIENT_SIGNATURE ;;
  }

  dimension: patient_tp_link_coupon {
    type: yesno
    label: "Patient Card Coupon"
    description: "Yes/No Flag indicating if a patient third party link record is a coupon. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_FLAG ='Y' ;;
  }

  dimension: patient_tp_link_alternate_cardholder_num {
    type: string
    label: "Patient Card Alternate Cardholder Identifier"
    description: "Alternate Cardholder ID. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM ;;
  }

  dimension: patient_tp_link_copied_during_rx_merge {
    type: yesno
    label: "Patient Card Copied During Rx Merge"
    description: "Yes/No Flag indicating if a TP link record has been copied from another patient during a single Rx merge. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COPIED_DURING_RX_MERGE = 'Y' ;;
  }

  dimension: patient_tp_link_coupon_type {
    type: string
    label: "Patient Card Coupon Type"
    description: "Indicates if the record is a discount coupon, if it is for a free medication, or something else. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # NULL option is not available in D_MASTER_CODE table. Added NULL logic to display as NOT SPECIFIED.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_COUPON_TYPE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_COUPON_TYPE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '01' THEN 'PRICE DISCOUNT'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '02' THEN 'FREE PRODUCT'
              WHEN ${TABLE}.STORE_TP_LINK_COUPON_TYPE = '99' THEN 'OTHER'
         END ;;
    suggestions: ["PRICE DISCOUNT", "FREE PRODUCT", "OTHER", "NOT SPECIFIED"]
  }

  dimension: patient_tp_link_coupon_number {
    type: string
    label: "Patient Card Coupon Number"
    description: "Unique serial number assigned to the prescription coupon. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_NUMBER ;;
  }

  measure: patient_tp_link_coupon_value_amount {
    type: sum
    label: "Patient Card Coupon Value Amount"
    description: "Dollar amount of the coupon. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_COUPON_VALUE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: patient_tp_link_medicaid_indicator {
    type: string
    label: "Patient Card Medicaid Indicator"
    description: "Two character State Postal Code indicating the state where Medicaid coverage exists. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_MEDICAID_INDICATOR ;;
  }

  dimension: patient_tp_link_medicaid_identifier {
    type: string
    label: "Patient Card Medicaid Identifier"
    description: "A unique member identification number assigned by the Medicaid Agency. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_MEDICAID_IDENTIFIER ;;
  }

  dimension: patient_tp_link_cms_part_d_qualified_facility {
    type: yesno
    label: "Patient Card CMS Part D Benefit"
    description: "Yes/No Flag indicating that the patient resides in a facility that qualifies for the CMS Part D benefit. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CMS_PART_D_QUALIFIED_FACILITY = 'Y' ;;
  }

  dimension: patient_tp_link_alternate_cardholder_num_qual {
    type: string
    label: "Patient Card Alternate Cardholder Identifier Code"
    description: "Code identifying the alternate cardholder ID. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column. Reamining values from DB with no CASE WHEN display NULL.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL') ;;
    #[ERXDWPS-1532] Removed Home from CASE WHEN and corrected SSN  value to 01
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '01' THEN 'SOCIAL SECURITY NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '1J' THEN 'FACILITY ID NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '02' THEN 'DRIVER\'S LICENSE NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '03' THEN 'U.S. MILITARY ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '04' THEN 'NON-SSN-BASED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '05' THEN 'SSN-BASED'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '06' THEN 'MEDICAID ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '07' THEN 'STATE ISSUED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '08' THEN 'PASSPORT ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '09' THEN 'MEDICARE HIC'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '10' THEN 'EMPLOYER ASSIGNED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '11' THEN 'PAYER/PBM ASSIGNED ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '12' THEN 'ALIEN NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '13' THEN 'GOVERNMENT STUDENT VISA NUMBER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '14' THEN 'INDIAN TRIBAL ID'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = '99' THEN 'OTHER'
              WHEN ${TABLE}.STORE_TP_LINK_ALTERNATE_CARDHOLDER_NUM_QUAL = 'EA' THEN 'MEDICAL RECORD IDENTIFICATION NUMBER (EHR)'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "SOCIAL SECURITY NUMBER",
      "FACILITY ID NUMBER",
      "DRIVER'S LICENSE NUMBER",
      "U.S. MILITARY ID",
      "NON-SSN-BASED",
      "SSN-BASED",
      "MEDICAID ID",
      "STATE ISSUED ID",
      "PASSPORT ID",
      "MEDICARE HIC",
      "EMPLOYER ASSIGNED ID",
      "PAYER/PBM ASSIGNED ID",
      "ALIEN NUMBER",
      "GOVERNMENT STUDENT VISA NUMBER",
      "INDIAN TRIBAL ID",
      "OTHER",
      "MEDICAL RECORD IDENTIFICATION NUMBER (EHR)"
    ]
  }

  dimension: patient_tp_link_residence {
    type: string
    label: "Patient Card Residence Code"
    description: "Code identifying the location type where the patient resides. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    #Master code table do not have values for all values in table column.
    # OTHER option is not available in D_MASTER_CODE table. Added to display all other relation codes as OTHER.
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.STORE_TP_LINK_RESIDENCE,'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TP_LINK_RESIDENCE') ;;
    sql: CASE WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '00' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '01' THEN 'HOME'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '02' THEN 'SKILLED NURSING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '03' THEN 'NURSING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '4' THEN 'ASSISTED LIVING FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '5' THEN 'CUSTODIAL CARE FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '6' THEN 'GROUP HOME'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '7' THEN 'INPATIENT PSYCHIATRIC FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '8' THEN 'PSYCHIATRIC FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '9' THEN 'INTERMEDIATE CARE FACILITY FOR MENTALLY RETARDED INDIVIDUALS'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '10' THEN 'RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '11' THEN 'HOSPICE'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '12' THEN 'PSYCHIATRIC RESIDENTIAL TREATMENT FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '13' THEN 'COMPREHENSIVE INPATIENT REHABILITATION FACILITY'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '14' THEN 'HOMELESS SHELTER'
              WHEN ${TABLE}.STORE_TP_LINK_RESIDENCE = '15' THEN 'CORRECTIONAL INSTITUTION'
              ELSE 'OTHER'
         END ;;
    suggestions: [
      "NOT SPECIFIED",
      "HOME",
      "SKILLED NURSING FACILITY",
      "NURSING FACILITY",
      "ASSISTED LIVING FACILITY",
      "CUSTODIAL CARE FACILITY",
      "GROUP HOME",
      "INPATIENT PSYCHIATRIC FACILITY",
      "PSYCHIATRIC FACILITY",
      "INTERMEDIATE CARE FACILITY FOR MENTALLY RETARDED INDIVIDUALS",
      "RESIDENTIAL SUBSTANCE ABUSE TREATMENT FACILITY",
      "HOSPICE",
      "PSYCHIATRIC RESIDENTIAL TREATMENT FACILITY",
      "COMPREHENSIVE INPATIENT REHABILITATION FACILITY",
      "HOMELESS SHELTER",
      "CORRECTIONAL INSTITUTION",
      "OTHER"
    ]
  }

  dimension: patient_tp_link_benefits_not_assigned {
    type: yesno
    label: "Patient Card Benefits Not Assigned"
    description: "Yes/No Flag indicating whether the patient has chosen not to assign benefits to the provider. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BENEFITS_NOT_ASSIGNED = 'Y' ;;
  }

  dimension: patient_tp_link_discount {
    type: yesno
    label: "Patient Discount Card"
    description: "Yes/No Flag indicating whether the plan is a discount card for the patient. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DISCOUNT_FLAG = 'Y' ;;
  }

  dimension: patient_tp_link_card_description {
    type: string
    label: "Patient Card Description"
    description: "Text description of a card. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_CARD_DESCRIPTION ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: patient_tp_link_card_description_deidentified {
    type: string
    label: "Patient Card Description"
    description: "Text description of a card. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_TP_LINK_CARD_DESCRIPTION) ;;
  }

  ################################################################################################## End of Dimensions ################################################################################################

  ################################################################################################## Date/Time Dimension ################################################################################################

  dimension_group: patient_tp_link_begin {
    type: time
    label: "Patient Card Effective"
    description: "Date the patient third party link record became effective. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_BEGIN_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: patient_tp_link_end {
    type: time
    label: "Patient Card TP Link Expiry"
    description: "Date the patient third party link record expires. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_END_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: patient_tp_link_eligibility_change {
    type: time
    label: "Patient Card TP Eligibility Change"
    description: "Date the eligibility status on a patient third party link record changes. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_ELIGIBILITY_CHANGE_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: patient_tp_link_tp_birth {
    type: time
    label: "Patient Card Patient Birth"
    description: "Patient's date of birth as known by the third party processor. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_TP_BIRTH_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: patient_tp_link_deactivate {
    type: time
    label: "Patient Card TP Link Deactivation"
    description: "Date record was deactivated. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DEACTIVATE_DATE ;;
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
      day_of_month
    ]
  }

  dimension_group: patient_tp_link_store_last_used {
    type: time
    label: "Patient Card Last Used"
    description: "Date a patient third party link record was last used. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_STORE_LAST_USED_DATE ;;
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
      day_of_month
    ]
  }

  #[ERXLPS-2383] - Added source_timestamp dimension group to expose in expores.
  dimension_group: patient_tp_link_last_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    label: "Patient Card TP Link Last Update"
    description: "Date and time at which the record was last updated in the source application. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }


  dimension_group: patient_tp_link_source_create {
    label: "Patient TP Link Source Create"
    description: "This is the date and time that the record was created in the source application. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  measure: sum_patient_tp_link_dollar_tx {
    type: sum
    label: "Patient Card Dollar Amount"
    description: "Total dollar amount of all transactions filled using a patient third party information record. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_DOLLAR_TX ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_patient_tp_link_number_tx {
    type: sum
    label: "Patient Card Filled"
    description: "Total number of transactions filled using a patient third party link record. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: TP_LINK, PDX Table Name:TPLINK"
    sql: ${TABLE}.STORE_TP_LINK_NUMBER_TX ;;
    value_format: "#,##0"
  }

  #################################################################################### End of ERXPLPS-1438 New set of dimensions for Patient card ##################################################################
  ################################################################################################## SETS ################################################################################################

  set: eps_transmit_queue_card_menu_candidate_list {
    fields: [
      store_tp_link_card_description,
      store_tp_link_child,
      store_tp_link_relation,
      store_tp_link_discount,
      store_tp_link_begin,
      store_tp_link_begin_time,
      store_tp_link_begin_date,
      store_tp_link_begin_week,
      store_tp_link_begin_month,
      store_tp_link_begin_month_num,
      store_tp_link_begin_year,
      store_tp_link_begin_quarter,
      store_tp_link_begin_quarter_of_year,
      store_tp_link_begin_hour_of_day,
      store_tp_link_begin_time_of_day,
      store_tp_link_begin_hour2,
      store_tp_link_begin_minute15,
      store_tp_link_begin_day_of_week,
      store_tp_link_begin_day_of_month,
      store_tp_link_store_last_used,
      store_tp_link_store_last_used_time,
      store_tp_link_store_last_used_date,
      store_tp_link_store_last_used_week,
      store_tp_link_store_last_used_month,
      store_tp_link_store_last_used_month_num,
      store_tp_link_store_last_used_year,
      store_tp_link_store_last_used_quarter,
      store_tp_link_store_last_used_quarter_of_year,
      store_tp_link_store_last_used_hour_of_day,
      store_tp_link_store_last_used_time_of_day,
      store_tp_link_store_last_used_hour2,
      store_tp_link_store_last_used_minute15,
      store_tp_link_store_last_used_day_of_week,
      store_tp_link_store_last_used_day_of_month,
      store_tp_link_residence,
      patient_tp_link_source_create_time,
      patient_tp_link_source_create_date,
      patient_tp_link_source_create_week,
      patient_tp_link_source_create_month,
      patient_tp_link_source_create_month_num,
      patient_tp_link_source_create_year,
      patient_tp_link_source_create_quarter,
      patient_tp_link_source_create_quarter_of_year,
      patient_tp_link_source_create,
      patient_tp_link_source_create_hour_of_day,
      patient_tp_link_source_create_time_of_day,
      patient_tp_link_source_create_hour2,
      patient_tp_link_source_create_minute15,
      patient_tp_link_source_create_day_of_week,
      patient_tp_link_source_create_day_of_month
    ]
  }

  #[ERXLPS-699] Adding new set for sales explore integration. Only dimensions are added to this set, excluded date dimension_groups and measures. Required measures will be created in sales view and referece eps_tp_link. Dates will be added in sales view to show financial calendar timeframes.
  set: sales_transmit_queue_tp_link_dimension_candidate_list {
    fields: [store_tp_link_relation, store_tp_link_child, store_tp_link_residence, store_tp_link_discount, store_tp_link_card_description]
  }

  #[ERXLPS-1436] Set created to use in DEMO Model Sales
  set: bi_demo_sales_transmit_queue_tp_link_dimension_candidate_list {
    fields: [store_tp_link_relation, store_tp_link_child, store_tp_link_residence, store_tp_link_discount, store_tp_link_card_description_deidentified]
  }

  #[ERXLPS-1438] Adding new set to expose patient card tp_link information in sales explore.
  #[ERXLPS-2383] #[ERXLPS-2383] Updated set name. Added last update date.
  set: sales_patient_tp_link_candidate_list {
    fields: [
      patient_card_tp_link_level_no,
      patient_tp_link_billing_seq,
      patient_tp_link_relation,
      patient_card_tp_link_child,
      patient_tp_link_student,
      patient_tp_link_adc,
      patient_tp_link_nursing_home,
      patient_tp_link_senior_citizen,
      patient_tp_link_apply_other_pricing_and_copay,
      patient_tp_link_location,
      patient_tp_link_special,
      patient_tp_link_series,
      patient_tp_link_eligible,
      patient_tp_link_blue_cross_home,
      patient_tp_link_clinic,
      patient_tp_link_eligibility_override,
      patient_tp_link_patient_signature,
      patient_tp_link_coupon,
      patient_tp_link_alternate_cardholder_num,
      patient_tp_link_copied_during_rx_merge,
      patient_tp_link_coupon_type,
      patient_tp_link_coupon_number,
      patient_tp_link_coupon_value_amount,
      patient_tp_link_medicaid_indicator,
      patient_tp_link_medicaid_identifier,
      patient_tp_link_cms_part_d_qualified_facility,
      patient_tp_link_alternate_cardholder_num_qual,
      patient_tp_link_residence,
      patient_tp_link_benefits_not_assigned,
      patient_tp_link_discount,
      patient_tp_link_card_description,
      patient_tp_link_begin,
      patient_tp_link_begin_time,
      patient_tp_link_begin_date,
      patient_tp_link_begin_week,
      patient_tp_link_begin_month,
      patient_tp_link_begin_month_num,
      patient_tp_link_begin_year,
      patient_tp_link_begin_quarter,
      patient_tp_link_begin_quarter_of_year,
      patient_tp_link_begin_hour_of_day,
      patient_tp_link_begin_time_of_day,
      patient_tp_link_begin_hour2,
      patient_tp_link_begin_minute15,
      patient_tp_link_begin_day_of_week,
      patient_tp_link_begin_day_of_month,
      patient_tp_link_end,
      patient_tp_link_end_time,
      patient_tp_link_end_date,
      patient_tp_link_end_week,
      patient_tp_link_end_month,
      patient_tp_link_end_month_num,
      patient_tp_link_end_year,
      patient_tp_link_end_quarter,
      patient_tp_link_end_quarter_of_year,
      patient_tp_link_end_hour_of_day,
      patient_tp_link_end_time_of_day,
      patient_tp_link_end_hour2,
      patient_tp_link_end_minute15,
      patient_tp_link_end_day_of_week,
      patient_tp_link_end_day_of_month,
      patient_tp_link_eligibility_change,
      patient_tp_link_eligibility_change_time,
      patient_tp_link_eligibility_change_date,
      patient_tp_link_eligibility_change_week,
      patient_tp_link_eligibility_change_month,
      patient_tp_link_eligibility_change_month_num,
      patient_tp_link_eligibility_change_year,
      patient_tp_link_eligibility_change_quarter,
      patient_tp_link_eligibility_change_quarter_of_year,
      patient_tp_link_eligibility_change_hour_of_day,
      patient_tp_link_eligibility_change_time_of_day,
      patient_tp_link_eligibility_change_hour2,
      patient_tp_link_eligibility_change_minute15,
      patient_tp_link_eligibility_change_day_of_week,
      patient_tp_link_eligibility_change_day_of_month,
      patient_tp_link_tp_birth,
      patient_tp_link_tp_birth_time,
      patient_tp_link_tp_birth_date,
      patient_tp_link_tp_birth_week,
      patient_tp_link_tp_birth_month,
      patient_tp_link_tp_birth_month_num,
      patient_tp_link_tp_birth_year,
      patient_tp_link_tp_birth_quarter,
      patient_tp_link_tp_birth_quarter_of_year,
      patient_tp_link_tp_birth_hour_of_day,
      patient_tp_link_tp_birth_time_of_day,
      patient_tp_link_tp_birth_hour2,
      patient_tp_link_tp_birth_minute15,
      patient_tp_link_tp_birth_day_of_week,
      patient_tp_link_tp_birth_day_of_month,
      patient_tp_link_deactivate,
      patient_tp_link_deactivate_time,
      patient_tp_link_deactivate_date,
      patient_tp_link_deactivate_week,
      patient_tp_link_deactivate_month,
      patient_tp_link_deactivate_month_num,
      patient_tp_link_deactivate_year,
      patient_tp_link_deactivate_quarter,
      patient_tp_link_deactivate_quarter_of_year,
      patient_tp_link_deactivate_hour_of_day,
      patient_tp_link_deactivate_time_of_day,
      patient_tp_link_deactivate_hour2,
      patient_tp_link_deactivate_minute15,
      patient_tp_link_deactivate_day_of_week,
      patient_tp_link_deactivate_day_of_month,
      patient_tp_link_store_last_used,
      patient_tp_link_store_last_used_time,
      patient_tp_link_store_last_used_date,
      patient_tp_link_store_last_used_week,
      patient_tp_link_store_last_used_month,
      patient_tp_link_store_last_used_month_num,
      patient_tp_link_store_last_used_year,
      patient_tp_link_store_last_used_quarter,
      patient_tp_link_store_last_used_quarter_of_year,
      patient_tp_link_store_last_used_hour_of_day,
      patient_tp_link_store_last_used_time_of_day,
      patient_tp_link_store_last_used_hour2,
      patient_tp_link_store_last_used_minute15,
      patient_tp_link_store_last_used_day_of_week,
      patient_tp_link_store_last_used_day_of_month,
      #[ERXLPS-2383] Exposing source_timestamp in patient - central and sales explore.
      patient_tp_link_last_update,
      patient_tp_link_last_update_time,
      patient_tp_link_last_update_date,
      patient_tp_link_last_update_week,
      patient_tp_link_last_update_month,
      patient_tp_link_last_update_month_num,
      patient_tp_link_last_update_year,
      patient_tp_link_last_update_quarter,
      patient_tp_link_last_update_quarter_of_year,
      patient_tp_link_last_update_hour_of_day,
      patient_tp_link_last_update_time_of_day,
      patient_tp_link_last_update_hour2,
      patient_tp_link_last_update_minute15,
      patient_tp_link_last_update_day_of_week,
      patient_tp_link_last_update_day_of_month,
      sum_patient_tp_link_dollar_tx,
      sum_patient_tp_link_number_tx,
      patient_tp_link_source_create_time,
      patient_tp_link_source_create_date,
      patient_tp_link_source_create_week,
      patient_tp_link_source_create_month,
      patient_tp_link_source_create_month_num,
      patient_tp_link_source_create_year,
      patient_tp_link_source_create_quarter,
      patient_tp_link_source_create_quarter_of_year,
      patient_tp_link_source_create,
      patient_tp_link_source_create_hour_of_day,
      patient_tp_link_source_create_time_of_day,
      patient_tp_link_source_create_hour2,
      patient_tp_link_source_create_minute15,
      patient_tp_link_source_create_day_of_week,
      patient_tp_link_source_create_day_of_month
    ]
  }

  #[ERXLPS-1438] Adding new set to expose patient card tp_link information in sales explore.
  set: bi_demo_sales_patient_tp_link_dimension_candidate_list {
    fields: [
      patient_card_tp_link_level_no,
      patient_tp_link_billing_seq,
      patient_tp_link_relation,
      patient_card_tp_link_child,
      patient_tp_link_student,
      patient_tp_link_adc,
      patient_tp_link_nursing_home,
      patient_tp_link_senior_citizen,
      patient_tp_link_apply_other_pricing_and_copay,
      patient_tp_link_location,
      patient_tp_link_special,
      patient_tp_link_series,
      patient_tp_link_eligible,
      patient_tp_link_blue_cross_home,
      patient_tp_link_clinic,
      patient_tp_link_eligibility_override,
      #patient_tp_link_patient_signature,
      patient_tp_link_coupon,
      #patient_tp_link_alternate_cardholder_num,
      patient_tp_link_copied_during_rx_merge,
      patient_tp_link_coupon_type,
      #patient_tp_link_coupon_number,
      patient_tp_link_coupon_value_amount,
      patient_tp_link_medicaid_indicator,
      #patient_tp_link_medicaid_identifier,
      patient_tp_link_cms_part_d_qualified_facility,
      patient_tp_link_alternate_cardholder_num_qual,
      patient_tp_link_residence,
      patient_tp_link_benefits_not_assigned,
      patient_tp_link_discount,
      patient_tp_link_card_description_deidentified,
      patient_tp_link_begin,
      patient_tp_link_begin_time,
      patient_tp_link_begin_date,
      patient_tp_link_begin_week,
      patient_tp_link_begin_month,
      patient_tp_link_begin_month_num,
      patient_tp_link_begin_year,
      patient_tp_link_begin_quarter,
      patient_tp_link_begin_quarter_of_year,
      patient_tp_link_begin_hour_of_day,
      patient_tp_link_begin_time_of_day,
      patient_tp_link_begin_hour2,
      patient_tp_link_begin_minute15,
      patient_tp_link_begin_day_of_week,
      patient_tp_link_begin_day_of_month,
      patient_tp_link_end,
      patient_tp_link_end_time,
      patient_tp_link_end_date,
      patient_tp_link_end_week,
      patient_tp_link_end_month,
      patient_tp_link_end_month_num,
      patient_tp_link_end_year,
      patient_tp_link_end_quarter,
      patient_tp_link_end_quarter_of_year,
      patient_tp_link_end_hour_of_day,
      patient_tp_link_end_time_of_day,
      patient_tp_link_end_hour2,
      patient_tp_link_end_minute15,
      patient_tp_link_end_day_of_week,
      patient_tp_link_end_day_of_month,
      patient_tp_link_eligibility_change,
      patient_tp_link_eligibility_change_time,
      patient_tp_link_eligibility_change_date,
      patient_tp_link_eligibility_change_week,
      patient_tp_link_eligibility_change_month,
      patient_tp_link_eligibility_change_month_num,
      patient_tp_link_eligibility_change_year,
      patient_tp_link_eligibility_change_quarter,
      patient_tp_link_eligibility_change_quarter_of_year,
      patient_tp_link_eligibility_change_hour_of_day,
      patient_tp_link_eligibility_change_time_of_day,
      patient_tp_link_eligibility_change_hour2,
      patient_tp_link_eligibility_change_minute15,
      patient_tp_link_eligibility_change_day_of_week,
      patient_tp_link_eligibility_change_day_of_month,
      patient_tp_link_deactivate,
      patient_tp_link_deactivate_time,
      patient_tp_link_deactivate_date,
      patient_tp_link_deactivate_week,
      patient_tp_link_deactivate_month,
      patient_tp_link_deactivate_month_num,
      patient_tp_link_deactivate_year,
      patient_tp_link_deactivate_quarter,
      patient_tp_link_deactivate_quarter_of_year,
      patient_tp_link_deactivate_hour_of_day,
      patient_tp_link_deactivate_time_of_day,
      patient_tp_link_deactivate_hour2,
      patient_tp_link_deactivate_minute15,
      patient_tp_link_deactivate_day_of_week,
      patient_tp_link_deactivate_day_of_month,
      patient_tp_link_store_last_used,
      patient_tp_link_store_last_used_time,
      patient_tp_link_store_last_used_date,
      patient_tp_link_store_last_used_week,
      patient_tp_link_store_last_used_month,
      patient_tp_link_store_last_used_month_num,
      patient_tp_link_store_last_used_year,
      patient_tp_link_store_last_used_quarter,
      patient_tp_link_store_last_used_quarter_of_year,
      patient_tp_link_store_last_used_hour_of_day,
      patient_tp_link_store_last_used_time_of_day,
      patient_tp_link_store_last_used_hour2,
      patient_tp_link_store_last_used_minute15,
      patient_tp_link_store_last_used_day_of_week,
      patient_tp_link_store_last_used_day_of_month,
      sum_patient_tp_link_dollar_tx,
      sum_patient_tp_link_number_tx,
      patient_tp_link_source_create_time,
      patient_tp_link_source_create_date,
      patient_tp_link_source_create_week,
      patient_tp_link_source_create_month,
      patient_tp_link_source_create_month_num,
      patient_tp_link_source_create_year,
      patient_tp_link_source_create_quarter,
      patient_tp_link_source_create_quarter_of_year,
      patient_tp_link_source_create,
      patient_tp_link_source_create_hour_of_day,
      patient_tp_link_source_create_time_of_day,
      patient_tp_link_source_create_hour2,
      patient_tp_link_source_create_minute15,
      patient_tp_link_source_create_day_of_week,
      patient_tp_link_source_create_day_of_month
    ]
  }

}

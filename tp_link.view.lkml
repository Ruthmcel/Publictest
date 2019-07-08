view: tp_link {

  label: "TP Link"
  sql_table_name: EDW.D_TP_LINK ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number.TP_LINK"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${tp_link_id} ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################


  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assinged to each customer chain by NHIN. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: tp_link_id {
    label: "TP Link ID"
    description: "Unique ID number identifying a card record. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.TP_LINK_ID ;;
  }

  dimension: rx_com_id {
    label: "Rx Com ID"
    description: "Unique ID number identifying a patient. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: tp_link_card_number {
    label: "TP Link Card Number"
    description: "Identification number on the insurance card. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_CARD_NUMBER ;;
  }

  dimension: tp_link_carrier_code {
    label: "TP Link Carrier Code"
    description: "Insurance plan Carrier ID code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_CARRIER_CODE ;;
  }

  dimension: tp_link_plan_code {
    label: "TP Link Plan Code"
    description: "Insurance plan Plan code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_PLAN_CODE ;;
  }

  dimension: tp_link_plan_group_code {
    label: "TP Link Plan Group Code"
    description: "Insurance plan Group code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_PLAN_GROUP_CODE ;;
  }

  dimension: tp_link_adc_benefits_flag {
    label: "TP Link ADC Benefits Flag"
    description: "Flag indicating if patient is eligible for ADC benefits under this third party link record. EPR Table Name: TP_LINK"
    type: string
    sql: CASE
              WHEN NVL(${TABLE}.TP_LINK_ADC_BENEFITS_FLAG, 'N') THEN 'N - NOT ELIGIBLE'
              WHEN ${TABLE}.TP_LINK_ADC_BENEFITS_FLAG = 'Y' THEN 'Y - ELIGIBLE'
              ELSE ${TABLE}.TP_LINK_ADC_BENEFITS_FLAG
         END ;;
    suggestions: ["N - NOT ELIGIBLE", "Y - ELIGIBLE"]
  }

  dimension: tp_link_alternate_card_number {
    label: "TP Link Alternate Card Number"
    description: "Alternate Cardholder ID. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_ALTERNATE_CARD_NUMBER ;;
  }

  dimension: tp_link_bc_home_plan {
    label: "TP Link BC Home Plan"
    description: "Blue Cross home plan identification code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_BC_HOME_PLAN ;;
  }

  dimension: tp_link_patient_clinic_id {
    label: "TP Link Patient Clinic ID"
    description: "Identification assigned to patient's clinic. EPR Table Name: TP_LINK"
    type: string
    hidden: yes
    sql: ${TABLE}.TP_LINK_PATIENT_CLINIC_ID ;;
  }

  dimension: tp_link_dependent_number {
    label: "TP Link Dependent Number"
    description: "Dependent number or child code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_DEPENDENT_NUMBER ;;
  }

  dimension: tp_link_eligibility_override {
    label: "TP Link Eligibility Override"
    description: "Eligibility override or clarification code. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE, '0') THEN '0 - NOT SPECIFIED'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '1' THEN '1 - NO OVERRIDE'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '2' THEN '2 - OVERRIDE PREFORMED'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '3' THEN '3 - FULL TIME STUDENT'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '4' THEN '4 - DISABLED DEPENDENT'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '5' THEN '5 - DEPENDENT PARENT'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = '6' THEN '6 - SIGNIFICANT OTHER'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = 'E' THEN 'E - EMPLOYED'
              WHEN ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE = 'P' THEN 'P - PART TIME STUDENT'
              ELSE ${TABLE}.TP_LINK_ELIGIBILITY_OVERRIDE
         END ;;
    suggestions: [
      "0 - NOT SPECIFIED",
      "1 - NO OVERRIDE",
      "2 - OVERRIDE PREFORMED",
      "3 - FULL TIME STUDENT",
      "4 - DISABLED DEPENDENT",
      "5 - DEPENDENT PARENT",
      "6 - SIGNIFICANT OTHER",
      "E - EMPLOYED",
      "P - PART TIME STUDENT"]
  }

  dimension: tp_link_eligible_code {
    label: "TP Link Eligible Code"
    description: "Code indicating if a patient third party link record is eligible to use when filling prescriptions. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_ELIGIBLE_CODE, 'Y') THEN 'Y - TP ELIGIBLE'
              WHEN ${TABLE}.TP_LINK_ELIGIBLE_CODE = 'N' THEN 'N - NOT ELIGIBLE TP'
              WHEN ${TABLE}.TP_LINK_ELIGIBLE_CODE = 'W' THEN 'W - WARN TP NOT ELIGIBLE'
              ELSE ${TABLE}.TP_LINK_ELIGIBLE_CODE
         END ;;
    suggestions: ["Y - TP ELIGIBLE", "N - NOT ELIGIBLE TP", "W - WARN TP NOT ELIGIBLE"]
  }

  dimension_group: tp_link_eligible_starting {
    label: "TP Link Eligible Starting"
    description: "Date this patient third party link record become effective. EPR Table Name: TP_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.TP_LINK_ELIGIBLE_STARTING_DATE ;;
  }

  dimension_group: tp_link_eligible_ending {
    label: "TP Link Eligible Ending"
    description: "Date this patient third party link record expires. EPR Table Name: TP_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.TP_LINK_ELIGIBLE_ENDING_DATE ;;
  }

  dimension: tp_link_employer_name {
    label: "TP Link Employer Name"
    description: "Name of Employer of TP submitter. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_EMPLOYER_NAME ;;
  }

  dimension: tp_link_billing_sequence_level {
    label: "TP Link Billing Sequence Level"
    description: "Third party billing sequence for a patient third party link record. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '1' THEN '1 - PRIMARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '2' THEN '2 - SECONDARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '3' THEN '3 - TERTIARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '4' THEN '4 - QUATERNARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '5' THEN '5 - QUINARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '6' THEN '6 - SENARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '7' THEN '7 - SEPTENARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '8' THEN '8 - OCTONARY TP'
              WHEN ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL = '9' THEN '9 - NOVENARY TP'
              ELSE ${TABLE}.TP_LINK_BILLING_SEQUENCE_LEVEL
         END ;;
    suggestions: [
      "1 - PRIMARY TP",
      "2 - SECONDARY TP",
      "3 - TERTIARY TP",
      "4 - QUATERNARY TPE",
      "5 - QUINARY TP",
      "6 - SENARY TP",
      "7 - SEPTENARY TP",
      "8 - OCTONARY TP",
      "9 - NOVENARY TP"]
  }

  dimension: tp_link_location_type {
    label: "TP Link Location Type"
    description: "Code identifying the location type where the patient receives the product or service. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_LOCATION_TYPE, '0') THEN '0 - NOT SPECIFIED'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '1' THEN '1 - HOME'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '2' THEN '2 - INTERMEDIATE CARE'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '3' THEN '3 - NURSING HOME'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '4' THEN '4 - ASSISTED LIVING'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '5' THEN '5 - CUSTODIAL CARE'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '6' THEN '6 - GROUP HOME'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '7' THEN '7 - INPATIENT PSYCHIATRIC'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '8' THEN '8 - PSYCHIATRIC'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '9' THEN '9 - MENTALLY RETARDED FACILITY'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '10' THEN '10 - SUBSTANCE ABUSE TREATMENT'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '11' THEN '11 - HOSPICE'
              WHEN ${TABLE}.TP_LINK_LOCATION_TYPE = '12' THEN '12 - END STAGE RENAL'
              ELSE ${TABLE}.TP_LINK_LOCATION_TYPE
         END ;;
    suggestions: [
      "0 - NOT SPECIFIED",
      "1 - HOME",
      "2 - INTERMEDIATE CARE",
      "3 - NURSING HOME",
      "4 - ASSISTED LIVING",
      "5 - CUSTODIAL CARE",
      "6 - GROUP HOME",
      "7 - INPATIENT PSYCHIATRIC",
      "8 - PSYCHIATRIC",
      "9 - MENTALLY RETARDED FACILITY",
      "10 - SUBSTANCE ABUSE TREATMENT",
      "11 - HOSPICE",
      "12 - END STAGE RENAL"]
  }

  dimension: tp_link_nursing_home_flag {
    label: "TP Link Nursing Home Flag"
    description: "Flag indicating if patient is considered a nursing home patient under this third party link record. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_NURSING_HOME_FLAG,'N') THEN 'N - NOT NURSING PATIENT'
              WHEN ${TABLE}.TP_LINK_NURSING_HOME_FLAG = 'Y' THEN 'Y - NURSING HOME PATIENT'
              ELSE ${TABLE}.TP_LINK_NURSING_HOME_FLAG
         END ;;
    suggestions: ["N - NOT NURSING PATIENTS", "Y - NURSING HOME PATIENT"]
  }

  dimension: tp_link_other {
    label: "TP Link Other"
    description: "Flag indicating if patient is considered a nursing home patient under this third party link record. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_OTHER ;;
  }

  dimension: tp_link_relationship_code {
    label: "TP Link Relationship Code"
    description: "Dependent Relationship code. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '0' THEN '0 - NOT SPECIFIED, CARDHOLDER'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '1' THEN '1 - CARDHOLDER, SPOUSE'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '2' THEN '2 - SPOUSE, CHILD'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '3' THEN '3 - CHILD, OVERAGE'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '4' THEN '4 - OTHER, DISABLED'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '5' THEN '5 - DEPENDENT STUDENT'
              WHEN ${TABLE}.TP_LINK_RELATIONSHIP_CODE = '9' THEN '9 - NOT KNOWN'
              ELSE ${TABLE}.TP_LINK_RELATIONSHIP_CODE
         END ;;
    suggestions: [
      "0 - NOT SPECIFIED, CARDHOLDER",
      "1 - CARDHOLDER, SPOUSE",
      "2 - SPOUSE, CHILD",
      "3 - CHILD, OVERAGE",
      "4 - OTHER, DISABLED",
      "5 - DEPENDENT STUDENT",
      "9 - NOT KNOWN"]
  }

  dimension: tp_link_senior_citizen_flag {
    label: "TP Link Senior Citizen Flag"
    description: "Flag indicating if patient is considered a senior citizen under this third party link record. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_SENIOR_CITIZEN_FLAG, 'N') THEN 'N - NOT SENIOR CITIZEN'
              WHEN ${TABLE}.TP_LINK_SENIOR_CITIZEN_FLAG = 'Y' THEN 'Y - SENIOR CITIZEN'
              ELSE ${TABLE}.TP_LINK_SENIOR_CITIZEN_FLAG
         END ;;
    suggestions: ["N - NOT SENIOR CITIZEN", "Y - SENIOR CITIZEN"]
  }

  dimension: tp_link_series_code {
    label: "TP Link Series Code"
    description: "Series code. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.TP_LINK_SERIES_CODE = 'S' THEN 'S - SINGLE'
              WHEN ${TABLE}.TP_LINK_SERIES_CODE = 'F' THEN 'F - FAMILY'
              WHEN ${TABLE}.TP_LINK_SERIES_CODE = 'X' THEN 'X - RETIRED'
              ELSE ${TABLE}.TP_LINK_SERIES_CODE
         END ;;
    suggestions: ["S - SINGLE", "F - FAMILY", "X - RETIRED"]
  }

  dimension: tp_link_special_benefits_code {
    label: "TP Link Special Benefits Code"
    description: "Special benefits code. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_SPECIAL_BENEFITS_CODE ;;
  }

  dimension: tp_link_student_flag {
    label: "TP Link Student Flag"
    description: "Flag indicating if this third party link record is for a dependent who is a student. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_STUDENT_FLAG, 'N') THEN 'N - NOT STUDENT'
              WHEN ${TABLE}.TP_LINK_STUDENT_FLAG = 'Y' THEN 'Y - STUDENT'
              ELSE ${TABLE}.TP_LINK_STUDENT_FLAG
         END ;;
    suggestions: ["N - NOT STUDENT", "Y - STUDENT"]
  }

  dimension: tp_link_source {
    label: "TP Link Source"
    description: "Benefit Information Source Indicator As EPR receiving a patient benefit update from the pharmacy,I will need to denote that the patient?s benefit information originates from the EPS so that I can differentiate between benefit information originating from EPS and benefit information originating from ESB. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_SOURCE ;;
  }

  dimension: tp_link_other_insurance_fee {
    label: "TP Link Other Insurance Fee"
    description: "Flag that is used by pricing logic that takes other insurance pricing & fees into account. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.TP_LINK_OTHER_INSURANCE_FEE = 'N' THEN 'N - IGNORE INSURANCE PRICING'
              WHEN ${TABLE}.TP_LINK_OTHER_INSURANCE_FEE = 'Y' THEN 'Y - CONSIDER INSURANCE FEES'
              ELSE ${TABLE}.TP_LINK_OTHER_INSURANCE_FEE
         END ;;
    suggestions: ["N - IGNORE INSURANCE PRICING", "Y - CONSIDER INSURANCE FEES"]
  }

  dimension: tp_link_escript_plan {
    label: "TP Link eScript Plan"
    description: "Flag that is used by pricing logic that takes other insurance pricing & fees into account. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_ESCRIPT_PLAN ;;
  }

  dimension: tp_link_residence_type {
    label: "TP Link Residence Type"
    description: "Code identifying the location type where the patient resides. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_RESIDENCE_TYPE, '0') THEN '0 - NOT SPECIFIED'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '1' THEN '1 - HOME'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '2' THEN '2 - SKILLED NURSING'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '3' THEN '3 - NURSING'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '4' THEN '4 - ASSISTED LIVING'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '5' THEN '5 - CUSTODIAL CARE'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '6' THEN '6 - GROUP HOME'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '7' THEN '7 - INPATIENT PSYCHIATRIC'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '8' THEN '8 - PSYCHIATRIC'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '9' THEN '9 - MENTALLY RETARDED FACILITY'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '10' THEN '10 - SUBSTANCE ABUSE TREATMENT'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '11' THEN '11 - HOSPICE'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '12' THEN '12 - PSYCHIATRIC'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '13' THEN '13 - REHABILITATION'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '14' THEN '14 - HOMELESS SHELTER'
              WHEN ${TABLE}.TP_LINK_RESIDENCE_TYPE = '15' THEN '15 - CORRECTIONAL INSTITUTION'
              ELSE ${TABLE}.TP_LINK_RESIDENCE_TYPE
         END ;;
    suggestions: [
                  "0 - NOT SPECIFIED",
                  "1 - HOME",
                  "2 - SKILLED NURSING",
                  "3 - NURSING",
                  "4 - ASSISTED LIVING",
                  "5 - CUSTODIAL CARE",
                  "6 - GROUP HOME",
                  "7 - INPATIENT PSYCHIATRIC",
                  "8 - PSYCHIATRIC",
                  "9 - MENTALLY RETARDED FACILITY",
                  "10 - SUBSTANCE ABUSE TREATMENT",
                  "11 - HOSPICE",
                  "12 - PSYCHIATRIC",
                  "13 - REHABILITATION",
                  "14 - HOMELESS SHELTER",
                  "15 - CORRECTIONAL INSTITUTION"
                  ]
  }

  dimension: tp_link_cms_part_d_qualified_facility {
    label: "TP Link Cms Part D Qualified Facility"
    description: "Indicates that the patient resides in a facility that qualifies for the CMS Part D benefit. EPR Table Name: TP_LINK"
    type: string
    sql: CASE  WHEN NVL(${TABLE}.TP_LINK_CMS_PART_D_QUALIFIED_FACILITY , 'N') THEN 'N - NOT RESIDENT'
              WHEN ${TABLE}.TP_LINK_CMS_PART_D_QUALIFIED_FACILITY = 'Y' THEN 'Y - RESIDES IN CMS FACILITY'
              ELSE ${TABLE}.TP_LINK_CMS_PART_D_QUALIFIED_FACILITY
         END ;;
    suggestions: ["N - NOT RESIDENT", "Y - RESIDES IN CMS FACILITY"]
  }

  dimension: tp_link_benefits_not_assigned {
    label: "TP Link Benefits Not Assigned"
    description: "Indicates whether the patient has chosen not to assign benefits to the provider. EPR Table Name: TP_LINK"
    type: string
    sql: CASE WHEN NVL(${TABLE}.TP_LINK_BENEFITS_NOT_ASSIGNED , 'N') THEN 'N - BENEFITS TO PROVIDER'
              WHEN ${TABLE}.TP_LINK_BENEFITS_NOT_ASSIGNED = 'Y' THEN 'Y - NO BENEFITS TO PROVIDER'
              ELSE ${TABLE}.TP_LINK_BENEFITS_NOT_ASSIGNED
         END ;;
    suggestions: ["N - BENEFITS TO PROVIDER", "Y - NO BENEFITS TO PROVIDER"]
  }

  dimension: tp_link_medicaid_identifier {
    label: "TP Link Medicaid Identifier"
    description: "A unique member identification number assigned by the Medicaid Agency. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_MEDICAID_IDENTIFIER ;;
  }

  dimension: tp_link_medicaid_indicator {
    label: "TP Link Medicaid Indicator"
    description: "Two character State Postal Code indicating the state where Medicaid coverage exists. EPR Table Name: TP_LINK"
    type: string
    sql: ${TABLE}.TP_LINK_MEDICAID_INDICATOR ;;
  }

  dimension: card_id {
    label: "Card ID"
    description: "Unique ID number identifying a card record. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.CARD_ID ;;
  }

  dimension: tp_link_deleted {
    label: "TP Link Deleted"
    description: "Flag that indicates the the TP Link record has been deleted in the source system. EPR Table Name: TP_LINK"
    type: yesno
    sql: ${TABLE}.TP_LINK_DELETED = 'Y';;

  }

  dimension: nhin_store_id {
    label: "Nhin Store ID"
    description: "NHIN_ID is the unique ID number assigned by NHIN for the store associated to this record. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tp_link_lcr_id {
    label: "TP Link LCR ID"
    description: "Unique ID populated during the data load process that identifies the record. EPR Table Name: TP_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.TP_LINK_LCR_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "Date and time at which the record was last updated in the source application. EPR Table Name: TP_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

view: plan {
  sql_table_name: EDW.D_PLAN ;;
  # 20160322 KR - This view is temporarily handled to get the latest Plan Type information from HOST STAGE as the production load jobs are currently stopped.
  # 20160322 KR - This will be changed to use EDW.D_PLAN once production load is attempted
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${carrier_code} ||'@'|| ${plan_code} ||'@'|| ${group_code} ||'@'|| ${source_system_id} ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: carrier_code {
    label: "Plan Carrier Code"
    description: "Unique code used to identify a Third Party Carrier. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.CARRIER_CODE ;;
  }

  dimension: plan_code {
    label: "Plan Code"
    description: "Unique code used to identify a Third Party Plan. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_CODE ;;
  }

  dimension: group_code {
    label: "Plan Group Code"
    description: "Unique code used to identify a Third Party Plan Group. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_GROUP_CODE ;;
  }

  dimension: plan_name {
    label: "Plan Name"
    description: "Name of the third party plan. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_NAME ;;
  }

  #[ERXLPS-4396] - Deidentified column create to expose in DEMO Model.
  dimension: plan_name_deindentified {
    label: "Plan Name"
    description: "Name of the third party plan. HOST Table Name: PLAN"
    type: string
    sql: 'PLAN NAME '|| NVL(${TABLE}.PLAN_BIN_NUMBER, '') || DECODE(${TABLE}.PLAN_PCN, NULL, '', '-'||${TABLE}.PLAN_PCN) ;;
  }

  dimension: plan_bin_number {
    label: "Plan BIN Number"
    description: "Stores the ANSI BIN number for claim transmittals. HOST Table Name: PLAN"
    sql: ${TABLE}.PLAN_BIN_NUMBER ;;
  }

  dimension: plan_pcn {
    label: "Plan PCN"
    description: "Stores the third party processor control number that aids the third party processor in distinguishing the software and the different insurance plans.  HOST Table Name: PLAN"
    sql: ${TABLE}.PLAN_PCN ;;
  }

  dimension: plan_eligible_reference {
    label: "Plan Eligible Code"
    description: "Indicates if the plan is eligible for third party activity. HOST Table Name: PLAN"
    hidden: yes
    type: string
    sql: ${TABLE}.PLAN_ELIGIBLE ;;
  }

  #[ERXDWPS-6658] - Update CASE WHEN logic with fn_get_master_code_desc. Updated suggestions. Added drill down field.
  dimension: plan_eligible {
    label: "Plan Eligible"
    description: "Indicates if the plan is eligible for third party activity. HOST Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PLAN_ELIGIBLE',${TABLE}.PLAN_ELIGIBLE,'Y') ;;
    suggestions: ["N - NOT ELIGIBLE - HARD HALT", "W - ELIGIBLE - WARNING", "C - NOT ELIGIBLE - CONVERTED", "Y - ELIGIBLE", "NULL - ELIGIBLE"]
    drill_fields: [plan_eligible_reference]
  }

  dimension: plan_alternate_bin_number {
    label: "Plan Alternate BIN Number"
    description: "ANSI bin number if transmitting to an alternate site. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_ALTERNATE_BIN_NUMBER ;;
  }

  dimension: plan_alternate_pcn {
    label: "Plan Alternate PCN"
    description: "Third party processor control number if transmitting to an alternate site. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_ALTERNATE_PCN ;;
  }

  dimension: plan_contact_name {
    label: "Plan Contact Name"
    description: "Help desk contact name or department. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_CONTACT_NAME ;;
  }

  dimension: plan_help_desck_phone {
    label: "Plan Help Desk Phone"
    description: "Phone number of the Third Party Plan help desk.  HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_HELP_DESK_PHONE ;;
  }

  dimension: plan_fax_number {
    label: "Plan Fax Number"
    description: "Fax number associated to the third party plan. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_FAX_NUMBER ;;
  }

  dimension: plan_minimum_patient_age {
    label: "Plan Minimum Patient Age"
    description: "Minimum age of the patient allowed by the plan. HOST Table Name: PLAN"
    type: number
    sql: ${TABLE}.PLAN_MINIMUM_PATIENT_AGE ;;
  }

  dimension: plan_maximum_dependent_age {
    label: "Plan Maximum Dependent Age"
    description: "Maximum age allowed for a dependent where the Relation code flag on the ‘Patient T/P Information’ screen is set to ‘3’. HOST Table Name: PLAN"
    type: number
    sql: ${TABLE}.PLAN_MAXIMUM_DEPENDENT_AGE ;;
  }

  dimension: plan_maximum_student_age {
    label: "Plan Maximum Student Age"
    description: "Maximum age for dependents that are considered students. HOST Table Name: PLAN"
    type: number
    sql: ${TABLE}.PLAN_MAXIMUM_STUDENT_AGE ;;
  }

  dimension: plan_adc_age {
    label: "Plan Aid Dependent Child Age"
    description: "Upper age limit for a patient to be considered an Aid Dependent Child. HOST Table Name: PLAN"
    type: number
    sql: ${TABLE}.PLAN_ADC_AGE ;;
  }

  dimension: plan_group_number_required {
    label: "Plan Group Number Required"
    description: "Flag that determines if the third party plan requires a plan group for prescription filling (for such insurance plans as PCS where the fee is determined at the group level). HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_GROUP_NUMBER_REQUIRED ;;
  }

  dimension: plan_standard_price_code {
    label: "Plan Standard Price Code"
    description: "Price code used to price prescriptions for drugs considered ‘Standard’. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_STANDARD_PRICE_CODE ;;
  }

  dimension: plan_generic_price_code {
    label: "Plan Generic Price Code"
    description: "Price code used to price prescriptions for drugs considered ‘Generic’. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_GENERIC_PRICE_CODE ;;
  }

  dimension: plan_no_generic_price_code {
    label: "Plan No Generic Price Code"
    description: "Price code used to price prescriptions for drugs considered to have no generic. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_NO_GENERIC_PRICE_CODE ;;
  }

  dimension: plan_otc_price_code {
    label: "Plan OTC Price Code"
    description: "Price code used to price prescriptions for drugs considered ‘over the counter’. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_OTC_PRICE_CODE ;;
  }

  dimension: plan_exceed_limit_price_code {
    label: "Plan Exceed Limit Price Code"
    description: "Price code used to price prescriptions that exceed the third party’s dispensing limitations. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_EXCEED_LIMIT_PRICE_CODE ;;
  }

  dimension: plan_adc_price_code {
    label: "Plan Aid Dependent Children Price Code"
    description: "Price code used to price prescriptions for patients considered ‘aid dependent children’. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_ADC_PRICE_CODE ;;
  }

  dimension: plan_nh_price_code {
    label: "Plan Nursing Home Price Code"
    description: "Price code used to price prescriptions for nursing home patients. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_NH_PRICE_CODE ;;
  }

  dimension: plan_senior_citizen_price_code {
    label: "Plan Senior Citizen Price Code"
    description: "Price code used to price prescriptions for patients considered ‘senior citizens’. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_SENIOR_CITIZEN_PRICE_CODE ;;
  }

  dimension: plan_oth_insurance_price_code {
    label: "Plan Other Insurance Price Code"
    description: "Price code used to price prescriptions when the ‘Other Ins’ flag is set to ‘Y’ on the Patient Third Party Information screen. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_OTH_INSURANCE_PRICE_CODE ;;
  }

  dimension: plan_compound_price_code {
    label: "Plan Compound Price Code"
    description: "Price code used to price prescriptions for compounds. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_COMPOUND_PRICE_CODE ;;
  }

  ##################################################################################### Master code/ CASE WHEN dimension #######################################################################
  dimension: plan_type_reference {
    label: "Plan Type Code"
    description: "Indicates the type of plan associated with this record (i.e. ‘Private’, ‘Medicaid’, ‘Part D’, ‘Workers Comp’, etc.).  HOST Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_TYPE ;;
  }

  #[ERXDWPS-6658] - Update CASE WHEN logic with fn_get_master_code_desc. Updated suggestions. Added drill down field.
  dimension: plan_type {
    description: "Indicates the type of plan associated with this record (i.e. ‘Private’, ‘Medicaid’, ‘Part D’, ‘Workers Comp’, etc.).  HOST Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PLAN_TYPE',${TABLE}.PLAN_TYPE,'Y') ;;
    suggestions: ["0 - NOT SPECIFIED",
                  "1 - PRIVATE INSURANCE",
                  "2 - STATE MEDICAID",
                  "3 - MEDICARE PART B",
                  "4 - MEDICARE PART D",
                  "5 - WORKERS COMP",
                  "6 - OTHER FEDERAL",
                  "7 - OTHER NON MEDICAID",
                  "8 - CASH",
                  "9 - OTHER BENEFIT TYPE",
                  "10 - HMO",
                  "11 - FINANCIAL ASSISTANCE",
                  "12 - HIGH DEDUCTIBLE",
                  "13 - AIDS ASSISTANCE",
                  "14 - SELF FUNDED",
                  "15 - CHRONIC CARE SI",
                  "16 - CLINICAL ADMIN DRUGS",
                  "17 - DURABLE MEDICAL EQUIP",
                  "18 - INSURANCE EXCHANGE",
                  "19 - INSURANCE EXCHANGE OFF",
                  "20 - PREFERRED PROVIDER",
                  "21 - KPIC"
                 ]
    drill_fields: [plan_type_reference]
  }

  dimension: plan_new_store_reference {
    label: "Plan New Store"
    description: "Flag indicating if new stores receive this insurance plan record in an update. HOST Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_NEW_STORE ;;
  }

  #[ERXDWPS-6658] - Update CASE WHEN logic with fn_get_master_code_desc. Updated suggestions. Added drill down field.
  dimension: plan_new_store {
    label: "Plan New Store"
    description: "Flag indicating if new stores receive this insurance plan record in an update. HOST Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PLAN_NEW_STORE',${TABLE}.PLAN_NEW_STORE,'Y') ;;
    suggestions: ["NULL - NOT FOR NEW STORES", "N - NOT FOR NEW STORES", "Y - FOR NEW STORES"]
    drill_fields: [plan_new_store_reference]
  }

  dimension: plan_disallow_workers_comp_reference {
    label: "Plan Disallow Workers Comp"
    description: "Flag that determines whether this plan does not allow worker’s compensation coverage. HOST Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_DISALLOW_WORKERS_COMP ;;
  }

  #[ERXDWPS-6658] - Update CASE WHEN logic with fn_get_master_code_desc. Updated suggestions. Added drill down field.
  dimension: plan_disallow_workers_comp {
    label: "Plan Disallow Workers Comp"
    description: "Flag that determines whether this plan does not allow worker’s compensation coverage. HOST Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PLAN_DISALLOW_WORKERS_COMP',${TABLE}.PLAN_DISALLOW_WORKERS_COMP,'Y') ;;
    suggestions: ["NULL - ALLOW", "N - ALLOW", "Y - YES DISALLOW"]
    drill_fields: [plan_disallow_workers_comp_reference]
  }

################################################################################################## Date Dimensions ###################################################################################################
  dimension_group: plan_begin_coverage_date {
    label: "Plan Begin Coverage"
    description: "Date when the third party plan is effective. HOST Table Name: PLAN"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.PLAN_BEGIN_COVERAGE_DATE ;;
  }

  dimension_group: store_plan_end_coverage_date {
    label: "Plan End Coverage"
    description: "Date when the third party plan expires. HOST Table Name: PLAN"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.PLAN_END_COVERAGE_DATE ;;
  }

}

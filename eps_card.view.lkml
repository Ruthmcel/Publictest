view: eps_card {
#[ERXLPS-1438] - Dimensions and measure label names are prefixed with Claim word. Few of the dimensions from eps_card are currently exposed in sales explore and showing the card information pertaining to claim associated with it.
#[ERXLPS-1438] - In future if we need to explore Patient card information we need to create another set of dimensions and measures (refer eps_tp_link view) to show the patient related card information in explores.
#[ERXDWPS-5579] - Derived SQL written to get the matching PLAN record for CARD. Most of the times PLAN table GROUP_CODE information is not populated.
#[ERXDWPS-5579] - For Classic, joining CARD table with PLAN table using PLAN_ID will miss all the records for which PLAN/GROUP_CODE is populated in CARD table and not populated in PLAN table.
#[ERXDWPS-5579] - Correct way to join Classic records between CARD and PLAN table is by always CARRIER_CODE along with PLAN and GROUP_code if populated.
#[ERXDWPS-5579] - Derived SQL written to get the matching PLAN record for CARD. Most of the times PLAN table GROUP_CODE information is not populated.
  label: "Card"
  derived_table: {
    sql: with store_card as
          (select *
                  , substr(plan_id, 1, regexp_instr(plan_id, '@::@', 1, 1) -1) as carrier_code
                  , case when regexp_replace(substr(plan_id, regexp_instr(plan_id, '@::@', 1, 1)+ 4), '@::@.*') = ''
                         then null
                         else regexp_replace(substr(plan_id, regexp_instr(plan_id, '@::@', 1, 1)+ 4), '@::@.*')
                    end as store_card_plan
            from edw.d_store_card
            where source_system_id = 11
          )
          , classic_card_plan as
          (select c.*,
                  p.plan_id as plan_id_derived,
                  row_number() over(partition by c.chain_id, c.nhin_store_id, c.card_id order by p.store_plan_plan asc nulls last, p.store_plan_group_code asc nulls last) rnk --Rank applied to get matching plan and group_code record if populated.
            from store_card c
            left outer join edw.d_store_plan p
            on c.chain_id = p.chain_id
            and c.nhin_store_id = p.nhin_store_id
            and c.source_system_id = p.source_system_id
            and p.source_system_id = 11
            and c.carrier_code = p.store_plan_carrier_code
            and nvl(c.store_card_plan,'NULL') = nvl(nvl2(p.store_plan_plan, p.store_plan_plan, c.store_card_plan), 'NULL') --Fetch null plan record if no plan information exists in PLAN table
            and nvl(c.store_card_group_code, 'NULL') = nvl(nvl2(p.store_plan_group_code, p.store_plan_group_code, c.store_card_group_code), 'NULL') --Fetch null group_code record if no group_code information exists in PLAN table
          )
          select chain_id,
                nhin_store_id,
                card_id,
                source_system_id,
                store_card_qualifier,
                store_card_identifier,
                store_card_last_name,
                store_card_first_name,
                store_card_middle_name,
                store_card_group_code,
                store_card_eligible_flag,
                store_card_benefit,
                store_card_calculate_cost_flag,
                store_card_copay_flag,
                store_card_dollar_limit,
                store_card_dollar_total,
                store_card_dollar_limit_copay,
                store_card_dollar_total_copay,
                store_card_number_of_rx_limit,
                store_card_number_of_rx_total,
                store_card_begin_date,
                store_card_end_date,
                store_card_eligibility_change_date,
                store_card_deactivate_date,
                coverage_code_id,
                notes_id,
                plan_id,
                source_timestamp,
                event_id,
                edw_insert_timestamp,
                edw_last_update_timestamp,
                load_type,
                store_card_deleted,
                store_card_with_transaction_flag,
                carrier_code,
                store_card_plan,
                plan_id_derived,
                rnk,
                store_card_contract_identifier,
                source_create_timestamp
          from classic_card_plan cp where rnk =1
          union all
          select chain_id,
                nhin_store_id,
                card_id,
                source_system_id,
                store_card_qualifier,
                store_card_identifier,
                store_card_last_name,
                store_card_first_name,
                store_card_middle_name,
                store_card_group_code,
                store_card_eligible_flag,
                store_card_benefit,
                store_card_calculate_cost_flag,
                store_card_copay_flag,
                store_card_dollar_limit,
                store_card_dollar_total,
                store_card_dollar_limit_copay,
                store_card_dollar_total_copay,
                store_card_number_of_rx_limit,
                store_card_number_of_rx_total,
                store_card_begin_date,
                store_card_end_date,
                store_card_eligibility_change_date,
                store_card_deactivate_date,
                coverage_code_id,
                notes_id,
                plan_id,
                source_timestamp,
                event_id,
                edw_insert_timestamp,
                edw_last_update_timestamp,
                load_type,
                store_card_deleted,
                store_card_with_transaction_flag,
                null carrier_code,
                null store_card_plan,
                plan_id plan_id_derived,
                1 rnk,
                store_card_contract_identifier,
                source_create_timestamp
          from edw.d_store_card c where source_system_id = 4
          order by chain_id, nhin_store_id, card_id, source_system_id ;;
    sql_trigger_value: SELECT MAX(EDW_LAST_UPDATE_TIMESTAMP) FROM EDW.D_STORE_CARD;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string #[ERXLPS2383] Corrected datatype
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${card_id}||'@'|| ${source_system_id} ;; #ERXLPS-1649 #[ERXDWPS-1530]
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: card_id {
    hidden: yes
    type: string #[ERXDWPS-1530]
    sql: ${TABLE}.CARD_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: coverage_code_id {
    label: "Coverage Code Id"
    description: "ID representing the coverage code record associated with a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string #[ERXDWPS-1530]
    hidden: yes
    sql: ${TABLE}.coverage_code_id ;;
  }

  dimension: notes_id {
    label: "Notes Id"
    description: "Points to the NOTES table entry for this record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.notes_id ;;
  }

  dimension: plan_id {
    label: "Plan Id"
    description: "ID of the plan record associated with a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string #[ERXDWPS-1530]
    hidden: yes
    sql: ${TABLE}.plan_id_derived ;; #[ERXDWPS-5579] Replaced PLAN_ID colum name with PLAN_ID_DERIVED
  }

  ################################################################################################# Dimensions #####################################################################################
  #dimension: store_card_deleted {
  #  label: "Card Deleted"
  #  description: "Indicates if the record has been deleted in the source. EPS Table Name: CARD, PDX Table Name: CARD"
  #  type: yesno
  #  hidden: yes
  #  sql: ${TABLE}.STORE_CARD_DELETED = 'Y' ;;
  #}

  dimension: store_card_dollar_limit {
    label: "Card Dollar Limit"
    description: "Maximum dollar amount a carrier will reimburse. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_card_dollar_total {
    label: "Card Dollar Total"
    description: "Total dollar amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_card_dollar_limit_copay {
    label: "Card Dollar Limit Copay"
    description: "Maximum copay amount a cardholder is required to pay. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_card_dollar_total_copay {
    label: "Card Dollar Total Copay"
    description: "Total copay amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #################################################################################################### End of Foreign Key References #########################################################################

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ###################################################
  filter: store_card_dollar_limit_filter {
    label: "Card Dollar Limit"
    description: "Maximum dollar amount a carrier will reimburse. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: {% condition store_card_dollar_limit_filter %} ${store_card_dollar_limit} {% endcondition %}
      ;;
  }

  filter: store_card_dollar_total_filter {
    label: "Card Dollar Total"
    description: "Total dollar amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: {% condition store_card_dollar_total_filter %} ${store_card_dollar_total} {% endcondition %}
      ;;
  }

  filter: store_card_dollar_limit_copay_filter {
    label: "Card Dollar Limit Copay"
    description: "Maximum copay amount a cardholder is required to pay. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: {% condition store_card_dollar_limit_copay_filter %} ${store_card_dollar_limit_copay} {% endcondition %}
      ;;
  }

  filter: store_card_dollar_total_copay_filter {
    label: "Card Dollar Total Copay"
    description: "Total copay amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: {% condition store_card_dollar_total_copay_filter %} ${store_card_dollar_total_copay} {% endcondition %}
      ;;
  }

  #####################################################################################################################################################################################################################
  ################################################################################################## Dimensions ################################################################################################

  dimension: store_card_qualifier {
    label: "Claim Card Qualifier"
    description: "Code indicating the card type. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_QUALIFIER ;;
  }

  dimension: store_card_identifier {
    label: "Claim Cardholder Identifier"
    description: "Cardholder ID added by a user when a third party card is being added to a pateint. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_IDENTIFIER ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: store_card_identifier_deidentified {
    label: "Claim Cardholder Identifier"
    description: "Cardholder ID added by a user when a third party card is being added to a pateint. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_CARD_IDENTIFIER) ;;
  }

  dimension: store_card_last_name {
    label: "Claim Card Last Name"
    description: "Cardholder's last name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_LAST_NAME ;;
  }

  dimension: store_card_first_name {
    label: "Claim Card First Name"
    description: "Cardholder's first name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_FIRST_NAME ;;
  }

  dimension: store_card_middle_name {
    label: "Claim Card Middle Name"
    description: "Cardholder's middle name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_MIDDLE_NAME ;;
  }

  dimension: store_card_group_code {
    label: "Claim Card Group Code"
    description: "Group ID for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_GROUP_CODE ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: store_card_group_code_deidentified {
    label: "Claim Card Group Code"
    description: "Group ID for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_CARD_GROUP_CODE) ;;
  }

  dimension: store_card_eligible_flag {
    label: "Claim Card Eligible"
    description: "Flag indicating if a card record is eligible for filling prescriptions. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CARD_ELIGIBLE_FLAG = 'Y' THEN 'YES'
          WHEN ${TABLE}.STORE_CARD_ELIGIBLE_FLAG = 'N' THEN 'NO'
          WHEN ${TABLE}.STORE_CARD_ELIGIBLE_FLAG = 'W' THEN 'WARNING'
          ELSE TO_CHAR(${TABLE}.STORE_CARD_ELIGIBLE_FLAG)
          END ;;
    suggestions: ["YES", "NO", "WARNING"]
  }

  dimension: store_card_benefit {
    label: "Claim Card Benefit"
    description: "Insurance benefits code. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_BENEFIT ;;
  }

  dimension: store_card_calculate_cost_flag {
    label: "Claim Card Calculate Cost"
    description: "Flag indicating how the copay should be calculated. EPS Table Name: CARD, PDX Table Name: CARD"
    type: yesno
    sql: ${TABLE}.STORE_CARD_CALCULATE_COST_FLAG = 'Y' ;;
  }

  dimension: store_card_copay_flag {
    label: "Claim Card Copay"
    description: "Flag indicating if the copay amount should be included in the dollar limit amount. EPS Table Name: CARD, PDX Table Name: CARD"
    type: yesno
    sql: ${TABLE}.STORE_CARD_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_card_number_of_rx_limit {
    label: "Claim Card Maximum Prescriptions Allowed"
    description: "Maximum number of prescriptions allowed to be filled for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: ${TABLE}.STORE_CARD_NUMBER_OF_RX_LIMIT ;;
  }

  dimension: store_card_number_of_rx_total {
    label: "Claim Card Prescriptions Filled"
    description: "Total number of prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: ${TABLE}.STORE_CARD_NUMBER_OF_RX_TOTAL ;;
  }

  ################################################################################################## End of Dimensions #########################################################################################

  ################################################################################################## DATE/TIME specific Fields ################################################################################

  dimension_group: store_card_begin_date {
    label: "Claim Card Begin"
    description: "Date a card record becomes effective. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_begin_date ;;
  }

  dimension_group: store_card_end_date {
    label: "Claim Card End"
    description: "Date a card record expires. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_end_date ;;
  }

  dimension_group: store_card_eligibility_change_date {
    label: "Claim Card Eligibility Change"
    description: "Date that the eligibility status of a card record last changed. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_eligibility_change_date ;;
  }

  dimension_group: store_card_deactivate_date {
    label: "Claim Card Deactivate"
    description: "Date record was deactivated. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_deactivate_date ;;
  }

  #[ERXLPS-1438]
  dimension_group: patient_card_deactivate_date {
    label: "Patient Card Deactivate"
    description: "Date record was deactivated. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_deactivate_date ;;
  }

  dimension_group: patient_card_end_date {
    label: "Patient Card End"
    description: "Date a card record expires. This information is for a patient’s third party link ‘Card’ record, that is set in the patient’s profile. The ‘Card’ record may or may not be associated with a transaction. EPS Table Name: CARD, PDX Table Name: CARD"
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
    sql: ${TABLE}.store_card_end_date ;;
  }

  ################################################################################################## End Of DATE/TIME specific Fields ################################################################################

  ########################################################################################################## reference dates used in other explores (currently used in sales )#############################################################################################
  ###### reference dates does not have any type as the type is defined in other explores....
  ###### the below objects are used as references in other view files....
  ### [ERXLPS-699]
  dimension: store_card_deactivate_reference {
    hidden: yes
    label: "Card Deactivate"
    description: "Date record was deactivated. EPS Table Name: CARD, PDX Table Name: CARD"
    sql: ${TABLE}.store_card_deactivate_date ;;
  }

  dimension: store_card_end_reference {
    hidden: yes
    label: "Card End"
    description: "Date a card record expires. EPS Table Name: CARD, PDX Table Name: CARD"
    sql: ${TABLE}.store_card_end_date ;;
  }

  #ERXDWPS-7258 = Sync EPS CARD to EDW | Start
  dimension_group: store_card_source_create {
    label: "Claim Card Source Create"
    description: "This is the date and time at which the record was created in the source application. EPS Table Name: CARD, PDX Table Name: CARD"
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: store_card_contract_identifier {
    label: "Claim Card Contract Identifier"
    description: "Plan Contract ID. This value is usually associated with Medicare plans - Medicare Part D, Medicare Advantage, etc. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_CONTRACT_IDENTIFIER ;;
  }
  #ERXDWPS-7258 = Sync EPS CARD to EDW | End

  ####################################################################################################### Measures ####################################################################################################
  measure: sum_store_card_dollar_limit {
    label: "Claim Card Dollar Limit"
    description: "Maximum dollar amount a carrier will reimburse. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_card_dollar_total {
    label: "Claim Card Dollar Total"
    description: "Total dollar amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_card_dollar_limit_copay {
    label: "Claim Card Dollar Limit Copay"
    description: "Maximum copay amount a cardholder is required to pay. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_card_dollar_total_copay {
    label: "Claim Card Dollar Total Copay"
    description: "Total copay amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ###################################################### Duplicate set of dimensions & measures with different label names (Ex: Patient Card ....) to use it in other than sales explore #####################################
  dimension: store_patient_card_qualifier {
    label: "Patient Card Qualifier"
    description: "Code indicating the card type. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_QUALIFIER ;;
  }

  dimension: store_patient_card_identifier {
    label: "Patient Cardholder Identifier"
    description: "Cardholder ID added by a user when a third party card is being added to a pateint. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_IDENTIFIER ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: store_patient_card_identifier_deidentified {
    label: "Patient Cardholder Identifier"
    description: "Cardholder ID added by a user when a third party card is being added to a pateint. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_CARD_IDENTIFIER) ;;
  }

  dimension: store_patient_card_last_name {
    label: "Patient Card Last Name"
    description: "Cardholder's last name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_LAST_NAME ;;
  }

  dimension: store_patient_card_first_name {
    label: "Patient Card First Name"
    description: "Cardholder's first name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_FIRST_NAME ;;
  }

  dimension: store_patient_card_middle_name {
    label: "Patient Card Middle Name"
    description: "Cardholder's middle name. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_MIDDLE_NAME ;;
  }

  dimension: store_patient_card_group_code {
    label: "Patient Card Group Code"
    description: "Group ID for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_GROUP_CODE ;;
  }

  #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
  dimension: store_patient_card_group_code_deidentified {
    label: "Patient Card Group Code"
    description: "Group ID for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.STORE_CARD_GROUP_CODE) ;;
  }

  dimension: store_patient_card_eligible_flag {
    label: "Patient Card Eligible"
    description: "Flag indicating if a card record is eligible for filling prescriptions. EPS Table Name: CARD, PDX Table Name: CARD"
    type: yesno
    sql: ${TABLE}.STORE_CARD_ELIGIBLE_FLAG = 'Y' ;;
  }

  dimension: store_patient_card_benefit {
    label: "Patient Card Benefit"
    description: "Insurance benefits code. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_BENEFIT ;;
  }

  dimension: store_patient_card_calculate_cost_flag {
    label: "Patient Card Calculate Cost"
    description: "Flag indicating how the copay should be calculated. EPS Table Name: CARD, PDX Table Name: CARD"
    type: yesno
    sql: ${TABLE}.STORE_CARD_CALCULATE_COST_FLAG = 'Y' ;;
  }

  dimension: store_patient_card_copay_flag {
    label: "Patient Card Copay"
    description: "Flag indicating if the copay amount should be included in the dollar limit amount. EPS Table Name: CARD, PDX Table Name: CARD"
    type: yesno
    sql: ${TABLE}.STORE_CARD_COPAY_FLAG = 'Y' ;;
  }

  dimension: store_patient_card_number_of_rx_limit {
    label: "Patient Card Maximum Prescriptions Allowed"
    description: "Maximum number of prescriptions allowed to be filled for a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: ${TABLE}.STORE_CARD_NUMBER_OF_RX_LIMIT ;;
  }

  dimension: store_patient_card_number_of_rx_total {
    label: "Patient Card Prescriptions Filled"
    description: "Total number of prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: number
    sql: ${TABLE}.STORE_CARD_NUMBER_OF_RX_TOTAL ;;
  }

  dimension_group: store_patient_card_last_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    label: "Patient Card Last Update"
    description: "Date and time at which the record was last updated in the source application. EPS Table Name: CARD, PDX Table Name: CARD"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  #ERXDWPS-7258 = Sync EPS CARD to EDW | Start
  dimension_group: store_patient_card_source_create {
    label: "Patient Card Source Create"
    description: "This is the date and time at which the record was created in the source application. EPS Table Name: CARD, PDX Table Name: CARD"
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: store_patient_card_contract_identifier {
    label: "Patient Card Contract Identifier"
    description: "Plan Contract ID. This value is usually associated with Medicare plans - Medicare Part D, Medicare Advantage, etc. EPS Table Name: CARD, PDX Table Name: CARD"
    type: string
    sql: ${TABLE}.STORE_CARD_CONTRACT_IDENTIFIER ;;
  }
  #ERXDWPS-7258 = Sync EPS CARD to EDW | End

  measure: sum_store_patient_card_dollar_limit {
    label: "Patient Card Dollar Limit"
    description: "Maximum dollar amount a carrier will reimburse. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_patient_card_dollar_total {
    label: "Patient Card Dollar Total"
    description: "Total dollar amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_patient_card_dollar_limit_copay {
    label: "Patient Card Dollar Limit Copay"
    description: "Maximum copay amount a cardholder is required to pay. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_LIMIT_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_patient_card_dollar_total_copay {
    label: "Patient Card Dollar Total Copay"
    description: "Total copay amount of all prescriptions filled using a card record. EPS Table Name: CARD, PDX Table Name: CARD"
    type: sum
    sql: ${TABLE}.STORE_CARD_DOLLAR_TOTAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
  ####################################################################################################### SETS ####################################################################################################

  set: eps_transmit_queue_card_menu_candidate_list {
    fields: [
      store_card_deactivate_date,
      store_card_deactivate_date_date,
      store_card_deactivate_date_week,
      store_card_deactivate_date_month,
      store_card_deactivate_date_month_num,
      store_card_deactivate_date_year,
      store_card_deactivate_date_quarter,
      store_card_deactivate_date_quarter_of_year,
      store_card_deactivate_date_hour_of_day,
      store_card_deactivate_date_time_of_day,
      store_card_deactivate_date_hour2,
      store_card_deactivate_date_minute15,
      store_card_deactivate_date_day_of_week,
      store_card_deactivate_date_week_of_year,
      store_card_deactivate_date_day_of_week_index,
      store_card_deactivate_date_day_of_month,
      store_card_eligible_flag,
      store_card_end_date,
      store_card_end_date_date,
      store_card_end_date_week,
      store_card_end_date_month,
      store_card_end_date_month_num,
      store_card_end_date_year,
      store_card_end_date_quarter,
      store_card_end_date_quarter_of_year,
      store_card_end_date_hour_of_day,
      store_card_end_date_time_of_day,
      store_card_end_date_hour2,
      store_card_end_date_minute15,
      store_card_end_date_day_of_week,
      store_card_end_date_week_of_year,
      store_card_end_date_day_of_week_index,
      store_card_end_date_day_of_month,
      store_card_group_code,
      store_card_qualifier,
      store_card_identifier,
      store_card_contract_identifier,
      store_card_source_create_time,
      store_card_source_create_date,
      store_card_source_create_week,
      store_card_source_create_month,
      store_card_source_create_month_num,
      store_card_source_create_year,
      store_card_source_create_quarter,
      store_card_source_create_quarter_of_year,
      store_card_source_create,
      store_card_source_create_hour_of_day,
      store_card_source_create_time_of_day,
      store_card_source_create_hour2,
      store_card_source_create_minute15,
      store_card_source_create_day_of_week,
      store_card_source_create_day_of_month
    ]
  }

  #[ERXLPS-699] Adding new set for sales explore integration. Only dimensions are added to this set, excluded date dimension_groups and measures. Required measures will be created in sales view and referece card. Dates will be added in sales view to show analysis calendar timeframes.
  set: sales_transmit_queue_card_dimension_candidate_list {
    fields: [
      store_card_qualifier,
      store_card_identifier,
      store_card_group_code,
      store_card_eligible_flag,
      store_card_identifier,
      store_card_contract_identifier,
      store_card_source_create_time,
      store_card_source_create_date,
      store_card_source_create_week,
      store_card_source_create_month,
      store_card_source_create_month_num,
      store_card_source_create_year,
      store_card_source_create_quarter,
      store_card_source_create_quarter_of_year,
      store_card_source_create,
      store_card_source_create_hour_of_day,
      store_card_source_create_time_of_day,
      store_card_source_create_hour2,
      store_card_source_create_minute15,
      store_card_source_create_day_of_week,
      store_card_source_create_day_of_month
    ]
  }

  #[ERXLPS-1436] Set created to use in DEMO Model Sales
  set: bi_demo_sales_transmit_queue_card_dimension_candidate_list {
    fields: [
      store_card_qualifier,
      store_card_identifier_deidentified,
      store_card_group_code_deidentified,
      store_card_eligible_flag,
      store_card_identifier,
      store_card_contract_identifier,
      store_card_source_create_time,
      store_card_source_create_date,
      store_card_source_create_week,
      store_card_source_create_month,
      store_card_source_create_month_num,
      store_card_source_create_year,
      store_card_source_create_quarter,
      store_card_source_create_quarter_of_year,
      store_card_source_create,
      store_card_source_create_hour_of_day,
      store_card_source_create_time_of_day,
      store_card_source_create_hour2,
      store_card_source_create_minute15,
      store_card_source_create_day_of_week,
      store_card_source_create_day_of_month
      ]
  }

  #[ERXLPS-1438] Adding new set to expose Card deactivate date and end date in sales explore
  set: eps_card_dates_menu_candidate_list {
    fields: [
      patient_card_deactivate_date,
      patient_card_deactivate_date_date,
      patient_card_deactivate_date_week,
      patient_card_deactivate_date_month,
      patient_card_deactivate_date_month_num,
      patient_card_deactivate_date_year,
      patient_card_deactivate_date_quarter,
      patient_card_deactivate_date_quarter_of_year,
      patient_card_deactivate_date_hour_of_day,
      patient_card_deactivate_date_time_of_day,
      patient_card_deactivate_date_hour2,
      patient_card_deactivate_date_minute15,
      patient_card_deactivate_date_day_of_week,
      patient_card_deactivate_date_week_of_year,
      patient_card_deactivate_date_day_of_week_index,
      patient_card_deactivate_date_day_of_month,
      patient_card_end_date,
      patient_card_end_date_date,
      patient_card_end_date_week,
      patient_card_end_date_month,
      patient_card_end_date_month_num,
      patient_card_end_date_year,
      patient_card_end_date_quarter,
      patient_card_end_date_quarter_of_year,
      patient_card_end_date_hour_of_day,
      patient_card_end_date_time_of_day,
      patient_card_end_date_hour2,
      patient_card_end_date_minute15,
      patient_card_end_date_day_of_week,
      patient_card_end_date_week_of_year,
      patient_card_end_date_day_of_week_index,
      patient_card_end_date_day_of_month,
      store_patient_card_contract_identifier,
      store_patient_card_source_create_time,
      store_patient_card_source_create_date,
      store_patient_card_source_create_week,
      store_patient_card_source_create_month,
      store_patient_card_source_create_month_num,
      store_patient_card_source_create_year,
      store_patient_card_source_create_quarter,
      store_patient_card_source_create_quarter_of_year,
      store_patient_card_source_create,
      store_patient_card_source_create_hour_of_day,
      store_patient_card_source_create_time_of_day,
      store_patient_card_source_create_hour2,
      store_patient_card_source_create_minute15,
      store_patient_card_source_create_day_of_week,
      store_patient_card_source_create_day_of_month
    ]
  }

  #[ERXLPS-2383] New set to expose all eps_card information.
  set: store_patient_card_candidate_list {
    fields: [
      patient_card_deactivate_date,
      patient_card_deactivate_date_date,
      patient_card_deactivate_date_week,
      patient_card_deactivate_date_month,
      patient_card_deactivate_date_month_num,
      patient_card_deactivate_date_year,
      patient_card_deactivate_date_quarter,
      patient_card_deactivate_date_quarter_of_year,
      patient_card_deactivate_date_hour_of_day,
      patient_card_deactivate_date_time_of_day,
      patient_card_deactivate_date_hour2,
      patient_card_deactivate_date_minute15,
      patient_card_deactivate_date_day_of_week,
      patient_card_deactivate_date_week_of_year,
      patient_card_deactivate_date_day_of_week_index,
      patient_card_deactivate_date_day_of_month,
      patient_card_end_date,
      patient_card_end_date_date,
      patient_card_end_date_week,
      patient_card_end_date_month,
      patient_card_end_date_month_num,
      patient_card_end_date_year,
      patient_card_end_date_quarter,
      patient_card_end_date_quarter_of_year,
      patient_card_end_date_hour_of_day,
      patient_card_end_date_time_of_day,
      patient_card_end_date_hour2,
      patient_card_end_date_minute15,
      patient_card_end_date_day_of_week,
      patient_card_end_date_week_of_year,
      patient_card_end_date_day_of_week_index,
      patient_card_end_date_day_of_month,
      store_patient_card_qualifier,
      store_patient_card_identifier,
      store_patient_card_last_name,
      store_patient_card_first_name,
      store_patient_card_middle_name,
      store_patient_card_group_code,
      store_patient_card_eligible_flag,
      store_patient_card_benefit,
      store_patient_card_calculate_cost_flag,
      store_patient_card_copay_flag,
      store_patient_card_number_of_rx_limit,
      store_patient_card_number_of_rx_total,
      sum_store_patient_card_dollar_limit,
      sum_store_patient_card_dollar_total,
      sum_store_patient_card_dollar_limit_copay,
      sum_store_patient_card_dollar_total_copay,
      store_patient_card_last_update,
      store_patient_card_last_update_time,
      store_patient_card_last_update_date,
      store_patient_card_last_update_week,
      store_patient_card_last_update_month,
      store_patient_card_last_update_month_num,
      store_patient_card_last_update_year,
      store_patient_card_last_update_quarter,
      store_patient_card_last_update_quarter_of_year,
      store_patient_card_last_update_hour_of_day,
      store_patient_card_last_update_time_of_day,
      store_patient_card_last_update_hour2,
      store_patient_card_last_update_minute15,
      store_patient_card_last_update_day_of_week,
      store_patient_card_last_update_day_of_month,
      store_card_identifier,
      store_patient_card_contract_identifier,
      store_patient_card_source_create_time,
      store_patient_card_source_create_date,
      store_patient_card_source_create_week,
      store_patient_card_source_create_month,
      store_patient_card_source_create_month_num,
      store_patient_card_source_create_year,
      store_patient_card_source_create_quarter,
      store_patient_card_source_create_quarter_of_year,
      store_patient_card_source_create,
      store_patient_card_source_create_hour_of_day,
      store_patient_card_source_create_time_of_day,
      store_patient_card_source_create_hour2,
      store_patient_card_source_create_minute15,
      store_patient_card_source_create_day_of_week,
      store_patient_card_source_create_day_of_month
    ]
  }
}

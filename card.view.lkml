view: card {
  label: "Card"
  sql_table_name: EDW.D_CARD ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number.CARD"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${card_id} ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################


  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assinged to each customer chain by NHIN. EPR Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: card_id {
    label: "Card ID"
    description: "Unique ID number identifying a card record. EPR Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.CARD_ID ;;
  }

  dimension: card_number {
    label: "Card Number"
    description: "Identification number on the insurance card. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_NUMBER ;;
  }

  dimension: card_carrier_code {
    label: "Card Carrier Code"
    description: "Insurance plan Carrier ID code. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_CARRIER_CODE ;;
  }

  dimension: card_plan_code {
    label: "Card Plan Code"
    description: "Insurance plan Plan code. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_PLAN_CODE ;;
  }

  dimension: card_plan_group_code {
    label: "Card Plan Group Code"
    description: "Insurance plan Group code. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_PLAN_GROUP_CODE ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN_ID is the unique ID number assigned by NHIN for the store associated to this record. EPR Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: card_holder_name {
    label: "Card Holder Name"
    description: "Full name of the insurance card holder. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_HOLDER_NAME ;;
  }

  dimension: card_first_name {
    label: "Card First Name"
    description: "Patient's first name. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_FIRST_NAME ;;
  }

  dimension: card_last_name {
    label: "Card Last Name"
    description: "Patient's last name. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_LAST_NAME ;;
  }

  dimension: card_middle_name {
    label: "Card Middle Name"
    description: "Patient's middle name. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_MIDDLE_NAME ;;
  }

  dimension: card_number_qualifier {
    label: "Card Number Qualifier"
    description: "Code indicating the card type; service provider ID qualifier. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_NUMBER_QUALIFIER ;;
  }

  dimension: card_benefits_code {
    label: "Card Benefits Code"
    description: "Insurance benefits code. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_BENEFITS_CODE ;;
  }

  dimension: card_coverage_code {
    label: "Card Coverage Code"
    description: "ID representing the coverage code record associated with a card record. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_COVERAGE_CODE ;;
  }

  dimension_group: card_beginning_coverage {
    label: "Card Beginning Coverage"
    description: "Date that coverage for this card began. EPR Table Name: CARD"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.CARD_BEGINNING_COVERAGE_DATE ;;
  }

  dimension_group: card_ending_coverage {
    label: "Card Ending Coverage"
    description: "Date that coverage for this card will expire. EPR Table Name: CARD"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.CARD_ENDING_COVERAGE_DATE ;;
  }

  dimension: card_eligible_flag {
    label: "Card Eligible Flag"
    description: "Flag that determines if patient is eligible to receive benefits under this plan. EPR Table Name: CARD"
    type: string
    sql: CASE WHEN NVL(${TABLE}.CARD_ELIGIBLE_FLAG, 'Y') THEN 'Y - YES'
              WHEN ${TABLE}.CARD_ELIGIBLE_FLAG = 'N' THEN 'N - NO'
              WHEN ${TABLE}.CARD_ELIGIBLE_FLAG = 'W' THEN 'W - NO'
              ELSE TO_CHAR(${TABLE}.CARD_ELIGIBLE_FLAG)
         END ;;
    suggestions: ["Y - YES", "N - NO", "W - NO"]

  }
  dimension: card_workmans_comp_flag {
    label: "Card Workmans Comp Flag"
    description: "Yes/No Flag determines if card is for workman's comp. EPR Table Name: CARD"
    type: yesno
    sql: ${TABLE}.CARD_WORKMANS_COMP_FLAG = 'Y' ;;
  }

  dimension_group: card_plan {
    label: "Card Plan"
    description: "Last date the card was used. EPR Table Name: CARD"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.CARD_PLAN_DATE ;;
  }

  dimension: card_alternate_card_number {
    label: "Card Alternate Card Number"
    description: "Alternate Card Number. EPR Table Name: CARD"
    type: string
    sql: ${TABLE}.CARD_ALTERNATE_CARD_NUMBER ;;
  }

  dimension: card_deleted {
    label: "Card Deleted"
    description: "Yes/No Flag determines whether Card record has been set to deleted. EPR Table Name: CARD"
    type: yesno
    sql: ${TABLE}.CARD_DELETED = 'Y' ;;
  }

  dimension: card_lcr_id {
    label: "Card LCR ID"
    description: "Unique ID populated during the data load process that identifies the record. EPR Table Name: CARD"
    type: number
    hidden: yes
    sql: ${TABLE}.CARD_LCR_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "Date and time at which the record was last updated in the source application. EPR Table Name: CARD"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

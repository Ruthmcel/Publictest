view: eps_credit_card {
  label: "Credit Card"
  sql_table_name: EDW.D_CREDIT_CARD ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${credit_card_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN."
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: credit_card_id {
    label: "Credit Card Id"
    description: "Unique Id number identifying this record"
    hidden: yes
    type: number
    sql: ${TABLE}.CREDIT_CARD_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: credit_card_sequence {
    label: "Credit Card Sequence"
    description: "Ordinal position of this credit card in the collection of credit cards associated with this patient through PATIENT_ID"
    type: number
    sql: ${TABLE}.CREDIT_CARD_SEQUENCE ;;
  }

  dimension: credit_card_type {
    label: "Credit Card Type"
    description: "Type of credit card"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.CREDIT_CARD_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'CREDIT_CARD_TYPE') ;;
    suggestions: [
      "NOT DEFINED",
      "MASTER CARD",
      "VISA",
      "AMERICAN EXPRESS",
      "DISCOVER/NOVUS",
      "PRIVATE LABEL",
      "DINER''S CLUB",
      "MASTER CARD HSA",
      "VISA HSA"
    ]
  }

  dimension_group: credit_card_discontinue {
    label: "Credit Card Discontinue"
    description: "Date/Time credit card record was discontinued"
    type: time
    sql: ${TABLE}.CREDIT_CARD_DISCONTINUE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: credit_card_deactivate {
    label: "Credit Card Deactivate"
    description: "Date/Time credit card was deactivated"
    type: time
    sql: ${TABLE}.CREDIT_CARD_DEACTIVATE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: credit_card_autopay_monthly_dollar_limit {
    label: "Credit Card Autopay Monthly Dollar Limit"
    description: "Maximum cummulative dollars and cents that can be charged to this card in any calendar month"
    type: number
    sql: ${TABLE}.CREDIT_CARD_AUTOPAY_MONTHLY_DOLLAR_LIMIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: credit_card_is_healthcare_type {
    label: "Credit Card Healthcare Type"
    description: "Yes/No flag indicating if the credit card is a healthcare type"
    type: yesno
    sql: ${TABLE}.CREDIT_CARD_IS_HEALTHCARE_TYPE_FLAG = 'Y' ;;
  }

  dimension: credit_card_payment_processor_type {
    label: "Credit Card Payment Processor Type"
    description: "An indicator of what payment processor setup was used to tokenize the credit card (i.e. Element Express, Standard - EPS Standard API)"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.CREDIT_CARD_PAYMENT_PROCESSOR_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'CREDIT_CARD_PAYMENT_PROCESSOR_TYPE') ;;
    suggestions: [
      "VANTIV",
      "STANDARD",
      "NOT SPECIFIED"
    ]
  }

  dimension: notes_id {
    label: "Notes Id"
    description: "ID of the note record associated with a credit card record"
    hidden: yes
    type: number
    sql: ${TABLE}.NOTES_ID ;;
  }

  dimension: patient_id {
    label: "Patient Id"
    description: "ID of the patient record associated with a credit card record"
    hidden: yes
    type: number
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time at which the record was last updated in the source application."
    hidden: yes
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  set: explore_rx_credit_card_4_13_candidate_list {
    fields: [
      credit_card_sequence,
      credit_card_type,
      credit_card_discontinue_time,
      credit_card_discontinue_date,
      credit_card_discontinue_week,
      credit_card_discontinue_month,
      credit_card_discontinue_month_num,
      credit_card_discontinue_year,
      credit_card_discontinue_quarter,
      credit_card_discontinue_quarter_of_year,
      credit_card_discontinue,
      credit_card_discontinue_hour_of_day,
      credit_card_discontinue_time_of_day,
      credit_card_discontinue_hour2,
      credit_card_discontinue_minute15,
      credit_card_discontinue_day_of_week,
      credit_card_discontinue_day_of_month,
      credit_card_deactivate_time,
      credit_card_deactivate_date,
      credit_card_deactivate_week,
      credit_card_deactivate_month,
      credit_card_deactivate_month_num,
      credit_card_deactivate_year,
      credit_card_deactivate_quarter,
      credit_card_deactivate_quarter_of_year,
      credit_card_deactivate,
      credit_card_deactivate_hour_of_day,
      credit_card_deactivate_time_of_day,
      credit_card_deactivate_hour2,
      credit_card_deactivate_minute15,
      credit_card_deactivate_day_of_week,
      credit_card_deactivate_day_of_month,
      credit_card_autopay_monthly_dollar_limit,
      credit_card_is_healthcare_type,
      credit_card_payment_processor_type
    ]
  }
}

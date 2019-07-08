view: store_disease_code {
  label: "Store Disease Code"
  sql_table_name: EDW.D_STORE_DISEASE_CODE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${disease_code_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: DISEASE_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: DISEASE_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: disease_code_id {
    label: "Disease Code Id"
    description: "Unique ID number identifying a Disease Codes record. EPS Table: DISEASE_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.DISEASE_CODE_ID ;;
  }

  dimension: disease_code {
    label: "Disease Code"
    description: "Medi-Span disease code. EPS Table: DISEASE_CODES"
    type: string
    sql: ${TABLE}.DISEASE_CODE ;;
  }

  dimension: disease_code_description {
    label: "Disease Code Description"
    description: "Disease description. EPS Table: DISEASE_CODES"
    type: string
    sql: ${TABLE}.DISEASE_CODE_DESCRIPTION ;;
  }

  dimension: disease_code_mnemonic {
    label: "Disease Code Mnemonic"
    description: "Mnemonic disease code. EPS Table: DISEASE_CODES"
    type: string
    sql: ${TABLE}.DISEASE_CODE_MNEMONIC ;;
  }

  dimension: disease_code_duration {
    label: "Disease Code Duration"
    description: "Disease duration. EPS Table: DISEASE_CODES"
    type: string
    sql: CASE WHEN ${TABLE}.DISEASE_CODE_DURATION is null THEN 'NOT SUPPLIED'
              WHEN ${TABLE}.DISEASE_CODE_DURATION = 'A' THEN 'A - ACUTE'
              WHEN ${TABLE}.DISEASE_CODE_DURATION = 'C' THEN 'C - CHRONIC'
              ELSE TO_CHAR(${TABLE}.DISEASE_CODE_DURATION)
         END ;;
  }

  dimension: disease_code_deactivate {
    label: "Disease Code Deactivate"
    description: "Data/Time when disease code is deactivated. This date is set via Host Update processing. If Medi-Span's update file tells that this code is no longer in use,the system sets this date = current date. EPS Table: DISEASE_CODES"
    type: date
    sql: ${TABLE}.DISEASE_CODE_DEACTIVATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Disease Code Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: DISEASE_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

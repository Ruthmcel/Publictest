view: store_icd9_disease_code_link {
  label: "Store Icd9 Disease Code Link"
  sql_table_name: EDW.D_STORE_ICD9_DISEASE_CODE_LINK ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_icd9_disease_code_link_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_icd9_disease_code_link_id {
    label: "Store Icd9 Disease Code Link Id"
    description: "Unique Id number identifying this record. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ID ;;
  }

  dimension: store_icd9_disease_code_link_icd9_prefix {
    label: "Store Icd9 Disease Code Link Icd9 Prefix"
    description: "ICD-9 type. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ICD9_PREFIX is null THEN 'ICD9'
              WHEN ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ICD9_PREFIX = 'E' THEN 'E - EXTERNAL CAUSE'
              WHEN ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ICD9_PREFIX = 'V' THEN 'V - FACTORS'
              ELSE TO_CHAR(${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ICD9_PREFIX)
         END ;;
  }

  dimension: store_icd9_disease_code_link_icd9_code {
    label: "Store Icd9 Disease Code Link Icd9 Code"
    description: "ICD-9 Code. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: string
    sql: ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_ICD9_CODE ;;
  }

  dimension: store_icd9_disease_code_link_disease_code {
    label: "Store Icd9 Disease Code Link Disease Code"
    description: "Medi-Span Disease Code. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: string
    sql: ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_DISEASE_CODE ;;
  }

  dimension: store_icd9_disease_code_link_update {
    label: "Store Icd9 Disease Code Link Update"
    description: "Date of last change from Medi-Span. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: date
    sql: ${TABLE}.STORE_ICD9_DISEASE_CODE_LINK_UPDATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Store Icd9 Disease Code Link Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: ICD9_DISEASE_CODE_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

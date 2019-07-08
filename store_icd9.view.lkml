view: store_icd9 {
  label: "Store Icd9"
  sql_table_name: EDW.D_STORE_ICD9 ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_icd9_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: ICD9"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: ICD9"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_icd9_id {
    label: "Store Icd9 Id"
    description: "Unique Id number identifying this record. EPS Table: ICD9"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_ICD9_ID ;;
  }

  #[ERXDWPS-6304] - Reference dimension created to utilize in joins.
  dimension: store_icd9_prefix_reference {
    label: "Store Icd9 Prefix"
    description: "ICD-9 type. EPS Table: ICD9"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_ICD9_PREFIX ;;
  }

  dimension: store_icd9_prefix {
    label: "Store Icd9 Prefix"
    description: "ICD-9 type. EPS Table: ICD9"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_ICD9_PREFIX is null THEN 'ICD9'
              WHEN ${TABLE}.STORE_ICD9_PREFIX = 'E' THEN 'E - EXTERNAL CAUSE'
              WHEN ${TABLE}.STORE_ICD9_PREFIX = 'V' THEN 'V - FACTORS'
              ELSE TO_CHAR(${TABLE}.STORE_ICD9_PREFIX)
         END ;;
  }

  dimension: store_icd9_code {
    label: "Store Icd9 Code"
    description: "ICD-9 Code. EPS Table: ICD9"
    type: string
    sql: ${TABLE}.STORE_ICD9_CODE ;;
  }

  dimension: store_icd9_description {
    label: "Store Icd9 Description"
    description: "Description of the ICD-9. EPS Table: ICD9"
    type: string
    sql: ${TABLE}.STORE_ICD9_DESCRIPTION ;;
  }

  dimension: store_icd9_update {
    label: "Store Icd9 Update"
    description: "Date of last change from Medi-Span. EPS Table: ICD9"
    type: date
    sql: ${TABLE}.STORE_ICD9_UPDATE_DATE ;;
  }

  dimension: store_icd9_deactivate {
    label: "Store Icd9 Deactivate"
    description: "The date this ICD9 was deactivated. EPS Table: ICD9"
    type: date
    sql: ${TABLE}.STORE_ICD9_DEACTIVATE_DATE ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Icd9 Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: ICD9"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Icd9 Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: ICD9"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

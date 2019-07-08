view: store_icd10 {
  label: "Store Icd10"
  sql_table_name: EDW.D_STORE_ICD10 ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_icd10_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: ICD10"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: ICD10"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_icd10_id {
    label: "Store Icd10 Id"
    description: "Unique Id number identifying this record. EPS Table: ICD10"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_ICD10_ID ;;
  }

  dimension: store_icd10_code {
    label: "Store Icd10 Code"
    description: "The ICD 10 code. EPS Table: ICD10"
    type: string
    sql: ${TABLE}.STORE_ICD10_CODE ;;
  }

  dimension: store_icd10_description {
    label: "Store Icd10 Description"
    description: "Description of the ICD 10 code. EPS Table: ICD10"
    type: string
    sql: ${TABLE}.STORE_ICD10_DESCRIPTION ;;
  }

  dimension_group: store_icd10_deactivate {
    label: "Store Icd10 Deactivate"
    description: "Date the ICD10 code is no longer listed in the Medispan tables. EPS Table: ICD10"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_ICD10_DEACTIVATE_DATE ;;
  }

  dimension_group: store_icd10_update {
    label: "Store Icd10 Update"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis. EPS Table: ICD10"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_ICD10_UPDATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Store Icd10 Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: ICD10"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

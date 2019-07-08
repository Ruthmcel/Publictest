view: store_prescriber_degree_type {
  label: "Store Prescriber Degree Type"
  sql_table_name: EDW.D_STORE_PRESCRIBER_DEGREE_TYPE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_prescriber_degree_type_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_prescriber_degree_type_id {
    label: "Store Prescriber Degree Type Id"
    description: "Unique Id number identifying this record. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_DEGREE_TYPE_ID ;;
  }

  dimension: store_prescriber_degree_type {
    label: "Store Prescriber Degree Type"
    description: "Professional degree type assigned to a prescriber. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_DEGREE_TYPE ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Prescriber Degree Type Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Prescriber Degree Type Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PRESCRIBER_DEGREE_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

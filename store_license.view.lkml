view: store_license {
  label: "Store License"
  sql_table_name: EDW.D_STORE_LICENSE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_license_identifier} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: STORE_LICENSE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: STORE_LICENSE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_license_identifier {
    label: "Store License Identifier"
    description: "Name of the Functionality to which the license applies. EPS Table: STORE_LICENSE"
    type: string
    sql: ${TABLE}.STORE_LICENSE_IDENTIFIER ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table: STORE_LICENSE"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_license_value {
    label: "Store License Value"
    description: "Flag indicating if this store is licensed for the product indicated in the LICENSE_NAME. EPS Table: STORE_LICENSE"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_LICENSE_VALUE = 'Y' THEN 'Y - ENABLED'
              WHEN ${TABLE}.STORE_LICENSE_VALUE = 'N' THEN 'N - DISABLED'
              ELSE TO_CHAR(${TABLE}.STORE_LICENSE_VALUE)
         END ;;
  }

  dimension: store_license_lcr_id {
    label: "Store License Lcr Id"
    description: "Unique ID populated during the data load process that identifies the record. EPS Table: STORE_LICENSE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_LICENSE_LCR_ID ;;
  }

  dimension: store_license_name {
    label: "Store License Name"
    description: "Name of the Functionality to which the license applies. EPS Table: STORE_LICENSE"
    type: string
    sql: ${TABLE}.STORE_LICENSE_NAME ;;
  }

  dimension: store_license_display_name {
    label: "Store License Display Name"
    description: "License name that describes the service/product. EPS Table: STORE_LICENSE"
    type: string
    sql: ${TABLE}.STORE_LICENSE_DISPLAY_NAME ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store License Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: STORE_LICENSE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store License Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: STORE_LICENSE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

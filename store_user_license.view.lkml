view: store_user_license {
  label: "Store User"
  sql_table_name: EDW.D_USER_LICENSE ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${user_license_id} ;;
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: LICENSES"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "Store record in the source system. This column is used to link STORE & STORE_SETTINGS table in source system. EPS Table Name: LICENSES"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: user_license_id {
    label: "Store User License ID"
    type: string
    description: "The number that uniquely identifies the user license in the source system. EPS Table Name: LICENSES"
    hidden: yes
    sql: ${TABLE}.USER_LICENSE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: user_id {
    label: "Store User ID"
    type: string
    description: "ID associated with a user record at login. EPS Table Name: LICENSES"
    hidden: yes
    sql: ${TABLE}.USER_IDENTIFIER ;;
  }

  dimension: user_license_type_id {
    label: "Store User License Type ID"
    type: string
    description: "Foreign Key pointing to LICENSE_TYPE table. EPS Table Name: LICENSES"
    hidden: yes
    sql: ${TABLE}.USER_LICENSE_TYPE_ID ;;
  }

  ############################################################## Dimensions######################################################
  dimension: store_user_license_number {
    label: "Store User License Number"
    type: string
    description: "License number associated with the record. EPS Table Name: LICENSES"
    sql: ${TABLE}.USER_LICENSE_NUMBER ;;
  }

  #Dimension for demo model with encryption.
  dimension: bi_demo_store_user_license_number {
    label: "Store User License Number"
    type: string
    description: "License number associated with the record. EPS Table Name: LICENSES"
    sql: SHA2(${TABLE}.USER_LICENSE_NUMBER) ;;
  }

  dimension: store_user_license_state {
    label: "Store User License State"
    type: string
    description: "State in which this license number is valid. EPS Table Name: LICENSES"
    sql: ${TABLE}.USER_LICENSE_STATE ;;
  }
  ############################################# Date dimensions ##########################################

  dimension_group: store_user_license_deactivate {
    label: "Store User License Deactivate"
    type: time
    timeframes: [date]
    description: "Date that the license was deactivated. EPS Table Name: LICENSES"
    sql: ${TABLE}.USER_LICENSE_DEACTIVATE_DATE ;;
  }

  dimension_group: store_user_source_create_timestamp {
    label: "Store User License Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time that the record was created. This date is used for central data analysis. EPS Table Name: LICENSES"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: store_user_source_timestamp {
    label: "Store User License Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: LICENSES"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

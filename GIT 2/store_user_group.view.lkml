view: store_user_group {
  label: "Store User Group"
  sql_table_name: EDW.D_USER_GROUP ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${user_id} ||'@'|| ${group_id};;
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: USER_GROUPS_LINK"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "Store record in the source system. This column is used to link STORE & STORE_SETTINGS table in source system. EPS Table Name: USER_GROUPS_LINK"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: user_id {
    label: "Store User ID"
    type: string
    description: "The number that uniquely identifies the store settings in the source system. EPS Table Name: USER_GROUPS_LINK"
    hidden: yes
    sql: ${TABLE}.USER_IDENTIFIER ;;
  }

  dimension: group_id {
    label: "Store User Group ID"
    type: number
    description: "GROUP_ID is the FK to the GROUP table, records are linked through this table for one or more USERS records to a GROUP record. EPS Table Name: USER_GROUPS_LINK"
    hidden: yes
    sql: ${TABLE}.GROUP_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN). EPS Table Name: USER_GROUPS_LINK"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }
  ############################################################## Dimensions######################################################
  dimension: store_user_group_deleted {
    label: "Store User Group Deleted"
    type: yesno
    description: "Yes/No Flag Indicating if the record is logically deleted. EPS Table Name: USER_GROUPS_LINK"
    sql: ${TABLE}.USER_GROUP_DELETED = 'Y' ;;
  }

  #[ERXLPS-1845] Reference dimension created to use in joins.
  dimension: store_user_group_deleted_reference {
    label: "Store User Group Deleted"
    type: string
    hidden: yes
    description: "Y/N Flag indicating soft delete of record in the source table. EPS Table Name: USER_GROUPS_LINK"
    sql: ${TABLE}.USER_GROUP_DELETED ;;
  }

  ############################################# Date dimensions ##########################################

  dimension_group: store_user_group_source_timestamp {
    label: "Store User Group Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: USER_GROUPS_LINK"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: store_user_group_source_create_timestamp {
    label: "Store User Group Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time that the record was created. This date is used for central data analysis. EPS Table Name: USER_GROUPS_LINK"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }
  ############################################# Sets #####################################################
  #[ERXLPS-2078]
  set: explore_dx_store_user_group_candidate_list {
    fields: [
      store_user_group_deleted,
      store_user_group_source_timestamp,
      store_user_group_source_timestamp_time,
      store_user_group_source_timestamp_date,
      store_user_group_source_timestamp_week,
      store_user_group_source_timestamp_month,
      store_user_group_source_timestamp_month_num,
      store_user_group_source_timestamp_year,
      store_user_group_source_timestamp_quarter,
      store_user_group_source_timestamp_quarter_of_year,
      store_user_group_source_timestamp_hour_of_day,
      store_user_group_source_timestamp_time_of_day,
      store_user_group_source_timestamp_hour2,
      store_user_group_source_timestamp_minute15,
      store_user_group_source_timestamp_day_of_week,
      store_user_group_source_timestamp_week_of_year,
      store_user_group_source_timestamp_day_of_week_index,
      store_user_group_source_timestamp_day_of_month,
      store_user_group_source_create_timestamp,
      store_user_group_source_create_timestamp_time,
      store_user_group_source_create_timestamp_date,
      store_user_group_source_create_timestamp_week,
      store_user_group_source_create_timestamp_month,
      store_user_group_source_create_timestamp_month_num,
      store_user_group_source_create_timestamp_year,
      store_user_group_source_create_timestamp_quarter,
      store_user_group_source_create_timestamp_quarter_of_year,
      store_user_group_source_create_timestamp_hour_of_day,
      store_user_group_source_create_timestamp_time_of_day,
      store_user_group_source_create_timestamp_hour2,
      store_user_group_source_create_timestamp_minute15,
      store_user_group_source_create_timestamp_day_of_week,
      store_user_group_source_create_timestamp_week_of_year,
      store_user_group_source_create_timestamp_day_of_week_index,
      store_user_group_source_create_timestamp_day_of_month
    ]
  }
}

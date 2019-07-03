view: store_group {
  label: "Store Group"
  sql_table_name: EDW.D_GROUP ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${group_id};;
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: GROUPS"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "Store record in the source system. This column is used to link STORE & STORE_SETTINGS table in source system. EPS Table Name: GROUPS"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: group_id {
    label: "Store User Group ID"
    type: number
    description: "GROUP_ID is the FK to the GROUP table, records are linked through this table for one or more USERS records to a GROUP record. EPS Table Name: GROUPS"
    hidden: yes
    sql: ${TABLE}.GROUP_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }
  ############################################################## Dimensions######################################################
  dimension: store_group_name {
    label: "Store User Group Name"
    type: string
    description: "Group name supplied by the user when creating a new user group or editing an existing user group. EPS Table Name: GROUPS"
    sql: UPPER(${TABLE}.GROUP_NAME) ;;
  }

  dimension: store_group_version_number {
    label: "Store User Group Version Number"
    type: number
    description: "Group version number for a new user group or editing an existing user group. The version is incremented with edits. EPS Table Name: GROUPS"
    sql: ${TABLE}.GROUP_VERSION_NUMBER ;;
  }

  dimension: store_group_description {
    label: "Store User Group Description"
    type: string
    description: "Group description supplied by the user when creating a new user group or editing an existing user group. EPS Table Name: GROUPS"
    sql: ${TABLE}.GROUP_DESCRIPTION ;;
  }

  dimension: store_group_ad_group {
    label: "Store User Group AD Group"
    type: string
    description: "Field that will hold AD group information, purposed to remove EPS's dependecy on LDAP. EPS Table Name: GROUPS"
    sql: ${TABLE}.GROUP_AD_GROUP ;;
  }

  ############################################# Date dimensions ##########################################
  dimension_group: store_user_group_deactivate {
    label: "Store User Group Deactivate"
    type: time
    timeframes: [date]
    description: "Date on which the user group record was deactivated. EPS Table Name: GROUPS"
    sql: ${TABLE}.GROUP_DEACTIVATE_DATE ;;
  }

  dimension_group: store_user_group_source_timestamp {
    label: "Store User Group Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: GROUPS"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: store_user_group_source_create_timestamp {
    label: "Store User Group Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time that the record was created. This date is used for central data analysis. EPS Table Name: GROUPS"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }
  ############################################# Sets #####################################################
}

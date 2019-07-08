view: store_user {
  label: "Store User"
  derived_table: {
    #[ERXDWPS-5731] - Derived logic written to choose latest record which have same USER_LOGIN and USER_EMPLOYEE_NUMEBR. Seems to be EPS Defect. Based on validation we found all duplcate records have same USER_LOGIN and EMPLOYEE_NUM. Hence both are added to partition by clause.
    sql:SELECT *
          FROM (SELECT *,
                       ROW_NUMBER() OVER(PARTITION BY CHAIN_ID, NHIN_STORE_ID, USER_LOGIN, USER_EMPLOYEE_NUMBER ORDER BY USER_IDENTIFIER DESC) rnk
                  FROM EDW.D_USER
                  WHERE SOURCE_SYSTEM_ID = 4
                    AND USER_DELETED = 'N')
          WHERE RNK = 1 ;;
    sql_trigger_value: SELECT MAX(EDW_LAST_UPDATE_TIMESTAMP) FROM EDW.D_USER ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${user_id} ;;
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: USERS"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "Store record in the source system. This column is used to link STORE & STORE_SETTINGS table in source system. EPS Table Name: USERS"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  #[ERXDWPS-6203] - Exposed in WF EXplore and Task History Explore. This dimensions will be used to merge results between different explore to get USER information.
  dimension: user_id {
    label: "Store User ID"
    type: string
    description: "ID associated with a user record at login. EPS Table Name: USERS"
    sql: ${TABLE}.USER_IDENTIFIER ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN).  EPS Table Name: USERS"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_user_lcr_id {
    label: "Store User LCR ID"
    type: number
    hidden: yes
    description: ""
    sql: ${TABLE}.USER_LCR_ID ;;
  }

  dimension: store_user_type_id {
    label: "Store User Type ID"
    type: number
    hidden: yes
    sql: ${TABLE}.USER_TYPE_ID ;;
  }
  ############################################################## Dimensions######################################################
  dimension: store_user_employee_number {
    label: "Store User Employee Number"
    type: string
    description: "Employee ID assigned by customer human resources/personnel department or store. EPS Table Name: USERS"
    sql: ${TABLE}.USER_EMPLOYEE_NUMBER ;;
  }

  dimension: store_user_first_name {
    label: "Store User First Name"
    type: string
    description: "User's first name. EPS Table Name: USERS"
    sql: ${TABLE}.USER_FIRST_NAME ;;
  }

  dimension: store_user_last_name {
    label: "Store User Last Name"
    type: string
    description: "User's last name. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LAST_NAME ;;
  }

  dimension: store_user_middle_name {
    label: "Store User Middle Name"
    type: string
    description: "User's middle name. EPS Table Name: USERS"
    sql: ${TABLE}.USER_MIDDLE_NAME ;;
  }

  dimension: store_user_initials {
    label: "Store User Initials"
    type: string
    description: "User's initials. EPS Table Name: USERS"
    sql: ${TABLE}.USER_INITIALS ;;
  }

  dimension: store_user_deactivate_reason {
    label: "Store User Deactivate Reason"
    type: string
    description: "Deactivate Reason. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DEACTIVATE_REASON ;;
  }

  dimension: store_user_npi_number {
    label: "Store User NPI Number"
    type: string
    description: "National Provider Identification Number of the individual pharmacy system user. EPS Table Name: USERS"
    sql: ${TABLE}.USER_NPI_NUMBER ;;
  }

  dimension: store_user_type {
    label: "Store User Type"
    type: string
    description: "Attribute to distinguish those users that are converted from PDX Classic versus ones that are created/added via the EPS application. EPS Table Name: USERS"
    sql: CASE WHEN ${TABLE}.USER_TYPE = 0 THEN '0 - USER ADDED BY CONVERSION FROM LEGACY PDX'
              WHEN ${TABLE}.USER_TYPE = 1 THEN '1 - USER ADDED BY EPSV2'
              WHEN ${TABLE}.USER_TYPE IS NULL THEN 'NOT AVAILABLE'
         END ;;
    suggestions: ["0 - USER ADDED BY CONVERSION FROM LEGACY PDX",
                  "1 - USER ADDED BY EPSV2",
                  "NOT AVAILABLE"]
  }

  dimension: store_user_deleted {
    label: "Store User Deleted"
    type: yesno
    hidden: yes
    description: "Yes/No Flag indicating whether user is deleted. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DELETED = 'Y' ;;
  }

  #[ERXLPS-1845] Reference dimension added to use in joins.
  dimension: store_user_deleted_reference {
    label: "Store User Deleted"
    type: string
    hidden: yes
    description: "Y/N Flag indicating soft delete of record in the source table. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DELETED ;;
  }

  dimension: store_user_login {
    label: "Store User Login"
    type: string
    description: "ID associated with a user record at login. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LOGIN ;;
  }

  dimension: store_user_version_number {
    label: "Store User Version Number"
    type: number
    description: "The version number to identify each time the user gets changed. Used in the synchronization with LDAP. EPS Table Name: USERS"
    sql: ${TABLE}.USER_VERSION_NUMBER ;;
  }

  #EDW.D_MASTER_CODE table has value as 0 & 1. But actual table contain N & Y. Updated the dimension with correct logic to use based EDW ETL table transformation.
  dimension: store_user_ldap_sync_dirty_flag {
    label: "Store User LDAP Sync Dirty Flag"
    type: string
    description: "Indicates this record has changes that have not yet been committed to LDAP. 1 = user record contains changes that haven't been pushed to LDAP (dirty), 0 = user record is in sync with LDAP. EPS Table Name: USERS"
    sql: CASE WHEN ${TABLE}.USER_LDAP_SYNC_DIRTY_FLAG = 'N' THEN 'N - USER RECORD IN SYNC WITH LDAP'
              WHEN ${TABLE}.USER_LDAP_SYNC_DIRTY_FLAG = 'Y' THEN 'Y - USER RECORD CONTAINS CHANGES NOT SYNCED WITH LDAP'
         END ;;
    suggestions: ["N - USER RECORD IN SYNC WITH LDAP",
                  "Y - USER RECORD CONTAINS CHANGES NOT SYNCED WITH LDAP"]
  }

  dimension: store_user_failed_logons {
    label: "Store User Failed Logons"
    type: number
    description: "Number of times that User has attempted to login and failed. EPS Table Name: USERS"
    sql: ${TABLE}.USER_FAILED_LOGONS ;;
  }

  dimension: store_user_barcode {
    label: "Store User Barcode"
    type: string
    description: "Stores the value of the barcode that is printed out to your barcode printer that the user can use to complete tasks. This barcode is required for portable Fill. EPS Table Name: USERS"
    sql: ${TABLE}.USER_BARCODE ;;
  }

  dimension: store_user_password_change_required {
    label: "Store User Password Change Required"
    type: yesno
    description: "Yes/No Flag indicating if the password change was required. EPS Table Name: USERS"
    sql: ${TABLE}.USER_PASSWORD_CHANGE_REQUIRED = 'Y' ;;
  }

  dimension: store_user_daily_successful_logons {
    label: "Store User Daily Successful Logons"
    type: number
    description: "Count of successful logins for a particular user. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DAILY_SUCCESSFUL_LOGONS ;;
  }
  ############################################# Date dimensions ##########################################

  dimension_group: store_user_enabled {
    label: "Store User Enabled"
    type: time
    timeframes: [date]
    description: "Date on which password was enabled. EPS Table Name: USERS"
    sql: ${TABLE}.USER_ENABLED_DATE ;;
  }

  dimension_group: store_user_deactivate {
    label: "Store User Deactivate"
    type: time
    timeframes: [date]
    description: "Date on which the user record was deactivated. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DEACTIVATE_DATE ;;
  }

  dimension_group: store_user_disabled {
    label: "Store User Disabled"
    type: time
    timeframes: [date]
    description: "Date the record was last disabled. EPS Table Name: USERS"
    sql: ${TABLE}.USER_DISABLED_DATE ;;
  }

  dimension_group: store_user_source_timestamp {
    label: "Store User Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: USERS"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: store_user_last_logon {
    label: "Store User Last Logon"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date on which the User last logged in. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LAST_LOGON_DATE ;;
  }

  dimension_group: store_user_barcode_expiration {
    label: "Store User Barcode Expiration"
    type: time
    timeframes: [date]
    description: "Expiration date applied to the printed user barcode which allows task completion using the barcode. EPS Table Name: USERS"
    sql: ${TABLE}.USER_BARCODE_EXPIRATION_DATE ;;
  }

  dimension_group: store_user_password_change {
    label: "Store User Password Change"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time that the password was last changed. EPS Table Name: USERS"
    sql: ${TABLE}.USER_PASSWORD_CHANGE_DATE ;;
  }

  dimension_group: store_user_last_pqa_reminder {
    label: "Store User Last PQA Reminder"
    type: time
    timeframes: [date]
    description: "Date when PQA reminder was last displayed to a particular pharmacy user. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LAST_PQA_REMINDER_DATE ;;
  }

  dimension_group: store_user_verified_with_ecc {
    label: "Store User Verified With ECC"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last verified with the ECC. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LAST_VERIFIED_WITH_ECC_DATE ;;
  }

  dimension_group: store_user_last_verified_with_ad {
    label: "Store User Last Verified with AD"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last verified with the AD. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LAST_VERIFIED_WITH_AD_DATE ;;
  }

  dimension_group: store_user_last_login {
    label: "Store User Last Login"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time on which this user last logged into this system. EPS Table Name: USERS"
    sql: ${TABLE}.USER_LOCAL_LAST_LOGIN_DATE ;;
  }

  dimension_group: store_user_source_create_timestamp {
    label: "Store User Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time that the record was created. This date is used for central data analysis. EPS Table Name: USERS"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ############################################# measures #################################################
  measure: count {
    label: "User Count"
    description: "Total User Count."
    type: count
    value_format: "#,##0"
    drill_fields: [store_user_drill_path*]
  }

  ############################################# Sets #####################################################
  set: store_user_drill_path {
    fields: [
      chain.chain_name,
      store.nhin_store_id,
      store.store_number,
      store_user.store_user_employee_number,
      store_user.store_user_login,
      store_user.store_user_first_name,
      store_user.store_user_last_name
    ]
  }
}

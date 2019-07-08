view: store_file_date_history {
  sql_table_name: EDW.D_FILE_DATE_HIST ;;

  dimension: chain_id {
    type: number
    label: "Chain ID - History"
    hidden: yes
    description: "CHAIN_ID is a unique assigned ID number for each customer chain."
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store Id - History"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: file_date_id {
    type: number
    hidden: yes
    label: "File Date Id - History"
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.FILE_DATE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${file_date_id} ||'@'|| ${source_timestamp_time} ;; #ERXLPS-1649
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id - History"
    description: "Unique ID number identifying a BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: file_date_product_name {
    type: string
    label: "Product Name - History"
    description: "Name of the file that was applied to EPS"
    sql: ${TABLE}.FILE_DATE_PRODUCT_NAME ;;
  }

  dimension: file_date_database_version {
    type: string
    label: "Database Version - History"
    description: "Version of the database that the specific Update File record pertains to"
    sql: ${TABLE}.FILE_DATE_DATABASE_VERSION ;;
  }

  dimension: file_date_build_version {
    type: string
    label: "Build Version - History"
    description: "Medispan build version for the file"
    sql: ${TABLE}.FILE_DATE_BUILD_VERSION ;;
  }

  dimension: file_date_frequency_reference {
    label: "Frequency Code - History"
    description: "Indicates the frequency at which the file is provided (monthly or weekly)"
    type: string
    hidden: yes
    sql: ${TABLE}.FILE_DATE_FREQUENCY ;;
  }

  dimension: file_date_frequency {
    type: string
    label: "Frequency - History"
    description: "Indicates the frequency at which the file is provided (monthly or weekly)"
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(upper(${TABLE}.FILE_DATE_FREQUENCY) AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'FILE_DATE_FREQUENCY') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [file_date_frequency_reference]
  }

  dimension: file_date_file_type_reference {
    label: "File Type Code - History"
    description: "Type of the file indicating if this is a comprehensive or incremental file"
    type: string
    hidden: yes
    sql: ${TABLE}.FILE_DATE_FILE_TYPE ;;
  }

  dimension: file_date_file_type {
    type: string
    label: "File Type - History"
    description: "Type of the file indicating if this is a comprehensive or incremental file"
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(upper(${TABLE}.FILE_DATE_FILE_TYPE) AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'FILE_DATE_FILE_TYPE') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [file_date_file_type_reference]
  }

  dimension_group: file_date_create {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "History - Create"
    description: "Date/Time on which the  update file was initially created by the vendor (or originator)"
    sql: ${TABLE}.FILE_DATE_CREATE_DATE ;;
    group_label: "Create Date - History"
  }

  dimension_group: file_date_issue {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "History - Issue"
    description: "Date/Time (provided by the vendor) on which the update file should be applied"
    sql: ${TABLE}.FILE_DATE_ISSUE_DATE ;;
    group_label: "Issue Date - History"
  }

  dimension_group: file_date_expire {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "History - Expire"
    description: "Date/Time (provided by the vendor) on which the update file expires"
    sql: ${TABLE}.FILE_DATE_EXPIRE_DATE ;;
    group_label: "Expire Date - History"
  }

  dimension_group: file_date_kill {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "History - Kill"
    description: "Date/Time (if applicable) on which the specific update file should be terminated"
    sql: ${TABLE}.FILE_DATE_KILL_DATE ;;
    group_label: "Kill Date - History"
  }

  dimension: file_date_volume {
    type: string
    label: "Volume - History"
    description: "Volume number of the file"
    sql: ${TABLE}.FILE_DATE_VOLUME ;;
  }

  dimension: file_date_supplement_number {
    type: string
    label: "Supplement Number - History"
    description: "Supplement number of the file provided by vendor"
    sql: ${TABLE}.FILE_DATE_SUPPLEMENT_NUMBER ;;
  }

  dimension: file_date_nhin_supplement_number {
    type: number
    label: "NHIN Supplement Number - History"
    description: "Supplement number of the file provided by NHIN"
    sql: ${TABLE}.FILE_DATE_NHIN_SUPPLEMENT_NUMBER ;;
    value_format: "######"
  }

  dimension: file_date_description {
    type: string
    label: "Description - History"
    description: "Abbreviation of the PRODUCT NAME and is used to describe the file"
    sql: ${TABLE}.FILE_DATE_DESCRIPTION ;;
  }

  dimension: file_date_copyright {
    type: string
    label: "Copyright - History"
    description: "COPYRIGHT stores the update file originator's copyright information"
    sql: ${TABLE}.FILE_DATE_COPYRIGHT ;;
  }

  dimension_group: source_timestamp {
    label: "File date history Source Timestamp - History"
    description: "Data/Time when the record was last updated in source application."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  measure: count {
    label: "Total File Updated - History"
    description: "Total files updated at the store"
    type: count
    value_format: "#,##0"
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_file_date_history_4_13_candidate_list {
    fields: [
      chain_id,
      nhin_store_id,
      file_date_id,
      source_system_id,
      file_date_product_name,
      file_date_database_version,
      file_date_build_version,
      file_date_frequency,
      file_date_file_type,
      file_date_volume,
      file_date_supplement_number,
      file_date_nhin_supplement_number,
      file_date_description,
      file_date_copyright,
      file_date_create,
      file_date_create_time,
      file_date_create_date,
      file_date_create_week,
      file_date_create_month,
      file_date_create_month_num,
      file_date_create_year,
      file_date_create_quarter,
      file_date_create_quarter_of_year,
      file_date_create_hour_of_day,
      file_date_create_time_of_day,
      file_date_create_day_of_week,
      file_date_create_week_of_year,
      file_date_create_day_of_week_index,
      file_date_create_day_of_month,
      file_date_issue,
      file_date_issue_time,
      file_date_issue_date,
      file_date_issue_week,
      file_date_issue_month,
      file_date_issue_month_num,
      file_date_issue_year,
      file_date_issue_quarter,
      file_date_issue_quarter_of_year,
      file_date_issue_hour_of_day,
      file_date_issue_time_of_day,
      file_date_issue_day_of_week,
      file_date_issue_week_of_year,
      file_date_issue_day_of_week_index,
      file_date_issue_day_of_month,
      file_date_expire,
      file_date_expire_time,
      file_date_expire_date,
      file_date_expire_week,
      file_date_expire_month,
      file_date_expire_month_num,
      file_date_expire_year,
      file_date_expire_quarter,
      file_date_expire_quarter_of_year,
      file_date_expire_hour_of_day,
      file_date_expire_time_of_day,
      file_date_expire_day_of_week,
      file_date_expire_week_of_year,
      file_date_expire_day_of_week_index,
      file_date_expire_day_of_month,
      file_date_kill,
      file_date_kill_time,
      file_date_kill_date,
      file_date_kill_week,
      file_date_kill_month,
      file_date_kill_month_num,
      file_date_kill_year,
      file_date_kill_quarter,
      file_date_kill_quarter_of_year,
      file_date_kill_hour_of_day,
      file_date_kill_time_of_day,
      file_date_kill_day_of_week,
      file_date_kill_week_of_year,
      file_date_kill_day_of_week_index,
      file_date_kill_day_of_month,
      count
    ]
  }
}

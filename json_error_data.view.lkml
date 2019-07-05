view: json_error_data {
  #[ERXDWPS-5511] - PK dimension did not add to json_error_data view. We did not define PK for this error table and not defined PK in view.
  #[ERXDWPS-5511] - This is currently not impacting Looker explore as all other joins are either many_to_one or one_to_one.
  label:  "Data Error"
  sql_table_name:  EDW.F_JSON_ERROR_DATA ;;

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_name {
    label: "Source System Name"
    description: "Source system name"
    type: string
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_NAME ;;
  }

  dimension: source_table_name {
    label: "Source Table Name"
    description: "Source table name"
    type: string
    sql: ${TABLE}.SOURCE_TABLE_NAME ;;
  }

  dimension_group: source_timestamp {
    label: "Source"
    description: "Date/time at which the record was last updated in the source application"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: data_record {
    label: "Data Record"
    description: "Complete JSON of the data record that contains parsing issues"
    type: string
    sql: ${TABLE}.DATA_RECORD ;;
  }

  dimension: dml_operation_type {
    label: "DML Operation Type"
    description: "Field indicating if the record was inserted/updated/deleted in the source system"
    type: string
    sql: ${TABLE}.DML_OPERATION_TYPE ;;
  }

  dimension: error_on_columns {
    label: "Error On Columns"
    description: "JSON containing details of the fields that caused parsing issues"
    type: string
    sql: ${TABLE}.ERROR_ON_COLUMNS ;;
  }

  dimension: loaded_in_edw_flag {
    label: "Loaded In EDW"
    description: "Flag indicating if the data record was loaded to EDW with nulled out fields that failed in parsing. This happens if valid Primary Key column values are available on the record but other columns have parsing issues."
    type: string
    hidden: yes
    sql: case ${TABLE}.LOADED_IN_EDW_FLAG when 'N' then 'No' when 'Y' then 'Yes' end;;
  }

  dimension: is_corrected_flag {
    label: "Is Corrected"
    description: "Flag indicating if updates to this records were received from the source system"
    type: string
    sql: case ${TABLE}.IS_CORRECTED_FLAG when 'N' then 'No' when 'Y' then 'Yes' end;;
  }

  dimension: store_client_version {
    label: "Store Client Version"
    description: "Store Client Version"
    type: string
    sql: ${TABLE}.STORE_CLIENT_VERSION ;;
  }

  filter: history_filter {
    label: "HISTORY"
    description: "Current state / History filter. 'Yes' returns all the history for an error record. 'No' returns only the latest un-corrected state of an error record"
    type: string
    suggestions: ["Yes", "No"]
    full_suggestions: yes
  }

  measure: count {
    type: count
    label: "Total Records"
  }
}

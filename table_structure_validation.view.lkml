view: table_structure_validation {
  sql_table_name: ETL_MANAGER.TABLE_STRUCTURE_VALIDATION_OUTPUT ;;
  ################################################################################################## Dimensions ################################################################################################


  dimension: SNOWFLAKE_TABLE_SCHEMA {
    label: "SNOWFLAKE TABLE SCHEMA"
    description: "Snowflake table schema"
    type: string
    sql: ${TABLE}.SNOWFLAKE_TABLE_SCHEMA ;;
  }

  dimension: SNOWFLAKE_TABLE_NAME {
    label: "SNOWFLAKE TABLE NAME"
    description: "Snowflake TABLE NAME"
    type: string
    sql: ${TABLE}.SNOWFLAKE_TABLE_NAME ;;
  }

  dimension: SNOWFLAKE_COLUMN_NAME {
    label: "Snowflake column name"
    description: "Snowflake column name"
    type: string
    sql: ${TABLE}.SNOWFLAKE_COLUMN_NAME ;;
  }

  dimension: SNOWFLAKE_DATA_TYPE {
    label: "Snowflake data type"
    description: "Snowflake data type"
    type: string
    sql: ${TABLE}.SNOWFLAKE_DATA_TYPE ;;
  }

  dimension: SNOWFLAKE_NULLABLE {
    label: "Snowflake NULLABLE"
    description: "Snowflake NULLABLE"
    type: string
    sql: ${TABLE}.SNOWFLAKE_NULLABLE ;;
  }

  dimension: DFMD_TABLE_SCHEMA {
    label: "DFMD Table Schema"
    description: "DFMD Table Schema"
    type: string
    sql: ${TABLE}.DFMD_TABLE_SCHEMA ;;
  }

  dimension: DFMD_TABLE_NAME {
    label: "DFMD Table Name"
    description: "DFMD Table Name"
    type: string
    sql: ${TABLE}.DFMD_TABLE_NAME ;;
  }

  dimension: DFMD_TARGET_COLUMN_NAME {
    label: "DFMD Column Name"
    description: "DFMD Column Name"
    type: string
    sql: ${TABLE}.DFMD_TARGET_COLUMN_NAME ;;
  }

  dimension: DFMD_TARGET_DATA_TYPE {
    label: "DFMD Data type"
    description: "DFMD Data type"
    type: string
    sql: ${TABLE}.DFMD_TARGET_DATA_TYPE ;;
  }

  dimension: DFMD_NULLABLE {
    label: "DFMD nullable"
    description: "DFMD null able constraint"
    type: string
    sql: ${TABLE}.DFMD_NULLABLE ;;
  }

  dimension: MISMATCH_TYPE {
    label: "MISMATCH TYPE"
    description: "TYPE OF MISMATCH"
    type: string
    sql: ${TABLE}.MISMATCH_TYPE ;;
  }
}

################################################################################################## End of Dimensions #########################################################################################

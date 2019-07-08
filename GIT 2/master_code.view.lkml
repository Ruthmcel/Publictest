view: master_code {
  sql_table_name: EDW.D_MASTER_CODE ;;

  #[ERXDWPS-6493] - Added edw_column_name to expose in Master Code Epxlore
  dimension: edw_column_name {
    label: "EDW Column Name"
    description: "Name of the column that the Master Code belongs too."
    type: string
    sql: ${TABLE}.EDW_COLUMN_NAME ;;
  }

  dimension: master_code_long_description {
    label: "Master Code Long Description"
    description: "Description of the Value that is stored in the Source System Column. The Value is the Master Code, and is described here"
    type: string
    sql: ${TABLE}.MASTER_CODE_LONG_DESCRIPTION ;;
  }

  dimension: master_code_short_description {
    label: "Master Code Short Description"
    description: "Description of the Value that is stored in the Source System Column. The Value is the Master Code, and is described here"
    type: string
    sql: ${TABLE}.MASTER_CODE_SHORT_DESCRIPTION ;;
  }

  dimension: master_code_value {
    label: "Master Code Value"
    description: "Value that is found in the EDW Column, for which a description is necessary"
    type: string
    sql: ${TABLE}.MASTER_CODE_VALUE ;;
  }

  dimension: sort_order {
    label: "Sort Order"
    description: "Order in which the Master Code Values are sorted"
    type: number
    sql: ${TABLE}.SORT_ORDER ;;
  }

  dimension: source_system {
    label: "Source System"
    description: "Name of the source system, for which the Master Code Value belongs"
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM ;;
  }

  dimension: source_system_column {
    label: "Source System Column"
    description: "Name of the Column in the source system, for which the Master Code Value belongs"
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_COLUMN ;;
  }

  dimension: source_system_table {
    label: "Source System Table"
    description: "Name of the table in the source system, for which the Master Code Value belongs"
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_TABLE ;;
  }
}

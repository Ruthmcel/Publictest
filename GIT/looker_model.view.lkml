view: looker_model {
  sql_table_name: EDW.D_LOOKER_MODEL ;;

  dimension: has_content {
    type: string
    sql: ${TABLE}.HAS_CONTENT ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.PROJECT_NAME ;;
  }

  dimension: unlimited_db_connections {
    type: string
    sql: ${TABLE}.UNLIMITED_DB_CONNECTIONS ;;
  }

  measure: count {
    type: count
    drill_fields: [name, project_name]
  }
}

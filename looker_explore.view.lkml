view: looker_explore {
  sql_table_name: EDW.D_LOOKER_EXPLORE ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: can_explain {
    type: string
    sql: ${TABLE}.CAN_EXPLAIN ;;
  }

  dimension: can_pivot_in_db {
    type: string
    sql: ${TABLE}.CAN_PIVOT_IN_DB ;;
  }

  dimension: can_save {
    type: string
    sql: ${TABLE}.CAN_SAVE ;;
  }

  dimension: can_total {
    type: string
    sql: ${TABLE}.CAN_TOTAL ;;
  }

  dimension: connection_name {
    type: string
    sql: ${TABLE}.CONNECTION_NAME ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: errors {
    type: string
    sql: ${TABLE}.ERRORS ;;
  }

  dimension: files {
    type: string
    sql: ${TABLE}.FILES ;;
  }

  dimension: group_label {
    type: string
    sql: ${TABLE}.GROUP_LABEL ;;
  }

  dimension: has_timezone_support {
    type: string
    sql: ${TABLE}.HAS_TIMEZONE_SUPPORT ;;
  }

  dimension: hidden {
    type: string
    sql: ${TABLE}.HIDDEN ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}.MODEL_NAME ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: null_sort_treatment {
    type: string
    sql: ${TABLE}.NULL_SORT_TREATMENT ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.PROJECT_NAME ;;
  }

  dimension: source_file {
    type: string
    sql: ${TABLE}.SOURCE_FILE ;;
  }

  dimension: sql_table_name {
    type: string
    sql: ${TABLE}.SQL_TABLE_NAME ;;
  }

  dimension: supports_cost_estimate {
    type: string
    sql: ${TABLE}.SUPPORTS_COST_ESTIMATE ;;
  }

  dimension: view_name {
    type: string
    sql: ${TABLE}.VIEW_NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      connection_name,
      model_name,
      view_name,
      sql_table_name,
      project_name
    ]
  }
}

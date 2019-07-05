view: looker_explore_field {
  sql_table_name: EDW.D_LOOKER_EXPLORE_FIELD ;;

  dimension: align {
    type: string
    sql: ${TABLE}.ALIGN ;;
  }

  dimension: can_filter {
    type: string
    sql: ${TABLE}.CAN_FILTER ;;
  }

  dimension: default_filter_value {
    type: string
    sql: ${TABLE}.DEFAULT_FILTER_VALUE ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: enumerations {
    type: string
    sql: ${TABLE}.ENUMERATIONS ;;
  }

  dimension: explore_id {
    type: string
    sql: ${TABLE}.EXPLORE_ID ;;
  }

  dimension: field_group_label {
    type: string
    sql: ${TABLE}.FIELD_GROUP_LABEL ;;
  }

  dimension: field_group_variant {
    type: string
    sql: ${TABLE}.FIELD_GROUP_VARIANT ;;
  }

  dimension: field_type {
    type: string
    sql: ${TABLE}.FIELD_TYPE ;;
  }

  dimension: hidden {
    type: string
    sql: ${TABLE}.HIDDEN ;;
  }

  dimension: is_numeric {
    type: string
    sql: ${TABLE}.IS_NUMERIC ;;
  }

  dimension: label {
    type: string
    sql: ${TABLE}.LABEL ;;
  }

  dimension: label_short {
    type: string
    sql: ${TABLE}.LABEL_SHORT ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.PROJECT_NAME ;;
  }

  dimension: requires_refresh_on_sort {
    type: string
    sql: ${TABLE}.REQUIRES_REFRESH_ON_SORT ;;
  }

  dimension: scope {
    type: string
    sql: ${TABLE}.SCOPE ;;
  }

  dimension: sortable {
    type: string
    sql: ${TABLE}.SORTABLE ;;
  }

  dimension: source_file {
    type: string
    sql: ${TABLE}.SOURCE_FILE ;;
  }

  dimension: sql {
    type: string
    sql: ${TABLE}.SQL ;;
  }

  dimension: sql_case {
    type: string
    sql: ${TABLE}.SQL_CASE ;;
  }

  dimension: suggest_dimension {
    type: string
    sql: ${TABLE}.SUGGEST_DIMENSION ;;
  }

  dimension: suggest_explore {
    type: string
    sql: ${TABLE}.SUGGEST_EXPLORE ;;
  }

  dimension: suggestable {
    type: string
    sql: ${TABLE}.SUGGESTABLE ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension: value_format {
    type: string
    sql: ${TABLE}.VALUE_FORMAT ;;
  }

  dimension: view {
    type: string
    sql: ${TABLE}.VIEW ;;
  }

  dimension: view_label {
    type: string
    sql: ${TABLE}.VIEW_LABEL ;;
  }

  measure: count {
    type: count
    drill_fields: [name, project_name]
  }
}

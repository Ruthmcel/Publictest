view: hcahps_national {
  sql_table_name: REPORT_TEMP.HCAHPS_NATIONAL ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${hcahps_measure_id} ;;
  }

  dimension: hcahps_measure_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.HCAHPS_MEASURE_ID ;;
  }

  dimension: footnote {
    type: string
    sql: ${TABLE}.FOOTNOTE ;;
  }

  dimension: hcahps_answer_description {
    label: "HCAHPS Answer Description"
    type: string
    sql: ${TABLE}.HCAHPS_ANSWER_DESCRIPTION ;;
  }

  dimension: hcahps_question {
    label: "HCAHPS Question"
    type: string
    sql: ${TABLE}.HCAHPS_QUESTION ;;
  }

  dimension_group: measure_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MEASURE_START_DATE ;;
  }

  dimension_group: measure_end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MEASURE_END_DATE ;;
  }

  measure: total_measures {
    type: count
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: hcahps_answer_percent {
    label: "HCAHPS Answer %"
    type: sum
    sql: ${TABLE}.HCAHPS_ANSWER_PERCENT ;;
    value_format: "#,##0.00;(#,##0.00)"
  }
}

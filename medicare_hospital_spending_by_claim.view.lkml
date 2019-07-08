view: medicare_hospital_spending_by_claim {
  sql_table_name: REPORT_TEMP.MEDICARE_HOSPITAL_SPENDING_BY_CLAIM ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id}  ||'@'|| ${claim_type} ||'@'|| ${period};;
  }

########################################## foreign key references  ###########################################################

  dimension: provider_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: claim_type {
    type: string
    sql: ${TABLE}.CLAIM_TYPE ;;
  }

  dimension: period {
    type: string
    sql: ${TABLE}.PERIOD ;;
  }
#################################################################################################################################################

  dimension_group: start {
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
    sql: ${TABLE}.START_DATE ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.END_DATE ;;
  }

  dimension: hospital_name {
    hidden:  yes
    type: string
    sql: ${TABLE}.HOSPITAL_NAME ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.STATE ;;
  }

  measure: claim_count {
    type: count
  }

  measure: avg_spending_per_episode_hospital {
    type: average
    sql: ${TABLE}.AVG_SPENDING_PER_EPISODE_HOSPITAL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_spending_per_episode_nation {
    type: average
    sql: ${TABLE}.AVG_SPENDING_PER_EPISODE_NATION ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_spending_per_episode_state {
    type: average
    sql: ${TABLE}.AVG_SPENDING_PER_EPISODE_STATE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: percent_of_spending_hospital {
    type: sum
    hidden: yes
    sql: ${TABLE}.PERCENT_OF_SPENDING_HOSPITAL ;;
    value_format: "0.00%"
  }

  measure: percent_of_spending_nation {
    type: sum
    hidden: yes
    sql: ${TABLE}.PERCENT_OF_SPENDING_NATION ;;
    value_format: "0.00%"
  }

  measure: percent_of_spending_state {
    type: sum
    hidden: yes
    sql: ${TABLE}.PERCENT_OF_SPENDING_STATE ;;
    value_format: "0.00%"
  }
}

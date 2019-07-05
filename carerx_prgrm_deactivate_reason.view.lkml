view: carerx_prgrm_deactivate_reason {
  sql_table_name: MTM_CLINICAL.PROGRAM_DEACTIVATE_REASON ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: program_deactivated_reason {
    label: "Program Deactivated Reason"
    description: "The basic description of the program deactivation reason"
    type: string
    sql: ${TABLE}.REASON ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: deactivate_reason {
    label: "Deactivated Reason"
    description: "The date that the program was deactivate and the reason was added"
    type: time
    timeframes: [
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DEACTIVATE_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: count {
    label: "Deactivated Reason Count"
    description: "A count of Deactivated Reasons"
    type: count
    drill_fields: [program_deactivated_reason, deactivate_reason_date]
  }
}

################################################################################################## SETS #################################################################################################

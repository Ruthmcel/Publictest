view: carerx_third_party {
  sql_table_name: MTM_CLINICAL.THIRD_PARTY ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Dimensions #################################################################################################

  dimension: tp_name {
    label: "Third Party Name"
    description: "The Name of the Third Party"
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: tp_type {
    label: "Third Party Insurance Type"
    description: "The type of insurance coverage that the third party is billed as"
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  ##  --  There are 4 distinct values in this columns. M, D, C, B. M = Medical, P = Pharmacy but is not in database. (Change to CASE if definitions can be found)

  dimension: payer_identifier {
    label: "Payer ID"
    description: "The unique payer ID that is used to identify the third party in medical billing transactions"
    type: string
    sql: ${TABLE}.PAYER_IDENTIFIER ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: tp_deactivated {
    label: "Third Party Deactivated"
    description: "The date/time that the third party account was deactivated"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DEACTIVATE_DATE ;;
  }
}

view: hospital_measure_link {
  sql_table_name: REPORT_TEMP.PROVIDER_MEASURE_LINK ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id}  ||'@'|| ${measure_id} ;;
  }

  dimension: provider_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: measure_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.MEASURE_ID ;;
  }

  dimension: measure_name {
    hidden:  yes
    type: string
    sql: ${TABLE}.MEASURE_NAME ;;
  }

}

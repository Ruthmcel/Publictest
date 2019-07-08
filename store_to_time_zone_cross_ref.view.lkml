view: store_to_time_zone_cross_ref {
  sql_table_name: ETL_MANAGER.STORE_TO_TIME_ZONE_CROSS_REF ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.chain_id ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nhin_store_id ;;
  }

  dimension: time_zone {
    type: string
    sql: case ${TABLE}.time_zone
           when 'US/Atlantic' then 'America/New_York'
           else ${TABLE}.time_zone
      end
       ;;
  }
}

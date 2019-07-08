view: store_price_code_hist_listagg {
# ERXDWPS-5091 - View with derived SQL created to get the price_code history. All the history information for a price code populated with source_timestamp.
  derived_table: {
    sql: select chain_id
                ,nhin_store_id
                ,price_code_id
                ,source_system_id
                ,listagg(date_part(epoch_nanosecond, source_timestamp) || ',' || price_code, ',') within group (order by source_timestamp) price_code_hist
          from edw.d_store_price_code_hist
          where {% condition chain.chain_id %} chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
            and source_system_id = 4 --Only EPS data available now. We can remove the joins when PDX Store data available and tested.
            and price_code_deleted = 'N' --ERXDWPS-6181
            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                    where source_system_id = 5
                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                      and {% condition store.store_number %} store_number {% endcondition %})
          group by chain_id
                  ,nhin_store_id
                  ,price_code_id
                  ,source_system_id
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${price_code_id} ||'@'|| ${source_system_id} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: price_code_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PRICE_CODE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: price_code_hist {
    type: string
    hidden: yes
    sql: ${TABLE}.PRICE_CODE_HIST ;;
  }
}

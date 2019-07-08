view: bi_demo_store_price_code_hist_listagg {
# ERXDWPS-5091 - View with derived SQL created to get the price_code history. All the history information for a price code populated with source_timestamp.
  derived_table: {
    sql: select chain_id
                ,nhin_store_id
                ,price_code_id
                ,source_system_id
                ,listagg(date_part(epoch_nanosecond, source_timestamp) || ',' || price_code, ',') within group (order by source_timestamp) price_code_hist
          from edw.d_store_price_code_hist
          where chain_id IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
            and nhin_store_id IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
            and source_system_id = 4 --Only EPS data available now. We can remove the joins when PDX Store data available and tested.
            and price_code_deleted = 'N' --ERXDWPS-6181
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

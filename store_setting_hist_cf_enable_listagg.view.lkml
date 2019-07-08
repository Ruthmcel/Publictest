view: store_setting_hist_cf_enable_listagg {
# ERXDWPS-6802 - Meijer - Expose additional EPS Central Fill data (Facility / Formulary / Delivery Schedule)
# and source_system_id = 4 --Only EPS data available now. We can remove the joins when PDX Store data available and tested.
# ERXDWPS-6802 - View granularity is at chain, store, store_setting_name.
  derived_table: {
    sql: select chain_id
                ,nhin_store_id
                ,source_system_id
                ,lower(store_setting_name) as store_setting_name
                ,listagg(date_part(epoch_nanosecond, source_timestamp) || ',' || store_setting_value, ',') within group (order by source_timestamp) store_setting_hist
          from edw.d_store_setting_hist
          where {% condition chain.chain_id %} chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
            and lower(store_setting_name) = lower('storeflags.central-fill.enabled')
            and source_system_id = 4
            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                    where source_system_id = 5
                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                      and {% condition store.store_number %} store_number {% endcondition %}
                                 )
          group by chain_id
                  ,nhin_store_id
                  ,source_system_id
                  ,lower(store_setting_name)
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${source_system_id} ;;
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

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_setting_name {
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_NAME ;;
  }

  dimension: store_setting_hist {
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_HIST ;;
  }
}

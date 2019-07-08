view: store_last_filled {
  #[ERXLPS-1855] his view file is crated for last filled transaction date
  #[ERXLPS-1855] View will be used to join in Pharmacy explore to determine if a store information exists in store_alignemtn table or not.

  derived_table: {
    sql: select chain_id, nhin_store_id, max(rx_tx_fill_date) last_filled
          from edw.f_rx_tx_link
          where {% condition chain.chain_id %} CHAIN_ID {% endcondition %}
            and {% condition store.nhin_store_id %} NHIN_STORE_ID {% endcondition %}
            -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                    where source_system_id = 5
                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                      and {% condition store.store_number %} store_number {% endcondition %})
            and source_system_id = 4
            and rx_tx_fill_date <= current_timestamp() --Added to exclude future fill dates
          group by chain_id, nhin_store_id ;;
  }


  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ;;
  }

  #################################################################################################### DIMENSIONS ####################################################################################
  #ERXDWPS-8224- Fix Logic for the 'Pharmacy Exists in Store Alignment Table (Yes/No)' object
  dimension: exist_in_store_alignment {
    label: "Pharmacy Exists in Store Alignment Table having Fill"
    description: "Yes/No Flag indicating if the store information is present in the STORE_ALIGNMENT table and having atleast one transaction filled on this store"
    type: yesno
    sql: ${nhin_store_id} = ${store_alignment.nhin_store_id} ;;
  }

  dimension_group: last_fill {
    label: "Pharmacy Last Filled"
    description: "Latest Date/Time when a transaction was filled at the store. This field is EPS only!!!"
    type: time
    timeframes:[time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.LAST_FILLED ;;
  }
}

view: store_nursing_home_flag_fill_time {
# ERXDWPS-1549 Account for Nursing Home Flag on Prescription Transaction
# This view is added to determine point in time value of patient_nursing_home_flag at time of fill for PDX data.  For EPS patient_nursing_home_flag is computed using ltc_facilty_id.
# Derived query here just aggregate patient history records at patient level and combine all history (source_timestamp) using listagg in chronological order.This listgg values is than passed to Javascript point in time engine to determine point in time value.
# [ERXDWPS-5897] - Modified derived SQL to calulate nursing home flag at at tx level. Made this change to directly make the join with sales view.
# [ERXDWPS-5897] - Used liqiud variables to avoid table scanning when nursing home filter and/or filter is not used in sales explore. Due to looker behaviour we currently we are not able to avoid table join with nursing home view file and implemented work around.
  derived_table: {
    sql: {% if sales.consider_nh_as_sold._in_query or store_nursing_home_flag_fill_time.patient_nursing_home_flag_fill_time._in_query %}
          with patient_history as
          (
          select p.chain_id,
                      p.nhin_store_id,
                      p.patient_id,
                      p.source_system_id,
                      listagg(date_part(epoch_nanosecond, date_trunc('day', p.source_timestamp)) || ',' ||  nvl(p.patient_nursing_home_flag,'N') , ',') within group (order by p.source_timestamp) patient_nursing_home_flag_hist
                 from edw.d_store_patient_hist p
                where p.source_system_id = 11
                  and {% condition chain.chain_id %} p.chain_id {% endcondition %}
                  and {% condition store.nhin_store_id %} p.nhin_store_id {% endcondition %}
                  and p.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                            where source_system_id = 5
                                              and {% condition chain.chain_id %} chain_id {% endcondition %}
                                              and {% condition store.store_number %} store_number {% endcondition %})
                group by p.chain_id,
                         p.nhin_store_id,
                         p.patient_id,
                         p.source_system_id
          )
          select rt.chain_id,
                 rt.nhin_store_id,
                 rt.rx_tx_id,
                 rt.source_system_id,
                 case when rt.source_system_id = 11
                      then etl_manager.fn_get_value_as_of_date(patient_nursing_home_flag_hist, date_part(epoch_nanosecond, rt.rx_tx_fill_date))
                      else nvl2(rt.rx_tx_ltc_facility_id,'Y','N') end as patient_nursing_home_flag_fill_time
            from {% if _explore._name == 'sales' %}
                   {% assign active_archive_filter_input_value = sales.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                   {% if active_archive_filter_input_value == 'archive'  %}
                     edw.f_rx_tx_link_archive rt
                     left outer join edw.f_rx_archive r
                   {% else %}
                     edw.f_rx_tx_link rt
                     left outer join edw.f_rx r
                   {% endif %}
                 {% else %}
                     edw.f_rx_tx_link rt
                     left outer join edw.f_rx r
                 {% endif %}
               on rt.chain_id = r.chain_id
              and rt.nhin_store_id = r.nhin_store_id
              and rt.rx_id = r.rx_id
              and rt.source_system_id = r.source_system_id
              and rt.rx_tx_tx_deleted = 'N'
              and r.rx_deleted = 'N'
            left outer join patient_history ph
               on r.chain_id = ph.chain_id
              and r.nhin_store_id = ph.nhin_store_id
              and r.rx_patient_id = ph.patient_id
              and r.source_system_id = ph.source_system_id
            where {% condition chain.chain_id %} rt.chain_id {% endcondition %}
              and {% condition store.nhin_store_id %} rt.nhin_store_id {% endcondition %}
              and rt.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                        where source_system_id = 5
                                          and {% condition chain.chain_id %} chain_id {% endcondition %}
                                          and {% condition store.store_number %} store_number {% endcondition %})
        {% else %}
        select 1 chain_id,
               1 nhin_store_id,
               1 rx_tx_id,
               1 source_system_id,
               1 patient_nursing_home_flag_fill_time
        {% endif %}
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assigned to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: patient_id {
    #label: "Store Patient Id"
    type: string
    description: "Unique ID of the Patient record"
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_nursing_home_flag_hist {
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_NURSING_HOME_FLAG_HIST ;;
  }

  #ERXDWPS-1549 Account for Nursing Home Flag on Prescription Transaction
  dimension: patient_nursing_home_flag_fill_time {
    label: "TX Nursing Home Flag (Derived)"
    description: "Y/N flag indicating if a prescription transaction was filled while patient was in a Nursing Home. For Classic Stores, Fill date is used to determine Patient Nursing Home flag at the time of fill. For EPS Store, transactions with LTC FACILITY ID populated are considered."
    type: string
    sql: ${TABLE}.PATIENT_NURSING_HOME_FLAG_FILL_TIME ;;
  }
}

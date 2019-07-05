view: bi_demo_medispan_rx_tx_drug_cost_hist {
  derived_table: {
    sql:
        select chain_id,
               nhin_store_id,
               rx_tx_id,
               max(case when drug_cost_type = 'AAWP' then rx_tx_cost_at_fill    end) as rx_tx_aawp_cost_at_fill,
               max(case when drug_cost_type = 'ACF'  then rx_tx_cost_at_fill    end) as rx_tx_acf_cost_at_fill,
               max(case when drug_cost_type = 'AWP'  then drug_cost_unit_amount end) as medispan_drug_awp_cost_unit_amount,
               max(case when drug_cost_type = 'AWP'  then rx_tx_cost_at_fill    end) as rx_tx_awp_cost_at_fill,
               max(case when drug_cost_type = 'DP'   then rx_tx_cost_at_fill    end) as rx_tx_dp_cost_at_fill,
               max(case when drug_cost_type = 'GEAP' then rx_tx_cost_at_fill    end) as rx_tx_geap_cost_at_fill,
               max(case when drug_cost_type = 'MAC'  then rx_tx_cost_at_fill    end) as rx_tx_mac_cost_at_fill,
               max(case when drug_cost_type = 'NADC' then rx_tx_cost_at_fill    end) as rx_tx_nadc_cost_at_fill,
               max(case when drug_cost_type = 'NADG' then rx_tx_cost_at_fill    end) as rx_tx_nadg_cost_at_fill,
               max(case when drug_cost_type = 'NADI' then rx_tx_cost_at_fill    end) as rx_tx_nadi_cost_at_fill,
               max(case when drug_cost_type = 'NADS' then rx_tx_cost_at_fill    end) as rx_tx_nads_cost_at_fill,
               max(case when drug_cost_type = 'WAA'  then rx_tx_cost_at_fill    end) as rx_tx_waa_cost_at_fill,
               max(case when drug_cost_type = 'WAC'  then rx_tx_cost_at_fill    end) as rx_tx_wac_cost_at_fill
          from (select *,
                       drug_cost_unit_amount * rx_tx_fill_quantity as rx_tx_cost_at_fill
                from (select tx.chain_id,
                             tx.nhin_store_id,
                             tx.rx_tx_id,
                             tx.rx_tx_fill_quantity,
                             drug_cost_hist.ndc,
                             drug_cost_hist.drug_cost_type,
                             drug_cost_hist.drug_cost_unit_amount,
                             row_number() over(partition by tx.chain_id, tx.nhin_store_id, tx.rx_tx_id, drug_cost_hist.drug_cost_type order by drug_cost_hist.source_timestamp desc) rnk
                        from (select tx.chain_id,
                                     tx.nhin_store_id,
                                     tx.rx_tx_id,
                                     tx.rx_tx_fill_quantity,
                                     tx.rx_tx_fill_date,
                                     d.store_drug_ndc
                                from edw.f_rx_tx_link tx
                                left outer join edw.d_store_drug d
                                  on d.chain_id = tx.chain_id
                                 and d.nhin_store_id = tx.nhin_store_id
                                 and d.drug_id = tx.rx_tx_drug_dispensed_id
                                 and d.store_drug_deleted = 'N'
                                 and d.source_system_id = 4
                               where tx.chain_id in (select distinct chain_id from report_temp.bi_demo_chain_store_mapping where {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                                 and tx.nhin_store_id in (select distinct nhin_store_id from report_temp.bi_demo_chain_store_mapping where {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
                                 and tx.is_active = 'Y'
                                 and tx.source_system_id = 4
                             ) tx
                        left outer join edw.d_drug_cost_hist drug_cost_hist
                          on (tx.store_drug_ndc = drug_cost_hist.ndc
                         and drug_cost_hist.chain_id = 3000
                         and drug_cost_hist.source_system_id = 16
                         and drug_cost_hist.drug_cost_source = 'M'
                         and drug_cost_hist.drug_cost_deleted = 'N'
                         and drug_cost_hist.source_timestamp <= tx.rx_tx_fill_date)
                     )
                 where rnk = 1
               )
         group by chain_id,
                  nhin_store_id,
                  rx_tx_id
 ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id} ;;
  }

  #################################################################################################### Foreign Key References #####################################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Cost History Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    label: "Drug Cost History NHIN Store ID"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    hidden: yes
    type: number
    label: "Drug Cost History Prescription Transaction Identifier"
    sql: ${TABLE}.RX_TX_ID ;;
  }

  #################################################################################################### Reference Dimension #######################################################################################

  dimension: rx_tx_aawp_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_AAWP_COST_AT_FILL ;;
  }

  dimension: rx_tx_acf_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_ACF_COST_AT_FILL ;;
  }

  dimension: medispan_drug_awp_cost_unit_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_AWP_COST_UNIT_AMOUNT ;;
  }

  dimension: rx_tx_awp_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_AWP_COST_AT_FILL ;;
  }

  dimension: rx_tx_dp_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_DP_COST_AT_FILL ;;
  }

  dimension: rx_tx_geap_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_GEAP_COST_AT_FILL ;;
  }

  dimension: rx_tx_mac_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_MAC_COST_AT_FILL ;;
  }

  dimension: rx_tx_nadc_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_NADC_COST_AT_FILL ;;
  }

  dimension: rx_tx_nadg_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_NADG_COST_AT_FILL ;;
  }

  dimension: rx_tx_nadi_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_NADI_COST_AT_FILL ;;
  }

  dimension: rx_tx_nads_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_NADS_COST_AT_FILL ;;
  }

  dimension: rx_tx_waa_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_WAA_COST_AT_FILL ;;
  }

  dimension: rx_tx_wac_cost_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_WAC_COST_AT_FILL ;;
  }
}

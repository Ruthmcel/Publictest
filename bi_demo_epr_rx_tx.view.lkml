view: bi_demo_epr_rx_tx {
  derived_table: {
    sql: -- derived sql to select only active patient transactions from EPR rx tx and patient based on survivor is and unmerge date.
      select r.chain_id,
             r.nhin_store_id,
             r.rx_tx_rx_number,
             r.rx_tx_tx_number,
             r.rx_tx_id,
             r.rx_com_id,
             r.prescriber_id
        from edw.f_rx_tx r,
             edw.d_patient p
       where r.chain_id = p.chain_id
         and r.rx_com_id = p.rx_com_id
         and p.patient_survivor_id is null
         and p.patient_unmerged_date is null
         and r.chain_id IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
         and r.nhin_store_id IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
         and r.rx_tx_rx_deleted = 'N'
         and r.rx_tx_tx_deleted = 'N'
       ;;
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

  dimension: rx_number {
    label: "Prescription RX Number"
    description: "Prescription number"
    type: number
    sql: ${TABLE}.RX_TX_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: tx_number {
    label: "Prescription TX Number"
    description: "Transaction number"
    type: number
    sql: ${TABLE}.RX_TX_TX_NUMBER ;;
    value_format: "####"
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_number} ||'@'|| ${tx_number} ;; #ERXLPS-1649
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    # Primary key in source
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: prescriber_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PRESCRIBER_ID ;;
  }
}

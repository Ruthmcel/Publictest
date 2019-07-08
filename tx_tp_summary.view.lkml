view: tx_tp_summary {
  # 1. This new view file is specifically created around claims to determine the order of the sequence so the patient copay or any other summary that needs to rolled up and shown against RX_TX can be utilized from here.
  # 2. Also looker cannot directly invoke analytical functions directly in a field sql, it has to be invoked within a derived table
  # 3. Performance Improvement Changes for Derived View
  #       - Chain Access Filter will also be applied to this derived table, if Row Level Security is enforced which would be the default behavior if any elements from this view is included in Customer DSS Model
  #       - filter Applied on Chain & NHIN STORE ID by default so if a specific chain or store is selected, only the specific chain and store would be selected instead of reading data for ALL CHAINS, STORES. Note: Access filter Will Still be applied if enforced.
  #             For example: If Chain 70 and 168 is selected, only 70 will be extracted at the end, if view is used in Customer DSS Model. If Chain 70 and NHIN_STORE_ID 109638 is selected, then only those records pertaining to chain 70 and the store 109638 would be selected even if there are records for other chain or store in this table.
  #       - The templated filters are not explicitly defined as the filter parameter as the field picker "Pharmacy NHIN Store ID" in the explore would correctly handle the store being selected


  derived_table: {
    sql: SELECT CHAIN_ID, NHIN_STORE_ID,RX_TX_ID,TX_TP_ID,TX_TP_PAID_STATUS,TX_TP_FINAL_COPAY,TX_TP_CLAIM_COUNT,TX_TP_SEQUENCE
      FROM
      ( SELECT
        CHAIN_ID,
        NHIN_STORE_ID,
        RX_TX_ID,
        TX_TP_ID,
        TX_TP_PAID_STATUS,
        TX_TP_FINAL_COPAY,
        COUNT(*) OVER (PARTITION BY T.CHAIN_ID, T.NHIN_STORE_ID, T.RX_TX_ID) AS TX_TP_CLAIM_COUNT,
        ROW_NUMBER() OVER (PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID ORDER BY NVL(TX_TP_COUNTER,0) DESC) AS TX_TP_SEQUENCE
        FROM EDW.F_TX_TP T
        WHERE {% condition chain.chain_id %} CHAIN_ID {% endcondition %}
        AND {% condition store.nhin_store_id %} NHIN_STORE_ID {% endcondition %}
        -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
        AND nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                where source_system_id = 5
                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                  and {% condition store.store_number %} store_number {% endcondition %})
        AND TX_TP_DELETED = 'N'
      )
      WHERE TX_TP_SEQUENCE = 1 -- The final Sequence has the correct patient copay
       ;;
  }

  dimension: tx_tp_id {
    hidden: yes
    label: "Transaction Third Party ID"
    description: "Unique ID number identifying an transaction third part record within a pharmacy chain, in EPR"
    type: number
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${tx_tp_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

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

  dimension: rx_tx_id {
    hidden: yes
    label: "Prescription Transaction ID"
    description: "Unique ID number identifying an prescription transaction record within a pharmacy chain, in EPR"
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  #################################################################################################### Dimensions ##################################################################################################

  #     field used for determinging 100% copay transactions
  dimension: patient_final_copay {
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: number
    sql: ${TABLE}.TX_TP_FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # This is an analytical count, and it not an actual count. If an actual count is ever needed, do not reference the CLAIM_COUNT column, do a measure count without an object reference
  dimension: claim_count {
    label: "Claim Count"
    type: number
    sql: ${TABLE}.TX_TP_CLAIM_COUNT ;;
    value_format: "#,##0"
  }

  ####################################################################################################### Measures ####################################################################################################

  measure: sum_patient_final_copay {
    label: "Patient Final Copay"
    description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user"
    type: sum
    sql: ${TABLE}.TX_TP_FINAL_COPAY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

view: bi_demo_rx_tx_drug_cost_hist {
  # ERXLPS-134: This view is primarily added to show AWP Cost of the Drug and Prescription Transaction AWP Cost at the time of the fill, only for EPS transactional dataset & may be extended to Classic in the future.
  # ERXLPS-134: Currently the latest Drug Cost Amount at the time of fill is selected irrespective of Drug Cost Region. This will be changed to pick all cost regions once we get the store region from store settings and region will be included as a part of the join condition while using the information from pharmacy drug cost region & the cost would also be based on the cost information available at the store at the time of dispensing instead of using the Cost information residing in HOST.
  #[ERXLPS-2295] - Logic added to calculate Drug Cost at the time of fill for AWP, WAC, ACQ, REG, MAC, STD and DP
  derived_table: {
    sql: SELECT chain_id,
       nhin_store_id,
       rx_tx_id,
       store_drug_ndc,
       max(CASE WHEN drug_cost_type = 'AWP' THEN drug_cost END) as drug_awp_cost,
       max(CASE WHEN drug_cost_type = 'AWP' THEN drug_cost_per_unit_amount END) as drug_awp_cost_per_unit_amount,
       max(CASE WHEN drug_cost_type = 'AWP' THEN rx_tx_cost_at_fill END) as rx_tx_awp_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'WAC' THEN rx_tx_cost_at_fill END) as rx_tx_wac_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'ACQ' THEN rx_tx_cost_at_fill END) as rx_tx_acq_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'REG' THEN rx_tx_cost_at_fill END) as rx_tx_reg_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'MAC' THEN rx_tx_cost_at_fill END) as rx_tx_mac_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'STD' THEN rx_tx_cost_at_fill END) as rx_tx_std_cost_at_fill,
       max(CASE WHEN drug_cost_type = 'DP' THEN rx_tx_cost_at_fill END) as rx_tx_dp_cost_at_fill
FROM   (SELECT tx.chain_id,
               tx.nhin_store_id,
               tx.rx_tx_id,
               d.store_drug_ndc,
               dch.drug_cost_type,
               d.store_drug_package_size,
               dch.drug_cost_amount AS drug_cost,
               tx.rx_tx_fill_quantity,
               (dch.drug_cost_amount/nullif(d.store_drug_package_size, 0)) as drug_cost_per_unit_amount,
               ((dch.drug_cost_amount/nullif(d.store_drug_package_size, 0))*tx.rx_tx_fill_quantity) as rx_tx_cost_at_fill, -- ( (Cost of the Drug for respective drug cost type, divided by drug cost per unit amount (i.e. Decimal Pack size of the Drug)), multiplied by decimal fill quantity of the transaction at the time of dispensing )
               tx.rx_tx_price, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
               ROW_NUMBER()
                 OVER(
                   partition BY tx.chain_id, tx.nhin_store_id, tx.rx_tx_id, dch.drug_cost_type
                   ORDER BY dch.source_timestamp DESC) rnk
        FROM   edw.f_rx_tx_link tx
               LEFT OUTER JOIN edw.d_store_drug d
               ON d.chain_id = tx.chain_id
               AND d.nhin_store_id = tx.nhin_store_id
               AND d.drug_id = tx.rx_tx_drug_dispensed_id --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
               AND d.store_drug_deleted = 'N'
               AND d.source_system_id = 4
               LEFT OUTER JOIN edw.d_drug_cost_hist dch
                            ON ( dch.chain_id = d.chain_id
                                 AND dch.ndc = d.store_drug_ndc
                                 AND UPPER(dch.drug_cost_type) IN ('AWP', 'WAC', 'ACQ', 'REG', 'MAC', 'STD', 'DP')
                                 AND dch.source_timestamp <= tx.rx_tx_fill_date )
        WHERE tx.chain_id IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
        AND tx.nhin_store_id IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
        AND tx.source_system_id = 4
       ) rx_tx_dch
WHERE  rx_tx_dch.rnk = 1
GROUP BY chain_id,
         nhin_store_id,
         rx_tx_id,
         store_drug_ndc
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
  dimension: drug_awp_cost_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_AWP_COST ;;
  }

  dimension: drug_awp_cost_per_unit_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT ;;
  }

  dimension: rx_tx_awp_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_AWP_COST_AT_FILL ;;
  }

  dimension: rx_tx_wac_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_WAC_COST_AT_FILL ;;
  }

  dimension: rx_tx_acq_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_ACQ_COST_AT_FILL ;;
  }

  dimension: rx_tx_reg_cost_amount_at_fill_reference {
    hidden:yes
    type: number
    sql: ${TABLE}.RX_TX_REG_COST_AT_FILL ;;
  }

  dimension: rx_tx_mac_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_MAC_COST_AT_FILL ;;
  }

  dimension: rx_tx_std_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_STD_COST_AT_FILL ;;
  }

  dimension: rx_tx_dp_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_DP_COST_AT_FILL ;;
  }

  #################################################################################################### Measures #########################################################################################################
  measure: sum_drug_awp_cost_amount {
    label: "Total HOST Drug AWP Amount"
    description: "Represents the Average Wholesale Price of the HOST Drug at the time of fill. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_awp_cost_per_unit_amount {
    label: "Total HOST Drug AWP Per Unit Amount"
    description: "Represents the Average Wholesale Price of the HOST Drug Per Unit Amount at the time of fill. (Calculation Used: HOST Drug AWP Amount/Decimal Pack Size). This field is EPS only!!!"
    type: number
    #[ERXLPS-1347] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
    sql: ( SUM(DISTINCT (CAST(FLOOR(${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${TABLE}.CHAIN_ID||'@'||${TABLE}.NHIN_STORE_ID||'@'||${TABLE}.RX_TX_ID ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${TABLE}.CHAIN_ID||'@'||${TABLE}.NHIN_STORE_ID||'@'||${TABLE}.RX_TX_ID ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_rx_tx_awp_cost_amount_at_fill {
    label: "Total AWP Amount At Fill - HOST"
    description: "Represents the Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug AWP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_AWP_COST_AT_FILL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################################# Sets###################################################################################
  set: explore_rx_drug_cost_hist_4_10_candidate_list {
    fields: [sum_drug_awp_cost_amount, sum_drug_awp_cost_per_unit_amount, sum_rx_tx_awp_cost_amount_at_fill]
  }
}
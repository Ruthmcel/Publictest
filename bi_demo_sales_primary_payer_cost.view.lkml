view: bi_demo_sales_primary_payer_cost {
  #[ERXLPS-2321] - view name created as bi_demo_sales_primary_payer_cost. Other primary cost can be added to this view in future if we comeup with any.
  derived_table: {
    sql: select *
          from (select tp.chain_id,
                       tp.nhin_store_id,
                       tp.rx_tx_id,
                       tsd.tx_tp_submit_detail_ingredient_cost as primary_payer_submitted_ingredient_cost,
                       --pick latest submit_detail record of primary payer
                       row_number() over(partition by tp.chain_id, tp.nhin_store_id, tp.rx_tx_id order by nvl(tp.tx_tp_counter, -1) asc, tsd.tx_tp_submit_detail_id desc nulls last) rnk
                  from edw.f_tx_tp_link tp
                  left outer join edw.f_tx_tp_transmit_queue ttq
                  on tp.chain_id = ttq.chain_id and tp.nhin_store_id = ttq.nhin_store_id and tp.tx_tp_id = ttq.tx_tp_id and ttq.tx_tp_transmit_queue_deleted = 'N'
                  left outer join edw.f_tx_tp_submit_detail tsd
                  on ttq.chain_id = tsd.chain_id and ttq.nhin_store_id = tsd.nhin_store_id and ttq.tx_tp_transmit_queue_id = tsd.tx_tp_submit_detail_id
                  where tp.chain_id in (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
                  and tp.nhin_store_id in (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
                  and (tp.tx_tp_paid_status in (1, 2, 3, 4, 5) or tp.tx_tp_submit_type = 'D')  -- added status 3 to match SASD logic, however, do not agree this status should live on tx_tp record
                  and tp.tx_tp_inactive = 'N'
                  and tp.source_system_id = 4
             )
          where rnk = 1 ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;;
  }

  ####################################################################################### Foreign Key ##########################################################################
  dimension: chain_id {
    type: number
    hidden: yes
    # primary key in source
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }
  ####################################################################################### End of Foreign Key ##########################################################################

  ####################################################################################### dimensions ################################################################################
  dimension: primary_payer_submitted_ingredient_cost {
    label: "Primary Payer Submitted Ingredient Cost"
    description: "Primary Payer Submitted Ingredient Cost of a transaction. EPS Table Name: TP_SUBMIT_CLAIM_DETAIL"
    type: number
    sql: ${TABLE}.PRIMARY_PAYER_SUBMITTED_INGREDIENT_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ####################################################################################### measures ###################################################################################
  measure: sum_primary_payer_submitted_ingredient_cost {
    label: "Primary Payer Submitted Ingredient Cost"
    description: "Primary Payer Submitted Ingredient Cost of a transaction. EPS Table Name: TP_SUBMIT_CLAIM_DETAIL"
    type: sum
    sql: ${TABLE}.PRIMARY_PAYER_SUBMITTED_INGREDIENT_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

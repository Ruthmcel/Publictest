view: sales_primary_payer_cost {
  #[ERXLPS-2321] - view name created as sales_primary_payer_cost. Other primary cost can be added to this view in future if we comeup with any.
  derived_table: {
    sql: select *
          from (select tp.chain_id,
                       tp.nhin_store_id,
                       tp.rx_tx_id,
                       tsd.tx_tp_submit_detail_ingredient_cost as primary_payer_submitted_ingredient_cost,
                       --pick latest submit_detail record of primary payer
                       row_number() over(partition by tp.chain_id, tp.nhin_store_id, tp.rx_tx_id order by nvl(tp.tx_tp_counter, -1) asc, tsd.tx_tp_submit_detail_id desc nulls last) rnk
                  from {% if _explore._name == 'sales' %}
                         {% assign active_archive_filter_input_value = sales.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                         {% if active_archive_filter_input_value == 'archive'  %}
                           EDW.F_TX_TP_LINK_ARCHIVE tp
                         {% else %}
                           EDW.F_TX_TP_LINK tp
                         {% endif %}
                       {% else %}
                         EDW.F_TX_TP_LINK tp
                       {% endif %}
                  left outer join edw.f_tx_tp_transmit_queue ttq
                  on tp.chain_id = ttq.chain_id and tp.nhin_store_id = ttq.nhin_store_id and tp.tx_tp_id = ttq.tx_tp_id and ttq.tx_tp_transmit_queue_deleted = 'N'
                  left outer join edw.f_tx_tp_submit_detail tsd
                  on ttq.chain_id = tsd.chain_id and ttq.nhin_store_id = tsd.nhin_store_id and ttq.tx_tp_transmit_queue_id = tsd.tx_tp_submit_detail_id
                  where {% condition chain.chain_id %} tp.chain_id {% endcondition %}
                  and {% condition store.nhin_store_id %} tp.nhin_store_id {% endcondition %}
                  -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                  and tp.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                            where source_system_id = 5
                                              and {% condition chain.chain_id %} chain_id {% endcondition %}
                                              and {% condition store.store_number %} store_number {% endcondition %})
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
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id}||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;;
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

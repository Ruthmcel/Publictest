# Copy of eps_task_history_gap_time_per_transaction for CUSTOMER_DEMO model

view: bi_demo_eps_task_history_gap_time_per_transaction {

  derived_table: {
    sql:  with task_history
            as (select task_history_id,
                       chain_id,
                       nhin_store_id,
                       rx_tx_id,
                       upper(task_history_task_name) task_history_task_name,
                       case when upper(task_history_task_action) = 'GETNEXT' then 'START'
                            when upper(task_history_task_action) = 'PUTBACK_CHECKED_OUT_TASK' then 'PUTBACK'
                            else upper(task_history_task_action)
                       end task_history_task_action,
                       date_part(epoch_nanosecond, task_history_action_date) task_history_action_date
                  from
                        {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                          {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                          {% if active_archive_filter_input_value == 'archive'  %}
                            EDW.F_TASK_HISTORY_ARCHIVE
                          {% else %}
                            EDW.F_TASK_HISTORY
                          {% endif %}
                        {% else %}
                          EDW.F_TASK_HISTORY
                        {% endif %}
                 where upper(task_history_task_action) in (
                                                           'START',
                                                           'GETNEXT',
                                                           'COMPLETE',
                                                           'PUTBACK',
                                                           'PUTBACK_CHECKED_OUT_TASK'
                                                          )
                   and upper(task_history_task_name) in (
                                                         'ORDER_ENTRY',
                                                         'DATA_ENTRY',
                                                         'DATA_VERIFICATION',
                                                         'ESCRIPT_DATA_ENTRY',
                                                         'FILL',
                                                         'PRODUCT_VERIFICATION',
                                                         'WILL_CALL',
                                                         'RX_FILLING',
                                                         'DUR_DISPLAY',
                                                         'INVISIBLE_FILL',
                                                         upper({% parameter eps_rx_tx.source_task %}),
                                                         upper({% parameter eps_rx_tx.target_task %})
                                                        )
                   and rx_tx_id is not null
                   and chain_id in (select distinct chain_id from report_temp.bi_demo_chain_store_mapping  where {% condition bi_demo_store.bi_demo_nhin_store_id %} nhin_store_id_bi_demo_mapping {% endcondition %})
                   and nhin_store_id in (select distinct nhin_store_id from report_temp.bi_demo_chain_store_mapping where {% condition bi_demo_store.bi_demo_nhin_store_id %} nhin_store_id_bi_demo_mapping {% endcondition %})
                ),
            task_history_filtered
            as (select t.task_history_id,
                       t.chain_id,
                       t.nhin_store_id,
                       t.rx_tx_id,
                       t.task_history_task_name,
                       t.task_history_task_action,
                       t.task_history_action_date
                  from task_history t,
                        {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                          {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                          {% if active_archive_filter_input_value == 'archive'  %}
                            EDW.F_RX_ARCHIVE r,
                          {% else %}
                            EDW.F_RX r,
                          {% endif %}
                        {% else %}
                          EDW.F_RX r,
                        {% endif %}
                        {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                          {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                          {% if active_archive_filter_input_value == 'archive'  %}
                            EDW.F_RX_TX_LINK_ARCHIVE l
                          {% else %}
                            EDW.F_RX_TX_LINK l
                          {% endif %}
                        {% else %}
                          EDW.F_RX_TX_LINK l
                        {% endif %}
                where r.chain_id = l.chain_id
                   and r.nhin_store_id = l.nhin_store_id
                   and r.rx_id = l.rx_id
                   and {% condition eps_rx_tx.rx_tx_fill_location %} case l.rx_tx_fill_location when 'A' then 'ACS System' when 'L' then 'Local Pharmacy' when 'M' then 'Mail Order' when 'C' then 'Central Fill' else 'Unknown' end {% endcondition %}
                   and {% condition eps_rx_tx.rx_tx_tx_number %} l.rx_tx_tx_number {% endcondition %}
                   and {% condition eps_rx_tx.rx_tx_refill_number %} l.rx_tx_refill_number {% endcondition %}
                   and r.chain_id = t.chain_id
                   and r.nhin_store_id = t.nhin_store_id
                   and l.rx_tx_id = t.rx_tx_id
                   and l.source_system_id = 4
                   and r.source_system_id = 4
               ),
            task_history_grouped
            as (select chain_id,
                       nhin_store_id,
                       rx_tx_id,
                       listagg(task_history_task_name || ',' || task_history_task_action || ',' || task_history_action_date, ',') within group(order by task_history_id) task_list
                  from task_history_filtered
                 group by chain_id,
                          nhin_store_id,
                          rx_tx_id
               ),
            gap_time
            as (select chain_id,
                       nhin_store_id,
                       rx_tx_id,
                       ',' || etl_manager.fn_get_task_gap_time(task_list, 'TRANSACTION', upper({% parameter eps_rx_tx.source_task %}), upper({% parameter eps_rx_tx.target_task %})) gap_time_str
                  from task_history_grouped
               ),
            gap_time_extract
            as (select chain_id,
                       nhin_store_id,
                       rx_tx_id,
                       regexp_substr(regexp_substr(gap_time_str,',ORDER_ENTRY:DATA_ENTRY,[0-9]*'),'[0-9]*$') wf_oe_de_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',ORDER_ENTRY:DATA_VERIFICATION,[0-9]*'),'[0-9]*$') wf_oe_dv_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',ORDER_ENTRY:FILL,[0-9]*'),'[0-9]*$') wf_oe_fill_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',DATA_ENTRY:DATA_VERIFICATION,[0-9]*'),'[0-9]*$') wf_de_dv_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',ESCRIPT_DATA_ENTRY:DATA_VERIFICATION,[0-9]*'),'[0-9]*$') wf_escript_de_dv_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',DATA_VERIFICATION:FILL,[0-9]*'),'[0-9]*$') wf_dv_fill_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',FILL:PRODUCT_VERIFICATION,[0-9]*'),'[0-9]*$') wf_fill_pv_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',PRODUCT_VERIFICATION:WILL_CALL,[0-9]*'),'[0-9]*$') wf_pv_wc_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',RX_FILLING:INVISIBLE_FILL,[0-9]*'),'[0-9]*$') rf_rx_fill_fill_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',RX_FILLING:DUR_DISPLAY,[0-9]*'),'[0-9]*$') rf_rx_fill_rph_verify_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',INVISIBLE_FILL:DUR_DISPLAY,[0-9]*'),'[0-9]*$') rf_fill_rph_verify_gap_time,
                       regexp_substr(regexp_substr(gap_time_str,',DUR_DISPLAY:WILL_CALL,[0-9]*'),'[0-9]*$') rf_rph_verify_will_call_gap_time,
                       regexp_substr(regexp_substr(gap_time_str, ',' || upper({% parameter eps_rx_tx.source_task %}) || ':' || upper({% parameter eps_rx_tx.target_task %}) || ',[0-9]*'),'[0-9]*$') source_target_gap_time
                  from gap_time
               )
            select chain_id,
                   nhin_store_id,
                   rx_tx_id,
                   case when wf_oe_de_gap_time is not null then round(wf_oe_de_gap_time/1000000000/60,2) else null end wf_oe_de_gap_time,
                   case when wf_oe_dv_gap_time is not null then round(wf_oe_dv_gap_time/1000000000/60,2) else null end wf_oe_dv_gap_time,
                   case when wf_oe_fill_gap_time is not null then round(wf_oe_fill_gap_time/1000000000/60,2) else null end wf_oe_fill_gap_time,
                   case when wf_de_dv_gap_time is not null then round(wf_de_dv_gap_time/1000000000/60,2) else null end wf_de_dv_gap_time,
                   case when wf_escript_de_dv_gap_time is not null then round(wf_escript_de_dv_gap_time/1000000000/60,2) else null end wf_escript_de_dv_gap_time,
                   case when wf_dv_fill_gap_time is not null then round(wf_dv_fill_gap_time/1000000000/60,2) else null end wf_dv_fill_gap_time,
                   case when wf_fill_pv_gap_time is not null then round(wf_fill_pv_gap_time/1000000000/60,2) else null end wf_fill_pv_gap_time,
                   case when wf_pv_wc_gap_time is not null then round(wf_pv_wc_gap_time/1000000000/60,2) else null end wf_pv_wc_gap_time,
                   case when rf_rx_fill_fill_gap_time is not null then round(rf_rx_fill_fill_gap_time/1000000000/60,2) else null end rf_rx_fill_fill_gap_time,
                   case when rf_rx_fill_rph_verify_gap_time is not null then round(rf_rx_fill_rph_verify_gap_time/1000000000/60,2) else null end rf_rx_fill_rph_verify_gap_time,
                   case when rf_fill_rph_verify_gap_time is not null then round(rf_fill_rph_verify_gap_time/1000000000/60,2) else null end rf_fill_rph_verify_gap_time,
                   case when rf_rph_verify_will_call_gap_time is not null then round(rf_rph_verify_will_call_gap_time/1000000000/60,2) else null end rf_rph_verify_will_call_gap_time,
                   case when source_target_gap_time is not null then round(source_target_gap_time/1000000000/60,2) else null end source_target_gap_time
              from gap_time_extract
        ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' ||  ${rx_tx_id} ;;
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
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  ####################################################################################################### Measures ####################################################################################################

  measure: sum_oe_de_gap_time {
    label: "Order Entry to Data Entry (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Order Entry and Data Entry. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_de_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_de_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_de_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_de_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_oe_de_gap_time {
    label: "Order Entry to Data Entry (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Order Entry and Data Entry. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql:  ${TABLE}.wf_oe_de_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_oe_de_gap_time {
    label: "Order Entry to Data Entry (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Order Entry and Data Entry. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_de_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_de_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_de_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_de_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_oe_de_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_oe_dv_gap_time {
    label: "Order Entry to Data Verification (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Order Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_oe_dv_gap_time {
    label: "Order Entry to Data Verification (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Order Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql:  ${TABLE}.wf_oe_dv_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_oe_dv_gap_time {
    label: "Order Entry to Data Verification (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Order Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_oe_dv_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_oe_fill_gap_time {
    label: "Order Entry to Fill (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Order Entry and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_oe_fill_gap_time {
    label: "Order Entry to Fill (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Order Entry and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql:  ${TABLE}.wf_oe_fill_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_oe_fill_gap_time {
    label: "Order Entry to Fill (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Order Entry and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql:  ${TABLE}.wf_oe_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_oe_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_oe_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_oe_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_oe_fill_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_de_dv_gap_time  {
    label: "Data Entry to Data Verification (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_de_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_de_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_de_dv_gap_time  {
    label: "Data Entry to Data Verification (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.wf_de_dv_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_de_dv_gap_time  {
    label: "Data Entry to Data Verification (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_de_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_de_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_de_dv_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_escript_de_dv_gap_time  {
    label: "EScript Data Entry to Data Verification (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between EScript Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_escript_de_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_escript_de_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_escript_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_escript_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_escript_de_dv_gap_time  {
    label: "EScript Data Entry to Data Verification (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between EScript Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.wf_escript_de_dv_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_escript_de_dv_gap_time  {
    label: "EScript Data Entry to Data Verification (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between EScript Data Entry and Data Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_escript_de_dv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_escript_de_dv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_escript_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_escript_de_dv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_escript_de_dv_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_dv_fill_gap_time  {
    label: "Data Verification to Fill (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Data Verification and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_dv_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_dv_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_dv_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_dv_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_dv_fill_gap_time  {
    label: "Data Verification to Fill (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Data Verification and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.wf_dv_fill_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_dv_fill_gap_time  {
    label: "Data Verification to Fill (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Averag gap time between Data Verification and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_dv_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_dv_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_dv_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_dv_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_dv_fill_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_fill_pv_gap_time  {
    label: "Fill to Product Verification (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Fill and Product Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_fill_pv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_fill_pv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_fill_pv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_fill_pv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_fill_pv_gap_time  {
    label: "Fill to Product Verification (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Fill and Product Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.wf_fill_pv_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_fill_pv_gap_time  {
    label: "Fill to Product Verification (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average time between Fill and Product Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_fill_pv_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_fill_pv_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_fill_pv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_fill_pv_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_fill_pv_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_pv_wc_gap_time  {
    label: "Product Verification To Will Call (WF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Product Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_pv_wc_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_pv_wc_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_pv_wc_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_pv_wc_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_pv_wc_gap_time  {
    label: "Product Verification To Will Call (WF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Product Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.wf_pv_wc_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_pv_wc_gap_time  {
    label: "Product Verification To Will Call (WF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Product Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.wf_pv_wc_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.wf_pv_wc_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.wf_pv_wc_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.wf_pv_wc_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.wf_pv_wc_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_rx_fill_fill_gap_time  {
    label: "Rx Filling to Fill (RF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Rx Filling and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rx_fill_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rx_fill_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rx_fill_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rx_fill_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0)  ;;
    value_format: "###0.00"
  }

  measure: median_rx_fill_fill_gap_time  {
    label: "Rx Filling to Fill (RF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Rx Filling and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.rf_rx_fill_fill_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_rx_fill_fill_gap_time  {
    label: "Rx Filling to Fill (RF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Rx Filling and Fill. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rx_fill_fill_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rx_fill_fill_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rx_fill_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rx_fill_fill_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.rf_rx_fill_fill_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_rx_fill_rph_verify_gap_time  {
    label: "Rx Fill to Rph Verification (RF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Rx Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rx_fill_rph_verify_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rx_fill_rph_verify_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rx_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rx_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_rx_fill_rph_verify_gap_time  {
    label: "Rx Fill to Rph Verification (RF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Rx Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.rf_rx_fill_rph_verify_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_rx_fill_rph_verify_gap_time  {
    label: "Rx Fill to Rph Verification (RF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Rx Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rx_fill_rph_verify_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rx_fill_rph_verify_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rx_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rx_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.rf_rx_fill_rph_verify_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_fill_rph_verify_gap_time  {
    label: "Fill to Rph Verification (RF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_fill_rph_verify_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_fill_rph_verify_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_fill_rph_verify_gap_time  {
    label: "Fill to Rph Verification (RF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.rf_fill_rph_verify_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_fill_rph_verify_gap_time  {
    label: "Fill to Rph Verification (RF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Fill and Rph Verification. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_fill_rph_verify_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_fill_rph_verify_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_fill_rph_verify_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.rf_fill_rph_verify_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_rph_verify_wc_gap_time  {
    label: "Rph Verification to Will Call (RF mode) - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between Rph Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rph_verify_will_call_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rph_verify_will_call_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rph_verify_will_call_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rph_verify_will_call_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_rph_verify_wc_gap_time  {
    label: "Rph Verification to Will Call (RF mode) - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between Rph Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.rf_rph_verify_will_call_gap_time  ;;
    value_format: "###0.00"
  }

  measure: avg_rph_verify_wc_gap_time  {
    label: "Rph Verification to Will Call (RF mode) - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between Rph Verification and Will Call. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.rf_rph_verify_will_call_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.rf_rph_verify_will_call_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.rf_rph_verify_will_call_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.rf_rph_verify_will_call_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.rf_rph_verify_will_call_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  measure: sum_source_target_task_gap_time  {
    label: "Source Task to Target Task - Transaction Level Gap Time (in Minutes)"
    description: "Gap time between selected Source and Target tasks. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.source_target_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.source_target_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.source_target_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.source_target_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) ;;
    value_format: "###0.00"
  }

  measure: median_source_target_task_gap_time  {
    label: "Source Task to Target Task - Transaction Level Median Gap Time (in Minutes)"
    description: "Median gap time between selected Source and Target tasks. Please use Local Pharmacy as Prescription Fill Location."
    type: median
    hidden: yes
    group_label: "Per Transaction"
    sql: ${TABLE}.source_target_gap_time ;;
    value_format: "###0.00"
  }

  measure: avg_source_target_task_gap_time  {
    label: "Source Task to Target Task - Transaction Level Average Gap Time (in Minutes)"
    description: "Average gap time between selected Source and Target tasks. Please use Local Pharmacy as Prescription Fill Location."
    type: number
    group_label: "Per Transaction"
    #sql: ${TABLE}.source_target_gap_time ;;
    sql: (sum(distinct (cast(floor(${TABLE}.source_target_gap_time*(1000000*1.0)) as decimal(38,0))) + (case when ${TABLE}.source_target_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0) ) - sum(distinct (case when ${TABLE}.source_target_gap_time is null then 0 else md5_number(${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id ) end % 1.0e27)::numeric(38,0))) / (1000000*1.0) / nullif(count(distinct case when ${TABLE}.source_target_gap_time is not null then ${TABLE}.chain_id || '@' || ${TABLE}.nhin_store_id || '@' || ${TABLE}.rx_tx_id else null end), 0) ;;
    value_format: "###0.00"
  }

  set: explore_rx_4_13_transaction_gap_time_measures {
    fields: [
      sum_oe_de_gap_time,
      median_oe_de_gap_time,
      avg_oe_de_gap_time,
      sum_oe_dv_gap_time,
      median_oe_dv_gap_time,
      avg_oe_dv_gap_time,
      sum_oe_fill_gap_time,
      median_oe_fill_gap_time,
      avg_oe_fill_gap_time,
      sum_de_dv_gap_time ,
      median_de_dv_gap_time ,
      avg_de_dv_gap_time ,
      sum_escript_de_dv_gap_time ,
      median_escript_de_dv_gap_time ,
      avg_escript_de_dv_gap_time ,
      sum_dv_fill_gap_time ,
      median_dv_fill_gap_time ,
      avg_dv_fill_gap_time ,
      sum_fill_pv_gap_time ,
      median_fill_pv_gap_time ,
      avg_fill_pv_gap_time ,
      sum_pv_wc_gap_time ,
      median_pv_wc_gap_time ,
      avg_pv_wc_gap_time ,
      sum_rx_fill_fill_gap_time ,
      median_rx_fill_fill_gap_time ,
      avg_rx_fill_fill_gap_time ,
      sum_rx_fill_rph_verify_gap_time ,
      median_rx_fill_rph_verify_gap_time ,
      avg_rx_fill_rph_verify_gap_time ,
      sum_fill_rph_verify_gap_time ,
      median_fill_rph_verify_gap_time ,
      avg_fill_rph_verify_gap_time ,
      sum_rph_verify_wc_gap_time ,
      median_rph_verify_wc_gap_time ,
      avg_rph_verify_wc_gap_time ,
      sum_source_target_task_gap_time ,
      median_source_target_task_gap_time,
      avg_source_target_task_gap_time
    ]
  }
}

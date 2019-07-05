# [ERXLPS-1073] Script to Skin requirement
# Provide more insights about how long a prescription fill/refill taken from the time of receive to will call arrive.
# For Escripts (NEWRX with refill_number 0 + REFRES with approval status A or C with refill number 0), consider prescriber_edi.received_date as the time when the e-script is received.
# For non Escripts consider the line_item.source_create_timestamp as starting point.
# Consider latest order entry active transaction will_call_arrival_date within a prescription fill/refill to get the will_call_arrival_time.
# If active transaction do not have will_call_arrival date populated for latest order_entry, consider latest will_call_arrival_date of inactive transactions for prescription fill/refill of latest order entry.

view: eps_rx_refill_received_to_will_call_qa {

  derived_table: {
    sql: with task_history
              as (select chain_id,
                         nhin_store_id,
                         line_item_id,
                         max(case when upper(task_history_task_action) IN ('GETNEXT','START')
                                   and task_history_status is null
                                   and task_history_action_date < data_entry_end
                                  then task_history_action_date end)
                              over(partition by chain_id, nhin_store_id, line_item_id) as data_entry_start, --logic to get the latest data_entry start time before data_entry complete at line_item_id level.
                         data_entry_end
                  from (select chain_id,
                               nhin_store_id,
                               task_history_id,
                               line_item_id,
                               task_history_task_name,
                               task_history_status,
                               task_history_task_action,
                               task_history_action_date,
                               max(case when upper(task_history_task_action) = 'COMPLETE' then task_history_action_date end)
                                    over(partition by chain_id, nhin_store_id, line_item_id) as data_entry_end --logic to get the latest data_entry complete task time at line_item_id level.
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
                        where {% condition chain.chain_id %} chain_id {% endcondition %}
                        and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
                        and task_history_task_name in ('data_entry','escript_data_entry')
                        -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                        and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                where source_system_id = 5
                                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                  and {% condition store.store_number %} store_number {% endcondition %})
                       )
                  ),
            change_billing_tx
              as (select distinct chain_id, nhin_store_id, line_item_id
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
                    where {% condition chain.chain_id %} chain_id {% endcondition %}
                    and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
                    -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                    and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                            where source_system_id = 5
                                              and {% condition chain.chain_id %} chain_id {% endcondition %}
                                              and {% condition store.store_number %} store_number {% endcondition %})
                    and (task_history_task_action like '%change_billing%' or task_history_status like '%refill_too_soon%'))
            select chain_id,
                   nhin_store_id,
                   rx_id,
                   rx_tx_refill_number,
                   escript_message_type,
                   escript_received_date,
                   latest_oe_created_date,
                   first_de_start,
                   rx_refill_wc_arrival_date,
                   case when TO_DATE(escript_received_date) = TO_DATE(rx_refill_wc_arrival_date) then datediff(sec, escript_received_date, rx_refill_wc_arrival_date) / 60 end as escript_receive_to_wc_arrive_same_day_mins,
                   datediff(sec, latest_oe_created_date, rx_refill_wc_arrival_date) / 60 as order_receive_to_wc_arrive_mins,
                   datediff(sec, escript_received_date, first_de_start) / 60 as escript_receive_to_de_mins,
                   case when TO_DATE(latest_oe_created_date) = TO_DATE(rx_refill_wc_arrival_date) then datediff(sec, latest_oe_created_date, rx_refill_wc_arrival_date) / 60 end as order_receive_to_wc_arrive_same_day_mins
            from (select chain_id,
                          nhin_store_id,
                          rx_id,
                          rx_tx_refill_number,
                          min(prescriber_edi_message_type) as escript_message_type,
                          min(case when rx_tx_refill_number = 0 then prescriber_edi_received_date end) as escript_received_date,
                          nvl(max(case when line_item_order_entry_id = latest_order_entry
                                        and rx_tx_tx_status = 'Y'
                                       then rx_tx_will_call_arrival_date end),
                              max(case when line_item_order_entry_id = latest_order_entry
                                       then rx_tx_will_call_arrival_date end)
                             ) as rx_refill_wc_arrival_date,
                          min(data_entry_start) as first_de_start,
                          min(case when line_item_order_entry_id = latest_order_entry then source_create_timestamp end) as latest_oe_created_date
                     from (select chain_id,
                                  nhin_store_id,
                                  rx_id,
                                  rx_tx_refill_number,
                                  prescriber_edi_message_type,
                                  prescriber_edi_received_date,
                                  line_item_original_line_item_id,
                                  line_item_id,
                                  source_create_timestamp,
                                  line_item_order_entry_id,
                                  latest_line_item_id,
                                  rx_tx_tx_status,
                                  rx_tx_will_call_arrival_date,
                                  data_entry_start,
                                  admin_rebill_rx,
                                  change_billing_rx,
                                  min(case when line_item_id = latest_line_item_id then line_item_order_entry_id end)
                                    over(partition by chain_id, nhin_store_id, rx_id, rx_tx_refill_number) latest_order_entry
                             from (select rxtx.chain_id,
                                          rxtx.nhin_store_id,
                                          rxtx.rx_id,
                                          rxtx.rx_tx_refill_number,
                                          edi.prescriber_edi_message_type,
                                          edi.prescriber_edi_received_date,
                                          l.line_item_original_line_item_id,
                                          l.line_item_id,
                                          l.source_create_timestamp,
                                          l.line_item_order_entry_id,
                                          max(l.line_item_id) over(partition by rxtx.chain_id, rxtx.nhin_store_id, rxtx.rx_id, rxtx.rx_tx_refill_number) as latest_line_item_id,
                                          nvl(rxtx.rx_tx_tx_status, 'Y') as rx_tx_tx_status,
                                          rxtx.rx_tx_will_call_arrival_date,
                                          min(t.data_entry_start) over(partition by rxtx.chain_id, rxtx.nhin_store_id, rxtx.rx_id, rxtx.rx_tx_refill_number) as data_entry_start,
                                          max(nvl(rx_tx_admin_rebilled, 'N')) over(partition by rxtx.chain_id, rxtx.nhin_store_id, rxtx.rx_id, rxtx.rx_tx_refill_number) as admin_rebill_rx,
                                          max(case when cbt.line_item_id is not null then 'Y' else 'N' end) over(partition by rxtx.chain_id, rxtx.nhin_store_id, rxtx.rx_id, rxtx.rx_tx_refill_number) as change_billing_rx
                                     from
                                          {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                                            {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                                            {% if active_archive_filter_input_value == 'archive'  %}
                                              EDW.F_RX_TX_LINK_ARCHIVE rxtx
                                            {% else %}
                                              EDW.F_RX_TX_LINK rxtx
                                            {% endif %}
                                          {% else %}
                                            EDW.F_RX_TX_LINK rxtx
                                          {% endif %}
                                          left outer join edw.f_prescriber_edi edi
                                            on rxtx.chain_id = edi.chain_id
                                            and rxtx.nhin_store_id = edi.nhin_store_id
                                            and rxtx.rx_tx_id = edi.line_item_id
                                            and upper(edi.prescriber_edi_message_type) || '-' || nvl(edi.prescriber_edi_approved, 'New')  IN ('REFRES-A', 'REFRES-C', 'NEWRX-New')
                                          left outer join edw.f_line_item l
                                            on rxtx.chain_id = l.chain_id
                                            and rxtx.nhin_store_id = l.nhin_store_id
                                            and rxtx.rx_tx_id = l.line_item_id
                                          left outer join task_history t
                                            on rxtx.chain_id = t.chain_id
                                            and rxtx.nhin_store_id = t.nhin_store_id
                                            and rxtx.rx_tx_id = t.line_item_id
                                          left outer join change_billing_tx cbt
                                            on rxtx.chain_id = cbt.chain_id
                                            and rxtx.nhin_store_id = cbt.nhin_store_id
                                            and rxtx.rx_tx_id = cbt.line_item_id
                                    where {% condition chain.chain_id %} rxtx.chain_id {% endcondition %}
                                      and {% condition store.nhin_store_id %} rxtx.nhin_store_id {% endcondition %}
                                      -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                                      and rxtx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                  where source_system_id = 5
                                                                    and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                    and {% condition store.store_number %} store_number {% endcondition %})
                                      and rxtx.source_system_id = 4
                                  )
                                where change_billing_rx = 'N'
                              --(admin_rebill_rx = 'N' or change_billing_rx = 'N')
                          )
                     where admin_rebill_rx = 'N'
                     group by chain_id,
                              nhin_store_id,
                              rx_id,
                              rx_tx_refill_number
                    )
        ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || ':' || ${nhin_store_id} || ':' || ${rx_id} || ':' || ${rx_tx_refill_number} ;;
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

  dimension: rx_id {
    label: "Prescription ID"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_tx_refill_number {
    label: "Prescription Refill Number"
    description: "Refill number of the transaction"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
  }

  ####################################################################################################### Dimensions ####################################################################################################

  dimension: escript_message_type {
    label: "Prescription eScript Message Type"
    description: "Message type for eScript. NEWRX, REFRES"
    type:  string
    sql:  ${TABLE}.escript_message_type ;;
  }

  dimension_group: escript_received {
    label: "Prescription eScript Received"
    description: "Date/time when a prescription eScript is received"
    type: time
    #hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.escript_received_date ;;
  }

  dimension_group: latest_oe_created {
    label: "Prescription Latest Order Received"
    description: "Date/time when a prescription(rx number + refill number) latest order is received (derived from line item)"
    type: time
    #hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.latest_oe_created_date ;;
  }

  dimension_group: first_de_start {
    label: "Prescription First Data Entry Created"
    description: "Prescription first successful data entry start time"
    type: time
    #hidden: yes #[ERXLPS-1330]
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.first_de_start ;;
  }

  dimension_group: rx_refill_wc_arrival {
    label: "Prescription Will Call Arrival"
    description: "Date/time when a prescription enters Will Call"
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.RX_REFILL_WC_ARRIVAL_DATE ;;
  }

  dimension: escript_receive_to_wc_arrive_same_day_mins {
    label: "Prescription eScript Receive to WC Arrival SameDay (in Min)"
    description: "Time in minutes for eScript from received to will call arrival. (Calculation used: eScript arrival to will call arrival)"
    type: number
    sql:  ${TABLE}.escript_receive_to_wc_arrive_same_day_mins ;;
    value_format: "###0.00"
  }

  dimension: order_receive_to_wc_arrive_mins {
    label: "Prescription Order Receive to WC Arrival (in Min)"
    description: "Time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: number
    sql:  ${TABLE}.order_receive_to_wc_arrive_mins ;;
    value_format: "###0.00"
  }

  dimension: escript_receive_to_de_mins {
    label: "Prescription eScript Receive to Data Entry (in Min)"
    description: "Time in minutes for eScripts from received to first successful data entry start time. (Calculation used: eScript arrival to data entry start (must be completed))"
    type: number
    sql: ${TABLE}.escript_receive_to_de_mins ;;
    value_format: "###0.00"
  }

  #[No Jira US] - New Dimension.
  dimension: order_receive_to_wc_arrive_same_day_mins {
    label: "Prescription Order Receive to WC Arrival Same Day (in Min)"
    description: "Time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: number
    sql:  ${TABLE}.order_receive_to_wc_arrive_same_day_mins ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1431]
  dimension: order_receive_to_wc_arrive_tier {
    label: "Prescription Order Received to WC Arrival Tier"
    description: "Prescription order received to will call arrival tier in days. Example: 0-3, 4-6, 7-10 and 11 above. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: tier
    sql: trunc(${order_receive_to_wc_arrive_mins}/1440) ;;
    tiers: [0,4,7,11]
    style: integer
  }

  #################################################################################################### Measures #########################################################################################################

  measure: median_escript_receive_to_wc_arrive_same_day_mins {
    label: "Median Prescription eScript Receive to Will Call Arrival Same Day (in Min)"
    description: "Median time in minutes for eScript from received to will call arrival. (Calculation used: eScript arrival to will call arrival)"
    type: number
    hidden: yes #Hiding median measures. SF currently doest not support sum_distinct on median function.
    sql: median(${escript_receive_to_wc_arrive_same_day_mins}) ;;
    value_format: "###0.00"
  }

  measure: avg_escript_receive_to_wc_arrive_same_day_mins {
    label: "Average Prescription eScript Receive to Will Call Arrival Same Day (in Min)"
    description: "Average time in minutes for eScript from received to will call arrival. (Calculation used: eScript arrival to will call arrival)"
    type: average
    sql: ${escript_receive_to_wc_arrive_same_day_mins} ;;
    value_format: "###0.00"
  }

  measure: median_order_receive_to_wc_arrive_mins {
    label: "Median Prescription Order Receive to Will Call Arrival (in Min)"
    description: "Median time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: number
    hidden: yes #Hiding median measures. SF currently doest not support sum_distinct on median function.
    sql: median(${order_receive_to_wc_arrive_mins}) ;;
    value_format: "###0.00"
  }

  measure: avg_order_receive_to_wc_arrive_mins {
    label: "Average Prescription Order Receive to Will Call Arrival (in Min)"
    description: "Average time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: average
    sql: ${order_receive_to_wc_arrive_mins} ;;
    value_format: "###0.00"
  }

  measure: median_escript_receive_to_de_mins {
    label: "Median Prescription eScript receive to Data Entry Time (in Min)"
    description: "Median time in minutes for eScripts from received to first successful data entry start time. (Calculation used: eScript arrival to data entry start (must be completed))"
    type: number
    hidden: yes #Hiding median measures. SF currently doest not support sum_distinct on median function.
    sql: median(${escript_receive_to_de_mins}) ;;
    value_format: "###0.00"
  }

  measure: avg_escript_receive_to_de_mins {
    label: "Average Prescription eScript receive to Data Entry Time (in Min)"
    description: "Average time in minutes for eScripts from received to first successful data entry start time. (Calculation used: eScript arrival to data entry start (must be completed))"
    type: average
    sql: ${escript_receive_to_de_mins} ;;
    value_format: "###0.00"
  }

  #[No Jira US] - New measures.
  measure: median_order_receive_to_wc_arrive_same_day_mins {
    label: "Median Prescription Order Receive to Will Call Arrival Same Day (in Min)"
    description: "Median time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: number
    hidden: yes #Hiding median measures. SF currently doest not support sum_distinct on median function.
    sql: median(${order_receive_to_wc_arrive_same_day_mins}) ;;
    value_format: "###0.00"
  }

  measure: avg_order_receive_to_wc_arrive_same_day_mins {
    label: "Average Prescription Order Receive to Will Call Arrival Same Day (in Min)"
    description: "Average time in minutes for a prescription taken from the latest order received to will call arrival. (Calculation used: Latest order entry created time (derived from line item) to will call arrival)"
    type: average
    sql: ${order_receive_to_wc_arrive_same_day_mins} ;;
    value_format: "###0.00"
  }
}

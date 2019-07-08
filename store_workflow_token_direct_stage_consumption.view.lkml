view: store_workflow_token_direct_stage_consumption {
  derived_table: {
    sql: select
        workflowtoken.chain_id,
        workflowtoken.nhin_store_id,
        workflowtoken.line_item_id,
        orderentry.order_entry_id,
        orderentry.order_entry_promised_date
        , case when lower(ws.workflow_state_name) in ('rx_filling', 'data_entry') then 'DATA_ENTRY' else upper(ws.workflow_state_name) end wf_state_name
        , workflowtoken.workflow_token_hold_until_date, workflowtoken.workflow_token_required_role
        , case when to_date(orderentry.order_entry_promised_date) < current_date then '1-Prior'
               when to_date(orderentry.order_entry_promised_date) >= dateadd(day,2,current_date) then '4-Future'
               when to_date(orderentry.order_entry_promised_date) >= dateadd(day,1,current_date) then '3-Next_Day'
                else '2-Today'
             end day_group_flag
        , case when datediff(minute, convert_timezone(tz.time_zone, cast(current_timestamp as timestamp(0))), orderentry.order_entry_promised_date) < 0 then 'Behind' else 'Ahead' end ahead_behind_Flag
        , datediff(minute, convert_timezone(tz.time_zone, cast(current_timestamp as timestamp(0))), orderentry.order_entry_promised_date) as minutes_ahead_behind
        , convert_timezone(tz.time_zone, cast(current_timestamp as timestamp(0))) db_current_timestamp_converted
        , workflowtoken.source_timestamp
        ,workflowtoken.latest_workflow_token_source_timestamp
from (select chain_id,
                                      nhin_store_id,
                                      id,
                                      4 as source_system_id,
                                      workflow_token_hold_until_date,
                                      workflow_token_required_role,
                                      workflow_state_id,
                                      line_item_id,
                                      source_timestamp,
                                      latest_workflow_token_source_timestamp
from
(select q.*,
                                      row_number() over(partition by chain_id,nhin_store_id,id order by data_feed_last_update_date desc, source_timestamp desc) rnk,
                                      max(source_timestamp) over (partition by chain_id, nhin_store_id) as latest_workflow_token_source_timestamp
                                 from (select q.chain_id,
                                              nhin_store_id,
                                              dml_operation_type,
                                              (((event_data:ID)                         :: varchar)  :: NUMBER(38,0)) id,
                                              (((event_data:HOLD_UNTIL_DATE)            :: varchar)  :: TIMESTAMP_NTZ(6)) workflow_token_hold_until_date,
                                              (((event_data:REQUIRED_ROLE)              :: varchar)  :: VARCHAR(64)) workflow_token_required_role,
                                              (((event_data:WORKFLOW_STATE_ID)          :: varchar)  :: NUMBER(38,0)) workflow_state_id,
                                              (((event_data:LINE_ITEM_ID)               :: varchar)  :: NUMBER(38,0)) line_item_id,
                                              (((event_data:DATA_FEED_LAST_UPDATE_DATE) :: varchar)  :: TIMESTAMP_NTZ(6)) data_feed_last_update_date,
                                              source_timestamp
                                            from json_stage.symmetric_event_stage q
                                            where q.table_name = 'WORKFLOW_TOKEN'
                                            and q.process_timestamp >= to_timestamp('2019-01-01 00:00:00')
                                            and {% condition chain.chain_id %} q.chain_id {% endcondition %}
                                            and {% condition store.nhin_store_id %} q.nhin_store_id {% endcondition %}
                                            and q.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                      where source_system_id = 5
                                                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                      and {% condition store.store_number %} store_number {% endcondition %}
                                                                    )
                                      ) q
) workflowtoken_src
where workflowtoken_src.rnk = 1
and dml_operation_type in ('I','U') -- Only considers valid token. Tokens that are no longer active will be disregards. In the future, when we process this into a table and store all records (then we do a merge with deletes and non-deletes)
) workflowtoken

inner join etl_manager.store_to_time_zone_cross_ref tz
   on tz.chain_id = workflowtoken.chain_id
   and tz.nhin_store_id = workflowtoken.nhin_store_id
                                               and {% condition chain.chain_id %} tz.chain_id {% endcondition %}
                                            and {% condition store.nhin_store_id %} tz.nhin_store_id {% endcondition %}
                                            and tz.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                      where source_system_id = 5
                                                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                      and {% condition store.store_number %} store_number {% endcondition %}
                                                                    )

inner join edw.d_workflow_state ws
   on ws.chain_id = workflowtoken.chain_id
   and ws.nhin_store_id = workflowtoken.nhin_store_id
   and ws.workflow_state_id = workflowtoken.workflow_state_id
                                               and {% condition chain.chain_id %} ws.chain_id {% endcondition %}
                                            and {% condition store.nhin_store_id %} ws.nhin_store_id {% endcondition %}
                                            and ws.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                      where source_system_id = 5
                                                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                      and {% condition store.store_number %} store_number {% endcondition %}
                                                                    )

inner join (select chain_id,
        nhin_store_id,
        4 as source_system_id,
        line_item_id,
        line_item_order_entry_id
                from (select q.*,
                                      row_number() over (partition by chain_id, nhin_store_id, line_item_id order by data_feed_last_update_date desc) rnk
                                 from (select chain_id,
                                              nhin_store_id,
                                              (((event_data:ID)                             :: varchar)  :: NUMBER(38, 0)) line_item_id,
                                              (((event_data:ORDER_ENTRY_ID)                 :: varchar)  :: NUMBER(38,0)) line_item_order_entry_id,
                                              (((event_data:DATA_FEED_LAST_UPDATE_DATE)     :: varchar)  :: TIMESTAMP_NTZ(6)) data_feed_last_update_date
                                         from json_stage.symmetric_event_stage q
                                            where table_name = 'LINE_ITEM'
                                            and process_timestamp >= to_timestamp('2019-01-01 00:00:00')
                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                            and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
                                            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                      where source_system_id = 5
                                                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                      and {% condition store.store_number %} store_number {% endcondition %}
                                                                    )
                                      ) q
) lineitem_src
where lineitem_src.rnk = 1
) lineitem
   on lineitem.chain_id = workflowtoken.chain_id
   and lineitem.nhin_store_id = workflowtoken.nhin_store_id
   and lineitem.source_system_id = workflowtoken.source_system_id
   and lineitem.line_item_id = workflowtoken.line_item_id
inner join ( select chain_id,
                                      nhin_store_id,
                                      order_entry_id,
                                      4 as source_system_id,
                                      order_entry_promised_date
from
(select q.*,
                                      row_number() over(partition by chain_id,nhin_store_id,order_entry_id order by data_feed_last_update_date desc) rnk
                                 from (select q.chain_id,
                                              nhin_store_id,
                                              (((event_data:ID)                             :: varchar)  :: NUMBER(38, 0)) order_entry_id,
                                              (((event_data:PROMISED_DATE)                  :: varchar)  :: TIMESTAMP_NTZ(6)) order_entry_promised_date,
                                              (((event_data:DATA_FEED_LAST_UPDATE_DATE)     :: varchar)  :: TIMESTAMP_NTZ(6)) data_feed_last_update_date
                                         from json_stage.symmetric_event_stage q
                                            where table_name = 'ORDER_ENTRY'
                                            and process_timestamp >= to_timestamp('2019-01-01 00:00:00')
                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                            and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
                                            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                                      where source_system_id = 5
                                                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                                      and {% condition store.store_number %} store_number {% endcondition %}
                                                                    )
                                      ) q
 )
 orderentry_src
where orderentry_src.rnk = 1
) orderentry
   on orderentry.chain_id = lineitem.chain_id
   and orderentry.nhin_store_id = lineitem.nhin_store_id
   and orderentry.source_system_id = lineitem.source_system_id
   and orderentry.order_entry_id = lineitem.line_item_order_entry_id
and lower(ws.workflow_state_name) in ('data_verification','data_verification2', 'rx_filling', 'data_entry', 'fulfillment_verification')
and (workflowtoken.workflow_token_HOLD_UNTIL_DATE  IS NULL OR to_date(workflowtoken.workflow_token_HOLD_UNTIL_DATE) <= convert_timezone(tz.time_zone, cast(current_timestamp as timestamp(0))))
and upper(workflowtoken.workflow_token_required_role) not in ('CALL_INS', 'CALL_PAT', 'CALL_PRE')
 ;;
  }


  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "Unique number assigned to PDX Inc. Accounting to identify a Chain or a Store"
    type: number
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    label: "NHIN STORE ID"
    description: "The NHIN (National Health Information Network) ID number"
    type: number
    sql: ${TABLE}."NHIN_STORE_ID" ;;
  }

  dimension: line_item_id {
    label: "Prescription Line Item ID"
    description: "Unique ID number identifying an line item record within a pharmacy chain"
    type: number
    sql: ${TABLE}."LINE_ITEM_ID" ;;
  }

  dimension: order_entry_id {
    label: "Prescription Order Entry ID"
    description: "Unique ID of the parent order entry record associated with this line item record within a pharmacy chain"
    type: number
    sql: ${TABLE}."ORDER_ENTRY_ID" ;;
  }

  dimension_group: order_entry_promised {
    label: "Order Entry Promised"
    description: "Date/Time an order is promised to be ready as calculated at Order Entry. The promise time is calculated off of the store setting for promise time for the pickup type selected"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}."ORDER_ENTRY_PROMISED_DATE" ;;
  }

  dimension: wf_state_name {
    label: "Current Workflow State Name"
    description: "Name of the current workflow state for prescriptions. This is used along with Task Count measure to get the details about current prescription count for each workflow state"
    type: string
    sql: ${TABLE}."WF_STATE_NAME" ;;
  }

  dimension_group: workflow_token_hold_until {
    description: "Date/Time that the workflow token will be on hold till"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}."WORKFLOW_TOKEN_HOLD_UNTIL_DATE" ;;
  }

  dimension: workflow_token_required_role {
    label: "Workflow Token Role"
    description: "Role required for a user to perform tasks"
    type: string
    sql: ${TABLE}."WORKFLOW_TOKEN_REQUIRED_ROLE" ;;
  }

  dimension: day_group_flag {
    label: "Day Group Flag"
    description: "Category group to determine how the transaction promised time relates to today; such a prior, today, next day, future"
    type: string
    sql: ${TABLE}."DAY_GROUP_FLAG" ;;
    suggestions: ["1-Prior", "2-Today","3-Next_Day","4-Future"]
    suggest_persist_for: "24 hours"
  }

  dimension: ahead_behind_flag {
    label: "Ahead Behind Flag"
    description: "Category group indicating how the transaction promised time relates to the report run time; such as ahead or behind"
    type: string
    sql: ${TABLE}."AHEAD_BEHIND_FLAG" ;;
    suggestions: ["Behind", "Ahead"]
    suggest_persist_for: "24 hours"
  }

  dimension: minutes_ahead_behind {
    label: "Minutes Ahead Behind"
    description: "The number of minutes the transaction promised time relates to the report run time which indicates if the transaction is past due, currently due or due in the future."
    type: number
    sql: ${TABLE}."MINUTES_AHEAD_BEHIND" ;;
  }

  dimension_group: db_current_timestamp_converted {
    label: "DB Current Timestamp - Converted"
    description: "The ExploreDx database time converted to the local pharmacy time"
    type: time
    sql: ${TABLE}."DB_CURRENT_TIMESTAMP_CONVERTED" ;;
  }

  dimension_group: workflow_token_source {
    label: "Workflow Token Source Timestamp"
    description: "Activity date/time on Workflow Token record"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}."SOURCE_TIMESTAMP" ;;
  }

  dimension_group: latest_workflow_token_source {
    label: "Workflow Token Source Max Timestamp"
    description: "Latest date/time on Workflow Token record"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}."LATEST_WORKFLOW_TOKEN_SOURCE_TIMESTAMP" ;;
  }

  measure: count {
    label: "Total Task Count"
    description: "Total tasks in the queue"
    type: count
    drill_fields: [detail*]
    value_format: "#,##0"
  }

  measure: median_minutes_ahead_behind {
    label: "Minutes Ahead Behind - Median"
    description: "The median number of minutes the transaction promised time relates to the report run time which indicates if the transaction is past due, currently due or due in the future."
    type: median
    sql: ${TABLE}."MINUTES_AHEAD_BEHIND" ;;
    drill_fields: [detail*]
    value_format: "###0"
  }

  measure: avg_minutes_ahead_behind {
    label: "Minutes Ahead Behind - Average"
    description: "The average number of minutes the transaction promised time relates to the report run time which indicates if the transaction is past due, currently due or due in the future."
    type: average
    sql: ${TABLE}."MINUTES_AHEAD_BEHIND" ;;
    drill_fields: [detail*]
    value_format: "###0"
  }

  # Applied to_char and MAX with type: string to show datetime values in measures. As type with max will not work for measures for timestamp fields.
  measure: max_workflow_token_source {
    label: "Workflow Token Max Source Timestamp"
    description: "Latest activity date/time on Workflow Token record"
    type: string
    sql: to_char(MAX(${TABLE}.SOURCE_TIMESTAMP), 'yyyy-mm-dd hh24:mi:ss') ;;
    drill_fields: [detail*]
  }


  set: detail {
    fields: [
      chain.chain_id,
      store.nhin_store_id,
      line_item_id,
      order_entry_id,
      order_entry_promised_time,
      wf_state_name,
      workflow_token_hold_until_time,
      workflow_token_required_role,
      day_group_flag,
      ahead_behind_flag,
      minutes_ahead_behind,
      db_current_timestamp_converted_time,
      workflow_token_source_time
    ]
  }
}

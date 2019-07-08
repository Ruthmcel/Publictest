view: symmetric_node_status_snapshot {
  sql_table_name: REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT ;;

####################################################################### Unique Key #########################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${snapshot_time} ;;
  }

####################################################################### Dimensions #########################################################################

  dimension: chain_id {
    type: number
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension: nhin_store_id {
    type: number
    sql: ${TABLE}."NHIN_STORE_ID" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
    suggestions: ["HEALTHY","DATA LAG","BATCHES IN ERROR","BATCHES IN ERROR & OFFLINE NODE","OFFLINE NODE","OFFLINE WITH NO STANDARD/RELOAD"]
  }

  dimension: offline_category {
    label: "Offline Vs. Online"
    type: string
    sql: CASE WHEN ${TABLE}."STATUS" LIKE '%OFFLINE%' THEN 'OFFLINE' ELSE 'ONLINE' END;;
    suggestions: ["OFFLINE","ONLINE"]
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}."STORE_NAME" ;;
  }

  dimension_group: snapshot {
    type: time
    timeframes: []
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}."SNAPSHOT_TIME") ;;
  }


  dimension: chain_name {
    type: string
    sql: ${TABLE}."CHAIN_NAME" ;;
  }

  dimension: data_lag_time {
    type: string
    sql: ${TABLE}."DATA_LAG_TIME" ;;
  }

  dimension: heartbeat_lag_time {
    type: string
    sql: ${TABLE}."HEARTBEAT_LAG_TIME" ;;
  }

  dimension_group: last_data_batch {
    type: time
    timeframes: []
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}."LAST_DATA_BATCH_TIME") ;;
  }

  dimension: last_data_channel_identifier {
    type: string
    sql: ${TABLE}."LAST_DATA_CHANNEL_IDENTIFIER" ;;
  }

  dimension_group: last_heartbeat {
    type: time
    timeframes: []
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}."LAST_HEARTBEAT_TIME") ;;
  }


  dimension_group: latest_snapshot {
    label: "Latest Snapshot"
    description: "Latest snapshot was taken for the Symmetric Node Status"
    type: time
    hidden: yes
    timeframes: []
    sql: SELECT MAX(CONVERT_TIMEZONE('America/Chicago',SNAPSHOT_TIME)) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT ;;
  }

###################################################################### Filter ###########################################################################
  filter: latest_snapshot_filter {
    label: "Latest Snapshot Date"
    description: "Yes/No Flag whether to consider latest snapshot date or all snaphots for Symmetric. Default value: Yes"
    type: string
    suggestions: ["Yes","No"]
    default_value: "Yes"
  }

####################################################################### Measures #########################################################################
  measure: count_stores {
    label: "Stores - Total"
    type: number
    sql: COUNT(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.NHIN_STORE_ID end
                  else ${TABLE}.NHIN_STORE_ID
            end) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }

  measure: avg_stores {
    label: "Stores - Average"
    type: number
    sql: COUNT(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.NHIN_STORE_ID end
                  else ${TABLE}.NHIN_STORE_ID
            end)/NULLIF(COUNT(DISTINCT(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.SNAPSHOT_TIME end
                  else ${TABLE}.SNAPSHOT_TIME
            end)),0) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }

  measure: sum_batches_in_error_cnt {
    label: "Batches in Error - Total"
    type: number
    sql: SUM(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.BATCHES_IN_ERROR_CNT end
                  else ${TABLE}.BATCHES_IN_ERROR_CNT
            end) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }

  measure: sum_batches_to_send_cnt {
    label: "Batches to Send - Total"
    type: number
    sql: SUM(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.BATCHES_TO_SEND_CNT end
                  else ${TABLE}.BATCHES_TO_SEND_CNT
            end) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }

  measure: avg_batches_in_error_cnt {
    label: "Batches in Error - Average"
    type: number
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.BATCHES_IN_ERROR_CNT end
                  else ${TABLE}.BATCHES_IN_ERROR_CNT
            end) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }

  measure: avg_batches_to_send_cnt {
    label: "Batches to Send - Average"
    type: number
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when SNAPSHOT_TIME = (SELECT MAX(SNAPSHOT_TIME) FROM REPORT_TEMP.SYMMETRIC_NODE_STATUS_SNAPSHOT) then ${TABLE}.BATCHES_TO_SEND_CNT end
                  else ${TABLE}.BATCHES_TO_SEND_CNT
            end) ;;
    value_format: "#,##0"
    drill_fields: [sym_drill_candidate_list*]
  }


  set: sym_drill_candidate_list {
    fields: [
      chain_id,
      chain_name.store_id,
      nhin_store_id,
      store_name,
      status,
      avg_batches_in_error_cnt,
      avg_batches_to_send_cnt,
      last_heartbeat_time,
      heartbeat_lag_time
    ]
  }
}

view: bi_demo_eps_task_history_task_time {
  # 1. This new view file is specifically created around task times so if any other information pertaining to task history is requested to determine completed tasks, every field from task history is not consumed from the derived table
  # 2. Also looker cannot directly invoke analytical functions directly in a field sql, it has to be invoked within a derived table
  # 3. Also this view specifically includes task times only for completed tasks and hence when task times are measured this view would be inner joined to the other view file.
  # 4. The business logic may required to be twealed for Invisible Fill and GUI fill.
  # 5. Currently this does not restrict any specific task name, inorder to give the ability to determine the task time for all completed tasks.
  # 6. Performance Improvement Changes for Derived View
  #       - Chain Access Filter will also be applied to this derived table, if Row Level Security is enforced which would be the default behavior if any elements from this view is included in Customer DSS Model
  #       - filter Applied on Chain & NHIN STORE ID by default so if a specific chain or store is selected, only the specific chain and store would be selected instead of reading data for ALL CHAINS, STORES. Note: Access filter Will Still be applied if enforced.
  #             For example: If Chain 70 and 168 is selected, only 70 will be extracted at the end, if view is used in Customer DSS Model. If Chain 70 and NHIN_STORE_ID 109638 is selected, then only those records pertaining to chain 70 and the store 109638 would be selected even if there are records for other chain or store in this table.
  #       - The templated filters are not explicitly defined as the filter parameter as the field picker "Pharmacy NHIN Store ID" in the explore would correctly handle the store being selected
  # 7. Updated derived table (User story:ERXLPS-156, task:ERXLPS-193) - Included TASK_HISTORY_TASK_ACTION='start' for order_entry, since order_entry does not have 'getnext'.
  #    This has been included only for order_entry in order to prevent pulling both 'start' and 'getnext' for other tasks.
  #    Also added condition to look only for TASK_HISTORY_TASK_ACTION='complete' for order_enry, and not consider TASK_HISTORY_TASK_STATUS since it is null for order_entry completion.

  ##### This view is specifically created for Demo Model so task times can be demable and existime_eps_task_history_task_time cannot be accessible as true customer NHIN_STORE_ID is not exposed in Demo Model ###############


  derived_table: {
    sql: SELECT CHAIN_ID, NHIN_STORE_ID, TASK_HISTORY_ID, RX_TX_ID, TASK_TIME
      FROM
      (
      SELECT
      CHAIN_ID,
      NHIN_STORE_ID,
      TASK_HISTORY_ID,
      RX_TX_ID,
      TASK_HISTORY_TASK_ACTION,
      TASK_HISTORY_STATUS,
      DATEDIFF(SECOND,LAG(TASK_HISTORY_ACTION_DATE) OVER (PARTITION BY CHAIN_ID,NHIN_STORE_ID,RX_TX_ID,TASK_HISTORY_TASK_NAME ORDER BY TASK_HISTORY_ACTION_DATE),TASK_HISTORY_ACTION_DATE) AS TASK_TIME
      FROM
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
      WHERE lower(TASK_HISTORY_TASK_ACTION) IN ('getnext','complete') OR (lower(TASK_HISTORY_TASK_NAME) IN ('order_entry') AND lower(TASK_HISTORY_TASK_ACTION) IN ('start','complete'))
      -- and lower(TASK_HISTORY_TASK_NAME) IN ('call_patient','call_pharmacy','call_prescriber','data_entry','data_verification','data_verification2','order_entry ','product_verification','will_call')
      AND TASK_HISTORY_USER_LOGIN NOT IN ('ACSWorkerManager', 'BgWorkerManager', 'EscriptResponseWorker', 'NoUser', 'OEInterface',  'POSMsgWorker', 'ServiceAdmin', 'System', 'IVRWorker') -- Excluding Background tasks
      AND {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID {% endcondition %}
      AND {% condition eps_task_history.task_history_task_name %} UPPER(TASK_HISTORY_TASK_NAME) {% endcondition %}
      )
      WHERE (lower(TASK_HISTORY_STATUS) like 'complete%' AND lower(TASK_HISTORY_TASK_ACTION) IN ('complete'))
            OR (TASK_HISTORY_STATUS IS NULL AND lower(TASK_HISTORY_TASK_ACTION) IN ('complete')) -- Include Only completed tasks
       ;;
  }

  dimension: task_history_id {
    hidden: yes
    label: "Task History ID"
    description: "Unique ID number identifying an task history record within a pharmacy chain"
    type: number
    sql: ${TABLE}.TASK_HISTORY_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${task_history_id} ;; #ERXLPS-1649
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

  ####################################################################################################### Measures ####################################################################################################

  measure: avg_task_time {
    label: "Average Task Time (In Seconds)"
    description: "Average time taken to perform a specific task. Value is displayed in Seconds. Calculation Used: Current Task Action Time - Previous Task Action Time, with respect to the most recent 'getnext' and 'completed' action for the same task within a given prescription transanction under a pharmacy chain"
    type: number
    sql: AVG(${TABLE}.TASK_TIME) ;;
    value_format: "###0.00"
  }

  measure: median_task_time {
    label: "Median Task Time (In Seconds)"
    description: "Median time taken to perform a specific task. Value is displayed in Seconds. Calculation Used: Current Task Action Time - Previous Task Action Time, with respect to the most recent 'getnext' and 'completed' action for the same task within a given prescription transanction under a pharmacy chain"
    type: number
    sql: MEDIAN(${TABLE}.TASK_TIME) ;;
    value_format: "###0.00"
  }

  measure: max_task_time {
    label: "Max Task Time (In Seconds)"
    description: "Maximum time taken to perform a specific task. Value is displayed in Seconds. Calculation Used: Current Task Action Time - Previous Task Action Time, with respect to the most recent 'getnext' and 'completed' action for the same task within a given prescription transanction under a pharmacy chain"
    type: number
    sql: MAX(${TABLE}.TASK_TIME) ;;
    value_format: "###0.00"
  }

  measure: min_task_time {
    label: "Min Task Time (In Seconds)"
    description: "Minimum time taken to perform a specific task. Value is displayed in Seconds. Calculation Used: Current Task Action Time - Previous Task Action Time, with respect to the most recent 'getnext' and 'completed' action for the same task within a given prescription transanction under a pharmacy chain"
    type: number
    sql: MIN(${TABLE}.TASK_TIME) ;;
    value_format: "###0.00"
  }
}

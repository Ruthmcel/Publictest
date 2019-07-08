view: bi_demo_task_history_task_start_listagg {
# ERXDWPS-5883 - Derived view to get Task History Task Start times. Below logic/conditions are based on EPS Productivity report task start time logic.
# ERXDWPS-5883 - Latest start time of a task will be used as start time.
  derived_table: {
    sql: select chain_id
                ,nhin_store_id
                ,rx_tx_id
                ,task_history_user_employee_number
                ,upper(task_history_task_name) as task_history_task_name
                ,listagg(date_part(epoch_nanosecond, task_history_action_date) || ',' || task_history_action_date, ',') within group (order by task_history_action_date) task_history_action_date_hist
          from edw.f_task_history
          WHERE CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
            AND NHIN_STORE_ID IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
            and ( (task_history_task_action in ('getNext','manual_select','remote_select')
                   or regexp_instr(task_history_task_action, 'start') != 0
                  )
                  and task_history_task_action != 'fill_start'
                )
          group by chain_id
                  ,nhin_store_id
                  ,rx_tx_id
                  ,task_history_user_employee_number
                  ,task_history_task_name
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${task_history_user_employee_number} ||'@'|| ${task_history_task_name} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
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

  dimension: task_history_user_employee_number {
    type: string
    hidden: yes
    sql: ${TABLE}.TASK_HISTORY_USER_EMPLOYEE_NUMBER ;;
  }
  dimension: task_history_task_name {
    type: string
    hidden: yes
    sql: ${TABLE}.TASK_HISTORY_TASK_NAME ;;
  }

  dimension: task_history_action_date_hist {
    type: string
    hidden: yes
    sql: ${TABLE}.TASK_HISTORY_ACTION_DATE_HIST ;;
  }
}

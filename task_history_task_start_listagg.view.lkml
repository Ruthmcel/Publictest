view: task_history_task_start_listagg {
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
          where {% condition chain.chain_id %} chain_id {% endcondition %}
            and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
            and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                    where source_system_id = 5
                                      and {% condition chain.chain_id %} chain_id {% endcondition %}
                                      and {% condition store.store_number %} store_number {% endcondition %})
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

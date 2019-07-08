view: bi_demo_eps_task_history_rx_start_time {
  # Below comments were made as part of ERXLPS-49
  # 1. This view file is specifically for determining Prescription Transaction Start times
  # 2. The Prescription Start Times are based on the TASK_HISTORY_ACTION_DATE in the TASK_HISTORY table when the TASK_HISTORY_TASK_ACTION value is 'START' or 'ESCRIPT_DATA_ENTRY' and other conditions are met.
  # 3. The Prescription Start Times are aggregated on a Rx Refill grouping level. A START time may occur on a previous transaction, but be carried forward to a new and different RX_TX_ID.
  # 4. The Prescription Start Times will be used in comparison with WILL_CALL_ARRIVAL_DATE. Becuase we select the WILL_CALL_ARRIVAL_DATE on the TX level
  #     , when there is more than one TX for a Refill that has a populated WILL_CALL_ARRIVAL_DATE we will have duplicate rows in the result set on the same RX_ID and REFILL for WILL_CALL_ARRIVAL_DATE to START TIME comparisons
  #     NOTE: This behavior occurs with Partial Fills and Defects. Further enhancements may be made to handle this.
  # 5. These conditions identify and correctly select the record for when a refill is returned, Tx Status changes to 'N', if the transaction number changes, rx_tx_id changes, credited, cancelled, partial fills, etc...
  # [ERXDWPS-5916] - Added proper comments in SQL logic. Added extra filter condition to consider all possible task_history start time combinations for Workflow and RapidFill stores. Added a check to consider tasks which are performed before will_call_arrival_date.
  # [ERXDWPS-5916] - Rewrote SQL logic to consider task start times less than will call arrival date of refill.

  derived_table: {
    sql: WITH RX_TX AS
          (SELECT R.CHAIN_ID
                , R.NHIN_STORE_ID
                , R.RX_ID
                , RT.RX_TX_REFILL_NUMBER
                , RT.RX_TX_ID
                , NVL(
                      MIN(CASE WHEN RT.RX_TX_TX_STATUS = 'Y' THEN RT.RX_TX_WILL_CALL_ARRIVAL_DATE END)
                        OVER(PARTITION BY RT.CHAIN_ID, RT.NHIN_STORE_ID, RT.RX_ID, RT.RX_TX_REFILL_NUMBER), --minimum will call arrival date of active tranaction in a refill
                      MAX(RT.RX_TX_WILL_CALL_ARRIVAL_DATE) OVER(PARTITION BY RT.CHAIN_ID, RT.NHIN_STORE_ID, RT.RX_ID, RT.RX_TX_REFILL_NUMBER) --minimum will call arrival date of refill
                     ) AS RX_REFILL_WC_ARRIVAL --maximum will call arrival date for refill.
            FROM {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                    {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                    {% if active_archive_filter_input_value == 'archive'  %}
                      EDW.F_RX_ARCHIVE R
                    {% else %}
                      EDW.F_RX R
                    {% endif %}
                  {% else %}
                    EDW.F_RX R
                  {% endif %}
            INNER JOIN  {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                          {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                          {% if active_archive_filter_input_value == 'archive'  %}
                            EDW.F_RX_TX_LINK_ARCHIVE RT
                          {% else %}
                            EDW.F_RX_TX_LINK RT
                          {% endif %}
                        {% else %}
                          EDW.F_RX_TX_LINK RT
                        {% endif %}
              ON (R.CHAIN_ID = RT.CHAIN_ID AND R.NHIN_STORE_ID = RT.NHIN_STORE_ID AND R.RX_ID = RT.RX_ID)
            WHERE R.RX_DELETED = 'N'
              AND RT.RX_TX_TX_DELETED = 'N'
              AND R.RX_NUMBER IS NOT NULL
              AND RT.RX_TX_TX_STATUS NOT IN ('H', 'C')
              AND R.CHAIN_ID IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
              AND R.NHIN_STORE_ID IN (SELECT DISTINCT NHIN_STORE_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})  -- Required for performance reasons and to avoid scanning all chain/store records
              AND {% condition eps_rx_tx.rx_tx_refill_number %} RT.RX_TX_REFILL_NUMBER {% endcondition %}
              AND R.source_system_id = 4
              AND RT.source_system_id = 4
           )
           SELECT RT.CHAIN_ID
                , RT.NHIN_STORE_ID
                , RT.RX_ID
                , RT.RX_TX_REFILL_NUMBER
                , MAX (T.TASK_HISTORY_ACTION_DATE) PRESCRIPTION_START_TIME --consider latest TASK_ACTION_DATE of a valid transaction. If data_entry task do not exists, order_entry complete time considered as data_entry start time. For refills, background process start with order_entry and do not create data_entry.
            FROM RX_TX RT
            INNER JOIN  {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
                          {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                          {% if active_archive_filter_input_value == 'archive'  %}
                            EDW.F_TASK_HISTORY_ARCHIVE T
                          {% else %}
                            EDW.F_TASK_HISTORY T
                          {% endif %}
                        {% else %}
                          EDW.F_TASK_HISTORY T
                        {% endif %}
              ON (RT.CHAIN_ID = T.CHAIN_ID AND RT.NHIN_STORE_ID = T.NHIN_STORE_ID AND RT.RX_TX_ID = T.RX_TX_ID)
            WHERE --ERXDWPS-5916 Update task_history start options.
                  ( UPPER(T.TASK_HISTORY_TASK_NAME) = 'ESCRIPT_DATA_ENTRY' and UPPER(T.TASK_HISTORY_TASK_ACTION) IN ('GETNEXT','MANUAL_SELECT','REMOTE_SELECT')
                    OR
                    UPPER(T.TASK_HISTORY_TASK_NAME) = 'ORDER_ENTRY' and UPPER(T.TASK_HISTORY_TASK_ACTION) = 'COMPLETE' --Few refills do not have data_entry tasks. Considering order_entry complete time as data_entry start time.
                    OR
                    UPPER(T.TASK_HISTORY_TASK_NAME) = 'DATA_ENTRY' and UPPER(T.TASK_HISTORY_TASK_ACTION) IN ('GETNEXT','MANUAL_SELECT','REMOTE_SELECT')
                    OR
                    UPPER(T.TASK_HISTORY_TASK_NAME) = 'RX_FILLING' and UPPER(T.TASK_HISTORY_TASK_ACTION) IN ('GETNEXT','START','MANUAL_SELECT')
                  )
              AND NVL(RT.RX_REFILL_WC_ARRIVAL, TO_TIMESTAMP_NTZ(CURRENT_TIMESTAMP())) > T.TASK_HISTORY_ACTION_DATE
              AND {% condition eps_rx_tx.bi_demo_start_date %} T.TASK_HISTORY_ACTION_DATE_YYYYMMDD {% endcondition %}
              AND {% condition eps_rx_tx.bi_demo_start_time %} T.TASK_HISTORY_ACTION_DATE_YYYYMMDD {% endcondition %}
            GROUP BY RT.CHAIN_ID, RT.NHIN_STORE_ID, RT.RX_ID, RT.RX_TX_REFILL_NUMBER
       ;;
  }

  dimension: rx_id {
    hidden: yes
    label: "Rx ID"
    description: "Unique ID number identifying a Rx record from within a pharmacy for a given chain"
    type: number
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_tx_refill_number {
    hidden: yes
    label: "Prescription Refill Number"
    description: "Refill Number of a Prescription fill / Rx Number from within a pharmacy for a given chain"
    type: number
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_id} ||'@'||  ${rx_tx_refill_number} ;; #ERXLPS-1649
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

  #################################################################################################### DIMENSIONS ####################################################################################

  # This dimension is referenced by the start field in the eps_rx_tx view - Leave this hidden, but it generates the correct start time from this Derived view
  dimension: bi_demo_prescription_start {
    hidden: yes
    label: "Prescription Transaction Start String"
    description: "Date/Time that a Prescription was started. Latest occurrence of Order Entry/Data Entry/RX Filling start task is considered as Prescription start time."
    type: string
    sql: ${TABLE}.PRESCRIPTION_START_TIME ;;
  }
}

view: etl_manager_event_warehouse {
  derived_table: {
    sql: SELECT EVENT_ID,
      UPPER(REPLACE(TRIM(SUBSTR(LOG_MESSAGE,position(' is',LOG_MESSAGE,0)+3)),'.','')) AS ETL_WAREHOUSE_USED
      FROM ETL_MANAGER.EVENT_JOB_LOG EJL
      WHERE UPPER(EJL.JOB_NAME) LIKE '%MASTER%' AND UPPER(EJL.LOG_MESSAGE) LIKE '%WAREHOUSE SIZE%'
       ;;
  }

  dimension: event_id {
    hidden: yes
    primary_key: yes
    description: "Primary key field that references the event id column in EVENT table under ETL_MANAGER schema"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: etl_warehouse_used {
    type: string
    label: "ETL Warehouse Used"
    description: "Indicates the size of the Warehouse used (X-SMALL, SMALL, LARGE, X-LARGE) for the Processing of this ETL event"
    sql: ${TABLE}.ETL_WAREHOUSE_USED ;;
  }
}

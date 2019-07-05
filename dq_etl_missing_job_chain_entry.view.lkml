view: dq_etl_missing_job_chain_entry {
  derived_table: {
    sql: SELECT DISTINCT CHAIN_ID,0 AS SOURCE_SYSTEM_ID,EJTM.JOB_NAME FROM HOST_CDC_STAGE.DRUG DRIVER -- Primary table of the system
      INNER JOIN (SELECT * FROM ETL_MANAGER.ETL_JOB_TABLE_MAPPING WHERE SCHEMA_NAME = 'EDW' AND BI_ADMIN_CHAIN_USE_ONLY = 'N' AND JOB_NAME LIKE '%HOST%' ) EJTM
      ON 1=1
      WHERE
      NOT EXISTS
      ( SELECT DISTINCT EJCRF.CHAIN_ID FROM ETL_MANAGER.ETL_JOB_CHAIN_REFRESH_FREQUENCY EJCRF
         WHERE DRIVER.CHAIN_ID = EJCRF.CHAIN_ID
         AND EJCRF.JOB_NAME LIKE '%HOST%')

      UNION ALL

      SELECT DISTINCT CHAIN_ID,4 AS SOURCE_SYSTEM_ID,EJTM.JOB_NAME FROM EPS_STAGE.RX_TX_STAGE DRIVER  -- Primary table of the system
      INNER JOIN (SELECT * FROM ETL_MANAGER.ETL_JOB_TABLE_MAPPING WHERE SCHEMA_NAME = 'EDW' AND BI_ADMIN_CHAIN_USE_ONLY = 'N' AND JOB_NAME LIKE '%EPS%' ) EJTM
      ON 1=1
      WHERE
      NOT EXISTS
      ( SELECT DISTINCT EJCRF.CHAIN_ID FROM ETL_MANAGER.ETL_JOB_CHAIN_REFRESH_FREQUENCY EJCRF
         WHERE DRIVER.CHAIN_ID = EJCRF.CHAIN_ID
         AND EJCRF.JOB_NAME LIKE '%EPS%')

      UNION ALL

      SELECT DISTINCT CHAIN_ID,3 AS SOURCE_SYSTEM_ID,EJTM.JOB_NAME FROM EPR_STAGE.RX_TX_STAGE DRIVER  -- Primary table of the system
      INNER JOIN (SELECT * FROM ETL_MANAGER.ETL_JOB_TABLE_MAPPING WHERE SCHEMA_NAME = 'EDW' AND BI_ADMIN_CHAIN_USE_ONLY = 'N' AND JOB_NAME LIKE '%EPR%' ) EJTM
      ON 1=1
      WHERE
      NOT EXISTS
      ( SELECT DISTINCT EJCRF.CHAIN_ID FROM ETL_MANAGER.ETL_JOB_CHAIN_REFRESH_FREQUENCY EJCRF
         WHERE DRIVER.CHAIN_ID = EJCRF.CHAIN_ID
         AND EJCRF.JOB_NAME LIKE '%EPR%')
       ;;
  }

  dimension: job_name {
    primary_key: yes
    description: "Name of the ETL job (in the master controller package) that processes data to the target table"
    type: string
    sql: ${TABLE}.JOB_NAME ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ################################################################################################### Measures ############################################################

  measure: count {
    type: count
  }
}

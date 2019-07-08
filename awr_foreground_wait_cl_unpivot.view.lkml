view: awr_foreground_wait_cl_unpivot {
  label: "Foreground Wait Class Types"

  derived_table: {
    sql: SELECT AWR_RPT_ID,
       FOREGROUND_WAIT_CLASS,
       FOREGROUND_WAIT_CLASS_PCT
FROM   AWR_DATA.FOREGROUND_WAIT_CLASS
UNPIVOT (FOREGROUND_WAIT_CLASS_PCT
                         FOR FOREGROUND_WAIT_CLASS
                         IN (USER_IO_PCT AS 'USER IO',
                              SYS_IO_PCT AS 'SYSTEM IO',
                              OTHER_PCT AS 'OTHER',
                              APPLICATION_PCT AS 'APPLICATION',
                              COMMIT_PCT AS 'COMMIT',
                              NETWORK_PCT AS 'NETWORK',
                              CONCURRENCY_PCT AS 'CONCURRENCY',
                              CONFIGURATION_PCT AS 'CONFIGURATION',
                              CLUSTER_PCT AS 'CLUSTER',
                              DB_CPU_PCT AS 'DATABASE CPU'))
 ;;
  }

  # Notes:
  # 1. View file added as a part of ERXLPS-90 change

  dimension: awr_rpt_id {
    type: number
    hidden: yes
    label: "AWR Report ID"
    description: "Unique number identifiying an Automatic Workload Repository for the Begin and End Snapshot"
    sql: ${TABLE}.AWR_RPT_ID ;;
  }

  dimension: foreground_wait_class {
    label: "Foreground Wait Class"
    description: "Shows the different Foreground Wait Class such as Cluster, User IO, System IO, Application, etc"
    type: string
    sql: ${TABLE}.FOREGROUND_WAIT_CLASS ;;
  }

  measure: foreground_wait_class_pct {
    label: "Foreground Wait Class %"
    description: "Shows the different Foreground Wait Class such as Cluster, User IO, System IO, Application, etc"
    type: number
    sql: AVG(${TABLE}.FOREGROUND_WAIT_CLASS_PCT) ;;
    value_format: "###0.00"
  }
}

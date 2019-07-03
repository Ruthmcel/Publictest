view: avro_eps_workflow {
  derived_table: {
    sql: select  src.ID,
        src.CHAIN_ID,
        src.NHIN_STORE_ID,
        src.RX_TX_ID,
        src.SOURCE_TIMESTAMP,
        src.WORKFLOW_PRESENT_STATE,
        src.USER_LICENSE_TYPE,
        src.ORDER_PICKUP_TYPE,
        CASE WHEN src.USER_LICENSE_TYPE =  'RPh' AND WORKFLOW_PRESENT_STATE = 'Product Verification' THEN 1 ELSE 0 END AS PRESCRIPTIONS_FILLED_BY_PHARMACIST
        FROM
        (SELECT
              t.logentry:id::number AS ID,
              MAX(t.logentry:chain_id::NUMBER) AS CHAIN_ID,
              MAX(t.logentry:store_id::NUMBER) AS NHIN_STORE_ID,
              MAX(f.value:propertyValueMap:txTxId::number) AS RX_TX_ID,
              MAX(to_timestamp_ntz((SUBSTR(logentry:source_timestamp,5,3)||'-'|| SUBSTR(logentry:source_timestamp,9,2)||'-'|| SUBSTR(logentry:source_timestamp,25,4)||' '|| SUBSTR(logentry:source_timestamp,12,8)),'mon-dd-yyyy hh24:mi:ss')) AS SOURCE_TIMESTAMP,
              MAX(f.value:propertyValueMap:piror_State::string) AS WORKFLOW_PRIOR_STATE,
              MAX(f.value:propertyValueMap:present_State::string) AS WORKFLOW_PRESENT_STATE,
              MAX(f.value:propertyValueMap:license_Type::string) AS USER_LICENSE_TYPE,
              MAX(f.value:propertyValueMap:orderPickupType::string) AS ORDER_PICKUP_TYPE,
              MAX(typeof(f.value)) AS "Type",
              MAX(t.logentry)
              FROM
              ETL_MANAGER.WORKFLOW_AVRO t,
              lateral flatten(t.logentry, 'entities') f
        GROUP BY 1 ) src
       ;;
  }

  dimension: id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: chain_id {
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: workflow_present_state {
    type: string
    sql: ${TABLE}.WORKFLOW_PRESENT_STATE ;;
  }

  dimension: user_license_type {
    type: string
    sql: ${TABLE}.USER_LICENSE_TYPE ;;
  }

  dimension: ORDER_PICKUP_TYPE {
    type: string
    sql: ${TABLE}.ORDER_PICKUP_TYPE ;;
  }

  dimension_group: source_timestamp {
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
  }

  measure: prescriptions_filled_by_pharmacist {
    type: sum
    sql: ${TABLE}.PRESCRIPTIONS_FILLED_BY_PHARMACIST ;;
    value_format: "#,##0"
  }
}

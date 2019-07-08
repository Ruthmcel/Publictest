view: store_rx_tx_diagnosis_code {
  label: "Store Rx Tx Diagnosis Code"
  sql_table_name: EDW.F_STORE_RX_TX_DIAGNOSIS_CODE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_rx_tx_diagnosis_code_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_rx_tx_diagnosis_code_id {
    label: "Store Rx Tx Diagnosis Code Id"
    description: "Unique ID number identifying this record. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_ID ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "ID number identifying the rx_tx record associated with the diagnosis code. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_rx_tx_diagnosis_code {
    label: "Store Rx Tx Diagnosis Code"
    description: "ICD9 or ICD10 code entered during data entry. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE ;;
  }

  dimension: store_rx_tx_diagnosis_code_prefix {
    label: "Store Rx Tx Diagnosis Code Prefix"
    description: "Used to identify External Causes codes of the Disease Section. Contain the Diagnosis code prefix. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX is null THEN 'NOT PRESENT'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'E' THEN 'E - EXTERNAL CAUSE'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'V' THEN 'V - FACTORS'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'B' THEN 'B - CANADIAN ODB'
              ELSE TO_CHAR(${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX)
         END ;;
  }

  dimension: store_rx_tx_diagnosis_code_qualifier {
    label: "Store Rx Tx Diagnosis Code Qualifier"
    description: "Identifies diagnosis code as an ICD9 or ICD10 code. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER is null THEN 'ICD 9'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER = '1' THEN '1 - ICD 10'
              ELSE TO_CHAR(${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER)
         END ;;
  }

  dimension: store_rx_tx_diagnosis_code_sequence {
    label: "Store Rx Tx Diagnosis Code Sequence"
    description: "Identifies the order that the diagnosis codes should be be adjudicated. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_SEQUENCE ;;
  }

  dimension: store_rx_tx_diagnosis_code_formatted {
    label: "Store Rx Tx Diagnosis Code Formatted"
    description: "Contain ICD9 or ICD10 code entered during data entry. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_FORMATTED ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Rx Tx Diagnosis Code Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Rx Tx Diagnosis Code Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

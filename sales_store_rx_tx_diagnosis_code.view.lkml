view: sales_store_rx_tx_diagnosis_code {
  label: "Prescription Transaction Diagnosis Code"
  sql_table_name: EDW.F_STORE_RX_TX_DIAGNOSIS_CODE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_rx_tx_diagnosis_code_id}||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;;
  }

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_rx_tx_diagnosis_code_id {
    label: "Prescription Transaction Diagnosis Code Id"
    description: "Unique ID number identifying this record. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: rx_tx_id {
    label: "Prescription Transaction Id"
    description: "ID number identifying the rx_tx record associated with the diagnosis code. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: store_rx_tx_diagnosis_code {
    label: "Prescription Transaction Diagnosis Code"
    description: "ICD9 or ICD10 code entered during data entry. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE ;;
  }

  dimension: store_rx_tx_diagnosis_code_description {
    label: "Prescription Transaction Diagnosis Code Description"
    description: "Description of the ICD-9 or ICD10. EPS Table: ICD9/ICD10"
    type: string
    sql: CASE WHEN ${store_rx_tx_diagnosis_code_qualifier} IS NULL THEN ${sales_rx_tx_diagnosis_code_icd9.store_icd9_description}
              WHEN ${store_rx_tx_diagnosis_code_qualifier} = '1' THEN ${sales_rx_tx_diagnosis_code_icd10.store_icd10_description}
         END ;;
  }

  dimension: store_rx_tx_diagnosis_code_prefix_reference {
    label: "Prescription Transaction Diagnosis Code Prefix"
    description: "Used to identify External Causes codes of the Disease Section. Contains the Diagnosis code prefix. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX ;;
  }

  #[ERXDWPS-6304] - Added store_rx_tx_diagnosis_code_id in CASE WHEN logic to handle actual NULL values in table. Without adding ID it will display all NULL values (genrated due to left outer join) as master code values.
  dimension: store_rx_tx_diagnosis_code_prefix {
    label: "Prescription Transaction Diagnosis Code Prefix"
    description: "Used to identify External Causes codes of the Disease Section. Contains the Diagnosis code prefix. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: CASE WHEN ${store_rx_tx_diagnosis_code_id} IS NOT NULL AND ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX is NULL THEN 'NULL - NOT PRESENT'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'E' THEN 'E - EXTERNAL CAUSE'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'V' THEN 'V - FACTORS'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX = 'B' THEN 'B - CANADIAN ODB'
              ELSE ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_PREFIX
         END ;;
    drill_fields: [store_rx_tx_diagnosis_code_prefix_reference]
    suggestions: ["NULL - NOT PRESENT", "E - EXTERNAL CAUSE", "V - FACTORS", "B - CANADIAN ODB"]
  }

  #[ERXDWPS-6304] - Added store_rx_tx_diagnosis_code_id in CASE WHEN logic to handle actual NULL values in table. Without adding ID it will display all NULL values (genrated due to left outer join) as master code values.
  dimension: store_rx_tx_diagnosis_code_qualifier_reference {
    label: "Prescription Transaction Diagnosis Code Qualifier"
    description: "Identifies diagnosis code as an ICD9 or ICD10 code. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER ;;

  }

  dimension: store_rx_tx_diagnosis_code_qualifier {
    label: "Prescription Transaction Diagnosis Code Qualifier"
    description: "Identifies diagnosis code as an ICD9 or ICD10 code. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: CASE WHEN ${store_rx_tx_diagnosis_code_id} IS NOT NULL AND ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER is NULL THEN 'NULL - ICD 9'
              WHEN ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER = '1' THEN '1 - ICD 10'
              ELSE ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_QUALIFIER
         END ;;
    drill_fields: [store_rx_tx_diagnosis_code_qualifier_reference]
    suggestions: ["NULL - ICD 9", "1 - ICD 10"]
  }

  dimension: store_rx_tx_diagnosis_code_sequence {
    label: "Prescription Transaction Diagnosis Code Sequence"
    description: "Identifies the order that the diagnosis codes should be adjudicated. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: number
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_SEQUENCE ;;
  }

  dimension: store_rx_tx_diagnosis_code_formatted {
    label: "Prescription Transaction Diagnosis Code Formatted"
    description: "Contains ICD9 or ICD10 code entered during data entry. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: string
    sql: ${TABLE}.STORE_RX_TX_DIAGNOSIS_CODE_FORMATTED ;;
  }

  dimension_group: source_create_timestamp {
    label: "Prescription Transaction Diagnosis Code Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Prescription Transaction Diagnosis Code Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: RX_TX_DIAGNOSIS_CODES"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

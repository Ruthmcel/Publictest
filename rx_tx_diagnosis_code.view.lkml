view: rx_tx_diagnosis_code {
  sql_table_name: EDW.F_RX_TX_DIAGNOSIS_CODE ;;

  dimension: chain_id {
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_tx_diagnosis_code_id {
    hidden: yes
    sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_ID ;;
  }

  dimension: rx_tx_diagnosis_code_unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${rx_tx_diagnosis_code_id} ;; #ERXLPS-1649
  }

  dimension: rx_tx_id {
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: diagnosis_code_deleted {
    hidden: yes
    sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_DELETED ;;
  }

  dimension: diagnosis_code {
    label: "Prescription Diagnosis Code"
    description: "Diagnosis code selected during data entry"
    sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE ;;
  }

  dimension: diagnosis_code_prefix {
    label: "Prescription Diagnosis Code Prefix"
    description: "Used to identify External Causes codes of the Disease Section"
    sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_PREFIX ;;
  }

  dimension: diagnosis_code_qualifier {
    label: "Prescription Diagnosis Code Qualifier"
    description: "Identifies diagnosis code as an ICD9 or ICD10 code"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_QUALIFIER IS NULL ;;
        label: "ICD-9"
      }

      when: {
        sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_QUALIFIER = 1 ;;
        label: "ICD-10"
      }

      when: {
        sql: true ;;
        label: "Unknown"
      }
    }
  }

  dimension: diagnosis_code_sequence {
    label: "Prescription Diagnosis Code Seq"
    description: "Identifies the order that the diagnosis codes should be be adjudicated"
    sql: ${TABLE}.RX_TX_DIAGNOSIS_CODE_SEQUENCE ;;
  }

  measure: rx_tx_diagnosis_code_count {
    label: "Prescription Diagnosis Codes Count"
    type: count
    value_format: "#,##0"
  }
}

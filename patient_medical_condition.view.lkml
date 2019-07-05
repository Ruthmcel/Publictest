view: patient_medical_condition {
  sql_table_name: EDW.D_PATIENT_MEDICAL_CONDITION ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    label: "Central Patient RX COM ID"
    description: "Patient unique identifier"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: medical_condition_id {
    hidden: yes
    description: "Unique ID identifying a patient medical condition record on the Rx.com network"
    type: number
    sql: ${TABLE}.MEDICAL_CONDITION_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${medical_condition_id} ;; #ERXLPS-1649
  }

  dimension: nhin_store_id {
    group_label: "Central Patient Medical Condition Info"
    label: "Central Patient Medical Condition NHIN STORE ID"
    description: "Pharmacy where the patient medical condition record was entered"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: code {
    group_label: "Central Patient Medical Condition Info"
    label: "Central Patient Medical Condition Code"
    description: "Code pertaining to the medical condition record "
    type: string
    sql: ${TABLE}.PATIENT_MED_COND_CODE ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_MED_COND_DELETED ;;
  }

  dimension: icd10 {
    group_label: "Central Patient Medical Condition Info"
    label: "Central Patient Medical Condition ICD10 Code"
    description: "Patient's Medical Condition ICD10 Code"
    type: string
    sql: ${TABLE}.PATIENT_MED_COND_ICD10 ;;
  }

  dimension: last_rx_date {
    group_label: "Central Patient Medical Condition Info"
    label: "Central Patient Medical Condition last RX Date"
    description: "Last time a prescription was filled to treat this medical condition"
    type: date
    sql: ${TABLE}.PATIENT_MED_COND_LAST_RX_DATE ;;
  }

  dimension: stop_date {
    group_label: "Central Patient Medical Condition Info"
    label: "Central Patient Medical Condition Stop Date"
    description: "Date to stop checking medical condition diagnosis"
    type: date
    sql: ${TABLE}.PATIENT_MED_COND_STOP_DATE ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: patient_medical_condition_count {
    label: "Central Patient Medical Condition Count"
    type: count
  }
}

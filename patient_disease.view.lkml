view: patient_disease {
  sql_table_name: EDW.D_PATIENT_DISEASE ;;

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

  dimension: id {
    hidden: yes
    description: "Unique ID identifying a patient disease record on the Rx.com network"
    type: number
    sql: ${TABLE}.DISEASE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${id} ;; #ERXLPS-1649

  }

  dimension: nhin_store_id {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease NHIN STORE ID"
    description: "Pharmacy where the patient disease record was entered"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: disease_ds_code {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease Diagnosis Code"
    description: "Diagnosis Code pertaining to the disease record"
    type: string
    sql: ${TABLE}.PATIENT_DISEASE_DS_CODE ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_DISEASE_DELETED ;;
  }

  dimension: icd9 {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease ICD9 Code"
    description: "Patient's Disease ICD9 Code. The International Classification of Diseases code assigned by the World Health Organisation to uniquely identify a disease"
    type: string
    sql: ${TABLE}.PATIENT_DISEASE_ICD9 ;;
  }

#[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: icd9_type_reference {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease ICD9 Type"
    description: "Identifies the ICD9 type such as EXTERNAL, FACTORS, MORPHOLOGY, CANADIAN ONTARIO DRUG BENEFIT"
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_DISEASE_ICD9_TYPE ;;
  }

  dimension: icd9_type {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease ICD9 Type"
    description: "Identifies the ICD9 type such as EXTERNAL, FACTORS, MORPHOLOGY, CANADIAN ONTARIO DRUG BENEFIT"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_DISEASE_ICD9_TYPE', ${TABLE}.PATIENT_DISEASE_ICD9_TYPE,'N') ;;
    drill_fields: [icd9_type_reference]
    suggestions: ["EXTERNAL", "FACTORS", "MORPHOLOGY", "ODB", "NOT SPECIFIED"]
  }

  dimension: converted {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease Converted"
    description: "Y/N Flag that determines whether the record was converted from a legacy system"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_DISEASE_CONVERTED = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

#[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: duration_reference {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease Duration"
    description: "Expected duration type of the disease. Possible values are: ACUTE, CHRONIC, NOT SPECIFIED"
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_DISEASE_DURATION ;;
  }

  dimension: duration {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease Duration"
    description: "Expected duration type of the disease. Possible values are: ACUTE, CHRONIC, NOT SPECIFIED"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_DISEASE_DURATION', ${TABLE}.PATIENT_DISEASE_DURATION,'N') ;;
    drill_fields: [duration_reference]
    suggestions: ["ACUTE", "CHRONIC","UNKNOWN"]
  }

  dimension: last_rx_date {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease last RX Date"
    description: "Last time a prescription was filled to treat this disease"
    type: date
    sql: ${TABLE}.PATIENT_DISEASE_LAST_RX_DATE ;;
  }

  dimension: stop_date {
    group_label: "Central Patient Disease Info"
    label: "Central Patient Disease Stop Date"
    description: "Date to stop checking disease diagnosis"
    type: date
    sql: ${TABLE}.PATIENT_DISEASE_STOP_DATE ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: patient_disease_count {
    label: "Central Patient Disease Count"
    type: count
  }
}

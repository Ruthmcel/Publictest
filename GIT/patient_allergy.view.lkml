#[ERXDWPS-8536] - View file updated. Updted few dimension to type: yesno. Exposed Allergy Code and Reported by.
view: patient_allergy {
  sql_table_name: EDW.D_PATIENT_ALLERGY ;;

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

  dimension: code {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Code"
    #hidden: yes
    description: "Unique code for the allergy. User entered via the client or can be added by a patient select response from EPR"
    type: number
    sql: ${TABLE}.PATIENT_ALLERGY_CODE ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${code} ;; #ERXLPS-1649
  }

  dimension: patient_allergy_nhin_store_id {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy NHIN STORE ID"
    description: "Pharmacy where the patient allergy record was entered"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: blood {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Blood"
    description: "Yes/No Flag indicating that this allergy causes an adverse reaction to the blood"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_BLOOD = 'Y' ;;
  }

  dimension: breath {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Breath"
    description: "Yes/No Flag indicating that this allergy causes an adverse reaction to breathing"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_BREATH = 'Y' ;;
  }

  dimension: converted {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Converted"
    description: "Y/N Flag that determines whether the record has been converted to the new PAR/KDC class"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_CONVERTED = 'Y' ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_ALLERGY_DELETED ;;
  }

  dimension: patient_allergy_gi_tract {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy GI Tract"
    description: "Yes/No Flag indicating that this allergy cause an adverse reaction in the GI Tract"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_GI_TRACT = 'Y' ;;
  }

  dimension: rash {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Rash"
    description: "Yes/No Flag indicating if the adverse reaction/allergy is in the form of rash"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_RASH = 'Y' ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: reported_by_reference {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Reported By"
    description: "Advises who reported the allergy"
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_ALLERGY_REPORTED_BY ;;
  }

  dimension: reported_by {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Reported By"
    description: "Advises who reported the allergy"
    type: string
    sql: CASE WHEN ${TABLE}.PATIENT_ALLERGY_CODE IS NOT NULL AND ${TABLE}.PATIENT_ALLERGY_REPORTED_BY IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.PATIENT_ALLERGY_REPORTED_BY = 'DP' THEN 'DP - DRUG POISON CENTER'
              WHEN ${TABLE}.PATIENT_ALLERGY_REPORTED_BY = 'PA' THEN 'PA - PATIENT'
              WHEN ${TABLE}.PATIENT_ALLERGY_REPORTED_BY = 'PH' THEN 'PH - PHARMACIST'
              WHEN ${TABLE}.PATIENT_ALLERGY_REPORTED_BY = 'PR' THEN 'PR - PRESCRIBER'
              ELSE 'UNKNOWN'
         END ;;
    drill_fields: [reported_by_reference]
    suggestions: ["DP - DRUG POISON CENTER", "PA - PATIENT", "PH - PHARMACIST", "PR - PRESCRIBER", "NULL - UNKNOWN"]
  }

  dimension: shock {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Shock"
    description: "Yes/No Flag indicating this type of advsere reaction apply"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_SHOCK = 'Y' ;;
  }

  dimension: unspecified {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Unspecified Reactions"
    description: "Yes/No Flag indicating are there additional unspecified reactions"
    type: yesno
    sql: ${TABLE}.PATIENT_ALLERGY_UNSPECIFIED = 'Y' ;;
  }

  #Patient Allergy dimensions are group under Central Patient Allergy Info group label. Hence create this dimension as type: date
  dimension: start_date {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Start Date"
    description: "Date Adverse Reaction Started"
    type: date
    sql: ${TABLE}.PATIENT_ALLERGY_START_DATE ;;
  }

  #Patient Allergy dimensions are group under Central Patient Allergy Info group label. Hence create this dimension as type: date
  dimension: added_date {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy Added Date"
    description: "Date Record Was Added"
    type: date
    sql: ${TABLE}.PATIENT_ALLERGY_ADDED_DATE ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_allergy_id {
    group_label: "Central Patient Allergy Info"
    label: "Central Patient Allergy ID"
    description: "Unique ID number identifying a patient allregy record"
    type: number
    sql: ${TABLE}.PATIENT_ALLERGY_ID ;;
  }

  measure: patient_allergy_count {
    label: "Central Patient Allergy Count"
    type: count
  }
}

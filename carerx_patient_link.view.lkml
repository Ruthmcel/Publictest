view: carerx_patient_link {
  sql_table_name: MTM_CLINICAL.PATIENT_LINK ;;

  dimension: original_patient_id {
    hidden: yes
    primary_key: yes
    label: "Patient Original ID"
    description: "The unique database ID of an older Care Rx patient record that is now linked to the most current patient record"
    type: number
    sql: ${TABLE}.ORIGINAL_PATIENT_ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: current_patient_id {
    hidden: yes
    label: "Patient Current ID"
    description: "The unique database ID of the most current record for a patient"
    type: number
    sql: ${TABLE}.CURRENT_PATIENT_ID ;;
  }
}

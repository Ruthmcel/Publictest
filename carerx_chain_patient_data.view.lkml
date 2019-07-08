view: carerx_chain_patient_data {
  sql_table_name: MTM_CLINICAL.CHAIN_PATIENT_DATA ;;
  ## ======= The following MTM_CLINICAL.CHAIN_PATIENT_DATA Database Objects were not exposed in this view ======= ##
  ## LAST_UPDATE_DATE

  # used for joining with other tables in the MTM_CLINICAL schema
  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "The CareRx unique database ID of the chain that the Care Rx patient is linked to. This is NOT the Chain NHIN ID assigned by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: original_patient_id {
    hidden: yes
    label: "Patient Original ID"
    description: "The Original unique database ID of the patient, before changes to patient data took place"
    type: number
    sql: ${TABLE}.ORIGINAL_PATIENT_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: last_sold_store_nhin_id {
    label: "Patient Last Store PHarmacy NHIN ID"
    description: "The Pharmacy NHIN Store ID where the patient last had a sold prescription transaction in the Pharmacy Chain."
    type: number
    sql: ${TABLE}.LAST_SOLD_STORE_NHINID ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: mtm_eligibility_last_update {
    label: "Patient MTM Eligibility Last Update"
    description: "The last date/time that the patient's MTM eligibility was updated for the patient at the chain"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.MTM_ELIG_LAST_UPDATED ;;
  }

  dimension_group: chain_patient_deactivated {
    label: "Chain Patient Deactivated"
    description: "The date/time that the Chain Specific Patient was deactivated"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DEACTIVATE_DATE ;;
  }
}

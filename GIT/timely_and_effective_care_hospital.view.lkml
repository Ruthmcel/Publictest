view: timely_and_effective_care_hospital {
  sql_table_name: REPORT_TEMP.TIMELY_AND_EFFECTIVE_CARE_HOSPITAL ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id}  ||'@'|| ${measure_id} ;;
  }

########################################## foreign key references  ###########################################################

  dimension: provider_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: measure_id {
#     hidden: yes
    type: string
    sql: ${TABLE}.MEASURE_ID ;;
  }

#################################################################################################################################################

  dimension: address {
    hidden: yes
    type: string
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: city {
    hidden: yes
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: county_name {
    hidden: yes
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: hospital_name {
    hidden: yes
    type: string
    sql: ${TABLE}.HOSPITAL_NAME ;;
  }

  dimension: state {
    hidden: yes
    type: string
    sql: ${TABLE}.STATE ;;
  }

  dimension: zip_code {
    hidden: yes
    type: zipcode
    sql: ${TABLE}.ZIP_CODE ;;
  }

  dimension: phone_number {
    hidden: yes
    type: string
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: condition {
    type: string
    sql: ${TABLE}.CONDITION ;;
  }


  dimension: footnote {
    type: string
    sql: ${TABLE}.FOOTNOTE ;;
  }


  dimension_group: measure_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MEASURE_START_DATE ;;
  }

  dimension_group: measure_end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MEASURE_END_DATE ;;
  }

  dimension: measure_name {
    hidden:  yes
    type: string
    sql: ${TABLE}.MEASURE_NAME ;;
  }

# Values such as High (40,000 - 59,999 patients annually) exist so defined as dimension unless business identifies possible values to use.
#   measure: total_score {
#     type: sum
#     sql: CASE WHEN ${measure_id} <> 'EDV' THEN ${TABLE}.SCORE END ;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }
#
#   measure: total_sample {
#     type: sum
#     sql: CASE WHEN ${measure_id} <> 'EDV' THEN ${TABLE}."SAMPLE" END;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }
#
#   measure: total_edv_score {
#     label: "Total Emergency Department Volume Score"
#     hidden:  yes
#     type: sum
#     sql: CASE WHEN ${measure_id} = 'EDV' THEN ${TABLE}.SCORE END ;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }
#
#   measure: total_edv_sample {
#     label: "Total Emergency Department Volume Sample"
#     hidden:  yes
#     type: sum
#     sql: CASE WHEN ${measure_id} = 'EDV' THEN ${TABLE}."SAMPLE" END;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }

  measure: median_ed_time_prior_to_admit {
    label: "ED Time Prior to Admit (In Minutes)"
    description: "Average (median) time patients spent in the emergency department, before they were admitted to the hospital as an inpatient (alternate Measure ID: ED-1)"
    type: median
    sql: CASE WHEN ${measure_id} IN ('ED_1b') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_ed_time_post_admit {
    label: "ED Time Post Admit Descision (In Minutes)"
    description: "Average (median) time patients spent in the emergency department, after the doctor decided to admit them as an inpatient before leaving the emergency department for their inpatient room (alternate Measure ID: ED-2)"
    type: median
    sql: CASE WHEN ${measure_id} IN ('ED_2b') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_patient_given_flu_vac {
    label: "Patients Given Flu Vac"
    description: "Patients assessed and given influenza vaccination"
    type: median
    sql: CASE WHEN ${measure_id} IN ('IMM_2') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_hc_worker_given_flu_vac {
    label: "HC Workers Given Flu Vac"
    description: "Healthcare workers given influenza vaccination (alternate Measure ID: IMM-3_OP_27_FAC_ADHPCT)"
    type: median
    sql: CASE WHEN ${measure_id} IN ('IMM_3') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_time_to_fibrinolysis {
    label: "Time to Fibrinolysis (In Minutes)"
    description: "Median time to fibrinolysis"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_1') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_ed_visit_time {
    label: "ED Visit Time (In Minutes)"
    description: "Average (median) time patients spent in the emergency department before leaving from the visit (alternate Measure ID: OP-18)"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_18b') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_fibrinolytic_theraphy {
    label: "Fibrinolytic Therapy Received Within 30 Minutes of ED Arrival (In Minutes)"
    description: "Outpatients with chest pain or possible heart attack who got drugs to break up blood clots within 30 minutes of arrival"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_2') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_time_door_to_diagnotic_eval {
    label: "Door to Diagnostic Eval (In Minutes)"
    description: "Average (median) time patients spent in the emergency department before they were seen by a healthcare professional"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_20') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_time_to_pain_med {
    label: "Median time to pain med (In Minutes)"
    description: "Average (median) time patients who came to the emergency department with broken bones had to wait before getting pain medication"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_21') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_patient_left_before_seen {
    label: "Patients Left before being seen"
    description: "Percentage of patients who left the emergency department before being seen"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_22') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_head_ct_results {
    label: "Head CT results"
    description: "Percentage of patients who came to the emergency department with stroke symptoms who received brain scan results within 45 minutes of arrival"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_23') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_follow_up_interval_colonoscopy {
    label: "Follow-up Interval for Normal Colonoscopy (avg risk)"
    description: "Percentage of patients receiving appropriate recommendation for follow-up screening colonoscopy"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_29') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_colonoscopy_interval_for_patient {
    label: "Colonoscopy Interval for Patients (hist of adenomatous polyps)"
    description: "Percentage of patients with history of polyps receiving follow-up colonoscopy in the appropriate timeframe"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_30') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_improvement_in_patient_visual_function {
    label: "Improvement in Patient’s Visual Function within 90 Days Following Cataract Surgery"
    description: "Percentage of patients who had cataract surgery and had improvement in visual function within 90 days following the surgery"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_31') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_external_beam_radiotheraphy {
    label: "External Beam Radiotherapy for Bone Metastases"
    description: "Percentage of patients receiving appropriate radiation therapy for cancer that has spread to the bone"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_33') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_transfer_to_another_facility_for_acute_coronary {
    label: "Transfer to Another Facility for Acute Coronary Intervention"
    description: "Average (median) number of minutes before outpatients with chest pain or possible heart attack who needed specialized care were transferred to another hospital"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_3b') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_aspirin_at_arrival {
    label: "Aspirin at Arrival"
    description: "Outpatients with chest pain or possible heart attack who received aspirin within 24 hours of arrival or before transferring from the emergency department"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_4') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_time_to_ecg {
    label: "Median Time to ECG (In Minutes)"
    description: "Average (median) number of minutes before outpatients with chest pain or possible heart attack got an ECG"
    type: median
    sql: CASE WHEN ${measure_id} IN ('OP_5') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_newborn_delivery {
    label: "Newborns (1-3 weeks early) and delivery was not medically necessary"
    description: "Percent of mothers whose deliveries were scheduled too early (1-2 weeks early), when a scheduled delivery was not medically necessary"
    type: median
    sql: CASE WHEN ${measure_id} IN ('PC_01') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: median_hospital_acquired_venous_thromboembolism {
    label: "Hospital acquired venous thromboembolism"
    description: "Patients who developed a blood clot while in the hospital who did not get treatment that could have prevented it"
    type: median
    sql: CASE WHEN ${measure_id} IN ('VTE_6') THEN ${TABLE}.SCORE END;;
    value_format: "#,##0;(#,##0)"
  }

}

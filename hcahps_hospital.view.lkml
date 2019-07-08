view: hcahps_hospital {
  sql_table_name: REPORT_TEMP.HCAHPS_HOSPITAL ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id}  ||'@'|| ${hcahps_measure_id} ;;
  }

####################################################### Foreign Key References #######################################################
  dimension: provider_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: hcahps_measure_id {
    type: string
#     hidden: yes
    sql: ${TABLE}.HCAHPS_MEASURE_ID ;;
  }
#####################################################################################################################################

  dimension: address {
    type: string
    hidden: yes
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: city {
    type: string
    hidden: yes
    sql: ${TABLE}.CITY ;;
  }

  dimension: county_name {
    type: string
    hidden: yes
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: hcahps_answer_description {
    label: "HCAHPS Answer Description"
    type: string
    sql: ${TABLE}.HCAHPS_ANSWER_DESCRIPTION ;;
  }

  dimension: hcahps_answer_percent_footnote {
    label: "HCAHPS Answer % Footnote"
    type: string
    sql: ${TABLE}.HCAHPS_ANSWER_PERCENT_FOOTNOTE ;;
  }

  dimension: hcahps_question {
    label: "HCAHPS Question"
    type: string
    sql: ${TABLE}.HCAHPS_QUESTION ;;
  }

  dimension: hospital_name {
    type: string
    hidden: yes
    sql: ${TABLE}.HOSPITAL_NAME ;;
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

# This field does contain values such as "higher than 50000"
  dimension: number_of_completed_surveys {
    type: string
    sql: ${TABLE}.NUMBER_OF_COMPLETED_SURVEYS ;;
  }

  dimension: number_of_completed_surveys_footnote {
    type: string
    sql: ${TABLE}.NUMBER_OF_COMPLETED_SURVEYS_FOOTNOTE ;;
  }

  dimension: patient_survey_star_rating_footnote {
    type: string
    sql: ${TABLE}.PATIENT_SURVEY_STAR_RATING_FOOTNOTE ;;
  }

  dimension: phone_number {
    type: string
    hidden: yes
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: state {
    type: string
    hidden: yes
    sql: ${TABLE}.STATE ;;
  }

  dimension: survey_response_rate_percent_footnote {
    type: string
    sql: ${TABLE}.SURVEY_RESPONSE_RATE_PERCENT_FOOTNOTE ;;
  }

  dimension: zip_code {
    type: zipcode
    hidden: yes
    sql: ${TABLE}.ZIP_CODE ;;
  }

  measure: total_providers {
    hidden:  yes
    type: count
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: summary_star_rating_reference {
    label: "Summary Star Rating"
    hidden: yes
    type: average
    sql: (CASE WHEN ${hcahps_measure_id} IN ('H_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END);;
    value_format: "#,##0;(#,##0)"
  }

  measure: summary_star_rating {
    label: "Summary Star Rating"
    type: number
    sql: ROUND(${summary_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }


  measure: cleanliness_star_rating_reference {
    label: "Cleanliness Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_CLEAN_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: cleanliness_star_rating {
    label: "Cleanliness Star Rating"
    type: number
    sql: ROUND(${cleanliness_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: nurse_communication_star_rating_reference {
    label: "Nurse Communication Star Rating"
    hidden: yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_1_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: nurse_communication_star_rating {
    label: "Nurse Communication Star Rating"
    type: number
    sql: ROUND(${nurse_communication_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: doctor_communication_star_rating_reference {
    label: "Doctor Communication Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_2_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: doctor_communication_star_rating {
    label: "Doctor Communication Star Rating"
    type: number
    sql: ROUND(${doctor_communication_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: staff_responsiveness_star_rating_reference {
    label: "Staff Responsiveness Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_3_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: staff_responsiveness_star_rating {
    label: "Staff Responsiveness Star Rating"
    type: number
    sql: ROUND(${staff_responsiveness_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: pain_management_star_rating_reference {
    label: "Pain Management Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_4_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: pain_management_star_rating {
    label: "Pain Management Star Rating"
    type: number
    sql: ROUND(${pain_management_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: communication_medicine_star_rating_reference {
    label: "Communication About Medicines Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_5_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: communication_medicine_star_rating {
    label: "Communication About Medicines Star Rating"
    type: number
    sql: ROUND(${communication_medicine_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: discharge_information_star_rating_reference {
    label: "Discharge Information Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_6_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: discharge_information_star_rating {
    label: "Discharge Information Star Rating"
    type: number
    sql: ROUND(${discharge_information_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: care_transition_star_rating_reference {
    label: "Care Transition Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_COMP_7_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: care_transition_star_rating {
    label: "Care Transition Star Rating"
    type: number
    sql: ROUND(${care_transition_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: overall_hospital_star_rating_reference {
    label: "Overall Hospital Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_HSP_RATING_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: overall_hospital_star_rating {
    label: "Overall Hospital Star Rating"
    type: number
    sql: ROUND(${overall_hospital_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: quietness_star_rating_reference {
    label: "Quietness Star Rating"
    hidden:  yes
    type: average
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_QUIET_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: quietness_star_rating {
    label: "Quietness Star Rating"
    type: number
    sql: ROUND(${quietness_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

  measure: recommended_hospital_star_rating_reference {
    label: "Recommended Hospital Star Rating"
    type: average
    hidden: yes
    sql: CASE WHEN ${hcahps_measure_id} IN ('H_RECMND_STAR_RATING') THEN ${TABLE}.PATIENT_SURVEY_STAR_RATING END;;
    value_format: "#,##0;(#,##0)"
  }

  measure: recommended_hospital_star_rating {
    label: "Recommended Hospital Star Rating"
    type: number
    sql: ROUND(${recommended_hospital_star_rating_reference});;
    drill_fields: [hospital_general_information.provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
    value_format: "#,##0;(#,##0)"
  }

#   measure: hcahps_answer_percent {
#     type: sum
#     sql: ${TABLE}.HCAHPS_ANSWER_PERCENT ;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }
#
#   measure: survey_response_rate_percent {
#     type: sum
#     sql: ${TABLE}.SURVEY_RESPONSE_RATE_PERCENT ;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }
#
#   measure: hcahps_linear_mean_value {
#     type: sum
#     sql: ${TABLE}.HCAHPS_LINEAR_MEAN_VALUE ;;
#     value_format: "#,##0.00;(#,##0.00)"
#   }

}

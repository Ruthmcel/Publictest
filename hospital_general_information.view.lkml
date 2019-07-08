view: hospital_general_information {
  sql_table_name: REPORT_TEMP.HOSPITAL_GENERAL_INFORMATION ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id} ;;
  }

  dimension: provider_id {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: effectiveness_of_care_national_comparison {
    type: string
    sql: ${TABLE}.EFFECTIVENESS_OF_CARE_NATIONAL_COMPARISON ;;
  }

  dimension: effectiveness_of_care_national_comparison_footnote {
    type: string
    sql: ${TABLE}.EFFECTIVENESS_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: efficient_use_of_medical_imaging_national_comparison {
    type: string
    sql: ${TABLE}.EFFICIENT_USE_OF_MEDICAL_IMAGING_NATIONAL_COMPARISON ;;
  }

  dimension: efficient_use_of_medical_imaging_national_comparison_footnote {
    type: string
    sql: ${TABLE}.EFFICIENT_USE_OF_MEDICAL_IMAGING_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: emergency_services {
    type: string
    sql: ${TABLE}.EMERGENCY_SERVICES ;;
  }

  dimension: hospital_name {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.HOSPITAL_NAME  ||'-'|| ${TABLE}.PROVIDER_ID ;;
  }

  dimension: hospital_overall_rating_footnote {
    type: string
    sql: ${TABLE}.HOSPITAL_OVERALL_RATING_FOOTNOTE ;;
  }

  dimension: hospital_ownership {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.HOSPITAL_OWNERSHIP ;;
  }

  dimension: hospital_type {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.HOSPITAL_TYPE ;;
  }

  dimension: meets_criteria_for_meaningful_use_of_EHR {
    type: string
    label: "Meets Criteria for Meaningful Use of EHR"
    sql: ${TABLE}.MEETS_CRITERIA_FOR_MEANINGFUL_USE_OF_EHR ;;
  }

  dimension: mortality_national_comparison {
    type: string
    sql: ${TABLE}.MORTALITY_NATIONAL_COMPARISON ;;
  }

  dimension: mortality_national_comparison_footnote {
    type: string
    sql: ${TABLE}.MORTALITY_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: patient_experience_national_comparison {
    type: string
    sql: ${TABLE}.PATIENT_EXPERIENCE_NATIONAL_COMPARISON ;;
  }

  dimension: patient_experience_national_comparison_footnote {
    type: string
    sql: ${TABLE}.PATIENT_EXPERIENCE_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: phone_number {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: readmission_national_comparison {
    type: string
    sql: ${TABLE}.READMISSION_NATIONAL_COMPARISON ;;
  }

  dimension: readmission_national_comparison_footnote {
    type: string
    sql: ${TABLE}.READMISSION_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: safety_of_care_national_comparison {
    type: string
    sql: ${TABLE}.SAFETY_OF_CARE_NATIONAL_COMPARISON ;;
  }

  dimension: safety_of_care_national_comparison_footnote {
    type: string
    sql: ${TABLE}.SAFETY_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: timeliness_of_care_national_comparison {
    type: string
    sql: ${TABLE}.TIMELINESS_OF_CARE_NATIONAL_COMPARISON ;;
  }

  dimension: timeliness_of_care_national_comparison_footnote {
    type: string
    sql: ${TABLE}.TIMELINESS_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE ;;
  }

  dimension: address {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: city {
    type: string
    group_label: "Hospital Demographics"
    sql: ${TABLE}.CITY ;;
  }

  dimension: county_name {
    type: string
    group_label: "Hospital Demographics"
#     map_layer_name: us_counties_fips    # this is your map layer
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: state {
    type: string
    group_label: "Hospital Demographics"
    map_layer_name: us_states
    sql: ${TABLE}.STATE ;;
    link: {
      label: "HIMSS Hospital - State Dashboard"
      url: "/dashboards/370?STATE={{value}}"
    }
  }

  dimension: zip_code {
    type: zipcode
    group_label: "Hospital Demographics"
    sql: ${TABLE}.ZIP_CODE ;;
  }

  measure: total_providers {
    type: count
    label: "Total Hospitals"
    drill_fields: [provider_general_set*]
    link: {label: "Explore Top 20 Results by Provider" url: "{{ link }}&sorts=hospital_name+desc&limit=20" }
  }

  measure: hospital_overall_rating {
    type: sum
    sql: ${TABLE}.HOSPITAL_OVERALL_RATING ;;
  }

  measure: avg_hospital_overall_rating {
    type: average
    sql: ${TABLE}.HOSPITAL_OVERALL_RATING ;;
  }

    set: provider_general_set {
      fields: [
        hospital_name,
        hospital_type,
        emergency_services,
        meets_criteria_for_meaningful_use_of_EHR,
        city,
        zip_code,
        state,
        hcahps_hospital.summary_star_rating
      ]
    }
}

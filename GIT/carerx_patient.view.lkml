view: carerx_patient {
  sql_table_name: MTM_CLINICAL.PATIENT ;;
  ## ======= The following MTM_CLINICAL.PATIENT Database Objects were not exposed in this view ======= ##
  ## EMAIL_TOKEN

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: survivor_patient_id {
    hidden: yes
    label: "Patient Survivor ID"
    description: "The unique database ID of the Care Rx patient record that this patient record has been merged into"
    type: number
    sql: ${TABLE}.SURVIVOR_PATIENT_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: first_name {
    group_label: "Patient's Name"
    label: "Patient First Name"
    description: "Patient First Name"
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: last_name {
    group_label: "Patient's Name"
    label: "Patient Last Name"
    description: "Patient Last Name"
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: middle_name {
    group_label: "Patient's Name"
    label: "Patient Middle Name"
    description: "Patient Middle Name"
    type: string
    sql: ${TABLE}.MIDDLE_NAME ;;
  }

  dimension: mother_maiden_name {
    group_label: "Patient's Name"
    label: "Patient's Mother's Maiden Name"
    description: "Patient's Mother's Maiden Name"
    type: string
    sql: ${TABLE}.MOTHER_MAIDEN_NAME ;;
  }

  dimension: address {
    group_label: "Patient Address"
    label: "Patient Address"
    description: "Patient Address"
    type: string
    sql: ${TABLE}.ADDRESS_LINE1 ;;
  }

  dimension: city {
    group_label: "Patient Address"
    label: "Patient City"
    description: "The City in which the Patient resides"
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: postal_code {
    group_label: "Patient Address"
    label: "Patient Zip Code"
    description: "Patient Zip Code"
    type: string
    sql: CASE WHEN LENGTH(${TABLE}.POSTAL_CODE) > 5 THEN SUBSTR(${TABLE}.POSTAL_CODE, 0, 5) || '-' || SUBSTR(${TABLE}.POSTAL_CODE, 6) ELSE ${TABLE}.POSTAL_CODE END ;;
  }

  dimension: state {
    group_label: "Patient Address"
    label: "Patient State"
    description: "The State in which the Patient resides"
    type: string
    sql: ${TABLE}.STATE ;;
  }

  # Hiding and using concatenated area code and phone number
  dimension: area_code {
    hidden: yes
    label: "Patient Area Code"
    description: "Patient Area Code"
    type: string
    sql: ${TABLE}.AREA_CODE ;;
  }

  # Hiding and using concatenated area code and phone number
  dimension: phone_number {
    hidden: yes
    label: "Patient Phone Number"
    description: "Patient Phone Number"
    type: string
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: phone_number_full {
    group_label: "Patient Contact Info"
    label: "Patient Phone Number"
    description: "Patient Area Code and Phone Number"
    type: string
    sql: ( '(' || ${TABLE}.AREA_CODE || ') ' || SUBSTR(${TABLE}.PHONE_NUMBER, 0, 3) || '-' || SUBSTR(${TABLE}.PHONE_NUMBER, 4) ) ;;
  }

  dimension: phone_type {
    group_label: "Patient Contact Info"
    label: "Patient Contact Phone Type"
    description: "The Patient Contact Phone Type, either HOME, WORK, or CELL)"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PHONE_TYPE = 'H' ;;
        label: "HOME"
      }

      when: {
        sql: ${TABLE}.PHONE_TYPE = 'W' ;;
        label: "WORK"
      }

      when: {
        sql: ${TABLE}.PHONE_TYPE = 'C' ;;
        label: "CELL"
      }
    }
  }

  dimension: email_address {
    group_label: "Patient Contact Info"
    label: "Patient Email Address"
    description: "The Patient's Email Address"
    type: string
    sql: ${TABLE}.EMAIL_ADDRESS ;;
  }

  dimension: patient_gender {
    label: "Patient Gender"
    description: "Patient's Gender"
    type: string

    case: {
      when: {
        sql: ${TABLE}.SEX = 'M' ;;
        label: "MALE"
      }

      when: {
        sql: ${TABLE}.SEX = 'F' ;;
        label: "FEMALE"
      }

      when: {
        sql: NVL(${TABLE}.SEX, 'U') = 'U' ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: ethnicity {
    label: "Patient's Ethnicity"
    description: "The Ethnicity of the Patient"
    type: string
    sql: ${TABLE}.ETHNICITY ;;
  }

  dimension: chicken_pox_flag {
    label: "Patient Has/Had Chicken Pox"
    description: "Flag indicating if the Patient has had Chicken Pox. Yes = The Patient has had Chicken pox at some point in their Medical History. No = The Patient has NOT had Chicken Pox."
    type: yesno
    sql: ${TABLE}.CHICKEN_POX_HISTORY = '1' ;;
  }

  dimension: appointment_email_flag {
    label: "Patient Appointment Email Flag"
    description: "Flag that Indicates if the patient wants to be emailed notifications about their appointments. Yes = The patient wants to receive email notifications. No = The Patient does not want to receive email notifications."
    type: yesno
    sql: ${TABLE}.APPOINTMENT_EMAIL_FLAG = '1' ;;
  }

  dimension: interview_email_flag {
    label: "Patient Survery/Interview Email Flag"
    description: "Flag that Indicates if the patient wants to be emailed notifications about their Interviews and Surveys. Yes = The patient wants to receive email notifications. No = The Patient does not want to receive email notifications."
    type: yesno
    sql: ${TABLE}.INTERVIEW_EMAIL_FLAG = '1' ;;
  }

  dimension: mtm_opt_out_flag {
    label: "Patient Survery/Interview Email Flag"
    description: "Flag that indicates if the patient has opted out of notification for available clinical opportunities. Yes = The patient has opted out of notifications. No = The patient has NOT opted out of notifications."
    type: yesno
    sql: ${TABLE}.MTM_OPT_OUT = '1' ;;
  }

  dimension: imm_shared_flag {
    label: "Patient Immunization Flag"
    description: "Flag that indicates if the patient's immunization data can be shared to other providers. Yes = The Patient's immunization data can be shared to other providers. No = The Patient's immunization data can NOT be shared."
    type: yesno
    sql: NVL(${TABLE}.IMM_SHARED_FLAG, '0') = '0' ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: patient_birth {
    label: "Patient DOB"
    description: "Patient's Date Of Birth"
    type: time
    timeframes: [
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
    sql: ${TABLE}.BIRTH_DATE ;;
  }

  dimension_group: chicken_pox {
    label: "Chicken Pox"
    description: "The date reported by the patient, that they last had Chicken Pox"
    type: time
    timeframes: [
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
    sql: ${TABLE}.CHICKEN_POX_DATE ;;
  }

  dimension_group: imm_shared {
    label: "Immunization Shared"
    description: "The date that the Patient declined to share their immunization data with other providers"
    type: time
    timeframes: [
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
    sql: ${TABLE}.IMM_SHARED_DATE ;;
  }

  dimension_group: patient_deceased {
    label: "Patient Deceased"
    description: "The date that the Patient became deceased"
    type: time
    timeframes: [
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
    sql: ${TABLE}.DECEASED_DATE ;;
  }

  dimension_group: patient_deactivate {
    label: "Patient Deactivated"
    description: "The date that the Patient was deactivated"
    type: time
    timeframes: [
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

  ################################################################################################## Measures #################################################################################################

  measure: patient_count {
    label: "Patient Count"
    description: "Count of Patients"
    type: count
    drill_fields: [patient_demographics*]
  }

  ################################################################################################## SETS #################################################################################################

  set: patient_demographics {
    fields: [
      first_name,
      last_name,
      address,
      city,
      state,
      postal_code,
      phone_number_full,
      patient_deceased_date,
      patient_deactivate_date
    ]
  }
}

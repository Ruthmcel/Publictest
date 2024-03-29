view: carerx_patient_program_link {
  sql_table_name: MTM_CLINICAL.PATIENT_PROGRAM_LINK ;;
  ## Granularity of this table is Patient and Active Program. There is a Unique Key on (ORIGINAL_PATIENT_ID, PROGRAM_ID, PROGRAM_DEACTIVATE_DATE) in the database

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: program_id {
    hidden: yes
    label: "Program ID"
    description: "The unique database ID of the program that the Care Rx patient is linked to"
    type: number
    sql: ${TABLE}.PROGRAM_ID ;;
  }

  dimension: original_patient_id {
    hidden: yes
    label: "Patient Original ID"
    description: "The unique database ID of the patient that the Third Party coverage is linked to"
    type: number
    sql: ${TABLE}.ORIGINAL_PATIENT_ID ;;
  }

  dimension: program_deactivate_reason_id {
    hidden: yes
    label: "Program Deactivate Reason ID"
    description: "The unique database ID of the deactivation reason that the patient program link is linked to"
    type: number
    sql: ${TABLE}.PROGRAM_DEACTIVATE_REASON_ID ;;
  }

  dimension: session_call_outcome_id {
    hidden: yes
    label: "Session Call Outcome ID"
    description: "The unique database ID of the outcome from the call to the patient regarding the session"
    type: number
    sql: ${TABLE}.SESSION_CALL_OUTCOME_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: next_due_override {
    label: "Patient Program Override Status"
    description: "The override status for the next time that a program is due to be completed by the patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.NEXT_DUE_OVERRIDE = 'I' ;;
        label: "IMMEDIATELY DUE"
      }

      when: {
        sql: ${TABLE}.NEXT_DUE_OVERRIDE = 'F' ;;
        label: "COMPLETED"
      }

      when: {
        sql: ${TABLE}.NEXT_DUE_OVERRIDE IS NULL ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: opportunity_identifier {
    ## -- This is used with the CareRx Application, and may not need to be exposed.
    hidden: yes
    label: "CareRx Application Opportunity ID"
    description: "The unique identification number generated by Care Rx and sent to the MTM application that identifies the opportunity for the patient to participate in the program"
    type: number
    sql: ${TABLE}.OPPORTUNITY_IDENTIFIER ;;
  }

  dimension: patient_opportunity_status {
    label: "Patient Program Opportunity Status"
    description: "The status of the opportunity that was sent to the MTM application "
    type: string

    case: {
      when: {
        sql: ${TABLE}.OPPORTUNITY_STATUS = 'S' ;;
        label: "SENT"
      }

      when: {
        sql: ${TABLE}.OPPORTUNITY_STATUS = 'C' ;;
        label: "COMPLETED"
      }

      when: {
        sql: ${TABLE}.OPPORTUNITY_STATUS = 'D' ;;
        label: "DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.OPPORTUNITY_STATUS = 'I' ;;
        label: "INACTIVE"
      }

      when: {
        sql: ${TABLE}.OPPORTUNITY_STATUS IS NULL ;;
        label: "UNKNOWN"
      }
    }
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: patient_program_next_due {
    label: "Patient Program Next Due"
    description: "The next scheduled date that the program is due to be completed by the patient"
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
    sql: ${TABLE}.NEXT_DUE_DATE ;;
  }

  dimension_group: patient_program_deactivate {
    label: "Patient Program Deactivated"
    description: "The date/time that the patient was deactivated (no longer able to participate) from the program"
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
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PROGRAM_DEACTIVATE_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: patient_program_count {
    label: "Patient Program Count"
    description: "A count of Patient Program opportunities"
    type: count
    drill_fields: [patient_program_session_detail*]
  }

  ################################################################################################## SETS #################################################################################################

  set: patient_program_session_detail {
    fields: [

      ## -- Need to add patient demographic information here
      carerx_program.program_name,
      carerx_program.program_category_type,
      carerx_program.session_estimated_duration,
      next_due_override,
      patient_opportunity_status,
      patient_program_next_due_date,
      patient_program_deactivate_time
    ]
  }
}

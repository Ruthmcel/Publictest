view: carerx_mtm_session {
  sql_table_name: MTM_CLINICAL.MTM_SESSION ;;
  ## Granularity of this table is a Session. There can be Many Session Records in this table for One Patient, Program record in the PATIENT_PROGRAM_LINK table. A record must exist in the PATIENT_PROGRAM_LINK table for a Session row to exist (FK)

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: mtm_session_source_id {
    hidden: yes
    label: "MTM Session Source ID"
    description: "FK to MTM_SESSION_SOURCE table"
    type: number
    sql: ${TABLE}.MTM_SESSION_SOURCE_ID ;;
  }

  dimension: patient_program_link_id {
    hidden: yes
    label: "Patient Program Link ID"
    description: "FK to PATIENT_PROGRAM_LINK table"
    type: number
    sql: ${TABLE}.PATIENT_PROGRAM_LINK_ID ;;
  }

  dimension: completed_user_profile_id {
    hidden: yes
    label: "Completed User Profile ID"
    description: "FK to COMPLETED_USER_PROFILE_ID table"
    type: number
    sql: ${TABLE}.COMPLETED_USER_PROFILE_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: session_status {
    label: "Session Status"
    description: "The Status of the Session"
    type: string

    case: {
      when: {
        sql: ${TABLE}.STATUS = 'A' ;;
        label: "ACTIVE"
      }

      when: {
        sql: ${TABLE}.STATUS = 'C' ;;
        label: "COMPLETED"
      }

      when: {
        sql: ${TABLE}.STATUS = 'B' ;;
        label: "BILLING"
      }

      when: {
        sql: ${TABLE}.STATUS IS NULL ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: billing_status {
    label: "Session Billing Status"
    description: "The status of the billing information that was transmitted to the billing application for the session"
    type: string
    sql: ${TABLE}.BILLING_STATUS ;;
  }

  dimension: completed_by_user {
    label: "Session Completed by UserName"
    description: "The username of the user that completed the session"
    type: string
    sql: ${TABLE}.COMPLETED_BY_USER ;;
  }

  dimension: completed_store_name {
    label: "Pharmacy Name Session Completion Location"
    description: "The name of the store that was selected as the physical location by the user that completed the session"
    type: string
    sql: ${TABLE}.COMPLETED_STORE_NAME ;;
  }

  dimension: completed_store_nhinid {
    label: "Pharmacy NHIN ID Session Completion Location"
    description: "The Pharmacy NHIN ID of the store the user was located at when they completed the session"
    type: number
    sql: ${TABLE}.COMPLETED_STORE_NHINID ;;
  }

  dimension: completed_store_npi {
    label: "Pharmacy NPI Session Completion Location"
    description: "The Pharmacy NPI of the store the user was located at when they completed the session"
    type: string
    sql: ${TABLE}.COMPLETED_STORE_NPI ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: session_billing {
    label: "Session Billing"
    description: "The date/time that the billing for the session was transmitted to the billing application"
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
    sql: ${TABLE}.BILLING_DATE ;;
  }

  dimension_group: session_complete {
    label: "Session Completed"
    description: "The date that the session was completed"
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
    sql: ${TABLE}.COMPLETE_DATE ;;
  }

  dimension_group: session_created {
    label: "Session Created"
    description: "The date that the session was issued (created)"
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
    sql: ${TABLE}.ISSUED_DATE ;;
  }

  dimension_group: last_start {
    label: "Session Last Start"
    description: "The latest date/time that the session was started with a patient"
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
    sql: ${TABLE}.LAST_START_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: session_count {
    label: "Session Count"
    description: "A count of Sessions"
    type: count
    drill_fields: [session_count_detail*]
  }

  ################################################################################################## SETS #################################################################################################

  set: session_count_detail {
    fields: [
      session_status,
      billing_status,

      ## Patient Information Here would probably be good
      completed_store_name,
      completed_store_nhinid,
      session_created_time,
      last_start_time,
      session_complete_time
    ]
  }
}

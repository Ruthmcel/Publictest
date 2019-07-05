view: carerx_clinical_session_patient_interview {

# PDT enabled from a performance standpoint so the dataset is materialized. Once this moves downstream to EDW, this can be a direct forklift.
  derived_table: {
    sql:  select *
            from
            EDW.V_CUSTOM_CLINICAL_SESSION_PATIENT_INTERVIEW
            order by CHAIN_ID;;
    sql_trigger_value: select max(max_event_end_date) from
                                                            (
                                                            select max(event_end_date) as max_event_end_date from etl_manager.event
                                                            where event_type in ('SURVEY GIZMO EDW LOAD')
                                                            and status = 'S'

                                                              union all

                                                            select  max(event_end_date) as max_event_end_date from etl_manager.event
                                                            where event_id in ( select max(event_id) from etl_manager.event_job where job_name like '%MTM%')
                                                            ) ;;
  }

  dimension: assessment_note_id {
    label: "Assessment Note ID"
    description: "The unique database ID of the note containing the assessment SOAP information entered by the clinician as part of the session panel"
    type: string
    sql: ${TABLE}."ASSESSMENT_NOTE_ID" ;;
  }

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    type: number
    description: "Unique number assigned to PDX Inc. Accounting to identify a Chain or a Store"
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension_group: clinical_patient_epr_link_source {
    label: "Clinical Patient EPR Link Source"
    description: "Date/Time when a Clinical Patient EPR Link was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CLINICAL_PATIENT_EPR_LINK_SOURCE_TIMESTAMP" ;;
  }

  dimension_group: clinical_patient_link_source {
    label: "Clinical Patient Link Source"
    description: "Date/Time when a Clinical Patient Link was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CLINICAL_PATIENT_LINK_SOURCE_TIMESTAMP" ;;
  }

  dimension_group: clinical_patient_program_source {
    label: "Clinical Patient Program Source"
    description: "Date/Time when a Clinical Patient Program was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CLINICAL_PATIENT_PROGRAM_SOURCE_TIMESTAMP" ;;
  }

  dimension_group: clinical_patient_source {
    label: "Clinical Patient Source"
    description: "Date/Time when a Clinical Patient was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CLINICAL_PATIENT_SOURCE_TIMESTAMP" ;;
  }

  dimension_group: clinical_program_source {
    label: "Clinical Program Source"
    description: "Date/Time when a Clinical Program was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CLINICAL_PROGRAM_SOURCE_TIMESTAMP" ;;
  }

  dimension: current_patient_id {
    label: "Current Patient ID"
    description: "The unique database ID of the most current record for a patient"
    type: number
    sql: ${TABLE}."CURRENT_PATIENT_ID" ;;
  }


  dimension: interview_configuration_has_quiz_score_flag {
    description: "YES/NO Flag Indicating if a quiz score action is present on the interview and needs to be retrieved"
    type: string
    sql: etl_manager.fn_get_master_code_desc('INTERVIEW_CONFIGURATION_HAS_QUIZ_SCORE_FLAG', ${TABLE}.INTERVIEW_CONFIGURATION_HAS_QUIZ_SCORE_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: interview_configuration_id {
    label: "Interview Configuration ID"
    description: "The unique database ID that identifies the interview configuration record"
    type: number
    sql: ${TABLE}."INTERVIEW_CONFIGURATION_ID" ;;
  }

  dimension: interview_configuration_interview_identifier {
    description: "The unique identification number assigned to the interview by the survey-generation software"
    group_label: "Interview Configuration"
    type: string
    sql: ${TABLE}."INTERVIEW_CONFIGURATION_INTERVIEW_IDENTIFIER" ;;
  }

  dimension: interview_configuration_interview_link {
    description: "The URL used to access the interview in the survey generation software"
    group_label: "Interview Configuration"
    type: string
    sql: ${TABLE}."INTERVIEW_CONFIGURATION_INTERVIEW_LINK" ;;
  }

  dimension: interview_configuration_interview_name {
    description: "The name of the interview"
    group_label: "Interview Configuration"
    type: string
    sql: ${TABLE}."INTERVIEW_CONFIGURATION_INTERVIEW_NAME" ;;
  }

  dimension: interview_configuration_share_data_flag {
    description: "YES/NO Flag indicating when interview data is shared across chains"
    group_label: "Interview Configuration"
    type: string
    sql: etl_manager.fn_get_master_code_desc('INTERVIEW_CONFIGURATION_SHARE_DATA_FLAG', ${TABLE}.INTERVIEW_CONFIGURATION_SHARE_DATA_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension_group: interview_configuration_source {
    label: "Interview Configuration Source"
    description: "Date/Time when an Interview Configuration source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."INTERVIEW_CONFIGURATION_SOURCE_TIMESTAMP" ;;
  }

  dimension_group: interview_response_data_complete {
    label: "Interview Response Data Complete"
    description: "Date/Time when the interview or survey was completed by the patient"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."INTERVIEW_RESPONSE_DATA_COMPLETE_DATE" ;;
  }

  dimension: interview_response_data_id {
    label: "Interview Response Data ID"
    group_label: "Interview Response"
    description: "The unique database ID that identifies the interview response data record"
    type: number
    sql: ${TABLE}."INTERVIEW_RESPONSE_DATA_ID" ;;
  }

  dimension: interview_response_data_identifier {
    group_label: "Interview Response"
    description: "The unique identification number assigned to the specific interview response. System generated by Care Rx (SGUID) when the interview/survey is presented to the patient"
    type: string
    sql: ${TABLE}."INTERVIEW_RESPONSE_DATA_IDENTIFIER" ;;
  }

  dimension: interview_response_data_quiz_score {
    group_label: "Interview Response"
    description: "The unique database ID that identifies the interview response data record"
    type: string
    sql: ${TABLE}."INTERVIEW_RESPONSE_DATA_QUIZ_SCORE" ;;
  }

  dimension_group: interview_response_data_source {
    label: "Interview Response Data Source"
    description: "Date/Time when the interview response source data was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."INTERVIEW_RESPONSE_DATA_SOURCE_TIMESTAMP" ;;
  }

  dimension: interview_response_session_information {
    group_label: "Interview Response"
    description: "Interview Response Session Information"
    type: string
    sql: ${TABLE}."INTERVIEW_RESPONSE_SESSION_INFORMATION" ;;
  }

  dimension: lab_test_result_set_id {
    label: "Lab Test Result Set ID"
    group_label: "Session"
    description: "Unique database ID of the immunization administration record that was entered by the clinician as part of the session panel"
    type: number
    sql: ${TABLE}."LAB_TEST_RESULT_SET_ID" ;;
  }

  dimension_group: mtm_session_billing {
    label: "MTM Session Billing"
    description: "Date/Time when the billing for the session was transmitted to the billing application"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_BILLING_DATE" ;;
  }

  dimension: mtm_session_billing_status {
    label: "MTM Session Billing Status"
    group_label: "Session"
    description: "The status of the billing information that was transmitted to the billing application for the session"
    type: string
    sql: etl_manager.fn_get_master_code_desc('MTM_SESSION_BILLING_STATUS', ${TABLE}.MTM_SESSION_BILLING_STATUS,'Y') ;;
    suggestions: ["P - PENDING", "S - SENT"]
    suggest_persist_for: "24 hours"
  }


  dimension_group: mtm_session_complete {
    label: "MTM Session Complete"
    description: "Date/Time when the session was completed"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_COMPLETE_DATE" ;;
  }

  dimension: mtm_session_completed_by_user {
    label: "MTM Session Completed By User"
    group_label: "Session"
    description: "The username of the user that completed the session"
    type: string
    sql: ${TABLE}."MTM_SESSION_COMPLETED_BY_USER" ;;
  }

  dimension: mtm_session_completed_nhin_store_id {
    label: "MTM Session Completed NHIN STORE ID"
    group_label: "Session"
    description: "The NHIN (National Health Information Network) ID number of the store the user was located at when they completed the session"
    type: number
    sql: ${TABLE}."MTM_SESSION_COMPLETED_NHIN_STORE_ID" ;;
  }

  dimension: mtm_session_completed_store_name {
    label: "MTM Session Completed Store Name"
    group_label: "Session"
    description: "The name of the store that was selected as the physical location for the user that completed the session"
    type: string
    sql: ${TABLE}."MTM_SESSION_COMPLETED_STORE_NAME" ;;
  }

  dimension: mtm_session_completed_store_npi {
    label: "MTM Session Completed Store NPI"
    group_label: "Session"
    description: "The NPI (National Provider Identifier) of the store that was selected as the physical location for the user that completed the session"
    type: string
    sql: ${TABLE}."MTM_SESSION_COMPLETED_STORE_NPI" ;;
  }

  dimension: mtm_session_completed_user_profile_id {
    label: "MTM Session Completed User Profile ID"
    group_label: "Session"
    description: "The unique database ID that is linked to the user profile of the user that completed the session"
    type: string
    sql: ${TABLE}."MTM_SESSION_COMPLETED_USER_PROFILE_ID" ;;
  }

  dimension: mtm_session_group_id {
    label: "MTM Session Group ID"
    group_label: "Session"
    description: "The unique database ID that identifies the session group record"
    type: number
    sql: ${TABLE}."MTM_SESSION_GROUP_ID" ;;
  }

  dimension: mtm_session_group_sequence_number {
    label: "MTM Session Group Sequence Number"
    group_label: "Session"
    description: "The sequence within the session that the group is displayed"
    type: number
    sql: ${TABLE}."MTM_SESSION_GROUP_SEQUENCE_NUMBER" ;;
  }

  dimension_group: mtm_session_group_source {
    label: "MTM Session Group Source"
    description: "Date/Time when the Session Group Source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_GROUP_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_group_status {
    label: "MTM Session Group Status"
    group_label: "Session"
    description: "The status of the session group"
    type: string
    sql: ${TABLE}."MTM_SESSION_GROUP_STATUS" ;;
  }

  dimension: mtm_session_id {
    label: "MTM Session ID"
    group_label: "Session"
    description: "The unique database ID of the sesssion that the session group is assigned to"
    type: number
    sql: ${TABLE}."MTM_SESSION_ID" ;;
  }

  dimension_group: mtm_session_issued {
    label: "MTM Session Issued"
    description: "Date/Time when the Session Group Source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_ISSUED_DATE" ;;
  }

  dimension_group: mtm_session_last_start {
    label: "MTM Session Last Start"
    description: "Date/Time when the session was started with a patient"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_LAST_START_DATE" ;;
  }

  dimension: mtm_session_note {
    label: "MTM Session Note"
    group_label: "Session"
    description: "The contents of the session note"
    type: string
    sql: ${TABLE}."MTM_SESSION_NOTE" ;;
  }

  dimension_group: mtm_session_note_create {
    label: "MTM Session Note Create"
    description: "Date/Time when the note was initially created"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_NOTE_CREATE_DATE" ;;
  }

  dimension: mtm_session_note_id {
    label: "MTM Session Note ID"
    group_label: "Session"
    description: "The unique database ID that identifies the session note record"
    type: number
    sql: ${TABLE}."MTM_SESSION_NOTE_ID" ;;
  }

  dimension_group: mtm_session_note_source {
    label: "MTM Session Note Source"
    description: "Date/Time when the Session Note Source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_NOTE_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_note_suppress_flag {
    label: "MTM Session Note Suppress Flag"
    group_label: "Session"
    description: "YES/NO flag Indicating if the note should be suppressed (hidden by default) in the user interface"
    type: string
    sql: etl_manager.fn_get_master_code_desc('MTM_SESSION_NOTE_SUPPRESS_FLAG', ${TABLE}.MTM_SESSION_NOTE_SUPPRESS_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension_group: mtm_session_panel_complete {
    label: "MTM Session Panel Complete"
    description: "Date/Time when the Session panel was completed"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_PANEL_COMPLETE_DATE" ;;
  }

  dimension: mtm_session_panel_id {
    label: "MTM Session Panel ID"
    group_label: "Session"
    description: "The unique database ID that identifies the session panel record"
    type: number
    sql: ${TABLE}."MTM_SESSION_PANEL_ID" ;;
  }

  dimension: mtm_session_panel_rx_tx_id {
    label: "MTM Session Panel Prescription Transaction ID"
    group_label: "Session"
    description: "The unique database ID that is used to identify the RxTx record which is associated with the session panel"
    type: number
    sql: ${TABLE}."MTM_SESSION_PANEL_RX_TX_ID" ;;
  }

  dimension_group: mtm_session_panel_rx_tx_source {
    label: "MTM Session Panel Prescription Transaction Source"
    description: "Date/Time when the Session panel Prescription Transaction source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_PANEL_RX_TX_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_panel_rx_tx_tx_number {
    label: "MTM Session Panel Prescription Transaction Number"
    group_label: "Session"
    description: "Prescription transaction number associated with the session panel"
    type: string
    sql: ${TABLE}."MTM_SESSION_PANEL_RX_TX_TX_NUMBER" ;;
  }

  dimension: mtm_session_panel_sequence_number {
    label: "MTM Session Panel Sequence Number"
    group_label: "Session"
    description: "The sequence within the session group that the panel is displayed"
    type: number
    sql: ${TABLE}."MTM_SESSION_PANEL_SEQUENCE_NUMBER" ;;
  }

  dimension: mtm_session_panel_service_registration_email {
    label: "MTM Session Panel Service Registration Email"
    group_label: "Session"
    description: "The email address that was used to register the patient with an external service as part of a service registration session panel"
    type: string
    sql: ${TABLE}."MTM_SESSION_PANEL_SERVICE_REGISTRATION_EMAIL" ;;
  }

  dimension_group: mtm_session_panel_source {
    label: "MTM Session Panel Source"
    description: "Date/Time when the Session panel source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_PANEL_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_panel_status {
    label: "MTM Session Panel Status"
    group_label: "Session"
    description: "The status of the session panel"
    type: string
    sql: ${TABLE}."MTM_SESSION_PANEL_STATUS" ;;
  }

  dimension: mtm_session_panel_type {
    label: "MTM Session Panel Tyoe"
    group_label: "Session"
    description: "The type or category of the session panel"
    type: string
    sql: ${TABLE}."MTM_SESSION_PANEL_TYPE" ;;
  }

  dimension_group: mtm_session_prompt_interview_complete {
    label: "MTM Session Prompt Interview Complete"
    description: "Date/Time when the interview was completed"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_PROMPT_INTERVIEW_COMPLETE_DATE" ;;
  }

  dimension: mtm_session_prompt_interview_id {
    label: "MTM Session Prompt Interview ID"
    group_label: "Session"
    description: "The unique database ID that identifies the session prompt interview record"
    type: number
    sql: ${TABLE}."MTM_SESSION_PROMPT_INTERVIEW_ID" ;;
  }

  dimension: mtm_session_prompt_interview_medication_gpi {
    label: "MTM Session Prompt Interview Medication GPI"
    group_label: "Session"
    description: "The Generic Product Identifier of the medication that the interview was for"
    type: string
    sql: ${TABLE}."MTM_SESSION_PROMPT_INTERVIEW_MEDICATION_GPI" ;;
  }

  dimension: mtm_session_prompt_interview_medication_name {
    label: "MTM Session Prompt Interview Medication Name"
    group_label: "Session"
    description: "The name of the medication that the interview was for"
    type: string
    sql: ${TABLE}."MTM_SESSION_PROMPT_INTERVIEW_MEDICATION_NAME" ;;
  }

  dimension_group: mtm_session_prompt_interview_source {
    label: "MTM Session Prompt Interview Source"
    description: "Date/Time when the Session Prompt Interview Source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_PROMPT_INTERVIEW_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_source_id {
    label: "MTM Session Source ID"
    group_label: "Session"
    description: "Session Source ID"
    type: number
    sql: ${TABLE}."MTM_SESSION_SOURCE_ID" ;;
  }

  dimension_group: mtm_session_source {
    label: "MTM Session Source"
    description: "Date/Time when the Session source was updated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MTM_SESSION_SOURCE_TIMESTAMP" ;;
  }

  dimension: mtm_session_status {
    label: "MTM Session Status"
    group_label: "Session"
    description: "The status of the session"
    type: string
    sql: etl_manager.fn_get_master_code_desc('MTM_SESSION_STATUS', ${TABLE}.MTM_SESSION_STATUS,'Y') ;;
    suggestions: ["A - ACTIVE", "B - BILLABLE","C - COMPLETED"]
    suggest_persist_for: "24 hours"
  }

  dimension: nhin_store_id {
    label: "NHIN STORE ID"
    group_label: "Session"
    description: "NHIN Store ID from the Session Panel"
    type: number
    sql: ${TABLE}."NHIN_STORE_ID" ;;
  }

  dimension: objective_note_id {
    label: "Objective Note ID"
    group_label: "Session"
    description: "The unique database ID of the note containing the objective SOAP information entered by the clinician as part of the session panel"
    type: number
    sql: ${TABLE}."OBJECTIVE_NOTE_ID" ;;
  }

  dimension: original_patient_id {
    label: "Original Patient ID"
    group_label: "Clinical Patient"
    description: "The unique database ID of the Care Rx patient that the program is linked to"
    type: number
    sql: ${TABLE}."ORIGINAL_PATIENT_ID" ;;
  }

  dimension: patient_address_line1 {
    group_label: "Clinical Patient"
    description: "The physical address (not including City, State, or Zip Code) of the patient"
    type: string
    sql: ${TABLE}."PATIENT_ADDRESS_LINE1" ;;
  }

  dimension: patient_appointment_email_flag {
    group_label: "Clinical Patient"
    description: "YES/NO Flag Indicating if the patient wants to be emailed notifications about their appointments"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_APPOINTMENT_EMAIL_FLAG', ${TABLE}.PATIENT_APPOINTMENT_EMAIL_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_area_code {
    group_label: "Clinical Patient"
    description: "The area code of the patient's phone number"
    type: string
    sql: ${TABLE}."PATIENT_AREA_CODE" ;;
  }

  dimension_group: patient_birth {
    description: "Birth of the patient"
    type: time
    timeframes: [
      raw,
#       time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_BIRTH_DATE" ;;
  }

  dimension_group: patient_chicken_pox {
    description: "Date/Time reported by the patient that they last had Chicken Pox"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_CHICKEN_POX_DATE" ;;
  }

  dimension: patient_chicken_pox_history_flag {
    group_label: "Clinical Patient"
    description: "YES/NO Flag indicating if the patient has had Chicken Pox"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_CHICKEN_POX_HISTORY_FLAG', ${TABLE}.PATIENT_CHICKEN_POX_HISTORY_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_city {
    group_label: "Clinical Patient"
    description: "The name of the city for the patient's physical address"
    type: string
    sql: ${TABLE}."PATIENT_CITY" ;;
  }

  dimension_group: patient_deactivate {
    description: "Date/Time when the patient was deactivated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_DEACTIVATE_DATE" ;;
  }

  dimension_group: patient_deceased {
    description: "Date/Time when the patient became deceased"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_DECEASED_DATE" ;;
  }

  dimension: patient_email_address {
    group_label: "Clinical Patient"
    description: "The patient's primary email address that is used by Care Rx"
    type: string
    sql: ${TABLE}."PATIENT_EMAIL_ADDRESS" ;;
  }

  dimension: patient_email_token {
    group_label: "Clinical Patient"
    description: "The token sent in emails to the patient that can be used later to identify them if they wish to unsubscribe from the messages"
    type: string
    sql: ${TABLE}."PATIENT_EMAIL_TOKEN" ;;
  }

  dimension: patient_epr_link_deleted {
    group_label: "Clinical Patient"
    label: "Patient EPR Link Deleted"
    description: "YES/NO Flag indicating if the record has been deleted in the source table."
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_EPR_LINK_DELETED', ${TABLE}.PATIENT_EPR_LINK_DELETED,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_epr_link_id {
    label: "Patients EPR Link ID"
    group_label: "Clinical Patient"
    description: "The unique database ID that identifies the patient EPR link record"
    type: string
    sql: ${TABLE}."PATIENT_EPR_LINK_ID" ;;
  }

  dimension: patient_epr_link_primary_flag {
    label: "Patient EPR Link Primary Flag"
    group_label: "Clinical Patient"
    description: "YES/NO Flag indicating the RX_COM_ID to use for the patient/chain when communicating with the EPR application"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_EPR_LINK_PRIMARY_FLAG', ${TABLE}.PATIENT_EPR_LINK_PRIMARY_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_ethnicity {
    group_label: "Clinical Patient"
    description: "Ethnicity of the Patient"
    type: string
    sql: ${TABLE}."PATIENT_ETHNICITY" ;;
  }

  dimension: patient_first_name {
    group_label: "Clinical Patient"
    description: "The first name of the patient"
    type: string
    sql: ${TABLE}."PATIENT_FIRST_NAME" ;;
  }

  dimension: patient_id {
    label: "Patient ID"
    group_label: "Clinical Patient"
    description: "The unique database ID that identifies the patient record"
    type: number
    sql: ${TABLE}."PATIENT_ID" ;;
  }

  dimension_group: patient_imm_shared {
    label: "Patient Immunization Shared"
    description: "Date/Time when the patient declined to share their immunization data with other providers"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_IMM_SHARED_DATE" ;;
  }

  dimension: patient_imm_shared_flag {
    label: "Patient Immunization Shared Flag"
    group_label: "Clinical Patient"
    description: "YES/NO Flag indicating if the patient's immunization data can be shared to other providers"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_IMM_SHARED_FLAG', ${TABLE}.PATIENT_IMM_SHARED_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_interview_email_flag {
    group_label: "Clinical Patient"
    description: "YES/NO Flag indicating if patient wants to receive email ntofiications for their appointments"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_INTERVIEW_EMAIL_FLAG', ${TABLE}.PATIENT_INTERVIEW_EMAIL_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
  }

  dimension: patient_last_name {
    group_label: "Clinical Patient"
    description: "The last name of the patient"
    type: string
    sql: ${TABLE}."PATIENT_LAST_NAME" ;;
  }

  dimension: patient_middle_name {
    group_label: "Clinical Patient"
    description: "The middle name of the patient"
    type: string
    sql: ${TABLE}."PATIENT_MIDDLE_NAME" ;;
  }

  dimension: patient_mother_maiden_name {
    group_label: "Clinical Patient"
    description: "Patient's Mother's Maiden Name"
    type: string
    sql: ${TABLE}."PATIENT_MOTHER_MAIDEN_NAME" ;;
  }

  dimension: patient_mtm_opt_out_flag {
    label: "Patient MTM Opt Out Flag"
    group_label: "Clinical Patient"
    description: "YES/NO Flag indicating if the patient is setup to receive MTM services"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_MTM_OPT_OUT_FLAG', ${TABLE}.PATIENT_MTM_OPT_OUT_FLAG,'Y') ;;
    suggestions: ["Y - YES", "N - NO"]
  }

  dimension: patient_phone_number {
    group_label: "Clinical Patient"
    description: "phone number of the patient"
    type: string
    sql: ${TABLE}."PATIENT_PHONE_NUMBER" ;;
  }

  dimension: phone_number_full {
    group_label: "Clinical Patient"
    label: "Patient Full Phone Number"
    description: "Patient Area Code and Phone Number"
    type: string
    sql: ( '(' || ${patient_area_code} || ') ' || SUBSTR(${patient_phone_number}, 0, 3) || '-' || SUBSTR(${patient_phone_number}, 4) ) ;;
  }

  dimension: patient_phone_type {
    group_label: "Clinical Patient"
    description: "The type or category of the patient's phone number"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_PHONE_TYPE', ${TABLE}.PATIENT_PHONE_TYPE,'Y') ;;
    suggestions: ["C - CELL", "H - HOME","W - WORK"]
    suggest_persist_for: "24 hours"
  }

  dimension: patient_postal_code {
    group_label: "Clinical Patient"
    description: "The postal or zip code for the patient's physical address"
    type: zipcode
    sql: ${TABLE}."PATIENT_POSTAL_CODE" ;;
  }

  dimension_group: patient_program_link_create {
    description: "Date/Time when the patient was originally linked to the program"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_CREATE_DATE" ;;
  }

  dimension: patient_program_link_deactivate_reason_id {
    label: "Patient Program Link Deactivate Reason ID"
    group_label: "Clinical Patient"
    description: "The unique database ID of the deactivation reason that the patient program link is linked to"
    type: number
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_DEACTIVATE_REASON_ID" ;;
  }

  dimension_group: patient_program_link_expire {
    description: "Date/Time when the program expires for the patient"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_EXPIRE_DATE" ;;
  }

  dimension: patient_program_link_id {
    label: "Patient Program Link ID"
    description: "Unique database ID that identifies the patient program link record"
    type: number
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_ID" ;;
  }

  dimension_group: patient_program_link_last_user_update {
    description: "Date/Time when the user last updated the patient program link"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_LAST_USER_UPDATE" ;;
  }

  dimension_group: patient_program_link_next_due {
    description: "Date/Time when next scheduled date that the program is due to be completed by the patient"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_NEXT_DUE_DATE" ;;
  }

  dimension: patient_program_link_next_due_override {
    group_label: "Clinical Patient"
    description: "The override status for the next time that a program is due to be completed by the patient"
    type: string
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_NEXT_DUE_OVERRIDE" ;;
  }

  dimension: patient_program_link_opportunity_identifier {
    group_label: "Clinical Patient"
    description: "The unique identification number generated by Care Rx and sent to the MTM application that identifies the opportunity for the patient to participate in the program "
    type: string
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_OPPORTUNITY_IDENTIFIER" ;;
  }

  dimension: patient_program_link_opportunity_nhin_store_id {
    label: "Patient Program Link Opportunity NHIN STORE ID"
    group_label: "Clinical Patient"
    description: "The NHIN ID number of the store that the opportunity is targeted to be delivered to"
    type: number
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_OPPORTUNITY_NHIN_STORE_ID" ;;
  }

  dimension: patient_program_link_opportunity_status {
    group_label: "Clinical Patient"
    description: "The status of the opportunity that was sent to the MTM application "
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_PROGRAM_LINK_OPPORTUNITY_STATUS', ${TABLE}.PATIENT_PROGRAM_LINK_OPPORTUNITY_STATUS,'Y') ;;
    suggestions: ["S - SENT","C - COMPLETED","D - DEACTIVATED","I - INACTIVE"]
    suggest_persist_for: "24 hours"
  }

  dimension_group: patient_program_link_program_deactivate {
    description: "Date/Time that the patient was deactivated (no longer able to participate) from the program"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_PROGRAM_DEACTIVATE_DATE" ;;
  }

  dimension: patient_program_link_user_profile_id {
    label: "Patient Program Link User Profile ID"
    group_label: "Clinical Patient"
    description: "The unique database ID of the user that is assigned to the patient-program link"
    type: number
    sql: ${TABLE}."PATIENT_PROGRAM_LINK_USER_PROFILE_ID" ;;
  }

  dimension: patient_sex {
    group_label: "Clinical Patient"
    description: "The gender of the patient"
    type: string
    sql: ${TABLE}."PATIENT_SEX" ;;
  }

  dimension: patient_src_postal_code {
    hidden: yes # internal only and discussed with Jeremy as we have a POSTAL_CODE field too
    group_label: "Clinical Patient"
    description: "The postal or zip code for the patient's physical address"
    type: zipcode
    sql: ${TABLE}."PATIENT_SRC_POSTAL_CODE" ;;
  }

  dimension: patient_state {
    group_label: "Clinical Patient"
    description: "This is the two letter code used to indicate the state or province for the patient's physical address"
    type: string
    sql: ${TABLE}."PATIENT_STATE" ;;
  }

  dimension: plan_note_id {
    label: "Plan Note ID"
    group_label: "Session"
    description: "The unique database ID of the note containing the plan-of-action SOAP information entered by the clinician as part of the session panel"
    type: number
    sql: ${TABLE}."PLAN_NOTE_ID" ;;
  }

  dimension_group: program_create {
    description: "Date/Time when the program was created"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PROGRAM_CREATE_DATE" ;;
  }

  dimension: program_created_by {
    group_label: "Clinical Program"
    description: "User who created the program"
    type: string
    sql: ${TABLE}."PROGRAM_CREATED_BY" ;;
  }

  dimension_group: program_deactivate {
    description: "Date/Time when the program was deactivated"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PROGRAM_DEACTIVATE_DATE" ;;
  }

  dimension: program_estimated_duration_in_minutes {
    label: "Program Estimated Duration (In Minutes)"
    group_label: "Clinical Program"
    description: "The estimated length of time (in minutes) that it will take a clinician to complete one session of the program with a patient"
    type: number
    sql: ${TABLE}."PROGRAM_ESTIMATED_DURATION_IN_MINUTES" ;;
  }

  dimension_group: program_expire {
    description: "Date/Time when the program expires"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PROGRAM_EXPIRE_DATE" ;;
  }

  dimension: program_group_id {
    label: "Program Group ID"
    group_label: "Clinical Program"
    description: "The unique database ID of the program group that the session group is linked to"
    type: number
    sql: ${TABLE}."PROGRAM_GROUP_ID" ;;
  }

  dimension: program_id {
    label: "Program ID"
    group_label: "Clinical Program"
    description: "The unique database ID that identifies the program record"
    type: number
    sql: ${TABLE}."PROGRAM_ID" ;;
  }

  dimension: program_name {
    group_label: "Clinical Program"
    description: "Name of the program"
    type: string
    sql: ${TABLE}."PROGRAM_NAME" ;;
  }

  dimension_group: program_start {
    description: "Date/Time when the program start"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."PROGRAM_START_DATE" ;;
  }

  dimension: program_task_id {
    label: "Program Task ID"
    group_label: "Session"
    description: "The unique database ID of the program task that the session panel is linked to"
    type: number
    sql: ${TABLE}."PROGRAM_TASK_ID" ;;
  }

  dimension: program_type {
    group_label: "Clinical Program"
    description: "The type or category of the program"
    type: string
    sql: ${TABLE}."PROGRAM_TYPE" ;;
  }

  dimension: question_id {
    label: "Question ID"
    group_label: "Survey Session Question"
    description: "Question Identification Number corresponding to the each question"
    type: number
    sql: ${TABLE}."QUESTION_ID" ;;
  }

  dimension: rx_com_id {
    label: "RxCom ID"
    group_label: "Clinical Patient"
    description: "Unique ID number issued by the EPR (Electronic Pharmacy Record) application that is used to identify the patient on the Rx.com network for a specific chain"
    type: number
    sql: ${TABLE}."RX_COM_ID" ;;
  }

  dimension: session_set {
    group_label: "Session"
    description: "Indicates if the extracted information is from SESSION_INTERVIEW or PANEL "
    type: string
    sql: ${TABLE}."SESSION_SET" ;;
    suggestions: ["SESSION_INTERVIEW","PANEL"]
  }

  dimension: source_system_id {
    label: "Source System ID"
    hidden: yes
    description: "Source System ID"
    type: string
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

  dimension: sponsor_id {
    label: "Sponsor ID"
    group_label: "Clinical Program"
    description: "The unique database ID of the sponsor that the program is associated with"
    type: string
    sql: ${TABLE}."SPONSOR_ID" ;;
  }

  dimension: subjective_note_id {
    label: "Subjective Note ID"
    group_label: "Survey Session"
    description: "The unique database ID of the note containing the subjective SOAP information entered by the clinician as part of the session panel"
    type: number
    sql: ${TABLE}."SUBJECTIVE_NOTE_ID" ;;
  }

  dimension: survey_id {
    label: "Survey ID"
    group_label: "Survey Question"
    description: "Identification Number assigned to each Survey created on Survey_Gizmo application"
    type: string
    sql: ${TABLE}."SURVEY_ID" ;;
  }

  dimension: survey_question_alias {
    group_label: "Survey Question"
    description: "To group questions with same intended meaning"
    type: string
    sql: ${TABLE}."SURVEY_QUESTION_ALIAS" ;;
  }

  dimension: survey_question_sub_type {
    group_label: "Survey Question"
    description: "Sub type of the question"
    type: string
    sql: ${TABLE}."SURVEY_QUESTION_SUB_TYPE" ;;
  }

  dimension: survey_question_text {
    group_label: "Survey Question"
    description: "Title text of the Question"
    type: string
    sql: ${TABLE}."SURVEY_QUESTION_TEXT" ;;
  }

  dimension: survey_question_type {
    group_label: "Survey Question"
    description: "API object type"
    type: string
    sql: ${TABLE}."SURVEY_QUESTION_TYPE" ;;
  }

  dimension: survey_session_custom_question_option_identifier {
    group_label: "Survey Session Response"
    description: "Survey Session Question Option Identifier"
    type: string
    sql: ${TABLE}."SURVEY_SESSION_CUSTOM_QUESTION_OPTION_IDENTIFIER" ;;
  }

  dimension: survey_session_id {
    label: "Survey Session ID"
    group_label: "Survey Session REsponse"
    description: "Unique session ID generated for each response"
    type: string
    sql: ${TABLE}."SURVEY_SESSION_ID" ;;
  }

  dimension: survey_session_response_additional_text {
    group_label: "Survey Session Response"
    description: "Additional response comment for selected question"
    type: string
    sql: ${TABLE}."SURVEY_SESSION_RESPONSE_ADDITIONAL_TEXT" ;;
  }

  dimension: survey_session_response_display_question_flag {
    group_label: "Survey Session Response"
    description: "Yes/No Flag Indicating whether given question ID was shown"
    type: string
    sql: etl_manager.fn_get_master_code_desc('SURVEY_SESSION_RESPONSE_DISPLAY_QUESTION_FLAG', ${TABLE}.SURVEY_SESSION_RESPONSE_DISPLAY_QUESTION_FLAG,'Y') ;;
    suggestions: ["Y - Yes", "N - No"]
    suggest_persist_for: "24 hours"
  }

  dimension: survey_session_response_option_id {
    label: "Survey Session Response Option ID"
    group_label: "Survey Question"
    description: "Option Identifier selected for the question"
    type: number
    sql: ${TABLE}."SURVEY_SESSION_RESPONSE_OPTION_ID" ;;
  }

  dimension: survey_session_response_question_id {
    label: "Survey Session Response Question ID"
    group_label: "Survey Session Response"
    description: "Question Identifier"
    type: number
    sql: ${TABLE}."SURVEY_SESSION_RESPONSE_QUESTION_ID" ;;
  }

  dimension: survey_session_response_text {
    group_label: "Survey Session Response"
    description: "Answer for selected question"
    type: string
    sql: ${TABLE}."SURVEY_SESSION_RESPONSE_TEXT" ;;
  }

  dimension: survivor_patient_id {
    label: "Survivor Patient ID"
    group_label: "Clinical Patient"
    description: "The unique database ID of the Care Rx patient record that this patient record has been merged into"
    type: number
    sql: ${TABLE}."SURVIVOR_PATIENT_ID" ;;
  }

  dimension: user_profile_id {
    label: "User Profile ID"
    group_label: "Session"
    description: "The unique database ID of the user that created the note"
    type: number
    sql: ${TABLE}."USER_PROFILE_ID" ;;
  }


  measure: session_count {
    label: "Total Sessions"
    description: "Count of Sessions"
    type: number
    sql:  COUNT(DISTINCT(${mtm_session_id})) ;;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: patient_count {
    label: "Total Patients"
    description: "Count of Patients"
    type: number
    sql:  COUNT(DISTINCT(${patient_id})) ;;
    drill_fields: [patient_demographics_detail*]
    value_format: "#,##0"
  }

  measure: program_count {
    label: "Total Programs"
    description: "Count of Programs"
    type: number
    sql:  COUNT(DISTINCT(${program_id})) ;;
    drill_fields: [program_detail*]
    value_format: "#,##0"
  }

  measure: patient_program_count {
    label: "Total Patient Programs"
    description: "Count of Patient Program opportunities"
    type: number
    sql:  COUNT(DISTINCT(${patient_program_link_id})) ;;
    drill_fields: [patient_program_session_detail*]
    value_format: "#,##0"
  }

  measure: survey_session_question_count {
    label: "Total Questions"
    description: "Count of Survey Session Questions"
    type: number
    sql:  COUNT(DISTINCT(${question_id})) ;;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: survey_session_response_count {
    label: "Total Responses"
    description: "Count of Survey Session Responses"
    type: number
    sql:  COUNT(DISTINCT(${interview_response_data_id})) ;;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }


  dimension: session_completion_time_in_days {
    label: "Session Completion Time (In Days)"
    description: "Difference between the Completion and Last Start Date of a Session (In Days)"
    type: number
    sql:  datediff(day,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: avg_session_completion_time_in_days {
    label: "Average Session Completion Time (In Days)"
    description: "Difference between the Completion and Last Start Date of a Session (In Days)"
    type: average
    sql:  ${session_completion_time_in_days};;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  dimension: session_completion_time_in_hours {
    label: "Session Completion Time (In Hours)"
    description: "Difference between the Completion and Last Start Date of a Session (In Hours)"
    type: number
    sql:  datediff(hour,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: avg_session_completion_time_in_hours {
    label: "Average Session Completion Time (In Hours)"
    description: "Difference between the Completion and Last Start Date of a Session (In Hours)"
    type: average
    sql:  datediff(hour,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  dimension: session_completion_time_in_min {
    label: "Session Completion Time (In Min)"
    description: "Difference between the Completion and Last Start Date of a Session (In Minutes)"
    type: number
    sql:  datediff(minute,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: avg_session_completion_time_in_min {
    label: "Average Session Completion Time (In Min)"
    description: "Difference between the Completion and Last Start Date of a Session (In Minutes)"
    type: average
    sql:  datediff(minute,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  dimension: session_completion_time_in_seconds { #  this_field_is_used_to_display_in_hour_min_seconds (used in downstream calculation)
    hidden:  yes
    label: "Session Completion Time (In Seconds)"
    description: "Difference between the Completion and Last Start Date of a Session (In Seconds)"
    type: number
    sql:  datediff(seconds,${mtm_session_last_start_time},${mtm_session_complete_time});;
    drill_fields: [session_detail*]
    value_format: "#,##0"
  }

  measure: session_completion_time_in_hh_mm_ss { #  this_field_is_used_to_display_in_hour_min_seconds (used in downstream calculation)
    label: "Average Session Completion Time (In hh:mm:ss)"
    description: "Difference between the Completion and Last Start Date of a Session (In hh:mm:ss)"
    type: average
    sql:  (${session_completion_time_in_seconds} / 86400.0);;
    drill_fields: [session_detail*]
    value_format: "hh:mm:ss"
  }

  # ----- Sets of fields for drilling ------
  set: patient_demographics_detail {
    fields: [
      patient_first_name,
      patient_last_name,
      patient_address_line1,
      patient_city,
      patient_state,
      patient_postal_code,
      patient_phone_number,
      patient_deceased_date,
      patient_deactivate_date
    ]
  }

  set: session_detail {
    fields: [
      mtm_session_status,
      mtm_session_billing_status,
      patient_first_name,
      patient_last_name,
      patient_address_line1,
      patient_city,
      patient_state,
      patient_postal_code,
      patient_phone_number,
      patient_deceased_date,
      patient_deactivate_date,
      mtm_session_completed_nhin_store_id,
      mtm_session_completed_store_name,
      mtm_session_last_start_time,
      mtm_session_complete_time
    ]
  }

  set: patient_program_session_detail {
    fields: [

      patient_first_name,
      patient_last_name,
      patient_address_line1,
      patient_city,
      patient_state,
      patient_postal_code,
      patient_phone_number,
      patient_deceased_date,
      patient_deactivate_date,
      program_name,
      program_type,
      program_estimated_duration_in_minutes,
      patient_program_link_next_due_override,
      patient_program_link_opportunity_status,
      patient_program_link_next_due_time,
      patient_program_link_program_deactivate_time
    ]
  }

  set: program_detail {
    fields: [
        chain.chain_name,
        program_name,
        program_type,
        program_estimated_duration_in_minutes,
        program_create_time,
        program_start_time,
        program_expire_time,
        program_deactivate_time
      ]
    }
}

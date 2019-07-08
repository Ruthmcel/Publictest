view: store_patient_diagnosis {

  label: "Store Patient Diagnosis"
  sql_table_name: EDW.D_STORE_PATIENT_DIAGNOSIS ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${store_patient_diagnosis_id} ;;
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_patient_diagnosis_id {
    label: "Store Patient Diagnosis ID"
    description: "Unique ID number identifying a patient disease record. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_id {
    label: "Patient ID"
    description: "Patient record. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: store_patient_diagnosis_notes_id {
    label: "Notes ID"
    description: "Patient diagnosis note. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_NOTES_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: store_patient_diagnosis_medical_condition_code {
    label: "Store Patient Diagnosis Medical Condition Code"
    description: "Medical Condition Code. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_MEDICAL_CONDITION_CODE ;;
  }

  #[ERXDWPS-6646] - Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_diagnosis_duration_reference {
    label: "Store Patient Diagnosis Duration"
    description: "Duration of this disease, i.e, sudden severe onset of this disease or chronic, lasting an extended period of time. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_DURATION ;;
  }

  dimension: store_patient_diagnosis_duration {
    label: "Store Patient Diagnosis Duration"
    description: "Duration of this disease, i.e, sudden severe onset of this disease or chronic, lasting an extended period of time. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_DIAGNOSIS_DURATION', ${TABLE}.STORE_PATIENT_DIAGNOSIS_DURATION,'N') ;;
    drill_fields: [store_patient_diagnosis_duration_reference]
    suggestions: ["NOT SUPPLIED", "ACUTE", "CHRONIC"]
  }

  dimension: store_patient_diagnosis_icd10_code {
    label: "Store Patient Diagnosis ICD10 Code"
    description: "The ICD 10 code unformatted .. i.e. does not contain the decimal point. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_ICD10_CODE ;;
  }

  dimension: store_patient_diagnosis_icd10_description {
    label: "Store Patient Diagnosis ICD10 Description"
    description: "Description of the ICD 10 code. EPS Table: ICD10"
    type: string
    sql: ${store_patient_icd10.store_icd10_description} ;;
  }

  dimension: store_patient_diagnosis_icd10_code_formatted {
    label: "Store Patient Diagnosis ICD10 Code Formatted"
    description: "The ICD 10 code formatted .. i.e. does contain the decimal point. EPS Table Name: PATIENT_DIAGNOSIS"
    type: string
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_ICD10_CODE_FORMATTED ;;
  }

  dimension_group: store_patient_diagnosis_end {
    label: "Store Patient Diagnosis End"
    description: "Date in which system suppresses the sending of this record to MS for DUR consideration. EPS Table Name: PATIENT_DIAGNOSIS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_END_DATE ;;
  }

  dimension_group: store_patient_diagnosis_last_rx {
    label: "Store Patient Diagnosis Last Rx"
    description: "Date when an Rx is filled that is linked to this disease. EPS Table Name: PATIENT_DIAGNOSIS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_LAST_RX_DATE ;;
  }

  dimension: store_patient_diagnosis_counter {
    label: "Store Patient Diagnosis Counter"
    description: "Order in which to display record. EPS Table Name: PATIENT_DIAGNOSIS"
    type: number
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_COUNTER ;;
  }

  dimension_group: store_patient_diagnosis_deactivate {
    label: "Store Patient Diagnosis Deactivate"
    description: "Date on which this record was deactivated. EPS Table Name: PATIENT_DIAGNOSIS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DIAGNOSIS_DEACTIVATE_DATE ;;
  }

  dimension_group: store_patient_disease_source_create_timestamp {
    label: "Store Patient Diagnosis Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time this record was created in source table. EPS Table Name: PATIENT_DIAGNOSIS"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: store_user_source_timestamp {
    label: "Store Patient Diagnosis Last Update"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: PATIENT_DIAGNOSIS"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

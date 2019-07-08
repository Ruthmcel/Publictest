view: store_patient_disease {

  label: "Store Patient Disease"
  sql_table_name: EDW.D_STORE_PATIENT_DISEASE ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${store_patient_disease_id} ;;
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_patient_disease_id {
    label: "Store Patient Disease ID"
    description: "Unique ID number identifying a patient disease record. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DISEASE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_id {
    label: "Patient ID"
    description: "Patient record. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: notes_id {
    label: "Notes ID"
    description: "Patient disease note. EPS Table Name: PATIENT_DISEASE"
    type: number
    hidden: yes
    sql: ${TABLE}.NOTES_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_disease_type_reference {
    label: "Store Patient Disease Type"
    description: "Type of disease. EPS Table Name: PATIENT_DISEASE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DISEASE_CODE_TYPE ;;
  }

  dimension: store_patient_disease_type {
    label: "Store Patient Disease Type"
    description: "Type of disease. EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_DISEASE_CODE_TYPE', ${TABLE}.STORE_PATIENT_DISEASE_CODE_TYPE,'N') ;;
    drill_fields: [store_patient_disease_type_reference]
    suggestions: ["NOT DEFINED", "MEDICAL CONDITION ID", "DRUG DISEASE"]
  }

  dimension: store_patient_disease_code {
    label: "Store Patient Disease Code"
    description: "Code indicating the duration of a disease record. EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: ${TABLE}.STORE_PATIENT_DISEASE_CODE ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_disease_duration_reference {
    label: "Store Patient Disease Duration"
    description: "Indicating the duration of a disease record. EPS Table Name: PATIENT_DISEASE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DISEASE_DURATION ;;
  }

  dimension: store_patient_disease_duration {
    label: "Store Patient Disease Duration"
    description: "Indicating the duration of a disease record. EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_DISEASE_DURATION', ${TABLE}.STORE_PATIENT_DISEASE_DURATION,'N') ;;
    drill_fields: [store_patient_disease_duration_reference]
    suggestions: ["NOT SUPPLIED", "ACUTE", "CHRONIC"]
  }

  dimension: store_patient_disease_icd9 {
    label: "Store Patient Disease ICD9"
    description: "ICD-9 diagnosis code. EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: ${TABLE}.STORE_PATIENT_DISEASE_ICD9 ;;
  }

  dimension: store_patient_disease_icd9_description {
    label: "Store Patient Disease ICD9 Description"
    description: "Description of the ICD-9. EPS Table: ICD9"
    type: string
    sql: ${store_patient_icd9.store_icd9_description} ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_disease_icd9_type_reference {
    label: "Store Patient Disease ICD9 Type"
    description: "ICD-9 Type. EPS Table Name: PATIENT_DISEASE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DISEASE_ICD9_TYPE ;;
  }

  dimension: store_patient_disease_icd9_type {
    label: "Store Patient Disease ICD9 Type"
    description: "ICD-9 Type. EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_DISEASE_ICD9_TYPE', ${TABLE}.STORE_PATIENT_DISEASE_ICD9_TYPE,'N') ;;
    drill_fields: [store_patient_disease_icd9_type_reference]
    suggestions: ["ICD-9", "EXTERNAL CAUSE", "FACTORS", "MORPHOLOGY"]
  }

  dimension_group: store_patient_disease_end {
    label: "Store Patient Disease End"
    description: "Stop Date on the UI and represents the date to stop checking this disease for the patient. EPS Table Name: PATIENT_DISEASE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DISEASE_END_DATE ;;
  }

  dimension: store_patient_disease_counter {
    label: "Store Patient Disease Counter"
    description: "Value indicating the severity of a patient disease record. EPS Table Name: PATIENT_DISEASE"
    type: number
    sql: ${TABLE}.STORE_PATIENT_DISEASE_COUNTER ;;
  }

  dimension_group: store_patient_disease_last_rx {
    label: "Store Patient Disease Last Rx"
    description: "Date rx was last filled for this disease. EPS Table Name: PATIENT_DISEASE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DISEASE_LAST_RX_DATE ;;
  }

  dimension_group: store_patient_disease_deactivate {
    label: "Store Patient Disease Deactivate"
    description: "Date disease was deactivated. EPS Table Name: PATIENT_DISEASE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_DISEASE_DEACTIVATE_DATE ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_disease_converted_flag_reference {
    label: "Store Patient Disease Converted Flag"
    description: "Indicates whether or not this particular Patient Disease record has been converted to an appropriate Medical Condition(s). EPS Table Name: PATIENT_DISEASE"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_DISEASE_CONVERTED_FLAG ;;
  }

  dimension: store_patient_disease_converted_flag {
    label: "Store Patient Disease Converted Flag"
    description: "Indicates whether or not this particular Patient Disease record has been converted to an appropriate Medical Condition(s). EPS Table Name: PATIENT_DISEASE"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_DISEASE_CONVERTED_FLAG', ${TABLE}.STORE_PATIENT_DISEASE_CONVERTED_FLAG,'N') ;;
    drill_fields: [store_patient_disease_converted_flag_reference]
    suggestions: ["RECORD HAS BEEN CONVERTED", "RECORD HAS NOT BEEN CONVERTED"]
  }

  dimension_group: store_patient_disease_source_create_timestamp {
    label: "Store Patient Disease Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time this record was created in source table. EPS Table Name: PATIENT_DISEASE"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: store_user_source_timestamp {
    label: "Store Patient Disease Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: PATIENT_DISEASE"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

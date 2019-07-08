view: store_patient_email {

  label: "Store Patient Email"
  sql_table_name: EDW.D_STORE_PATIENT_EMAIL ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${store_patient_email_id} ;;
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_patient_email_id {
    label: "Store Patient Email ID"
    description: "Unique ID number identifying a patient email record. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_EMAIL_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_id {
    label: "Patient ID"
    description: "Patient record. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: notes_id {
    label: "Notes ID"
    description: "Patient disease note. EPS Table Name: PATIENT_EMAIL"
    type: number
    hidden: yes
    sql: ${TABLE}.NOTES_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: store_patient_email_primary_email {
    label: "Store Patient Primary Email"
    description: "Yes/No Flag indicating if this record is the primary email address for a patient. EPS Table Name: PATIENT_EMAIL"
    type: yesno
    sql: ${TABLE}.STORE_PATIENT_EMAIL_PRIMARY_EMAIL_FLAG = 'Y' ;;
  }

  dimension: store_patient_email_address {
    label: "Store Patient Email Address"
    description: "Patient's email address. EPS Table Name: PATIENT_EMAIL"
    type: string
    sql: ${TABLE}.STORE_PATIENT_EMAIL_ADDRESS ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_email_location_type_reference {
    label: "Store Patient Email Location Type"
    description: "Represents the email address location. EPS Table Name: PATIENT_EMAIL"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_EMAIL_LOCATION_TYPE ;;
  }

  dimension: store_patient_email_location_type {
    label: "Store Patient Email Location Type"
    description: "Represents the email address location. EPS Table Name: PATIENT_EMAIL"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_EMAIL_LOCATION_TYPE', ${TABLE}.STORE_PATIENT_EMAIL_LOCATION_TYPE,'N') ;;
    drill_fields: [store_patient_email_location_type_reference]
    suggestions: ["HOME", "WORK", "SCHOOL", "UNSPECIFIED", "NOT DEFINED"]
  }

  dimension_group: store_patient_email_deactivate {
    label: "Store Patient Email Deactivate"
    description: "Date a patient email record should be or was deactivated. EPS Table Name: PATIENT_EMAIL"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_EMAIL_DEACTIVATE_DATE ;;
  }

  dimension: store_patient_email_sms_indicator {
    label: "Store Patient Email SMS Indicator"
    description: "Yes/No Flag indicating if the value entered in the address line is for a phone number that can accept text messages. EPS Table Name: PATIENT_EMAIL"
    type: yesno
    sql: ${TABLE}.STORE_PATIENT_EMAIL_SMS_INDICATIOR = 'Y' ;;
  }

  #[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_patient_email_service_vendor_reference {
    label: "Store Patient Email Service Vendor"
    description: "Indicates the mobile services the patient will be using for notifications. EPS Table Name: PATIENT_EMAIL"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PATIENT_EMAIL_SERVICE_VENDOR ;;
  }

  dimension: store_patient_email_service_vendor {
    label: "Store Patient Email Service Vendor"
    description: "Indicates the mobile services the patient will be using for notifications. EPS Table Name: PATIENT_EMAIL"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PATIENT_EMAIL_SERVICE_VENDOR', ${TABLE}.STORE_PATIENT_EMAIL_SERVICE_VENDOR,'N') ;;
    drill_fields: [store_patient_email_service_vendor_reference]
    suggestions: ["NO CHOICE", "MSCRIPTS", "CELLEPATHIC", "ACCLAIM", "NOT DEFINED"]

  }

  dimension_group: store_patient_email_terms_of_service {
    label: "Store Patient Email Terms of Service"
    description: "Date/Time patient presented the terms of service agreement and accepted the terms. EPS Table Name: PATIENT_EMAIL"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    sql: ${TABLE}.STORE_PATIENT_EMAIL_TERMS_OF_SERVICE_DATE ;;
  }

  dimension_group: store_patient_email_source_create_timestamp {
    label: "Store Patient Email Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time this record was created in source table. EPS Table Name: PATIENT_EMAIL"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: store_user_source_timestamp {
    label: "Store Patient Email Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table Name: PATIENT_EMAIL"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

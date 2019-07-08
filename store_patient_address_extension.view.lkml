view: store_patient_address_extension {
  #[ERXLPS-1024][ERXLPS-2420] - Renamed eps_patient_address_extension view name to store_patient_address_extension.
  label: "Store Patient Address"
  sql_table_name: edw.d_patient_address_extension ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${address_id} ||'@'||${source_system_id} ;; #ERXLPS-1649  #ERXDWPS-5137
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: address_id {
    label: "Address Id"
    type: string #ERXLPS-5137
    description: "Unique ID of the Address record"
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem."
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_address_extension_default_delivery_site_code {
    label: "Store Patient Address Default Delivery Site Code"
    description: "Used to track the default delivery site/center that services this patient address record.Used to set the new ORDER_ENTRY.DELIVERY_SITE column. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_DELIVERY_SITE_CODE ;;
  }

  ############################################################## Dimensions ######################################################
  dimension: patient_address_extension_primary {
    label: "Store Patient Address Primary"
    description: "Yes/No flag indicating the address is the patient's primary address. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_PRIMARY_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_billing {
    label: "Store Patient Address Billing"
    description: "Yes/No flag indicating if the associated address is used for billing purpose. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_BILLING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_shipping {
    label: "Store Patient Address Shipping"
    description: "Yes/No flag indicating if the associated address is used for shipping purpose. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_SHIPPING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_type_code {
    label: "Store Patient Address Type Code"
    description: "Defines whether or not the address is Not Defined, a home, Second Home, work, vacation home, or temporary. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PATIENT_ADDRESS_EXTENSION_TYPE_CODE') ;;
    suggestions: ["UNKNOWN", "HOME", "SECOND HOME", "WORK", "VACATION", "TEMPORARY", "SCHOOL"]
  }

  dimension_group: patient_address_extension_deactivate {
    label: "Store Patient Address Deactivate"
    description: "Date/Time address was discontinued. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEACTIVATE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_start {
    label: "Store Patient Address Start"
    description: "Date/Time address initiated by the patient. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_end {
    label: "Store Patient Address End"
    description: "Date/Time the patient will no longer be living at the address. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: patient_address_extension_clean {
    label: "Store Patient Address Clean"
    description: "Yes/No flag indicating if address has been standardized to USPS. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_CLEAN_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_note_id {
    label: "Store Patient Address Note ID"
    description: "User entered free format note for the address.Foreign key to notes table. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: number
    hidden: yes
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_NOTE_ID ;;
  }

  dimension: patient_address_extension_address_identifier {
    label: "Store Patient Address Identifier"
    description: "Used to uniquely identify a patient's address.IVR request ID used to determine the shipping address of the patient for the order. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_ADDRESS_IDENTIFIER ;;
  }

  dimension: patient_address_extension_default_address {
    label: "Store Patient Address Default Address"
    description: "Yes/No flag populated from EPR indicating if the default address is defined or not. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_ADDRESS_FLAG = 'Y' ;;

  }

  dimension_group: source_create_timestamp {
    label: "Source Create Timestamp"
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
    hidden: yes
    description: "This is the date and time that the record was created in source table. EPS Table Name: PATIENT_ADDRESS_EXT"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Patient address extention Last Update"
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
    hidden: yes
    description: "This is the date and time at which the record was last updated in the source application. EPS Table Name: PATIENT_ADDRESS_EXT"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }


############################################################## Measures ######################################################

  measure: patient_address_count {
    label: "Store Patient Address Count"
    description: "Total Addresses of patient. EPS Table Name: PATIENT_ADDRESS_EXT"
    type: count
  }


############################################# Sets #####################################################

  set: explore_patient_address_extension_4_14_candidate_list {
    fields: [
      patient_address_extension_primary,
      patient_address_extension_billing,
      patient_address_extension_shipping,
      patient_address_extension_type_code,
      patient_address_extension_deactivate_time,
      patient_address_extension_deactivate_date,
      patient_address_extension_deactivate_week,
      patient_address_extension_deactivate_month,
      patient_address_extension_deactivate_month_num,
      patient_address_extension_deactivate_year,
      patient_address_extension_deactivate_quarter,
      patient_address_extension_deactivate_quarter_of_year,
      patient_address_extension_deactivate_hour_of_day,
      patient_address_extension_deactivate_time_of_day,
      patient_address_extension_deactivate_hour2,
      patient_address_extension_deactivate_minute15,
      patient_address_extension_deactivate_day_of_week,
      patient_address_extension_deactivate_day_of_month,
      patient_address_extension_start_time,
      patient_address_extension_start_date,
      patient_address_extension_start_week,
      patient_address_extension_start_month,
      patient_address_extension_start_month_num,
      patient_address_extension_start_year,
      patient_address_extension_start_quarter,
      patient_address_extension_start_quarter_of_year,
      patient_address_extension_start_hour_of_day,
      patient_address_extension_start_time_of_day,
      patient_address_extension_start_hour2,
      patient_address_extension_start_minute15,
      patient_address_extension_start_day_of_week,
      patient_address_extension_start_day_of_month,
      patient_address_extension_end_time,
      patient_address_extension_end_date,
      patient_address_extension_end_week,
      patient_address_extension_end_month,
      patient_address_extension_end_month_num,
      patient_address_extension_end_year,
      patient_address_extension_end_quarter,
      patient_address_extension_end_quarter_of_year,
      patient_address_extension_end_hour_of_day,
      patient_address_extension_end_time_of_day,
      patient_address_extension_end_hour2,
      patient_address_extension_end_minute15,
      patient_address_extension_end_day_of_week,
      patient_address_extension_end_day_of_month,
      patient_address_extension_clean,
      patient_address_extension_default_address
    ]
  }
}

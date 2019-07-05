view: eps_patient_address_link {
  label: "Patient Address Link"
  sql_table_name: edw.d_patient_address_link ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${patient_address_link_id}||'@'||${source_system_id} ;; #ERXLPS-1649  #ERXDWPS-5137
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

  dimension: patient_address_link_id {
    label: "Address Id"
    type: string #ERXDWPS-5137
    description: "Unique ID of the Address Link record"
    hidden: yes
    sql: ${TABLE}.PATIENT_ADDRESS_LINK_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_id {
    label: "Patient ID"
    type: string #ERXDWPS-5137
    description: "Unique Id number identifying the patient record, at the store, to which this record is linked. EPS Table Name: PATIENT_ADDRESS_LINK"
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }
  dimension: address_id {
    label: "Address ID"
    type: string  #ERXDWPS-5137
    description: "Unique Id number identifying the address record, at the store, to which this record is linked. EPS Table Name: PATIENT_ADDRESS_LINK"
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }
################################################################## DIMENSIONS ################################
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
    description: "This is the date and time that the record was created in source table. EPS Table Name: PATIENT_ADDRESS_LINK"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
    description: "This is the date and time at which the record was last updated in the source application. EPS Table Name: PATIENT_ADDRESS_LINK"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

view: store_central_fill_facility {

  label: "Store Central Fill Facility"
  sql_table_name: EDW.D_STORE_CENTRAL_FILL_FACILITY ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_central_fill_facility_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_central_fill_facility_id {
    label: "Store Central Fill Facility ID"
    description: "Unique ID number identifying this record. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_central_fill_facility_name {
    label: "Store Central Fill Facility Name"
    description: "Name of central fill facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_NAME ;;
  }

  dimension: address_id {
    label: "Address ID"
    description: "Address of central fill facility. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: store_central_fill_facility_contact {
    label: "Store Central Fill Facility Contact"
    description: "Name of contact at central fill facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_CONTACT ;;
  }

  dimension_group: store_central_fill_facility_close {
    label: "Store Central Fill Facility Close"
    description: "Date a central fill facility is or was deactivated. EPS Table Name: CF_FACILITY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_CLOSE_DATE ;;
  }

  dimension_group: store_central_fill_facility_dea_expire {
    label: "Store Central Fill Facility DEA Expire"
    description: "Facility DEA expiration date. EPS Table Name: CF_FACILITY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_DEA_EXPIRE_DATE ;;
  }

  dimension: store_central_fill_facility_dea_number {
    label: "Store Central Fill Facility DEA Number"
    description: "Federal DEA number for this Facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_DEA_NUMBER ;;
  }

  dimension: store_central_fill_facility_federal_tax_number {
    label: "Store Central Fill Facility Federal Tax Number"
    description: "Federal Tax number for this Facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_FEDERAL_TAX_NUMBER ;;
  }

  dimension: store_central_fill_facility_state_license_number {
    label: "Store Central Fill Facility State License Number"
    description: "State or local facility license number. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_STATE_LICENSE_NUMBER ;;
  }

  dimension: store_central_fill_facility_ncpdp_number {
    label: "Store Central Fill Facility NCPDP Number"
    description: "NCPDP or NABP number for facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_NCPDP_NUMBER ;;
  }

  dimension: phone_id {
    label: "Phone Id"
    description: "ID of the phone record for this facility. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.PHONE_ID ;;
  }

  dimension: store_central_fill_facility_alternate_phone_id {
    label: "Store Central Fill Facility Alternate Phone Id"
    description: "ID of the Alternate phone number for this facility. EPS Table Name: CF_FACILITY"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_ALTERNATE_PHONE_ID ;;
  }

  dimension: store_central_fill_facility_short_name {
    label: "Store Central Fill Facility Short Name"
    description: "Short name of central fill facility. EPS Table Name: CF_FACILITY"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_FACILITY_SHORT_NAME ;;
  }

  dimension_group: source {
    label: "Store Central Fill Facility Source Update"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis. EPS Table Name: CF_FACILITY"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW."
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW."
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

############################################################ END OF DIMENSIONS ############################################################

}

#[ERXLPS-6307] - New view created for ars.contact_info table. Only Phone and Fax information exposed from this view.
#All other columns are currently hidden. Currently Store address is exposed from SEC ADMIN tables. We need to perform analysis on saved to report to see the impact before we expose store address information from contact_info and hiding from sec_admin.
view: store_contact_information {
  label: "Pharmacy Central"
  sql_table_name: EDW.D_CONTACT_INFORMATION ;;

  dimension: store_contact_info_id {
    label: "Pharmacy Central Contact Information ID"
    description: "Pharmacy ARS ID"
    type: number
    hidden: yes
    sql: ${TABLE}.CONTACT_INFO_ID ;;
  }

  dimension: store_contact_info_code {
    label: "Pharmacy Central Contact Information Code"
    description: "Pharmacy ARS Code"
    type: string
    hidden: yes
    sql: ${TABLE}.CONTACT_INFO_CODE ;;
  }

  dimension: store_contact_info_address {
    label: "Pharmacy Address (Central)"
    description: "Pharmacy Central Address"
    type: string
    sql: ${TABLE}.CONTACT_INFO_ADDRESS ;;
  }

  dimension: store_contact_info_address_line2 {
    label: "Pharmacy Address Line2 (Central)"
    description: "Pharmacy Central Address Line2"
    type: string
    sql: ${TABLE}.CONTACT_INFO_ADDRESS_LINE_2 ;;
  }

  dimension: store_contact_info_state {
    label: "Pharmacy State (Central)"
    description: "Pharmacy Central State"
    type: string
    sql: ${TABLE}.CONTACT_INFO_STATE ;;
  }

  dimension: store_contact_info_city {
    label: "Pharmacy City (Central)"
    description: "Pharmacy Central City"
    type: string
    sql: ${TABLE}.CONTACT_INFO_CITY ;;
  }
  dimension: store_contact_info_county {
    label: "Pharmacy County (Central)"
    description: "Pharmacy Central County"
    type: string
    sql: ${TABLE}.CONTACT_INFO_COUNTY ;;
  }

  dimension: store_contact_info_zip_code {
    label: "Pharmacy ZIP Code (Central)"
    description: "Pharmacy Central ZIP Code"
    type: string
    sql: ${TABLE}.CONTACT_INFO_ZIP_CODE ;;
  }

  dimension: store_contact_info_src_zip_code {
    label: "Pharmacy Source ZIP Code (Central)"
    description: "Pharmacy Central Source ZIP Code"
    type: string
    sql: ${TABLE}.CONTACT_INFO_SRC_ZIP_CODE ;;
  }
  dimension: store_contact_info_email_address {
    label: "Pharmacy Email Address (Central)"
    description: "Pharmacy Central Email Address"
    type: string
    sql: ${TABLE}.CONTACT_INFO_EMAIL_ADDRESS ;;
  }

  dimension: store_contact_info_fax_number {
    label: "Pharmacy FAX Number (Central)"
    description: "Pharmacy Central FAX Number"
    type: string
    sql: ${TABLE}.CONTACT_INFO_FAX_NUMBER ;;
    value_format: "(###)-###-####"
  }

  dimension: store_contact_info_voice_number {
    label: "Pharmacy Phone Number (Central)"
    description: "Pharmacy Central Phone Number"
    type: string
    sql: ${TABLE}.CONTACT_INFO_VOICE_NUMBER ;;
    value_format: "(###)-###-####"
  }
  dimension: store_contact_info_lcr_id {
    label: "Pharmacy Central LCR ID"
    description: "Pharmacy Central LCR ID"
    hidden: yes
    type: number
    sql: ${TABLE}.CONTACT_INFO_LCR_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: event_id {
    hidden:  yes
    type: number
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: edw_insert_timestamp {
    hidden:  yes
    type: time
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    hidden:  yes
    type: time
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: store_contact_info_deleted {
    label: "Pharmacy Central Deleted"
    description: "Pharmacy Central Deleted"
    type: string
    hidden: yes
    sql: ${TABLE}.CONTACT_INFO_DELETED ;;
  }

  dimension: store_contact_info_last_update_user_identifier {
    label: "Pharmacy Last Update User Identifier (Central)"
    description: "Pharmacy Central Last Update User Identifier"
    type: number
    hidden: yes
    sql: ${TABLE}.CONTACT_INFO_LAST_UPDATE_USER_IDENTIFIER ;;
  }
}

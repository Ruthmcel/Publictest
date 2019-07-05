view: epr_alt_prescriber {
  label: "Alt Prescriber"
  sql_table_name: EDW.D_ALT_PRESCRIBER ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${alt_prescriber_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "ID number for chain. EPR Table: ALT_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: alt_prescriber_id {
    label: "Alt Prescriber Id"
    description: "Unique ID number identifying a prescriber record. EPR Table: ALT_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.ALT_PRESCRIBER_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying an BI source system. EPR Table: ALT_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN_ID is the NHIN (National Health Information Network) account number uniquely identifying the pharmacy (store) that originally added this record. EPR Table: ALT_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: alt_prescriber_first_name {
    label: "Alt Prescriber First Name"
    description: "Prescriber's first name. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: alt_prescriber_middle_name {
    label: "Alt Prescriber Middle Name"
    description: "Prescriber's middle name. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_MIDDLE_NAME ;;
  }

  dimension: alt_prescriber_last_name {
    label: "Alt Prescriber Last Name"
    description: "Prescriber's last name. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_LAST_NAME ;;
  }

  dimension: alt_prescriber_name {
    label: "Alt Prescriber Name"
    description: "Prescriber's full name (Last name,First name). EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_NAME ;;
  }

  dimension: alt_prescriber_address {
    label: "Alt Prescriber Address"
    description: "ADDRESS contains all address line 1 and can contain address line 2 information. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_ADDRESS ;;
  }

  dimension: alt_prescriber_address1 {
    label: "Alt Prescriber Address1"
    description: "ADDRESS1 stores the second line of prescriber address in non-EPS clients. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_ADDRESS1 ;;
  }

  dimension: alt_prescriber_city {
    label: "Alt Prescriber City"
    description: "City of Prescriber's office. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_CITY ;;
  }

  dimension: alt_prescriber_state {
    label: "Alt Prescriber State"
    description: "Prescriber's state. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_STATE ;;
  }

  dimension: alt_prescriber_src_zip_code {
    label: "Alt Prescriber Src Zip Code"
    description: "Prescriber's zip code same as present in source system. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_SRC_ZIP_CODE ;;
  }

  dimension: alt_prescriber_zip_code {
    label: "Alt Prescriber Zip Code"
    description: "Contain first five characters of Prescriber's zip code present in source system. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_ZIP_CODE ;;
  }

  dimension: alt_prescriber_country {
    label: "Alt Prescriber Country"
    description: "Country of Prescriber's office. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_COUNTRY ;;
  }

  dimension: alt_prescriber_phone_number {
    label: "Alt Prescriber Phone Number"
    description: "Prescriber's telephone number. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_PHONE_NUMBER ;;
  }

  dimension: alt_prescriber_fax_phone_num {
    label: "Alt Prescriber Fax Phone Num"
    description: "Prescriber's fax phone number. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_FAX_PHONE_NUM ;;
  }

  dimension: alt_prescriber_npi_number {
    label: "Alt Prescriber Npi Number"
    description: "Prescriber's National Provider ID. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_NPI_NUMBER ;;
  }

  dimension: alt_prescriber_dea_number {
    label: "Alt Prescriber Dea Number"
    description: "Prescriber's Drug Enforcement Agency number. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: alt_prescriber_state_id_number {
    label: "Alt Prescriber State Id Number"
    description: "STATE_ID is issued by the state for a prescriber. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_STATE_ID_NUMBER ;;
  }

  dimension: alt_prescriber_hcid {
    label: "Alt Prescriber Hcid"
    description: "HCID will store the HCID associated with the prescriber record that was linked to the RX_TX. EPR Table: ALT_PRESCRIBER"
    type: string
    hidden: yes
    sql: ${TABLE}.ALT_PRESCRIBER_HCID ;;
  }

  dimension: alt_prescriber_hms_identifier {
    label: "Alt Prescriber Hms Identifier"
    description: "HMS_IDENTIFIER will store the HMS Prescriber ID associated with the prescriber record that was linked to the RX_TX. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_HMS_IDENTIFIER ;;
  }

  dimension: alt_prescriber_cpm_identifier {
    label: "Alt Prescriber Cpm Identifier"
    description: "CPM_IDENTIFIER will store the Central Prescriber ID associated with the prescriber record that was linked to the RX_TX. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: ${TABLE}.ALT_PRESCRIBER_CPM_IDENTIFIER ;;
  }

  dimension: alt_prescriber_deleted {
    label: "Alt Prescriber Deleted"
    description: "Flag that determines whether a Prescriber record has been set to deleted. EPR Table: ALT_PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.ALT_PRESCRIBER_DELETED = 'N' THEN 'N - NO'
              WHEN ${TABLE}.ALT_PRESCRIBER_DELETED = 'Y' THEN 'Y - YES'
              ELSE TO_CHAR(${TABLE}.ALT_PRESCRIBER_DELETED)
         END ;;
  }

  dimension: alt_prescriber_lcr_id {
    label: "Alt Prescriber Lcr Id"
    description: "Unique ID populated during the data load process that identifies the record. EPR Table: ALT_PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.ALT_PRESCRIBER_LCR_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Alt Prescriber Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: ALT_PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

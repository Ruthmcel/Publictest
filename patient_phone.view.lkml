view: patient_phone {
  sql_table_name: EDW.D_PATIENT_PHONE ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    label: "Central Patient RX COM ID"
    description: "Patient unique identifier"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: phone_number {
    group_label: "Central Patient Phone Info"
    label: "Central Patient Cell Phone Number"
    description: "Patient's Cell Phone Number"
    type: number
    sql: ${TABLE}.PATIENT_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: country_code {
    #     currently no-value as EPR does not store the country code for the chains loaded to EDW
    hidden: yes
    group_label: "Central Patient Phone Info"
    label: "Central Patient Cell Phone Country Code"
    description: "Patient's Cell Phone Country Code"
    type: string
    sql: ${TABLE}.PATIENT_PHONE_COUNTRY_CODE ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${phone_number} ;; #ERXLPS-1649
  }

  dimension: nhin_store_id {
    # Disabled as the NHIN_STORE_ID on the patient record is the candidate that's enabled to determine which store last touched/updated Patient's record
    hidden: yes
    type: string
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_PHONE_DELETED ;;
  }

  dimension: location_type {
    # Only CCC types possible.  EPR Currently stores only CELLPHONE information of the patient.
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_PHONE_LOCATION_TYPE ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }
}

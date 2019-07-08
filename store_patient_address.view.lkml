view: store_patient_address {

  label: "Store Patient Address"
  sql_table_name: EDW.D_ADDRESS ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string #ERXDWPS-5137
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${address_id}||'@'|| ${source_system_id} ;; #ERXDWPS-5137
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. EPS Table Name: ADDRESS"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. EPS Table Name: ADDRESS"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: address_id {
    label: "Address ID"
    description: "Unique ID number identifying an address record. EPS Table Name: ADDRESS"
    type: string
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. EPS Table Name: ADDRESS"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: address_home_phone_id {
    label: "Address Home Phone ID"
    description: "Id from the phone table for the home phone for the associated address. EPS Table Name: ADDRESS"
    type: string #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_HOME_PHONE_ID ;;
  }

  dimension: address_work_phone_id {
    label: "Address Work Phone ID"
    description: "Id from the phone table for the work phone for the associated address. EPS Table Name: ADDRESS"
    type: string #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_WORK_PHONE_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: address_line_1 {
    label: "Store Patient Address Line 1"
    description: "First line of the address not including City, State, Country, PO Box, or Zip Code. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_LINE_1 ;;
  }

  dimension: address_line_2 {
    label: "Store Patient Address Line 2"
    description: "Second line of the address not including City, State, Country, PO Box, or Zip Code.Second address line. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_LINE_2 ;;
  }

  dimension: address_city {
    label: "Store Patient Address City"
    description: "Address city name. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_CITY ;;
  }

  dimension: address_state {
    label: "Store Patient Address State"
    description: "Two letter code used to indicate the state or province in which the address exists. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_STATE ;;
  }

  dimension: address_postal_code {
    label: "Store Patient Address Postal Code"
    description: "Zip or postal code. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_POSTAL_CODE ;;
  }

  dimension: address_src_postal_code {
    label: "Store Patient Address Source Postal Code"
    description: "Zip or postal code. EPS Table Name: ADDRESS"
    type: string
    hidden: yes
    sql: ${TABLE}.ADDRESS_SRC_POSTAL_CODE ;;
  }

  dimension: address_country {
    label: "Store Patient Address Country"
    description: "Code used to represent the country. EPS Table Name: ADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_COUNTRY ;;
  }

  dimension: address_po_box_flag {
    label: "Store Patient Address PO Box"
    description: "Yes/No Flag indicating if this address is a post office box. EPS Table Name: ADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_PO_BOX_FLAG = 'Y' ;;
  }

  dimension: address_do_not_verify_flag {
    label: "Store Patient Address Do Not Verify"
    description: "Yes/No Flag indicatting if the address record does not need to be verified by Rx.com. EPS Table Name: ADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_DO_NOT_VERIFY_FLAG = 'Y' ;;
  }

  dimension: address_validated_flag {
    label: "Store Patient Address Validated"
    description: "Yes/No Flag indicating that Rx.com has successfully validated an address record. EPS Table Name: ADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_VALIDATED_FLAG = 'Y' ;;
  }

  dimension: address_home_phone {
    label: "Store Patient Home Phone Number"
    description: "Patient home phone number. EPS Table Name: PHONE"
    type: string
    sql: ${store_patient_home_phone.phone_number} ;;
    #value_format: "000-000-0000"
  }

  dimension: address_work_phone {
    label: "Store Patient Work Phone Number"
    description: "Patient work phone number. EPS Table Name: PHONE"
    type: string
    sql: ${store_patient_work_phone.phone_number} ;;
    #value_format: "###-(###-####)"
  }

}

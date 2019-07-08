view: eps_address {

  label: "Address"
  sql_table_name: EDW.D_ADDRESS ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${address_id}||'@'||${source_system_id}  ;; #ERXDWPS-5137
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: address_id {
    label: "Address ID"
    description: "Unique ID number identifying an address record. This field is EPS only!!!"
    type: string  #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: address_home_phone_id {
    label: "Address Home Phone ID"
    description: "Id from the phone table for the home phone for the associated address. This field is EPS only!!!"
    type: string #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_HOME_PHONE_ID ;;
  }

  dimension: address_work_phone_id {
    label: "Address Work Phone ID"
    description: "Id from the phone table for the work phone for the associated address. This field is EPS only!!!"
    type: string #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_WORK_PHONE_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: address_line_1 {
    label: "Address Line 1"
    description: "First line of the address not including City, State, Country, PO Box, or Zip Code. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_LINE_1 ;;
  }

  dimension: address_line_2 {
    label: "Address Line 2"
    description: "Second line of the address not including City, State, Country, PO Box, or Zip Code.Second address line. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_LINE_2 ;;
  }

  dimension: address_city {
    label: "Address City"
    description: "Address city name. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_CITY ;;
  }

  dimension: address_state {
    label: "Address State"
    description: "This is the two letter code used to indicate the state or province in which the address exists. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_STATE ;;
  }

  dimension: address_postal_code {
    label: "Address Postal Code"
    description: "Zip or postal code. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_POSTAL_CODE ;;
  }

  dimension: address_src_postal_code {
    label: "Address Source Postal Code"
    description: "Zip or postal code. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_SRC_POSTAL_CODE ;;
  }

  dimension: address_country {
    label: "Address Country"
    description: "The code used to represent the coUntry. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_COUNTRY ;;
  }

  dimension: address_po_box_flag {
    label: "Address PO Box Flag"
    description: "Flag indicating if this address is a post office box. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_PO_BOX_FLAG ;;
  }

  dimension: address_do_not_verify_flag {
    label: "Address City"
    description: "Any valid zip or postal code. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_DO_NOT_VERIFY_FLAG ;;
  }

  dimension: address_validated_flag {
    label: "Address Vlidated Flag"
    description: "Flag indicating that Rx.com has successfully validated an address record. This field is EPS only!!!"
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS_VALIDATED_FLAG ;;
  }

  dimension_group: source_create_timestamp {
    label: "Address Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }
}

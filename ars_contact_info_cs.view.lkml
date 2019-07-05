view: ars_contact_info_cs {
  label: "Pharmacy"
  sql_table_name: ARS.CONTACT_INFO ;;
  ##  contact info ID is also used as FK to ID in the ars_store_cs view file / ARS.STORES table
  dimension: contact_info_id {
    primary_key: yes
    hidden: yes
    type: number
    description: "Unique ID of the contact info record in the ARS system. Auto-Assigned by the ARS system"
    sql: ${TABLE}.ID ;;
  }

  #####################################################################################   DIMENSIONS  #######################################################################################################


  dimension: pharmacy_address {
    group_label: "Pharmacy Address Info"
    label: "Pharmacy Address"
    description: "The Pharmacy Address as it exists from the ARS source system"
    type: string
    sql: CONCAT(UPPER(${TABLE}.ADDRESS), UPPER(${TABLE}.ADDRESS_LINE_2)) ;;
  }

  dimension: pharmacy_city {
    group_label: "Pharmacy Address Info"
    label: "Pharmacy City"
    description: "The Pharmacy City as it exists from the ARS source system"
    type: string
    sql: UPPER(${TABLE}.CITY) ;;
  }

  dimension: pharmacy_state {
    group_label: "Pharmacy Address Info"
    label: "Pharmacy State"
    description: "The Pharmacy State as it exists from the ARS source system"
    type: string
    sql: ${TABLE}.STATE ;;
  }

  dimension: pharmacy_county {
    group_label: "Pharmacy Address Info"
    label: "Pharmacy County"
    description: "The Pharmacy County as it exists from the ARS source system"
    type: string
    sql: UPPER(${TABLE}.COUNTY) ;;
  }

  dimension: pharmacy_zip_code {
    group_label: "Pharmacy Address Info"
    label: "Pharmacy Postal Code"
    description: "The Pharmacy Postal Code / Zip Code as it exists from the ARS source system"
    type: zipcode
    sql: SUBSTR(${TABLE}.ZIP,1,5) ;;
  }

  dimension: pharmacy_phone_number {
    label: "Pharmacy Phone Number"
    description: "Pharmacy/Store phone number provide by the customer, as it exists in the ARS source system"
    type: number
    sql: ${TABLE}.VOICE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: pharmacy_fax_number {
    label: "Pharmacy Fax Number"
    description: "Pharmacy/Store Fax number provide by the customer, as it exists in the ARS source system"
    type: number
    sql: ${TABLE}.FAX_NUMBER ;;
    value_format: "(###) ###-####"
  }
}

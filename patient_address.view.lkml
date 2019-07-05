view: patient_address {
  sql_table_name: EDW.D_PATIENT_ADDRESS ;;

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

  dimension: id {
    hidden: yes
    description: "Unique ID identifying a patient address record on the Rx.com network"
    type: number
    sql: ${TABLE}.PATIENT_ADDRESS_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${id} ;; #ERXLPS-1649
  }

  dimension: nhin_store_id {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address NHIN Store ID"
    description: "Pharmacy where the patient address record was last touched/updated by"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: care_of {
    # this field is blank for all the chains loaded into EDW as of July 10th 2016
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Care Of"
    description: "Indicates the intermediary who is responsible for accepting the shipment. Input by the user on the Work Queue - Shipping screen "
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_CARE_OF ;;
  }

  dimension: city {
    #       Using Patient Zip Code the city from patient_zip_code file will be exposed so the information is more cleaner as zip_code is loaded from the Commercial Zip Code database, which includes more cleansed information from USPS, Census, IRS.
    #hidden: yes #[ERXLPS-1969] Exposing Patient City from patient_address view.
    group_label: "Central Patient Address Info"
    label: "Central Patient City"
    description: "Patient's City"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_CITY ;;
  }

  dimension: clean_flag {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Clean"
    description: "Y/N Flag that determines if the address has been cleansed according to USPS standards"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_ADDRESS_CLEAN_FLAG = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: country {
    #       Using Patient Zip Code the city from patient_zip_code file will be exposed so the information is more cleaner as zip_code is loaded from the Commercial Zip Code database, which includes more cleansed information from USPS, Census, IRS.
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Country"
    description: "Patient's Country Code"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_COUNTRY ;;
  }

  dimension: county {
    #       Using Patient Zip Code the city from patient_zip_code file will be exposed so the information is more cleaner as zip_code is loaded from the Commercial Zip Code database, which includes more cleansed information from USPS, Census, IRS.
    hidden: yes
    label: "Central Patient County"
    description: "Patient's County"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_COUNTY ;;
  }

  dimension: deactivate_date {
    # This field is hidden as all address which has a deactivation date is not currently displayed to the end user.
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Deactivated Date"
    description: "Date this patient address record was deactivated"
    type: date
    sql: ${TABLE}.PATIENT_ADDRESS_DEACTIVATE_DATE ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_DELETED ;;
  }

  dimension: delivery_site {
    # this field is blank for all the chains loaded into EDW as of July 10th 2016
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Delivery Site"
    description: "Used to track the default delivery site/center that services the patient address record"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_DELIVERY_SITE ;;
  }

  dimension: ending_date {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Ending Date"
    description: "Date that specifies when address will no longer be used"
    type: date
    sql: ${TABLE}.PATIENT_ADDRESS_ENDING_DATE ;;
  }

  dimension: home_phone_number {
    group_label: "Central Patient Phone Info"
    label: "Central Patient Home Phone Number"
    description: "Patient's Home Phone Number"
    type: number
    sql: ${TABLE}.PATIENT_ADDRESS_HOME_PHONE_NUM ;;
    value_format: "(###) ###-####"
  }

  dimension: work_phone_number {
    group_label: "Central Patient Phone Info"
    label: "Central Patient Work Phone Number"
    description: "Patient's Work Phone Number"
    type: number
    sql: ${TABLE}.PATIENT_ADDRESS_WORK_PHONE_NUM ;;
    value_format: "(###) ###-####"
  }

  dimension: identifier {
    # this field is blank for all the chains loaded into EDW as of July 10th 2016
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Identifier"
    description: "Populated with an identifier used to track a given address record."
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_IDENTIFIER ;;
  }

  dimension: address_line1 {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Line 1"
    description: "Contains all of the client's sent address line 1 and address line 2 information"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_LINE1 ;;
  }

  dimension: address_line2 {
    # ADDRESS_LINE2 is not used. For legacy reasons, any received address line 1 and address line 2 information will be concatenated when received and then stored into the ADDRESS_LINE_1 column.  This information will be split again when returned to the client
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Line 2"
    description: "In care of name listed for patient address record"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_LINE2 ;;
  }

  dimension: mail_stop {
    # this field is blank for all the chains loaded into EDW as of July 10th 2016
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Mail Stop"
    description: "Internal mail stop/department"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_MAIL_STOP ;;
  }

  dimension: address_notes1 {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Notes 1"
    description: "Line one of free format note field for address record"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_NOTES1 ;;
  }

  dimension: address_notes2 {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Notes 2"
    description: "Line two of free format note field for address record"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_NOTES2 ;;
  }

  dimension: po_box {
    group_label: "Central Patient Address"
    label: "Central Patient PO Box"
    description: "Y/N Flag indicating if this address is a post office box"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_ADDRESS_PO_BOX = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: zip_code {
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient Zip Code"
    description: "In care of name listed for patient address record"
    type: string
    sql: SUBSTR(${TABLE}.PATIENT_ADDRESS_POSTAL_CODE,1,5) ;;
  }

  dimension: shipping_address {
    group_label: "Central Patient Address Info"
    label: "Central Patient Shipping Address Enabled"
    description: "Y/N Flag indicating ship address is enabled or disabled."
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_ADDRESS_SHIPPING_ADDRESS = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: starting_date {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Starting Date"
    description: "Date that specifies when address will be used"
    type: date
    sql: ${TABLE}.PATIENT_ADDRESS_STARTING_DATE ;;
  }

  dimension: state {
    #       Using Patient Zip Code the city from patient_zip_code file will be exposed so the information is more cleaner as zip_code is loaded from the Commercial Zip Code database, which includes more cleansed information from USPS, Census, IRS.
    hidden: yes
    group_label: "Central Patient Address Info"
    label: "Central Patient State"
    description: "Patient's State"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_STATE ;;
  }

#[ERXDWPS-6646] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: type_reference {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Type"
    description: "Value that represents the type of address record"
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_ADDRESS_TYPE ;;
  }

  dimension: type {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Type"
    description: "Value that represents the type of address record"
    type: string
    sql: etl_manager.fn_get_master_code_desc('PATIENT_ADDRESS_TYPE', ${TABLE}.PATIENT_ADDRESS_TYPE,'N') ;;
    drill_fields: [type_reference]
    suggestions: ["UNKNOWN", "HOME", "SECOND HOME", "WORK", "VACATION", "TEMPORARY", "SCHOOL"]
  }

  dimension: valid_flag {
    group_label: "Central Patient Address Info"
    label: "Central Patient Address Valid"
    description: "Y/N Flag that determines whether address record has been deemed to be a valid address by USPS"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_VALID_FLAG ;;

    case: {
      when: {
        sql: ${TABLE}.PATIENT_ADDRESS_VALID_FLAG = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  # Primarily used only when performing point-in-time analysis and ranking records based on the last_updated information in EPR
  dimension: source_timestamp {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: patient_address_rank {
    # This field would be used in joins to pick the latest address information of the patient based on the address type.
    hidden: yes
    type: string
    # PATIENT_ADDRESS_TYPE is not referenced with ${} due to performance reasons
    sql: ROW_NUMBER() OVER (PARTITION BY ${chain_id},${rx_com_id} ORDER BY CASE WHEN PATIENT_ADDRESS_TYPE = 1 THEN -1 END,${source_timestamp} DESC) ;;
  }

  measure: patient_address_count {
    label: "Central Patient Address Count"
    description: "Total Patient's address"
    type: count
  }
}

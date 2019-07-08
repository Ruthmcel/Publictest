view: prescriber {
  sql_table_name: EDW.D_PRESCRIBER ;;

  dimension: chain_id {
    label: "Prescriber Chain ID"
    description: "Prescriber Chain ID"
    hidden: yes #[ERXLPS-2045] chiain_id exposed from chain view
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Prescriber NHIN Store ID"
    description: "Prescriber NHIN Store ID"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.prescriber_id ;;
  }

  dimension: npi_number {
    label: "Prescriber NPI Number"
    description: "Prescriber's National Provider ID"
    sql: ${TABLE}.PRESCRIBER_NPI_NUMBER ;;
  }

  dimension: dea_number {
    label: "Prescriber DEA Number"
    description: "Prescriber's Drug Enforcement Agency number"
    sql: ${TABLE}.PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: npi_number_deidentified {
    label: "Prescriber NPI Number"
    description: "Prescriber's National Provider ID"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.PRESCRIBER_NPI_NUMBER) ;;
  }

  dimension: dea_number_deidentified {
    label: "Prescriber DEA Number"
    description: "Prescriber's Drug Enforcement Agency number"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.PRESCRIBER_DEA_NUMBER) ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: NVL(${npi_number},${dea_number}) ;;
  }

  #[ERXDWPS-8047] - Updated tool tip.
  dimension: address {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address"
    description: "Prescriber Address - Line 1. Street name and number for this prescriber."
    sql: ${TABLE}.PRESCRIBER_ADDRESS ;;
  }

  dimension: phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Phone"
    description: "Prescriber's telephone number"
    sql: ${TABLE}.PRESCRIBER_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: fax_phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Fax Phone"
    description: "Prescriber's fax phone number"
    sql: ${TABLE}.PRESCRIBER_FAX_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  #[ERXDWPS-8047] - Updated label and tool tip.
  dimension: address1 {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address - Line 2"
    description: "Prescriber Address - Line 2. Will contain additional information about the address when appropriate."
    sql: ${TABLE}.PRESCRIBER_ADDRESS1 ;;
  }

  dimension: city {
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_CITY ;;
  }

  dimension: country {
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_COUNTRY ;;
  }

  dimension: cpm_identifier {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber CPM Identifier"
    description: "CPM Identifier will store the Central Prescriber ID associated with the prescriber record that was linked to the prescription"
    sql: ${TABLE}.PRESCRIBER_CPM_IDENTIFIER ;;
  }

  dimension: name {
    label: "Prescriber Name"
    description: "Prescriber name (Last name, First name)"
    sql: ${TABLE}.PRESCRIBER_NAME ;;
  }

  dimension: name_deidentified {
    label: "Prescriber Name"
    description: "Prescriber name (Last name, First name)"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.PRESCRIBER_NAME) ;;
  }

  dimension: first_name {
    label: "Prescriber First Name"
    description: "Prescriber's first name"
    sql: ${TABLE}.PRESCRIBER_FIRST_NAME ;;
  }

  dimension: last_name {
    label: "Prescriber Last Name"
    description: "Prescriber's last name"
    sql: ${TABLE}.PRESCRIBER_LAST_NAME ;;
  }

  dimension: middle_name {
    label: "Prescriber Middle Name"
    description: "Prescriber's middle name"
    sql: ${TABLE}.PRESCRIBER_MIDDLE_NAME ;;
  }

  dimension: hcid {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber HCID"
    description: "HCID will store the HCID associated with the prescriber record that was linked to the RX_TX"
    sql: ${TABLE}.PRESCRIBER_HCID ;;
  }

  dimension: hms_identifier {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber HMS ID"
    description: "HCIdea prescriber ID managed by NCPDP"
    sql: ${TABLE}.PRESCRIBER_HMS_IDENTIFIER ;;
  }

  dimension: state {
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_STATE ;;
  }

  dimension: state_id_number {
    label: "Prescriber State ID Number"
    description: "ID issued by the state for a prescriber"
    sql: ${TABLE}.PRESCRIBER_STATE_ID_NUMBER ;;
  }

  dimension: zip_code {
    hidden: yes
    type: zipcode
    sql: ${TABLE}.PRESCRIBER_ZIP_CODE ;;
  }

  dimension: deleted {
    label: "Prescriber Deleted"
    description: "Flag that determines whether a Prescriber record has been set to deleted"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_DELETED ;;
  }

  measure: count {
    label: "Prescriber Count"
    description: "Total Prescribers"
    type: number
    sql: COUNT(DISTINCT(NVL(${npi_number},${dea_number}))) ;;
    value_format: "#,##0"
  }

  dimension: data_waived_prescriber {
    label: "Data Waived Prescriber"
    description: "Yes/No Flag that indicates if the Prescriber has a Data Waived DEA Number, that begins with an X."
    type: yesno
    sql: UPPER(SUBSTR(${dea_number}, 1, 1)) = 'X' ;;
  }
}

view: bi_demo_prescriber {
  sql_table_name: EDW.D_PRESCRIBER ;;
  ## [ERXLPS-201] - All Fields in this view (except for PK and FK) reference the bi_demo_prescriber_unique_view. When any dimension or measure is chosen from a look, the join to the bi_demo_prescriber_unique view will occur.

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.prescriber_id ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    label: "Prescriber Chain ID"
    #hidden: true
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Prescriber NHIN Store ID"
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  ## [ERXLPS-201] - This is needed in order to uniquely join with the bi_demo_prescriber_unique view
  dimension: prescriber_key {
    hidden: yes
    type: string
    sql: ${TABLE}.CHAIN_ID ||'@'|| NVL(${TABLE}.PRESCRIBER_NPI_NUMBER, '#@@#') ||'@'|| NVL(${TABLE}.PRESCRIBER_DEA_NUMBER, '#@@#') ||'@'|| NVL(SUBSTR(${TABLE}.PRESCRIBER_FIRST_NAME, 1, 1), '#@@#') ||'@'|| NVL(${TABLE}.PRESCRIBER_LAST_NAME, '#@@#') ||'@'|| NVL(${TABLE}.PRESCRIBER_ZIP_CODE, '#@@#') ;;
  }

  #################################################################################################### DIMENSIONS ####################################################################################

  dimension: npi_number {
    label: "Prescriber NPI Number"
    description: "Prescriber's National Provider ID"
    sql: ${bi_demo_prescriber_unique.npi_number} ;;
  }

  dimension: dea_number {
    label: "Prescriber DEA Number"
    description: "Prescriber's Drug Enforcement Agency number"
    sql: ${bi_demo_prescriber_unique.dea_number} ;;
  }

  dimension: unique_key {
    hidden: yes
    sql: NVL(${TABLE}.PRESCRIBER_NPI_NUMBER,${TABLE}.PRESCRIBER_DEA_NUMBER) ;;
  }

  #[ERXDWPS-8047] - Updated tool tip.
  dimension: address {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address"
    description: "Prescriber Address - Line 1. Street name and number for this prescriber."
    sql: ${bi_demo_prescriber_unique.address} ;;
  }

  dimension: phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Phone"
    description: "Prescriber's telephone number"
    sql: ${bi_demo_prescriber_unique.phone} ;;
    value_format: "(###) ###-####"
  }

  dimension: fax_phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Fax Phone"
    description: "Prescriber's fax phone number"
    sql: ${bi_demo_prescriber_unique.fax_phone} ;;
    value_format: "(###) ###-####"
  }

  dimension: address1 {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address - Line 2"
    description: "Prescriber Address - Line 2. Will contain additional information about the address when appropriate."
    sql: ${bi_demo_prescriber_unique.address1} ;;
  }

  dimension: city {
    hidden: yes
    sql: ${bi_demo_prescriber_unique.city} ;;
  }

  dimension: country {
    hidden: yes
    sql: ${bi_demo_prescriber_unique.country} ;;
  }

  dimension: cpm_identifier {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber CPM Identifier"
    description: "CPM Identifier will store the Central Prescriber ID associated with the prescriber record that was linked to the prescription"
    sql: ${bi_demo_prescriber_unique.cpm_identifier} ;;
  }

  dimension: name {
    label: "Prescriber Name"
    description: "Prescriber name (Last name, First name)"
    sql: ${bi_demo_prescriber_unique.name} ;;
  }

  dimension: first_name {
    label: "Prescriber First Name"
    description: "Prescriber's first name"
    sql: ${bi_demo_prescriber_unique.first_name} ;;
  }

  dimension: last_name {
    label: "Prescriber Last Name"
    description: "Prescriber's last name"
    sql: ${bi_demo_prescriber_unique.last_name} ;;
  }

  dimension: middle_name {
    label: "Prescriber Middle Name"
    description: "Prescriber's middle name"
    sql: ${bi_demo_prescriber_unique.middle_name} ;;
  }

  dimension: hcid {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber HCID"
    description: "HCID will store the HCID associated with the prescriber record that was linked to the RX_TX"
    sql: ${bi_demo_prescriber_unique.hcid} ;;
  }

  dimension: hms_identifier {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber HMS ID"
    description: "HCIdea prescriber ID managed by NCPDP"
    sql: ${bi_demo_prescriber_unique.hms_identifier} ;;
  }

  dimension: state {
    hidden: yes
    sql: ${bi_demo_prescriber_unique.state} ;;
  }

  dimension: state_id_number {
    label: "Prescriber State ID Number"
    description: "ID issued by the state for a prescriber"
    sql: ${bi_demo_prescriber_unique.state_id_number} ;;
  }

  dimension: zip_code {
    hidden: yes
    type: zipcode
    sql: ${bi_demo_prescriber_unique.zip_code} ;;
  }

  dimension: deleted {
    label: "Prescriber Deleted"
    description: "Flag that determines whether a Prescriber record has been set to deleted"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_DELETED ;;
  }

  dimension: data_waived_prescriber {
    label: "Data Waived Prescriber"
    description: "The Prescribers Data Waived DEA Number that begins with an X. The Prescriber may also have another record that is not Data Waived."
    type: yesno
    sql: UPPER(SUBSTR(${bi_demo_prescriber_unique.dea_number}, 1, 1)) = 'X' ;;
  }

  #################################################################################################### MEASURES ####################################################################################

  measure: count {
    label: "Prescriber Count"
    description: "Total Prescribers"
    type: number
    sql: COUNT(DISTINCT(${bi_demo_prescriber_unique.prescriber_key})) ;;
    value_format: "#,##0"
    drill_fields: [prescriber_info*]
  }

  #################################################################################################### SETS ####################################################################################

  set: prescriber_info {
    fields: [
      name,
      npi_number,
      address,
      city,
      state,
      zip_code,
      phone,
      fax_phone,
      state_id_number,
      dea_number
    ]
  }
}

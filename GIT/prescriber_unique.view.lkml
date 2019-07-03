view: prescriber_unique {
  ## 1) This view file selects Unique Records from the PRESCRIBER table based on (1) CHAIN_ID, NPI, DEA, FIRST_NAME (first initial), LAST_NAME, ZIP_CODE (Reason for uniqueness level: There are records with NULL NPI and DEA tied to transactions)
  ## 2) The JOIN that is defined with the existing PRESCRIBER table ensures that all records are selected. Any further grouping an attempting to join to the PRESCRIBER table would loose records, and subsequently transactions.

  ## 3)  ALL FIELDS IN THIS VIEW ARE HIDDEN. The Prescriber VIEW references all the fields in this view, from the Prescriber VIEW file. THe JOIN is enforced when dimensions and measures are chosen. This Design was implemented so that any current/legacy reports using that view would not be broken.

  derived_table: {
    sql: SELECT CHAIN_ID
          , NHIN_STORE_ID
          , PRESCRIBER_NPI_NUMBER
          , PRESCRIBER_FIRST_NAME
          , PRESCRIBER_MIDDLE_NAME
          , PRESCRIBER_LAST_NAME
          , PRESCRIBER_NAME
          , PRESCRIBER_ADDRESS
          , PRESCRIBER_ADDRESS1
          , PRESCRIBER_CITY
          , PRESCRIBER_STATE
          , PRESCRIBER_SRC_ZIP_CODE
          , PRESCRIBER_ZIP_CODE
          , PRESCRIBER_COUNTRY
          , PRESCRIBER_PHONE_NUMBER
          , PRESCRIBER_FAX_PHONE_NUMBER
          , PRESCRIBER_DEA_NUMBER
          , PRESCRIBER_STATE_ID_NUMBER
          , PRESCRIBER_HCID
          , PRESCRIBER_HMS_IDENTIFIER
          , PRESCRIBER_CPM_IDENTIFIER
      FROM  (
              SELECT CHAIN_ID, NHIN_STORE_ID, PRESCRIBER_NPI_NUMBER  , PRESCRIBER_FIRST_NAME , PRESCRIBER_MIDDLE_NAME , PRESCRIBER_LAST_NAME , PRESCRIBER_NAME , PRESCRIBER_ADDRESS , PRESCRIBER_ADDRESS1 , PRESCRIBER_CITY , PRESCRIBER_STATE , PRESCRIBER_SRC_ZIP_CODE , PRESCRIBER_ZIP_CODE , PRESCRIBER_COUNTRY , PRESCRIBER_PHONE_NUMBER , PRESCRIBER_FAX_PHONE_NUMBER , PRESCRIBER_DEA_NUMBER , PRESCRIBER_STATE_ID_NUMBER , PRESCRIBER_HCID , PRESCRIBER_HMS_IDENTIFIER , PRESCRIBER_CPM_IDENTIFIER
              FROM (
                      SELECT P.CHAIN_ID, P.NHIN_STORE_ID, PRESCRIBER_NPI_NUMBER  , PRESCRIBER_FIRST_NAME , PRESCRIBER_MIDDLE_NAME , PRESCRIBER_LAST_NAME , PRESCRIBER_NAME , PRESCRIBER_ADDRESS , PRESCRIBER_ADDRESS1 , PRESCRIBER_CITY , PRESCRIBER_STATE , PRESCRIBER_SRC_ZIP_CODE , PRESCRIBER_ZIP_CODE , PRESCRIBER_COUNTRY , PRESCRIBER_PHONE_NUMBER , PRESCRIBER_FAX_PHONE_NUMBER , PRESCRIBER_DEA_NUMBER , PRESCRIBER_STATE_ID_NUMBER , PRESCRIBER_HCID , PRESCRIBER_HMS_IDENTIFIER , PRESCRIBER_CPM_IDENTIFIER
                              , ROW_NUMBER () OVER (PARTITION BY P.CHAIN_ID, PRESCRIBER_NPI_NUMBER, PRESCRIBER_DEA_NUMBER, SUBSTR(PRESCRIBER_FIRST_NAME, 1, 1),  PRESCRIBER_LAST_NAME, PRESCRIBER_ZIP_CODE ORDER BY P.SOURCE_TIMESTAMP DESC) RNK
                      FROM EDW.D_PRESCRIBER P
                      WHERE PRESCRIBER_DELETED = 'N'
                        AND {% condition chain.chain_id %} P.CHAIN_ID {% endcondition %}
               ) WHERE RNK = 1
        )
       ;;
  }

  dimension: prescriber_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| NVL(${npi_number}, '#@@#') ||'@'|| NVL(${dea_number}, '#@@#') ||'@'|| NVL(SUBSTR(${first_name}, 1, 1), '#@@#') ||'@'|| NVL(${last_name}, '#@@#') ||'@'|| NVL(${zip_code}, '#@@#') ;;
  }

  dimension: chain_id {
    label: "Prescriber Chain ID"
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: npi_number {
    label: "Prescriber NPI Number"
    description: "Prescriber's National Provider ID"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_NPI_NUMBER ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: nhin_store_id {
    label: "Prescriber NHIN Store ID"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  #################################################################################################### DIMENSIONS ####################################################################################

  ##########  DEMOGRAPHIC DIMENSIONS ##########

  dimension: name {
    label: "Prescriber Name"
    description: "Prescriber name (Last name, First name)"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_NAME ;;
  }

  dimension: first_name {
    label: "Prescriber First Name"
    description: "Prescriber's first name"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_FIRST_NAME ;;
  }

  dimension: last_name {
    label: "Prescriber Last Name"
    description: "Prescriber's last name"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_LAST_NAME ;;
  }

  dimension: middle_name {
    label: "Prescriber Middle Name"
    description: "Prescriber's middle name"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_MIDDLE_NAME ;;
  }

  dimension: state_id_number {
    label: "Prescriber State ID Number"
    description: "ID issued by the state for a prescriber"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_STATE_ID_NUMBER ;;
  }

  dimension: dea_number {
    label: "Prescriber DEA Number"
    description: "Prescriber's Drug Enforcement Agency number"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_DEA_NUMBER ;;
  }

  ##########  ADDRESS GROUP DIMENSIONS ##########

  dimension: address {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address"
    description: "Address contains all address from line 1. Addresses can contain a second line of information"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_ADDRESS ;;
  }

  dimension: address1 {
    group_label: "Prescriber Address Info"
    label: "Prescriber Address 2nd Line"
    description: "The second Address line of the prescriber address record."
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_ADDRESS1 ;;
  }

  dimension: city {
    group_label: "Prescriber Address Info"
    label: "Prescriber City"
    description: "The City that the Prescriber Address resides in"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_CITY ;;
  }

  dimension: state {
    group_label: "Prescriber Address Info"
    label: "Prescriber State"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_STATE ;;
  }

  dimension: zip_code {
    group_label: "Prescriber Address Info"
    label: "Prescriber Zip Code"
    type: zipcode
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_ZIP_CODE ;;
  }

  dimension: phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Phone"
    description: "Prescriber's telephone number"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: fax_phone {
    type: number
    group_label: "Prescriber Address Info"
    label: "Prescriber Fax Phone"
    description: "Prescriber's fax phone number"
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_FAX_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: country {
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_COUNTRY ;;
  }

  ########## OTHER DIMENSIONS ##########

  dimension: cpm_identifier {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescriber CPM Identifier"
    description: "CPM Identifier will store the Central Prescriber ID associated with the prescriber record that was linked to the prescription"
    sql: ${TABLE}.PRESCRIBER_CPM_IDENTIFIER ;;
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
}

#################################################################################################### MEASURES ####################################################################################

#################################################################################################### SETS ####################################################################################

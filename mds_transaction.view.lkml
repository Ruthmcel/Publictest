view: mds_transaction {
  sql_table_name: EDW.F_TRANSACTION ;;

  dimension: transaction_id {
    label: "Transaction ID"
    # Foreign Key to mds_transaction view
    description: "Unique ID number identifying a transaction record in MDS"
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  dimension: transaction_patient_address {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient Address"
    description: "Address on the patient profile sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_ADDRESS ;;
  }

  dimension: transaction_patient_address2 {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient Address 2"
    description: "Address on the patient profile sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_ADDRESS2 ;;
  }

  dimension: transaction_patient_city {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient City"
    description: "Patient City on the patient profile sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_CITY ;;
  }

  # State is not hidden as this the chances of identifiying a patient information or a patient using state has less risk. Currently exposing this field if geographical analysis is required to be performed on State. If not required, this field can also be hidden
  dimension: transaction_patient_state {
    label: "Transaction Patient State"
    description: "Patient State on the patient profile sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_STATE ;;
  }

  dimension: transaction_patient_postal_code {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient Zip Code"
    description: "Patient Zip Code on the patient profile sent to MDS in a PrintDocumentRequest"
    type: zipcode
    sql: ${TABLE}.TRANSACTION_POSTAL_CODE ;;
  }

  dimension: transaction_patient_rx_com_id_deidentified {
    label: "Transaction Patient ID"
    description: "Patient unique identifier sent to MDS in a PrintDocumentRequest"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: CASE WHEN TRANSACTION_RX_COM_ID IS NOT NULL THEN SHA2(CONCAT(${TABLE}.CHAIN_ID,${TABLE}.TRANSACTION_RX_COM_ID)) ELSE SHA2(CONCAT(CONCAT(${TABLE}.CHAIN_ID,${TABLE}.NHIN_STORE_ID),${TABLE}.TRANSACTION_PATIENT_CODE)) END ;;
  }

  dimension: transaction_patient_code {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient Code"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_CODE ;;
  }

  dimension: transaction_patient_md5_sum {
    #  Sha256 is more reliable cryptographic hashing and hence a new transaction_patient_rx_com_id_sha2 is created which replaces transaction_patient_md5_sum and additionally the sha256 is applied at chain+rx_com_id combination so it is unique at the enterprise level
    hidden: yes
    label: "Transaction Patient MD5SUM Value"
    type: string
    sql: ${TABLE}.TRANSACTION_PATIENT_MD5SUM ;;
  }

  dimension_group: transaction_patient_birth {
    # Patient Identifiable Information with regard to Manufacturers/Pharma is not exposed
    hidden: yes
    label: "Transaction Patient DOB"
    description: "Patient Date of Birth on the patient profile sent to MDS in a PrintDocumentRequest"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      day_of_week,
      day_of_month
    ]
    sql: ${TABLE}.TRANSACTION_DOB ;;
  }

  # Age is not hidden as the chances of identifiying a patient information or a patient using age has less risk
  dimension: transaction_age {
    label: "Transaction Patient Age"
    description: "Patient's Age sent to MDS in a PrintDocumentRequest"
    type: number
    sql: (DATEDIFF('DAY',${transaction_patient_birth_date},CURRENT_DATE)/365.25) ;;
  }

  # Age Tiering is not hidden as the chances of identifiying a patient information with patient age grouping has very less risk
  dimension: transaction_age_tier {
    type: tier
    sql: ${transaction_age} ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      10,
      20,
      30,
      40,
      50,
      60,
      70,
      80
    ]
    style: integer
  }

  dimension: transaction_gender {
    label: "Transaction Patient Gender"
    description: "Patient Gender on the patient profile sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_GENDER ;;
  }

  dimension: gpi {
    label: "Transaction GPI"
    description: "Generic Product Identifier sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_GPI ;;
  }

  #   - dimension: transaction_confirmed_gpi
  #     type: string
  #     sql: ${TABLE}.TRANSACTION_CONFIRMED_GPI

  dimension: ndc {
    label: "Transaction NDC"
    description: "National Drug Code Identifier sent to MDS in a PrintDocumentRequest"
    type: string
    sql: ${TABLE}.TRANSACTION_NDC ;;
  }

  dimension: rx_number_deidentified {
    label: "Prescription Number"
    description: "Prescription Number sent to MDS in a PrintDocumentRequest"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(CONCAT(${TABLE}.CHAIN_ID,${TABLE}.TRANSACTION_RX_NUMBER)) ;;
  }

  dimension: rx_number {
    hidden: yes
    label: "Prescription Number"
    description: "Prescription Number sent to MDS in a PrintDocumentRequest"
    type: string
    # rx_number without sha256 is still used in this view file because, this is used for joining to the dispensing data
    sql: ${TABLE}.TRANSACTION_RX_NUMBER ;;
  }

  dimension: tx_number {
    label: "Transaction Number"
    description: "Transaction Number sent to MDS in a PrintDocumentRequest"
    type: number
    sql: ${TABLE}.TRANSACTION_TX_NUMBER ;;
    value_format: "####"
  }

  dimension: transaction_refill_number {
    label: "Prescription Refill Number"
    description: "Prescription Refill Number sent to MDS in a PrintDocumentRequest"
    type: number
    sql: ${TABLE}.TRANSACTION_REFILL_NUMBER ;;
  }

  dimension: transaction_refills_remaining {
    label: "Transaction Refills Remaining"
    type: number
    sql: ${TABLE}.TRANSACTION_REFILLS_REMAINING ;;
  }

  dimension: transaction_days_supply {
    label: "Transaction Days Supply"
    description: "Rx Tx Days Supply sent to MDS in a PrintDocumentRequest"
    type: number
    sql: ${TABLE}.TRANSACTION_DAYS_SUPPLY ;;
  }

  dimension: transaction_previous_days_supply {
    label: "Transaction Previous Days Supply"
    description: "Previous Rx Tx Days Supply sent to MDS in a PrintDocumentRequest"
    type: number
    sql: ${TABLE}.TRANSACTION_PREVIOUS_DAYS_SUPPLY ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: transaction_request {
    label: "Transaction Request"
    description: "Identifies when the transaction was sent to MDS in a PrintDocumentRequest"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TRANSACTION_REQUEST_DATE ;;
  }

  dimension_group: transaction_previous_fill {
    label: "Transaction Previous Fill"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.TRANSACTION_PREVIOUS_FILL_DATE ;;
  }

  ################################################################################################## Meta Data Dimension #################################################################################################

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ################################################################################################## Measure #################################################################################################

  measure: count {
    label: "PE / POD Activity"
    description: "This is a count of activity from PDX-MS Pre Edit and / or PDX-MS Print On Demand occurences at Pharmacies actively utilizing PDX-MS Programs."
    type: count
    drill_fields: [
      mds_program.program_code,
      mds_program.program_description,
      mds_transaction.transaction_request_time,
      drug.drug_ndc,
      drug.drug_full_name,
      drug.drug_manufacturer,
      mds_transaction.count
    ]
  }

  measure: transaction_drug_acq {
    label: "Transaction Drug ACQ"
    description: "Drug Acquistion Cost"
    type: sum
    sql: ${TABLE}.TRANSACTION_DRUG_ACQ ;;
  }

  measure: transaction_drug_awp {
    label: "Transaction Drug AWP"
    description: "Drug Average Wholesale Price"
    type: sum
    sql: ${TABLE}.TRANSACTION_DRUG_AWP ;;
  }

  measure: transaction_patient_pay_amount {
    label: "Transaction Patient Pay Amount"
    type: sum
    sql: ${TABLE}.TRANSACTION_PATIENT_PAY_AMOUNT ;;
  }

  measure: transaction_price {
    label: "Transaction Prescription Price"
    type: sum
    sql: ${TABLE}.TRANSACTION_PRICE ;;
  }
}

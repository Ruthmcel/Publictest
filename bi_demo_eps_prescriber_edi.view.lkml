view: bi_demo_eps_prescriber_edi {
  label: "eScript"
  sql_table_name: EDW.F_PRESCRIBER_EDI ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${prescriber_edi_id} ;;
  }
##################FOREIGN KEY REFRENCES##################

  dimension: chain_id {
    label: "Chain Id"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: prescriber_edi_id {
    label: "eScript Id"
    description: "Unique ID number identifying each record in this table"
    type: number
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_EDI_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: line_item_id {
    label: "Line Item Id"
    description: "Workflow line item that each record is associated with"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

##################DIMENSIONS##################

  dimension: prescriber_edi_message_type {
    label: "eScript Message Type"
    description: "Type of message that represents eScript record"
    type: string
    case: {
      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE = 'NEWRX' ;;
        label: "NEW PRESCRIPTION MESSAGE"
      }

      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE = 'REFRES' ;;
        label: "REFILL RESPONSE MESSAGE"
      }

      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE = 'CANRX' ;;
        label: "CANCEL PRESCRIPTION MESSAGE"
      }

      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE = 'VERIFY' ;;
        label: "VERIFICATION MESSAGE"
      }

      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE = 'ERROR' ;;
        label: "ERROR MESSAGE"
      }

      when: {
        sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE IS NULL ;;
        label: "NOT SPECIFIED"
      }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_MESSAGE_TYPE') ;;
  }

  dimension: prescriber_edi_message_type_filter {
    label: "eScript Message Type"
    description: "Type of message that represents eScript record"
    type: string
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_TYPE ;;
  }

  dimension_group: prescriber_edi_received {
    label: "eScript Received"
    description: "Date/Time eScript message/record was received. If the message was sent from EPS, then this can be null"
    type: time
    sql: ${TABLE}.PRESCRIBER_EDI_RECEIVED_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_approved {
    label: "eScript Approved"
    description: "Indicates if the doctor approved a Refill Request"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_APPROVED IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_APPROVED = 'A' ;; label: "APPROVED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_APPROVED = 'D' ;; label: "DENIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_APPROVED = 'C' ;; label: "APPROVED WITH CHANGES" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_APPROVED = 'N' ;; label: "DENIED NEW RX TO FOLLOW" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_APPROVED AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_APPROVED') ;;
  }

  dimension: prescriber_edi_status_type {
    label: "eScript Status Type"
    description: "Actual status type received in a STATUS message"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '000' ;; label: "TRANSACTION SUCCESSFUL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '001' ;; label: "TRANSACTION SUCCESSFUL, MESSAGES WAITING" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '002' ;; label: "NO MORE MESSAGES" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '003' ;; label: "TRANSACTION SUCCESSFUL, NO MESSAGES" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '005' ;; label: "TRANSACTION SUCCESSFUL, PASSWORD TO EXPIRE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '010' ;; label: "SUCCESSFUL, ACCEPTED BY RECEIVER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '600' ;; label: "COMMUNICATION PROBLEM" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '601' ;; label: "UNABLE TO PROCESS" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '602' ;; label: "SYSTEM ERROR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_STATUS_TYPE = '900' ;; label: "TRANSACTION REJECTED" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_STATUS_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_STATUS_TYPE') ;;
  }

  dimension: prescriber_edi_status_code {
    label: "eScript Status Code"
    description: "This is the reject code used by the responder taking responsibility for the transaction. This value is received in the code list qualifier of the STATUS message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_STATUS_CODE ;;
  }

  dimension: prescriber_edi_status_free_form {
    label: "eScript Status Free Form"
    description: "Actual text received in the Free Text field of a STATUS message"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_STATUS_FREE_FORM) ;;
  }

  dimension: prescriber_edi_clinic_reference_number {
    label: "eScript Clinic Reference Number"
    description: "Transaction Control Reference received in a SCRIPT message's UIB segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_CLINIC_REFERENCE_NUMBER) ;;
  }

  dimension: prescriber_edi_prescriber_first_name {
    label: "eScript Prescriber First Name"
    description: "Prescriber's first name as received in SCRIPT message PVD segment."
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_FIRST_NAME) ;;
  }

  dimension: prescriber_edi_prescriber_last_name {
    label: "eScript Prescriber Last Name"
    description: "Prescriber's last name as received in SCRIPT message PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_LAST_NAME) ;;
  }

  dimension: prescriber_edi_prescriber_id_number_1 {
    label: "eScript Prescriber ID Number 1"
    description: "Reference Number received in PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_1) ;;
  }

  dimension: prescriber_edi_prescriber_id_number_qualifier_1 {
    label: "eScript Prescriber ID Number Qualifier 1"
    description: "Reference Qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '1G' ;; label: "UPIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 = '0B' ;; label: "STATE LICENSE NUMBER" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_1') ;;
  }

  dimension: prescriber_edi_prescriber_id_number_2 {
    label: "eScript Prescriber ID Number 2"
    description: "Reference Number received in PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_2) ;;
  }

  dimension: prescriber_edi_prescriber_id_number_qualifier_2 {
    label: "eScript Prescriber ID Number Qualifier 2"
    description: "Reference Qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '1G' ;; label: "UPIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 = '0B' ;; label: "STATE LICENSE NUMBER" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_2') ;;
  }

  dimension: prescriber_edi_prescriber_phone_1 {
    label: "eScript Prescriber Phone 1"
    description: "Prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_1) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_prescriber_phone_qualifier_1 {
    label: "eScript Prescriber Phone Qualifier 1"
    description: "Prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_1') ;;
  }

  dimension: prescriber_edi_prescriber_phone_2 {
    label: "eScript Prescriber Phone 2"
    description: "Prescriber's phone number qualifier received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_2) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_prescriber_phone_qualifier_2 {
    label: "eScript Prescriber Phone Qualifier 2"
    description: "Prescriber's phone number qualifier received in the PVD segment"
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_2') ;;
    type: string
  }

  dimension: prescriber_edi_patient_last_name {
    label: "eScript Patient Last Name"
    description: "Identifies the last name of the patient for which this eScript is for"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_LAST_NAME) ;;
  }

  dimension: prescriber_edi_patient_first_name {
    label: "eScript Patient First Name"
    description: "This is the first name of the patient for which this prescription is for"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_FIRST_NAME) ;;
  }

  dimension_group: prescriber_edi_patient_birth {
    label: "eScript Patient Birth"
    description: "This is the patient's date of birth as received in the eScript message"
    type: time
    hidden: yes
    sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_BIRTH_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_patient_phone {
    label: "eScript Patient Phone"
    description: "Patient's phone number as received in the PTT segment from a SCRIPT message"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_patient_gender {
    label: "eScript Patient Gender"
    description: "Identifies the gender of the patient for which the prescription belongs to"
    type: string
    hidden: yes
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_GENDER IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_GENDER = 'M' ;; label: "MALE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_GENDER = 'F' ;; label: "FEMALE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_GENDER = 'U' ;; label: "UNKNOWN" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PATIENT_GENDER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PATIENT_GENDER') ;;
  }

  dimension: prescriber_edi_item_description_1 {
    label: "eScript Item Description 1"
    description: "Item desc (drug name) from DRU segment"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_ITEM_DESCRIPTION_1 ;;
  }

  dimension: prescriber_edi_drug_strength {
    label: "eScript Drug Strength"
    description: "As received from the DRU segment, this is a measurement value of the drug's strength"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_DRUG_STRENGTH ;;
  }

  dimension: prescriber_edi_days_supply {
    label: "eScript Days Supply"
    description: "This qualifier indicates Days Supply for the prescription as received from the DRU segment when the date/time period qualifier is equal to 'ZDS'"
    type: number
    sql: ${TABLE}.PRESCRIBER_EDI_DAYS_SUPPLY ;;
  }

  dimension: prescriber_edi_refills_authorized {
    label: "eScript Refills Authorized"
    description: "Specifies the amount of refills authorized for this prescription"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_REFILLS_AUTHORIZED ;;
  }

  dimension_group: prescriber_edi_written {
    label: "eScript Written"
    description: "This qualifier indicates that the date is the written date for the prescription as received from the DRU segment when the date/time period qualifier is equal to: '85'"
    type: time
    sql: ${TABLE}.PRESCRIBER_EDI_WRITTEN_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_sig_text {
    label: "eScript SIG Text"
    description: "SIG text as received from the DRU segment"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SIG_TEXT ;;
  }

  dimension: prescriber_edi_daw {
    label: "eScript DAW"
    description: "This is the dispense as written directions provided for the eScript by the prescriber"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '0' ;; label: "NO SELECTION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '1' ;; label: "SUBSTITUTION NOT ALLOWED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '2' ;; label: "SUBSTITUTION ALLOWED- PATIENT REQUESTED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '3' ;; label: "SUBSTITUTION ALLOWED- PHARMACIST SELECTED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '4' ;; label: "SUBSTITUTION ALLOWED- GENERIC NOT IN STOCK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '5' ;; label: "SUBSTITUTION ALLOWED- BRAND AS GENERIC" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '7' ;; label: "SUBSTITUTION NOT ALLOWED- BRAND MANDATED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DAW = '8' ;; label: "SUBSTITUTION ALLOWED- GENERIC NOT AVAILABLE" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_DAW AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_DAW') ;;
  }

  dimension: prescriber_edi_prescriber_message {
    label: "eScript Prescriber Message"
    description: "Free form prescriber message that was receivd in a DRU segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_MESSAGE) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_first_name {
    label: "eScript Supervising Prescriber First Name"
    description: "Supervising prescriber's first name as received from the PVD segment in eScript Messages"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_FIRST_NAME) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_last_name {
    label: "eScript Supervising Prescriber Last Name"
    description: "Supervising prescriber's last name as received from the PVD segment in eScript Messages"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_LAST_NAME) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_1 {
    label: "eScript Supervising Prescriber Number 1"
    description: "Prescriber's actual ID Number as received from the PVD segment of eScript messages"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_1) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_qualifier_1 {
    label: "eScript Supervising Prescriber Number Qualifier 1"
    description: "Qualifier for the Prescriber ID Number as received from the PVD segment of eScript messages"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '1G' ;; label: "UPIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 = '0B' ;; label: "STATE LICENSE NUMBER" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_1') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_2 {
    label: "eScript Supervising Prescriber Number 2"
    description: "Prescriber's actual ID Number as received from the PVD segment of eScript messages"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_2) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_qualifier_2 {
    label: "eScript Supervising Prescriber Number Qualifier 2"
    description: "Qualifier for the Prescriber ID Number as received from the PVD segment of eScript messages"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '1G' ;; label: "UPIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 = '0B' ;; label: "STATE LICENSE NUMBER" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_2') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_phone_1 {
    label: "eScript Supervising Prescriber Phone 1"
    description: "Supervising prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_1) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_supervising_prescriber_phone_qualifier_1 {
    label: "eScript Supervising Prescriber Phone Qualifier 1"
    description: "Supervising prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_1') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_phone_2 {
    label: "eScript Supervising Prescriber Phone 2"
    description: "Supervising prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_2) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_supervising_prescriber_phone_qualifier_2 {
    label: "eScript Supervising Prescriber Phone Qualifier 2"
    description: "Supervising prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_2') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_phone_3 {
    label: "eScript Supervising Prescriber Phone 3"
    description: "Supervising prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_3) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_supervising_prescriber_phone_qualifier_3 {
    label: "eScript Supervising Prescriber Phone Qualifier 3"
    description: "Supervising prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_3') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_phone_4 {
    label: "eScript Supervising Prescriber Phone 4"
    description: "Supervising prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_4) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_supervising_prescriber_phone_qualifier_4 {
    label: "eScript Supervising Prescriber Phone Qualifier 4"
    description: "Supervising prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_PHONE_QUALIFIER_4') ;;
  }

  dimension: prescriber_edi_prescriber_phone_3 {
    label: "eScript Prescriber Phone 3"
    description: "Prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_3) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_prescriber_phone_qualifier_3 {
    label: "eScript Prescriber Phone Qualifier 3"
    description: "Prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_3') ;;
  }

  dimension: prescriber_edi_prescriber_phone_4 {
    label: "eScript Prescriber Phone 4"
    description: "Prescriber's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_4) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_prescriber_phone_qualifier_4 {
    label: "eScript Prescriber Phone Qualifier 4"
    description: "Prescriber's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_PHONE_QUALIFIER_4') ;;
  }

  dimension: prescriber_edi_patient_phone_1 {
    label: "eScript Patient Phone 1"
    description: "Patient's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_1) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_patient_phone_qualifier_1 {
    label: "eScript Patient Phone Qualifier 1"
    description: "Patient's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_1') ;;
  }

  dimension: prescriber_edi_patient_phone_2 {
    label: "eScript Patient Phone 2"
    description: "Patient's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_2) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_patient_phone_qualifier_2 {
    label: "eScript Patient Phone Qualifier 2"
    description: "Patient's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_2') ;;
  }

  dimension: prescriber_edi_patient_phone_3 {
    label: "eScript Patient Phone 3"
    description: "Patient's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_3) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_patient_phone_qualifier_3 {
    label: "eScript Patient Phone Qualifier 3"
    description: "Patient's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_3') ;;
  }

  dimension: prescriber_edi_patient_phone_4 {
    label: "eScript Patient Phone 4"
    description: "Patient's phone number received in the PVD segment"
    type: number
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_4) ;;
    value_format: "0"
  }

  dimension: prescriber_edi_patient_phone_qualifier_4 {
    label: "eScript Patient Phone Qualifier 4"
    description: "Patient's phone number qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'BN' ;; label: "BEEPER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'CP' ;; label: "CELLULAR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'EM' ;; label: "ELECTRONIC MAIL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'FX' ;; label: "FAX" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'NP' ;; label: "NIGHT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'TE' ;; label: "TELEPHONE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'WP' ;; label: "WORK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 = 'HP' ;; label: "HOME" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PATIENT_PHONE_QUALIFIER_4') ;;
  }

  dimension: prescriber_edi_item_description_2 {
    label: "eScript Item Description 2"
    description: "Extended text from the item (drug name)"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_ITEM_DESCRIPTION_2 ;;
  }

  dimension: prescriber_edi_item_description_3 {
    label: "eScript Item Description 3"
    description: "Extended text from the item (drug name)"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_ITEM_DESCRIPTION_3 ;;
  }

  dimension: prescriber_edi_item_description_4 {
    label: "eScript Item Description 4"
    description: "Extended text from the item (drug name)"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_ITEM_DESCRIPTION_4 ;;
  }

  dimension: prescriber_edi_patient_address {
    label: "eScript Patient Address"
    description: "This is the patient's street address that is associated with the eScript received"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_ADDRESS) ;;
  }

  dimension: prescriber_edi_patient_city {
    label: "eScript Patient City"
    description: "This is the city where the patient's address is located as received in the eScript message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_CITY ;;
  }

  dimension: prescriber_edi_patient_state {
    label: "eScript Patient State"
    description: "This is the state where the patient's address is located as received in the eScript message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_STATE ;;
  }

  dimension: prescriber_edi_patient_postal_code {
    label: "eScript Patient Postal Code"
    description: "This is the postal code for the patient's address as received in the eScript message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PATIENT_POSTAL_CODE ;;
  }

  dimension: prescriber_edi_prescriber_address {
    label: "eScript Prescriber Address"
    description: "This is the prescriber's street address as received in the PVD segment from a SCRIPT message"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ADDRESS) ;;
  }

  dimension: prescriber_edi_prescriber_city {
    label: "eScript Prescriber City"
    description: "This is the city where the prescriber's address is located as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_CITY ;;
  }

  dimension: prescriber_edi_prescriber_state {
    label: "eScript Prescriber State"
    description: "This is the state where the prescriber's address is located as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_STATE ;;
  }

  dimension: prescriber_edi_prescriber_postal_code {
    label: "eScript Prescriber Postal Code"
    description: "This is the postal code for the prescriber's address as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_POSTAL_CODE ;;
  }

  dimension: prescriber_edi_supervising_prescriber_address {
    label: "eScript Supervising Prescriber Address"
    description: "This is the supervising prescriber's street address as received in the PVD segment from a SCRIPT message"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_ADDRESS) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_city {
    label: "eScript Supervising Prescriber City"
    description: "This is the city where the supervising prescriber's address is located as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_CITY ;;
  }

  dimension: prescriber_edi_supervising_prescriber_state {
    label: "eScript Supervising Prescriber State"
    description: "This is the state where the supervising prescriber's address is located as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_STATE ;;
  }

  dimension: prescriber_edi_supervising_prescriber_postal_code {
    label: "eScript Supervising Prescriber Postal Code"
    description: "This is the postal code for the supervising prescriber's address as received in the PVD segment from a SCRIPT message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_POSTAL_CODE ;;
  }

  dimension_group: prescriber_edi_rx_expiration {
    label: "eScript Rx Expiration"
    description: "The expiration date as received in the DRU segment when the date/time period qualifier is equal to '36'. This qualifier in the message indicates that this date is the expiration date for the Rx"
    type: time
    sql: ${TABLE}.PRESCRIBER_EDI_RX_EXPIRATION_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_barcode {
    label: "eScript Barcode"
    description: "System assigned barcode that is assigned on an incoming NEWRX message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_BARCODE ;;
  }

  dimension: prescriber_edi_prior_authorization_number {
    label: "eScript Prior Authorization Number"
    description: "This number is used to store the Prior Authorization or Sample Prescription  number or the Prescriber Order Number, if used"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRIOR_AUTHORIZATION_NUMBER ;;
  }

  dimension: prescriber_edi_primary_diagnosis_code {
    label: "eScript Primary Diagnosis Code"
    description: "The prescribers supplied or pharmacy inferred primary diagnosis code"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE ;;
  }

  dimension: prescriber_edi_primary_diagnosis_code_qualifier {
    label: "eScript Primary Diagnosis Code Qualifier"
    description: "This column stores the diagnosis code qualifier that can be used to determine which classification system this code is referenced from"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER = 'E' ;; label: "MICROMEDEX/MEDICAL ECONOMICS" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER = 'F' ;; label: "FIRST DATABANK" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER = 'M' ;; label: "MEDI-SPAN PRODUCT LINE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER = 'DX' ;; label: "ICD-9" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER = 'ABF' ;; label: "ICD-10" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRIMARY_DIAGNOSIS_CODE_QUALIFIER') ;;
  }

  dimension: prescriber_edi_secondary_diagnosis_code {
    label: "eScript Secondary Diagnosis Code"
    description: "Prescriber supplied or pharmacy inferred secondary diagnosis code."
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE ;;
  }

  dimension: prescriber_edi_secondary_diagnosis_code_qualifier {
    label: "eScript Secondary Diagnosis Code Qualifier"
    description: "This field is for the secondary diagnosis code qualifier. This will determine what classification system to use as reference for the code value received"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE_QUALIFIER IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE_QUALIFIER = 'DX' ;; label: "ICD-9" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE_QUALIFIER = 'ABF' ;; label: "ICD-10" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SECONDARY_DIAGNOSIS_CODE_QUALIFIER') ;;
  }

  dimension: prescriber_edi_prescribed_quantity_qualifier {
    label: "eScript Prescribed Quantity Qualifier"
    description: "This value qualifies the prescribed quantity received in the DRU segment of the eScript message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBED_QUANTITY_QUALIFIER ;;
  }

  dimension: prescriber_edi_drug_reference_number {
    label: "eScript Drug Reference Number"
    description: "Drug reference number from the DRU segment. This is an identifying number for the prescribed drug"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_NUMBER ;;
  }

  dimension: prescriber_edi_drug_reference_qualifier {
    label: "eScript Drug Reference Qualifier"
    description: "Qualifies the DRUG_REFERENCE_NUMBER by identifying the entity's number. This is mapped from the DRU segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'E' ;; label: "MEDICAL ECONOMICS GFC" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'G' ;; label: "MEDICAL ECONOMICS GM" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'AF' ;; label: "AMERICAN HOSPITAL FORMULARY SERVICE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FD' ;; label: "FDB ROUTED DOSAGE FORM ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FG' ;; label: "FDB CLINICAL FORMULATION ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FI' ;; label: "FDB MEDID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FL' ;; label: "FDB INGREDIENT LIST ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FM' ;; label: "FDB ROUTED MEDID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FN' ;; label: "FDB MEDICATION NAME ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'FS' ;; label: "FDB SMARTKEY" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'MC' ;; label: "MULTURN DRUG ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'MD' ;; label: "MEDI-SPAN PRODUCT LINE (DDID)" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'MG' ;; label: "MEDI-SPAN GENERIC PRODUCT IDENTIFIER (GPI)" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'MM' ;; label: "MULTUM MMDC" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER = 'ND' ;; label: "NDC" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_DRUG_REFERENCE_QUALIFIER') ;;
  }

  dimension: prescriber_edi_clinic_name {
    label: "eScript Clinic Name"
    description: "Clinic name from the eScript message. Mapped from the PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_CLINIC_NAME) ;;
  }

  dimension: prescriber_edi_patient_address_2 {
    label: "eScript Patient Address 2"
    description: "Patient's street address that is associated with the eScript received. This column holds overflow from the PATIENT_ADDRESS column as received in the PTT segment from a SCRIPT message"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_ADDRESS_2) ;;
  }

  dimension: prescriber_edi_prescriber_address_2 {
    label: "eScript Prescriber Address 2"
    description: "Prescriber address line 2 mapped from the PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ADDRESS_2) ;;
  }

  dimension: prescriber_edi_prescriber_order_number {
    label: "eScript Prescriber Order Number"
    description: "Prescriber order number mapped from the UIH segment. This is the trace number assigned by the doctor' s system to uniquely identiy an eScript record"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ORDER_NUMBER ;;
  }

  dimension: prescriber_edi_designated_agent_first_name {
    label: "eScript Designated Agent First Name"
    description: "Designated agent first name mapped from PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_DESIGNATED_AGENT_FIRST_NAME) ;;
  }

  dimension: prescriber_edi_designated_agent_last_name {
    label: "eScript Designated Agent Last Name"
    description: "Designated agent last name mapped  from PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_DESIGNATED_AGENT_LAST_NAME) ;;
  }

  dimension: prescriber_edi_prescriber_suffix {
    label: "eScript Prescriber Suffix"
    description: "Prescriber Suffix mapped from PVD segment. Appended to Prescriber full name and displayed on System generated hard copy"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_SUFFIX ;;
  }

  dimension: prescriber_edi_supervising_prescriber_suffix {
    label: "eScript Supervising Prescriber Suffix"
    description: "Supervising Prescriber Suffix mapped from PVD segment. Appended to Supervising Prescriber full name and displayed on System generated hard copy"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_SUFFIX ;;
  }

  dimension: prescriber_edi_drug_form {
    label: "eScript Drug Form"
    description: "This is the drug form in a code qualified in the message from the source code list"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_DRUG_FORM ;;
  }

  dimension_group: prescriber_edi_rx_start {
    label: "eScript Rx Start"
    description: "The date from which the patient can start taking the prescribed medication. The date is set by the prescriber and is sent in the DRU segment when the date/time period qualifier is eqaul to '07'. This qualifier indicates that this date is the effective date (or begin date)"
    type: time
    sql: ${TABLE}.PRESCRIBER_EDI_RX_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: prescriber_edi_message_sent {
    label: "eScript Message Sent"
    description: "Message sent date from eScript message"
    type: time
    sql: ${TABLE}.PRESCRIBER_EDI_MESSAGE_SENT_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_dea_schedule {
    label: "eScript DEA Schedule"
    description: "This is the schedule of the controlled substance drug"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C38046' ;; label: "UNSPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C48672' ;; label: "SCHEDULE I SUBSTANCE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C48675' ;; label: "SCHEDULE II SUBSTANCE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C48676' ;; label: "SCHEDULE III SUBSTANCE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C48677' ;; label: "SCHEDULE IV SUBSTANCE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE = 'C48679' ;; label: "SCHEDULE V SUBSTANCE" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_DEA_SCHEDULE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_DEA_SCHEDULE') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_address_2 {
    label: "eScript Supervising Prescriber Address 2"
    description: "This stores the second line of the address for the supervisng prescriber if received in the eScript"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_ADDRESS_2) ;;
  }

  dimension: prescriber_edi_signature_indicator {
    label: "eScript Signature Indicator"
    description: "Field used for EPCS Controlled eScripts that indicates that a prescriber digitally signed and approved the prescription"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SIGNATURE_INDICATOR = 'Y' ;; label: "YES THE SIGNATURE IS PRESENT" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SIGNATURE_INDICATOR = 'N' ;; label: "THE SIGNATURE IS NOT PRESENT" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SIGNATURE_INDICATOR AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SIGNATURE_INDICATOR') ;;
  }

  dimension: prescriber_edi_patient_ssn {
    label: "eScript Patient SSN"
    description: "Patient's Social Security Number as received in the PTT segment from a SCRIPT message"
    type: string
    hidden: yes
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PATIENT_SSN) ;;
  }

  dimension: prescriber_edi_prescriber_id_number_3 {
    label: "eScript Prescriber ID Number 3"
    description: "Reference Number received in the PVD segment"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_3) ;;
  }

  dimension: prescriber_edi_prescriber_id_number_qualifier_3 {
    label: "eScript Prescriber ID Number Qualifier 3"
    description: "Reference Qualifier received in the PVD segment"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '1G' ;; label: "UPIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 = '0B' ;; label: "STATE LICENSE NUMBER" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_PRESCRIBER_ID_NUMBER_QUALIFIER_3') ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_3 {
    label: "eScript Supervising Prescriber Number 3"
    description: "Supervising prescriber's actual ID Number as received from the PVD segment of eScript messages"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_3) ;;
  }

  dimension: prescriber_edi_supervising_prescriber_number_qualifier_3 {
    label: "eScript Supervising Prescriber Number Qualifier 3"
    description: "Qualifier for the supervising prescriber's ID Number as received from the PVD segment of eScript messages"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'ADI' ;; label: "PROCESSOR IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'BO' ;; label: "BIN LOCATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'C1' ;; label: "COMMERCIAL" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'DH' ;; label: "DEA NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1E' ;; label: "DENTIST LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1J' ;; label: "FACILITY ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'HI' ;; label: "HIN" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'IP' ;; label: "INDIVIDUAL POLICY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1D' ;; label: "MEDICAID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'EA' ;; label: "MEDICAL RECORD ID NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1C' ;; label: "MEDICARE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'ZZ' ;; label: "MUTUALLY DEFINED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'NF' ;; label: "NAIC CODE" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'HPI' ;; label: "NPI" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'D3' ;; label: "NCPDP PROVIDER ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'EJ' ;; label: "PATIENT ACCOUNT NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '2U' ;; label: "PAYER IDENTIFICATION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '94' ;; label: "PHARMACY OR PRESCRIBER FILE ID" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1M' ;; label: "PPO NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'G1' ;; label: "PRIOR AUTHORIZATION" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'PD' ;; label: "PROMOTION NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'NC' ;; label: "SECONDARY COVERAGE COMPANY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = 'SY' ;; label: "SOCIAL SECURITY NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '0B' ;; label: "STATE LICENSE NUMBER" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 = '1G' ;; label: "UPIN" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3 AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_SUPERVISING_PRESCRIBER_NUMBER_QUALIFIER_3') ;;
  }

  dimension: prescriber_edi_rxfill_indicator {
    label: "eScript Rxfill Indicator"
    description: "Holds the value of when a prescriber requests an RXFILL message to verify the fill of a prescription.  In SCRIPT 10.6 will be mapped from the <Receiver><SecondaryIdentification> field in the header of the XML message"
    type: string
    sql: ${TABLE}.PRESCRIBER_EDI_RXFILL_INDICATOR ;;
  }

  dimension: prescriber_edi_prescriber_location_identifier {
    label: "eScript Prescriber Location Identifier"
    description: "Prescriber's clinic location ID that is provided by a third party (such as Emdeon) through the eScript interface. Similar to the third party's version of a prescriber NPI number"
    type: string
    sql: SHA2(${TABLE}.PRESCRIBER_EDI_PRESCRIBER_LOCATION_IDENTIFIER) ;;
  }

  dimension: prescriber_edi_routing_status {
    label: "eScript Routing Status"
    description: "Stores the status of eScripts routed by the eScript forwarding service"
    type: string
    case: {
      when: { sql: ${TABLE}.PRESCRIBER_EDI_ROUTING_STATUS IS NULL ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_ROUTING_STATUS = 'S' ;; label: "SUCCESS" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_ROUTING_STATUS = 'C' ;; label: "COMM ERROR" }
      when: { sql: ${TABLE}.PRESCRIBER_EDI_ROUTING_STATUS = 'E' ;; label: "ERROR" }
    }
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PRESCRIBER_EDI_ROUTING_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PRESCRIBER_EDI_ROUTING_STATUS') ;;
  }

  dimension_group: source_create_timestamp {
    label: "Source Create Timestamp"
    description: "This is the date and time that the record was created in source table."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time at which the record was last updated in the source application."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: prescriber_edi_quantity_prescribed {
    label: "eScript Prescribed Quantity"
    description: "The prescribed quantity for an eScript prescription"
    type: number
    sql: ${TABLE}.PRESCRIBER_EDI_QUANTITY_PRESCRIBED ;;
    value_format: "###0.00"
  }

  dimension: received_to_rpt_sales_duration {
    label: "eScript Received to Reportable Sales Date (in Mins)"
    description: "Time taken in minutes for a prescription transaction from eScript received to adjudicated."
    type: number
    #hidden: yes
    sql: DATEDIFF(MINUTE, ${prescriber_edi_received_time},${eps_rx_tx.rx_tx_reportable_sales_time}) ;;
    value_format: "###0.00"
  }


  dimension: received_to_will_call_picked_up_duration {
    label: "eScript Received to Will Call Picked Up Date (in Mins)"
    description: "Time taken in minutes for a prescription transaction from eScript received to will call picked up"
    type: number
    #hidden: yes
    sql: DATEDIFF(MINUTE, ${prescriber_edi_received_time},${eps_rx_tx.rx_tx_will_call_picked_up_time}) ;;
    value_format: "###0.00"
  }

  filter: rx_tx_fill_status_filter {
    label: "eScript Prescription Fill Status \"Filter Only\""
    description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
    type: string
    sql: {% condition rx_tx_fill_status_filter %} ${eps_rx_tx.rx_tx_fill_status} {% endcondition %} ;;
    suggestions: ["NEW PRESCRIPTION", "REFILL", "NON FILLED COGNITIVE", "NOT SPECIFIED"]
  }

  filter: rx_tx_tx_status_filter {
    label: "eScript Prescription Transaction Status \"Filter Only\""
    description: "Status of the Transaction. Normal, Cancelled, Credit Returned, Hold, and Replacement"
    type: string
    sql: {% condition rx_tx_tx_status_filter %} ${eps_rx_tx.rx_tx_tx_status} {% endcondition %} ;;
    suggestions: ["NORMAL", "CANCELLED", "CREDIT RETURNED", "HOLD", "REPLACEMENT"]
  }

  filter: escript_message_approval_status_filter {
    label: "eScript Message Approval Status \"Filter Only\""
    description: "Concatenated value of eScript Message Type and Approval status. Used for filter only"
    type: string
    sql: {% condition escript_message_approval_status_filter %}
          CASE WHEN ${prescriber_edi_message_type} = 'NOT SPECIFIED' AND ${prescriber_edi_approved} = 'NOT SPECIFIED'
               THEN 'NOT SPECIFIED'
               ELSE ${prescriber_edi_message_type}||CASE WHEN ${prescriber_edi_approved} = 'NOT SPECIFIED' THEN '' ELSE ' '||${prescriber_edi_approved} END
          END {% endcondition %} ;;
    suggestions: ["NOT SPECIFIED",
      "NEW PRESCRIPTION MESSAGE",
      "REFILL RESPONSE MESSAGE APPROVED",
      "REFILL RESPONSE MESSAGE APPROVED WITH CHANGES",
      "REFILL RESPONSE MESSAGE DENIED",
      "REFILL RESPONSE MESSAGE DENIED NEW RX TO FOLLOW",
      "VERIFICATION MESSAGE",
      "CANCEL PRESCRIPTION MESSAGE",
      "ERROR MESSAGE"]
  }

  ##########################Measures############################
  #sum_distinct_key mentioned at eps_rx_tx.rx_tx_id level to calculate measure values correctly.
  measure: sum_prescriber_edi_quantity_prescribed {
    label: "Total eScript Prescribed Quantity"
    description: "The prescribed quantity for an eScript prescription"
    #type: sum
    type: sum_distinct
    sql_distinct_key: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${eps_rx_tx.rx_tx_id}  ;;
    sql: ${TABLE}.PRESCRIBER_EDI_QUANTITY_PRESCRIBED ;;
    value_format: "###0.00"
  }

  measure: sum_received_to_rpt_sales_duration {
    label: "eScript Received to Reportable Sales Date (in Mins)"
    description: "Time taken in minutes for a prescription transaction from eScript received to adjudicated."
    #type: sum
    type: sum_distinct
    sql_distinct_key: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${eps_rx_tx.rx_tx_id}  ;;
    sql: ${received_to_rpt_sales_duration} ;;
    value_format: "###0.00"
  }

  measure: sum_received_to_will_call_picked_up_duration {
    label: "eScript Received to Will Call Picked Up Date (in Mins)"
    description: "Time taken in minutes for a prescription transaction from eScript received to will call picked up"
    #type: sum
    type: sum_distinct
    sql_distinct_key: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${eps_rx_tx.rx_tx_id} ;;
    sql: ${received_to_will_call_picked_up_duration} ;;
    value_format: "###0.00"
  }

  measure: avg_received_to_rpt_sales_duration {
    label: "Avg eScript Received to Reportable Sales Date (in Mins)"
    description: "Average time taken in minutes for a prescription transaction from eScript received to adjudicated."
    #type: sum
    type: average_distinct
    sql_distinct_key: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${eps_rx_tx.rx_tx_id}  ;;
    sql: ${received_to_rpt_sales_duration} ;;
    value_format: "###0.00"
  }

  measure: avg_received_to_will_call_picked_up_duration {
    label: "Avg eScript Received to Will Call Picked Up Date (in Mins)"
    description: "Average time taken in minutes for a prescription transaction from eScript received to will call picked up"
    #type: sum
    type: average_distinct
    sql_distinct_key: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${eps_rx_tx.rx_tx_id}  ;;
    sql: ${received_to_will_call_picked_up_duration} ;;
    value_format: "###0.00"
  }
}

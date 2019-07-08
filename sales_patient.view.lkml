view: sales_patient {
  sql_table_name: EDW.D_PATIENT ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    label: "Central Patient RX COM ID"
    description: "Patient unique identifier"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: rx_com_id_deidentified {
    label: "Central Patient RX COM ID"
    description: "Patient unique identifier"
    type: string
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.RX_COM_ID) ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;;
  }

  dimension: created_by_nhin_store_id {
    label: "Central Patient Created By NHIN STORE ID"
    description: "Pharmacy where the patient record was originally created"
    type: number
    sql: ${TABLE}.PATIENT_CREATED_BY_NHIN_STORE_ID ;;
  }

  dimension: updated_by_nhin_store_id {
    label: "Central Patient Updated By NHIN STORE ID"
    description: "Pharmacy where the patient record was last touched/updated by"
    type: number
    sql: ${TABLE}.PATIENT_UPDATED_BY_NHIN_STORE_ID ;;
  }

  dimension: old_contrib_id {
    label: "Central Patient Old Contributor RX COM ID"
    description: "The other patient record that is being used in a patient merge to create a survivor patient record"
    type: number
    sql: ${TABLE}.PATIENT_OLD_CONTRIB_ID ;;
  }

  dimension: new_contrib_id {
    label: "Central Patient New Contributor RX COM ID"
    description: "The current patient record that is being used in a patient merge to create a survivor patient record"
    type: number
    sql: ${TABLE}.PATIENT_NEW_CONTRIB_ID ;;
  }

  dimension: survivor_id {
    label: "Central Patient Survivor RX COM ID"
    description: "Patient RX COM ID that is generated when two patients are merged"
    type: number
    sql: ${TABLE}.PATIENT_SURVIVOR_ID ;;
  }

  dimension_group: added {
    label: "Central Patient Added"
    description: "Date patient record was added into EPR System"
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
    sql: ${TABLE}.PATIENT_ADDED ;;
  }

  dimension: alt_patient_id {
    label: "Central Patient Alternate ID"
    description: "Alternate ID number of the patient"
    type: string
    sql: ${TABLE}.PATIENT_ALT_PATIENT_ID ;;
  }

  dimension: alt_patient_id_state {
    label: "Central Patient Alternate ID State"
    description: "State where the alternate ID of the patient was issued"
    type: string
    sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_STATE ;;
  }

  dimension: alt_patient_id_type {
    label: "Central Patient Alternate ID Type"
    description: "Type of alternate ID for a patient (state issued, military, passport, etc.)"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 1 ;;
        label: "STATED ISSUED ID"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 2 ;;
        label: "MILITARY ID"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 3 ;;
        label: "PASSPORT"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 4 ;;
        label: "UNIQUE SYSTEM ID"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 5 ;;
        label: "OTHER"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 6 ;;
        label: "GREEN CARD"
      }

      when: {
        sql: ${TABLE}.PATIENT_ALT_PATIENT_ID_TYPE = 7 ;;
        label: "TRIBAL ID"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: animal_type {
    label: "Central Patient Animal Type"
    description: "Type of animal (non-human) patient"
    type: string
    sql: ${TABLE}.PATIENT_ANIMAL_TYPE ;;
  }

  dimension_group: patient_birth {
    label: "Central Patient DoB"
    description: "Patient's Date Of Birth"
    type: time
    # time component is not included as the data in EPR is always set to 12 noon
    timeframes: [
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
    sql: ${TABLE}.PATIENT_BIRTH_DATE ;;
  }

  dimension: patient_age {
    label: "Central Patient Age"
    description: "Patient's Age"
    type: number
    sql: CAST((DATEDIFF('DAY',${patient_birth_date},CURRENT_DATE)/365.25) AS NUMBER) ;;
  }

  #[ERXLPS-6239] - Modified label name. Added ALL word. Removed 0 from tiers.
  dimension: patient_age_tier {
    label: "Central Patient Age All Tier"
    type: tier
    description: "Patient age group distribution"
    sql: ${patient_age} ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      10,
      20,
      30,
      40,
      50,
      60,
      65,
      70,
      80
    ]
    style: integer
  }

  dimension: bottle_color {
    # This field was specifically used for TARGET (CHAIN-101)
    hidden: yes
    label: "Central Patient Bottle Color"
    description: "Patient prescription bottle collar ring color"
    type: number
    sql: ${TABLE}.PATIENT_BOTTLE_COLOR ;;
  }

  dimension: category {
    label: "Central Patient Category"
    description: "Code for a category of patients"
    type: string
    sql: ${TABLE}.PATIENT_CATEGORY ;;
  }

  dimension: clinical_track_name {
    label: "Central Patient Clinical Track Name"
    description: "The default clinical track of the patient used for specialty pharmacy"
    type: string
    sql: ${TABLE}.PATIENT_CLINICAL_TRACK_NAME ;;
  }

  dimension: contact_email {
    label: "Central Patient Contact Email"
    description: "Indicates the method (HOME, WORK, SCHOOL) of contacting the patient via email"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_CONTACT_EMAIL = 'H' ;;
        label: "HOME"
      }

      when: {
        sql: ${TABLE}.PATIENT_CONTACT_EMAIL = 'W' ;;
        label: "WORK"
      }

      when: {
        sql: ${TABLE}.PATIENT_CONTACT_EMAIL = 'O' ;;
        label: "SCHOOL"
      }

      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  dimension: contact_phone {
    label: "Central Patient Contact Phone"
    description: "Indicates the method (HOME, WORK, CELL)  of contacting the patient via phone"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_CONTACT_PHONE = 'H' ;;
        label: "HOME"
      }

      when: {
        sql: ${TABLE}.PATIENT_CONTACT_PHONE = 'W' ;;
        label: "WORK"
      }

      when: {
        sql: ${TABLE}.PATIENT_CONTACT_PHONE = 'C' ;;
        label: "CELL"
      }

      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  dimension: contact_sms {
    label: "Central Patient Contact SMS"
    description: "Y/N flag indicating if text messaging is enabled for contacting the patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_CONTACT_SMS = 'S' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: daw {
    label: "Central Patient DAW"
    description: "Y/N flag indicating if the DAW code should be defaulted to the patient DAW when filling a prescription"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_DAW = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension_group: deactivate {
    label: "Central Patient Deactivated"
    description: "Date/Time this patient record was deactivated"
    type: time
    # time component is not included as the data in EPR is always set to 12 noon
    timeframes: [
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
    sql: ${TABLE}.PATIENT_DEACTIVATE_DATE ;;
  }

  dimension_group: deceased {
    label: "Central Patient Deceased"
    description: "Date/Time this patient record was deaceased"
    type: time
    # time component is not included as the data in EPR is always set to 12 noon
    timeframes: [
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
    sql: ${TABLE}.PATIENT_DECEASED_DATE ;;
  }

  dimension_group: direct_marketing {
    label: "Central Patient Direct Marketing"
    description: "Date/Time when the Patient Direct Marketing is updated. Needed for the POS interface"
    type: time
    # time component is not included as the data in EPR is always set to 12 noon
    timeframes: [
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
    sql: ${TABLE}.PATIENT_DIRECT_MARKETING_DATE ;;
  }

  dimension: discount {
    label: "Central Patient Discount Code"
    description: "Discount code to be applied to the patient's prescriptions"
    type: string
    sql: ${TABLE}.PATIENT_DISCOUNT ;;
  }

  dimension: driver_license_add {
    label: "Central Patient Driver License Addendum"
    description: "Additional information on the patient's driver's license. This field is used if the required state's id number exceeds the length of the drivers license number field"
    type: string
    sql: ${TABLE}.PATIENT_DRIVER_LICENSE_ADD ;;
  }

  dimension: driver_license_number {
    label: "Central Patient Driver License Number"
    description: "Patient's driver's license number"
    type: string
    sql: ${TABLE}.PATIENT_DRIVER_LICENSE_NUMBER ;;
  }

  dimension: driver_license_state {
    label: "Central Patient Driver License State"
    description: "State that the patient's driver's license was issued in"
    type: string
    sql: ${TABLE}.PATIENT_DRIVER_LICENSE_STATE ;;
  }

  dimension: ehr_enabled {
    label: "Central Patient Prescription ACS Priority"
    description: "Y/N flag indicating if clinical data sharing cross-chain is enabled for this patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_EHR_ENABLED = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: suffix {
    label: "Suffix"
    group_label: "Central Patient Name"
    description: "Patient's name suffix"
    type: string
    sql: ${TABLE}.PATIENT_SUFFIX ;;
  }

  dimension: first_name {
    group_label: "Central Patient Name"
    label: "First Name"
    description: "Patient's First Name"
    type: string
    sql: ${TABLE}.PATIENT_FIRST_NAME ;;
  }

  dimension: last_name {
    group_label: "Central Patient Name"
    label: "Last Name"
    description: "Patient's Last Name"
    type: string
    sql: ${TABLE}.PATIENT_LAST_NAME ;;
  }

  dimension: middle_name {
    group_label: "Central Patient Name"
    label: "Middle Name"
    description: "Patient's Middle Name"
    type: string
    sql: ${TABLE}.PATIENT_MIDDLE_NAME ;;
  }

  dimension: record_type {
    label: "Central Patient Record Type"
    description: "Specifies the type of record (PATIENT, ANIMAL, OFFICE) this is being used for"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_RECORD_TYPE = 1 ;;
        label: "PATIENT"
      }

      when: {
        sql: ${TABLE}.PATIENT_RECORD_TYPE = 2 ;;
        label: "ANIMAL"
      }

      when: {
        sql: ${TABLE}.PATIENT_RECORD_TYPE = 3 ;;
        label: "OFFICE"
      }

      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  dimension: sex {
    label: "Central Patient Sex"
    description: "Patient's sex"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_SEX = 'M' ;;
        label: "MALE"
      }

      when: {
        sql: ${TABLE}.PATIENT_SEX = 'F' ;;
        label: "FEMALE"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: height {
    label: "Central Patient Height"
    description: "Patient's Height"
    type: number
    sql: ${TABLE}.PATIENT_HEIGHT ;;
  }

  dimension: weight {
    label: "Central Patient Weight"
    description: "Patient's Weight"
    type: number
    sql: ${TABLE}.PATIENT_WEIGHT ;;
  }

  dimension: group_number {
    label: "Central Patient Group Number"
    description: "Code used to group patients for processing or reports"
    type: string
    sql: ${TABLE}.PATIENT_GROUP_NUMBER ;;
  }

  dimension: language {
    label: "Central Patient Language Code"
    description: "Patient's Language Code"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_LANGUAGE = 'S' ;;
        label: "SPANISH"
      }

      when: {
        sql: ${TABLE}.PATIENT_LANGUAGE = 'F' ;;
        label: "FRENCH"
      }

      when: {
        sql: true ;;
        label: "ENGLISH"
      }
    }
  }

  dimension: link_flags {
    label: "Central Patient Link Flag"
    description: "Stores bit level flags indicating which token(s) this patient record has: GOOGLE, MICROSOFT HEALTH VAULT, and/or SMS (MScripts) tokens"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 1 ;;
        label: "GOOGLE"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 2 ;;
        label: "MICROSOFT HEALTH VAULT"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 3 ;;
        label: "GOOGLE & MICROSOFT HEALTH VAULT"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 4 ;;
        label: "SMS"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 5 ;;
        label: "GOOGLE & SMS"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 6 ;;
        label: "MICROSOFT HEALTH VAULT & SMS"
      }

      when: {
        sql: ${TABLE}.PATIENT_LINK_FLAGS = 7 ;;
        label: "GOOGLE, MICROSOFT HEALTH VAULT & SMS"
      }

      when: {
        sql: true ;;
        label: "NONE"
      }
    }
  }

  dimension: loyalty_card_number {
    label: "Central Patient Loyalty Card Number"
    description: "Represents the patient's loyalty card number."
    type: string
    sql: ${TABLE}.PATIENT_LOYALTY_CARD_NUMBER ;;
  }

  dimension_group: majority_date {
    label: "Central Patient Majority"
    description: "Date when the patient is considered a legal adult if not the standard date (18yrs)"
    type: time
    timeframes: [
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
    sql: ${TABLE}.PATIENT_MAJORITY_DATE ;;
  }

  dimension: marital_status {
    label: "Central Patient Marital Status"
    description: "Marital status of the Patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_MARITAL_STATUS = 'M' ;;
        label: "MARRIED"
      }

      when: {
        sql: ${TABLE}.PATIENT_MARITAL_STATUS = 'S' ;;
        label: "SINGLE"
      }

      when: {
        sql: ${TABLE}.PATIENT_MARITAL_STATUS = 'P' ;;
        label: "DOMESTIC PARTNER"
      }

      when: {
        sql: ${TABLE}.PATIENT_MARITAL_STATUS = 'O' ;;
        label: "OTHER"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: medical_record_number {
    label: "Central Patient Medical Record Number"
    description: "Medical Record Number of the Patient"
    type: string
    sql: ${TABLE}.PATIENT_MEDICAL_RECORD_NUMBER ;;
  }

  dimension: medigap_identifier {
    label: "Central Patient Medigap Identifier"
    description: "Medigap (Medicare Supplement) ID used when patient has Medigap coverage"
    type: string
    sql: ${TABLE}.PATIENT_MEDIGAP_IDENTIFIER ;;
  }

  dimension_group: merged_date {
    label: "Central Patient Merged"
    description: "Date/Time patient record was merged with another patient"
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
    sql: ${TABLE}.PATIENT_MERGED_DATE ;;
  }

  dimension: metric_weight {
    label: "Central Patient Metric Weight"
    description: "Flag indicating if patient weight is measured in kilograms or pounds and patient height is measured in centimeters or inches"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_METRIC_WEIGHT = 'Y' ;;
        label: "CENTIMETERS KILOGRAMS"
      }

      when: {
        sql: true ;;
        label: "INCHES POUNDS"
      }
    }
  }

  dimension: mtm_opt_out {
    label: "Central Patient MTM Opt Out"
    description: "Y/N Flag indicating if the patient is setup to receive MTM services."
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_MTM_OPT_OUT = '1' ;;
        label: "N"
      }

      when: {
        sql: true ;;
        label: "Y"
      }
    }
  }

  dimension: multibirth {
    label: "Central Patient Multibirth Status"
    description: "Indicates multiple birth status of the patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH IN ('Y','2') ;;
        label: "TWIN"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '3' ;;
        label: "TRIPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '4' ;;
        label: "QUADRUPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '5' ;;
        label: "QUINTUPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '6' ;;
        label: "SEXTUPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '7' ;;
        label: "SEPTUPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '8' ;;
        label: "OCTUPLET"
      }

      when: {
        sql: ${TABLE}.PATIENT_MULTIBIRTH = '9' ;;
        label: "NONUPLET"
      }

      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  dimension: no_cf {
    label: "Central Patient No Central Fill"
    description: "Y/N Flag indicating if prescriptions for a patient may be sent to Central Fill"
    type: string

    case: {
      #Disallow Central Fill
      when: {
        sql: ${TABLE}.PATIENT_NO_CF = 'Y' ;;
        label: "N"
      }

      #Allow Central Fill
      when: {
        sql: true ;;
        label: "Y"
      }
    }
  }

  dimension: no_compliance {
    label: "Central Patient No Compliance"
    description: "Y/N Flag indicating if compliance monitoring should be performed for the patient"
    type: string

    case: {
      #No Compliance Monitoring
      when: {
        sql: ${TABLE}.PATIENT_NO_COMPLIANCE = 'Y' ;;
        label: "N"
      }

      #Perform Compliance Monitoring
      when: {
        sql: true ;;
        label: "Y"
      }
    }
  }

  dimension: no_prefill {
    label: "Central Patient No Prefill"
    description: "Y/N Flag indicating if prescriptions for a patient may be auto-filled"
    type: string

    case: {
      #Disallow Autofill
      when: {
        sql: ${TABLE}.PATIENT_NO_PREFILL = 'Y' ;;
        label: "N"
      }

      #Allow Autofill
      when: {
        sql: true ;;
        label: "Y"
      }
    }
  }

  dimension: no_ref_pref {
    label: "Central Patient No Refill Preference"
    description: "Instructions indicating the actions to take when a prescription that is being auto-filled has no refills remaining or is expired"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_NO_REF_PREF = 'D' ;;
        label: "CALL DOCTOR"
      }

      when: {
        sql: ${TABLE}.PATIENT_NO_REF_PREF = 'P' ;;
        label: "NO REFILL"
      }

      when: {
        sql: ${TABLE}.PATIENT_NO_REF_PREF = 'N' ;;
        label: "NO AUTO FILL"
      }

      when: {
        sql: true ;;
        label: "DEFAULTS"
      }
    }
  }

  dimension: no_transfer {
    label: "Central Patient No Transfer"
    description: "Y/N Flag indicating if auto-transfer of prescriptions is allowed for the patient"
    type: string

    case: {
      #Disallow Autotransfer
      when: {
        sql: ${TABLE}.PATIENT_NO_TRANSFER = 'Y' ;;
        label: "N"
      }

      #Allow Autotransfer
      when: {
        sql: true ;;
        label: "Y"
      }
    }
  }

  dimension: nsc {
    label: "Central Patient NSC"
    description: "Y/N Flag indicating if No Safety Cap is requested by the patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_NSC = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: omit_dur {
    label: "Central Patient Omit DUR"
    description: "Y/N Flag indicating if DUR checking should be omitted for a patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_OMIT_DUR = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: otc_price_code {
    label: "Central Patient OTC Price Code"
    description: "Price Code for over-the-counter drugs"
    type: string
    sql: ${TABLE}.PATIENT_OTC_PRICE_CODE ;;
  }

  dimension: partial_cii_fill {
    label: "Central Patient Partial C-II Fills"
    description: "Y/N Flag indicating if patient is allowed to receive partial fills on a schedule II drug"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_PARTIAL_CII_FILL = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: price_code {
    label: "Central Patient Price Code"
    description: "Price code to be used when pricing prescriptions for the patient"
    type: string
    sql: ${TABLE}.PATIENT_PRICE_CODE ;;
  }

  dimension: profession {
    label: "Central Patient Profession"
    description: "Patient's Profession"
    type: string
    sql: ${TABLE}.PATIENT_PROFESSION ;;
  }

  dimension: race {
    label: "Central Patient Race"
    description: "Patient's Race"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_RACE = 'A' ;;
        label: "ASIAN"
      }

      when: {
        sql: ${TABLE}.PATIENT_RACE = 'B' ;;
        label: "AFRICAN AMERICAN"
      }

      when: {
        sql: ${TABLE}.PATIENT_RACE = 'H' ;;
        label: "HISPANIC"
      }

      when: {
        sql: ${TABLE}.PATIENT_RACE = 'I' ;;
        label: "AMERICAN INDIAN"
      }

      when: {
        sql: ${TABLE}.PATIENT_RACE = 'O' ;;
        label: "OTHER"
      }

      when: {
        sql: ${TABLE}.PATIENT_RACE = 'W' ;;
        label: "CAUCASIAN"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: sub_group {
    label: "Central Patient Sub Group Code"
    description: "Code used for a sub-group of patients"
    type: string
    sql: ${TABLE}.PATIENT_SUB_GROUP ;;
  }

  dimension: taxable {
    label: "Central Patient Taxable"
    description: "Y/N Flag indicating if a patient is tax exempt"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_TAXABLE = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension_group: unmerged {
    # this field does not serve any value at this point as only patient as a result of merge/un-merge operations.
    hidden: yes
    label: "Central Patient UnMerged"
    description: "Date/Time patient record was unmerged with another patient"
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
    sql: ${TABLE}.PATIENT_UNMERGED_DATE ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXLPS-6239] - Added individual age tier dimensions.
  dimension: patient_age_tier_0_to_9 {
    label: "Central Patient Age Tier 0-9"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 0 AND ${patient_age} < 10 THEN '0 to 9' END ;; #Add check >= 0. Few patients DOB is in future.
  }

  dimension: patient_age_tier_10_to_19 {
    label: "Central Patient Age Tier 10-19"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 10 AND ${patient_age} < 20 THEN '10 to 19' END ;;
  }

  dimension: patient_age_tier_20_to_29 {
    label: "Central Patient Age Tier 20-29"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 20 AND ${patient_age} < 30 THEN '20 to 29' END ;;
  }

  dimension: patient_age_tier_30_to_39 {
    label: "Central Patient Age Tier 30-39"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 30 AND ${patient_age} < 40 THEN '30 to 39' END ;;
  }
  dimension: patient_age_tier_40_to_49 {
    label: "Central Patient Age Tier 40-49"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 40 AND ${patient_age} < 50 THEN '40 to 49' END ;;
  }

  dimension: patient_age_tier_50_to_59 {
    label: "Central Patient Age Tier 50-59"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 50 AND ${patient_age} < 60 THEN '50 to 59' END ;;
  }

  dimension: patient_age_tier_60_to_64 {
    label: "Central Patient Age Tier 60-64"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 60 AND ${patient_age} < 65 THEN '60 to 64' END ;;
  }

  dimension: patient_age_tier_65_to_69 {
    label: "Central Patient Age Tier 65-69"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 65 AND ${patient_age} < 70 THEN '65 to 69' END ;;
  }

  dimension: patient_age_tier_65_plus {
    label: "Central Patient Age Tier 65+"
    type: string
    description: "Patient age group distribution"
    sql: CASE WHEN ${patient_age} >= 65 THEN '65+' END ;;
  }

  ############################################################## Measure #############################################################################
  measure: patient_count {
    label: "Central Patient Count"
    description: "Total Patients"
    type: count_distinct
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${unique_key} END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: patient_count_ly {
    label: "LY Central Patient Count"
    description: "Total Patients for Last Year based on the period selected"
    type: count_distinct
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${unique_key} END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: patient_count_variance {
    label: "TY/LY Central Patient Count Variance"
    description: "Increase/Decrease of Total Central Patient Count compared to last year. Calculation Used: (Central Patient Count - LY Central Patient Count)."
    type: number
    sql: ${patient_count} - ${patient_count_ly} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: patient_count_variance_pct {
    label: "TY/LY Central Patient Count Variance %"
    description: "Percentage Increase/Decrease of Total Central Patient Count compared to last year. Calculation Used: (Central Patient Count - LY Central Patient Count)/LY Central Patient Count."
    type: number
    sql: CAST((${patient_count} - ${patient_count_ly}) AS DECIMAL(17,4))/NULLIF(ABS(${patient_count_ly}),0) ;;
    value_format: "00.00%"
  }

  #[ERXLPS-6323]
  measure: patient_count_age_65_plus {
    label: "Central Patient Count (Age 65+)"
    description: "Total Patients whose age is 65 and above. Patient Age is calculated at the time of report run."
    type: count_distinct
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${patient_age} >= 65 THEN ${unique_key} END ;;
  }

  ############################################################ sets ##################################################################################
  #[ERXLPS-6239] - Set created for newly added individual age tier dimensions.
  set: explore_dx_patient_age_tier_candidate_list {
    fields: [
      patient_age_tier_0_to_9,
      patient_age_tier_10_to_19,
      patient_age_tier_20_to_29,
      patient_age_tier_30_to_39,
      patient_age_tier_40_to_49,
      patient_age_tier_50_to_59,
      patient_age_tier_60_to_64,
      patient_age_tier_65_to_69,
      patient_age_tier_65_plus
    ]
  }
}

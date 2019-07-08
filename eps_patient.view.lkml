view: eps_patient {
  # 1. Currently this view would be used as a pass through to get the actual Patient information from the EDW.D_PATIENT (which includes Centralized Patient information)
  # 2. There are fields that are in D_STORE_PATIENT, which does not reside in D_PATIENT. Discussion was held with the business team on not exposing shuch fields currently -
  #     - this is due to the fact, the patient information in one store might not be the same patient information in another store.
  # 3. When analysis around store Patient, is required, the elements from Store Patient would be exposed but not currently.
  # 4. All columns from EDW.D_STORE_PATIENT table are added and PDX Classic specific columns related dimensions and measures are currently hidden.

  sql_table_name: EDW.D_STORE_PATIENT ;;

  dimension: patient_id {
    label: "Store Patient ID"
    description: "Unique ID number identifying a patient record within a pharmacy chain"
    type: string
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    type:  string
    primary_key: yes #ERXLPS-4429
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${patient_id} ||'@'||${source_system_id} ;; #ERXLPS-1649  #ERXDWPS-5137
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

  # used as a reference to get to the patient EPR information
  dimension: rx_com_id {
    #hidden: yes
    type: number
    label: "Store Patient RX COM ID"
    description: "Patient unique identifier. EPS Table Name: PATIENT"
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: rx_com_id_deidentified {
    type: string
    label: "Store Patient RX COM ID"
    description: "Patient unique identifier. EPS Table Name: PATIENT"
    sql: SHA2(${TABLE}.RX_COM_ID) ;;
  }

  dimension: patient_source_create_reference {
    label: "Store Patient Pharmacy Add"
    description: "Date/Time patient record was added"
    hidden:  yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: patient_discount_id {
    type: number
    hidden: yes
    label: "Store Patient Discount ID"
    sql: ${TABLE}.PATIENT_DISCOUNT_ID ;;
  }

  dimension: patient_ltc_facility_id {
    type: number
    hidden: yes
    label: "Store Patient LTC Facility ID"
    sql: ${TABLE}.PATIENT_LTC_FACILITY_ID ;;
  }

  dimension: patient_autofill_reject_note_id {
    type: number
    hidden: yes
    label: "Store Patient Autofill Reject Note ID"
    sql: ${TABLE}.PATIENT_AUTOFILL_REJECT_NOTE_ID ;;
  }

  dimension: patient_syncscript_reject_note_id {
    type: number
    hidden: yes
    label: "Store Patient Sync Script Reject Note ID"
    sql: ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_NOTE_ID ;;
  }

  dimension: patient_refill_services_phone_id {
    type: string #ERXDWPS-5137
    hidden: yes
    label: "Store Patient Refill Services Phone ID"
    sql: ${TABLE}.PATIENT_REFILL_SERVICES_PHONE_ID ;;
  }

  dimension: patient_ltc_room_phone_id {
    type: string #ERXDWPS-5137
    hidden: yes
    label: "Store Patient LTC Room Phone ID"
    sql: ${TABLE}.PATIENT_LTC_ROOM_PHONE_ID ;;
  }

  dimension: patient_mobile_phone_id {
    type: string #ERXDWPS-5137
    hidden: yes
    label: "Store Patient Mobile Phone ID"
    sql: ${TABLE}.PATIENT_MOBILE_PHONE_ID ;;
  }

  dimension: patient_primary_prescriber_id {
    type: string
    hidden: yes
    label: "Store Patient Primary Prescriber ID"
    sql: ${TABLE}.PATIENT_PRIMARY_PRESCRIBER_ID ;;
  }

  dimension: patient_primary_prescriber_clinic_link_id {
    type: number
    hidden: yes
    label: "Store Patient Primary Prescriber Clinic Link ID"
    sql: ${TABLE}.PATIENT_PRIMARY_PRESCRIBER_CLINIC_LINK_ID ;;
  }

  dimension: patient_otc_price_code_id {
    type: string
    hidden: yes
    label: "Store Patient OTC Price Code ID"
    sql: ${TABLE}.PATIENT_OTC_PRICE_CODE_ID ;;
  }

  dimension: patient_price_code_id {
    type: string
    hidden: yes
    label: "Store Patient Price Code ID"
    sql: ${TABLE}.PATIENT_PRICE_CODE_ID ;;
  }

  dimension: patient_tax_id {
    type: number
    hidden: yes
    label: "Store Patient Tax ID"
    sql: ${TABLE}.PATIENT_TAX_ID ;;
  }

  dimension: patient_responsible_party_patient_id {
    type: string
    hidden: yes
    label: "Store Patient Responsible Party Patient ID"
    sql: ${TABLE}.PATIENT_RESPONSIBLE_PARTY_PATIENT_ID ;;
  }

  dimension: patient_merge_to_patient_id {
    type: string
    hidden: yes
    label: "Store Patient Merge To Patient ID"
    sql: ${TABLE}.PATIENT_MERGE_TO_PATIENT_ID ;;
  }

  dimension: patient_image_cross_ref_id {
    type: number
    hidden: yes
    label: "Store Patient Image Cross Ref ID"
    description: "Patient Information Form Scanned Image ID Number."
    sql: ${TABLE}.IMAGE_CROSS_REF_ID ;;
  }

  dimension: patient_alternate_responsible_party_patient_id {
    type: string
    hidden: yes
    label: "Store Patient Alternate Responsible Party Patient ID"
    description: "Alternate responsible party, AR"
    sql: ${TABLE}.PATIENT_ALTERNATE_RESPONSIBLE_PARTY_PATIENT_ID ;;
  }
  ################################################################################################# Dimensions #################################################################################################
  dimension: patient_first_name {
    type: string
    label: "Store Patient First Name"
    description: "Patient First Name. EPS Table Name: PATIENT"
    sql: UPPER(${TABLE}.PATIENT_FIRST_NAME) ;;
  }

  dimension: patient_middle_name {
    type: string
    label: "Store Patient Middle Name"
    description: "Patient Middle Name. Middle Name is user entered via the client or can be returned to the client from a patient select response from EPR. EPS Table Name: PATIENT"
    sql: UPPER(${TABLE}.PATIENT_MIDDLE_NAME) ;;
  }

  dimension: patient_last_name {
    type: string
    label: "Store Patient Last Name"
    description: "Patient Last Name."
    sql: UPPER(${TABLE}.PATIENT_LAST_NAME) ;;
  }

  dimension: patient_race {
    type: string
    label: "Store Patient Race"
    description: "Represents the patient's race. RACE is set manually by the user in the client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_RACE IS NULL THEN 'UNKNOWN'
              WHEN ${TABLE}.PATIENT_RACE = 'A' THEN 'ASIAN'
              WHEN ${TABLE}.PATIENT_RACE = 'B' THEN 'AFRICAN AMERICAN'
              WHEN ${TABLE}.PATIENT_RACE = 'H' THEN 'HISPANIC'
              WHEN ${TABLE}.PATIENT_RACE = 'I' THEN 'AMERICAN INDIAN'
              WHEN ${TABLE}.PATIENT_RACE = 'O' THEN 'OTHER'
              WHEN ${TABLE}.PATIENT_RACE = 'W' THEN 'CAUCASIAN'
              WHEN ${TABLE}.PATIENT_RACE = 'P' THEN 'PACIFIC ISLANDER'
              WHEN ${TABLE}.PATIENT_RACE = 'T' THEN 'TWO OR MORE'
              ELSE ${TABLE}.PATIENT_RACE --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["UNKNOWN","ASIAN","AFRICAN AMERICAN","HISPANIC","AMERICAN INDIAN","OTHER","CAUCASIAN","PACIFIC ISLANDER","TWO OR MORE"]
  }

  dimension: patient_gender {
    type: string
    label: "Store Patient Gender"
    description: "Represents the patient's gender. GENDER is user entered via the client or can be returned to the client from a patient select response from EPR. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_GENDER = 'F' THEN 'FEMALE'
              WHEN ${TABLE}.PATIENT_GENDER = 'M' THEN 'MALE'
              WHEN ${TABLE}.PATIENT_GENDER = 'U' THEN 'UNKNOWN'
              ELSE ${TABLE}.PATIENT_GENDER --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["FEMALE","MALE","UNKNOWN"]
  }

  dimension: patient_marital_status {
    type: string
    label: "Store Patient Marital Status"
    description: "Represents the patient's marital status. MARITAL STATUS is manually entered by user via a client dropdown. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_MARITAL_STATUS IS NULL THEN 'UNKNOWN'
              WHEN ${TABLE}.PATIENT_MARITAL_STATUS = 'M' THEN 'MARRIED'
              WHEN ${TABLE}.PATIENT_MARITAL_STATUS = 'S' THEN 'SINGLE'
              WHEN ${TABLE}.PATIENT_MARITAL_STATUS = 'O' THEN 'OTHER'
              ELSE ${TABLE}.PATIENT_MARITAL_STATUS --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["UNKNOWN","MARRIED","SINGLE","OTHER"]
  }

  dimension: patient_language {
    type: string
    label: "Store Patient Language"
    description: "Represents the patient's language code. LANG is manually entered by the user via a client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_LANGUAGE = 'en' THEN 'ENGLISH'
              WHEN ${TABLE}.PATIENT_LANGUAGE = 'es' THEN 'SPANISH'
              WHEN ${TABLE}.PATIENT_LANGUAGE = 'fr' THEN 'FRENCH'
              ELSE ${TABLE}.PATIENT_LANGUAGE --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["ENGLISH","SPANISH","FRENCH"]
  }

  dimension: patient_medical_record_number {
    type: string
    label: "Store Patient Medical Record Number"
    description: "Represents the patient's medical record number. MEDICAL RECORD NUMBER is manually entered by a user via a client. Example: 'A378B2689'. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MEDICAL_RECORD_NUMBER ;;
  }

  dimension: patient_multi_birth {
    type: string
    label: "Store Patient Multi Birth"
    description: "Indicate the multiple birth status of patient; that is, twins, triplets, etc. MULTIBIRTH is set manually by a user via the client or can be returned to the client from a patient select response from EPR. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_MULTIBIRTH IS NULL THEN 'NO'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '1' THEN 'NO' --Added based on Data Dictionary and Table values. Not available in D_MASTER_CODE table.
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '2' THEN 'TWIN'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '3' THEN 'TRIPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '4' THEN 'QUADRUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '5' THEN 'QUINTUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '6' THEN 'SEXTUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '7' THEN 'SEPTUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '8' THEN 'OCTUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = '9' THEN 'NONUPLET'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = 'Y' THEN 'TWIN'
              WHEN ${TABLE}.PATIENT_MULTIBIRTH = 'N' THEN 'NO'
         END ;;
    suggestions: ["NO","TWIN","TRIPLET","QUADRUPLET","QUINTUPLET","SEXTUPLET","SEPTUPLET","OCTUPLET","NONUPLET"]
  }

  dimension: patient_birth_order {
    type: number
    label: "Store Patient Birth Order"
    description: "Represents the ordinal position of a child in a multi birth. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_BIRTH_ORDER ;;
  }

  dimension: patient_height {
    type: number
    label: "Store Patient Height"
    description: "Represents the patient's Height. HEIGHT is user entered via a client or it can be returned in a select patient response from EPR. If the Metric_Measure field is 'Y' this field will be stored and displayed as centimeters. If the Metric_Measure field is 'N' this field will be stored and displayed as inches. Example: 75.25. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_HEIGHT ;;
  }

  dimension: patient_weight {
    type: number
    label: "Store Patient Weight"
    description: "Represents the patient's weight. WEIGHT is entered manually by a user via the client. If the Metric Measure field is 'Y' this field will be stored and displayed as kilograms. If the Metric Measure field is 'N', this field will be stored and displayed as pounds. Example: 125.25. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_WEIGHT ;;
  }

  dimension: patient_driver_license {
    type: string
    label: "Store Patient Driver License"
    description: "Represents the Patient record's driver's license number. DRIVER LICENSE is user entered via the client or can be returned in a patient select response from EPR.Example: '712834545'. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DRIVER_LICENSE ;;
  }

  dimension: patient_driver_license_state {
    type: string
    label: "Store Patient Driver License State"
    description: "represents the state or province in which a patient's driver's license was issued. DRIVER LICENSE_STATE is user entered via the client or can be returned in a patient select response from EPR. Example: OK. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DRIVER_LICENSE_STATE ;;
  }

  dimension: patient_safety_cap_flag {
    type: string
    label: "Store Patient Safety Cap Flag"
    description: "Specifies the patients preference for safety caps. SAFETY CAP FLAG is manually entered by a user via the client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_SAFETY_CAP_FLAG = 'N' THEN 'NO SAFETY CAPS'
              WHEN ${TABLE}.PATIENT_SAFETY_CAP_FLAG = 'Y' THEN 'SAFETY CAPS'
              ELSE ${TABLE}.PATIENT_SAFETY_CAP_FLAG --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["NO SAFETY CAPS","SAFETY CAPS"]
  }

  dimension: patient_loyalty_card_number {
    type: string
    label: "Store Patient Loyalty Card Number"
    description: "Represents the patient's loyalty card number. LOYALTY CARD NUMBER is entered manually by the user via the client. Free-format field. Example: 23424-4783-33. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LOYALTY_CARD_NUMBER ;;
  }

  dimension: patient_md5_opt_out_flag {
    type: yesno
    label: "Store Patient MDS OPT Out Flag"
    description: "Yes/No Flag indicating if the patient is setup to receive MDS program services. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MDS_OPT_OUT_FLAG = 'Y' ;;
  }

  dimension: patient_Category {
    type: string
    label: "Store Patient Category"
    description: "Representing the patient category. This can be used for grouping patient records and reporting. CATEGORY is user entered via the client or can be returned to the client from a patient select response from EPR. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_CATEGORY ;;
  }

  dimension: patient_daw_flag {
    type: yesno
    label: "Store Patient DAW Flag"
    description: "Yes/No Flag indicating if the prescription's DAW code should be defaulted to the patient DAW when filling a prescription. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DAW_FLAG = 'Y' ;;
  }

  dimension: patient_group_number{
    type: string
    label: "Store Patient Group Number"
    description: "Represents the patient group. This can be used for grouping patient records and reporting. GROUP NUMBER is user entered via the client or can be returned to the client from a patient select response from EPR. The patient group code may be linked to a user-defined record in the Quick Text File which provides a short description of the patient category. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_GROUP_NUMBER ;;
  }

  dimension: patient_label {
    type: string
    label: "Store Patient Label"
    description: "Code indicating the label type that should be used when printing a label for a patient. LABEL is manually entered by user via a client. Note this is not used by EPS. It is kept for Central Patient reasons. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LABEL ;;
  }

  dimension: patient_metric_measure_flag {
    type: yesno
    label: "Store Patient Metric Measure Flag"
    description: "Yes/No Flag indicating if patient weight is measured in kilograms or pounds and patient height is measured in centimeters or inches METRIC_MEASURE is entered manually by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_METRIC_MEASURE_FLAG = 'Y' ;;
  }

  dimension: patient_no_central_fill_flag {
    type: yesno
    label: "Store Patient No Central Fill Flag"
    description: "Yes/No Flag indicating if prescriptions for a patient may be sent to Central Fill or SBMO (for store delivery) NO CF is manually entered by a user via a client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NO_CENTRAL_FILL_FLAG = 'Y' ;;
  }

  dimension: patient_no_compliance_flag {
    type: yesno
    label: "Store Patient No Compliance Flag"
    description: "Yes/No Flag indicating if compliance monitoring should be performed for this patient. NO COMPLIANCE should be manually entered by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NO_COMPLIANCE_FLAG = 'Y' ;;
  }

  dimension: patient_disallow_autofill {
    type: string
    label: "Store Patient Disallow Autofill"
    description: "Flag indicating if prescriptions for a patient may be auto-filled. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_DISALLOW_AUTOFILL = 'N' THEN 'ASK'
              WHEN ${TABLE}.PATIENT_DISALLOW_AUTOFILL = 'Y' THEN 'YES'
              WHEN ${TABLE}.PATIENT_DISALLOW_AUTOFILL = 'A' THEN 'ENROLL'
              ELSE ${TABLE}.PATIENT_DISALLOW_AUTOFILL --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["ASK","YES","ENROLL"]
  }

  dimension: patient_call_for_refills {
    type: string
    label: "Store Patient Call For Refills"
    description: "Contains instructions indicating the actions to take when a prescription that is being auto-filled has no refills remaining or is expired CALL FOR REFILLS is manually entered by a user via the client. Unless this element is blank, this element overrides the element on the Store record indicating what actions to take when auto-filling prescriptions that are expired or have zero refills remaining. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_CALL_FOR_REFILLS IS NULL THEN 'USE STORE DEFAULTS'
              WHEN ${TABLE}.PATIENT_CALL_FOR_REFILLS = 'D' THEN 'CALL DOCTOR'
              WHEN ${TABLE}.PATIENT_CALL_FOR_REFILLS = 'P' THEN 'NOTIFY PATIENT'
              WHEN ${TABLE}.PATIENT_CALL_FOR_REFILLS = 'N' THEN 'DO NOT REFILL'
              ELSE ${TABLE}.PATIENT_CALL_FOR_REFILLS --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["USE STORE DEFAULTS","CALL DOCTOR","NOTIFY PATIENT","DO NOT REFILL"]
  }

  dimension: patient_no_transfer_flag {
    type: string
    label: "Store Patient No Transfer Flag"
    description: "Flag indicates if the patient has opted out of EPR, meaning their prescriptions will not be shared with other stores.  NO TRANSFER is manually entered by a user via the client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_NO_TRANSFER_FLAG = 'N' THEN 'ALLOW TRANSFER'
              WHEN ${TABLE}.PATIENT_NO_TRANSFER_FLAG = 'Y' THEN 'NO TRANSFER'
         END ;;
    suggestions: ["ALLOW TRANSFER","NO TRANSFER"]
  }

  dimension: patient_no_disease_management_flag {
    type: string
    label: "Store Patient No Disease Management Flag"
    description: "Flag indicates if disease management modules should be performed for this patient. NO DISEASE MANAGEMENT is manually entered by a user via the client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_NO_DISEASE_MANAGEMENT_FLAG = 'N' THEN 'PERFORM DISEASE MANAGEMENT'
              WHEN ${TABLE}.PATIENT_NO_DISEASE_MANAGEMENT_FLAG = 'Y' THEN 'DO NOT PERFORM DISEASE MANAGEMENT'
         END ;;
    suggestions: ["PERFORM DISEASE MANAGEMENT","DO NOT PERFORM DISEASE MANAGEMENT"]
  }

  dimension: patient_number_of_labels {
    type: string
    label: "Store Patient Number of Labels"
    description: "Represents the total number of labels to print each time an Rx label is printed for this patient. NUM LABELS is manually entered by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NUMBER_OF_LABELS ;;
  }

  dimension: patient_omit_dur_flag {
    type: yesno
    label: "Store Patient Omit DUR Flag"
    description: "Yes/No Flag indicating if DUR checking should be omitted for a patient. OMIT DUR is entered by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_OMIT_DUR_FLAG = 'Y' ;;
  }

  dimension: patient_partial_cii_fill_flag {
    type: string
    label: "Store Patient Partial CII Fill Flag"
    description: "Flag indicating if the patient is allowed to receive partial fills on a schedule II drug. PARTIAL_CII_FILL is set manually by a user via the client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_PARTIAL_CII_FILL_FLAG = 'N' THEN 'NO PARTIAL'
              WHEN ${TABLE}.PATIENT_PARTIAL_CII_FILL_FLAG = 'Y' THEN 'ALLOW PARTIAL'
         END ;;
    suggestions: ["NO PARTIAL","ALLOW PARTIAL"]
  }

  dimension: patient_social_security_number {
    type: string
    hidden: yes
    label: "Store Patient Social Security Number"
    description: "SSN represents the patient's social security number. SSN is entered manually by a user via the client. Example: '123-45-6789'. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SOCIAL_SECURITY_NUMBER ;;
  }

  dimension: patient_sub_group_code {
    type: string
    label: "Store Patient Sub Group Code"
    description: "Code representing patient's sub-group. This can be used for grouping patient records and reporting. SUB GROUP is user entered via the client or can be returned to the client from a patient select response from EPR. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SUB_GROUP_CODE ;;
  }

  dimension: patient_mail_option {
    type: string
    label: "Store Patient Mail Option"
    description: "Unique number identifying a patient's default mail type. MAIL OPTION is manually entered via a client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_MAIL_OPTION IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PATIENT_MAIL_OPTION = '1' THEN 'STANDARD'
              WHEN ${TABLE}.PATIENT_MAIL_OPTION = '2' THEN 'SECOND DAY'
              WHEN ${TABLE}.PATIENT_MAIL_OPTION = '3' THEN 'OVERNIGHT'
         END ;;
    suggestions: ["NOT SPECIFIED","STANDARD","SECOND DAY","OVERNIGHT"]
  }

  dimension: patient_tax_exempt_flag {
    type: string
    label: "Store Patient Tax Exempt Flag"
    description: "Flag indicating whether a patient is tax exempt. TAX EXEMPT is set manually by a user via the client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_TAX_EXEMPT_FLAG = 'N' THEN 'NO'
              WHEN ${TABLE}.PATIENT_TAX_EXEMPT_FLAG = 'Y' THEN 'YES'
              ELSE ${TABLE}.PATIENT_TAX_EXEMPT_FLAG --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["YES","NO"]
  }

  dimension: patient_delivery_preference {
    type: string
    label: "Store Patient Delivery Preference"
    description: "Patient's delivery preference for prescriptions. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_DELIVERY_PREFERENCE = 'N' THEN 'NO'
              WHEN ${TABLE}.PATIENT_DELIVERY_PREFERENCE = 'Y' THEN 'YES'
              WHEN ${TABLE}.PATIENT_DELIVERY_PREFERENCE = 'M' THEN 'MAIL'
              WHEN ${TABLE}.PATIENT_DELIVERY_PREFERENCE = 'P' THEN 'PICKUP'
              WHEN ${TABLE}.PATIENT_DELIVERY_PREFERENCE = 'BLANK' THEN 'NO'
              ELSE PATIENT_DELIVERY_PREFERENCE --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["NO","YES","MAIL","PICKUP"]
  }

  dimension: patient_delivery_note {
    type: string
    label: "Store Patient Delivery Note"
    description: "Delivery specific comment to the patient's profile. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DELIVERY_NOTE ;;
  }

  dimension: patient_record_type {
    type: string
    label: "Store Patient Record Type"
    description: "Specifies the type of record this is being used for.  RECORD TYPE is set manually by a user via a client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_RECORD_TYPE = '0' THEN 'PATIENT'
              WHEN ${TABLE}.PATIENT_RECORD_TYPE = '1' THEN 'ANIMAL (EPR,PDX)/OFFICE (EPS)'
              WHEN ${TABLE}.PATIENT_RECORD_TYPE = '2' THEN 'PATIENT (EPR,PDX)/ANIMAL (EPS)'
              ELSE TO_CHAR(${TABLE}.PATIENT_RECORD_TYPE) --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["PATIENT","ANIMAL (EPR,PDX)/OFFICE (EPS)","PATIENT (EPR,PDX)/ANIMAL (EPS)"]
  }

  dimension: patient_animal_type {
    type: string
    label: "Store Patient Animal Type"
    description: "Specify a more detailed description of the animal if patient RECORD TYPE is set to 'Animal'. ANIMAL TYPE is manually entered by a user via a client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ANIMAL_TYPE ;;
  }

  dimension: patient_profession {
    type: string
    label: "Store Patient Profession"
    description: "PROFESSION is used to document the patient's profession or credentials.  PROFESSION is manually enetered by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_PROFESSION ;;
  }

  dimension: patient_suffix {
    type: string
    label: "Store Patient Suffix"
    description: "Represents the patient's name suffix. SUFFIX is manually enetered by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SUFFIX ;;
  }

  dimension: patient_personal_identification_number {
    type: string
    label: "Store Patient Personal Identification Number"
    description: "Represents the patient's personal identification number used for remote profile access. Manually Entered. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_PERSONAL_IDENTIFICATION_NUMBER ;;
  }

  dimension: patient_contact_preference_type{
    type: string
    label: "Store Patient Contact Preference Type"
    description: "Patient's preferred method of contact User selected/entered. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '0' THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '1' THEN 'PHONE'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '2' THEN 'EMAIL'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '3' THEN 'FAX'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '5' THEN 'ERX'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '6' THEN 'WEB'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE = '7' THEN 'IVR'
              WHEN ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE IS NULL THEN 'NOT SPECIFIED'
              ELSE ${TABLE}.PATIENT_CONTACT_PREFERENCE_TYPE --displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["NOT SPECIFIED","PHONE","EMAIL","FAX","ERX","WEB","IVR"]
  }

  dimension: patient_require_id_pickup {
    type: string
    label: "Store Patient Require ID Pickup"
    description: "Indicates whether an ID is required to pick-up this patient's prescriptions, and which schedule drug requires it. REQUIRE ID PICKUP is manually set by a user via the client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP IS NULL THEN 'NOT REQUIRED'
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '1' THEN 'ALL PRESCRIPTIONS' --Changed A to 1. Did testing with Kelly to confirm it is A.
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '2' THEN 'SCHEDULE 2 ONLY'
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '3' THEN 'SCHEDULE 3 AND BELOW'
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '4' THEN 'SCHEDULE 4 AND BELOW'
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '5' THEN 'SCHEDULE 5 AND BELOW'
              WHEN ${TABLE}.PATIENT_REQUIRE_ID_PICKUP = '6' THEN 'SCHEDULE 6 AND BELOW'
         END ;;
    suggestions: ["NOT REQUIRED","ALL PRESCRIPTIONS","SCHEDULE 2 ONLY","SCHEDULE 3 AND BELOW","SCHEDULE 4 AND BELOW","SCHEDULE 5 AND BELOW","SCHEDULE 6 AND BELOW"]
  }

  dimension: patient_require_unit_dose_flag {
    type: yesno
    label: "Store Patient Require Unit Dose Flag"
    description: "Yes/No Flag indicating whether the patient requests unit dose packing. REQUIRE UNIT DOSE is set manually by a user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_REQUIRE_UNIT_DOSE_FLAG = 'Y' ;;
  }

  dimension: patient_possible_duplicate_skip_count {
    type: number
    label: "Store Patient Possible Duplicate Skip Count"
    description: "Tracks the number of times a user has skipped dealing with possible duplicate patient records. POSSIBLE DUPLICATE SKIP COUNT is set by the client after a user is presented with a possible duplicates situation. This number is re-set to zero (0) once a user reviews the possible duplicate patient records associated with this patient record. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_POSSIBLE_DUPLICATE_SKIP_COUNT ;;
  }

  dimension: patient_autoplay_flag {
    type: yesno
    label: "Store Patient Autopay Flag"
    description: "Yes/No Flag indicating whether this patient has authorized use of the 'AutoPay' (AKA 'Prepay') feature, whereby the patient balance due per prescription up to the limit of the patient's AutoPay RX Dollar Limit is charged to the patient's credit card before pick-up or delivery. AUTOPAY is set manually by the user via the client. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_AUTOPAY_FLAG = 'Y' ;;
  }

  dimension: patient_bottle_ring_color{
    type: string
    label: "Store Patient Bottle Ring Color"
    description: "Represents this patient's prescription bottle collar ring color. This is used by patients to easily identify their prescriptions when in the mix with other patient's prescriptions. BOTTLE RING COLOR is manually set by the user on the client. DB Value will be displayed when master code value not available in Master Code table. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '0' THEN 'NO SELECTION'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '1' THEN 'RED'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '2' THEN 'ORANGE'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '3' THEN 'YELLOW'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '4' THEN 'GREEN'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '5' THEN 'BLUE'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '6' THEN 'PURPLE'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '7' THEN 'PINK'
              WHEN ${TABLE}.PATIENT_BOTTLE_RING_COLOR = '8' THEN 'NO RING COLOR'
              ELSE TO_CHAR(${TABLE}.PATIENT_BOTTLE_RING_COLOR) ----displaying DB column value if D_MASTER_CODE table do not have an entry
         END ;;
    suggestions: ["NO SELECTION","RED","ORANGE","YELLOW","GREEN","BLUE","PURPLE","PINK","NO RING COLOR"]
  }

  dimension: patient_general_phone_notices {
    type: string
    label: "Store Patient General Phone Notices"
    description: "Patient allows phone notice method of outbound notification for IVR. User selected/entered. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_GENERAL_PHONE_NOTICES IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PATIENT_GENERAL_PHONE_NOTICES = 'C' THEN 'CELL PHONE'
              WHEN ${TABLE}.PATIENT_GENERAL_PHONE_NOTICES = 'D' THEN 'DO NOT GRANT'
              WHEN ${TABLE}.PATIENT_GENERAL_PHONE_NOTICES = 'H' THEN 'HOME PHONE'
              WHEN ${TABLE}.PATIENT_GENERAL_PHONE_NOTICES = 'W' THEN 'WORK PHONE'
         END ;;
    suggestions: ["NOT SPECIFIED","CELL PHONE","DO NOT GRANT","HOME PHONE","WORK PHONE"]
  }

  dimension: patient_general_sms_notices {
    type: string
    label: "Store Patient General SMS Notices"
    description: "Patient allows SMS notice method of outbound notification for IVR. User selected/entered. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_GENERAL_SMS_NOTICES IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PATIENT_GENERAL_SMS_NOTICES = 'S' THEN 'SMS TEXT'
              WHEN ${TABLE}.PATIENT_GENERAL_SMS_NOTICES = 'D' THEN 'DO NOT GRANT'
         END ;;
    suggestions: ["SMS TEXT","DO NOT GRANT"]
  }

  dimension: patient_general_email_notices {
    type: string
    label: "Store Patient General Email Notices"
    description: "Patient allows E-mail notice method of outbound notification for IVR. User selected/entered. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_GENERAL_EMAIL_NOTICES IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PATIENT_GENERAL_EMAIL_NOTICES = 'O' THEN 'SCHOOL EMAIL'
              WHEN ${TABLE}.PATIENT_GENERAL_EMAIL_NOTICES = 'D' THEN 'DO NOT GRANT'
              WHEN ${TABLE}.PATIENT_GENERAL_EMAIL_NOTICES = 'H' THEN 'HOME EMAIL'
              WHEN ${TABLE}.PATIENT_GENERAL_EMAIL_NOTICES = 'W' THEN 'WORK EMAIL'
         END ;;
    suggestions: ["NOT SPECIFIED","SCHOOL EMAIL","DO NOT GRANT","HOME EMAIL","WORK EMAIL"]
  }

  dimension: patient_code {
    type: string
    label: "Store Patient Code"
    description: "Represents the unique code used to identify a patient record from a PDX Classic store. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_CODE ;;
  }

  dimension: patient_registered_with_catalina_flag{
    type: yesno
    label: "Store Patient Registered With Catalina Flag"
    description: "Yes/No Flag indicating whether this patient has been sent to CHR (Catalina HealthResources). System-assigned. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_REGISTERED_WITH_CATALINA_FLAG = 'Y' ;;
  }

  dimension: patient_medigap_identifier {
    type: string
    label: "Store Patient Medigap Identifier"
    description: "Patient s ID assigned by the Medigap insurer. Populated when the user enters and saves a value in the Medigap ID field on the Patient Additional screen. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MEDIGAP_IDENTIFIER ;;
  }

  dimension: patient_mtm_eligibility_flag {
    type: yesno
    label: "Store Patient MTM Eligibility Flag"
    description: "Yes/No Flag indicating if the patient is eligible for MTM or not. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MTM_ELIGIBILITY_FLAG = 'Y' ;;
  }

  dimension: patient_mtm_opt_out_flag {
    type: yesno
    label: "Store Patient MTM OPT Out Flag"
    description: "Yes/No Flag indicating if the patient is setup to receive MTM services. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MTM_OPT_OUT_FLAG = 'Y' ;;
  }

  dimension: patient_clinical_track_name {
    type: string
    label: "Store Patient Clinical Track Name"
    description: "Name for the Clinical Track User defined when creating a new Clinical Track at ECC. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_CLINICAL_TRACK_NAME ;;
  }

  dimension: patient_exclude_from_batch_fill_flag {
    type: yesno
    label: "Store Patient Exclude From Batch Fill Flag"
    description: "Yes/No Flag indicating if the patient is excluded from participating in the batch fill process. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_EXCLUDE_FROM_BATCH_FILL_FLAG = 'Y' ;;
  }

  dimension: patient_ltc_unit {
    type: string
    label: "Store Patient LTC Unit"
    description: "The long term care unit the patient occupies. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_UNIT ;;
  }

  dimension: patient_ltc_ward {
    type: string
    label: "Store Patient LTC Ward"
    description: "The long term care ward that the patient occupies. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_WARD ;;
  }

  dimension: patient_ltc_wing {
    type: string
    label: "Store Patient LTC Wing"
    description: "The long term care wing that the patient occupies."
    sql: ${TABLE}.PATIENT_LTC_WING ;;
  }

  dimension: patient_ltc_room {
    type: string
    label: "Store Patient LTC Room"
    description: "The long term care room that the patient occupies. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_ROOM ;;
  }

  dimension: patient_ltc_bed {
    type: string
    label: "Store Patient LTC Bed"
    description: "The long term care bed that the patient occupies. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_BED ;;
  }

  dimension: patient_ltc_group {
    type: string
    label: "Store Patient LTC Group"
    description: "Groups the patient with other patients at the long term care facility. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_GROUP ;;
  }

  dimension: patient_ltc_power_of_attorney_flag {
    type: yesno
    label: "Store Patient LTC Power Of Attorney Flag"
    description: "Yes/No Flag indicating if the responsible party has power of attorney for the long term care patient. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_POWER_OF_ATTORNEY_FLAG = 'Y' ;;
  }

  dimension: patient_exclude_from_mar_flag {
    type: yesno
    label: "Store Patient Exclude From MAR Flag"
    description: "Yes/No Flag indicating if all of the patient's prescriptions are to be excluded from the MAR's report. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_EXCLUDE_FROM_MAR_FLAG = 'Y' ;;
  }

  dimension: patient_exclude_from_prescriber_order_flag {
    type: yesno
    label: "Store Patient Exclude From Prescriber Order Flag"
    description: "Yes/No Flag indicating if all of the patient's prescriptions are to be excluded from the Physician's Orders report. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_EXCLUDE_FROM_PRESCRIBER_ORDER_FLAG = 'Y' ;;
  }

  dimension: patient_ar_account_number {
    type: string
    label: "Store Patient AR Account Number"
    description: "The AR (Accounts Receivable) account number for the patient. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_AR_ACCOUNT_NUMBER ;;
  }

  dimension: patient_direct_marketing {
    type: string
    label: "Store Patient Direct Marketing"
    description: "Flag that determines the patient's direct marketing decision. The patient can be enrolled in direct marketing as long as none of their active third parties disallow it (plan flag). User entered for the Patient on the Additional screen in Filecabinet. OR this value can be updated by the POS system when the flag is returned in the message from POS. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_DIRECT_MARKETING IS NULL THEN 'ASK PATIENT'
              WHEN ${TABLE}.PATIENT_DIRECT_MARKETING = 'N' THEN 'PATIENT INELIGIBLE'
              WHEN ${TABLE}.PATIENT_DIRECT_MARKETING = 'R' THEN 'PATIENT REFUSED'
              WHEN ${TABLE}.PATIENT_DIRECT_MARKETING = 'Y' THEN 'PATIENT ENROLLED'
              WHEN ${TABLE}.PATIENT_DIRECT_MARKETING = 'E' THEN 'PATIENT ELIGIBLE (ASK)'
         END ;;
    suggestions: ["ASK PATIENT","PATIENT INELIGIBLE","PATIENT REFUSED","PATIENT ENROLLED","PATIENT ELIGIBLE (ASK)"]
  }

  dimension: patient_sync_script_enrollment {
    type: string
    label: "Store Patient Sync Script Enrollment"
    description: "Patient level enrollment in the SyncScript program. User entered. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLMENT IS NULL THEN 'NOT ASKED'
              WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLMENT = 'E' THEN 'ENROLLED'
              WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLMENT = 'R' THEN 'REFUSED'
         END ;;
    suggestions: ["NOT ASKED","ENROLLED","REFUSED"]
  }

  dimension: patient_sync_script_interval {
    type: number
    label: "Store Patient Sync Script Interval"
    description: "Number of days between SyncScript dates. User entered on SyncScript profile screen. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SYNC_SCRIPT_INTERVAL ;;
  }

  dimension: patient_sync_script_enrolled_by {
    type: string
    label: "Store Patient Sync Script Enrolled By"
    description: "Source by which patient was enrolled in SyncScript program System generated. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLED_BY IS NULL THEN 'NOT ENROLLED'
              WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLED_BY = 'P' THEN 'PHARMACY'
              WHEN ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLED_BY = 'I' THEN 'IVR'
         END ;;
    suggestions: ["NOT ENROLLED","PHARMACY","IVR"]
  }

  dimension: patient_pharmasmart_identifier {
    type: string
    label: "Store Patient Pharmasmart Identifier"
    description: "Unique code used to identify patients for PharmaSmart. User entered. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_PHARMASMART_IDENTIFIER ;;
  }

  dimension: patient_allow_acs_flag {
    type: string
    label: "Store Patient Allow ACS Flag"
    description: "Flag indicating whether the patient's prescriptions should be sent to the ACS (if the drug allows ACS). Entered by the user via the client. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_ALLOW_ACS_FLAG = 'Y' THEN 'ALLOW'
              WHEN ${TABLE}.PATIENT_ALLOW_ACS_FLAG = 'N' THEN 'DISALLOW'
         END ;;
    suggestions: ["ALLOW","DISALLOW"]
  }

  dimension: patient_autofill_reject_code {
    type: string
    label: "Store Patient Autofill Reject Reason"
    description: "Indicates a reason why a patient is canceling the Autofill service. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE IS NULL THEN 'NOT REJECTED'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '0' THEN 'NOT REJECTED'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '1' THEN 'DECEASED'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '2' THEN 'INSURANCE'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '3' THEN 'PATIENT CHOICE'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '4' THEN 'AUTOMATION CONCERNS'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '5' THEN 'MOVED/TRANSFERRED'
              WHEN ${TABLE}.PATIENT_AUTOFILL_REJECT_CODE = '6' THEN 'OTHER'
              END ;;
    suggestions: ["NOT REJECTED",
      "DECEASED",
      "INSURANCE",
      "PATIENT CHOICE",
      "AUTOMATION CONCERNS",
      "MOVED/TRANSFERRED",
      "OTHER"]
  }

  dimension: patient_sync_script_reject_code {
    type: string
    label: "Store Patient Sync Script Reject Reason"
    description: "Indicates a reason why a patient is canceling the SyncScript service. EPS Table Name: PATIENT"
    sql: CASE WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE IS NULL THEN 'NOT REJECTED'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '1' THEN 'DECEASED'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '2' THEN 'INSURANCE'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '3' THEN 'PATIENT CHOICE'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '4' THEN 'AUTOMATION CONCERNS'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '5' THEN 'MOVED/TRANSFERRED'
              WHEN ${TABLE}.PATIENT_SYNCSCRIPT_REJECT_CODE = '6' THEN 'OTHER'
         END ;;
    suggestions: ["NOT REJECTED",
      "DECEASED",
      "INSURANCE",
      "PATIENT CHOICE",
      "AUTOMATION CONCERNS",
      "MOVED/TRANSFERRED",
      "OTHER"]
  }

  dimension: patient_no_automated_calls_flag {
    type: yesno
    label: "Store Patient No Automated Calls Flag"
    description: "Yes/No Flag on the Patient file to indicate if the patient does not want automated calls. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NO_AUTOMATED_CALLS_FLAG = 'Y' ;;
  }

  dimension: patient_verify_phone_flag {
    type: yesno
    label: "Store Patient Verify Phone Flag"
    description: "Yes/No Flag indicating if a patient requires their contact information updated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_VERIFY_PHONE_FLAG = 'Y' ;;
  }

  dimension: patient_loyalty_card_opt_out_flag {
    type: yesno
    label: "Store Patient Loyalty Card OPT Out Flag"
    description: "Yes/No Flag indicating if patient wants to opt in / opt out for loyalty card number. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LOYALTY_CARD_OPT_OUT_FLAG = 'Y' ;;
  }

  dimension: patient_private_profile_flag {
    type: yesno
    label: "Store Patient Private Profile Flag"
    description: "Yes/No Flag inficating if a patient profile is to be treated as private in the pharmacy application systems. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_PRIVATE_PROFILE_FLAG = 'Y' ;;
  }

  dimension: patient_private_profile_pin {
    type: string
    label: "Store Patient Private Profile PIN"
    description: "Column which stores the pin to unlock a private profile in the event one is pin protected by the patient. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_PRIVATE_PROFILE_PIN ;;
  }

  dimension: patient_rx_com_upload_flag {
    type: yesno
    label: "Store Patient Rx COM Upload Flag"
    description: "Yes/No Flag Indicating if the patient record will be uploaded to Rx.com during the next background auto-task run. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_RX_COM_UPLOAD_FLAG = 'Y' ;;
  }

  dimension: patient_deactivate_reason_code {
    type: string
    label: "Store Patient Deactivate Reason Code"
    description: "Code used to track why a patient is deactivated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DEACTIVATE_REASON_CODE ;;
  }

  dimension: patient_deactivate_reason_description {
    type: string
    label: "Store Patient Deactivate Reason Description"
    description: "Description to provide a user friendly reason why the patient is deactivated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DEACTIVATE_REASON_DESCRIPTION ;;
  }

  #PDX Classic Specific columns. Start...
  dimension: patient_default_mail_type {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Default Mail Type"
    description: "Default Mail Type. Used for AutoFill if Ship Type set to Mail. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DEFAULT_MAIL_TYPE ;;
  }

  dimension: patient_discount_speed_code {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Discount Speed Code"
    description: "Patient discount code. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DISCOUNT_SPEED_CODE ;;
  }

  dimension: patient_alternate_identification_number {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Alternate Identification Number"
    description: "Patient's alternate ID - State Issued, Military, Passport etc... EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ALTERNATE_IDENTIFICATION_NUMBER ;;
  }

  dimension: patient_alternate_id_issuing_state_or_country {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Alternate ID Issuing State or Country"
    description: "Issuing state/country for patient's alternate ID. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ALTERNATE_ID_ISSUING_STATE_OR_COUNTRY ;;
  }

  dimension: patient_alternate_identification_type{
    type: number
    hidden: yes #PDX Classic Column
    label: "Store Patient Alternate Identification Type"
    description: "Patient Alternate Identification Type. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ALTERNATE_IDENTIFICATION_TYPE ;;
  }

  dimension: patient_active_for_charging_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Active For Charging Flag"
    description: "Activate the current patient displayed for charging. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ACTIVE_FOR_CHARGING_FLAG ;;
  }

  dimension: patient_identification_number_addedndum {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Identification Number Addendum"
    description: "Patient Identification Number Addendum. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_IDENTIFICATION_NUMBER_ADDENDUM ;;
  }

  dimension: patient_has_email_address_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Has Email Address Flag"
    description: "Yes/No Flag indicating if patient has email address. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_HAS_EMAIL_ADDRESS_FLAG ;;
  }

  dimension: patient_free_form_allergy_1 {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Free Form Allergy 1"
    description: "Free Format Allergy 1. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_FREE_FORM_ALLERGY_1 ;;
  }

  dimension: patient_free_form_allergy_2 {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Free Form Allergy 2"
    description: "Free Format Allergy 2. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_FREE_FORM_ALLERGY_2 ;;
  }

  dimension: patient_free_form_allergy_3 {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Free Form Allergy 3"
    description: "Free Format Allergy 3. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_FREE_FORM_ALLERGY_3 ;;
  }

  dimension: patient_dat_label_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient DAT Label Flag"
    description: "Y=Label Type (left) refers to DAT label format. Blank/N=Regular label format. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DAT_LABEL_FLAG ;;
  }

  dimension: patient_ideal_weight{
    type: number
    hidden: yes #PDX Classic Column
    label: "Store Patient Ideal Weight"
    description: "Ideal Body Weight. Calculated using sex, height and age. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_IDEAL_WEIGHT ;;
  }

  dimension: patient_mes_print_code {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient MES Print Code"
    description: "MES print flag. A = Always print. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MES_PRINT_CODE ;;
  }

  dimension: patient_note {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Note"
    description: "Patient Message EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NOTE ;;
  }

  dimension: patient_over_20_allergies_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Ovre 20 Allergies Flag"
    description: "Y = patient has more than 20 allergies. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_OVER_20_ALLERGIES_FLAG ;;
  }

  dimension: patient_over_20_diseases_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Over 20 Diseases Flag"
    description: "Y = patient has more than 20 disease states. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_OVER_20_DISEASES_FLAG ;;
  }

  dimension: patient_multiple_store_code {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Multiple Store Code"
    description: "Flag showing if patient has visited more than one store in network. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MULTIPLE_STORE_CODE ;;
  }

  dimension: patient_nursing_home_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Nursing Home Flag"
    description: "Y to link patient to nursing home. N to unlink. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NURSING_HOME_FLAG ;;
  }

  dimension: patient_no_payment_required_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient No Payment Required Flag"
    description: "Y=No payments are required from  this patient 48029. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_NO_PAYMENT_REQUIRED_FLAG ;;
  }

  dimension: patient_default_shipping_type {
    type: number
    hidden: yes #PDX Classic Column
    label: "Store Patient Default Shipping Type"
    description: "Default Package/Ship Type used for setting the Order Record's ore_shiptype flag. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DEFAULT_SHIPPING_TYPE ;;
  }

  dimension: patient_third_party_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Third Party Flag"
    description: "Flag showing patient linked to a third party. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_THIRD_PARTY_FLAG ;;
  }

  dimension: patient_third_party_split_bill_code {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Third Party Split Bill Code"
    description: "Y=Auto Split Background Only, A=Split All Transactions, N=Do Not Split Bill. Blank - Not Specified. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_THIRD_PARTY_SPLIT_BILL_CODE ;;
  }

  dimension: patient_upload_to_host_flag {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Upload To Host Flag"
    description: "Upload the latest ADD/UPDATE of this record to Host? (Y/N). EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_UPLOAD_TO_HOST_FLAG ;;
  }

  dimension: patient_zone_pricing {
    type: string
    hidden: yes #PDX Classic Column
    label: "Store Patient Zone Pricing"
    description: "Zone Pricing. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_ZONE_PRICING ;;
  }
  #PDX Classic Specific columns. End...

  dimension: patient_event_id {
    type: number
    hidden: yes
    label: "Store Patient Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW. EPS Table Name: PATIENT"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: patient_load_type {
    type: string
    hidden: yes
    label: "Store Patient Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW. EPS Table Name: PATIENT"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  ############################################################################ Date Dimensions #######################################################################################
  dimension_group: patient_birth {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Birth"
    description: "Represents the date of birth for patient record. BIRTH DATE is user entered via the client or can be added by a patient select response from EPR. This is a required element on the patient record. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_BIRTH_DATE ;;
  }

  dimension_group: patient_deceased {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Deceased"
    description: "Represents the patient's deceased date. DECEASED DATE is user inputed via the client or can be returned in a patient select response from EPR. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DECEASED_DATE ;;
  }

  dimension_group: patient_safety_cap_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Safety Cap Update"
    description: "Represents the date and time that the no safety caps flag was updated. SAFETY CAP UPDATED_DATE is populated with the current date and time by the system when the SAFETY CAP element is modified. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SAFETY_CAP_UPDATE_DATE ;;
  }

  dimension_group: patient_majority {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Majority"
    description: "Date when the patient is considered a legal adult if not the standard date (18yrs). EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MAJORITY_DATE ;;
  }

  dimension_group: patient_last_mes {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Last MES"
    description: "Date the system last printed an MES report for the patient. System generated with the current date when an MES report prints. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LAST_MES_DATE ;;
  }

  dimension_group: patient_ltc_admitted {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient LTC Admitted"
    description: "Date/time that the patient was admitted to the long term care facility. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_ADMITTED_DATE ;;
  }

  dimension_group: patient_ltc_discharged {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient LTC Discharged"
    description: "date/time that the patient was discharged from the long term care facility. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LTC_DISCHARGED_DATE ;;
  }

  dimension_group: patient_disallo_autofill_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Disallow Autofill Update"
    description: "Date/time when the patient's AutoFill preference was set/changed. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DISALLOW_AUTOFILL_UPDATE_DATE ;;
  }

  dimension_group: patient_direct_marketing_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Direct Marketing Update"
    description: "Date/time when the patient's direct marketing options were updated. Either a user set or changed the direct marketing preference OR the direct marketing choice was set/updated by the POS. System set when the Direct Marketing preference for the patient is set/updated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DIRECT_MARKETING_UPDATE_DATE ;;
  }

  dimension_group: patient_sync_script_fill {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Sync Script Fill"
    description: "Scheduled date of next SyncScript fill. User entered from SyncScript profile screen. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SYNC_SCRIPT_FILL_DATE ;;
  }

  dimension_group: patient_sync_script_enrollment_date {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Sync Script Enrollment"
    description: "Date patient was enrolled in the SyncScript program. System generated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_SYNC_SCRIPT_ENROLLMENT_DATE ;;
  }

  dimension_group: patient_refill_reminder_opt_in {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Refill Reminder OPT In"
    description: "Date the patient chose to OPT-IN for refill reminders. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_REFILL_REMINDER_OPT_IN_DATE ;;
  }

  dimension_group: patient_refill_reminder_opt_in_refuse {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Refill Reminder OPT In Refuse"
    description: "Date the patient has opted to refuse or discontinue refill reminders. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_REFILL_REMINDER_OPT_IN_REFUSE_DATE ;;
  }

  dimension_group: patient_rx_com_changed {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Rx COM Changed"
    description: "Date the patient record was last changed at Rx.com. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_RX_COM_CHANGED_DATE ;;
  }

  dimension_group: patient_rx_com_duplicate_check {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Rx COM Duplicate Check"
    description: "Date the last duplicate check on this patient was done at Rx.com. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_RX_COM_DUPLICATE_CHECK_DATE ;;
  }

  dimension_group: patient_rx_com_poll {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Rx COM Poll"
    description: "Date the last poll was done for this patient at Rx.com. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_RX_COM_POLL_DATE ;;
  }

  dimension_group: patient_rx_com_notes_last_poll {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Rx COM Notes Last Poll"
    description: "Used to inform EPR the last time a successful PatientNoteSelectResponse was returned to the EPS store. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_RX_COM_NOTES_LAST_POLL_DATE ;;
  }

  dimension_group: patient_merge_to{
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Merge To"
    description: "Date the patient record was merged into another patient record. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_MERGE_TO_DATE ;;
  }

  dimension_group: patient_deactivate {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Deactivate"
    description: "Date a patient record was deactivated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_DEACTIVATE_DATE ;;
  }

  #PDX Classic Specific Date columns. Start...
  dimension_group: patient_information_host_last_pulled {
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Information Host Last Pulled"
    description: "Last date and time Patient Info/DUR Rxs were pulled from Host. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_INFORMATION_HOST_LAST_PULLED_TIMESTAMP ;;
  }

  dimension_group: patient_information_host_last_sent {
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Information Host Last Sent"
    description: "Last date and time Patient Info was sent to Host. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_INFORMATION_HOST_LAST_SENT_TIMESTAMP ;;
  }

  dimension_group: patient_last_update {
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Last Update"
    description: "Last Date Record Updated. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_LAST_UPDATE_DATE ;;
  }
  #PDX Classic Specific Date columns. End...

  dimension_group: patient_source_create_timestamp {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Source Create Timestamp"
    description: "Date and time that the record was created in source table. EPS Table Name: PATIENT"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: patient_soruce_timestamp {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    label: "Store Patient Source Timestamp"
    description: "Date and time at which the record was last updated in the source application. EPS Table Name: PATIENT"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: patient_edw_insert_timestamp {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    hidden: yes
    label: "EDW Insert Timestamp"
    description: "The time at which the record is inserted to EDW."
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: patient_edw_last_update_timestamp {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    hidden: yes
    label: "Store Patient EDW Last Update Timestamp"
    description: "The time at which the record is updated to EDW."
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  #[ERXLPS-2329]
  dimension: store_patient_pharmacy_number {
    type: string
    label: "Store Patient Pharmacy Number"
    description: "Store patient pharmacy number."
    sql: ${eps_patient_store.store_number} ;;
  }

  dimension: store_patient_mobile_number {
    type: string
    label: "Store Patient Mobile Phone Number"
    description: "Store patient mobile number. EPS Table Name: PHONE"
    sql: ${store_patient_mobile_phone.phone_number} ;;
  }

  #[ERXLPS-6239] - New dimnesion related to store patient age.
  dimension: store_patient_age {
    label: "Store Patient Age"
    description: "Store Patient's Age"
    type: number
    sql: CAST((DATEDIFF('DAY',${patient_birth_date},CURRENT_DATE)/365.25) AS NUMBER) ;;
  }

  dimension: store_patient_age_tier {
    label: "Store Patient Age All Tier"
    type: tier
    description: "Store Patient age group distribution"
    sql: ${store_patient_age} ;;
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

  dimension: store_patient_age_tier_0_to_9 {
    label: "Store Patient Age Tier 0-9"
    type: string
    description: "Store age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 0 AND ${store_patient_age} < 10 THEN '0 to 9' END ;; #Add check >= 0. Few patients DOB is in future.
  }

  dimension: store_patient_age_tier_10_to_19 {
    label: "Store Patient Age Tier 10-19"
    type: string
    description: "Store age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 10 AND ${store_patient_age} < 20 THEN '10 to 19' END ;;
  }

  dimension: store_patient_age_tier_20_to_29 {
    label: "Store Patient Age Tier 20-29"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 20 AND ${store_patient_age} < 30 THEN '20 to 29' END ;;
  }

  dimension: store_patient_age_tier_30_to_39 {
    label: "Store Patient Age Tier 30-39"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 30 AND ${store_patient_age} < 40 THEN '30 to 39' END ;;
  }
  dimension: store_patient_age_tier_40_to_49 {
    label: "Store Patient Age Tier 40-49"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 40 AND ${store_patient_age} < 50 THEN '40 to 49' END ;;
  }

  dimension: store_patient_age_tier_50_to_59 {
    label: "Store Patient Age Tier 50-59"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 50 AND ${store_patient_age} < 60 THEN '50 to 59' END ;;
  }

  dimension: store_patient_age_tier_60_to_64 {
    label: "Store Patient Age Tier 60-64"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 60 AND ${store_patient_age} < 65 THEN '60 to 64' END ;;
  }

  dimension: store_patient_age_tier_65_to_69 {
    label: "Store Patient Age Tier 65-69"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 65 AND ${store_patient_age} < 70 THEN '65 to 69' END ;;
  }

  dimension: store_patient_age_tier_65_plus {
    label: "Store Patient Age Tier 65+"
    type: string
    description: "Store Patient age group distribution"
    sql: CASE WHEN ${store_patient_age} >= 65 THEN '65+' END ;;
  }

  #ERXDWPS-7256 - Sync EPS PATIENT to EDW | Start
  dimension_group: patient_mobile_services_ask {
    label:"Store Patient Mobile Services Ask"
    description:"Date/time the patient was last asked to enroll in Mobile Services"
    type: time
    sql: ${TABLE}.PATIENT_MOBILE_SERVICES_ASK_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: patient_visually_impaired_reference {
    label:"Store Patient Visually Impaired"
    description:"This flag is used to indicate if the patient is visually impaired."
    type: string
    hidden: yes
    sql: ${TABLE}.PATIENT_VISUALLY_IMPAIRED ;;
  }

  dimension: patient_visually_impaired {
    label:"Store Patient Visually Impaired"
    description:"This flag is used to indicate if the patient is visually impaired."
    type: string
    sql: CASE WHEN ${TABLE}.PATIENT_VISUALLY_IMPAIRED IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.PATIENT_VISUALLY_IMPAIRED = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.PATIENT_VISUALLY_IMPAIRED = 'N' THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [patient_visually_impaired_reference]
  }

  dimension_group: patient_sync_script_refused {
    label:"Store Patient Sync Script Refused"
    description:"Date/Time the patient refused enrollment into Sync Script"
    type: time
    sql: ${TABLE}.PATIENT_SYNC_SCRIPT_REFUSED_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  #ERXDWPS-7256 - Sync EPS PATIENT to EDW | End

  ############################################################# measures #################################################################
  measure: patient_total_price_amount {
    type: sum
    hidden: yes #PDX Classic Column
    label: "Store Patient Total Price Amount"
    description: "Total dollars worth of Rx's for this patient. Includes tax. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_TOTAL_PRICE_AMOUNT ;;
  }

  measure: patient_total_prescription_count {
    type: sum
    hidden: yes #PDX Classic Column
    label: "Store Patient Total Prescription Count"
    description: "Number of prescriptions accumulator. EPS Table Name: PATIENT"
    sql: ${TABLE}.PATIENT_TOTAL_PRESCRIPTION_COUNT ;;
  }

  measure: store_patient_count {
    label: "Store Patient Count"
    description: "Total Store Patients. EPS Table Name: PATIENT"
    type: count
  }

  measure: store_patient_count_central_patient_explore {
    label: "Store Patient Count*"
    description: "Total Store Patients with RX COM ID populated. EPS Table Name: PATIENT"
    type: count_distinct
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_com_id} ;;
  }

  ############################################################# Sets ########################################################################
  set: explore_dx_store_patient_age_tier_candidate_list {
    fields: [
      store_patient_age,
      store_patient_age_tier,
      store_patient_age_tier_0_to_9,
      store_patient_age_tier_10_to_19,
      store_patient_age_tier_20_to_29,
      store_patient_age_tier_30_to_39,
      store_patient_age_tier_40_to_49,
      store_patient_age_tier_50_to_59,
      store_patient_age_tier_60_to_64,
      store_patient_age_tier_65_to_69,
      store_patient_age_tier_65_plus
    ]
  }
}

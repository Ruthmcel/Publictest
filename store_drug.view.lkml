view: store_drug {
  sql_table_name: EDW.D_STORE_DRUG ;;

  dimension: drug_id {
    type: string
    hidden: yes
    label: "Drug ID"
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Drug Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Drug NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: gpi_identifier {
    # Exposing this field, so we can determine what's in the pharmacy vs. host
    hidden: no
    type: string
    label: "Drug GPI"
    description: "Generic Product Identifier"
    sql: ${TABLE}.STORE_DRUG_GPI ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: competitive_pricing_id {
    hidden: yes
    type: string
    label: "Drug Competitive Pricing ID"
    sql: ${TABLE}.STORE_DRUG_COMPETITIVE_PRICING_ID ;;
  }

  dimension: notes_id {
    hidden: yes
    type: number
    label: "Drug Notes ID"
    sql: ${TABLE}.STORE_DRUG_NOTES_ID ;;
  }

  dimension: price_code_id {
    hidden: yes
    type: string
    label: "Drug Price Code ID"
    sql: ${TABLE}.STORE_DRUG_PRICE_CODE_ID ;;
  }

  dimension: drug_cost_type_id {
    hidden: yes
    type: string
    label: "Drug Cost Type ID"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE_ID ;;
  }

  dimension: commercial_drug_id {
    hidden: yes
    type: string
    label: "Pharmacy Commercial Drug ID"
    # circular reference
    sql: ${TABLE}.STORE_DRUG_COMMERCIAL_DRUG_ID ;;
  }

  dimension: reorder_drug_id {
    hidden: yes
    type: number
    label: "Pharmacy Reorder Drug ID"
    # circular reference
    sql: ${TABLE}.REORDER_DRUG_ID ;;
  }

  dimension: reference_drug_id {
    hidden: yes
    type: number
    label: "Pharmacy Reference Drug ID"
    # circular reference
    sql: ${TABLE}.REFERENCE_DRUG_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################
  dimension: ndc {
    type: string
    label: "Drug NDC"
    description: "National Drug Code Identifier"
    sql: ${TABLE}.STORE_DRUG_NDC ;;
  }

  dimension: drug_ndc_9 {
    type: string
    label: "Drug NDC 9"
    description: "First 9 Digits of NDC"
    sql: substring(${TABLE}.STORE_DRUG_NDC, 1, 9) ;;
  }

  dimension: drug_code {
    type: string
    label: "Drug Code"
    description: "User Defined Code to uniquely identify a drug record"
    sql: ${TABLE}.STORE_DRUG_CODE ;;
  }

  dimension: allergy_code {
    type: string
    label: "Drug Allergy Code"
    description: "Medi-Span allergy, or allerchek, code which corresponds with the drug or its class of drugs"
    sql: ${TABLE}.STORE_DRUG_ALLERGY_CODE ;;
  }

  dimension: drug_ddid {
    type: number
    label: "Drug DDID"
    description: "Medi-Span specific Dispensable Drug Identifier which identifies a unique combination of Drug name, Route, Dosage Form, Strength, and Strength Unit of Measure"
    sql: ${TABLE}.STORE_DRUG_DDID ;;
    # ERXLPS-199 Change to ensure commas are not shown
    value_format: "###0"
  }

  dimension: drug_name {
    type: string
    label: "Dispensed Drug Name"
    description: "Shorter Dispensed Drug Name"
    sql: ${TABLE}.STORE_DRUG_NAME ;;
  }

  #[ERXLPS-645] New dimension added for Prescribed Drug Name
  dimension: prescribed_drug_name {
    type: string
    label: "Prescribed Drug Name"
    description: "Shorter Prescribed Drug Name"
    sql: ${TABLE}.STORE_DRUG_NAME ;;
  }

  dimension: drug_full_name {
    type: string
    label: "Drug Name - Full"
    description: "Extended drug name"
    sql: ${TABLE}.STORE_DRUG_FULL_NAME ;;
  }

  dimension: drug_full_generic_name {
    type: string
    label: "Drug Generic Name - Full"
    description: "Full generic or chemical name of the drug mainly used for products which have a longer drug name than what is allowed in the Drug Name column"
    sql: ${TABLE}.STORE_DRUG_FULL_GENERIC_NAME ;;
  }

  dimension: drug_generic_name {
    type: string
    label: "Drug Generic Name"
    description: "Shorter generic or chemical description of drug irrespective of the manufacturer. It is usually considered the official nonproprietary name of the drug, under which it is licensed and identified by the manufacturer."
    sql: ${TABLE}.STORE_DRUG_GENERIC_NAME ;;
  }

  dimension: drug_user_defined_name {
    type: string
    label: "Drug Name - User Defined"
    description: "Customer defined Drug Name. Extended version of the Drug Name. Free Formatted field. When populated, this name is used for display"
    sql: ${TABLE}.STORE_DRUG_USER_DEFINED_NAME ;;
  }

  dimension: drug_barcode {
    type: string
    label: "Drug Barcode"
    description: "10+digit NDC number that matches product Barcode."
    sql: ${TABLE}.STORE_DRUG_BARCODE ;;
  }

  dimension: drug_strength {
    type: string
    label: "Drug Strength"
    description: "Metric strength or concentration"
    sql: ${TABLE}.STORE_DRUG_STRENGTH ;;
  }

  #[ERXLPS-1942] - Updated the label name and description.
  dimension: drug_therapeutic_class {
    type: string
    label: "Drug Therapeutic Class"
    description: "Primary therapeutic class number (ASHP)"
    sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_CLASS ;;
  }

  dimension: drug_dosage_form {
    type: string
    label: "Drug Dosage Form"
    description: "The physical form of a drug intended for administration or consumption."
    sql: ${TABLE}.STORE_DRUG_DOSAGE_FORM ;;
  }

  dimension: drug_shelf {
    type: number
    label: "Drug Shelf Life (In Days)"
    description: "Shelf life in days of the drug in the pharmacy"
    sql: ${TABLE}.STORE_DRUG_SHELF ;;
  }

  dimension: drug_life {
    type: number
    label: "Drug Life (In Days)"
    description: "Shelf life of the drug after it is dispensed"
    sql: ${TABLE}.STORE_DRUG_LIFE ;;
  }

  dimension: drug_napra {
    type: string
    label: "Drug NAPRA"
    description: "NAPRA Code (National Association of Pharmacy Regulatory Authorities) This field is used for a national scheduling system in Canada"
    sql: ${TABLE}.STORE_DRUG_NAPRA ;;
  }

  dimension: drug_other_code {
    type: string
    label: "Drug Other Code"
    description: "User defined code that is used as a misc entry that can be used to identify the drug"
    sql: ${TABLE}.STORE_DRUG_OTHER_CODE ;;
  }

  dimension: drug_ncpdp_daw {
    type: string
    label: "Pharmacy NCPDP DAW"
    description: "Default DAW code assigned to the drug"
    sql: ${TABLE}.STORE_DRUG_NCPDP_DAW ;;
  }

  dimension: drug_substitution_group {
    type: string
    label: "Drug Substitution Group"
    description: "Code of drug substitution group in which a drug record is categorized"
    sql: ${TABLE}.STORE_DRUG_SUBSTITUTION_GROUP ;;
  }

  dimension: drug_labeler {
    type: string
    label: "Drug Labeler"
    description: "Name of the Drug's Distributor"
    sql: ${TABLE}.STORE_DRUG_LABELER ;;
  }

  dimension: drug_labeler_number {
    type: string
    label: "Drug Labeler Number"
    description: "Number identifying the distributor of this drug"
    sql: ${TABLE}.STORE_DRUG_LABELER_NUMBER ;;
  }

  dimension: drug_ahfs_therapeutic_class {
    type: string
    label: "Drug AHFS Therapeutic Class"
    description: "Therapeutic Class as identified by the American Hospital Formulary Service"
    sql: ${TABLE}.STORE_DRUG_AHFS_THERAPEUTIC_CLASS ;;
  }

  dimension: drug_alternate_product_name {
    type: string
    label: "Drug Alternate Product Name"
    description: "Used for multiple brands/generics for the same drug. A particular drug may have more than one branded name, as well as a generic"
    sql: ${TABLE}.STORE_DRUG_ALTERNATE_PRODUCT_NAME ;;
  }

  dimension: drug_alternate_nhin_drug_name {
    type: string
    label: "Drug Alternate NHIN Drug Name"
    description: "Alternate drug name as identified by NHIN"
    sql: ${TABLE}.STORE_DRUG_ALTERNATE_NHIN_DRUG_NAME ;;
  }

  dimension: drug_dib_strength {
    type: string
    label: "Drug DIB Strength"
    description: "Medi-Span drug strength"
    sql: ${TABLE}.STORE_DRUG_DIB_STRENGTH ;;
  }

  dimension: drug_dib_unit {
    type: string
    label: "Drug DIB Unit"
    description: "Medi-Span drug unit"
    sql: ${TABLE}.STORE_DRUG_DIB_UNIT ;;
  }

  dimension: drug_inner_pack_barcode {
    type: string
    label: "Drug Inner Pack Barcode"
    description: "Used when drug packaging contains smaller packs within a larger pack and the inner pack has its own barcode"
    sql: ${TABLE}.STORE_DRUG_INNER_PACK_BARCODE ;;
  }

  dimension: drug_outer_pack_barcode {
    type: string
    label: "Drug Outer Pack Barcode"
    description: "10 digit NDC/DIN matching the barcode of the outer pack of the drug"
    sql: ${TABLE}.STORE_DRUG_OUTER_PACK_BARCODE ;;
  }

  dimension: drug_inner_pack_ndc {
    type: string
    label: "Drug Inner Pack NDC"
    description: "Used when drug packaging contains smaller packs within a larger pack and the inner pack has its own NDC"
    sql: ${TABLE}.STORE_DRUG_INNER_PACK_NDC ;;
  }

  dimension: drug_pack {
    type: number
    label: "Drug Pack"
    description: "Decimal pack size"
    sql: ${TABLE}.STORE_DRUG_PACKAGE_SIZE ;;
    value_format: "###0.0000"
  }

# added as a part of [ERXLPS-1241]
  dimension: drug_derived_pack_size {
    type: number
    label: "Derived Pack Size"
    description: "Drug pack size which shows Integer pack size when Decimal pack size is null"
    sql: CASE WHEN ${TABLE}.STORE_DRUG_PACKAGE_SIZE IS NULL THEN ${TABLE}.STORE_DRUG_INTEGER_PACK ELSE ${TABLE}.STORE_DRUG_PACKAGE_SIZE END   ;;
    value_format: "###0.0000"
  }

  dimension: drug_integer_pack {
    type: number
    label: "Drug Integer Pack"
    description: "This is the Drug's Pack Size represented as an integer value (The drug's decimal packsize rounded up to the nearest whole number)"
    sql: ${TABLE}.STORE_DRUG_INTEGER_PACK ;;
    # Integer pack should not represent decimals
    value_format: "###0"
  }

  dimension: drug_packs_per_container {
    type: number
    label: "Drug Packs per Container"
    description: "Number of individual containers per package"
    sql: ${TABLE}.STORE_DRUG_PACKS_PER_CONTAINER ;;
    value_format: "###0.0000"
  }

  #ERXLPS-199
  dimension: drug_pack_individual_container_pack {
    type: number
    label: "Drug Individual container pack size"
    description: "Individual container pack size"
    sql: ${TABLE}.STORE_DRUG_INDIVIDUAL_CONTAINER_PACK ;;
    value_format: "###0.0000"
  }

  dimension: drug_outer_pack_ndc {
    type: string
    label: "Drug Outer Pack NDC"
    description: "Outer-Pack National Drug Code used as a universal product identifier for human drugs"
    sql: ${TABLE}.STORE_DRUG_OUTER_PACK_NDC ;;
  }

  dimension: drug_custom_imprint_code {
    type: string
    label: "Drug Custom Imprint Code"
    description: "Unique code that identifies the imprint text to use when this drug is dispensed"
    sql: ${TABLE}.STORE_DRUG_CUSTOM_IMPRINT_CODE ;;
  }

  dimension: drug_global_trade_number {
    type: string
    label: "Drug Global Trade Number"
    description: "Tracking number used to identify how the product is packaged for shipping"
    sql: ${TABLE}.STORE_DRUG_GLOBAL_TRADE_NUMBER ;;
  }

  dimension: drug_cvx_code {
    type: string
    label: "Drug CVX Code"
    description: "The CVX code is a numeric string, which identifies the type of vaccine product used. Contains CVX  Vaccine Administered Code. E.g. 128 , 162, 13"
    sql: ${TABLE}.STORE_DRUG_CVX_CODE ;;
  }

  dimension: drug_mvx_code {
    type: string
    label: "Drug MVX Code"
    description: "Contains MVX Manufacturer of Vaccine Code. The MVX is an alphabetic string, which represents the manufacturer of a vaccine. E.g. PHR, WAL"
    sql: ${TABLE}.STORE_DRUG_MVX_CODE ;;
  }

  dimension: drug_cpt_code {
    type: string
    label: "Drug CPT Code"
    description: "Five digit numeric code that is used for this drug, issued by AMA, to describe medical services"
    sql: ${TABLE}.STORE_DRUG_CPT_CODE ;;
  }

  dimension: drug_cpt_code2 {
    type: string
    label: "Drug CPT Code2"
    description: "Second CPT code -- should only exist if CPT_CODE also exists. E.g. 90281, 90283, 90287"
    sql: ${TABLE}.STORE_DRUG_CPT_CODE2 ;;
  }

  dimension: deleted {
    hidden: yes #[ERXLPS-2064]
    type: yesno
    label: "Drug Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Yes/No Flag indicating if the drug was deleted from the source system"
    sql: ${TABLE}.STORE_DRUG_DELETED = 'Y' ;;
  }

  #[ERXLPS-2064] - Added reference dimension to use in joins
  dimension: deleted_reference {
    hidden: yes
    type: string
    label: "Drug Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug was deleted from the source system"
    sql: ${TABLE}.STORE_DRUG_DELETED ;;
  }

  dimension: drug_sig_conversion_factor {
    type: number
    label: "Pharmacy Sig Conversion Factor"
    description: "SIG conversion factor that converts metric liquid measurements to dosage units. The system also uses the conversion factor to calculate days' supply"
    sql: ${TABLE}.STORE_DRUG_SIG_CONVERSION_FACTOR ;;
    value_format: "###0.0000"
  }

  ########################################################################################################### DATE/TIME specific Fields #########################################################################################
  dimension_group: drug_manufacturer_discontinue {
    label: "Drug Manufacturer Discontinue"
    description: "Date drug was or will be discontinued by the manufacturer"
    type: time
    sql: ${TABLE}.STORE_DRUG_MANUFACTURER_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_chain_discountine {
    label: "Drug Chain Discontinue"
    description: "Date drug was or will be discontinued by pharmacy"
    type: time
    sql: ${TABLE}.STORE_DRUG_CHAIN_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_last_update {
    label: "Drug Update"
    description: "Date/Time the record was last updated in source"
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################
  dimension: drug_repack {
    label: "Drug Repack"
    description: "Yes/No Flag indicating if a drug has been repackaged from the original manufacturer package/size"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_REPACK = 'Y' ;;
  }

  dimension: drug_preferred_brand {
    label: "Drug Preferred Brand"
    description: "Yes/No Flag indicating if a drug should be treated as a preferred brand product for drug selection logic"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_PREFERRED_BRAND = 'Y' ;;
  }

  dimension: drug_preferred_generic {
    label: "Drug Preferred Generic"
    description: "Yes/No Flag indicating if a drug should be treated as a preferred generic product for drug selection logic"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_PREFERRED_GENERIC = 'Y' ;;
  }

  dimension: drug_store_generic {
    label: "Drug Store Generic"
    description: "Yes/No Flag indicating if the system lists the transaction as a generic sale in the pharmacist summary of the transaction log and submits the drug as a generic to third parties"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_STORE_GENERIC = 'Y' ;;
  }

  dimension: drug_unit_dose {
    label: "Drug Unit Dose Flag"
    description: "Yes/No flag indicating if a drug is considered unit dose"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_UNIT_DOSE = 'Y' ;;
  }

  dimension: drug_unit_of_use {
    label: "Drug Unit of Use"
    description: "Yes/No Flag that determines if this drug is a unit of use drug (pack should not be broken) or in other words they cannot open packaging to dispense quantities less than one full package"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_UNIT_OF_USE = 'Y' ;;
  }

  dimension: drug_omit_dur {
    label: "Drug Omit DUR"
    description: "Yes/No Flag indicating whether or not DUR checking should be omitted for this drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_OMIT_DUR = 'Y' ;;
  }

  dimension: drug_injectable {
    label: "Drug Injectable"
    description: "Yes/No Flag indicating if this drug is an injectable"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INJECTABLE = 'Y' ;;
  }

  dimension: drug_life_type {
    label: "Drug Life Type"
    description: "Yes/No Flag indicating whether the system bases the drug expiration date on the date on which the patient opens the product or on the dispensed date. If Yes = Base the expiration date on the date the patient opens the product. The system uses the date from the 'Expires' field on the drug record to calculate the expiration date. If the Expires field is blank, the system uses the entry from the Drug Expire field on the Store Information screen to calculate the expiration date"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_LIFE_TYPE = 'Y' ;;
  }

  dimension: drug_same_pack {
    label: "Drug Same Pack"
    description: "Yes/No Flag indicating whether automatic drug selection excludes drugs that have a different pack size when picking a substitute for this drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_SAME_PACK = 'Y' ;;
  }

  dimension: drug_bubble {
    label: "Drug Bubble"
    description: "Yes/No Flag indicating if you can add a bubble-pack fee for unit dose prescriptions for the purpose of pricing"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_BUBBLE = 'Y' ;;
  }

  dimension: drug_brand_pricing {
    label: "Drug Brand Pricing"
    description: "Yes/No Flag indicating whether the system uses this drug record for brand pricing for all drugs with the same GPI"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_BRAND_PCT = 'Y' ;;
  }

  dimension: drug_print_no_patient_education {
    label: "Drug Print No Patient Education"
    description: "Yes/No Flag indicating whether the system prints patient education when you fill a prescription for this drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_NO_PATIENT_EDUCATION = 'Y' ;;
  }

  dimension: drug_hazmat {
    label: "Drug HAZMAT"
    description: "Yes/No Flag indicating if this drug is a HAZMAT drug (hazardous material)"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_HAZARDOUS_MATERIAL = 'Y' ;;
  }

  dimension: drug_warehouse {
    label: "Drug Warehouse"
    description: "Yes/No Flag indicating if this drug is a Warehouse drug source"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_WAREHOUSE = 'Y' ;;
  }

  dimension: drug_otc {
    label: "Drug OTC"
    description: "Yes/No Flag indicating if drug is an over-the-counter drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_OVER_THE_COUNTER = 'Y' ;;
  }

  dimension: drug_maintenance {
    label: "Drug Maintenance"
    description: "Yes/No Flag indicating if drug is a maintenance drug and therefore subject to a separate set of dispensing limits"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_MAINTENANCE = 'Y' ;;
  }

  dimension: drug_requires_signature {
    label: "Drug Requires Signature"
    description: "Yes/No Flag indicating if a signature is required upon delivery of this drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_REQUIRES_SIGNATURE = 'Y' ;;
  }

  dimension: drug_is_compound {
    label: "Pharmacy Compound Drug"
    description: "Yes/No Flag indicating if this drug record is for a Compound drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_IS_COMPOUND = 'Y' ;;
  }

  dimension: drug_use_competitive_pricing {
    label: "Drug Use Competitive Pricing"
    description: "Yes/No Flag indicating whether the competitive pricing table is to be used"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_USE_COMPETITIVE_PRICING = 'Y' ;;
  }

  dimension: drug_clinical_pack {
    label: "Drug Clinical Pack"
    description: "Yes/No Flag indicating the drug is used for a Clinical trail. Used to create non-fillable Interaction prescriptions"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_CLINICAL_PACK = 'Y' ;;
  }

  dimension: drug_investigational {
    label: "Drug Investigational"
    description: "Yes/No Flag indicating the drugs, not yet approved by the FDA, that are used for investigational purposes"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVESTIGATIONAL = 'Y' ;;
  }

  dimension: drug_cost_verified {
    label: "Drug Cost Verified"
    description: "Yes/No Flag indicating whether or not a drug's acquisition cost has been verified by a Host Administrator"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_COST_VERIFIED = 'Y' ;;
  }

  dimension: drug_veterinary_use_only {
    label: "Drug Veterinary Use Only"
    description: "Yes/No Flag indicating  whether this drug is to be used for Veterinarian use only"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_VETERINARY_USE_ONLY = 'Y' ;;
  }

  dimension: drug_immunization_indicator {
    label: "Drug Immunization Indicator"
    description: "Yes/No Flag which determines if a drug is a vaccination or immunization"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_IMMUNIZATION_INDICATOR = 'Y' ;;
  }

  ## ERXLPS - 1368 - Two Flu immunization dimensions requested by Freds
  dimension: drug_flu_immunization_indicator {
    label: "Drug Flu Immunization Indicator"
    description: "Yes/No Flag which determines if a drug is a Flu immunization (Calculation used; Evaluates to Yes if: Drug Immunization indicator = Y AND Drug GPI starts with 17100020)"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_IMMUNIZATION_INDICATOR = 'Y' AND SUBSTR(${TABLE}.STORE_DRUG_GPI, 1, 8) = '17100020' ;;
  }

  dimension: drug_immunization_category {
    label: "Drug Immunization Category"
    description: "Drug vaccination or immunization category, or if a drug is not set as an immunization indicator (Calculation used; (1) IMZ Non Flu:  Drug Immunization indicator = Y AND Drug GPI does not Start with 17100020 (2) IMZ Flu: Drug Immunization indicator = Y AND Drug GPI starts with 17100020 (3) Non Imz: Drug Immunization indicator = N)"
    type: string
    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_IMMUNIZATION_INDICATOR = 'Y' AND SUBSTR(${TABLE}.STORE_DRUG_GPI, 1, 8) <> '17100020' ;;
        label: "IMMUNIZATION (NON FLU)"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_IMMUNIZATION_INDICATOR = 'Y' AND SUBSTR(${TABLE}.STORE_DRUG_GPI, 1, 8) = '17100020' ;;
        label: "IMMUNIZATION (FLU)"
      }

      when: {
        sql: COALESCE(${TABLE}.STORE_DRUG_IMMUNIZATION_INDICATOR, 'N') = 'N' ;;
        label: "NON-IMMUNIZATION"
      }
    }
  }

  dimension: drug_disallow_autofill {
    label: "Drug Disallow Autofill"
    description: "Yes/No Flag indicating whether autofill column will be used to capture the state for Allowing or disallowing Autofill enrollment for drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_DISALLOW_AUTOFILL = 'Y' ;;
  }

  dimension: drug_inner_pack_indicator {
    label: "Drug Inner Pack Indicator"
    description: "Yes/No Flag indicating  it's an inner pack"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INNER_PACK_INDICATOR = 'Y' ;;
  }

  dimension: drug_rems {
    label: "Drug REMS"
    description: "Yes/No Flag indicating for a TX flagged as Y for a female patient, the RX will expire 7 days after Fill in Will Call.  For a TX flagged as Y for male patient, the RX will expire 30 days after Fill in Will Call"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_REMS = 'Y' ;;
  }

  dimension: drug_specialty {
    label: "Drug Specialty"
    description: "Yes/No Flag indicating if a drug is a specialty drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_SPECIALTY = 'Y' ;;
  }

  dimension: drug_black_box {
    label: "Drug Black Box"
    description: "Yes/No Flag indicating whether a medication contains a black box warning on the package insert"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_BLACK_BOX = 'Y' ;;
  }

  dimension: drug_med_guide {
    label: "Drug Med Guide"
    description: "Yes/No Flag indicating whether a medication has a Med Guide available"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_MED_GUIDE = 'Y' ;;
  }

  dimension: drug_tall_man {
    label: "Drug Tall Man"
    description: "Yes/No Flag indicating  whether part of a drug name is capitalized in order to distinguish it from other similar medications"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_TALL_MAN = 'Y' ;;
  }

  dimension: drug_partial_gpi {
    label: "Drug Partial GPI"
    description: "Yes/No Flag indicating that there is not a full GPI on the drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_PARTIAL_GPI = 'Y' ;;
  }

  dimension: drug_durable_medical_equipment_flag {
    label: "Drug Durable Medical Equipment"
    description: "Yes/No Flag indicating if a drug is flagged as DME at Host"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_DURABLE_MEDICAL_EQUIPMENT_FLAG = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: drug_desi {
    type: string
    label: "Drug DESI"
    description: "Value which designates the NDC's DESI status, which is used to determine if a drug is effective, ineffective, or needing further study"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_DESI = 2 ;;
        label: "NON DESI/IRS DRUG"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_DESI = 2 ;;
        label: "DESI/IRS DRUG UNDER REVIEW"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_DESI = 2 ;;
        label: "LESS THEN EFFECTIVE FOR SOME"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_DESI = 2 ;;
        label: "LESS THEN EFFECTIVE FOR ALL"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_DESI = 2 ;;
        label: "NORMAL"
      }

      when: {
        sql: true ;;
        label: "NON DRUG OR OTHER ITEM"
      }
    }
  }

  dimension: drug_bin_storage_type {
    type: string
    label: "Drug Bin Storage Type"
    description: "Type of Will Call Bin used as a default for this drug"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 0 ;;
        label: "NORMAL"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 1 ;;
        label: "LARGE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 2 ;;
        label: "REFRIGERATOR"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 3 ;;
        label: "FREEZER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 4 ;;
        label: "SAFE LOCKBOX"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_BIN_STORAGE_TYPE = 5 ;;
        label: "HAZMAT"
      }
    }
  }

  dimension: drug_brand_generic {
    type: string
    description: "Identifies if a drug is brand or generic"
    label: "Drug Brand/Generic"

    case: {
      when: {
        sql: ${drug_multi_source} <> 'Y' ;;
        label: "Brand"
      }

      when: {
        sql: true ;;
        label: "Generic"
      }
    }
  }

  #[ERXDWPS-5467] - New dimension added to classify drug as Brand, Generic and Others.
  dimension: drug_brand_generic_other {
    type: string
    description: "Identifies if a drug is brand, generic or other. Multi source with M,N and O as Brand, Multi Source with Y as Generic and everything else is Other."
    label: "Drug Brand/Generic/Other"

    case: {
      when: {
        sql: ${drug_multi_source} IN ('M','N','O') ;;
        label: "BRAND"
      }

      when: {
        sql: ${drug_multi_source} = 'Y' ;;
        label: "GENERIC"
      }

      when: {
        sql: true ;;
        label: "OTHER"
      }
    }
  }

  dimension: drug_schedule {
    type: string
    label: "Drug Schedule"
    description: "The U.S. Drug Schedule."

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 1 ;;
        label: "SCHEDULE I DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 2 ;;
        label: "SCHEDULE II DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 3 ;;
        label: "SCHEDULE III DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 4 ;;
        label: "SCHEDULE IV DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 5 ;;
        label: "SCHEDULE V DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 8 ;;
        label: "OTC"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: drug_previous_schedule {
    type: string
    label: "Drug Previous Schedule"
    description: "This displays the original schedule of a drug, if it has been changed. Users can change a drug schedule from the UI, or from Host. This field will be automatically updated with the schedule that the drug was before the change."

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 1 ;;
        label: "SCHEDULE I DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 2 ;;
        label: "SCHEDULE II DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 3 ;;
        label: "SCHEDULE III DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 4 ;;
        label: "SCHEDULE IV DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 5 ;;
        label: "SCHEDULE V DRUGS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_PREVIOUS_SCHEDULE = 8 ;;
        label: "OTC"
      }

      when: {
        sql: true ;;
        label: "NOT CHANGED"
      }
    }
  }

  #[ERXLPS-1434] - Modified master code label values.
  dimension: drug_schedule_category {
    type: string
    label: "Drug Schedule Category"
    description: "Drugs are categorized as controlled drugs, legend drugs, or OTC drugs."

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE IN (1,2,3,4,5) ;;
        label: "CONTROL"
      }

      # LEGEND
      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SCHEDULE = 8 ;;
        label: "OTC"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: drug_ther_equivalency_code {
    type: string
    label: "Drug Therapeutic Equivalence Code"
    description: "FDA Therapeutic Equivalence Code (Orange Book Rating). It is used as a tool in determining the therapeutic equivalence of two NDCs for the purpose of drug substitution and DUR"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A1','AB1') ;;
        label: "AB-RATED 1"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A2','AB2') ;;
        label: "AB-RATED 2"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A3','AB3') ;;
        label: "AB-RATED 3"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A4','AB4') ;;
        label: "AB-RATED 4"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A5','AB5') ;;
        label: "AB-RATED 5"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A6','AB6') ;;
        label: "AB-RATED 6"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A7','AB7') ;;
        label: "AB-RATED 7"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A8','AB8') ;;
        label: "AB-RATED 8"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE IN ('A9','AB9') ;;
        label: "AB-RATED 9"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AA' ;;
        label: "NO BIO PROBLEMS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AB' ;;
        label: "MEETS BIO"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AN' ;;
        label: "AEROSOL"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AO' ;;
        label: "INJECTABLE OIL SOLUTE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AP' ;;
        label: "INJECTABLE AQUEOUS"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'AT' ;;
        label: "TOPICAL"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BC' ;;
        label: "CONTROLLED RELEASE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BD' ;;
        label: "DOCUMENTED BIO ISSUES"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BE' ;;
        label: "ENTERIC DOSAGE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BN' ;;
        label: "NEBULIZER SYSTEM"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BP' ;;
        label: "POTENTIAL BIO ISSUES"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BR' ;;
        label: "SYSTEMIC USE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BS' ;;
        label: "DEFICENCIES"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BT' ;;
        label: "BIOEQUIVALENCE ISSUES"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'BX' ;;
        label: "INSUFFICIENT DATA"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'B*' ;;
        label: "FDA REVIEW"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'NA' ;;
        label: "NOT APPLICABLE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'NR' ;;
        label: "NOT RATED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'ZA' ;;
        label: "DATABANK REPACKAGED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'ZB' ;;
        label: "DATABANK"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_EQUIVALENCY_CODE = 'ZC' ;;
        label: "ORANGE BOOK"
      }

      when: {
        sql: true ;;
        label: "NO CODE"
      }
    }
  }

  dimension: drug_abbreviated_unit {
    type: string
    label: "Drug Unit - Abbreviated"
    description: "Unit of measure in which drug is dispensed. Alpha-numeric value, which may be up to 3 characters in length. TAB, CAP, ML, etc."
    sql: ${TABLE}.STORE_DRUG_UNIT ;;
  }

  dimension: drug_refrigerate {
    type: string
    label: "Drug Refrigerate"
    description: "Flag that determines if this drug requires refrigeration when shipped"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_REFRIGERATE = 'R' ;;
        label: "SHIP REFRIGERATED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_REFRIGERATE = 'F' ;;
        label: "SHIP FROZEN"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_REFRIGERATE = 'T' ;;
        label: "ROOM TEMPERATURE"
      }

      # ERXLPS-199 (fixed issue, where values are shown as false instead of showing as NO)
      when: {
        sql: true ;;
        label: "NO"
      }
    }
  }

  dimension: drug_route_code {
    type: string
    label: "Drug Route Code"
    description: "Description of how a Drug is administered"
    sql: ${TABLE}.STORE_DRUG_ROUTE_CODE ;;
  }

  dimension: drug_multi_source {
    type: string
    label: "Drug Multi-Source Indicator"
    description: "Source: Y=Multi, N=Single, O=Orig MFG, M=Multi, Not a Generic"
    sql: ${TABLE}.STORE_DRUG_MULTI_SOURCE ;;
  }

  dimension: drug_identifier_type {
    type: string
    label: "Drug Identifier Type"
    description: "Flag that indicates to certain insurance claim processors what type of product code is entered in the NDC/DIN field"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_IDENTIFIER_TYPE = 'H' ;;
        label: "HRI"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_IDENTIFIER_TYPE = 'N' ;;
        label: "NDC/DIN"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_IDENTIFIER_TYPE = 'O' ;;
        label: "OTHER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_IDENTIFIER_TYPE = 'U' ;;
        label: "UPC"
      }
    }
  }

  dimension: drug_name_type_code {
    type: string
    label: "Drug Name Type Code"
    description: "Defines whether this drug is a tradename, brand, or generic"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_NAME_TYPE_CODE = 'B' ;;
        label: "BRAND"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NAME_TYPE_CODE = 'G' ;;
        label: "GENERIC"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NAME_TYPE_CODE = 'T' ;;
        label: "TRADENAME"
      }

      when: {
        sql: true ;;
        label: "NOT SET"
      }
    }
  }

  # ERXLPS-199 Changes
  dimension: drug_ncpdp_form_type {
    type: string
    label: "Pharmacy Compound Drug NCPDP Form Type"
    description: "Normal form type of a compound. Populated when drug record is for a compound and user populates this field on the Compound screen"
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_DRUG_NCPDP_FORM_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_DRUG_NCPDP_FORM_TYPE') ;;
    suggestions: ["EACH", "GRAMS", "MILLILITERS", "NOT SELECTED"]
  }

  dimension: drug_ncpdp_form_description {
    type: string
    label: "Pharmacy Compound Drug NCPDP Form Description"
    description: "Form description of a compound"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '1' ;;
        label: "CAPSULE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '2' ;;
        label: "OINTMENT"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '3' ;;
        label: "CREAM"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '4' ;;
        label: "SUPPOSITORY"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '5' ;;
        label: "POWDER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '6' ;;
        label: "EMULSION"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '7' ;;
        label: "LIQUID"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '8' ;;
        label: "TABLET"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '9' ;;
        label: "SOLUTION"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '10' ;;
        label: "SUSPENSION"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '11' ;;
        label: "LOTION"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '12' ;;
        label: "SHAMPOO"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '13' ;;
        label: "ELIXIR"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '14' ;;
        label: "SYRUP"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '15' ;;
        label: "LOZENGE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '16' ;;
        label: "ENEMA"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_NCPDP_FORM_DESCRIPTION = '' ;;
        label: "NOT SPECIFIED"
      }

      when: {
        sql: true ;;
        label: "NOT SELECTED"
      }
    }
  }

  dimension: drug_acq_source {
    type: string
    label: "Drug ACQ Source"
    description: "Indicator to determine the source of ACQ cost"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = '1' ;;
        label: "PRIMARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = '2' ;;
        label: "SECONDARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = '3' ;;
        label: "TERTIARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = '4' ;;
        label: "QUATERNARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = 'M' ;;
        label: "MAIL ORDER COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = 'C' ;;
        label: "CENTRAL FILL COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ACQUISITION_COST_SOURCE = '%' ;;
        label: "PERCENT OF AWP"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: drug_awp_source {
    type: string
    label: "Drug AWP Source"
    description: "Indicator to determine the source of AWP cost"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_AWP_SOURCE = 'A' ;;
        label: "CALCULATED USING INQUIRY MARK-UP FACTOR"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_AWP_SOURCE = 'S' ;;
        label: "SUGGESTED AWP FROM MANUFACTURER"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_AWP_SOURCE = 'M' ;;
        label: "STANDARD 25 PERCENT MARK-UP FACTOR USED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_AWP_SOURCE = 'K' ;;
        label: "ADJUSTED MARK-UP FACTOR USED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_AWP_SOURCE = 'L' ;;
        label: "STANDARD 20 PERCENT MARK-UP FACTOR USED"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: drug_arcos {
    type: string
    label: "Drug ARCOS"
    description: "Indicates whether a drug is reportable to ARCOS (Federal Automation of Reports and Consolidated Order Systems)"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_ARCOS = '1' ;;
        label: "YES"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ARCOS = '2' ;;
        label: "NO"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ARCOS = '3' ;;
        label: "N/A"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_ARCOS IS NULL ;;
        label: "NOT SUPPORTED"
      }
    }
  }

  dimension: drug_single_ingredient {
    type: string
    label: "Drug Single Ingredient"
    description: "Indicates whether a drug only has a single ingredient"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_SINGLE_INGREDIENT = 'C' ;;
        label: "COMBINATION"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SINGLE_INGREDIENT = 'S' ;;
        label: "SINGLE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_SINGLE_INGREDIENT IS NULL ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  #ERXLPS-199
  dimension: drug_ncpdp_route {
    type: string
    label: "Pharmacy Compound Drug NCPDP Route"
    description: "Route that is normally used by the patient for using/taking this compound. Populated when drug record is for a compound and user populates this field on the Compound screen"
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_DRUG_NCPDP_ROUTE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_DRUG_NCPDP_ROUTE') ;;
    suggestions: [
      "BUCCAL",
      "DENTAL",
      "INHALATION",
      "INJECTION",
      "INTRAPERITONEAL",
      "IRRIGATION",
      "MOUTH/THROAT",
      "MUCOUS MEMBRANE",
      "NASAL",
      "OPTHALMIC",
      "ORAL",
      "OTHER/MISCELLANEOUS",
      "OTIC",
      "PERFUSION",
      "RECTAL",
      "SUBLINGUAL",
      "TOPICAL",
      "TRANSDERMAL",
      "TRANSLINGUAL",
      "URETHAL",
      "VAGINAL",
      "ENTERAL",
      "NOT SET"
    ]
  }

  #ERXLPS-199
  dimension: drug_narcotic_indicator {
    type: string
    label: "Drug Narcotic Indicator"
    description: "Field indicating if the drug is a narcotic"
    sql: ${TABLE}.STORE_DRUG_NARCOTIC_INDICATOR ;;
  }

  #[ERXLPS-1262]
  dimension: drug_generic {
    type: string
    label: "Drug Generic"
    description: "Determines if this is a generic drug for the purposes of fee and co-pay assignments"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_GENERIC = '0' ;;
        label: "BRAND"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_GENERIC = '1' ;;
        label: "GENERIC"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_GENERIC = '2' ;;
        label: "NO GENERIC"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_GENERIC IS NULL ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  #[ERXLPS-1925]
  dimension: store_drug_cost_region {
    label: "Drug Cost Region"
    type: string
    description: "Pharmacy drug cost region"
    #sql: ${TABLE}.STORE_SETTING_VALUE ;;
    sql: ${store_drug_cost_region.store_setting_value} ;;
  }


  ####################################################################### Host Vs. Pharmacy Comparison Flags Dimensions Start ##############################################
#ERXDWPS-6164 - Trouble understanding the Drug Immunization Different Flag | Start

  dimension: drug_awp_cost_different_flag {
    label: "Drug AWP Cost Amount Different"
    description: "Host Vs Pharmacy Drug Average Wholesale Price Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.awp_cost_amount},0) = NVL(${store_drug_cost_pivot.awp_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_acq_cost_different_flag {
    label: "Drug ACQ Cost Amount Different"
    description: "Host Vs Pharmacy Drug Acquisition Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.acq_cost_amount},0) = NVL(${store_drug_cost_pivot.acq_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_wac_cost_different_flag {
    label: "Drug WAC Amount Different"
    description: "Host Vs Pharmacy Drug Wholesaler Acquisition Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.wac_cost_amount},0) = NVL(${store_drug_cost_pivot.wac_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_mac_cost_different_flag {
    label: "Drug MAC Amount Different"
    description: "Host Vs Pharmacy Drug Maximum Allowable Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.mac_cost_amount},0) = NVL(${store_drug_cost_pivot.mac_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_reg_cost_different_flag {
    label: "Drug REG Cost Amount Different"
    description: "Host Vs Pharmacy Drug Regular Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.reg_cost_amount},0) = NVL(${store_drug_cost_pivot.reg_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_dp_cost_different_flag {
    label: "Drug DP Cost Amount Different"
    description: "Host Vs Pharmacy Drug Direct Price Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.dp_cost_amount},0) = NVL(${store_drug_cost_pivot.dp_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_wel_cost_different_flag {
    label: "Drug WEL Cost Amount Different"
    description: "Host Vs Pharmacy Drug Welfare Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.wel_cost_amount},0) = NVL(${store_drug_cost_pivot.wel_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_340b_cost_different_flag {
    label: "Drug 340B MED Part D Cost Amount Different"
    description: "Host Vs Pharmacy Drug 340B Medicare Part D Cost Amount comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug_cost_pivot.340b_cost_amount},0) = NVL(${store_drug_cost_pivot.340b_cost_amount},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_cost_file_any_flag_different {
    label: "Drug Cost File Any Flag Different"
    description: "Host Vs Pharmacy Drug cost File all Flags comparison(Y/N) to determine if any of the drug cost flags are different."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN (${drug_awp_cost_different_flag} = 'Y'
                OR ${drug_acq_cost_different_flag} = 'Y'
                OR ${drug_wac_cost_different_flag} = 'Y'
                OR ${drug_mac_cost_different_flag} = 'Y'
                OR ${drug_reg_cost_different_flag} = 'Y'
                OR ${drug_dp_cost_different_flag} = 'Y'
                OR ${drug_wel_cost_different_flag} = 'Y'
                OR ${drug_340b_cost_different_flag} = 'Y')
              THEN 'Y'
              ELSE 'N'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_name_different_flag {
    label: "Drug Name Different"
    description: "Host Vs Pharmacy Drug Name comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_name},'N') = NVL(${store_drug.drug_name},'N') THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_package_size_different_flag {
    label: "Drug Package Size Different"
    description: "Host Vs Pharmacy Drug Package Size comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_pack},0) = NVL(${store_drug.drug_pack},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_integer_pack_different_flag {
    label: "Drug Integer Pack Different"
    description: "Host Vs Pharmacy Drug Integer Pack comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_integer_pack},0) = NVL(${store_drug.drug_integer_pack},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_discontinue_date_different_flag {
    label: "Drug Discontinue Date Different"
    description: "Host Vs Pharmacy Drug Discontinue Date comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_manufacturer_discontinue_date},to_date('1900-01-01', 'yyyy-mm-dd')) = NVL(${store_drug.drug_manufacturer_discontinue_date},to_date('1900-01-01', 'yyyy-mm-dd')) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_ind_container_pack_different_flag {
    label: "Drug Individual Container Pack Different"
    description: "Host Vs Pharmacy Drug Individual Container Pack comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_individual_container_pack},0) = NVL(${store_drug.drug_pack_individual_container_pack},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_packs_per_container_different_flag {
    label: "Drug Packs Per Container Different"
    description: "Host Vs Pharmacy Drug Packs Per Container comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_packs_per_container},0) = NVL(${store_drug.drug_packs_per_container},0) THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }

  dimension: drug_immunization_flag_different_flag {
    label: "Drug Immunization Different"
    description: "Host Vs Pharmacy Drug Immunization comparison flag(Y/N)."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN NVL(${drug.drug_immunization_flag},'N') = NVL(${store_drug.drug_immunization_indicator},'N') THEN 'N'
              ELSE 'Y'
          END ;;
    suggestions: ["Y","N","N/A"]
  }


  dimension: drug_file_any_flag_different {
    label: "Drug All File Any Flag Different"
    description: "Host Vs Pharmacy Drug All File flags comparison(Y/N) to determine if any of the drug flags are different."
    type: string
    sql: CASE WHEN ${store_drug.drug_id} is null or ${drug.drug_ndc} is null THEN 'N/A'
              WHEN (${drug_cost_file_any_flag_different} = 'Y'
                OR ${drug_name_different_flag} = 'Y'
                OR ${drug_package_size_different_flag} = 'Y'
                OR ${drug_integer_pack_different_flag} = 'Y'
                OR ${drug_discontinue_date_different_flag} = 'Y'
                OR ${drug_ind_container_pack_different_flag} = 'Y'
                OR ${drug_packs_per_container_different_flag} = 'Y'
                OR ${drug_immunization_flag_different_flag} = 'Y')
              THEN 'Y'
              ELSE 'N'
         END ;;
    suggestions: ["Y","N","N/A"]
  }
#ERXDWPS-6164 - Trouble understanding the Drug Immunization Different Flag | End
####################################################################### Host Vs. Pharmacy Comparison Flags Dimensions End ##############################################
  ################################################################################################## End of Dimensions #################################################################################################

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    label: "Drug Count" #[ERXLPS-2064]
    description: "Total Drug count"
    type: count
    value_format: "#,##0"
  }

  measure: sum_drug_price_quantity {
    type: sum
    label: "Drug Quantity"
    description: "Quantity to use for the Drug Retail Price List report"
    sql: ${TABLE}.STORE_DRUG_PRICE_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_price_quantity_2 {
    type: sum
    label: "Drug Quantity 2"
    description: "Second quantity to use for the Drug Retail Price List report"
    sql: ${TABLE}.STORE_DRUG_PRICE_QUANTITY_2 ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_rebate_amount {
    type: sum
    label: "Drug Rebate Amount"
    description: "Reflects the manufacturers rebate amount for this drug"
    sql: ${TABLE}.STORE_DRUG_REBATE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_user_defined_quantity {
    type: sum
    label: "Drug User Defined Quantity"
    description: "User defined quantity that allows the use of multiple packages when dispensing a drug"
    sql: ${TABLE}.STORE_DRUG_USER_DEFINED_QUANTITY ;;
    value_format: "###0.0000"
  }

  ##################################################################################################### End of Measures #################################################################################################

  #[ERXLPS-1925]
  set: explore_rx_host_vs_store_drug_comparison_candidate_list {
    fields: [
      drug_awp_cost_different_flag,
      drug_acq_cost_different_flag,
      drug_wac_cost_different_flag,
      drug_mac_cost_different_flag,
      drug_reg_cost_different_flag,
      drug_dp_cost_different_flag,
      drug_wel_cost_different_flag,
      drug_340b_cost_different_flag,
      drug_cost_file_any_flag_different,
      drug_name_different_flag,
      drug_package_size_different_flag,
      drug_integer_pack_different_flag,
      drug_discontinue_date_different_flag,
      drug_ind_container_pack_different_flag,
      drug_packs_per_container_different_flag,
      drug_immunization_flag_different_flag,
      drug_file_any_flag_different
    ]
  }
}

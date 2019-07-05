view: ar_drug {
  label: "DRUG"
  derived_table: {
    sql: SELECT
      --NHIN Columns
      nhinDrug.DRUG_ADD_DATE, nhinDrug.DRUG_AUTO_PREFILL_CODE, nhinDrug.DRUG_BARCODE, nhinDrug.DRUG_BIN_STORAGE_TYPE,
      nhinDrug.DRUG_CATEGORY, nhinDrug.DRUG_CENTRAL_FILL_CODE, nhinDrug.DRUG_CHAIN_DISCONTINUE_DATE, nhinDrug.DRUG_CHANGE_DATE,
      nhinDrug.DRUG_CLASS, nhinDrug.DRUG_CLEAR_REORDER_CODE_FLAG, nhinDrug.DRUG_CODE, nhinDrug.DRUG_DDID, nhinDrug.DRUG_DELETED,
      nhinDrug.DRUG_DISPENSABLE_IDENTIFIER, nhinDrug.DRUG_DME_FLAG, nhinDrug.DRUG_DOSAGE_FORM, nhinDrug.DRUG_GROUP,
      nhinDrug.DRUG_HAZARDOUS_MATERIAL_FLAG, nhinDrug.DRUG_HOST_LAST_UPDATE_DATE, nhinDrug.DRUG_IMMUNIZATION_FLAG,
      nhinDrug.DRUG_INNER_PACK_FLAG, nhinDrug.DRUG_INTEGER_PACK, nhinDrug.DRUG_INTERACTION_CODE, nhinDrug.DRUG_LAST_DISPENSED_DATE,
      nhinDrug.DRUG_MAIL_ORDER_ONLY_FLAG, nhinDrug.DRUG_MAXIMUM_PACK_MULTIPLE, nhinDrug.DRUG_MEDICATION_GUIDE_FLAG,
      nhinDrug.DRUG_MFR_DISCONTINUE_DATE, nhinDrug.DRUG_MINIMUM_DISPENSE_QUANTITY, nhinDrug.DRUG_NARCOTIC_CODE,
      nhinDrug.DRUG_NDC_FORMAT, nhinDrug.DRUG_NDC_QUALIFIER, nhinDrug.DRUG_NEW_STORE_FLAG, nhinDrug.DRUG_ORIGINAL_SCHEDULE,
      nhinDrug.DRUG_PARTIAL_GPI_FLAG, nhinDrug.DRUG_PREFERRED_BRAND, nhinDrug.DRUG_PREFERRED_GENERIC, nhinDrug.DRUG_PREVIOUS_NDC,
      nhinDrug.DRUG_PRICE_CODE, nhinDrug.DRUG_REFRIGERATE, nhinDrug.DRUG_REGION, nhinDrug.DRUG_REMS_MONITORING_FLAG,
      nhinDrug.DRUG_REORDER_CODE, nhinDrug.DRUG_REPACK, nhinDrug.DRUG_REPLACEMENT_NDC, nhinDrug.DRUG_REQUIRE_WRITTEN_FLAG,
      nhinDrug.DRUG_ROUTE_CODE, nhinDrug.DRUG_SIG_ROUTE, nhinDrug.DRUG_SIG_UNIT, nhinDrug.DRUG_SIG_UNITS, nhinDrug.DRUG_SIG_VERB,
      nhinDrug.DRUG_SIGNATURE_REQUIRED_FLAG, nhinDrug.DRUG_SINGLE_INGREDIENT_CODE, nhinDrug.DRUG_SPECIALTY_FLAG, nhinDrug.DRUG_SRC_ID,
      nhinDrug.DRUG_STORE_GENERIC, nhinDrug.DRUG_SUBGROUP, nhinDrug.DRUG_TALL_MAN_FLAG, nhinDrug.DRUG_TALL_MAN_NAME,
      nhinDrug.DRUG_TP_RESTRICTION_CODE, nhinDrug.DRUG_UNIT_OF_USE, nhinDrug.DRUG_USER_DEFINED_NAME, nhinDrug.DRUG_VETERINARIAN_FLAG,
      nhinDrug.DRUG_WAREHOUSE_FLAG,

      --AR Columns
      arDrug.CHAIN_ID, arDrug.DRUG_FULL_GENERIC_NAME, arDrug.DRUG_FULL_NAME, arDrug.DRUG_GCN, arDrug.DRUG_GENERIC_NAME,
      arDrug.DRUG_HASH, arDrug.DRUG_INDIVIDUAL_CONTAINER_PACK, arDrug.DRUG_INJECTABLE_FLAG, arDrug.DRUG_LABEL_DOSAGE_FORM,
      arDrug.DRUG_LABEL_MANUFACTURER, arDrug.DRUG_LABEL_STRENGTH, arDrug.DRUG_LCR_ID, arDrug.DRUG_MAINTENANCE_DRUG_FLAG,
      arDrug.DRUG_MANUFACTURER, arDrug.DRUG_MEDISPAN_STRENGTH_UNIT_OF_MEASURE, arDrug.DRUG_MEDISPAN_STRENGTH_UNIT_QUANTITY,
      arDrug.DRUG_MULTI_SOURCE, arDrug.DRUG_NAME, arDrug.DRUG_NHIN_DATA_SOURCE_CODE, arDrug.DRUG_NHIN_NAME, arDrug.DRUG_PACK,
      arDrug.DRUG_PACKS_PER_CONTAINER, arDrug.DRUG_SCHEDULE, arDrug.DRUG_STRENGTH, arDrug.DRUG_THER_EQUIVALENCY_CODE,
      arDrug.DRUG_THERAPEUTIC_CLASS, arDrug.DRUG_THERAPEUTIC_CLASS8, arDrug.DRUG_UNIT, arDrug.DRUG_UNIT_DOSE,
      arDrug.EDW_INSERT_TIMESTAMP, arDrug.EDW_LAST_UPDATE_TIMESTAMP, arDrug.EVENT_ID, arDrug.GPI, arDrug.LOAD_TYPE,
      arDrug.NDC, arDrug.SOURCE_SYSTEM_ID, arDrug.SOURCE_TIMESTAMP
      FROM edw.D_DRUG nhinDrug
      LEFT JOIN
      ( SELECT
      arDrug.CHAIN_ID, arDrug.DRUG_FULL_GENERIC_NAME, arDrug.DRUG_FULL_NAME, arDrug.DRUG_GCN, arDrug.DRUG_GENERIC_NAME,
      arDrug.DRUG_HASH, arDrug.DRUG_INDIVIDUAL_CONTAINER_PACK, arDrug.DRUG_INJECTABLE_FLAG, arDrug.DRUG_LABEL_DOSAGE_FORM,
      arDrug.DRUG_LABEL_MANUFACTURER, arDrug.DRUG_LABEL_STRENGTH, arDrug.DRUG_LCR_ID, arDrug.DRUG_MAINTENANCE_DRUG_FLAG,
      arDrug.DRUG_MANUFACTURER, arDrug.DRUG_MEDISPAN_STRENGTH_UNIT_OF_MEASURE, arDrug.DRUG_MEDISPAN_STRENGTH_UNIT_QUANTITY,
      arDrug.DRUG_MULTI_SOURCE, arDrug.DRUG_NAME, arDrug.DRUG_NHIN_DATA_SOURCE_CODE, arDrug.DRUG_NHIN_NAME, arDrug.DRUG_PACK,
      arDrug.DRUG_PACKS_PER_CONTAINER, arDrug.DRUG_SCHEDULE, arDrug.DRUG_STRENGTH, arDrug.DRUG_THER_EQUIVALENCY_CODE,
      arDrug.DRUG_THERAPEUTIC_CLASS, arDrug.DRUG_THERAPEUTIC_CLASS8, arDrug.DRUG_UNIT, arDrug.DRUG_UNIT_DOSE,
      arDrug.EDW_INSERT_TIMESTAMP, arDrug.EDW_LAST_UPDATE_TIMESTAMP, arDrug.EVENT_ID, arDrug.GPI, arDrug.LOAD_TYPE,
      arDrug.NDC, arDrug.SOURCE_SYSTEM_ID, arDrug.SOURCE_TIMESTAMP
      FROM edw.D_DRUG arDrug
      WHERE arDrug.CHAIN_ID=3000 AND arDrug.source_system_id =8 ) arDrug
      ON arDrug.NDC = nhinDrug.NDC
      WHERE nhinDrug.source_system_id = 6;;
  }

  dimension: drug_ndc {
    type: string
    label: "Drug NDC"
    description: "National Drug Code Identifier"
    sql: ${TABLE}.NDC ;;
  }

  dimension: drug_ndc_9 {
    type: string
    label: "Drug NDC 9"
    description: "First 9 Digits of NDC"
    sql: substring(${TABLE}.NDC, 1, 9) ;;
  }

  dimension: drug_ndc_11_digit_format {
    type: string
    label: "Drug NDC 11 Digit Format"
    description: "11-Digit Format of National Drug Code Identifer represented in the format of 99999-9999-99"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(SUBSTRING(${TABLE}.NDC,1,5),'-'),SUBSTRING(${TABLE}.NDC,6,4)),'-'),SUBSTRING(${TABLE}.NDC,10,2)) ;;
  }

  #  ERXLPS-199 Change
  dimension: drug_ndc_format {
    type: number
    label: "Drug NDC Format"
    description: "Represents which digit to insert '0' in scanned 10-digit NDC"
    sql: ${TABLE}.DRUG_NDC_FORMAT ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    # source_system_id is not included as it is handled at the join level, where only record from one source system will be joined based on the view selected
    #################################################################################################### Foreign Key References #####################################################################################################
    sql: ${chain_id} ||'@'|| ${drug_ndc} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: drug_gpi {
    hidden: yes
    type: string
    label: "Drug GPI"
    sql: ${TABLE}.GPI ;;
  }

  dimension: drug_source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_src_id {
    type: number
    hidden: yes
    sql: ${TABLE}.DRUG_SRC_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################
  dimension: drug_name {
    type: string
    label: "Drug Name"
    description: "Drug Name"
    sql: ${TABLE}.DRUG_NAME ;;
  }

  dimension: drug_full_name {
    type: string
    label: "Drug Name - Full"
    description: "Extended drug name"
    sql: ${TABLE}.DRUG_FULL_NAME ;;
  }

  dimension: drug_full_generic_name {
    type: string
    label: "Drug Generic Name - Full"
    description: "Full generic or chemical name of the drug mainly used for products which have a longer drug name than what is allowed in the Drug Name column"
    sql: ${TABLE}.DRUG_FULL_GENERIC_NAME ;;
  }

  dimension: drug_generic_name {
    type: string
    label: "Drug Generic Name"
    description: "Shorter generic or chemical description of drug"
    sql: ${TABLE}.DRUG_GENERIC_NAME ;;
  }

  dimension: drug_user_defined_name {
    type: string
    label: "Drug Name - User Defined"
    description: "Customer defined Drug Name"
    sql: ${TABLE}.DRUG_USER_DEFINED_NAME ;;
  }

  dimension: drug_nhin_name {
    type: string
    label: "Drug Name - NHIN"
    description: "Alternate drug name as identified by NHIN"
    sql: ${TABLE}.DRUG_NHIN_NAME ;;
  }

  dimension: drug_manufacturer {
    type: string
    label: "Drug Manufacturer"
    description: "Vendor who manufactures the drug. Could be a wholesaler or distributor"
    sql: ${TABLE}.DRUG_MANUFACTURER ;;
  }

  dimension: drug_ndc_qualifier {
    type: string
    label: "Drug ID Qualifier"
    description: "Flag that indicates to certain insurance claim processors what type of product code is entered in the NDC/DIN field"
    sql: ${TABLE}.DRUG_NDC_QUALIFIER ;;
  }

  dimension: drug_price_code {
    type: string
    label: "Drug Price Code"
    description: "Price code of the Drug. The Drug Price Code information from Drug file may not be accurate."
    sql: ${TABLE}.DRUG_PRICE_CODE ;;
  }

  dimension: drug_barcode {
    type: string
    description: "10+digit NDC number that matches product Barcode."
    sql: ${TABLE}.DRUG_BARCODE ;;
  }

  dimension: drug_category {
    type: string
    label: "Drug Category"
    description: "Code representing a drug category"
    sql: ${TABLE}.DRUG_CATEGORY ;;
  }

  dimension: drug_class {
    type: string
    label: "Drug Class"
    description: "Code representing free-format drug class/alternate group"
    sql: ${TABLE}.DRUG_CLASS ;;
  }

  dimension: drug_strength {
    type: string
    label: "Drug Strength"
    description: "Metric strength or concentration"
    sql: ${TABLE}.DRUG_STRENGTH ;;
  }

  dimension: drug_group {
    type: string
    label: "Drug Group"
    description: "Grouping of drug for reporting purposes"
    sql: ${TABLE}.DRUG_GROUP ;;
  }

  dimension: drug_subgroup {
    type: string
    label: "Drug SubGroup"
    description: "Code representing a sub grouping of drugs"
    sql: ${TABLE}.DRUG_SUBGROUP ;;
  }

  #[ERXLPS-1942] - Updated the label name and description.
  dimension: drug_therapeutic_class {
    type: string
    label: "Drug Therapeutic Class"
    description: "Primary therapeutic class number"
    sql: ${TABLE}.DRUG_THERAPEUTIC_CLASS ;;
  }

  dimension: drug_ddid {
    type: number
    label: "Drug DDID"
    description: "Medi-Span specific Dispensable Drug Identifier which identifies a unique combination of Drug name, Route, Dosage Form, Strength, and Strength Unit of Measure"
    sql: ${TABLE}.DRUG_DDID ;;
    # ERXLPS-199 Change to ensure commas are not shown
    value_format: "###0"
  }

  dimension: drug_dosage_form {
    type: string
    label: "Drug Dosage Form"
    description: "The physical form of a drug intended for administration or consumption"
    sql: ${TABLE}.DRUG_DOSAGE_FORM ;;
  }

  dimension: drug_individual_container_pack {
    type: number
    label: "Drug Individual Container Pack"
    description: "Individual container pack size rounded up to nearest whole number"
    sql: ${TABLE}.DRUG_INDIVIDUAL_CONTAINER_PACK ;;
  }

  dimension: drug_integer_pack {
    type: number
    label: "Drug Integer Pack"
    description: "Integer pack size"
    sql: ${TABLE}.DRUG_INTEGER_PACK ;;
    value_format: "###0"
  }

  dimension: drug_pack {
    type: number
    label: "Drug Pack"
    description: "Decimal pack size"
    sql: ${TABLE}.DRUG_PACK ;;
    value_format: "###0.0000"
  }

# added as a part of [ERXLPS-1241]
  dimension: drug_derived_pack_size {
    type: number
    label: "Derived Pack Size"
    description: "Drug pack size which shows Integer pack size when Decimal pack size is null"
    sql: CASE WHEN ${TABLE}.DRUG_PACK IS NULL THEN ${TABLE}.DRUG_INTEGER_PACK ELSE ${TABLE}.DRUG_PACK END  ;;
    value_format: "###0.0000"
  }

  dimension: drug_packs_per_container {
    type: number
    label: "Drug Packs per Container"
    description: "Number of individual containers per package"
    sql: ${TABLE}.DRUG_PACKS_PER_CONTAINER ;;
    value_format: "###0.0000"
  }

  dimension: drug_sig_route {
    type: string
    label: "Drug SIG Route"
    description: "Route to be used in the SIG when filling Rx"
    sql: ${TABLE}.DRUG_SIG_ROUTE ;;
  }

  dimension: drug_sig_unit {
    type: string
    label: "Drug SIG Unit"
    description: "Units to be used in the SIG at Rx filling time. Tablet, Caps"
    sql: ${TABLE}.DRUG_SIG_UNIT ;;
  }

  dimension: drug_sig_units {
    type: string
    label: "Drug SIG Units"
    description: "Plural units to be used in the SIG at Rx filling time. Tablets, Caps"
    sql: ${TABLE}.DRUG_SIG_UNITS ;;
  }

  dimension: drug_sig_verb {
    type: string
    label: "Drug SIG Verb"
    description: "Verb to be used in the SIG when filling Rx. Take, Chew, etc"
    sql: ${TABLE}.DRUG_SIG_VERB ;;
  }

  #[ERXLPS-1132] - Added new dimension drug_code
  dimension: drug_code {
    type: string
    label: "Drug Code"
    description: "Drug Code to uniquely identify a drug record"
    sql: ${TABLE}.DRUG_CODE ;;
  }

  ########################################################################################################### DATE/TIME specific Fields #########################################################################################
  dimension_group: drug_manufacturer_discontinue {
    label: "Drug Manufacturer Discontinue"
    description: "Date drug was or will be discontinued by the manufacturer"
    type: time
    sql: ${TABLE}.DRUG_MFR_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_add {
    label: "Drug Add"
    description: "Date drug was added in HOST"
    type: time
    sql: ${TABLE}.DRUG_ADD_DATE ;;
  }

  dimension_group: drug_change {
    label: "Drug Change"
    description: "Date drug was changed in HOST"
    type: time
    sql: ${TABLE}.DRUG_CHANGE_DATE ;;
  }

  dimension_group: drug_chain_discountine {
    label: "Drug Chain Discontinue"
    description: "Date drug was or will be discontinued by store or chain"
    type: time
    sql: ${TABLE}.DRUG_CHAIN_DISCONTINUE_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################
  dimension: drug_repack {
    label: "Drug Repack"
    description: "Yes/No Flag indicating if a drug has been repackaged from the original manufacturer package/size"
    type: yesno
    sql: ${TABLE}.DRUG_REPACK = 'Y' ;;
  }

  dimension: drug_preferred_brand {
    label: "Drug Preferred Brand"
    description: "Yes/No Flag indicating if a drug should be treated as a preferred brand product for drug selection logic"
    type: yesno
    sql: ${TABLE}.DRUG_PREFERRED_BRAND = 'Y' ;;
  }

  dimension: drug_preferred_generic {
    label: "Drug Preferred Generic"
    description: "Yes/No Flag indicating if a drug should be treated as a preferred generic product for drug selection logic"
    type: yesno
    sql: ${TABLE}.DRUG_PREFERRED_GENERIC = 'Y' ;;
  }

  dimension: drug_store_generic {
    label: "Drug Store Generic"
    description: "Yes/No Flag indicating if the system lists the transaction as a generic sale in the pharmacist summary of the transaction log and submits the drug as a generic to third parties"
    type: yesno
    sql: ${TABLE}.DRUG_STORE_GENERIC = 'Y' ;;
  }

  dimension: drug_unit_dose {
    label: "Drug Unit Dose Flag"
    description: "Yes/No flag indicating if a drug is considered unit dose"
    type: yesno
    sql: ${TABLE}.DRUG_UNIT_DOSE = 'Y' ;;
  }

  dimension: drug_unit_of_use {
    label: "Drug Unit of Use"
    description: "Yes/No Flag that determines if this drug is a unit of use drug (pack should not be broken) or in other words they cannot open packaging to dispense quantities less than one full package"
    type: yesno
    sql: ${TABLE}.DRUG_UNIT_OF_USE = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################
  dimension: drug_bin_storage_type {
    type: string
    label: "Drug Bin Storage Type"
    description: "Default Bin Type"

    case: {
      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 0 ;;
        label: "NORMAL"
      }

      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 1 ;;
        label: "LARGE"
      }

      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 2 ;;
        label: "REFRIGERATOR"
      }

      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 3 ;;
        label: "FREEZER"
      }

      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 4 ;;
        label: "SAFE LOCKBOX"
      }

      when: {
        sql: ${TABLE}.DRUG_BIN_STORAGE_TYPE = 5 ;;
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
        label: "BRAND"
      }

      when: {
        sql: true ;;
        label: "GENERIC"
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

  ## Changed sort order of Brand Generic Case i.e. 1, 2, 3, = Brand, Generic, Other per AR Team request
  dimension: ar_drug_brand_generic {
    type: string
    description: "Identifies if a drug is brand, generic or other"
    label: "Drug Brand/Generic"

    case: {
      when: {
        sql: COALESCE(${drug_multi_source}, 'Y') <> 'Y' ;; ## Used 'Y' for NULL's to pass to lower branch
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
        sql: ${TABLE}.DRUG_SCHEDULE = 1 ;;
        label: "SCHEDULE I DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 2 ;;
        label: "SCHEDULE II DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 3 ;;
        label: "SCHEDULE III DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 4 ;;
        label: "SCHEDULE IV DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 5 ;;
        label: "SCHEDULE V DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 8 ;;
        label: "OTC"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: drug_schedule_2 {
    type: string
    label: "Drug Schedule 2"
    description: "This identifies all drugs as either, belonging to the 'SCHEDULE II DRUGS' U.S. Drug Schedule, or belonging to 'OTHER SCHEDULE DRUGS'."

    case: {
      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 2 ;;
        label: "SCHEDULE II DRUGS"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE != 2 ;;
        label: "OTHER SCHEDULE DRUGS"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
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
        sql: ${TABLE}.DRUG_SCHEDULE IN (1,2,3,4,5) ;;
        label: "CONTROL"
      }

      # LEGEND
      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.DRUG_SCHEDULE = 8 ;;
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
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A1','AB1') ;;
        label: "AB-RATED 1"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A2','AB2') ;;
        label: "AB-RATED 2"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A3','AB3') ;;
        label: "AB-RATED 3"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A4','AB4') ;;
        label: "AB-RATED 4"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A5','AB5') ;;
        label: "AB-RATED 5"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A6','AB6') ;;
        label: "AB-RATED 6"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A7','AB7') ;;
        label: "AB-RATED 7"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A8','AB8') ;;
        label: "AB-RATED 8"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE IN ('A9','AB9') ;;
        label: "AB-RATED 9"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AA' ;;
        label: "NO BIO PROBLEMS"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AB' ;;
        label: "MEETS BIO"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AN' ;;
        label: "AEROSOL"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AO' ;;
        label: "INJECTABLE OIL SOLUTE"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AP' ;;
        label: "INJECTABLE AQUEOUS"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'AT' ;;
        label: "TOPICAL"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BC' ;;
        label: "CONTROLLED RELEASE"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BD' ;;
        label: "DOCUMENTED BIO ISSUES"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BE' ;;
        label: "ENTERIC DOSAGE"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BN' ;;
        label: "NEBULIZER SYSTEM"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BP' ;;
        label: "POTENTIAL BIO ISSUES"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BR' ;;
        label: "SYSTEMIC USE"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BS' ;;
        label: "DEFICENCIES"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BT' ;;
        label: "BIOEQUIVALENCE ISSUES"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'BX' ;;
        label: "INSUFFICIENT DATA"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'B*' ;;
        label: "FDA REVIEW"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'NA' ;;
        label: "NOT APPLICABLE"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'NR' ;;
        label: "NOT RATED"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'ZA' ;;
        label: "DATABANK REPACKAGED"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'ZB' ;;
        label: "DATABANK"
      }

      when: {
        sql: ${TABLE}.DRUG_THER_EQUIVALENCY_CODE = 'ZC' ;;
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
    sql: ${TABLE}.DRUG_UNIT ;;
  }

  dimension: drug_refrigerate {
    type: string
    label: "Drug Refrigerate"
    description: "Flag that determines if this drug requires refrigeration when shipped"

    case: {
      when: {
        sql: ${TABLE}.DRUG_REFRIGERATE = 'R' ;;
        label: "SHIP REFRIGERATED"
      }

      when: {
        sql: ${TABLE}.DRUG_REFRIGERATE = 'F' ;;
        label: "SHIP FROZEN"
      }

      when: {
        sql: ${TABLE}.DRUG_REFRIGERATE = 'T' ;;
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
    sql: ${TABLE}.DRUG_ROUTE_CODE ;;
  }

  dimension: drug_multi_source {
    type: string
    label: "Drug Multi-Source Indicator"
    description: "Source: Y=Multi, N=Single, O=Orig MFG, M=Multi, Not a Generic"
    sql: ${TABLE}.DRUG_MULTI_SOURCE ;;
  }

  ################################################################################################## End of Dimensions #################################################################################################

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    label: "Drug Count"
    description: "Total Drug count"
    type: count
    value_format: "#,##0"
  }

  ##################################################################################################### End of Measures #################################################################################################

  ##################################################################### Metadata Fields (Required for Data Consumption, if consumed from API) ##########################################################################
  dimension: event_id {
    type: number
    label: "Drug EDW Event ID"
    group_label: "EDW ETL Event Metadata"
    description: "The ETL Event that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: source_timestamp {
    type: date_time
    label: "Drug Source Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/Time the record was last updated in source"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: edw_insert_timestamp {
    type: date_time
    label: "Drug EDW Insert Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension: edw_last_update_timestamp {
    type: date_time
    label: "Drug EDW Last Update Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is updated to EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

##################################################### 4.11 fields ########################################################

  dimension: drug_deleted {
    type: yesno
    label: "Drug Deleted"
    description: "Yes/No flag indicating whether drug is deleted"
    sql: ${TABLE}.DRUG_DELETED = 'Y' ;;
  }

  #[ERXLPS-2064] Added reference dimension to use in joins
  dimension: drug_deleted_reference {
    type: string
    hidden: yes
    label: "Drug Deleted"
    description: "Y/N flag indicating whether drug is deleted"
    sql: ${TABLE}.DRUG_DELETED ;;
  }

  dimension: drug_dme_flag {
    type: yesno
    label: "Drug Durable Medical Equipment"
    description: "Yes/No flag indicating if its DME product - EPS only"
    sql: ${TABLE}.DRUG_DME_FLAG = 'Y' ;;
  }

  dimension: drug_dispensable_identifier {
    type: string
    label: "Drug Dispensable Identifier"
    description: "Dispensable Drug Identifier"
    sql: ${TABLE}.DRUG_DISPENSABLE_IDENTIFIER ;;
  }

  dimension: drug_hazardous_material_flag {
    type: yesno
    label: "Drug Hazardous Material"
    description: "Yes/ No flag indicating if this is a HAZMAT drug. Blank=N"
    sql: ${TABLE}.DRUG_HAZARDOUS_MATERIAL_FLAG = 'Y' ;;
  }

  dimension_group: drug_host_last_update {
    type: time
    label: "Drug Host Last Update"
    description: "Date/Time the drug last updated from Host"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DRUG_HOST_LAST_UPDATE_DATE ;;
  }

  dimension: drug_immunization_flag {
    type: yesno
    label: "Drug Immunization"
    description: "Yes/No flag indicating if drug is Immunization drug"
    sql: ${TABLE}.DRUG_IMMUNIZATION_FLAG = 'Y' ;;
  }

  dimension: drug_interaction_code {
    type: string
    label: "Drug Interaction Code"
    description: "Interaction Code, MEDISPAN"
    sql: ${TABLE}.DRUG_INTERACTION_CODE ;;
  }

  dimension: drug_inner_pack_flag {
    type: yesno
    label: "Drug Inner Pack"
    description: "Yes/No flag indicating if drug is inner package drug"
    sql: ${TABLE}.DRUG_INNER_PACK_FLAG = 'Y' ;;
  }

  dimension_group: drug_last_dispensed {
    type: time
    label: "Drug Last Dispensed"
    description: "Date/Time the drug last dispensed"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LAST_DISPENSED_DATE ;;
  }

  dimension: drug_mail_order_only_flag {
    type: yesno
    label: "Drug Mail Order Only"
    description: "Yes/No flag indicating if Drug is mail order only"
    sql: ${TABLE}.DRUG_MAIL_ORDER_ONLY_FLAG = 'Y' ;;
  }

  dimension: drug_medication_guide_flag {
    type: yesno
    label: "Drug Medication Guide"
    description: "Yes/No flag indicating if Medication Guide is available for this drug"
    sql: ${TABLE}.DRUG_MEDICATION_GUIDE_FLAG = 'Y' ;;
  }

  dimension: drug_rems_monitoring_flag {
    type: yesno
    label: "Drug REMS Monitoring"
    description: "Yes/No flag indicating Monitoring Programs Indicator (REMS) Values Y/N"
    sql: ${TABLE}.DRUG_REMS_MONITORING_FLAG = 'Y' ;;
  }

  dimension: drug_narcotic_code {
    type: string
    label: "Drug Narcotic Code"
    description: "Narcotic code potentially N2/N3/N4"
    sql: ${TABLE}.DRUG_NARCOTIC_CODE ;;
  }

  dimension: drug_new_store_flag {
    type: yesno
    label: "Drug New Store"
    description: "Yes/No flag indicating if its a New Store"
    sql: ${TABLE}.DRUG_NEW_STORE_FLAG = 'Y' ;;
  }

  dimension: drug_original_schedule {
    type: string
    label: "Drug Original Schedule"
    description: "Original Schedule"
    sql: ${TABLE}.DRUG_ORIGINAL_SCHEDULE ;;
  }

  dimension: drug_partial_gpi_flag {
    type: yesno
    label: "Drug Partial GPI"
    description: "Yes/No flag indicating if its partial GPI value"
    sql: ${TABLE}.DRUG_PARTIAL_GPI_FLAG = 'Y' ;;
  }

  dimension: drug_auto_prefill_code {
    type: string
    label: "Drug Auto Prefill Code"
    description: "This flag overrides store level flags unless store level flag is set as H (Halt)"
    case: {
      when: {
        sql: ${TABLE}.DRUG_AUTO_PREFILL_CODE = 'Y' ;;
        label: "AUFO-SET AUTOFILL"
      }

      when: {
        sql: ${TABLE}.DRUG_AUTO_PREFILL_CODE = 'N' ;;
        label: "ALLOW AUTOFILL"
      }

      when: {
        sql: ${TABLE}.DRUG_AUTO_PREFILL_CODE = 'D' ;;
        label: "DISABLE AUTOFILL"
      }
    }
  }

  dimension: drug_region {
    type: number
    label: "Drug Region"
    hidden: yes #[ERXLPS-1926]
    description: "Drug region for comparison at Store paste program"
    sql: ${TABLE}.DRUG_REGION ;;
  }

  dimension: drug_clear_reorder_code_flag {
    type: yesno
    label: "Drug Clear Reorder Code"
    description: "Yes/No flag indicating clear reorder field on paste"
    sql: ${TABLE}.DRUG_CLEAR_REORDER_CODE_FLAG = 'Y' ;;
  }

  dimension: drug_reorder_code {
    type: string
    label: "Drug Reorder Code"
    description: "Code of drug responsible for this drug's Reorder Parameters. Blank = Self."
    sql: ${TABLE}.DRUG_REORDER_CODE ;;
  }

  dimension: drug_single_ingredient_code {
    type: string
    label: "Drug Single Ingredient Code"
    description: "Single Ingredient values S=single C=Combo"
    case: {
      when: {
        sql: ${TABLE}.DRUG_SINGLE_INGREDIENT_CODE = 'C' ;;
        label: "COMBO"
      }

      when: {
        sql: ${TABLE}.DRUG_SINGLE_INGREDIENT_CODE = 'S' ;;
        label: "SINGLE"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: drug_signature_required_flag {
    type: yesno
    label: "Drug Signature Required"
    description: "Yes/No flag indicating if signature is required for delivery of this drug"
    sql: ${TABLE}.DRUG_SIGNATURE_REQUIRED_FLAG = 'Y' ;;
  }

  dimension: drug_specialty_flag {
    type: yesno
    label: "Drug Specialty"
    description: "Yes/ No flag indicating if its a Specialty Drug"
    sql: ${TABLE}.DRUG_SPECIALTY_FLAG = 'Y' ;;
  }

  dimension: drug_tall_man_flag {
    type: yesno
    label: "Drug Tall Man"
    description: "Yes/ No flag indicating if its a Tallman Drug"
    sql: ${TABLE}.DRUG_TALL_MAN_FLAG = 'Y' ;;
  }

  dimension: drug_veterinarian_flag {
    type: yesno
    label: "Drug Veterinarian"
    description: "Yes/ No flag indicating if this drug should be prescribed by a veterinarian - EPS only"
    sql: ${TABLE}.DRUG_VETERINARIAN_FLAG = 'Y' ;;
  }

  dimension: drug_warehouse_flag {
    type: yesno
    label: "Drug Warehouse"
    description: "Yes/ No flag indicating if its a Warehouse Drug"
    sql: ${TABLE}.DRUG_WAREHOUSE_FLAG = 'Y' ;;
  }

  dimension: drug_require_written_flag {
    type: yesno
    label: "Drug Require Written"
    description: "Yes/No Flag indicating if this drug requires a written prescription"
    sql: ${TABLE}.DRUG_REQUIRE_WRITTEN_FLAG = 'Y' ;;
  }

  dimension: drug_injectable_flag {
    type: yesno
    label: "Drug Injectable"
    description: "Yes/No flag indicating if this Drug is an injectable"
    sql: ${TABLE}.DRUG_INJECTABLE_FLAG = 'Y' ;;
  }

  dimension: drug_maximum_pack_multiple {
    type: number
    label: "Drug Maximum Pack Multiple"
    description: "Max Pack Multiple"
    sql: ${TABLE}.DRUG_MAXIMUM_PACK_MULTIPLE ;;
    value_format: "#,##0.00"
  }

  dimension: drug_minimum_dispense_quantity {
    type: number
    label: "Drug Minimum Dispense Quantity"
    description: "Minimum Dispense Qty - EPS Only"
    sql: ${TABLE}.DRUG_MINIMUM_DISPENSE_QUANTITY ;;
    value_format: "#,##0.00"
  }

  dimension: drug_central_fill_code {
    type: string
    label: "Drug Central Fill Code"
    description: "Drug Central Fill code"
    case: {
      when: {
        sql: ${TABLE}.DRUG_CENTRAL_FILL_CODE = 'Y' ;;
        label: "CENTRAL FILL ONLY"
      }
      when: {
        sql: ${TABLE}.DRUG_CENTRAL_FILL_CODE = 'S' ;;
        label: "LOCAL ONLY"
      }
      when: {
        sql: ${TABLE}.DRUG_CENTRAL_FILL_CODE = 'B' ;;
        label: "CENTRAL FILL AND LOCAL BOTH"
      }
    }
  }

  #[ERXLPS-1262] - Missing EDW column dimensions added here.
  dimension: drug_tall_man_name {
    type: string
    label: "Drug Tall Man Name"
    description: "Uses mixed case letters to help draw attention to the dissimilarities in the names of look-alike drug names, i.e. acetaZOLAMIDE versus acetoHEXAMIDE or buPROPion versus busPIRone."
    sql: ${TABLE}.DRUG_TALL_MAN_NAME ;;
  }

  dimension: drug_previous_ndc {
    type: string
    label: "Drug Previous NDC"
    description: "Previous NDC for the Drug"
    sql: ${TABLE}.DRUG_PREVIOUS_NDC ;;
  }

  dimension: drug_replacement_ndc {
    type: string
    label: "Drug Replacement NDC"
    description: "New/replacement NDC for the drug"
    sql: ${TABLE}.DRUG_REPLACEMENT_NDC ;;
  }

  dimension: drug_gcn {
    type: string
    label: "Drug GCN"
    description: "Generic Code Number. A combination of ingredient, strength, form, and route. The GCN is a 5-digit number, assigned sequentially."
    sql: ${TABLE}.DRUG_GCN ;;
  }

  #[ERXLPS-1942] - Updated the label name and description.
  dimension: drug_therapeutic_class8 {
    type: string
    label: "Drug Therapeutic Class8"
    description: "Therapeutic class number based on 8 digits of GPI"
    sql: ${TABLE}.DRUG_THERAPEUTIC_CLASS8 ;;
  }

  dimension: drug_tp_restriction_code {
    type: string
    label: "Drug TP Restriction Code"
    description: "Identifies groups of Drug products and/or formularies"
    case: {
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE IS NULL ;;
        label: "NOT SPECIFIED"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '1' ;;
        label: "INSULIN"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '2' ;;
        label: "ORAL CONTRACEPTIVES"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '3' ;;
        label: "SURGICAL SUPPLY"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '4' ;;
        label: "BLOOD COMPONENT"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '5' ;;
        label: "DIAGNOSTIC AGENT"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '6' ;;
        label: "GENERAL ANESTHETIC"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '7' ;;
        label: "FERTILITY DRUGS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '8' ;;
        label: "ANOREXIC / ANTI-OBESITY"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = '9' ;;
        label: "MULTIPLE VITAMINS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'A' ;;
        label: "HIV INFECTION"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'B' ;;
        label: "BULK CHEMICALS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'C' ;;
        label: "COSMETIC ALTERATION"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'D' ;;
        label: "ANTIDEPRESSANTS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'F' ;;
        label: "MULTIPLE VITAMIN FLOURIDE"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'G' ;;
        label: "GROWTH HORMONES"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'H' ;;
        label: "HYPNOTICS / SEDATIVES"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'I' ;;
        label: "MULTIPLE VITAMIN IRON"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'K' ;;
        label: "NON ORAL CONTRACEPTIVES"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'L' ;;
        label: "CONTRACEPTIVES"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'M' ;;
        label: "IMMUNOSUPPRESSANTS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'P' ;;
        label: "ANTIPSYCHOTICS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'S' ;;
        label: "SMOKING DETERRENTS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'T' ;;
        label: "ANTIANXIETY AGENTS"
      }
      when: {
        sql: ${TABLE}.DRUG_TP_RESTRICTION_CODE = 'V' ;;
        label: "IMPOTENCE AGENTS"
      }
    }
  }

  dimension: drug_maintenance_drug_flag {
    type: yesno
    label: "Drug Maintenance"
    description: "Yes/No Flag indicating if this is a maintenance drug"
    sql: ${TABLE}.DRUG_MAINTENANCE_DRUG_FLAG = 'Y' ;;
  }

  dimension: drug_label_manufacturer {
    type: string
    label: "Drug Label Manufacturer"
    description: "Abreviation of the manufacturer that is printed on the label"
    sql: ${TABLE}.DRUG_LABEL_MANUFACTURER ;;
  }

  dimension: drug_label_dosage_form {
    type: string
    label: "Drug Label Dosage Form"
    description: "Abbreviation of the dosage form that is printed on the label"
    sql: ${TABLE}.DRUG_LABEL_DOSAGE_FORM ;;
  }

  dimension: drug_label_strength {
    type: string
    label: "Drug Label Strength"
    description: "Strength of the drug or concentration that is printed on the label"
    sql: ${TABLE}.DRUG_LABEL_STRENGTH ;;
  }

  dimension: drug_medispan_strength_unit_of_quantity {
    type: string
    label: "Drug Medispan Strength Unit Quantity"
    description: "Drug strength or concentration, but shows Unit only. Does not store the Unit of Measure in same column"
    sql: ${TABLE}.DRUG_MEDISPAN_STRENGTH_UNIT_QUANTITY ;;
  }

  dimension: drug_medispan_strength_unit_of_measure {
    type: string
    label: "Drug Medispan Strength Unit of Measure"
    description: "Drug strength or concentration unit of measure only. Does not store the Unit also in the same column"
    sql: ${TABLE}.DRUG_MEDISPAN_STRENGTH_UNIT_OF_MEASURE ;;
  }

  dimension: drug_nhin_data_source_code {
    type: string
    label: "Drug NHIN Data Source Code"
    description: "Data Provider Identification FOR NHIN. These values indicate where NHIN received the DRUG data from"
    case: {
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 0 ;;
        label: "MULTISRC"
      }
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 1 ;;
        label: "MS ONLY"
      }
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 2 ;;
        label: "FD ONLY"
      }
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 3 ;;
        label: "OTHER"
      }
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 4 ;;
        label: "VERIFIED"
      }
      when: {
        sql: ${TABLE}.DRUG_NHIN_DATA_SOURCE_CODE = 5 ;;
        label: "CUSTOMER"
      }
    }
  }

  dimension_group: drug_last_update {
    type: time
    label: "Drug Update"
    description: "Date/Time the record was last updated in source"
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
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

############################################################# Sets #######################################################

  set: explore_rx_drug_4_11_candidate_list {
    fields: [
      drug_deleted ,
      drug_dme_flag ,
      drug_dispensable_identifier ,
      drug_hazardous_material_flag ,
      drug_immunization_flag ,
      drug_interaction_code ,
      drug_inner_pack_flag ,
      drug_mail_order_only_flag ,
      drug_medication_guide_flag ,
      drug_rems_monitoring_flag ,
      drug_narcotic_code ,
      drug_new_store_flag ,
      drug_original_schedule ,
      drug_partial_gpi_flag ,
      drug_auto_prefill_code ,
      drug_region ,
      drug_clear_reorder_code_flag ,
      drug_reorder_code ,
      drug_single_ingredient_code ,
      drug_signature_required_flag ,
      drug_specialty_flag ,
      drug_tall_man_flag ,
      drug_veterinarian_flag ,
      drug_warehouse_flag ,
      drug_require_written_flag ,
      drug_injectable_flag ,
      drug_maximum_pack_multiple ,
      drug_minimum_dispense_quantity ,
      drug_host_last_update_date,
      drug_host_last_update_time,
      drug_host_last_update_week,
      drug_host_last_update_month,
      drug_host_last_update_month_num,
      drug_host_last_update_year,
      drug_host_last_update_quarter,
      drug_host_last_update_quarter_of_year,
      drug_host_last_update,
      drug_host_last_update_hour_of_day,
      drug_host_last_update_time_of_day,
      drug_host_last_update_day_of_week,
      drug_host_last_update_week_of_year,
      drug_host_last_update_day_of_week_index,
      drug_host_last_update_day_of_month,
      drug_last_dispensed_date,
      drug_last_dispensed_time,
      drug_last_dispensed_week,
      drug_last_dispensed_month,
      drug_last_dispensed_month_num,
      drug_last_dispensed_year,
      drug_last_dispensed_quarter,
      drug_last_dispensed_quarter_of_year,
      drug_last_dispensed,
      drug_last_dispensed_hour_of_day,
      drug_last_dispensed_time_of_day,
      drug_last_dispensed_day_of_week,
      drug_last_dispensed_week_of_year,
      drug_last_dispensed_day_of_week_index,
      drug_last_dispensed_day_of_month,
      drug_central_fill_code
    ]
  }

  set: explore_rx_drug_candidate_list {
    fields: [
      drug_ndc,
      drug_ndc_9,
      drug_ndc_11_digit_format,
      drug_bin_storage_type,
      drug_category,
      drug_class,
      drug_ddid,
      drug_dosage_form,
      drug_full_generic_name,
      drug_full_name,
      drug_generic_name,
      drug_individual_container_pack,
      drug_integer_pack,
      drug_manufacturer,
      drug_brand_generic,
      drug_name,
      drug_schedule,
      drug_schedule_category,
      drug_strength,
      count,
      drug_barcode,
      drug_add_date,
      drug_add_time,
      drug_add_week,
      drug_add_month,
      drug_add_month_num,
      drug_add_year,
      drug_add_quarter,
      drug_add_quarter_of_year,
      drug_add_hour_of_day,
      drug_add_time_of_day,
      drug_add_hour,
      drug_add_minute,
      drug_add_day_of_week,
      drug_add_week_of_year,
      drug_add_day_of_week_index,
      drug_add_day_of_month,
      drug_chain_discountine_date,
      drug_chain_discountine_time,
      drug_chain_discountine_week,
      drug_chain_discountine_month,
      drug_chain_discountine_month_num,
      drug_chain_discountine_year,
      drug_chain_discountine_quarter,
      drug_chain_discountine_quarter_of_year,
      drug_chain_discountine_hour_of_day,
      drug_chain_discountine_time_of_day,
      drug_chain_discountine_hour,
      drug_chain_discountine_minute,
      drug_chain_discountine_day_of_week,
      drug_chain_discountine_week_of_year,
      drug_chain_discountine_day_of_week,
      drug_chain_discountine_week_of_year,
      drug_chain_discountine_day_of_week_index,
      drug_chain_discountine_day_of_month,
      drug_change_date,
      drug_change_time,
      drug_change_week,
      drug_change_month,
      drug_change_month_num,
      drug_change_year,
      drug_change_quarter,
      drug_change_quarter_of_year,
      drug_change_hour_of_day,
      drug_change_time_of_day,
      drug_change_hour,
      drug_change_minute,
      drug_change_day_of_week,
      drug_change_week_of_year,
      drug_change_day_of_week,
      drug_change_week_of_year,
      drug_change_day_of_week_index,
      drug_change_day_of_month,
      drug_group,
      drug_ndc_qualifier,
      drug_manufacturer_discontinue_date,
      drug_multi_source,
      drug_nhin_name,
      drug_user_defined_name,
      drug_ndc_format,
      drug_pack,
      drug_packs_per_container,
      drug_preferred_brand,
      drug_preferred_generic,
      drug_price_code,
      drug_refrigerate,
      drug_repack,
      drug_route_code,
      drug_schedule_2,
      drug_sig_route,
      drug_sig_unit,
      drug_sig_units,
      drug_sig_verb,
      drug_store_generic,
      drug_subgroup,
      drug_therapeutic_class,
      drug_ther_equivalency_code,
      drug_abbreviated_unit,
      drug_unit_dose,
      drug_unit_of_use,
      drug_code #[ERXLPS-1132]
    ]
  }

  set: explore_rx_drug_metadata_candidate_list {
    fields: [
      event_id,
      edw_insert_timestamp,
      edw_last_update_timestamp
    ]
  }
}

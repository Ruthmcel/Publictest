view: poc_drug {
  derived_table: {
  sql: SELECT
    STORE_DRUG_NDC,
    STORE_DRUG_GPI,
    STORE_DRUG_UNIT,
    STORE_DRUG_NAME,
    STORE_DRUG_STRENGTH,
    STORE_DRUG_THERAPEUTIC_CLASS,
    STORE_DRUG_SCHEDULE,
    STORE_DRUG_INJECTABLE,
    STORE_DRUG_MULTI_SOURCE,
    STORE_DRUG_MANUFACTURER_DISCONTINUE_DATE,
    STORE_DRUG_CHAIN_DISCONTINUE_DATE,
    STORE_DRUG_UNIT_OF_USE,
    STORE_DRUG_REFRIGERATE,
    STORE_DRUG_HAZARDOUS_MATERIAL,
    STORE_DRUG_PACKAGE_SIZE,
    STORE_DRUG_PACKS_PER_CONTAINER,
    STORE_DRUG_PREFERRED_GENERIC,
    STORE_DRUG_PREFERRED_BRAND,
    STORE_DRUG_LABELER,
    STORE_DRUG_INDIVIDUAL_CONTAINER_PACK,
    STORE_DRUG_ACQUISITION_COST_SOURCE,
    STORE_DRUG_AWP_SOURCE,
    STORE_DRUG_SPECIALTY,
    Row_number() over (Partition BY STORE_DRUG_NDC ORDER BY SOURCE_TIMESTAMP DESC nulls Last)
    DRUG_ROW_NUM
FROM
    EDW.D_STORE_DRUG ;;

  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${drug_ndc}  ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: drug_ndc {
    # hidden: yes
    label: "Drug NDC"
    type: string
    sql: ${TABLE}.STORE_DRUG_NDC ;;
  }

  dimension: drug_gpi {
    label: "Drug GPI"
    type: string
    sql: ${TABLE}.STORE_DRUG_GPI ;;
  }

  dimension: drug_unit {
    label: "Drug unit"
    type: string
    sql: ${TABLE}.STORE_DRUG_UNIT ;;
  }

  dimension: drug_name {
    label: "Drug Name"
    type: string
    sql: ${TABLE}.STORE_DRUG_NAME ;;
  }


  dimension: drug_row_num {
    hidden: yes
    label: "Drug row Num"
    type: number
    sql: ${TABLE}.DRUG_ROW_NUM ;;
  }

  dimension: drug_strength {
    label: "Drug strength"
    type: string
    sql: ${TABLE}.STORE_DRUG_STRENGTH ;;
  }

  dimension: drug_therapeutic {
    label: "Drug thearputic"
    type: string
    sql: ${TABLE}.STORE_DRUG_THERAPEUTIC_CLASS ;;
  }

  dimension: drug_schedule {
    label: "Drug schedule"
    type: string
    sql: ${TABLE}.STORE_DRUG_SCHEDULE ;;
  }


  dimension: drug_multi_source {
    label: "Drug multi Source"
    type: string
    sql: ${TABLE}.STORE_DRUG_MULTI_SOURCE ;;
  }

  dimension: drug_discont_date {
    label: "Drug discontinued Date"
    type: date
    sql: ${TABLE}.STORE_DRUG_MANUFACTURER_DISCONTINUE_DATE ;;
  }

  dimension: drug_chain_discont_date {
    label: "Drug chain discontinued Date"
    type: date
    sql: ${TABLE}.STORE_DRUG_CHAIN_DISCONTINUE_DATE ;;
  }


   }

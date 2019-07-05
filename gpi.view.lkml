view: gpi {
  sql_table_name: EDW.D_GPI ;;

  dimension: gpi_identifier {
    type: string
    label: "GPI Identifier"
    description: "Generic Product Identifier"
    sql: ${TABLE}.GPI ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${gpi_identifier} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    label: "GPI Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################

  dimension: gpi_description {
    type: string
    label: "GPI Description"
    description: "Description of the drug associated with a GPI number"
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_level {
    type: number
    label: "GPI Level"
    description: "GPI Number level- allows the general to  specific grouping of the drugs based on the classification system"
    sql: ${TABLE}.GPI_LEVEL ;;
  }

  dimension: gpi_level_custom {
    type: number
    description: "GPI level derived from parsing the actual Generic Product Identifier number"
    hidden: yes
    sql: ${TABLE}.GPI_LEVEL_CUSTOM ;;
  }

  dimension: gpi_level_variance_flag {
    type: string
    label: "GPI Level Variance Flag"
    description: "Y/N flag indicating if there is a difference in the GPI Level sourced from the actual source system vs NHIN host"
    sql: ${TABLE}.GPI_LEVEL_VARIANCE_FLAG ;;
  }

  #[ERXDWPS-1454]
  dimension: gpi_drug_group_level1 {
    type: string
    group_label: "Drug GPI Classification"
    label: "Drug Group (Level 1)"
    description: "Drug Group description based on corresponding GPI level within the medispan file received by NHIN. Drug Group dimension is recommended to use along with GPI key dimension of corresponding level."
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_key_drug_group_level1 {
    type: string
    group_label: "Drug GPI Classification"
    label: "GPI Key - Drug Group (Level 1)"
    description: "GPI Key of the drug group. Level 1 is the first 2 digits of GPI."
    sql: substr(${gpi_identifier},1,2) ;;
  }

  dimension: gpi_drug_class_level2 {
    type: string
    group_label: "Drug GPI Classification"
    label: "Drug Class (Level 2)"
    description: "Drug Class description based on corresponding GPI level within the medispan file received by NHIN. Drug Class dimension is recommended to use along with GPI key dimension of corresponding level."
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_key_drug_class_level2 {
    type: string
    group_label: "Drug GPI Classification"
    label: "GPI Key - Drug Class (Level 2)"
    description: "GPI Key of the drug class. Level 2 is the first 4 digits of GPI."
    sql: substr(${gpi_identifier},1,4) ;;
  }

  dimension: gpi_drug_subclass_level3 {
    type: string
    group_label: "Drug GPI Classification"
    label: "Drug Subclass (Level 3)"
    description: "Drug Subclass description based on corresponding GPI level within the medispan file received by NHIN. Drug Subclass dimension is recommended to use along with GPI key dimension of corresponding level."
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_key_drug_subclass_level3 {
    type: string
    group_label: "Drug GPI Classification"
    label: "GPI Key - Drug Subclass (Level 3)"
    description: "GPI Key of the drug subclass. Level 3 is the first 6 digits of GPI."
    sql: substr(${gpi_identifier},1,6) ;;
  }

  dimension: gpi_drug_name_level4 {
    type: string
    group_label: "Drug GPI Classification"
    label: "Drug Name (Level 4)"
    description: "Drug Name description based on corresponding GPI level within the medispan file received by NHIN. Drug Name dimension is recommended to use along with GPI key dimension of corresponding level."
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_key_drug_name_level4 {
    type: string
    group_label: "Drug GPI Classification"
    label: "GPI Key - Drug Name (Level 4)"
    description: "GPI Key of the drug name. Level 4 is the first 10 digits of GPI."
    sql: substr(${gpi_identifier},1,10) ;;
  }

  dimension: gpi_drug_strength_level5 {
    type: string
    group_label: "Drug GPI Classification"
    label: "Drug Strength (Level 5)"
    description: "Drug Strength description based on corresponding GPI level within the medispan file received by NHIN. Drug Strength dimension is recommended to use along with GPI key dimension of corresponding level."
    sql: ${TABLE}.GPI_DESCRIPTION ;;
  }

  dimension: gpi_key_drug_strength_level5 {
    type: string
    group_label: "Drug GPI Classification"
    label: "GPI Key - Drug Strength (Level 5)"
    description: "GPI Key of the drug strength. Level 5 is the entire 14 digits of GPI."
    sql: ${gpi_identifier} ;;
  }

  ################################################################################################## End of Dimensions #################################################################################################

  #################################################################################################### Measures #######################################################################################################

  measure: count {
    label: "Total Drug Cost Types"
    type: count
    value_format: "#,##0"
  }

  ################################################################################################## End of Measures #################################################################################################

  ##################################################################### Metadata Fields (Required for Data Consumption, if consumed from API) #######################################################
  dimension: event_id {
    type: number
    label: "GPI EDW Event ID"
    group_label: "EDW ETL Event Metadata"
    description: "The ETL Event that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: source_timestamp {
    type: date_time
    label: "GPI Source Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/Time the record was last updated in source"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: edw_insert_timestamp {
    type: date_time
    label: "GPI EDW Insert Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension: edw_last_update_timestamp {
    type: date_time
    label: "GPI EDW Last Update Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is updated to EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  set: explore_rx_gpi_metadata_candidate_list {
    fields: [
      event_id,
      edw_insert_timestamp,
      edw_last_update_timestamp
    ]
  }

  set: explore_dx_gpi_levels_candidate_list {
    fields: [
      gpi_drug_group_level1,
      gpi_key_drug_group_level1,
      gpi_drug_class_level2,
      gpi_key_drug_class_level2,
      gpi_drug_subclass_level3,
      gpi_key_drug_subclass_level3,
      gpi_drug_name_level4,
      gpi_key_drug_name_level4,
      gpi_drug_strength_level5,
      gpi_key_drug_strength_level5
    ]
  }
}

view: ar_actualrx_drug_exclusion {
  sql_table_name: EDW.D_ACTUALRX_DRUG_EXCLUSION ;;

  dimension: actualrx_drug_exclusion_added_user_identifier {
    label: "Actualrx Drug Exclusion Added User Identifier"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_ADDED_USER_IDENTIFIER" ;;
  }

  dimension: actualrx_drug_exclusion_deleted {
    label: "Research Note Status"
    description: "Indicates the status of the note"
    type: string
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_DELETED" ;;
  }

  dimension: actualrx_drug_exclusion_drug_ndc {
    label: "NDC"
    description: "Drug NDC defined in the Drug Exclusion table"
    type: string
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_DRUG_NDC" ;;
  }

  dimension: actualrx_drug_exclusion_exclude_from_report_id {
    label: "Exclude from Report flag ID"
    description: "Specifies the ActualRx report/s the NDC/GPI record is excluded from"
    type: number
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_EXCLUDE_FROM_REPORT_ID" ;;
  }

  dimension: actualrx_drug_exclusion_exclude_from_report {
    label: "Exclude from Report flag"
    description: "Specifies the ActualRx report/s the NDC/GPI record is excluded from"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${actualrx_drug_exclusion_exclude_from_report_id}) ;;
  }

  dimension: actualrx_drug_exclusion_gpi {
    label: "GPI"
    description: "GPI defined in the Drug Exclusion table"
    type: string
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_GPI" ;;
  }

  dimension: actualrx_drug_exclusion_last_updated_user_identifier {
    label: "Actualrx Drug Exclusion Last Updated User Identifier"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_LAST_UPDATED_USER_IDENTIFIER" ;;
  }

  dimension: actualrx_drug_exclusion_lcr_id {
    label: "Actualrx Drug Exclusion Lcr Id"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_LCR_ID" ;;
  }

  dimension: unique_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${actualrx_drug_exclusion_sequence_number} ;;
  }

  dimension: actualrx_drug_exclusion_sequence_number {
    label: "Actualrx Drug Exclusion Sequence Number"
    description:""
    type: number
    hidden: yes
    sql: ${TABLE}."ACTUALRX_DRUG_EXCLUSION_SEQUENCE_NUMBER" ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: ""
    type: number
    hidden: yes
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension_group: edw_insert_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_INSERT_TIMESTAMP" ;;
  }

  dimension_group: edw_last_update_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_LAST_UPDATE_TIMESTAMP" ;;
  }

  dimension: event_id {
    type: number
    hidden: yes
    sql: ${TABLE}."EVENT_ID" ;;
  }

  dimension: load_type {
    type: string
    hidden: yes
    sql: ${TABLE}."LOAD_TYPE" ;;
  }

  dimension_group: source_create_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_CREATE_TIMESTAMP" ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}."SOURCE_SYSTEM_ID" ;;
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SOURCE_TIMESTAMP" ;;
  }

}

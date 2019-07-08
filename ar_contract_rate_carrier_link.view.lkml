view: ar_contract_rate_carrier_link {
  sql_table_name: EDW.D_CONTRACT_RATE_CARRIER_LINK ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${contract_rate_id} ||'@'|| ${contract_rate_carrier_id} ;;
  }

  dimension: chain_id {
    type: number
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: contract_rate_carrier_id {
    type: number
    label: "Contract Rate Carrier ID"
    description: "Unique ID assigned to a Contract Rate Carrier ID which must be unique"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_ID ;;
  }

  dimension: contract_rate_id {
    type: number
    label: "Contract Rate ID"
    description: "Unique ID assigned to a Contract Rate Network Name and Tp Contract ID which together must be unique"
    sql: ${TABLE}.CONTRACT_RATE_ID ;;
  }

  dimension: contract_rate_carrier_link_deleted {
    type: string
    hidden:  yes
    label: "Contract Rate Carrier Link Deleted"
    description: "Contract Rate Carrier Link Deleted"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_LINK_DELETED ;;
  }

#################################################################################### Measure  ##############################################################################################################

  measure: count {
    type: count
    label: "Total Contract Rate  Carrier Links"
    value_format: "#,##0;(#,##0)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_LINK_LCR_ID ;;
  }

  dimension: event_id {
    hidden:  yes
    type: number
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: edw_insert_timestamp {
    hidden:  yes
    type: time
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    hidden:  yes
    type: time
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }
  dimension_group: source_timestamp {
    hidden:  yes
    type: time
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}
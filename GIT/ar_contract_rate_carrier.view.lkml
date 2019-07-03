view: ar_contract_rate_carrier {
  sql_table_name: EDW.D_CONTRACT_RATE_CARRIER ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################


  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${contract_rate_carrier_id} ;;
  }

  dimension: chain_id {
    type: number
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: source_system_id {
    type: number
    label: "EDW Source System Identifier"
    description: "Unique ID number identifying an BI source sytem"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: contract_rate_carrier_id {
    type: number
    label: "Contract Rate Carrier ID"
    description: "Unique ID assigned to a Contract Rate Carrier ID which must be unique"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_ID ;;
  }

  dimension: contract_rate_carrier_plan_id {
    type: number
    hidden: yes
    label: "Contract Rate Carrier Plan ID"
    description: "Referential Key to the Carrier Plan"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_PLAN_ID ;;
  }

  dimension: contract_rate_carrier_group_code {
    type: string
    label: "Contract Rate Carrier Group Code"
    description: "Unique code used to identify a third party group"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_GROUP_CODE ;;
  }

  dimension: contract_rate_carrier_bin_number {
    type: string
    label: "Contract Rate Carrier BIN Number"
    description: "ANSI Bank Identification Number for claim transmittals"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_BIN_NUMBER ;;
  }

  dimension: contract_rate_carrier_pcn_number {
    type: string
    label: "Contract Rate Carrier Group Code"
    description: "Third Party Processor Control Number that aids the third party processor in distinguishing the software and the different insurance plans"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_PCN_NUMBER ;;
  }

  dimension: contract_rate_carrier_added_user_identifier {
    type: number
    label: "Contract Rate Carrier Added User Identifier"
    description: "User ID from when the Contract Rate Carrier record was added to the Contract Rate Table"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_ADDED_USER_IDENTIFIER ;;
  }

  dimension: contract_rate_carrier_last_update_user_identifier {
    type: number
    label: "Contract Rate Carrier Last Update User Identifier"
    description: "User ID from when the Contract Rate Carrier record was last updated by a User"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_LAST_UPDATE_USER_IDENTIFIER ;;
  }

#################################################################################### Measure  ##############################################################################################################

  measure: count {
    type: count
    label: "Total Contract Rate Carrier"
    value_format: "#,##0;(#,##0)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: contract_rate_carrier_deleted {
    type: string
    hidden:  yes
    label: "Contract Rate Carrier Deleted"
    description: "Contract Rate Carrier Deleted"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_DELETED ;;
  }

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.CONTRACT_RATE_CARRIER_LCR_ID ;;
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
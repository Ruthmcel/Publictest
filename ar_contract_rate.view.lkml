view: ar_contract_rate {
  sql_table_name: EDW.D_CONTRACT_RATE ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${contract_rate_id} ;;
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
    description: "Unique ID number identifying an BI source system"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: contract_rate_id {
    type: number
    label: "Contract Rate ID"
    description: "Unique ID assigned to a Contract Rate Network Name and TP Contract ID which together must be unique"
    sql: ${TABLE}.CONTRACT_RATE_ID ;;
  }

  dimension: third_party_contract_id {
    hidden:  yes
    type: number
    label: "Third Party Contract ID"
    description: "ID of the contract for the TP that is not unique in the table, but must be unique in combination with the Contract Rate Network Name"
    sql: ${TABLE}.CONTRACT_RATE_THIRD_PARTY_CONTRACT_ID ;;
  }

  dimension: contract_rate_state_type_id {
    type: number
    hidden: yes
    label: "Contract Rate State Type ID"
    description: "ID of the state for which this Contract Rate will apply and is valid"
    sql: ${TABLE}.CONTRACT_RATE_STATE_TYPE_ID ;;
  }

  dimension: contract_rate_lower_of_value_type_id {
    label: "Contract Rate Lower of Value Type"
    description: "This is a Value that the Contract Rate Carrier may use if it is lower than the Pricing Point number that is determined, this would then be used for reimbursement"
    type: number
    hidden: yes
    sql: ${TABLE}.CONTRACT_RATE_LOWER_OF_VALUE_TYPE_ID ;;
  }

  dimension: contract_rate_brand_or_generic_type_id {
    label: "Contract Rate Brand or Generic Type"
    description: "Used to identify if a contract rate ties to a Brand, Generic or Both"
    type: number
    hidden: yes
    sql: ${TABLE}.CONTRACT_RATE_BRAND_OR_GENERIC_TYPE_ID ;;
  }

  dimension: contract_rate_added_user_identifier {
    type: number
    label: "Contract Rate Added User Identifier"
    description: "User ID from when the Contract Rate record was added to the Contract Rate Table"
    sql: ${TABLE}.CONTRACT_RATE_ADDED_USER_IDENTIFIER ;;
  }

  dimension: contract_rate_last_update_user_identifier {
    type: number
    label: "Contract Rate Last Update User Identifier"
    description: "User ID from when the Contract Rate record was last updated by a User"
    sql: ${TABLE}.CONTRACT_RATE_LAST_UPDATE_USER_IDENTIFIER ;;
  }

  dimension: contract_rate_network_identifier {
    label: "Contract Rate Network ID"
    description: "Third Party ID of the Network used in reimbursement"
    type: string
    sql: ${TABLE}.CONTRACT_RATE_NETWORK_IDENTIFIER ;;
  }

  dimension: contract_rate_network_name {
    type: string
    label: "Contract Rate Network Name"
    description: "The Name of the contract that a customer has with a payer based on specific criteria"
    sql: ${TABLE}.CONTRACT_RATE_NETWORK_NAME ;;
  }

  dimension_group: contract_rate_start_date {
    type: time
    label: "Contract Rate Start"
    description: "Start Date that the Contract Rate is eligible from"
    sql: ${TABLE}.CONTRACT_RATE_START_DATE ;;
  }

  dimension_group: contract_rate_end_date {
    type: time
    label: "Contract Rate End"
    description: "End Date that ends the eligibility of the Contract Rate"
    sql: ${TABLE}.CONTRACT_RATE_END_DATE ;;
  }

  dimension: contract_rate_start_days_supply {
    type: number
    label: "Contract Rate Start Days Supply"
    description: "Beginning eligible amount of days supply that Contract Rate is eligible for"
    sql: ${TABLE}.CONTRACT_RATE_START_DAYS_SUPPLY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: contract_rate_end_days_supply {
    type: number
    label: "Contract Rate End Days Supply"
    description: "Ending eligible amount of days supply that Contract Rate is eligible for"
    sql: ${TABLE}.CONTRACT_RATE_END_DAYS_SUPPLY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  ###################################################################### Master code dimensions ##############################################
  dimension: contract_rate_state_type_id_mc {
    label: "Contract Rate State Type"
    description: "State for which this Contract Rate will apply and is valid"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CONTRACT_RATE_STATE_TYPE_ID) ;;
    suggestions : ["ALL STATES","ALABAMA","ARIZONA","ARKANSAS","CALIFORNIA","COLORADO","MICHIGAN","MINNESOTA","MISSISSIPPI","NEVADA","NEW YORK","OHIO","SOUTH CAROLINA","TENNESSEE","TEXAS"]
  }

  dimension: contract_rate_lower_of_value_type_id_mc {
    label: "Contract Rate Lower of Value Type"
    description: "Value that the Contract Rate Carrier may use if it is lower than the Pricing Point number that is determined, this would then be used for reimbursement"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CONTRACT_RATE_LOWER_OF_VALUE_TYPE_ID) ;;
    suggestions : ["NOT APPLICABLE", "USUAL & CUSTOMARY"]
  }

  dimension: contract_rate_brand_or_generic_type_id_mc {
    label: "Contract Rate Brand or Generic Type"
    description: "Used to identify if a contract rate ties to a Brand, Generic or Both"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CONTRACT_RATE_BRAND_OR_GENERIC_TYPE_ID) ;;
    suggestions : ["BOTH", "BRAND" , "GENERIC"]
  }

#################################################################################### Measure  ##############################################################################################################

  measure: contract_rate_adjustment_percentage {
    type: sum
    label: "Contract Rate Adjustment Percentage"
    description: "Percentage that the TP Contract Carrier uses to determine how reimbursements may be made"
    sql: ${TABLE}.CONTRACT_RATE_ADJUSTMENT_PERCENTAGE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: contract_rate_add_adjustment_percentage {
    type: sum
    label: "Contract Rate Additional Adjustment Percentage"
    description: "Additional Second Percentage that the TP Contract Carrier uses to determine how reimbursements may be made. Adjustment will be made with this percentage after other fees and adjustments are applied"
    sql: ${TABLE}.CONTRACT_RATE_ADD_ADJUSTMENT_PERCENTAGE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: contract_rate_administration_fee {
    type: sum
    label: "Contract Rate Administration Fee"
    description: "Administration fees that payers are willing to pay pharmacists/pharmacies for giving immunizations"
    sql: ${TABLE}.CONTRACT_RATE_ADMINISTRATION_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: contract_rate_dispensing_fee {
    type: sum
    label: "Contract Rate Dispensing Fee"
    description: "Dispensing that is added the to Pricing Point. Eg. AWP – 20% + $2.50.  $2.50 is that dispensing fee"
    sql: ${TABLE}.CONTRACT_RATE_DISPENSING_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: contract_rate_cost_base {
    type: sum
    label: "Contract Rate Cost Base"
    description: "Pricing Points that determine how reimbursements may be made"
    sql: ${TABLE}.CONTRACT_RATE_COST_BASE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: contract_rate_service_fee {
    type: sum
    label: "Contract Rate Service Fee"
    description: "Old contract rate screen from 2012. Service fee that was applied to contract rate"
    sql: ${TABLE}.CONTRACT_RATE_SERVICE_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }


  measure: contract_rate_transaction_fee {
    type: sum
    label: "Contract Rate Transaction Fee"
    description: "click fee that a payer charges a pharmacy for submitting an electronic transaction"
    sql: ${TABLE}.CONTRACT_RATE_TRANSACTION_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: contract_rate_underpay_threshold {
    type: sum
    label: "Contract Rate Underpay Threshold"
    description: "Additional Percentage that the TP Contract Carrier uses to determine how reimbursements may be made"
    sql: ${TABLE}.CONTRACT_RATE_UNDERPAY_THRESHOLD ;;
  }

  dimension: contract_rate_deleted {
    type: string
    hidden:  yes
    label: "Contract Rate Deleted"
    description: "Contract Rate Deleted"
    sql: ${TABLE}.CONTRACT_RATE_DELETED ;;
  }

  measure: count {
    type: count
    label: "Total Contract Rates"
    description: "Total Unique Networks per Contract"
#     drill_fields: [contract_rate_network_name]
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.CONTRACT_RATE_LCR_ID ;;
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

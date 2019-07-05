view: ar_claim_to_contract_rate {
  label: "Contract Rate"
  sql_table_name: edw.f_claim_to_contract_rate ;;
  #################################################################################### dimesions ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${transaction_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain ID"
    type: number
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: transaction_id {
    hidden:  yes
    label: "Transaction ID"
    type: number
    description: "Unique ID of the transaction associated with this claim. ID of the TRANSACTION_STATUS table record for this claim."
    sql: ${TABLE}.transaction_id ;;
    value_format: "####"
  }

  dimension: source_system_id {
    label: "Source System ID"
    type: number
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    sql: ${TABLE}.source_system_id ;;
  }

  dimension: third_party_contract_id {
    type: number
    description: "ID of the THIRD_PARTY_CONTRACT table record that is associated with this claim"
    hidden: yes
    sql: ${TABLE}.third_party_contract_id ;;
  }

  dimension: contract_rate_id {
    type: number
    description: "Indicates which contract rate this claim follows (ID of the CONTRACT_RATE table record for the associated third party contract for this claim)"
    hidden: yes
    sql: ${TABLE}.contract_rate_id ;;
  }

  dimension: contract_rate_carrier_id {
    type: number
    description: "ID of the CONTRACT_RATE_CARRIER table record that is associated with this claim"
    hidden: yes
    sql: ${TABLE}.contract_rate_carrier_id ;;
  }

  dimension: claim_to_contract_rate_added_user_identifier {
    label: "User Identifier"
    type: number
    description: "ID of the user who added this claim to contract record"
    sql: ${TABLE}.claim_to_contract_rate_added_user_identifier ;;
    value_format: "####"
  }

  dimension: claim_to_contract_rate_last_update_user_identifier {
    label: "Last Updated User Identifier"
    type: number
    description: "ID of the user who last updated this claim to contract record"
    sql: ${TABLE}.claim_to_contract_rate_last_update_user_identifier ;;
    value_format: "####"
  }

  dimension: claim_to_contract_rate_carrier_code {
    label: "Carrier Code"
    type: string
    description: "Unique code used to identify a third party carrier"
    sql: ${TABLE}.claim_to_contract_rate_carrier_code ;;
  }

  dimension: claim_to_contract_rate_plan_code {
    label: "Plan Code"
    type: string
    description: "Unique code used to identify a third party carrier plan"
    sql: ${TABLE}.claim_to_contract_rate_plan_code ;;
  }

  dimension: claim_to_contract_rate_group_code {
    label: "Group Code"
    type: string
    description: "Unique code used to identify a third party group"
    sql: ${TABLE}.claim_to_contract_rate_group_code ;;
  }
}

#############################################################################################################################################################################################################
view: ar_contract_rate_pricing {
  label: "Contract Rate Pricing"
  sql_table_name: EDW.D_CONTRACT_RATE_PRICING ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${contract_rate_id} ||'@'|| ${contract_rate_pricing_cost_base_type_id} ||'@'|| ${contract_rate_pricing_mac_list_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: contract_rate_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_ID ;;
  }

  dimension: contract_rate_pricing_percentage_adjustment_type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_PERCENTAGE_ADJUSTMENT_TYPE_ID ;;
  }

  dimension: contract_rate_pricing_cost_base_type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_COST_BASE_TYPE_ID ;;
  }

  dimension: contract_rate_pricing_mac_list_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_MAC_LIST_ID ;;
  }

  dimension: contract_rate_pricing_type_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_TYPE_ID ;;
  }

  dimension: source_system_id {
    type: number
    description: "Unique ID number identifying a BI source system"
    sql: ${TABLE}.source_system_id ;;
    hidden: yes
  }

  dimension: contract_rate_pricing_dispensing_fee {
    label: "Dispensing Fee"
    description: "Dispensing fee to be used for this contract rate pricing calculation"
    type: number
    hidden: yes
    sql: ${TABLE}.CONTRACT_RATE_PRICING_DISPENSING_FEE ;;
  }

################################################################################## Master code dimensions ################################################################################################

  dimension: contract_rate_pricing_cost_base_type_id_mc {
    type: string
    label: "Third Party Contract Rate Pricing Base Type"
    description: "??"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CONTRACT_RATE_PRICING_COST_BASE_TYPE_ID) ;;
    suggestions : ["AVERAGE WHOLESALE PRICE (FIRST DATABANK)",
                  "AVERAGE WHOLESALE PRICE (MEDI-SPAN)",
                  "WHOLESALE ACQUISITION COST (MEDI-SPAN)",
                  "MAXIMUM ALLOWABLE COST (MEDI-SPAN)",
                  "DIRECT (MEDI-SPAN)",
                  "FEE SCHEDULE",
                  "USUAL & CUSTOMARY",
                  "AVERAGE AVERAGE WHOLESALE PRICE (MEDI-SPAN)",
                  "FEDERAL UPPER LIMIT ACF (MEDI-SPAN)",
                  "NATIONAL AVERAGE ACQUISITION COST CHAIN (MEDI-SPAN)"]
  }
  dimension: contract_rate_pricing_type_id_mc {
    type: string
    label: "Third Party Contract Rate Pricing Type"
    description: "??"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.CONTRACT_RATE_PRICING_TYPE_ID) ;;
    suggestions : ["CALCULATED RATE","FEE SCHEDULE","STATIC VALUE"]
  }


  #################################################################################################### End of Foreign Key References #########################################################################

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ###################################################

  filter: contract_rate_pricing_dispensing_fee_filter {
    label: "Dispensing Fee"
    description: "Dispensing fee to be used for this contract rate pricing calculation"
    type: number
    sql: {% condition contract_rate_pricing_dispensing_fee_filter %} ${contract_rate_pricing_dispensing_fee} {% endcondition %}
      ;;
  }

  #####################################################################################################################################################################################################################
  ################################################################################################## Dimensions ################################################################################################

  dimension: contract_rate_pricing_deleted {
    label: "Contract rate pricing deleted"
    hidden: yes
    type: string
    sql: ${TABLE}.CONTRACT_RATE_PRICING_DELETED ;;
  }

  dimension: cost_base_nhin_type {
    label: "Cost Base"
    description: "Type of cost to be used for pricing calculation"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${contract_rate_pricing_cost_base_type_id}) ;;
  }

  dimension: pricing_nhin_type {
    label: "Pricing Type"
    description: "Type of pricing"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${contract_rate_pricing_type_id}) ;;
  }

  dimension: contract_rate_pricing_added_user_identifer {
    label: "User Identifier"
    description: "ID of the user who added this contract rate pricing"
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_ADDED_USER_IDENTIFER ;;
    value_format: "####"
  }

  dimension: contract_rate_pricing_last_update_user_identifier {
    label: "Last Updated User Identifier"
    description: "ID of the user who last updated this contract rate pricing"
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "####"
  }

  dimension: contract_rate_pricing_percentage_adjustment {
    label: "Percentage Adjustment"
    description: "Percentage to be used for this pricing calculation"
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PRICING_PERCENTAGE_ADJUSTMENT ;;
    value_format: "00.00\"%\""
  }

  ################################################################################################## End of Dimensions #########################################################################################

  ################################################################################################## Measures ################################################################################################

  measure: sum_contract_rate_pricing_dispensing_fee {
    label: "Dispensing Fee"
    description: "Dispensing fee to be used for this contract rate pricing calculation"
    type: sum
    sql: ${TABLE}.CONTRACT_RATE_PRICING_DISPENSING_FEE/100 ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

 # [ARND-11285] - New Measure for Percentage Adjustment
  measure: sum_contract_rate_pricing_percentage_adjustment {
    label: "Contract Rate Percentage Adjustment"
    description: "Percentage to be used for this contract rate pricing calculation as a measure."
    type: sum
    sql: ${TABLE}.CONTRACT_RATE_PRICING_PERCENTAGE_ADJUSTMENT/100 ;;
    value_format:  "00.00%"
  }
}

################################################################################################## End of Measures ################################################################################################

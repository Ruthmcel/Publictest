view: ar_contract_rate_dir {
  sql_table_name: REPORT_TEMP.D_CONTRACT_RATE_DIR ;;

  ## NOTE:  IF AT ANY TIME WE CHANGE JOINS IN THE AR EXPLORE TO DIRECTLY EXPOSE THIS VIEW IN THE AR MODEL... THE FORMATTING CHANGES THAT WERE APPLIED
  ##        TO THE ar_contract_rate_dir_latest VIEW ** NEED ** TO BE APPLIED TO THIS VIEW ALSO -- 7/25/2018

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################
  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${contract_rate_dir_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: contract_rate_dir_id {
    type: number
    sql: ${TABLE}.CONTRACT_RATE_DIR_ID ;;
  }

  dimension: contract_rate_id {
    hidden:  yes
    type: number
    sql: ${TABLE}.CONTRACT_RATE_ID ;;
  }

  dimension: adj_base_type_id {
    type: number
    sql: ${TABLE}.ADJ_BASE_TYPE_ID ;;
  }

  dimension: awp_wac_add_subtract_type_id {
    type: number
    sql: ${TABLE}.AWP_WAC_ADD_SUBTRACT_TYPE_ID ;;
  }

  dimension: awp_wac_cost_base_type_id {
    type: number
    sql: ${TABLE}.AWP_WAC_COST_BASE_TYPE_ID ;;
  }


  dimension: contract_rate_add_subtract_type_id {
    type: number
    sql: ${TABLE}.CONTRACT_RATE_ADD_SUBTRACT_TYPE_ID ;;
  }

  dimension: contract_rate_cost_base_type_id {
    type: number
    sql: ${TABLE}.CONTRACT_RATE_COST_BASE_TYPE_ID ;;
  }

  dimension: dir_fee_calculation {
    type: string
    sql: ${TABLE}.DIR_FEE_CALCULATION ;;
  }

  dimension: dir_fee_type {
    type: number
    sql: ${TABLE}.DIR_FEE_TYPE ;;
    value_format: "######"
  }

  dimension: dir_flat_fee_amt_reference {
    type: number
    sql: ${TABLE}.DIR_FLAT_FEE_AMT/100 ;;
  }

  measure: sum_dir_flat_fee_amt {
    type: sum
    sql: ${TABLE}.DIR_FLAT_FEE_AMT/100 ;;
  }

  dimension: dir_pct_reference {
    type: number
    sql: ${TABLE}.DIR_PCT ;;
  }

  ## VALUE IS STORED AS WHOLE PERCENT IN TABLE, DIVISION BY 100 TO CONVERT TO A DECIMAL AND ALLOW MULTIPLICATION WITH FIELDS
  dimension: dir_pct_as_pct_reference {
    hidden:  yes
    type: number
    sql: ${TABLE}.DIR_PCT / 100 ;;
  }

  measure: sum_dir_pct {
    type: sum
    sql: ${TABLE}.DIR_PCT ;;
  }

  dimension: awp_wac_pct_reference {
    type: number
    sql: ${TABLE}.AWP_WAC_PCT ;;
  }

  measure: awp_wac_pct {
    type: sum
    sql: ${TABLE}.AWP_WAC_PCT ;;
  }

  dimension: contract_rate_pct_reference {
    type: number
    sql: ${TABLE}.CONTRACT_RATE_PCT ;;
  }

  measure: contract_rate_pct {
    type: sum
    sql: ${TABLE}.CONTRACT_RATE_PCT ;;
  }
}

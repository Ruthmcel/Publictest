view: ar_non_contract_rate_dir {
  sql_table_name: REPORT_TEMP.D_NON_CONTRACT_RATE_DIR ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${bin} ||'@'|| ${pcn} ||'@'|| ${group_code} ||'@'|| ${brand_generic} || '@' || ${days_supply_start} || '@' || ${days_supply_end} || '@' || ${network_id};; # ERXDWPS-6327 Changes
  }

  dimension: chain_id {
    hidden:  yes
    type: number
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension: bin {
    hidden:  yes
    type: string
    sql: ${TABLE}."BIN" ;;
  }

  dimension: pcn {
    hidden:  yes
    type: string
    sql: ${TABLE}."PCN" ;;
  }

  dimension: group_code {
    hidden:  yes
    type: string
    sql: ${TABLE}."GROUP_CODE" ;;
  }

  dimension: brand_generic {
    hidden:  yes
    type: string
    sql: ${TABLE}."BRAND_GENERIC" ;;
  }

################################################################ Dimensions ############################################################

  dimension: pbm {
    label: "PBM"
    description: "PBM name for the non-contract DIR table"
    type: string
    sql: ${TABLE}."PBM" ;;
  }

  dimension: dir_plan_name {
    label:  "DIR Plan Name"
    description: "Plan name associated with each DIR Network"
    type: string
    sql: ${TABLE}."DIR_PLAN_NAME" ;;
  }

  dimension: network_id {
    label: "Network ID"
    description: "Network ID for Non Contract DIR"
    type: string
    sql: ${TABLE}."NETWORK_ID" ;;
  }

  dimension: comments {
    label: "Comments"
    description: "The comments that pertain to the Non Contract Rate DIR record"
    type: string
    sql: ${TABLE}."COMMENTS" ;;
  }

  ## Exposing Start and End, leaving string hidden
  dimension: days_supply {
    hidden:  yes
    type: string
    sql: ${TABLE}."DAYS_SUPPLY" ;;
  }

  dimension: days_supply_start {
    label: "Days Supply Start"
    description: "The starting number for the Day's Supply Range that is applicable to this DIR rate"
    type: number
    sql: ${TABLE}."DAYS_SUPPLY_START" ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: days_supply_end {
    label: "Days Supply End"
    description: "The ending number for the Days Supply Range that is applicable to this DIR rate"
    type: number
    sql: ${TABLE}."DAYS_SUPPLY_END" ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: dir_fee_type {
    label: "DIR Fee Type"
    description: "Description of how the DIR Fee is calculated (Flat Fee or Percent)"
    type: number
    sql: ${TABLE}."DIR_FEE_TYPE" ;;
    value_format: "######"
  }

  ## NOTE: This is different from the Contract Rate table, it is stored without percent in the other table
  dimension: dir_flat_fee_amt {
    label: "DIR Flat Fee Amount"
    description: "DIR Flat Fee Amount"
    type: number
    sql: ${TABLE}.DIR_FLAT_FEE_AMT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_dir_flat_fee_amt {
    label: "Total DIR Flat Fee Amount"
    description: "The sum of DIR Flat Fee Amount"
    type: sum
    sql: ${TABLE}."DIR_FLAT_FEE_AMT" ;;
  }

  ## Used in the DIR Accrual calculation. The value is stored as a decimal representing the percentage thus needs division for logic, but no division for end users as dimension
  dimension: dir_pct_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DIR_PCT / 100 ;;
  }

  dimension: dir_pct {
    label: "DIR Percentage"
    description: "DIR Percentage"
    type: number
    sql: ${TABLE}.DIR_PCT ;;
  }

############################################################### Master code Dimensions #################################################

  dimension: adj_base_type_id {
    hidden:  yes
    type: number
    sql: ${TABLE}."ADJ_BASE_TYPE_ID" ;;
  }

  dimension: adj_base_type_id_mc {
    label: "Adjusted Base Type"
    description:  "Contract Rate DIR values; Ing Cost (20301), Ttl Pd Amt (20302), AWP Fill (20303), WAC Fill (20304)"
    type: string
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${adj_base_type_id}) ;;
  }


}

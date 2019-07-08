view: ar_contract_rate_dir_latest {
  label: "Contract Rate DIR"

  ## (1) THIS DERIVED TABLE IS NEEDED BECAUSE THERE ARE UP TO AS MANY AS THREE POSSIBLE CONTRACT RATES IN THE CONTRACT RATE TABLE FOR A SINGLE UNIQUE TRANSACTION CLAIM
  ## AND, SINCE THE AR TEAM STATED THAT WE SHOULD BE KEEPING THE LATEST ONLY FOR DIR CALCULATIONS
  ## (2) THIS SHOULD BE REVISITED ONCE AR TEAM CLEANS UP CONTRACT RATE FILE CABINENT AND EXPLORE HAS CONTRACT RATE DIR TABLES

  derived_table: {
    sql:
          SELECT *
          FROM (
                  SELECT chain_id
                    , contract_rate_dir_id
                    , contract_rate_id
                    , dir_fee_calculation
                    , dir_fee_type
                    , dir_pct
                    , dir_flat_fee_amt
                    , adj_base_type_id
                    , awp_wac_cost_base_type_id
                    , awp_wac_add_subtract_type_id
                    , awp_wac_pct
                    , contract_rate_cost_base_type_id
                    , contract_rate_add_subtract_type_id
                    , contract_rate_pct
                    , row_number () over (partition by chain_id, contract_rate_id order by contract_rate_dir_id desc) rnk
                  FROM report_temp.d_contract_rate_dir
                  WHERE {% condition ar_chain.chain_id %} CHAIN_ID {% endcondition %}
                )
          WHERE rnk = 1
        ;;

  }

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

    ## NOTE: THE UNIQUENESS OF THIS TABLE WITHOUT THE DERIVED VIEW IS ACTUALLY BASED ON THE CONTRACT_RATE_DIR_ID, HOWEVER, THE GRAIN HAS CHANGED TO CONTRACT_RATE TO ENSURE UNIQUENESS WITH CLAIMS
    dimension: unique_key {
      hidden: yes
      primary_key: yes
      type: string
      sql: ${chain_id} ||'@'|| ${contract_rate_id} ;;
    }

    dimension: chain_id {
      hidden:  yes
      type: number
      sql: ${TABLE}.CHAIN_ID ;;
    }

    dimension: contract_rate_dir_id {
      hidden: yes
      description: "Database ID for unique DIR record"
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
      hidden: yes
      sql: ${TABLE}.ADJ_BASE_TYPE_ID ;;
    }

    dimension: awp_wac_add_subtract_type_id {
      type: number
      hidden: yes
      sql: ${TABLE}.AWP_WAC_ADD_SUBTRACT_TYPE_ID ;;
    }

    dimension: awp_wac_cost_base_type_id {
      type: number
      hidden: yes
      sql: ${TABLE}.AWP_WAC_COST_BASE_TYPE_ID ;;
    }

    dimension: contract_rate_add_subtract_type_id {
      type: number
      hidden: yes
      sql: ${TABLE}.CONTRACT_RATE_ADD_SUBTRACT_TYPE_ID ;;
    }

    dimension: contract_rate_cost_base_type_id {
      type: number
      hidden: yes
      sql: ${TABLE}.CONTRACT_RATE_COST_BASE_TYPE_ID ;;
    }
    ################################################################# Reference Dimensions #################################################

    ## Need this divided by 100 before it can be used in the DIR Accrual calculation, but cannot display this way to the user. See dimension below
    dimension: dir_pct_reference {
      hidden: yes
      type: number
      sql: ${TABLE}.DIR_PCT / 100 ;;
    }

    ## Not being used currently in DIR calculation but needs to be divided by 100 before used in any calculation
    dimension: awp_wac_pct_reference {
      type: number
      hidden: yes
      sql: ${TABLE}.AWP_WAC_PCT / 100 ;;
    }

    ## Not being used currently in DIR calculation but needs to be divided by 100 before used in any calculation
    dimension: contract_rate_pct_reference {
      type: number
      hidden: yes
      sql: ${TABLE}.CONTRACT_RATE_PCT / 100 ;;
    }

    ################################################################ Dimensions ############################################################
    dimension: dir_fee_calculation {
      label: "DIR Fee Calculation"
      description: "Display of DIR Fee Calculation"
      type: string
      sql: ${TABLE}.DIR_FEE_CALCULATION ;;
    }

    dimension: dir_fee_type {
      label: "DIR Fee Type"
      description: "Description of how the DIR Fee is calculated (Flat Fee or Percent)"
      type: number
      sql: ${TABLE}.DIR_FEE_TYPE ;;
      value_format: "######"
    }

    ## Flat Fee amount needs to be divided by 100 befoer displaying or using in calculations due to storing without decimal in the table
    ## NOTE: This is different from the Non Contract Rate table
    dimension: dir_flat_fee_amt {
      label: "DIR Flat Fee Amount"
      description: "DIR Flat Fee Amount"
      type: number
      sql: ${TABLE}.DIR_FLAT_FEE_AMT / 100 ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: dir_pct {
      label: "DIR Percentage"
      description: "DIR Percentage"
      type: number
      sql: ${TABLE}.DIR_PCT ;;
      value_format: "00.00%"
    }

    ## Not being used currently in DIR calculation but needs to be divided by 100 before used in any calculation -- Use the awp_wac_pct_reference in measures
    dimension: awp_wac_pct {
      label: "AWP WAC Percentage"
      description: "Percentage to be used in applicable Contract rate AWP and WAC DIR calculations"
      type: number
      sql: ${TABLE}.AWP_WAC_PCT ;;
      value_format: "00.00%"
    }

    ## Not being used currently in DIR calculation but needs to be divided by 100 before used in any calculation -- Use the contract_rate_pct_reference in measures
    dimension: contract_rate_pct {
      label: "Contract Rate Percentage"
      description: "Contract Rate discount applicable to DIR Rate"
      type: number
      sql: ${TABLE}.CONTRACT_RATE_PCT ;;
      value_format: "00.00%"
    }

    ############################################################### Master code Dimensions #################################################

    dimension: adj_base_type_id_mc {
      label: "Adjusted Base Type"
      description:  "Contract Rate DIR values; Ing Cost (20301), Ttl Pd Amt (20302), AWP Fill (20303), WAC Fill (20304)"
      type: string
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${adj_base_type_id}) ;;
    }

    dimension: awp_wac_add_subtract_type_id_mc {
      label: "AWP WAC Add Subtract Type"
      description: "Mathematical operator used to determine DIR accrual logic"
      type: string
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${awp_wac_add_subtract_type_id}) ;;
    }

    dimension: awp_wac_cost_base_type_id_mc {
      label: "AWP WAC Cost Base Type"
      description: "The Cost base Type used to determine DIR accrual logic"
      type: string
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${awp_wac_cost_base_type_id}) ;;
    }


    dimension: contract_rate_add_subtract_type_id_mc {
      label: "Contract Rate Add Subtract Type"
      description: "Mathematical operator used to determine DIR accrual logic"
      type: string
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${contract_rate_add_subtract_type_id}) ;;
    }


    dimension: contract_rate_cost_base_type_id_mc {
      label: "Contract Rate Cost Base Type"
      description: "Cost Base Source (AWP, WAC, U&C, FUL, etc.)"
      type: string
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${contract_rate_cost_base_type_id}) ;;
    }

    ####################################################################### Measures ########################################################

    measure: sum_dir_flat_fee_amt {
      label: "Total DIR Flat Fee Amount"
      description: "The sum of DIR Flat Fee AMT"
      type: sum
      sql: ${TABLE}.DIR_FLAT_FEE_AMT/100 ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }
  }

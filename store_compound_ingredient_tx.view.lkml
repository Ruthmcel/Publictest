view: store_compound_ingredient_tx {
  label: "Pharmacy Compound Ingredient Transaction"
  sql_table_name: edw.f_compound_ingredient_tx ;;

  dimension: compound_ingredient_tx_id {
    label: "Compound Ingredient Tx Id"
    description: "Unique ID number identifying a pharmacy record"
    type: number
    sql: ${TABLE}.compound_ingredient_tx_id ;;
    hidden: yes
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${compound_ingredient_tx_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    label: "Chain Id"
    description: "CHAIN_ID is the NHIN assigned customer chain ID number to uniquely identify the chain owning this record"
    type: number
    sql: ${TABLE}.chain_id ;;
    hidden: yes
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "Unique ID number assigned by NHIN for the source store associated to this record"
    type: number
    sql: ${TABLE}.nhin_store_id ;;
    hidden: yes
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    type: number
    sql: ${TABLE}.source_system_id ;;
    hidden: yes
  }

  dimension: compound_ingredient_id {
    label: "Compound Ingredient Id"
    description: "Unique ID that identifies the COMPOUND_INGREDIENT record that this record is linked to"
    type: number
    sql: ${TABLE}.compound_ingredient_id ;;
    hidden: yes
  }

  dimension: drug_id {
    label: "Drug Id"
    description: "Unique ID that identifies the DRUG record that this record is linked to"
    type: number
    sql: ${TABLE}.drug_id ;;
    hidden: yes
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "Unique ID that identifies the RX_TX record that this record is linked to"
    type: number
    sql: ${TABLE}.rx_tx_id ;;
    hidden: yes
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: compound_ingredient_tx_ndc {
    label: "Compound Ingredient Tx NDC"
    description: "NDC number of the ingredient used"
    type: string
    sql: ${TABLE}.compound_ingredient_tx_ndc ;;
  }

  dimension: compound_ingredient_tx_deleted {
    label: "Compound Ingredient Tx Deleted"
    description: "Compound Ingredient Tx Deleted"
    type: string
    sql: ${TABLE}.compound_ingredient_tx_deleted ;;
    hidden: yes
  }

  ########################################### Dimensions to be referenced in Sales explore for creating measures #########################################################

  dimension: compound_ingredient_tx_quantity_used {
    label: "Total Compound Ingredient Tx Quantity Used"
    description: "Total Amount of ingredient used to make the compound"
    type: number
    hidden: yes
    sql: ${TABLE}.compound_ingredient_tx_quantity_used ;;
    value_format: "#,##0.00"
  }

  dimension: compound_ingredient_tx_base_cost {
    label: "Total Compound Ingredient Tx Base Cost"
    description: "The total base cost of this ingredient for this transaction at the time it was priced"
    type: number
    hidden: yes
    sql: ${TABLE}.compound_ingredient_tx_base_cost ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: compound_ingredient_tx_acquisition_cost {
    label: "Total Compound Ingredient Tx Acquisition Cost"
    description: "The ACQ cost of this ingredient for this transaction at the time it was priced"
    type: number
    hidden: yes
    sql: ${TABLE}.compound_ingredient_tx_acquisition_cost ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ######################################################################################################### Measures #############################################################################################################

  measure: sum_compound_ingredient_tx_quantity_used {
    label: "Total Compound Ingredient Tx Quantity Used"
    description: "Total Amount of ingredient used to make the compound"
    type: sum
    sql: ${TABLE}.compound_ingredient_tx_quantity_used ;;
    value_format: "#,##0.00"
  }

  measure: sum_compound_ingredient_tx_base_cost {
    label: "Total Compound Ingredient Tx Base Cost"
    description: "The total base cost of this ingredient for this transaction at the time it was priced"
    type: sum
    sql: ${TABLE}.compound_ingredient_tx_base_cost ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_compound_ingredient_tx_acquisition_cost {
    label: "Total Compound Ingredient Tx Acquisition Cost"
    description: "The ACQ cost of this ingredient for this transaction at the time it was priced"
    type: sum
    sql: ${TABLE}.compound_ingredient_tx_acquisition_cost ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_compound_ingredient_tx_sales_4_10_candidate_list {
    fields: [compound_ingredient_tx_ndc]
  }
}

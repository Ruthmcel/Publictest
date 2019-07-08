view: store_compound {
  label: "Pharmacy Compound"
  sql_table_name: edw.d_compound ;;

  dimension: compound_id {
    label: "Compound Id"
    description: "Unique ID number identifying a compound record"
    type: number
    sql: ${TABLE}.compound_id ;;
    hidden: yes
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${compound_id} ;; #ERXLPS-1649
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
    label: "NHIN Store Id"
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

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: compound_mixing_instructions {
    label: "Compound Mixing Instructions"
    description: "Directions for formulating (mixing, shaking, crushing) the compound"
    type: string
    sql: ${TABLE}.compound_mixing_instructions ;;
  }

  dimension: compound_source_of_recipe {
    label: "Compound Source Of Recipe"
    description: "Free format text indicating what was the source of the compound recipe"
    type: string
    sql: ${TABLE}.compound_source_of_recipe ;;
  }

  dimension: compound_deleted {
    label: "Compound Deleted"
    description: "Compound Deleted"
    type: string
    sql: ${TABLE}.compound_deleted ;;
    hidden: yes
  }

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: compound_disallow_autofill_flag {
    label: "Compound Disallow Autofill"
    description: "Yes/No flag indicating whether the compound is eligible for the AutoFill refill service"
    type: yesno
    sql: ${TABLE}.compound_disallow_autofill_flag = 'Y' ;;
  }

  dimension: compound_type_code_reference {
    label: "Compound Type Code"
    description: "NCPDP code that clarifies the type of compound"
    type: string
    hidden: yes
    sql: ${TABLE}.COMPOUND_TYPE_CODE ;;
  }

  #[ERXDWPS-6655] - Converted CASE WHEN to SELECT MAX logic function. Added suggestions.
  dimension: compound_type_code {
    label: "Compound Type"
    description: "NCPDP code that clarifies the type of compound"
    type: string
    sql: etl_manager.fn_get_master_code_desc('COMPOUND_TYPE_CODE', ${TABLE}.COMPOUND_TYPE_CODE, 'Y') ;;
    suggestions: ["01 - ANTI-INFECTIVE",
                  "02 - IONOTROPIC",
                  "03 - CHEMOTHERAPY",
                  "04 - PAIN MANAGEMENT",
                  "05 - TPN/PPN (HEPATIC, RENAL, PEDIATRIC)",
                  "06 - HYDRATION",
                  "07 - OPHTHALMIC",
                  "99 - OTHER",
                  "NULL - NOT INDICATED"]
    drill_fields: [compound_type_code_reference]
  }

  dimension: compound_outsourced_flag {
    label: "Compound Outsourced"
    description: "Yes/No flag indicating if a compound is manufactured by a source outside of the local pharmacy"
    type: yesno
    sql: ${TABLE}.compound_outsourced_flag = 'Y' ;;
  }

  ######################################################################################################### Measures #############################################################################################################

  measure: sum_compound_dispensing_fee {
    label: "Total Compound Dispensing Fee"
    description: "Total Dollar amount to add to the price of the prescription for dispensing a compound"
    type: sum
    sql: ${TABLE}.compound_dispensing_fee ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_compound_mixing_fee {
    label: "Total Compound Mixing Fee"
    description: "Total Dollar amount to add to the price of the prescription for mixing the compound"
    type: sum
    sql: ${TABLE}.compound_mixing_fee ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_compound_time_to_prepare {
    label: "Total Compound Time To Prepare (in minutes)"
    description: "Number of minutes it takes to prepare this compound"
    type: sum
    sql: ${TABLE}.compound_time_to_prepare ;;
    value_format: "######"
  }
}

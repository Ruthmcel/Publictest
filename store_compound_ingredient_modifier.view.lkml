view: store_compound_ingredient_modifier {
  label: "Pharmacy Compound Ingredient Modifier"
  sql_table_name: edw.d_compound_ingredient_modifier ;;

  dimension: compound_ingredient_modifier_id {
    label: "Compound Ingredient Modifier Id"
    description: "Unique ID number identifying a pharmacy record"
    type: number
    sql: ${TABLE}.compound_ingredient_modifier_id ;;
    hidden: yes
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${compound_ingredient_modifier_id} ;; #ERXLPS-1649
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

  dimension: compound_ingredient_id {
    label: "Compound Ingredient Id"
    description: "Foreign key to the COMPOUND_INGREDIENTS table"
    type: number
    sql: ${TABLE}.compound_ingredient_id ;;
    hidden: yes
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: compound_ingredient_modifier_code {
    label: "Compound Ingredient Modifier Code"
    description: "Identifies special circumstances related to the dispensing/payment of the product as identified in the Compound Product ID (498-TE).  This represents values to be submitted in NCPDP field 363-2H (Compound Ingredient Modifier Code)"
    type: string
    sql: ${TABLE}.compound_ingredient_modifier_code ;;
  }

  dimension: compound_ingredient_modifier_deleted {
    label: "Compound Ingredient Modifier Deleted"
    description: "Compound Ingredient Modifier Deleted"
    type: string
    sql: ${TABLE}.compound_ingredient_modifier_deleted ;;
    hidden: yes
  }
}

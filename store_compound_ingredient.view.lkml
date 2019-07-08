view: store_compound_ingredient {
  label: "Pharmacy Compound Ingredient"
  sql_table_name: edw.d_compound_ingredient ;;

  dimension: compound_ingredient_id {
    label: "Compound Ingredient Id"
    description: "Unique ID number identifying a pharmacy record"
    type: number
    sql: ${TABLE}.compound_ingredient_id ;;
    hidden: yes
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${compound_ingredient_id} ;; #ERXLPS-1649
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

  dimension: compound_id {
    label: "Compound Id"
    description: "Unique ID that identifies the COMPOUND record that this record is linked to"
    type: number
    sql: ${TABLE}.compound_id ;;
    hidden: yes
  }

  dimension: drug_id {
    label: "Drug Id"
    description: "Unique ID that identifies the DRUG record that is linked to this Ingredient record. This is used when a specific drug record is chosen as the ingredient as opposed to selecting a DDID to represent the ingredient generically"
    type: number
    sql: ${TABLE}.drug_id ;;
    hidden: yes
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: compound_ingredient_ddid {
    label: "Compound Ingredient DDID"
    description: "Dispensable Drug Identifier for this ingredient"
    type: number
    sql: ${TABLE}.compound_ingredient_ddid ;;
    value_format: "####"
  }

  dimension: compound_ingredient_name {
    label: "Compound Ingredient Name"
    description: "Display Name for this ingredient"
    type: string
    sql: ${TABLE}.compound_ingredient_name ;;
  }

  dimension: compound_ingredient_sequence_number {
    label: "Compound Ingredient Sequence Number"
    description: "Order in which to display the ingredients of a compound.  Also, used when submitting TP claims. Some claims will send the NDC of the sequence zero ingredient"
    type: number
    sql: ${TABLE}.compound_ingredient_sequence_number ;;
    value_format: "####"
  }

  dimension_group: compound_ingredient_deactivate {
    label: "Compound Ingredient Deactivate"
    description: "Date/time this record is no longer active"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.compound_ingredient_deactivate_date ;;
  }

  dimension: compound_ingredient_deleted {
    label: "Compound Ingredient Deleted"
    description: "Compound Ingredient Deleted"
    type: string
    sql: ${TABLE}.compound_ingredient_deleted ;;
    hidden: yes
  }

  ######################################################################################################### Measures #############################################################################################################

  measure: sum_compound_ingredient_quantity {
    label: "Total Compound Ingredient Quantity"
    description: "Total Compound Ingredient Quantity"
    type: sum
    sql: ${TABLE}.compound_ingredient_quantity ;;
    value_format: "#,##0.00"
  }
}

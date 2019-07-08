view: store_compound_ingredient_tx_lot {
  label: "Pharmacy Compound Ingredient Transaction Lot"
  sql_table_name: edw.f_compound_ingredient_tx_lot ;;

  dimension: compound_ingredient_tx_lot_id {
    label: "Compound Ingredient Tx Lot ID"
    description: "Unique ID number identifying a pharmacy record"
    type: number
    sql: ${TABLE}.compound_ingredient_tx_lot_id ;;
    hidden: yes
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${compound_ingredient_tx_lot_id} ;; #ERXLPS-1649
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

  dimension: compound_ingredient_tx_id {
    label: "Compound Ingredient Tx ID"
    description: "Unique ID that identifies the COMPOUND_INGREDIENT_TX record that this record is linked to"
    type: number
    sql: ${TABLE}.compound_ingredient_tx_id ;;
    hidden: yes
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: compound_ingredient_tx_lot_number {
    label: "Compound Ingredient Tx Lot Number"
    description: "Drug Lot Number"
    type: string
    sql: ${TABLE}.compound_ingredient_tx_lot_number ;;
  }

  dimension_group: compound_ingredient_tx_lot_expiration {
    label: "Compound Ingredient Tx Lot Expiration"
    description: "Drug Expiration date/time for this lot number"
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
    sql: ${TABLE}.compound_ingredient_tx_lot_expiration_date ;;
  }

  dimension: compound_ingredient_tx_lot_deleted {
    label: "Compound Ingredient Tx Lot Deleted"
    description: "Compound Ingredient Tx Lot Deleted"
    type: string
    sql: ${TABLE}.compound_ingredient_tx_lot_deleted ;;
    hidden: yes
  }
}

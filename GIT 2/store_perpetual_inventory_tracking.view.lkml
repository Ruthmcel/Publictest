view: store_perpetual_inventory_tracking {
  label: "Pharmacy Perpetual Inventory Tracking"
  sql_table_name: EDW.F_PERPETUAL_INVENTORY_TRACKING ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${perpetual_inventory_tracking_id} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain ID"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: perpetual_inventory_tracking_id {
    label: "Perpetual Inventory Tracking ID"
    description: "Unique ID number identifying each record in this table"
    type: number
    hidden: yes
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_id {
    label: "Drug ID"
    description: "Unique ID number identifying the drug record associated with this record"
    type: number
    hidden: yes
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: adjustment_code_id {
    label: "Adjustment Code ID"
    description: "Foreign Key to the Adjustment_Codes record to which the Perpetual_Inventory record is associated"
    type: number
    hidden: yes
    sql: ${TABLE}.ADJUSTMENT_CODE_ID ;;
  }

  dimension: perpetual_inventory_tracking_note_id {
    label: "Perpetual Inventory Tracking Note ID"
    description: "Foreign key to notes table"
    type: number
    hidden: yes
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_NOTE_ID ;;
  }

  ##################################################################### dimensions ###################################################

  dimension: perpetual_inventory_tracking_invoice_number {
    label: "Invoice Number"
    description: "Drug item number for the inventory item"
    type: string
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_INVOICE_NUMBER ;;
  }

  dimension_group: perpetual_inventory_tracking_invoice {
    label: "Invoice"
    description: "Date/time when Invoice added to the Perpetual Inventory Tracking tool"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_INVOICE_DATE ;;
  }


  dimension: perpetual_inventory_tracking_add_source_code {
    label: "Entry Source"
    description: "Indication of how the entry was added to the tracking tool"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ADD_SOURCE_CODE = 1 ;;
        label: "Manual Entry by User"
      }

      when: {
        sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ADD_SOURCE_CODE = 2 ;;
        label: "RPhV process in RapidFill"
      }

      when: {
        sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ADD_SOURCE_CODE = 3 ;;
        label: "DV process in WorkFlow"
      }
    }
  }

  dimension_group: perpetual_inventory_tracking_add {
    label: "Add"
    description: "Date/time this record was added to the Perpetual Inventory Tracking tool"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ADD_DATE ;;
  }

  dimension: perpetual_inventory_tracking_rx_number {
    label: "Rx Number"
    description: "Prescription number if applicable"
    type: number
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_RX_NUMBER ;;
    value_format: "######"
  }

  dimension_group: perpetual_inventory_tracking_fill {
    label: "Fill"
    description: "Date/time the user filled the prescription"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_FILL_DATE ;;
  }

  dimension: perpetual_inventory_tracking_refill_number {
    label: "Refill Number"
    description: "Refill number of the transaction of the Prescription number if applicable"
    type: number
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_REFILL_NUMBER ;;
    value_format: "####"
  }

  dimension: perpetual_inventory_tracking_authentication_method {
    label: "Authentication Method"
    description: "The method that was used to authenticate the user that entered the Perpetual Inventory tracking record"
    type: string
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_AUTHENTICATION_METHOD ;;
  }

  dimension: perpetual_inventory_tracking_add_user_id {
    label: "Add User ID"
    hidden: yes
    description: "Employee ID of the user that added the record. System populated using USERS.LOGIN for the user that added the record"
    type: number
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_ADD_USER_ID ;;
  }

  dimension: perpetual_inventory_tracking_counted_by_user_id {
    label: "Counted By User ID"
    hidden: yes
    description: "Employee ID of the user who performed the initial drug Perpetual inventory count before RPhV"
    type: number
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_COUNTED_BY_USER_ID ;;
  }

  ################################################################################### Measures ####################################

  measure: sum_perpetual_inventory_tracking_fill_quantity {
    label: "Total Fill Quantity"
    description: "Total quantity (number of units) of the drug the user dispensed when applicable"
    type: sum
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_FILL_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_perpetual_inventory_tracking_balance_onhand_variance {
    label: "Total Balance Onhand Variance"
    description: "Total number of units of the drug returned, destroyed, transferred, adjusted, filled or added to the INVENTORY_AMOUNT"
    type: sum
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_BALANCE_ONHAND_VARIANCE ;;
    value_format: "###0.0000"
  }

  measure: sum_perpetual_inventory_tracking_inventory_amount {
    label: "Total Inventory Amount"
    description: "Total Running Balance OnHand of units of the drug before any adjustment"
    type: sum
    sql: ${TABLE}.PERPETUAL_INVENTORY_TRACKING_INVENTORY_AMOUNT ;;
    value_format: "###0.0000"
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_perpetual_inventory_tracking_4_11_candidate_list {
    fields: [
      perpetual_inventory_tracking_invoice_number,
      perpetual_inventory_tracking_add_source_code,
      perpetual_inventory_tracking_rx_number,
      perpetual_inventory_tracking_refill_number,
      perpetual_inventory_tracking_authentication_method,
      perpetual_inventory_tracking_add_user_id,
      perpetual_inventory_tracking_counted_by_user_id,
      sum_perpetual_inventory_tracking_fill_quantity,
      sum_perpetual_inventory_tracking_balance_onhand_variance,
      sum_perpetual_inventory_tracking_inventory_amount,
      perpetual_inventory_tracking_fill,
      perpetual_inventory_tracking_fill_time,
      perpetual_inventory_tracking_fill_date,
      perpetual_inventory_tracking_fill_week,
      perpetual_inventory_tracking_fill_month,
      perpetual_inventory_tracking_fill_month_num,
      perpetual_inventory_tracking_fill_year,
      perpetual_inventory_tracking_fill_quarter,
      perpetual_inventory_tracking_fill_quarter_of_year,
      perpetual_inventory_tracking_fill_hour_of_day,
      perpetual_inventory_tracking_fill_time_of_day,
      perpetual_inventory_tracking_fill_day_of_week,
      perpetual_inventory_tracking_fill_day_of_month,
      perpetual_inventory_tracking_fill_week_of_year,
      perpetual_inventory_tracking_fill_day_of_week_index,
      perpetual_inventory_tracking_add,
      perpetual_inventory_tracking_add_time,
      perpetual_inventory_tracking_add_date,
      perpetual_inventory_tracking_add_week,
      perpetual_inventory_tracking_add_month,
      perpetual_inventory_tracking_add_month_num,
      perpetual_inventory_tracking_add_year,
      perpetual_inventory_tracking_add_quarter,
      perpetual_inventory_tracking_add_quarter_of_year,
      perpetual_inventory_tracking_add_hour_of_day,
      perpetual_inventory_tracking_add_time_of_day,
      perpetual_inventory_tracking_add_day_of_week,
      perpetual_inventory_tracking_add_day_of_month,
      perpetual_inventory_tracking_add_week_of_year,
      perpetual_inventory_tracking_add_day_of_week_index,
      perpetual_inventory_tracking_invoice,
      perpetual_inventory_tracking_invoice_time,
      perpetual_inventory_tracking_invoice_date,
      perpetual_inventory_tracking_invoice_week,
      perpetual_inventory_tracking_invoice_month,
      perpetual_inventory_tracking_invoice_month_num,
      perpetual_inventory_tracking_invoice_year,
      perpetual_inventory_tracking_invoice_quarter,
      perpetual_inventory_tracking_invoice_quarter_of_year,
      perpetual_inventory_tracking_invoice_hour_of_day,
      perpetual_inventory_tracking_invoice_time_of_day,
      perpetual_inventory_tracking_invoice_day_of_week,
      perpetual_inventory_tracking_invoice_day_of_month,
      perpetual_inventory_tracking_invoice_week_of_year,
      perpetual_inventory_tracking_invoice_day_of_week_index
    ]
  }
}

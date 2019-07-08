view: sales_rx_tx_transfer_prior_fill_dates {
  label: "Pharmacy Transfer Prior Fill Dates"
  sql_table_name: EDW.F_TRANSFER_PRIOR_FILL_DATES ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${transfer_prior_fill_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type}  ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain ID"
    hidden: yes
    type: number
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store ID"
    hidden: yes
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: transfer_prior_fill_id {
    label: "Transfer Prior Fill ID"
    hidden: yes
    type: number
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.TRANSFER_PRIOR_FILL_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    hidden: yes
    type: number
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: note_id {
    label: "Note ID"
    hidden: yes
    type: number
    description: "ID of the notes record associated with a transfer fill date record.  Populated by the system using the transfer information in memory when a new transfer fill date record is created"
    sql: ${TABLE}.NOTE_ID ;;
  }

  dimension: transfer_id {
    label: "Transfer ID"
    hidden: yes
    type: number
    description: "ID of the transfer record associated with a transfer fill date record.  Populated by the system using the transfer information in memory when a new transfer fill date record is created"
    sql: ${TABLE}.TRANSFER_ID ;;
  }

  dimension: transfer_prior_fill_quantity {
    label: "Transfer Prior Fill Quantity"
    type: number
    hidden: yes
    description: "Total quantity dispensed at the transferring pharmacy. Populated by the system using the transfer information in memory when a new transfer fill date record is created"
    sql: ${TABLE}.TRANSFER_PRIOR_FILL_QUANTITY ;;
    value_format: "#,##0.00"
  }

  ################################################################################# dimensions #######################################################

  dimension: transfer_prior_fill_other_store_rx_number {
    label: "Transfer Prior Fill Other Pharmacy Rx Number*"
    type: number
    description: "Prescription number of a prescription at the transferring pharmacy. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_PRIOR_FILL_OTHER_STORE_RX_NUMBER ;;
    value_format: "####"
  }

  dimension_group: transfer_prior_fill {
    label: "Transfer Prior Fill*"
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
    description: "Date a prescription was filled at the transferring pharmacy. Populated by the system using the transfer information in memory when a new transfer fill date record is created. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_PRIOR_FILL_DATE ;;
  }

  ################################################################################# Measures ##############################################################################
  measure: sum_transfer_prior_fill_quantity {
    label: "Total Transfer Prior Fill Quantity*"
    type: sum_distinct
    hidden: yes #[ERXLPS-1961] Hiding in Sales explore. This measure has prior fill information.
    description: "Total quantity dispensed at the transferring pharmacy. Populated by the system using the transfer information in memory when a new transfer fill date record is created. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg}= 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${transfer_prior_fill_quantity} END ;;
    value_format: "#,##0.00"
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_transfer_prior_fill_4_10_candidate_list {
    fields: [
      transfer_prior_fill_other_store_rx_number,
      transfer_prior_fill,
      transfer_prior_fill_time,
      transfer_prior_fill_date,
      transfer_prior_fill_week,
      transfer_prior_fill_month,
      transfer_prior_fill_month_num,
      transfer_prior_fill_year,
      transfer_prior_fill_quarter,
      transfer_prior_fill_quarter_of_year,
      transfer_prior_fill_hour_of_day,
      transfer_prior_fill_time_of_day,
      transfer_prior_fill_hour2,
      transfer_prior_fill_minute15,
      transfer_prior_fill_day_of_week,
      transfer_prior_fill_day_of_month,
      transfer_prior_fill_week_of_year,
      transfer_prior_fill_day_of_week_index,
      sum_transfer_prior_fill_quantity
    ]
  }
}
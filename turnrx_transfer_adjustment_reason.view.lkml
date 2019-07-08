view: turnrx_transfer_adjustment_reason {
  label: "Transfer Adjustment Reason"
  sql_table_name: EDW.D_TRANSFER_ADJUSTMENT_REASON ;;

  dimension: primary_key {
    description: "Unique Identification number."
    type: string
    hidden: yes
    primary_key: yes
    sql: ${transfer_adjustment_reason_id} ;;
  }

  dimension: transfer_adjustment_reason_id {
    label: "Transfer Adjustment Reason Id"
    description: "PK ID of the Adjustment Reason for Transfers."
    type: number
    hidden: yes
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_ID ;;
  }

  dimension: transfer_adjustment_reason_short_description {
    label: "Transfer Adjustment Reason Short Description"
    description: "The short description of the Adjustment Reason for Transfers."
    type: string
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_SHORT_DESCRIPTION ;;
  }

  dimension: transfer_adjustment_reason_long_description {
    label: "Transfer Adjustment Reason Long Description"
    description: "The long description of the Adjustment Reason for Transfers."
    type: string
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_LONG_DESCRIPTION ;;
  }

  dimension: transfer_adjustment_reason_hold_until_duration_days {
    label: "Transfer Adjustment Reason Hold Until Duration Days"
    description: "The number of days that a Drug NDC should be held before it is available again for a newly created Transfer."
    type: number
    sql: ${TABLE}.TRANSFER_ADJUSTMENT_REASON_HOLD_UNTIL_DURATION_DAYS ;;
  }

  dimension_group: edw_insert_timestamp {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

############################################################ END OF DIMENSIONS ############################################################

  set: turn_rx_adjustment_reason_invoice_drug_candidate_list {
    fields: [
      transfer_adjustment_reason_short_description,
      transfer_adjustment_reason_long_description,
      transfer_adjustment_reason_hold_until_duration_days
    ]
  }

  set: turn_rx_adjustment_reason_invoice_candidate_list {
    fields: [
      transfer_adjustment_reason_short_description,
      transfer_adjustment_reason_long_description
    ]
  }

}

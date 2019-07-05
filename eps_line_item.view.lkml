view: eps_line_item {
  sql_table_name: EDW.F_LINE_ITEM ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${line_item_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: line_item_id {
    label: "Prescription Line Item ID"
    description: "Unique ID number identifying an line item record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

  dimension: original_line_item_id {
    label: "Prescription Original Line Item ID"
    description: "Unique ID of the original line item record used to create this line item record. Used for relating line item records that were created as a result of a merge, split or owed quantity action"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_ORIGINAL_LINE_ITEM_ID ;;
  }

  dimension: order_entry_id {
    label: "Prescription Order Entry ID"
    description: "Unique ID of the parent order entry record associated with this line item record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_ORDER_ENTRY_ID ;;
  }

  dimension: completion_fill_order_entry_id {
    label: "Prescription Completion Fill Order Entry ID"
    description: "This record is created if a Line Item record has been created as a Completion Fill for this Line_Item record, in the event this Line_Item record is the original record for a partially filled prescription"
    type: number
    hidden: yes
    sql: ${TABLE}.LINE_ITEM_COMPLETION_FILL_ORDER_ENTRY_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  dimension: line_item_basket {
    label: "Prescription Bin"
    description: "Basket or Bin the prescription was placed in when the fill station task was completed. (This keeps the order together for Product Verification and Will Call)"
    type: string
    sql: ${TABLE}.LINE_ITEM_BASKET ;;
  }

  dimension: line_item_bin_code {
    label: "Prescription Bin Code"
    description: "The Will Call bin code that this prescription's line item was/is assigned to"
    type: string
    sql: ${TABLE}.LINE_ITEM_BIN_CODE ;;
  }

  dimension: line_item_ltc_batch_identifier {
    label: "Prescription LTC Batch Identifier"
    description: "Indicates the LTC Batch process that was used to generate the line item"
    type: number
    sql: ${TABLE}.LINE_ITEM_LTC_BATCH_IDENTIFIER ;;
  }

  dimension: line_item_rma_number {
    label: "Line Item RMA Number"
    description: "Risk Management Authorization number provided by the REMS program that will be required to process specific REMS drugs"
    type: string
    sql: ${TABLE}.LINE_ITEM_RMA_NUMBER ;;
  }

  dimension: line_item_slot_number {
    label: "Line Item Slot Number"
    description: "Will call bin slot number that this line item is assigned to"
    type: number
    sql: ${TABLE}.LINE_ITEM_SLOT_NUMBER ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: line_item_bottle_label_printed_date {
    label: "Prescription Bottle Label Printed"
    description: "Date/Time Bottle Lable was printed"
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
    sql: ${TABLE}.LINE_ITEM_BOTTLE_LABEL_PRINTED_DATE ;;
  }

  dimension_group: line_item_do_not_sell_after_date {
    label: "Prescription Do Not Sell After"
    description: "Date that will be populated by EPS based on the following formula criteria: Written Date + Dispensing Rules (Male Max Days != 0 OR Female Max Days !=0) = Do Not Sell After Date"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.LINE_ITEM_DO_NOT_SELL_AFTER_DATE ;;
  }

  dimension_group: line_item_fill_task_completed_date {
    label: "Prescription Fill Task Completed"
    description: "Date/Time Fill Task is completed"
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
    sql: ${TABLE}.LINE_ITEM_FILL_TASK_COMPLETED_DATE ;;
  }

  dimension_group: line_item_create_date {
    label: "Prescription Line Item Create"
    description: "Date/Time the line item was actually created and written to the database"
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
    sql: ${TABLE}.LINE_ITEM_CREATE_DATE ;;
  }

  dimension_group: line_item_ivr_last_poll_date {
    label: "Prescription IVR Last Poll"
    description: "Date/Time the IVR system accessed this line item record"
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
    sql: ${TABLE}.LINE_ITEM_IVR_LAST_POLL_DATE ;;
  }

  dimension_group: line_item_next_contact_date {
    label: "Prescription Line Item Next Contact"
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
    sql: ${TABLE}.LINE_ITEM_NEXT_CONTACT_DATE ;;
  }

  dimension_group: line_item_out_of_stock_hold_until_date {
    label: "Prescription Out Of Stock Hold Until"
    description: "Date/Time  stating when the transaction may be worked again. This is necessary since we lose the current information if the transaction changes state during the process of setting a transaction to out-of-stock in rapidfill after successful TP billing and the reversal is unsucessful and the tranascation lands in TP expection."
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
    sql: ${TABLE}.LINE_ITEM_OUT_OF_STOCK_HOLD_UNTIL_DATE ;;
  }

  dimension_group: line_item_partial_fill_completion_date {
    label: "Prescription Partial Fill Completion"
    description: "Date/Time the completion fill of a partial fill prescription is scheduled to be filled. Populated on the original (partial fill) line item's record"
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
    sql: ${TABLE}.LINE_ITEM_PARTIAL_FILL_COMPLETION_DATE ;;
  }

  dimension_group: line_item_payment_authorization_state_completion_date {
    label: "Prescription Payment Authorization Completion"
    description: "Date/Time Payment Authorization was completed"
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
    sql: ${TABLE}.LINE_ITEM_PAYMENT_AUTHORIZATION_STATE_COMPLETION_DATE ;;
  }

  dimension_group: line_item_payment_settlement_state_completion_date {
    label: "Prescription Payment Settlement Completion"
    description: "Date/Time Payment Settlement was completed"
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
    sql: ${TABLE}.LINE_ITEM_PAYMENT_SETTLEMENT_STATE_COMPLETION_DATE ;;
  }

  dimension_group: line_item_rescheduled_process_date {
    label: "Prescription Rescheduled Process"
    description: "Date/Time the prescription will be processed after user chooses Refill too Soon on TP Exception Reject screen"
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
    sql: ${TABLE}.LINE_ITEM_RESCHEDULED_PROCESS_DATE ;;
  }

  #[ERXDWPS] - Excluding this dimension from looker release 3.0.007
  dimension_group: line_item_source_create {
    label: "Source Create"
    description: "Date/Time the line item was created"
    type: time
    hidden: yes
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
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################
  dimension: line_item_completion_fill_created {
    label: "Prescription Completion Fill Created"
    description: "Yes/No Flag indicating record has been created as a Completion Fill for this Line Item record, in the event this Line Item record is the original record for a partially filled prescription"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_COMPLETION_FILL_CREATED = 'Y' ;;
  }

  dimension: line_item_fill_complete {
    label: "Prescription Fill Complete"
    description: "Yes/No Flag indicating if Fill has been completed"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_FILL_COMPLETE = 'Y' ;;
  }

  dimension: line_item_via_autofill {
    label: "Line Item Auto Fill"
    description: "Yes/No Flag indicating  if a line item record was created as a result of an Auto-Fill auto-task"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_VIA_AUTOFILL = 'Y' ;;
  }

  dimension: line_item_is_on_hand_decremented {
    label: "Line Item On Hand Decremented"
    description: "Yes/No Flag indicating  drug on hand amount was decremented"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_IS_ON_HAND_DECREMENTED = 'Y' ;;
  }

  dimension: line_item_is_quantity_allocated {
    label: "Line Item Quantity Allocated"
    description: "Yes/No Flag indicating if the allocated quantity was incremented during the completion of Data Entry"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_IS_QUANTITY_ALLOCATED = 'Y' ;;
  }

  dimension: line_item_is_quantity_remaining_decremented {
    label: "Prescription Quantity Remaining Decremented"
    description: "Yes/No Flag indicating if the quantity remaining is decremented"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_IS_QUANTITY_REMAINING_DECREMENTED = 'Y' ;;
  }

  dimension: line_item_is_owed_quantity {
    label: "Prescription Owed Quantity"
    description: "Yes/No Flag indicating if a line item record is for an owed quantity only"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_OWED_FLAG = 'Y' ;;
  }

  dimension: line_item_is_pos_response_fail {
    label: "Prescription POS Response Fail"
    description: "Yes/No Flag indicating if a POS response was failed"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_POS_RESPONSE_FAIL = 'Y' ;;
  }

  dimension: line_item_is_pv_approved {
    label: "Prescription Product Verification Completed"
    description: "Yes/No Flag indicating if Product Verification has been completed"
    type: yesno
    # If "No", then PV has not yet been completed or has been undone when the transaction was rejected or cancelled
    sql: ${TABLE}.LINE_ITEM_PV_APPROVED = 'Y' ;;
  }

  dimension: line_item_auto_dispense {
    label: "Line Item Auto Dispense"
    description: "Yes/No Flag indicating if a line item record has been processed through the auto dispensing system"
    type: yesno
    sql: ${TABLE}.LINE_ITEM_AUTO_DISPENSE = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: line_item_current_tx_tp {
    hidden: yes
    type: string
    sql: ${TABLE}.LINE_ITEM_CURRENT_TX_TP ;;
  }

  dimension: line_item_shipment_status {
    label: "Line Item Shipment Status"
    description: "Shipment Status of this line item record"
    type: string

    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_SHIPMENT_STATUS = 'R' ;;
        label: "READY TO SHIP"
      }

      when: {
        sql: true ;;
        label: "NOT READY TO SHIP"
      }
    }
  }

  dimension: line_item_status {
    label: "Line Item Status"
    description: "Status of this line item record"
    type: string

    case: {
      when: {
        sql: true ;;
        label: "NEW"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_STATUS = 1 ;;
        label: "COMPLETE"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_STATUS = 2 ;;
        label: "CANCEL"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_STATUS = 3 ;;
        label: "REJECT"
      }
    }
  }

  dimension: line_item_type {
    label: "Line Item Type"
    description: "Type of transaction or task for which this line item record was created"
    type: string

    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 0 ;;
        label: "NEW"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 1 ;;
        label: "REFILL"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 2 ;;
        label: "CALL FOR NEW RX"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 3 ;;
        label: "TRANSFER"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 4 ;;
        label: "CALL FOR REFILL"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 5 ;;
        label: "ON FILE"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 6 ;;
        label: "AUTO TRANSFER"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 7 ;;
        label: "PARTIAL FILL"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 8 ;;
        label: "COMPLETION FILL"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 9 ;;
        label: "CONVERTED TRANSACTION"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 10 ;;
        label: "CALL FOR TRANSFER"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 11 ;;
        label: "RAR"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 12 ;;
        label: "AUTO TRANSFER RAR"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 13 ;;
        label: "AUTO TRANSFER CALL PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 14 ;;
        label: "AUTO TRANSFER DE"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 15 ;;
        label: "RX CONVERSION"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 16 ;;
        label: "REPLACEMENT ORDER"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 17 ;;
        label: "LTC BATCH"
      }

      when: {
        sql: ${TABLE}.LINE_ITEM_TYPE = 18 ;;
        label: "SINGLE DRUG BATCH PROCESSING"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  ################################################################################################ End of Dimensions  ###############################################################################################
  ################################################################################################ Fiscal/Standard Timeframes for Date columns ######################################################################
  #Line Item Bottle Label Printed Date fiscal timeframes. dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_bottle_label_printed {
    label: "Line Item Bottle Label Printed"
    description: "Line Item Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_BOTTLE_LABEL_PRINTED_DATE ;;
  }

  dimension: li_bottle_label_printed_calendar_date {
    label: "Line Item Bottle Label Printed Date"
    description: "Line Item Bottle Label Printed Date"
    type: date
    hidden: yes
    sql: ${li_bottle_label_printed_timeframes.calendar_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_chain_id {
    label: "Line Item Bottle Label Printed Chain ID"
    description: "Line Item Bottle Label Printed Chain ID"
    type: number
    hidden: yes
    sql: ${li_bottle_label_printed_timeframes.chain_id} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_calendar_owner_chain_id {
    label: "Line Item Bottle Label Printed Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_bottle_label_printed_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_yesno {
    label: "Line Item Bottle Label Printed (Yes/No)"
    group_label: "Line Item Bottle Label Printed Date"
    description: "Yes/No flag indicating if a prescription has Bottle Label Printed Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_BOTTLE_LABEL_PRINTED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_bottle_label_printed_day_of_week {
    label: "Line Item Bottle Label Printed Day Of Week"
    description: "Line Item Bottle Label Printed Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_bottle_label_printed_timeframes.day_of_week} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_day_of_month {
    label: "Line Item Bottle Label Printed Day Of Month"
    description: "Line Item Bottle Label Printed Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.day_of_month} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_week_of_year {
    label: "Line Item Bottle Label Printed Week Of Year"
    description: "Line Item Bottle Label Printed Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.week_of_year} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_month_num {
    label: "Line Item Bottle Label Printed Month Num"
    description: "Line Item Bottle Label Printed Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.month_num} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_month {
    label: "Line Item Bottle Label Printed Month"
    description: "Line Item Bottle Label Printed Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_bottle_label_printed_timeframes.month} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_quarter_of_year {
    label: "Line Item Bottle Label Printed Quarter Of Year"
    description: "Line Item Bottle Label Printed Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_bottle_label_printed_timeframes.quarter_of_year} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_quarter {
    label: "Line Item Bottle Label Printed Quarter"
    description: "Line Item Bottle Label Printed Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_bottle_label_printed_timeframes.quarter} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_year {
    label: "Line Item Bottle Label Printed Year"
    description: "Line Item Bottle Label Printed Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.year} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_day_of_week_index {
    label: "Line Item Bottle Label Printed Day Of Week Index"
    description: "Line Item Bottle Label Printed Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.day_of_week_index} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_week_begin_date {
    label: "Line Item Bottle Label Printed Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Bottle Label Printed Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.week_begin_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_week_end_date {
    label: "Line Item Bottle Label Printed Week End Date"
    description: "Line Item Bottle Label Printed Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.week_end_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_week_of_quarter {
    label: "Line Item Bottle Label Printed Week Of Quarter"
    description: "Line Item Bottle Label Printed Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.week_of_quarter} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_month_begin_date {
    label: "Line Item Bottle Label Printed Month Begin Date"
    description: "Line Item Bottle Label Printed Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.month_begin_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_month_end_date {
    label: "Line Item Bottle Label Printed Month End Date"
    description: "Line Item Bottle Label Printed Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.month_end_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_weeks_in_month {
    label: "Line Item Bottle Label Printed Weeks In Month"
    description: "Line Item Bottle Label Printed Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.weeks_in_month} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_quarter_begin_date {
    label: "Line Item Bottle Label Printed Quarter Begin Date"
    description: "Line Item Bottle Label Printed Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_quarter_end_date {
    label: "Line Item Bottle Label Printed Quarter End Date"
    description: "Line Item Bottle Label Printed Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.quarter_end_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_weeks_in_quarter {
    label: "Line Item Bottle Label Printed Weeks In Quarter"
    description: "Line Item Bottle Label Printed Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_year_begin_date {
    label: "Line Item Bottle Label Printed Year Begin Date"
    description: "Line Item Bottle Label Printed Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.year_begin_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_year_end_date {
    label: "Line Item Bottle Label Printed Year End Date"
    description: "Line Item Bottle Label Printed Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_bottle_label_printed_timeframes.year_end_date} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_weeks_in_year {
    label: "Line Item Bottle Label Printed Weeks In Year"
    description: "Line Item Bottle Label Printed Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.weeks_in_year} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_leap_year_flag {
    label: "Line Item Bottle Label Printed Leap Year Flag"
    description: "Line Item Bottle Label Printed Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_bottle_label_printed_timeframes.leap_year_flag} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_day_of_quarter {
    label: "Line Item Bottle Label Printed Day Of Quarter"
    description: "Line Item Bottle Label Printed Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.day_of_quarter} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  dimension: li_bottle_label_printed_day_of_year {
    label: "Line Item Bottle Label Printed Day Of Year"
    description: "Line Item Bottle Label Printed Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_bottle_label_printed_timeframes.day_of_year} ;;
    group_label: "Line Item Bottle Label Printed Date"
  }

  #Line Item Do Not Sell After Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_do_not_sell_after {
    label: "Line Item Do Not Sell After"
    description: "Line Item Do Not Sell After Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_DO_NOT_SELL_AFTER_DATE ;;
  }

  dimension: li_do_not_sell_after_calendar_date {
    label: "Line Item Do Not Sell After Date"
    description: "Line Item Do Not Sell After Date"
    type: date
    hidden: yes
    sql: ${li_do_not_sell_after_timeframes.calendar_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_chain_id {
    label: "Line Item Do Not Sell After Chain ID"
    description: "Line Item Do Not Sell After Chain ID"
    type: number
    hidden: yes
    sql: ${li_do_not_sell_after_timeframes.chain_id} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_calendar_owner_chain_id {
    label: "Line Item Do Not Sell After Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_do_not_sell_after_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_yesno {
    label: "Line Item Do Not Sell After (Yes/No)"
    group_label: "Line Item Do Not Sell After Date"
    description: "Yes/No flag indicating if a prescription has Do Not Sell After Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_DO_NOT_SELL_AFTER_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_do_not_sell_after_day_of_week {
    label: "Line Item Do Not Sell After Day Of Week"
    description: "Line Item Do Not Sell After Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_do_not_sell_after_timeframes.day_of_week} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_day_of_month {
    label: "Line Item Do Not Sell After Day Of Month"
    description: "Line Item Do Not Sell After Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.day_of_month} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_week_of_year {
    label: "Line Item Do Not Sell After Week Of Year"
    description: "Line Item Do Not Sell After Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.week_of_year} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_month_num {
    label: "Line Item Do Not Sell After Month Num"
    description: "Line Item Do Not Sell After Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.month_num} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_month {
    label: "Line Item Do Not Sell After Month"
    description: "Line Item Do Not Sell After Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_do_not_sell_after_timeframes.month} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_quarter_of_year {
    label: "Line Item Do Not Sell After Quarter Of Year"
    description: "Line Item Do Not Sell After Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_do_not_sell_after_timeframes.quarter_of_year} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_quarter {
    label: "Line Item Do Not Sell After Quarter"
    description: "Line Item Do Not Sell After Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_do_not_sell_after_timeframes.quarter} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_year {
    label: "Line Item Do Not Sell After Year"
    description: "Line Item Do Not Sell After Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.year} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_day_of_week_index {
    label: "Line Item Do Not Sell After Day Of Week Index"
    description: "Line Item Do Not Sell After Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.day_of_week_index} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_week_begin_date {
    label: "Line Item Do Not Sell After Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Do Not Sell After Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.week_begin_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_week_end_date {
    label: "Line Item Do Not Sell After Week End Date"
    description: "Line Item Do Not Sell After Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.week_end_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_week_of_quarter {
    label: "Line Item Do Not Sell After Week Of Quarter"
    description: "Line Item Do Not Sell After Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.week_of_quarter} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_month_begin_date {
    label: "Line Item Do Not Sell After Month Begin Date"
    description: "Line Item Do Not Sell After Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.month_begin_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_month_end_date {
    label: "Line Item Do Not Sell After Month End Date"
    description: "Line Item Do Not Sell After Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.month_end_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_weeks_in_month {
    label: "Line Item Do Not Sell After Weeks In Month"
    description: "Line Item Do Not Sell After Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.weeks_in_month} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_quarter_begin_date {
    label: "Line Item Do Not Sell After Quarter Begin Date"
    description: "Line Item Do Not Sell After Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_quarter_end_date {
    label: "Line Item Do Not Sell After Quarter End Date"
    description: "Line Item Do Not Sell After Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.quarter_end_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_weeks_in_quarter {
    label: "Line Item Do Not Sell After Weeks In Quarter"
    description: "Line Item Do Not Sell After Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_year_begin_date {
    label: "Line Item Do Not Sell After Year Begin Date"
    description: "Line Item Do Not Sell After Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.year_begin_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_year_end_date {
    label: "Line Item Do Not Sell After Year End Date"
    description: "Line Item Do Not Sell After Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_do_not_sell_after_timeframes.year_end_date} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_weeks_in_year {
    label: "Line Item Do Not Sell After Weeks In Year"
    description: "Line Item Do Not Sell After Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.weeks_in_year} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_leap_year_flag {
    label: "Line Item Do Not Sell After Leap Year Flag"
    description: "Line Item Do Not Sell After Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_do_not_sell_after_timeframes.leap_year_flag} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_day_of_quarter {
    label: "Line Item Do Not Sell After Day Of Quarter"
    description: "Line Item Do Not Sell After Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.day_of_quarter} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  dimension: li_do_not_sell_after_day_of_year {
    label: "Line Item Do Not Sell After Day Of Year"
    description: "Line Item Do Not Sell After Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_do_not_sell_after_timeframes.day_of_year} ;;
    group_label: "Line Item Do Not Sell After Date"
  }

  #Line Item Fill Task Completed Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_fill_task_completed {
    label: "Line Item Fill Task Completed"
    description: "Line Item Fill Task Completed Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_FILL_TASK_COMPLETED_DATE ;;
  }

  dimension: li_fill_task_completed_calendar_date {
    label: "Line Item Fill Task Completed Date"
    description: "Line Item Fill Task Completed Date"
    type: date
    hidden: yes
    sql: ${li_fill_task_completed_timeframes.calendar_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_chain_id {
    label: "Line Item Fill Task Completed Chain ID"
    description: "Line Item Fill Task Completed Chain ID"
    type: number
    hidden: yes
    sql: ${li_fill_task_completed_timeframes.chain_id} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_calendar_owner_chain_id {
    label: "Line Item Fill Task Completed Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_fill_task_completed_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_yesno {
    label: "Line Item Fill Task Completed (Yes/No)"
    group_label: "Line Item Fill Task Completed Date"
    description: "Yes/No flag indicating if a prescription has Fill Task Completed Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_FILL_TASK_COMPLETED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_fill_task_completed_day_of_week {
    label: "Line Item Fill Task Completed Day Of Week"
    description: "Line Item Fill Task Completed Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_fill_task_completed_timeframes.day_of_week} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_day_of_month {
    label: "Line Item Fill Task Completed Day Of Month"
    description: "Line Item Fill Task Completed Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.day_of_month} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_week_of_year {
    label: "Line Item Fill Task Completed Week Of Year"
    description: "Line Item Fill Task Completed Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.week_of_year} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_month_num {
    label: "Line Item Fill Task Completed Month Num"
    description: "Line Item Fill Task Completed Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.month_num} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_month {
    label: "Line Item Fill Task Completed Month"
    description: "Line Item Fill Task Completed Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_fill_task_completed_timeframes.month} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_quarter_of_year {
    label: "Line Item Fill Task Completed Quarter Of Year"
    description: "Line Item Fill Task Completed Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_fill_task_completed_timeframes.quarter_of_year} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_quarter {
    label: "Line Item Fill Task Completed Quarter"
    description: "Line Item Fill Task Completed Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_fill_task_completed_timeframes.quarter} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_year {
    label: "Line Item Fill Task Completed Year"
    description: "Line Item Fill Task Completed Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.year} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_day_of_week_index {
    label: "Line Item Fill Task Completed Day Of Week Index"
    description: "Line Item Fill Task Completed Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.day_of_week_index} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_week_begin_date {
    label: "Line Item Fill Task Completed Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Fill Task Completed Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.week_begin_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_week_end_date {
    label: "Line Item Fill Task Completed Week End Date"
    description: "Line Item Fill Task Completed Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.week_end_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_week_of_quarter {
    label: "Line Item Fill Task Completed Week Of Quarter"
    description: "Line Item Fill Task Completed Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.week_of_quarter} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_month_begin_date {
    label: "Line Item Fill Task Completed Month Begin Date"
    description: "Line Item Fill Task Completed Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.month_begin_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_month_end_date {
    label: "Line Item Fill Task Completed Month End Date"
    description: "Line Item Fill Task Completed Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.month_end_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_weeks_in_month {
    label: "Line Item Fill Task Completed Weeks In Month"
    description: "Line Item Fill Task Completed Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.weeks_in_month} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_quarter_begin_date {
    label: "Line Item Fill Task Completed Quarter Begin Date"
    description: "Line Item Fill Task Completed Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_quarter_end_date {
    label: "Line Item Fill Task Completed Quarter End Date"
    description: "Line Item Fill Task Completed Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.quarter_end_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_weeks_in_quarter {
    label: "Line Item Fill Task Completed Weeks In Quarter"
    description: "Line Item Fill Task Completed Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_year_begin_date {
    label: "Line Item Fill Task Completed Year Begin Date"
    description: "Line Item Fill Task Completed Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.year_begin_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_year_end_date {
    label: "Line Item Fill Task Completed Year End Date"
    description: "Line Item Fill Task Completed Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_fill_task_completed_timeframes.year_end_date} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_weeks_in_year {
    label: "Line Item Fill Task Completed Weeks In Year"
    description: "Line Item Fill Task Completed Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.weeks_in_year} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_leap_year_flag {
    label: "Line Item Fill Task Completed Leap Year Flag"
    description: "Line Item Fill Task Completed Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_fill_task_completed_timeframes.leap_year_flag} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_day_of_quarter {
    label: "Line Item Fill Task Completed Day Of Quarter"
    description: "Line Item Fill Task Completed Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.day_of_quarter} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  dimension: li_fill_task_completed_day_of_year {
    label: "Line Item Fill Task Completed Day Of Year"
    description: "Line Item Fill Task Completed Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_fill_task_completed_timeframes.day_of_year} ;;
    group_label: "Line Item Fill Task Completed Date"
  }

  #Line Item Create Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_create {
    label: "Line Item Create"
    description: "Line Item Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_CREATE_DATE ;;
  }

  dimension: li_create_calendar_date {
    label: "Line Item Create Date"
    description: "Line Item Create Date"
    type: date
    hidden: yes
    sql: ${li_create_timeframes.calendar_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_chain_id {
    label: "Line Item Create Chain ID"
    description: "Line Item Create Chain ID"
    type: number
    hidden: yes
    sql: ${li_create_timeframes.chain_id} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_calendar_owner_chain_id {
    label: "Line Item Create Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_create_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_yesno {
    label: "Line Item Create (Yes/No)"
    group_label: "Line Item Create Date"
    description: "Yes/No flag indicating if a prescription has Create Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_CREATE_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_create_day_of_week {
    label: "Line Item Create Day Of Week"
    description: "Line Item Create Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_create_timeframes.day_of_week} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_day_of_month {
    label: "Line Item Create Day Of Month"
    description: "Line Item Create Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.day_of_month} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_week_of_year {
    label: "Line Item Create Week Of Year"
    description: "Line Item Create Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.week_of_year} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_month_num {
    label: "Line Item Create Month Num"
    description: "Line Item Create Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.month_num} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_month {
    label: "Line Item Create Month"
    description: "Line Item Create Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_create_timeframes.month} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_quarter_of_year {
    label: "Line Item Create Quarter Of Year"
    description: "Line Item Create Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_create_timeframes.quarter_of_year} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_quarter {
    label: "Line Item Create Quarter"
    description: "Line Item Create Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_create_timeframes.quarter} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_year {
    label: "Line Item Create Year"
    description: "Line Item Create Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.year} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_day_of_week_index {
    label: "Line Item Create Day Of Week Index"
    description: "Line Item Create Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.day_of_week_index} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_week_begin_date {
    label: "Line Item Create Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Create Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.week_begin_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_week_end_date {
    label: "Line Item Create Week End Date"
    description: "Line Item Create Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.week_end_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_week_of_quarter {
    label: "Line Item Create Week Of Quarter"
    description: "Line Item Create Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.week_of_quarter} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_month_begin_date {
    label: "Line Item Create Month Begin Date"
    description: "Line Item Create Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.month_begin_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_month_end_date {
    label: "Line Item Create Month End Date"
    description: "Line Item Create Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.month_end_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_weeks_in_month {
    label: "Line Item Create Weeks In Month"
    description: "Line Item Create Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.weeks_in_month} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_quarter_begin_date {
    label: "Line Item Create Quarter Begin Date"
    description: "Line Item Create Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_quarter_end_date {
    label: "Line Item Create Quarter End Date"
    description: "Line Item Create Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.quarter_end_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_weeks_in_quarter {
    label: "Line Item Create Weeks In Quarter"
    description: "Line Item Create Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_year_begin_date {
    label: "Line Item Create Year Begin Date"
    description: "Line Item Create Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.year_begin_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_year_end_date {
    label: "Line Item Create Year End Date"
    description: "Line Item Create Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_create_timeframes.year_end_date} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_weeks_in_year {
    label: "Line Item Create Weeks In Year"
    description: "Line Item Create Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.weeks_in_year} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_leap_year_flag {
    label: "Line Item Create Leap Year Flag"
    description: "Line Item Create Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_create_timeframes.leap_year_flag} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_day_of_quarter {
    label: "Line Item Create Day Of Quarter"
    description: "Line Item Create Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.day_of_quarter} ;;
    group_label: "Line Item Create Date"
  }

  dimension: li_create_day_of_year {
    label: "Line Item Create Day Of Year"
    description: "Line Item Create Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_create_timeframes.day_of_year} ;;
    group_label: "Line Item Create Date"
  }

  #Line Item IVR Last Poll Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_ivr_last_poll {
    label: "Line Item Last Poll"
    description: "Line Item IVR Last Poll Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_IVR_LAST_POLL_DATE ;;
  }

  dimension: li_ivr_last_poll_calendar_date {
    label: "Line Item IVR Last Poll Date"
    description: "Line Item IVR Last Poll Date"
    type: date
    hidden: yes
    sql: ${li_ivr_last_poll_timeframes.calendar_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_chain_id {
    label: "Line Item IVR Last Poll Chain ID"
    description: "Line Item IVR Last Poll Chain ID"
    type: number
    hidden: yes
    sql: ${li_ivr_last_poll_timeframes.chain_id} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_calendar_owner_chain_id {
    label: "Line Item IVR Last Poll Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_ivr_last_poll_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_yesno {
    label: "Line Item IVR Last Poll (Yes/No)"
    group_label: "Line Item IVR Last Poll Date"
    description: "Yes/No flag indicating if a prescription has IVR Last Poll Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_IVR_LAST_POLL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_ivr_last_poll_day_of_week {
    label: "Line Item IVR Last Poll Day Of Week"
    description: "Line Item IVR Last Poll Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_ivr_last_poll_timeframes.day_of_week} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_day_of_month {
    label: "Line Item IVR Last Poll Day Of Month"
    description: "Line Item IVR Last Poll Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.day_of_month} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_week_of_year {
    label: "Line Item IVR Last Poll Week Of Year"
    description: "Line Item IVR Last Poll Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.week_of_year} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_month_num {
    label: "Line Item IVR Last Poll Month Num"
    description: "Line Item IVR Last Poll Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.month_num} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_month {
    label: "Line Item IVR Last Poll Month"
    description: "Line Item IVR Last Poll Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_ivr_last_poll_timeframes.month} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_quarter_of_year {
    label: "Line Item IVR Last Poll Quarter Of Year"
    description: "Line Item IVR Last Poll Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_ivr_last_poll_timeframes.quarter_of_year} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_quarter {
    label: "Line Item IVR Last Poll Quarter"
    description: "Line Item IVR Last Poll Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_ivr_last_poll_timeframes.quarter} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_year {
    label: "Line Item IVR Last Poll Year"
    description: "Line Item IVR Last Poll Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.year} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_day_of_week_index {
    label: "Line Item IVR Last Poll Day Of Week Index"
    description: "Line Item IVR Last Poll Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.day_of_week_index} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_week_begin_date {
    label: "Line Item IVR Last Poll Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item IVR Last Poll Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.week_begin_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_week_end_date {
    label: "Line Item IVR Last Poll Week End Date"
    description: "Line Item IVR Last Poll Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.week_end_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_week_of_quarter {
    label: "Line Item IVR Last Poll Week Of Quarter"
    description: "Line Item IVR Last Poll Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.week_of_quarter} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_month_begin_date {
    label: "Line Item IVR Last Poll Month Begin Date"
    description: "Line Item IVR Last Poll Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.month_begin_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_month_end_date {
    label: "Line Item IVR Last Poll Month End Date"
    description: "Line Item IVR Last Poll Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.month_end_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_weeks_in_month {
    label: "Line Item IVR Last Poll Weeks In Month"
    description: "Line Item IVR Last Poll Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.weeks_in_month} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_quarter_begin_date {
    label: "Line Item IVR Last Poll Quarter Begin Date"
    description: "Line Item IVR Last Poll Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.quarter_begin_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_quarter_end_date {
    label: "Line Item IVR Last Poll Quarter End Date"
    description: "Line Item IVR Last Poll Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.quarter_end_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_weeks_in_quarter {
    label: "Line Item IVR Last Poll Weeks In Quarter"
    description: "Line Item IVR Last Poll Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_year_begin_date {
    label: "Line Item IVR Last Poll Year Begin Date"
    description: "Line Item IVR Last Poll Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.year_begin_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_year_end_date {
    label: "Line Item IVR Last Poll Year End Date"
    description: "Line Item IVR Last Poll Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_ivr_last_poll_timeframes.year_end_date} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_weeks_in_year {
    label: "Line Item IVR Last Poll Weeks In Year"
    description: "Line Item IVR Last Poll Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.weeks_in_year} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_leap_year_flag {
    label: "Line Item IVR Last Poll Leap Year Flag"
    description: "Line Item IVR Last Poll Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_ivr_last_poll_timeframes.leap_year_flag} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_day_of_quarter {
    label: "Line Item IVR Last Poll Day Of Quarter"
    description: "Line Item IVR Last Poll Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.day_of_quarter} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  dimension: li_ivr_last_poll_day_of_year {
    label: "Line Item IVR Last Poll Day Of Year"
    description: "Line Item IVR Last Poll Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_ivr_last_poll_timeframes.day_of_year} ;;
    group_label: "Line Item IVR Last Poll Date"
  }

  #Line Item Next Contact Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_next_contact {
    label: "Line Item Next Contact"
    description: "Line Item Next Contact Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_NEXT_CONTACT_DATE ;;
  }

  dimension: li_next_contact_calendar_date {
    label: "Line Item Next Contact Date"
    description: "Line Item Next Contact Date"
    type: date
    hidden: yes
    sql: ${li_next_contact_timeframes.calendar_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_chain_id {
    label: "Line Item Next Contact Chain ID"
    description: "Line Item Next Contact Chain ID"
    type: number
    hidden: yes
    sql: ${li_next_contact_timeframes.chain_id} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_calendar_owner_chain_id {
    label: "Line Item Next Contact Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_next_contact_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_yesno {
    label: "Line Item Next Contact (Yes/No)"
    group_label: "Line Item Next Contact Date"
    description: "Yes/No flag indicating if a prescription has Next Contact Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_NEXT_CONTACT_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_next_contact_day_of_week {
    label: "Line Item Next Contact Day Of Week"
    description: "Line Item Next Contact Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_next_contact_timeframes.day_of_week} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_day_of_month {
    label: "Line Item Next Contact Day Of Month"
    description: "Line Item Next Contact Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.day_of_month} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_week_of_year {
    label: "Line Item Next Contact Week Of Year"
    description: "Line Item Next Contact Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.week_of_year} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_month_num {
    label: "Line Item Next Contact Month Num"
    description: "Line Item Next Contact Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.month_num} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_month {
    label: "Line Item Next Contact Month"
    description: "Line Item Next Contact Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_next_contact_timeframes.month} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_quarter_of_year {
    label: "Line Item Next Contact Quarter Of Year"
    description: "Line Item Next Contact Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_next_contact_timeframes.quarter_of_year} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_quarter {
    label: "Line Item Next Contact Quarter"
    description: "Line Item Next Contact Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_next_contact_timeframes.quarter} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_year {
    label: "Line Item Next Contact Year"
    description: "Line Item Next Contact Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.year} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_day_of_week_index {
    label: "Line Item Next Contact Day Of Week Index"
    description: "Line Item Next Contact Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.day_of_week_index} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_week_begin_date {
    label: "Line Item Next Contact Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Next Contact Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.week_begin_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_week_end_date {
    label: "Line Item Next Contact Week End Date"
    description: "Line Item Next Contact Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.week_end_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_week_of_quarter {
    label: "Line Item Next Contact Week Of Quarter"
    description: "Line Item Next Contact Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.week_of_quarter} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_month_begin_date {
    label: "Line Item Next Contact Month Begin Date"
    description: "Line Item Next Contact Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.month_begin_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_month_end_date {
    label: "Line Item Next Contact Month End Date"
    description: "Line Item Next Contact Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.month_end_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_weeks_in_month {
    label: "Line Item Next Contact Weeks In Month"
    description: "Line Item Next Contact Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.weeks_in_month} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_quarter_begin_date {
    label: "Line Item Next Contact Quarter Begin Date"
    description: "Line Item Next Contact Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_quarter_end_date {
    label: "Line Item Next Contact Quarter End Date"
    description: "Line Item Next Contact Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.quarter_end_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_weeks_in_quarter {
    label: "Line Item Next Contact Weeks In Quarter"
    description: "Line Item Next Contact Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_year_begin_date {
    label: "Line Item Next Contact Year Begin Date"
    description: "Line Item Next Contact Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.year_begin_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_year_end_date {
    label: "Line Item Next Contact Year End Date"
    description: "Line Item Next Contact Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_next_contact_timeframes.year_end_date} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_weeks_in_year {
    label: "Line Item Next Contact Weeks In Year"
    description: "Line Item Next Contact Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.weeks_in_year} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_leap_year_flag {
    label: "Line Item Next Contact Leap Year Flag"
    description: "Line Item Next Contact Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_next_contact_timeframes.leap_year_flag} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_day_of_quarter {
    label: "Line Item Next Contact Day Of Quarter"
    description: "Line Item Next Contact Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.day_of_quarter} ;;
    group_label: "Line Item Next Contact Date"
  }

  dimension: li_next_contact_day_of_year {
    label: "Line Item Next Contact Day Of Year"
    description: "Line Item Next Contact Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_next_contact_timeframes.day_of_year} ;;
    group_label: "Line Item Next Contact Date"
  }

  #Line Item Out Of Stock Hold Until Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_out_of_stock_hold_until {
    label: "Line Item Out Of Stock Hold Until"
    description: "Line Item Out Of Stock Hold Until Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_OUT_OF_STOCK_HOLD_UNTIL_DATE ;;
  }

  dimension: li_out_of_stock_hold_until_calendar_date {
    label: "Line Item Out Of Stock Hold Until Date"
    description: "Line Item Out Of Stock Hold Until Date"
    type: date
    hidden: yes
    sql: ${li_out_of_stock_hold_until_timeframes.calendar_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_chain_id {
    label: "Line Item Out Of Stock Hold Until Chain ID"
    description: "Line Item Out Of Stock Hold Until Chain ID"
    type: number
    hidden: yes
    sql: ${li_out_of_stock_hold_until_timeframes.chain_id} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_calendar_owner_chain_id {
    label: "Line Item Out Of Stock Hold Until Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_out_of_stock_hold_until_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_yesno {
    label: "Line Item Out Of Stock Hold Until (Yes/No)"
    group_label: "Line Item Out Of Stock Hold Until Date"
    description: "Yes/No flag indicating if a prescription has Out Of Stock Hold Until Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_OUT_OF_STOCK_HOLD_UNTIL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_out_of_stock_hold_until_day_of_week {
    label: "Line Item Out Of Stock Hold Until Day Of Week"
    description: "Line Item Out Of Stock Hold Until Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_out_of_stock_hold_until_timeframes.day_of_week} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_day_of_month {
    label: "Line Item Out Of Stock Hold Until Day Of Month"
    description: "Line Item Out Of Stock Hold Until Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.day_of_month} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_week_of_year {
    label: "Line Item Out Of Stock Hold Until Week Of Year"
    description: "Line Item Out Of Stock Hold Until Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.week_of_year} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_month_num {
    label: "Line Item Out Of Stock Hold Until Month Num"
    description: "Line Item Out Of Stock Hold Until Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.month_num} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_month {
    label: "Line Item Out Of Stock Hold Until Month"
    description: "Line Item Out Of Stock Hold Until Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_out_of_stock_hold_until_timeframes.month} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_quarter_of_year {
    label: "Line Item Out Of Stock Hold Until Quarter Of Year"
    description: "Line Item Out Of Stock Hold Until Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_out_of_stock_hold_until_timeframes.quarter_of_year} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_quarter {
    label: "Line Item Out Of Stock Hold Until Quarter"
    description: "Line Item Out Of Stock Hold Until Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_out_of_stock_hold_until_timeframes.quarter} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_year {
    label: "Line Item Out Of Stock Hold Until Year"
    description: "Line Item Out Of Stock Hold Until Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.year} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_day_of_week_index {
    label: "Line Item Out Of Stock Hold Until Day Of Week Index"
    description: "Line Item Out Of Stock Hold Until Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.day_of_week_index} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_week_begin_date {
    label: "Line Item Out Of Stock Hold Until Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Out Of Stock Hold Until Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.week_begin_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_week_end_date {
    label: "Line Item Out Of Stock Hold Until Week End Date"
    description: "Line Item Out Of Stock Hold Until Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.week_end_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_week_of_quarter {
    label: "Line Item Out Of Stock Hold Until Week Of Quarter"
    description: "Line Item Out Of Stock Hold Until Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.week_of_quarter} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_month_begin_date {
    label: "Line Item Out Of Stock Hold Until Month Begin Date"
    description: "Line Item Out Of Stock Hold Until Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.month_begin_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_month_end_date {
    label: "Line Item Out Of Stock Hold Until Month End Date"
    description: "Line Item Out Of Stock Hold Until Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.month_end_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_weeks_in_month {
    label: "Line Item Out Of Stock Hold Until Weeks In Month"
    description: "Line Item Out Of Stock Hold Until Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.weeks_in_month} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_quarter_begin_date {
    label: "Line Item Out Of Stock Hold Until Quarter Begin Date"
    description: "Line Item Out Of Stock Hold Until Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_quarter_end_date {
    label: "Line Item Out Of Stock Hold Until Quarter End Date"
    description: "Line Item Out Of Stock Hold Until Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.quarter_end_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_weeks_in_quarter {
    label: "Line Item Out Of Stock Hold Until Weeks In Quarter"
    description: "Line Item Out Of Stock Hold Until Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_year_begin_date {
    label: "Line Item Out Of Stock Hold Until Year Begin Date"
    description: "Line Item Out Of Stock Hold Until Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.year_begin_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_year_end_date {
    label: "Line Item Out Of Stock Hold Until Year End Date"
    description: "Line Item Out Of Stock Hold Until Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_out_of_stock_hold_until_timeframes.year_end_date} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_weeks_in_year {
    label: "Line Item Out Of Stock Hold Until Weeks In Year"
    description: "Line Item Out Of Stock Hold Until Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.weeks_in_year} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_leap_year_flag {
    label: "Line Item Out Of Stock Hold Until Leap Year Flag"
    description: "Line Item Out Of Stock Hold Until Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_out_of_stock_hold_until_timeframes.leap_year_flag} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_day_of_quarter {
    label: "Line Item Out Of Stock Hold Until Day Of Quarter"
    description: "Line Item Out Of Stock Hold Until Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.day_of_quarter} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  dimension: li_out_of_stock_hold_until_day_of_year {
    label: "Line Item Out Of Stock Hold Until Day Of Year"
    description: "Line Item Out Of Stock Hold Until Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_out_of_stock_hold_until_timeframes.day_of_year} ;;
    group_label: "Line Item Out Of Stock Hold Until Date"
  }

  #Line Item Partial Fill Completion Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_partial_fill_completion {
    label: "Line Item Partial Fill Completion"
    description: "Line Item Partial Fill Completion Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_PARTIAL_FILL_COMPLETION_DATE ;;
  }

  dimension: li_partial_fill_completion_calendar_date {
    label: "Line Item Partial Fill Completion Date"
    description: "Line Item Partial Fill Completion Date"
    type: date
    hidden: yes
    sql: ${li_partial_fill_completion_timeframes.calendar_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_chain_id {
    label: "Line Item Partial Fill Completion Chain ID"
    description: "Line Item Partial Fill Completion Chain ID"
    type: number
    hidden: yes
    sql: ${li_partial_fill_completion_timeframes.chain_id} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_calendar_owner_chain_id {
    label: "Line Item Partial Fill Completion Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_partial_fill_completion_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_yesno {
    label: "Line Item Partial Fill Completion (Yes/No)"
    group_label: "Line Item Partial Fill Completion Date"
    description: "Yes/No flag indicating if a prescription has Partial Fill Completion Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_PARTIAL_FILL_COMPLETION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_partial_fill_completion_day_of_week {
    label: "Line Item Partial Fill Completion Day Of Week"
    description: "Line Item Partial Fill Completion Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_partial_fill_completion_timeframes.day_of_week} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_day_of_month {
    label: "Line Item Partial Fill Completion Day Of Month"
    description: "Line Item Partial Fill Completion Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.day_of_month} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_week_of_year {
    label: "Line Item Partial Fill Completion Week Of Year"
    description: "Line Item Partial Fill Completion Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.week_of_year} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_month_num {
    label: "Line Item Partial Fill Completion Month Num"
    description: "Line Item Partial Fill Completion Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.month_num} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_month {
    label: "Line Item Partial Fill Completion Month"
    description: "Line Item Partial Fill Completion Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_partial_fill_completion_timeframes.month} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_quarter_of_year {
    label: "Line Item Partial Fill Completion Quarter Of Year"
    description: "Line Item Partial Fill Completion Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_partial_fill_completion_timeframes.quarter_of_year} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_quarter {
    label: "Line Item Partial Fill Completion Quarter"
    description: "Line Item Partial Fill Completion Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_partial_fill_completion_timeframes.quarter} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_year {
    label: "Line Item Partial Fill Completion Year"
    description: "Line Item Partial Fill Completion Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.year} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_day_of_week_index {
    label: "Line Item Partial Fill Completion Day Of Week Index"
    description: "Line Item Partial Fill Completion Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.day_of_week_index} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_week_begin_date {
    label: "Line Item Partial Fill Completion Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Partial Fill Completion Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.week_begin_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_week_end_date {
    label: "Line Item Partial Fill Completion Week End Date"
    description: "Line Item Partial Fill Completion Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.week_end_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_week_of_quarter {
    label: "Line Item Partial Fill Completion Week Of Quarter"
    description: "Line Item Partial Fill Completion Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.week_of_quarter} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_month_begin_date {
    label: "Line Item Partial Fill Completion Month Begin Date"
    description: "Line Item Partial Fill Completion Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.month_begin_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_month_end_date {
    label: "Line Item Partial Fill Completion Month End Date"
    description: "Line Item Partial Fill Completion Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.month_end_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_weeks_in_month {
    label: "Line Item Partial Fill Completion Weeks In Month"
    description: "Line Item Partial Fill Completion Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.weeks_in_month} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_quarter_begin_date {
    label: "Line Item Partial Fill Completion Quarter Begin Date"
    description: "Line Item Partial Fill Completion Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_quarter_end_date {
    label: "Line Item Partial Fill Completion Quarter End Date"
    description: "Line Item Partial Fill Completion Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.quarter_end_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_weeks_in_quarter {
    label: "Line Item Partial Fill Completion Weeks In Quarter"
    description: "Line Item Partial Fill Completion Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_year_begin_date {
    label: "Line Item Partial Fill Completion Year Begin Date"
    description: "Line Item Partial Fill Completion Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.year_begin_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_year_end_date {
    label: "Line Item Partial Fill Completion Year End Date"
    description: "Line Item Partial Fill Completion Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_partial_fill_completion_timeframes.year_end_date} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_weeks_in_year {
    label: "Line Item Partial Fill Completion Weeks In Year"
    description: "Line Item Partial Fill Completion Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.weeks_in_year} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_leap_year_flag {
    label: "Line Item Partial Fill Completion Leap Year Flag"
    description: "Line Item Partial Fill Completion Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_partial_fill_completion_timeframes.leap_year_flag} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_day_of_quarter {
    label: "Line Item Partial Fill Completion Day Of Quarter"
    description: "Line Item Partial Fill Completion Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.day_of_quarter} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  dimension: li_partial_fill_completion_day_of_year {
    label: "Line Item Partial Fill Completion Day Of Year"
    description: "Line Item Partial Fill Completion Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_partial_fill_completion_timeframes.day_of_year} ;;
    group_label: "Line Item Partial Fill Completion Date"
  }

  #Line Item Payment Authorization State Completion Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_payment_authorization_state_completion {
    label: "Line Item Payment Authorization State Completion"
    description: "Line Item Payment Authorization State Completion Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_PAYMENT_AUTHORIZATION_STATE_COMPLETION_DATE ;;
  }

  dimension: li_payment_authorization_state_completion_calendar_date {
    label: "Line Item Payment Authorization State Completion Date"
    description: "Line Item Payment Authorization State Completion Date"
    type: date
    hidden: yes
    sql: ${li_payment_authorization_state_completion_timeframes.calendar_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_chain_id {
    label: "Line Item Payment Authorization State Completion Chain ID"
    description: "Line Item Payment Authorization State Completion Chain ID"
    type: number
    hidden: yes
    sql: ${li_payment_authorization_state_completion_timeframes.chain_id} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_calendar_owner_chain_id {
    label: "Line Item Payment Authorization State Completion Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_payment_authorization_state_completion_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_yesno {
    label: "Line Item Payment Authorization State Completion (Yes/No)"
    group_label: "Line Item Payment Authorization State Completion Date"
    description: "Yes/No flag indicating if a prescription has Payment Authorization State Completion Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_PAYMENT_AUTHORIZATION_STATE_COMPLETION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_payment_authorization_state_completion_day_of_week {
    label: "Line Item Payment Authorization State Completion Day Of Week"
    description: "Line Item Payment Authorization State Completion Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_authorization_state_completion_timeframes.day_of_week} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_day_of_month {
    label: "Line Item Payment Authorization State Completion Day Of Month"
    description: "Line Item Payment Authorization State Completion Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.day_of_month} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_week_of_year {
    label: "Line Item Payment Authorization State Completion Week Of Year"
    description: "Line Item Payment Authorization State Completion Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.week_of_year} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_month_num {
    label: "Line Item Payment Authorization State Completion Month Num"
    description: "Line Item Payment Authorization State Completion Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.month_num} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_month {
    label: "Line Item Payment Authorization State Completion Month"
    description: "Line Item Payment Authorization State Completion Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_authorization_state_completion_timeframes.month} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_quarter_of_year {
    label: "Line Item Payment Authorization State Completion Quarter Of Year"
    description: "Line Item Payment Authorization State Completion Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_authorization_state_completion_timeframes.quarter_of_year} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_quarter {
    label: "Line Item Payment Authorization State Completion Quarter"
    description: "Line Item Payment Authorization State Completion Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_authorization_state_completion_timeframes.quarter} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_year {
    label: "Line Item Payment Authorization State Completion Year"
    description: "Line Item Payment Authorization State Completion Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.year} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_day_of_week_index {
    label: "Line Item Payment Authorization State Completion Day Of Week Index"
    description: "Line Item Payment Authorization State Completion Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.day_of_week_index} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_week_begin_date {
    label: "Line Item Payment Authorization State Completion Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Payment Authorization State Completion Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.week_begin_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_week_end_date {
    label: "Line Item Payment Authorization State Completion Week End Date"
    description: "Line Item Payment Authorization State Completion Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.week_end_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_week_of_quarter {
    label: "Line Item Payment Authorization State Completion Week Of Quarter"
    description: "Line Item Payment Authorization State Completion Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.week_of_quarter} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_month_begin_date {
    label: "Line Item Payment Authorization State Completion Month Begin Date"
    description: "Line Item Payment Authorization State Completion Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.month_begin_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_month_end_date {
    label: "Line Item Payment Authorization State Completion Month End Date"
    description: "Line Item Payment Authorization State Completion Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.month_end_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_weeks_in_month {
    label: "Line Item Payment Authorization State Completion Weeks In Month"
    description: "Line Item Payment Authorization State Completion Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.weeks_in_month} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_quarter_begin_date {
    label: "Line Item Payment Authorization State Completion Quarter Begin Date"
    description: "Line Item Payment Authorization State Completion Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_quarter_end_date {
    label: "Line Item Payment Authorization State Completion Quarter End Date"
    description: "Line Item Payment Authorization State Completion Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.quarter_end_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_weeks_in_quarter {
    label: "Line Item Payment Authorization State Completion Weeks In Quarter"
    description: "Line Item Payment Authorization State Completion Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_year_begin_date {
    label: "Line Item Payment Authorization State Completion Year Begin Date"
    description: "Line Item Payment Authorization State Completion Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.year_begin_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_year_end_date {
    label: "Line Item Payment Authorization State Completion Year End Date"
    description: "Line Item Payment Authorization State Completion Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_authorization_state_completion_timeframes.year_end_date} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_weeks_in_year {
    label: "Line Item Payment Authorization State Completion Weeks In Year"
    description: "Line Item Payment Authorization State Completion Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.weeks_in_year} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_leap_year_flag {
    label: "Line Item Payment Authorization State Completion Leap Year Flag"
    description: "Line Item Payment Authorization State Completion Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_authorization_state_completion_timeframes.leap_year_flag} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_day_of_quarter {
    label: "Line Item Payment Authorization State Completion Day Of Quarter"
    description: "Line Item Payment Authorization State Completion Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.day_of_quarter} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  dimension: li_payment_authorization_state_completion_day_of_year {
    label: "Line Item Payment Authorization State Completion Day Of Year"
    description: "Line Item Payment Authorization State Completion Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_authorization_state_completion_timeframes.day_of_year} ;;
    group_label: "Line Item Payment Authorization State Completion Date"
  }

  #Line Item Payment Settlement State Completion Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_payment_settlement_state_completion {
    label: "Line Item Payment Settlement State Completion"
    description: "Line Item Payment Settlement State Completion Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_PAYMENT_SETTLEMENT_STATE_COMPLETION_DATE ;;
  }

  dimension: li_payment_settlement_state_completion_calendar_date {
    label: "Line Item Payment Settlement State Completion Date"
    description: "Line Item Payment Settlement State Completion Date"
    type: date
    hidden: yes
    sql: ${li_payment_settlement_state_completion_timeframes.calendar_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_chain_id {
    label: "Line Item Payment Settlement State Completion Chain ID"
    description: "Line Item Payment Settlement State Completion Chain ID"
    type: number
    hidden: yes
    sql: ${li_payment_settlement_state_completion_timeframes.chain_id} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_calendar_owner_chain_id {
    label: "Line Item Payment Settlement State Completion Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_payment_settlement_state_completion_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_yesno {
    label: "Line Item Payment Settlement State Completion (Yes/No)"
    group_label: "Line Item Payment Settlement State Completion Date"
    description: "Yes/No flag indicating if a prescription has Payment Settlement State Completion Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_PAYMENT_SETTLEMENT_STATE_COMPLETION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_payment_settlement_state_completion_day_of_week {
    label: "Line Item Payment Settlement State Completion Day Of Week"
    description: "Line Item Payment Settlement State Completion Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_settlement_state_completion_timeframes.day_of_week} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_day_of_month {
    label: "Line Item Payment Settlement State Completion Day Of Month"
    description: "Line Item Payment Settlement State Completion Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.day_of_month} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_week_of_year {
    label: "Line Item Payment Settlement State Completion Week Of Year"
    description: "Line Item Payment Settlement State Completion Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.week_of_year} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_month_num {
    label: "Line Item Payment Settlement State Completion Month Num"
    description: "Line Item Payment Settlement State Completion Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.month_num} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_month {
    label: "Line Item Payment Settlement State Completion Month"
    description: "Line Item Payment Settlement State Completion Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_settlement_state_completion_timeframes.month} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_quarter_of_year {
    label: "Line Item Payment Settlement State Completion Quarter Of Year"
    description: "Line Item Payment Settlement State Completion Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_settlement_state_completion_timeframes.quarter_of_year} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_quarter {
    label: "Line Item Payment Settlement State Completion Quarter"
    description: "Line Item Payment Settlement State Completion Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_settlement_state_completion_timeframes.quarter} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_year {
    label: "Line Item Payment Settlement State Completion Year"
    description: "Line Item Payment Settlement State Completion Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.year} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_day_of_week_index {
    label: "Line Item Payment Settlement State Completion Day Of Week Index"
    description: "Line Item Payment Settlement State Completion Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.day_of_week_index} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_week_begin_date {
    label: "Line Item Payment Settlement State Completion Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Payment Settlement State Completion Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.week_begin_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_week_end_date {
    label: "Line Item Payment Settlement State Completion Week End Date"
    description: "Line Item Payment Settlement State Completion Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.week_end_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_week_of_quarter {
    label: "Line Item Payment Settlement State Completion Week Of Quarter"
    description: "Line Item Payment Settlement State Completion Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.week_of_quarter} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_month_begin_date {
    label: "Line Item Payment Settlement State Completion Month Begin Date"
    description: "Line Item Payment Settlement State Completion Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.month_begin_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_month_end_date {
    label: "Line Item Payment Settlement State Completion Month End Date"
    description: "Line Item Payment Settlement State Completion Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.month_end_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_weeks_in_month {
    label: "Line Item Payment Settlement State Completion Weeks In Month"
    description: "Line Item Payment Settlement State Completion Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.weeks_in_month} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_quarter_begin_date {
    label: "Line Item Payment Settlement State Completion Quarter Begin Date"
    description: "Line Item Payment Settlement State Completion Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_quarter_end_date {
    label: "Line Item Payment Settlement State Completion Quarter End Date"
    description: "Line Item Payment Settlement State Completion Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.quarter_end_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_weeks_in_quarter {
    label: "Line Item Payment Settlement State Completion Weeks In Quarter"
    description: "Line Item Payment Settlement State Completion Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_year_begin_date {
    label: "Line Item Payment Settlement State Completion Year Begin Date"
    description: "Line Item Payment Settlement State Completion Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.year_begin_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_year_end_date {
    label: "Line Item Payment Settlement State Completion Year End Date"
    description: "Line Item Payment Settlement State Completion Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_payment_settlement_state_completion_timeframes.year_end_date} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_weeks_in_year {
    label: "Line Item Payment Settlement State Completion Weeks In Year"
    description: "Line Item Payment Settlement State Completion Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.weeks_in_year} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_leap_year_flag {
    label: "Line Item Payment Settlement State Completion Leap Year Flag"
    description: "Line Item Payment Settlement State Completion Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_payment_settlement_state_completion_timeframes.leap_year_flag} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_day_of_quarter {
    label: "Line Item Payment Settlement State Completion Day Of Quarter"
    description: "Line Item Payment Settlement State Completion Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.day_of_quarter} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  dimension: li_payment_settlement_state_completion_day_of_year {
    label: "Line Item Payment Settlement State Completion Day Of Year"
    description: "Line Item Payment Settlement State Completion Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_payment_settlement_state_completion_timeframes.day_of_year} ;;
    group_label: "Line Item Payment Settlement State Completion Date"
  }

  #Line Item Rescheduled Process Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_rescheduled_process {
    label: "Line Item Rescheduled Process"
    description: "Line Item Rescheduled Process Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.LINE_ITEM_RESCHEDULED_PROCESS_DATE ;;
  }

  dimension: li_rescheduled_process_calendar_date {
    label: "Line Item Rescheduled Process Date"
    description: "Line Item Rescheduled Process Date"
    type: date
    hidden: yes
    sql: ${li_rescheduled_process_timeframes.calendar_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_chain_id {
    label: "Line Item Rescheduled Process Chain ID"
    description: "Line Item Rescheduled Process Chain ID"
    type: number
    hidden: yes
    sql: ${li_rescheduled_process_timeframes.chain_id} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_calendar_owner_chain_id {
    label: "Line Item Rescheduled Process Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_rescheduled_process_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_yesno {
    label: "Line Item Rescheduled Process (Yes/No)"
    group_label: "Line Item Rescheduled Process Date"
    description: "Yes/No flag indicating if a prescription has Rescheduled Process Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.LINE_ITEM_RESCHEDULED_PROCESS_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_rescheduled_process_day_of_week {
    label: "Line Item Rescheduled Process Day Of Week"
    description: "Line Item Rescheduled Process Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_rescheduled_process_timeframes.day_of_week} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_day_of_month {
    label: "Line Item Rescheduled Process Day Of Month"
    description: "Line Item Rescheduled Process Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.day_of_month} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_week_of_year {
    label: "Line Item Rescheduled Process Week Of Year"
    description: "Line Item Rescheduled Process Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.week_of_year} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_month_num {
    label: "Line Item Rescheduled Process Month Num"
    description: "Line Item Rescheduled Process Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.month_num} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_month {
    label: "Line Item Rescheduled Process Month"
    description: "Line Item Rescheduled Process Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_rescheduled_process_timeframes.month} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_quarter_of_year {
    label: "Line Item Rescheduled Process Quarter Of Year"
    description: "Line Item Rescheduled Process Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_rescheduled_process_timeframes.quarter_of_year} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_quarter {
    label: "Line Item Rescheduled Process Quarter"
    description: "Line Item Rescheduled Process Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_rescheduled_process_timeframes.quarter} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_year {
    label: "Line Item Rescheduled Process Year"
    description: "Line Item Rescheduled Process Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.year} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_day_of_week_index {
    label: "Line Item Rescheduled Process Day Of Week Index"
    description: "Line Item Rescheduled Process Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.day_of_week_index} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_week_begin_date {
    label: "Line Item Rescheduled Process Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Rescheduled Process Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.week_begin_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_week_end_date {
    label: "Line Item Rescheduled Process Week End Date"
    description: "Line Item Rescheduled Process Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.week_end_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_week_of_quarter {
    label: "Line Item Rescheduled Process Week Of Quarter"
    description: "Line Item Rescheduled Process Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.week_of_quarter} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_month_begin_date {
    label: "Line Item Rescheduled Process Month Begin Date"
    description: "Line Item Rescheduled Process Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.month_begin_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_month_end_date {
    label: "Line Item Rescheduled Process Month End Date"
    description: "Line Item Rescheduled Process Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.month_end_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_weeks_in_month {
    label: "Line Item Rescheduled Process Weeks In Month"
    description: "Line Item Rescheduled Process Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.weeks_in_month} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_quarter_begin_date {
    label: "Line Item Rescheduled Process Quarter Begin Date"
    description: "Line Item Rescheduled Process Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_quarter_end_date {
    label: "Line Item Rescheduled Process Quarter End Date"
    description: "Line Item Rescheduled Process Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.quarter_end_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_weeks_in_quarter {
    label: "Line Item Rescheduled Process Weeks In Quarter"
    description: "Line Item Rescheduled Process Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_year_begin_date {
    label: "Line Item Rescheduled Process Year Begin Date"
    description: "Line Item Rescheduled Process Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.year_begin_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_year_end_date {
    label: "Line Item Rescheduled Process Year End Date"
    description: "Line Item Rescheduled Process Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_rescheduled_process_timeframes.year_end_date} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_weeks_in_year {
    label: "Line Item Rescheduled Process Weeks In Year"
    description: "Line Item Rescheduled Process Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.weeks_in_year} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_leap_year_flag {
    label: "Line Item Rescheduled Process Leap Year Flag"
    description: "Line Item Rescheduled Process Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_rescheduled_process_timeframes.leap_year_flag} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_day_of_quarter {
    label: "Line Item Rescheduled Process Day Of Quarter"
    description: "Line Item Rescheduled Process Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.day_of_quarter} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  dimension: li_rescheduled_process_day_of_year {
    label: "Line Item Rescheduled Process Day Of Year"
    description: "Line Item Rescheduled Process Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_rescheduled_process_timeframes.day_of_year} ;;
    group_label: "Line Item Rescheduled Process Date"
  }

  #Line Item Source Create Date fiscal timeframes. Dimensions name shortened to avoid confilicts with default timeframe date column.
  dimension_group: li_source_create {
    label: "Line Item Source Create"
    description: "Line Item Source Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: li_source_create_calendar_date {
    label: "Line Item Source Create Date"
    description: "Line Item Source Create Date"
    type: date
    hidden: yes
    sql: ${li_source_create_timeframes.calendar_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_chain_id {
    label: "Line Item Source Create Chain ID"
    description: "Line Item Source Create Chain ID"
    type: number
    hidden: yes
    sql: ${li_source_create_timeframes.chain_id} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_calendar_owner_chain_id {
    label: "Line Item Source Create Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${li_source_create_timeframes.calendar_owner_chain_id} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_yesno {
    label: "Line Item Source Create (Yes/No)"
    group_label: "Line Item Source Create Date"
    description: "Yes/No flag indicating if a prescription has Source Create Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: li_source_create_day_of_week {
    label: "Line Item Source Create Day Of Week"
    description: "Line Item Source Create Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${li_source_create_timeframes.day_of_week} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_day_of_month {
    label: "Line Item Source Create Day Of Month"
    description: "Line Item Source Create Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.day_of_month} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_week_of_year {
    label: "Line Item Source Create Week Of Year"
    description: "Line Item Source Create Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.week_of_year} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_month_num {
    label: "Line Item Source Create Month Num"
    description: "Line Item Source Create Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.month_num} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_month {
    label: "Line Item Source Create Month"
    description: "Line Item Source Create Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${li_source_create_timeframes.month} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_quarter_of_year {
    label: "Line Item Source Create Quarter Of Year"
    description: "Line Item Source Create Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_source_create_timeframes.quarter_of_year} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_quarter {
    label: "Line Item Source Create Quarter"
    description: "Line Item Source Create Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${li_source_create_timeframes.quarter} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_year {
    label: "Line Item Source Create Year"
    description: "Line Item Source Create Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.year} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_day_of_week_index {
    label: "Line Item Source Create Day Of Week Index"
    description: "Line Item Source Create Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.day_of_week_index} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_week_begin_date {
    label: "Line Item Source Create Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Line Item Source Create Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.week_begin_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_week_end_date {
    label: "Line Item Source Create Week End Date"
    description: "Line Item Source Create Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.week_end_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_week_of_quarter {
    label: "Line Item Source Create Week Of Quarter"
    description: "Line Item Source Create Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.week_of_quarter} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_month_begin_date {
    label: "Line Item Source Create Month Begin Date"
    description: "Line Item Source Create Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.month_begin_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_month_end_date {
    label: "Line Item Source Create Month End Date"
    description: "Line Item Source Create Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.month_end_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_weeks_in_month {
    label: "Line Item Source Create Weeks In Month"
    description: "Line Item Source Create Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.weeks_in_month} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_quarter_begin_date {
    label: "Line Item Source Create Quarter Begin Date"
    description: "Line Item Source Create Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.quarter_begin_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_quarter_end_date {
    label: "Line Item Source Create Quarter End Date"
    description: "Line Item Source Create Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.quarter_end_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_weeks_in_quarter {
    label: "Line Item Source Create Weeks In Quarter"
    description: "Line Item Source Create Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.weeks_in_quarter} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_year_begin_date {
    label: "Line Item Source Create Year Begin Date"
    description: "Line Item Source Create Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.year_begin_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_year_end_date {
    label: "Line Item Source Create Year End Date"
    description: "Line Item Source Create Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${li_source_create_timeframes.year_end_date} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_weeks_in_year {
    label: "Line Item Source Create Weeks In Year"
    description: "Line Item Source Create Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.weeks_in_year} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_leap_year_flag {
    label: "Line Item Source Create Leap Year Flag"
    description: "Line Item Source Create Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${li_source_create_timeframes.leap_year_flag} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_day_of_quarter {
    label: "Line Item Source Create Day Of Quarter"
    description: "Line Item Source Create Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.day_of_quarter} ;;
    group_label: "Line Item Source Create Date"
  }

  dimension: li_source_create_day_of_year {
    label: "Line Item Source Create Day Of Year"
    description: "Line Item Source Create Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${li_source_create_timeframes.day_of_year} ;;
    group_label: "Line Item Source Create Date"
  }

  ##################################################################################################### Measures  ##################################################################################################

  measure: count {
    label: "Prescription Line Item Count"
    description: "Line item count"
    type: count
    value_format: "#,##0"
  }

  measure: sum_line_item_oe_fill_quantity {
    label: "Prescription Order Entry Fill Quantity"
    description: "Represents the Total Fill Quantity specified for a refill prescription at Order Entry when the patient requests a quantity that is different from the Prescribed quantity"
    type: sum
    sql: ${TABLE}.LINE_ITEM_OE_FILL_QUANTITY ;;
    # Changes made as per ERXLPS-133
    value_format: "###0.0000"
  }

  measure: avg_line_item_oe_fill_quantity {
    label: "Prescription Order Entry Fill Quantity - Average"
    description: "Represents the Average Fill Quantity specified for a refill prescription at Order Entry when the patient requests a quantity that is different from the Prescribed quantity"
    type: average
    sql: ${TABLE}.LINE_ITEM_OE_FILL_QUANTITY ;;
    # Changes made as per ERXLPS-133
    value_format: "###0.0000"
  }

  measure: sum_line_item_dowtime_copay_amount {
    label: "Prescription Downtime Copay Amount"
    description: "Represents the Total Copay amount entered by the user when a claim for the Tx is in Downtime"
    type: sum
    sql: ${TABLE}.LINE_ITEM_DOWTIME_COPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_line_item_dowtime_copay_amount {
    label: "Prescription Downtime Copay Amount - Average"
    description: "Represents the Average Copay amount entered by the user when a claim for the Tx is in Downtime"
    type: average
    sql: ${TABLE}.LINE_ITEM_DOWTIME_COPAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_line_item_quantity_owed {
    label: "Prescription Quantity Owed"
    description: "Represents the Total Quantity that remains to be dispensed or is owed to a patient. This should match the dispense quantity on a completion fill"
    type: sum
    sql: ${TABLE}.LINE_ITEM_QUANTITY_OWED ;;
    # Changes made as per ERXLPS-133
    value_format: "###0.0000"
  }

  measure: avg_line_item_quantity_owed {
    label: "Prescription Quantity Owed - Average"
    description: "Represents the Average Quantity that remains to be dispensed or is owed to a patient. This should match the dispense quantity on a completion fill"
    type: average
    sql: ${TABLE}.LINE_ITEM_QUANTITY_OWED ;;
    # Changes made as per ERXLPS-133
    value_format: "###0.0000"
  }

############################################################## Sets ###################################################
  set: exploredx_eps_line_item_analysis_cal_timeframes {
    fields: [
      li_bottle_label_printed_date,
      li_bottle_label_printed_calendar_date,
      li_bottle_label_printed_chain_id,
      li_bottle_label_printed_calendar_owner_chain_id,
      li_bottle_label_printed_yesno,
      li_bottle_label_printed_day_of_week,
      li_bottle_label_printed_day_of_month,
      li_bottle_label_printed_week_of_year,
      li_bottle_label_printed_month_num,
      li_bottle_label_printed_month,
      li_bottle_label_printed_quarter_of_year,
      li_bottle_label_printed_quarter,
      li_bottle_label_printed_year,
      li_bottle_label_printed_day_of_week_index,
      li_bottle_label_printed_week_begin_date,
      li_bottle_label_printed_week_end_date,
      li_bottle_label_printed_week_of_quarter,
      li_bottle_label_printed_month_begin_date,
      li_bottle_label_printed_month_end_date,
      li_bottle_label_printed_weeks_in_month,
      li_bottle_label_printed_quarter_begin_date,
      li_bottle_label_printed_quarter_end_date,
      li_bottle_label_printed_weeks_in_quarter,
      li_bottle_label_printed_year_begin_date,
      li_bottle_label_printed_year_end_date,
      li_bottle_label_printed_weeks_in_year,
      li_bottle_label_printed_leap_year_flag,
      li_bottle_label_printed_day_of_quarter,
      li_bottle_label_printed_day_of_year,
      li_do_not_sell_after_date,
      li_do_not_sell_after_calendar_date,
      li_do_not_sell_after_chain_id,
      li_do_not_sell_after_calendar_owner_chain_id,
      li_do_not_sell_after_yesno,
      li_do_not_sell_after_day_of_week,
      li_do_not_sell_after_day_of_month,
      li_do_not_sell_after_week_of_year,
      li_do_not_sell_after_month_num,
      li_do_not_sell_after_month,
      li_do_not_sell_after_quarter_of_year,
      li_do_not_sell_after_quarter,
      li_do_not_sell_after_year,
      li_do_not_sell_after_day_of_week_index,
      li_do_not_sell_after_week_begin_date,
      li_do_not_sell_after_week_end_date,
      li_do_not_sell_after_week_of_quarter,
      li_do_not_sell_after_month_begin_date,
      li_do_not_sell_after_month_end_date,
      li_do_not_sell_after_weeks_in_month,
      li_do_not_sell_after_quarter_begin_date,
      li_do_not_sell_after_quarter_end_date,
      li_do_not_sell_after_weeks_in_quarter,
      li_do_not_sell_after_year_begin_date,
      li_do_not_sell_after_year_end_date,
      li_do_not_sell_after_weeks_in_year,
      li_do_not_sell_after_leap_year_flag,
      li_do_not_sell_after_day_of_quarter,
      li_do_not_sell_after_day_of_year,
      li_fill_task_completed_date,
      li_fill_task_completed_calendar_date,
      li_fill_task_completed_chain_id,
      li_fill_task_completed_calendar_owner_chain_id,
      li_fill_task_completed_yesno,
      li_fill_task_completed_day_of_week,
      li_fill_task_completed_day_of_month,
      li_fill_task_completed_week_of_year,
      li_fill_task_completed_month_num,
      li_fill_task_completed_month,
      li_fill_task_completed_quarter_of_year,
      li_fill_task_completed_quarter,
      li_fill_task_completed_year,
      li_fill_task_completed_day_of_week_index,
      li_fill_task_completed_week_begin_date,
      li_fill_task_completed_week_end_date,
      li_fill_task_completed_week_of_quarter,
      li_fill_task_completed_month_begin_date,
      li_fill_task_completed_month_end_date,
      li_fill_task_completed_weeks_in_month,
      li_fill_task_completed_quarter_begin_date,
      li_fill_task_completed_quarter_end_date,
      li_fill_task_completed_weeks_in_quarter,
      li_fill_task_completed_year_begin_date,
      li_fill_task_completed_year_end_date,
      li_fill_task_completed_weeks_in_year,
      li_fill_task_completed_leap_year_flag,
      li_fill_task_completed_day_of_quarter,
      li_fill_task_completed_day_of_year,
      li_create_date,
      li_create_calendar_date,
      li_create_chain_id,
      li_create_calendar_owner_chain_id,
      li_create_yesno,
      li_create_day_of_week,
      li_create_day_of_month,
      li_create_week_of_year,
      li_create_month_num,
      li_create_month,
      li_create_quarter_of_year,
      li_create_quarter,
      li_create_year,
      li_create_day_of_week_index,
      li_create_week_begin_date,
      li_create_week_end_date,
      li_create_week_of_quarter,
      li_create_month_begin_date,
      li_create_month_end_date,
      li_create_weeks_in_month,
      li_create_quarter_begin_date,
      li_create_quarter_end_date,
      li_create_weeks_in_quarter,
      li_create_year_begin_date,
      li_create_year_end_date,
      li_create_weeks_in_year,
      li_create_leap_year_flag,
      li_create_day_of_quarter,
      li_create_day_of_year,
      li_ivr_last_poll_date,
      li_ivr_last_poll_calendar_date,
      li_ivr_last_poll_chain_id,
      li_ivr_last_poll_calendar_owner_chain_id,
      li_ivr_last_poll_yesno,
      li_ivr_last_poll_day_of_week,
      li_ivr_last_poll_day_of_month,
      li_ivr_last_poll_week_of_year,
      li_ivr_last_poll_month_num,
      li_ivr_last_poll_month,
      li_ivr_last_poll_quarter_of_year,
      li_ivr_last_poll_quarter,
      li_ivr_last_poll_year,
      li_ivr_last_poll_day_of_week_index,
      li_ivr_last_poll_week_begin_date,
      li_ivr_last_poll_week_end_date,
      li_ivr_last_poll_week_of_quarter,
      li_ivr_last_poll_month_begin_date,
      li_ivr_last_poll_month_end_date,
      li_ivr_last_poll_weeks_in_month,
      li_ivr_last_poll_quarter_begin_date,
      li_ivr_last_poll_quarter_end_date,
      li_ivr_last_poll_weeks_in_quarter,
      li_ivr_last_poll_year_begin_date,
      li_ivr_last_poll_year_end_date,
      li_ivr_last_poll_weeks_in_year,
      li_ivr_last_poll_leap_year_flag,
      li_ivr_last_poll_day_of_quarter,
      li_ivr_last_poll_day_of_year,
      li_next_contact_date,
      li_next_contact_calendar_date,
      li_next_contact_chain_id,
      li_next_contact_calendar_owner_chain_id,
      li_next_contact_yesno,
      li_next_contact_day_of_week,
      li_next_contact_day_of_month,
      li_next_contact_week_of_year,
      li_next_contact_month_num,
      li_next_contact_month,
      li_next_contact_quarter_of_year,
      li_next_contact_quarter,
      li_next_contact_year,
      li_next_contact_day_of_week_index,
      li_next_contact_week_begin_date,
      li_next_contact_week_end_date,
      li_next_contact_week_of_quarter,
      li_next_contact_month_begin_date,
      li_next_contact_month_end_date,
      li_next_contact_weeks_in_month,
      li_next_contact_quarter_begin_date,
      li_next_contact_quarter_end_date,
      li_next_contact_weeks_in_quarter,
      li_next_contact_year_begin_date,
      li_next_contact_year_end_date,
      li_next_contact_weeks_in_year,
      li_next_contact_leap_year_flag,
      li_next_contact_day_of_quarter,
      li_next_contact_day_of_year,
      li_out_of_stock_hold_until_date,
      li_out_of_stock_hold_until_calendar_date,
      li_out_of_stock_hold_until_chain_id,
      li_out_of_stock_hold_until_calendar_owner_chain_id,
      li_out_of_stock_hold_until_yesno,
      li_out_of_stock_hold_until_day_of_week,
      li_out_of_stock_hold_until_day_of_month,
      li_out_of_stock_hold_until_week_of_year,
      li_out_of_stock_hold_until_month_num,
      li_out_of_stock_hold_until_month,
      li_out_of_stock_hold_until_quarter_of_year,
      li_out_of_stock_hold_until_quarter,
      li_out_of_stock_hold_until_year,
      li_out_of_stock_hold_until_day_of_week_index,
      li_out_of_stock_hold_until_week_begin_date,
      li_out_of_stock_hold_until_week_end_date,
      li_out_of_stock_hold_until_week_of_quarter,
      li_out_of_stock_hold_until_month_begin_date,
      li_out_of_stock_hold_until_month_end_date,
      li_out_of_stock_hold_until_weeks_in_month,
      li_out_of_stock_hold_until_quarter_begin_date,
      li_out_of_stock_hold_until_quarter_end_date,
      li_out_of_stock_hold_until_weeks_in_quarter,
      li_out_of_stock_hold_until_year_begin_date,
      li_out_of_stock_hold_until_year_end_date,
      li_out_of_stock_hold_until_weeks_in_year,
      li_out_of_stock_hold_until_leap_year_flag,
      li_out_of_stock_hold_until_day_of_quarter,
      li_out_of_stock_hold_until_day_of_year,
      li_partial_fill_completion_date,
      li_partial_fill_completion_calendar_date,
      li_partial_fill_completion_chain_id,
      li_partial_fill_completion_calendar_owner_chain_id,
      li_partial_fill_completion_yesno,
      li_partial_fill_completion_day_of_week,
      li_partial_fill_completion_day_of_month,
      li_partial_fill_completion_week_of_year,
      li_partial_fill_completion_month_num,
      li_partial_fill_completion_month,
      li_partial_fill_completion_quarter_of_year,
      li_partial_fill_completion_quarter,
      li_partial_fill_completion_year,
      li_partial_fill_completion_day_of_week_index,
      li_partial_fill_completion_week_begin_date,
      li_partial_fill_completion_week_end_date,
      li_partial_fill_completion_week_of_quarter,
      li_partial_fill_completion_month_begin_date,
      li_partial_fill_completion_month_end_date,
      li_partial_fill_completion_weeks_in_month,
      li_partial_fill_completion_quarter_begin_date,
      li_partial_fill_completion_quarter_end_date,
      li_partial_fill_completion_weeks_in_quarter,
      li_partial_fill_completion_year_begin_date,
      li_partial_fill_completion_year_end_date,
      li_partial_fill_completion_weeks_in_year,
      li_partial_fill_completion_leap_year_flag,
      li_partial_fill_completion_day_of_quarter,
      li_partial_fill_completion_day_of_year,
      li_payment_authorization_state_completion_date,
      li_payment_authorization_state_completion_calendar_date,
      li_payment_authorization_state_completion_chain_id,
      li_payment_authorization_state_completion_calendar_owner_chain_id,
      li_payment_authorization_state_completion_yesno,
      li_payment_authorization_state_completion_day_of_week,
      li_payment_authorization_state_completion_day_of_month,
      li_payment_authorization_state_completion_week_of_year,
      li_payment_authorization_state_completion_month_num,
      li_payment_authorization_state_completion_month,
      li_payment_authorization_state_completion_quarter_of_year,
      li_payment_authorization_state_completion_quarter,
      li_payment_authorization_state_completion_year,
      li_payment_authorization_state_completion_day_of_week_index,
      li_payment_authorization_state_completion_week_begin_date,
      li_payment_authorization_state_completion_week_end_date,
      li_payment_authorization_state_completion_week_of_quarter,
      li_payment_authorization_state_completion_month_begin_date,
      li_payment_authorization_state_completion_month_end_date,
      li_payment_authorization_state_completion_weeks_in_month,
      li_payment_authorization_state_completion_quarter_begin_date,
      li_payment_authorization_state_completion_quarter_end_date,
      li_payment_authorization_state_completion_weeks_in_quarter,
      li_payment_authorization_state_completion_year_begin_date,
      li_payment_authorization_state_completion_year_end_date,
      li_payment_authorization_state_completion_weeks_in_year,
      li_payment_authorization_state_completion_leap_year_flag,
      li_payment_authorization_state_completion_day_of_quarter,
      li_payment_authorization_state_completion_day_of_year,
      li_payment_settlement_state_completion_date,
      li_payment_settlement_state_completion_calendar_date,
      li_payment_settlement_state_completion_chain_id,
      li_payment_settlement_state_completion_calendar_owner_chain_id,
      li_payment_settlement_state_completion_yesno,
      li_payment_settlement_state_completion_day_of_week,
      li_payment_settlement_state_completion_day_of_month,
      li_payment_settlement_state_completion_week_of_year,
      li_payment_settlement_state_completion_month_num,
      li_payment_settlement_state_completion_month,
      li_payment_settlement_state_completion_quarter_of_year,
      li_payment_settlement_state_completion_quarter,
      li_payment_settlement_state_completion_year,
      li_payment_settlement_state_completion_day_of_week_index,
      li_payment_settlement_state_completion_week_begin_date,
      li_payment_settlement_state_completion_week_end_date,
      li_payment_settlement_state_completion_week_of_quarter,
      li_payment_settlement_state_completion_month_begin_date,
      li_payment_settlement_state_completion_month_end_date,
      li_payment_settlement_state_completion_weeks_in_month,
      li_payment_settlement_state_completion_quarter_begin_date,
      li_payment_settlement_state_completion_quarter_end_date,
      li_payment_settlement_state_completion_weeks_in_quarter,
      li_payment_settlement_state_completion_year_begin_date,
      li_payment_settlement_state_completion_year_end_date,
      li_payment_settlement_state_completion_weeks_in_year,
      li_payment_settlement_state_completion_leap_year_flag,
      li_payment_settlement_state_completion_day_of_quarter,
      li_payment_settlement_state_completion_day_of_year,
      li_rescheduled_process_date,
      li_rescheduled_process_calendar_date,
      li_rescheduled_process_chain_id,
      li_rescheduled_process_calendar_owner_chain_id,
      li_rescheduled_process_yesno,
      li_rescheduled_process_day_of_week,
      li_rescheduled_process_day_of_month,
      li_rescheduled_process_week_of_year,
      li_rescheduled_process_month_num,
      li_rescheduled_process_month,
      li_rescheduled_process_quarter_of_year,
      li_rescheduled_process_quarter,
      li_rescheduled_process_year,
      li_rescheduled_process_day_of_week_index,
      li_rescheduled_process_week_begin_date,
      li_rescheduled_process_week_end_date,
      li_rescheduled_process_week_of_quarter,
      li_rescheduled_process_month_begin_date,
      li_rescheduled_process_month_end_date,
      li_rescheduled_process_weeks_in_month,
      li_rescheduled_process_quarter_begin_date,
      li_rescheduled_process_quarter_end_date,
      li_rescheduled_process_weeks_in_quarter,
      li_rescheduled_process_year_begin_date,
      li_rescheduled_process_year_end_date,
      li_rescheduled_process_weeks_in_year,
      li_rescheduled_process_leap_year_flag,
      li_rescheduled_process_day_of_quarter,
      li_rescheduled_process_day_of_year,
      li_source_create_date,
      li_source_create_calendar_date,
      li_source_create_chain_id,
      li_source_create_calendar_owner_chain_id,
      li_source_create_yesno,
      li_source_create_day_of_week,
      li_source_create_day_of_month,
      li_source_create_week_of_year,
      li_source_create_month_num,
      li_source_create_month,
      li_source_create_quarter_of_year,
      li_source_create_quarter,
      li_source_create_year,
      li_source_create_day_of_week_index,
      li_source_create_week_begin_date,
      li_source_create_week_end_date,
      li_source_create_week_of_quarter,
      li_source_create_month_begin_date,
      li_source_create_month_end_date,
      li_source_create_weeks_in_month,
      li_source_create_quarter_begin_date,
      li_source_create_quarter_end_date,
      li_source_create_weeks_in_quarter,
      li_source_create_year_begin_date,
      li_source_create_year_end_date,
      li_source_create_weeks_in_year,
      li_source_create_leap_year_flag,
      li_source_create_day_of_quarter,
      li_source_create_day_of_year
    ]
  }

  set: exploredx_eps_line_item_looker_default_timeframes {
    fields: [
      line_item_bottle_label_printed_date_time,
      line_item_bottle_label_printed_date_date,
      line_item_bottle_label_printed_date_week,
      line_item_bottle_label_printed_date_month,
      line_item_bottle_label_printed_date_month_num,
      line_item_bottle_label_printed_date_year,
      line_item_bottle_label_printed_date_quarter,
      line_item_bottle_label_printed_date_quarter_of_year,
      line_item_bottle_label_printed_date,
      line_item_bottle_label_printed_date_hour_of_day,
      line_item_bottle_label_printed_date_time_of_day,
      line_item_bottle_label_printed_date_hour2,
      line_item_bottle_label_printed_date_minute15,
      line_item_bottle_label_printed_date_day_of_week,
      line_item_bottle_label_printed_date_week_of_year,
      line_item_bottle_label_printed_date_day_of_week_index,
      line_item_bottle_label_printed_date_day_of_month,
      line_item_do_not_sell_after_date_date,
      line_item_do_not_sell_after_date_week,
      line_item_do_not_sell_after_date_month,
      line_item_do_not_sell_after_date_month_num,
      line_item_do_not_sell_after_date_year,
      line_item_do_not_sell_after_date_quarter,
      line_item_do_not_sell_after_date_quarter_of_year,
      line_item_do_not_sell_after_date,
      line_item_do_not_sell_after_date_day_of_week,
      line_item_do_not_sell_after_date_week_of_year,
      line_item_do_not_sell_after_date_day_of_week_index,
      line_item_do_not_sell_after_date_day_of_month,
      line_item_fill_task_completed_date_time,
      line_item_fill_task_completed_date_date,
      line_item_fill_task_completed_date_week,
      line_item_fill_task_completed_date_month,
      line_item_fill_task_completed_date_month_num,
      line_item_fill_task_completed_date_year,
      line_item_fill_task_completed_date_quarter,
      line_item_fill_task_completed_date_quarter_of_year,
      line_item_fill_task_completed_date,
      line_item_fill_task_completed_date_hour_of_day,
      line_item_fill_task_completed_date_time_of_day,
      line_item_fill_task_completed_date_hour2,
      line_item_fill_task_completed_date_minute15,
      line_item_fill_task_completed_date_day_of_week,
      line_item_fill_task_completed_date_week_of_year,
      line_item_fill_task_completed_date_day_of_week_index,
      line_item_fill_task_completed_date_day_of_month,
      line_item_create_date_time,
      line_item_create_date_date,
      line_item_create_date_week,
      line_item_create_date_month,
      line_item_create_date_month_num,
      line_item_create_date_year,
      line_item_create_date_quarter,
      line_item_create_date_quarter_of_year,
      line_item_create_date,
      line_item_create_date_hour_of_day,
      line_item_create_date_time_of_day,
      line_item_create_date_hour2,
      line_item_create_date_minute15,
      line_item_create_date_day_of_week,
      line_item_create_date_week_of_year,
      line_item_create_date_day_of_week_index,
      line_item_create_date_day_of_month,
      line_item_ivr_last_poll_date_time,
      line_item_ivr_last_poll_date_date,
      line_item_ivr_last_poll_date_week,
      line_item_ivr_last_poll_date_month,
      line_item_ivr_last_poll_date_month_num,
      line_item_ivr_last_poll_date_year,
      line_item_ivr_last_poll_date_quarter,
      line_item_ivr_last_poll_date_quarter_of_year,
      line_item_ivr_last_poll_date,
      line_item_ivr_last_poll_date_hour_of_day,
      line_item_ivr_last_poll_date_time_of_day,
      line_item_ivr_last_poll_date_hour2,
      line_item_ivr_last_poll_date_minute15,
      line_item_ivr_last_poll_date_day_of_week,
      line_item_ivr_last_poll_date_week_of_year,
      line_item_ivr_last_poll_date_day_of_week_index,
      line_item_ivr_last_poll_date_day_of_month,
      line_item_next_contact_date_time,
      line_item_next_contact_date_date,
      line_item_next_contact_date_week,
      line_item_next_contact_date_month,
      line_item_next_contact_date_month_num,
      line_item_next_contact_date_year,
      line_item_next_contact_date_quarter,
      line_item_next_contact_date_quarter_of_year,
      line_item_next_contact_date,
      line_item_next_contact_date_hour_of_day,
      line_item_next_contact_date_time_of_day,
      line_item_next_contact_date_hour2,
      line_item_next_contact_date_minute15,
      line_item_next_contact_date_day_of_week,
      line_item_next_contact_date_week_of_year,
      line_item_next_contact_date_day_of_week_index,
      line_item_next_contact_date_day_of_month,
      line_item_out_of_stock_hold_until_date_time,
      line_item_out_of_stock_hold_until_date_date,
      line_item_out_of_stock_hold_until_date_week,
      line_item_out_of_stock_hold_until_date_month,
      line_item_out_of_stock_hold_until_date_month_num,
      line_item_out_of_stock_hold_until_date_year,
      line_item_out_of_stock_hold_until_date_quarter,
      line_item_out_of_stock_hold_until_date_quarter_of_year,
      line_item_out_of_stock_hold_until_date,
      line_item_out_of_stock_hold_until_date_hour_of_day,
      line_item_out_of_stock_hold_until_date_time_of_day,
      line_item_out_of_stock_hold_until_date_hour2,
      line_item_out_of_stock_hold_until_date_minute15,
      line_item_out_of_stock_hold_until_date_day_of_week,
      line_item_out_of_stock_hold_until_date_week_of_year,
      line_item_out_of_stock_hold_until_date_day_of_week_index,
      line_item_out_of_stock_hold_until_date_day_of_month,
      line_item_partial_fill_completion_date_time,
      line_item_partial_fill_completion_date_date,
      line_item_partial_fill_completion_date_week,
      line_item_partial_fill_completion_date_month,
      line_item_partial_fill_completion_date_month_num,
      line_item_partial_fill_completion_date_year,
      line_item_partial_fill_completion_date_quarter,
      line_item_partial_fill_completion_date_quarter_of_year,
      line_item_partial_fill_completion_date,
      line_item_partial_fill_completion_date_hour_of_day,
      line_item_partial_fill_completion_date_time_of_day,
      line_item_partial_fill_completion_date_hour2,
      line_item_partial_fill_completion_date_minute15,
      line_item_partial_fill_completion_date_day_of_week,
      line_item_partial_fill_completion_date_week_of_year,
      line_item_partial_fill_completion_date_day_of_week_index,
      line_item_partial_fill_completion_date_day_of_month,
      line_item_payment_authorization_state_completion_date_time,
      line_item_payment_authorization_state_completion_date_date,
      line_item_payment_authorization_state_completion_date_week,
      line_item_payment_authorization_state_completion_date_month,
      line_item_payment_authorization_state_completion_date_month_num,
      line_item_payment_authorization_state_completion_date_year,
      line_item_payment_authorization_state_completion_date_quarter,
      line_item_payment_authorization_state_completion_date_quarter_of_year,
      line_item_payment_authorization_state_completion_date,
      line_item_payment_authorization_state_completion_date_hour_of_day,
      line_item_payment_authorization_state_completion_date_time_of_day,
      line_item_payment_authorization_state_completion_date_hour2,
      line_item_payment_authorization_state_completion_date_minute15,
      line_item_payment_authorization_state_completion_date_day_of_week,
      line_item_payment_authorization_state_completion_date_week_of_year,
      line_item_payment_authorization_state_completion_date_day_of_week_index,
      line_item_payment_authorization_state_completion_date_day_of_month,
      line_item_payment_settlement_state_completion_date_time,
      line_item_payment_settlement_state_completion_date_date,
      line_item_payment_settlement_state_completion_date_week,
      line_item_payment_settlement_state_completion_date_month,
      line_item_payment_settlement_state_completion_date_month_num,
      line_item_payment_settlement_state_completion_date_year,
      line_item_payment_settlement_state_completion_date_quarter,
      line_item_payment_settlement_state_completion_date_quarter_of_year,
      line_item_payment_settlement_state_completion_date,
      line_item_payment_settlement_state_completion_date_hour_of_day,
      line_item_payment_settlement_state_completion_date_time_of_day,
      line_item_payment_settlement_state_completion_date_hour2,
      line_item_payment_settlement_state_completion_date_minute15,
      line_item_payment_settlement_state_completion_date_day_of_week,
      line_item_payment_settlement_state_completion_date_week_of_year,
      line_item_payment_settlement_state_completion_date_day_of_week_index,
      line_item_payment_settlement_state_completion_date_day_of_month,
      line_item_rescheduled_process_date_time,
      line_item_rescheduled_process_date_date,
      line_item_rescheduled_process_date_week,
      line_item_rescheduled_process_date_month,
      line_item_rescheduled_process_date_month_num,
      line_item_rescheduled_process_date_year,
      line_item_rescheduled_process_date_quarter,
      line_item_rescheduled_process_date_quarter_of_year,
      line_item_rescheduled_process_date,
      line_item_rescheduled_process_date_hour_of_day,
      line_item_rescheduled_process_date_time_of_day,
      line_item_rescheduled_process_date_hour2,
      line_item_rescheduled_process_date_minute15,
      line_item_rescheduled_process_date_day_of_week,
      line_item_rescheduled_process_date_week_of_year,
      line_item_rescheduled_process_date_day_of_week_index,
      line_item_rescheduled_process_date_day_of_month,
      line_item_source_create_time,
      line_item_source_create_date,
      line_item_source_create_week,
      line_item_source_create_month,
      line_item_source_create_month_num,
      line_item_source_create_year,
      line_item_source_create_quarter,
      line_item_source_create_quarter_of_year,
      line_item_source_create,
      line_item_source_create_hour_of_day,
      line_item_source_create_time_of_day,
      line_item_source_create_hour2,
      line_item_source_create_minute15,
      line_item_source_create_day_of_week,
      line_item_source_create_week_of_year,
      line_item_source_create_day_of_week_index,
      line_item_source_create_day_of_month
    ]
  }
}

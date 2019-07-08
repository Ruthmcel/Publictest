view: bi_demo_sales_eps_rx {
  # [ERXLPS-1020] - New view with sales_eps_rx created for eps_rx.
  # sales view sold_flg, adjudicated_flg and report_calendar_global.type added along with transmit_queue column to unique_key to produce correct results fr sales measures.
  sql_table_name: EDW.F_RX ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
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

  dimension: rx_id {
    label: "Prescription ID"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_prescriber_edi_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_PRESCRIBER_EDI_ID ;;
  }

  dimension: rx_prescribed_drug_id {
    label: "Prescription Prescried Drug ID"
    description: "Unique ID that links this record to a specific DRUG record"
    hidden: yes
    type: string
    sql: ${TABLE}.RX_PRESCRIBED_DRUG_ID ;;
  }

  dimension: rx_prescribed_drug_ddid {
    label: "Prescriber Prescribed Drug DDID"
    description: "Unique reference to a drug concept that defines the prescribed drug without selecting a specific pack size"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_PRESCRIBED_DRUG_DDID ;;
    value_format: "######"
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### End of Foreign Key References ####################################################################################

  ########################################################################################################## reference objects used in other explores (currently used in sales )#########################################
  #{ERXLPS-652} Dimensions created to reference in sales view. This is required to maintain the correct Uniqueness when pulling measures from Sales and TP Transmit Queue subject area.
  #dimension: rx_qty_left_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_QTY_LEFT ;;
  #}

  #dimension: rx_autofill_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_AUTOFILL_QUANTITY ;;
  #}

  ########################################################################################################## Dimensions #############################################################################################

  dimension: rx_number {
    label: "Prescription Number"
    description: "Prescription Number"
    type: number
    sql: ${TABLE}.RX_NUMBER ;;
    value_format: "######"
  }

  dimension: rx_ncpcp_route {
    label: "Prescription NCPDP Route"
    description: "Route that is normally used by the patient for using/taking a compound. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_NCPDP_ROUTE ;;
  }

  dimension: rx_deleted {
    label: "Prescription Deleted"
    hidden: yes
    type: string
    sql: ${TABLE}.RX_DELETED ;;
  }

  dimension: rx_escript_message_identifier {
    label: "Prescription Escript Message Identifier"
    description: "eScript ID# generated at pharmacy at the time of sell which is sent in EPSv15 patientUpdate/select to EPR in order for a triggered message to be sent to Emdeon to make them aware of a successfull eScript fill"
    type: string
    sql: ${TABLE}.RX_ESCRIPT_MESSAGE_ID ;;
  }

  dimension: rx_reportable_drug_number {
    label: "Prescription Reportable Drug Number"
    description: "Schedule 2 (CAN N) Form Number"
    type: string
    sql: ${TABLE}.RX_REPORTABLE_DRUG_NUMBER ;;
  }

  dimension: rx_image_total {
    label: "Prescription Image Total"
    description: "Defines the number of prescriptions on a single hard copy image"
    type: number
    sql: ${TABLE}.RX_IMAGE_TOTAL ;;
    value_format: "#,##0"
  }

  ########################################################################################################## End of Dimensions #############################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: rx_merged_to_date {
    label: "Prescription Merged To"
    description: "Date the patient was changed on this prescription due to a single-prescription merge"
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
    sql: ${TABLE}.RX_MERGED_TO_DATE ;;
  }

  dimension_group: rx_autofill_enable_date {
    label: "Prescription Autofill Enabled"
    description: "Date/Time the prescription was set up for auto-fill. This field is EPS only!!!"
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
    sql: ${TABLE}.RX_AUTOFILL_ENABLE_DATE ;;
  }

  dimension_group: rx_received_date {
    label: "Prescription Received"
    description: "Date/Time that a prescription was presented to the pharmacy for filling. Set either by the user upon receipt of the Rx (or) when a new escript Rx is received in the store (or) populated by the auto transfer response with the received date sent in the auto transfer message. This field is EPS only!!!"
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
    sql: ${TABLE}.RX_RECEIVED_DATE ;;
  }

  dimension_group: rx_file_buy_date {
    label: "Prescription File Buy"
    description: "Identifies if a patient or script was imported into EPS as part of a file buy"
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
    sql: ${TABLE}.RX_FILE_BUY_DATE ;;
  }

  dimension_group: rx_last_refill_reminder_date {
    label: "Prescription Last Refill Reminder"
    description: "Indicates the last time this prescription was triggered for a refill reminder notification"
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
    sql: ${TABLE}.RX_LAST_REFILL_REMINDER_DATE ;;
  }

  dimension_group: rx_short_fill_sent {
    label: "Prescription Short Fill Sent"
    description: "Used to identify when a SyncScript Short-Fill Request form was printed for the Prescription"
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
    sql: ${TABLE}.RX_SHORT_FILL_SENT ;;
  }

  ################################################################################################### End of DATE/TIME specific Fields ################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################
  dimension: rx_status {
    label: "Prescription Status"
    type: yesno
    sql: ${TABLE}.RX_STATUS = 'Y' ;;
  }

  dimension: rx_source {
    label: "Prescription Source"
    description: "Indicates what process was used to create this prescription record"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_SOURCE = 0 ;;
        label: "Not Specified"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 1 ;;
        label: "Written"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 2 ;;
        label: "Phoned In"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 3 ;;
        label: "E-Script"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 4 ;;
        label: "Fax"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 5 ;;
        label: "Pharmacy Generated"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 20 ;;
        label: "Manual Transfer"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 21 ;;
        label: "Informational Rx"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 22 ;;
        label: "Patient Specified"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 23 ;;
        label: "Auto Transfer"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 24 ;;
        label: "Transfer Auto RAR"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 25 ;;
        label: "Escript RAR"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 26 ;;
        label: "Escript Addfill"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 27 ;;
        label: "Patient Request"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 28 ;;
        label: "Prescriber Request"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 29 ;;
        label: "Other"
      }

      when: {
        sql: true ;;
        label: "Blank"
      }
    }
  }

  ## [ERXLPS-609] - For the dimension: rx_source - Temporarily removed the Master Code Sub Query that is preventing the end user from using this column as a pivot with counts.
  ##                Changing to SQL Case until DE for long term fix for Master Code Subqueries is decided upon
  ## sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION)
  ##         FROM EDW.D_MASTER_CODE MC
  ##         WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_SOURCE AS VARCHAR),'NULL')
  ##         AND MC.EDW_COLUMN_NAME = 'RX_SOURCE')
  ## suggestions: ['BLANK','NOT SPECIFIED','WRITTEN','PHONED IN','E-SCRIPT','FAX','PHARMACY GENERATED','MANUAL TRANSFER','INFORMATIONAL RX','PATIENT SPECIFIED','AUTO TRANSFER','TRANSFER AUTO RAR',
  ##               'ESCRIPT RAR','ESCRIPT ADDFILL','PATIENT REQUEST','PRESCRIBER REQUEST','OTHER']

  dimension: rx_on_file {
    label: "Prescription On File"
    description: "Yes/No flag indicating if the prescription is On File"
    type: yesno
    sql: ${TABLE}.RX_ON_FILE = 'Y' ;;
  }

  dimension: wholesale_order {
    label: "Prescription Wholesale Order"
    description: "Yes/No flag indicating if the prescription is a part of wholesale orders. Value populated at the time of Order Entry Confirmation. If the Record type of the selected patient is “Office”, then the prescription is a wholesale order. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_WHOLESALE_ORDER_FLAG = 'Y' ;;
  }

  dimension: controlled_substance_escript {
    label: "Prescription Controlled Substance Escript"
    description: "Yes/No flag indicating prescription was generated from a controlled substance escript. Used to identify prescriptions for  auditing and RX edits requirement. This field is EPS only!!!"
    hidden: yes
    type: yesno
    sql: ${TABLE}.RX_CONTROLLED_SUBSTANCE_ESCRIPT_FLAG = 'Y' ;;
  }

  dimension: rx_enable_autofill {
    label: "Prescription Enable Autofill"
    description: "Flag that indicates whether this prescription is an Auto-Fill prescription"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'N' ;;
        label: "NO"
      }

      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'Y' ;;
        label: "YES"
      }

      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'R' ;;
        label: "REFUSED"
      }
    }
  }

  dimension: rx_hard_copy_printed {
    label: "Prescription Hard Copy Printed"
    description: "Yes/No flag indicating whether the E-script hard copy and the System-Generated Hard Copy have been successfully printed"
    type: yesno
    sql: ${TABLE}.RX_HARD_COPY_PRINTED = 'Y' ;;
  }

  #[ERXLPS-1845] - Added deleted check.
  dimension: rx_prescribed_drug_ndc {
    label: "Prescription Prescribed Drug NDC"
    description: "Prescribed drug NDC"
    type: string
    sql: (select max(store_drug_ndc) from edw.d_store_drug where chain_id = ${chain_id} and nhin_store_id = ${nhin_store_id} and drug_id = ${rx_prescribed_drug_id} and source_system_id = 4 and store_drug_deleted = 'N') ;;
  }

  dimension: rx_prescribed_days_supply {
    label: "Prescription Prescribed Days Supply"
    description: "Total days supply as prescribed"
    type: number
    sql: ${TABLE}.RX_PRESCRIBED_DAYS_SUPPLY ;;
  }

  #####################################################################################End of YES/NO & CASE WHEN fields ###############################################################################################

  ####################################################################################################### Measures ####################################################################################################
  measure: count {
    type: count
    description: "Total Prescription Count"
  }

  measure: rx_transfer_out_fill_count {
    label: "Prescription Transfer Out Fill Quantity"
    group_label: "Other Measures"
    description: "Total quantity transferred out"
    type: sum
    sql: ${TABLE}.RX_TRANSFER_OUT_FILL_COUNT ;;
    value_format: "#,##0"
  }

  measure: sum_rx_qty_left {
    label: "Prescription Quantity Left"
    description: "Number of remaining units (quantity) of the drug"
    type: sum_distinct
    sql: ${TABLE}.RX_QTY_LEFT ;;
    value_format: "###0.0000"
  }

  #[ERX-326]/[ERX-1623]
  ########################################################################################################## 4.8.000 New columns start #############################################################################################

  dimension: rx_last_filled_rx_tx_id {
    description: "Unique ID that links this record to the RX_TX record that represents the last fill of this prescription. System generated"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_LAST_FILLED_RX_TX_ID ;;
    value_format: "######"
  }

  dimension: rx_new_rx_id {
    description: "Unique ID that identifies the reassigned RX_SUMMARY record that was generated from this record.  System generated"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_NEW_RX_ID ;;
    value_format: "######"
  }

  dimension: rx_old_rx_id {
    description: "Unique ID that identifies the previous RX_SUMMARY record that this record was generated from. System generated"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_OLD_RX_ID ;;
    value_format: "######"
  }

  ########################################################################################################## Dimensions #############################################################################################

  dimension: rx_barcode {
    label: "Prescription Barcode"
    description: "Barcode number attached to the hard copy. Auto-generated. Alpha-numeric"
    type: string
    sql: ${TABLE}.RX_BARCODE ;;
  }

  dimension: rx_compound_id {
    label: "Prescription Compound Identifier"
    description: "Unique ID that links this record to a specific COMPOUND record. System generated"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_COMPOUND_ID ;;
    value_format: "######"
  }

  dimension: rx_note {
    label: "Prescription Note"
    description: "Notes that pertain to this prescription; will display as All Fills notes each time prescription is filled. User entered. Alpha-Numeric"
    type: string
    hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.
    sql: ${TABLE}.RX_NOTE ;;
  }

  dimension: rx_patient_id {
    label: "Prescription Patient Identifier"
    description: "Unique ID that links this record with a specific PATIENT record. System generated"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_PATIENT_ID ;;
    value_format: "######"
  }

  dimension: rx_prescriber_not_found_response {
    label: "Prescription Prescriber Not Found Response"
    description: "Contains prescriber information when the prescriber is not found during a patient select request. Alpha-numeric"
    type: string
    sql: ${TABLE}.RX_PRESCRIBER_NOT_FOUND_RESPONSE ;;
  }

  dimension: rx_prescriber_order_number {
    label: "Prescription Prescriber Order Number"
    description: "Unique ID that is given to an escript from a prescriber. The ID corresponds to an Rx number when the escript is processed. System Generated"
    type: string
    sql: ${TABLE}.RX_PRESCRIBER_ORDER_NUMBER ;;
  }

  dimension: rx_refills_authorized {
    label: "Prescription Refills Authorized"
    description: "Number of refills originally authorized by doctor. User entered"
    type: string
    sql: ${TABLE}.RX_REFILLS_AUTHORIZED ;;
  }

  dimension: rx_refills_remaining {
    label: "Prescription Refills Remaining"
    description: "Number of remaining refills. System Generated"
    type: string
    sql: ${TABLE}.RX_REFILLS_REMAINING ;;
  }

  dimension: rx_refills_transferred {
    label: "Prescription Refills Transferred"
    description: "Number of refills that have been transferred out for the prescription. System Generated"
    type: string
    sql: ${TABLE}.RX_REFILLS_TRANSFERRED ;;
  }

  #label name modified based on business functionlaity
  dimension: rx_rxfill_indicator {
    label: "Prescription Fill Status Notification Indicator"
    description: "Holds the value of when a prescriber requests an RXFILL message to verify the fill of a prescription."
    type: string
    sql: ${TABLE}.RX_RXFILL_INDICATOR ;;
  }

  dimension: rx_image_index {
    label: "Prescription Image Index"
    description: "If multiple barcodes/prescriptions on a single hard copy, defines which prescription this one is. System designates which barcode corresponds with each prescription"
    type: number
    sql: ${TABLE}.RX_IMAGE_INDEX ;;
    value_format: "######"
  }

  dimension: rx_temporary_prescriber_identifier {
    label: "Prescription Temporary Prescriber Identifier"
    description: "Temporary prescriber ID number used to identify the prescriber for third party billing purposes when no DEA exists. System Generated"
    type: string
    sql: ${TABLE}.RX_TEMPORARY_PRESCRIBER_ID_NUMBER ;;
  }

  ########################################################################################################## End of Dimensions #############################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: rx_chain_first_filled {
    label: "Prescription Chain First Filled"
    description: "Original first fill date used to populate SGHC and other.  System generated"
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
    sql: ${TABLE}.RX_CHAIN_FIRST_FILLED_DATE ;;
  }

  dimension_group: rx_expiration {
    label: "Prescription Expiration"
    description: "Date the prescription expires. Generated by client or entered by user"
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
    sql: ${TABLE}.RX_EXPIRATION_DATE ;;
  }

  dimension_group: rx_first_filled {
    label: "Prescription First Filled"
    description: "Original date the system filled and added the prescription to the patient's prescription profile. System generated"
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
    sql: ${TABLE}.RX_FIRST_FILLED_DATE ;;
  }

  dimension_group: rx_original_written {
    label: "Prescription Original Written"
    description: "Date the physician originally wrote the prescription. User entered"
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
    sql: ${TABLE}.RX_ORIGINAL_WRITTEN_DATE ;;
  }

  dimension_group: rx_start {
    label: "Prescription Start"
    description: "Effective Date or the Earliest Fill Date in which the pharmacy may fill a prescription. Can be set from an incoming escript record or set when Data entry is performed on the Rx"
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
    sql: ${TABLE}.RX_START_DATE ;;
  }

  # Check with Kumaran whether to remove _date at the end as another column present with rx_sync_script_enrollment
  dimension_group: rx_sync_script_enrollment {
    label: "Prescription Sync Script Enrollment"
    description: "Source of prescription enrollment in SyncScript program. System generated"
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
    sql: ${TABLE}.RX_SYNC_SCRIPT_ENROLLMENT_DATE ;;
  }

  dimension_group: source_create {
    label: "Prescription Source Create"
    description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database."
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
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ########################################################################################################### End of DATE/TIME specific Fields ################################################################################

  # [ERXLPS-676] - Add dimension to reference in sales view for file buy date
  dimension: rx_file_buy_reference {
    hidden: yes
    label: "Prescription File Buy"
    description: "Date that identifies if a patient or script was imported into EPS as part of a file buy"
    sql: ${TABLE}.RX_FILE_BUY_DATE ;;
  }

  #[ERXLPS-1055]
  dimension: rx_merged_to_reference {
    hidden: yes
    label: "Prescription Merged To"
    description: "Date the patient was changed on this prescription due to a single-prescription merge"
    sql: ${TABLE}.RX_MERGED_TO_DATE ;;
  }

  dimension: rx_autofill_enable_reference {
    hidden: yes
    label: "Prescription Autofill Enabled"
    description: "Date/Time the prescription was set up for auto-fill. This field is EPS only!!!"
    sql: ${TABLE}.RX_AUTOFILL_ENABLE_DATE ;;
  }

  dimension: rx_received_reference {
    hidden: yes
    label: "Prescription Received"
    description: "Date/Time that a prescription was presented to the pharmacy for filling. Set either by the user upon receipt of the Rx (or) when a new escript Rx is received in the store (or) populated by the auto transfer response with the received date sent in the auto transfer message. This field is EPS only!!!"
    sql: ${TABLE}.RX_RECEIVED_DATE ;;
  }

  dimension: rx_last_refill_reminder_reference {
    hidden: yes
    label: "Prescription Last Refill Reminder"
    description: "Date/Time last time the prescription was triggered for a refill reminder notification"
    sql: ${TABLE}.RX_LAST_REFILL_REMINDER_DATE ;;
  }

  dimension: rx_short_fill_sent_reference {
    hidden: yes
    label: "Prescription Short Fill Sent"
    description: "Date/Time used to identify when a SyncScript Short-Fill Request form was printed for the Prescription"
    sql: ${TABLE}.RX_SHORT_FILL_SENT ;;
  }

  dimension: rx_chain_first_filled_reference {
    hidden: yes
    label: "Prescription Chain First Filled"
    description: "Original first fill date used to populate SGHC and other.  System generated"
    sql: ${TABLE}.RX_CHAIN_FIRST_FILLED_DATE ;;
  }

  dimension: rx_expiration_reference {
    hidden: yes
    label: "Prescription Expiration"
    description: "Date the prescription expires. Generated by client or entered by user"
    sql: ${TABLE}.RX_EXPIRATION_DATE ;;
  }

  dimension: rx_first_filled_reference {
    hidden: yes
    label: "Prescription First Filled"
    description: "Original date the system filled and added the prescription to the patient's prescription profile. System generated"
    sql: ${TABLE}.RX_FIRST_FILLED_DATE ;;
  }

  dimension: rx_original_written_reference {
    hidden: yes
    label: "Prescription Original Written"
    description: "Date the physician originally wrote the prescription. User entered"
    sql: ${TABLE}.RX_ORIGINAL_WRITTEN_DATE ;;
  }

  dimension: rx_start_reference {
    hidden: yes
    label: "Prescription Start"
    description: "Effective Date or the Earliest Fill Date in which the pharmacy may fill a prescription. Can be set from an incoming escript record or set when Data entry is performed on the prescription"
    sql: ${TABLE}.RX_START_DATE ;;
  }

  dimension: rx_sync_script_enrollment_reference {
    hidden: yes
    label: "Prescription Sync Script Enrollment"
    description: "Source of prescription enrollment in SyncScript program. System generated"
    sql: ${TABLE}.RX_SYNC_SCRIPT_ENROLLMENT_DATE ;;
  }

  dimension: rx_source_create_reference {
    hidden: yes
    label: "Prescription Source Create"
    description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database."
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: rx_autofill_mail_flag {
    label: "Prescription Autofill Mail Flag"
    description: "Flag that indicates patient wants this auto-filled prescription mailed to them. User entered"
    type: yesno
    sql: ${TABLE}.RX_AUTOFILL_MAIL_FLAG = 'Y' ;;
  }

  dimension: rx_call_for_refills {
    label: "Prescription Call For Refills"
    description: "Flag that determines what AutoFill should do when no refills remain or the Rx has expired. Entered by user based on patient preference"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_CALL_FOR_REFILLS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_CALL_FOR_REFILLS') ;;
    suggestions: ["CALL DOCTOR", "NOTIFY PATIENT", "DO NOT AUTO-FILL", "NOT SPECIFIED"]
  }

  dimension: rx_sync_script_enrolled_by {
    label: "Prescription Sync Script Enrolled By"
    description: "Source of prescription enrollment in SyncScript program. System generated"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_SYNC_SCRIPT_ENROLLED_BY AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_SYNC_SCRIPT_ENROLLED_BY') ;;
    suggestions: ["NOT ENROLLED", "PHARMACY", "IVR"]
  }

  dimension: rx_sync_script_enrollment_desc {
    label: "Prescription Sync Script Enrollment"
    description: "Prescription level enrollment in SyncScript program. User entered"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_SYNC_SCRIPT_ENROLLMENT AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_SYNC_SCRIPT_ENROLLMENT') ;;
    suggestions: ["NOT ASKED", "YES", "PATIENT REFUSED SYNCSCRIPT"]
  }

  dimension: rx_temporary_prescriber_id_qualifier {
    label: "Prescription Temporary Prescriber ID Qualifier"
    description: "Temporary ID Qualifier for the prescriber. System Generated"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TEMPORARY_PRESCRIBER_ID_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TEMPORARY_PRESCRIBER_ID_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NPI",
      "BLUE CROSS",
      "BLUE SHIELD",
      "MEDICARE",
      "MEDICAID",
      "UPIN",
      "STATE LICENSE",
      "CHAMPUS",
      "HEALTH INDUSTRY NUMBER",
      "FEDERAL TAX ID",
      "DEA",
      "STATE ISSUED",
      "PLAN SPECIFIC",
      "HCID",
      "FOREIGN PRESCRIBER IDENTIFIER",
      "OTHER"
    ]
  }

  ########################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

  ####################################################################################################### Measures ####################################################################################################

  measure: sum_rx_autofill_quantity {
    label: "Prescription Autofill Quantity"
    description: "The quantity to be dispensed during Auto-Fill. User entered.  If null, dispense quantity like regular"
    type: sum_distinct
    sql: ${TABLE}.RX_AUTOFILL_QUANTITY ;;
    value_format: "###0.0000"
  }

  #[ERXLPS-910] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sum_sales_rx_qty_left {
    label: "Prescription Quantity Left"
    group_label: "Quantity"
    description: "Number of remaining units (quantity) of the drug"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_qty_left END ;;
    value_format: "###0.0000"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_autofill_quantity {
    label: "Prescription Autofill Quantity"
    group_label: "Quantity"
    description: "The quantity to be dispensed during Auto-Fill. User entered.  If null, dispense quantity like regular"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_autofill_quantity END ;;
    value_format: "###0.0000"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - Sourcing remaining columns into Sales explore
  measure: sum_sales_rx_transfer_out_fill_count {
    label: "Prescription Transfer Out Fill Count"
    group_label: "Other Measures"
    description: "Total quantity transferred out"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.RX_TRANSFER_OUT_FILL_COUNT END ;;
    value_format: "#,##0"
  }

  ####################################################################################################### End of Measures ####################################################################################################

  ########################################################################################################## End of 4.8.000 New columns #############################################################################################

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension_group: rx_alignment_start_date {
    label: "Rx Alignment Start"
    description: "Prescription alignment start date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RX_ALIGNMENT_START_DATE ;;
  }

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension: rx_is_patient_auto_selected {
    label: "Rx Is Patient Auto Selected"
    description: "Yes/No flag indicating whether the patient was auto selected"
    type: yesno
    sql: ${TABLE}.RX_IS_PATIENT_AUTO_SELECTED = 'Y' ;;
  }

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension_group: rx_sync_script_refused_date {
    label: "Rx Sync Script Refused"
    description: "Prescription sync script refused date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RX_SYNC_SCRIPT_REFUSED_DATE ;;
  }

  ####################################################################################### Sets ##################################################################

  #- sum_rx_autofill_quantity #[ERXLPS-652] Commenting measure from eps_rx view. For consistency and filter TY only, creating instance of this measure in sales view.

  set: explore_bi_demo_sales_candidate_list {
    fields: [
      rx_ncpcp_route,
      rx_reportable_drug_number,
      rx_image_total,
      rx_status,
      rx_source,
      rx_on_file,
      wholesale_order,
      controlled_substance_escript,
      rx_enable_autofill,
      rx_hard_copy_printed,
      rx_prescribed_drug_ndc,
      rx_transfer_out_fill_count,
      rx_prescribed_days_supply,
      sum_rx_qty_left,
      rx_autofill_mail_flag,
      rx_barcode,
      rx_call_for_refills,
      rx_prescriber_not_found_response,
      rx_refills_authorized,
      rx_refills_remaining,
      rx_refills_transferred,
      rx_rxfill_indicator,
      rx_image_index,
      rx_sync_script_enrollment_desc,
      sum_rx_autofill_quantity,
      #[1055] - Integration of Prescription Transaction explore into sales explore. Sourcing remaining columns.
      rx_escript_message_identifier,
      rx_note,
      rx_prescriber_order_number,
      rx_sync_script_enrolled_by,
      rx_temporary_prescriber_id_qualifier,
      #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
      rx_alignment_start_date_date,
      rx_alignment_start_date_day_of_month,
      rx_alignment_start_date_day_of_week,
      rx_alignment_start_date_day_of_week_index,
      rx_alignment_start_date_month,
      rx_alignment_start_date_month_num,
      rx_alignment_start_date_quarter,
      rx_alignment_start_date_quarter_of_year,
      rx_alignment_start_date_time,
      rx_alignment_start_date_week,
      rx_alignment_start_date_week_of_year,
      rx_alignment_start_date_year,
      rx_is_patient_auto_selected,
      rx_sync_script_refused_date_date,
      rx_sync_script_refused_date_day_of_month,
      rx_sync_script_refused_date_day_of_week,
      rx_sync_script_refused_date_day_of_week_index,
      rx_sync_script_refused_date_month,
      rx_sync_script_refused_date_month_num,
      rx_sync_script_refused_date_quarter,
      rx_sync_script_refused_date_quarter_of_year,
      rx_sync_script_refused_date_time,
      rx_sync_script_refused_date_week,
      rx_sync_script_refused_date_week_of_year,
      rx_sync_script_refused_date_year
    ]
  }

}

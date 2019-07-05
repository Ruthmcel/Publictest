view: eps_rx {
  #[ERX-6185]
  sql_table_name:
  {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
    {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
    {% if active_archive_filter_input_value == 'archive'  %}
      EDW.F_RX_ARCHIVE
    {% else %}
      EDW.F_RX
    {% endif %}
  {% else %}
    EDW.F_RX
  {% endif %}
  ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_id} ;; #ERXLPS-1649
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
  dimension: rx_qty_left_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_QTY_LEFT ;;
  }

  dimension: rx_autofill_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_AUTOFILL_QUANTITY ;;
  }

  ########################################################################################################## Dimensions #############################################################################################

  dimension: rx_number {
    label: "Prescription Number"
    description: "Prescription Number"
    type: number
    sql: ${TABLE}.RX_NUMBER ;;
    value_format: "######"
  }

  #[ERXLPS-1286] - Rx Number Usage for Script to Skin report with values obfuscated.
  dimension: rx_number_deidentified {
    label: "Prescription Number"
    description: "Prescription Number"
    type: number
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.RX_NUMBER) ;;
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

  #[ERXLPS-1845] - Added delete check
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
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
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
    description: "Holds the value of when a prescriber requests a RXFILL message to verify the fill of a prescription."
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

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: rx_autofill_mail_flag {
    label: "Prescription Autofill Mail Flag"
    description: "Flag that indicated if the Patient wants this auto-filled. User entered"
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
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_AUTOFILL_QUANTITY ;;
    value_format: "###0.0000"
  }

  ####################################################################################################### End of Measures ####################################################################################################

  ########################################################################################################## End of 4.8.000 New columns #############################################################################################

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension_group: rx_alignment_start_date {
    label: "Alignment Start"
    description: "Prescription alignment start date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RX_ALIGNMENT_START_DATE ;;
  }

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension: rx_is_patient_auto_selected {
    label: "Patient Auto Selected"
    description: "Yes/No flag indicating whether the patient was auto selected"
    type: yesno
    sql: ${TABLE}.RX_IS_PATIENT_AUTO_SELECTED = 'Y' ;;
  }

  #[ERXDWPS-7254] Sync EPS RX_SUMMARY to EDW
  dimension_group: rx_sync_script_refused_date {
    label: "Sync Script Refused"
    description: "Prescription sync script refused date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.RX_SYNC_SCRIPT_REFUSED_DATE ;;
  }

  ########################################################################## Fiscal/Standard timefrmae dimensions ##############################################
  #Prescription Merged To Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_merged_to_cust {
    label: "Prescription Merged To"
    description: "Prescription Merged To Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_MERGED_TO_DATE ;;
  }

  dimension: rx_merged_to_cust_calendar_date {
    label: "Prescription Merged To Date"
    description: "Prescription Merged To Date"
    type: date
    hidden: yes
    sql: ${rx_merged_to_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_chain_id {
    label: "Prescription Merged To Chain ID"
    description: "Prescription Merged To Chain ID"
    type: number
    hidden: yes
    sql: ${rx_merged_to_cust_timeframes.chain_id} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_calendar_owner_chain_id {
    label: "Prescription Merged To Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_merged_to_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_yesno {
    label: "Prescription Merged To (Yes/No)"
    group_label: "Prescription Merged To Date"
    description: "Yes/No flag indicating if a prescription has Merged To Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_MERGED_TO_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_merged_to_cust_day_of_week {
    label: "Prescription Merged To Day Of Week"
    description: "Prescription Merged To Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_merged_to_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_day_of_month {
    label: "Prescription Merged To Day Of Month"
    description: "Prescription Merged To Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_week_of_year {
    label: "Prescription Merged To Week Of Year"
    description: "Prescription Merged To Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_month_num {
    label: "Prescription Merged To Month Num"
    description: "Prescription Merged To Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.month_num} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_month {
    label: "Prescription Merged To Month"
    description: "Prescription Merged To Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_merged_to_cust_timeframes.month} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_quarter_of_year {
    label: "Prescription Merged To Quarter Of Year"
    description: "Prescription Merged To Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_merged_to_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_quarter {
    label: "Prescription Merged To Quarter"
    description: "Prescription Merged To Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_merged_to_cust_timeframes.quarter} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_year {
    label: "Prescription Merged To Year"
    description: "Prescription Merged To Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.year} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_day_of_week_index {
    label: "Prescription Merged To Day Of Week Index"
    description: "Prescription Merged To Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_week_begin_date {
    label: "Prescription Merged To Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Merged To Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_week_end_date {
    label: "Prescription Merged To Week End Date"
    description: "Prescription Merged To Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_week_of_quarter {
    label: "Prescription Merged To Week Of Quarter"
    description: "Prescription Merged To Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_month_begin_date {
    label: "Prescription Merged To Month Begin Date"
    description: "Prescription Merged To Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_month_end_date {
    label: "Prescription Merged To Month End Date"
    description: "Prescription Merged To Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_weeks_in_month {
    label: "Prescription Merged To Weeks In Month"
    description: "Prescription Merged To Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_quarter_begin_date {
    label: "Prescription Merged To Quarter Begin Date"
    description: "Prescription Merged To Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_quarter_end_date {
    label: "Prescription Merged To Quarter End Date"
    description: "Prescription Merged To Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_weeks_in_quarter {
    label: "Prescription Merged To Weeks In Quarter"
    description: "Prescription Merged To Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_year_begin_date {
    label: "Prescription Merged To Year Begin Date"
    description: "Prescription Merged To Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_year_end_date {
    label: "Prescription Merged To Year End Date"
    description: "Prescription Merged To Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_merged_to_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_weeks_in_year {
    label: "Prescription Merged To Weeks In Year"
    description: "Prescription Merged To Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_leap_year_flag {
    label: "Prescription Merged To Leap Year Flag"
    description: "Prescription Merged To Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_merged_to_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_day_of_quarter {
    label: "Prescription Merged To Day Of Quarter"
    description: "Prescription Merged To Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Merged To Date"
  }

  dimension: rx_merged_to_cust_day_of_year {
    label: "Prescription Merged To Day Of Year"
    description: "Prescription Merged To Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_merged_to_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Merged To Date"
  }

  #Prescription Autofill Enable Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_autofill_enable_cust {
    label: "Prescription Autofill Enable"
    description: "Prescription Autofill Enable Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_AUTOFILL_ENABLE_DATE ;;
  }

  dimension: rx_autofill_enable_cust_calendar_date {
    label: "Prescription Autofill Enable Date"
    description: "Prescription Autofill Enable Date"
    type: date
    hidden: yes
    sql: ${rx_autofill_enable_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_chain_id {
    label: "Prescription Autofill Enable Chain ID"
    description: "Prescription Autofill Enable Chain ID"
    type: number
    hidden: yes
    sql: ${rx_autofill_enable_cust_timeframes.chain_id} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_calendar_owner_chain_id {
    label: "Prescription Autofill Enable Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_autofill_enable_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_yesno {
    label: "Prescription Autofill Enable (Yes/No)"
    group_label: "Prescription Autofill Enable Date"
    description: "Yes/No flag indicating if a prescription has Autofill Enable Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_AUTOFILL_ENABLE_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_autofill_enable_cust_day_of_week {
    label: "Prescription Autofill Enable Day Of Week"
    description: "Prescription Autofill Enable Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_enable_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_day_of_month {
    label: "Prescription Autofill Enable Day Of Month"
    description: "Prescription Autofill Enable Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_week_of_year {
    label: "Prescription Autofill Enable Week Of Year"
    description: "Prescription Autofill Enable Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_month_num {
    label: "Prescription Autofill Enable Month Num"
    description: "Prescription Autofill Enable Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.month_num} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_month {
    label: "Prescription Autofill Enable Month"
    description: "Prescription Autofill Enable Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_enable_cust_timeframes.month} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_quarter_of_year {
    label: "Prescription Autofill Enable Quarter Of Year"
    description: "Prescription Autofill Enable Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_enable_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_quarter {
    label: "Prescription Autofill Enable Quarter"
    description: "Prescription Autofill Enable Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_enable_cust_timeframes.quarter} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_year {
    label: "Prescription Autofill Enable Year"
    description: "Prescription Autofill Enable Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.year} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_day_of_week_index {
    label: "Prescription Autofill Enable Day Of Week Index"
    description: "Prescription Autofill Enable Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_week_begin_date {
    label: "Prescription Autofill Enable Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Autofill Enable Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_week_end_date {
    label: "Prescription Autofill Enable Week End Date"
    description: "Prescription Autofill Enable Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_week_of_quarter {
    label: "Prescription Autofill Enable Week Of Quarter"
    description: "Prescription Autofill Enable Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_month_begin_date {
    label: "Prescription Autofill Enable Month Begin Date"
    description: "Prescription Autofill Enable Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_month_end_date {
    label: "Prescription Autofill Enable Month End Date"
    description: "Prescription Autofill Enable Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_weeks_in_month {
    label: "Prescription Autofill Enable Weeks In Month"
    description: "Prescription Autofill Enable Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_quarter_begin_date {
    label: "Prescription Autofill Enable Quarter Begin Date"
    description: "Prescription Autofill Enable Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_quarter_end_date {
    label: "Prescription Autofill Enable Quarter End Date"
    description: "Prescription Autofill Enable Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_weeks_in_quarter {
    label: "Prescription Autofill Enable Weeks In Quarter"
    description: "Prescription Autofill Enable Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_year_begin_date {
    label: "Prescription Autofill Enable Year Begin Date"
    description: "Prescription Autofill Enable Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_year_end_date {
    label: "Prescription Autofill Enable Year End Date"
    description: "Prescription Autofill Enable Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_enable_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_weeks_in_year {
    label: "Prescription Autofill Enable Weeks In Year"
    description: "Prescription Autofill Enable Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_leap_year_flag {
    label: "Prescription Autofill Enable Leap Year Flag"
    description: "Prescription Autofill Enable Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_enable_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_day_of_quarter {
    label: "Prescription Autofill Enable Day Of Quarter"
    description: "Prescription Autofill Enable Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  dimension: rx_autofill_enable_cust_day_of_year {
    label: "Prescription Autofill Enable Day Of Year"
    description: "Prescription Autofill Enable Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_enable_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Autofill Enable Date"
  }

  #Prescription Received Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_received_cust {
    label: "Prescription Received"
    description: "Prescription Received Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_RECEIVED_DATE ;;
  }

  dimension: rx_received_cust_calendar_date {
    label: "Prescription Received Date"
    description: "Prescription Received Date"
    type: date
    hidden: yes
    sql: ${rx_received_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_chain_id {
    label: "Prescription Received Chain ID"
    description: "Prescription Received Chain ID"
    type: number
    hidden: yes
    sql: ${rx_received_cust_timeframes.chain_id} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_calendar_owner_chain_id {
    label: "Prescription Received Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_received_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_yesno {
    label: "Prescription Received (Yes/No)"
    group_label: "Prescription Received Date"
    description: "Yes/No flag indicating if a prescription has Received Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_RECEIVED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_received_cust_day_of_week {
    label: "Prescription Received Day Of Week"
    description: "Prescription Received Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_received_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_day_of_month {
    label: "Prescription Received Day Of Month"
    description: "Prescription Received Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_week_of_year {
    label: "Prescription Received Week Of Year"
    description: "Prescription Received Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_month_num {
    label: "Prescription Received Month Num"
    description: "Prescription Received Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.month_num} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_month {
    label: "Prescription Received Month"
    description: "Prescription Received Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_received_cust_timeframes.month} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_quarter_of_year {
    label: "Prescription Received Quarter Of Year"
    description: "Prescription Received Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_received_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_quarter {
    label: "Prescription Received Quarter"
    description: "Prescription Received Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_received_cust_timeframes.quarter} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_year {
    label: "Prescription Received Year"
    description: "Prescription Received Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.year} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_day_of_week_index {
    label: "Prescription Received Day Of Week Index"
    description: "Prescription Received Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_week_begin_date {
    label: "Prescription Received Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Received Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_week_end_date {
    label: "Prescription Received Week End Date"
    description: "Prescription Received Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_week_of_quarter {
    label: "Prescription Received Week Of Quarter"
    description: "Prescription Received Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_month_begin_date {
    label: "Prescription Received Month Begin Date"
    description: "Prescription Received Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_month_end_date {
    label: "Prescription Received Month End Date"
    description: "Prescription Received Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_weeks_in_month {
    label: "Prescription Received Weeks In Month"
    description: "Prescription Received Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_quarter_begin_date {
    label: "Prescription Received Quarter Begin Date"
    description: "Prescription Received Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_quarter_end_date {
    label: "Prescription Received Quarter End Date"
    description: "Prescription Received Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_weeks_in_quarter {
    label: "Prescription Received Weeks In Quarter"
    description: "Prescription Received Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_year_begin_date {
    label: "Prescription Received Year Begin Date"
    description: "Prescription Received Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_year_end_date {
    label: "Prescription Received Year End Date"
    description: "Prescription Received Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_received_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_weeks_in_year {
    label: "Prescription Received Weeks In Year"
    description: "Prescription Received Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_leap_year_flag {
    label: "Prescription Received Leap Year Flag"
    description: "Prescription Received Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_received_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_day_of_quarter {
    label: "Prescription Received Day Of Quarter"
    description: "Prescription Received Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Received Date"
  }

  dimension: rx_received_cust_day_of_year {
    label: "Prescription Received Day Of Year"
    description: "Prescription Received Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_received_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Received Date"
  }

  #Prescription File Buy Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_file_buy_cust {
    label: "Prescription File Buy"
    description: "Prescription File Buy Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_FILE_BUY_DATE ;;
  }

  dimension: rx_file_buy_cust_calendar_date {
    label: "Prescription File Buy Date"
    description: "Prescription File Buy Date"
    type: date
    hidden: yes
    sql: ${rx_file_buy_cust_timeframes.calendar_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_chain_id {
    label: "Prescription File Buy Chain ID"
    description: "Prescription File Buy Chain ID"
    type: number
    hidden: yes
    sql: ${rx_file_buy_cust_timeframes.chain_id} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_calendar_owner_chain_id {
    label: "Prescription File Buy Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_file_buy_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_yesno {
    label: "Prescription File Buy (Yes/No)"
    group_label: "Prescription File Buy Date"
    description: "Yes/No flag indicating if a prescription has File Buy Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_FILE_BUY_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_file_buy_cust_day_of_week {
    label: "Prescription File Buy Day Of Week"
    description: "Prescription File Buy Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_file_buy_cust_timeframes.day_of_week} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_day_of_month {
    label: "Prescription File Buy Day Of Month"
    description: "Prescription File Buy Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.day_of_month} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_week_of_year {
    label: "Prescription File Buy Week Of Year"
    description: "Prescription File Buy Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.week_of_year} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_month_num {
    label: "Prescription File Buy Month Num"
    description: "Prescription File Buy Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.month_num} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_month {
    label: "Prescription File Buy Month"
    description: "Prescription File Buy Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_file_buy_cust_timeframes.month} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_quarter_of_year {
    label: "Prescription File Buy Quarter Of Year"
    description: "Prescription File Buy Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_file_buy_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_quarter {
    label: "Prescription File Buy Quarter"
    description: "Prescription File Buy Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_file_buy_cust_timeframes.quarter} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_year {
    label: "Prescription File Buy Year"
    description: "Prescription File Buy Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.year} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_day_of_week_index {
    label: "Prescription File Buy Day Of Week Index"
    description: "Prescription File Buy Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_week_begin_date {
    label: "Prescription File Buy Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription File Buy Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_week_end_date {
    label: "Prescription File Buy Week End Date"
    description: "Prescription File Buy Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.week_end_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_week_of_quarter {
    label: "Prescription File Buy Week Of Quarter"
    description: "Prescription File Buy Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_month_begin_date {
    label: "Prescription File Buy Month Begin Date"
    description: "Prescription File Buy Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_month_end_date {
    label: "Prescription File Buy Month End Date"
    description: "Prescription File Buy Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.month_end_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_weeks_in_month {
    label: "Prescription File Buy Weeks In Month"
    description: "Prescription File Buy Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_quarter_begin_date {
    label: "Prescription File Buy Quarter Begin Date"
    description: "Prescription File Buy Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_quarter_end_date {
    label: "Prescription File Buy Quarter End Date"
    description: "Prescription File Buy Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_weeks_in_quarter {
    label: "Prescription File Buy Weeks In Quarter"
    description: "Prescription File Buy Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_year_begin_date {
    label: "Prescription File Buy Year Begin Date"
    description: "Prescription File Buy Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_year_end_date {
    label: "Prescription File Buy Year End Date"
    description: "Prescription File Buy Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_file_buy_cust_timeframes.year_end_date} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_weeks_in_year {
    label: "Prescription File Buy Weeks In Year"
    description: "Prescription File Buy Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_leap_year_flag {
    label: "Prescription File Buy Leap Year Flag"
    description: "Prescription File Buy Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_file_buy_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_day_of_quarter {
    label: "Prescription File Buy Day Of Quarter"
    description: "Prescription File Buy Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription File Buy Date"
  }

  dimension: rx_file_buy_cust_day_of_year {
    label: "Prescription File Buy Day Of Year"
    description: "Prescription File Buy Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_file_buy_cust_timeframes.day_of_year} ;;
    group_label: "Prescription File Buy Date"
  }

  #Prescription Last Refill Reminder Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_last_refill_reminder_cust {
    label: "Prescription Last Refill Reminder"
    description: "Prescription Last Refill Reminder Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_LAST_REFILL_REMINDER_DATE ;;
  }

  dimension: rx_last_refill_reminder_cust_calendar_date {
    label: "Prescription Last Refill Reminder Date"
    description: "Prescription Last Refill Reminder Date"
    type: date
    hidden: yes
    sql: ${rx_last_refill_reminder_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_chain_id {
    label: "Prescription Last Refill Reminder Chain ID"
    description: "Prescription Last Refill Reminder Chain ID"
    type: number
    hidden: yes
    sql: ${rx_last_refill_reminder_cust_timeframes.chain_id} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_calendar_owner_chain_id {
    label: "Prescription Last Refill Reminder Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_last_refill_reminder_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_yesno {
    label: "Prescription Last Refill Reminder (Yes/No)"
    group_label: "Prescription Last Refill Reminder Date"
    description: "Yes/No flag indicating if a prescription has Last Refill Reminder Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_LAST_REFILL_REMINDER_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_last_refill_reminder_cust_day_of_week {
    label: "Prescription Last Refill Reminder Day Of Week"
    description: "Prescription Last Refill Reminder Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_last_refill_reminder_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_day_of_month {
    label: "Prescription Last Refill Reminder Day Of Month"
    description: "Prescription Last Refill Reminder Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_week_of_year {
    label: "Prescription Last Refill Reminder Week Of Year"
    description: "Prescription Last Refill Reminder Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_month_num {
    label: "Prescription Last Refill Reminder Month Num"
    description: "Prescription Last Refill Reminder Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.month_num} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_month {
    label: "Prescription Last Refill Reminder Month"
    description: "Prescription Last Refill Reminder Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_last_refill_reminder_cust_timeframes.month} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_quarter_of_year {
    label: "Prescription Last Refill Reminder Quarter Of Year"
    description: "Prescription Last Refill Reminder Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_last_refill_reminder_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_quarter {
    label: "Prescription Last Refill Reminder Quarter"
    description: "Prescription Last Refill Reminder Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_last_refill_reminder_cust_timeframes.quarter} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_year {
    label: "Prescription Last Refill Reminder Year"
    description: "Prescription Last Refill Reminder Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.year} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_day_of_week_index {
    label: "Prescription Last Refill Reminder Day Of Week Index"
    description: "Prescription Last Refill Reminder Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_week_begin_date {
    label: "Prescription Last Refill Reminder Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Last Refill Reminder Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_week_end_date {
    label: "Prescription Last Refill Reminder Week End Date"
    description: "Prescription Last Refill Reminder Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_week_of_quarter {
    label: "Prescription Last Refill Reminder Week Of Quarter"
    description: "Prescription Last Refill Reminder Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_month_begin_date {
    label: "Prescription Last Refill Reminder Month Begin Date"
    description: "Prescription Last Refill Reminder Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_month_end_date {
    label: "Prescription Last Refill Reminder Month End Date"
    description: "Prescription Last Refill Reminder Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_weeks_in_month {
    label: "Prescription Last Refill Reminder Weeks In Month"
    description: "Prescription Last Refill Reminder Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_quarter_begin_date {
    label: "Prescription Last Refill Reminder Quarter Begin Date"
    description: "Prescription Last Refill Reminder Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_quarter_end_date {
    label: "Prescription Last Refill Reminder Quarter End Date"
    description: "Prescription Last Refill Reminder Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_weeks_in_quarter {
    label: "Prescription Last Refill Reminder Weeks In Quarter"
    description: "Prescription Last Refill Reminder Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_year_begin_date {
    label: "Prescription Last Refill Reminder Year Begin Date"
    description: "Prescription Last Refill Reminder Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_year_end_date {
    label: "Prescription Last Refill Reminder Year End Date"
    description: "Prescription Last Refill Reminder Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_last_refill_reminder_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_weeks_in_year {
    label: "Prescription Last Refill Reminder Weeks In Year"
    description: "Prescription Last Refill Reminder Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_leap_year_flag {
    label: "Prescription Last Refill Reminder Leap Year Flag"
    description: "Prescription Last Refill Reminder Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_last_refill_reminder_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_day_of_quarter {
    label: "Prescription Last Refill Reminder Day Of Quarter"
    description: "Prescription Last Refill Reminder Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  dimension: rx_last_refill_reminder_cust_day_of_year {
    label: "Prescription Last Refill Reminder Day Of Year"
    description: "Prescription Last Refill Reminder Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_last_refill_reminder_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Last Refill Reminder Date"
  }

  #Prescription Short Fill Sent Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_short_fill_sent_cust {
    label: "Prescription Short Fill Sent"
    description: "Prescription Short Fill Sent Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_SHORT_FILL_SENT ;;
  }

  dimension: rx_short_fill_sent_cust_calendar_date {
    label: "Prescription Short Fill Sent Date"
    description: "Prescription Short Fill Sent Date"
    type: date
    hidden: yes
    sql: ${rx_short_fill_sent_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_chain_id {
    label: "Prescription Short Fill Sent Chain ID"
    description: "Prescription Short Fill Sent Chain ID"
    type: number
    hidden: yes
    sql: ${rx_short_fill_sent_cust_timeframes.chain_id} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_calendar_owner_chain_id {
    label: "Prescription Short Fill Sent Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_short_fill_sent_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_yesno {
    label: "Prescription Short Fill Sent (Yes/No)"
    group_label: "Prescription Short Fill Sent Date"
    description: "Yes/No flag indicating if a prescription has Short Fill Sent Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_SHORT_FILL_SENT IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_short_fill_sent_cust_day_of_week {
    label: "Prescription Short Fill Sent Day Of Week"
    description: "Prescription Short Fill Sent Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_short_fill_sent_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_day_of_month {
    label: "Prescription Short Fill Sent Day Of Month"
    description: "Prescription Short Fill Sent Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_week_of_year {
    label: "Prescription Short Fill Sent Week Of Year"
    description: "Prescription Short Fill Sent Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_month_num {
    label: "Prescription Short Fill Sent Month Num"
    description: "Prescription Short Fill Sent Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.month_num} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_month {
    label: "Prescription Short Fill Sent Month"
    description: "Prescription Short Fill Sent Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_short_fill_sent_cust_timeframes.month} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_quarter_of_year {
    label: "Prescription Short Fill Sent Quarter Of Year"
    description: "Prescription Short Fill Sent Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_short_fill_sent_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_quarter {
    label: "Prescription Short Fill Sent Quarter"
    description: "Prescription Short Fill Sent Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_short_fill_sent_cust_timeframes.quarter} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_year {
    label: "Prescription Short Fill Sent Year"
    description: "Prescription Short Fill Sent Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.year} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_day_of_week_index {
    label: "Prescription Short Fill Sent Day Of Week Index"
    description: "Prescription Short Fill Sent Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_week_begin_date {
    label: "Prescription Short Fill Sent Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Short Fill Sent Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_week_end_date {
    label: "Prescription Short Fill Sent Week End Date"
    description: "Prescription Short Fill Sent Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_week_of_quarter {
    label: "Prescription Short Fill Sent Week Of Quarter"
    description: "Prescription Short Fill Sent Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_month_begin_date {
    label: "Prescription Short Fill Sent Month Begin Date"
    description: "Prescription Short Fill Sent Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_month_end_date {
    label: "Prescription Short Fill Sent Month End Date"
    description: "Prescription Short Fill Sent Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_weeks_in_month {
    label: "Prescription Short Fill Sent Weeks In Month"
    description: "Prescription Short Fill Sent Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_quarter_begin_date {
    label: "Prescription Short Fill Sent Quarter Begin Date"
    description: "Prescription Short Fill Sent Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_quarter_end_date {
    label: "Prescription Short Fill Sent Quarter End Date"
    description: "Prescription Short Fill Sent Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_weeks_in_quarter {
    label: "Prescription Short Fill Sent Weeks In Quarter"
    description: "Prescription Short Fill Sent Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_year_begin_date {
    label: "Prescription Short Fill Sent Year Begin Date"
    description: "Prescription Short Fill Sent Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_year_end_date {
    label: "Prescription Short Fill Sent Year End Date"
    description: "Prescription Short Fill Sent Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_short_fill_sent_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_weeks_in_year {
    label: "Prescription Short Fill Sent Weeks In Year"
    description: "Prescription Short Fill Sent Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_leap_year_flag {
    label: "Prescription Short Fill Sent Leap Year Flag"
    description: "Prescription Short Fill Sent Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_short_fill_sent_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_day_of_quarter {
    label: "Prescription Short Fill Sent Day Of Quarter"
    description: "Prescription Short Fill Sent Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  dimension: rx_short_fill_sent_cust_day_of_year {
    label: "Prescription Short Fill Sent Day Of Year"
    description: "Prescription Short Fill Sent Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_short_fill_sent_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Short Fill Sent Date"
  }

  #Prescription Chain First Filled Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_chain_first_filled_cust {
    label: "Prescription Chain First Filled"
    description: "Prescription Chain First Filled Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_CHAIN_FIRST_FILLED_DATE ;;
  }

  dimension: rx_chain_first_filled_cust_calendar_date {
    label: "Prescription Chain First Filled Date"
    description: "Prescription Chain First Filled Date"
    type: date
    hidden: yes
    sql: ${rx_chain_first_filled_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_chain_id {
    label: "Prescription Chain First Filled Chain ID"
    description: "Prescription Chain First Filled Chain ID"
    type: number
    hidden: yes
    sql: ${rx_chain_first_filled_cust_timeframes.chain_id} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_calendar_owner_chain_id {
    label: "Prescription Chain First Filled Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_chain_first_filled_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_yesno {
    label: "Prescription Chain First Filled (Yes/No)"
    group_label: "Prescription Chain First Filled Date"
    description: "Yes/No flag indicating if a prescription has Chain First Filled Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_CHAIN_FIRST_FILLED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_chain_first_filled_cust_day_of_week {
    label: "Prescription Chain First Filled Day Of Week"
    description: "Prescription Chain First Filled Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_chain_first_filled_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_day_of_month {
    label: "Prescription Chain First Filled Day Of Month"
    description: "Prescription Chain First Filled Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_week_of_year {
    label: "Prescription Chain First Filled Week Of Year"
    description: "Prescription Chain First Filled Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_month_num {
    label: "Prescription Chain First Filled Month Num"
    description: "Prescription Chain First Filled Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.month_num} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_month {
    label: "Prescription Chain First Filled Month"
    description: "Prescription Chain First Filled Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_chain_first_filled_cust_timeframes.month} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_quarter_of_year {
    label: "Prescription Chain First Filled Quarter Of Year"
    description: "Prescription Chain First Filled Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_chain_first_filled_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_quarter {
    label: "Prescription Chain First Filled Quarter"
    description: "Prescription Chain First Filled Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_chain_first_filled_cust_timeframes.quarter} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_year {
    label: "Prescription Chain First Filled Year"
    description: "Prescription Chain First Filled Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.year} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_day_of_week_index {
    label: "Prescription Chain First Filled Day Of Week Index"
    description: "Prescription Chain First Filled Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_week_begin_date {
    label: "Prescription Chain First Filled Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Chain First Filled Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_week_end_date {
    label: "Prescription Chain First Filled Week End Date"
    description: "Prescription Chain First Filled Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_week_of_quarter {
    label: "Prescription Chain First Filled Week Of Quarter"
    description: "Prescription Chain First Filled Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_month_begin_date {
    label: "Prescription Chain First Filled Month Begin Date"
    description: "Prescription Chain First Filled Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_month_end_date {
    label: "Prescription Chain First Filled Month End Date"
    description: "Prescription Chain First Filled Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_weeks_in_month {
    label: "Prescription Chain First Filled Weeks In Month"
    description: "Prescription Chain First Filled Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_quarter_begin_date {
    label: "Prescription Chain First Filled Quarter Begin Date"
    description: "Prescription Chain First Filled Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_quarter_end_date {
    label: "Prescription Chain First Filled Quarter End Date"
    description: "Prescription Chain First Filled Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_weeks_in_quarter {
    label: "Prescription Chain First Filled Weeks In Quarter"
    description: "Prescription Chain First Filled Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_year_begin_date {
    label: "Prescription Chain First Filled Year Begin Date"
    description: "Prescription Chain First Filled Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_year_end_date {
    label: "Prescription Chain First Filled Year End Date"
    description: "Prescription Chain First Filled Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_chain_first_filled_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_weeks_in_year {
    label: "Prescription Chain First Filled Weeks In Year"
    description: "Prescription Chain First Filled Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_leap_year_flag {
    label: "Prescription Chain First Filled Leap Year Flag"
    description: "Prescription Chain First Filled Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_chain_first_filled_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_day_of_quarter {
    label: "Prescription Chain First Filled Day Of Quarter"
    description: "Prescription Chain First Filled Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  dimension: rx_chain_first_filled_cust_day_of_year {
    label: "Prescription Chain First Filled Day Of Year"
    description: "Prescription Chain First Filled Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_chain_first_filled_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Chain First Filled Date"
  }

  #Prescription Expiration Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_expiration_cust {
    label: "Prescription Expiration"
    description: "Prescription Expiration Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_EXPIRATION_DATE ;;
  }

  dimension: rx_expiration_cust_calendar_date {
    label: "Prescription Expiration Date"
    description: "Prescription Expiration Date"
    type: date
    hidden: yes
    sql: ${rx_expiration_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_chain_id {
    label: "Prescription Expiration Chain ID"
    description: "Prescription Expiration Chain ID"
    type: number
    hidden: yes
    sql: ${rx_expiration_cust_timeframes.chain_id} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_calendar_owner_chain_id {
    label: "Prescription Expiration Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_expiration_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_yesno {
    label: "Prescription Expiration (Yes/No)"
    group_label: "Prescription Expiration Date"
    description: "Yes/No flag indicating if a prescription has Expiration Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_EXPIRATION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_expiration_cust_day_of_week {
    label: "Prescription Expiration Day Of Week"
    description: "Prescription Expiration Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_expiration_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_day_of_month {
    label: "Prescription Expiration Day Of Month"
    description: "Prescription Expiration Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_week_of_year {
    label: "Prescription Expiration Week Of Year"
    description: "Prescription Expiration Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_month_num {
    label: "Prescription Expiration Month Num"
    description: "Prescription Expiration Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.month_num} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_month {
    label: "Prescription Expiration Month"
    description: "Prescription Expiration Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_expiration_cust_timeframes.month} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_quarter_of_year {
    label: "Prescription Expiration Quarter Of Year"
    description: "Prescription Expiration Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_expiration_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_quarter {
    label: "Prescription Expiration Quarter"
    description: "Prescription Expiration Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_expiration_cust_timeframes.quarter} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_year {
    label: "Prescription Expiration Year"
    description: "Prescription Expiration Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.year} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_day_of_week_index {
    label: "Prescription Expiration Day Of Week Index"
    description: "Prescription Expiration Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_week_begin_date {
    label: "Prescription Expiration Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Expiration Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_week_end_date {
    label: "Prescription Expiration Week End Date"
    description: "Prescription Expiration Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_week_of_quarter {
    label: "Prescription Expiration Week Of Quarter"
    description: "Prescription Expiration Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_month_begin_date {
    label: "Prescription Expiration Month Begin Date"
    description: "Prescription Expiration Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_month_end_date {
    label: "Prescription Expiration Month End Date"
    description: "Prescription Expiration Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_weeks_in_month {
    label: "Prescription Expiration Weeks In Month"
    description: "Prescription Expiration Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_quarter_begin_date {
    label: "Prescription Expiration Quarter Begin Date"
    description: "Prescription Expiration Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_quarter_end_date {
    label: "Prescription Expiration Quarter End Date"
    description: "Prescription Expiration Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_weeks_in_quarter {
    label: "Prescription Expiration Weeks In Quarter"
    description: "Prescription Expiration Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_year_begin_date {
    label: "Prescription Expiration Year Begin Date"
    description: "Prescription Expiration Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_year_end_date {
    label: "Prescription Expiration Year End Date"
    description: "Prescription Expiration Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_expiration_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_weeks_in_year {
    label: "Prescription Expiration Weeks In Year"
    description: "Prescription Expiration Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_leap_year_flag {
    label: "Prescription Expiration Leap Year Flag"
    description: "Prescription Expiration Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_expiration_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_day_of_quarter {
    label: "Prescription Expiration Day Of Quarter"
    description: "Prescription Expiration Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Expiration Date"
  }

  dimension: rx_expiration_cust_day_of_year {
    label: "Prescription Expiration Day Of Year"
    description: "Prescription Expiration Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_expiration_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Expiration Date"
  }

  #Prescription First Filled Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_first_filled_cust {
    label: "Prescription First Filled"
    description: "Prescription First Filled Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_FIRST_FILLED_DATE ;;
  }

  dimension: rx_first_filled_cust_calendar_date {
    label: "Prescription First Filled Date"
    description: "Prescription First Filled Date"
    type: date
    hidden: yes
    sql: ${rx_first_filled_cust_timeframes.calendar_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_chain_id {
    label: "Prescription First Filled Chain ID"
    description: "Prescription First Filled Chain ID"
    type: number
    hidden: yes
    sql: ${rx_first_filled_cust_timeframes.chain_id} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_calendar_owner_chain_id {
    label: "Prescription First Filled Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_first_filled_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_yesno {
    label: "Prescription First Filled (Yes/No)"
    group_label: "Prescription First Filled Date"
    description: "Yes/No flag indicating if a prescription has First Filled Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_FIRST_FILLED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_first_filled_cust_day_of_week {
    label: "Prescription First Filled Day Of Week"
    description: "Prescription First Filled Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_first_filled_cust_timeframes.day_of_week} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_day_of_month {
    label: "Prescription First Filled Day Of Month"
    description: "Prescription First Filled Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.day_of_month} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_week_of_year {
    label: "Prescription First Filled Week Of Year"
    description: "Prescription First Filled Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.week_of_year} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_month_num {
    label: "Prescription First Filled Month Num"
    description: "Prescription First Filled Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.month_num} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_month {
    label: "Prescription First Filled Month"
    description: "Prescription First Filled Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_first_filled_cust_timeframes.month} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_quarter_of_year {
    label: "Prescription First Filled Quarter Of Year"
    description: "Prescription First Filled Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_first_filled_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_quarter {
    label: "Prescription First Filled Quarter"
    description: "Prescription First Filled Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_first_filled_cust_timeframes.quarter} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_year {
    label: "Prescription First Filled Year"
    description: "Prescription First Filled Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.year} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_day_of_week_index {
    label: "Prescription First Filled Day Of Week Index"
    description: "Prescription First Filled Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_week_begin_date {
    label: "Prescription First Filled Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription First Filled Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_week_end_date {
    label: "Prescription First Filled Week End Date"
    description: "Prescription First Filled Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.week_end_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_week_of_quarter {
    label: "Prescription First Filled Week Of Quarter"
    description: "Prescription First Filled Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_month_begin_date {
    label: "Prescription First Filled Month Begin Date"
    description: "Prescription First Filled Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_month_end_date {
    label: "Prescription First Filled Month End Date"
    description: "Prescription First Filled Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.month_end_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_weeks_in_month {
    label: "Prescription First Filled Weeks In Month"
    description: "Prescription First Filled Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_quarter_begin_date {
    label: "Prescription First Filled Quarter Begin Date"
    description: "Prescription First Filled Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_quarter_end_date {
    label: "Prescription First Filled Quarter End Date"
    description: "Prescription First Filled Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_weeks_in_quarter {
    label: "Prescription First Filled Weeks In Quarter"
    description: "Prescription First Filled Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_year_begin_date {
    label: "Prescription First Filled Year Begin Date"
    description: "Prescription First Filled Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_year_end_date {
    label: "Prescription First Filled Year End Date"
    description: "Prescription First Filled Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_first_filled_cust_timeframes.year_end_date} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_weeks_in_year {
    label: "Prescription First Filled Weeks In Year"
    description: "Prescription First Filled Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_leap_year_flag {
    label: "Prescription First Filled Leap Year Flag"
    description: "Prescription First Filled Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_first_filled_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_day_of_quarter {
    label: "Prescription First Filled Day Of Quarter"
    description: "Prescription First Filled Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription First Filled Date"
  }

  dimension: rx_first_filled_cust_day_of_year {
    label: "Prescription First Filled Day Of Year"
    description: "Prescription First Filled Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_first_filled_cust_timeframes.day_of_year} ;;
    group_label: "Prescription First Filled Date"
  }

  #Prescription Original Written Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_original_written_cust {
    label: "Prescription Original Written"
    description: "Prescription Original Written Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_ORIGINAL_WRITTEN_DATE ;;
  }

  dimension: rx_original_written_cust_calendar_date {
    label: "Prescription Original Written Date"
    description: "Prescription Original Written Date"
    type: date
    hidden: yes
    sql: ${rx_original_written_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_chain_id {
    label: "Prescription Original Written Chain ID"
    description: "Prescription Original Written Chain ID"
    type: number
    hidden: yes
    sql: ${rx_original_written_cust_timeframes.chain_id} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_calendar_owner_chain_id {
    label: "Prescription Original Written Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_original_written_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_yesno {
    label: "Prescription Original Written (Yes/No)"
    group_label: "Prescription Original Written Date"
    description: "Yes/No flag indicating if a prescription has Original Written Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_ORIGINAL_WRITTEN_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_original_written_cust_day_of_week {
    label: "Prescription Original Written Day Of Week"
    description: "Prescription Original Written Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_original_written_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_day_of_month {
    label: "Prescription Original Written Day Of Month"
    description: "Prescription Original Written Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_week_of_year {
    label: "Prescription Original Written Week Of Year"
    description: "Prescription Original Written Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_month_num {
    label: "Prescription Original Written Month Num"
    description: "Prescription Original Written Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.month_num} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_month {
    label: "Prescription Original Written Month"
    description: "Prescription Original Written Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_original_written_cust_timeframes.month} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_quarter_of_year {
    label: "Prescription Original Written Quarter Of Year"
    description: "Prescription Original Written Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_original_written_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_quarter {
    label: "Prescription Original Written Quarter"
    description: "Prescription Original Written Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_original_written_cust_timeframes.quarter} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_year {
    label: "Prescription Original Written Year"
    description: "Prescription Original Written Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.year} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_day_of_week_index {
    label: "Prescription Original Written Day Of Week Index"
    description: "Prescription Original Written Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_week_begin_date {
    label: "Prescription Original Written Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Original Written Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_week_end_date {
    label: "Prescription Original Written Week End Date"
    description: "Prescription Original Written Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_week_of_quarter {
    label: "Prescription Original Written Week Of Quarter"
    description: "Prescription Original Written Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_month_begin_date {
    label: "Prescription Original Written Month Begin Date"
    description: "Prescription Original Written Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_month_end_date {
    label: "Prescription Original Written Month End Date"
    description: "Prescription Original Written Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_weeks_in_month {
    label: "Prescription Original Written Weeks In Month"
    description: "Prescription Original Written Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_quarter_begin_date {
    label: "Prescription Original Written Quarter Begin Date"
    description: "Prescription Original Written Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_quarter_end_date {
    label: "Prescription Original Written Quarter End Date"
    description: "Prescription Original Written Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_weeks_in_quarter {
    label: "Prescription Original Written Weeks In Quarter"
    description: "Prescription Original Written Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_year_begin_date {
    label: "Prescription Original Written Year Begin Date"
    description: "Prescription Original Written Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_year_end_date {
    label: "Prescription Original Written Year End Date"
    description: "Prescription Original Written Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_original_written_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_weeks_in_year {
    label: "Prescription Original Written Weeks In Year"
    description: "Prescription Original Written Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_leap_year_flag {
    label: "Prescription Original Written Leap Year Flag"
    description: "Prescription Original Written Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_original_written_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_day_of_quarter {
    label: "Prescription Original Written Day Of Quarter"
    description: "Prescription Original Written Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Original Written Date"
  }

  dimension: rx_original_written_cust_day_of_year {
    label: "Prescription Original Written Day Of Year"
    description: "Prescription Original Written Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_original_written_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Original Written Date"
  }

  #Prescription Start Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_start_cust {
    label: "Prescription Start"
    description: "Prescription Start Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_START_DATE ;;
  }

  dimension: rx_start_cust_calendar_date {
    label: "Prescription Start Date"
    description: "Prescription Start Date"
    type: date
    hidden: yes
    sql: ${rx_start_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_chain_id {
    label: "Prescription Start Chain ID"
    description: "Prescription Start Chain ID"
    type: number
    hidden: yes
    sql: ${rx_start_cust_timeframes.chain_id} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_calendar_owner_chain_id {
    label: "Prescription Start Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_start_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_yesno {
    label: "Prescription Start (Yes/No)"
    group_label: "Prescription Start Date"
    description: "Yes/No flag indicating if a prescription has Start Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_START_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_start_cust_day_of_week {
    label: "Prescription Start Day Of Week"
    description: "Prescription Start Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_start_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_day_of_month {
    label: "Prescription Start Day Of Month"
    description: "Prescription Start Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_week_of_year {
    label: "Prescription Start Week Of Year"
    description: "Prescription Start Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_month_num {
    label: "Prescription Start Month Num"
    description: "Prescription Start Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.month_num} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_month {
    label: "Prescription Start Month"
    description: "Prescription Start Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_start_cust_timeframes.month} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_quarter_of_year {
    label: "Prescription Start Quarter Of Year"
    description: "Prescription Start Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_start_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_quarter {
    label: "Prescription Start Quarter"
    description: "Prescription Start Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_start_cust_timeframes.quarter} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_year {
    label: "Prescription Start Year"
    description: "Prescription Start Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.year} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_day_of_week_index {
    label: "Prescription Start Day Of Week Index"
    description: "Prescription Start Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_week_begin_date {
    label: "Prescription Start Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Start Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_week_end_date {
    label: "Prescription Start Week End Date"
    description: "Prescription Start Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_week_of_quarter {
    label: "Prescription Start Week Of Quarter"
    description: "Prescription Start Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_month_begin_date {
    label: "Prescription Start Month Begin Date"
    description: "Prescription Start Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_month_end_date {
    label: "Prescription Start Month End Date"
    description: "Prescription Start Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_weeks_in_month {
    label: "Prescription Start Weeks In Month"
    description: "Prescription Start Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_quarter_begin_date {
    label: "Prescription Start Quarter Begin Date"
    description: "Prescription Start Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_quarter_end_date {
    label: "Prescription Start Quarter End Date"
    description: "Prescription Start Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_weeks_in_quarter {
    label: "Prescription Start Weeks In Quarter"
    description: "Prescription Start Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_year_begin_date {
    label: "Prescription Start Year Begin Date"
    description: "Prescription Start Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_year_end_date {
    label: "Prescription Start Year End Date"
    description: "Prescription Start Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_start_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_weeks_in_year {
    label: "Prescription Start Weeks In Year"
    description: "Prescription Start Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_leap_year_flag {
    label: "Prescription Start Leap Year Flag"
    description: "Prescription Start Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_start_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_day_of_quarter {
    label: "Prescription Start Day Of Quarter"
    description: "Prescription Start Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Start Date"
  }

  dimension: rx_start_cust_day_of_year {
    label: "Prescription Start Day Of Year"
    description: "Prescription Start Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_start_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Start Date"
  }

  #Prescription Sync Script Enrollment Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_sync_script_enrollment_cust {
    label: "Prescription Sync Script Enrollment"
    description: "Prescription Sync Script Enrollment Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_SYNC_SCRIPT_ENROLLMENT_DATE ;;
  }

  dimension: rx_sync_script_enrollment_cust_calendar_date {
    label: "Prescription Sync Script Enrollment Date"
    description: "Prescription Sync Script Enrollment Date"
    type: date
    hidden: yes
    sql: ${rx_sync_script_enrollment_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_chain_id {
    label: "Prescription Sync Script Enrollment Chain ID"
    description: "Prescription Sync Script Enrollment Chain ID"
    type: number
    hidden: yes
    sql: ${rx_sync_script_enrollment_cust_timeframes.chain_id} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_calendar_owner_chain_id {
    label: "Prescription Sync Script Enrollment Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_sync_script_enrollment_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_yesno {
    label: "Prescription Sync Script Enrollment (Yes/No)"
    group_label: "Prescription Sync Script Enrollment Date"
    description: "Yes/No flag indicating if a prescription has Sync Script Enrollment Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_SYNC_SCRIPT_ENROLLMENT_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_sync_script_enrollment_cust_day_of_week {
    label: "Prescription Sync Script Enrollment Day Of Week"
    description: "Prescription Sync Script Enrollment Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_enrollment_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_day_of_month {
    label: "Prescription Sync Script Enrollment Day Of Month"
    description: "Prescription Sync Script Enrollment Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_week_of_year {
    label: "Prescription Sync Script Enrollment Week Of Year"
    description: "Prescription Sync Script Enrollment Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_month_num {
    label: "Prescription Sync Script Enrollment Month Num"
    description: "Prescription Sync Script Enrollment Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.month_num} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_month {
    label: "Prescription Sync Script Enrollment Month"
    description: "Prescription Sync Script Enrollment Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_enrollment_cust_timeframes.month} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_quarter_of_year {
    label: "Prescription Sync Script Enrollment Quarter Of Year"
    description: "Prescription Sync Script Enrollment Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_enrollment_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_quarter {
    label: "Prescription Sync Script Enrollment Quarter"
    description: "Prescription Sync Script Enrollment Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_enrollment_cust_timeframes.quarter} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_year {
    label: "Prescription Sync Script Enrollment Year"
    description: "Prescription Sync Script Enrollment Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.year} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_day_of_week_index {
    label: "Prescription Sync Script Enrollment Day Of Week Index"
    description: "Prescription Sync Script Enrollment Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_week_begin_date {
    label: "Prescription Sync Script Enrollment Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Sync Script Enrollment Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_week_end_date {
    label: "Prescription Sync Script Enrollment Week End Date"
    description: "Prescription Sync Script Enrollment Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_week_of_quarter {
    label: "Prescription Sync Script Enrollment Week Of Quarter"
    description: "Prescription Sync Script Enrollment Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_month_begin_date {
    label: "Prescription Sync Script Enrollment Month Begin Date"
    description: "Prescription Sync Script Enrollment Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_month_end_date {
    label: "Prescription Sync Script Enrollment Month End Date"
    description: "Prescription Sync Script Enrollment Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_weeks_in_month {
    label: "Prescription Sync Script Enrollment Weeks In Month"
    description: "Prescription Sync Script Enrollment Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_quarter_begin_date {
    label: "Prescription Sync Script Enrollment Quarter Begin Date"
    description: "Prescription Sync Script Enrollment Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_quarter_end_date {
    label: "Prescription Sync Script Enrollment Quarter End Date"
    description: "Prescription Sync Script Enrollment Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_weeks_in_quarter {
    label: "Prescription Sync Script Enrollment Weeks In Quarter"
    description: "Prescription Sync Script Enrollment Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_year_begin_date {
    label: "Prescription Sync Script Enrollment Year Begin Date"
    description: "Prescription Sync Script Enrollment Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_year_end_date {
    label: "Prescription Sync Script Enrollment Year End Date"
    description: "Prescription Sync Script Enrollment Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_enrollment_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_weeks_in_year {
    label: "Prescription Sync Script Enrollment Weeks In Year"
    description: "Prescription Sync Script Enrollment Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_leap_year_flag {
    label: "Prescription Sync Script Enrollment Leap Year Flag"
    description: "Prescription Sync Script Enrollment Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_enrollment_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_day_of_quarter {
    label: "Prescription Sync Script Enrollment Day Of Quarter"
    description: "Prescription Sync Script Enrollment Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  dimension: rx_sync_script_enrollment_cust_day_of_year {
    label: "Prescription Sync Script Enrollment Day Of Year"
    description: "Prescription Sync Script Enrollment Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_enrollment_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Sync Script Enrollment Date"
  }

  #Prescription Source Create Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_source_create_cust {
    label: "Prescription Source Create"
    description: "Prescription Source Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: rx_source_create_cust_calendar_date {
    label: "Prescription Source Create Date"
    description: "Prescription Source Create Date"
    type: date
    hidden: yes
    sql: ${rx_source_create_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_chain_id {
    label: "Prescription Source Create Chain ID"
    description: "Prescription Source Create Chain ID"
    type: number
    hidden: yes
    sql: ${rx_source_create_cust_timeframes.chain_id} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_calendar_owner_chain_id {
    label: "Prescription Source Create Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_source_create_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_yesno {
    label: "Prescription Source Create (Yes/No)"
    group_label: "Prescription Source Create Date"
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

  dimension: rx_source_create_cust_day_of_week {
    label: "Prescription Source Create Day Of Week"
    description: "Prescription Source Create Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_create_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_day_of_month {
    label: "Prescription Source Create Day Of Month"
    description: "Prescription Source Create Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_week_of_year {
    label: "Prescription Source Create Week Of Year"
    description: "Prescription Source Create Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_month_num {
    label: "Prescription Source Create Month Num"
    description: "Prescription Source Create Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.month_num} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_month {
    label: "Prescription Source Create Month"
    description: "Prescription Source Create Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_create_cust_timeframes.month} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_quarter_of_year {
    label: "Prescription Source Create Quarter Of Year"
    description: "Prescription Source Create Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_create_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_quarter {
    label: "Prescription Source Create Quarter"
    description: "Prescription Source Create Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_create_cust_timeframes.quarter} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_year {
    label: "Prescription Source Create Year"
    description: "Prescription Source Create Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.year} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_day_of_week_index {
    label: "Prescription Source Create Day Of Week Index"
    description: "Prescription Source Create Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_week_begin_date {
    label: "Prescription Source Create Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Source Create Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_week_end_date {
    label: "Prescription Source Create Week End Date"
    description: "Prescription Source Create Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_week_of_quarter {
    label: "Prescription Source Create Week Of Quarter"
    description: "Prescription Source Create Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_month_begin_date {
    label: "Prescription Source Create Month Begin Date"
    description: "Prescription Source Create Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_month_end_date {
    label: "Prescription Source Create Month End Date"
    description: "Prescription Source Create Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_weeks_in_month {
    label: "Prescription Source Create Weeks In Month"
    description: "Prescription Source Create Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_quarter_begin_date {
    label: "Prescription Source Create Quarter Begin Date"
    description: "Prescription Source Create Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_quarter_end_date {
    label: "Prescription Source Create Quarter End Date"
    description: "Prescription Source Create Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_weeks_in_quarter {
    label: "Prescription Source Create Weeks In Quarter"
    description: "Prescription Source Create Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_year_begin_date {
    label: "Prescription Source Create Year Begin Date"
    description: "Prescription Source Create Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_year_end_date {
    label: "Prescription Source Create Year End Date"
    description: "Prescription Source Create Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_create_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_weeks_in_year {
    label: "Prescription Source Create Weeks In Year"
    description: "Prescription Source Create Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_leap_year_flag {
    label: "Prescription Source Create Leap Year Flag"
    description: "Prescription Source Create Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_create_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_day_of_quarter {
    label: "Prescription Source Create Day Of Quarter"
    description: "Prescription Source Create Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Source Create Date"
  }

  dimension: rx_source_create_cust_day_of_year {
    label: "Prescription Source Create Day Of Year"
    description: "Prescription Source Create Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_create_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Source Create Date"
  }

  #Prescription Other Store Last Filled Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_other_store_last_filled_cust {
    label: "Prescription Other Store Last Filled"
    description: "Prescription Other Store Last Filled Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_OTHER_STORE_LAST_FILLED_DATE ;;
  }

  dimension: rx_other_store_last_filled_cust_calendar_date {
    label: "Prescription Other Store Last Filled Date"
    description: "Prescription Other Store Last Filled Date"
    type: date
    hidden: yes
    sql: ${rx_other_store_last_filled_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_chain_id {
    label: "Prescription Other Store Last Filled Chain ID"
    description: "Prescription Other Store Last Filled Chain ID"
    type: number
    hidden: yes
    sql: ${rx_other_store_last_filled_cust_timeframes.chain_id} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_calendar_owner_chain_id {
    label: "Prescription Other Store Last Filled Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_other_store_last_filled_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_yesno {
    label: "Prescription Other Store Last Filled (Yes/No)"
    group_label: "Prescription Other Store Last Filled Date"
    description: "Yes/No flag indicating if a prescription has Other Store Last Filled Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_OTHER_STORE_LAST_FILLED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_other_store_last_filled_cust_day_of_week {
    label: "Prescription Other Store Last Filled Day Of Week"
    description: "Prescription Other Store Last Filled Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_other_store_last_filled_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_day_of_month {
    label: "Prescription Other Store Last Filled Day Of Month"
    description: "Prescription Other Store Last Filled Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_week_of_year {
    label: "Prescription Other Store Last Filled Week Of Year"
    description: "Prescription Other Store Last Filled Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_month_num {
    label: "Prescription Other Store Last Filled Month Num"
    description: "Prescription Other Store Last Filled Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.month_num} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_month {
    label: "Prescription Other Store Last Filled Month"
    description: "Prescription Other Store Last Filled Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_other_store_last_filled_cust_timeframes.month} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_quarter_of_year {
    label: "Prescription Other Store Last Filled Quarter Of Year"
    description: "Prescription Other Store Last Filled Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_other_store_last_filled_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_quarter {
    label: "Prescription Other Store Last Filled Quarter"
    description: "Prescription Other Store Last Filled Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_other_store_last_filled_cust_timeframes.quarter} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_year {
    label: "Prescription Other Store Last Filled Year"
    description: "Prescription Other Store Last Filled Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.year} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_day_of_week_index {
    label: "Prescription Other Store Last Filled Day Of Week Index"
    description: "Prescription Other Store Last Filled Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_week_begin_date {
    label: "Prescription Other Store Last Filled Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Other Store Last Filled Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_week_end_date {
    label: "Prescription Other Store Last Filled Week End Date"
    description: "Prescription Other Store Last Filled Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_week_of_quarter {
    label: "Prescription Other Store Last Filled Week Of Quarter"
    description: "Prescription Other Store Last Filled Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_month_begin_date {
    label: "Prescription Other Store Last Filled Month Begin Date"
    description: "Prescription Other Store Last Filled Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_month_end_date {
    label: "Prescription Other Store Last Filled Month End Date"
    description: "Prescription Other Store Last Filled Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_weeks_in_month {
    label: "Prescription Other Store Last Filled Weeks In Month"
    description: "Prescription Other Store Last Filled Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_quarter_begin_date {
    label: "Prescription Other Store Last Filled Quarter Begin Date"
    description: "Prescription Other Store Last Filled Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_quarter_end_date {
    label: "Prescription Other Store Last Filled Quarter End Date"
    description: "Prescription Other Store Last Filled Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_weeks_in_quarter {
    label: "Prescription Other Store Last Filled Weeks In Quarter"
    description: "Prescription Other Store Last Filled Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_year_begin_date {
    label: "Prescription Other Store Last Filled Year Begin Date"
    description: "Prescription Other Store Last Filled Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_year_end_date {
    label: "Prescription Other Store Last Filled Year End Date"
    description: "Prescription Other Store Last Filled Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_other_store_last_filled_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_weeks_in_year {
    label: "Prescription Other Store Last Filled Weeks In Year"
    description: "Prescription Other Store Last Filled Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_leap_year_flag {
    label: "Prescription Other Store Last Filled Leap Year Flag"
    description: "Prescription Other Store Last Filled Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_other_store_last_filled_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_day_of_quarter {
    label: "Prescription Other Store Last Filled Day Of Quarter"
    description: "Prescription Other Store Last Filled Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  dimension: rx_other_store_last_filled_cust_day_of_year {
    label: "Prescription Other Store Last Filled Day Of Year"
    description: "Prescription Other Store Last Filled Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_other_store_last_filled_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Other Store Last Filled Date"
  }

  #Prescription Autofill Due Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_autofill_due_cust {
    label: "Prescription Autofill Due"
    description: "Prescription Autofill Due Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_AUTOFILL_DUE_DATE ;;
  }

  dimension: rx_autofill_due_cust_calendar_date {
    label: "Prescription Autofill Due Date"
    description: "Prescription Autofill Due Date"
    type: date
    hidden: yes
    sql: ${rx_autofill_due_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_chain_id {
    label: "Prescription Autofill Due Chain ID"
    description: "Prescription Autofill Due Chain ID"
    type: number
    hidden: yes
    sql: ${rx_autofill_due_cust_timeframes.chain_id} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_calendar_owner_chain_id {
    label: "Prescription Autofill Due Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_autofill_due_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_yesno {
    label: "Prescription Autofill Due (Yes/No)"
    group_label: "Prescription Autofill Due Date"
    description: "Yes/No flag indicating if a prescription has Autofill Due Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_AUTOFILL_DUE_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_autofill_due_cust_day_of_week {
    label: "Prescription Autofill Due Day Of Week"
    description: "Prescription Autofill Due Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_due_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_day_of_month {
    label: "Prescription Autofill Due Day Of Month"
    description: "Prescription Autofill Due Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_week_of_year {
    label: "Prescription Autofill Due Week Of Year"
    description: "Prescription Autofill Due Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_month_num {
    label: "Prescription Autofill Due Month Num"
    description: "Prescription Autofill Due Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.month_num} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_month {
    label: "Prescription Autofill Due Month"
    description: "Prescription Autofill Due Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_due_cust_timeframes.month} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_quarter_of_year {
    label: "Prescription Autofill Due Quarter Of Year"
    description: "Prescription Autofill Due Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_due_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_quarter {
    label: "Prescription Autofill Due Quarter"
    description: "Prescription Autofill Due Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_due_cust_timeframes.quarter} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_year {
    label: "Prescription Autofill Due Year"
    description: "Prescription Autofill Due Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.year} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_day_of_week_index {
    label: "Prescription Autofill Due Day Of Week Index"
    description: "Prescription Autofill Due Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_week_begin_date {
    label: "Prescription Autofill Due Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Autofill Due Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_week_end_date {
    label: "Prescription Autofill Due Week End Date"
    description: "Prescription Autofill Due Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_week_of_quarter {
    label: "Prescription Autofill Due Week Of Quarter"
    description: "Prescription Autofill Due Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_month_begin_date {
    label: "Prescription Autofill Due Month Begin Date"
    description: "Prescription Autofill Due Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_month_end_date {
    label: "Prescription Autofill Due Month End Date"
    description: "Prescription Autofill Due Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_weeks_in_month {
    label: "Prescription Autofill Due Weeks In Month"
    description: "Prescription Autofill Due Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_quarter_begin_date {
    label: "Prescription Autofill Due Quarter Begin Date"
    description: "Prescription Autofill Due Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_quarter_end_date {
    label: "Prescription Autofill Due Quarter End Date"
    description: "Prescription Autofill Due Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_weeks_in_quarter {
    label: "Prescription Autofill Due Weeks In Quarter"
    description: "Prescription Autofill Due Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_year_begin_date {
    label: "Prescription Autofill Due Year Begin Date"
    description: "Prescription Autofill Due Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_year_end_date {
    label: "Prescription Autofill Due Year End Date"
    description: "Prescription Autofill Due Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_autofill_due_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_weeks_in_year {
    label: "Prescription Autofill Due Weeks In Year"
    description: "Prescription Autofill Due Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_leap_year_flag {
    label: "Prescription Autofill Due Leap Year Flag"
    description: "Prescription Autofill Due Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_autofill_due_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_day_of_quarter {
    label: "Prescription Autofill Due Day Of Quarter"
    description: "Prescription Autofill Due Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Autofill Due Date"
  }

  dimension: rx_autofill_due_cust_day_of_year {
    label: "Prescription Autofill Due Day Of Year"
    description: "Prescription Autofill Due Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_autofill_due_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Autofill Due Date"
  }

  #Prescription Written Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_written_cust {
    label: "Prescription Written"
    description: "Prescription Written Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_WRITTEN_DATE ;;
  }

  dimension: rx_written_cust_calendar_date {
    label: "Prescription Written Date"
    description: "Prescription Written Date"
    type: date
    hidden: yes
    sql: ${rx_written_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_chain_id {
    label: "Prescription Written Chain ID"
    description: "Prescription Written Chain ID"
    type: number
    hidden: yes
    sql: ${rx_written_cust_timeframes.chain_id} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_calendar_owner_chain_id {
    label: "Prescription Written Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_written_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_yesno {
    label: "Prescription Written (Yes/No)"
    group_label: "Prescription Written Date"
    description: "Yes/No flag indicating if a prescription has Written Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_WRITTEN_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_written_cust_day_of_week {
    label: "Prescription Written Day Of Week"
    description: "Prescription Written Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_written_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_day_of_month {
    label: "Prescription Written Day Of Month"
    description: "Prescription Written Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_week_of_year {
    label: "Prescription Written Week Of Year"
    description: "Prescription Written Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_month_num {
    label: "Prescription Written Month Num"
    description: "Prescription Written Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.month_num} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_month {
    label: "Prescription Written Month"
    description: "Prescription Written Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_written_cust_timeframes.month} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_quarter_of_year {
    label: "Prescription Written Quarter Of Year"
    description: "Prescription Written Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_written_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_quarter {
    label: "Prescription Written Quarter"
    description: "Prescription Written Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_written_cust_timeframes.quarter} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_year {
    label: "Prescription Written Year"
    description: "Prescription Written Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.year} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_day_of_week_index {
    label: "Prescription Written Day Of Week Index"
    description: "Prescription Written Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_week_begin_date {
    label: "Prescription Written Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Written Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_week_end_date {
    label: "Prescription Written Week End Date"
    description: "Prescription Written Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_week_of_quarter {
    label: "Prescription Written Week Of Quarter"
    description: "Prescription Written Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_month_begin_date {
    label: "Prescription Written Month Begin Date"
    description: "Prescription Written Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_month_end_date {
    label: "Prescription Written Month End Date"
    description: "Prescription Written Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_weeks_in_month {
    label: "Prescription Written Weeks In Month"
    description: "Prescription Written Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_quarter_begin_date {
    label: "Prescription Written Quarter Begin Date"
    description: "Prescription Written Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_quarter_end_date {
    label: "Prescription Written Quarter End Date"
    description: "Prescription Written Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_weeks_in_quarter {
    label: "Prescription Written Weeks In Quarter"
    description: "Prescription Written Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_year_begin_date {
    label: "Prescription Written Year Begin Date"
    description: "Prescription Written Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_year_end_date {
    label: "Prescription Written Year End Date"
    description: "Prescription Written Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_written_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_weeks_in_year {
    label: "Prescription Written Weeks In Year"
    description: "Prescription Written Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_leap_year_flag {
    label: "Prescription Written Leap Year Flag"
    description: "Prescription Written Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_written_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_day_of_quarter {
    label: "Prescription Written Day Of Quarter"
    description: "Prescription Written Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Written Date"
  }

  dimension: rx_written_cust_day_of_year {
    label: "Prescription Written Day Of Year"
    description: "Prescription Written Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_written_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Written Date"
  }

  #Prescription Stop Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_stop_cust {
    label: "Prescription Stop"
    description: "Prescription Stop Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_STOP_DATE ;;
  }

  dimension: rx_stop_cust_calendar_date {
    label: "Prescription Stop Date"
    description: "Prescription Stop Date"
    type: date
    hidden: yes
    sql: ${rx_stop_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_chain_id {
    label: "Prescription Stop Chain ID"
    description: "Prescription Stop Chain ID"
    type: number
    hidden: yes
    sql: ${rx_stop_cust_timeframes.chain_id} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_calendar_owner_chain_id {
    label: "Prescription Stop Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_stop_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_yesno {
    label: "Prescription Stop (Yes/No)"
    group_label: "Prescription Stop Date"
    description: "Yes/No flag indicating if a prescription has Stop Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_STOP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_stop_cust_day_of_week {
    label: "Prescription Stop Day Of Week"
    description: "Prescription Stop Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_stop_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_day_of_month {
    label: "Prescription Stop Day Of Month"
    description: "Prescription Stop Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_week_of_year {
    label: "Prescription Stop Week Of Year"
    description: "Prescription Stop Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_month_num {
    label: "Prescription Stop Month Num"
    description: "Prescription Stop Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.month_num} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_month {
    label: "Prescription Stop Month"
    description: "Prescription Stop Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_stop_cust_timeframes.month} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_quarter_of_year {
    label: "Prescription Stop Quarter Of Year"
    description: "Prescription Stop Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_stop_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_quarter {
    label: "Prescription Stop Quarter"
    description: "Prescription Stop Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_stop_cust_timeframes.quarter} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_year {
    label: "Prescription Stop Year"
    description: "Prescription Stop Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.year} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_day_of_week_index {
    label: "Prescription Stop Day Of Week Index"
    description: "Prescription Stop Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_week_begin_date {
    label: "Prescription Stop Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Stop Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_week_end_date {
    label: "Prescription Stop Week End Date"
    description: "Prescription Stop Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_week_of_quarter {
    label: "Prescription Stop Week Of Quarter"
    description: "Prescription Stop Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_month_begin_date {
    label: "Prescription Stop Month Begin Date"
    description: "Prescription Stop Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_month_end_date {
    label: "Prescription Stop Month End Date"
    description: "Prescription Stop Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_weeks_in_month {
    label: "Prescription Stop Weeks In Month"
    description: "Prescription Stop Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_quarter_begin_date {
    label: "Prescription Stop Quarter Begin Date"
    description: "Prescription Stop Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_quarter_end_date {
    label: "Prescription Stop Quarter End Date"
    description: "Prescription Stop Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_weeks_in_quarter {
    label: "Prescription Stop Weeks In Quarter"
    description: "Prescription Stop Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_year_begin_date {
    label: "Prescription Stop Year Begin Date"
    description: "Prescription Stop Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_year_end_date {
    label: "Prescription Stop Year End Date"
    description: "Prescription Stop Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_stop_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_weeks_in_year {
    label: "Prescription Stop Weeks In Year"
    description: "Prescription Stop Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_leap_year_flag {
    label: "Prescription Stop Leap Year Flag"
    description: "Prescription Stop Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_stop_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_day_of_quarter {
    label: "Prescription Stop Day Of Quarter"
    description: "Prescription Stop Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Stop Date"
  }

  dimension: rx_stop_cust_day_of_year {
    label: "Prescription Stop Day Of Year"
    description: "Prescription Stop Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_stop_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Stop Date"
  }

  #Prescription Follow Up Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_follow_up_cust {
    label: "Prescription Follow Up"
    description: "Prescription Follow Up Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_FOLLOW_UP_DATE ;;
  }

  dimension: rx_follow_up_cust_calendar_date {
    label: "Prescription Follow Up Date"
    description: "Prescription Follow Up Date"
    type: date
    hidden: yes
    sql: ${rx_follow_up_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_chain_id {
    label: "Prescription Follow Up Chain ID"
    description: "Prescription Follow Up Chain ID"
    type: number
    hidden: yes
    sql: ${rx_follow_up_cust_timeframes.chain_id} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_calendar_owner_chain_id {
    label: "Prescription Follow Up Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_follow_up_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_yesno {
    label: "Prescription Follow Up (Yes/No)"
    group_label: "Prescription Follow Up Date"
    description: "Yes/No flag indicating if a prescription has Follow Up Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_FOLLOW_UP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_follow_up_cust_day_of_week {
    label: "Prescription Follow Up Day Of Week"
    description: "Prescription Follow Up Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_follow_up_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_day_of_month {
    label: "Prescription Follow Up Day Of Month"
    description: "Prescription Follow Up Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_week_of_year {
    label: "Prescription Follow Up Week Of Year"
    description: "Prescription Follow Up Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_month_num {
    label: "Prescription Follow Up Month Num"
    description: "Prescription Follow Up Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.month_num} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_month {
    label: "Prescription Follow Up Month"
    description: "Prescription Follow Up Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_follow_up_cust_timeframes.month} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_quarter_of_year {
    label: "Prescription Follow Up Quarter Of Year"
    description: "Prescription Follow Up Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_follow_up_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_quarter {
    label: "Prescription Follow Up Quarter"
    description: "Prescription Follow Up Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_follow_up_cust_timeframes.quarter} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_year {
    label: "Prescription Follow Up Year"
    description: "Prescription Follow Up Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.year} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_day_of_week_index {
    label: "Prescription Follow Up Day Of Week Index"
    description: "Prescription Follow Up Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_week_begin_date {
    label: "Prescription Follow Up Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Follow Up Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_week_end_date {
    label: "Prescription Follow Up Week End Date"
    description: "Prescription Follow Up Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_week_of_quarter {
    label: "Prescription Follow Up Week Of Quarter"
    description: "Prescription Follow Up Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_month_begin_date {
    label: "Prescription Follow Up Month Begin Date"
    description: "Prescription Follow Up Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_month_end_date {
    label: "Prescription Follow Up Month End Date"
    description: "Prescription Follow Up Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_weeks_in_month {
    label: "Prescription Follow Up Weeks In Month"
    description: "Prescription Follow Up Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_quarter_begin_date {
    label: "Prescription Follow Up Quarter Begin Date"
    description: "Prescription Follow Up Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_quarter_end_date {
    label: "Prescription Follow Up Quarter End Date"
    description: "Prescription Follow Up Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_weeks_in_quarter {
    label: "Prescription Follow Up Weeks In Quarter"
    description: "Prescription Follow Up Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_year_begin_date {
    label: "Prescription Follow Up Year Begin Date"
    description: "Prescription Follow Up Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_year_end_date {
    label: "Prescription Follow Up Year End Date"
    description: "Prescription Follow Up Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_follow_up_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_weeks_in_year {
    label: "Prescription Follow Up Weeks In Year"
    description: "Prescription Follow Up Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_leap_year_flag {
    label: "Prescription Follow Up Leap Year Flag"
    description: "Prescription Follow Up Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_follow_up_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_day_of_quarter {
    label: "Prescription Follow Up Day Of Quarter"
    description: "Prescription Follow Up Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Follow Up Date"
  }

  dimension: rx_follow_up_cust_day_of_year {
    label: "Prescription Follow Up Day Of Year"
    description: "Prescription Follow Up Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_follow_up_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Follow Up Date"
  }

  #Prescription Last Updated Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_source_cust {
    label: "Prescription Last Updated"
    description: "Prescription Last Updated Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: rx_source_cust_calendar_date {
    label: "Prescription Last Updated Date"
    description: "Prescription Last Updated Date"
    type: date
    hidden: yes
    sql: ${rx_source_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_chain_id {
    label: "Prescription Last Updated Chain ID"
    description: "Prescription Last Updated Chain ID"
    type: number
    hidden: yes
    sql: ${rx_source_cust_timeframes.chain_id} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_calendar_owner_chain_id {
    label: "Prescription Last Updated Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_source_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_yesno {
    label: "Prescription Last Updated (Yes/No)"
    group_label: "Prescription Last Updated Date"
    description: "Yes/No flag indicating if a prescription has Last Updated Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.SOURCE_TIMESTAMP IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_source_cust_day_of_week {
    label: "Prescription Last Updated Day Of Week"
    description: "Prescription Last Updated Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_day_of_month {
    label: "Prescription Last Updated Day Of Month"
    description: "Prescription Last Updated Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_week_of_year {
    label: "Prescription Last Updated Week Of Year"
    description: "Prescription Last Updated Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_month_num {
    label: "Prescription Last Updated Month Num"
    description: "Prescription Last Updated Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.month_num} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_month {
    label: "Prescription Last Updated Month"
    description: "Prescription Last Updated Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_cust_timeframes.month} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_quarter_of_year {
    label: "Prescription Last Updated Quarter Of Year"
    description: "Prescription Last Updated Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_quarter {
    label: "Prescription Last Updated Quarter"
    description: "Prescription Last Updated Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_cust_timeframes.quarter} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_year {
    label: "Prescription Last Updated Year"
    description: "Prescription Last Updated Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.year} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_day_of_week_index {
    label: "Prescription Last Updated Day Of Week Index"
    description: "Prescription Last Updated Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_week_begin_date {
    label: "Prescription Last Updated Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Last Updated Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_week_end_date {
    label: "Prescription Last Updated Week End Date"
    description: "Prescription Last Updated Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_week_of_quarter {
    label: "Prescription Last Updated Week Of Quarter"
    description: "Prescription Last Updated Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_month_begin_date {
    label: "Prescription Last Updated Month Begin Date"
    description: "Prescription Last Updated Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_month_end_date {
    label: "Prescription Last Updated Month End Date"
    description: "Prescription Last Updated Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_weeks_in_month {
    label: "Prescription Last Updated Weeks In Month"
    description: "Prescription Last Updated Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_quarter_begin_date {
    label: "Prescription Last Updated Quarter Begin Date"
    description: "Prescription Last Updated Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_quarter_end_date {
    label: "Prescription Last Updated Quarter End Date"
    description: "Prescription Last Updated Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_weeks_in_quarter {
    label: "Prescription Last Updated Weeks In Quarter"
    description: "Prescription Last Updated Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_year_begin_date {
    label: "Prescription Last Updated Year Begin Date"
    description: "Prescription Last Updated Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_year_end_date {
    label: "Prescription Last Updated Year End Date"
    description: "Prescription Last Updated Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_source_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_weeks_in_year {
    label: "Prescription Last Updated Weeks In Year"
    description: "Prescription Last Updated Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_leap_year_flag {
    label: "Prescription Last Updated Leap Year Flag"
    description: "Prescription Last Updated Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_source_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_day_of_quarter {
    label: "Prescription Last Updated Day Of Quarter"
    description: "Prescription Last Updated Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Last Updated Date"
  }

  dimension: rx_source_cust_day_of_year {
    label: "Prescription Last Updated Day Of Year"
    description: "Prescription Last Updated Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_source_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Last Updated Date"
  }

  #Prescription Alignment Start Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_alignment_start_cust {
    label: "Prescription Last Update"
    description: "Prescription Alignment Start Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_ALIGNMENT_START_DATE ;;
  }

  dimension: rx_alignment_start_cust_calendar_date {
    label: "Prescription Alignment Start Date"
    description: "Prescription Alignment Start Date"
    type: date
    hidden: yes
    sql: ${rx_alignment_start_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_chain_id {
    label: "Prescription Alignment Start Chain ID"
    description: "Prescription Alignment Start Chain ID"
    type: number
    hidden: yes
    sql: ${rx_alignment_start_cust_timeframes.chain_id} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_calendar_owner_chain_id {
    label: "Prescription Alignment Start Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_alignment_start_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_yesno {
    label: "Prescription Alignment Start (Yes/No)"
    group_label: "Prescription Alignment Start Date"
    description: "Yes/No flag indicating if a prescription has Alignment Start Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_ALIGNMENT_START_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_alignment_start_cust_day_of_week {
    label: "Prescription Alignment Start Day Of Week"
    description: "Prescription Alignment Start Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_alignment_start_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_day_of_month {
    label: "Prescription Alignment Start Day Of Month"
    description: "Prescription Alignment Start Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_week_of_year {
    label: "Prescription Alignment Start Week Of Year"
    description: "Prescription Alignment Start Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_month_num {
    label: "Prescription Alignment Start Month Num"
    description: "Prescription Alignment Start Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.month_num} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_month {
    label: "Prescription Alignment Start Month"
    description: "Prescription Alignment Start Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_alignment_start_cust_timeframes.month} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_quarter_of_year {
    label: "Prescription Alignment Start Quarter Of Year"
    description: "Prescription Alignment Start Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_alignment_start_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_quarter {
    label: "Prescription Alignment Start Quarter"
    description: "Prescription Alignment Start Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_alignment_start_cust_timeframes.quarter} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_year {
    label: "Prescription Alignment Start Year"
    description: "Prescription Alignment Start Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.year} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_day_of_week_index {
    label: "Prescription Alignment Start Day Of Week Index"
    description: "Prescription Alignment Start Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_week_begin_date {
    label: "Prescription Alignment Start Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Alignment Start Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_week_end_date {
    label: "Prescription Alignment Start Week End Date"
    description: "Prescription Alignment Start Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_week_of_quarter {
    label: "Prescription Alignment Start Week Of Quarter"
    description: "Prescription Alignment Start Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_month_begin_date {
    label: "Prescription Alignment Start Month Begin Date"
    description: "Prescription Alignment Start Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_month_end_date {
    label: "Prescription Alignment Start Month End Date"
    description: "Prescription Alignment Start Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_weeks_in_month {
    label: "Prescription Alignment Start Weeks In Month"
    description: "Prescription Alignment Start Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_quarter_begin_date {
    label: "Prescription Alignment Start Quarter Begin Date"
    description: "Prescription Alignment Start Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_quarter_end_date {
    label: "Prescription Alignment Start Quarter End Date"
    description: "Prescription Alignment Start Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_weeks_in_quarter {
    label: "Prescription Alignment Start Weeks In Quarter"
    description: "Prescription Alignment Start Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_year_begin_date {
    label: "Prescription Alignment Start Year Begin Date"
    description: "Prescription Alignment Start Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_year_end_date {
    label: "Prescription Alignment Start Year End Date"
    description: "Prescription Alignment Start Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_alignment_start_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_weeks_in_year {
    label: "Prescription Alignment Start Weeks In Year"
    description: "Prescription Alignment Start Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_leap_year_flag {
    label: "Prescription Alignment Start Leap Year Flag"
    description: "Prescription Alignment Start Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_alignment_start_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_day_of_quarter {
    label: "Prescription Alignment Start Day Of Quarter"
    description: "Prescription Alignment Start Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Alignment Start Date"
  }

  dimension: rx_alignment_start_cust_day_of_year {
    label: "Prescription Alignment Start Day Of Year"
    description: "Prescription Alignment Start Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_alignment_start_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Alignment Start Date"
  }

  #Prescription Sync Script Refused Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_sync_script_refused_cust {
    label: "Prescription Sync Script Refused"
    description: "Prescription Sync Script Refused Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_SYNC_SCRIPT_REFUSED_DATE ;;
  }

  dimension: rx_sync_script_refused_cust_calendar_date {
    label: "Prescription Sync Script Refused Date"
    description: "Prescription Sync Script Refused Date"
    type: date
    hidden: yes
    sql: ${rx_sync_script_refused_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_chain_id {
    label: "Prescription Sync Script Refused Chain ID"
    description: "Prescription Sync Script Refused Chain ID"
    type: number
    hidden: yes
    sql: ${rx_sync_script_refused_cust_timeframes.chain_id} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_calendar_owner_chain_id {
    label: "Prescription Sync Script Refused Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_sync_script_refused_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_yesno {
    label: "Prescription Sync Script Refused (Yes/No)"
    group_label: "Prescription Sync Script Refused Date"
    description: "Yes/No flag indicating if a prescription has Sync Script Refused Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_SYNC_SCRIPT_REFUSED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_sync_script_refused_cust_day_of_week {
    label: "Prescription Sync Script Refused Day Of Week"
    description: "Prescription Sync Script Refused Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_refused_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_day_of_month {
    label: "Prescription Sync Script Refused Day Of Month"
    description: "Prescription Sync Script Refused Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_week_of_year {
    label: "Prescription Sync Script Refused Week Of Year"
    description: "Prescription Sync Script Refused Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_month_num {
    label: "Prescription Sync Script Refused Month Num"
    description: "Prescription Sync Script Refused Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.month_num} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_month {
    label: "Prescription Sync Script Refused Month"
    description: "Prescription Sync Script Refused Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_refused_cust_timeframes.month} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_quarter_of_year {
    label: "Prescription Sync Script Refused Quarter Of Year"
    description: "Prescription Sync Script Refused Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_refused_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_quarter {
    label: "Prescription Sync Script Refused Quarter"
    description: "Prescription Sync Script Refused Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_refused_cust_timeframes.quarter} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_year {
    label: "Prescription Sync Script Refused Year"
    description: "Prescription Sync Script Refused Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.year} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_day_of_week_index {
    label: "Prescription Sync Script Refused Day Of Week Index"
    description: "Prescription Sync Script Refused Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_week_begin_date {
    label: "Prescription Sync Script Refused Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Sync Script Refused Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_week_end_date {
    label: "Prescription Sync Script Refused Week End Date"
    description: "Prescription Sync Script Refused Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_week_of_quarter {
    label: "Prescription Sync Script Refused Week Of Quarter"
    description: "Prescription Sync Script Refused Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_month_begin_date {
    label: "Prescription Sync Script Refused Month Begin Date"
    description: "Prescription Sync Script Refused Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_month_end_date {
    label: "Prescription Sync Script Refused Month End Date"
    description: "Prescription Sync Script Refused Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_weeks_in_month {
    label: "Prescription Sync Script Refused Weeks In Month"
    description: "Prescription Sync Script Refused Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_quarter_begin_date {
    label: "Prescription Sync Script Refused Quarter Begin Date"
    description: "Prescription Sync Script Refused Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_quarter_end_date {
    label: "Prescription Sync Script Refused Quarter End Date"
    description: "Prescription Sync Script Refused Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_weeks_in_quarter {
    label: "Prescription Sync Script Refused Weeks In Quarter"
    description: "Prescription Sync Script Refused Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_year_begin_date {
    label: "Prescription Sync Script Refused Year Begin Date"
    description: "Prescription Sync Script Refused Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_year_end_date {
    label: "Prescription Sync Script Refused Year End Date"
    description: "Prescription Sync Script Refused Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_sync_script_refused_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_weeks_in_year {
    label: "Prescription Sync Script Refused Weeks In Year"
    description: "Prescription Sync Script Refused Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_leap_year_flag {
    label: "Prescription Sync Script Refused Leap Year Flag"
    description: "Prescription Sync Script Refused Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_sync_script_refused_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_day_of_quarter {
    label: "Prescription Sync Script Refused Day Of Quarter"
    description: "Prescription Sync Script Refused Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  dimension: rx_sync_script_refused_cust_day_of_year {
    label: "Prescription Sync Script Refused Day Of Year"
    description: "Prescription Sync Script Refused Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_sync_script_refused_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Sync Script Refused Date"
  }

  ####################################################################################### Sets ##################################################################

  set: explore_rx_4_6_000_sf_deployment_candidate_list {
    fields: [
      rx_enable_autofill,
      rx_escript_message_identifier,
      rx_hard_copy_printed,
      rx_last_refill_reminder_date_date,
      rx_last_refill_reminder_date_day_of_month,
      rx_last_refill_reminder_date_day_of_week,
      rx_last_refill_reminder_date_day_of_week_index,
      rx_last_refill_reminder_date_hour_of_day,
      rx_last_refill_reminder_date_hour2,
      rx_last_refill_reminder_date_minute15,
      rx_last_refill_reminder_date_month,
      rx_last_refill_reminder_date_month_num,
      rx_last_refill_reminder_date_quarter,
      rx_last_refill_reminder_date_quarter_of_year,
      rx_last_refill_reminder_date_time,
      rx_last_refill_reminder_date_time_of_day,
      rx_last_refill_reminder_date_week,
      rx_last_refill_reminder_date_week_of_year,
      rx_last_refill_reminder_date_year,
      rx_last_refill_reminder_date,
      rx_prescribed_drug_ddid,
      rx_prescribed_drug_id,
      rx_prescriber_edi_id,
      sum_rx_qty_left,
      rx_reportable_drug_number,
      rx_image_total,
      rx_short_fill_sent_date,
      rx_short_fill_sent_day_of_month,
      rx_short_fill_sent_day_of_week,
      rx_short_fill_sent_day_of_week_index,
      rx_short_fill_sent_hour_of_day,
      rx_short_fill_sent_hour2,
      rx_short_fill_sent_minute15,
      rx_short_fill_sent_month,
      rx_short_fill_sent_month_num,
      rx_short_fill_sent_quarter,
      rx_short_fill_sent_quarter_of_year,
      rx_short_fill_sent_time,
      rx_short_fill_sent_time_of_day,
      rx_short_fill_sent_week,
      rx_short_fill_sent_week_of_year,
      rx_short_fill_sent_year,
      rx_short_fill_sent
    ]
  }

  set: explore_rx_4_8_000_sf_deployment_candidate_list {
    fields: [
      rx_autofill_mail_flag,
      sum_rx_autofill_quantity,
      rx_barcode,
      rx_call_for_refills,
      rx_chain_first_filled,
      rx_chain_first_filled_time,
      rx_chain_first_filled_date,
      rx_chain_first_filled_week,
      rx_chain_first_filled_month,
      rx_chain_first_filled_month_num,
      rx_chain_first_filled_year,
      rx_chain_first_filled_quarter,
      rx_chain_first_filled_quarter_of_year,
      rx_chain_first_filled_hour_of_day,
      rx_chain_first_filled_time_of_day,
      rx_chain_first_filled_hour2,
      rx_chain_first_filled_minute15,
      rx_chain_first_filled_day_of_week,
      rx_chain_first_filled_week_of_year,
      rx_chain_first_filled_day_of_week_index,
      rx_chain_first_filled_day_of_month,
      rx_compound_id,
      rx_expiration,
      rx_expiration_time,
      rx_expiration_date,
      rx_expiration_week,
      rx_expiration_month,
      rx_expiration_month_num,
      rx_expiration_year,
      rx_expiration_quarter,
      rx_expiration_quarter_of_year,
      rx_expiration_hour_of_day,
      rx_expiration_time_of_day,
      rx_expiration_hour2,
      rx_expiration_minute15,
      rx_expiration_day_of_week,
      rx_expiration_week_of_year,
      rx_expiration_day_of_week_index,
      rx_expiration_day_of_month,
      rx_first_filled,
      rx_first_filled_time,
      rx_first_filled_date,
      rx_first_filled_week,
      rx_first_filled_month,
      rx_first_filled_month_num,
      rx_first_filled_year,
      rx_first_filled_quarter,
      rx_first_filled_quarter_of_year,
      rx_first_filled_hour_of_day,
      rx_first_filled_time_of_day,
      rx_first_filled_hour2,
      rx_first_filled_minute15,
      rx_first_filled_day_of_week,
      rx_first_filled_week_of_year,
      rx_first_filled_day_of_week_index,
      rx_first_filled_day_of_month,
      rx_last_filled_rx_tx_id,
      rx_new_rx_id,
      rx_old_rx_id,
      rx_note,
      rx_original_written,
      rx_original_written_time,
      rx_original_written_date,
      rx_original_written_week,
      rx_original_written_month,
      rx_original_written_month_num,
      rx_original_written_year,
      rx_original_written_quarter,
      rx_original_written_quarter_of_year,
      rx_original_written_hour_of_day,
      rx_original_written_time_of_day,
      rx_original_written_hour2,
      rx_original_written_minute15,
      rx_original_written_day_of_week,
      rx_original_written_week_of_year,
      rx_original_written_day_of_week_index,
      rx_original_written_day_of_month,
      rx_patient_id,
      rx_prescriber_not_found_response,
      rx_prescriber_order_number,
      rx_refills_authorized,
      rx_refills_remaining,
      rx_refills_transferred,
      rx_rxfill_indicator,
      rx_image_index,
      rx_start,
      rx_start_time,
      rx_start_date,
      rx_start_week,
      rx_start_month,
      rx_start_month_num,
      rx_start_year,
      rx_start_quarter,
      rx_start_quarter_of_year,
      rx_start_hour_of_day,
      rx_start_time_of_day,
      rx_start_hour2,
      rx_start_minute15,
      rx_start_day_of_week,
      rx_start_week_of_year,
      rx_start_day_of_week_index,
      rx_start_day_of_month,
      rx_sync_script_enrolled_by,
      rx_sync_script_enrollment_desc,
      rx_sync_script_enrollment,
      rx_sync_script_enrollment_time,
      rx_sync_script_enrollment_date,
      rx_sync_script_enrollment_week,
      rx_sync_script_enrollment_month,
      rx_sync_script_enrollment_month_num,
      rx_sync_script_enrollment_year,
      rx_sync_script_enrollment_quarter,
      rx_sync_script_enrollment_quarter_of_year,
      rx_sync_script_enrollment_hour_of_day,
      rx_sync_script_enrollment_time_of_day,
      rx_sync_script_enrollment_hour2,
      rx_sync_script_enrollment_minute15,
      rx_sync_script_enrollment_day_of_week,
      rx_sync_script_enrollment_week_of_year,
      rx_sync_script_enrollment_day_of_week_index,
      rx_sync_script_enrollment_day_of_month,
      rx_temporary_prescriber_identifier,
      rx_temporary_prescriber_id_qualifier,
      source_create,
      source_create_time,
      source_create_date,
      source_create_week,
      source_create_month,
      source_create_month_num,
      source_create_year,
      source_create_quarter,
      source_create_quarter_of_year,
      source_create_hour_of_day,
      source_create_time_of_day,
      source_create_hour2,
      source_create_minute15,
      source_create_day_of_week,
      source_create_week_of_year,
      source_create_day_of_week_index,
      source_create_day_of_month
    ]
  }

  #[ERXLPS-1922]
  set: explore_Workflow_taskhistory_candidate_list {
    fields: [
      rx_number,
      rx_file_buy_date,
      rx_file_buy_date_time,
      rx_file_buy_date_date,
      rx_file_buy_date_week,
      rx_file_buy_date_month,
      rx_file_buy_date_month_num,
      rx_file_buy_date_year,
      rx_file_buy_date_quarter,
      rx_file_buy_date_quarter_of_year,
      rx_file_buy_date_hour_of_day,
      rx_file_buy_date_time_of_day,
      rx_file_buy_date_hour2,
      rx_file_buy_date_minute15,
      rx_file_buy_date_day_of_week,
      rx_file_buy_date_week_of_year,
      rx_file_buy_date_day_of_week_index,
      rx_file_buy_date_day_of_month
    ]
  }

  #[ERXLPS-1922]
  set: explore_bi_demo_Workflow_taskhistory_candidate_list {
    fields: [
      rx_number_deidentified,
      rx_file_buy_date,
      rx_file_buy_date_time,
      rx_file_buy_date_date,
      rx_file_buy_date_week,
      rx_file_buy_date_month,
      rx_file_buy_date_month_num,
      rx_file_buy_date_year,
      rx_file_buy_date_quarter,
      rx_file_buy_date_quarter_of_year,
      rx_file_buy_date_hour_of_day,
      rx_file_buy_date_time_of_day,
      rx_file_buy_date_hour2,
      rx_file_buy_date_minute15,
      rx_file_buy_date_day_of_week,
      rx_file_buy_date_week_of_year,
      rx_file_buy_date_day_of_week_index,
      rx_file_buy_date_day_of_month
    ]
  }

  set: exploredx_eps_rx_analysis_cal_timeframes {
    fields: [
      rx_merged_to_cust_date,
      rx_merged_to_cust_calendar_date,
      rx_merged_to_cust_chain_id,
      rx_merged_to_cust_calendar_owner_chain_id,
      rx_merged_to_cust_yesno,
      rx_merged_to_cust_day_of_week,
      rx_merged_to_cust_day_of_month,
      rx_merged_to_cust_week_of_year,
      rx_merged_to_cust_month_num,
      rx_merged_to_cust_month,
      rx_merged_to_cust_quarter_of_year,
      rx_merged_to_cust_quarter,
      rx_merged_to_cust_year,
      rx_merged_to_cust_day_of_week_index,
      rx_merged_to_cust_week_begin_date,
      rx_merged_to_cust_week_end_date,
      rx_merged_to_cust_week_of_quarter,
      rx_merged_to_cust_month_begin_date,
      rx_merged_to_cust_month_end_date,
      rx_merged_to_cust_weeks_in_month,
      rx_merged_to_cust_quarter_begin_date,
      rx_merged_to_cust_quarter_end_date,
      rx_merged_to_cust_weeks_in_quarter,
      rx_merged_to_cust_year_begin_date,
      rx_merged_to_cust_year_end_date,
      rx_merged_to_cust_weeks_in_year,
      rx_merged_to_cust_leap_year_flag,
      rx_merged_to_cust_day_of_quarter,
      rx_merged_to_cust_day_of_year,
      rx_autofill_enable_cust_date,
      rx_autofill_enable_cust_calendar_date,
      rx_autofill_enable_cust_chain_id,
      rx_autofill_enable_cust_calendar_owner_chain_id,
      rx_autofill_enable_cust_yesno,
      rx_autofill_enable_cust_day_of_week,
      rx_autofill_enable_cust_day_of_month,
      rx_autofill_enable_cust_week_of_year,
      rx_autofill_enable_cust_month_num,
      rx_autofill_enable_cust_month,
      rx_autofill_enable_cust_quarter_of_year,
      rx_autofill_enable_cust_quarter,
      rx_autofill_enable_cust_year,
      rx_autofill_enable_cust_day_of_week_index,
      rx_autofill_enable_cust_week_begin_date,
      rx_autofill_enable_cust_week_end_date,
      rx_autofill_enable_cust_week_of_quarter,
      rx_autofill_enable_cust_month_begin_date,
      rx_autofill_enable_cust_month_end_date,
      rx_autofill_enable_cust_weeks_in_month,
      rx_autofill_enable_cust_quarter_begin_date,
      rx_autofill_enable_cust_quarter_end_date,
      rx_autofill_enable_cust_weeks_in_quarter,
      rx_autofill_enable_cust_year_begin_date,
      rx_autofill_enable_cust_year_end_date,
      rx_autofill_enable_cust_weeks_in_year,
      rx_autofill_enable_cust_leap_year_flag,
      rx_autofill_enable_cust_day_of_quarter,
      rx_autofill_enable_cust_day_of_year,
      rx_received_cust_date,
      rx_received_cust_calendar_date,
      rx_received_cust_chain_id,
      rx_received_cust_calendar_owner_chain_id,
      rx_received_cust_yesno,
      rx_received_cust_day_of_week,
      rx_received_cust_day_of_month,
      rx_received_cust_week_of_year,
      rx_received_cust_month_num,
      rx_received_cust_month,
      rx_received_cust_quarter_of_year,
      rx_received_cust_quarter,
      rx_received_cust_year,
      rx_received_cust_day_of_week_index,
      rx_received_cust_week_begin_date,
      rx_received_cust_week_end_date,
      rx_received_cust_week_of_quarter,
      rx_received_cust_month_begin_date,
      rx_received_cust_month_end_date,
      rx_received_cust_weeks_in_month,
      rx_received_cust_quarter_begin_date,
      rx_received_cust_quarter_end_date,
      rx_received_cust_weeks_in_quarter,
      rx_received_cust_year_begin_date,
      rx_received_cust_year_end_date,
      rx_received_cust_weeks_in_year,
      rx_received_cust_leap_year_flag,
      rx_received_cust_day_of_quarter,
      rx_received_cust_day_of_year,
      rx_file_buy_cust_date,
      rx_file_buy_cust_calendar_date,
      rx_file_buy_cust_chain_id,
      rx_file_buy_cust_calendar_owner_chain_id,
      rx_file_buy_cust_yesno,
      rx_file_buy_cust_day_of_week,
      rx_file_buy_cust_day_of_month,
      rx_file_buy_cust_week_of_year,
      rx_file_buy_cust_month_num,
      rx_file_buy_cust_month,
      rx_file_buy_cust_quarter_of_year,
      rx_file_buy_cust_quarter,
      rx_file_buy_cust_year,
      rx_file_buy_cust_day_of_week_index,
      rx_file_buy_cust_week_begin_date,
      rx_file_buy_cust_week_end_date,
      rx_file_buy_cust_week_of_quarter,
      rx_file_buy_cust_month_begin_date,
      rx_file_buy_cust_month_end_date,
      rx_file_buy_cust_weeks_in_month,
      rx_file_buy_cust_quarter_begin_date,
      rx_file_buy_cust_quarter_end_date,
      rx_file_buy_cust_weeks_in_quarter,
      rx_file_buy_cust_year_begin_date,
      rx_file_buy_cust_year_end_date,
      rx_file_buy_cust_weeks_in_year,
      rx_file_buy_cust_leap_year_flag,
      rx_file_buy_cust_day_of_quarter,
      rx_file_buy_cust_day_of_year,
      rx_last_refill_reminder_cust_date,
      rx_last_refill_reminder_cust_calendar_date,
      rx_last_refill_reminder_cust_chain_id,
      rx_last_refill_reminder_cust_calendar_owner_chain_id,
      rx_last_refill_reminder_cust_yesno,
      rx_last_refill_reminder_cust_day_of_week,
      rx_last_refill_reminder_cust_day_of_month,
      rx_last_refill_reminder_cust_week_of_year,
      rx_last_refill_reminder_cust_month_num,
      rx_last_refill_reminder_cust_month,
      rx_last_refill_reminder_cust_quarter_of_year,
      rx_last_refill_reminder_cust_quarter,
      rx_last_refill_reminder_cust_year,
      rx_last_refill_reminder_cust_day_of_week_index,
      rx_last_refill_reminder_cust_week_begin_date,
      rx_last_refill_reminder_cust_week_end_date,
      rx_last_refill_reminder_cust_week_of_quarter,
      rx_last_refill_reminder_cust_month_begin_date,
      rx_last_refill_reminder_cust_month_end_date,
      rx_last_refill_reminder_cust_weeks_in_month,
      rx_last_refill_reminder_cust_quarter_begin_date,
      rx_last_refill_reminder_cust_quarter_end_date,
      rx_last_refill_reminder_cust_weeks_in_quarter,
      rx_last_refill_reminder_cust_year_begin_date,
      rx_last_refill_reminder_cust_year_end_date,
      rx_last_refill_reminder_cust_weeks_in_year,
      rx_last_refill_reminder_cust_leap_year_flag,
      rx_last_refill_reminder_cust_day_of_quarter,
      rx_last_refill_reminder_cust_day_of_year,
      rx_short_fill_sent_cust_date,
      rx_short_fill_sent_cust_calendar_date,
      rx_short_fill_sent_cust_chain_id,
      rx_short_fill_sent_cust_calendar_owner_chain_id,
      rx_short_fill_sent_cust_yesno,
      rx_short_fill_sent_cust_day_of_week,
      rx_short_fill_sent_cust_day_of_month,
      rx_short_fill_sent_cust_week_of_year,
      rx_short_fill_sent_cust_month_num,
      rx_short_fill_sent_cust_month,
      rx_short_fill_sent_cust_quarter_of_year,
      rx_short_fill_sent_cust_quarter,
      rx_short_fill_sent_cust_year,
      rx_short_fill_sent_cust_day_of_week_index,
      rx_short_fill_sent_cust_week_begin_date,
      rx_short_fill_sent_cust_week_end_date,
      rx_short_fill_sent_cust_week_of_quarter,
      rx_short_fill_sent_cust_month_begin_date,
      rx_short_fill_sent_cust_month_end_date,
      rx_short_fill_sent_cust_weeks_in_month,
      rx_short_fill_sent_cust_quarter_begin_date,
      rx_short_fill_sent_cust_quarter_end_date,
      rx_short_fill_sent_cust_weeks_in_quarter,
      rx_short_fill_sent_cust_year_begin_date,
      rx_short_fill_sent_cust_year_end_date,
      rx_short_fill_sent_cust_weeks_in_year,
      rx_short_fill_sent_cust_leap_year_flag,
      rx_short_fill_sent_cust_day_of_quarter,
      rx_short_fill_sent_cust_day_of_year,
      rx_chain_first_filled_cust_date,
      rx_chain_first_filled_cust_calendar_date,
      rx_chain_first_filled_cust_chain_id,
      rx_chain_first_filled_cust_calendar_owner_chain_id,
      rx_chain_first_filled_cust_yesno,
      rx_chain_first_filled_cust_day_of_week,
      rx_chain_first_filled_cust_day_of_month,
      rx_chain_first_filled_cust_week_of_year,
      rx_chain_first_filled_cust_month_num,
      rx_chain_first_filled_cust_month,
      rx_chain_first_filled_cust_quarter_of_year,
      rx_chain_first_filled_cust_quarter,
      rx_chain_first_filled_cust_year,
      rx_chain_first_filled_cust_day_of_week_index,
      rx_chain_first_filled_cust_week_begin_date,
      rx_chain_first_filled_cust_week_end_date,
      rx_chain_first_filled_cust_week_of_quarter,
      rx_chain_first_filled_cust_month_begin_date,
      rx_chain_first_filled_cust_month_end_date,
      rx_chain_first_filled_cust_weeks_in_month,
      rx_chain_first_filled_cust_quarter_begin_date,
      rx_chain_first_filled_cust_quarter_end_date,
      rx_chain_first_filled_cust_weeks_in_quarter,
      rx_chain_first_filled_cust_year_begin_date,
      rx_chain_first_filled_cust_year_end_date,
      rx_chain_first_filled_cust_weeks_in_year,
      rx_chain_first_filled_cust_leap_year_flag,
      rx_chain_first_filled_cust_day_of_quarter,
      rx_chain_first_filled_cust_day_of_year,
      rx_expiration_cust_date,
      rx_expiration_cust_calendar_date,
      rx_expiration_cust_chain_id,
      rx_expiration_cust_calendar_owner_chain_id,
      rx_expiration_cust_yesno,
      rx_expiration_cust_day_of_week,
      rx_expiration_cust_day_of_month,
      rx_expiration_cust_week_of_year,
      rx_expiration_cust_month_num,
      rx_expiration_cust_month,
      rx_expiration_cust_quarter_of_year,
      rx_expiration_cust_quarter,
      rx_expiration_cust_year,
      rx_expiration_cust_day_of_week_index,
      rx_expiration_cust_week_begin_date,
      rx_expiration_cust_week_end_date,
      rx_expiration_cust_week_of_quarter,
      rx_expiration_cust_month_begin_date,
      rx_expiration_cust_month_end_date,
      rx_expiration_cust_weeks_in_month,
      rx_expiration_cust_quarter_begin_date,
      rx_expiration_cust_quarter_end_date,
      rx_expiration_cust_weeks_in_quarter,
      rx_expiration_cust_year_begin_date,
      rx_expiration_cust_year_end_date,
      rx_expiration_cust_weeks_in_year,
      rx_expiration_cust_leap_year_flag,
      rx_expiration_cust_day_of_quarter,
      rx_expiration_cust_day_of_year,
      rx_first_filled_cust_date,
      rx_first_filled_cust_calendar_date,
      rx_first_filled_cust_chain_id,
      rx_first_filled_cust_calendar_owner_chain_id,
      rx_first_filled_cust_yesno,
      rx_first_filled_cust_day_of_week,
      rx_first_filled_cust_day_of_month,
      rx_first_filled_cust_week_of_year,
      rx_first_filled_cust_month_num,
      rx_first_filled_cust_month,
      rx_first_filled_cust_quarter_of_year,
      rx_first_filled_cust_quarter,
      rx_first_filled_cust_year,
      rx_first_filled_cust_day_of_week_index,
      rx_first_filled_cust_week_begin_date,
      rx_first_filled_cust_week_end_date,
      rx_first_filled_cust_week_of_quarter,
      rx_first_filled_cust_month_begin_date,
      rx_first_filled_cust_month_end_date,
      rx_first_filled_cust_weeks_in_month,
      rx_first_filled_cust_quarter_begin_date,
      rx_first_filled_cust_quarter_end_date,
      rx_first_filled_cust_weeks_in_quarter,
      rx_first_filled_cust_year_begin_date,
      rx_first_filled_cust_year_end_date,
      rx_first_filled_cust_weeks_in_year,
      rx_first_filled_cust_leap_year_flag,
      rx_first_filled_cust_day_of_quarter,
      rx_first_filled_cust_day_of_year,
      rx_original_written_cust_date,
      rx_original_written_cust_calendar_date,
      rx_original_written_cust_chain_id,
      rx_original_written_cust_calendar_owner_chain_id,
      rx_original_written_cust_yesno,
      rx_original_written_cust_day_of_week,
      rx_original_written_cust_day_of_month,
      rx_original_written_cust_week_of_year,
      rx_original_written_cust_month_num,
      rx_original_written_cust_month,
      rx_original_written_cust_quarter_of_year,
      rx_original_written_cust_quarter,
      rx_original_written_cust_year,
      rx_original_written_cust_day_of_week_index,
      rx_original_written_cust_week_begin_date,
      rx_original_written_cust_week_end_date,
      rx_original_written_cust_week_of_quarter,
      rx_original_written_cust_month_begin_date,
      rx_original_written_cust_month_end_date,
      rx_original_written_cust_weeks_in_month,
      rx_original_written_cust_quarter_begin_date,
      rx_original_written_cust_quarter_end_date,
      rx_original_written_cust_weeks_in_quarter,
      rx_original_written_cust_year_begin_date,
      rx_original_written_cust_year_end_date,
      rx_original_written_cust_weeks_in_year,
      rx_original_written_cust_leap_year_flag,
      rx_original_written_cust_day_of_quarter,
      rx_original_written_cust_day_of_year,
      rx_start_cust_date,
      rx_start_cust_calendar_date,
      rx_start_cust_chain_id,
      rx_start_cust_calendar_owner_chain_id,
      rx_start_cust_yesno,
      rx_start_cust_day_of_week,
      rx_start_cust_day_of_month,
      rx_start_cust_week_of_year,
      rx_start_cust_month_num,
      rx_start_cust_month,
      rx_start_cust_quarter_of_year,
      rx_start_cust_quarter,
      rx_start_cust_year,
      rx_start_cust_day_of_week_index,
      rx_start_cust_week_begin_date,
      rx_start_cust_week_end_date,
      rx_start_cust_week_of_quarter,
      rx_start_cust_month_begin_date,
      rx_start_cust_month_end_date,
      rx_start_cust_weeks_in_month,
      rx_start_cust_quarter_begin_date,
      rx_start_cust_quarter_end_date,
      rx_start_cust_weeks_in_quarter,
      rx_start_cust_year_begin_date,
      rx_start_cust_year_end_date,
      rx_start_cust_weeks_in_year,
      rx_start_cust_leap_year_flag,
      rx_start_cust_day_of_quarter,
      rx_start_cust_day_of_year,
      rx_sync_script_enrollment_cust_date,
      rx_sync_script_enrollment_cust_calendar_date,
      rx_sync_script_enrollment_cust_chain_id,
      rx_sync_script_enrollment_cust_calendar_owner_chain_id,
      rx_sync_script_enrollment_cust_yesno,
      rx_sync_script_enrollment_cust_day_of_week,
      rx_sync_script_enrollment_cust_day_of_month,
      rx_sync_script_enrollment_cust_week_of_year,
      rx_sync_script_enrollment_cust_month_num,
      rx_sync_script_enrollment_cust_month,
      rx_sync_script_enrollment_cust_quarter_of_year,
      rx_sync_script_enrollment_cust_quarter,
      rx_sync_script_enrollment_cust_year,
      rx_sync_script_enrollment_cust_day_of_week_index,
      rx_sync_script_enrollment_cust_week_begin_date,
      rx_sync_script_enrollment_cust_week_end_date,
      rx_sync_script_enrollment_cust_week_of_quarter,
      rx_sync_script_enrollment_cust_month_begin_date,
      rx_sync_script_enrollment_cust_month_end_date,
      rx_sync_script_enrollment_cust_weeks_in_month,
      rx_sync_script_enrollment_cust_quarter_begin_date,
      rx_sync_script_enrollment_cust_quarter_end_date,
      rx_sync_script_enrollment_cust_weeks_in_quarter,
      rx_sync_script_enrollment_cust_year_begin_date,
      rx_sync_script_enrollment_cust_year_end_date,
      rx_sync_script_enrollment_cust_weeks_in_year,
      rx_sync_script_enrollment_cust_leap_year_flag,
      rx_sync_script_enrollment_cust_day_of_quarter,
      rx_sync_script_enrollment_cust_day_of_year,
      rx_source_create_cust_date,
      rx_source_create_cust_calendar_date,
      rx_source_create_cust_chain_id,
      rx_source_create_cust_calendar_owner_chain_id,
      rx_source_create_cust_yesno,
      rx_source_create_cust_day_of_week,
      rx_source_create_cust_day_of_month,
      rx_source_create_cust_week_of_year,
      rx_source_create_cust_month_num,
      rx_source_create_cust_month,
      rx_source_create_cust_quarter_of_year,
      rx_source_create_cust_quarter,
      rx_source_create_cust_year,
      rx_source_create_cust_day_of_week_index,
      rx_source_create_cust_week_begin_date,
      rx_source_create_cust_week_end_date,
      rx_source_create_cust_week_of_quarter,
      rx_source_create_cust_month_begin_date,
      rx_source_create_cust_month_end_date,
      rx_source_create_cust_weeks_in_month,
      rx_source_create_cust_quarter_begin_date,
      rx_source_create_cust_quarter_end_date,
      rx_source_create_cust_weeks_in_quarter,
      rx_source_create_cust_year_begin_date,
      rx_source_create_cust_year_end_date,
      rx_source_create_cust_weeks_in_year,
      rx_source_create_cust_leap_year_flag,
      rx_source_create_cust_day_of_quarter,
      rx_source_create_cust_day_of_year,
      rx_other_store_last_filled_cust_date,
      rx_other_store_last_filled_cust_calendar_date,
      rx_other_store_last_filled_cust_chain_id,
      rx_other_store_last_filled_cust_calendar_owner_chain_id,
      rx_other_store_last_filled_cust_yesno,
      rx_other_store_last_filled_cust_day_of_week,
      rx_other_store_last_filled_cust_day_of_month,
      rx_other_store_last_filled_cust_week_of_year,
      rx_other_store_last_filled_cust_month_num,
      rx_other_store_last_filled_cust_month,
      rx_other_store_last_filled_cust_quarter_of_year,
      rx_other_store_last_filled_cust_quarter,
      rx_other_store_last_filled_cust_year,
      rx_other_store_last_filled_cust_day_of_week_index,
      rx_other_store_last_filled_cust_week_begin_date,
      rx_other_store_last_filled_cust_week_end_date,
      rx_other_store_last_filled_cust_week_of_quarter,
      rx_other_store_last_filled_cust_month_begin_date,
      rx_other_store_last_filled_cust_month_end_date,
      rx_other_store_last_filled_cust_weeks_in_month,
      rx_other_store_last_filled_cust_quarter_begin_date,
      rx_other_store_last_filled_cust_quarter_end_date,
      rx_other_store_last_filled_cust_weeks_in_quarter,
      rx_other_store_last_filled_cust_year_begin_date,
      rx_other_store_last_filled_cust_year_end_date,
      rx_other_store_last_filled_cust_weeks_in_year,
      rx_other_store_last_filled_cust_leap_year_flag,
      rx_other_store_last_filled_cust_day_of_quarter,
      rx_other_store_last_filled_cust_day_of_year,
      rx_autofill_due_cust_date,
      rx_autofill_due_cust_calendar_date,
      rx_autofill_due_cust_chain_id,
      rx_autofill_due_cust_calendar_owner_chain_id,
      rx_autofill_due_cust_yesno,
      rx_autofill_due_cust_day_of_week,
      rx_autofill_due_cust_day_of_month,
      rx_autofill_due_cust_week_of_year,
      rx_autofill_due_cust_month_num,
      rx_autofill_due_cust_month,
      rx_autofill_due_cust_quarter_of_year,
      rx_autofill_due_cust_quarter,
      rx_autofill_due_cust_year,
      rx_autofill_due_cust_day_of_week_index,
      rx_autofill_due_cust_week_begin_date,
      rx_autofill_due_cust_week_end_date,
      rx_autofill_due_cust_week_of_quarter,
      rx_autofill_due_cust_month_begin_date,
      rx_autofill_due_cust_month_end_date,
      rx_autofill_due_cust_weeks_in_month,
      rx_autofill_due_cust_quarter_begin_date,
      rx_autofill_due_cust_quarter_end_date,
      rx_autofill_due_cust_weeks_in_quarter,
      rx_autofill_due_cust_year_begin_date,
      rx_autofill_due_cust_year_end_date,
      rx_autofill_due_cust_weeks_in_year,
      rx_autofill_due_cust_leap_year_flag,
      rx_autofill_due_cust_day_of_quarter,
      rx_autofill_due_cust_day_of_year,
      rx_written_cust_date,
      rx_written_cust_calendar_date,
      rx_written_cust_chain_id,
      rx_written_cust_calendar_owner_chain_id,
      rx_written_cust_yesno,
      rx_written_cust_day_of_week,
      rx_written_cust_day_of_month,
      rx_written_cust_week_of_year,
      rx_written_cust_month_num,
      rx_written_cust_month,
      rx_written_cust_quarter_of_year,
      rx_written_cust_quarter,
      rx_written_cust_year,
      rx_written_cust_day_of_week_index,
      rx_written_cust_week_begin_date,
      rx_written_cust_week_end_date,
      rx_written_cust_week_of_quarter,
      rx_written_cust_month_begin_date,
      rx_written_cust_month_end_date,
      rx_written_cust_weeks_in_month,
      rx_written_cust_quarter_begin_date,
      rx_written_cust_quarter_end_date,
      rx_written_cust_weeks_in_quarter,
      rx_written_cust_year_begin_date,
      rx_written_cust_year_end_date,
      rx_written_cust_weeks_in_year,
      rx_written_cust_leap_year_flag,
      rx_written_cust_day_of_quarter,
      rx_written_cust_day_of_year,
      rx_stop_cust_date,
      rx_stop_cust_calendar_date,
      rx_stop_cust_chain_id,
      rx_stop_cust_calendar_owner_chain_id,
      rx_stop_cust_yesno,
      rx_stop_cust_day_of_week,
      rx_stop_cust_day_of_month,
      rx_stop_cust_week_of_year,
      rx_stop_cust_month_num,
      rx_stop_cust_month,
      rx_stop_cust_quarter_of_year,
      rx_stop_cust_quarter,
      rx_stop_cust_year,
      rx_stop_cust_day_of_week_index,
      rx_stop_cust_week_begin_date,
      rx_stop_cust_week_end_date,
      rx_stop_cust_week_of_quarter,
      rx_stop_cust_month_begin_date,
      rx_stop_cust_month_end_date,
      rx_stop_cust_weeks_in_month,
      rx_stop_cust_quarter_begin_date,
      rx_stop_cust_quarter_end_date,
      rx_stop_cust_weeks_in_quarter,
      rx_stop_cust_year_begin_date,
      rx_stop_cust_year_end_date,
      rx_stop_cust_weeks_in_year,
      rx_stop_cust_leap_year_flag,
      rx_stop_cust_day_of_quarter,
      rx_stop_cust_day_of_year,
      rx_follow_up_cust_date,
      rx_follow_up_cust_calendar_date,
      rx_follow_up_cust_chain_id,
      rx_follow_up_cust_calendar_owner_chain_id,
      rx_follow_up_cust_yesno,
      rx_follow_up_cust_day_of_week,
      rx_follow_up_cust_day_of_month,
      rx_follow_up_cust_week_of_year,
      rx_follow_up_cust_month_num,
      rx_follow_up_cust_month,
      rx_follow_up_cust_quarter_of_year,
      rx_follow_up_cust_quarter,
      rx_follow_up_cust_year,
      rx_follow_up_cust_day_of_week_index,
      rx_follow_up_cust_week_begin_date,
      rx_follow_up_cust_week_end_date,
      rx_follow_up_cust_week_of_quarter,
      rx_follow_up_cust_month_begin_date,
      rx_follow_up_cust_month_end_date,
      rx_follow_up_cust_weeks_in_month,
      rx_follow_up_cust_quarter_begin_date,
      rx_follow_up_cust_quarter_end_date,
      rx_follow_up_cust_weeks_in_quarter,
      rx_follow_up_cust_year_begin_date,
      rx_follow_up_cust_year_end_date,
      rx_follow_up_cust_weeks_in_year,
      rx_follow_up_cust_leap_year_flag,
      rx_follow_up_cust_day_of_quarter,
      rx_follow_up_cust_day_of_year,
      rx_source_cust_date,
      rx_source_cust_calendar_date,
      rx_source_cust_chain_id,
      rx_source_cust_calendar_owner_chain_id,
      rx_source_cust_yesno,
      rx_source_cust_day_of_week,
      rx_source_cust_day_of_month,
      rx_source_cust_week_of_year,
      rx_source_cust_month_num,
      rx_source_cust_month,
      rx_source_cust_quarter_of_year,
      rx_source_cust_quarter,
      rx_source_cust_year,
      rx_source_cust_day_of_week_index,
      rx_source_cust_week_begin_date,
      rx_source_cust_week_end_date,
      rx_source_cust_week_of_quarter,
      rx_source_cust_month_begin_date,
      rx_source_cust_month_end_date,
      rx_source_cust_weeks_in_month,
      rx_source_cust_quarter_begin_date,
      rx_source_cust_quarter_end_date,
      rx_source_cust_weeks_in_quarter,
      rx_source_cust_year_begin_date,
      rx_source_cust_year_end_date,
      rx_source_cust_weeks_in_year,
      rx_source_cust_leap_year_flag,
      rx_source_cust_day_of_quarter,
      rx_source_cust_day_of_year,
      rx_alignment_start_cust_date,
      rx_alignment_start_cust_calendar_date,
      rx_alignment_start_cust_chain_id,
      rx_alignment_start_cust_calendar_owner_chain_id,
      rx_alignment_start_cust_yesno,
      rx_alignment_start_cust_day_of_week,
      rx_alignment_start_cust_day_of_month,
      rx_alignment_start_cust_week_of_year,
      rx_alignment_start_cust_month_num,
      rx_alignment_start_cust_month,
      rx_alignment_start_cust_quarter_of_year,
      rx_alignment_start_cust_quarter,
      rx_alignment_start_cust_year,
      rx_alignment_start_cust_day_of_week_index,
      rx_alignment_start_cust_week_begin_date,
      rx_alignment_start_cust_week_end_date,
      rx_alignment_start_cust_week_of_quarter,
      rx_alignment_start_cust_month_begin_date,
      rx_alignment_start_cust_month_end_date,
      rx_alignment_start_cust_weeks_in_month,
      rx_alignment_start_cust_quarter_begin_date,
      rx_alignment_start_cust_quarter_end_date,
      rx_alignment_start_cust_weeks_in_quarter,
      rx_alignment_start_cust_year_begin_date,
      rx_alignment_start_cust_year_end_date,
      rx_alignment_start_cust_weeks_in_year,
      rx_alignment_start_cust_leap_year_flag,
      rx_alignment_start_cust_day_of_quarter,
      rx_alignment_start_cust_day_of_year,
      rx_sync_script_refused_cust_date,
      rx_sync_script_refused_cust_calendar_date,
      rx_sync_script_refused_cust_chain_id,
      rx_sync_script_refused_cust_calendar_owner_chain_id,
      rx_sync_script_refused_cust_yesno,
      rx_sync_script_refused_cust_day_of_week,
      rx_sync_script_refused_cust_day_of_month,
      rx_sync_script_refused_cust_week_of_year,
      rx_sync_script_refused_cust_month_num,
      rx_sync_script_refused_cust_month,
      rx_sync_script_refused_cust_quarter_of_year,
      rx_sync_script_refused_cust_quarter,
      rx_sync_script_refused_cust_year,
      rx_sync_script_refused_cust_day_of_week_index,
      rx_sync_script_refused_cust_week_begin_date,
      rx_sync_script_refused_cust_week_end_date,
      rx_sync_script_refused_cust_week_of_quarter,
      rx_sync_script_refused_cust_month_begin_date,
      rx_sync_script_refused_cust_month_end_date,
      rx_sync_script_refused_cust_weeks_in_month,
      rx_sync_script_refused_cust_quarter_begin_date,
      rx_sync_script_refused_cust_quarter_end_date,
      rx_sync_script_refused_cust_weeks_in_quarter,
      rx_sync_script_refused_cust_year_begin_date,
      rx_sync_script_refused_cust_year_end_date,
      rx_sync_script_refused_cust_weeks_in_year,
      rx_sync_script_refused_cust_leap_year_flag,
      rx_sync_script_refused_cust_day_of_quarter,
      rx_sync_script_refused_cust_day_of_year
    ]
  }

  set: exploredx_eps_rx_looker_default_timeframes {
    fields: [
      rx_merged_to_date_time,
      rx_merged_to_date_date,
      rx_merged_to_date_week,
      rx_merged_to_date_month,
      rx_merged_to_date_month_num,
      rx_merged_to_date_year,
      rx_merged_to_date_quarter,
      rx_merged_to_date_quarter_of_year,
      rx_merged_to_date,
      rx_merged_to_date_hour_of_day,
      rx_merged_to_date_time_of_day,
      rx_merged_to_date_hour2,
      rx_merged_to_date_minute15,
      rx_merged_to_date_day_of_week,
      rx_merged_to_date_week_of_year,
      rx_merged_to_date_day_of_week_index,
      rx_merged_to_date_day_of_month,
      rx_autofill_enable_date_time,
      rx_autofill_enable_date_date,
      rx_autofill_enable_date_week,
      rx_autofill_enable_date_month,
      rx_autofill_enable_date_month_num,
      rx_autofill_enable_date_year,
      rx_autofill_enable_date_quarter,
      rx_autofill_enable_date_quarter_of_year,
      rx_autofill_enable_date,
      rx_autofill_enable_date_hour_of_day,
      rx_autofill_enable_date_time_of_day,
      rx_autofill_enable_date_hour2,
      rx_autofill_enable_date_minute15,
      rx_autofill_enable_date_day_of_week,
      rx_autofill_enable_date_week_of_year,
      rx_autofill_enable_date_day_of_week_index,
      rx_autofill_enable_date_day_of_month,
      rx_received_date_time,
      rx_received_date_date,
      rx_received_date_week,
      rx_received_date_month,
      rx_received_date_month_num,
      rx_received_date_year,
      rx_received_date_quarter,
      rx_received_date_quarter_of_year,
      rx_received_date,
      rx_received_date_hour_of_day,
      rx_received_date_time_of_day,
      rx_received_date_hour2,
      rx_received_date_minute15,
      rx_received_date_day_of_week,
      rx_received_date_week_of_year,
      rx_received_date_day_of_week_index,
      rx_received_date_day_of_month,
      rx_file_buy_date_time,
      rx_file_buy_date_date,
      rx_file_buy_date_week,
      rx_file_buy_date_month,
      rx_file_buy_date_month_num,
      rx_file_buy_date_year,
      rx_file_buy_date_quarter,
      rx_file_buy_date_quarter_of_year,
      rx_file_buy_date,
      rx_file_buy_date_hour_of_day,
      rx_file_buy_date_time_of_day,
      rx_file_buy_date_hour2,
      rx_file_buy_date_minute15,
      rx_file_buy_date_day_of_week,
      rx_file_buy_date_week_of_year,
      rx_file_buy_date_day_of_week_index,
      rx_file_buy_date_day_of_month,
      rx_last_refill_reminder_date_time,
      rx_last_refill_reminder_date_date,
      rx_last_refill_reminder_date_week,
      rx_last_refill_reminder_date_month,
      rx_last_refill_reminder_date_month_num,
      rx_last_refill_reminder_date_year,
      rx_last_refill_reminder_date_quarter,
      rx_last_refill_reminder_date_quarter_of_year,
      rx_last_refill_reminder_date,
      rx_last_refill_reminder_date_hour_of_day,
      rx_last_refill_reminder_date_time_of_day,
      rx_last_refill_reminder_date_hour2,
      rx_last_refill_reminder_date_minute15,
      rx_last_refill_reminder_date_day_of_week,
      rx_last_refill_reminder_date_week_of_year,
      rx_last_refill_reminder_date_day_of_week_index,
      rx_last_refill_reminder_date_day_of_month,
      rx_short_fill_sent_time,
      rx_short_fill_sent_date,
      rx_short_fill_sent_week,
      rx_short_fill_sent_month,
      rx_short_fill_sent_month_num,
      rx_short_fill_sent_year,
      rx_short_fill_sent_quarter,
      rx_short_fill_sent_quarter_of_year,
      rx_short_fill_sent,
      rx_short_fill_sent_hour_of_day,
      rx_short_fill_sent_time_of_day,
      rx_short_fill_sent_hour2,
      rx_short_fill_sent_minute15,
      rx_short_fill_sent_day_of_week,
      rx_short_fill_sent_week_of_year,
      rx_short_fill_sent_day_of_week_index,
      rx_short_fill_sent_day_of_month,
      rx_chain_first_filled_time,
      rx_chain_first_filled_date,
      rx_chain_first_filled_week,
      rx_chain_first_filled_month,
      rx_chain_first_filled_month_num,
      rx_chain_first_filled_year,
      rx_chain_first_filled_quarter,
      rx_chain_first_filled_quarter_of_year,
      rx_chain_first_filled,
      rx_chain_first_filled_hour_of_day,
      rx_chain_first_filled_time_of_day,
      rx_chain_first_filled_hour2,
      rx_chain_first_filled_minute15,
      rx_chain_first_filled_day_of_week,
      rx_chain_first_filled_week_of_year,
      rx_chain_first_filled_day_of_week_index,
      rx_chain_first_filled_day_of_month,
      rx_expiration_time,
      rx_expiration_date,
      rx_expiration_week,
      rx_expiration_month,
      rx_expiration_month_num,
      rx_expiration_year,
      rx_expiration_quarter,
      rx_expiration_quarter_of_year,
      rx_expiration,
      rx_expiration_hour_of_day,
      rx_expiration_time_of_day,
      rx_expiration_hour2,
      rx_expiration_minute15,
      rx_expiration_day_of_week,
      rx_expiration_week_of_year,
      rx_expiration_day_of_week_index,
      rx_expiration_day_of_month,
      rx_first_filled_time,
      rx_first_filled_date,
      rx_first_filled_week,
      rx_first_filled_month,
      rx_first_filled_month_num,
      rx_first_filled_year,
      rx_first_filled_quarter,
      rx_first_filled_quarter_of_year,
      rx_first_filled,
      rx_first_filled_hour_of_day,
      rx_first_filled_time_of_day,
      rx_first_filled_hour2,
      rx_first_filled_minute15,
      rx_first_filled_day_of_week,
      rx_first_filled_week_of_year,
      rx_first_filled_day_of_week_index,
      rx_first_filled_day_of_month,
      rx_original_written_time,
      rx_original_written_date,
      rx_original_written_week,
      rx_original_written_month,
      rx_original_written_month_num,
      rx_original_written_year,
      rx_original_written_quarter,
      rx_original_written_quarter_of_year,
      rx_original_written,
      rx_original_written_hour_of_day,
      rx_original_written_time_of_day,
      rx_original_written_hour2,
      rx_original_written_minute15,
      rx_original_written_day_of_week,
      rx_original_written_week_of_year,
      rx_original_written_day_of_week_index,
      rx_original_written_day_of_month,
      rx_start_time,
      rx_start_date,
      rx_start_week,
      rx_start_month,
      rx_start_month_num,
      rx_start_year,
      rx_start_quarter,
      rx_start_quarter_of_year,
      rx_start,
      rx_start_hour_of_day,
      rx_start_time_of_day,
      rx_start_hour2,
      rx_start_minute15,
      rx_start_day_of_week,
      rx_start_week_of_year,
      rx_start_day_of_week_index,
      rx_start_day_of_month,
      rx_sync_script_enrollment_time,
      rx_sync_script_enrollment_date,
      rx_sync_script_enrollment_week,
      rx_sync_script_enrollment_month,
      rx_sync_script_enrollment_month_num,
      rx_sync_script_enrollment_year,
      rx_sync_script_enrollment_quarter,
      rx_sync_script_enrollment_quarter_of_year,
      rx_sync_script_enrollment,
      rx_sync_script_enrollment_hour_of_day,
      rx_sync_script_enrollment_time_of_day,
      rx_sync_script_enrollment_hour2,
      rx_sync_script_enrollment_minute15,
      rx_sync_script_enrollment_day_of_week,
      rx_sync_script_enrollment_week_of_year,
      rx_sync_script_enrollment_day_of_week_index,
      rx_sync_script_enrollment_day_of_month,
      source_create_time,
      source_create_date,
      source_create_week,
      source_create_month,
      source_create_month_num,
      source_create_year,
      source_create_quarter,
      source_create_quarter_of_year,
      source_create,
      source_create_hour_of_day,
      source_create_time_of_day,
      source_create_hour2,
      source_create_minute15,
      source_create_day_of_week,
      source_create_week_of_year,
      source_create_day_of_week_index,
      source_create_day_of_month,
      rx_alignment_start_date_time,
      rx_alignment_start_date_date,
      rx_alignment_start_date_week,
      rx_alignment_start_date_day_of_week,
      rx_alignment_start_date_day_of_week_index,
      rx_alignment_start_date_month,
      rx_alignment_start_date_month_num,
      rx_alignment_start_date_month_name,
      rx_alignment_start_date_day_of_month,
      rx_alignment_start_date_quarter,
      rx_alignment_start_date_quarter_of_year,
      rx_alignment_start_date_year,
      rx_alignment_start_date_day_of_year,
      rx_alignment_start_date_week_of_year,
      rx_sync_script_refused_date_time,
      rx_sync_script_refused_date_date,
      rx_sync_script_refused_date_week,
      rx_sync_script_refused_date_day_of_week,
      rx_sync_script_refused_date_day_of_week_index,
      rx_sync_script_refused_date_month,
      rx_sync_script_refused_date_month_num,
      rx_sync_script_refused_date_month_name,
      rx_sync_script_refused_date_day_of_month,
      rx_sync_script_refused_date_quarter,
      rx_sync_script_refused_date_quarter_of_year,
      rx_sync_script_refused_date_year,
      rx_sync_script_refused_date_day_of_year,
      rx_sync_script_refused_date_week_of_year
    ]
  }
}

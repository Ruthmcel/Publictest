view: bi_demo_sales_rx_tx_transfer {
  label: "Pharmacy Transfer"
  #[ERXLPS-1961] - Added derived SQL logic to bypass EPS source system defect where multiple entries are created for same transfer.
  #Prescription transfer logic: Consider first created entry for each transfer status. Exclude NULL status is any valid transfer status exist for prescription transfer. Include NULL status if a prescription transfer has only NULL status.
  #Single Refill transfer logic: Consider all Single refills. We are not bypassing any EPS Source system defects. Single refill data will be shown as it is.
  #Primary key: No change in primary key. Derived logic is written to get the unique set of valid records. We can still use the existing PK (transfer_id)
  derived_table: {
    sql:
      select *
        from (
              select *
                     ,row_number() over(partition by chain_id, nhin_store_id, rx_id, transfer_status, transfer_single_refill_flag order by transfer_date asc) rnk
                     ,count(distinct nvl(transfer_status,-1)) over(partition by chain_id, nhin_store_id, rx_id, transfer_single_refill_flag) cnt
              from edw.f_transfer
              where rx_id is not null
              and chain_id in (select distinct chain_id from report_temp.bi_demo_chain_store_mapping  where {% condition bi_demo_store.bi_demo_nhin_store_id %} nhin_store_id_bi_demo_mapping {% endcondition %})
              and nhin_store_id in (select distinct nhin_store_id from report_temp.bi_demo_chain_store_mapping where {% condition bi_demo_store.bi_demo_nhin_store_id %} nhin_store_id_bi_demo_mapping {% endcondition %})
             )
        where (transfer_single_refill_flag = 'Y' --consider all single refill transfers
               or (transfer_single_refill_flag = 'N' -- prescription transfers
                  and (rnk = 1 --first created entry for each transfer status (null/incoming/outgoing/batch)
                       and (cnt = 1 --prescription transfer has only one status
                            or (cnt>1 and transfer_status is not null) ) --excluding nulls when multiple transfer status records exists
                      )
                  )
              ) ;;
  }

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${transfer_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg}  ;; #ERXLPS-1649
  }

  ################################################################# Foreign Key refresnces ############################################

  dimension: chain_id {
    type: number
    hidden: yes
    label: "Chain ID"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: transfer_id {
    type: number
    hidden: yes
    label: "Transfer ID"
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.TRANSFER_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: pharmacy_id {
    type: number
    hidden: yes
    label: "Pharmacy ID"
    description: "ID of the Pharmacy record from/to which this transfer occurred. Primary key of pharmacy record found or created when transfer record is created"
    sql: ${TABLE}.PHARMACY_ID ;;
  }

  dimension: rx_id {
    type: number
    hidden: yes
    label: "Rx ID"
    description: "ID of the prescription record related to a transfer record; Prescription ID of the transferred prescription at the local store. Populated by the system, using the prescription summary information in memory when a new transfer record is created"
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    label: "Rx Tx ID"
    description: "ID of the transaction record associated with this Transfer record.  Populated by the system either when an Auto transfer response record is processed or when a prescription is manually transfered into a store, using the ID of the transaction record created in the process"
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: note_id {
    type: number
    hidden: yes
    label: "Note ID"
    description: "ID of the Notes record for this Rx Transfer"
    sql: ${TABLE}.NOTE_ID ;;
  }

  dimension: store_user_id {
    type: number
    hidden: yes
    label: "Store User ID"
    description: "ID of the store user who is working on this Rx Transfer"
    sql: ${TABLE}.STORE_USER_ID ;;
  }

  #[ERXLPS-2599]
  dimension: transfer_reason_id {
    type: number
    hidden: yes
    label: "Transfer Reason ID"
    description: "Foreign key of TRANSFER_REASON table to transfer table"
    sql: ${TABLE}.TRANSFER_REASON_ID ;;
  }

  dimension: transfer_remaining_quantity {
    type: number
    hidden: yes
    label: "Transfer Remaining Quantity"
    description: "Number of remaining units/quantity of the drug for this transfer"
    sql: ${TABLE}.TRANSFER_REMAINING_QUANTITY ;;
    value_format: "#,##0.00"
  }

  dimension: transfer_type_reference {
    type: string
    label: "Transfer Type"
    hidden: yes
    description: "Type of transfer record"
    sql: ${TABLE}.TRANSFER_TYPE ;;
  }

  #[ERXLPS-1961]
  dimension: transfer_status_reference {
    type: string
    label: "Transfer Status"
    hidden: yes
    description: "Transfer status"
    sql: ${TABLE}.TRANSFER_STATUS ;;
  }

  dimension: transfer_single_refill_flag_reference {
    type: string
    label: "Transfer Single Refill"
    hidden:  yes
    description: "Yes/No flag indicating if a transfer record is for a single refill only and not the entire prescription (incoming transfers only). "
    sql: ${TABLE}.TRANSFER_SINGLE_REFILL_FLAG ;;
  }

  ######################################################################### dimensions #####################################################

  dimension: transfer_comments_deidentified {
    type: string
    label: "Transfer Comments*"
    description: "Comment regarding a transfer record. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.TRANSFER_COMMENTS) ;;
  }

  dimension: transfer_dea_number_deidentified {
    type: string
    label: "Transfer DEA Number*"
    description: "Drug Enforcement Agency number of pharmacy to which/from which the precription was transferred. Populated by the system when a transfer record is processed using. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.TRANSFER_DEA_NUMBER) ;;
  }

  dimension_group: transfer {
    type: time
    label: "Transfer*"
    description: "Date/time a prescription was transferred and a transfer record was created.  Populated by the system with the current date when a new transfer record is created. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
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
    sql: ${TABLE}.TRANSFER_DATE ;;
  }

  dimension: transfer_store_rph_name_deidentified {
    type: string
    label: "Transfer Pharmacy RPH Name*"
    description: "Name of the pharmacist on the local system responsible for transferring a prescription (requesting pharmacy). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.TRANSFER_STORE_RPH_NAME) ;;
  }

  dimension: transfer_store_user_initials {
    type: string
    label: "Transfer Pharmacy User Initials*"
    description: "Initials of the pharmacist on the local system responsible for transferring a prescription (requesting pharmacy). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_STORE_USER_INITIALS ;;
  }

  dimension: transfer_initiating_rph_initials {
    type: string
    label: "Transfer Initiating RPH Initials*"
    description: "Initials of the pharmacist responsible for initiating a transfer. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_INITIATING_RPH_INITIALS ;;
  }

  dimension: transfer_other_store_user_initials {
    type: string
    label: "Transfer Other Pharmacy User Initials*"
    description: "Initials of the pharmacist who received a transfer (receiving pharmacy). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_OTHER_STORE_USER_INITIALS ;;
  }

  dimension: transfer_other_store_rph_name_deidentified {
    type: string
    label: "Transfer Other Pharmacy RPH Name*"
    description: "Name of the pharmacist who received a transfer (receiving pharmacy). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.TRANSFER_OTHER_STORE_RPH_NAME) ;;
  }

  dimension: transfer_refills_authorized {
    type: string
    label: "Transfer Refills Authorized*"
    description: "Total number of refills authorized on the original prescription (incoming transfers only). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_REFILLS_AUTHORIZED ;;
  }

  dimension: transfer_refills_remaining {
    type: string
    label: "Transfer Refills Remaining*"
    description: "Refills remaining on the original prescription (incoming transfers only). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_REFILLS_REMAINING ;;
  }

  dimension: transfer_other_store_rx_number_deidentified {
    type: string
    label: "Transfer Other Pharmacy Rx Number*"
    description: "Other pharmacy prescription number; incoming transfers only. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    # sha2 by default uses 256 as the message digest size.
    sql: SHA2(${TABLE}.TRANSFER_OTHER_STORE_RX_NUMBER) ;;
    value_format: "####"
  }

  dimension: transfer_authentication_method {
    type: string
    label: "Transfer Authentication Method*"
    description: "Authentication method by which the transfer was performed. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_AUTHENTICATION_METHOD ;;
  }

  #[ERXLPS-1535]
  dimension: transfer_pharmacy_name {
    type: string
    label: "Transfer Other Pharmacy Name*"
    description: "Name of the Pharmacy record from/to which this transfer occurred. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(UPPER(${sales_rx_tx_transfer_pharmacy.pharmacy_name})) ;; #[ERXLPS-1961] Added upper function to display all Pharmacy names in UPPER.
  }

  dimension: transfer_pharmacy_address_line_1 {
    type: string
    label: "Transfer Other Pharmacy Address Line 1*"
    description: "Other Pharmacy Address Line 1. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_address.address_line_1}) ;;
  }

  dimension: transfer_pharmacy_address_line_2 {
    type: string
    label: "Transfer Other Pharmacy Address Line 2*"
    description: "Other Pharmacy Address Line 2. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_address.address_line_2}) ;;
  }

  dimension: transfer_pharmacy_address_city {
    type: string
    label: "Transfer Other Pharmacy Address City*"
    description: "Other Pharmacy Address City. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_address.address_city}) ;;
  }

  dimension: transfer_pharmacy_address_state {
    type: string
    label: "Transfer Other Pharmacy Address State*"
    description: "Other Pharmacy Address State. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_address.address_state}) ;;
  }

  dimension: transfer_pharmacy_address_postal_code {
    type: string
    label: "Transfer Other Pharmacy Address Postal Code*"
    description: "Other Pharmacy Address Postal Code. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_address.address_postal_code}) ;;
  }

  #[ERXLPS-1553] - Other Pharmacy Phone Number
  dimension: transfer_pharmacy_phone_number {
    type: string
    label: "Transfer Other Pharmacy Phone Number*"
    description: "Other Pharmacy Phone Number. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: SHA2(${sales_rx_tx_transfer_pharmacy_phone.phone_number}) ;;
  }

  ################################################################## Case when or Yes/No Fields ########################################

  dimension: transfer_sequence {
    type: string
    label: "Transfer Sequence*"
    description: "Value indicating if a transfer record is for a current transfer or previous transfers. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    #[ERXLPS-4640]
    sql: CASE WHEN ${TABLE}.TRANSFER_SEQUENCE = 0 THEN '0 - CURRENT TRANSFER'
              WHEN ${TABLE}.TRANSFER_SEQUENCE = 1 THEN '1 - PRIOR TRANSFER 1'
              WHEN ${TABLE}.TRANSFER_SEQUENCE = 2 THEN '2 - PRIOR TRANSFER 2'
              WHEN ${TABLE}.TRANSFER_SEQUENCE IS NULL THEN 'NOT SPECIFIED'
              ELSE TO_CHAR(${TABLE}.TRANSFER_SEQUENCE)
         END ;;
    suggestions: ["0 - CURRENT TRANSFER", "1 - PRIOR TRANSFER 1", "2 - PRIOR TRANSFER 2", "NOT SPECIFIED"]
  }

  dimension: transfer_type {
    type: string
    label: "Transfer Type*"
    description: "Type of transfer record. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    #[ERXLPS-4640]
    sql: CASE WHEN ${TABLE}.TRANSFER_TYPE = 'A' THEN 'A - AUTO TRANSFER'
              WHEN ${TABLE}.TRANSFER_TYPE = 'S' THEN 'S - MANUAL PHARMACY TRANSFER'
              WHEN ${TABLE}.TRANSFER_TYPE = 'B' THEN 'B - BATCH TRANSFER PRESCRIPTION'
              WHEN ${TABLE}.TRANSFER_TYPE IS NULL THEN 'NOT SPECIFIED'
              ELSE ${TABLE}.TRANSFER_TYPE
         END ;;
    suggestions: ["A - AUTO TRANSFER", "S - MANUAL PHARMACY TRANSFER", "B - BATCH TRANSFER PRESCRIPTION", "NOT SPECIFIED"]
  }

  dimension: transfer_status {
    type: string
    label: "Transfer Status*"
    description: "Transfer status. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    #[ERXLPS-4640]
    sql: CASE WHEN ${TABLE}.TRANSFER_STATUS = 0 THEN '0 - OUTGOING'
              WHEN ${TABLE}.TRANSFER_STATUS = 1 THEN '1 - INCOMING'
              WHEN ${TABLE}.TRANSFER_STATUS = 2 THEN '2 - HISTORY'
              WHEN ${TABLE}.TRANSFER_STATUS = 3 THEN '3 - BATCH TRANSFER PRESCRIPTION'
              WHEN ${TABLE}.TRANSFER_STATUS IS NULL THEN 'UNKNOWN'
              ELSE TO_CHAR(${TABLE}.TRANSFER_STATUS)
         END ;;
    suggestions: ["0 - OUTGOING", "1 - INCOMING", "2 - HISTORY", "3 - BATCH TRANSFER PRESCRIPTION", "UNKNOWN"]
  }

  dimension: transfer_single_refill_flag {
    type: yesno
    label: "Transfer Single Refill*"
    description: "Yes/No flag indicating if a transfer record is for a single refill only and not the entire prescription (incoming transfers only). Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: ${TABLE}.TRANSFER_SINGLE_REFILL_FLAG = 'Y' ;;
  }

  #[ERXLPS-2599] - Logic update to use Transfer Reason table reason description.
  dimension: transfer_reason {
    type: string
    label: "Transfer Reason*"
    description: "The reason the transfer occurred. Use this dimension with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    #[ERXLPS-2599] - Updated logic. If Transfer reason do not available in F_TRANSFER fall back to D_STORE_TRANSFER_REASON table.
    sql: CASE WHEN ${TABLE}.TRANSFER_REASON = 'O' THEN 'OUT OF STOCK'
              WHEN ${TABLE}.TRANSFER_REASON = 'R' THEN 'PRICE'
              WHEN ${TABLE}.TRANSFER_REASON = 'B' THEN 'BATCH TRANSFER PRESCRIPTIONS'
              WHEN ${store_transfer_reason.transfer_reason_id} IS NOT NULL THEN ${store_transfer_reason.transfer_reason_description}
              WHEN ${TABLE}.TRANSFER_ID IS NOT NULL AND ${TABLE}.TRANSFER_REASON IS NULL THEN 'NOT SPECIFIED'
              ELSE ${TABLE}.TRANSFER_REASON
         END ;;
    suggestions: ["OUT OF STOCK", "PRICE", "BATCH TRANSFER PRESCRIPTIONS", "NOT SPECIFIED"]
  }

  ################################################################################# Measures ##############################################################################
  measure: count_transfer {
    type: count_distinct
    label: "Total Transfers*"
    description: "Total number of transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN ${transfer_id} END ;;
    value_format: "#,##0"
  }

  measure: count_outgoing {
    type: sum
    label: "Total Outgoing Transfers*"
    description: "Total number of outgoing transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_status_reference} = '0' THEN 1 ELSE 0 END) END ;; #[ERXLPS-1961]
    value_format: "#,##0"
  }

  measure: count_incoming {
    type: sum
    label: "Total Incoming Transfers*"
    description: "Total number of incoming transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_status_reference} = '1' THEN 1 ELSE 0 END) END ;; #[ERXLPS-1961]
    value_format: "#,##0"
  }

  measure: count_auto_transfer {
    type: sum
    label: "Total Auto Transfers*"
    description: "Total number of auto transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_type_reference} ='A' THEN 1 ELSE 0 END) END ;;
    value_format: "#,##0"
  }

  measure: count_manual_transfer {
    type: sum
    label: "Total Manual Pharmacy Transfers*"
    description: "Total number of manual transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_type_reference} ='S' THEN 1 ELSE 0 END) END ;;
    value_format: "#,##0"
  }

  #[ERXLPS-1961] - New measures added.
  measure: count_outgoing_single_refill {
    type: sum
    label: "Total Outgoing Single Refill Transfers*"
    description: "Total number of outgoing single refill transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y')
              THEN (CASE WHEN ${transfer_status_reference} = '0' AND ${transfer_single_refill_flag_reference} = 'Y' THEN 1 ELSE 0 END)
         END ;;
    value_format: "#,##0"
  }

  measure: count_outgoing_all_refills {
    type: sum
    label: "Total Outgoing Prescription Transfers - All Refills*"
    description: "Total number of outgoing prescription transfers (all refills). Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y')
              THEN (CASE WHEN ${transfer_status_reference} = '0' AND ${transfer_single_refill_flag_reference} = 'N' THEN 1 ELSE 0 END)
         END ;;
    value_format: "#,##0"
  }

  measure: count_incoming_single_refill {
    type: sum
    label: "Total Incoming Single Refill Transfers*"
    description: "Total number of incoming single refill transfers. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y')
              THEN (CASE WHEN ${transfer_status_reference} = '1' AND ${transfer_single_refill_flag_reference} = 'Y' THEN 1 ELSE 0 END)
         END ;;
    value_format: "#,##0"
  }

  measure: count_incoming_all_refills {
    type: sum
    label: "Total Incoming Prescription Transfers - All Refills*"
    description: "Total number of incoming prescription transfers (all refills). Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y')
              THEN (CASE WHEN ${transfer_status_reference} = '1' AND ${transfer_single_refill_flag_reference} = 'N' THEN 1 ELSE 0 END)
         END ;;
    value_format: "#,##0"
  }

  measure: sum_transfer_outgoing_remaining_quantity {
    type: sum
    label: "Total Outgoing Transfer Remaining Quantity*"
    description: "Total number of outgoing remaining units/quantity of the drug for this transfer. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_status_reference} = '0' THEN ${transfer_remaining_quantity} END) END ;;
    value_format: "#,##0.00"
  }

  measure: sum_transfer_incoming_remaining_quantity {
    type: sum
    label: "Total Incoming Transfer Remaining Quantity*"
    description: "Total number of incoming remaining units/quantity of the drug for this transfer. Use this measure with DATE TO USE as FILLED. Increase REPORT PERIOD duration to broader range (Ex: 1 year or 2 year) and use the TRANSFER DATE as a Date Range filter on the report to include all the possible transactions."
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg}= 'Y') THEN (CASE WHEN ${transfer_status_reference} = '1' THEN ${transfer_remaining_quantity} END) END ;;
    value_format: "#,##0.00"
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_transfer_4_10_candidate_list {
    fields: [
      transfer_comments_deidentified,
      transfer_dea_number_deidentified,
      transfer_store_rph_name_deidentified,
      transfer_store_user_initials,
      transfer_initiating_rph_initials,
      transfer_other_store_user_initials,
      transfer_other_store_rph_name_deidentified,
      transfer_refills_authorized,
      transfer_refills_remaining,
      transfer_other_store_rx_number_deidentified,
      transfer_authentication_method,
      transfer_sequence,
      transfer_type,
      transfer_status,
      transfer_single_refill_flag,
      transfer_reason,
      transfer,
      transfer_time,
      transfer_date,
      transfer_week,
      transfer_month,
      transfer_month_num,
      transfer_year,
      transfer_quarter,
      transfer_quarter_of_year,
      transfer_hour_of_day,
      transfer_time_of_day,
      transfer_hour2,
      transfer_minute15,
      transfer_day_of_week,
      transfer_day_of_month,
      transfer_week_of_year,
      transfer_day_of_week_index,
      #sum_transfer_remaining_quantity, #[ERXLPS-1961]
      count_transfer,
      count_outgoing,
      count_incoming,
      count_auto_transfer,
      count_manual_transfer
    ]
  }
}

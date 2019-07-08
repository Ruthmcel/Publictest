view: store_transfer {
  label: "Pharmacy Transfer"
  sql_table_name: EDW.F_TRANSFER ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${transfer_id} ;; #ERXLPS-1649
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

  ######################################################################### dimensions #####################################################

  dimension: transfer_comments {
    type: string
    label: "Transfer Comments"
    description: "Comment regarding a transfer record"
    sql: ${TABLE}.TRANSFER_COMMENTS ;;
  }

  dimension: transfer_dea_number {
    type: string
    label: "Transfer DEA Number"
    description: "Drug Enforcement Agency number of pharmacy to which/from which the precription was transferred. Populated by the system when a transfer record is processed using"
    sql: ${TABLE}.TRANSFER_DEA_NUMBER ;;
  }

  dimension_group: transfer {
    type: time
    label: "Transfer"
    description: "Date/time a prescription was transferred and a transfer record was created.  Populated by the system with the current date when a new transfer record is created"
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

  dimension: transfer_store_rph_name {
    type: string
    label: "Transfer Pharmacy RPH Name"
    description: "Name of the pharmacist on the local system responsible for transferring a prescription (requesting pharmacy). Populated by the system using the user information in memory when a new transfer record is created"
    sql: ${TABLE}.TRANSFER_STORE_RPH_NAME ;;
  }

  dimension: transfer_store_user_initials {
    type: string
    label: "Transfer Pharmacy User Initials"
    description: "Initials of the pharmacist on the local system responsible for transferring a prescription (requesting pharmacy). Populated by the system using the user information in memory when a new transfer record is created"
    sql: ${TABLE}.TRANSFER_STORE_USER_INITIALS ;;
  }

  dimension: transfer_initiating_rph_initials {
    type: string
    label: "Transfer Initiating RPH Initials"
    description: "Initials of the pharmacist responsible for initiating a transfer. Populated by the system using the user information in memory when a new transfer record is created"
    sql: ${TABLE}.TRANSFER_INITIATING_RPH_INITIALS ;;
  }

  dimension: transfer_other_store_user_initials {
    type: string
    label: "Transfer Other Pharmacy User Initials"
    description: "Initials of the pharmacist who received a transfer (receiving pharmacy). Populated by the system using the user information in memory when a transfer record is received"
    sql: ${TABLE}.TRANSFER_OTHER_STORE_USER_INITIALS ;;
  }

  dimension: transfer_other_store_rph_name {
    type: string
    label: "Transfer Other Pharmacy RPH Name"
    description: "Name of the pharmacist who received a transfer (receiving pharmacy). Populated by the system using the user information in memory when a transfer record is received"
    sql: ${TABLE}.TRANSFER_OTHER_STORE_RPH_NAME ;;
  }

  dimension: transfer_refills_authorized {
    type: string
    label: "Transfer Refills Authorized"
    description: "Total number of refills authorized on the original prescription (incoming transfers only)"
    sql: ${TABLE}.TRANSFER_REFILLS_AUTHORIZED ;;
  }

  dimension: transfer_refills_remaining {
    type: string
    label: "Transfer Refills Remaining"
    description: "Refills remaining on the original prescription (incoming transfers only)"
    sql: ${TABLE}.TRANSFER_REFILLS_REMAINING ;;
  }

  dimension: transfer_other_store_rx_number {
    type: number
    label: "Transfer Other Pharmacy Rx Number"
    description: "Other pharmacy prescription number; incoming transfers only"
    sql: ${TABLE}.TRANSFER_OTHER_STORE_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: transfer_authentication_method {
    type: string
    label: "Transfer Authentication Method"
    description: "Authentication method by which the transfer was performed"
    sql: ${TABLE}.TRANSFER_AUTHENTICATION_METHOD ;;
  }

  ################################################################## Case when or Yes/No Fields ########################################

  dimension: transfer_sequence {
    type: string
    label: "Transfer Sequence"
    description: "Value indicating if a transfer record is for a current transfer or previous transfers"

    case: {
      when: {
        sql: ${TABLE}.TRANSFER_SEQUENCE = '0' ;;
        label: "CURRENT TRANSFER"
      }

      when: {
        sql: ${TABLE}.TRANSFER_SEQUENCE = '1' ;;
        label: "PRIOR TRANSFER 1"
      }

      when: {
        sql: ${TABLE}.TRANSFER_SEQUENCE = '2' ;;
        label: "PRIOR TRANSFER 2"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: transfer_type {
    type: string
    label: "Transfer Type"
    description: "Type of transfer record"

    case: {
      when: {
        sql: ${TABLE}.TRANSFER_TYPE = 'A' ;;
        label: "AUTO TRANSFER"
      }

      when: {
        sql: ${TABLE}.TRANSFER_TYPE = 'S' ;;
        label: "MANUAL PHARMACY TRANSFER"
      }

      when: {
        sql: ${TABLE}.TRANSFER_TYPE = 'B' ;;
        label: "BATCH TRANSFER PRESCRIPTION"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: transfer_status {
    type: string
    label: "Transfer Status"
    description: "Transfer status"

    case: {
      when: {
        sql: ${TABLE}.TRANSFER_STATUS = '0' ;;
        label: "OUTGOING"
      }

      when: {
        sql: ${TABLE}.TRANSFER_STATUS = '1' ;;
        label: "INCOMING"
      }

      when: {
        sql: ${TABLE}.TRANSFER_STATUS = '2' ;;
        label: "HISTORY"
      }

      when: {
        sql: ${TABLE}.TRANSFER_STATUS = '3' ;;
        label: "BATCH TRANSFER PRESCRIPTION"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: transfer_single_refill_flag {
    type: yesno
    label: "Transfer Single Refill"
    description: "Yes/No flag indicating if a transfer record is for a single refill only and not the entire prescription (incoming transfers only). "
    sql: ${TABLE}.TRANSFER_SINGLE_REFILL_FLAG = 'Y' ;;
  }

  dimension: transfer_reason {
    type: string
    label: "Transfer Reason"
    description: "The reason the transfer occurred"

    case: {
      when: {
        sql: ${TABLE}.TRANSFER_REASON = 'O' ;;
        label: "OUT OF STOCK"
      }

      when: {
        sql: ${TABLE}.TRANSFER_REASON = 'P' ;;
        label: "PRICE"
      }

      when: {
        sql: ${TABLE}.TRANSFER_REASON = 'B' ;;
        label: "BATCH TRANSFER PRESCRIPTION"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_transfer_4_10_candidate_list {
    fields: [
      transfer_comments,
      transfer_dea_number,
      transfer_store_rph_name,
      transfer_store_user_initials,
      transfer_initiating_rph_initials,
      transfer_other_store_user_initials,
      transfer_other_store_rph_name,
      transfer_refills_authorized,
      transfer_refills_remaining,
      transfer_other_store_rx_number,
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
      transfer_day_of_week_index
    ]
  }
}

view: store_transfer_request_queue {
  label: "Pharmacy Transfer Request Queue"
  sql_table_name: EDW.F_TRANSFER_REQUEST_QUEUE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${transfer_request_queue_id} ;; #ERXLPS-1649
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

  dimension: transfer_request_queue_id {
    label: "Transfer Request Queue ID"
    hidden: yes
    type: number
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.TRANSFER_REQUEST_QUEUE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    hidden: yes
    type: number
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: transfer_request_receiving_rx_summary_id {
    label: "Transfer Request Receiving Rx Summary ID"
    hidden: yes
    type: number
    description: "Foreign key to the RX_SUMMARY.ID that is created after a successful autotransfer that has been initiated from a received transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_RECEIVING_RX_SUMMARY_ID ;;
    value_format: "####"
  }

  dimension: rx_com_id {
    label: "Rx Com ID"
    hidden: yes
    type: number
    description: "Rx.com ID of the patient for the Rx transfer request"
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: transfer_request_prescribed_quantity {
    label: "Transfer Request Prescribed Quantity"
    type: number
    hidden: yes
    description: "Prescribed quantity of the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_PRESCRIBED_QUANTITY ;;
    value_format: "#,##0.00"
  }

  dimension: transfer_request_quantity_remaining {
    label: "Transfer Request Quantity Remaining"
    type: number
    hidden: yes
    description: "Quantity remaining in the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_QUANTITY_REMAINING ;;
    value_format: "#,##0.00"
  }

  ################################################################################## dimensions #############################################

  dimension: transfer_request_sending_rx_number {
    label: "Transfer Request Sending Rx Number"
    type: number
    description: "The sending pharmacy's Rx number for the autotransfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: transfer_request_sending_nhin_store_id {
    label: "Transfer Request Sending Nhin Pharmacy ID"
    type: number
    description: "NHIN ID of the pharmacy sending the transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_NHIN_STORE_ID ;;
    value_format: "####"
  }

  dimension: transfer_request_sending_store_number {
    label: "Transfer Request Sending Pharmacy Number"
    type: string
    description: "Pharmacy number of the sending pharmacy. This is the chain's internal pharmacy number, not the NHIN ID.  The sending_pharmacy_number is captured so that EPS can show the chain's pharmacy number on the Transfer Request Queue in EPS"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_STORE_NUMBER ;;
  }

  dimension: transfer_request_sending_eps_user_first_name {
    label: "Transfer Request Sending Eps User First Name"
    type: string
    description: "First name of the user sending the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_EPS_USER_FIRST_NAME ;;
  }

  dimension: transfer_request_sending_eps_user_last_name {
    label: "Transfer Request Sending Eps User Last Name"
    type: string
    description: "Last name of the user sending the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_EPS_USER_LAST_NAME ;;
  }

  dimension: transfer_request_sending_eps_user_employee_number {
    label: "Transfer Request Sending Eps User Employee Number"
    type: string
    description: "Employee number of the user sending the transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_SENDING_EPS_USER_EMPLOYEE_NUMBER ;;
  }

  dimension: transfer_request_receiving_nhin_store_id {
    label: "Transfer Request Receiving Nhin Pharmacy ID"
    type: number
    description: "NHIN ID of the pharmacy receiving the request"
    sql: ${TABLE}.TRANSFER_REQUEST_RECEIVING_NHIN_STORE_ID ;;
    value_format: "####"
  }

  dimension: transfer_request_patient_first_name {
    label: "Transfer Request Patient First Name"
    type: string
    description: "First name of the patient for the Rx transfer request. "
    sql: ${TABLE}.TRANSFER_REQUEST_PATIENT_FIRST_NAME ;;
  }

  dimension: transfer_request_patient_last_name {
    label: "Transfer Request Patient Last Name"
    type: string
    description: "Last name of the patient for the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_PATIENT_LAST_NAME ;;
  }

  dimension: transfer_request_drug_name {
    label: "Transfer Request Drug Name"
    type: string
    description: "Drug name contained in the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_DRUG_NAME ;;
  }

  dimension: transfer_request_refills_remaining {
    label: "Transfer Request Refills Remaining"
    type: string
    description: "Refills remaining contained in the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_REFILLS_REMAINING ;;
  }

  dimension: transfer_request_prescriber_first_name {
    label: "Transfer Request Prescriber First Name"
    type: string
    description: "Prescriber first name contained in the Rx transfer request. "
    sql: ${TABLE}.TRANSFER_REQUEST_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: transfer_request_prescriber_last_name {
    label: "Transfer Request Prescriber Last Name"
    type: string
    description: "Prescriber last name contained in the Rx transfer request. "
    sql: ${TABLE}.TRANSFER_REQUEST_PRESCRIBER_LAST_NAME ;;
  }

  dimension_group: transfer_request_last_filled {
    label: "Transfer Request Last Filled"
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
    description: "Last filled date/time contained in the Rx transfer request. "
    sql: ${TABLE}.TRANSFER_REQUEST_LAST_FILLED_DATE ;;
  }

  dimension_group: transfer_request_requested_fill {
    label: "Transfer Request Requested Fill"
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
    description: "Requested fill date/time captured when the Rx transfer request is created"
    sql: ${TABLE}.TRANSFER_REQUEST_REQUESTED_FILL_DATE ;;
  }

  dimension: transfer_request_status_code {
    label: "Transfer Request Status Code"
    type: string
    description: "Status code of the Rx transfer request"
    sql: ${TABLE}.TRANSFER_REQUEST_STATUS_CODE ;;

    case: {
      when: {
        sql: ${TABLE}.TRANSFER_REQUEST_STATUS_CODE = '1' ;;
        label: "SENT"
      }

      when: {
        sql: ${TABLE}.TRANSFER_REQUEST_STATUS_CODE = '2' ;;
        label: "PENDING"
      }

      when: {
        sql: ${TABLE}.TRANSFER_REQUEST_STATUS_CODE = '3' ;;
        label: "COMPLETED"
      }

      when: {
        sql: ${TABLE}.TRANSFER_REQUEST_STATUS_CODE = '4' ;;
        label: "DEACTIVATED"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: transfer_request_note {
    label: "Transfer Request Note"
    type: string
    description: "Note that is captured when an Rx transfer request is sent. "
    sql: ${TABLE}.TRANSFER_REQUEST_NOTE ;;
  }

  ################################################################################# Sets###################################################################################

  set: explore_rx_store_transfer_request_queue_4_10_candidate_list {
    fields: [
      transfer_request_sending_rx_number,
      transfer_request_sending_nhin_store_id,
      transfer_request_sending_store_number,
      transfer_request_sending_eps_user_first_name,
      transfer_request_sending_eps_user_last_name,
      transfer_request_sending_eps_user_employee_number,
      transfer_request_receiving_nhin_store_id,
      transfer_request_patient_first_name,
      transfer_request_patient_last_name,
      transfer_request_drug_name,
      transfer_request_refills_remaining,
      transfer_request_prescriber_first_name,
      transfer_request_prescriber_last_name,
      transfer_request_status_code,
      transfer_request_note,
      transfer_request_last_filled,
      transfer_request_last_filled_time,
      transfer_request_last_filled_date,
      transfer_request_last_filled_week,
      transfer_request_last_filled_month,
      transfer_request_last_filled_month_num,
      transfer_request_last_filled_year,
      transfer_request_last_filled_quarter,
      transfer_request_last_filled_quarter_of_year,
      transfer_request_last_filled_hour_of_day,
      transfer_request_last_filled_time_of_day,
      transfer_request_last_filled_hour2,
      transfer_request_last_filled_minute15,
      transfer_request_last_filled_day_of_week,
      transfer_request_last_filled_day_of_month,
      transfer_request_last_filled_week_of_year,
      transfer_request_last_filled_day_of_week_index,
      transfer_request_requested_fill,
      transfer_request_requested_fill_time,
      transfer_request_requested_fill_date,
      transfer_request_requested_fill_week,
      transfer_request_requested_fill_month,
      transfer_request_requested_fill_month_num,
      transfer_request_requested_fill_year,
      transfer_request_requested_fill_quarter,
      transfer_request_requested_fill_quarter_of_year,
      transfer_request_requested_fill_hour_of_day,
      transfer_request_requested_fill_time_of_day,
      transfer_request_requested_fill_hour2,
      transfer_request_requested_fill_minute15,
      transfer_request_requested_fill_day_of_week,
      transfer_request_requested_fill_day_of_month,
      transfer_request_requested_fill_week_of_year,
      transfer_request_requested_fill_day_of_week_index
    ]
  }
}

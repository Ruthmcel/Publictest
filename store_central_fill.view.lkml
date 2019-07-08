#[ERXDWPS-6571] - Exposed Central Fill table internal IDs. central_fill_id - PK of Central Fill table. check_in_user_id - Exposed to perform merge with User explore.
view: store_central_fill {
  label: "Central Fill - Store"
  sql_table_name: EDW.F_CENTRAL_FILL ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${central_fill_id} ;; #ERXLPS-1649
  }

  ################################################################# Foreign Key refresnces ############################################

  dimension: chain_id {
    label: "Chain Id"
    type: number
    hidden: yes
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    type: number
    hidden: yes
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: central_fill_id {
    label: "Central Fill ID"
    type: number
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.CENTRAL_FILL_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    hidden: yes
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: check_in_user_id {
    label: "Check In User ID"
    type: number
    description: "ID of the user responsible for checking in a central fill record. Populated by the system using the user information in memory when a central fill record is checked into the central fill queue"
    sql: ${TABLE}.CHECK_IN_USER_ID ;;
  }

  dimension: central_fill_facility_id {
    label: "Central Fill Facility Id"
    type: number
    hidden: yes
    description: "ID of the central fill facility responsible for processing a prescription. Populated by the system when processing a Status Update response"
    sql: ${TABLE}.CENTRAL_FILL_FACILITY_ID ;;
  }

  dimension: package_information_id {
    label: "Package Information Id"
    type: number
    hidden: yes
    description: "ID of the associated Package_Info record. Populated by the system when processing a Staus Update response"
    sql: ${TABLE}.PACKAGE_INFORMATION_ID ;;
  }

  dimension: patient_id {
    label: "Patient Id"
    type: number
    hidden: yes
    description: "ID of the patient record associated with a central fill record. Populated by the system using the patient information in memory when a central fill record is created"
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: responsible_party_patient_id {
    label: "Responsible Party Patient Id"
    type: number
    hidden: yes
    description: "ID of the responsible party record associated with a central fill record. Populated by the system using the responsible party information in memory when a central fill record is created"
    sql: ${TABLE}.RESPONSIBLE_PARTY_PATIENT_ID ;;
  }

  ##################################################################### Dimensions ###################################################

  dimension: central_fill_number {
    label: "Central Fill Number"
    type: number
    description: "Unique ID number identifying a central fill record within the central fill queue. System-generated when a new central fill record is added. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_NUMBER ;;
    value_format: "######"
  }

  dimension_group: central_fill_pick_up {
    label: "Central Fill Pick Up"
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
    description: "Date and time a central fill prescription is scheduled to be picked up by the patient. Calculated by the system when a central fill record is added or updated. User may modify the system calculated value. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_PICK_UP_DATE ;;
  }

  dimension_group: central_fill_check_in {
    label: "Central Fill Check In"
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
    description: "Date and time a central fill record was checked in to the central fill queue. Populated by the system with current system date and time when a central fill record is checked in. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_CHECK_IN_DATE ;;
  }

  dimension: central_fill_check_in_user_initials {
    label: "Central Fill Check In User Initials"
    type: string
    description: "Initials of user who checked in to the central fill queue.  Populated by the system with the user who performs the check in function. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_CHECK_IN_USER_INITIALS ;;
  }

  dimension: central_fill_check_in_user_initials_deidentified {
    label: "Central Fill Check In User Initials"
    type: string
    description: "Initials of user who checked in to the central fill queue.  Populated by the system with the user who performs the check in function. EPS Table: CENTRAL_FILL"
    sql: SHA2(${TABLE}.CENTRAL_FILL_CHECK_IN_USER_INITIALS) ;;
  }

  dimension: central_fill_status_reference {
    label: "Central Fill Status"
    description: "Status of a central fill record in the central fill queue. Updated by the system using information received from the central fill facility. EPS Table: CENTRAL_FILL"
    type: string
    hidden: yes
    sql: ${TABLE}.CENTRAL_FILL_STATUS ;;
  }

  dimension: central_fill_status {
    label: "Central Fill Status"
    type: string
    description: "Status of a central fill record in the central fill queue. Updated by the system using information received from the central fill facility. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_ID IS NULL THEN 'N/A'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '0'  THEN '0 - PENDING'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '1'  THEN '1 - SENT TO FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '2'  THEN '2 - IN PROGRESS AT FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '3'  THEN '3 - PROCESSED BY FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '4'  THEN '4 - CANCELLED BY PHARMACY'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '5'  THEN '5 - CANCELLED BY DISPENSING SYSTEM'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '6'  THEN '6 - CANCELLED BY FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '7'  THEN '7 - MISSING RX REPORTED'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '8'  THEN '8 - SHIPPED BY FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '9'  THEN '9 - RECEIVED FROM FULFILLMENT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '10' THEN '10 - COMPLETE'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '11' THEN '11 - DISPENSING SYSTEM REJECT'
              WHEN ${TABLE}.CENTRAL_FILL_STATUS = '12' THEN '12 - FULFILLMENT SUSPENDED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["NULL - UNKNOWN",
                  "0 - PENDING",
                  "1 - SENT TO FULFILLMENT",
                  "2 - IN PROGRESS AT FULFILLMENT",
                  "3 - PROCESSED BY FULFILLMENT",
                  "4 - CANCELLED BY PHARMACY",
                  "5 - CANCELLED BY DISPENSING SYSTEM",
                  "6 - CANCELLED BY FULFILLMENT",
                  "7 - MISSING RX REPORTED",
                  "8 - SHIPPED BY FULFILLMENT",
                  "9 - RECEIVED FROM FULFILLMENT",
                  "10 - COMPLETE",
                  "11 - DISPENSING SYSTEM REJECT",
                  "12 - FULFILLMENT SUSPENDED"]
    suggest_persist_for: "24 hours"
    drill_fields: [central_fill_status_reference]
  }

  dimension_group: central_fill_status_updated {
    label: "Central Fill Status Updated"
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
    description: "Date and time a status update was last received from the central fill facility. Updated by the system with the current system date and time when a status update is received from the central fill facility. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_STATUS_DATE ;;
  }

  dimension: central_fill_was_credited_flag {
    label: "Central Fill Was Credited"
    type: yesno
    description: "Yes/No Flag indicating if the transaction associated with a central fill record was credit returned. Updated by the system when a transaction associated with a central fill record is credit returned. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_WAS_CREDITED_FLAG = 'Y' ;;
  }

  dimension_group: central_fill_cancel {
    label: "Central Fill Cancel"
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
    description: "Date and time a cancellation request was sent to the central fill facility. Updated by the system with the current system date and time when a cancellation request is sent. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_CANCEL_DATE ;;
  }

  dimension: central_fill_system_order_number {
    label: "Central Fill System Order Number"
    type: number
    description: "Order number at the central fill facility for a central fill transaction record. Populated by the system when a central fill record is added to the central fill queue. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_SYSTEM_ORDER_NUMBER ;;
    value_format: "######"
  }

  dimension: central_fill_system_queue_number {
    label: "Central Fill System Queue Number"
    type: number
    description: "Queue number at the central fill facility for a central fill transaction record. Populated by the system when a central fill record is added to the central fill queue. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_SYSTEM_QUEUE_NUMBER ;;
  }

  dimension: central_fill_system_error_code_reference {
    label: "Central Fill System Error Code"
    description: "Error code returned from the central fill system. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    type: string
    hidden: yes
    sql: ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE ;;
  }

  dimension: central_fill_system_error_code {
    label: "Central Fill System Error Code"
    type: string
    description: "Error code returned from the central fill system. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_ID IS NULL THEN 'N/A'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ND' THEN 'ND - NDC NOT FOUND'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'NF' THEN 'NF - NON-FORMULARY NDC'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'PE' THEN 'PE - PARSING ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ME' THEN 'ME - MISCELLANEOUS ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'RM' THEN 'RM - MISSING RX'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'FR' THEN 'FR - FOUND RX'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ST' THEN 'ST - STORE NOT ELIGIBLE'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'TU' THEN 'TU - REQUEST UNDEFINED'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'CF' THEN 'CF - CF ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'DQ' THEN 'DQ - INADEQUATE DRUG INVENTORY'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'CE' THEN 'CE - COMMUNICATIONS ERROR'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN",
                  "ND - NDC NOT FOUND",
                  "NF - NON-FORMULARY NDC",
                  "PE - PARSING ERROR",
                  "ME - MISCELLANEOUS ERROR",
                  "RM - MISSING RX",
                  "FR - FOUND RX",
                  "ST - STORE NOT ELIGIBLE",
                  "TU - REQUEST UNDEFINED",
                  "CF - CF ERROR",
                  "DQ - INADEQUATE DRUG INVENTORY",
                  "CE - COMMUNICATIONS ERROR"]
    suggest_persist_for: "24 hours"
    drill_fields: [central_fill_system_error_code_reference]
  }

  dimension: central_fill_ndc_filled {
    label: "Central Fill NDC Filled"
    type: string
    description: "NDC of the drug used to fill a central fill prescription. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_NDC_FILLED ;;
  }

  dimension: central_fill_pack_size_used {
    label: "Central Fill Pack Size Used"
    type: number
    description: "Pack size of stock bottle used to fill a central fill prescription.  Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_PACK_SIZE_USED ;;
    value_format: "######"
  }

  dimension_group: central_fill_dispensed {
    label: "Central Fill Dispensed"
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
    description: "Date and time a prescription was dispensed at the central fill facility. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_DISPENSED_DATE ;;
  }

  dimension: central_fill_barcode {
    label: "Central Fill Barcode"
    type: number
    description: "Barcode ID for a central fill prescription. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_BARCODE ;;
    value_format: "######"
  }

  dimension: central_fill_missing_from_delivery_reference {
    label: "Central Fill Missing From Delivery"
    description: "Flag indicating if a prescription was missing when an order was checked in. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    type: string
    hidden: yes
    sql: ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY ;;
  }

  dimension: central_fill_missing_from_delivery {
    label: "Central Fill Missing From Delivery"
    type: string
    description: "Flag indicating if a prescription was missing when an order was checked in. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_ID IS NULL THEN 'N/A'
              WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY IS NULL THEN 'NULL - NOT MISSING'
              WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY = 'F' THEN 'F - FLAGGED MISSING BUT FOUND'
              WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY = 'Y' THEN 'Y - MISSING'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - NOT MISSING","F - FLAGGED MISSING BUT FOUND","Y - MISSING"]
    suggest_persist_for: "24 hours"
    drill_fields: [central_fill_missing_from_delivery_reference]
  }

  dimension: central_fill_fill_operator {
    label: "Central Fill Operator"
    type: string
    description: "Central fill operator or technician responsible for filling a prescription at the central fill facility. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR ;;
  }

  dimension: central_fill_fill_operator_deidentified {
    label: "Central Fill Operator"
    type: string
    description: "Central fill operator or technician responsible for filling a prescription at the central fill facility. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: SHA2(${TABLE}.CENTRAL_FILL_FILL_OPERATOR) ;;
  }

  dimension_group: central_fill_delivery {
    label: "Central Fill Delivery"
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
    description: "Date and time a prescription is expected to be delivered from the central fill facility. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_DELIVERY_DATE ;;
  }

  dimension: central_fill_error_text {
    label: "Central Fill Error Text"
    type: string
    description: "Error messages returned from the central fill facility. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_ERROR_TEXT ;;
  }

  dimension: central_fill_destination_reference {
    label: "Central Fill Destination"
    description: "Home Delivery or Pharmacy Delivery. Populated by the system when the record is created. Determined by the Pickup Type. EPS Table: CENTRAL_FILL"
    type: string
    hidden: yes
    sql: ${TABLE}.CENTRAL_FILL_DESTINATION ;;
  }

  dimension: central_fill_destination {
    label: "Central Fill Destination"
    type: string
    description: "Home Delivery or Pharmacy Delivery. Populated by the system when the record is created. Determined by the Pickup Type. EPS Table: CENTRAL_FILL"
    sql:  CASE WHEN ${TABLE}.CENTRAL_FILL_ID IS NULL THEN 'N/A'
               WHEN ${TABLE}.CENTRAL_FILL_DESTINATION IS NULL THEN 'NULL - NOT SPECIFIED'
               WHEN ${TABLE}.CENTRAL_FILL_DESTINATION = 'H' THEN 'H - HOME DELIVERY'
               WHEN ${TABLE}.CENTRAL_FILL_DESTINATION = 'S' THEN 'S - STORE DELIVERY'
               ELSE 'UNKNOWN'
           END ;;
    suggestions: ["NULL - NOT SPECIFIED","H - HOME DELIVERY","S - STORE DELIVERY"]
    suggest_persist_for: "24 hours"
    drill_fields: [central_fill_destination_reference]
  }

  dimension: central_fill_fill_operator_employee {
    label: "Central Fill Operator Employee"
    type: string
    description: "Employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE ;;
  }

  dimension: central_fill_fill_operator_employee_deidentified {
    label: "Central Fill Operator Employee"
    type: string
    description: "Employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: SHA2(${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE) ;;
  }

  dimension: central_fill_fill_operator_employee_initials {
    label: "Central Fill Operator Employee Initials"
    type: string
    description: "Initials of the employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE_INITIALS ;;
  }

  dimension: central_fill_fill_operator_employee_initials_deidentified {
    label: "Central Fill Fill Operator Employee Initials"
    type: string
    description: "Initials of the employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: SHA2(${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE_INITIALS) ;;
  }

  dimension_group: central_fill_completed {
    label: "Central Fill Completed"
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
    description: "Date that this record was completed and shipped from the fulfilment center. SBMO Status Update response. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_COMPLETED_DATE ;;
  }

  dimension_group: source_create_timestamp {
    label: "Central Fill Source Create"
    type: time
    description: "Date/Time the record was created in source table. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Central Fill Last Update"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  #ERXDWPS-7261 - Sync EPS CENTRAL_FILL to EDW
  dimension_group: central_fill_accepted {
    label: "Central Fill Accepted"
    description: "Date/time the prescription was accepted by the dispenser"
    type: time
    sql: ${TABLE}.CENTRAL_FILL_ACCEPTED_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  ##################################################################### Reference Dimsnsions ########################################
  #[ERXDWPS-8916] - Reference dimensions created to utilize in central fill explore for Fiscal timeframes.
  dimension: rpt_cal_central_fill_completed_date {
    hidden: yes
    sql: TO_DATE(${TABLE}.CENTRAL_FILL_COMPLETED_DATE) ;;
  }

  #Central Fill Completed Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_completed.
  dimension_group: cf_completed {
    label: "Central Fill Completed"
    description: "Central Fill Compelted Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    can_filter: no
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_COMPLETED_DATE ;;
  }

  dimension: cf_completed_calendar_date {
    label: "Central Fill Completed Date"
    description: "Central Fill Completed Date"
    type: date
    hidden: yes
    sql: ${cf_completed_timeframes.calendar_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_chain_id {
    label: "Central Fill Completed Chain ID"
    description: "Central Fill Completed Chain ID"
    type: number
    hidden: yes
    sql: ${cf_completed_timeframes.chain_id} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_calendar_owner_chain_id {
    label: "Central Fill Completed Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_completed_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_yesno {
    label: "Central Fill Completed (Yes/No)"
    group_label: "Central Fill Completed Date"
    description: "Yes/No flag indicating if a prescription has Completed Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_COMPLETED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_completed_day_of_week {
    label: "Central Fill Completed Day Of Week"
    description: "Central Fill Completed Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_completed_timeframes.day_of_week} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_day_of_month {
    label: "Central Fill Completed Day Of Month"
    description: "Central Fill Completed Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.day_of_month} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_week_of_year {
    label: "Central Fill Completed Week Of Year"
    description: "Central Fill Completed Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.week_of_year} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_month_num {
    label: "Central Fill Completed Month Num"
    description: "Central Fill Completed Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.month_num} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_month {
    label: "Central Fill Completed Month"
    description: "Central Fill Completed Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_completed_timeframes.month} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_quarter_of_year {
    label: "Central Fill Completed Quarter Of Year"
    description: "Central Fill Completed Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_completed_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_quarter {
    label: "Central Fill Completed Quarter"
    description: "Central Fill Completed Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_completed_timeframes.quarter} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_year {
    label: "Central Fill Completed Year"
    description: "Central Fill Completed Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.year} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_day_of_week_index {
    label: "Central Fill Completed Day of Week Index"
    description: "Central Fill Completed Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_week_begin_date {
    label: "Central Fill Completed Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Completed Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.week_begin_date} ;;
    group_label: "Central Fill Completed Date"
  }

  #[ERXLPS-1229] - Added remaining timeframe components from d_fiscal_date
  dimension: cf_completed_week_end_date {
    label: "Central Fill Completed Week End Date"
    description: "Central Fill Completed Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.week_end_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_week_of_quarter {
    label: "Central Fill Completed Week Of Quarter"
    description: "Central Fill Completed Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_month_begin_date {
    label: "Central Fill Completed Month Begin Date"
    description: "Central Fill Completed Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.month_begin_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_month_end_date {
    label: "Central Fill Completed Month End Date"
    description: "Central Fill Completed Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.month_end_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_weeks_in_month {
    label: "Central Fill Completed Weeks In Month"
    description: "Central Fill Completed Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_quarter_begin_date {
    label: "Central Fill Completed Quarter Begin Date"
    description: "Central Fill Completed Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_quarter_end_date {
    label: "Central Fill Completed Quarter End Date"
    description: "Central Fill Completed Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_weeks_in_quarter {
    label: "Central Fill Completed Weeks In Quarter"
    description: "Central Fill Completed Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_year_begin_date {
    label: "Central Fill Completed Year Begin Date"
    description: "Central Fill Completed Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.year_begin_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_year_end_date {
    label: "Central Fill Completed Year End Date"
    description: "Central Fill Completed Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_completed_timeframes.year_end_date} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_weeks_in_year {
    label: "Central Fill Completed Weeks In Year"
    description: "Central Fill Completed Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_leap_year_flag {
    label: "Central Fill Completed Leap Year Flag"
    description: "Central Fill Completed Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_completed_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_day_of_quarter {
    label: "Central Fill Completed Day Of Quarter"
    description: "Central Fill Completed Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Completed Date"
  }

  dimension: cf_completed_day_of_year {
    label: "Central Fill Completed Day Of Year"
    description: "Central Fill Completed Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_completed_timeframes.day_of_year} ;;
    group_label: "Central Fill Completed Date"
  }

  #Central Fill Accepted Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_accepted.
  dimension_group: cf_accepted {
    label: "Central Fill Accepted"
    description: "Central Fill Accepted Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_ACCEPTED_DATE ;;
  }

  dimension: cf_accepted_calendar_date {
    label: "Central Fill Accepted Date"
    description: "Central Fill Accepted Date"
    type: date
    hidden: yes
    sql: ${cf_accepted_timeframes.calendar_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_chain_id {
    label: "Central Fill Accepted Chain ID"
    description: "Central Fill Accepted Chain ID"
    type: number
    hidden: yes
    sql: ${cf_accepted_timeframes.chain_id} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_calendar_owner_chain_id {
    label: "Central Fill Accepted Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_accepted_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_yesno {
    label: "Central Fill Accepted (Yes/No)"
    group_label: "Central Fill Accepted Date"
    description: "Yes/No flag indicating if a prescription has Accepted Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_ACCEPTED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_accepted_day_of_week {
    label: "Central Fill Accepted Day Of Week"
    description: "Central Fill Accepted Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_accepted_timeframes.day_of_week} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_day_of_month {
    label: "Central Fill Accepted Day Of Month"
    description: "Central Fill Accepted Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.day_of_month} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_week_of_year {
    label: "Central Fill Accepted Week Of Year"
    description: "Central Fill Accepted Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.week_of_year} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_month_num {
    label: "Central Fill Accepted Month Num"
    description: "Central Fill Accepted Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.month_num} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_month {
    label: "Central Fill Accepted Month"
    description: "Central Fill Accepted Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_accepted_timeframes.month} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_quarter_of_year {
    label: "Central Fill Accepted Quarter Of Year"
    description: "Central Fill Accepted Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_accepted_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_quarter {
    label: "Central Fill Accepted Quarter"
    description: "Central Fill Accepted Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_accepted_timeframes.quarter} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_year {
    label: "Central Fill Accepted Year"
    description: "Central Fill Accepted Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.year} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_day_of_week_index {
    label: "Central Fill Accepted Day of Week Index"
    description: "Central Fill Accepted Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_week_begin_date {
    label: "Central Fill Accepted Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Accepted Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.week_begin_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  #[ERXLPS-1229] - Added remaining timeframe components from d_fiscal_date
  dimension: cf_accepted_week_end_date {
    label: "Central Fill Accepted Week End Date"
    description: "Central Fill Accepted Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.week_end_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_week_of_quarter {
    label: "Central Fill Accepted Week Of Quarter"
    description: "Central Fill Accepted Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_month_begin_date {
    label: "Central Fill Accepted Month Begin Date"
    description: "Central Fill Accepted Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.month_begin_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_month_end_date {
    label: "Central Fill Accepted Month End Date"
    description: "Central Fill Accepted Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.month_end_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_weeks_in_month {
    label: "Central Fill Accepted Weeks In Month"
    description: "Central Fill Accepted Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_quarter_begin_date {
    label: "Central Fill Accepted Quarter Begin Date"
    description: "Central Fill Accepted Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_quarter_end_date {
    label: "Central Fill Accepted Quarter End Date"
    description: "Central Fill Accepted Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_weeks_in_quarter {
    label: "Central Fill Accepted Weeks In Quarter"
    description: "Central Fill Accepted Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_year_begin_date {
    label: "Central Fill Accepted Year Begin Date"
    description: "Central Fill Accepted Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.year_begin_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_year_end_date {
    label: "Central Fill Accepted Year End Date"
    description: "Central Fill Accepted Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_accepted_timeframes.year_end_date} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_weeks_in_year {
    label: "Central Fill Accepted Weeks In Year"
    description: "Central Fill Accepted Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_leap_year_flag {
    label: "Central Fill Accepted Leap Year Flag"
    description: "Central Fill Accepted Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_accepted_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_day_of_quarter {
    label: "Central Fill Accepted Day Of Quarter"
    description: "Central Fill Accepted Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Accepted Date"
  }

  dimension: cf_accepted_day_of_year {
    label: "Central Fill Accepted Day Of Year"
    description: "Central Fill Accepted Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_accepted_timeframes.day_of_year} ;;
    group_label: "Central Fill Accepted Date"
  }

  #Central Fill Cancel Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_cancel.
  dimension_group: cf_cancel {
    label: "Central Fill Cancel"
    description: "Central Fill Cancel Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_CANCEL_DATE ;;
  }

  dimension: cf_cancel_calendar_date {
    label: "Central Fill Cancel Date"
    description: "Central Fill Cancel Date"
    type: date
    hidden: yes
    sql: ${cf_cancel_timeframes.calendar_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_chain_id {
    label: "Central Fill Cancel Chain ID"
    description: "Central Fill Cancel Chain ID"
    type: number
    hidden: yes
    sql: ${cf_cancel_timeframes.chain_id} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_calendar_owner_chain_id {
    label: "Central Fill Cancel Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_cancel_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_yesno {
    label: "Central Fill Cancel (Yes/No)"
    group_label: "Central Fill Cancel Date"
    description: "Yes/No flag indicating if a prescription has Cancel Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_CANCEL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_cancel_day_of_week {
    label: "Central Fill Cancel Day Of Week"
    description: "Central Fill Cancel Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_cancel_timeframes.day_of_week} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_day_of_month {
    label: "Central Fill Cancel Day Of Month"
    description: "Central Fill Cancel Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.day_of_month} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_week_of_year {
    label: "Central Fill Cancel Week Of Year"
    description: "Central Fill Cancel Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.week_of_year} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_month_num {
    label: "Central Fill Cancel Month Num"
    description: "Central Fill Cancel Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.month_num} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_month {
    label: "Central Fill Cancel Month"
    description: "Central Fill Cancel Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_cancel_timeframes.month} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_quarter_of_year {
    label: "Central Fill Cancel Quarter Of Year"
    description: "Central Fill Cancel Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_cancel_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_quarter {
    label: "Central Fill Cancel Quarter"
    description: "Central Fill Cancel Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_cancel_timeframes.quarter} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_year {
    label: "Central Fill Cancel Year"
    description: "Central Fill Cancel Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.year} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_day_of_week_index {
    label: "Central Fill Cancel Day of Week Index"
    description: "Central Fill Cancel Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_week_begin_date {
    label: "Central Fill Cancel Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Cancel Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.week_begin_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_week_end_date {
    label: "Central Fill Cancel Week End Date"
    description: "Central Fill Cancel Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.week_end_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_week_of_quarter {
    label: "Central Fill Cancel Week Of Quarter"
    description: "Central Fill Cancel Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_month_begin_date {
    label: "Central Fill Cancel Month Begin Date"
    description: "Central Fill Cancel Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.month_begin_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_month_end_date {
    label: "Central Fill Cancel Month End Date"
    description: "Central Fill Cancel Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.month_end_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_weeks_in_month {
    label: "Central Fill Cancel Weeks In Month"
    description: "Central Fill Cancel Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_quarter_begin_date {
    label: "Central Fill Cancel Quarter Begin Date"
    description: "Central Fill Cancel Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_quarter_end_date {
    label: "Central Fill Cancel Quarter End Date"
    description: "Central Fill Cancel Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_weeks_in_quarter {
    label: "Central Fill Cancel Weeks In Quarter"
    description: "Central Fill Cancel Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_year_begin_date {
    label: "Central Fill Cancel Year Begin Date"
    description: "Central Fill Cancel Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.year_begin_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_year_end_date {
    label: "Central Fill Cancel Year End Date"
    description: "Central Fill Cancel Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_cancel_timeframes.year_end_date} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_weeks_in_year {
    label: "Central Fill Cancel Weeks In Year"
    description: "Central Fill Cancel Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_leap_year_flag {
    label: "Central Fill Cancel Leap Year Flag"
    description: "Central Fill Cancel Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_cancel_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_day_of_quarter {
    label: "Central Fill Cancel Day Of Quarter"
    description: "Central Fill Cancel Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Cancel Date"
  }

  dimension: cf_cancel_day_of_year {
    label: "Central Fill Cancel Day Of Year"
    description: "Central Fill Cancel Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_cancel_timeframes.day_of_year} ;;
    group_label: "Central Fill Cancel Date"
  }

  #Central Fill Check In Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_check_in.
  dimension_group: cf_check_in {
    label: "Central Fill Check In"
    description: "Central Fill Check In Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_CHECK_IN_DATE ;;
  }

  dimension: cf_check_in_calendar_date {
    label: "Central Fill Check In Date"
    description: "Central Fill Check In Date"
    type: date
    hidden: yes
    sql: ${cf_check_in_timeframes.calendar_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_chain_id {
    label: "Central Fill Check In Chain ID"
    description: "Central Fill Check In Chain ID"
    type: number
    hidden: yes
    sql: ${cf_check_in_timeframes.chain_id} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_calendar_owner_chain_id {
    label: "Central Fill Check In Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_check_in_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_yesno {
    label: "Central Fill Check In (Yes/No)"
    group_label: "Central Fill Check In Date"
    description: "Yes/No flag indicating if a prescription has Check In Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_CHECK_IN_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_check_in_day_of_week {
    label: "Central Fill Check In Day Of Week"
    description: "Central Fill Check In Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_check_in_timeframes.day_of_week} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_day_of_month {
    label: "Central Fill Check In Day Of Month"
    description: "Central Fill Check In Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.day_of_month} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_week_of_year {
    label: "Central Fill Check In Week Of Year"
    description: "Central Fill Check In Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.week_of_year} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_month_num {
    label: "Central Fill Check In Month Num"
    description: "Central Fill Check In Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.month_num} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_month {
    label: "Central Fill Check In Month"
    description: "Central Fill Check In Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_check_in_timeframes.month} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_quarter_of_year {
    label: "Central Fill Check In Quarter Of Year"
    description: "Central Fill Check In Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_check_in_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_quarter {
    label: "Central Fill Check In Quarter"
    description: "Central Fill Check In Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_check_in_timeframes.quarter} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_year {
    label: "Central Fill Check In Year"
    description: "Central Fill Check In Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.year} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_day_of_week_index {
    label: "Central Fill Check In Day of Week Index"
    description: "Central Fill Check In Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_week_begin_date {
    label: "Central Fill Check In Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Check In Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.week_begin_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_week_end_date {
    label: "Central Fill Check In Week End Date"
    description: "Central Fill Check In Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.week_end_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_week_of_quarter {
    label: "Central Fill Check In Week Of Quarter"
    description: "Central Fill Check In Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_month_begin_date {
    label: "Central Fill Check In Month Begin Date"
    description: "Central Fill Check In Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.month_begin_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_month_end_date {
    label: "Central Fill Check In Month End Date"
    description: "Central Fill Check In Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.month_end_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_weeks_in_month {
    label: "Central Fill Check In Weeks In Month"
    description: "Central Fill Check In Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_quarter_begin_date {
    label: "Central Fill Check In Quarter Begin Date"
    description: "Central Fill Check In Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_quarter_end_date {
    label: "Central Fill Check In Quarter End Date"
    description: "Central Fill Check In Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_weeks_in_quarter {
    label: "Central Fill Check In Weeks In Quarter"
    description: "Central Fill Check In Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_year_begin_date {
    label: "Central Fill Check In Year Begin Date"
    description: "Central Fill Check In Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.year_begin_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_year_end_date {
    label: "Central Fill Check In Year End Date"
    description: "Central Fill Check In Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_check_in_timeframes.year_end_date} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_weeks_in_year {
    label: "Central Fill Check In Weeks In Year"
    description: "Central Fill Check In Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_leap_year_flag {
    label: "Central Fill Check In Leap Year Flag"
    description: "Central Fill Check In Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_check_in_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_day_of_quarter {
    label: "Central Fill Check In Day Of Quarter"
    description: "Central Fill Check In Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Check In Date"
  }

  dimension: cf_check_in_day_of_year {
    label: "Central Fill Check In Day Of Year"
    description: "Central Fill Check In Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_check_in_timeframes.day_of_year} ;;
    group_label: "Central Fill Check In Date"
  }

  #Central Fill Delivery Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_delivery.
  dimension_group: cf_delivery {
    label: "Central Fill Delivery"
    description: "Central Fill Delivery Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_DELIVERY_DATE ;;
  }

  dimension: cf_delivery_calendar_date {
    label: "Central Fill Delivery Date"
    description: "Central Fill Delivery Date"
    type: date
    hidden: yes
    sql: ${cf_delivery_timeframes.calendar_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_chain_id {
    label: "Central Fill Delivery Chain ID"
    description: "Central Fill Delivery Chain ID"
    type: number
    hidden: yes
    sql: ${cf_delivery_timeframes.chain_id} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_calendar_owner_chain_id {
    label: "Central Fill Delivery Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_delivery_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_yesno {
    label: "Central Fill Delivery (Yes/No)"
    group_label: "Central Fill Delivery Date"
    description: "Yes/No flag indicating if a prescription has Delivery Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_DELIVERY_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_delivery_day_of_week {
    label: "Central Fill Delivery Day Of Week"
    description: "Central Fill Delivery Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_delivery_timeframes.day_of_week} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_day_of_month {
    label: "Central Fill Delivery Day Of Month"
    description: "Central Fill Delivery Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.day_of_month} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_week_of_year {
    label: "Central Fill Delivery Week Of Year"
    description: "Central Fill Delivery Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.week_of_year} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_month_num {
    label: "Central Fill Delivery Month Num"
    description: "Central Fill Delivery Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.month_num} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_month {
    label: "Central Fill Delivery Month"
    description: "Central Fill Delivery Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_delivery_timeframes.month} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_quarter_of_year {
    label: "Central Fill Delivery Quarter Of Year"
    description: "Central Fill Delivery Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_delivery_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_quarter {
    label: "Central Fill Delivery Quarter"
    description: "Central Fill Delivery Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_delivery_timeframes.quarter} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_year {
    label: "Central Fill Delivery Year"
    description: "Central Fill Delivery Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.year} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_day_of_week_index {
    label: "Central Fill Delivery Day of Week Index"
    description: "Central Fill Delivery Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_week_begin_date {
    label: "Central Fill Delivery Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Delivery Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.week_begin_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_week_end_date {
    label: "Central Fill Delivery Week End Date"
    description: "Central Fill Delivery Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.week_end_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_week_of_quarter {
    label: "Central Fill Delivery Week Of Quarter"
    description: "Central Fill Delivery Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_month_begin_date {
    label: "Central Fill Delivery Month Begin Date"
    description: "Central Fill Delivery Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.month_begin_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_month_end_date {
    label: "Central Fill Delivery Month End Date"
    description: "Central Fill Delivery Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.month_end_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_weeks_in_month {
    label: "Central Fill Delivery Weeks In Month"
    description: "Central Fill Delivery Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_quarter_begin_date {
    label: "Central Fill Delivery Quarter Begin Date"
    description: "Central Fill Delivery Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_quarter_end_date {
    label: "Central Fill Delivery Quarter End Date"
    description: "Central Fill Delivery Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_weeks_in_quarter {
    label: "Central Fill Delivery Weeks In Quarter"
    description: "Central Fill Delivery Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_year_begin_date {
    label: "Central Fill Delivery Year Begin Date"
    description: "Central Fill Delivery Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.year_begin_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_year_end_date {
    label: "Central Fill Delivery Year End Date"
    description: "Central Fill Delivery Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_delivery_timeframes.year_end_date} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_weeks_in_year {
    label: "Central Fill Delivery Weeks In Year"
    description: "Central Fill Delivery Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_leap_year_flag {
    label: "Central Fill Delivery Leap Year Flag"
    description: "Central Fill Delivery Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_delivery_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_day_of_quarter {
    label: "Central Fill Delivery Day Of Quarter"
    description: "Central Fill Delivery Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Delivery Date"
  }

  dimension: cf_delivery_day_of_year {
    label: "Central Fill Delivery Day Of Year"
    description: "Central Fill Delivery Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_delivery_timeframes.day_of_year} ;;
    group_label: "Central Fill Delivery Date"
  }

  #Central Fill Dispensed Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_dispensed.
  dimension_group: cf_dispensed {
    label: "Central Fill Dispensed"
    description: "Central Fill Dispensed Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_DISPENSED_DATE ;;
  }

  dimension: cf_dispensed_calendar_date {
    label: "Central Fill Dispensed Date"
    description: "Central Fill Dispensed Date"
    type: date
    hidden: yes
    sql: ${cf_dispensed_timeframes.calendar_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_chain_id {
    label: "Central Fill Dispensed Chain ID"
    description: "Central Fill Dispensed Chain ID"
    type: number
    hidden: yes
    sql: ${cf_dispensed_timeframes.chain_id} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_calendar_owner_chain_id {
    label: "Central Fill Dispensed Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_dispensed_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_yesno {
    label: "Central Fill Dispensed (Yes/No)"
    group_label: "Central Fill Dispensed Date"
    description: "Yes/No flag indicating if a prescription has Dispensed Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_DISPENSED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_dispensed_day_of_week {
    label: "Central Fill Dispensed Day Of Week"
    description: "Central Fill Dispensed Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_dispensed_timeframes.day_of_week} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_day_of_month {
    label: "Central Fill Dispensed Day Of Month"
    description: "Central Fill Dispensed Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.day_of_month} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_week_of_year {
    label: "Central Fill Dispensed Week Of Year"
    description: "Central Fill Dispensed Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.week_of_year} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_month_num {
    label: "Central Fill Dispensed Month Num"
    description: "Central Fill Dispensed Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.month_num} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_month {
    label: "Central Fill Dispensed Month"
    description: "Central Fill Dispensed Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_dispensed_timeframes.month} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_quarter_of_year {
    label: "Central Fill Dispensed Quarter Of Year"
    description: "Central Fill Dispensed Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_dispensed_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_quarter {
    label: "Central Fill Dispensed Quarter"
    description: "Central Fill Dispensed Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_dispensed_timeframes.quarter} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_year {
    label: "Central Fill Dispensed Year"
    description: "Central Fill Dispensed Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.year} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_day_of_week_index {
    label: "Central Fill Dispensed Day of Week Index"
    description: "Central Fill Dispensed Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_week_begin_date {
    label: "Central Fill Dispensed Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Dispensed Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.week_begin_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_week_end_date {
    label: "Central Fill Dispensed Week End Date"
    description: "Central Fill Dispensed Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.week_end_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_week_of_quarter {
    label: "Central Fill Dispensed Week Of Quarter"
    description: "Central Fill Dispensed Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_month_begin_date {
    label: "Central Fill Dispensed Month Begin Date"
    description: "Central Fill Dispensed Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.month_begin_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_month_end_date {
    label: "Central Fill Dispensed Month End Date"
    description: "Central Fill Dispensed Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.month_end_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_weeks_in_month {
    label: "Central Fill Dispensed Weeks In Month"
    description: "Central Fill Dispensed Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_quarter_begin_date {
    label: "Central Fill Dispensed Quarter Begin Date"
    description: "Central Fill Dispensed Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_quarter_end_date {
    label: "Central Fill Dispensed Quarter End Date"
    description: "Central Fill Dispensed Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_weeks_in_quarter {
    label: "Central Fill Dispensed Weeks In Quarter"
    description: "Central Fill Dispensed Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_year_begin_date {
    label: "Central Fill Dispensed Year Begin Date"
    description: "Central Fill Dispensed Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.year_begin_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_year_end_date {
    label: "Central Fill Dispensed Year End Date"
    description: "Central Fill Dispensed Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_dispensed_timeframes.year_end_date} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_weeks_in_year {
    label: "Central Fill Dispensed Weeks In Year"
    description: "Central Fill Dispensed Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_leap_year_flag {
    label: "Central Fill Dispensed Leap Year Flag"
    description: "Central Fill Dispensed Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_dispensed_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_day_of_quarter {
    label: "Central Fill Dispensed Day Of Quarter"
    description: "Central Fill Dispensed Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Dispensed Date"
  }

  dimension: cf_dispensed_day_of_year {
    label: "Central Fill Dispensed Day Of Year"
    description: "Central Fill Dispensed Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_dispensed_timeframes.day_of_year} ;;
    group_label: "Central Fill Dispensed Date"
  }

  #Central Fill Pick Up Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_pick_up.
  dimension_group: cf_pick_up {
    label: "Central Fill Pick Up"
    description: "Central Fill Pick Up Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_PICK_UP_DATE ;;
  }

  dimension: cf_pick_up_calendar_date {
    label: "Central Fill Pick Up Date"
    description: "Central Fill Pick Up Date"
    type: date
    hidden: yes
    sql: ${cf_pick_up_timeframes.calendar_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_chain_id {
    label: "Central Fill Pick Up Chain ID"
    description: "Central Fill Pick Up Chain ID"
    type: number
    hidden: yes
    sql: ${cf_pick_up_timeframes.chain_id} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_calendar_owner_chain_id {
    label: "Central Fill Pick Up Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_pick_up_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_yesno {
    label: "Central Fill Pick Up (Yes/No)"
    group_label: "Central Fill Pick Up Date"
    description: "Yes/No flag indicating if a prescription has Pick Up Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_PICK_UP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_pick_up_day_of_week {
    label: "Central Fill Pick Up Day Of Week"
    description: "Central Fill Pick Up Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_pick_up_timeframes.day_of_week} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_day_of_month {
    label: "Central Fill Pick Up Day Of Month"
    description: "Central Fill Pick Up Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.day_of_month} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_week_of_year {
    label: "Central Fill Pick Up Week Of Year"
    description: "Central Fill Pick Up Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.week_of_year} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_month_num {
    label: "Central Fill Pick Up Month Num"
    description: "Central Fill Pick Up Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.month_num} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_month {
    label: "Central Fill Pick Up Month"
    description: "Central Fill Pick Up Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_pick_up_timeframes.month} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_quarter_of_year {
    label: "Central Fill Pick Up Quarter Of Year"
    description: "Central Fill Pick Up Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_pick_up_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_quarter {
    label: "Central Fill Pick Up Quarter"
    description: "Central Fill Pick Up Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_pick_up_timeframes.quarter} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_year {
    label: "Central Fill Pick Up Year"
    description: "Central Fill Pick Up Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.year} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_day_of_week_index {
    label: "Central Fill Pick Up Day of Week Index"
    description: "Central Fill Pick Up Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_week_begin_date {
    label: "Central Fill Pick Up Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Pick Up Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.week_begin_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_week_end_date {
    label: "Central Fill Pick Up Week End Date"
    description: "Central Fill Pick Up Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.week_end_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_week_of_quarter {
    label: "Central Fill Pick Up Week Of Quarter"
    description: "Central Fill Pick Up Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_month_begin_date {
    label: "Central Fill Pick Up Month Begin Date"
    description: "Central Fill Pick Up Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.month_begin_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_month_end_date {
    label: "Central Fill Pick Up Month End Date"
    description: "Central Fill Pick Up Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.month_end_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_weeks_in_month {
    label: "Central Fill Pick Up Weeks In Month"
    description: "Central Fill Pick Up Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_quarter_begin_date {
    label: "Central Fill Pick Up Quarter Begin Date"
    description: "Central Fill Pick Up Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_quarter_end_date {
    label: "Central Fill Pick Up Quarter End Date"
    description: "Central Fill Pick Up Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_weeks_in_quarter {
    label: "Central Fill Pick Up Weeks In Quarter"
    description: "Central Fill Pick Up Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_year_begin_date {
    label: "Central Fill Pick Up Year Begin Date"
    description: "Central Fill Pick Up Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.year_begin_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_year_end_date {
    label: "Central Fill Pick Up Year End Date"
    description: "Central Fill Pick Up Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_pick_up_timeframes.year_end_date} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_weeks_in_year {
    label: "Central Fill Pick Up Weeks In Year"
    description: "Central Fill Pick Up Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_leap_year_flag {
    label: "Central Fill Pick Up Leap Year Flag"
    description: "Central Fill Pick Up Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_pick_up_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_day_of_quarter {
    label: "Central Fill Pick Up Day Of Quarter"
    description: "Central Fill Pick Up Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Pick Up Date"
  }

  dimension: cf_pick_up_day_of_year {
    label: "Central Fill Pick Up Day Of Year"
    description: "Central Fill Pick Up Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_pick_up_timeframes.day_of_year} ;;
    group_label: "Central Fill Pick Up Date"
  }

  #Central Fill Status Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name central_fill_status.
  dimension_group: cf_status {
    label: "Central Fill Status"
    description: "Central Fill Status Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.CENTRAL_FILL_STATUS_DATE ;;
  }

  dimension: cf_status_calendar_date {
    label: "Central Fill Status Date"
    description: "Central Fill Status Date"
    type: date
    hidden: yes
    sql: ${cf_status_timeframes.calendar_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_chain_id {
    label: "Central Fill Status Chain ID"
    description: "Central Fill Status Chain ID"
    type: number
    hidden: yes
    sql: ${cf_status_timeframes.chain_id} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_calendar_owner_chain_id {
    label: "Central Fill Status Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_status_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_yesno {
    label: "Central Fill Status (Yes/No)"
    group_label: "Central Fill Status Date"
    description: "Yes/No flag indicating if a prescription has Status Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.CENTRAL_FILL_STATUS_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: cf_status_day_of_week {
    label: "Central Fill Status Day Of Week"
    description: "Central Fill Status Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_status_timeframes.day_of_week} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_day_of_month {
    label: "Central Fill Status Day Of Month"
    description: "Central Fill Status Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.day_of_month} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_week_of_year {
    label: "Central Fill Status Week Of Year"
    description: "Central Fill Status Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.week_of_year} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_month_num {
    label: "Central Fill Status Month Num"
    description: "Central Fill Status Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.month_num} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_month {
    label: "Central Fill Status Month"
    description: "Central Fill Status Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_status_timeframes.month} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_quarter_of_year {
    label: "Central Fill Status Quarter Of Year"
    description: "Central Fill Status Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_status_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_quarter {
    label: "Central Fill Status Quarter"
    description: "Central Fill Status Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_status_timeframes.quarter} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_year {
    label: "Central Fill Status Year"
    description: "Central Fill Status Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.year} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_day_of_week_index {
    label: "Central Fill Status Day of Week Index"
    description: "Central Fill Status Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_week_begin_date {
    label: "Central Fill Status Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Status Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.week_begin_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_week_end_date {
    label: "Central Fill Status Week End Date"
    description: "Central Fill Status Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.week_end_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_week_of_quarter {
    label: "Central Fill Status Week Of Quarter"
    description: "Central Fill Status Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_month_begin_date {
    label: "Central Fill Status Month Begin Date"
    description: "Central Fill Status Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.month_begin_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_month_end_date {
    label: "Central Fill Status Month End Date"
    description: "Central Fill Status Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.month_end_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_weeks_in_month {
    label: "Central Fill Status Weeks In Month"
    description: "Central Fill Status Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_quarter_begin_date {
    label: "Central Fill Status Quarter Begin Date"
    description: "Central Fill Status Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_quarter_end_date {
    label: "Central Fill Status Quarter End Date"
    description: "Central Fill Status Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_weeks_in_quarter {
    label: "Central Fill Status Weeks In Quarter"
    description: "Central Fill Status Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_year_begin_date {
    label: "Central Fill Status Year Begin Date"
    description: "Central Fill Status Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.year_begin_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_year_end_date {
    label: "Central Fill Status Year End Date"
    description: "Central Fill Status Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_status_timeframes.year_end_date} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_weeks_in_year {
    label: "Central Fill Status Weeks In Year"
    description: "Central Fill Status Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_leap_year_flag {
    label: "Central Fill Status Leap Year Flag"
    description: "Central Fill Status Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_status_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_day_of_quarter {
    label: "Central Fill Status Day Of Quarter"
    description: "Central Fill Status Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Status Date"
  }

  dimension: cf_status_day_of_year {
    label: "Central Fill Status Day Of Year"
    description: "Central Fill Status Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_status_timeframes.day_of_year} ;;
    group_label: "Central Fill Status Date"
  }

  #Central Fill Source Create Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name.
  dimension_group: cf_source_create {
    label: "Central Fill Source Create"
    description: "Central Fill Source Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: cf_source_create_calendar_date {
    label: "Central Fill Source Create Date"
    description: "Central Fill Source Create Date"
    type: date
    hidden: yes
    sql: ${cf_source_create_timeframes.calendar_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_chain_id {
    label: "Central Fill Source Create Chain ID"
    description: "Central Fill Source Create Chain ID"
    type: number
    hidden: yes
    sql: ${cf_source_create_timeframes.chain_id} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_calendar_owner_chain_id {
    label: "Central Fill Source Create Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_source_create_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_yesno {
    label: "Central Fill Source Create (Yes/No)"
    group_label: "Central Fill Source Create Date"
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

  dimension: cf_source_create_day_of_week {
    label: "Central Fill Source Create Day Of Week"
    description: "Central Fill Source Create Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_create_timeframes.day_of_week} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_day_of_month {
    label: "Central Fill Source Create Day Of Month"
    description: "Central Fill Source Create Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.day_of_month} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_week_of_year {
    label: "Central Fill Source Create Week Of Year"
    description: "Central Fill Source Create Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.week_of_year} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_month_num {
    label: "Central Fill Source Create Month Num"
    description: "Central Fill Source Create Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.month_num} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_month {
    label: "Central Fill Source Create Month"
    description: "Central Fill Source Create Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_create_timeframes.month} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_quarter_of_year {
    label: "Central Fill Source Create Quarter Of Year"
    description: "Central Fill Source Create Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_create_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_quarter {
    label: "Central Fill Source Create Quarter"
    description: "Central Fill Source Create Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_create_timeframes.quarter} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_year {
    label: "Central Fill Source Create Year"
    description: "Central Fill Source Create Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.year} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_day_of_week_index {
    label: "Central Fill Source Create Day of Week Index"
    description: "Central Fill Source Create Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_week_begin_date {
    label: "Central Fill Source Create Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Source Create Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.week_begin_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_week_end_date {
    label: "Central Fill Source Create Week End Date"
    description: "Central Fill Source Create Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.week_end_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_week_of_quarter {
    label: "Central Fill Source Create Week Of Quarter"
    description: "Central Fill Source Create Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_month_begin_date {
    label: "Central Fill Source Create Month Begin Date"
    description: "Central Fill Source Create Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.month_begin_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_month_end_date {
    label: "Central Fill Source Create Month End Date"
    description: "Central Fill Source Create Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.month_end_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_weeks_in_month {
    label: "Central Fill Source Create Weeks In Month"
    description: "Central Fill Source Create Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_quarter_begin_date {
    label: "Central Fill Source Create Quarter Begin Date"
    description: "Central Fill Source Create Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_quarter_end_date {
    label: "Central Fill Source Create Quarter End Date"
    description: "Central Fill Source Create Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_weeks_in_quarter {
    label: "Central Fill Source Create Weeks In Quarter"
    description: "Central Fill Source Create Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_year_begin_date {
    label: "Central Fill Source Create Year Begin Date"
    description: "Central Fill Source Create Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.year_begin_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_year_end_date {
    label: "Central Fill Source Create Year End Date"
    description: "Central Fill Source Create Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_create_timeframes.year_end_date} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_weeks_in_year {
    label: "Central Fill Source Create Weeks In Year"
    description: "Central Fill Source Create Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_leap_year_flag {
    label: "Central Fill Source Create Leap Year Flag"
    description: "Central Fill Source Create Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_create_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_day_of_quarter {
    label: "Central Fill Source Create Day Of Quarter"
    description: "Central Fill Source Create Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Source Create Date"
  }

  dimension: cf_source_create_day_of_year {
    label: "Central Fill Source Create Day Of Year"
    description: "Central Fill Source Create Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_create_timeframes.day_of_year} ;;
    group_label: "Central Fill Source Create Date"
  }

  #Central Fill Source Last Update Date fiscal timeframes. dimensions name shortened to avoid confilicts with exisintg dimension_group name.
  dimension_group: cf_source_last_update {
    label: "Central Fill Source Last Update"
    description: "Central Fill Source Last Update Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: cf_source_last_update_calendar_date {
    label: "Central Fill Source Last Update Date"
    description: "Central Fill Source Last Update Date"
    type: date
    hidden: yes
    sql: ${cf_source_last_update_timeframes.calendar_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_chain_id {
    label: "Central Fill Source Last Update Chain ID"
    description: "Central Fill Source Last Update Chain ID"
    type: number
    hidden: yes
    sql: ${cf_source_last_update_timeframes.chain_id} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_calendar_owner_chain_id {
    label: "Central Fill Source Last Update Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${cf_source_last_update_timeframes.calendar_owner_chain_id} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_yesno {
    label: "Central Fill Source Last Update (Yes/No)"
    group_label: "Central Fill Source Last Update Date"
    description: "Yes/No flag indicating if a prescription has Source Last Update Date. Example output 'Yes'" #[ERXLPS-2054]
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

  dimension: cf_source_last_update_day_of_week {
    label: "Central Fill Source Last Update Day Of Week"
    description: "Central Fill Source Last Update Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_last_update_timeframes.day_of_week} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_day_of_month {
    label: "Central Fill Source Last Update Day Of Month"
    description: "Central Fill Source Last Update Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.day_of_month} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_week_of_year {
    label: "Central Fill Source Last Update Week Of Year"
    description: "Central Fill Source Last Update Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.week_of_year} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_month_num {
    label: "Central Fill Source Last Update Month Num"
    description: "Central Fill Source Last Update Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.month_num} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_month {
    label: "Central Fill Source Last Update Month"
    description: "Central Fill Source Last Update Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_last_update_timeframes.month} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_quarter_of_year {
    label: "Central Fill Source Last Update Quarter Of Year"
    description: "Central Fill Source Last Update Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_last_update_timeframes.quarter_of_year} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_quarter {
    label: "Central Fill Source Last Update Quarter"
    description: "Central Fill Source Last Update Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_last_update_timeframes.quarter} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_year {
    label: "Central Fill Source Last Update Year"
    description: "Central Fill Source Last Update Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.year} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_day_of_week_index {
    label: "Central Fill Source Last Update Day of Week Index"
    description: "Central Fill Source Last Update Day of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.day_of_week_index} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_week_begin_date {
    label: "Central Fill Source Last Update Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Central Fill Source Last Update Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.week_begin_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_week_end_date {
    label: "Central Fill Source Last Update Week End Date"
    description: "Central Fill Source Last Update Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.week_end_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_week_of_quarter {
    label: "Central Fill Source Last Update Week Of Quarter"
    description: "Central Fill Source Last Update Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.week_of_quarter} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_month_begin_date {
    label: "Central Fill Source Last Update Month Begin Date"
    description: "Central Fill Source Last Update Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.month_begin_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_month_end_date {
    label: "Central Fill Source Last Update Month End Date"
    description: "Central Fill Source Last Update Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.month_end_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_weeks_in_month {
    label: "Central Fill Source Last Update Weeks In Month"
    description: "Central Fill Source Last Update Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.weeks_in_month} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_quarter_begin_date {
    label: "Central Fill Source Last Update Quarter Begin Date"
    description: "Central Fill Source Last Update Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.quarter_begin_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_quarter_end_date {
    label: "Central Fill Source Last Update Quarter End Date"
    description: "Central Fill Source Last Update Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.quarter_end_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_weeks_in_quarter {
    label: "Central Fill Source Last Update Weeks In Quarter"
    description: "Central Fill Source Last Update Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.weeks_in_quarter} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_year_begin_date {
    label: "Central Fill Source Last Update Year Begin Date"
    description: "Central Fill Source Last Update Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.year_begin_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_year_end_date {
    label: "Central Fill Source Last Update Year End Date"
    description: "Central Fill Source Last Update Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${cf_source_last_update_timeframes.year_end_date} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_weeks_in_year {
    label: "Central Fill Source Last Update Weeks In Year"
    description: "Central Fill Source Last Update Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.weeks_in_year} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_leap_year_flag {
    label: "Central Fill Source Last Update Leap Year Flag"
    description: "Central Fill Source Last Update Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${cf_source_last_update_timeframes.leap_year_flag} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_day_of_quarter {
    label: "Central Fill Source Last Update Day Of Quarter"
    description: "Central Fill Source Last Update Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.day_of_quarter} ;;
    group_label: "Central Fill Source Last Update Date"
  }

  dimension: cf_source_last_update_day_of_year {
    label: "Central Fill Source Last Update Day Of Year"
    description: "Central Fill Source Last Update Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${cf_source_last_update_timeframes.day_of_year} ;;
    group_label: "Central Fill Source Last Update Date"
  }
  ########################################################### Measures ####################################################
  measure: sum_central_fill_filled_quantity {
    label: "Total Central Fill Filled Quantity"
    type: sum
    description: "Total quantity a prescription was actually filled for at the central fill facility. Populated by the system using the information returned from the central fill system. User may not modify. May be different from the prescription written quantity. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILLED_QUANTITY ;;
    value_format: "#,##0.00"
  }

  #[ERXWDPS-6571] - Script count measures for each fill status.
  measure: sum_central_fill_script_count_fill_status_0 {
    label: "Total Central Fill Script Count - Pending"
    type: sum
    description: "Total Scripts with fill status of Pending. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 0 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_1 {
    label: "Total Central Fill Script Count - Sent To Fulfillment"
    type: sum
    description: "Total Scripts with fill status of Sent To Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 1 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_2 {
    label: "Total Central Fill Script Count - In Progress At Fulfillment"
    type: sum
    description: "Total Scripts with fill status of In Progress At Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 2 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_3 {
    label: "Total Central Fill Script Count - Processed By Fulfillment"
    type: sum
    description: "Total Scripts with fill status of Processed By Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 3 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_4 {
    label: "Total Central Fill Script Count - Cancelled By Pharmacy"
    type: sum
    description: "Total Scripts with fill status of Cancelled By Pharmacy. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 4 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_5 {
    label: "Total Central Fill Script Count - Cancelled By Dispensing System"
    type: sum
    description: "Total Scripts with fill status of Cancelled By Dispensing System. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 5 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_6 {
    label: "Total Central Fill Script Count - Cancelled By Fulfillment"
    type: sum
    description: "Total Scripts with fill status of Cancelled By Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 6 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_7 {
    label: "Total Central Fill Script Count - Missing Rx Reported"
    type: sum
    description: "Total Scripts with fill status of Missing Rx Reported. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 7 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_8 {
    label: "Total Central Fill Script Count - Shipped By Fulfillment"
    type: sum
    description: "Total Scripts with fill status of Shipped By Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 8 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_9 {
    label: "Total Central Fill Script Count - Received From Fulfillment"
    type: sum
    description: "Total Scripts with fill status of Received From Fulfillment. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 9 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_10 {
    label: "Total Central Fill Script Count - Complete"
    type: sum
    description: "Total Scripts with fill status of Complete. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 10 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_11 {
    label: "Total Central Fill Script Count - Dispensing System Reject"
    type: sum
    description: "Total Scripts with fill status of Dispensing System Reject. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 11 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: sum_central_fill_script_count_fill_status_12 {
    label: "Total Central Fill Script Count - Fulfillment Suspended"
    type: sum
    description: "Total Scripts with fill status of Fulfillment Suspended. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = 12 THEN 1 ELSE 0 END ;;
    value_format: "#,##0;(#,##0)"
  }

############################################################## Sets ###################################################
  set: exploredx_eps_central_fill_analysis_cal_timeframes {
    fields: [
      cf_completed_date,
      cf_completed_calendar_date,
      cf_completed_chain_id,
      cf_completed_calendar_owner_chain_id,
      cf_completed_yesno,
      cf_completed_day_of_week,
      cf_completed_day_of_month,
      cf_completed_week_of_year,
      cf_completed_month_num,
      cf_completed_month,
      cf_completed_quarter_of_year,
      cf_completed_quarter,
      cf_completed_year,
      cf_completed_day_of_week_index,
      cf_completed_week_begin_date,
      cf_completed_week_end_date,
      cf_completed_week_of_quarter,
      cf_completed_month_begin_date,
      cf_completed_month_end_date,
      cf_completed_weeks_in_month,
      cf_completed_quarter_begin_date,
      cf_completed_quarter_end_date,
      cf_completed_weeks_in_quarter,
      cf_completed_year_begin_date,
      cf_completed_year_end_date,
      cf_completed_weeks_in_year,
      cf_completed_leap_year_flag,
      cf_completed_day_of_quarter,
      cf_completed_day_of_year,
      cf_accepted_date,
      cf_accepted_calendar_date,
      cf_accepted_chain_id,
      cf_accepted_calendar_owner_chain_id,
      cf_accepted_yesno,
      cf_accepted_day_of_week,
      cf_accepted_day_of_month,
      cf_accepted_week_of_year,
      cf_accepted_month_num,
      cf_accepted_month,
      cf_accepted_quarter_of_year,
      cf_accepted_quarter,
      cf_accepted_year,
      cf_accepted_day_of_week_index,
      cf_accepted_week_begin_date,
      cf_accepted_week_end_date,
      cf_accepted_week_of_quarter,
      cf_accepted_month_begin_date,
      cf_accepted_month_end_date,
      cf_accepted_weeks_in_month,
      cf_accepted_quarter_begin_date,
      cf_accepted_quarter_end_date,
      cf_accepted_weeks_in_quarter,
      cf_accepted_year_begin_date,
      cf_accepted_year_end_date,
      cf_accepted_weeks_in_year,
      cf_accepted_leap_year_flag,
      cf_accepted_day_of_quarter,
      cf_accepted_day_of_year,
      cf_cancel_date,
      cf_cancel_calendar_date,
      cf_cancel_chain_id,
      cf_cancel_calendar_owner_chain_id,
      cf_cancel_yesno,
      cf_cancel_day_of_week,
      cf_cancel_day_of_month,
      cf_cancel_week_of_year,
      cf_cancel_month_num,
      cf_cancel_month,
      cf_cancel_quarter_of_year,
      cf_cancel_quarter,
      cf_cancel_year,
      cf_cancel_day_of_week_index,
      cf_cancel_week_begin_date,
      cf_cancel_week_end_date,
      cf_cancel_week_of_quarter,
      cf_cancel_month_begin_date,
      cf_cancel_month_end_date,
      cf_cancel_weeks_in_month,
      cf_cancel_quarter_begin_date,
      cf_cancel_quarter_end_date,
      cf_cancel_weeks_in_quarter,
      cf_cancel_year_begin_date,
      cf_cancel_year_end_date,
      cf_cancel_weeks_in_year,
      cf_cancel_leap_year_flag,
      cf_cancel_day_of_quarter,
      cf_cancel_day_of_year,
      cf_check_in_date,
      cf_check_in_calendar_date,
      cf_check_in_chain_id,
      cf_check_in_calendar_owner_chain_id,
      cf_check_in_yesno,
      cf_check_in_day_of_week,
      cf_check_in_day_of_month,
      cf_check_in_week_of_year,
      cf_check_in_month_num,
      cf_check_in_month,
      cf_check_in_quarter_of_year,
      cf_check_in_quarter,
      cf_check_in_year,
      cf_check_in_day_of_week_index,
      cf_check_in_week_begin_date,
      cf_check_in_week_end_date,
      cf_check_in_week_of_quarter,
      cf_check_in_month_begin_date,
      cf_check_in_month_end_date,
      cf_check_in_weeks_in_month,
      cf_check_in_quarter_begin_date,
      cf_check_in_quarter_end_date,
      cf_check_in_weeks_in_quarter,
      cf_check_in_year_begin_date,
      cf_check_in_year_end_date,
      cf_check_in_weeks_in_year,
      cf_check_in_leap_year_flag,
      cf_check_in_day_of_quarter,
      cf_check_in_day_of_year,
      cf_delivery_date,
      cf_delivery_calendar_date,
      cf_delivery_chain_id,
      cf_delivery_calendar_owner_chain_id,
      cf_delivery_yesno,
      cf_delivery_day_of_week,
      cf_delivery_day_of_month,
      cf_delivery_week_of_year,
      cf_delivery_month_num,
      cf_delivery_month,
      cf_delivery_quarter_of_year,
      cf_delivery_quarter,
      cf_delivery_year,
      cf_delivery_day_of_week_index,
      cf_delivery_week_begin_date,
      cf_delivery_week_end_date,
      cf_delivery_week_of_quarter,
      cf_delivery_month_begin_date,
      cf_delivery_month_end_date,
      cf_delivery_weeks_in_month,
      cf_delivery_quarter_begin_date,
      cf_delivery_quarter_end_date,
      cf_delivery_weeks_in_quarter,
      cf_delivery_year_begin_date,
      cf_delivery_year_end_date,
      cf_delivery_weeks_in_year,
      cf_delivery_leap_year_flag,
      cf_delivery_day_of_quarter,
      cf_delivery_day_of_year,
      cf_dispensed_date,
      cf_dispensed_calendar_date,
      cf_dispensed_chain_id,
      cf_dispensed_calendar_owner_chain_id,
      cf_dispensed_yesno,
      cf_dispensed_day_of_week,
      cf_dispensed_day_of_month,
      cf_dispensed_week_of_year,
      cf_dispensed_month_num,
      cf_dispensed_month,
      cf_dispensed_quarter_of_year,
      cf_dispensed_quarter,
      cf_dispensed_year,
      cf_dispensed_day_of_week_index,
      cf_dispensed_week_begin_date,
      cf_dispensed_week_end_date,
      cf_dispensed_week_of_quarter,
      cf_dispensed_month_begin_date,
      cf_dispensed_month_end_date,
      cf_dispensed_weeks_in_month,
      cf_dispensed_quarter_begin_date,
      cf_dispensed_quarter_end_date,
      cf_dispensed_weeks_in_quarter,
      cf_dispensed_year_begin_date,
      cf_dispensed_year_end_date,
      cf_dispensed_weeks_in_year,
      cf_dispensed_leap_year_flag,
      cf_dispensed_day_of_quarter,
      cf_dispensed_day_of_year,
      cf_pick_up_date,
      cf_pick_up_calendar_date,
      cf_pick_up_chain_id,
      cf_pick_up_calendar_owner_chain_id,
      cf_pick_up_yesno,
      cf_pick_up_day_of_week,
      cf_pick_up_day_of_month,
      cf_pick_up_week_of_year,
      cf_pick_up_month_num,
      cf_pick_up_month,
      cf_pick_up_quarter_of_year,
      cf_pick_up_quarter,
      cf_pick_up_year,
      cf_pick_up_day_of_week_index,
      cf_pick_up_week_begin_date,
      cf_pick_up_week_end_date,
      cf_pick_up_week_of_quarter,
      cf_pick_up_month_begin_date,
      cf_pick_up_month_end_date,
      cf_pick_up_weeks_in_month,
      cf_pick_up_quarter_begin_date,
      cf_pick_up_quarter_end_date,
      cf_pick_up_weeks_in_quarter,
      cf_pick_up_year_begin_date,
      cf_pick_up_year_end_date,
      cf_pick_up_weeks_in_year,
      cf_pick_up_leap_year_flag,
      cf_pick_up_day_of_quarter,
      cf_pick_up_day_of_year,
      cf_status_date,
      cf_status_calendar_date,
      cf_status_chain_id,
      cf_status_calendar_owner_chain_id,
      cf_status_yesno,
      cf_status_day_of_week,
      cf_status_day_of_month,
      cf_status_week_of_year,
      cf_status_month_num,
      cf_status_month,
      cf_status_quarter_of_year,
      cf_status_quarter,
      cf_status_year,
      cf_status_day_of_week_index,
      cf_status_week_begin_date,
      cf_status_week_end_date,
      cf_status_week_of_quarter,
      cf_status_month_begin_date,
      cf_status_month_end_date,
      cf_status_weeks_in_month,
      cf_status_quarter_begin_date,
      cf_status_quarter_end_date,
      cf_status_weeks_in_quarter,
      cf_status_year_begin_date,
      cf_status_year_end_date,
      cf_status_weeks_in_year,
      cf_status_leap_year_flag,
      cf_status_day_of_quarter,
      cf_status_day_of_year,
      cf_source_create_date,
      cf_source_create_calendar_date,
      cf_source_create_chain_id,
      cf_source_create_calendar_owner_chain_id,
      cf_source_create_yesno,
      cf_source_create_day_of_week,
      cf_source_create_day_of_month,
      cf_source_create_week_of_year,
      cf_source_create_month_num,
      cf_source_create_month,
      cf_source_create_quarter_of_year,
      cf_source_create_quarter,
      cf_source_create_year,
      cf_source_create_day_of_week_index,
      cf_source_create_week_begin_date,
      cf_source_create_week_end_date,
      cf_source_create_week_of_quarter,
      cf_source_create_month_begin_date,
      cf_source_create_month_end_date,
      cf_source_create_weeks_in_month,
      cf_source_create_quarter_begin_date,
      cf_source_create_quarter_end_date,
      cf_source_create_weeks_in_quarter,
      cf_source_create_year_begin_date,
      cf_source_create_year_end_date,
      cf_source_create_weeks_in_year,
      cf_source_create_leap_year_flag,
      cf_source_create_day_of_quarter,
      cf_source_create_day_of_year,
      cf_source_last_update_date,
      cf_source_last_update_calendar_date,
      cf_source_last_update_chain_id,
      cf_source_last_update_calendar_owner_chain_id,
      cf_source_last_update_yesno,
      cf_source_last_update_day_of_week,
      cf_source_last_update_day_of_month,
      cf_source_last_update_week_of_year,
      cf_source_last_update_month_num,
      cf_source_last_update_month,
      cf_source_last_update_quarter_of_year,
      cf_source_last_update_quarter,
      cf_source_last_update_year,
      cf_source_last_update_day_of_week_index,
      cf_source_last_update_week_begin_date,
      cf_source_last_update_week_end_date,
      cf_source_last_update_week_of_quarter,
      cf_source_last_update_month_begin_date,
      cf_source_last_update_month_end_date,
      cf_source_last_update_weeks_in_month,
      cf_source_last_update_quarter_begin_date,
      cf_source_last_update_quarter_end_date,
      cf_source_last_update_weeks_in_quarter,
      cf_source_last_update_year_begin_date,
      cf_source_last_update_year_end_date,
      cf_source_last_update_weeks_in_year,
      cf_source_last_update_leap_year_flag,
      cf_source_last_update_day_of_quarter,
      cf_source_last_update_day_of_year
    ]
  }

  set: exploredx_central_fill_looker_default_timeframes {
    fields: [
      central_fill_completed_time,
      central_fill_completed_date,
      central_fill_completed_week,
      central_fill_completed_month,
      central_fill_completed_month_num,
      central_fill_completed_year,
      central_fill_completed_quarter,
      central_fill_completed_quarter_of_year,
      central_fill_completed,
      central_fill_completed_hour_of_day,
      central_fill_completed_time_of_day,
      central_fill_completed_hour2,
      central_fill_completed_minute15,
      central_fill_completed_day_of_week,
      central_fill_completed_week_of_year,
      central_fill_completed_day_of_week_index,
      central_fill_completed_day_of_month,
      central_fill_accepted_time,
      central_fill_accepted_date,
      central_fill_accepted_week,
      central_fill_accepted_month,
      central_fill_accepted_month_num,
      central_fill_accepted_year,
      central_fill_accepted_quarter,
      central_fill_accepted_quarter_of_year,
      central_fill_accepted,
      central_fill_accepted_hour_of_day,
      central_fill_accepted_time_of_day,
      central_fill_accepted_hour2,
      central_fill_accepted_minute15,
      central_fill_accepted_day_of_week,
      central_fill_accepted_day_of_month,
      central_fill_cancel_time,
      central_fill_cancel_date,
      central_fill_cancel_week,
      central_fill_cancel_month,
      central_fill_cancel_month_num,
      central_fill_cancel_year,
      central_fill_cancel_quarter,
      central_fill_cancel_quarter_of_year,
      central_fill_cancel,
      central_fill_cancel_hour_of_day,
      central_fill_cancel_time_of_day,
      central_fill_cancel_hour2,
      central_fill_cancel_minute15,
      central_fill_cancel_day_of_week,
      central_fill_cancel_week_of_year,
      central_fill_cancel_day_of_week_index,
      central_fill_cancel_day_of_month,
      central_fill_check_in_time,
      central_fill_check_in_date,
      central_fill_check_in_week,
      central_fill_check_in_month,
      central_fill_check_in_month_num,
      central_fill_check_in_year,
      central_fill_check_in_quarter,
      central_fill_check_in_quarter_of_year,
      central_fill_check_in,
      central_fill_check_in_hour_of_day,
      central_fill_check_in_time_of_day,
      central_fill_check_in_hour2,
      central_fill_check_in_minute15,
      central_fill_check_in_day_of_week,
      central_fill_check_in_week_of_year,
      central_fill_check_in_day_of_week_index,
      central_fill_check_in_day_of_month,
      central_fill_delivery_time,
      central_fill_delivery_date,
      central_fill_delivery_week,
      central_fill_delivery_month,
      central_fill_delivery_month_num,
      central_fill_delivery_year,
      central_fill_delivery_quarter,
      central_fill_delivery_quarter_of_year,
      central_fill_delivery,
      central_fill_delivery_hour_of_day,
      central_fill_delivery_time_of_day,
      central_fill_delivery_hour2,
      central_fill_delivery_minute15,
      central_fill_delivery_day_of_week,
      central_fill_delivery_week_of_year,
      central_fill_delivery_day_of_week_index,
      central_fill_delivery_day_of_month,
      central_fill_dispensed_time,
      central_fill_dispensed_date,
      central_fill_dispensed_week,
      central_fill_dispensed_month,
      central_fill_dispensed_month_num,
      central_fill_dispensed_year,
      central_fill_dispensed_quarter,
      central_fill_dispensed_quarter_of_year,
      central_fill_dispensed,
      central_fill_dispensed_hour_of_day,
      central_fill_dispensed_time_of_day,
      central_fill_dispensed_hour2,
      central_fill_dispensed_minute15,
      central_fill_dispensed_day_of_week,
      central_fill_dispensed_week_of_year,
      central_fill_dispensed_day_of_week_index,
      central_fill_dispensed_day_of_month,
      central_fill_pick_up_time,
      central_fill_pick_up_date,
      central_fill_pick_up_week,
      central_fill_pick_up_month,
      central_fill_pick_up_month_num,
      central_fill_pick_up_year,
      central_fill_pick_up_quarter,
      central_fill_pick_up_quarter_of_year,
      central_fill_pick_up,
      central_fill_pick_up_hour_of_day,
      central_fill_pick_up_time_of_day,
      central_fill_pick_up_hour2,
      central_fill_pick_up_minute15,
      central_fill_pick_up_day_of_week,
      central_fill_pick_up_week_of_year,
      central_fill_pick_up_day_of_week_index,
      central_fill_pick_up_day_of_month,
      central_fill_status_updated_time,
      central_fill_status_updated_date,
      central_fill_status_updated_week,
      central_fill_status_updated_month,
      central_fill_status_updated_month_num,
      central_fill_status_updated_year,
      central_fill_status_updated_quarter,
      central_fill_status_updated_quarter_of_year,
      central_fill_status_updated,
      central_fill_status_updated_hour_of_day,
      central_fill_status_updated_time_of_day,
      central_fill_status_updated_hour2,
      central_fill_status_updated_minute15,
      central_fill_status_updated_day_of_week,
      central_fill_status_updated_week_of_year,
      central_fill_status_updated_day_of_week_index,
      central_fill_status_updated_day_of_month,
      source_create_timestamp_time,
      source_create_timestamp_date,
      source_create_timestamp_week,
      source_create_timestamp_month,
      source_create_timestamp_month_num,
      source_create_timestamp_year,
      source_create_timestamp_quarter,
      source_create_timestamp_quarter_of_year,
      source_create_timestamp_hour_of_day,
      source_create_timestamp_time_of_day,
      source_create_timestamp_day_of_week,
      source_create_timestamp_week_of_year,
      source_create_timestamp_day_of_week_index,
      source_create_timestamp_day_of_month,
      source_create_timestamp_day_of_year,
      source_create_timestamp_hour,
      source_create_timestamp_minute,
      source_create_timestamp_month_name,
      source_create_timestamp_month_num,
      source_timestamp_time,
      source_timestamp_date,
      source_timestamp_week,
      source_timestamp_month,
      source_timestamp_month_num,
      source_timestamp_year,
      source_timestamp_quarter,
      source_timestamp_quarter_of_year,
      source_timestamp,
      source_timestamp_hour_of_day,
      source_timestamp_time_of_day,
      source_timestamp_hour2,
      source_timestamp_minute15,
      source_timestamp_day_of_week,
      source_timestamp_week_of_year,
      source_timestamp_day_of_week_index,
      source_timestamp_day_of_month
    ]
  }
}

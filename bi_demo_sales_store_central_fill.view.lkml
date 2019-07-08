#ERXLPS-1349 #ERXLPS-1383
view: bi_demo_sales_store_central_fill {
  label: "Central Fill - Store"
  sql_table_name: EDW.F_CENTRAL_FILL ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${central_fill_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;;
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
    label: "Central Fill Id"
    type: number
    hidden: yes
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
    label: "Check In User Id"
    type: number
    hidden: yes
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
    description: "ID of the patient record associated with a central fill record. Populated by the system using the patient information in memory when a central fill record is created. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: responsible_party_patient_id {
    label: "Responsible Party Patient Id"
    type: number
    hidden: yes
    description: "ID of the responsible party record associated with a central fill record. Populated by the system using the responsible party information in memory when a central fill record is created. EPS Table: CENTRAL_FILL"
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
    description: "Date and time a central fill prescription is scheduled to be picked up by the patient. Calculated by the system when a central fill record is added or updated.  User may modify the system calculated value. EPS Table: CENTRAL_FILL"
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
    hidden: yes
    description: "Initials of user who checked in to the central fill queue.  Populated by the system with the user who performs the check in function. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_CHECK_IN_USER_INITIALS ;;
  }

    dimension: central_fill_status {
      label: "Central Fill Status"
      type: string
      description: "Status of a central fill record in the central fill queue. Updated by the system using information received from the central fill facility. EPS Table: CENTRAL_FILL"
      sql: CASE WHEN ${TABLE}.CENTRAL_FILL_STATUS = '0'  THEN 'PENDING'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '1'  THEN 'SENT TO FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '2'  THEN 'IN PROGRESS AT FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '3'  THEN 'PROCESSED BY FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '4'  THEN 'CANCELLED BY PHARMACY'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '5'  THEN 'CANCELLED BY DISPENSING SYSTEM'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '6'  THEN 'CANCELLED BY FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '7'  THEN 'MISSING RX REPORTED'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '8'  THEN 'SHIPPED BY FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '9'  THEN 'RECEIVED FROM FULFILLMENT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '10' THEN 'COMPLETE'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '11' THEN 'DISPENSING SYSTEM REJECT'
                WHEN ${TABLE}.CENTRAL_FILL_STATUS = '12' THEN 'FULFILLMENT SUSPENDED'
                ELSE TO_CHAR(${TABLE}.CENTRAL_FILL_STATUS) --Added else condition to display DB value if master code values are not available.
            END ;;
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

  dimension: central_fill_system_error_code {
    label: "Central Fill System Error Code"
    type: string
    description: "Error code returned from the central fill system. Populated by the system using the information returned from the central fill system"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ND' THEN 'NDC NOT FOUND'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'NF' THEN 'NON-FORMULARY NDC'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'PE' THEN 'PARSING ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ME' THEN 'MISCELLANEOUS ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'RM' THEN 'MISSING RX'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'FR' THEN 'FOUND RX'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'ST' THEN 'STORE NOT ELIGIBLE'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'TU' THEN 'REQUEST UNDEFINED'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'CF' THEN 'CF ERROR'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'DQ' THEN 'INADEQUATE DRUG INVENTORY'
              WHEN ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE = 'CE' THEN 'COMMUNICATIONS ERROR'
              ELSE ${TABLE}.CENTRAL_FILL_SYSTEM_ERROR_CODE --Added else condition to display DB value if master code values are not available.
          END ;;
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

  dimension: central_fill_missing_from_delivery {
    label: "Central Fill Missing From Delivery"
    type: string
    description: "Flag indicating if a prescription was missing when an order was checked in. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: CASE WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY IS NULL THEN 'NOT MISSING'
              WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY = 'F' THEN 'FLAGGED MISSING BUT FOUND'
              WHEN ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY = 'Y' THEN 'MISSING'
              ELSE ${TABLE}.CENTRAL_FILL_MISSING_FROM_DELIVERY --Added else condition to display DB value if master code values are not available.
          END ;;
  }

  dimension: central_fill_fill_operator {
    label: "Central Fill Fill Operator"
    type: string
    hidden: yes
    description: "Central fill operator or technician responsible for filling a prescription at the central fill facility. Populated by the system using the information returned from the central fill system. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR ;;
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

  dimension: central_fill_destination {
    label: "Central Fill Destination"
    type: string
    description: "Home Delivery or Pharmacy Delivery. Populated by the system when the record is created. Determined by the Pickup Type. EPS Table: CENTRAL_FILL"
    sql:  CASE WHEN ${TABLE}.CENTRAL_FILL_DESTINATION IS NULL THEN 'NOT SPECIFIED'
               WHEN ${TABLE}.CENTRAL_FILL_DESTINATION = 'H' THEN 'HOME DELIVERY'
               WHEN ${TABLE}.CENTRAL_FILL_DESTINATION = 'S' THEN 'STORE DELIVERY'
               ELSE ${TABLE}.CENTRAL_FILL_DESTINATION
           END ;;
  }

  dimension: central_fill_fill_operator_employee {
    label: "Central Fill Fill Operator Employee"
    type: string
    hidden: yes
    description: "Employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE ;;
  }

  dimension: central_fill_fill_operator_employee_initials {
    label: "Central Fill Fill Operator Employee Initials"
    type: string
    hidden: yes
    description: "Initials of the employee at the fulfillment facility who operated the automated dispensing equipment. Populated by the system when processing a Status Update response. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILL_OPERATOR_EMPLOYEE_INITIALS ;;
  }

  dimension_group: central_fill_completed {
    label: "Central Fill Completed"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
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

  ########################################################### Measures ####################################################
  measure: sum_central_fill_filled_quantity {
    label: "Total Central Fill Filled Quantity"
    type: sum
    description: "Total quantity a prescription was actually filled for at the central fill facility. Populated by the system using the information returned from the central fill system. User may not modify. May be different from the prescription written quantity. EPS Table: CENTRAL_FILL"
    sql: ${TABLE}.CENTRAL_FILL_FILLED_QUANTITY ;;
    value_format: "#,##0.00"
  }
}

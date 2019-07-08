view: store_rx_status_change {
  label: "Rx Status Change"
  sql_table_name: EDW.F_RX_STATUS_CHANGE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${rx_status_change_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain. EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }


  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_status_change_id {
    label: "Rx Status Change Id"
    description: "Unique ID number identifying each record in this table. EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_STATUS_CHANGE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying an BI source system. EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: rx_id {
    label: "Rx Id"
    description: "Foreign key to record in Prescription (RXF) table when record is inserted into table (positive integer). EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_status_change_reason_code {
    label: "Rx Status Change Reason Code"
    description: "Enumerated values of reasons prescription was deactivated/re-activate. EPS Table: RX_STATUS_CHANGE"
    type: string
    sql: CASE WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'S' THEN 'S - STORE TRANSFER'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'A' THEN 'A - AUTOTANSFER'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'D' THEN 'D - DEACTIVATED BY PRESCIBER'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'P' THEN 'P - DEACTIVATE BY PHARMACIST'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'N' THEN 'N - NEVER PICKED UP'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'R' THEN 'R - RETURNED HARD COPY'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'E' THEN 'E - DEACTIVATED FOR ERROR CORRECTION'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'C' THEN 'C - CONVERSION'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'T' THEN 'T - RX STOLEN'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE = 'Q' THEN 'Q - PATIENT REQUEST'
              WHEN ${TABLE}.RX_STATUS_CHANGE_REASON_CODE is null THEN 'ACTIVE'
              ELSE TO_CHAR(${TABLE}.RX_STATUS_CHANGE_REASON_CODE)
         END ;;
  }

  dimension: rx_status_change_deactivate_reason_code {
    label: "Rx Status Change Deactivate Reason Code"
    description: "This will hold the additional reason selected when a prescription is deactivated by a Pharmacist. System Generated based upon the deactivate reason selected from the Reject dialogue. EPS Table: RX_STATUS_CHANGE"
    type: string
    sql: CASE WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE = 'S' THEN 'S - CORRESPONDING RESPONSIBILITY'
              WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE = 'P' THEN 'P - PHARMACIST'S DISCRETION'
              WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE = 'C' THEN 'C - CORPORATE DISCRETION'
              WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE = 'O' THEN 'O - OUT OF STOCK'
              WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE = 'R' THEN 'R - PRICE'
              WHEN ${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE is null THEN 'NOT SPECIFIED'
              ELSE TO_CHAR(${TABLE}.RX_STATUS_CHANGE_DEACTIVATE_REASON_CODE)
         END ;;
  }

  dimension: rx_status_change_type {
    label: "Rx Status Change Type"
    description: "Enumerated value of prescription status; toggles between Active and Deactivated. This indicates the most recent state change of the prescription from Active/Deactivated to Deactivated/Active. EPS Table: RX_STATUS_CHANGE"
    type: string
    sql: CASE WHEN ${TABLE}.RX_STATUS_CHANGE_TYPE = 'A' THEN 'A - ACTIVE'
              WHEN ${TABLE}.RX_STATUS_CHANGE_TYPE = 'D' THEN 'D - DEACTIVATED'
              ELSE TO_CHAR(${TABLE}.RX_STATUS_CHANGE_TYPE)
         END ;;
  }

  dimension_group: rx_status_change {
    label: "Rx Status Change"
    description: "Date/Time of insertion of this record into table; supplied by pharmacy system when record is created. This orders a prescriptions status changes chronologically. EPS Table: RX_STATUS_CHANGE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.RX_STATUS_CHANGE_DATE ;;
  }

  dimension: notes_id {
    label: "Notes Id"
    description: "Foreign key to record in NOTES table supplied by pharmacy application when a NOTES record is created and associated with the RX_STATUS_CAHNGE record. This captures any notes deemed necessary to supplement the REASON_CODE. EPS Table: RX_STATUS_CHANGE"
    type: number
    hidden: yes
    sql: ${TABLE}.NOTES_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Rx Status Change Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: RX_STATUS_CHANGE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Rx Status Change Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: RX_STATUS_CHANGE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: is_active {
    label: "Is Active"
    description: "Indicates whether or not the inserted/updated the record in EDW is from the currently active client system for this dataset. EPS Table: RX_STATUS_CHANGE"
    type: string
    sql: ${TABLE}.IS_ACTIVE ;;
  }

}

view: store_central_fill_delivery_schedule {
  label: "Store Central Fill Delivery Schedule"
  sql_table_name: EDW.D_STORE_CENTRAL_FILL_DELIVERY_SCHEDULE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_central_fill_delivery_schedule_id} ;;
  }

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_central_fill_delivery_schedule_id {
    label: "Store Central Fill Delivery Schedule ID"
    description: "Unique Id number identifying this record. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_central_fill_delivery_schedule_cut_off_day_of_week {
    label: "Store Central Fill Delivery Schedule Cut Off Day Of Week"
    description: "Cut off day. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_ID is NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '0' THEN '0 - SUNDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '1' THEN '1 - MONDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '2' THEN '2 - TUESDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '3' THEN '3 - WEDNESDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '4' THEN '4 - THURSDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '5' THEN '5 - FRIDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK = '6' THEN '6 - SATURDAY'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["0 - SUNDAY","1 - MONDAY","2 - TUESDAY","3 - WEDNESDAY","4 - THURSDAY","5 - FRIDAY","6 - SATURDAY"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_central_fill_delivery_schedule_cut_off_day_of_week_reference]
  }

  dimension: store_central_fill_delivery_schedule_cut_off_day_of_week_reference {
    label: "Store Central Fill Delivery Schedule Cut Off Day Of Week Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_DAY_OF_WEEK ;;
  }

  dimension: store_central_fill_delivery_schedule_delivery_day_of_week {
    label: "Store Central Fill Delivery Schedule Delivery Day Of Week"
    description: "Day of the week prescriptions will be delivered from the central fill facility. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_ID is NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '0' THEN '0 - SUNDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '1' THEN '1 - MONDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '2' THEN '2 - TUESDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '3' THEN '3 - WEDNESDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '4' THEN '4 - THURSDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '5' THEN '5 - FRIDAY'
              WHEN ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK = '6' THEN '6 - SATURDAY'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["0 - SUNDAY","1 - MONDAY","2 - TUESDAY","3 - WEDNESDAY","4 - THURSDAY","5 - FRIDAY","6 - SATURDAY"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_central_fill_delivery_schedule_delivery_day_of_week_reference]
  }

  dimension: store_central_fill_delivery_schedule_delivery_day_of_week_reference {
    label: "Store Central Fill Delivery Schedule Delivery Day Of Week Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_DAY_OF_WEEK ;;
  }

  dimension: store_central_fill_delivery_schedule_drug_purchase_order_number {
    label: "Store Central Fill Delivery Schedule Drug Purchase Order Number"
    description: "Purchase order number assigned to the prescriptions transferred to the central fill facility during the time defined by a delivery schedule record. NOTE: THIS COLUMN IS NOT USED BY EPS. THIS IS A RELIC FROM PDX. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DRUG_PURCHASE_ORDER_NUMBER ;;
  }

  dimension_group: store_central_fill_delivery_schedule_purchase_order_cut_off {
    label: "Store Central Fill Delivery Schedule Purchase Order Cut Off"
    description: "Date the system uses the purchase order number in the Drug_Order_PO_Number element when creating drug reorder records. NOTE: THIS COLUMN IS NOT USED BY EPS. THIS IS A RELIC FROM PDX. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_PURCHASE_ORDER_CUT_OFF_DATE ;;
  }

  dimension: store_central_fill_delivery_schedule_route_code {
    label: "Store Central Fill Delivery Schedule Route Code"
    description: "Delivery schedule route code used to indicate the route number which the delivery truck takes to deliver the prescriptions to this store. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_ROUTE_CODE ;;
  }

  dimension: store_central_fill_delivery_schedule_stop_number {
    label: "Store Central Fill Delivery Schedule Stop Number"
    description: "Stop number for the delivery truck. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: number
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_STOP_NUMBER ;;
  }

  dimension_group: store_central_fill_delivery_schedule_one_time {
    label: "Store Central Fill Delivery Schedule One Time"
    description: "Specific date that this delivery schedule is defined for. Overrides a general-day-of-the-week record. The system first looks for a record with a specific date. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_ONE_TIME_DATE ;;
  }

  dimension: store_central_fill_delivery_schedule_cut_off_time_of_day {
    label: "Store Central Fill Delivery Schedule Cut Off Time Of Day"
    description: "Cut off time. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_CUT_OFF_TIME_OF_DAY ;;
  }

  dimension: store_central_fill_delivery_schedule_delivery_time_of_day {
    label: "Store Central Fill Delivery Schedule Delivery Time Of Day"
    description: "Time of day prescriptions will be delivered from the central fill facility. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: string
    sql: ${TABLE}.STORE_CENTRAL_FILL_DELIVERY_SCHEDULE_DELIVERY_TIME_OF_DAY ;;
  }

  dimension_group: source {
    label: "Central Fill Delivery Schedule Source Last Update"
    description: "This is the date and time that the record was last updated from the source. This date is used for central data analysis. EPS Table Name: CF_DELIVERY_SCHEDULE"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  #Derived dimensions based on sql attached in ERXDWPS-6802 US.
  dimension_group: central_fill_cutoff_timestamp {
    label: "Central Fill Cutoff Timestamp"
    description: "Central fill cutoff timestamp"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: case when ${store_central_fill_delivery_schedule_cut_off_time_of_day} is null
              then to_timestamp(cast(cast(${eps_line_item.line_item_source_create_date} as date) as varchar) || ' 23:59:59','yyyy-mm-dd hh24:mi:ss')
              else to_timestamp(cast(cast(${eps_line_item.line_item_source_create_date} as date) as varchar) || ' ' || ${store_central_fill_delivery_schedule_cut_off_time_of_day}||':00','yyyy-mm-dd hh24:mi:ss')
           end ;;
  }

  dimension_group: central_fill_delivery_timestamp {
    label: "Central Fill Delivery Timestamp"
    description: "Central fill delivery timestamp"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: case when ${store_central_fill_delivery_schedule_delivery_time_of_day} is null
              then dateadd(day,2,to_timestamp(cast(cast(${eps_line_item.line_item_source_create_date} as date) as varchar) || ' ' || ' 23:59:59','yyyy-mm-dd hh24:mi:ss'))
              else dateadd(day,(${store_central_fill_delivery_schedule_delivery_day_of_week_reference} - ${store_central_fill_delivery_schedule_cut_off_day_of_week_reference}),to_timestamp(cast(cast(${eps_line_item.line_item_source_create_date} as date) as varchar) || ' 14:30:00','yyyy-mm-dd hh24:mi:ss'))
           end ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW."
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW."
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW."
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

############################################################ END OF DIMENSIONS ############################################################

}

view: store_pickup_type {
  label: "Pickup Type"
  sql_table_name: EDW.D_PICKUP_TYPE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${pickup_type_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PICKUP_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PICKUP_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: pickup_type_id {
    label: "Pickup Type Id"
    description: "Unique ID number identfying this record. EPS Table: PICKUP_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.PICKUP_TYPE_ID ;;
  }

  dimension: pickup_type_code {
    label: "Pickup Type Code"
    description: "Pickup type code is the number assigned to each custom pickup type in EPS. EPS Table: PICKUP_TYPE"
    type: number
    sql: ${TABLE}.PICKUP_TYPE_CODE ;;
    value_format: "0"
  }

  dimension: pickup_type_description {
    label: "Pickup Type Description"
    description: "Description used to identify each pickup type. (user defined). EPS Table: PICKUP_TYPE"
    type: string
    sql: ${TABLE}.PICKUP_TYPE_DESCRIPTION ;;
  }

  dimension: pickup_type_promised_time_type {
    label: "Pickup Type Promised Time Type"
    description: "Corresponds to the promised time calculation type used in EPS. EPS Table: PICKUP_TYPE"
    type: string
    sql: CASE WHEN ${TABLE}.PICKUP_TYPE_PROMISED_TIME_TYPE = 'A' THEN 'A - ADD-ON'
              WHEN ${TABLE}.PICKUP_TYPE_PROMISED_TIME_TYPE = 'E' THEN 'E - EXACT TIME'
              WHEN ${TABLE}.PICKUP_TYPE_PROMISED_TIME_TYPE = 'O' THEN 'O - PRESCRIPTION BASED'
              ELSE ${TABLE}.PICKUP_TYPE_PROMISED_TIME_TYPE
         END ;;
    suggestions: ["A - ADD-ON", "E - EXACT TIME", "O - PRESCRIPTION BASED"]
  }

  dimension: pickup_type_acs_priority {
    label: "Pickup Type ACS Priority"
    description: "The number assigned to each pickup type to communicate the priority in which each prescription needs to be sent to the automated counting machine. Valid values for this field are 1-9. 1=most urgent 9=least urgent. EPS Table: PICKUP_TYPE"
    type: number
    sql: ${TABLE}.PICKUP_TYPE_ACS_PRIORITY ;;
  }

  dimension: pickup_type_priority {
    label: "Pickup Type Priority"
    description: "Used in conjunction with promised time to determine'get next'priority. EPS Table: PICKUP_TYPE"
    type: number
    sql: ${TABLE}.PICKUP_TYPE_PRIORITY ;;
  }

  dimension: pickup_type_exact_cutoff_time {
    label: "Pickup Type Exact Cutoff Time"
    description: "Determines the Exact Promised Time by comparing the current time for the order being entered to the Exact Cutoff Time."
    type: string
    sql: ${TABLE}.PICKUP_TYPE_EXACT_CUTOFF_TIME ;;
  }

  dimension: pickup_type_exact_promised_time {
    label: "Pickup Type Exact Promised Time"
    description: "Sets the promised time on an order to this time and sets the date by evaluating the current time and the Exact Cutoff Time."
    type: string
    sql: ${TABLE}.PICKUP_TYPE_EXACT_PROMISED_TIME ;;
  }

  dimension: pickup_type_include_cf_delivery_schedule {
    label: "Pickup Type Include CF Delivery Schedule"
    description: "Allows a user to create a pick-up type that will always use the fulfillment center delivery schedule when calculating promised time. EPS Table: PICKUP_TYPE"
    type: string
    sql: CASE WHEN ${TABLE}.PICKUP_TYPE_INCLUDE_CF_DELIVERY_SCHEDULE = 'Y' THEN 'Y - USE FULFILLMENT CENTER DELIVERY SCHEDULE'
              WHEN ${TABLE}.PICKUP_TYPE_INCLUDE_CF_DELIVERY_SCHEDULE = 'N' THEN 'N - USE LOCAL STORE DELIVERY SCHEDULE'
              ELSE ${TABLE}.PICKUP_TYPE_INCLUDE_CF_DELIVERY_SCHEDULE
         END ;;
    suggestions: ["Y - USE FULFILLMENT CENTER DELIVERY SCHEDULE", "N - USE LOCAL STORE DELIVERY SCHEDULE"]
  }

  dimension: pickup_type_delivery_type {
    label: "Pickup Type Delivery Type"
    description: "Determines how a patient is expecting to receive their prescription/order. EPS Table: PICKUP_TYPE"
    type: string
    sql: CASE WHEN ${TABLE}.PICKUP_TYPE_DELIVERY_TYPE = 'I' THEN 'I - IN-STORE'
              WHEN ${TABLE}.PICKUP_TYPE_DELIVERY_TYPE = 'D' THEN 'D - DELIVERY'
              WHEN ${TABLE}.PICKUP_TYPE_DELIVERY_TYPE = 'S' THEN 'S - SHIPPING'
              ELSE ${TABLE}.PICKUP_TYPE_DELIVERY_TYPE
         END ;;
    suggestions: ["I - IN-STORE", "D - DELIVERY", "S - SHIPPING"]
  }

  dimension: pickup_type_store_setting_name {
    label: "Pickup Type Store Setting Name"
    description: "This value corresponds with the EPS-side store setting values and is part of what determines whether the pickup types promised time calculations are set for all stores or store-specific. EPS Table: PICKUP_TYPE"
    type: string
    sql: ${TABLE}.PICKUP_TYPE_STORE_SETTING_NAME ;;
  }

  dimension_group: pickup_type_deactivated {
    label: "Pickup Type Deactivated"
    description: "The date/Time by which you have deactivated a pickup type. EPS Table: PICKUP_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.PICKUP_TYPE_DEACTIVATED_DATE ;;
  }

  #[ERXLPS-6216] - Pickup Type informtion exposed from eps_order_entry.order_entry_pickup_type_id dimension by referencing to store_pickup_type.pickup_type_display_name dimension. Most of the existing prod reports are referencing the order_entry dimension and require saved looks/dashboard changes to modify the reference..
  dimension: pickup_type_display_name {
    label: "Pickup Type Display Name"
    description: "The display name given to each pickup type. This is customizable to say whatever the user wants to name it. EPS Table: PICKUP_TYPE"
    type: string
    hidden: yes
    sql: UPPER(${TABLE}.PICKUP_TYPE_DISPLAY_NAME) ;; #[ERXLPS-6216]
  }

  dimension_group: source_timestamp {
    label: "Pickup Type Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PICKUP_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: pickup_type_order_based_delay_minutes {
    label: "Pickup Type Order Based Delay Minutes"
    description: "Value added to each pickup type in the ECC when determining the amount of minutes to add on to the promised time calculations. EPS Table: PICKUP_TYPE"
    type: number
    sql: ${TABLE}.PICKUP_TYPE_ORDER_BASED_DELAY_MINUTES ;;
  }

  dimension: pickup_type_add_on_delay_minutes {
    label: "Pickup Type Add On Delay Minutes"
    description: "Value added to each pickup type in the ECC when determining the amount of minutes to add on to the promised time calculations. EPS Table: PICKUP_TYPE"
    type: number
    sql: ${TABLE}.PICKUP_TYPE_ADD_ON_DELAY_MINUTES ;;
  }
}

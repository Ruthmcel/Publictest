view: store_cycle_count {
  label: "Store Cycle Count"
  sql_table_name: EDW.F_STORE_CYCLE_COUNT ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_cycle_count_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CYCLE_COUNT"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CYCLE_COUNT"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_cycle_count_id {
    label: "Store Cycle Count Id"
    description: "Unique Id number identifying this record. EPS Table: CYCLE_COUNT"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_CYCLE_COUNT_ID ;;
  }

  dimension: store_cycle_count_ndc {
    label: "Store Cycle Count Ndc"
    description: "NDC of the drug for which cycle count needs to be performed. EPS Table: CYCLE_COUNT"
    type: string
    sql: ${TABLE}.STORE_CYCLE_COUNT_NDC ;;
  }

  dimension_group: store_cycle_count_promised {
    label: "Store Cycle Count Promised"
    description: "Date and time a cycle count is expected to be completed for particular NDC. EPS Table: CYCLE_COUNT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CYCLE_COUNT_PROMISED_DATE ;;
  }

  dimension: store_cycle_count_priority {
    label: "Store Cycle Count Priority"
    description: "This filed is sent by Turn Rx. Its not being used in EPS. Its used in PDX pharmacy to decide when to work on a particular NDC cycle count record. EPS Table: CYCLE_COUNT"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CYCLE_COUNT_PRIORITY ;;
  }

  dimension_group: store_cycle_count_expiration {
    label: "Store Cycle Count Expiration"
    description: "Date on which a pending cycle count task should be marked as expired and user should not get this task to work on. EPS Table: CYCLE_COUNT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CYCLE_COUNT_EXPIRATION_DATE ;;
  }

  dimension: store_cycle_count_pickup_type_code {
    label: "Store Cycle Count Pickup Type Code"
    description: "This field is needed in case dynamic prioritization is enabled on store. EPS Table: CYCLE_COUNT"
    type: number
    sql: ${TABLE}.STORE_CYCLE_COUNT_PICKUP_TYPE_CODE ;;
  }

  dimension: store_cycle_count_central_inventory_event_identifier {
    label: "Store Cycle Count Central Inventory Event Identifier"
    description: "Event Identifier send by TurnRx to EPS in cycle count request to identify a particular cycle count. EPS Table: CYCLE_COUNT"
    type: number
    sql: ${TABLE}.STORE_CYCLE_COUNT_CENTRAL_INVENTORY_EVENT_IDENTIFIER ;;
  }

  dimension_group: store_cycle_count_central_inventory_publish {
    label: "Store Cycle Count Central Inventory Publish"
    description: "Publish timestamp send by TurnRx to EPS in cycle count request to identify a particular cycle count. EPS Table: CYCLE_COUNT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_CYCLE_COUNT_CENTRAL_INVENTORY_PUBLISH_DATE ;;
  }

  dimension: store_cycle_count_status {
    label: "Store Cycle Count Status"
    description: "Shows the status of a particular cycle count record. EPS Table: CYCLE_COUNT"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_CYCLE_COUNT_STATUS is null THEN 'UNKNOWN'
              WHEN ${TABLE}.STORE_CYCLE_COUNT_STATUS = '1' THEN '1 - PENDING'
              WHEN ${TABLE}.STORE_CYCLE_COUNT_STATUS = '2' THEN '2 - COMPLETED'
              WHEN ${TABLE}.STORE_CYCLE_COUNT_STATUS = '3' THEN '3 - EXPIRED'
              WHEN ${TABLE}.STORE_CYCLE_COUNT_STATUS = '4' THEN '4 - INVALID'
              ELSE TO_CHAR(${TABLE}.STORE_CYCLE_COUNT_STATUS)
         END ;;
  }

  dimension: drug_id {
    label: "Drug Id"
    description: "ID of the drug record with matching NDC. EPS Table: CYCLE_COUNT"
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Cycle Count Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: CYCLE_COUNT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Cycle Count Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CYCLE_COUNT"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

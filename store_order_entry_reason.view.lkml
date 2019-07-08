view: store_order_entry_reason {
  label: "Order Entry Reason"
  sql_table_name: EDW.D_ORDER_ENTRY_REASON ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${order_entry_reason_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: ORDER_ENTRY_REASON"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: ORDER_ENTRY_REASON"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: order_entry_reason_id {
    label: "Order Entry Reason Id"
    description: "Unique ID number identfying this record. EPS Table: ORDER_ENTRY_REASON"
    type: number
    hidden: yes
    sql: ${TABLE}.ORDER_ENTRY_REASON_ID ;;
  }

  dimension: order_entry_reason_code {
    label: "Order Entry Reason Code"
    description: "The number assigned to each Order Entry Reason. EPS Table: ORDER_ENTRY_REASON"
    type: string
    sql: ${TABLE}.ORDER_ENTRY_REASON_CODE ;;
  }

  dimension: order_entry_reason_description {
    label: "Order Entry Reason Description"
    description: "Description of the order reason. EPS Table: ORDER_ENTRY_REASON"
    type: string
    sql: ${TABLE}.ORDER_ENTRY_REASON_DESCRIPTION ;;
  }

  dimension_group: order_entry_reason_deactivate {
    label: "Order Entry Reason Deactivate"
    description: "Date/Time that this Order Reason was deactivated. EPS Table: ORDER_ENTRY_REASON"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.ORDER_ENTRY_REASON_DEACTIVATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Order Entry Reason Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: ORDER_ENTRY_REASON"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

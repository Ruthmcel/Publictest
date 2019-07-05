view: eps_payment_group_line_item_link {
  label: "Payment Group Line Item Link"
  sql_table_name: EDW.F_PAYMENT_GROUP_LINE_ITEM_LINK ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${payment_group_id} ||'@'|| ${line_item_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN."
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: payment_group_id {
    label: "Payment Group Id"
    description: "FK to the Payment Group record"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_GROUP_ID ;;
  }

  dimension: line_item_id {
    label: "Line Item Id"
    description: "FK to the Line Item record"
    hidden: yes
    type: number
    sql: ${TABLE}.LINE_ITEM_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Payment Group Line Item Link Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }
}

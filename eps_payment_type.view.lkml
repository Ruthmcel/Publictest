view: eps_payment_type {
  label: "Payment Type"
  sql_table_name: EDW.D_PAYMENT_TYPE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${payment_type_id} ;; #ERXLPS-1649
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

  dimension: payment_type_id {
    label: "Payment Type Id"
    description: "Unique Id number identifying this record"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_TYPE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: payment_type_code {
    label: "Payment Type Code"
    description: "Unique Code identifying the payment type"
    type: string
    sql: ${TABLE}.PAYMENT_TYPE_CODE ;;
  }

  dimension: payment_type_description {
    label: "Payment Type Description"
    description: "Description for this payment type"
    type: string
    sql: ${TABLE}.PAYMENT_TYPE_DESCRIPTION ;;
  }

  dimension: payment_type_priority {
    label: "Payment Type Priority"
    description: "Order the payment type appears in the drop down list when selecting the payment type"
    type: number
    sql: ${TABLE}.PAYMENT_TYPE_PRIORITY ;;
  }

  dimension_group: payment_type_deactivate {
    label: "Payment Type Deactivate"
    description: "Date/Time the payment type was deactivated"
    type: time
    sql: ${TABLE}.PAYMENT_TYPE_DEACTIVATE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: payment_type_payment_rule {
    label: "Payment Type Payment Rule"
    description: "Payment rule which should be applied when using this payment type"
    type: string
    sql: ${TABLE}.PAYMENT_TYPE_PAYMENT_RULE ;;
  }

  dimension: payment_type_display_local_mail_order_oe {
    label: "Payment Type Availability at Order Entry"
    description: "Yes/No flag indicating if the payment type should be available at Order Entry"
    type: yesno
    sql: ${TABLE}.PAYMENT_TYPE_DISPLAY_LOCAL_MAIL_ORDER_OE_FLAG = 'Y' ;;
  }

  dimension: payment_type_display_local_mail_order_moca_flag {
    label: "Payment Type Availability at Mail Order Charge and Approval"
    description: "Yes/No flag indicating if the payment type should be available at Mail Order Charge and Approval"
    type: yesno
    sql: ${TABLE}.PAYMENT_TYPE_DISPLAY_LOCAL_MAIL_ORDER_MOCA_FLAG = 'Y' ;;
  }

  dimension: payment_type_display_local_mail_order_oor_flag {
    label: "Payment Type Availability at Open Orders Review"
    description: "Yes/No flag indicating if the payment type should be available at Open Orders Review"
    type: yesno
    sql: ${TABLE}.PAYMENT_TYPE_DISPLAY_LOCAL_MAIL_ORDER_OOR_FLAG = 'Y' ;;
  }

  dimension: payment_type_display_local_mail_order_pse_flag {
    label: "Payment Type Availability at Payment Settlement Exception"
    description: "Yes/No flag indicating if the payment type should be available at Payment Settlement Exception"
    type: yesno
    sql: ${TABLE}.PAYMENT_TYPE_DISPLAY_LOCAL_MAIL_ORDER_PSE_FLAG = 'Y' ;;
  }

  dimension: payment_type_display_at_will_call {
    label: "Payment Type Display Availability at Will Call"
    description: "Yes/No flag indicating if the payment type should be available at Will Call"
    type: yesno
    sql: ${TABLE}.PAYMENT_TYPE_DISPLAY_AT_WILL_CALL_FLAG = 'Y' ;;
  }

  dimension_group: source_create_timestamp {
    label: "Payment Type Source Create"
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

  set: explore_rx_payment_type_4_13_candidate_list {
    fields: [
      payment_type_code,
      payment_type_description,
      payment_type_priority,
      payment_type_deactivate_time,
      payment_type_deactivate_date,
      payment_type_deactivate_week,
      payment_type_deactivate_month,
      payment_type_deactivate_month_num,
      payment_type_deactivate_year,
      payment_type_deactivate_quarter,
      payment_type_deactivate_quarter_of_year,
      payment_type_deactivate,
      payment_type_deactivate_hour_of_day,
      payment_type_deactivate_time_of_day,
      payment_type_deactivate_hour2,
      payment_type_deactivate_minute15,
      payment_type_deactivate_day_of_week,
      payment_type_deactivate_day_of_month,
      payment_type_payment_rule,
      payment_type_display_local_mail_order_oe,
      payment_type_display_local_mail_order_moca_flag,
      payment_type_display_local_mail_order_oor_flag,
      payment_type_display_local_mail_order_pse_flag,
      payment_type_display_at_will_call
    ]
  }
}

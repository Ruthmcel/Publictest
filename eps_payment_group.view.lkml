view: eps_payment_group {
  label: "Payment Group"
  sql_table_name: EDW.F_PAYMENT_GROUP ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${payment_group_id} ;; #ERXLPS-1649
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
    description: "Unique Id number identifying this record"
    hidden: yes
    type: number
    sql: ${TABLE}.PAYMENT_GROUP_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: payment_group_active_status_flag {
    label: "Payment Group Active Status Flag"
    description: "Flag indicating status of the PAYMENT_GROUP, which is updated any time the payment group is created, completed, or closed"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_GROUP_ACTIVE_STATUS_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_GROUP_ACTIVE_STATUS_FLAG') ;;
    suggestions: [
      "YES, ACTIVE",
      "NO, INACTIVE"
    ]
  }

  measure: sum_payment_group_postage_amount {
    label: "Total Payment Group Postage Amount"
    description: "Total postage amount for this payment group"
    type: sum
    sql: ${TABLE}.PAYMENT_GROUP_POSTAGE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: payment_group_settled_at {
    label: "Payment Group Settled At"
    description: "Indicator where payment has been settled"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PAYMENT_GROUP_SETTLED_AT AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PAYMENT_GROUP_SETTLED_AT') ;;
    suggestions: [
      "NOT SPECIFIED",
      "PAYMENT SETTLEMENT STATE",
      "RPHV",
      "MOCA",
      "WILL CALL"
    ]
  }

  dimension_group: source_create_timestamp {
    label: "Payment Group Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis."
    hidden: yes
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  set: explore_rx_payment_group_4_13_candidate_list {
    fields: [
      payment_group_active_status_flag,
      sum_payment_group_postage_amount,
      payment_group_settled_at
    ]
  }
}

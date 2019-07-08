view: store_transfer_reason {
  #[ERXLPS-2599] - TRANSFER_REASON table has information about transfer reason. Earlier this information was available in TRANSFER table and in recent EPS releases this got moved into a separate table.
  #[ERXLPS-2599] - Old records transfer reason information available in F_TRANSFER table. All new transfer records information available in D_STORE_TRANSFER_REASON table.
  #[ERXLPS-2599] - Hence no dimension are directly exposed from this view. Only transfer_reason_description dimension is referenced in Transfer view of transfer reason dimension.
  label: "Pharmacy Transfer"
  sql_table_name: EDW.D_STORE_TRANSFER_REASON ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${transfer_reason_id} ;;
  }

  ################################################################# Foreign Key refresnces ############################################

  dimension: chain_id {
    type: number
    hidden: yes
    label: "Chain ID"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: transfer_reason_id {
    type: number
    hidden: yes
    label: "Transfer Reason ID"
    description: "Unique ID number identifying each record in this table. EPS Table: TRANSFER_REASON"
    sql: ${TABLE}.STORE_TRANSFER_REASON_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system. EPS Table: TRANSFER_REASON"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }
  ######################################################################### dimensions #####################################################

  dimension: transfer_reason_description {
    type: string
    hidden: yes
    label: "Transfer Reason Description"
    description: "Holds the transfer reason description like, Price, Out of Stock etc. EPS Table: TRANSFER_REASON"
    sql: UPPER(${TABLE}.STORE_TRANSFER_REASON_DESCRIPTION) ;;
  }

  dimension_group: transfer_reason_deactivated {
    type: time
    hidden: yes
    label: "Transfer Reason Deactivated"
    description: "Date when the record was deactivated at ECC. EPS Table: TRANSFER_REASON"
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_TRANSFER_REASON_DEACTIVATED_DATE ;;
  }

  dimension_group: source_create_timestamp {
    label: "Transfer Reason Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: TRANSFER_REASON"
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Transfer Reason Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: TRANSFER_REASON"
    type: time
    hidden: yes
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

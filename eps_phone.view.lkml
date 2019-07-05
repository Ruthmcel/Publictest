view: eps_phone {
  #[ERXLPS-1618] - Added only the required dimensions to get Phone details.
  label: "Phone"
  sql_table_name: EDW.D_PHONE ;;

  dimension: primary_key {
    hidden: yes
    type:string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${phone_id}||'@'||${source_system_id} ;;   #ERXDWPS-5137
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

  dimension: phone_id {
    type: string
    hidden: yes
    label: "Phone ID"
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.PHONE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################### dimensions #####################################################
  dimension: phone_long_distance {
    type: string
    hidden: yes
    label: "Phone Long Distance"
    description: "Flag that indicates if the phone record is long distance"
    sql: ${TABLE}.PHONE_LONG_DISTANCE ;;
  }

  dimension: phone_country_code {
    type: string
    hidden: yes
    label: "Phone Country Code"
    description: "Telephone country code for fax number"
    sql: ${TABLE}.PHONE_COUNTRY_CODE ;;
  }

  dimension: phone_number {
    type: string
    hidden: yes
    label: "Phone Number"
    description: "Three digit area code, and seven digit phone number respectively"
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: phone_extension {
    type: string
    hidden: yes
    label: "Phone Extension"
    description: "Phone extension for the phone record"
    sql: ${TABLE}.PHONE_EXTENSION ;;
  }

#[[ERXDWPS-7276]] Exposed source_create_timestamp as a part of sync US
  dimension_group: source_create_timestamp {
    label: "Phone Source Create"
    description: "This is the date and time that the record was created. This date is used for central data analysis."
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
       }
}

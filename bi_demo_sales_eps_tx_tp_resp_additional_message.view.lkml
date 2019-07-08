view: bi_demo_sales_eps_tx_tp_resp_additional_message {
  sql_table_name: edw.f_tx_tp_response_additional_message ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_response_additional_message_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_response_additional_message_id {
    label: "Response Additional Message Id"
    type: number
    description: "Unique ID number assigned by NHIN for the store associated to this record"
    hidden: yes
    sql: ${TABLE}.tx_tp_response_additional_message_id ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem."
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_response_detail_id {
    label: "Response Detail Id"
    type: number
    description: "Unique identifier for each record in the F_TX_TP_RESPONSE_CLAIM_DETAIL table."
    hidden: yes
    sql: ${TABLE}.tx_tp_response_detail_id ;;
  }

  ############################################################## Dimensions######################################################

  dimension: tx_tp_response_additional_message_counter {
    label: "Response Additional Message Counter"
    type: number
    description: "Count of the ‘ADDITIONAL MESSAGE INFORMATION’(526-FQ) occurrences."
    sql: ${TABLE}.tx_tp_response_additional_message_counter ;;
  }

  dimension: tx_tp_response_additional_message_qualifier {
    type: string
    label: "Response Additional Message Qualifier"
    description: "Format qualifier of the ‘Additional Message Information’ (526‐FQ). Each value may occur only once per transaction and values are ordered sequentially (numeric characters precede alpha characters, i.e., Ø‐9, A‐Z) associated with the third party response claim detail id"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '01' ;;
        label: "FIRST LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '02' ;;
        label: "SECOND LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '03' ;;
        label: "THIRD LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '04' ;;
        label: "FOURTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '05' ;;
        label: "FIFTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '06' ;;
        label: "SIXTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '07' ;;
        label: "SEVENTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '08' ;;
        label: "EIGHTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '09' ;;
        label: "NINTH LINE OF FREE FORM TEXT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '10' ;;
        label: "NEXT AVAILABLE FILL DATE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '11' ;;
        label: "PRIOR AUTHORIZATION END DATE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '12' ;;
        label: "MAXIMUM QUANTITY ALLOWED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_QUALIFIER = '13' ;;
        label: "MAXIMUM DAYS SUPPLY ALLOWED"
      }

      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_response_additional_message_information {
    label: "Response Additional Message Information"
    type: string
    description: "Identifies the 'ADDITIONAL MESSAGE INFORMATION'. (NCPDP field 526-FQ) associated with the third party response claim detail id"
    sql: ${TABLE}.TX_TP_RESPONSE_ADDITIONAL_MESSAGE_INFORMATION ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    hidden: yes
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

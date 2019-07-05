view: bi_demo_sales_eps_tx_tp_resp_approval_message {
  label: "Response Approval Message"
  sql_table_name: edw.f_tx_tp_response_approval_message ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_response_approval_message_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
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

  dimension: tx_tp_response_approval_message_id {
    label: "Response Approval Message Id"
    type: number
    description: "Unique Identification Value for the tx_tp_response_approval_message record"
    hidden: yes
    sql: ${TABLE}.tx_tp_response_approval_message_id ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.source_system_id ;;
  }

  dimension: tx_tp_response_detail_id {
    label: "Response Detail Id"
    type: number
    description: "Unique identifier for each record in the F_TX_TP_RESPONSE_CLAIM_DETAIL table."
    hidden: yes
    sql: ${TABLE}.tx_tp_response_detail_id ;;
  }

  ############################################################## Dimensions######################################################

  dimension: tx_tp_response_approval_message_counter {
    label: "Response Approval Message Counter"
    type: number
    description: "Count of the ‘APPROVED MESSAGE CODE’ (548-6F) occurrences."
    sql: ${TABLE}.tx_tp_response_approval_message_counter ;;
  }

  dimension: tx_tp_response_approval_message_code {
    type: string
    label: "Response Approval Message Code"
    description: "Identifies the 'APPROVED MESSAGE CODE' NCPDP field 548-6F associated with the third party response claim detail id"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '001' ;;
        label: "GENERIC AVAILABLE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '002' ;;
        label: "NON-FORMULARY DRUG"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '003' ;;
        label: "MAINTENANCE DRUG"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '004' ;;
        label: "FILLED DURING TRANSITION BENEFIT"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '005' ;;
        label: "TRANSITION BENEFIT/PRIOR AUTHORIZATION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '006' ;;
        label: "TRANSITION BENEFIT/NON-FORMULARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '007' ;;
        label: "TRANSITION BENEFIT/OTHER REJECTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '008' ;;
        label: "EMERGENCY FILL SITUATION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '009' ;;
        label: "EMERGENCY FILL SITUATION/PRIOR AUTHORIZATION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '010' ;;
        label: "EMERGENCY FILL SITUATION/NON-FORMULARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '011' ;;
        label: "EMERGENCY FILL SITUATION/OTHER REJECTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '012' ;;
        label: "LEVEL OF CARE CHANGE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '013' ;;
        label: "LEVEL OF CARE CHANGE/PRIOR AUTHORIZATION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '014' ;;
        label: "LEVEL OF CARE CHANGE/NON-FORMULARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '015' ;;
        label: "LEVEL OF CARE CHANGE/OTHER REJECTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '016' ;;
        label: "PMP REPORTABLE REQUIRED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '017' ;;
        label: "PMP REPORTING COMPLETED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '018' ;;
        label: "PROVIDE CMS NOTICE OF APPEAL RIGHTS"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '019' ;;
        label: "PRESCRIBER ID INACTIVE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '020' ;;
        label: "DEA NOT FOUND"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '021' ;;
        label: "DEA INACTIVE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '022' ;;
        label: "PRESCRIBER ID DOES NOT ALLOW DEA SCHEDULE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '023' ;;
        label: "PRORATED COPAYMENT APPLIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '024' ;;
        label: "PRESCRIBER ID NOT FOUND"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '025' ;;
        label: "DECEASED PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '026' ;;
        label: "PRESCRIBER TYPE 1 NPI REQUIRED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '027' ;;
        label: "PRESCRIBER DEA DOES NOT ALLOW DEA SCHEDULE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '028' ;;
        label: "TYPE 1 NPI REQUIRED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '029' ;;
        label: "GRACE PERIOD CLAIM"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '030' ;;
        label: "PRESCRIBER ACTIVE ENROLLMENT REQUIRED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '031' ;;
        label: "PHARMACY ACTIVE ENROLLMENT REQUIRED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '032' ;;
        label: "ACTIVE STATE LICENSE NOT VERIFIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '033' ;;
        label: "HOSPICE COMPASSIONATE FIRST FILL"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '034' ;;
        label: "PRIOR AUTHORIZATION APPROVAL ON FILE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '035' ;;
        label: "QUANTITY LIMIT PER SPECIFIC TIME PERIOD"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '036' ;;
        label: "DAYS SUPPLY LIMIT PER SPECIFIC TIME PERIOD"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '037' ;;
        label: "PREFERRED FORMULARY ALTERNATIVE AVAILABLE"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '038' ;;
        label: "PREFERRED NETWORK PHARMACY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '039' ;;
        label: "NON‐PREFERRED NETWORK PHARMACY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_APPROVAL_MESSAGE_CODE = '040' ;;
        label: "SPECIALTY PHARMACY NETWORK AVAILABLE"
      }

      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
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

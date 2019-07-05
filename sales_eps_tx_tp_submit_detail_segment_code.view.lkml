view: sales_eps_tx_tp_submit_detail_segment_code {
  label: "Tx Tp Submit Detail Segment Code"
  sql_table_name: edw.F_TX_TP_SUBMIT_DETAIL_SEGMENT_CODE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_submit_detail_segment_code_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type}  ;; #ERXLPS-1649
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

  dimension: tx_tp_submit_detail_segment_code_id {
    label: "Tx Tp Submit Detail Segment Code Id"
    type: number
    description: "Unique Identification Value for the tx_tp_submit_detail_segment_code record"
    hidden: yes
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_submit_detail_id {
    label: "Response Detail Id"
    type: number
    description: "Unique ID number assigned by NHIN for the store associated to this record"
    hidden: yes
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_ID ;;
  }

  ############################################################## Dimensions######################################################

  dimension: tx_tp_submit_detail_segment_code_counter {
    label: "Submit Detail Segment Code Counter"
    description: "Count of the ‘Procedure Modifier Code’ (459-ER) occurrences. Count of the ‘Submission Clarification Code’ (42Ø-DK) occurrences"
    type: number
    sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_COUNTER ;;
  }

  dimension: tx_tp_submit_detail_segment_code {
    label: "Submit Detail Segment Code"
    description: "Identifies special circumstances related to the performance of the service. Code indicating that the pharmacist is clarifying the submission"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST((${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE || ':NCPDP ' || ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_NCPDP_TYPE) AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_SUBMIT_DETAIL_SEGMENT_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "NO OVERRIDE",
      "OTHER OVERRIDE",
      "VACATION SUPPLY",
      "LOST PRESCRIPTION",
      "THERAPY CHANGE",
      "STARTER DOSE",
      "MEDICALLY NECESSARY",
      "PROCESS COMPOUND",
      "ENCOUNTERS",
      "MEETS PLAN LIMITATIONS",
      "CERTIFICATION ON FILE",
      "DME REPLACEMENT INDICATOR",
      "PAYER-RECOGNIZED EMERGENCY",
      "LEAVE OF ABSENCE",
      "REPLACEMENT MEDICATION",
      "EMERGENCY BOX",
      "EMERGENCY SUPPLY REMAINDER",
      "PATIENT ADMIT/READMIT INDICATOR",
      "SPLIT BILLING",
      "340B",
      "LTC DISPENSING 14 DAYS OR LESS",
      "LTC DISPENSING: 7 DAYS",
      "LTC DISPENSING: 4 DAYS",
      "LTC DISPENSING: 3 DAYS",
      "LTC DISPENSING: 2 DAYS",
      "LTC DISPENSING: 1 DAY",
      "LTC DISPENSING: 4-3 DAYS",
      "LTC DISPENSING: 2-2-3 DAYS",
      "LTC DISPENSING: DAILY AND 3-DAY WEEKEND",
      "LTC DISPENSING: PER SHIFT DISPENSING",
      "LTC DISPENSING: PER MED PASS DISPENSING",
      "LTC DISPENSING: PRN ON DEMAND",
      "LTC DISPENSING: 7 DAY OR LESS CYCLE NOT REPRESENTED",
      "LTC DISPENSING: 14 DAYS DISPENSING",
      "LTC DISPENSING: 8-14 DAY DISPENSING",
      "LTC DISPENSING: DISPENSED OUTSIDE SHORT CYCLE",
      "PRESCRIBER ID SUBMITTED IS VALID",
      "PRESCRIBER''S DEA IS ACTIVE WITH DEA",
      "PRESCRIBER DEA LICENSED",
      "PRESCRIBER DEA IS A VALID HOSPITAL DEA",
      "PRESCRIBER DEA HAS PRESCRIPTIVE AUTHORITY",
      "SHORTENED DAYS SUPPLY FILL",
      "FILL SUBSEQUENT TO A SHORTENED DAYS SUPPLY FILL",
      "PRESCRIBER DOES NOT CURRENTLY HAVE AN ACTIVE TYPE 1 NPI",
      "PRESCRIBER''S ACTIVE MEDICARE FEE VALIDATED",
      "PHARMACY''S ACTIVE MEDICARE FEE VALIDATED",
      "PRESCRIBER''S STATE LICENSE VALIDATED",
      "PRESCRIBER NPI ACTIVE AND VALID",
      "CMS OTHER AUTHORIZED PRESCRIBER (OAP)",
      "OTHER"
    ]
  }

  dimension: tx_tp_submit_detail_segment_code_ncpdp_type {
    label: "Submit Detail Segment Code NCPDP Type"
    description: "NCPDP Field Indicating the type of code being stored"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_NCPDP_TYPE = 'N/A' ;;
        label: "NOT SPECIFIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_NCPDP_TYPE = '459-ER' ;;
        label: "PROCEDURE MODIFIER CODE"
      }

      when: {
        sql: ${TABLE}.TX_TP_SUBMIT_DETAIL_SEGMENT_CODE_NCPDP_TYPE = '420-DK' ;;
        label: "SUBMISSION CLASSIFICATION CODE"
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

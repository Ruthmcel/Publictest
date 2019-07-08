view: sales_eps_tx_tp_denial_clarification {
  label: "Denial Clarification"
  sql_table_name: edw.f_tx_tp_denial_clarification ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_denial_clarification_id}  ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;; #ERXLPS-1649
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

  dimension: tx_tp_denial_clarification_id {
    label: "TX_TP Denial Clarification Id"
    type: number
    description: "Unique Identification Value for the tx_tp_response_approval_message record"
    hidden: yes
    sql: ${TABLE}.tx_tp_denial_clarification_id ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_id {
    label: "TX_TP Response Detail Id"
    type: number
    description: "The transaction third party TX_TP record that is associated to this TX_TP_DENIAL_CLARIFICATION record (Foreign key to the TX_TP table's TX_TP_ID column)."
    hidden: yes
    sql: ${TABLE}.tx_tp_id ;;
  }

  ############################################################## Dimensions######################################################

  dimension: tx_tp_denial_clarification_code {
    label: "Denial Clarification Code"
    type: string
    description: "Code indicating pharmacist clarifying the submission. Allows 3 codes with each having multiple options listed."

    case: {
      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '1' ;;
        label: "NO OVERRIDE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '2' ;;
        label: "OTHER OVERRIDE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '3' ;;
        label: "VACATION SUPPLY"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '4' ;;
        label: "LOST PRESCRIPTION"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '5' ;;
        label: "THERAPY CHANGE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '6' ;;
        label: "STARTER DOSE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '7' ;;
        label: "MEDICALLY NECESSARY"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '8' ;;
        label: "PROCESS COMPOUND"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '9' ;;
        label: "ENCOUNTERS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '10' ;;
        label: "MEETS PLAN LIMITATIONS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '11' ;;
        label: "CERTIFICATION ON FILE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '12' ;;
        label: "DME REPLACEMENT INDICATOR"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '13' ;;
        label: "PAYER-RECOGNIZED EMERGENCY"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '14' ;;
        label: "LEAVE OF ABSENCE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '15' ;;
        label: "REPLACEMENT MEDICATION"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '16' ;;
        label: "EMERGENCY BOX"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '17' ;;
        label: "EMERGENCY SUPPLY REMAINDER"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '18' ;;
        label: "PATIENT ADMIT/READMIT INDICATOR"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '19' ;;
        label: "SPLIT BILLING"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '20' ;;
        label: "340B"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '21' ;;
        label: "LTC DISPENSING 14 DAYS OR LESS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '22' ;;
        label: "LTC DISPENSING: 7 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '23' ;;
        label: "LTC DISPENSING: 4 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '24' ;;
        label: "LTC DISPENSING: 3 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '25' ;;
        label: "LTC DISPENSING: 2 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '26' ;;
        label: "LTC DISPENSING: 1 DAY"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '27' ;;
        label: "LTC DISPENSING: 4-3 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '28' ;;
        label: "LTC DISPENSING: 2-2-3 DAYS"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '29' ;;
        label: "LTC DISPENSING: DAILY AND 3-DAY WEEKEND"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '30' ;;
        label: "LTC DISPENSING: PER SHIFT DISPENSING"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '31' ;;
        label: "LTC DISPENSING: PER MED PASS DISPENSING"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '32' ;;
        label: "LTC DISPENSING: PRN ON DEMAND"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '33' ;;
        label: "LTC DISPENSING: 7 DAY OR LESS CYCLE NOT REPRESENTED"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '34' ;;
        label: "LTC DISPENSING: 14 DAYS DISPENSING"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '35' ;;
        label: "LTC DISPENSING: 8-14 DAY DISPENSING"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '36' ;;
        label: "LTC DISPENSING: DISPENSED OUTSIDE SHORT CYCLE"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '42' ;;
        label: "PRESCRIBER ID SUBMITTED IS VALID"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '43' ;;
        label: "PRESCRIBER''S DEA IS ACTIVE WITH DEA"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '44' ;;
        label: "PRESCRIBER DEA LICENSED"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '45' ;;
        label: "PRESCRIBER DEA IS A VALID HOSPITAL DEA"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '46' ;;
        label: "PRESCRIBER DEA HAS PRESCRIPTIVE AUTHORITY"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '47' ;;
        label: "SHORTENED DAYS SUPPLY FILL"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '48' ;;
        label: "FILL SUBSEQUENT TO A SHORTENED DAYS SUPPLY FILL"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '49' ;;
        label: "PRESCRIBER DOES NOT CURRENTLY HAVE AN ACTIVE TYPE 1 NPI"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '50' ;;
        label: "PRESCRIBER''S ACTIVE MEDICARE FEE VALIDATED"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '51' ;;
        label: "PHARMACY''S ACTIVE MEDICARE FEE VALIDATED"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '52' ;;
        label: "PRESCRIBER''S STATE LICENSE VALIDATED"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '53' ;;
        label: "PRESCRIBER NPI ACTIVE AND VALID"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '54' ;;
        label: "CMS OTHER AUTHORIZED PRESCRIBER (OAP)"
      }

      when: {
        sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_CODE = '99' ;;
        label: "OTHER"
      }
      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_denial_clarification_deleted {
    type: yesno
    hidden: yes
    label: "Denial Clarification Deleted Record"
    description: "Yes/no Flag indicating soft delete of record in the source table"
    sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_DELETED = 'Y' ;;
  }

  #[ERXLPS-1845] Reference dimension created to use in joins.
  dimension: tx_tp_denial_clarification_deleted_reference {
    type: string
    hidden: yes
    label: "Denial Clarification Deleted Record"
    description: "Y/N Flag indicating soft delete of record in the source table."
    sql: ${TABLE}.TX_TP_DENIAL_CLARIFICATION_DELETED ;;
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

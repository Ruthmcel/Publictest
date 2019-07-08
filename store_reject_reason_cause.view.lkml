view: store_reject_reason_cause {
  label: "Reject Reason Cause"
  sql_table_name: EDW.F_REJECT_REASON_CAUSE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${reject_reason_cause_id} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assigned to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: reject_reason_cause_id {
    label: "Reject Reason Cause Id"
    type: number
    description: "Unique Identification Value for the Reject_Reason_Cause record"
    hidden: yes
    sql: ${TABLE}.REJECT_REASON_CAUSE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source system"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: reject_reason_id {
    label: "Reject Reason Id"
    type: number
    description: "System populated using the value of the ID column from the associated Reject Reason record"
    hidden: yes
    sql: ${TABLE}.REJECT_REASON_ID ;;
  }

  ############################################################## Dimensions######################################################
  dimension: reject_reason_cause {
    type: string
    label: "Reject Reason Cause"
    description: "Actual event/reason that caused the creation of a rejection record in the database. More than one cause may be associated with a single rejection"

    case: {
      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '100' ;;
        label: "DRUG SELECTION FAILURE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '101' ;;
        label: "RXEDITS FAILURE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '111' ;;
        label: "DOWNTIME"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '112' ;;
        label: "REVERT TP EXCEPTION"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '113' ;;
        label: "FILL RX LOCALLY"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '114' ;;
        label: "PENDING CONTRACT"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '200' ;;
        label: "CALL PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '201' ;;
        label: "CALL PATIENT"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '202' ;;
        label: "CALL PLAN"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '300' ;;
        label: "CHANGE FILL"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '301' ;;
        label: "CHANGE COMPOUND INGREDIENTS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '400' ;;
        label: "RE DISPLAY IN"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '401' ;;
        label: "RE DISPLAY AFTER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '402' ;;
        label: "DISPLAY AT LOCAL STORE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '403' ;;
        label: "CANCEL"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '404' ;;
        label: "MISSING"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '500' ;;
        label: "WRONG DRUG"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '501' ;;
        label: "WRONG IMAGE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '600' ;;
        label: "PAST REVERSAL DAYS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '601' ;;
        label: "TRANSMIT FAIL TO DONE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '602' ;;
        label: "CHANGE BILLING ADD SPLIT BILL FAIL"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '700' ;;
        label: "DATA ENTRY ERRORS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '701' ;;
        label: "PRESCRIBED DRUG"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '702' ;;
        label: "DISPENSED DRUG"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '703' ;;
        label: "PRESCRIBED QUANTITY"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '704' ;;
        label: "THIS FILL QUANTITY"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '705' ;;
        label: "REFILLS AUTHORIZED"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '706' ;;
        label: "PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '707' ;;
        label: "SIG TEXT"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '708' ;;
        label: "DAYS SUPPLY"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '709' ;;
        label: "DAW"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '710' ;;
        label: "BILLING"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '711' ;;
        label: "OTHER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '712' ;;
        label: "FILL ERRORS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '713' ;;
        label: "CHANGE BILLING TP EXCEPTION"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '714' ;;
        label: "REJECT TO TP EXCEPTION QUEUE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '715' ;;
        label: "RETRANSMIT ON"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '716' ;;
        label: "WILL CALL TO TP EXCEPTION"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '800' ;;
        label: "MTM CALL PATIENT"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '900' ;;
        label: "DRUG NOT LOCALLY AVAILABLE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '901' ;;
        label: "REJECT TO RXFILLING QUEUE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '902' ;;
        label: "ENTIRE CLINIC"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '903' ;;
        label: "INDVIDUAL PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '904' ;;
        label: "CANCELLED BY PRESCRIBER"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '905' ;;
        label: "CANCELLED BY PHARMACIST"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '906' ;;
        label: "CANCEL THIS RX"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '907' ;;
        label: "CANCEL ALL RXS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '908' ;;
        label: "REQUIRES REVIEW"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '909' ;;
        label: "OUT OF STOCK"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '910' ;;
        label: "REFILL TOO SOON"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '911' ;;
        label: "READ DOCTOR"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '912' ;;
        label: "READ SIG"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '913' ;;
        label: "READ DRUG"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '914' ;;
        label: "READ PATIENT"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '915' ;;
        label: "LOW PAY"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '916' ;;
        label: "DUR"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '917' ;;
        label: "FILL RX ON LATER DATE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '918' ;;
        label: "CANCEL PUT ON FILE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '919' ;;
        label: "CANCEL AND LEAVE RX ACTIVE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '920' ;;
        label: "CANCEL AND DEACTIVATE RX"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '921' ;;
        label: "ABORT SPLIT BILLING"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '922' ;;
        label: "PRESCRIBER PREEDIT FAILURE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '923' ;;
        label: "CANCEL RETURN HARD COPY PRICE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '924' ;;
        label: "CANCEL RETURN HARD COPY OOS"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '925' ;;
        label: "NOTIFY PATIENT PARTIAL FILL"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '926' ;;
        label: "WRITTEN DATE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '927' ;;
        label: "EXPIRATION DATE"
      }

      when: {
        sql: ${TABLE}.REJECT_REASON_CAUSE = '999' ;;
        label: "TEST DUR RERUN"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension_group: source_create_timestamp {
    label: "Source Create Timestamp"
    type: time
    hidden: yes
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    description: "Date/Time the record was created in source table"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ############################################# Sets #####################################################

  set: explore_rx_reject_reason_cause_4_13_candidate_list {
    fields: [
      reject_reason_cause
    ]
  }
}

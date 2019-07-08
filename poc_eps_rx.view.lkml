view: poc_eps_rx {
  sql_table_name: EDW.F_RX ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
   # hidden: yes
    type: number
    label: "Prescription Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_id {
    label: "Prescription ID"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_status {
    label: "Prescription Status"
    type: yesno
    sql: ${TABLE}.RX_STATUS = 'Y' ;;
  }

  dimension: rx_source {
    label: "Prescription Source"
    description: "Indicates what process was used to create this prescription record"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_SOURCE = 0 ;;
        label: "Not Specified"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 1 ;;
        label: "Written"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 2 ;;
        label: "Phoned In"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 3 ;;
        label: "E-Script"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 4 ;;
        label: "Fax"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 5 ;;
        label: "Pharmacy Generated"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 20 ;;
        label: "Manual Transfer"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 21 ;;
        label: "Informational Rx"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 22 ;;
        label: "Patient Specified"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 23 ;;
        label: "Auto Transfer"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 24 ;;
        label: "Transfer Auto RAR"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 25 ;;
        label: "Escript RAR"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 26 ;;
        label: "Escript Addfill"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 27 ;;
        label: "Patient Request"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 28 ;;
        label: "Prescriber Request"
      }

      when: {
        sql: ${TABLE}.RX_SOURCE = 29 ;;
        label: "Other"
      }

      when: {
        sql: true ;;
        label: "Blank"
      }
    }
  }

  dimension: rx_first_filled_date {
    label: "Prescription First Filled Date"
    description: "Unique ID that links this record with a specific PATIENT record. System generated"
    type: date
    sql: ${TABLE}.RX_FIRST_FILLED_DATE ;;
    }

  dimension: rx_expiration_date {
    label: "Prescription Expiration Date"
    description: "Unique ID that links this record with a specific PATIENT record. System generated"
    type: date
    sql: ${TABLE}.RX_EXPIRATION_DATE ;;
  }

  dimension: rx_refills_authorized {
    label: "Prescription Refills Authorized"
    description: "Unique ID that links this record with a specific PATIENT record. System generated"
    type: number
    sql: ${TABLE}.RX_REFILLS_AUTHORIZED ;;
  }

  dimension: rx_refills_remaining {
    label: "Prescription Refills Remaining"
    description: "Unique ID that links this record with a specific PATIENT record. System generated"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.RX_REFILLS_REMAINING = 'NR' then 0
              WHEN  ${TABLE}.RX_REFILLS_REMAINING = 'p' then 99
              WHEN  ${TABLE}.RX_REFILLS_REMAINING = 'P' then 99
              WHEN  ${TABLE}.RX_REFILLS_REMAINING is null then 0
              ELSE ${TABLE}.RX_REFILLS_REMAINING END    ;;
  }

  measure: count_of_refill_remaining {
    label: "Total Refills Remaining"
    type: sum
    sql: ${rx_refills_remaining} ;;
  }

 }

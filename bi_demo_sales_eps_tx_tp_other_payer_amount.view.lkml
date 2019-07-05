view: bi_demo_sales_eps_tx_tp_other_payer_amount {
  label: "Tx Tp Other Payer Amount"
  sql_table_name: edw.f_tx_tp_other_payer_amount ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_other_payer_amount_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg}  ;; #ERXLPS-1649
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

  dimension: tx_tp_other_payer_amount_id {
    label: "Tx Tp Other Payer Amount Id"
    type: number
    description: "Unique ID of the TP_OTHER_PAYER_AMOUNT record"
    hidden: yes
    sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_other_payer_id {
    label: "Tx Tp Other Payer Id"
    type: number
    description: "Foreign key to the TP_OTHER_PAYERS record."
    hidden: yes
    sql: ${TABLE}.TX_TP_OTHER_PAYER_ID ;;
  }

  ############################################################## Dimensions ######################################################

  dimension: tx_tp_other_payer_amount_qualifier {
    label: "Other Payer Amount Qualifier"
    description: "Qualifier for the Other Payer Amount Paid (431-DV). Populated by the system using the third party transaction information in memory when a TP_OTHER_PAYER_AMOUNTS record is created."
    type: string
    #sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST((${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE) AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER') ;;
    #[ERXLPS-1778]
    case: {
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = 'NULL' ;; label: "NOT SPECIFIED" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '01:NCPDP 431-DV' ;; label: "DELIVERY" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '02:NCPDP 431-DV' ;; label: "SHIPPING" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '03:NCPDP 431-DV' ;; label: "POSTAGE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '04:NCPDP 431-DV' ;; label: "ADMINISTRATIVE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '05:NCPDP 431-DV' ;; label: "INCENTIVE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '06:NCPDP 431-DV' ;; label: "COGNITIVE SERVICE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '07:NCPDP 431-DV' ;; label: "DRUG BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '08:NCPDP 431-DV' ;; label: "SUM OF ALL REIMBURSEMENTS" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '09:NCPDP 431-DV' ;; label: "COMPOUND PREPARATION COST" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '10:NCPDP 431-DV' ;; label: "SALES TAX" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '98:NCPDP 431-DV' ;; label: "COUPON" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '99:NCPDP 431-DV' ;; label: "OTHER" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '01:NCPDP 352-NQ' ;; label: "PERIODIC DEDUCTIBLE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '02:NCPDP 352-NQ' ;; label: "PRODUCT SELECTION/BRAND DRUG" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '03:NCPDP 352-NQ' ;; label: "SALES TAX" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '04:NCPDP 352-NQ' ;; label: "PERIODIC BENEFIT MAXIMUM" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '05:NCPDP 352-NQ' ;; label: "COPAY" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '06:NCPDP 352-NQ' ;; label: "PATIENT PAY AMOUNT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '07:NCPDP 352-NQ' ;; label: "COINSURANCE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '08:NCPDP 352-NQ' ;; label: "PRODUCT SELECTION/NON-PREFERRED FORMULARY SELECTION" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '09:NCPDP 352-NQ' ;; label: "HEALTH PLAN ASSISTANCE AMOUNT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '10:NCPDP 352-NQ' ;; label: "PROVIDER NETWORK SELECTION" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '11:NCPDP 352-NQ' ;; label: "PRODUCT SELECTION/BRAND NON-PREFERRED FORMULARY SELECTION" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '12:NCPDP 352-NQ' ;; label: "COVERAGE GAP" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '13:NCPDP 352-NQ' ;; label: "PROCESSOR FEE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '01:NCPDP 394-MW' ;; label: "DEDUCTIBLE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '02:NCPDP 394-MW' ;; label: "INITIAL BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '03:NCPDP 394-MW' ;; label: "COVERAGE GAP (DONUT HOLE)" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '04:NCPDP 394-MW' ;; label: "CATASTROPHIC COVERAGE" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '50:NCPDP 394-MW' ;; label: "PART C BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '60:NCPDP 394-MW' ;; label: "SUPPLEMENTAL BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '61:NCPDP 394-MW' ;; label: "CO-ADMINISTERED INSURED BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '62:NCPDP 394-MW' ;; label: "CO-ADMINISTERED BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '63:NCPDP 394-MW' ;; label: "MEDICAID BENEFIT" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '70:NCPDP 394-MW' ;; label: "PART D DRUG PAID BY BENEFICIARY" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '80:NCPDP 394-MW' ;; label: "NON-PART D/NON-QUALIFIED DRUG PAID BY BENEFICIARY" }
      when: { sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_QUALIFIER || ':NCPDP ' || ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '90:NCPDP 394-MW' ;; label: "ENHANCE OR OTC DRUG COVERED BY PART D PLAN" }
    }
  }

  dimension: tx_tp_other_payer_amount_ncpdp_type {
    label: "Other Payer Amount NCPDP Type"
    description: "NCPDP field prefix associated with the amount"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = 'N/A' ;;
        label: "NOT SPECIFIED"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '431-DV' ;;
        label: "OTHER PAYER AMOUNT PAID"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '352-NQ' ;;
        label: "OTHER PAYER-PATIENT RESPONSIBILITY"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_NCPDP_TYPE = '394-MW' ;;
        label: "BENEFIT STAGE AMOUNT"
      }
    }
  }

  dimension: tx_tp_other_payer_amount_deleted {
    label: "Other Payer Amount Deleted"
    hidden: yes
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table."
    type: string
    case: {
      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_DELETED = 'N' ;;
        label: "NO"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_DELETED = 'Y' ;;
        label: "YES"
      }
    }
  }

  #[ERXLPS-1845] - Reference dimension added to use in joins.
  dimension: tx_tp_other_payer_amount_deleted_reference {
    label: "Other Payer Amount Deleted"
    hidden: yes
    description: "Y/N Flag indicating soft delete of record in the source table."
    type: string
    sql: ${TABLE}.TX_TP_OTHER_PAYER_AMOUNT_DELETED ;;
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

  ############################################################## Measures ######################################################

  measure: tx_tp_other_payer_amount {
    label: "Other Payer Amount"
    description: "Amount of any payment known by the pharmacy from other sources."
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.tx_tp_other_payer_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

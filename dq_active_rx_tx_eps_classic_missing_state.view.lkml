view: dq_active_rx_tx_eps_classic_missing_state {
  derived_table: {
    sql: SELECT
      EPS.CHAIN_ID,
      EPS.NHIN_STORE_ID,
      EPS.RX_TX_ID,
      EPS.RX_TX_RX_NUMBER,
      EPS.RX_TX_TX_NUMBER,
      EPS.RX_SOURCE,
      EPS.FILE_BUY_FLAG,
      EPS.RX_FILE_BUY_DATE,
      EPS.RX_TX_FILLED_DATE,
      EPS.RX_TX_SOLD_DATE,
      EPS.RX_TX_REPORTABLE_SALES_DATE,
      EPS.RX_TX_PRICE,
      EPS.RX_TX_ACQUISITION_COST,
      EPS.RX_TX_GROSS_MARGIN,
      'EPS TX MISSING IN EPR' AS RX_TX_MISSING_STATE,
      NULL AS RX_TX_MISSING_DETAIL_STATE
       FROM
       (SELECT
            TX.CHAIN_ID,
            TX.NHIN_STORE_ID,
            TX.RX_TX_ID,
            RX.RX_NUMBER AS RX_TX_RX_NUMBER,
            TX.RX_TX_TX_NUMBER,
            RX.RX_SOURCE,
            RX.RX_FILE_BUY_DATE,
            TX.RX_TX_FILL_DATE AS RX_TX_FILLED_DATE,
            CASE WHEN RX.RX_FILE_BUY_DATE IS NOT NULL AND TX.RX_TX_FILL_DATE <= RX.RX_FILE_BUY_DATE THEN 'Y' ELSE 'N' END AS FILE_BUY_FLAG,
            TX.RX_TX_WILL_CALL_PICKED_UP_DATE AS RX_TX_SOLD_DATE,
            TX.RX_TX_REPORTABLE_SALES_DATE,
            TX.RX_TX_FILL_QUANTITY,
            TX.RX_TX_TX_STATUS,
            TX.RX_TX_FILL_STATUS,
            DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_PRICE,NVL(TX.RX_TX_ORIGINAL_PRICE,0)) AS RX_TX_PRICE, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
            DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_ACQUISITION_COST,0) AS RX_TX_ACQUISITION_COST, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
            (DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_PRICE,NVL(TX.RX_TX_ORIGINAL_PRICE,0)) - DECODE(TX.RX_TX_RETURNED_DATE,NULL,TX.RX_TX_ACQUISITION_COST,0)) AS RX_TX_GROSS_MARGIN --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
       FROM EDW.F_RX_TX_LINK TX
       INNER JOIN EDW.F_RX RX
       ON ( RX.CHAIN_ID = TX.CHAIN_ID AND
            RX.NHIN_STORE_ID = TX.NHIN_STORE_ID AND
            RX.RX_ID = TX.RX_ID
          )
       WHERE RX.source_system_id = 4
       AND TX.source_system_id = 4
       ) EPS
       INNER JOIN EDW.D_STORE S
       ON S.CHAIN_ID = EPS.CHAIN_ID AND
       S.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND
       S.SOURCE_SYSTEM_ID = 5 AND
       UPPER(S.STORE_REGISTRATION_STATUS) = 'REGISTERED'
       WHERE NVL(EPS.RX_TX_TX_STATUS,'Y') = 'Y'
       AND EPS.RX_TX_PRICE IS NOT NULL
       AND EPS.RX_TX_ACQUISITION_COST IS NOT NULL
       AND EPS.RX_TX_FILL_STATUS IS NOT NULL
       AND EPS.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL
       AND EPS.RX_TX_FILL_QUANTITY IS NOT NULL
       AND EPS.RX_TX_RX_NUMBER IS NOT NULL
       AND EPS.RX_TX_TX_NUMBER IS NOT NULL
       AND NOT EXISTS
         ( SELECT 'X' FROM
             EDW.F_RX_TX EPR
           WHERE EPR.CHAIN_ID = EPS.CHAIN_ID AND
                 EPR.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND
                 EPR.RX_TX_RX_NUMBER = EPS.RX_TX_RX_NUMBER AND
                 EPR.RX_TX_TX_NUMBER = EPS.RX_TX_TX_NUMBER )
       UNION ALL

       SELECT EPR.CHAIN_ID,
              EPR.NHIN_STORE_ID,
              EPR.RX_TX_ID,
              EPR.RX_TX_RX_NUMBER,
              EPR.RX_TX_TX_NUMBER,
              NULL AS RX_SOURCE,
              'N/A' AS FILE_BUY_FLAG,
              NULL AS RX_FILE_BUY_DATE,
              EPR.RX_TX_FILLED_DATE,
              EPR.RX_TX_SOLD_DATE,
              DECODE(EPR.RX_TX_REPORTABLE_SALES_DATE,NULL,EPR.RX_TX_FILLED_DATE,EPR.RX_TX_REPORTABLE_SALES_DATE) AS RX_TX_REPORTABLE_SALES_DATE,
              EPR.RX_TX_PRICE,
              EPR.RX_TX_ACQUISITION_COST,
              (EPR.RX_TX_PRICE - EPR.RX_TX_ACQUISITION_COST) AS RX_TX_GROSS_MARGIN,
               'EPR TX MISSING IN EPS' AS RX_TX_MISSING_STATE,
               CASE
               WHEN RX.NHIN_STORE_ID IS NULL AND TX.NHIN_STORE_ID IS NOT NULL THEN 'EPS RX MISSING IN BI SYSTEM'
               WHEN RX.NHIN_STORE_ID IS NOT NULL AND TX.NHIN_STORE_ID IS NULL THEN 'EPS TX MISSING IN BI SYSTEM'
               WHEN RX.NHIN_STORE_ID IS NULL AND TX.NHIN_STORE_ID IS NULL THEN 'EPS RX & TX MISSING IN BI SYSTEM'
               ELSE 'EPS RX/TX MISSING IN EDW'
               END AS RX_TX_MISSING_DETAIL_STATE
       FROM EDW.F_RX_TX EPR
       INNER JOIN EDW.D_STORE S
       ON S.CHAIN_ID = EPR.CHAIN_ID AND
       S.NHIN_STORE_ID = EPR.NHIN_STORE_ID AND
       S.SOURCE_SYSTEM_ID = 5 AND
       UPPER(S.STORE_REGISTRATION_STATUS) = 'REGISTERED'
       LEFT OUTER JOIN (SELECT DISTINCT CHAIN_ID,NHIN_STORE_ID,RX_NUMBER
                                   FROM EPS_STAGE.RX_SUMMARY_STAGE ) RX
       ON EPR.CHAIN_ID = RX.CHAIN_ID AND
       EPR.NHIN_STORE_ID = RX.NHIN_STORE_ID AND
       EPR.RX_TX_RX_NUMBER = RX.RX_NUMBER
       LEFT OUTER JOIN (SELECT DISTINCT CHAIN_ID,META_NHIN_STORE_ID AS NHIN_STORE_ID,TX_NUMBER
                                   FROM EPS_STAGE.RX_TX_STAGE ) TX
       ON EPR.CHAIN_ID = TX.CHAIN_ID AND
       EPR.NHIN_STORE_ID = TX.NHIN_STORE_ID AND
       EPR.RX_TX_TX_NUMBER = TX.TX_NUMBER
       WHERE  EPR.RX_TX_RX_DELETED = 'N'
       AND EPR.RX_TX_TX_DELETED = 'N'
       AND EPR.RX_TX_TX_NUMBER IS NOT NULL
       AND NVL(EPR.RX_TX_TX_STATUS,'Y') = 'Y'
       AND EPR.RX_TX_PRICE IS NOT NULL
       AND EPR.RX_TX_ACQUISITION_COST IS NOT NULL
       AND EPR.RX_TX_FILL_STATUS IS NOT NULL
       AND EPR.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL
       AND EPR.RX_TX_FILL_QUANTITY IS NOT NULL
       AND EPR.NHIN_STORE_ID IN (SELECT DISTINCT TX.NHIN_STORE_ID FROM EDW.F_RX_TX_LINK TX WHERE TX.source_system_id = 4) -- Only Checking for stores that has Symmetric Data
       AND NOT EXISTS
         ( SELECT 'X' FROM
             (   SELECT
                 TX.CHAIN_ID,
                 TX.NHIN_STORE_ID,
                 TX.RX_TX_ID,
                 RX.RX_ID,
                 RX.RX_NUMBER,
                 TX.RX_TX_TX_NUMBER
                 FROM EDW.F_RX_TX_LINK TX
                 INNER JOIN EDW.F_RX RX
                 ON (    RX.CHAIN_ID = TX.CHAIN_ID AND
                         RX.NHIN_STORE_ID = TX.NHIN_STORE_ID AND
                         RX.RX_ID = TX.RX_ID
                    )
                  WHERE RX.source_system_id = 4
                  AND TX.source_system_id = 4
               ) EPS
           WHERE EPR.CHAIN_ID = EPS.CHAIN_ID AND
                 EPR.NHIN_STORE_ID = EPS.NHIN_STORE_ID AND
                 EPR.RX_TX_RX_NUMBER = EPS.RX_NUMBER AND
                 EPR.RX_TX_TX_NUMBER = EPS.RX_TX_TX_NUMBER )
       ;;
  }

  dimension: rx_number {
    label: "Prescription RX Number"
    description: "Prescription number"
    type: number
    sql: ${TABLE}.RX_TX_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: tx_number {
    label: "Prescription TX Number"
    description: "Transaction number"
    type: number
    sql: ${TABLE}.RX_TX_TX_NUMBER ;;
    value_format: "####"
  }

  dimension: rx_tx_id {
    label: "Prescription TX Source ID"
    description: "Prescription Transaction Source System Identifier"
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
    value_format: "####"
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_number} ||'@'|| ${tx_number} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  #############################################################################################################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: file_buy {
    label: "Prescription File Buy"
    description: "Identifies if a patient or script was imported into EPS as part of a file buy.  Is populated with the date the patient or script was imported into the system"
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
    sql: ${TABLE}.RX_FILE_BUY_DATE ;;
  }

  dimension_group: filled {
    label: "Prescription Filled"
    description: "Date prescription was filled"
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
    sql: ${TABLE}.RX_TX_FILLED_DATE ;;
  }

  dimension_group: reportable_sales {
    label: "Prescription Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
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
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension_group: sold {
    label: "Prescription Sold"
    description: "Date/Time prescription was sold"
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
    sql: ${TABLE}.RX_TX_SOLD_DATE ;;
  }

  ################################################################################### Dimension ###############################################################################

  dimension: file_buy_flag {
    label: "Prescription File Buy"
    description: "Y/N Flag Indicating if a prescription/transaction came via File Buy"
    type: string
    sql: ${TABLE}.FILE_BUY_FLAG ;;
    suggestions: ["Y", "N", "N/A"]
  }

  dimension: rx_source {
    label: "Prescription Source"
    description: "Indicates what process was used to create this prescription record. This field is EPS only!!!"
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

  dimension: rx_tx_missing_state {
    label: "Prescription Transaction Missing State"
    description: "Provides insights if transaction is present in EPS but not in EPR and vice versa, based on the data processed into the BI system"
    type: string
    sql: ${TABLE}.RX_TX_MISSING_STATE ;;
  }

  dimension: rx_tx_missing_detail_state {
    label: "Prescription Transaction Missing Detail State"
    description: "Provides insights if transaction is present in EPS but not in EPR and vice versa, based on the data processed into the BI system. Provides detail level analysis (EPS RX MISSING IN BI SYSTEM, EPS TX MISSING IN BI SYSTEM, EPS RX & TX MISSING IN BI SYSTEM, EPS RX/TX MISSING IN EDW)"
    type: string
    sql: ${TABLE}.RX_TX_MISSING_DETAIL_STATE ;;
  }

  ################################################################################### Measures ################################################################################

  measure: sum_price {
    label: "Total Sales"
    description: "Total Price of prescription"
    type: sum
    sql: ${TABLE}.RX_TX_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_acquisition_cost {
    label: "Prescription ACQ Cost"
    description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
    type: sum
    sql: ${TABLE}.RX_TX_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_margin_dollars {
    label: "Prescription Gross Margin $"
    description: "Margin $ of the Prescription based on the Period Selected. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription))"
    type: sum
    sql: ${TABLE}.RX_TX_GROSS_MARGIN ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: count {
    label: "Total Scripts"
    description: "Total Scripts for Active fills"
    type: count_distinct
    # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
    sql: ${chain_id} ||'@'||  ${nhin_store_id} ||'@'||  ${tx_number} ;; #ERXLPS-1649
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  ################################################################################### End of Measures ################################################################################

  set: detail {
    fields: [
      chain.chain_name,
      store_alignment.division,
      store_alignment.region,
      store_alignment.district,

      #Changes made w.r.t ERXLPS-126
      store.store_number,
      store.store_name,
      dq_active_rx_tx_eps_classic_missing_state.rx_tx_missing_state,
      dq_active_rx_tx_eps_classic_missing_state.rx_tx_missing_detail_state,
      dq_active_rx_tx_eps_classic_missing_state.rx_tx_id,
      dq_active_rx_tx_eps_classic_missing_state.rx_number,
      dq_active_rx_tx_eps_classic_missing_state.tx_number,
      dq_active_rx_tx_eps_classic_missing_state.filled_time,
      dq_active_rx_tx_eps_classic_missing_state.reportable_sales_time,
      dq_active_rx_tx_eps_classic_missing_state.sold_time,
      dq_active_rx_tx_eps_classic_missing_state.sum_price,
      dq_active_rx_tx_eps_classic_missing_state.sum_acquisition_cost,
      dq_active_rx_tx_eps_classic_missing_state.sum_margin_dollars
    ]
  }
}

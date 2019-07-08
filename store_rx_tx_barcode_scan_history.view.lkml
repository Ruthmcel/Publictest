view: store_rx_tx_barcode_scan_history {
  derived_table: {
    sql:
    select chain_id,
           nhin_store_id,
           rx_tx_barcode_scan_history_id,
           rx_tx_barcode_scan_history_scanned_barcode,
           rx_tx_barcode_scan_history_matched_scan_flag,
           rx_tx_barcode_scan_history_scan_date,
           rx_tx_barcode_scan_history_employee_number,
           rx_tx_barcode_scan_history_ndc_validation_method_code,
           rx_tx_id,
           row_number() over(partition by chain_id,nhin_store_id,rx_tx_id order by rx_tx_barcode_scan_history_id desc) barcode_scan_rnk
      from edw.f_rx_tx_barcode_scan_history
     ;;
  }

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_barcode_scan_history_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain ID"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_barcode_scan_history_id {
    label: "Rx Tx Barcode Scan History Id"
    description: "Unique ID number identifying a barcode scan record"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_ID ;;
  }

  dimension: rx_tx_id {
    label: "Rx Tx Id"
    description: "Unique ID identifying this EPS RX_TX record, which is a foreign key to the EPS RX_TX table"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_tx_barcode_scan_history_scanned_barcode {
    label: "Scanned Barcode"
    description: "Stores the scanned NDC of the stock bottle. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - History"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_SCANNED_BARCODE ;;
  }

  dimension: rx_tx_barcode_scan_history_matched_scan_flag {
    label: "Matched Scan"
    description: "Yes/No flag that indicates if the Scanned Bottle matches the NDC entered during the Data Entry / Order Entry / Rx Filling process. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: yesno
    group_label: "Barcode Scan - History"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_MATCHED_SCAN_FLAG = 'Y' ;;
  }

  dimension_group: rx_tx_barcode_scan_history_scan {
    label: "Scan - History"
    description: "Date/time that the Scan of the Barcode for the NDC occurred. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_SCAN_DATE ;;
  }

  dimension: rx_tx_barcode_scan_history_employee_number {
    label: "Employee Number"
    description: "The employee number of the person who perfomred the Scan operation. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - History"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_barcode_scan_history_ndc_validation_method_code {
    label: "NDC Validation Method Code"
    description: "Flag that indicates how the NDC was validated at time of fill. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - History"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_NDC_VALIDATION_METHOD_CODE = 'M' ;;
        label: "MANUAL ENTRY"
      }

      when: {
        sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_NDC_VALIDATION_METHOD_CODE = 'S' ;;
        label: "SCANNED"
      }

      when: {
        sql: true ;;
        label: "OFF"
      }
    }
  }

  dimension: barcode_scan_rnk {
    hidden: yes
    group_label: "Barcode Scan - Latest. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: number
    sql: ${TABLE}.BARCODE_SCAN_RNK ;;
  }

  dimension: current_rx_tx_barcode_scan_history_scanned_barcode {
    label: "Scanned Barcode (Unique)"
    description: "Stores the scanned NDC of the stock bottle. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - Latest"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_SCANNED_BARCODE ;;
  }

  dimension: current_rx_tx_barcode_scan_history_matched_scan_flag {
    label: "Matched Scan (Unique)"
    description: "Yes/No flag that indicates if the Scanned Bottle matches the NDC entered during the Data Entry / Order Entry / Rx Filling process. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: yesno
    group_label: "Barcode Scan - Latest"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_MATCHED_SCAN_FLAG = 'Y' ;;
  }

  dimension_group: current_rx_tx_barcode_scan_history_scan {
    label: "Scan (Unique)"
    description: "Date/time that the Scan of the Barcode for the NDC occurred. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_SCAN_DATE ;;
  }

  dimension: current_rx_tx_barcode_scan_history_employee_number {
    label: "Employee Number (Unique)"
    description: "The employee number of the person who perfomred the Scan operation. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - Latest"
    sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_EMPLOYEE_NUMBER ;;
  }

  dimension: current_rx_tx_barcode_scan_history_ndc_validation_method_code {
    label: "NDC Validation Method (Unique)"
    description: "Flag that indicates how the NDC was validated at time of fill. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: string
    group_label: "Barcode Scan - Latest"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_NDC_VALIDATION_METHOD_CODE = 'M' ;;
        label: "MANUAL ENTRY"
      }

      when: {
        sql: ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_NDC_VALIDATION_METHOD_CODE = 'S' ;;
        label: "SCANNED"
      }

      when: {
        sql: true ;;
        label: "OFF"
      }
    }
  }

  measure: count_scan {
    label: "Total Barcode Validated"
    description: "Total number of barcode validation performed. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: count
    group_label: "Barcode Scan - History"
    value_format: "#,##0"
  }

  measure: current_count_scan {
    label: "Total Barcode Validated (Unique)"
    description: "Total number of barcode validation performed. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: count_distinct
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_barcode_scan_history_id} ;; #ERXLPS-1649
    group_label: "Barcode Scan - Latest"
    value_format: "#,##0"
  }

  measure: current_count_barcode_scan {
    label: "Total Barcode Scanned (Unique)"
    description: "Total number of barcode scanned. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: count_distinct
    hidden: yes
    sql: case when ${TABLE}.RX_TX_BARCODE_SCAN_HISTORY_NDC_VALIDATION_METHOD_CODE = 'S' then (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_barcode_scan_history_id}) end;;
    group_label: "Barcode Scan - Latest"
    value_format: "#,##0"
  }

  measure: scanned_barcode_fill_pct {
    label: "Scanned Barcode Fills (Unique) %"
    description: "The Percent of total Prescription Fill’s for which NDC Barcode was scanned at the time of validation. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: number
    group_label: "Barcode Scan - Latest"
    sql: ${current_count_barcode_scan}/NULLIF(${eps_rx_tx.count},0) ;;
    value_format: "00.00%"
  }

  measure: sales_scanned_barcode_fill_pct {
    label: "Scanned Barcode Fills (Unique) %"
    description: "The Percent of total Prescription Fill’s for which NDC Barcode was scanned at the time of validation. EPS Table Name: RX_TX_BARCODE_SCAN_HISTORY"
    type: number
    group_label: "Barcode Scan - Latest"
    sql: ${current_count_barcode_scan}/NULLIF(${sales.count_distinct_rx_tx_id},0) ;;
    value_format: "00.00%"
  }

  set: barcode_scan_current_list {
    fields: [
      current_rx_tx_barcode_scan_history_scanned_barcode,
      current_rx_tx_barcode_scan_history_matched_scan_flag,
      current_rx_tx_barcode_scan_history_employee_number,
      current_rx_tx_barcode_scan_history_ndc_validation_method_code,
      current_count_scan,
      scanned_barcode_fill_pct,
      barcode_scan_rnk,
      current_rx_tx_barcode_scan_history_scan,
      current_rx_tx_barcode_scan_history_scan_time,
      current_rx_tx_barcode_scan_history_scan_date,
      current_rx_tx_barcode_scan_history_scan_week,
      current_rx_tx_barcode_scan_history_scan_month,
      current_rx_tx_barcode_scan_history_scan_month_num,
      current_rx_tx_barcode_scan_history_scan_year,
      current_rx_tx_barcode_scan_history_scan_quarter,
      current_rx_tx_barcode_scan_history_scan_quarter_of_year,
      current_rx_tx_barcode_scan_history_scan_hour_of_day,
      current_rx_tx_barcode_scan_history_scan_time_of_day,
      current_rx_tx_barcode_scan_history_scan_day_of_week,
      current_rx_tx_barcode_scan_history_scan_day_of_month,
      current_rx_tx_barcode_scan_history_scan_week_of_year,
      current_rx_tx_barcode_scan_history_scan_day_of_week_index
    ]
  }

  set: sales_barcode_scan_current_list {
    fields: [
      current_rx_tx_barcode_scan_history_scanned_barcode,
      current_rx_tx_barcode_scan_history_matched_scan_flag,
      current_rx_tx_barcode_scan_history_employee_number,
      current_rx_tx_barcode_scan_history_ndc_validation_method_code,
      current_count_scan,
      sales_scanned_barcode_fill_pct,
      barcode_scan_rnk,
      current_rx_tx_barcode_scan_history_scan,
      current_rx_tx_barcode_scan_history_scan_time,
      current_rx_tx_barcode_scan_history_scan_date,
      current_rx_tx_barcode_scan_history_scan_week,
      current_rx_tx_barcode_scan_history_scan_month,
      current_rx_tx_barcode_scan_history_scan_month_num,
      current_rx_tx_barcode_scan_history_scan_year,
      current_rx_tx_barcode_scan_history_scan_quarter,
      current_rx_tx_barcode_scan_history_scan_quarter_of_year,
      current_rx_tx_barcode_scan_history_scan_hour_of_day,
      current_rx_tx_barcode_scan_history_scan_time_of_day,
      current_rx_tx_barcode_scan_history_scan_day_of_week,
      current_rx_tx_barcode_scan_history_scan_day_of_month,
      current_rx_tx_barcode_scan_history_scan_week_of_year,
      current_rx_tx_barcode_scan_history_scan_day_of_week_index
    ]
  }

  set: barcode_scan_history_list {
    fields: [
      rx_tx_barcode_scan_history_scanned_barcode,
      rx_tx_barcode_scan_history_matched_scan_flag,
      rx_tx_barcode_scan_history_employee_number,
      rx_tx_barcode_scan_history_ndc_validation_method_code,
      count_scan,
      rx_tx_barcode_scan_history_scan,
      rx_tx_barcode_scan_history_scan_time,
      rx_tx_barcode_scan_history_scan_date,
      rx_tx_barcode_scan_history_scan_week,
      rx_tx_barcode_scan_history_scan_month,
      rx_tx_barcode_scan_history_scan_month_num,
      rx_tx_barcode_scan_history_scan_year,
      rx_tx_barcode_scan_history_scan_quarter,
      rx_tx_barcode_scan_history_scan_quarter_of_year,
      rx_tx_barcode_scan_history_scan_hour_of_day,
      rx_tx_barcode_scan_history_scan_time_of_day,
      rx_tx_barcode_scan_history_scan_day_of_week,
      rx_tx_barcode_scan_history_scan_day_of_month,
      rx_tx_barcode_scan_history_scan_week_of_year,
      rx_tx_barcode_scan_history_scan_day_of_week_index
    ]
  }
}

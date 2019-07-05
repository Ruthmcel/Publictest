view: rx_tx_package_information {
  sql_table_name: EDW.F_PACKAGE_INFORMATION ;;

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  # [ERXLPS -100] Changes - Was using ID_RX_TX and was replaced with RX_TX_ID
  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: pkg_info_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PACKAGE_INFORMATION_ID ;;
  }

  dimension: pkg_info_shipment_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SHIPMENT_ID ;;
  }

  dimension: pkg_info_unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${pkg_info_id} ;; #ERXLPS-1649
  }

  dimension_group: pkg_info_shipment_actual {
    label: "Prescription Pkg Info Shipment Actual"
    description: "Stores the Date that the Package was shipped"
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
      day_of_month
    ]
    sql: ${TABLE}.PKG_INFO_SHIP_DATE ;;
  }

  dimension_group: pkg_info_shipment_promised {
    label: "Prescription Pkg Info Shipment Promised"
    description: "Stores the Date that the Package was promised to ship on"
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
      day_of_month
    ]
    sql: ${TABLE}.PKG_INFO_SHIPMENT_PROMISED_DT ;;
  }

  dimension: pkg_info_shipper_name {
    type: string
    label: "Prescription Pkg Info Shipper Name"
    description: "Name of shipping company"
    sql: ${TABLE}.PKG_INFO_SHIPPER_NAME ;;
  }

  # [ERXLPS -100] Changes - SQL Unknown Issue. Fixed by the applying THEN.
  dimension: pkg_info_shipping_method {
    type: string
    label: "Prescription Pkg Info Shipping Method"
    description: "Type of Shipping that was chosen for delivery"
    sql: CASE WHEN ${TABLE}.PKG_INFO_SHIPPING_METHOD IS NULL THEN 'Unknown' ELSE ${TABLE}.PKG_INFO_SHIPPING_METHOD END ;;
  }

  dimension: pkg_info_signature_required {
    type: string
    label: "Prescription Pkg Info Sign Req Flag"
    description: "Flag to indicate if a signature is recquired"
    sql: ${TABLE}.PKG_INFO_SIGNATURE_REQUIRED ;;
  }

  measure: count {
    label: "Prescription Pkg Info Shipments Count"
    type: count
    value_format: "#,##0"
  }

  measure: pkg_info_actual_ship_cost {
    label: "Prescription Pkg Info Shipping Cost - Actual"
    type: sum
    sql: ${TABLE}.PKG_INFO_ACTUAL_SHIP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: pkg_info_average_ship_cost {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Pkg Info Shipping Cost - Average"
    type: average
    sql: ${TABLE}.PKG_INFO_AVERAGE_SHIPPING_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

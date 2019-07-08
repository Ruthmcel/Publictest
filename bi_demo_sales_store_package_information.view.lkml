#ERXLPS-1349 #ERXLPS-1383
view: bi_demo_sales_store_package_information {
  label: "Package Information - Store"
  sql_table_name: EDW.D_STORE_PACKAGE_INFORMATION ;;

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_package_information_id {
    label: "Store Package Information ID"
    description: "Unique Id number identifying this record"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_pkg_info_unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${store_package_information_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;;
  }

  ######################## END OF PK/FK REFRENCES ########################

  dimension_group: store_package_information_shipped_date {
    label: "Store Package Information Shipped"
    description: "Date/Time the fulfillment facility shipped the package of prescription medications. EPS Table: PACKAGE_INFO"
    type: time
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPED_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: store_package_information_packer_initials {
    label: "Store Package Information Packer Initials"
    description: "Initials of employee who packed prescription medications for shipping. EPS Table: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_PACKER_INITIALS ;;
  }

  dimension: store_package_information_packer_number {
    label: "Store Package Information Packer Number"
    description: "Employee ID of employee who packed prescription medications for shipping. EPS Table: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_PACKER_NUMBER ;;
  }

  dimension: store_package_information_manifest_initials {
    label: "Store Package Information Manifest Initials"
    description: "Initials of employee who packed prescription medications for shipping and applied packing list and shipping label. EPS Table: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_MANIFEST_INITIALS ;;
  }

  dimension: store_package_information_manifest_number {
    label: "Store Package Information Manifest Number"
    description: "Employee ID of employee who packed prescription medications for shipping and applied packing list and shipping label. EPS Table: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_MANIFEST_NUMBER ;;
  }

  dimension: store_package_information_tracking_number {
    label: "Store Package Information Tracking Number"
    description: "Tracking number assigned by common carrier employed to ship package to patient. e.g. FedEx airbill number. EPS Table: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_TRACKING_NUMBER ;;
  }

  dimension: store_package_information_weight {
    label: "Store Package Information Weight"
    description: "Gross weight of the shipped package. EPS Table: PACKAGE_INFO"
    type: number
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_WEIGHT ;;
  }

  dimension: store_package_information_shipper_name {
    label: "Store Package Information Shipper Name"
    description: "Name of common carrier employed to ship package, e.g. USPS, FedEx, etc. EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPER_NAME ;;
  }

  dimension: store_package_information_cf_system_package_number {
    label: "Store Package Information Central Fill System Package Number"
    description: "Package number assigned by the fulfillment facility. EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_CF_SYSTEM_PACKAGE_NUMBER ;;
  }

  dimension: store_package_information_shipping_system_package_identifier {
    label: "Store Package Information Shipping System Package Identifier"
    description: "Shipping system package ID from manifest: Fedex, UPS, etc. (named Logicor_Package_ID in SBMO). EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPING_SYSTEM_PACKAGE_IDENTIFIER ;;
  }

  dimension: store_package_information_shipping_box_identifier {
    label: "Store Package Information Shipping Box Identifier"
    description: "In the status update message from SBMO we will receive the shipping box type and save in EPS, The shipping box type received from SBMO will be saved in this column at EPS. EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPING_BOX_IDENTIFIER ;;
  }

  dimension: store_package_information_actual_shipping_method_code {
    label: "Store Package Information Actual Shipping Method Code"
    description: "For mail order prescriptions we will send the shipping method code and shipping method description. We will send this information to SBMO and also receive the information from SBMO if updated. EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_METHOD_CODE ;;
  }

  dimension: store_package_information_actual_shipping_method_description {
    label: "Store Package Information Actual Shipping Method Description"
    description: "For mail order prescriptions we will send the shipping method code and shipping method description. We will send this information to SBMO and also receive the information from SBMO if updated. EPS Table: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_METHOD_DESCRIPTION ;;
  }

  dimension_group: source_timestamp {
    label: "Store Package Information Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PACKAGE_INFO"
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: source_create_timestamp {
    label: "Package Information Source Create"
    description: "Date/Time the record was created in source table."
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  ######################## END OF DIMENSIONS ########################

  measure: count {
    label: "Prescription Pkg Info Shipments Count."
    description: "Prescription Pkg Info Shipments Count. EPS Table: PACKAGE_INFO"
    type: count
    value_format: "#,##0"
  }

  measure: sum_store_pkg_info_actual_ship_cost {
    label: "Prescription Pkg Info Shipping Cost - Actual"
    description: "Prescription Package Information Shipping Cost - Actual. EPS Table: PACKAGE_INFO"
    type: sum
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_store_pkg_info_average_ship_cost {
    label: "Prescription Package Info Shipping Cost - Average"
    description: "Prescription Package Info Shipping Cost - Average. EPS Table: PACKAGE_INFO"
    type: average
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_AVERAGE_SHIPPING_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_pkg_info_weight {
    label: "Store Package Information Weight"
    description: "Gross weight of the shipped package. EPS Table: PACKAGE_INFO"
    type: sum
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_WEIGHT ;;
    value_format: "###0.00"
  }

  ######################## END OF MEASURES ########################
}

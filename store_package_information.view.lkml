view: store_package_information {
  label: "Store Package Information"
  sql_table_name: EDW.D_STORE_PACKAGE_INFORMATION ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_package_information_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table Name: PACKAGE_INFO"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table Name: PACKAGE_INFO"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_package_information_id {
    label: "Store Package Information Id"
    description: "Unique Id number identifying this record. EPS Table Name: PACKAGE_INFO"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table Name: PACKAGE_INFO"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: store_package_information_shipped {
    label: "Store Package Information Shipped"
    description: "The date the fulfillment facility shipped the package of prescription medications. EPS Table Name: PACKAGE_INFO"
    type: time
    timeframes: [date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPED_DATE ;;
  }

  dimension: store_package_information_packer_initials {
    label: "Store Package Information Packer Initials"
    description: "Initials of employee who packed prescription medications for shipping. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_PACKER_INITIALS ;;
  }

  dimension: store_package_information_packer_number {
    label: "Store Package Information Packer Number"
    description: "Employee ID of employee who packed prescription medications for shipping. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_PACKER_NUMBER ;;
  }

  dimension: store_package_information_manifest_initials {
    label: "Store Package Information Manifest Initials"
    description: "Initials of employee who packed prescription medications for shipping and applied packing list and shipping label. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_MANIFEST_INITIALS ;;
  }

  dimension: store_package_information_manifest_number {
    label: "Store Package Information Manifest Number"
    description: "Employee ID of employee who packed prescription medications for shipping and applied packing list and shipping label. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_MANIFEST_NUMBER ;;
  }

  dimension: store_package_information_tracking_number {
    label: "Store Package Information Tracking Number"
    description: "Tracking number assigned by common carrier employed to ship package to patient. e.g. FedEx airbill number. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_TRACKING_NUMBER ;;
  }

  dimension: store_package_information_weight {
    label: "Store Package Information Weight"
    description: "Gross weight of the shipped package. EPS Table Name: PACKAGE_INFO "
    type: number
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_WEIGHT ;;
  }

  dimension: store_package_information_shipper_name {
    label: "Store Package Information Shipper Name"
    description: "Name of common carrier employed to ship package, e.g. USPS, FedEx, etc. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPER_NAME ;;
  }

  dimension: store_package_information_actual_shipping_cost_amount {
    label: "Store Package Information Actual Shipping Cost Amount"
    description: "Actual cost of shipping and handling package. EPS Table Name: PACKAGE_INFO"
    type: number
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_COST_AMOUNT ;;
  }

  dimension: store_package_information_cf_system_package_number {
    label: "Store Package Information CF System Package Number"
    description: "Package number assigned by the fulfillment facility. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_CF_SYSTEM_PACKAGE_NUMBER ;;
  }

  measure: store_package_information_average_shipping_cost_amount {
    label: "Store Package Information Average Shipping Cost Amount"
    description: "The cost of shipping each prescription refill calculated as the quotient of the ACTUAL_SHIP_COST divide by the number of prescription refills in the package.EPS Table Name: PACKAGE_INFO"
    type: sum
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_AVERAGE_SHIPPING_COST_AMOUNT ;;
  }

  dimension: store_package_information_shipping_system_package_identifier {
    label: "Store Package Information Shipping System Package Identifier"
    description: "Shipping system package ID from manifest: Fedex, UPS, etc. (named Logicor_Package_ID in SBMO). EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPING_SYSTEM_PACKAGE_IDENTIFIER ;;
  }

  dimension: store_package_information_shipping_box_identifier {
    label: "Store Package Information Shipping Box Identifier"
    description: "In the status update message from SBMO we will receive the shipping box type and save in EPS, The shipping box type received from SBMO will be saved in this column at EPS. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_SHIPPING_BOX_IDENTIFIER ;;
  }

  dimension: store_package_information_actual_shipping_method_code {
    label: "Store Package Information Actual Shipping Method Code"
    description: "For mail order prescriptions we will send the shipping method code and shipping method description. We will send this information to SBMO and also receive the information from SBMO if updated. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_METHOD_CODE ;;
  }

  dimension: store_package_information_actual_shipping_method_description {
    label: "Store Package Information Actual Shipping Method Description"
    description: "For mail order prescriptions we will send the shipping method code and shipping method description. We will send this information to SBMO and also receive the information from SBMO if updated. EPS Table Name: PACKAGE_INFO"
    type: string
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_ACTUAL_SHIPPING_METHOD_DESCRIPTION ;;
  }

  dimension_group: source {
    label: "Store Package Information Source Last Update"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis. EPS Table Name: PACKAGE_INFO"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW. EPS Table Name: PACKAGE_INFO"
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert{
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW. EPS Table Name: PACKAGE_INFO"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW. EPS Table Name: PACKAGE_INFO"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW. EPS Table Name: PACKAGE_INFO"
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension: store_package_information_dispenser_batch_identifier {
    label: "Store Package Information Dispenser Batch Identifier"
    description: "Holds the dispenser batch identifier received from dispenser via SBMO. EPS Table Name: PACKAGE_INFO"
    type: number
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_DISPENSER_BATCH_IDENTIFIER ;;
  }

  dimension: store_package_information_dispensed_decimal_quantity {
    label: "Store Package Information Dispensed Decimal Quantity"
    description: "Holds the dispensed decimal quantity received from dispenser via SBMO. EPS Table Name: PACKAGE_INFO"
    type: number
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_DISPENSED_DECIMAL_QUANTITY ;;
  }

  dimension: store_package_information_auto_dispensed_flag {
    label: "Store Package Information Auto Dispensed Flag"
    description: "Holds the auto dispensed value received from dispenser via SBMO. EPS Table Name: PACKAGE_INFO"
    type: yesno
    sql: ${TABLE}.STORE_PACKAGE_INFORMATION_AUTO_DISPENSED_FLAG ='Y';;
  }

  dimension_group: source_create_timestamp {
    label: "Package Information Source Create"
    description: "Date/Time the record was created in source table."
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

############################################################ END OF DIMENSIONS ############################################################
}

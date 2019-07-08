view: bi_demo_sales_eps_shipment {
  sql_table_name: EDW.F_SHIPMENT ;;

  dimension: shipment_id {
    label: "Shipment ID"
    description: "Unique ID number identifying a shipment record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.SHIPMENT_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${shipment_id}||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;;
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

  dimension: shipment_address_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SHIPMENT_ADDRESS_ID ;;
  }

  dimension: shipment_ship_to_phone_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SHIPMENT_SHIP_TO_PHONE_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: shipment_create {
    label: "Shipment Created"
    description: "Date/Time shipment record was created. EPS_TABLE: SHIPMENT"
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
    sql: ${TABLE}.SHIPMENT_CREATE_DATE ;;
  }

  dimension_group: shipment_promised {
    label: "Shipment Promised"
    description: "Date/Time shipment was promised. EPS_TABLE: SHIPMENT"
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
    sql: ${TABLE}.SHIPMENT_PROMISED_DATE ;;
  }

  dimension_group: shipment_date {
    label: "Shipment"
    description: "Date/Time that the shipment should be shipped by. EPS_TABLE: SHIPMENT"
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
    sql: ${TABLE}.SHIPMENT_DATE ;;
  }

  ########################################################################################################### Dimensions ################################################################################################
  dimension: shipment_care_of {
    label: "Shipment Care Of"
    description: "Indicates the intermediary who is responsible for accepting the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_CARE_OF ;;
  }

  dimension: shipment_created_by {
    label: "Shipment Created By"
    description: "Indicates the name of the person that created the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_CREATED_BY ;;
  }

  dimension: shipment_ship_to {
    label: "Shipment Ship To"
    description: "Indicates the person or destination that the shipment is sent to. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_SHIP_TO ;;
  }

  dimension: shipment_shipper_name {
    label: "Shipment Shipper Name"
    description: "The name of the person or service that is delivering the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_SHIPPER_NAME ;;
  }

  dimension: shipment_shipping_instructions {
    label: "Shipment Shipping Instructions"
    description: "Stores any special instructions for the delivery of the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_SHIPPING_INSTRUCTIONS ;;
  }

  dimension: shipment_shipping_method {
    label: "Shipment Shipping Method"
    description: "The method that is being used to send the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_SHIPPING_METHOD ;;
  }

  dimension: shipment_tracking_number {
    label: "Shipment Tracking Number"
    description: "The tracking number for the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: ${TABLE}.SHIPMENT_TRACKING_NUMBER ;;
  }

  dimension: shipment_tracking_url_format {
    sql: CASE WHEN REGEXP_LIKE(UPPER(TRIM(${shipment_tracking_number})),'\\b(\\d\\d\\d\\d ?\\d\\d\\d\\d ?\\d\\d\\d\\d)\\b') = 'TRUE' OR UPPER(TRIM(${shipment_shipper_name})) LIKE '%FED%' THEN CONCAT(CONCAT('https://www.fedex.com/apps/fedextrack/?action=track&tracknumbers=',UPPER(TRIM(${shipment_tracking_number}))),'&locale=en_US&cntry_code=us') WHEN REGEXP_LIKE(UPPER(TRIM(${shipment_tracking_number})),'(1Z ?[0-9A-Z]{3} ?[0-9A-Z]{3} ?[0-9A-Z]{2} ?[0-9A-Z]{4} ?[0-9A-Z]{3} ?[0-9A-Z]|[\dT]\d\d\d ?\d\d\d\d ?\d\d\d)') = 'TRUE' OR UPPER(TRIM(${shipment_shipper_name})) LIKE '%UPS%' THEN CONCAT('http://wwwapps.ups.com/WebTracking/processInputRequest?TypeOfInquiryNumber=T&InquiryNumber1=',UPPER(TRIM(${shipment_tracking_number}))) WHEN LENGTH(TRIM(${shipment_tracking_number})) >=22 OR UPPER(TRIM(${shipment_shipper_name})) LIKE '%USPS%' THEN CONCAT('https://tools.usps.com/go/TrackConfirmAction?qtc_tLabels1=',UPPER(TRIM(${shipment_tracking_number}))) END ;;
  }

  dimension: shipment_tracking_url {
    label: "Shipment Tracking URL"
    description: "The web URL used for tracking the shipment. EPS_TABLE: SHIPMENT"
    sql: ${shipment_tracking_url_format} ;;
    html: #<a href="https://www.google.com/maps/place/{{value}}" target="_blank">
      <a href="{{value}}" target="_blank">
      <img src="https://cdn2.iconfinder.com/data/icons/perfect-flat-icons-2/512/Order_tracking_online_offer_cart_shopping.png" height=16></a>
      ;;
  }

  ########################################################################################################### SQL (Case) /Yes-No Dimensions ################################################################################################
  dimension: shipment_refrigerated {
    label: "Shipment Refrigerated"
    description: "The Storage Temperature required for the shipment as specified by the User who initiated the shipment. EPS_TABLE: SHIPMENT"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = ${TABLE}.SHIPMENT_REFRIGERATED AND MC.EDW_COLUMN_NAME = 'SHIPMENT_REFRIGERATED') ;;
    suggestions: ["FROZEN", "REFRIGERATED", "ROOM TEMPERATURE", "NOT SET"]
  }

  #     suggest_explore: master_code
  #     suggest_dimension: master_code.master_code_short_description


  dimension: shipment_require_signature {
    label: "Shipment Require Signature"
    description: "Yes / No Flag indicating if a signature is required when the shipment is picked up or delivered. EPS_TABLE: SHIPMENT"
    type: yesno
    sql: ${TABLE}.SHIPMENT_REQUIRE_SIGNATURE = 'Y' ;;
  }

  dimension_group: source_timestamp {
    label: "Shipment Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS_TABLE: SHIPMENT"
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  ####################################################################################################### Measures ####################################################################################################

  measure: count {
    label: "Total Shipment Count"
    description: "Total Shipment Count. EPS_TABLE: SHIPMENT"
    type: count
    value_format: "#,##0"
  }

  measure: sum_shipment_weight {
    label: "Total Shipment Weight"
    description: "The weight of the shipment package. EPS_TABLE: SHIPMENT"
    type: sum
    sql: ${TABLE}.SHIPMENT_WEIGHT ;;
    value_format: "###0.00"
  }

  measure: sum_shipment_cost {
    label: "Total Shipment Cost"
    description: "The cost of delivering the shipment. EPS_TABLE: SHIPMENT"
    type: sum
    sql: ${TABLE}.SHIPMENT_COST ;;
    value_format: "#,##0.0000"
  }
}

view: turnrx_store_drug_inventory_mvmnt_snapshot {
  label: "Store Drug Inventory Movement Detail Snapshot"
  sql_table_name: EDW.F_STORE_DRUG_INVENTORY_MOVEMENT_DETAIL_SNAPSHOT  ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: primary_key {
    description: "Unique Identification number."
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_drug_ndc} || '@' || ${activity_date} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "Unique ID number assigned by NHIN for the source store associated to this record."
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_drug_ndc {
    label: "Store Drug NDC"
    description: "National Drug Code used as a universal product identifier for human drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_NDC ;;
  }

  dimension_group: activity {
    label: "Activity"
    description: "Calendar Date that represents the day in which the Inventory values pertain too."
    type: time
    sql: ${TABLE}.ACTIVITY_DATE ;;
    timeframes: [date,week,month,month_num,month_name,year,quarter,quarter_of_year,day_of_week,day_of_month,day_of_year]
    drill_fields: [] #disabled the drill ability as looker by default drills for timeframes #TRX-5281
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system."
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_id {
    label: "Drug Id"
    description: "Unique ID number identifying this local Drug record."
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: store_drug_gpi {
    label: "Store Drug Gpi"
    description: "Generic Product Identifier (GPI) categorizes drug products by a hierarchical therapeutic classification scheme used for computerized therapeutic drug monitoring applications (such as duplicate therapy and drug dosing), market research, and reporting applications."
    type: string
    sql: ${TABLE}.STORE_DRUG_GPI ;;
  }

  dimension: store_drug_inventory_cumulative_quantity_committed {
    label: "Store Drug Inventory Cumulative Quantity Committed"
    description: "Cumulative aggregate of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_cumulative_drug_ordered_not_received_quantity {
    label: "Store Drug Inventory Cumulative Drug Ordered Not Received Quantity"
    description: "Sum of Quantity where Purchase Orders are still open and have not been closed/applied to inventory. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension_group: store_drug_inventory_drug_order_last_create {
    label: "Store Drug Inventory Drug Order Last Create"
    description: "Last create date for a drug order for this drug."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_LAST_CREATE_DATE ;;
  }

  dimension: store_drug_inventory_calculated_ending_on_hand {
    label: "Store Drug Inventory Calculated Ending On Hand"
    description: "Calculated Ending On Hand per Activity Date based on Starting On Hand, Quantities committed and un-committed, and adjustments. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_calculated_on_hand_balance_flag {
    label: "Store Drug Inventory Calculated On Hand Balance Flag"
    description: "Yes/No flag that indicates if the database ending on hand matches the calculated ending on hand."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ON_HAND_BALANCE_FLAG = 'Y' ;;
  }

  dimension: store_drug_inventory_calculated_ending_on_hand_variance {
    label: "Store Drug Inventory Calculated Ending On Hand Variance"
    description: "Variance from the database ending on hand to the calculated ending on hand. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND_VARIANCE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_item_number {
    label: "Store Drug Inventory Reorder Primary Level Item Number"
    description: "ITEM_NUM is the supplier's order number for this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ITEM_NUMBER ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_warehouse_region {
    label: "Store Drug Inventory Reorder Primary Level Warehouse Region"
    description: "WAREHOUSE_REGION represents the region this drug would be sourced from, from the warehouse."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_WAREHOUSE_REGION ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_order_point {
    label: "Store Drug Inventory Reorder Primary Level Order Point"
    description: "Point at which the system should reorder new supplies of this drug. When the on-hand amount minus allocated qty reaches the order point, the system will generate a drug order maintenance record when the Generate Order Records report is run. Example: '9'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ORDER_POINT ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_order_quantity {
    label: "Store Drug Inventory Reorder Primary Level Order Quantity"
    description: "ORDER_QTY is the quantity to reorder when the drug reaches the reorder point. The system uses a multiple of this quantity to generate drug order maintenance records that brings the on-hand quantity equal to or greater than the Up To quantity. If the quantity is not evenly divisible by the number in the Pack field, the EPS client system does not let you add or update a drug order record. Example: '300'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ORDER_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_minimum_quantity {
    label: "Store Drug Inventory Reorder Primary Level Minimum Quantity"
    description: "MINIMUM_QTY is the on-hand amount needed after filling the order. The system uses this quantity during the Generate Order Records function and orders the quantity of the drug that brings the on-hand quantity equal to or greater than this value. Example: '90'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_MINIMUM_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_conversion_factor {
    label: "Store Drug Inventory Reorder Primary Level Conversion Factor"
    description: "CONVERSION_FACTOR is the number the system uses to convert the ordered quantity to the quantity reported that is sent to the supplier in the Drug Order List. To determine the number of reorder units, the system first divides the reorder quantity by the pack size. Then, it divides the result by the conversion factor. The system reports the result on the Drug Order List report."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_CONVERSION_FACTOR ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_unit {
    label: "Store Drug Inventory Reorder Primary Level Unit"
    description: "UNIT is the unit/basis of measurement for the order quantity that the system transmits during an electronic drug order."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'BO' THEN 'BO - BOTTLE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'BX' THEN 'BX - BOX'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'CA' THEN 'CA - CASE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'CH' THEN 'CH - CONTAINER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'CT' THEN 'CT - CARTON'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'DE' THEN 'DE - DEAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'DZ' THEN 'DZ - DOZEN'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'EA' THEN 'EA - EACH'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'GS' THEN 'GS - GROSS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT = 'PK' THEN 'PK - PACKAGE'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["BO - BOTTLE","BX - BOX","CA - CASE","CH - CONTAINER","CT - CARTON","DE - DEAL","DZ - DOZEN","EA - EACH","GS - GROSS","PK - PACKAGE"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_reorder_primary_level_unit_reference]
  }

  dimension: store_drug_inventory_reorder_primary_level_unit_reference {
    label: "Store Drug Inventory Reorder Primary Level Unit Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_UNIT ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_product_number {
    label: "Store Drug Inventory Reorder Primary Level Product Number"
    description: "PRODUCT_NUM specifies to the supplier what the item number (from the Item # field), which is transmitted during electronic drug ordering, represents."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'IN' THEN 'IN - BUYER ITEM NUMBER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'N1' THEN 'N1 - NDC (4-4-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'N2' THEN 'N2 - NDC (5-3-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'N3' THEN 'N3 - NDC (5-4-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'N4' THEN 'N4 - NDC (5-4-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'ND' THEN 'ND - NDC (VER 2.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'NH' THEN 'NH - NATIONAL HEATH RELATED ITEM CODE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'SV' THEN 'SV - SERVICE RENDERED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UA' THEN 'UA - UPC/EAN CASE CODE (1-4-6-1)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UG' THEN 'UG - DRUG UPC CONSUMER PACKAGE CODE (1-4-6-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UH' THEN 'UH - DRUG UPC SHIPPING CONTAINER CODE (1-2-4-6-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UI' THEN 'UI - UPC CONSUMER PACKAGE CODE (1-5-5)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UN' THEN 'UN - UPC CASE CODE NUMBER (1-1-5-5)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'UP' THEN 'UP - UPC CONSUMER PACKAGE CODE (1-5-5-1)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER = 'VN' THEN 'VN - VENDOR ITEM NUMBER'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER IS NULL THEN 'NULL - VENDOR DEFAULT'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["IN - BUYER ITEM NUMBER","N1 - NDC (4-4-2) (VER 3.0)","N2 - NDC (5-3-2) (VER 3.0)","N3 - NDC (5-4-1) (VER 3.0)","N4 - NDC (5-4-2) (VER 3.0)","ND - NDC (VER 2.0)","NH - NATIONAL HEATH RELATED ITEM CODE","SV - SERVICE RENDERED","UA - UPC/EAN CASE CODE (1-4-6-1)","UG - DRUG UPC CONSUMER PACKAGE CODE (1-4-6-1) (VER 3.0)","UH - DRUG UPC SHIPPING CONTAINER CODE (1-2-4-6-1) (VER 3.0)","UI - UPC CONSUMER PACKAGE CODE (1-5-5)","UN - UPC CASE CODE NUMBER (1-1-5-5)","UP - UPC CONSUMER PACKAGE CODE (1-5-5-1)","VN - VENDOR ITEM NUMBER","NULL - VENDOR DEFAULT"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_reorder_primary_level_product_number_reference]
  }

  dimension: store_drug_inventory_reorder_primary_level_product_number_reference {
    label: "Store Drug Inventory Reorder Primary Level Product Number Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_PRODUCT_NUMBER ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_shipping_method {
    label: "Store Drug Inventory Reorder Primary Level Shipping Method"
    description: "SHIPPING_METHOD represents the method of delivery for this drug from this vendor when receiving an order."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_SHIPPING_METHOD ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_group_code {
    label: "Store Drug Inventory Reorder Primary Level Group Code"
    description: "GROUP_CODE represents the drug reorder group for the drug's reorder record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_GROUP_CODE ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_cycle_time_in_days {
    label: "Store Drug Inventory Reorder Primary Level Cycle Time In Days"
    description: "CYCLE represents the number of days between orders."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_CYCLE_TIME_IN_DAYS ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_lead_time_in_days {
    label: "Store Drug Inventory Reorder Primary Level Lead Time In Days"
    description: "LEAD_TIME is the usual amount of time it takes to receive product once it has been ordered."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_LEAD_TIME_IN_DAYS ;;
  }

  dimension_group: store_drug_inventory_reorder_primary_level_last_order {
    label: "Store Drug Inventory Reorder Primary Level Last Order"
    description: "LAST_ORDER_DATE is the date this drug was last ordered from the vendor."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_LAST_ORDER_DATE ;;
  }

  dimension_group: store_drug_inventory_reorder_primary_level_hold_until {
    label: "Store Drug Inventory Reorder Primary Level Hold Until"
    description: "The HOLD_UNTIL_DATE is the date the system uses to determine when to generate an order for this drug. The system will not generate an order for this drug until this date, even if the drug's on-hand quantity falls below the reorder point quantity."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_HOLD_UNTIL_DATE ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_no_substitutions {
    label: "Store Drug Inventory Reorder Primary Level No Substitutions"
    description: "Yes/No Flag indicating whether the system automatically receives or applies any substitutions for this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_NO_SUBSTITUTIONS = 'Y' ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_sub_group {
    label: "Store Drug Inventory Reorder Primary Level Sub Group"
    description: "SUB_GROUP represents the Sub-group code for the drug reorder record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_SUB_GROUP ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_category {
    label: "Store Drug Inventory Reorder Primary Level Category"
    description: "CATEGORY represents the Drug Reorder Category."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_CATEGORY ;;
  }

  dimension_group: store_drug_inventory_reorder_primary_level_discontinue {
    label: "Store Drug Inventory Reorder Primary Level Discontinue"
    description: "DISCONTINUE_DATE is the date the system uses to determine when to generate an order for this drug. The system will not generate an order for this drug after this date, even if the drug's on-hand quantity falls below the reorder point quantity."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_DISCONTINUE_DATE ;;
  }

  dimension: store_drug_inventory_reorder_primary_level_vendor_name {
    label: "Store Drug Inventory Reorder Primary Level Vendor Name"
    description: "Vendor Name related to the Drug Reorder record level number 1 for Activity Date."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_VENDOR_NAME ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_item_number {
    label: "Store Drug Inventory Reorder Secondary Level Item Number"
    description: "ITEM_NUM is the supplier's order number for this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_ITEM_NUMBER ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_warehouse_region {
    label: "Store Drug Inventory Reorder Secondary Level Warehouse Region"
    description: "WAREHOUSE_REGION represents the region this drug would be sourced from, from the warehouse."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_WAREHOUSE_REGION ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_order_point {
    label: "Store Drug Inventory Reorder Secondary Level Order Point"
    description: "Point at which the system should reorder new supplies of this drug. When the on-hand amount minus allocated qty reaches the order point, the system will generate a drug order maintenance record when the Generate Order Records report is run. Example: '89'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_ORDER_POINT ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_order_quantity {
    label: "Store Drug Inventory Reorder Secondary Level Order Quantity"
    description: "ORDER_QTY is the quantity to reorder when the drug reaches the reorder point. The system uses a multiple of this quantity to generate drug order maintenance records that brings the on-hand quantity equal to or greater than the Up To quantity. If the quantity is not evenly divisible by the number in the Pack field, the EPS client system does not let you add or update a drug order record.Example: '300'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_ORDER_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_minimum_quantity {
    label: "Store Drug Inventory Reorder Secondary Level Minimum Quantity"
    description: "MINIMUM_QTY is the on-hand amount needed after filling the order. The system uses this quantity during the Generate Order Records function and orders the quantity of the drug that brings the on-hand quantity equal to or greater than this value. Example: '90'."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_MINIMUM_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_conversion_factor {
    label: "Store Drug Inventory Reorder Secondary Level Conversion Factor"
    description: "CONVERSION_FACTOR is the number the system uses to convert the ordered quantity to the quantity reported that is sent to the supplier in the Drug Order List. To determine the number of reorder units, the system first divides the reorder quantity by the pack size. Then, it divides the result by the conversion factor. The system reports the result on the Drug Order List report."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_CONVERSION_FACTOR ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_unit {
    label: "Store Drug Inventory Reorder Secondary Level Unit"
    description: "UNIT is the unit/basis of measurement for the order quantity that the system transmits during an electronic drug order."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'BO' THEN 'BO - BOTTLE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'BX' THEN 'BX - BOX'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'CA' THEN 'CA - CASE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'CH' THEN 'CH - CONTAINER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'CT' THEN 'CT - CARTON'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'DE' THEN 'DE - DEAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'DZ' THEN 'DZ - DOZEN'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'EA' THEN 'EA - EACH'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'GS' THEN 'GS - GROSS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT = 'PK' THEN 'PK - PACKAGE'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["BO - BOTTLE","BX - BOX","CA - CASE","CH - CONTAINER","CT - CARTON","DE - DEAL","DZ - DOZEN","EA - EACH","GS - GROSS","PK - PACKAGE"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_reorder_secondary_level_unit_reference]
  }

  dimension: store_drug_inventory_reorder_secondary_level_unit_reference {
    label: "Store Drug Inventory Reorder Secondary Level Unit Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_UNIT ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_product_number {
    label: "Store Drug Inventory Reorder Secondary Level Product Number"
    description: "PRODUCT_NUM specifies to the supplier what the item number (from the Item # field), which is transmitted during electronic drug ordering, represents."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'IN' THEN 'IN - BUYER ITEM NUMBER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'N1' THEN 'N1 - NDC (4-4-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'N2' THEN 'N2 - NDC (5-3-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'N3' THEN 'N3 - NDC (5-4-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'N4' THEN 'N4 - NDC (5-4-2) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'ND' THEN 'ND - NDC (VER 2.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'NH' THEN 'NH - NATIONAL HEATH RELATED ITEM CODE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'SV' THEN 'SV - SERVICE RENDERED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UA' THEN 'UA - UPC/EAN CASE CODE (1-4-6-1)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UG' THEN 'UG - DRUG UPC CONSUMER PACKAGE CODE (1-4-6-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UH' THEN 'UH - DRUG UPC SHIPPING CONTAINER CODE (1-2-4-6-1) (VER 3.0)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UI' THEN 'UI - UPC CONSUMER PACKAGE CODE (1-5-5)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UN' THEN 'UN - UPC CASE CODE NUMBER (1-1-5-5)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'UP' THEN 'UP - UPC CONSUMER PACKAGE CODE (1-5-5-1)'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER = 'VN' THEN 'VN - VENDOR ITEM NUMBER'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER IS NULL THEN 'NULL - VENDOR DEFAULT'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["IN - BUYER ITEM NUMBER","N1 - NDC (4-4-2) (VER 3.0)","N2 - NDC (5-3-2) (VER 3.0)","N3 - NDC (5-4-1) (VER 3.0)","N4 - NDC (5-4-2) (VER 3.0)","ND - NDC (VER 2.0)","NH - NATIONAL HEATH RELATED ITEM CODE","SV - SERVICE RENDERED","UA - UPC/EAN CASE CODE (1-4-6-1)","UG - DRUG UPC CONSUMER PACKAGE CODE (1-4-6-1) (VER 3.0)","UH - DRUG UPC SHIPPING CONTAINER CODE (1-2-4-6-1) (VER 3.0)","UI - UPC CONSUMER PACKAGE CODE (1-5-5)","UN - UPC CASE CODE NUMBER (1-1-5-5)","UP - UPC CONSUMER PACKAGE CODE (1-5-5-1)","VN - VENDOR ITEM NUMBER","NULL - VENDOR DEFAULT"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_reorder_secondary_level_product_number_reference]
  }

  dimension: store_drug_inventory_reorder_secondary_level_product_number_reference {
    label: "Store Drug Inventory Reorder Secondary Level Product Number Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_PRODUCT_NUMBER ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_shipping_method {
    label: "Store Drug Inventory Reorder Secondary Level Shipping Method"
    description: "SHIPPING_METHOD represents the method of delivery for this drug from this vendor when receiving an order."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_SHIPPING_METHOD ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_group_code {
    label: "Store Drug Inventory Reorder Secondary Level Group Code"
    description: "GROUP_CODE represents the drug reorder group for the drug's reorder record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_GROUP_CODE ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_cycle_time_in_days {
    label: "Store Drug Inventory Reorder Secondary Level Cycle Time In Days"
    description: "CYCLE represents the number of days between orders."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_CYCLE_TIME_IN_DAYS ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_lead_time_in_days {
    label: "Store Drug Inventory Reorder Secondary Level Lead Time In Days"
    description: "LEAD_TIME is the usual amount of time it takes to receive product once it has been ordered."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_LEAD_TIME_IN_DAYS ;;
  }

  dimension_group: store_drug_inventory_reorder_secondary_level_last_order {
    label: "Store Drug Inventory Reorder Secondary Level Last Order"
    description: "LAST_ORDER_DATE is the date this drug was last ordered from the vendor."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_LAST_ORDER_DATE ;;
  }

  dimension_group: store_drug_inventory_reorder_secondary_level_hold_until {
    label: "Store Drug Inventory Reorder Secondary Level Hold Until"
    description: "The HOLD_UNTIL_DATE is the date the system uses to determine when to generate an order for this drug. The system will not generate an order for this drug until this date, even if the drug's on-hand quantity falls below the reorder point quantity."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_HOLD_UNTIL_DATE ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_no_substitutions {
    label: "Store Drug Inventory Reorder Secondary Level No Substitutions"
    description: "Yes/No Flag indicating whether the system automatically receives or applies any substitutions for this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_NO_SUBSTITUTIONS = 'Y' ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_sub_group {
    label: "Store Drug Inventory Reorder Secondary Level Sub Group"
    description: "SUB_GROUP represents the Sub-group code for the drug reorder record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_SUB_GROUP ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_category {
    label: "Store Drug Inventory Reorder Secondary Level Category"
    description: "CATEGORY represents the Drug Reorder Category."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_CATEGORY ;;
  }

  dimension_group: store_drug_inventory_reorder_secondary_level_discontinue {
    label: "Store Drug Inventory Reorder Secondary Level Discontinue"
    description: "DISCONTINUE_DATE is the date the system uses to determine when to generate an order for this drug. The system will not generate an order for this drug after this date, even if the drug's on-hand quantity falls below the reorder point quantity."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_DISCONTINUE_DATE ;;
  }

  dimension: store_drug_inventory_reorder_secondary_level_vendor_name {
    label: "Store Drug Inventory Reorder Secondary Level Vendor Name"
    description: "Vendor Name related to the Drug Reorder record level number 2 for Activity Date."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_VENDOR_NAME ;;
  }

  dimension: store_drug_inventory_acquistion_cost_amount {
    label: "Store Drug Inventory Acquisition Cost Amount"
    description: "The daily snapshot value of the Drug Acquisition Cost amount from the Pharmacy's data."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_acquistion_unit_cost_amount {
    label: "Store Drug Inventory Acquisition Unit Cost Amount"
    description: "The daily snapshot value of the Drug Acquisition Cost per unit amount from the Pharmacy's data."
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  dimension: store_drug_inventory_price_code {
    label: "Store Drug Inventory Price Code"
    description: "Price Code that exists on the Drug Record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_PRICE_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_code {
    label: "Store Drug Inventory Drug Unique Code"
    description: "user defined code used to uniquely identify drug record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_name {
    label: "Store Drug Inventory Drug Unique Name"
    description: "Shorter drug name."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_generic_name {
    label: "Store Drug Inventory Drug Unique Generic Name"
    description: "Generic or chemical description of the drug, irrespective of the manufacturer. It is usually considered the official non-proprietary name of the drug, under which it is licensed and identified by the manufacturer."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_ddid {
    label: "Store Drug Inventory Drug Unique Ddid"
    description: "Medi-Span specific Drug Descriptor Identifier which identifies a unique combination of Drug name, Route, Dosage Form, Strength, and Strength Unit of Measure."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DDID ;;
  }

  dimension: store_drug_inventory_drug_unique_full_name {
    label: "Store Drug Inventory Drug Unique Full Name"
    description: "Full name of the Drug mainly used for products which have a longer drug name than what is allowed in the  DRUG_NAME column."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_FULL_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_full_generic_name {
    label: "Store Drug Inventory Drug Unique Full Generic Name"
    description: "Full generic or chemical name of the Drug mainly used for products which have a longer drug name than what is allowed in the DRUG_NAME column."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_FULL_GENERIC_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_allergy_code {
    label: "Store Drug Inventory Drug Unique Allergy Code"
    description: "Medi-Span allergy, or allerchek, code which corresponds with the drug or its class of drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALLERGY_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_unit {
    label: "Store Drug Inventory Drug Unique Unit"
    description: "Unit of measure in which drug is dispensed. Alpha-numeric value, which may be up-to 3 characters in length. TAB, CAP, ML, etc."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_UNIT ;;
  }

  dimension: store_drug_inventory_drug_unique_strength {
    label: "Store Drug Inventory Drug Unique Strength"
    description: "Metric strength or concentration of the drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_STRENGTH ;;
  }

  dimension: store_drug_inventory_drug_unique_therapeutic_class {
    label: "Store Drug Inventory Drug Unique Therapeutic Class"
    description: "Primary therapeutic class number of the drug. (ASHP)."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_CLASS ;;
  }

  dimension: store_drug_inventory_drug_unique_therapeutic_equivalency_code {
    label: "Store Drug Inventory Drug Unique Therapeutic Equivalency Code"
    description: "FDA Therapeutic Equivalence Code, also known as the Orange Book Rating. It is used as a tool in determining the therapeutic equivalence of two NDCs for the purpose of drug substitution and DUR."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE IS NULL THEN 'NULL - NO CODE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A1' THEN 'A1 - AB-RATED 1'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A2' THEN 'A2 - AB-RATED 2'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A3' THEN 'A3 - AB-RATED 3'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A4' THEN 'A4 - AB-RATED 4'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A5' THEN 'A5 - AB-RATED 5'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A6' THEN 'A6 - AB-RATED 6'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A7' THEN 'A7 - AB-RATED 7'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A8' THEN 'A8 - AB-RATED 8'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'A9' THEN 'A9 - AB-RATED 9'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AA' THEN 'AA - NO BIO PROBLEMS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB' THEN 'AB - MEETS BIO'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AN' THEN 'AN - AEROSOL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AO' THEN 'AO - INJECTABLE OIL SOLUTE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AP' THEN 'AP - INJECTABLE AQUEOUS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AT' THEN 'AT - TOPICAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BC' THEN 'BC - CONTROLLED RELEASE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BD' THEN 'BD - DOCUMENTED BIO ISSUES'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BE' THEN 'BE - ENTERIC DOSAGE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BN' THEN 'BN - NEBULIZER SYSTEM'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BP' THEN 'BP - POTENTIAL BIO ISSUES'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BR' THEN 'BR - SYSTEMIC USE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BS' THEN 'BS - DEFICENCIES'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BT' THEN 'BT - BIOEQUIVALENCE ISSUES'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'BX' THEN 'BX - INSUFFICIENT DATA'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'B*' THEN 'B* - FDA REVIEW'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'NA' THEN 'NA - NOT APPLICABLE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'NR' THEN 'NR - NOT RATED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'ZA' THEN 'ZA - DATABANK REPACKAGED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'ZB' THEN 'ZB - DATABANK'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'ZC' THEN 'ZC - ORANGE BOOK'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB1' THEN 'AB1 - AB-RATED 1'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB2' THEN 'AB2 - AB-RATED 2'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB3' THEN 'AB3 - AB-RATED 3'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB4' THEN 'AB4 - AB-RATED 4'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB5' THEN 'AB5 - AB-RATED 5'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB6' THEN 'AB6 - AB-RATED 6'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB7' THEN 'AB7 - AB-RATED 7'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB8' THEN 'AB8 - AB-RATED 8'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE = 'AB9' THEN 'AB9 - AB-RATED 9'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["NULL - NO CODE","A1 - AB-RATED 1","A2 - AB-RATED 2","A3 - AB-RATED 3","A4 - AB-RATED 4","A5 - AB-RATED 5","A6 - AB-RATED 6","A7 - AB-RATED 7","A8 - AB-RATED 8","A9 - AB-RATED 9","AA - NO BIO PROBLEMS","AB - MEETS BIO","AN - AEROSOL","AO - INJECTABLE OIL SOLUTE","AP - INJECTABLE AQUEOUS","AT - TOPICAL","BC - CONTROLLED RELEASE","BD - DOCUMENTED BIO ISSUES","BE - ENTERIC DOSAGE","BN - NEBULIZER SYSTEM","BP - POTENTIAL BIO ISSUES","BR - SYSTEMIC USE","BS - DEFICENCIES","BT - BIOEQUIVALENCE ISSUES","BX - INSUFFICIENT DATA","B* - FDA REVIEW","NA - NOT APPLICABLE","NR - NOT RATED","ZA - DATABANK REPACKAGED","ZB - DATABANK","ZC - ORANGE BOOK","AB1 - AB-RATED 1","AB2 - AB-RATED 2","AB3 - AB-RATED 3","AB4 - AB-RATED 4","AB5 - AB-RATED 5","AB6 - AB-RATED 6","AB7 - AB-RATED 7","AB8 - AB-RATED 8","AB9 - AB-RATED 9"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_therapeutic_equivalency_code_reference]
  }

  dimension: store_drug_inventory_drug_unique_therapeutic_equivalency_code_reference {
    label: "Store Drug Inventory Drug Unique Therapeutic Equivalency Code Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_THERAPEUTIC_EQUIVALENCY_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_schedule {
    label: "Store Drug Inventory Drug Unique Schedule"
    description: "US Drug Schedule of NDC. Determines first number in Rx."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '1' THEN '1 - C-I'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '2' THEN '2 - C-II'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '3' THEN '3 - C-III'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '4' THEN '4 - C-IV'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '5' THEN '5 - C-V'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '6' THEN '6 - RX'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE = '8' THEN '8 - OTC'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["1 - C-I","2 - C-II","3 - C-III","4 - C-IV","5 - C-V","6 - RX","8 - OTC"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_schedule_reference]
  }

  dimension: store_drug_inventory_drug_unique_schedule_reference {
    label: "Store Drug Inventory Drug Unique Schedule Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SCHEDULE ;;
  }

  dimension: store_drug_inventory_drug_unique_canada_schedule {
    label: "Store Drug Inventory Drug Unique Canada Schedule"
    description: "Canada drug schedule. Only pertains to pharmacies operating in Canada."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CANADA_SCHEDULE ;;
  }

  dimension: store_drug_inventory_drug_unique_desi {
    label: "Store Drug Inventory Drug Unique Desi"
    description: "Enumerated value which designates the NDC's DESI status, which is used to determine if a drug is effective, ineffective, or needing further study."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI is NULL THEN 'NULL - NON DRUG OR OTHER ITEM'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI = '2' THEN '2 - NON DESI/IRS DRUG'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI = '3' THEN '3 - DESI/IRS DRUG UNDER REVIEW'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI = '4' THEN '4 - LESS THEN EFFECTIVE FOR SOME'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI = '5' THEN '5 - LESS THEN EFFECTIVE FOR ALL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI = '6' THEN '6 - WITHDRAWN FROM THE MARKET'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - NON DRUG OR OTHER ITEM","2 - NON DESI/IRS DRUG","3 - DESI/IRS DRUG UNDER REVIEW","4 - LESS THEN EFFECTIVE FOR SOME","5 - LESS THEN EFFECTIVE FOR ALL","6 - WITHDRAWN FROM THE MARKET"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_desi_reference]
  }

  dimension: store_drug_inventory_drug_unique_desi_reference {
    label: "Store Drug Inventory Drug Unique Desi Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DESI ;;
  }

  dimension: store_drug_inventory_drug_unique_omit_dur {
    label: "Store Drug Inventory Drug Unique Omit Dur"
    description: "Yes/No flag indicating whether or not DUR checking should be performed for this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OMIT_DUR = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_injectable {
    label: "Store Drug Inventory Drug Unique Injectable"
    description: "Yes/No flag that determines if this is drug is an injectable."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INJECTABLE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_multi_source {
    label: "Store Drug Inventory Drug Unique Multi Source"
    description: "Flag that indicates drug source (used by some third party plans, used for generic substitution analysis on the daily log, and updated by NHIN)."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE = 'Y' THEN 'Y - GENERIC'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE = 'N' THEN 'N - SINGLE SOURCE BRAND'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE = 'O' THEN 'O - ORIGINAL MANUFACTURER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE = 'M' THEN 'M - MULTI SOURCE BRAND'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE IS NULL THEN 'NULL - UNKNOWN'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["Y - GENERIC","N - SINGLE SOURCE BRAND","O - ORIGINAL MANUFACTURER","M - MULTI SOURCE BRAND","NULL - UNKNOWN"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_multi_source_reference]
  }

  dimension: store_drug_inventory_drug_unique_multi_source_reference {
    label: "Store Drug Inventory Drug Unique Multi Source Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTI_SOURCE ;;
  }

  dimension: store_drug_inventory_drug_unique_life_type {
    label: "Store Drug Inventory Drug Unique Life Type"
    description: "Yes/No flag that indicates whether the system bases the drug expiration date on the date on which the patient opens the product or on the dispensed date."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_LIFE_TYPE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_same_pack {
    label: "Store Drug Inventory Drug Unique Same Pack"
    description: "Yes/No flag that indicates whether automatic drug selection excludes drugs that have a different pack size when picking a substitute for this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SAME_PACK = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_bubble {
    label: "Store Drug Inventory Drug Unique Bubble"
    description: "Yes/No flag that determines if you can add a bubble-pack fee for unit dose prescriptions for the purpose of pricing."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BUBBLE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_brand_percentage {
    label: "Store Drug Inventory Drug Unique Brand Percentage"
    description: "Yes/No flag that indicates whether the system uses this drug record for brand pricing for all drugs with the same GPI."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BRAND_PERCENTAGE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_shelf {
    label: "Store Drug Inventory Drug Unique Shelf"
    description: "Shelf life in days of the drug in the store."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SHELF ;;
  }

  dimension: store_drug_inventory_drug_unique_life {
    label: "Store Drug Inventory Drug Unique Life"
    description: "Shelf life of the drug after it is dispensed."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_LIFE ;;
  }

  dimension: store_drug_inventory_drug_unique_sig_conversion_factor {
    label: "Store Drug Inventory Drug Unique SIG Conversion Factor"
    description: "SIG conversion factor that converts metric liquid measurements to dosage units. The system also uses the conversion factor to calculate day's supply."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SIG_CONVERSION_FACTOR ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension_group: store_drug_inventory_drug_unique_manufacturer_discontinue {
    label: "Store Drug Inventory Drug Unique Manufacturer Discontinue"
    description: "The date the manufacturer discontinued producing this product."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MANUFACTURER_DISCONTINUE_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_chain_discontinue {
    label: "Store Drug Inventory Drug Unique Chain Discontinue"
    description: "The date the store stopped using this product."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CHAIN_DISCONTINUE_DATE ;;
  }

  dimension: store_drug_inventory_drug_unique_no_patient_education {
    label: "Store Drug Inventory Drug Unique No Patient Education"
    description: "Yes/No flag indicating whether the system prints patient education when you fill a prescription for this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NO_PATIENT_EDUCATION = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_repack {
    label: "Store Drug Inventory Drug Unique Repack"
    description: "Yes/No flag that indicates if this drug has been repackaged."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REPACK = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_unit_dose {
    label: "Store Drug Inventory Drug Unique Unit Dose"
    description: "Yes/No flag that determines if this drug is a unit dose drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_UNIT_DOSE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_unit_of_use {
    label: "Store Drug Inventory Drug Unique Unit Of Use"
    description: "Yes/No flag that determines if this drug is a unit of use drug (pack should not be broken)."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_UNIT_OF_USE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_napra {
    label: "Store Drug Inventory Drug Unique Napra"
    description: "NAPRA Code (National Association of Pharmacy Regulatory Authorities) This field is used for a national scheduling system in Canada."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAPRA ;;
  }

  dimension: store_drug_inventory_drug_unique_refrigerate {
    label: "Store Drug Inventory Drug Unique Refrigerate"
    description: "Flag that determines if this drug requires refrigeration when shipped."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFRIGERATE = 'T' THEN 'T - ROOM TEMPERATURE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFRIGERATE = 'F' THEN 'F - FROZEN'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFRIGERATE = 'R' THEN 'R - REFRIGERATED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFRIGERATE = 'N' THEN 'N - NOT SET'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["T - ROOM TEMPERATURE","F - FROZEN","R - REFRIGERATED","N - NOT SET"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_refrigerate_reference]
  }

  dimension: store_drug_inventory_drug_unique_refrigerate_reference {
    label: "Store Drug Inventory Drug Unique Refrigerate Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFRIGERATE ;;
  }

  dimension: store_drug_inventory_drug_unique_hazardous_material {
    label: "Store Drug Inventory Drug Unique Hazardous Material"
    description: "Yes/No Flag indicating if this drug is a HAZMAT drug (hazardous material)."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_HAZARDOUS_MATERIAL = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_identifier_type {
    label: "Store Drug Inventory Drug Unique Identifier Type"
    description: "Flag that indicates to certain insurance claim processors what type of product code is entered in the NDC/DIN field."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IDENTIFIER_TYPE = 'H' THEN 'H - HRI'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IDENTIFIER_TYPE = 'N' THEN 'N - NDC/DIN'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IDENTIFIER_TYPE = 'O' THEN 'O - OTHER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IDENTIFIER_TYPE = 'U' THEN 'U - UPC'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["H - HRI","N - NDC/DIN","O - OTHER","U - UPC"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_identifier_type_reference]
  }

  dimension: store_drug_inventory_drug_unique_identifier_type_reference {
    label: "Store Drug Inventory Drug Unique Identifier Type Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IDENTIFIER_TYPE ;;
  }

  dimension: store_drug_inventory_drug_unique_other_code {
    label: "Store Drug Inventory Drug Unique Other Code"
    description: "User defined code that is used as a misc entry that can be used to identify the drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OTHER_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_package_size {
    label: "Store Drug Inventory Drug Unique Package Size"
    description: "Package size associated with the NDC."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PACKAGE_SIZE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_barcode {
    label: "Store Drug Inventory Drug Unique Barcode"
    description: "10-digit NDC/DIN matching the barcode for this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BARCODE ;;
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_daw {
    label: "Store Drug Inventory Drug Unique NCPDP DAW"
    description: "Default DAW code assigned to the drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_DAW ;;
  }

  dimension: store_drug_inventory_drug_unique_warehouse_flag {
    label: "Store Drug Inventory Drug Unique Warehouse Flag"
    description: "Yes/No Flag indicating if this drug is a Warehouse drug source."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_WAREHOUSE_FLAG = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_store_generic {
    label: "Store Drug Inventory Drug Unique Store Generic"
    description: "Yes/No Flag indicating if the system lists the transaction as a generic sale in the pharmacist summary of the transaction log and submits the drug as a generic to third parties."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_STORE_GENERIC = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_price_quantity {
    label: "Store Drug Inventory Drug Unique Price Quantity"
    description: "Quantity to use for the Drug Retail Price List report."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PRICE_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_price_quantity_2 {
    label: "Store Drug Inventory Drug Unique Price Quantity 2"
    description: "Second quantity to use for the Drug Retail Price List report."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PRICE_QUANTITY_2 ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_packs_per_container {
    label: "Store Drug Inventory Drug Unique Packs Per Container"
    description: "Number of individual packs per container, for example number of birth control packs per box."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PACKS_PER_CONTAINER ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_generic {
    label: "Store Drug Inventory Drug Unique Generic"
    description: "Determines if this is a generic drug for the purposes of fee and co-pay assignments"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC = '0' THEN '0 - BRAND'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC = '1' THEN '1 - GENERIC'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC = '2' THEN '2 - NO GENERIC'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC IS NULL THEN 'NULL - NOT SPECIFIED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["0 - BRAND","1 - GENERIC","2 - NO GENERIC","NULL - NOT SPECIFIED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_generic_reference]
  }

  dimension: store_drug_inventory_drug_unique_generic_reference {
    label: "Store Drug Inventory Drug Unique Generic Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GENERIC ;;
  }

  dimension: store_drug_inventory_drug_unique_over_the_counter {
    label: "Store Drug Inventory Drug Unique Over The Counter"
    description: "Yes/No Flag indicating if drug is an over-the-counter drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OVER_THE_COUNTER = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_maintenance {
    label: "Store Drug Inventory Drug Unique Maintenance"
    description: "Yes/No Flag indicating if drug is a maintenance drug and therefore subject to a separate set of dispensing limits."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MAINTENANCE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_name_type_code {
    label: "Store Drug Inventory Drug Unique Name Type Code"
    description: "Defines whether this drug is a trade name, brand, or generic."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME_TYPE_CODE = 'B' THEN 'B - BRAND'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME_TYPE_CODE = 'G' THEN 'G - GENERIC'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME_TYPE_CODE = 'T' THEN 'T - TRADENAME'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME_TYPE_CODE IS NULL THEN 'NULL - NOT SET'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["B - BRAND","G - GENERIC","T - TRADENAME","NULL - NOT SET"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_name_type_code_reference]
  }

  dimension: store_drug_inventory_drug_unique_name_type_code_reference {
    label: "Store Drug Inventory Drug Unique Name Type Code Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NAME_TYPE_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_substitution_group {
    label: "Store Drug Inventory Drug Unique Substitution Group"
    description: "Code of drug substitution group in which a drug record is categorized."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SUBSTITUTION_GROUP ;;
  }

  dimension: store_drug_inventory_drug_unique_preferred_generic {
    label: "Store Drug Inventory Drug Unique Preferred Generic"
    description: "Yes/No flag indicating if a drug record is a preferred generic drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREFERRED_GENERIC = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_preferred_brand {
    label: "Store Drug Inventory Drug Unique Preferred Brand"
    description: "Yes/No flag indicating if a drug record is a preferred brand drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREFERRED_BRAND = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_requires_signature {
    label: "Store Drug Inventory Drug Unique Requires Signature"
    description: "Yes/No flag indicating if a signature is required upon delivery of this drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REQUIRES_SIGNATURE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_form_type {
    label: "Store Drug Inventory Drug Unique NCPDP Form Type"
    description: "Normal form type of a compound. Populated when drug record is for a compound and user populates this field on the Compound screen."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_TYPE = '1' THEN '1 - EACH'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_TYPE = '2' THEN '2 - GRAMS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_TYPE = '3' THEN '3 - MILLILITERS'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_TYPE IS NULL THEN 'NULL - NOT SELECTED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["1 - EACH","2 - GRAMS","3 - MILLILITERS","NULL - NOT SELECTED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_ncpdp_form_type_reference]
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_form_type_reference {
    label: "Store Drug Inventory Drug Unique Ncpdp Form Type Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_TYPE ;;
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_route {
    label: "Store Drug Inventory Drug Unique NCPDP Route"
    description: "Route that is normally used by the patient for using/taking this compound. Populated when drug record is for a compound and user populates this field on the Compound screen."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '1' THEN '1 - BUCCAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '2' THEN '2 - DENTAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '3' THEN '3 - INHALATION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '4' THEN '4 - INJECTION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '5' THEN '5 - INTRAPERITONEAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '6' THEN '6 - IRRIGATION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '7' THEN '7 - MOUTH/THROAT'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '8' THEN '8 - MUCOUS MEMBRANE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '9' THEN '9 - NASAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '10' THEN '10 - OPTHALMIC'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '11' THEN '11 - ORAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '12' THEN '12 - OTHER/MISCELLANEOUS'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '13' THEN '13 - OTIC'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '14' THEN '14 - PERFUSION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '15' THEN '15 - RECTAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '16' THEN '16 - SUBLINGUAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '17' THEN '17 - TOPICAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '18' THEN '18 - TRANSDERMAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '19' THEN '19 - TRANSLINGUAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '20' THEN '20 - URETHAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '21' THEN '21 - VAGINAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE = '22' THEN '22 - ENTERAL'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE IS NULL THEN 'NULL - NOT SET'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["1 - BUCCAL","2 - DENTAL","3 - INHALATION","4 - INJECTION","5 - INTRAPERITONEAL","6 - IRRIGATION","7 - MOUTH/THROAT","8 - MUCOUS MEMBRANE","9 - NASAL","10 - OPTHALMIC","11 - ORAL","12 - OTHER/MISCELLANEOUS","13 - OTIC","14 - PERFUSION","15 - RECTAL","16 - SUBLINGUAL","17 - TOPICAL","18 - TRANSDERMAL","19 - TRANSLINGUAL","20 - URETHAL","21 - VAGINAL","22 - ENTERAL","NULL - NOT SET"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_ncpdp_route_reference]
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_route_reference {
    label: "Store Drug Inventory Drug Unique Ncpdp Route Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_ROUTE ;;
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_form_description {
    label: "Store Drug Inventory Drug Unique NCPDP Form Description"
    description: "Form description of a compound."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '1' THEN '1 - CAPSULE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '2' THEN '2 - OINTMENT'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '3' THEN '3 - CREAM'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '4' THEN '4 - SUPPOSITORY'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '5' THEN '5 - POWDER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '6' THEN '6 - EMULSION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '7' THEN '7 - LIQUID'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '10' THEN '10 - TABLET'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '11' THEN '11 - SOLUTION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '12' THEN '12 - SUSPENSION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '13' THEN '13 - LOTION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '14' THEN '14 - SHAMPOO'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '15' THEN '15 - ELIXIR'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '16' THEN '16 - SYRUP'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '17' THEN '17 - LOZENGE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = '18' THEN '18 - ENEMA'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION = 'BLANK' THEN 'BLANK - NOT SPECIFIED'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION IS NULL THEN 'NULL - NOT SET'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["1 - CAPSULE","2 - OINTMENT","3 - CREAM","4 - SUPPOSITORY","5 - POWDER","6 - EMULSION","7 - LIQUID","10 - TABLET","11 - SOLUTION","12 - SUSPENSION","13 - LOTION","14 - SHAMPOO","15 - ELIXIR","16 - SYRUP","17 - LOZENGE","18 - ENEMA","BLANK - NOT SPECIFIED","NULL - NOT SET"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_ncpdp_form_description_reference]
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_form_description_reference {
    label: "Store Drug Inventory Drug Unique Ncpdp Form Description Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_FORM_DESCRIPTION ;;
  }

  dimension: store_drug_inventory_drug_unique_is_compound {
    label: "Store Drug Inventory Drug Unique Is Compound"
    description: "Yes/No flag that identifies if this drug record is for a Compound drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IS_COMPOUND = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_labeler {
    label: "Store Drug Inventory Drug Unique Labeler"
    description: "Name of the drug's Distributor."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_LABELER ;;
  }

  dimension: store_drug_inventory_drug_unique_use_competitive_pricing {
    label: "Store Drug Inventory Drug Unique Use Competitive Pricing"
    description: "Yes/No flag that Indicates whether the competitive pricing table is to be used."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_USE_COMPETITIVE_PRICING = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_labeler_number {
    label: "Store Drug Inventory Drug Unique Labeler Number"
    description: "Number identifying the distributor of this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_LABELER_NUMBER ;;
  }

  dimension: store_drug_inventory_drug_unique_bin_storage_type {
    label: "Store Drug Inventory Drug Unique Bin Storage Type"
    description: "Type of Will Call Bin used as a default for this drug."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '0' THEN '0 - NORMAL'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '1' THEN '1 - LARGE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '2' THEN '2 - REFRIGERATOR'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '3' THEN '3 - FREEZER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '4' THEN '4 - SAFE LOCKBOX'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE = '5' THEN '5 - HAZMAT'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["0 - NORMAL","1 - LARGE","2 - REFRIGERATOR","3 - FREEZER","4 - SAFE LOCKBOX","5 - HAZMAT"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_bin_storage_type_reference]
  }

  dimension: store_drug_inventory_drug_unique_bin_storage_type_reference {
    label: "Store Drug Inventory Drug Unique Bin Storage Type Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BIN_STORAGE_TYPE ;;
  }

  dimension: store_drug_inventory_drug_unique_individual_container_pack {
    label: "Store Drug Inventory Drug Unique Individual Container Pack"
    description: "Individual container pack size."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INDIVIDUAL_CONTAINER_PACK ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_integer_pack {
    label: "Store Drug Inventory Drug Unique Integer Pack"
    description: "This is the drug's Pack Size represented as an integer value (The drug's decimal packsize rounded up to the nearest whole number)."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INTEGER_PACK ;;
    value_format:  "#,##0;(#,##0)"
  }

  dimension: store_drug_inventory_drug_unique_acquisition_cost_source {
    label: "Store Drug Inventory Drug Unique Acquisition Cost Source"
    description: "Indicator to determine the source of ACQ cost."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = '1' THEN '1 - PRIMARY WHOLESALER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = '2' THEN '2 - SECONDARY WHOLESALER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = '3' THEN '3 - TERTIARY WHOLESALER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = '4' THEN '4 - QUATERNARY WHOLESALER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = 'M' THEN 'M - MAIL ORDER COST'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = 'C' THEN 'C - CENTRAL FILL COST'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE = '%' THEN '% - PERCENT OF AWP'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE IS NULL THEN 'NULL - NOT SPECIFIED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["1 - PRIMARY WHOLESALER","2 - SECONDARY WHOLESALER","3 - TERTIARY WHOLESALER","4 - QUATERNARY WHOLESALER","M - MAIL ORDER COST","C - CENTRAL FILL COST","% - PERCENT OF AWP","NULL - NOT SPECIFIED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_acquisition_cost_source_reference]
  }

  dimension: store_drug_inventory_drug_unique_acquisition_cost_source_reference {
    label: "Store Drug Inventory Drug Unique Acquisition Cost Source Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACQUISITION_COST_SOURCE ;;
  }

  dimension: store_drug_inventory_drug_unique_awp_source {
    label: "Store Drug Inventory Drug Unique Awp Source"
    description: "Indicator to determine the source of AWP cost."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE = 'A' THEN 'A - CALCULATED USING INQUIRY MARK-UP FACTOR'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE = 'S' THEN 'S - SUGGESTED AWP FROM MANUFACTURER'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE = 'M' THEN 'M - STANDARD 25 PERCENT MARK-UP FACTOR USED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE = 'K' THEN 'K - ADJUSTED MARK-UP FACTOR USED'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE = 'L' THEN 'L - STANDARD 20 PERCENT MARK-UP FACTOR USED'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE IS NULL THEN 'NULL - NOT SPECIFIED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["A - CALCULATED USING INQUIRY MARK-UP FACTOR","S - SUGGESTED AWP FROM MANUFACTURER","M - STANDARD 25 PERCENT MARK-UP FACTOR USED","K - ADJUSTED MARK-UP FACTOR USED","L - STANDARD 20 PERCENT MARK-UP FACTOR USED","NULL - NOT SPECIFIED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_awp_source_reference]
  }

  dimension: store_drug_inventory_drug_unique_awp_source_reference {
    label: "Store Drug Inventory Drug Unique Awp Source Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AWP_SOURCE ;;
  }

  dimension: store_drug_inventory_drug_unique_clinical_pack {
    label: "Store Drug Inventory Drug Unique Clinical Pack"
    description: "Yes/No flag that indicates the drug is used for a Clinical trail. Used to create non-fillable Interaction prescriptions."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CLINICAL_PACK = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_ahfs_therapeutic_class {
    label: "Store Drug Inventory Drug Unique Ahfs Therapeutic Class"
    description: "Therapeutic Class as identified by the American Hospital Formulary Service."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_AHFS_THERAPEUTIC_CLASS ;;
  }

  dimension: store_drug_inventory_drug_unique_alternate_product_name {
    label: "Store Drug Inventory Drug Unique Alternate Product Name"
    description: "Used for multiple brands/generics for the same drug. A particular drug may have more than one branded name, as well as a generic."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALTERNATE_PRODUCT_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_alternate_nhin_drug_name {
    label: "Store Drug Inventory Drug Unique Alternate Nhin Drug Name"
    description: "Alternate drug name as identified by NHIN."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALTERNATE_NHIN_DRUG_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_dib_strength {
    label: "Store Drug Inventory Drug Unique Dib Strength"
    description: "Medi-Span drug strength."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DIB_STRENGTH ;;
  }

  dimension: store_drug_inventory_drug_unique_dib_unit {
    label: "Store Drug Inventory Drug Unique Dib Unit"
    description: "Medi-Span drug unit."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DIB_UNIT ;;
  }

  dimension: store_drug_inventory_drug_unique_inner_pack_barcode {
    label: "Store Drug Inventory Drug Unique Inner Pack Barcode"
    description: "When drug packaging contains smaller packs within a larger pack and the inner pack has its own barcode."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INNER_PACK_BARCODE ;;
  }

  dimension: store_drug_inventory_drug_unique_inner_pack_ndc {
    label: "Store Drug Inventory Drug Unique Inner Pack NDC"
    description: "When drug packaging contains smaller packs within a larger pack and the inner pack has its own NDC."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INNER_PACK_NDC ;;
  }

  dimension: store_drug_inventory_drug_unique_investigational {
    label: "Store Drug Inventory Drug Unique Investigational"
    description: "Drugs, not yet approved by the FDA, that are used for investigational purposes."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INVESTIGATIONAL = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_user_defined_name {
    label: "Store Drug Inventory Drug Unique User Defined Name"
    description: "Extended version of the Drug Name. Free Formatted field. When populated, this name is used for display."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_USER_DEFINED_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_route_code {
    label: "Store Drug Inventory Drug Unique Route Code"
    description: "Description of how a Drug is administered."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ROUTE_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_dosage_form {
    label: "Store Drug Inventory Drug Unique Dosage Form"
    description: "The physical form of a drug intended for administration or consumption."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DOSAGE_FORM ;;
  }

  dimension: store_drug_inventory_drug_unique_outer_pack_barcode {
    label: "Store Drug Inventory Drug Unique Outer Pack Barcode"
    description: "10 digit NDC/DIN matching the barcode of the outer pack of the drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OUTER_PACK_BARCODE ;;
  }

  dimension: store_drug_inventory_drug_unique_outer_pack_ndc {
    label: "Store Drug Inventory Drug Unique Outer Pack NDC"
    description: "Outer-Pack National Drug Code used as a universal product identifier for human drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OUTER_PACK_NDC ;;
  }

  dimension: store_drug_inventory_drug_unique_custom_imprint_code {
    label: "Store Drug Inventory Drug Unique Custom Imprint Code"
    description: "Unique code that identifies the imprint text to use when this drug is dispensed."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CUSTOM_IMPRINT_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_cost_verified {
    label: "Store Drug Inventory Drug Unique Cost Verified"
    description: "Yes/No flag indicating whether or not a drug's acquisition cost has been verified by a Host Administrator."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_COST_VERIFIED = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_global_trade_number {
    label: "Store Drug Inventory Drug Unique Global Trade Number"
    description: "Tracking number used to identify how the product is packaged for shipping."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_GLOBAL_TRADE_NUMBER ;;
  }

  dimension: store_drug_inventory_drug_unique_veterinary_use_only {
    label: "Store Drug Inventory Drug Unique Veterinary Use Only"
    description: "Yes/No flag that indicates whether this drug is to be used for Veterinarian use only."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_VETERINARY_USE_ONLY = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_previous_schedule {
    label: "Store Drug Inventory Drug Unique Previous Schedule"
    description: "Tracks original schedule of a drug if it has been changed. ( Added as a part of the Hydrocodone schedule change o 10/6/2014. )  This is an automated process through EPS code. Users can change schedule through UI or in Host and this field will be updated with the schedule that the drug was before the change."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '1' THEN '1 - C-I'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '2' THEN '2 - C-II'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '3' THEN '3 - C-III'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '4' THEN '4 - C-IV'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '5' THEN '5 - C-V'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '6' THEN '6 - RX'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE = '8' THEN '8 - OTC'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE IS NULL THEN 'NULL - NOT CHANGED'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["1 - C-I","2 - C-II","3 - C-III","4 - C-IV","5 - C-V","6 - RX","8 - OTC","NULL - NOT CHANGED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_previous_schedule_reference]
  }

  dimension: store_drug_inventory_drug_unique_previous_schedule_reference {
    label: "Store Drug Inventory Drug Unique Previous Schedule Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PREVIOUS_SCHEDULE ;;
  }

  dimension: store_drug_inventory_drug_unique_immunization_indicator {
    label: "Store Drug Inventory Drug Unique Immunization Indicator"
    description: "Yes/No flag which determines if a drug is a vaccination / immunization."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_IMMUNIZATION_INDICATOR = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_cvx_code {
    label: "Store Drug Inventory Drug Unique Cvx Code"
    description: "The CVX code is a numeric string, which identifies the type of vaccine product used. Contains CVX  Vaccine Administered Code. E.g. 128 , 162, 13."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CVX_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_mvx_code {
    label: "Store Drug Inventory Drug Unique Mvx Code"
    description: "Contains MVX Manufacturer of Vaccine Code. The MVX is an alphabetic string, which represents the manufacturer of a vaccine. e.g. PHR, WAL."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MVX_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_cpt_code {
    label: "Store Drug Inventory Drug Unique Cpt Code"
    description: "A five digit numeric code that is used for this drug, issued by AMA, to describe medical services."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CPT_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_cpt_code2 {
    label: "Store Drug Inventory Drug Unique Cpt Code2"
    description: "Second CPT code -- should only exist if CPT_CODE also exists. e.g. 90281, 90283, 90287."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CPT_CODE2 ;;
  }

  dimension: store_drug_inventory_drug_unique_disallow_autofill {
    label: "Store Drug Inventory Drug Unique Disallow Autofill"
    description: "The Autofill column will be used to capture the state for Allowing or disallowing Autofill enrollment for drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DISALLOW_AUTOFILL ='Y'  ;;
  }

  dimension: store_drug_inventory_drug_unique_inner_pack_indicator {
    label: "Store Drug Inventory Drug Unique Inner Pack Indicator"
    description: "Yes/No flag indicating it's an inner pack."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INNER_PACK_INDICATOR = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_narcotic_indicator {
    label: "Store Drug Inventory Drug Unique Narcotic Indicator"
    description: "Field indicating if the drug is a narcotic."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NARCOTIC_INDICATOR ;;
  }

  dimension: store_drug_inventory_drug_unique_rebate_amount {
    label: "Store Drug Inventory Drug Unique Rebate Amount"
    description: "Reflects the manufacturers rebate amount for this drug."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REBATE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_user_defined_quantity {
    label: "Store Drug Inventory Drug Unique User Defined Quantity"
    description: "User defined quantity that allows the use of multiple packages when dispensing a drug."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_USER_DEFINED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_rems {
    label: "Store Drug Inventory Drug Unique REMS"
    description: "Yes/No Flag indicating for a TX flagged as Y for a female patient, the RX will expire 7 days after Fill in Will Call. For a TX flagged as Y for male patient, the RX will expire 30 days after Fill in Will Call."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REMS = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_specialty {
    label: "Store Drug Inventory Drug Unique Specialty"
    description: "Yes/No Flag indicating if a drug is a specialty drug"
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SPECIALTY = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_black_box {
    label: "Store Drug Inventory Drug Unique Black Box"
    description: "Indicated by a Y (yes) or N (no) or null. Indicates whether a medication contains a black box warning on the package insert."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_BLACK_BOX = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_med_guide {
    label: "Store Drug Inventory Drug Unique Med Guide"
    description: "Indicated by a Y (yes) or N (no) or null. Indicates whether a medication has a Med Guide available."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MED_GUIDE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_tall_man {
    label: "Store Drug Inventory Drug Unique Tall Man"
    description: "Indicated by a Y (yes) or N (no) or null. Indicates whether part of a drug name is capitalized in order to distinguish it from other similar medications."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_TALL_MAN = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_arcos {
    label: "Store Drug Inventory Drug Unique Arcos"
    description: "Indicated by 1 (yes), 2 (no), or 3 (not applicable). Indicates whether a drug is reportable to ARCOS (Federal Automation of Reports and Consolidated Order Systems)."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ARCOS = '1' THEN '1 - YES'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ARCOS = '2' THEN '2 - NO'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ARCOS = '3' THEN '3 - N/A'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ARCOS IS NULL THEN 'NULL - NOT SUPPORTED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["1 - YES","2 - NO","3 - N/A","NULL - NOT SUPPORTED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_arcos_reference]
  }

  dimension: store_drug_inventory_drug_unique_arcos_reference {
    label: "Store Drug Inventory Drug Unique Arcos Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ARCOS ;;
  }

  dimension: store_drug_inventory_drug_unique_single_ingredient {
    label: "Store Drug Inventory Drug Unique Single Ingredient"
    description: "Indicated by C (Combination) or S (Single) or null. Indicates whether a drug only has a single ingredient."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_INGREDIENT = 'C' THEN 'C - COMBINATION'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_INGREDIENT = 'S' THEN 'S - SINGLE'
              WHEN ${TABLE}.STORE_DRUG_NDC IS NOT NULL AND ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_INGREDIENT IS NULL THEN 'NULL - NOT SPECIFIED'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["C - COMBINATION","S - SINGLE","NULL - NOT SPECIFIED"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_unique_single_ingredient_reference]
  }

  dimension: store_drug_inventory_drug_unique_single_ingredient_reference {
    label: "Store Drug Inventory Drug Unique Single Ingredient Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_INGREDIENT ;;
  }

  dimension: store_drug_inventory_drug_unique_partial_gpi {
    label: "Store Drug Inventory Drug Unique Partial Gpi"
    description: "Indicated by Y (yes) or N (no) or null. Indicates that there is not a full GPI on the drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PARTIAL_GPI = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_durable_medical_equipment_flag {
    label: "Store Drug Inventory Drug Unique Durable Medical Equipment Flag"
    description: "Yes/No indiacating if a drug is flagged as DME at Host."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DURABLE_MEDICAL_EQUIPMENT_FLAG = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_unique_original_schedule {
    label: "Store Drug Inventory Drug Unique Original Schedule"
    description: "Original drug schedule prior to applying Disp. Rules."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ORIGINAL_SCHEDULE ;;
  }

  dimension: store_drug_inventory_drug_unique_substitute_drug_code {
    label: "Store Drug Inventory Drug Unique Substitute Drug Code"
    description: "Code of drug to be used as a substitute. Must be on File."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SUBSTITUTE_DRUG_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_standard_pack_ndc {
    label: "Store Drug Inventory Drug Unique Standard Pack NDC"
    description: "Standard package NDC/DIN code."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_STANDARD_PACK_NDC ;;
  }

  dimension: store_drug_inventory_drug_unique_tall_man_drug_name {
    label: "Store Drug Inventory Drug Unique Tall Man Drug Name"
    description: "Tall Man Drug Name."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_TALL_MAN_DRUG_NAME ;;
  }

  dimension: store_drug_inventory_drug_unique_sig_code {
    label: "Store Drug Inventory Drug Unique SIG Code"
    description: "SIG code commonly used with this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SIG_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_drug_route_of_admin_code {
    label: "Store Drug Inventory Drug Unique Drug Route Of Admin Code"
    description: "Drug route of admin code, MEDISPAN."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DRUG_ROUTE_OF_ADMIN_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_ncpdp_unit {
    label: "Store Drug Inventory Drug Unique NCPDP Unit"
    description: "NCPDP unit: EA,ML,GM."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NCPDP_UNIT ;;
  }

  dimension: store_drug_inventory_drug_unique_daw_flag {
    label: "Store Drug Inventory Drug Unique DAW Flag"
    description: "Drug DAW flag."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DAW_FLAG ;;
  }

  dimension: store_drug_inventory_drug_unique_host_new_store_flag {
    label: "Store Drug Inventory Drug Unique Host New Store Flag"
    description: "Flag for new store."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_HOST_NEW_STORE_FLAG ;;
  }

  dimension: store_drug_inventory_drug_unique_canada_require_written {
    label: "Store Drug Inventory Drug Unique Canada Require Written"
    description: "Requires a written prescription."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CANADA_REQUIRE_WRITTEN ;;
  }

  dimension: store_drug_inventory_drug_unique_canada_reportable_drug {
    label: "Store Drug Inventory Drug Unique Canada Reportable Drug"
    description: "Report Flag."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CANADA_REPORTABLE_DRUG ;;
  }

  dimension: store_drug_inventory_drug_unique_triplicate_flag {
    label: "Store Drug Inventory Drug Unique Triplicate Flag"
    description: "Triplicate Drug Flag."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_TRIPLICATE_FLAG ;;
  }

  dimension: store_drug_inventory_drug_unique_active_drug {
    label: "Store Drug Inventory Drug Unique Active Drug"
    description: "Flag for active Drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACTIVE_DRUG ;;
  }

  dimension: store_drug_inventory_drug_unique_substitute_link_option {
    label: "Store Drug Inventory Drug Unique Substitute Link Option"
    description: "Substitute link option."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SUBSTITUTE_LINK_OPTION ;;
  }

  dimension: store_drug_inventory_drug_unique_customer_clinical {
    label: "Store Drug Inventory Drug Unique Customer Clinical"
    description: "Customer-supported clinicals."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CUSTOMER_CLINICAL ;;
  }

  dimension: store_drug_inventory_drug_unique_canada_use_print_enum {
    label: "Store Drug Inventory Drug Unique Canada Use Print Enum"
    description: "Use/Print option to be loaded on the Rx Filling Screen."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CANADA_USE_PRINT_ENUM ;;
  }

  dimension: store_drug_inventory_drug_unique_activity_code_medispan {
    label: "Store Drug Inventory Drug Unique Activity Code Medispan"
    description: "MEDISPAN activity code."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ACTIVITY_CODE_MEDISPAN ;;
  }

  dimension: store_drug_inventory_drug_unique_refills_authorized {
    label: "Store Drug Inventory Drug Unique Refills Authorized"
    description: "Default refills authorized."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REFILLS_AUTHORIZED ;;
  }

  dimension: store_drug_inventory_drug_unique_use_subs_code_search {
    label: "Store Drug Inventory Drug Unique Use Subs Code Search"
    description: "Use SUBS Code search rather than GPI-based search for substitute drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_USE_SUBS_CODE_SEARCH ;;
  }

  dimension: store_drug_inventory_drug_unique_zone_price_code {
    label: "Store Drug Inventory Drug Unique Zone Price Code"
    description: "Price Zone."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ZONE_PRICE_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_counseling_code {
    label: "Store Drug Inventory Drug Unique Counseling Code"
    description: "Patient counseling code."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_COUNSELING_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_interaction_code {
    label: "Store Drug Inventory Drug Unique Interaction Code"
    description: "Drug interaction number."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INTERACTION_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_default_quantity {
    label: "Store Drug Inventory Drug Unique Default Quantity"
    description: "Quantity dispensed commonly used with this drug."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DEFAULT_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_standard_pack_size {
    label: "Store Drug Inventory Drug Unique Standard Pack Size"
    description: "Package size used for standard pricing."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_STANDARD_PACK_SIZE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_maximum_daily_dosage {
    label: "Store Drug Inventory Drug Unique Maximum Daily Dosage"
    description: "Maximum daily dosage of standard units on this drug."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MAXIMUM_DAILY_DOSAGE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_monthly_usage {
    label: "Store Drug Inventory Drug Unique Monthly Usage"
    description: "Month to date usage."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MONTHLY_USAGE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_yearly_usage {
    label: "Store Drug Inventory Drug Unique Yearly Usage"
    description: "Year to date usage."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_YEARLY_USAGE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_override_percentage_of_cost {
    label: "Store Drug Inventory Drug Unique Override Percentage Of Cost"
    description: "Override percentage of cost = minimum price."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_OVERRIDE_PERCENTAGE_OF_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: store_drug_inventory_drug_unique_ndc_add {
    label: "Store Drug Inventory Drug Unique NDC Add"
    description: "NDC add date."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NDC_ADD_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_ndc_change {
    label: "Store Drug Inventory Drug Unique NDC Change"
    description: "NDC change date."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NDC_CHANGE_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_sig_text_change {
    label: "Store Drug Inventory Drug Unique SIG Text Change"
    description: "Timestamp SIG text was changed."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SIG_TEXT_CHANGE_TIMESTAMP ;;
  }

  dimension: store_drug_inventory_drug_unique_first_substitute_ndc {
    label: "Store Drug Inventory Drug Unique First Substitute NDC"
    description: "First substitute NDC."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_FIRST_SUBSTITUTE_NDC ;;
  }

  dimension: store_drug_inventory_drug_unique_second_substitute_ndc {
    label: "Store Drug Inventory Drug Unique Second Substitute NDC"
    description: "Second substitute NDC."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SECOND_SUBSTITUTE_NDC ;;
  }

  dimension: store_drug_inventory_drug_unique_clear_reorder_filed {
    label: "Store Drug Inventory Drug Unique Clear Reorder Filed"
    description: "Clear Reorder Field on Paste."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CLEAR_REORDER_FILED ;;
  }

  dimension: store_drug_inventory_drug_unique_counseling_code_2 {
    label: "Store Drug Inventory Drug Unique Counseling Code 2"
    description: "Patient counseling code 2."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_COUNSELING_CODE_2 ;;
  }

  dimension: store_drug_inventory_drug_unique_interaction_code_2 {
    label: "Store Drug Inventory Drug Unique Interaction Code 2"
    description: "Drug interaction number 2."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_INTERACTION_CODE_2 ;;
  }

  dimension: store_drug_inventory_drug_unique_clear_competitive_pricing {
    label: "Store Drug Inventory Drug Unique Clear Competitive Pricing"
    description: "Clear Competitive Fields on Paste."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CLEAR_COMPETITIVE_PRICING ;;
  }

  dimension: store_drug_inventory_drug_unique_region {
    label: "Store Drug Inventory Drug Unique Region"
    description: "Drug region for comparison at Store paste program."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REGION ;;
  }

  dimension: store_drug_inventory_drug_unique_multiple_medispan_image_indicator {
    label: "Store Drug Inventory Drug Unique Multiple Medispan Image Indicator"
    description: "Indicator that there are multiple Images for this Drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MULTIPLE_MEDISPAN_IMAGE_INDICATOR ;;
  }

  dimension: store_drug_inventory_drug_unique_medispan_image_file {
    label: "Store Drug Inventory Drug Unique Medispan Image File"
    description: "File name for MS Image Database."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MEDISPAN_IMAGE_FILE_DATE ;;
  }

  dimension: store_drug_inventory_drug_unique_ndc_format {
    label: "Store Drug Inventory Drug Unique NDC Format"
    description: "NDC format."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NDC_FORMAT ;;
  }

  dimension: store_drug_inventory_drug_unique_clear_mfg_field_on_paste {
    label: "Store Drug Inventory Drug Unique Clear Mfg Field On Paste"
    description: "Clear drug MFG field on paste."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CLEAR_MFG_FIELD_ON_PASTE ;;
  }

  dimension: store_drug_inventory_drug_unique_allocated_quantity {
    label: "Store Drug Inventory Central Fill Allocated Quantitiy"
    description: "Central Fill ONLY, drug's allocated quantity. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALLOCATED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_not_mail_order {
    label: "Store Drug Inventory Drug Unique Not Mail Order"
    description: "Not Mail Order."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NOT_MAIL_ORDER ;;
  }

  dimension: store_drug_inventory_drug_unique_max_pack_multiple {
    label: "Store Drug Inventory Drug Unique Max Pack Multiple"
    description: "Max Pack Multiple."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MAX_PACK_MULTIPLE ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_price_quantity_3 {
    label: "Store Drug Inventory Drug Unique Price Quantity 3"
    description: "Third quantity used on the Drug Retail Price List."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_PRICE_QUANTITY_3 ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_dispensable_drug_identifier {
    label: "Store Drug Inventory Drug Unique Dispensable Drug Identifier"
    description: "Dispensable Drug Identifier."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_DISPENSABLE_DRUG_IDENTIFIER ;;
  }

  dimension: store_drug_inventory_drug_unique_clinical_drug_identifier {
    label: "Store Drug Inventory Drug Unique Clinical Drug Identifier"
    description: "Clinical Drug Identifier."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_CLINICAL_DRUG_IDENTIFIER ;;
  }

  dimension: store_drug_inventory_drug_unique_alternate_drug_name_up {
    label: "Store Drug Inventory Drug Unique Alternate Drug Name Up"
    description: "Alternate Drug Name."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALTERNATE_DRUG_NAME_UP ;;
  }

  dimension: store_drug_inventory_drug_unique_manual_acq_drug {
    label: "Store Drug Inventory Drug Unique Manual ACQ Drug"
    description: "Manual ACQ Drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MANUAL_ACQ_DRUG ;;
  }

  dimension: store_drug_inventory_drug_unique_reconstitute {
    label: "Store Drug Inventory Drug Unique Reconstitute"
    description: "Drug must be reconstituted."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_RECONSTITUTE ;;
  }

  dimension: store_drug_inventory_drug_unique_potency_unit {
    label: "Store Drug Inventory Drug Unique Potency Unit"
    description: "Potency Unit of Measure."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_POTENCY_UNIT ;;
  }

  dimension: store_drug_inventory_drug_unique_nadean {
    label: "Store Drug Inventory Drug Unique NADEAN"
    description: "Narcotics Addiction DEA Number."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_NADEAN ;;
  }

  dimension: store_drug_inventory_drug_unique_reissue_flag {
    label: "Store Drug Inventory Drug Unique Reissue Flag"
    description: "Re-issued NDC with previous and current assignment for different drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REISSUE_FLAG ;;
  }

  dimension_group: store_drug_inventory_drug_unique_reissue {
    label: "Store Drug Inventory Drug Unique Reissue"
    description: "Date this NDC was re-issued for another drug."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REISSUE_DATE ;;
  }

  dimension: store_drug_inventory_drug_unique_message {
    label: "Store Drug Inventory Drug Unique Message"
    description: "Free-form Drug Message."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MESSAGE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_last_update {
    label: "Store Drug Inventory Drug Unique Last Update"
    description: "Date this drug was last updated."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_LAST_UPDATE_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_host_last_update {
    label: "Store Drug Inventory Drug Unique Host Last Update"
    description: "Date this drug was last updated from Host."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_HOST_LAST_UPDATE_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_unique_add {
    label: "Store Drug Inventory Drug Unique Add"
    description: "Date Drug Record Added to System."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ADD_DATE ;;
  }

  dimension: store_drug_inventory_drug_unique_costbase {
    label: "Store Drug Inventory Drug Unique Costbase"
    description: "Price base to calculate level prices if updates are allowed."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_COSTBASE ;;
  }

  dimension: store_drug_inventory_drug_unique_commercial_drug_code {
    label: "Store Drug Inventory Drug Unique Commercial Drug Code"
    description: "Commercial Drug Code."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_COMMERCIAL_DRUG_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_kdc5 {
    label: "Store Drug Inventory Drug Unique KDC5"
    description: "Medi-Span KDC5 Code."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_KDC5 ;;
  }

  dimension: store_drug_inventory_drug_unique_single_batch_sig_code {
    label: "Store Drug Inventory Drug Unique Single Batch SIG Code"
    description: "The default SIG Code that will be used during the Single Drug Batch Processing utility if available."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_BATCH_SIG_CODE ;;
  }

  dimension: store_drug_inventory_drug_unique_minimum_dispense_quantity {
    label: "Store Drug Inventory Drug Unique Minimum Dispense Quantity"
    description: "A user defined quantity that alerts when a user tries to dispense any amount not of the increment of that quantity."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_MINIMUM_DISPENSE_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_unique_route_of_administration_id {
    label: "Store Drug Inventory Drug Unique Route Of Administration Identifier"
    description: "Identifier of the Route of Administration record linked to this drug record."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ROUTE_OF_ADMINISTRATION_ID ;;
  }

  dimension: store_drug_inventory_drug_unique_single_drug_batch_indicator {
    label: "Store Drug Inventory Drug Unique Single Drug Batch Indicator"
    description: "Indicates if the drug is available for Single Drug Batch Processing."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_SINGLE_DRUG_BATCH_INDICATOR ;;
  }

  dimension: store_drug_inventory_drug_unique_reorder_drug_id {
    label: "Store Drug Inventory Drug Unique Reorder Drug Identifier"
    description: "Drug Identifier of the drug record that is linked to the reorder record that is to be used for this drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_REORDER_DRUG_ID ;;
  }

  dimension: store_drug_inventory_drug_local_setting_manufacturer {
    label: "Store Drug Inventory Drug Local Setting Manufacturer"
    description: "Name of the drug's manufacturer."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_MANUFACTURER ;;
  }

  dimension: store_drug_inventory_drug_local_setting_lot_number {
    label: "Store Drug Inventory Drug Local Setting Lot Number"
    description: "Number from the bottle given by the manufacturer that identifies the production lot of a given drug."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_LOT_NUMBER ;;
  }

  dimension: store_drug_inventory_drug_local_setting_nursing_home_hold {
    label: "Store Drug Inventory Drug Local Setting Nursing Home Hold"
    description: "Flag that determines how the system sets the nursing home hold status flag when this drug is displayed on the Data Entry screen."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'B' THEN 'B - BATCH'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'M' THEN 'M - MAR'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'Y' THEN 'Y - BOTH'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'N' THEN 'N - NO HOLD'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["B - BATCH","M - MAR","Y - BOTH","N - NO HOLD"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_local_setting_nursing_home_hold_reference]
  }

  dimension: store_drug_inventory_drug_local_setting_nursing_home_hold_reference {
    label: "Store Drug Inventory Drug Local Setting Nursing Home Hold Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_NURSING_HOME_HOLD ;;
  }

  dimension: store_drug_inventory_drug_local_setting_group_code {
    label: "Store Drug Inventory Drug Local Setting Group Code"
    description: "Group of drug for reports."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_GROUP_CODE ;;
  }

  dimension: store_drug_inventory_drug_local_setting_subgroup {
    label: "Store Drug Inventory Drug Local Setting Subgroup"
    description: "Code representing a sub grouping of drugs."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_SUBGROUP ;;
  }

  dimension: store_drug_inventory_drug_local_setting_category {
    label: "Store Drug Inventory Drug Local Setting Category"
    description: "Code representing a drug category."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_CATEGORY ;;
  }

  dimension: store_drug_inventory_drug_local_setting_baker_cell {
    label: "Store Drug Inventory Drug Local Setting Baker Cell"
    description: "Baker Cell (automated capsule/tablet counter) number for this drug."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_BAKER_CELL ;;
  }

  dimension: store_drug_inventory_drug_local_setting_acquisition_cost {
    label: "Store Drug Inventory Drug Local Setting Acquisition Cost"
    description: "True acquisition cost per pack for the stock that you have on the shelf. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_ACQUISITION_COST ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_last_fill {
    label: "Store Drug Inventory Drug Local Setting Last Fill"
    description: "Date this record was last used to fill a prescription."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_LAST_FILL_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_expiration {
    label: "Store Drug Inventory Drug Local Setting Expiration"
    description: "Date this drug's effectiveness expires (from the medication stock bottle)."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_EXPIRATION_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_discontinue {
    label: "Store Drug Inventory Drug Local Setting Discontinue"
    description: "Date to discontinue use of this drug."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_DISCONTINUE_DATE ;;
  }

  dimension: store_drug_inventory_drug_local_setting_bay {
    label: "Store Drug Inventory Drug Local Setting Bay"
    description: "Bay in which the drug is located."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_BAY ;;
  }

  dimension: store_drug_inventory_drug_local_setting_rack {
    label: "Store Drug Inventory Drug Local Setting Rack"
    description: "Rack on which the drug is located."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_RACK ;;
  }

  dimension: store_drug_inventory_drug_local_setting_shelf_location {
    label: "Store Drug Inventory Drug Local Setting Shelf Location"
    description: "Shelf on which the drug is located."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_SHELF_LOCATION ;;
  }

  dimension: store_drug_inventory_drug_local_setting_bin {
    label: "Store Drug Inventory Drug Local Setting Bin"
    description: "Bin in which the drug is located."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_BIN ;;
  }

  dimension: store_drug_inventory_drug_local_setting_auto_dispense {
    label: "Store Drug Inventory Drug Local Setting Auto Dispense"
    description: "Yes/No flag that indicates if the drug is available in an automatic filling system."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_AUTO_DISPENSE = 'Y' ;;
  }

  dimension: store_drug_inventory_drug_local_setting_quantity_allocated {
    label: "Store Drug Inventory Drug Local Setting Quantity Allocated"
    description: "Amount of the drug that has been allocated by Data Entry. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_drug_local_setting_unavailable_locally {
    label: "Store Drug Inventory Drug Local Setting Unavailable Locally"
    description: "Flag that determines whether the drug can be dispensed locally."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'Y' THEN 'Y - FULFILLMENT FACILITY ONLY'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'N' THEN 'N - AVAILABLE LOCALLY'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'B' THEN 'B - BOTH'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["Y - FULFILLMENT FACILITY ONLY","N - AVAILABLE LOCALLY","B - BOTH"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_drug_local_setting_unavailable_locally_reference]
  }

  dimension: store_drug_inventory_drug_local_setting_unavailable_locally_reference {
    label: "Store Drug Inventory Drug Local Setting Unavailable Locally Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY ;;
  }

  dimension: store_drug_inventory_drug_local_setting_baker_cassette {
    label: "Store Drug Inventory Drug Local Setting Baker Cassette"
    description: "The cassette number for a Baker cassette device. Used by Baker cassette interface."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_BAKER_CASSETTE ;;
  }

  dimension: store_drug_inventory_drug_local_setting_drug_image_key {
    label: "Store Drug Inventory Drug Local Setting Drug Image Key"
    description: "DIB filename of the drug image associated with this drug record. Populated based on the image selected the last time this product was dispensed at Fill. Displayed as the default image until Fill user selects a different image when this product is dispensed."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_DRUG_IMAGE_KEY ;;
  }

  dimension: store_drug_inventory_drug_local_setting_class {
    label: "Store Drug Inventory Drug Local Setting Class"
    description: "Field that can be used to group drug records for reports or processing, such as a therapeutic class."
    type: string
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_CLASS ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_image_imprint_start {
    label: "Store Drug Inventory Drug Local Setting Image Imprint Start"
    description: "Date that the drug's imprint or image became available."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_IMAGE_IMPRINT_START_DATE ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_last_dib_sync {
    label: "Store Drug Inventory Drug Local Setting Last Dib Sync"
    description: "Shows the last date on which the Drug was updated by a DIB update."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_LAST_DIB_SYNC_DATE ;;
  }

  dimension: store_drug_inventory_drug_local_setting_use_local_quantity_first {
    label: "Store Drug Inventory Drug Local Setting Use Local Quantity First"
    description: "Yes/No flag to indicate if routing to central fill should be stopped if local inventory has sufficient BOH of the NDC that was RTS from central fill. Must be previous RTS from CF."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_USE_LOCAL_QUANTITY_FIRST = 'Y' ;;
  }

  dimension_group: store_drug_inventory_drug_local_setting_last_count {
    label: "Store Drug Inventory Drug Local Setting Last Count"
    description: "Date field which holds the last time the drug was counted."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_LAST_COUNT_DATE ;;
  }

  dimension: store_drug_inventory_drug_local_setting_manual_acquisition_drug {
    label: "Store Drug Inventory Drug Local Setting Manual Acquisition Drug"
    description: "Yes/No flag identifying this drug as a Manual ACQ Drug so that when dispensed, different pricing logic is applied in order to use a lower ACQ than what is currently on the drug."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_MANUAL_ACQUISITION_DRUG = 'Y' ;;
  }

  dimension: store_drug_inventory_restated_flag {
    label: "Store Drug Inventory Restated Flag"
    description: "Yes/No flag indicating whether drug inventory information has been restated."
    type: yesno
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RESTATED_FLAG = 'Y' ;;
  }

  dimension: store_drug_inventory_store_drug_activity {
    label: "Store Drug Inventory Store Drug Activity"
    description: "Flag indication the activity of NDC at chain or store."
    type: string
    sql: CASE WHEN ${TABLE}.STORE_DRUG_NDC IS NULL THEN 'N/A'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_STORE_DRUG_ACTIVITY_CODE = 'I' THEN 'I - INACTIVE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_STORE_DRUG_ACTIVITY_CODE = 'A' THEN 'A - ACTIVE'
              WHEN ${TABLE}.STORE_DRUG_INVENTORY_STORE_DRUG_ACTIVITY_CODE = 'N' THEN 'N - ACTIVE BUT NO ONHAND QUANTITY'
              ELSE 'UNKNOWN'
          END ;;
    suggestions: ["I - INACTIVE","A - ACTIVE","N - ACTIVE BUT NO ONHAND QUANTITY"]
    suggest_persist_for: "24 hours"
    drill_fields: [store_drug_inventory_store_drug_activity_code_reference]
  }

  dimension: store_drug_inventory_store_drug_activity_code_reference {
    label: "Store Drug Inventory Store Drug Activity Code Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_STORE_DRUG_ACTIVITY_CODE ;;
  }

  dimension: store_drug_inventory_hash {
    label: "Store Drug Inventory Hash"
    description: "HASH of all the fields except metadata fields."
    type: string
    hidden:  yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_HASH ;;
  }

  dimension: event_id {
    label: "Event Id"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW."
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension_group: edw_insert_timestamp {
    label: "Edw Insert"
    description: "The time at which the record is inserted to EDW."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    hidden: yes
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "Edw Last Update"
    description: "The time at which the record is updated to EDW."
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    hidden: yes
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: load_type {
    label: "Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW."
    type: string
    hidden: yes
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension: store_drug_inventory_beginning_on_hand {
    label: "Beginning On Hand"
    description: "Beginning On Hand Value for Activity Date, which is the Ending On Hand Value from Previous Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_ending_on_hand {
    label: "Ending On Hand"
    description: "Ending On Hand Value for the Drug, for the Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_return_and_adjustment_total_quantity {
    label: "Return And Adjustment Quantity"
    description: "Manual Adjustments for Activity Date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_TOTAL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_expected_quantity {
    label: "Expected Quantity"
    description: "Expected Quantity On Hand Value for the Drug, for the Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: (nvl(${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND, 0) + nvl(${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_RECEIVED_QUANTITY, 0)) - nvl(${TABLE}.STORE_DRUG_INVENTORY_RX_FILLED_DECREASE_QUANTITY, 0) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_manual_and_expected_quantity {
    label: "Expected Quantity +/- Manual Adjustments"
    description: "Expected Quantity +/- Manual Adjustments for Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: nvl(${store_drug_inventory_return_and_adjustment_total_quantity}, 0) + ${store_drug_inventory_expected_quantity} ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_committed {
    label: "Quantity Committed"
    description: "Daily value of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_COMMITTED ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_uncommitted {
    label: "Quantity UnCommitted"
    description: "Daily value of the Sum of Quantity that is returned to Stock, that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_UNCOMMITTED ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  ###################################### START - ERXDWPS-8261 ACQ and MVAC dimensions ######################################

  dimension: store_drug_inventory_moving_average_cost_per_unit {
    label: "Store Drug Inventory Moving Average Cost Per Unit"
    description: "The daily snapshot value of the Drug Moving Average Cost (MVAC) Per Unit."
    type: number
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  dimension: store_drug_inventory_beginning_on_hand_acquisition_cost {
    label: "Beginning On Hand Acquisition Cost"
    description: "Beginning On Hand Acquisition Cost for Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_ending_on_hand_acquisition_cost {
    label: "Ending On Hand Acquisition Cost"
    description: "Ending On Hand Acquisition Cost for the Drug, for the Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_committed_acquisition_cost {
    label: "Quantity Committed Acquisition Cost"
    description: "Daily Acquisition Cost of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_cumulative_quantity_committed_acquisition_cost {
    label: "Store Drug Inventory Cumulative Quantity Committed Acquisition Cost"
    description: "Cumulative aggregate Acquisition Cost of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_uncommitted_acquisition_cost {
    label: "Quantity UnCommitted Acquisition Cost"
    description: "Daily Acquisition Cost of the Sum of Quantity that is returned to Stock, that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_UNCOMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_cumulative_drug_ordered_not_received_quantity_acquisition_cost {
    label: "Store Drug Inventory Cumulative Drug Ordered Not Received Quantity Acquisition Cost"
    description: "Acquisition Cost of Sum of Quantity where Purchase Orders are still open and have not been closed/applied to inventory. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_calculated_ending_on_hand_acquisition_cost {
    label: "Store Drug Inventory Calculated Ending On Hand Acquisition Cost"
    description: "Calculated Ending On Hand Acquisition Cost per Activity Date based on Starting On Hand, Quantities committed and un-committed, and adjustments. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_order_quantity_acquisition_cost {
    label: "Store Drug Inventory Reorder Primary Level Order Quantity Acquisition Cost"
    description: "Store Drug Inventory Reorder Primary Level Order Quantity Acquisition Cost."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_minimum_quantity_acquisition_cost {
    label: "Store Drug Inventory Reorder Primary Level Minimum Quantity Acquisition Cost."
    description: "Store Drug Inventory Reorder Primary Level Minimum Quantity Acquisition Cost"
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_MINIMUM_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_order_quantity_acquisition_cost {
    label: "Store Drug Inventory Reorder Secondary Level Order Quantity Acquisition Cost"
    description: "Store Drug Inventory Reorder Secondary Level Order Quantity Acquisition Cost."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_minimum_quantity_acquisition_cost {
    label: "Store Drug Inventory Reorder Secondary Level Minimum Quantity Acquisition Cost"
    description: "Store Drug Inventory Reorder Secondary Level Minimum Quantity Acquisition Cost."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_MINIMUM_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_drug_local_setting_quantity_allocated_acquisition_cost {
    label: "Store Drug Inventory Drug Local Setting Quantity Allocated Acquisition Cost"
    description: "Acquisition Cost Amount of the drug that has been allocated by Data Entry. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_beginning_on_hand_moving_average_cost {
    label: "Beginning On Hand Moving Average Cost"
    description: "Beginning On Hand Moving Average Cost (MVAC) for Activity Date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_ending_on_hand_moving_average_cost {
    label: "Ending On Hand Moving Average Cost"
    description: "Ending On Hand Moving Average Cost (MVAC) for the Drug. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_committed_moving_average_cost {
    label: "Quantity Committed Moving Average Cost"
    description: "Daily Moving Average Cost (MVAC) of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_cumulative_quantity_committed_moving_average_cost {
    label: "Store Drug Inventory Cumulative Quantity Committed Moving Average Cost"
    description: "Cumulative aggregate Moving Average Cost (MVAC) of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_quantity_uncommitted_moving_average_cost {
    label: "Quantity UnCommitted Moving Average Cost"
    description: "Daily Moving Average Cost (MVAC) of the Sum of Quantity that is returned to Stock, that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_QUANTITY_UNCOMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_cumulative_drug_ordered_not_received_quantity_moving_average_cost {
    label: "Store Drug Inventory Cumulative Drug Ordered Not Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of Sum of Quantity where Purchase Orders are still open and have not been closed/applied to inventory. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_calculated_ending_on_hand_moving_average_cost {
    label: "Store Drug Inventory Calculated Ending On Hand Moving Average Cost."
    description: "Calculated Ending On Hand Moving Average Cost (MVAC) per Activity Date based on Starting On Hand, Quantities committed and un-committed, and adjustments. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_order_quantity_moving_average_cost {
    label: "Store Drug Inventory Reorder Primary Level Order Quantity Moving Average Cost"
    description: "Store Drug Inventory Reorder Primary Level Order Quantity Moving Average Cost (MVAC)."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_primary_level_minimum_quantity_moving_average_cost {
    label: "Store Drug Inventory Reorder Primary Level Minimum Quantity Moving Average Cost"
    description: "Store Drug Inventory Reorder Primary Level Minimum Quantity Moving Average Cost (MVAC)."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_MINIMUM_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_order_quantity_moving_average_cost {
    label: "Store Drug Inventory Reorder Secondary Level Order Quantity Moving Average Cost"
    description: "Store Drug Inventory Reorder Secondary Level Order Quantity Moving Average Cost (MVAC)."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_reorder_secondary_level_minimum_quantity_moving_average_cost {
    label: "Store Drug Inventory Reorder Secondary Level Minimum Quantity Moving Average Cost"
    description: "Store Drug Inventory Reorder Secondary Level Minimum Quantity Moving Average Cost (MVAC)."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_SECONDARY_LEVEL_MINIMUM_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: store_drug_inventory_drug_local_setting_quantity_allocated_moving_average_cost {
    label: "Store Drug Inventory Drug Local Setting Quantity Allocated Moving Average Cost"
    description: "Moving Average Cost (MVAC) Amount of the drug that has been allocated by Data Entry. Use the Activity Range measures instead of the dimension for any reports that consider a date range and grouping by day is not desired."
    type: number
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ###################################### END - ERXDWPS-8261 ACQ and MVAC dimensions ######################################

  ############################################################ END OF DIMENSIONS ############################################################

  measure: sum_store_drug_inventory_sold_quantity {
    label: "Total Sold Quantity"
    description: "Fill Quantity of the Drug that was Sold, and not returned on the same day, on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SOLD_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_returned_fill_quantity {
    label: "Total Returned Fill Quantity"
    description: "Returned Fill Quantity of the Drug on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURNED_FILL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_received_quantity {
    label: "Total Drug Order Received Quantity"
    description: "Quantity of the drug received. Initially reported by 855; may be adjusted manually for ACTUAL."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_RECEIVED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_acknowledgement_received_quantity {
    label: "Total Drug Order Acknowledgement Received Quantity"
    description: "Quantity that the vendor indicated would be shipped on the drug order acknowledgment."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_ACKNOWLEDGEMENT_RECEIVED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_cost_recieved {
    label: "Total Drug Order Cost Received"
    description: "Current acquisition cost for the drug being ordered. This cost may be updated with a new cost if the supplier returns the acquisition cost when receiving the order."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_COST_RECIEVED ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_quantity {
    label: "Total Drug Order Quantity"
    description: "Reorder quantity that corresponds to the Reorder QTY field of the drug's reorder parameters record. The entry in this field depends on the supplier designation. This is the quantity of drug inventory to be ordered from the supplier. The units must be a multiple of the units on the drug record. For example, if the Pack field on the drug record is 100, this field must be 100, 200, 300, etc.The user can however override the reorder qty with another qty. Also, the Up To Qty on the reorder record can cause this field to be greater than the order qty from the reorder parameter."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_order_quantity {
    label: "Total Drug Order Vendor Order Quantity"
    description: "Quantity that was actually ordered in the 850 with the conversion factor applied. If the pack size is 100 and we order 1 pack, the order qty will be 100, but if the vendor views that as 1 unit, the conversion factor will be .01, and the vendor_order_qty wil be 1."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ORDER_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_acknowledgement_received_quantity {
    label: "Total Drug Order Vendor Acknowledgement Received Quantity"
    description: "Quantity that the vendor indicated would be shipped on the drug order acknowledgment before applying the conversion factor to convert back to multiples of the pack size. f the pack size is 100 and we order 1 pack, the ack rec qty will be 100, but if the vendor views that as 1 unit, the conversion factor will be .01, and the vendor_ack_received_qty wil be 1."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ACKNOWLEDGEMENT_RECEIVED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_received_quantity {
    label: "Total Drug Order Vendor Received Quantity"
    description: "Quantity of the drug received before applying the conversion factor to convert back to multiples of the pack size. To determine the number of reorder units, the system first divides the reorder quantity by the pack size. Then, it divides the result by the conversion factor."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_RECEIVED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_return_and_adjustment_increase_quantity {
    label: "Total Return And Adjustment Increase Quantity"
    description: "Total Positive Adjustments for Activity Date."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_decrease_quantity {
    label: "Total Return And Adjustment Decrease Quantity"
    description: "Total Negative Adjustments for Activity Date."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_total_quantity {
    label: "Total Return And Adjustment Quantity"
    description: "Total Adjustments for Activity Date."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_TOTAL_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_primary_wholesaler_increase_quantity {
    label: "Total Primary Wholesaler Increase Quantity (APW)"
    description: "Total Adjustments for Activity Date for Primary Wholesaler."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_PRIMARY_WHOLESALER_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_secondary_wholesaler_increase_quantity {
    label: "Total Secondary Wholesaler Increase Quantity (ASW)"
    description: "Total Adjustments for Activity Date for Secondary Wholesaler."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SECONDARY_WHOLESALER_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_tertiary_wholesaler_increase_quantity {
    label: "Total Tertiary Wholesaler Increase Quantity (ATW)"
    description: "Total Adjustments for Activity Date for Tertiary Wholesaler."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_TERTIARY_WHOLESALER_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_decrease_quantity {
    label: "Total Correct Prior Adjustment Return Decrease Quantity (CAD)"
    description: "Total Adjustments for Activity Date for Correct prior adj ret decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_increase_quantity {
    label: "Total Correct Prior Adjustment Return Increase Quantity (CAI)"
    description: "Total Adjustments for Activity Date for Correct prior adj ret increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_clearing_house_decrease_quantity {
    label: "Total Clearing House Decrease Quantity (CLH)"
    description: "Total Adjustments for Activity Date for Clearing house decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CLEARING_HOUSE_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_correction_shortage_on_order_decrease_quantity {
    label: "Total Correction Shortage On Order Decrease Quantity (COD)"
    description: "Total Adjustments for Activity Date for Correction shortage on order decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_SHORTAGE_ON_ORDER_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_correction_overage_on_order_increase_quantity {
    label: "Total Correction Overage On Order Increase Quantity (COI)"
    description: "Total Adjustments for Activity Date for Correction - overage on order increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_OVERAGE_ON_ORDER_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_direct_from_manufacturer_increase_quantity {
    label: "Total Direct From Manufacturer Increase Quantity (DFM)"
    description: "Total Adjustments for Activity Date for Direct from manufacturer increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DIRECT_FROM_MANUFACTURER_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_destroyed_inventory_spillage_decrease_quantity {
    label: "Total Destroyed Inventory Spillage Decrease Quantity (DST)"
    description: "Total Adjustments for Activity Date for Destroyed inventory spillage decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DESTROYED_INVENTORY_SPILLAGE_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_overage_on_physical_inventory_increase_quantity {
    label: "Total Overage On Physical Inventory Increase Quantity (OVR)"
    description: "Total Adjustments for Activity Date for Overage on physical inventory increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_OVERAGE_ON_PHYSICAL_INVENTORY_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_direct_to_manufacturer_decrease_quantity {
    label: "Total Return Direct To Manufacturer Decrease Quantity (RMF)"
    description: "Total Adjustments for Activity Date for Return direct to manufacturer decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_DIRECT_TO_MANUFACTURER_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_to_primary_wholesaler_decrease_quantity {
    label: "Total Return To Primary Wholesaler Decrease Quantity (RPW)"
    description: "Total Adjustments for Activity Date for Return to primary wholesaler decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_PRIMARY_WHOLESALER_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_to_secondary_wholesaler_decrease_quantity {
    label: "Total Return To Secondary Wholesaler Decrease Quantity (RSW)"
    description: "Total Adjustments for Activity Date for Return to secondary wholesaler decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_SECONDARY_WHOLESALER_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_to_tertiary_wholesaler_decrease_quantity {
    label: "Total Return To Tertiary Wholesaler Decrease Quantity (RTW)"
    description: "Total Adjustments for Activity Date for Return to tertiary wholesaler decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_TERTIARY_WHOLESALER_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_shrinkage_from_physical_inventory_decrease_quantity {
    label: "Total Shrinkage From Physical Inventory Decrease Quantity (SHK)"
    description: "Total Adjustments for Activity Date for Shrinkage from physical inventory decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SHRINKAGE_FROM_PHYSICAL_INVENTORY_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_manual_decrease_of_onhand_amount_quantity {
    label: "Total Manual Decrease Of On Hand Amount Quantity (UPD)"
    description: "Total Adjustments for Activity Date for Manual decrease of On Hand amount."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_DECREASE_OF_ONHAND_AMOUNT_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_manual_increase_of_onhand_amount_quantity {
    label: "Total Manual Increase Of On Hand Amount Quantity (UPI)"
    description: "Total Adjustments for Activity Date for Manual increase of On Hand amount."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_INCREASE_OF_ONHAND_AMOUNT_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_cycle_count_correction_equal_quantity {
    label: "Total Cycle Count Correction Equal Quantity (CCC)"
    description: "Total Adjustments for Activity Date for Cycle count correction equal."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CYCLE_COUNT_CORRECTION_EQUAL_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_increase_quantity {
    label: "Total Return To Stock Increase Quantity (RSI)"
    description: "Total Adjustments for Activity Date for Return to stock increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_stolen_decrease_quantity {
    label: "Total Return To Stock Stolen Decrease Quantity (RSD)"
    description: "Total Adjustments for Activity Date for Return to stock stolen decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_STOLEN_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_rx_filled_decrease_quantity {
    label: "Total Rx Filled Decrease Quantity (RFD)"
    description: "Total Adjustments for Activity Date for Rx filled decrease."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_FILLED_DECREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_rx_cancelled_rejected_increase_quantity {
    label: "Total Rx Cancelled Rejected Increase Quantity (RCI)"
    description: "Total Adjustments for Activity Date for Rx cancelled rejected increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_CANCELLED_REJECTED_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_apply_drug_order_inventory_increase_quantity {
    label: "Total Apply Drug Order Inventory Increase Quantity (DOI)"
    description: "Total Adjustments for Activity Date for Apply drug order inventory increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_APPLY_DRUG_ORDER_INVENTORY_INCREASE_QUANTITY ;;
  }

  measure: sum_store_drug_inventory_adjust_negative_on_hand_increase_quantity {
    label: "Total Adjust Negative On Hand Increase Quantity (NOI)"
    description: "Total Adjustments for Activity Date for Adjust negative on hand increase."
    type: sum
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ADJUST_NEGATIVE_ON_HAND_INCREASE_QUANTITY ;;
  }

  #ERXDWPS-6633 #ERXDWPS-6632
  measure: net_store_drug_inventory_fill_quantity {
    label: "Total Net Fill Quantity"
    description: "The Total Net Fill Quantity (number of units) of the drug's dispensed transaction activity derived from (1) Units Dispensed based on the Fill Task Complete Date, and (2) Units Returned based on the Returned Date."
    type: number
    hidden: yes
    value_format: "#,##0.00;(#,##0.00)"
    sql: ${sum_store_drug_inventory_rx_filled_decrease_quantity} -  ${sum_store_drug_inventory_returned_fill_quantity} ;;
  }

  measure: dispensed_acq_cost {
    label: "Dispensed Acquisition Cost"
    description: "The Total Acquisition Cost of the dispensed drug's transaction activity based on the Total Net Fill Quantity (number of units) x the Drugâ€™s Acquisition Unit Cost."
    type: sum
    hidden: yes
    value_format: "$#,##0.00;($#,##0.00)"
    sql: (NVL(${TABLE}.STORE_DRUG_INVENTORY_RX_FILLED_DECREASE_QUANTITY,0) - NVL(${TABLE}.STORE_DRUG_INVENTORY_RETURNED_FILL_QUANTITY,0) ) * NVL(${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT,0) ;;
  }

  measure: sum_store_drug_inventory_ending_on_hand {
    label: "Ending On Hand"
    description: "Ending On Hand Value for the Drug, for the Activity Date. Use the Activity Range measures instead of the dimension or measure for any reports that consider a date range and grouping by day is not desired."
    type: sum
    hidden:  yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_store_drug_inventory_reorder_primary_level_order_point {
    label: "Store Drug Inventory Reorder Primary Level Order Point"
    description: "Point at which the system should reorder new supplies of this drug. When the on-hand amount minus allocated qty reaches the order point, the system will generate a drug order maintenance record when the Generate Order Records report is run. Example: '9'."
    type: sum
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_INVENTORY_REORDER_PRIMARY_LEVEL_ORDER_POINT ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  ###################################### START - ERXDWPS-8261 ACQ and MVAC measures ######################################

  measure: sum_store_drug_inventory_sold_quantity_acquisition_cost {
    label: "Total Sold Quantity Acquisition Cost"
    description: "Fill Quantity Acquisition Cost of the Drug that was Sold, and not returned on the same day, on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SOLD_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_returned_fill_quantity_acquisition_cost {
    label: "Total Returned Fill Quantity Acquisition Cost"
    description: "Returned Fill Quantity Acquisition Cost of the Drug on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURNED_FILL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_received_quantity_acquisition_cost {
    label: "Total Drug Order Received Quantity Acquisition Cost"
    description: "Acquisition Cost of the drug received."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_acknowledgement_received_quantity_acquisition_cost {
    label: "Total Drug Order Acknowledgement Received Quantity Acquisition Cost"
    description: "Acquisition Cost of the Quantity that the vendor indicated would be shipped on the drug order acknowledgment."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_ACKNOWLEDGEMENT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_quantity_acquisition_cost {
    label: "Total Drug Order Quantity Acquisition Cost"
    description: "Acquisition Cost of the Reorder quantity that corresponds to the Reorder QTY field of the drug's reorder parameters record."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_order_quantity_acquisition_cost {
    label: "Total Drug Order Vendor Order Quantity Acquisition Cost"
    description: "Acquisition Cost of the Quantity that was actually ordered in the 850 with the conversion factor applied."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_acknowledgement_received_quantity_acquisition_cost {
    label: "Total Drug Order Vendor Acknowledgement Received Quantity Acquisition Cost"
    description: "Acquisition Cost of the Quantity that the vendor indicated would be shipped on the drug order acknowledgment before applying the conversion factor to convert back to multiples of the pack size."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ACKNOWLEDGEMENT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_received_quantity_acquisition_cost {
    label: "Total Drug Order Vendor Received Quantity Acquisition Cost"
    description: "Acquisition Cost of the Quantity of the drug received before applying the conversion factor to convert back to multiples of the pack size."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_return_and_adjustment_increase_quantity_acquisition_cost {
    label: "Total Return And Adjustment Increase Quantity Acquisition Cost"
    description: "Total Acquisition Cost of the Positive Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_decrease_quantity_acquisition_cost {
    label: "Total Return And Adjustment Decrease Quantity Acquisition Cost"
    description: "Total Acquisition Cost of the Negative Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_total_quantity_acquisition_cost {
    label: "Total Return And Adjustment Quantity Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_TOTAL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_primary_wholesaler_increase_quantity_acquisition_cost {
    label: "Total Primary Wholesaler Increase Quantity (APW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Primary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_PRIMARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_secondary_wholesaler_increase_quantity_acquisition_cost {
    label: "Total Secondary Wholesaler Increase Quantity (ASW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Secondary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SECONDARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_tertiary_wholesaler_increase_quantity_acquisition_cost {
    label: "Total Tertiary Wholesaler Increase Quantity (ATW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Tertiary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_TERTIARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_decrease_quantity_acquisition_cost {
    label: "Total Correct Prior Adjustment Return Decrease Quantity (CAD) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Correct prior adj ret decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_increase_quantity_acquisition_cost {
    label: "Total Correct Prior Adjustment Return Increase Quantity (CAI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Correct prior adj ret increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_clearing_house_decrease_quantity_acquisition_cost {
    label: "Total Clearing House Decrease Quantity (CLH) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Clearing house decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CLEARING_HOUSE_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_correction_shortage_on_order_decrease_quantity_acquisition_cost {
    label: "Total Correction Shortage On Order Decrease Quantity (COD) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Correction shortage on order decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_SHORTAGE_ON_ORDER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_correction_overage_on_order_increase_quantity_acquisition_cost {
    label: "Total Correction Overage On Order Increase Quantity (COI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Correction - overage on order increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_OVERAGE_ON_ORDER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_direct_from_manufacturer_increase_quantity_acquisition_cost {
    label: "Total Direct From Manufacturer Increase Quantity (DFM) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Direct from manufacturer increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DIRECT_FROM_MANUFACTURER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_destroyed_inventory_spillage_decrease_quantity_acquisition_cost {
    label: "Total Destroyed Inventory Spillage Decrease Quantity (DST) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Destroyed inventory spillage decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DESTROYED_INVENTORY_SPILLAGE_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_overage_on_physical_inventory_increase_quantity_acquisition_cost {
    label: "Total Overage On Physical Inventory Increase Quantity (OVR) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Overage on physical inventory increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_OVERAGE_ON_PHYSICAL_INVENTORY_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_direct_to_manufacturer_decrease_quantity_acquisition_cost {
    label: "Total Return Direct To Manufacturer Decrease Quantity (RMF) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return direct to manufacturer decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_DIRECT_TO_MANUFACTURER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_to_primary_wholesaler_decrease_quantity_acquisition_cost {
    label: "Total Return To Primary Wholesaler Decrease Quantity (RPW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return to primary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_PRIMARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_to_secondary_wholesaler_decrease_quantity_acquisition_cost {
    label: "Total Return To Secondary Wholesaler Decrease Quantity (RSW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return to secondary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_SECONDARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_to_tertiary_wholesaler_decrease_quantity_acquisition_cost {
    label: "Total Return To Tertiary Wholesaler Decrease Quantity (RTW) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return to tertiary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_TERTIARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_shrinkage_from_physical_inventory_decrease_quantity_acquisition_cost {
    label: "Total Shrinkage From Physical Inventory Decrease Quantity (SHK) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Shrinkage from physical inventory decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SHRINKAGE_FROM_PHYSICAL_INVENTORY_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_manual_decrease_of_onhand_amount_quantity_acquisition_cost {
    label: "Total Manual Decrease Of On Hand Amount Quantity (UPD) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Manual decrease of On Hand amount."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_DECREASE_OF_ONHAND_AMOUNT_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_manual_increase_of_onhand_amount_quantity_acquisition_cost {
    label: "Total Manual Increase Of On Hand Amount Quantity (UPI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Manual increase of On Hand amount."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_INCREASE_OF_ONHAND_AMOUNT_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_cycle_count_correction_equal_quantity_acquisition_cost {
    label: "Total Cycle Count Correction Equal Quantity (CCC) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Cycle count correction equal."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CYCLE_COUNT_CORRECTION_EQUAL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_increase_quantity_acquisition_cost {
    label: "Total Return To Stock Increase Quantity (RSI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return to stock increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_stolen_decrease_quantity_acquisition_cost {
    label: "Total Return To Stock Stolen Decrease Quantity (RSD) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Return to stock stolen decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_STOLEN_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_rx_filled_decrease_quantity_acquisition_cost {
    label: "Total Rx Filled Decrease Quantity (RFD) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Rx filled decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_FILLED_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_rx_cancelled_rejected_increase_quantity_acquisition_cost {
    label: "Total Rx Cancelled Rejected Increase Quantity (RCI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Rx cancelled rejected increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_CANCELLED_REJECTED_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_apply_drug_order_inventory_increase_quantity_acquisition_cost {
    label: "Total Apply Drug Order Inventory Increase Quantity (DOI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Apply drug order inventory increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_APPLY_DRUG_ORDER_INVENTORY_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_adjust_negative_on_hand_increase_quantity_acquisition_cost {
    label: "Total Adjust Negative On Hand Increase Quantity (NOI) Acquisition Cost"
    description: "Total Acquisition Cost of the Adjustments for Activity Date for Adjust negative on hand increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ADJUST_NEGATIVE_ON_HAND_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT ;;
  }

  measure: sum_store_drug_inventory_sold_quantity_moving_average_cost {
    label: "Total Sold Quantity Moving Average Cost"
    description: "Fill Quantity Moving Average Cost (MVAC) of the Drug that was Sold, and not returned on the same day, on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SOLD_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_returned_fill_quantity_moving_average_cost {
    label: "Total Returned Fill Quantity Moving Average Cost"
    description: "Returned Fill Quantity Moving Average Cost (MVAC) of the Drug on the Activity Date."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURNED_FILL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_received_quantity_moving_average_cost {
    label: "Total Drug Order Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the drug received."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_acknowledgement_received_quantity_moving_average_cost {
    label: "Total Drug Order Acknowledgement Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Quantity that the vendor indicated would be shipped on the drug order acknowledgment."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_ACKNOWLEDGEMENT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_quantity_moving_average_cost {
    label: "Total Drug Order Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Reorder quantity that corresponds to the Reorder QTY field of the drug's reorder parameters record."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_order_quantity_moving_average_cost {
    label: "Total Drug Order Vendor Order Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Quantity that was actually ordered in the 850 with the conversion factor applied."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ORDER_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_acknowledgement_received_quantity_moving_average_cost {
    label: "Total Drug Order Vendor Acknowledgement Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Quantity that the vendor indicated would be shipped on the drug order acknowledgment before applying the conversion factor to convert back to multiples of the pack size."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_ACKNOWLEDGEMENT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_drug_order_vendor_received_quantity_moving_average_cost {
    label: "Total Drug Order Vendor Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Quantity of the drug received before applying the conversion factor to convert back to multiples of the pack size."
    type: sum
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DRUG_ORDER_VENDOR_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_inventory_return_and_adjustment_increase_quantity_moving_average_cost {
    label: "Total Return And Adjustment Increase Quantity Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Positive Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_decrease_quantity_moving_average_cost {
    label: "Total Return And Adjustment Decrease Quantity Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Negative Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_and_adjustment_total_quantity_moving_average_cost {
    label: "Total Return And Adjustment Quantity Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_AND_ADJUSTMENT_TOTAL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_primary_wholesaler_increase_quantity_moving_average_cost {
    label: "Total Primary Wholesaler Increase Quantity (APW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Primary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_PRIMARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_secondary_wholesaler_increase_quantity_moving_average_cost {
    label: "Total Secondary Wholesaler Increase Quantity (ASW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Secondary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SECONDARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_tertiary_wholesaler_increase_quantity_moving_average_cost {
    label: "Total Tertiary Wholesaler Increase Quantity (ATW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Tertiary Wholesaler."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_TERTIARY_WHOLESALER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_decrease_quantity_moving_average_cost {
    label: "Total Correct Prior Adjustment Return Decrease Quantity (CAD) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Correct prior adj ret decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_correct_prior_adjustment_return_increase_quantity_moving_average_cost {
    label: "Total Correct Prior Adjustment Return Increase Quantity (CAI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Correct prior adj ret increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECT_PRIOR_ADJUSTMENT_RETURN_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_clearing_house_decrease_quantity_moving_average_cost {
    label: "Total Clearing House Decrease Quantity (CLH) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Clearing house decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CLEARING_HOUSE_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_correction_shortage_on_order_decrease_quantity_moving_average_cost {
    label: "Total Correction Shortage On Order Decrease Quantity (COD) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Correction shortage on order decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_SHORTAGE_ON_ORDER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_correction_overage_on_order_increase_quantity_moving_average_cost {
    label: "Total Correction Overage On Order Increase Quantity (COI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Correction - overage on order increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CORRECTION_OVERAGE_ON_ORDER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_direct_from_manufacturer_increase_quantity_moving_average_cost {
    label: "Total Direct From Manufacturer Increase Quantity (DFM) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Direct from manufacturer increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DIRECT_FROM_MANUFACTURER_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_destroyed_inventory_spillage_decrease_quantity_moving_average_cost {
    label: "Total Destroyed Inventory Spillage Decrease Quantity (DST) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Destroyed inventory spillage decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_DESTROYED_INVENTORY_SPILLAGE_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_overage_on_physical_inventory_increase_quantity_moving_average_cost {
    label: "Total Overage On Physical Inventory Increase Quantity (OVR) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Overage on physical inventory increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_OVERAGE_ON_PHYSICAL_INVENTORY_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_direct_to_manufacturer_decrease_quantity_moving_average_cost {
    label: "Total Return Direct To Manufacturer Decrease Quantity (RMF) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return direct to manufacturer decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_DIRECT_TO_MANUFACTURER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_to_primary_wholesaler_decrease_quantity_moving_average_cost {
    label: "Total Return To Primary Wholesaler Decrease Quantity (RPW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return to primary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_PRIMARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_to_secondary_wholesaler_decrease_quantity_moving_average_cost {
    label: "Total Return To Secondary Wholesaler Decrease Quantity (RSW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return to secondary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_SECONDARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_to_tertiary_wholesaler_decrease_quantity_moving_average_cost {
    label: "Total Return To Tertiary Wholesaler Decrease Quantity (RTW) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return to tertiary wholesaler decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_TERTIARY_WHOLESALER_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_shrinkage_from_physical_inventory_decrease_quantity_moving_average_cost {
    label: "Total Shrinkage From Physical Inventory Decrease Quantity (SHK) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Shrinkage from physical inventory decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_SHRINKAGE_FROM_PHYSICAL_INVENTORY_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_manual_decrease_of_onhand_amount_quantity_moving_average_cost {
    label: "Total Manual Decrease Of On Hand Amount Quantity (UPD) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Manual decrease of On Hand amount."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_DECREASE_OF_ONHAND_AMOUNT_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_manual_increase_of_onhand_amount_quantity_moving_average_cost {
    label: "Total Manual Increase Of On Hand Amount Quantity (UPI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Manual increase of On Hand amount."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_MANUAL_INCREASE_OF_ONHAND_AMOUNT_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_cycle_count_correction_equal_quantity_moving_average_cost {
    label: "Total Cycle Count Correction Equal Quantity (CCC) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Cycle count correction equal."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_CYCLE_COUNT_CORRECTION_EQUAL_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_increase_quantity_moving_average_cost {
    label: "Total Return To Stock Increase Quantity (RSI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return to stock increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_return_to_stock_stolen_decrease_quantity_moving_average_cost {
    label: "Total Return To Stock Stolen Decrease Quantity (RSD) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Return to stock stolen decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RETURN_TO_STOCK_STOLEN_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_rx_filled_decrease_quantity_moving_average_cost {
    label: "Total Rx Filled Decrease Quantity (RFD) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Rx filled decrease."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_FILLED_DECREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_rx_cancelled_rejected_increase_quantity_moving_average_cost {
    label: "Total Rx Cancelled Rejected Increase Quantity (RCI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Rx cancelled rejected increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_RX_CANCELLED_REJECTED_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_apply_drug_order_inventory_increase_quantity_moving_average_cost {
    label: "Total Apply Drug Order Inventory Increase Quantity (DOI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Apply drug order inventory increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_APPLY_DRUG_ORDER_INVENTORY_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  measure: sum_store_drug_inventory_adjust_negative_on_hand_increase_quantity_moving_average_cost {
    label: "Total Adjust Negative On Hand Increase Quantity (NOI) Moving Average Cost"
    description: "Total Moving Average Cost (MVAC) of the Adjustments for Activity Date for Adjust negative on hand increase."
    type: sum
    value_format: "$#,##0.00;($#,##0.00)"
    sql: ${TABLE}.STORE_DRUG_INVENTORY_ADJUST_NEGATIVE_ON_HAND_INCREASE_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT ;;
  }

  ###################################### END - ERXDWPS-8261 ACQ and MVAC measures ######################################

################################### Activity Range Measures ###################################

  dimension: min_activity_date {
    group_label: "Activity Range Measures"
    hidden: yes
    sql:  {% date_start turnrx_store_drug_inventory_mvmnt_snapshot.activity_date %} ;;
    type: string
  }

  dimension: max_activity_date {
    group_label: "Activity Range Measures"
    hidden: yes
    sql:  least(least(dateadd(day, -1, {% date_end turnrx_store_drug_inventory_mvmnt_snapshot.activity_date %}), current_date()), dateadd(day, -1, current_date())) ;;
    # Need to set max_activity_date for "past ... days" and "past ... complete days" correctly. We want to make sure that the date range ends on (current_date - 1).
    # This is because when the job runs on current_date, it populates data with activity_date as (current_date - 1).
    type: string
  }

  dimension: activity_date_range {
    label: "Activity Date Range"
    description: "An inclusive date range, the start and end date, of the Activity Date Range selected. Note: Inventory snapshots occur at the end of the day. Reports executed with Activity Date Ranges up to and including the current date will display an Activity Date Range ending on the previous day, which is the latest captured Inventory snapshot."
    sql:  to_char(${min_activity_date}, 'mm-dd-yyyy') || ' to ' || to_char(${max_activity_date}, 'mm-dd-yyyy') ;;
    type: string
    can_filter: no
  }

  #[ERXDWPS-6988][TRX-5281]
  dimension: week_end_activity_date {
    label: "Week End Activity Date"
    description: "End date of the Activity Week when the report is at the week grain."
    hidden: yes
    sql:  dateadd('day',-1,last_day(to_date( dateadd('day',1,${activity_week})), 'week')) ;;
    type: string
  }

  #[ERXDWPS-6988][TRX-5281]
  measure: week_ending_inventory_value {
    label: "Week Ending Inventory Value"
    description: "Inventory Value for the Drug, for the last day of the Activity Week. For accurate resuls this measure should be used only with the week grain."
    type: sum
    hidden: yes
    sql: case when ${week_end_activity_date} = ${TABLE}.activity_date then NVL(${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND, 0) * NVL(${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT, 0) ELSE 0 end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_beginning_on_hand_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Beginning On Hand Quantity"
    description: "Beginning On Hand Value for Activity Date Range, which is the Ending On Hand Value from Previous Activity Date."
    type: sum
    sql: case when ${min_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_calculated_ending_on_hand_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Calculated Ending On Hand Quantity"
    description: "Calculated Ending On Hand for Activity Date Range based on Starting On Hand, Quantities committed and un-committed, and adjustments."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_calculated_ending_on_hand_variance_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Calculated Ending On Hand Variance"
    description: "Variance from the database ending on hand to the calculated ending on hand."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND_VARIANCE end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_drug_ordered_not_received_quantity_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Drug Ordered Not Received Quantity"
    description: "Sum of Quantity where Purchase Orders are still open and have not been closed/applied to inventory."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_quantity_committed_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Quantity Committed"
    description: "Cumulative aggregate of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  #[ERXDWPS-8164] New measure store_drug_inventory_ending_on_hand_acquisition_cost_activity_range created as part of ERXDWPS-8261 replaced this measure..
  #measure: store_drug_inventory_drug_local_setting_acquisition_cost_activity_range {
  #  group_label: "Activity Range Measures"
  #  label: "Activity Range Ending On Hand Acquisition Cost"
  #  description: "True acquisition cost per pack for the stock that you have on the shelf."
  #  type: sum
  #  sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_ACQUISITION_COST end;;
  #  value_format: "$#,##0.00;($#,##0.00)"
  #}

  measure: store_drug_inventory_drug_local_setting_quantity_allocated_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending Allocated Quantity"
    description: "Amount of the drug that has been allocated by Data Entry."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_drug_unique_allocated_quantity_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending Central Fill Allocated Quantity"
    description: "Central Fill ONLY, drug's allocated quantity."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_DRUG_UNIQUE_ALLOCATED_QUANTITY end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_ending_on_hand_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending On Hand Quantity"
    description: "Ending On Hand Value for the Drug, for the Activity Date."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND end;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_expected_quantity_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Expected Quantity"
    description: "Expected Quantity On Hand Value for the Drug, for the Activity Date."
    type: number
    sql: nvl(${store_drug_inventory_beginning_on_hand_activity_range}, 0) + ${sum_store_drug_inventory_drug_order_received_quantity} - ${sum_store_drug_inventory_rx_filled_decrease_quantity} ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: store_drug_inventory_manual_and_expected_quantity_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Expected Quantity +/- Manual Adjustments"
    description: "Expected Quantity +/- Manual Adjustments for Activity Date."
    type: number
    sql: ${store_drug_inventory_expected_quantity_activity_range} + ${sum_store_drug_inventory_return_and_adjustment_total_quantity} ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  ###################################### START - ERXDWPS-8261 ACQ and MVAC Activity Range measures ######################################

  measure: store_drug_inventory_beginning_on_hand_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Beginning On Hand Quantity Acquisition Cost"
    description: "Beginning On Hand Acquisition Cost for Activity Date Range."
    type: sum
    sql: case when ${min_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_calculated_ending_on_hand_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Calculated Ending On Hand Quantity Acquisition Cost"
    description: "Calculated Ending On Hand Acquisition Cost for Activity Date Range based on Starting On Hand, Quantities committed and un-committed, and adjustments."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_drug_ordered_not_received_quantity_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Drug Ordered Not Received Quantity Acquisition Cost"
    description: "Acquisition Cost of the Quantity where Purchase Orders are still open and have not been closed/applied to inventory."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_quantity_committed_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Quantity Committed Acquisition Cost"
    description: "Acquisition Cost of the Cumulative aggregate of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_drug_local_setting_quantity_allocated_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending Allocated Quantity Acquisition Cost"
    description: "Acquisition Cost of the drug that has been allocated by Data Entry."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_ending_on_hand_acquisition_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending On Hand Acquisition Cost"
    description: "Ending On Hand Acquisition Cost for the Drug, for the Activity Date Range."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_ACQUISTION_UNIT_COST_AMOUNT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_beginning_on_hand_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Beginning On Hand Quantity Moving Average Cost"
    description: "Beginning On Hand Moving Average Cost (MVAC) for Activity Date Range."
    type: sum
    sql: case when ${min_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_BEGINNING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_calculated_ending_on_hand_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Calculated Ending On Hand Quantity Moving Average Cost"
    description: "Calculated Ending On Hand Moving Average Cost (MVAC) for Activity Date Range based on Starting On Hand, Quantities committed and un-committed, and adjustments."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CALCULATED_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_drug_ordered_not_received_quantity_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Drug Ordered Not Received Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Quantity where Purchase Orders are still open and have not been closed/applied to inventory."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_DRUG_ORDERED_NOT_RECEIVED_QUANTITY * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_cumulative_quantity_committed_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Cumulative Quantity Committed Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the Cumulative aggregate of the Sum of Quantity that is Filled but not Sold, and not returned / cancelled / returned to stock, on the reported date."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_CUMULATIVE_QUANTITY_COMMITTED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_drug_local_setting_quantity_allocated_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending Allocated Quantity Moving Average Cost"
    description: "Moving Average Cost (MVAC) of the drug that has been allocated by Data Entry."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: store_drug_inventory_ending_on_hand_moving_average_cost_activity_range {
    group_label: "Activity Range Measures"
    label: "Activity Range Ending On Hand Moving Average Cost"
    description: "Ending On Hand Moving Average Cost (MVAC) for the Drug, for the Activity Date Range."
    type: sum
    sql: case when ${max_activity_date} = ${TABLE}.activity_date then ${TABLE}.STORE_DRUG_INVENTORY_ENDING_ON_HAND * ${TABLE}.STORE_DRUG_INVENTORY_MOVING_AVERAGE_COST_PER_UNIT end;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ###################################### End - ERXDWPS-8261 ACQ and MVAC Activity Range measures ######################################

################################### End Activity Range Measures ###################################
}

view: store_drug_reorder {
  sql_table_name: EDW.D_DRUG_REORDER ;;

  dimension: drug_reorder_id {
    type: number
    hidden: yes
    label: "Drug Reorder ID"
    sql: ${TABLE}.DRUG_REORDER_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_reorder_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Drug Reorder Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Drug Reorder NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: drug_id {
    type: number
    hidden: yes
    label: "Drug Reorder Drug ID"
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: vendor_id {
    type: number
    hidden: yes
    label: "Drug Reorder Vendor ID"
    sql: ${TABLE}.VENDOR_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################
  dimension: drug_reorder_level_number {
    type: number
    label: "Drug Reorder Level Number"
    description: "Represents the Vendor level of the drug's reorder record. This acts as a priority"
    sql: ${TABLE}.DRUG_REORDER_LEVEL_NUMBER ;;
  }

  dimension: drug_reorder_item_number {
    type: string
    label: "Drug Reorder Item Number"
    description: "Supplier's order number for this drug"
    sql: ${TABLE}.DRUG_REORDER_ITEM_NUMBER ;;
  }

  dimension: drug_reorder_category {
    type: string
    label: "Drug Reorder Category"
    description: "Represents the Drug Reorder Category"
    sql: ${TABLE}.DRUG_REORDER_CATEGORY ;;
  }

  dimension: drug_reorder_cycle_time_in_days {
    type: number
    label: "Drug Reorder Cycle Time (In Days)"
    description: "Represents the number of days between orders"
    sql: ${TABLE}.DRUG_REORDER_CYCLE_TIME_IN_DAYS ;;
  }

  dimension: drug_reorder_lead_time_in_days {
    type: number
    label: "Drug Reorder Lead Time (In Days)"
    description: "The usual amount of time it takes to receive product once it has been ordered"
    sql: ${TABLE}.DRUG_REORDER_LEAD_TIME_IN_DAYS ;;
  }

  dimension: drug_reorder_group_code {
    type: string
    label: "Drug Reorder Group Code"
    description: "Represents the drug reorder group for the drug's reorder record"
    sql: ${TABLE}.DRUG_REORDER_GROUP_CODE ;;
  }

  dimension: drug_reorder_shipping_method {
    type: string
    label: "Drug Reorder Shipping Method"
    description: "Represents the method of delivery for this drug from this vendor when receiving an order"
    sql: ${TABLE}.DRUG_REORDER_SHIPPING_METHOD ;;
  }

  dimension: drug_reorder_sub_group {
    type: string
    label: "Drug Reorder Sub Group"
    description: "Represents the Sub-group code for the drug reorder record"
    sql: ${TABLE}.DRUG_REORDER_SUB_GROUP ;;
  }

  dimension: drug_reorder_warehouse_region {
    type: number
    label: "Drug Reorder Warehouse Region" #ERXLPS-6114
    description: "Represents the region this drug would be sourced from, from the warehouse"
    sql: ${TABLE}.DRUG_REORDER_WAREHOUSE_REGION ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Drug Reorder Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug reorder was deleted from the source system"
    sql: ${TABLE}.DRUG_REORDER_DELETED ;;
  }

  dimension: drug_reorder_conversion_factor {
    type: number
    label: "Drug Reorder Conversion Factor"
    description: "The number the system uses to convert the ordered quantity to the quantity reported that is sent to the supplier in the Drug Order List.  To determine the number of reorder units, the system first divides the reorder quantity by the pack size. Then, it divides the result by the conversion factor. The system reports the result on the Drug Order List report.  For example, you price and order Ortho-Novum 10/11 21 based a package size of 21 units. Your reorder quantity for 12 packs of this drug is 252 units (or two boxes of six packs each). For the wholesaler that supplies this drug, you need to report the reorder quantity in boxes instead of units. Therefore, enter 6 as your conversion factor.  The system takes the reorder quantity (252) and divides it by the package size (21). It then takes the result (12) and divides it by the conversion factor (6). On the drug order list, the system reports 2 (boxes) as the reorder quantity."
    sql: ${TABLE}.DRUG_REORDER_CONVERSION_FACTOR ;;
    value_format: "###0.0000"
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: drug_reorder_discontinue {
    label: "Drug Reorder Discontinue"
    description: "Date the system uses to determine when to generate an order for this drug.  The system will not generate an order for this drug after this date, even if the drug's on-hand quantity falls below the reorder point quantity"
    type: time
    sql: ${TABLE}.DRUG_REORDER_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_reorder_hold_until {
    label: "Drug Reorder Hold Until"
    description: "Date the system uses to determine when to generate an order for this drug.  The system will not generate an order for this drug until this date, even if the drug's on-hand quantity falls below the reorder point quantity"
    type: time
    sql: ${TABLE}.DRUG_REORDER_HOLD_UNTIL_DATE ;;
  }

  dimension_group: drug_reorder_last_order {
    label: "Drug Reorder Last Order"
    description: "Date this drug was last ordered from the Vendor"
    type: time
    sql: ${TABLE}.DRUG_REORDER_LAST_ORDER_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: drug_reorder_no_substitutions {
    label: "Drug Reorder No Substituions"
    description: "Yes/No Flag indicating whether the system automatically receives or applies any substitutions for this drug"
    type: yesno
    sql: ${TABLE}.DRUG_REORDER_NO_SUBSTITUTIONS = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: drug_reorder_unit {
    type: string
    label: "Drug Reorder Unit"
    description: "Unit/Basis of measurement for the order quantity that the system transmits during an electronic drug order"

    case: {
      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'BO' ;;
        label: "BOTTLE"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'BX' ;;
        label: "BOX"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'CA' ;;
        label: "CASE"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'CH' ;;
        label: "CONTAINER"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'CT' ;;
        label: "CARTON"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'DE' ;;
        label: "DEAL"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'DZ' ;;
        label: "DOZEN"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'EA' ;;
        label: "EACH"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'GS' ;;
        label: "GROSS"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_UNIT = 'PK' ;;
        label: "PACKAGE"
      }
    }
  }

  dimension: drug_reorder_product_number {
    type: string
    label: "Drug Reorder Product Number"
    description: "Specifies to the supplier what the item number (from the Item # field), which is transmitted during electronic drug ordering, represents"

    case: {
      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'IN' ;;
        label: "BUYER'S ITEM NUMBER"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'N1' ;;
        label: "NDC (4-4-2) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'N2' ;;
        label: "NDC (5-3-2) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'N3' ;;
        label: "NDC (5-4-1) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'N4' ;;
        label: "NDC (5-4-2) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'ND' ;;
        label: "NDC (VER 2.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'NH' ;;
        label: "NATIONAL HEATH RELATED ITEM CODE"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'SV' ;;
        label: "SERVICE RENDERED"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UA' ;;
        label: "UPC/EAN CASE CODE (1-4-6-1)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UG' ;;
        label: "DRUG UPC CONSUMER PACKAGE CODE (1-4-6-1) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UH' ;;
        label: "DRUG UPC SHIPPING CONTAINER CODE (1-2-4-6-1) (VER 3.0)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UI' ;;
        label: "UPC CONSUMER PACKAGE CODE (1-5-5)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UN' ;;
        label: "UPC CASE CODE NUMBER (1-1-5-5)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'UP' ;;
        label: "UPC CONSUMER PACKAGE CODE (1-5-5-1)"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER = 'VN' ;;
        label: "VENDOR'S ITEM NUMBER"
      }

      when: {
        sql: ${TABLE}.DRUG_REORDER_PRODUCT_NUMBER IS NULL ;;
        label: "VENDOR'S DEFAULT"
      }
    }
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################
  measure: count {
    label: "Total Drug Reorders"
    description: "Total number of reorders of the drug"
    type: count
    value_format: "#,##0"
  }

  measure: sum_drug_reorder_minimum_quantity {
    type: sum
    label: "Total Drug Reorder Minimum Quantity"
    description: "The on-hand amount needed after filling the order.  The system uses this quantity during the Generate Order Records function and orders the quantity of the drug that brings the on-hand quantity equal to or greater than this value"
    sql: ${TABLE}.DRUG_REORDER_MINIMUM_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_reorder_order_quantity {
    type: sum
    label: "Total Drug Reorder Order Quantity"
    description: "The quantity to reorder when the drug reaches the reorder point.  The system uses a multiple of this quantity to generate drug order maintenance records that brings the on-hand quantity equal to or greater than the Up To quantity. If the quantity is not evenly divisible by the number in the Pack field, the EPS client system does not let you add or update a drug order record"
    sql: ${TABLE}.DRUG_REORDER_ORDER_QUANTITY ;;
    value_format: "###0.0000"
  }

  measure: sum_drug_reorder_order_point {
    type: sum
    label: "Total Drug Reorder Order Point"
    description: "Point at which the system should reorder new supplies of this drug.  When the on-hand amount minus allocated qty reaches the order point, the system will generate a drug order maintenance record when the Generate Order Records report is run"
    sql: ${TABLE}.DRUG_REORDER_ORDER_POINT ;;
    value_format: "###0.0000"
  }
}

####################################################################################################### End of Measures #################################################################################################################

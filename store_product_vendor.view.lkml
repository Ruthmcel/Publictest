view: store_product_vendor {
  sql_table_name: EDW.D_STORE_PRODUCT_VENDOR ;;

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

  dimension: product_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PRODUCT_ID ;;
  }

  dimension: store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.STORE_ID ;;
  }

  dimension: vendor_id {
    hidden: yes
    type: number
    sql: ${TABLE}.VENDOR_ID ;;
  }

  dimension: product_name {
    type: string
    label: "Pharmacy Product Name"
    description: "Unique Identification name assinged to a product by NHIN"
    sql: ${TABLE}.PRODUCT_NAME ;;
  }

  dimension: vendor_name {
    type: string
    label: "Vendor Name"
    description: "Unique Identification name assinged to a vendor by NHIN"
    sql: ${TABLE}.VENDOR_NAME ;;
  }

  dimension: store_product_vendor_deleted {
    label: "Store Product Vendor Deleted"
    type: string
    description: "Unique Identification name assinged to a vendor by NHIN"
    sql: NVL(${TABLE}.STORE_PRODUCT_VENDOR_DELETED,'N') ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: count {
    type: count_distinct
    # Including only chain, store and products to avoid duplicates while determining total stores registered under a product b/c MTM products is tied to multiple vendors: MIRIXA, OUTCOMES
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${product_name} ;; #ERXLPS-1649
    drill_fields: [chain_id, nhin_store_id]
  }
}

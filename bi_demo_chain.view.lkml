view: bi_demo_chain {
  sql_table_name: REPORT_TEMP.BI_DEMO_CHAIN_MAPPING ;;
  # 03112016 - KR - This View is specificall used for BI Demo"
  # 03112016 - KR - All explore view in "CUSTOMER_DEMO" model will use chain_id to join to other transaction & child tables but bi_demo_chain_id will only be exposed for the demo customer model
  # 03112016 - KR - All mapping information is handled under REPORT_TEMP.BI_DEMO_CHAIN_MAPPING and only those chains residing in this table will be exposed due to inner join"

  dimension: bi_demo_chain_id {
    label: "Chain Id"
    description: "BI Demo Chain"
    primary_key: yes
    type: number
    sql: ${TABLE}.CHAIN_ID_BI_DEMO_MAPPING ;;
  }

  dimension: chain_id {
    hidden: yes
    description: "Identification number assinged to each customer chain by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: chain_name {
    description: "Name of the Chain"
    sql: 'BI DEMO CHAIN' ;;
    drill_fields: [bi_demo_region.division, bi_demo_region.region, bi_demo_region.district, bi_demo_store.store_number, bi_demo_store.store_name]
  }

  measure: count {
    label: "Chain Count"
    type: count
    value_format: "#,##0"
  }
}

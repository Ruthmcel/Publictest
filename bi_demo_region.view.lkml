view: bi_demo_region {
  sql_table_name: REPORT_TEMP.BI_DEMO_REGION_MAPPING ;;
  # 03222016 - KR - This View is specificall used for BI Demo"
  dimension: division {
    label: "Pharmacy Division (Central)"
    description: "BI Demo Division"
    primary_key: yes
    sql: ${TABLE}.DIVISION ;;
    drill_fields: [region, district, bi_demo_store.store_number]
  }

  dimension: region {
    label: "Pharmacy Region (Central)"
    description: "BI Demo Region"
    sql: ${TABLE}.REGION ;;
    drill_fields: [district, bi_demo_store.store_number]
  }

  dimension: district {
    type: number
    label: "Pharmacy District (Central)"
    description: "BI Demo District"
    sql: ${TABLE}.DISTRICT ;;
    drill_fields: [bi_demo_store.store_number]
  }

  dimension: store_state {
    hidden: yes
    label: "Pharmacy State (Central)"
    description: "BI Demo Store"
    sql: ${TABLE}.STORE_STATE ;;
  }
}

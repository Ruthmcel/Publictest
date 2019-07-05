view: mds_sponsor {
  sql_table_name: EDW.D_SPONSOR ;;

  dimension: sponsor_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.SPONSOR_ID ;;
  }

  dimension: sponsor_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}.SPONSOR_DELETED ;;
  }

  dimension: vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.VENDOR_ID ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: sponsor_lcr_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SPONSOR_LCR_ID ;;
  }

  dimension: sponsor_type_reference {
    type: string
    hidden: yes
    sql: ${TABLE}.SPONSOR_TYPE ;;
  }

  dimension: sponsor_type {
    label: "Sponsor Type"
    description: "Indicates the type of Sponsor."
    type: string
    sql: CASE WHEN ${TABLE}.SPONSOR_TYPE = 'V' THEN 'V - VENDOR'
              WHEN ${TABLE}.SPONSOR_TYPE = 'C' THEN 'C - CHAIN'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["V - VENDOR", "C - CHAIN"]
    suggest_persist_for: "24 hours"
    drill_fields: [sponsor_type_reference]
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

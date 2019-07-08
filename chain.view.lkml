view: chain {
  sql_table_name: EDW.D_CHAIN ;;

  dimension: chain_id {
    type: number
    description: "Identification number assigned to each customer chain by NHIN"
    primary_key: yes
    label: "Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: fiscal_chain_id {
    type: number
    description: "Identification number assigned to each customer chain by NHIN"
#     primary_key: yes
    hidden:  yes
    label: "Chain ID"
    sql: ${chain_id} ;;
  }

  dimension: chain_name {
    type: string
    description: "Name of the Chain"
    sql: ${TABLE}.CHAIN_NAME ;;
    drill_fields: [store_alignment.division, store_alignment.region, store_alignment.district, store.store_number]
  }

  dimension: master_chain_name {
    type: string
    description: "Master Chain used to group chain under a single bucket and useful especially during merges or acquisitions"
    sql: CASE WHEN ${chain_id} IN (168,205,439) THEN 'ALBERTSONS' ELSE ${chain_name} END ;;
    drill_fields: [store_alignment.division, store_alignment.region, store_alignment.district, store.store_number]
  }

  dimension: chain_category {
    description: "Displays Speciality (Avella Only) or Retail Pharmacy"

    case: {
      when: {
        sql: ${chain_id} = 478 ;;
        label: "Speciality"
      }

      else: "Retail"
    }
  }

  dimension: chain_headquarters_identifier {
    description: "HQ ID of the chain assigned by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_HEADQUARTERS_IDENTIFIER ;;
  }

  dimension: chain_deactivated_date {
    description: "The date/time that the chain was deactivated"
    sql: ${TABLE}.CHAIN_DEACTIVATED_DATE ;;
  }

  dimension: chain_open_or_closed {
    description: "Flag that indicates if a chain is open or closed. All closed chains will hold a deactivated date"

    case: {
      when: {
        sql: ${TABLE}.CHAIN_DEACTIVATED_DATE IS NULL ;;
        label: "Open"
      }

      #${TABLE}.DEACTIVATED_DATE IS NOT NULL
      when: {
        sql: true ;;
        label: "Closed"
      }
    }

    alpha_sort: no
  }

  # used for joining with stores table from ARS
  dimension: id {
    hidden: yes
    sql: ${TABLE}.CHAIN_SRC_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: count {
    label: "Chain Count"
    description: "Total chains"
    type: count
    value_format: "#,##0"
  }

  filter: chain_filter {
    type: number
    hidden:  yes
    sql:  ${chain_id} ;;
  }
}

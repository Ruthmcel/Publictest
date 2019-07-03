view: ars_chain_cs {
  label: "Pharmacy"
  sql_table_name: ARS.CHAINS ;;

  dimension: chain_id {
    type: number
    primary_key: yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN"
    sql: CAST(${TABLE}.NHINID AS NUMBER) ;;
    full_suggestions: yes
  }

  dimension: chain_name {
    type: string
    description: "Name of the Chain"
    sql: UPPER(REPLACE(${TABLE}.NAME,'CLOSED','')) ;;
    full_suggestions: yes
  }

  dimension: chain_headquarters_identifier {
    description: "HQ ID of the chain assigned by NHIN"
    hidden: yes
    sql: ${TABLE}.HQ_ID ;;
  }

  dimension: chain_deactivated_date {
    description: "The date/time that the chain was deactivated"
    sql: ${TABLE}.DEACTIVATED_DATE ;;
  }

  dimension: chain_open_or_closed {
    type: string
    description: "Flag that indicates if a chain is open or closed. All closed chains will hold a deactivated date"

    case: {
      when: {
        sql: ${TABLE}.DEACTIVATED_DATE IS NULL ;;
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
    sql: ${TABLE}.ID ;;
  }

  measure: count {
    label: "Chain Count"
    type: count
    value_format: "#,##0"
  }
}

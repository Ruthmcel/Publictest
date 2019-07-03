view: ar_processor {
  sql_table_name: REPORT_TEMP.D_PROCESSOR ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${processor_id} ;;
  }

  dimension: processor_id {
    label: "Payer Code"
    description: "Absolute AR code representing the payer"
    type: string
    sql: ${TABLE}."PROCESSOR_ID" ;;
  }

  dimension: processor_name {
    label:  "Payer Name"
    description: "The name of the Payer"
    type: string
    sql: ${TABLE}."PROCESSOR_NAME" ;;
  }

  measure: count {
    label:  "Total Payers"
    description: "The count of total payers"
    type: count
    drill_fields: [processor_name]
  }
}

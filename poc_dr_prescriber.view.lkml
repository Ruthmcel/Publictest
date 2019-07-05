view: poc_dr_prescriber {
  sql_table_name: EDW.DR_PRESCIRBER_SALES_PREDICTION ;;

  dimension: file_row_id {
    type: number
    description: "Unique identifier of a record with in a prediction file"
    label: "File Row ID"
    sql: ${TABLE}.FILE_ROW_ID ;;
  }

  dimension: primary_key {
    type: string
    description: "Unique identifier of a record"
    hidden: yes
    primary_key: yes
    sql: ${prescriber_npi_number}||'@'||${prescriber_dea_number}||'@'||${prescriber_first_name}||'@'||${prescriber_last_name} ;;
  }

  dimension: prescriber_npi_number {
    type: string
    description: "Prescriber NPI Number"
    label: "Prescriber NPI Number"
    sql: ${TABLE}.PRESCRIBER_NPI_NUMBER ;;
  }

  dimension: prescriber_dea_number {
    type: string
    description: "Prescriber DEA Number"
    label: "Prescriber DEA Number"
    sql: ${TABLE}.PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: prescriber_first_name {
    type: string
    description: "Prescriber First Name"
    label: "Prescriber First Name"
    sql: ${TABLE}.PRESCRIBER_FIRST_NAME ;;
  }

  dimension: prescriber_last_name {
    type: string
    description: "Prescriber Last Name"
    label: "Prescriber Last Name"
    sql: ${TABLE}.PRESCRIBER_LAST_NAME ;;
  }

  measure: sum_prescriber_predicted_yearly_sales {
    type: sum
    description: "Prescriber Predicted Yearly Sales"
    label: "Prescriber Predicted Yearly Sales"
    sql: ${TABLE}.PRESCRIBER_PREDICTED_YEARLY_SALES ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: source_timestamp {
    type: time
    hidden: yes
    description: "EDW Insert Time"
    label: "EDW Insert Times"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }
}

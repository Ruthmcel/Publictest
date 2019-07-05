view: poc_dr_drug {
  sql_table_name: EDW.DR_DRUG_PRICE_CHANGE_PREDICTION ;;

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
    sql: ${drug_ndc}||'@'||${drug_pack_size}||'@'||${drug_change_month} ;;
  }

  dimension: drug_ndc {
    type: string
    description: "Drug NDC"
    label: "Drug NDC"
    sql: ${TABLE}.DRUG_NDC ;;
  }

  dimension: drug_name {
    type: string
    description: "Drug Name"
    label: "Drug Name"
    sql: ${TABLE}.DRUG_NAME ;;
  }

  dimension: drug_change_month {
    type: string
    description: "Drug Change Month. Ex:'2018-01'"
    label: "Drug Change Month"
    sql: TO_CHAR(${TABLE}.DRUG_CHANGE_MONTH,'YYYY-MM') ;;
  }

  dimension: drug_pack_size {
    type: number
    description: "Drug Pack Size"
    label: "Drug Pack Size"
    sql: ${TABLE}.DRUG_PACK_SIZE ;;
  }

  measure: drug_predicted_price_change {
    type: sum
    description: "Drug predicted price change"
    label: "Drug Predicted Price Change"
    sql: ${TABLE}.DRUG_PREDICTED_PRICE_CHANGE ;;
    value_format: "00.00%"
  }

  measure: avg_drug_predicted_price_change {
    type: average
    description: "Avg Drug predicted price change"
    label: "Avg Drug Predicted Price Change"
    sql: ${TABLE}.DRUG_PREDICTED_PRICE_CHANGE ;;
    value_format: "00.00%"
  }
}

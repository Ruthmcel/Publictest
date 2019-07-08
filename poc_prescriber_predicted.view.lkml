view: poc_prescriber_predicted {

   sql_table_name: PUBLIC.PRESCRIBER_LFTV_PREDICTED ;;

    dimension: unique_prescriber_identifier {
    #hidden: yes
    label: "Prescriber ID"
    type: string
    sql: ${TABLE}.PRESCRIBER_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${unique_prescriber_identifier}  ;;
  }

  dimension: sales_quarter {
    #hidden: yes
    label: "Sales Quarter"
    type: string
    sql: ${TABLE}.SALES_QUARTER ;;
  }

  dimension: primary_clinic_count {
    label: "Prescriber Primary Clinic Count"
    type: number
    sql: ${TABLE}.PRIMARY_CLINIC_COUNT ;;
  }

  dimension: stores_count {
    label: "Prescriber stores Count"
    type: number
    sql: ${TABLE}.STORES_COUNT ;;
  }

  dimension: clinic_count {
    label: "Prescriber Clinic Count"
    type: number
    sql: ${TABLE}.CLINIC_COUNT ;;
  }

  dimension: Presc_net_sales {
    label: "Prescriber Net Sales"
    type: number
    sql: ${TABLE}.PRESCRIBER_NET_SALES ;;
  }

  dimension: Presc_future_net_sales {
    label: "Prescriber Future Net Sales"
    type: number
    sql: ${TABLE}.PRESCRIBER_FUTURE_NET_SALES ;;
  }

  dimension: Presc_avg_net_sales {
    label: "Prescriber Avg Net Sales"
    type: number
    sql: ${TABLE}.PRESCRIBER_AVG_NET_SALES ;;
  }

  dimension: acq_cost {
    label: "Acquisition Cost"
    type: string
    sql: ${TABLE}.ACQUISITION_COST ;;
  }

  dimension: avg_acq_cost {
    label: "Avg Acquisition Cost"
    type: string
    sql: ${TABLE}.AVG_ACQUISITION_COST ;;
  }

  dimension: avg_fill_quantity {
    label: "Avg Fill Quantity"
    type: number
    sql: ${TABLE}.AVG_FILL_QUANTITY ;;
  }

  dimension: fill_quantity {
    label: "Fill Quantity"
    type: number
    sql: ${TABLE}.FILL_QUANTITY ;;
  }

  dimension: tot_no_of_scripts_pres {
    label: "Total No Of Scripts Prescribed"
    type: number
    sql: ${TABLE}.TOT_NO_OF_SCRIPT ;;
  }

  dimension: Predicted_future_net_sales {
    label: "Predicted Prescriber Future Sales"
    type: number
    sql: ${TABLE}.FUTURE_NET_SALES_PREDICTED ;;
  }

  measure: diff_Predicted_future_net_sales {
    label: "Predicted Future Sales Difference"
    type: sum
    sql: Coalesce(${Predicted_future_net_sales},0) -  coalesce(${Presc_future_net_sales},0);;
    value_format: "$###0.00"
  }

  measure: diff_Predicted_actual_net_sales {
    label: "Predicted Actual Sales Difference"
    type: sum
    sql: Coalesce(${Predicted_future_net_sales},0) -  coalesce(${Presc_net_sales},0);;
    value_format: "$###0.00"
  }

  }

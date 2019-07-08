view: sales_history_suggestions {
  derived_table: {
    sql: SELECT 'SOLD' AS DATE_TO_USE,'YES' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'YES' {% endcondition %}
      UNION
      SELECT 'REPORTABLE SALES' AS DATE_TO_USE,'YES' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'YES' {% endcondition %}
      UNION
      SELECT 'FILLED' AS DATE_TO_USE,'NO' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'NO' {% endcondition %}
      UNION
      SELECT 'REPORTABLE SALES' AS DATE_TO_USE,'NO' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'NO' {% endcondition %}
      UNION
      SELECT 'SOLD' AS DATE_TO_USE,'NO' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'NO' {% endcondition %}
      UNION
      SELECT 'RETURNED' AS DATE_TO_USE,'NO' AS HISTORY FROM DUAL WHERE {% condition sales.history_filter %} 'NO' {% endcondition %}
       ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: date_to_use {
    hidden: yes
    label: "DATE TO USE"
    description: "Dictates if analysis has to be conducted on 'REPORTABLE SALES' or 'SOLD' date when 'YES' is chosen for HISTORY. If 'NO' provides filtering capabilities FILLED, REPORTABLE SALES, SOLD, RETURNED"
    type: string
    sql: ${TABLE}.DATE_TO_USE ;;
  }

  dimension: history {
    hidden: yes
    label: "HISTORY"
    description: "Includes all suggested values based on history or no history analysis"
    type: string
    sql: ${TABLE}.HISTORY ;;
  }
}

####################################################################################################### Measures #################################################################################################

view: poc_drug_cost_type {
  derived_table:{
  sql:
    SELECT
    STORE_DRUG_COST_TYPE,
    CHAIN_ID,
    NHIN_STORE_ID,
    DRUG_COST_TYPE_ID,
    Row_number() over (Partition BY STORE_DRUG_COST_TYPE ORDER BY SOURCE_TIMESTAMP DESC nulls Last)
    DRUG_COST_TYPE_ROW_NUM
  FROM
    EDW.D_STORE_DRUG_COST_TYPE ;;
  }


  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${cost_type} ;;
  }

  dimension: drug_cost_type_row_num {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_COST_TYPE_ROW_NUM ;;
  }

  dimension: cost_type {
    label: "Cost Type"
    hidden: yes
    type: string
    sql: ${TABLE}.STORE_DRUG_COST_TYPE ;;
  }



   }

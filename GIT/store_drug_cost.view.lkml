view: store_drug_cost {
  label: "Pharmacy Drug Cost"
  sql_table_name: EDW.D_STORE_DRUG_COST ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_cost_id} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    type: number
    hidden: yes
    description: "Identification number assinged to each customer chain by NHIN"
    label: "Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    description: "NHIN account number which uniquely identifies the store with NHIN"
    label: "Nhin Store ID"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: drug_cost_id {
    type: number
    hidden: yes
    description: "Unique ID number identifying drug costs record"
    label: "Drug Cost ID"
    sql: ${TABLE}.DRUG_COST_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_cost_type_id {
    type: number
    hidden: yes
    description: "Unique ID number identifying a DRUG_COST_TYPE record, which identifies whether this record is for AWP, MAC, ACQ, etc"
    label: "Drug Cost Type ID"
    sql: ${TABLE}.DRUG_COST_TYPE_ID ;;
  }

  dimension: drug_id {
    type: number
    hidden: yes
    description: "Unique ID number identifying a drug record"
    label: "Drug ID"
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: drug_tp_id {
    type: number
    hidden: yes
    description: "Unique ID identifying the Drug_TP record to which this Drug_Costs record is associated"
    label: "Drug TP ID"
    sql: ${TABLE}.DRUG_TP_ID ;;
  }

  ##################################################################### dimensions ###################################################

  dimension: store_drug_cost_update_flag {
    type: string
    description: "Flag that indicates how the drug cost update should update the corresponding cost base fields"
    label: "Drug Cost Update"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'N' ;;
        label: "DOLLAR AMOUNT REMAINS THE SAME"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'Y' ;;
        label: "MAINTAIN A CONSTANT PERCENTAGE OF AWP"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'M' ;;
        label: "COST USED IS DEFINED ON THE COST BASE RECORD"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'U' ;;
        label: "PRICE UPDATE"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'W' ;;
        label: "WHOLESALERS ACQ COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'L' ;;
        label: "WHOLESALERS AWP COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'S' ;;
        label: "UPDATE SERVICES AWP COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_UPDATE_FLAG = 'C' ;;
        label: "STANDARD AWP COST"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension_group: store_drug_cost_update {
    type: time
    description: "Date/Time this record was last updated for cost base such as MAC, AWP, ACQ."
    label: "Drug Cost Updated"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.STORE_DRUG_COST_UPDATE_DATE ;;
  }

  #[ERXLPS-1262]
  dimension_group: store_drug_cost_create {
    type: time
    description: "Date/Time this record was created"
    label: "Drug Cost Create"
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: store_drug_cost_last_update {
    label: "Drug Cost Update"
    description: "Date/Time the record was last updated in source"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: store_drug_cost_deleted {
    type: yesno
    #hidden: yes [ERXLPS-1254] Exposed to make it sync with Drug Cost dimensions/measures in sales view.
    description: "Yes/No flag indicating if this record has been deleted in the source table"
    label: "Drug Cost Deleted"
    sql: ${TABLE}.STORE_DRUG_COST_DELETED = 'Y' ;;
  }

  #[ERXLPS-2064] - Added reference dimension to use in joins
  dimension: store_drug_cost_deleted_reference {
    type: string
    hidden: yes
    description: "Y/N flag indicating if this record has been deleted in the source table"
    label: "Drug Cost Deleted"
    sql: ${TABLE}.STORE_DRUG_COST_DELETED ;;
  }

  #[ERXLPS-1617] - Dimension created to use in sales explore for grouping
  dimension: store_drug_cost_amount {
    type: number
    description: "Dollar amount per drug package. This dimension should be used in conjunction with Pharmacy Drug Cost Type."
    label: "Drug Cost Amount"
    sql: ${TABLE}.STORE_DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ##################################################################### Measures ######################################################

  measure: count {
    label: "Drug Cost Count"
    description: "Drug Cost Count"
    type: count
    value_format: "#,##0"
  }

  measure: sum_store_drug_cost_amount {
    type: sum
    description: "Total Dollar amount per drug package. This measure should be used in conjunction with Pharmacy Drug Cost Type. Excluding the Pharmacy Drug Cost Type dimension will cause this measure to sum across all Drug Cost Types."
    # modified as a part of [ERXLPS-1241]
    label: "Total Drug Cost Amount"
    sql: ${TABLE}.STORE_DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_store_drug_cost_amount {
    type: average
    label: "Avg Drug Cost Amount"
    description: "Average Dollar amount per drug package. This measure should be used in conjunction with Pharmacy Drug Cost Type. Excluding the Pharmacy Drug Cost Type dimension will cause this measure to average across all Drug Cost Types."
    sql: ${TABLE}.STORE_DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_store_drug_cost_unit_cost {
    label: "Total Drug Cost Unit Amount"
    description: "Total of the Unit Cost Amount for Drug Base Cost Type"
    type: number
    #[ERXLPS-1721] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
    sql: ( SUM(DISTINCT (CAST(FLOOR(${TABLE}.STORE_DRUG_COST_UNIT_COST*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${TABLE}.STORE_DRUG_COST_UNIT_COST IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_cost_id} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${TABLE}.STORE_DRUG_COST_UNIT_COST IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_cost_id} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  ############################################# Sets #####################################################

  set: explore_rx_store_drug_cost_4_10_candidate_list {
    fields: [
      store_drug_cost_update_flag,
      count,
      sum_store_drug_cost_amount,
      avg_store_drug_cost_amount,
      sum_store_drug_cost_unit_cost,
      store_drug_cost_update,
      store_drug_cost_update_time,
      store_drug_cost_update_date,
      store_drug_cost_update_week,
      store_drug_cost_update_month,
      store_drug_cost_update_month_num,
      store_drug_cost_update_year,
      store_drug_cost_update_quarter,
      store_drug_cost_update_quarter_of_year,
      store_drug_cost_update_hour_of_day,
      store_drug_cost_update_time_of_day,
      store_drug_cost_update_hour2,
      store_drug_cost_update_minute15,
      store_drug_cost_update_day_of_week,
      store_drug_cost_update_day_of_month,
      store_drug_cost_update_week_of_year,
      store_drug_cost_update_day_of_week_index
    ]
  }
}

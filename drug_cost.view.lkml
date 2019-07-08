view: drug_cost {
  sql_table_name: EDW.D_DRUG_COST ;;

  dimension: region {
    label: "Drug Cost Region"
    description: "Indicates the region associated to the drug cost"
    sql: ${TABLE}.DRUG_COST_REGION ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${region} ||'@'|| ${cost_type} ||'@'|| ${ndc} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Cost Type Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: ndc {
    hidden: yes
    type: string
    label: "Drug Cost NDC"
    description: "11 digit NDC associated with drug cost"
    sql: ${TABLE}.NDC ;;
  }

  dimension: cost_type {
    hidden: yes
    type: string
    label: "Drug Cost Type Code"
    description: "Includes different Cost Type Codes such as AWP - Average Wholesale Price, MAC- Maximum Allowable Cost, ACQ - Acquistion Cost, REG - Regular Cost, STD - Standard Cost, etc"
    sql: ${TABLE}.DRUG_COST_TYPE ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################

  dimension: deleted {
    label: "Drug Cost Deleted"
    type: yesno
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug cost was deleted from the source system"
    sql: ${TABLE}.DRUG_COST_DELETED = 'Y' ;;
  }

  #[ERXLPS-1925] - Created reference dimension to add at drug_cost join
  dimension: deleted_reference {
    label: "Drug Cost Deleted"
    type: string
    hidden: yes
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    sql: ${TABLE}.DRUG_COST_DELETED ;;
  }

  #[ERXLPS-1617] - Dimension created to use in sales explore for grouping
  #[ERXLPS-1926] - Updated label and description
  dimension: cost_amount {
    label: "Drug Cost Amount*"
    description: "Dollar amount per drug package. This dimension should be used in conjunction with HOST drug region and HOST Drug Cost Type."
    type: number
    sql: ${TABLE}.DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ########################################################################################################### SQL Case When Fields (Suggestions) #################################################################################

  dimension: cost_type_override_flag {
    type: string
    label: "Drug Cost Price Update Flag"
    description: "Drug Cost Update Flag Override for Drug Cost Type"

    case: {
      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'Y' ;;
        label: "AWP UPDATE NO COST TYPE"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'N' ;;
        label: "AWP IMPACT PERCENTAGE"
      }

      when: {
        sql: true ;;
        label: "PRICE UPDATE"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'C' ;;
        label: "STANDARD AWP COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'L' ;;
        label: "WHOLESALERS AWP COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'M' ;;
        label: "ACQ COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'S' ;;
        label: "UPDATE SERVICES AWP COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'W' ;;
        label: "WHOLESALERS ACQ COST"
      }
    }
  }

  dimension: source {
    type: string
    label: "Drug Cost Source"
    description: "Source of the Drug Cost"
    sql: ${TABLE}.DRUG_COST_SOURCE ;;

    case: {
      when: {
        sql: ${TABLE}.DRUG_COST_SOURCE = '1' ;;
        label: "PRIMARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_SOURCE = '2' ;;
        label: "SECONDARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_SOURCE = '3' ;;
        label: "TERTIARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_SOURCE = '4' ;;
        label: "QUADRARY WHOLESALER"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_SOURCE = '%' ;;
        label: "PERCENTAGE OF AWP"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'M' ;;
        label: "MAIL ODRDER COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'C' ;;
        label: "CENTRAL FILL COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'A' ;;
        label: "MARK UP FACTOR"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'S' ;;
        label: "MANUFACTURER AWP"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'K' ;;
        label: "FIXED 20 PERCENT OF WAC"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_PRICE_UPDATE_FLAG = 'L' ;;
        label: "20 PERCENT ABOVE WAC"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  #[ERXLPS-1254]
  dimension_group: drug_cost_last_updated {
    type: time
    label: "Drug Cost Update"
    description: "Date/Time the record was last updated in source"
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

  ################################################################################################## End of Dimensions #################################################################################################

  #################################################################################################### Measures #########################################################################################################

  measure: count {
    label: "Drug Cost Count"
    description: "Total Drug Cost count. This measure should be used in conjuction with HOST drug regionand HOST Drug Cost Type." #[ERXLPS-1926]
    type: count
    value_format: "#,##0"
  }

  measure: sum_cost_unit_amount {
    label: "Total Drug Cost Unit Amount*"
    description: "Total Unit Cost Amount for a Drug Cost Type. This measure should be used in conjuction with HOST drug region and HOST Drug Cost Type." #[ERXLPS-1926]
    type: number
    #[ERXLPS-1721] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
    sql: ( SUM(DISTINCT (CAST(FLOOR(${TABLE}.DRUG_COST_UNIT_AMOUNT*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${TABLE}.DRUG_COST_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'|| ${region} ||'@'|| ${cost_type} ||'@'|| ${ndc} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${TABLE}.DRUG_COST_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'|| ${region} ||'@'|| ${cost_type} ||'@'|| ${ndc} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  #[ERXLPS-1926] label and description changes.
  measure: sum_cost_amount {
    label: "Total Drug Cost Amount*"
    description: "Dollar amount per drug package. This measure should be used in conjunction with HOST drug region and HOST Drug Cost Type. Excluding the HOST Drug Cost Type dimension will cause this measure to sum across all Drug Cost Types."
    # modified as a part of [ERXLPS-1241]
    type: sum
    sql: ${TABLE}.DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1926] label and description changes.
  measure: avg_cost_amount {
    label: "Avg Drug Cost Amount*"
    description: "Average Dollar amount per drug package. This measure should be used in conjunction with HOST drug region and HOST Drug Cost Type. Excluding the HOST Drug Cost Type dimension will cause this measure to average across all Drug Cost Types."
    type: average
    sql: ${TABLE}.DRUG_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################################################## End of Measures #################################################################################################

  ##################################################################### Metadata Fields (Required for Data Consumption, if consumed from API) #######################################################
  dimension: event_id {
    type: number
    label: "Drug Cost EDW Event ID"
    group_label: "EDW ETL Event Metadata"
    description: "The ETL Event that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: source_timestamp {
    type: date_time
    label: "Drug Cost Source Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/Time the record was last updated in source"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: edw_insert_timestamp {
    type: date_time
    label: "Drug Cost EDW Insert Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension: edw_last_update_timestamp {
    type: date_time
    label: "Drug Cost EDW Last Update Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is updated to EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  set: explore_rx_drug_cost_metadata_candidate_list {
    fields: [
      event_id,
      edw_insert_timestamp,
      edw_last_update_timestamp
    ]
  }
}

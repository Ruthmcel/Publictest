view: drug_cost_type {
  sql_table_name: EDW.D_DRUG_COST_TYPE ;;

  dimension: cost_type {
    type: string
    label: "Drug Cost Type Code"
    description: "Includes different Cost Type Codes such as AWP - Average Wholesale Price, MAC- Maximum Allowable Cost, ACQ - Acquistion Cost, REG - Regular Cost, STD - Standard Cost, etc"
    sql: ${TABLE}.DRUG_COST_TYPE ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    # source_system_id is not included as it is handled at the join level, where only record from one source system will be joined based on the view selected
    sql: ${chain_id} ||'@'|| ${cost_type} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################

  dimension: cost_type_description {
    type: string
    label: "Drug Cost Type Description"
    description: "Long form description of drug cost type code"
    sql: ${TABLE}.DRUG_COST_TYPE_DESCRIPTION ;;
  }

  ########################################################################################################### SQL Case When Fields (Suggestions) ######################################################################

  dimension: cost_type_override_flag {
    type: string
    label: "Drug Cost Type Override Flag"
    description: "Drug Cost Update Flag Override for Drug Cost Type"

    case: {
      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'Y' ;;
        label: "USE PRICE NOT PERCENT"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'N' ;;
        label: "BLOCK UPDATE"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'U' ;;
        label: "ALLOW"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'C' ;;
        label: "STANDARD NDC ACQ COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'L' ;;
        label: "WHOLESALE AWP LIST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'M' ;;
        label: "DRUG NDC ACQ COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'S' ;;
        label: "AWP COST"
      }

      when: {
        sql: ${TABLE}.DRUG_COST_TYPE_OVERRIDE_FLAG = 'W' ;;
        label: "DRUG NDC WAC"
      }

      when: {
        sql: true ;;
        label: "ORIGINAL COST"
      }
    }
  }

  dimension: cost_type_deleted {
    type: yesno
    label: "Drug Cost Type Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Yes/No Flag indicating if a Drug Cost Type has been physically deleted in the source system"
    sql: ${TABLE}.DRUG_COST_TYPE_DELETED = 'Y' ;;
  }

  #[ERXLPS-2064] - Added reference dimension to use in joins
  dimension: cost_type_deleted_reference {
    type: string
    hidden: yes
    label: "Drug Cost Type Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if a Drug Cost Type has been physically deleted in the source system"
    sql: ${TABLE}.DRUG_COST_TYPE_DELETED ;;
  }

  #[ERXLPS-1262]
  dimension_group: drug_cost_type_last_updated {
    type: time
    label: "Drug Cost Type Update"
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

  #################################################################################################### Measures #######################################################################################################

  measure: count {
    label: "Drug Cost Type Count"
    description: "Total Drug Cost Type count"
    type: count
    value_format: "#,##0"
  }

  ################################################################################################## End of Measures #################################################################################################

  ##################################################################### Metadata Fields (Required for Data Consumption, if consumed from API) #######################################################

  dimension: event_id {
    type: number
    label: "Drug Cost Type EDW Event ID"
    group_label: "EDW ETL Event Metadata"
    description: "The ETL Event that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: source_timestamp {
    type: date_time
    label: "Drug Cost Type Source Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/Time the record was last updated in source"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: edw_insert_timestamp {
    type: date_time
    label: "Drug Cost Type EDW Insert Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension: edw_last_update_timestamp {
    type: date_time
    label: "Drug Cost Type EDW Last Update Timestamp"
    group_label: "EDW ETL Event Metadata"
    description: "Date/time at which the record is updated to EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }
  ################################################################################################### Sets ##################################################################################################################
#[ERXLPS-2064]
## [ERXLPS-2114] - Per request of QA to be consistent, the source_timestamp is being exposed by removing it from this redacted set to match other Drug views
  set: explore_rx_drug_cost_type_metadata_candidate_list {
    fields: [
      event_id,
      edw_insert_timestamp,
      edw_last_update_timestamp
    ]
  }
}

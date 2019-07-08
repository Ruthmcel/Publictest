view: store_drug_cost_type {
  label: "Pharmacy Drug Cost Type"
  sql_table_name: EDW.D_STORE_DRUG_COST_TYPE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_cost_type_id} ;; #ERXLPS-1649
  }

  ############################################################# Foreign key references ###################################

  dimension: chain_id {
    type: number
    hidden: yes
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: drug_cost_type_id {
    type: number
    hidden: yes
    label: "Drug Cost Type Id"
    description: "Unique ID number identifying a DRUG_COST_TYPE record, which identifies whether this record is for AWP, MAC, ACQ, etc"
    sql: ${TABLE}.DRUG_COST_TYPE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ########################################################################Dimensions##########################################

  dimension: store_drug_cost_type {
    type: string
    label: "Drug Cost Type Code" #[ERXLPS-1254] - Added "Code" to label name.
    description: "Includes different Cost Type Codes such as AWP - Average Wholesale Price, MAC- Maximum Allowable Cost, ACQ - Acquistion Cost, REG - Regular Cost, STD - Standard Cost, etc"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE ;;
  }

  #[ERXLPS-1927] - Deidentified dimension for DEMO model
  dimension: store_drug_cost_type_deidentified {
    type: string
    label: "Drug Cost Type Code" #[ERXLPS-1254] - Added "Code" to label name.
    description: "Includes different Cost Type Codes such as AWP - Average Wholesale Price, MAC- Maximum Allowable Cost, ACQ - Acquistion Cost, REG - Regular Cost, STD - Standard Cost, etc"
    sql: CASE WHEN ${TABLE}.STORE_DRUG_COST_TYPE in ('AWP','ACQ','WAC','MAC','REG','DP','WEL','340B') THEN ${TABLE}.STORE_DRUG_COST_TYPE ELSE 'OTHER' END ;;
  }


  dimension: store_drug_cost_type_description {
    type: string
    label: "Drug Cost Type Description"
    description: "Long form description of drug cost type code"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE_DESCRIPTION ;;
  }

  #[ERXLPS-1927] - Deidentified dimension for DEMO model
  dimension: store_drug_cost_type_description_deidentified {
    type: string
    label: "Drug Cost Type Description"
    description: "Long form description of drug cost type code"
    sql: CASE WHEN ${TABLE}.STORE_DRUG_COST_TYPE in ('AWP','ACQ','WAC','MAC','REG','DP','WEL','340B') THEN ${TABLE}.STORE_DRUG_COST_TYPE_DESCRIPTION ELSE 'OTHER' END ;;
  }

  dimension: store_drug_cost_type_enable_constant_percentage_awp_flag {
    type: yesno
    label: "Drug Cost Type Enable Constant Percentage AWP"
    description: "Yes/No flag indicating whether the Maintain Constant % of AWP option is enabled on the Drug Pricing screen"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE_ENABLE_CONSTANT_PERCENTAGE_AWP_FLAG = 'Y' ;;
  }

  dimension: store_drug_cost_type_enable_constant_dollar_cost_flag {
    type: yesno
    label: "Drug Cost Type Enable Constant Dollar Cost"
    description: "Yes/No flag indicating whether the Maintain Constant $ Cost (Block Price Updates) option is enabled on the Drug Pricing screen"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE_ENABLE_CONSTANT_DOLLAR_COST_FLAG = 'Y' ;;
  }

  dimension: store_drug_cost_type_enable_mapped_dollar_cost_flag {
    type: yesno
    label: "Drug Cost Type Enable Mapped Dollar Cost"
    description: "Yes/No flag indicating whether the Update $ Cost with field is enabled on the Drug Pricing screen"
    sql: ${TABLE}.STORE_DRUG_COST_TYPE_ENABLE_MAPPED_DOLLAR_COST_FLAG = 'Y' ;;
  }

  dimension: store_drug_cost_type_default_price_update_code {
    type: string
    label: "Drug Cost Type Default Price Update Code"
    description: "Indicates the default price update option displayed on the Drug Pricing screen when a drug pricing cost base value is being added"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'N' ;;
        label: "MAINTAIN CONSTANT DOLLAR COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'Y' ;;
        label: "MAINTAIN CONSTANT PERCENT OF AWP  (BLOCKS COST UPDATE)"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'M' ;;
        label: "UPDATE DOLLAR COST WITH THE COST SPECIFIED"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'C' ;;
        label: "STANDARD NDC ACQ COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'L' ;;
        label: "WHOLESALE AWP LIST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'S' ;;
        label: "AWP COST"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_DEFAULT_PRICE_UPDATE_CODE = 'W' ;;
        label: "DRUG NDC WAC"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: store_drug_cost_type_price_update_cost_type_code {
    type: string
    label: "Drug Cost Type Price Update Cost Type Code"
    description: "Indicates which price update $ amount type is to be used to update the cost. If the price update does not contain the selected $ amount type, AWP is used"

    case: {
      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_PRICE_UPDATE_COST_TYPE_CODE = '0' ;;
        label: "AWP"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_PRICE_UPDATE_COST_TYPE_CODE = '1' ;;
        label: "MAC"
      }

      when: {
        sql: ${TABLE}.STORE_DRUG_COST_TYPE_PRICE_UPDATE_COST_TYPE_CODE = '2' ;;
        label: "ACQ"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  #[ERXLPS-1262]
  dimension_group: store_drug_cost_type_last_update {
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

  dimension_group: store_drug_cost_type_create {
    type: time
    description: "Date/Time this record was created"
    label: "Drug Cost Type Create"
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

  #[ERXLPS-1254] Added Drug Cost Type Count
  measure: count {
    label: "Drug Cost Type Count"
    description: "Total Drug Cost Type count"
    type: count
    value_format: "#,##0"
  }

  ############################################# Sets #####################################################

  set: explore_rx_store_drug_cost_type_4_10_candidate_list {
    fields: [
      store_drug_cost_type,
      store_drug_cost_type_description,
      store_drug_cost_type_enable_constant_percentage_awp_flag,
      store_drug_cost_type_enable_constant_dollar_cost_flag,
      store_drug_cost_type_enable_mapped_dollar_cost_flag,
      store_drug_cost_type_default_price_update_code,
      store_drug_cost_type_price_update_cost_type_code
    ]
  }
}

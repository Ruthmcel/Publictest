view: poc_drug_price_predicted {

   sql_table_name: PUBLIC.DRUG_PRICE_PREDICTED ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${drug_ndc} || '@' || ${pack_size} ;;
  }

  dimension: drug_ndc {
    # hidden: yes
    label: "Drug NDC"
    type: string
    sql: ${TABLE}.DRUG_NDC ;;
  }

  dimension: drug_schedule {
    label: "Drug Schedule"
    type: string
    sql: ${TABLE}.DRUG_SCHEDULE ;;
  }

  dimension: pack_size {
    label: "Pack Size"
    type: string
    sql: ${TABLE}.PACK_SIZE ;;
  }

  dimension: drug_strength {
    label: "Drug Strength"
    type: string
    sql: ${TABLE}.DRUG_STRENGTH ;;
  }

  dimension: drug_therapeutic {
    label: "Drug Thearputic"
    type: string
    sql: ${TABLE}.DRUG_THEARPUTIC ;;
  }

  dimension: drug_unit {
    label: "Drug Unit"
    type: string
    sql: ${TABLE}.DRUG_UNIT ;;
  }

  dimension: drug_multi_source {
    label: "Drug Multi Source"
    type: string
    sql: ${TABLE}.DRUG_MULTI_SOURCE ;;
  }

  dimension: drug_discont_date {
    label: "Drug Discontinued Date"
    type: date
    sql: ${TABLE}.DRUG_DISCONTINUED_DATE ;;
  }

  dimension: price_increase_flag {
    label: "Calculate Price Increase Flag"
    type: string
    sql: ${TABLE}.PRICE_INCREASE_FLAG ;;
  }

  dimension: predicted_price_increase_flag {
    label: "Predicted Price Increase Flag"
    type: string
    sql: ${TABLE}.PRICE_INCREASE_FLAG_PREDICTED ;;
  }

  dimension: predicted_prob_price_increase_range {
    type: tier
    description: "Predicted Probability Increase Range"
    sql: ${TABLE}.PRICE_INCREASE_FLAG_PREDICTED_Y ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0.0,
      0.5,
      0.6,
      0.7,
      0.8,
      0.85,
      0.9,
      0.95,
      1
    ]
    style: relational
  }

  dimension: predicted_prob_price_increase {
    type: number
    description: "Predicted Probability Price Increase"
    sql: ${TABLE}.PRICE_INCREASE_FLAG_PREDICTED_Y ;;
  }

  dimension: predicted_prob_price_decrease {
    type: number
    description: "Predicted Probability Price Decrease"
    sql: ${TABLE}.PRICE_INCREASE_FLAG_PREDICTED_N ;;
    }

  dimension: predicted_prob_price_decrease_range {
    type: tier
    description: "Predicted Probability Increase Range"
    sql: ${TABLE}.PRICE_INCREASE_FLAG_PREDICTED_N ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0.0,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.9,
      1
    ]
    style: relational
  }

  dimension: avg_unit_price {
    label: "Avg Unit Price"
    type: number
    sql: ${TABLE}.AVG_UNIT_PRICE;;
  }


  dimension: max_unit_price {
    label: "Max Unit Price"
    type: number
    sql: ${TABLE}.MAX_UNIT_PRICE ;;
  }
  dimension: min_unit_price {
    label: "Min Unit Price"
    type: number
    sql: ${TABLE}.MIN_UNIT_PRICE ;;
  }

  dimension: start_unit_price {
    label: "Start Unit Price"
    type: number
    sql: ${TABLE}.START_UNIT_PRICE ;;
  }
  dimension: end_unit_price {
    label: "End Unit Price"
    type: number
    sql: ${TABLE}.END_UNIT_PRICE ;;
  }

  dimension: sum_unit_price {
    label: "Total Unit Price"
    type: number
    sql: ${TABLE}.TOTAL_UNIT_PRICE ;;
  }

measure: count_ndc_pack_size {
  label: "Count of NDC"
  type: count_distinct
  sql: ${drug_ndc} || '@' || ${pack_size} ;;
  }

  }

view: sales_eps_tx_tp_response_preferred_product {
  sql_table_name: edw.f_tx_tp_response_preferred_product ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_response_preferred_product_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type}  ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_response_preferred_product_id {
    label: "Response Preferred Product Id"
    type: number
    description: "Unique ID number assigned by NHIN for the store associated to this record"
    hidden: yes
    sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_response_detail_id {
    label: "Response Detail Id"
    type: number
    description: "Unique identifier for each record in the F_TX_TP_RESPONSE_CLAIM_DETAIL table."
    hidden: yes
    sql: ${TABLE}.tx_tp_response_detail_id ;;
  }

  ############################################################## Dimensions######################################################

  dimension: tx_tp_response_preferred_product_counter {
    label: "Response Preferred Product Counter"
    type: number
    description: "Count of the ‘PREFERRED PRODUCT’ occurrences (NCPDP field 551-9F)"
    sql: ${TABLE}.tx_tp_response_preferred_product_counter ;;
  }

  dimension: tx_tp_response_preferred_product_id_qualifier {
    type: string
    label: "Response Preferred Product ID Qualifier"
    description: "Code qualifying the type of product ID submitted in ‘Preferred Product ID’ (553‐AR)  associated with the third party response claim detail id"

    case: {
      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '01' ;;
        label: "UPC"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '02' ;;
        label: "HRI"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '03' ;;
        label: "NDC"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '04' ;;
        label: "HIBCC"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '05' ;;
        label: "DOD"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '11' ;;
        label: "NAPPI"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '12' ;;
        label: "GTIN"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '13' ;;
        label: "DIN"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '14' ;;
        label: "GPI"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '15' ;;
        label: "FIRST DATABANK FORMULATION ID (GCN)"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '16' ;;
        label: "MICROMEDEX/MEDICAL ECONOMICS GENERIC FORMULATION CODE (GFC)"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '17' ;;
        label: "MEDI-SPAN PRODUCT LINE DRUG DESCRIPTOR ID (DDID)"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '18' ;;
        label: "FDB SMARTKEY"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '19' ;;
        label: "MICROMEDEX/MEDICAL ECONOMICS GM"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '28' ;;
        label: "FDB MED NAME ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '29' ;;
        label: "FDB ROUTED MED ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '30' ;;
        label: "FDB ROUTED DOSAGE FORM MED ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '31' ;;
        label: "FDB MEDID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '32' ;;
        label: "FDB CLINICAL FORMULATION ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '33' ;;
        label: "FDB INGREDIENT LIST ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '37' ;;
        label: "AHFS"
      }

      when: {
        sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_ID_QUALIFIER = '99' ;;
        label: "OTHER"
      }

      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_response_preferred_product_identifier {
    label: "Response Preferred Product Identifier"
    type: string
    description: "‘Preferred Product ID’ associated with the third party response claim detail id indicated. NCPDP field 553-AR."
    sql: ${TABLE}.tx_tp_response_preferred_product_identifier ;;
  }

  dimension: tx_tp_response_preferred_product_description {
    label: "Response Preferred Product Description"
    type: string
    description: "Freeform textal description of preferred product (NCPDP field 553‐AR)  associated with the third party response claim detail id. NCPCP field 556-AU."
    sql: ${TABLE}.TX_TP_RESPONSE_PREFERRED_PRODUCT_DESCRIPTION ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
    hidden: yes
    description: "Date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
  ############################################################## Measures ######################################################

  measure: tx_tp_response_preferred_product_incentive_amount {
    label: "Response Preferred Product Incentive Amount"
    description: "Amount of pharmacy incentive available for substitution of preferred product. NCPDP field 554-AS."
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_response_preferred_product_incentive_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: tx_tp_resp_preferred_prod_cost_share_incentive_amount {
    label: "Response Preferred Product Cost Share Incentive Amount"
    description: "Amount of patient's copay/cost-share incentive for preferred product.NCPDP field 555-AT"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.tx_tp_resp_preferred_prod_cost_share_incentive_amount END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

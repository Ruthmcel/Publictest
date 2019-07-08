view: eps_tx_tp_response_detail_amount {
  sql_table_name: EDW.F_TX_TP_RESPONSE_DETAIL_AMOUNT ;;

  dimension: tx_tp_response_detail_amount_id {
    type: number
    hidden: yes
    label: "Response Detail Amount ID"
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_response_detail_amount_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Response Detail Amount Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Response Detail Amount NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_response_detail_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################

  dimension: tx_tp_response_detail_amount_ncpdp_type {
    label: "Response Detail Amount NCPDP Type"
    description: "NCPDP field indicating the type of amount being stored. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT_NCPDP_TYPE ;;
  }

  dimension: tx_tp_response_detail_amount_counter {
    label: "Response Detail Amount Counter"
    description: "Count of the other amount paid occurrences. / Count of ‘Benefit Stage Amount’ (394-MW) occurrences. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT_COUNTER ;;
    value_format: "#,##0"
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: tx_tp_response_detail_amount_amount_qualifier {
    label: "Response Detail Amount Qualifier"
    description: "NCPDP field indicating the type of amount being stored. This field is EPS only!!!"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT_AMOUNT_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_RESPONSE_DETAIL_AMOUNT_AMOUNT_QUALIFIER') ;;
    suggestions: [
      "NOT SPECIFIED",
      "DELIVERY COST",
      "SHIPPING COST",
      "POSTAGE COST",
      "ADMINISTRATIVE COST",
      "COMPOUND PREPARATION COST SUBMITTED",
      "OTHER",
      "DEDUCTIBLE",
      "INITIAL BENEFIT",
      "COVERAGE GAP (DONUT HOLE)",
      "CATASTROPHIC COVERAGE",
      "NOT PAID UNDER PART D, PAID UNDER PART C BENEFIT (FOR MA-PD PLAN)",
      "NOT PAID UNDER PART D, PAID AS OR UNDER A SUPPLEMENTAL BENEFIT ONLY",
      "PAID AS OR UNDER A CO-ADMINISTERED BENEFIT ONLY",
      "PAID AS OR UNDER A CO-ADMINISTERED BENEFIT ONLY",
      "PAID BY THE BENEFICIARY UNDER PLAN-SPONSORED NEGOTIATED PRICING",
      "HOSPICE BENEFIT, OR ANY OTHER COMPONENT OF MEDICARE",
      "ENHANCE OR OTC DRUG (PDE VALUE OF E/O)"
    ]
  }

  ################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

  ####################################################################################################### Measures #################################################################################################################

  measure: tx_tp_response_detail_amount {
    label: "Response Detail Amount"
    description: "Code clarifying the value in the ‘Other Amount Paid’ (565-J4). / Code qualifying the ’Benefit Stage Amount’ (394-MW). This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-726] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sales_sum_tx_tp_response_detail_amount {
    label: "Response Detail Amount"
    description: "Code clarifying the value in the ‘Other Amount Paid’ (565-J4). / Code qualifying the ’Benefit Stage Amount’ (394-MW). This field is EPS only!!!"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${TABLE}.TX_TP_RESPONSE_DETAIL_AMOUNT END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

############################################################################ Sets ############################################################
  #[ERXLPS-726] New set created for dimensions only to include in sales explore
  set: sales_tx_tp_response_detial_amount_dimension_candidate_list {
    fields: [
      tx_tp_response_detail_amount_ncpdp_type,
      tx_tp_response_detail_amount_counter,
      tx_tp_response_detail_amount_amount_qualifier
    ]
  }

  #[ERXLPS-726] New set created to exclude sales specific measures from other explores
  set: explore_sales_specific_candidate_list {
    fields: [
      sales_sum_tx_tp_response_detail_amount
    ]
  }
}

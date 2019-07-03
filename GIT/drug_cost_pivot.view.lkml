view: drug_cost_pivot {
  derived_table: {
    #[ERXLPS-1925] Drug Cost Region added to derived SQL logic to calculate Cost at region level.
    sql: SELECT
      CHAIN_ID,
      NDC,
      SOURCE_SYSTEM_ID,
      DRUG_COST_REGION,
      MAX(DRUG_AWP_COST) AS DRUG_AWP_COST,
      MAX(DRUG_ACQ_COST) AS DRUG_ACQ_COST,
      MAX(DRUG_WAC_COST) AS DRUG_WAC_COST,
      MAX(DRUG_MAC_COST) AS DRUG_MAC_COST,
      MAX(DRUG_REG_COST) AS DRUG_REG_COST,
      MAX(DRUG_DP_COST) AS DRUG_DP_COST,
      MAX(DRUG_WEL_COST) AS DRUG_WEL_COST,
      MAX(DRUG_340B_COST) AS DRUG_340B_COST
      FROM
      (SELECT
      CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION, --ERXLPS1925 Added Drug Cost Region
      MAX(CASE WHEN DRUG_COST_TYPE = 'AWP' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_AWP_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'ACQ' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_ACQ_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'WAC' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_WAC_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'MAC' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_MAC_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'REG' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_REG_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'DP' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_DP_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = 'WEL' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_WEL_COST,
      MAX(CASE WHEN DRUG_COST_TYPE = '340B' THEN DRUG_COST_AMOUNT END) OVER (PARTITION BY CHAIN_ID,NDC,SOURCE_SYSTEM_ID,DRUG_COST_REGION) AS DRUG_340B_COST
      FROM EDW.D_DRUG_COST
      WHERE DRUG_COST_DELETED = 'N'
      )DRUG_COST_PIVOT
      GROUP BY 1,2,3,4
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${ndc} ||'@'|| ${drug_cost_region}  ;; #ERXLPS-1649 #[ERXLPS-1925]
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

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXLPS-1925]
  dimension: drug_cost_region {
    type: number
    label: "Drug Cost Region"
    hidden: yes
    description: "Drug cost region"
    sql: ${TABLE}.DRUG_COST_REGION ;;
  }

  #################################################################################################### Dimension #########################################################################################################

  #field used for determinging Total Drug On Hand Cost
  #[ERXLPS-1926]
  dimension: acq_cost_amount {
    label: "Drug Acquisition Cost Amount"
    description: "Acquisition Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    # used in the calculation of drug on hand cost amount but not exposed in the explore
    #hidden: yes #[ERXLPS-1926]
    type: number
    sql: ${TABLE}.DRUG_ACQ_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: awp_cost_amount {
    label: "Drug Average Wholesale Price Cost Amount"
    description: "Average Wholesale Price Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: wac_cost_amount {
    label: "Drug Wholesaler Acquisition Cost Amount"
    description: "Wholesaler Acquisition Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_WAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: mac_cost_amount {
    label: "Drug Maximum Allowable Cost Amount"
    description: "Maximum Allowable Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_MAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: reg_cost_amount {
    label: "Drug Regular Cost Amount"
    description: "Regular Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_REG_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: dp_cost_amount {
    label: "Drug Direct Price Cost Amount"
    description: "Direct Price Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_DP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: wel_cost_amount {
    label: "Drug Welfare Cost Amount"
    description: "Welfare Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_WEL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: 340b_cost_amount {
    label: "Drug 340B Medicare Part D Cost Amount"
    description: "340B Medicare Part D Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.DRUG_340B_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #################################################################################################### Measures #########################################################################################################
  measure: sum_acq_cost_amount {
    label: "Total Drug Acquisition Cost Amount"
    description: "Acquisition Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_ACQ_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_awp_cost_amount {
    label: "Total Drug Average Wholesale Price Cost Amount"
    description: "Average Wholesale Price Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_wac_cost_amount {
    label: "Total Drug Wholesaler Acquisition Cost Amount"
    description: "Wholesaler Acquisition Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_WAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_mac_cost_amount {
    label: "Total Drug Maximum Allowable Cost Amount"
    description: "Maximum Allowable Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_MAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_reg_cost_amount {
    label: "Total Drug Regular Cost Amount"
    description: "Regular Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_REG_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_dp_cost_amount {
    label: "Total Drug Direct Price Cost Amount"
    description: "Direct Price Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_DP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_wel_cost_amount {
    label: "Total Drug Welfare Cost Amount"
    description: "Welfare Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_WEL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_340b_cost_amount {
    label: "Total Drug 340B Medicare Part D Cost Amount"
    description: "340B Medicare Part D Cost of the Drug. For correct Drug Cost comparison between Host and Pharmacy, the Drug Cost Region must be used within the report. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.DRUG_340B_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

################################################################################################## End of Measures #################################################################################################

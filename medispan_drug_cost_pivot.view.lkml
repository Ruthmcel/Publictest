view: medispan_drug_cost_pivot {
  derived_table: {
    sql: select ndc,
                max(case when drug_cost_type = 'AAWP' then drug_cost_unit_amount end) as medispan_drug_aawp_cost_unit_amount,
                max(case when drug_cost_type = 'ACF'  then drug_cost_unit_amount end) as medispan_drug_acf_cost_unit_amount,
                max(case when drug_cost_type = 'AWP'  then drug_cost_unit_amount end) as medispan_drug_awp_cost_unit_amount,
                max(case when drug_cost_type = 'DP'   then drug_cost_unit_amount end) as medispan_drug_dp_cost_unit_amount,
                max(case when drug_cost_type = 'GEAP' then drug_cost_unit_amount end) as medispan_drug_geap_cost_unit_amount,
                max(case when drug_cost_type = 'MAC'  then drug_cost_unit_amount end) as medispan_drug_mac_cost_unit_amount,
                max(case when drug_cost_type = 'NADC' then drug_cost_unit_amount end) as medispan_drug_nadc_cost_unit_amount,
                max(case when drug_cost_type = 'NADG' then drug_cost_unit_amount end) as medispan_drug_nadg_cost_unit_amount,
                max(case when drug_cost_type = 'NADI' then drug_cost_unit_amount end) as medispan_drug_nadi_cost_unit_amount,
                max(case when drug_cost_type = 'NADS' then drug_cost_unit_amount end) as medispan_drug_nads_cost_unit_amount,
                max(case when drug_cost_type = 'WAA'  then drug_cost_unit_amount end) as medispan_drug_waa_cost_unit_amount,
                max(case when drug_cost_type = 'WAC'  then drug_cost_unit_amount end) as medispan_drug_wac_cost_unit_amount
           from (select ndc,
                        drug_cost_type,
                        drug_cost_unit_amount,
                        row_number() over (partition by ndc, drug_cost_type order by source_timestamp desc) rnk
                   from edw.d_drug_cost_hist
                  where chain_id = 3000
                    and source_system_id = 16
                    and drug_cost_source = 'M'
                    and drug_cost_deleted = 'N'
                )
          where rnk = 1
          group by ndc
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${ndc} ;;
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: ndc {
    label: "Medi-Span Drug NDC"
    description: "Medi-Span Drug NDC associated with drug cost"
    type: string
    sql: ${TABLE}.NDC ;;
  }

  #################################################################################################### Dimension #########################################################################################################

  dimension: medispan_drug_aawp_cost_unit_amount {
    label: "Medi-Span Drug AAWP Cost Unit Amount"
    description: "Average Average Wholesale Price of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_AAWP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_acf_cost_unit_amount {
    label: "Medi-Span Drug ACF Cost Unit Amount"
    description: "Affordable Care Act - Federal Upper Limit of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_ACF_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_awp_cost_unit_amount {
    label: "Medi-Span Drug AWP Cost Unit Amount"
    description: "Average Wholesale Price of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_AWP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_dp_cost_unit_amount {
    label: "Medi-Span Drug DP Cost Unit Amount"
    description: "Direct Price of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_DP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_geap_cost_unit_amount {
    label: "Medi-Span Drug GEAP Cost Unit Amount"
    description: "Generic Equivalent Average Price of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_GEAP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_mac_cost_unit_amount {
    label: "Medi-Span Drug MAC Unit Amount"
    description: "Maximum Allowable Cost of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_MAC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_nadc_cost_unit_amount {
    label: "Medi-Span Drug NADC Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Chain of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_NADC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_nadg_cost_unit_amount {
    label: "Medi-Span Drug NADG Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Generic of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_NADG_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_nadi_cost_unit_amount {
    label: "Medi-Span Drug NADI Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Independent of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_NADI_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_nads_cost_unit_amount {
    label: "Medi-Span Drug NADS Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Specialty of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_NADS_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_waa_cost_unit_amount {
    label: "Medi-Span Drug WAA Cost Unit Amount"
    description: "Weighted Average - Average Manufacturer Cost of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_WAA_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: medispan_drug_wac_cost_unit_amount {
    label: "Medi-Span WAC Cost Unit Amount"
    description: "Wholesale Acquisition Cost of the Drug. This dimension is current state, not a point in time metric."
    type: number
    sql: ${TABLE}.MEDISPAN_DRUG_WAC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  #################################################################################################### Measures #########################################################################################################
  measure: sum_medispan_drug_aawp_cost_unit_amount {
    label: "Total Medi-Span Drug AAWP Cost Unit Amount"
    description: "Average Average Wholesale Price of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_AAWP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_acf_cost_unit_amount {
    label: "Total Medi-Span Drug ACF Cost Unit Amount"
    description: "Affordable Care Act - Federal Upper Limit of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_ACF_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_awp_cost_unit_amount {
    label: "Total Medi-Span Drug AWP Cost Unit Amount"
    description: "Average Wholesale Price of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_AWP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_dp_cost_unit_amount {
    label: "Total Medi-Span Drug DP Cost Unit Amount"
    description: "Direct Price of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_DP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_geap_cost_unit_amount {
    label: "Total Medi-Span Drug GEAP Cost Unit Amount"
    description: "Generic Equivalent Average Price of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_GEAP_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_mac_cost_unit_amount {
    label: "Total Medi-Span Drug MAC Unit Amount"
    description: "Maximum Allowable Cost of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_MAC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_nadc_cost_unit_amount {
    label: "Total Medi-Span Drug NADC Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Chain of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_NADC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_nadg_cost_unit_amount {
    label: "Total Medi-Span Drug NADG Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Generic of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_NADG_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_nadi_cost_unit_amount {
    label: "Total Medi-Span Drug NADI Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Independent of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_NADI_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_nads_cost_unit_amount {
    label: "Total Medi-Span Drug NADS Cost Unit Amount"
    description: "National Average Drug Acquisition Cost Specialty of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_NADS_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_waa_cost_unit_amount {
    label: "Total Medi-Span Drug WAA Cost Unit Amount"
    description: "Weighted Average - Average Manufacturer Cost of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_WAA_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_medispan_drug_wac_cost_unit_amount {
    label: "Total Medi-Span Drug WAC Cost Unit Amount"
    description: "Wholesale Acquisition Cost of the Drug. This dimension is current state, not a point in time metric."
    type: sum
    sql: ${TABLE}.MEDISPAN_DRUG_WAC_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }
}

################################################################################################## End of Measures #################################################################################################

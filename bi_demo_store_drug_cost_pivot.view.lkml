view: bi_demo_store_drug_cost_pivot {
  # This view is used to showcase the drug_cost associated with each drug_cost_type for a drug at pharmacy level in a chain.
  # At present we are showing cost associated with few of the cost type like AWP, ACQ, WAC, etc. we can add other drug cost type if requested by business users.

  derived_table: {
    sql: select chain_id,
       nhin_store_id,
       drug_id,
       max(drug_awp_cost) as drug_awp_cost,
       max(drug_acq_cost) as drug_acq_cost,
       max(drug_wac_cost) as drug_wac_cost,
       max(drug_mac_cost) as drug_mac_cost,
       max(drug_reg_cost) as drug_reg_cost,
       max(drug_dp_cost) as drug_dp_cost,
       max(drug_wel_cost) as drug_wel_cost,
       max(drug_340b_cost) as drug_340b_cost
from
(select dc.chain_id,
        dc.nhin_store_id,
        dc.drug_id,
        (case when upper(dct.store_drug_cost_type) = 'AWP' then dc.store_drug_cost_amount end) as drug_awp_cost,
        (case when upper(dct.store_drug_cost_type) = 'ACQ' then dc.store_drug_cost_amount end) as drug_acq_cost,
        (case when upper(dct.store_drug_cost_type) = 'WAC' then dc.store_drug_cost_amount end) as drug_wac_cost,
        (case when upper(dct.store_drug_cost_type) = 'MAC' then dc.store_drug_cost_amount end) as drug_mac_cost,
        (case when upper(dct.store_drug_cost_type) = 'REG' then dc.store_drug_cost_amount end) as drug_reg_cost,
        (case when upper(dct.store_drug_cost_type) = 'DP' Then dc.store_drug_cost_amount end) as drug_dp_cost,
        (case when upper(dct.store_drug_cost_type) = 'WEL' then dc.store_drug_cost_amount end) as drug_wel_cost,
        (case when upper(dct.store_drug_cost_type) = '340B' then dc.store_drug_cost_amount end) as drug_340b_cost
        from edw.d_store_drug_cost dc,
             edw.d_store_drug_cost_type dct
        where dc.chain_id = dct.chain_id
          and dc.nhin_store_id = dct.nhin_store_id
          and dc.drug_cost_type_id = dct.drug_cost_type_id
          and dc.store_drug_cost_deleted = 'N'
          and dc.chain_id IN (SELECT DISTINCT CHAIN_ID FROM REPORT_TEMP.BI_DEMO_CHAIN_STORE_MAPPING  WHERE {% condition bi_demo_store.bi_demo_nhin_store_id %} NHIN_STORE_ID_BI_DEMO_MAPPING {% endcondition %})   -- Required for performance reasons and to avoid scanning all chain/store records
)drug_cost_pivot
group by 1,2,3
 ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Cost Type Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    label: "Nhin Store ID"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: drug_id {
    hidden: yes
    type: string
    label: "Drug ID"
    description: "Drug ID associated with drug cost"
    sql: ${TABLE}.DRUG_ID ;;
  }

  #################################################################################################### Dimension #########################################################################################################

  #field used for determinging Total Drug On Hand Cost
  #[ERXLPS-1926] - Dimensions added for correcsponding measures to expose in Inventory and Sales explore.
  dimension: acq_cost_amount {
    label: "Drug Acquisition Cost Amount"
    description: "Acquisition Cost of the Drug"
    # used in the calculation of drug on hand cost amount but not exposed in the explore
    type: number
    sql: ${TABLE}.DRUG_ACQ_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: awp_cost_amount {
    label: "Drug Average Wholesale Price Cost Amount"
    description: "Average Wholesale Price Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: wac_cost_amount {
    label: "Drug Wholesaler Acquisition Cost Amount"
    description: "Wholesaler Acquisition Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_WAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: mac_cost_amount {
    label: "Drug Maximum Allowable Cost Amount"
    description: "Maximum Allowable Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_MAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: reg_cost_amount {
    label: "Drug Regular Cost Amount"
    description: "Regular Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_REG_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: dp_cost_amount {
    label: "Drug Direct Price Cost Amount"
    description: "Direct Price Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_DP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: wel_cost_amount {
    label: "Drug Welfare Cost Amount"
    description: "Welfare Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_WEL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: 340b_cost_amount {
    label: "Drug 340B Medicare Part D Cost Amount"
    description: "340B Medicare Part D Cost of the Drug"
    type: number
    sql: ${TABLE}.DRUG_340B_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #################################################################################################### Measures #########################################################################################################
  measure: sum_acq_cost_amount {
    label: "Total Drug Acquisition Cost Amount"
    description: "Acquisition Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_ACQ_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_awp_cost_amount {
    label: "Total Drug Average Wholesale Price Cost Amount"
    description: "Average Wholesale Price Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_wac_cost_amount {
    label: "Total Drug Wholesaler Acquisition Cost Amount"
    description: "Wholesaler Acquisition Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_WAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_mac_cost_amount {
    label: "Total Drug Maximum Allowable Cost Amount"
    description: "Maximum Allowable Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_MAC_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_reg_cost_amount {
    label: "Total Drug Regular Cost Amount"
    description: "Regular Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_REG_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_dp_cost_amount {
    label: "Total Drug Direct Price Cost Amount"
    description: "Direct Price Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_DP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_wel_cost_amount {
    label: "Total Drug Welfare Cost Amount"
    description: "Welfare Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_WEL_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_340b_cost_amount {
    label: "Total Drug 340B Medicare Part D Cost Amount"
    description: "340B Medicare Part D Cost of the Drug"
    type: sum
    sql: ${TABLE}.DRUG_340B_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################################################## End of Measures #################################################################################################
  ############################################# Sets #####################################################

  set: explore_rx_store_drug_cost_pivot_4_10_candidate_list {
    fields: [
      sum_acq_cost_amount,
      sum_awp_cost_amount,
      sum_wac_cost_amount,
      sum_mac_cost_amount,
      sum_reg_cost_amount,
      sum_dp_cost_amount,
      sum_wel_cost_amount,
      sum_340b_cost_amount
    ]
  }
}

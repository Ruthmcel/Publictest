view: ar_drug_cost_hist {
  derived_table: {
    sql: select ndc,drug_cost_gpi,drug_cost_effective_start_date,drug_cost_effective_end_date,unit_price,drug_cost_form,drug_cost_gcn,drug_cost_gsn,drug_cost_type
                from
                 (
                    select
                    ndc,
                    drug_cost_gpi,
                    drug_cost_effective_start_date,
                    drug_cost_effective_end_date,
                    drug_cost_unit_amount as unit_price,
                    drug_cost_form,
                    drug_cost_gcn,
                    drug_cost_gsn,
                    drug_cost_type,
                    row_number() over (partition by ndc,drug_cost_type,drug_cost_effective_start_date order by source_timestamp desc) as rnk
                    from edw.d_drug_cost_hist
                    where chain_id = 3000
                    and source_system_id = 8 -- Absolute AR
                  ) dc
                where dc.rnk = 1;;
  }

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  ## Added DRUG COST TYPE to Unique Key as we are partitioning and keeping one row per each drug cost type
  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${drug_ndc} ||'@'|| ${drug_cost_effective_start_time} || '@' || ${drug_cost_type} ;;
  }

  dimension: drug_ndc {
    type: number
    label: "Drug NDC"
    description: "National Drug Code that represents the drug"
    hidden: yes
    sql: ${TABLE}.NDC ;;
  }

  dimension: drug_cost_type {
    type: string
    label: "Drug Cost Type"
    description: "Drug Cost Type (AWP, WAC, etc)"
    hidden: yes
    sql: ${TABLE}.DRUG_COST_TYPE ;;
  }

  dimension_group: drug_cost_effective_start {
    type: time
    label: "Drug Cost Effective Start"
    description: "The date/time at which this drug cost record became effective"
    sql: ${TABLE}.DRUG_COST_EFFECTIVE_START_DATE ;;
  }

  dimension_group: drug_cost_effective_end {
    type: time
    label: "Drug Cost Effective End"
    description: "The date/time at which this drug cost record ceased to be in effect"
    sql: ${TABLE}.DRUG_COST_EFFECTIVE_END_DATE ;;
  }

  dimension: drug_cost_form {
    type: string
    label: "Drug Cost Form"
    description: "Form in which this drug associated with this record is dispensed"
    sql: ${TABLE}.DRUG_COST_FORM ;;
  }

  dimension: drug_cost_gcn {
    type: string
    label: "Drug Cost GCN"
    description: "First Data Bank Generic Code Number"
    sql: ${TABLE}.DRUG_COST_GCN ;;
  }

  dimension: drug_cost_gsn {
    type: string
    label: "Drug Cost GSN"
    description: "First Data Bank Generic Sequence Number"
    sql: ${TABLE}.DRUG_COST_GSN ;;
  }

  dimension: drug_cost_gpi {
    type: string
    label: "Drug Cost GPI"
    description: "Medi-Span Generic Product Indicator"
    sql: ${TABLE}.DRUG_COST_GPI ;;
  }

#################################################################################### Measure  ##############################################################################################################
  dimension: drug_cost_unit_price_reference {
    type: number
    label: "Drug Cost Unit Price"
    description: "Unit Price of the Drug"
    sql: ${TABLE}.UNIT_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_cost_unit_price {
    type: sum
    label: "Drug Cost Unit Price"
    description: "Unit Price of the Drug"
    sql: ${TABLE}.UNIT_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

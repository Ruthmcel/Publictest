view: poc_eps_rx_tx {
  derived_table: {
    sql:

   Select * ,
   lead(SUM_NET_SALES) over (partition by chain_id,NHIN_STORE_ID,RX_TX_PRESC_CLINIC_LINK_ID order by SALES_QUARTER NULLS LAST) FUTURE_NET_SALES
   from (Select chain_id,NHIN_STORE_ID,RX_TX_PRESC_CLINIC_LINK_ID,sum(RX_TX_PRICE)RX_TX_PRICE, sum(RX_TX_DISCOUNT_AMOUNT) RX_TX_DISCOUNT_AMOUNT,
   sum(RX_TX_ACQUISITION_COST)RX_TX_ACQUISITION_COST ,
   sum(RX_TX_ORIGINAL_PRICE)RX_TX_ORIGINAL_PRICE ,sum(RX_TX_BRAND_PRICE)RX_TX_BRAND_PRICE ,SUM(RX_TX_GENERIC_PRICE)RX_TX_GENERIC_PRICE,
   SUM(RX_TX_BRAND_ACQUISITION_COST)RX_TX_BRAND_ACQUISITION_COST ,sum(RX_TX_GENERIC_ACQUISITION_COST)RX_TX_GENERIC_ACQUISITION_COST ,
   SUM(RX_TX_DAYS_SUPPLY)RX_TX_DAYS_SUPPLY,sum(RX_TX_FILL_QUANTITY)RX_TX_FILL_QUANTITY,
   sum (CASE WHEN RX_TX_FILL_STATUS is not null and RX_TX_RETURNED_DATE is null
   and RX_TX_WILL_CALL_PICKED_UP_DATE is not null then RX_TX_PRICE - RX_TX_DISCOUNT_AMOUNT else 0 end ) SUM_NET_SALES,
   sum (CASE WHEN RX_TX_FILL_STATUS is not null and RX_TX_RETURNED_DATE is null
   and RX_TX_WILL_CALL_PICKED_UP_DATE is not null then 1 else 0 end ) SUM_SCRIPTS,
   Case when quarter( RX_TX_WILL_CALL_PICKED_UP_DATE) = 1 then extract('year', RX_TX_WILL_CALL_PICKED_UP_DATE)|| 'Q1'
   when quarter( RX_TX_WILL_CALL_PICKED_UP_DATE) = 2 then extract('year', RX_TX_WILL_CALL_PICKED_UP_DATE)|| 'Q2'
   when quarter( RX_TX_WILL_CALL_PICKED_UP_DATE) = 3 then extract('year', RX_TX_WILL_CALL_PICKED_UP_DATE)|| 'Q3'
   when quarter( RX_TX_WILL_CALL_PICKED_UP_DATE) = 4 then extract('year', RX_TX_WILL_CALL_PICKED_UP_DATE)|| 'Q4' ELSE
   NULL end
   AS SALES_QUARTER,
   sum (CASE WHEN RX_TX_FILL_STATUS = 'N' then 1 else 0 end) NEWFILL_COUNT,
   sum (CASE WHEN RX_TX_FILL_STATUS = 'R' then 1 else 0 end) REFILLS_COUNT,
   sum (CASE WHEN RX_TX_DRUG_DISPENSED = 'G' then 1 else 0 end) BRAND_COUNT,
   sum (CASE WHEN RX_TX_DRUG_DISPENSED = 'B' then 1 else 0 end) GENERIC_COUNT,
   sum (CASE WHEN RX_TX_DRUG_DISPENSED = 'C' then 1 else 0 end) COMP_COUNT,
   count (distinct RX_TX_DISPENSED_DRUG_NDC) DISTINCT_NDC_COUNT
   from EDW.F_RX_TX_LINK
   WHERE  --(CHAIN_ID  = 70) and
    RX_TX_WILL_CALL_PICKED_UP_DATE between '2016-01-01' and  '2018-01-01'
   GROUP BY chain_id,NHIN_STORE_ID,RX_TX_PRESC_CLINIC_LINK_ID,
   SALES_QUARTER
   ) Trans_summary  ;;
      }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${Prescriber_clinic_link_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
   # hidden: yes
    label: " RX TX Chain ID"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

   dimension: Prescriber_clinic_link_id {
    label: "Prescription Clinic ID"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESC_CLINIC_LINK_ID ;;
  }

  dimension: sales_quarter{
    label: "Sales Quarter"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: string
    sql: ${TABLE}.SALES_QUARTER ;;
  }

  measure: Brand_price {
    label: "Brand Price "
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    sql:  ${TABLE}.RX_TX_BRAND_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: Generic_price {
    label: "Generic Price "
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    sql:  ${TABLE}.RX_TX_GENERIC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: Brand_acq_cost {
    label: "Brand Acquisition Price"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    sql:  ${TABLE}.RX_TX_BRAND_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: Generic_acq_price {
    label: "Generic Acquisition Price"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    sql:  ${TABLE}.RX_TX_GENERIC_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: Acquisition_cost {
    label: "Acquisition Cost "
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    sql:  ${TABLE}.RX_TX_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }


 measure: sum_net_sales {
    label: "Net Sales"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.SUM_NET_SALES  ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_sum_net_sales {
    label: "Avg Net Sales"
    description: "Average acquisition cost of filled drug. Calculation Used: Acquisition Cost/Total no. of scripts"
    type: number
    sql: COALESCE(${sum_net_sales}/NULLIF(${sum_scripts},0),0) ;;

  }

  measure: sum_future_net_sales {
    label: "Future Net Sales"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: number
    sql: sum(${TABLE}.FUTURE_NET_SALES )  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_scripts {
    label: "Tot No of Script"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.SUM_SCRIPTS  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_acquisition_cost {
    label: "Avg Acquisition Cost"
    description: "Average acquisition cost of filled drug. Calculation Used: Acquisition Cost/Total no. of scripts"
    type: number
    sql: COALESCE(${Acquisition_cost}/NULLIF(${sum_scripts},0),0) ;;

  }

  measure: Days_of_supply{
    label: "Days of Supply"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: sum
    #hidden: yes
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY ;;
  }

  measure: avg_days_of_supply {
    label: "Avg Days of supply"
    description: "Average acquisition cost of filled drug. Calculation Used: Acquisition Cost/Total no. of scripts"
    type: number
    #hidden: yes
    sql: COALESCE(${Days_of_supply}/NULLIF(${sum_scripts},0),0) ;;

  }

  measure: sum_fill_quantity {
    label: "Fill Quantity"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.RX_TX_FILL_QUANTITY  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_fill_quantity {
    label: "Avg Fill Quantity"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: number
    sql: COALESCE(${sum_fill_quantity}/NULLIF(${sum_scripts},0),0);;
    #value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: newfill_count {
    label: "Newfill Count"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.NEWFILL_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: refill_count {
    label: "Refill Count"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.REFILLS_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: brand_count {
    label: "Brand Count"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.BRAND_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: generic_count {
    label: "Generic Count"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.GENERIC_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: cmpd_count {
    label: "Compound Count"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.COMP_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }
  measure: ndc_count {
    label: "Unique Dispensed NDC"
    #group_label: "Net Sales"
    description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount"
    type: sum
    sql: ${TABLE}.DISTINCT_NDC_COUNT  ;;
    #value_format: "$#,##0.00;($#,##0.00)"
  }




  }

view: rx_tx_store_drug_cost_hist {
  #This view is primarily added to show AWP Cost of the Drug from store and Prescription Transaction AWP Cost at the time of the fill from respective store , only for EPS transactional dataset & may be extended to Classic in the future.
  #[ERXLPS-2295] - Logic added to calculate Drug Cost at the time of fill for AWP, WAC, ACQ, REG, MAC, STD and DP
  derived_table: {
    sql: select chain_id,
       nhin_store_id,
       rx_tx_id,
       store_drug_ndc,
       max(CASE WHEN store_drug_cost_type = 'AWP' THEN drug_cost END) as drug_awp_cost,
       max(CASE WHEN store_drug_cost_type = 'AWP' THEN drug_cost_per_unit_amount END) as drug_awp_cost_per_unit_amount,
       max(CASE WHEN store_drug_cost_type = 'ACQ' THEN drug_cost_per_unit_amount END) as drug_acq_cost_per_unit_amount,
       max(CASE WHEN store_drug_cost_type = 'AWP' THEN rx_tx_cost_at_fill END) as rx_tx_awp_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'WAC' THEN rx_tx_cost_at_fill END) as rx_tx_wac_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'ACQ' THEN rx_tx_cost_at_fill END) as rx_tx_acq_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'REG' THEN rx_tx_cost_at_fill END) as rx_tx_reg_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'MAC' THEN rx_tx_cost_at_fill END) as rx_tx_mac_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'STD' THEN rx_tx_cost_at_fill END) as rx_tx_std_cost_at_fill,
       max(CASE WHEN store_drug_cost_type = 'DP' THEN rx_tx_cost_at_fill END) as rx_tx_dp_cost_at_fill
from   (select tx.chain_id,
               tx.nhin_store_id,
               tx.rx_tx_id,
               d.store_drug_ndc,
               dct.store_drug_cost_type,
               d.store_drug_package_size,
               dch.store_drug_cost_amount as drug_cost,
               tx.rx_tx_fill_quantity,
               (dch.store_drug_cost_amount/nullif(d.store_drug_package_size, 0)) as drug_cost_per_unit_amount,
               ((dch.store_drug_cost_amount/nullif(d.store_drug_package_size, 0))*tx.rx_tx_fill_quantity) as rx_tx_cost_at_fill, -- ( (Cost of the Drug for respective drug cost type, divided by drug cost per unit amount (i.e. Decimal Pack size of the Drug)), multiplied by decimal fill quantity of the transaction at the time of dispensing )
               tx.rx_tx_price, --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
               row_number() over(partition by tx.chain_id, tx.nhin_store_id, tx.rx_tx_id, dct.store_drug_cost_type order by dch.source_timestamp desc) rnk
          from {% if _explore._name == 'sales' %}
                 {% assign active_archive_filter_input_value = sales.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                 {% if active_archive_filter_input_value == 'archive'  %}
                   EDW.F_RX_TX_LINK_ARCHIVE TX
                 {% else %}
                   EDW.F_RX_TX_LINK TX
                 {% endif %}
               {% else %}
                 EDW.F_RX_TX_LINK TX
               {% endif %}
               --[ERXDWPS-7176] added for performance improvement
               inner join report_calendar_global cal
               on (    tx.chain_id = cal.chain_id
                       --[ERXDWPS-7176] - Sales Explore report_calendar_global join conditions are implemented to filter same transactions for history NO condition.
                       --[ERXDWPS-7176] - Reportable, sold and returned dates are compared with calendar date for history YES condition to filter required rx_tx_link records.
                   and (
                        ({% parameter sales.history_filter %} = 'NO'
                         and cal.calendar_date = (case when {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES' then to_date(tx.rx_tx_reportable_sales_date)
                                                       when {% parameter sales.date_to_use_filter %} = 'SOLD' then to_date(tx.rx_tx_will_call_picked_up_date)
                                                       when {% parameter sales.date_to_use_filter %} = 'FILLED' then to_date(tx.rx_tx_fill_date)
                                                       when {% parameter sales.date_to_use_filter %} = 'RETURNED' then to_date(tx.rx_tx_returned_date)
                                                   end
                                                 )
                        )
                       or
                        ({% parameter sales.history_filter %} = 'YES'
                          and (case when cal.calendar_date = to_date(tx.rx_tx_will_call_picked_up_date) then 1
                                    when cal.calendar_date = to_date(tx.rx_tx_reportable_sales_date) then 1
                                     when cal.calendar_date = to_date(tx.rx_tx_returned_date) then 1
                                     else 2
                               end = 1)
                        )
                       )
                  )
               left outer join edw.d_store_drug d
               on (    d.chain_id = tx.chain_id
                   and d.nhin_store_id = tx.nhin_store_id
                   and d.drug_id = tx.rx_tx_drug_dispensed_id --ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
                   and d.store_drug_deleted = 'N'
                   and d.source_system_id = 4
                   and {% condition chain.chain_id %} d.chain_id {% endcondition %}) --[ERXDWPS-7176]
               left outer join edw.d_store_drug_cost_hist dch
               on (    dch.chain_id = d.chain_id
                   and dch.nhin_store_id = d.nhin_store_id
                   and to_char(dch.drug_id) = d.drug_id
                   and dch.store_drug_cost_deleted = 'N' --ERXLPS-1845
                   and dch.source_timestamp <= tx.rx_tx_fill_date
                   and {% condition chain.chain_id %} dch.chain_id {% endcondition %}) --[ERXDWPS-7176]
               inner join edw.d_store_drug_cost_type dct
               on (    dch.chain_id = dct.chain_id
                   and dch.nhin_store_id = dct.nhin_store_id
                   and dch.drug_cost_type_id = dct.drug_cost_type_id
                   and upper(dct.store_drug_cost_type) IN ('AWP', 'WAC', 'ACQ', 'REG', 'MAC', 'STD', 'DP')
                   and {% condition chain.chain_id %} dct.chain_id {% endcondition %}) --[ERXDWPS-7176]
         where {% condition chain.chain_id %} tx.chain_id {% endcondition %}
           and {% condition store.nhin_store_id %} tx.nhin_store_id {% endcondition %}
           and tx.source_system_id = 4
           -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
           and tx.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                      where source_system_id = 5
                                        and {% condition chain.chain_id %} chain_id {% endcondition %}
                                        and {% condition store.store_number %} store_number {% endcondition %})
       ) rx_tx_dch
where  rx_tx_dch.rnk = 1
group by chain_id,
         nhin_store_id,
         rx_tx_id,
         store_drug_ndc
 ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id} ;;
  }

  #################################################################################################### Foreign Key References #####################################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Cost History Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    label: "Drug Cost History NHIN Store ID"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    hidden: yes
    type: number
    label: "Drug Cost History Prescription Transaction Identifier"
    sql: ${TABLE}.RX_TX_ID ;;
  }

  #################################################################################################### Reference Dimension #######################################################################################
  dimension: drug_awp_cost_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_AWP_COST ;;
  }

  dimension: drug_awp_cost_per_unit_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT ;;
  }

  #[ERXDWPS-7024] - Reference dimension added.
  dimension: drug_acq_cost_per_unit_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_ACQ_COST_PER_UNIT_AMOUNT ;;
  }

  dimension: rx_tx_awp_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_AWP_COST_AT_FILL ;;
  }

  dimension: rx_tx_wac_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_WAC_COST_AT_FILL ;;
  }

  dimension: rx_tx_acq_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_ACQ_COST_AT_FILL ;;
  }

  dimension: rx_tx_reg_cost_amount_at_fill_reference {
    hidden:yes
    type: number
    sql: ${TABLE}.RX_TX_REG_COST_AT_FILL ;;
  }

  dimension: rx_tx_mac_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_MAC_COST_AT_FILL ;;
  }

  dimension: rx_tx_std_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_STD_COST_AT_FILL ;;
  }

  dimension: rx_tx_dp_cost_amount_at_fill_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_DP_COST_AT_FILL ;;
  }

  #################################################################################################### Measures #########################################################################################################
  measure: sum_drug_awp_cost_amount {
    label: "Total Pharmacy Drug AWP Amount"
    description: "Represents the Average Wholesale Price of the Pharmacy Drug at the time of fill. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.DRUG_AWP_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_awp_cost_per_unit_amount {
    label: "Total Pharmacy Drug AWP Per Unit Amount"
    description: "Represents the Average Wholesale Price of the Pharmacy Drug Per Unit Amount at the time of fill. (Calculation Used: Pharmacy Drug AWP Amount/Decimal Pack Size). This field is EPS only!!!"
    type: number
    #[ERXLPS-1347] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
    sql: ( SUM(DISTINCT (CAST(FLOOR(${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${TABLE}.CHAIN_ID||'@'||${TABLE}.NHIN_STORE_ID||'@'||${TABLE}.RX_TX_ID ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${TABLE}.DRUG_AWP_COST_PER_UNIT_AMOUNT IS NOT NULL THEN MD5_NUMBER(${TABLE}.CHAIN_ID||'@'||${TABLE}.NHIN_STORE_ID||'@'||${TABLE}.RX_TX_ID ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_rx_tx_awp_cost_amount_at_fill {
    label: "Total AWP Amount At Fill - Pharmacy"
    description: "Represents the Pharmacy Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug AWP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
    type: sum
    group_label: "Drug Cost at Fill"
    sql: ${TABLE}.RX_TX_AWP_COST_AT_FILL ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################################################## End of Measures #################################################################################################
  ################################################################################# Sets###################################################################################

  set: explore_rx_store_drug_cost_hist_4_10_candidate_list {
    fields: [sum_drug_awp_cost_amount, sum_drug_awp_cost_per_unit_amount, sum_rx_tx_awp_cost_amount_at_fill]
  }
}

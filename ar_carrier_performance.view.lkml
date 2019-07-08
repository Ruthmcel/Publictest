view: ar_carrier_performance {
  derived_table: {
    sql: WITH
      nhin_type
      AS (SELECT
          nhin_type_id,
          nhin_type_description
          FROM EDW.D_NHIN_TYPE
         )
      SELECT chain_id,
        nhin_store_id,
        transaction_id,
        store_id,
        store_division,
        store_npi,
        nabp_num,
        contract_name,
        contract_rate_network_name,
        carrier_code,
        plan_name,
        plan_code,
        group_code,
        rx_num,
        tx_num,
        fill_date,
        sold_date,
        drug_name,
        drug_ndc,
        tax_amt,
        bin_num,
        pcn_num,
        basis_of_reimb,
        network_reimb_id,
        bgdesc,
        processor_id,
        msdesc,
        transaction_type,
        days_supply,
        split_type,
        plan_type,
        dispensed_qty,
        acq_cost,
        awp_price,
        wac_price,
        effective_start_date,
        copay_collected,
        dispd_fee_paid,
        gpi,
        uc_price,
        tp_paid,
        tot_paid,
        paid_below_acq_cost,
        paid_at_uc_price,
        ingredient_cost_paid,
        awp_discount,
        wac_discount,
        paid_per_unit
      from
      (select ts.chain_id,
        ts.nhin_store_id,
        ts.transaction_id,
        st.store_number AS store_id,
        st.store_division AS store_division,
        st.store_npi_number AS store_npi,
        st.store_ncpdp_number AS nabp_num,
        tpc.third_party_contract_name as contract_name,
        cr.contract_rate_network_name,
        cp.carrier_code,
        cp.plan_name,
        cp.plan_code,
        ti.group_code,
        ts.rx_num,
        ts.tx_num,
        ts.fill_date,
        ts.sold_date,
        ti.drug_name,
        ti.drug_ndc,
        ti.tax_amt,
        ti.bin_num,
        ti.pcn_num,
        ti.basis_of_reimb,
        ti.network_reimb_id,
        (CASE
          WHEN nd.drug_multi_source IS NULL THEN 'OTHER'
          WHEN nd.drug_multi_source = 'Y' THEN 'GENERIC'
          ELSE 'BRAND'
        END) AS bgdesc,
        ts.processor_id,
        nd.drug_multi_source AS msdesc,
        NVL(clmtp.nhin_type_description, '') AS transaction_type,
        ti.tx_dec_qty,
        ti.days_supply,
        nt.nhin_type_description AS split_type,
        pt.nhin_type_description as plan_type,
        (CASE
          WHEN ti.tx_dec_qty <= 0 OR
            dch.unit_price IS NULL OR
            dch.unit_price <= 0 THEN NULL
          WHEN ROUND((ti.tx_dec_qty * dch.unit_price), 2) = 0 THEN .01
          ELSE ROUND((ti.tx_dec_qty * dch.unit_price), 2)
        END) AS awp_price,
        (CASE
          WHEN ti.tx_dec_qty <= 0 OR
            wac.unit_price IS NULL OR
            wac.unit_price <= 0 THEN NULL
          WHEN ROUND((ti.tx_dec_qty * wac.unit_price), 2) = 0 THEN .01
          ELSE ROUND((ti.tx_dec_qty * wac.unit_price), 2)
        END) AS wac_price,
        (CASE
          WHEN ti.tx_dec_qty <= 0 OR
            dch.unit_price IS NULL OR
            dch.unit_price <= 0 THEN NULL
          ELSE dch.effective_start_date
        END) AS effective_start_date,
        NVL(ti.copay_amt, 0) AS copay_collected,
        (CASE
          WHEN ti.transaction_info_dispensing_fee_paid > 0 THEN ti.transaction_info_dispensing_fee_paid
          WHEN ti.cost <= 0 THEN NULL
          ELSE (ti.rx_price - ti.cost)
        END) AS dispd_fee_paid,
        dch.gpi,
        ti.tx_dec_qty as dispensed_qty,
        ti.acq_cost AS acq_cost,
        ti.uc_price AS uc_price,
        CASE WHEN (NVL(ti.copay_amt, 0) + ts.tot_paid_amt) < NVL(ti.acq_cost,0) THEN 'Y' ELSE 'N' END paid_below_acq_cost,
        CASE WHEN (NVL(ti.copay_amt, 0) + ts.tot_paid_amt) = NVL(ti.uc_price,0) THEN 'Y' ELSE 'N' END paid_at_uc_price,
        dch.effective_start_date AS dch_effective_start_date,
        dch.effective_end_date AS dch_effective_end_date,
        wac.effective_start_date AS wac_effective_start_date,
        wac.effective_end_date AS wac_effective_end_date,
        (ts.tot_paid_amt) AS tp_paid,
        (NVL(ti.copay_amt, 0) + ts.tot_paid_amt) AS tot_paid,
        (CASE
          WHEN ti.transaction_info_ingredient_cost_paid > 0 THEN ti.transaction_info_ingredient_cost_paid
          WHEN ti.cost <= 0 THEN NULL
          ELSE ((NVL(ti.copay_amt, 0) + ts.tot_paid_amt) - (ti.rx_price - ti.cost) - ti.tax_amt)
        END) AS ingredient_cost_paid,
        (CASE
                WHEN ti.tx_dec_qty<=0
                OR  dch.unit_price IS NULL
                OR  dch.unit_price <= 0
                OR  split_bill_opt>197
                THEN NULL
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                        AND (ti.tx_dec_qty*dch.unit_price) = 0
                   THEN ti.transaction_info_ingredient_cost_paid
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                        AND (ti.tx_dec_qty*dch.unit_price) = ti.transaction_info_ingredient_cost_paid
                   THEN 0
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                   THEN 100 - ((CAST ((ti.transaction_info_ingredient_cost_paid) AS DECIMAL(15,2)) / nullif(CAST((ti.tx_dec_qty*dch.unit_price) AS DECIMAL(15,2)),0) ) * 100)
                WHEN ti.cost <= 0 THEN NULL
                WHEN (ti.tx_dec_qty*dch.unit_price) = 0
                THEN ((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt)
                WHEN (ti.tx_dec_qty*dch.unit_price) = ((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt)
                THEN 0
                ELSE 100 - ((CAST (((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt) AS DECIMAL(15,2)) / nullif(CAST((ti.tx_dec_qty*dch.unit_price) AS DECIMAL(15,2)),0) ) * 100)

            END) as awp_discount,
        (CASE
                WHEN ti.tx_dec_qty<=0
                OR  wac.unit_price IS NULL
                OR  wac.unit_price <= 0
                OR  split_bill_opt>197
                THEN NULL
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                        AND (ti.tx_dec_qty*wac.unit_price) = 0
                   THEN ti.transaction_info_ingredient_cost_paid
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                        AND (ti.tx_dec_qty*wac.unit_price) = ti.transaction_info_ingredient_cost_paid
                   THEN 0
                WHEN ti.transaction_info_ingredient_cost_paid > 0
                   THEN 100 - ((CAST ((ti.transaction_info_ingredient_cost_paid) AS DECIMAL(15,2)) / nullif(CAST((ti.tx_dec_qty*wac.unit_price) AS DECIMAL(15,2)),0) ) * 100)
                WHEN ti.cost <= 0 THEN NULL
                WHEN (ti.tx_dec_qty*wac.unit_price)  = 0
                THEN ((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt)
                WHEN (ti.tx_dec_qty*wac.unit_price) = ((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt)
                THEN 0
                ELSE 100 - ((CAST (((NVL(ti.copay_amt,0)+ts.tot_paid_amt)-(ti.rx_price-ti.cost)-ti.tax_amt) AS DECIMAL(15,2)) / nullif(CAST((ti.tx_dec_qty*wac.unit_price) AS DECIMAL(15,2)),0) ) * 100)
            END) AS wac_discount,
        (CASE
          WHEN ti.cost <= 0 OR
            ti.tx_dec_qty <= 0 THEN NULL
          ELSE (((NVL(ti.copay_amt, 0) + ts.tot_paid_amt) - (ti.rx_price - ti.cost) - ti.tax_amt) / nullif(ti.tx_dec_qty,0))
        END) AS paid_per_unit
      FROM (select
            chain_id,
            transaction_status_nhin_store_id as nhin_store_id,
            transaction_id,
            transaction_status_rx_number as rx_num,
            transaction_status_tx_number as tx_num,
            transaction_status_fill_date as fill_date,
            transaction_status_sold_date as sold_date,
            transaction_status_processor_id as processor_id,
            nvl((case
                    when {% condition paid_amount_filter %} 'Actual Payments' {% endcondition %}
                    then transaction_status_total_paid_amount/100
                    else transaction_status_submit_amount/100
                end),0) AS tot_paid_amt,
            transaction_status_transaction_location as transaction_location,
            transaction_status_transaction_type_id as transaction_type,
            transaction_status_split_bill_opt_type_id as split_bill_opt,
            transaction_status_credit_date as cr_date,
            transaction_status_plan_id as plan_id
            from edw.f_transaction_status
            where transaction_status_deleted = 'N'
            and {% condition ar_chain.chain_id %} chain_id {% endcondition %}
            and {% condition store_filter %} transaction_status_nhin_store_id {% endcondition %}
            and (
                  (
                    {% condition paid_amount_filter %} 'Actual Payments' {% endcondition %}
                    and
                    (
                      transaction_status_total_paid_amount > 0
                      and transaction_status_transaction_location = 5900
                    )
                  )
                  or
                  (
                    {% condition paid_amount_filter %} 'Adjudicated Amount' {% endcondition %}
                    and
                    (
                      transaction_status_transaction_location IN (5900,5901,5903)
                    )
                  )
                )
            and (
                  (
                    {% condition exclude_zero_dollar_claim_filter %} 'YES' {% endcondition %}
                    and
                    (
                      transaction_status_submit_amount <> 0 -- Excludes $0 Claims
                    )
                  )
                  or
                  (
                    {% condition exclude_zero_dollar_claim_filter %} 'NO' {% endcondition %}
                    and
                    (
                      1 = 1
                    )
                  )
                )
            and (
                  (
                    {% condition exclude_credit_returns_filter %} 'YES' {% endcondition %}
                    and
                    (
                      transaction_status_credit_date IS NULL -- Excludes Credit Returns
                    )
                  )
                  or
                  (
                    {% condition exclude_credit_returns_filter %} 'NO' {% endcondition %}
                    and
                    (
                      1 = 1
                    )
                  )
                )
            and (
                  (
                    {% condition include_split_bill_filter %} 'YES' {% endcondition %}
                    and
                    (
                      transaction_status_split_bill_opt_type_id in (196,197,198,199,1500,1504,1505,1506,1507,1508,1509)
                    )
                  )
                  or
                  (
                    {% condition include_split_bill_filter %} 'NO' {% endcondition %}
                    and
                    (
                      transaction_status_split_bill_opt_type_id in (196, 197)
                    )
                  )
                )
            and {% condition fill_date_filter %} transaction_status_fill_date {% endcondition %}
            and {% condition sold_date_filter %} transaction_status_sold_date {% endcondition %}
            ) ts
            left outer join
            (select
              chain_id,
              transaction_id,
              transaction_info_group_code as group_code,
              transaction_info_drug_name as drug_name,
              transaction_info_drug_ndc as drug_ndc,
              nvl(transaction_info_tax_amount/100,0) AS tax_amt,
              transaction_info_bin_number as bin_num,
              transaction_info_pcn_number as pcn_num,
              transaction_info_basis_of_reimbursement as basis_of_reimb,
              transaction_info_network_reimbursement_id as network_reimb_id,
              nvl(transaction_info_tx_decimal_quantity,0) AS tx_dec_qty,
              transaction_info_days_supply as days_supply,
              nvl(transaction_info_acquisition_cost/100,0) AS acq_cost,
              nvl(transaction_info_copay_amount/100,0) AS copay_amt,
              nvl(transaction_info_cost/100,0) AS cost,
              nvl(transaction_info_rx_price/100,0) AS rx_price,
              nvl(transaction_info_uc_price/100,0) AS uc_price,
              nvl(transaction_info_dispensing_fee_paid/100,0) AS transaction_info_dispensing_fee_paid,
              nvl(transaction_info_ingredient_cost_paid/100,0) AS transaction_info_ingredient_cost_paid
              from edw.f_transaction_info
              where transaction_info_deleted = 'N'
              and {% condition ar_chain.chain_id %} chain_id {% endcondition %}
            ) ti
            on ts.chain_id = ti.chain_id
            and ts.transaction_id = ti.transaction_id
            left outer join edw.f_claim_to_contract_rate ccr
            on ts.chain_id = ccr.chain_id
            and ts.transaction_id = ccr.transaction_id
            left outer join edw.d_contract_rate cr
            on ccr.chain_id = cr.chain_id
            and ccr.third_party_contract_id = cr.contract_rate_third_party_contract_id
            and ccr.contract_rate_id = cr.contract_rate_id
            left outer join edw.d_third_party_contract tpc
            on ccr.chain_id = tpc.chain_id
            and ccr.third_party_contract_id = tpc.third_party_contract_id
            left outer join
            (select drug_ndc,gpi,effective_start_date,effective_end_date,unit_price
                from
                  (
                    select
                    ndc as drug_ndc,
                    drug_cost_gpi as gpi,
                    drug_cost_effective_start_date as effective_start_date,
                    drug_cost_effective_end_date as effective_end_date,
                    drug_cost_unit_amount as unit_price,
                    row_number() over (partition by ndc,drug_cost_effective_start_date order by source_timestamp desc) as rnk
                    from edw.d_drug_cost_hist
                    where chain_id = 3000
                    and source_system_id = 8 -- Absolute AR
                    and drug_cost_type IN ('AWP MS')
                  ) dc
                where dc.rnk = 1
            ) dch
            on ti.drug_ndc = dch.drug_ndc and ts.fill_date between dch.effective_start_date and dch.effective_end_date
            left outer join
            (select drug_ndc,gpi,effective_start_date,effective_end_date,unit_price
                from
                  (
                    select
                    ndc as drug_ndc,
                    drug_cost_gpi as gpi,
                    drug_cost_effective_start_date as effective_start_date,
                    drug_cost_effective_end_date as effective_end_date,
                    drug_cost_unit_amount as unit_price,
                    row_number() over (partition by ndc,drug_cost_effective_start_date order by source_timestamp desc) as rnk
                    from edw.d_drug_cost_hist
                    where chain_id = 3000
                    and source_system_id = 8 -- Absolute AR
                    and drug_cost_type IN ('WAC MS')
                  ) dc
                where dc.rnk = 1
            ) wac
            on ti.drug_ndc = wac.drug_ndc and ts.fill_date between wac.effective_start_date and wac.effective_end_date
            left outer join edw.d_drug nd
            on ti.drug_ndc = nd.ndc and nd.chain_id = 3000 and nd.source_system_id = 6 -- Using NHIN data as Absolute AR receives NHIN data too
            inner join edw.d_store st
            on ts.chain_id = st.chain_id and ts.nhin_store_id = st.nhin_store_id and st.source_system_id = 8 and upper(st.store_ar_activity_flag) = 'Y'
            left outer join
            /******** Fix done as per the issue identified in ERXDWPS-665 (Once fixed the below code will be replaced by a direct fork lift from EDW.D_PLAN ****/
            (select plan_carrier_plan_id,carrier_code,plan_name,plan_code,plan_type_id from
              (select
                  plan_carrier_plan_id,carrier_code,plan_name,plan_code,plan_type_id,
                  row_number() over (partition by chain_id,plan_carrier_plan_id order by plan_lcr_id desc) rnk
                  from edw.d_plan
                  where chain_id = 3000 and source_system_id = 8 -- Absolute AR
              ) cp_rnk
             where cp_rnk.rnk = 1
            ) cp
            on ts.plan_id = cp.plan_carrier_plan_id
            left outer join nhin_type nt
            on nt.nhin_type_id = ts.split_bill_opt
            left outer join nhin_type clmtp
            on clmtp.nhin_type_id = ts.transaction_type
            left outer join nhin_type pt
            on pt.nhin_type_id = cp.plan_type_id
            where {% condition carrier_filter %} cp.carrier_code {% endcondition %}
              and {% condition plan_filter %} cp.plan_code {% endcondition %}
              and (
                    (
                      {% condition brand_generic_filter %} 'All' {% endcondition %}                                 /** All brand and generic types **/
                      and ( 1 = 1 )
                    )
                    OR
                    (
                      {% condition brand_generic_filter %} 'Y=Generic product' {% endcondition %}                             /** Y=Generic product **/
                      and ( NVL(nd.drug_multi_source,'OTHER') IN ('Y') )
                    )
                    OR
                    (
                      {% condition brand_generic_filter %} 'All Brand - M, N, O' {% endcondition %}                               /** All brand types- M, N, O **/
                      and ( NVL(nd.drug_multi_source,'OTHER') NOT IN ('OTHER','Y') )
                    )
                    OR
                    (
                      {% condition brand_generic_filter %} 'M=Multi-source brand' {% endcondition %}                /** M=Multi-source brand (more than one branded version of a drug available) **/
                      and ( NVL(nd.drug_multi_source,'OTHER') IN ('M') )
                    )
                    OR
                    (
                      {% condition brand_generic_filter %} 'N=Single-source brand' {% endcondition %}               /** N=Single-source brand (a brand-name drug only, no generic(s) available) **/
                      and ( NVL(nd.drug_multi_source,'OTHER') IN ('N') )
                    )
                    OR
                    (
                      {% condition brand_generic_filter %} 'O=Brand drug product with generics' {% endcondition %}  /** O=Brand drug product with generics **/
                      and ( NVL(nd.drug_multi_source,'OTHER') IN ('O') )
                    )
                  )
      ) src
      WHERE ((
      dch_effective_start_date IS NULL
      AND dch_effective_end_date IS NULL)
      OR (
      fill_date BETWEEN dch_effective_start_date AND dch_effective_end_date))
      AND ((
      wac_effective_start_date IS NULL
      AND wac_effective_end_date IS NULL)
      OR (
      fill_date BETWEEN wac_effective_start_date AND wac_effective_end_date))
       ;;
  }

  dimension: chain_id {
    hidden: yes
    type: number
    # primary key in source
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_number {
    type: number
    label: "Rx Num"
    description: "Prescription number"
    sql: ${TABLE}.RX_NUM ;;
    value_format: "####"
  }

  dimension: tx_number {
    type: number
    label: "Tx Num"
    description: "Transaction number"
    sql: ${TABLE}.TX_NUM ;;
    value_format: "####"
  }

  dimension: transaction_id {
    type: number
    label: "Claim ID"
    sql: ${TABLE}.TRANSACTION_ID ;;
    value_format: "####"
  }

  dimension: store_id {
    type: string
    label: "Store ID"
    sql: ${TABLE}.STORE_ID ;;
  }

  dimension: store_division {
    type: string
    label: "Store Divison"
    sql: ${TABLE}.STORE_DIVISION ;;
  }

  dimension: store_npi {
    type: string
    label: "Store NPI"
    description: "Store NPI"
    sql: ${TABLE}.STORE_NPI ;;
  }

  dimension: nabp_num {
    type: string
    label: "NCPDP store #"
    description: "NABP Number"
    sql: ${TABLE}.NABP_NUM ;;
  }

  dimension: contract_name {
    type: string
    label: "Master Contract Name"
    sql: ${TABLE}.CONTRACT_NAME ;;
  }

  dimension: contract_rate_network_name {
    type: string
    label: "Rate/Network Name"
    sql: ${TABLE}.CONTRACT_RATE_NETWORK_NAME ;;
  }

  dimension: carrier_code {
    type: string
    label: "Carrier Code"
    sql: ${TABLE}.CARRIER_CODE ;;
  }

  dimension: carrier_name {
    type: string
    label: "Carrier Name"
    sql: ${TABLE}.PLAN_NAME ;;
  }

  dimension: plan_code {
    type: string
    label: "Plan Code"
    sql: ${TABLE}.PLAN_CODE ;;
  }

  dimension: plan_type {
    type: string
    label: "Plan Type"
    sql: ${TABLE}.PLAN_TYPE ;;
  }

  dimension: group_code {
    type: string
    label: "Group Code"
    sql: ${TABLE}.GROUP_CODE ;;
  }

  dimension: bin_number {
    type: string
    label: "BIN"
    sql: ${TABLE}.BIN_NUM ;;
  }

  dimension: pcn_number {
    type: string
    label: "PCN"
    sql: ${TABLE}.PCN_NUM ;;
  }

  dimension: drug_name {
    type: string
    label: "Drug Name"
    sql: ${TABLE}.DRUG_NAME ;;
  }

  dimension: drug_ndc {
    type: string
    label: "Drug NDC"
    sql: ${TABLE}.DRUG_NDC ;;
  }

  dimension: gpi {
    type: string
    label: "Drug GPI"
    sql: ${TABLE}.GPI ;;
  }

  measure: basis_of_reimb {
    type: string
    label: "Basis of Reimbursement Code"
    # defined as a measure with MAX to be able to place the field between other measure fields (as-is in CPR V2 report
    sql: MAX(${TABLE}.BASIS_OF_REIMB) ;;
  }

  dimension: network_reimb_id {
    type: string
    label: "Network ID"
    sql: ${TABLE}.NETWORK_REIMB_ID ;;
  }

  dimension: bg_desc {
    type: string
    label: "B/G"
    sql: ${TABLE}.BGDESC ;;
  }

  dimension: msdesc {
    type: string
    label: "MSB"
    sql: ${TABLE}.MSDESC ;;
  }

  dimension: processor_id {
    type: string
    label: "Payer"
    sql: ${TABLE}.PROCESSOR_ID ;;
  }

  dimension: days_supply {
    type: number
    label: "Days Supply"
    sql: ${TABLE}.DAYS_SUPPLY ;;
  }

  dimension: paid_below_acq_cost {
    type: string
    label: "Paid Below Acq Cost"
    description: "Y/N Flag Indicating if the transaction was paid below the Acquisition Cost"
    sql: ${TABLE}.PAID_BELOW_ACQ_COST ;;
    suggestions: ["Y", "N"]
  }

  dimension: paid_at_uc_price {
    type: string
    label: "Paid At UC Price"
    description: "Y/N Flag Indicating if the transaction was paid at Usual and Customary Pricing"
    sql: ${TABLE}.PAID_AT_UC_PRICE ;;
    suggestions: ["Y", "N"]
  }

  dimension_group: filled {
    label: "Fill"
    description: "Date prescription was filled"
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
    sql: ${TABLE}.FILL_DATE ;;
  }

  dimension_group: sold {
    label: "Sold"
    description: "Date prescription was sold"
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
    sql: ${TABLE}.SOLD_DATE ;;
  }

  ############################# Dimensions defined as measure with MAX to be able to place the field between other measure fields in Detail Analysis (to match CPR v2 format) ######################

  measure: type_desc {
    type: string
    label: "Claim Type"
    sql: MAX(${TABLE}.TRANSACTION_TYPE) ;;
  }

  measure: split_desc {
    type: string
    label: "Split Bill"
    sql: MAX(${TABLE}.SPLIT_TYPE) ;;
  }

  measure: days_supply_max {
    type: number
    label: "Days Supply "
    sql: MAX(${TABLE}.DAYS_SUPPLY) ;;
  }

  measure: drug_effective_start {
    label: "AWP Date"
    type: date
    sql: MAX(${TABLE}.EFFECTIVE_START_DATE) ;;
  }

  #####################################################################################  Measures ##########################################################################

  measure: sum_networks {
    label: "Total Unique Networks"
    type: number
    sql: COUNT(DISTINCT(${TABLE}.CONTRACT_RATE_NETWORK_NAME)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_carrier {
    label: "Total Carriers"
    type: number
    sql: COUNT(DISTINCT(${TABLE}.CARRIER_CODE)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_plan {
    label: "Total Plans"
    type: number
    sql: COUNT(DISTINCT(${TABLE}.PLAN_CODE)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_group {
    label: "Total Groups"
    type: number
    sql: COUNT(DISTINCT(${TABLE}.GROUP_CODE)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tx_decimal_qty {
    label: "Transaction Decimal Quantity"
    type: sum
    sql: ${TABLE}.TX_DECIMAL_QTY ;;
    value_format: "###0.00"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_dispensed_qty {
    label: "Dispensed Qty"
    type: sum
    sql: ${TABLE}.DISPENSED_QTY ;;
    value_format: "###0.00"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_acq_cost {
    label: "Acquisition Cost"
    type: sum
    sql: NVL(${TABLE}.ACQ_COST,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_awp_price {
    label: "AWP Price"
    type: sum
    sql: ${TABLE}.AWP_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_wac_price {
    label: "WAC Price"
    type: sum
    sql: ${TABLE}.WAC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_awp_discount {
    label: "AWP Discount"
    type: sum
    sql: ${TABLE}.AWP_DISCOUNT ;;
    value_format: "#,##0.00" #[ERXLPS-1966]
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_wac_discount {
    label: "WAC Discount"
    type: sum
    sql: ${TABLE}.WAC_DISCOUNT ;;
    value_format: "#,##0.00" #[ERXLPS-1966]
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_copay_collected {
    label: "Copay Collected"
    type: sum
    sql: ${TABLE}.COPAY_COLLECTED ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tax_amount {
    label: "Tax"
    type: sum
    sql: ${TABLE}.TAX_AMT ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_uc_price {
    label: "U&C Price"
    type: sum
    sql: ${TABLE}.UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tp_paid {
    label: "TP Paid Amt"
    type: sum
    sql: ${TABLE}.TP_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tot_paid {
    label: "Total Paid Amt"
    type: sum
    sql: ${TABLE}.TOT_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_claim {
    label: "Total Claims"
    type: number
    sql: COUNT(DISTINCT(${TABLE}.TRANSACTION_ID)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_claim_with_network_name {
    label: "Total Claims With Network Name"
    type: number
    sql: CASE WHEN ${contract_rate_network_name} IS NOT NULL THEN COUNT(DISTINCT(${TABLE}.TRANSACTION_ID)) END ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: contract_coverage {
    label: "Contract Coverage %"
    type: number
    sql: ${sum_claim_with_network_name}/NULLIF(${sum_claim},0) ;;
    value_format: "00.00%"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tot_paid_below_acq_cost {
    label: "Total Paid Amount Below Acq Cost"
    type: sum
    sql: CASE WHEN ${TABLE}.PAID_BELOW_ACQ_COST = 'Y' THEN (NVL(${TABLE}.TOT_PAID,0) - NVL(${TABLE}.ACQ_COST,0)) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_claim_paid_below_acq_cost {
    label: "Total Claims Paid Below Acq Cost"
    type: number
    sql: COUNT(DISTINCT(CASE WHEN ${TABLE}.PAID_BELOW_ACQ_COST = 'Y' THEN ${TABLE}.TRANSACTION_ID END)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_tot_paid_at_uc_price {
    label: "Total Paid Amount At UC Price"
    type: sum
    sql: CASE WHEN ${TABLE}.PAID_AT_UC_PRICE = 'Y' THEN (NVL(${TABLE}.TOT_PAID,0) - NVL(${TABLE}.ACQ_COST,0)) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_claim_paid_at_uc_price {
    label: "Total Claims Paid At UC Price"
    type: number
    sql: COUNT(DISTINCT(CASE WHEN ${TABLE}.PAID_AT_UC_PRICE = 'Y' THEN ${TABLE}.TRANSACTION_ID END)) ;;
    value_format: "#,##0"
    drill_fields: [cpr_detail_candidate_list*]
  }

  # ICP
  measure: sum_ingredient_cost_paid {
    label: "Ingredient Cost Paid"
    type: sum
    sql: ${TABLE}.INGREDIENT_COST_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_ingredient_cost_paid_per_unit {
    label: "Ingredient Cost Paid Per Unit"
    type: sum
    sql: ${TABLE}.PAID_PER_UNIT ;;
    value_format: "$#,##0.0000;($#,##0.0000)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  measure: sum_dispd_fee_paid {
    label: "Dispensed Fee Paid"
    type: sum
    sql: ${TABLE}.DISPD_FEE_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  # totalRevenue = totalDispFees + totalICP
  measure: sum_revenue {
    label: "Total Paid"
    type: sum
    sql: (NVL(${TABLE}.INGREDIENT_COST_PAID,0) + NVL(${TABLE}.DISPD_FEE_PAID,0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  # totalGrossProfit = totalRevenue - totalAcqCost
  measure: sum_gross_profit {
    label: "Gross Profit $"
    type: number
    sql: ((${sum_tot_paid}) - ${sum_acq_cost}) ;; #[ERXLPS-1358]
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [cpr_detail_candidate_list*]
  }

  # totalGrossProfitPerc = (totalGrossProfit / totalRevenue) * 100
  measure: sum_gross_profit_percentage {
    label: "Gross Margin %"
    type: number
    sql: ((${sum_gross_profit})/NULLIF(${sum_tot_paid},0)) ;; #[ERXLPS-1358]
    value_format: "00.00%"
    drill_fields: [cpr_detail_candidate_list*]
  }

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
  filter: store_filter {
    label: "Store \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: carrier_filter {
    label: "Carrier \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: plan_filter {
    label: "Plan \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: group_filter {
    label: "Group \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: network_filter {
    label: "Network ID \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: bin_filter {
    label: "BIN \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: pcn_filter {
    label: "PCN \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: drug_name_filter {
    label: "Drug Name \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: drug_ndc_filter {
    label: "Drug NDC \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: drug_gpi_filter {
    label: "Drug GPI \"Filter Only\""
    type: string
    full_suggestions: yes
  }

  filter: days_supply_filter {
    label: "Days Supply \"Filter Only\""
    type: number
    full_suggestions: yes
  }

  filter: fill_date_filter {
    label: "Fill Date \"Filter Only\""
    type: date
  }

  filter: sold_date_filter {
    label: "Sold Date \"Filter Only\""
    type: date
  }

  filter: paid_amount_filter {
    label: "Paid Amount \"Filter Only\""
    type: string
    suggestions: ["Actual Payments", "Adjudicated Amount"]
    full_suggestions: yes
  }

  filter: include_split_bill_filter {
    label: "Include Split Bills \"Filter Only\""
    type: string
    suggestions: ["NO", "YES"]
  }

  filter: exclude_zero_dollar_claim_filter {
    label: "Exclude $0 Claims \"Filter Only\""
    type: string
    suggestions: ["NO", "YES"]
  }

  filter: exclude_credit_returns_filter {
    label: "Exclude Credit Returns \"Filter Only\""
    type: string
    suggestions: ["NO", "YES"]
  }

  filter: brand_generic_filter {
    label: "Brand/Generic \"Filter Only\""
    type: string
    suggestions: [
      "All",
      "All Brand - M, N, O",
      "M=Multi-source brand",
      "N=Single-source brand",
      "O=Brand drug product with generics",
      "Y=Generic product"
    ]
    full_suggestions: yes
  }

  ################################################################################################ Sets ###########################################################

  set: cpr_detail_candidate_list {
    fields: [
      transaction_id,
      ar_carrier_performance.store_id,
      nabp_num,
      store_npi,
      contract_name,
      contract_rate_network_name,
      processor_id,
      ar_carrier_performance.carrier_code,
      carrier_name,
      plan_code,
      group_code,
      network_reimb_id,
      bin_number,
      pcn_number,
      rx_number,
      tx_number,
      filled_date,
      drug_name,
      drug_ndc,
      gpi,
      bg_desc,
      msdesc,
      sum_dispensed_qty,
      days_supply_max,
      split_desc,
      sum_acq_cost,
      sum_uc_price,
      sum_awp_price,
      sum_wac_price,
      drug_effective_start,
      sum_tp_paid,
      sum_copay_collected,
      sum_tot_paid,
      sum_dispd_fee_paid,
      sum_tax_amount,
      sum_ingredient_cost_paid,
      sum_awp_discount,
      sum_wac_discount,
      basis_of_reimb,
      sum_ingredient_cost_paid_per_unit,
      type_desc
    ]
  }
}

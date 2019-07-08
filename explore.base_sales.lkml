view: explore_base_sales_lkml {}

explore: sales_base {
  extension: required
  view_name: sales
  label: "Sales"
  view_label: "Prescription Transaction"


  always_filter: {
    filters: {
      field: history_filter
      value: "YES"
    }

    filters: {
      field: report_calendar_global.report_period_filter
      value: "Last 1 Month"
    }

    filters: {
      field: report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Month"
    }

    filters: {
      field: report_calendar_global.this_year_last_year_filter
      value: "No"
    }

    filters: {
      field: date_to_use_filter
      value: "REPORTABLE SALES"
    }

    filters: {
      field: sales_rxtx_payor_summary_detail_analysis
      value: "SUMMARY"
    }

    #[ERXLPS-895] - New filter added to restrict after sold transactions
    filters: {
      field: show_after_sold_measure_values
      value: "NO"
    }

    #[ERX-7360] new filter for base vs archive table selection
    filters: {
      field: sales.active_archive_filter
      value: "Active Tables – Current and Past 2 complete years' data"
    }
  }

  fields: [
    ALL_FIELDS*,
    -store.nhin_store_id,
    -store_budget.store_sales_budget,
    -store_budget.pharmacy_scripts_budget,
    -store_budget.fiscal_budget_period_identifier,
    -patient_gpi_pdc.gpi,
    -store_drug.prescribed_drug_name,
    -patient.rx_com_id_deidentified,        #ERXLPS-1162
    -prescriber.npi_number_deidentified,    #ERXLPS-1162
    -prescriber.dea_number_deidentified,    #ERXLPS-1162
    -prescriber.name_deidentified,          #ERXLPS-1162
    -store_drug_cost_type.store_drug_cost_type_deidentified, -store_drug_cost_type.store_drug_cost_type_description_deidentified, #[ERXLPS-1927]
    -store_drug.explore_rx_host_vs_store_drug_comparison_candidate_list*, #[ERXLPS-1925]
    #[ERXLPS-2064] Excluding drug subject area deleted dimension from Inventory and sales explore
    -drug.drug_deleted,-drug_cost.deleted,-drug_cost_type.cost_type_deleted,-store_drug_cost.store_drug_cost_deleted,
    -eps_patient.rx_com_id_deidentified, #[ERXLPS-1625]
    -rx_tx_drug_cost_hist.explore_rx_drug_cost_hist_4_10_candidate_list, #[ERXLPS-2295]
    -rx_tx_store_drug_cost_hist.explore_rx_store_drug_cost_hist_4_10_candidate_list, #[ERXLPS-2295]
    -eps_patient.store_patient_pharmacy_number, #[ERXLPS-2329]
    -eps_patient.store_patient_count_central_patient_explore, #[ERXLPS-2329]
    -drug.ar_drug_brand_generic, #[ERXLPS-6148]
    -drug_cost_type.explore_rx_drug_cost_type_metadata_candidate_list*,#[ERXLPS-2114]
    -drug_cost.explore_rx_drug_cost_metadata_candidate_list*,#[ERXLPS-2114]
    -gpi.explore_rx_gpi_metadata_candidate_list* #[ERXLPS-2114]
  ]
  description: "The Sales Analysis contains sales information for all cash and third party transactions that were sold, credit returned, or cancelled on the date(s) you specify. Includes all new, refill, and downtime prescriptions that have a reportable sales date. If the transaction was cancelled or credit returned, the report will display records for both the sale information and the credit/cancel information."

  #[ERXLPS-1020] - Added chain view columns whcih are exposed in TP Claim explore as part of TP claim integration into Sales explore.
  join: chain {
    view_label: "Pharmacy - Central"
    fields: [chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count,
      fiscal_chain_id,
      chain_filter]
    type: inner
    sql_on: ${sales.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXLPS-1020] - Commented fields section to expose all attributes from store table in sales explore as part of TP Claim integration.
  join: store {
    view_label: "Pharmacy - Central"
    #fields: [store_number, store_name, deactivated_date, count, nhin_store_id]
    type: inner
    sql_on: ${sales.chain_id} = ${store.chain_id} AND ${sales.nhin_store_id} = ${store.nhin_store_id} AND ${store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-6276] Changes
  join: store_to_store_alignment_secured_view {
    view_label: "Pharmacy - Central"
    type: inner
    sql_on: ${sales.chain_id} = ${store_to_store_alignment_secured_view.chain_id} AND ${sales.nhin_store_id} = ${store_to_store_alignment_secured_view.nhin_store_id} ;;
    relationship: many_to_one
  }

#[ERXDWPS-5897] - Added liquid variables for nursing home script logic to make joins & use in logic only when Consider Nursing Home Scripts as Sold filter is used in Sales explore.
  join: report_calendar_global {
    fields: [global_calendar_candidate_list*]
    view_label: "Prescription Transaction"
    type: inner
    relationship: many_to_one
    sql_on:  ${sales.chain_id} = ${report_calendar_global.chain_id}
             and ((    {% parameter sales.history_filter %} = 'YES'

                   and ${sales.sale_activity_date} = ${report_calendar_global.calendar_date}
                   and ${sales.sale_current_state_flg} = 'N'
                   and (case when {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES' then 1
                             when {% parameter sales.date_to_use_filter %} = 'SOLD' then 1
                             when {% parameter sales.date_to_use_filter %} = 'FILLED' then 2
                             when {% parameter sales.date_to_use_filter %} = 'RETURNED' then 2
                             end
                        ) = 1
                   and (   (   {% condition sales.show_after_sold_measure_values %} 'NO' {% endcondition %}
                            and (case when {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES'
                                      then ${sales.adjudicated_flg_from_table}
                                      --[ERXLPS-2056] - SASD Report fix: Added admin_rebill logic for WillCallPickUp/SOLD date. Fix implemented in EPS version 2.6.09.006 version.
                                      when {% parameter sales.date_to_use_filter %} = 'SOLD' --then ${sales.sold_flg_from_table}
                                      then {% if sales.consider_nh_as_sold._in_query %}
                                              case when ${sales.is_tx_nh_with_null_sold_date} = 'Y'
                                                   then ${sales.adjudicated_flg_from_table}
                                                   else ${sales.sold_flg_from_table}
                                              end
                                             {% else %}
                                              ${sales.sold_flg_from_table}
                                             {% endif %}
                                  end
                                ) = 'Y'
                           )
                         or (    {% condition sales.show_after_sold_measure_values %} 'YES' {% endcondition %}
                             and ( (    {% parameter sales.date_to_use_filter %} = 'SOLD'
                                    AND ${sales.financial_category} IN ('CASH - FILLED', 'CASH - CREDIT')
                                    AND ${sales.sold_date} IS NOT NULL
                                   )
                                 OR (    {% parameter sales.date_to_use_filter %} = 'SOLD'
                                     AND ${sales.financial_category} IN ('T/P - FILLED', 'T/P - CREDIT', 'PARTIAL - FILLED', 'PARTIAL - CREDIT')
                                    )
                                 OR {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES'
                                 )
                            )

                       )
                  )
                  or
                  (    {% parameter sales.history_filter %} = 'NO'
                   and ${sales.sale_current_state_flg} = 'Y'
                   and ${report_calendar_global.calendar_date} = (case when {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES' then ${rpt_cal_report_sales_date}
                                                                       when {% parameter sales.date_to_use_filter %} = 'SOLD' then ${rpt_cal_sold_date}
                                                                       when {% parameter sales.date_to_use_filter %} = 'FILLED' then ${rpt_cal_filled_date}
                                                                       when {% parameter sales.date_to_use_filter %} = 'RETURNED' then ${rpt_cal_returned_date}
                                                                   end
                                                                 )
                  )) ;;
  }

  join: report_period_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${report_period_timeframes.calendar_date} = ${report_calendar_global.report_date} AND ${report_period_timeframes.chain_id} = ${report_calendar_global.chain_id} ;;
    relationship: many_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_alignment.chain_id} AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 5 ;;
    relationship: one_to_one
  }

  join: store_setting {
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting.chain_id} AND  ${store.nhin_store_id} = ${store_setting.nhin_store_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-2448] - Join to get Price Region from store_setting table.
  join: store_setting_price_code_region {
    from: store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_price_code_region.chain_id} AND  ${store.nhin_store_id} = ${store_setting_price_code_region.nhin_store_id} AND upper(${store_setting_price_code_region.store_setting_name}) = 'STOREDESCRIPTION.PRICEREGION' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-1925]
  join: store_drug_cost_region {
    from:  store_setting
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_drug_cost_region.chain_id} AND  ${store.nhin_store_id} = ${store_drug_cost_region.nhin_store_id} AND UPPER(${store_drug_cost_region.store_setting_name}) = 'STOREDESCRIPTION.DRUGREGION' ;;
    relationship: one_to_one
    fields: [ ] #[ERXLPS-2596]
  }

  #[ERXLPS-1925]
  join: host_vs_pharmacy_comp {
    from: store_drug
    view_label: "NHIN Vs. Pharmacy Drug" #[ERXLPS-2089] Renamed Host to NHIN. DEMO and Enterprise models are comparing NHIN vs Host.
    type: left_outer #[ERXDWPS-6164] changed join type from inner to left_outer
    fields: [explore_rx_host_vs_store_drug_comparison_candidate_list*]
    sql_on: ${store_drug.chain_id} = ${host_vs_pharmacy_comp.chain_id} AND ${store_drug.nhin_store_id} = ${host_vs_pharmacy_comp.nhin_store_id} AND ${store_drug.drug_id} = ${host_vs_pharmacy_comp.drug_id} AND ${host_vs_pharmacy_comp.deleted_reference} = 'N'  AND ${store_drug.source_system_id} = ${host_vs_pharmacy_comp.source_system_id} ;; #[ERXLPS-2064] [ERXLPS-2211]
    relationship: one_to_one
  }

  #[ERXDWPS-9281] - Pharmacy DEA Information
  join: store_setting_dea_number {
    from: store_setting_rank
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_dea_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_dea_number.nhin_store_id} AND upper(${store_setting_dea_number.store_setting_name}) = 'STOREDESCRIPTION.STOREDEA' ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-1152] - Include "Scripts Converted" Yes/No Dimension in Sales Explore
  join: store_setting_conversionservice_run_date {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_conversionservice_run_date.chain_id} AND  ${store.nhin_store_id} = ${store_setting_conversionservice_run_date.nhin_store_id} AND upper(${store_setting_conversionservice_run_date.store_setting_name}) = 'CONVERSIONSERVICE.RUN.DATE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXLPS-6307] - Added ARS Pharamcy Contact Information join. Renamed all Pharmacy labels names with Pharmacy - *Source* for all store related views.
  join: store_contact_information {
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.store_id} = ${store_contact_information.store_contact_info_id} AND ${store_contact_information.store_contact_info_code} = 'S' AND ${store_contact_information.store_contact_info_deleted} = 'N' ;;
    relationship: one_to_one
  }

  #[RXLPS_753] [ERXLPS-6307] - Joins to get Pharmacy Phone Number and Fax Number from store_setting view
  join: store_setting_phone_number {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_phone_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Store"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  #[ERXDWPS-5191] - Looker - Albertsons Dispensed Quantity dimensions / measures not using same Partial Logic as Financial Category | Start
  join: eps_rx_tx_active_completion_fill {
    from: sales_eps_rx_tx
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${eps_rx_tx_active_completion_fill.chain_id}
        AND ${sales.nhin_store_id} = ${eps_rx_tx_active_completion_fill.nhin_store_id}
        AND ${sales.rx_id} = ${eps_rx_tx_active_completion_fill.rx_id}
        AND ${sales.rx_tx_refill_number} = ${eps_rx_tx_active_completion_fill.rx_tx_refill_number}
        AND ${sales.rx_tx_id} = ${eps_rx_tx_active_completion_fill.rx_tx_partial_rx_tx_id}
        AND (   (${sales.rx_tx_partial_fill_status_reference} = 'P' and ${sales.rx_tx_partial_fill_bill_type_reference} = 'C')
             OR (${sales.rx_tx_partial_fill_status_reference} = 'C' and ${sales.rx_tx_partial_fill_bill_type_reference} = 'P')
            )
        AND ${sales.rx_tx_tx_status_reference} = 'Y'
        AND (   (${eps_rx_tx_active_completion_fill.rx_tx_partial_fill_status_reference} = 'P' and ${eps_rx_tx_active_completion_fill.rx_tx_partial_fill_bill_type_reference} != 'C')
             OR (${eps_rx_tx_active_completion_fill.rx_tx_partial_fill_status_reference} = 'C' and ${eps_rx_tx_active_completion_fill.rx_tx_partial_fill_bill_type_reference} != 'P')
            )
        AND ${eps_rx_tx_active_completion_fill.rx_tx_tx_status_reference} = 'Y'
        AND ${eps_rx_tx_active_completion_fill.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
  }

#[ERXLPS-1261] this join is added as a part of this US.
#[ERXDWPS-5191] - Looker - Albertsons Dispensed Quantity dimensions / measures not using same Partial Logic as Financial Category | Start
  join: eps_rx_tx_partial_fill {
    from: sales_eps_rx_tx
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${eps_rx_tx_partial_fill.chain_id}
        AND ${sales.nhin_store_id} = ${eps_rx_tx_partial_fill.nhin_store_id}
        AND ${sales.rx_id} = ${eps_rx_tx_partial_fill.rx_id}
        AND ${sales.rx_tx_refill_number} = ${eps_rx_tx_partial_fill.rx_tx_refill_number}
        AND ${sales.rx_tx_partial_rx_tx_id} = ${eps_rx_tx_partial_fill.rx_tx_id}
        AND ${sales.rx_tx_id} = ${eps_rx_tx_partial_fill.rx_tx_completion_rx_tx_id}
        AND (   (${sales.rx_tx_partial_fill_status_reference} = 'P' and ${sales.rx_tx_partial_fill_bill_type_reference} != 'C')
             OR (${sales.rx_tx_partial_fill_status_reference} = 'C' and ${sales.rx_tx_partial_fill_bill_type_reference} != 'P')
            )
        AND (   (${eps_rx_tx_partial_fill.rx_tx_partial_fill_status_reference} = 'P' and ${eps_rx_tx_partial_fill.rx_tx_partial_fill_bill_type_reference} = 'C')
             OR (${eps_rx_tx_partial_fill.rx_tx_partial_fill_status_reference} = 'C' and ${eps_rx_tx_partial_fill.rx_tx_partial_fill_bill_type_reference} = 'P')
            )
        AND ${eps_rx_tx_partial_fill.rx_tx_tx_status_reference} = 'Y'
        AND ${eps_rx_tx_partial_fill.rx_tx_fill_status} IS NOT NULL
        AND ${eps_rx_tx_partial_fill.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211]
    relationship: one_to_one
  }

  #[ERX-3485] : added as a part of 4.13 for reject reason and reject reason cause
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join:  store_reject_reason {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_reject_reason.chain_id} AND ${sales.nhin_store_id}= ${store_reject_reason.nhin_store_id} AND ${sales.rx_tx_id} = ${store_reject_reason.rx_tx_id}  ;;
    relationship: many_to_many
  }

  join:  store_reject_reason_cause {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${store_reject_reason.chain_id} = ${store_reject_reason_cause.chain_id} AND ${store_reject_reason.nhin_store_id}= ${store_reject_reason_cause.nhin_store_id} AND ${store_reject_reason.reject_reason_id} = ${store_reject_reason_cause.reject_reason_id}  ;;
    relationship: one_to_many
  }

  #ERXDWPS-1549 Account for Nursing Home Flag on Prescription Transaction
  #[ERXDWPS-5897] - Due to looker behaviour we currently we are not able to avoid table join with nursing home view file and implemented work around.
  join: store_nursing_home_flag_fill_time {
    #fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: {% if sales.consider_nh_as_sold._in_query or store_nursing_home_flag_fill_time.patient_nursing_home_flag_fill_time._in_query %}
                ${store_nursing_home_flag_fill_time.chain_id} = ${sales.chain_id}
            AND ${store_nursing_home_flag_fill_time.nhin_store_id}= ${sales.nhin_store_id}
            AND ${store_nursing_home_flag_fill_time.rx_tx_id} = ${sales.rx_tx_id}
            AND ${store_nursing_home_flag_fill_time.source_system_id} = ${sales.source_system_id}
            {% else %}
            1 = 1
            {% endif %} ;;
    relationship: many_to_one
  }

  join: sales_tx_tp {
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales.chain_id} = ${sales_tx_tp.chain_id} AND ${sales.nhin_store_id} = ${sales_tx_tp.nhin_store_id} AND ${sales.rx_tx_id} = ${sales_tx_tp.rx_tx_id} and ${sales_tx_tp.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211] ;;
    relationship: many_to_one
  }

  #[ERXLPS-1020] - Integration of TP Claim into Sales
  #[ERXLPS-1385] - Revised the join condition. Earlier the join was b/w sales and eps_tx_tp. Updated the join to eps_tx_tp and sales_tx_tp.
  join: eps_tx_tp {
    from: sales_eps_tx_tp
    view_label: "Claim"
    type: left_outer
    fields: [sales_tx_tp_dimension_candidate_list*,explore_sales_specific_candidate_list*]
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp.nhin_store_id} AND ${sales_tx_tp.rx_tx_id} = ${eps_tx_tp.rx_tx_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp.tx_tp_id} AND ${eps_tx_tp.source_system_id} = ${sales_tx_tp.source_system_id} ;; # [ERXLPS-2211]
    relationship: one_to_one
  }

  join: eps_tx_tp_transmit_queue {
    from: sales_eps_tx_tp_transmit_queue
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${sales_tx_tp.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${sales_tx_tp.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_id} = ${sales_tx_tp.tx_tp_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_submit_detail {
    from: sales_eps_tx_tp_submit_detail
    view_label: "Submit Detail"
    fields: [sales_tx_tp_submit_detial_dimension_candidate_list*,explore_sales_specific_candidate_list*]
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_submit_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_submit_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_submit_detail.tx_tp_submit_detail_id} ;;
    relationship: one_to_one
  }

  #[ERX-8] added Tx Tp SA tables as a part of 4.13.000 release
  join: eps_tx_tp_submit_detail_segment_code {
    from: sales_eps_tx_tp_submit_detail_segment_code
    view_label: "Submit Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_submit_detail.chain_id} = ${eps_tx_tp_submit_detail_segment_code.chain_id} AND ${eps_tx_tp_submit_detail.nhin_store_id} = ${eps_tx_tp_submit_detail_segment_code.nhin_store_id} AND ${eps_tx_tp_submit_detail.tx_tp_submit_detail_id} = ${eps_tx_tp_submit_detail_segment_code.tx_tp_submit_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tp_link {
    fields: [-ALL_FIELDS*, eps_tp_link.sales_transmit_queue_tp_link_dimension_candidate_list*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tp_link.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tp_link.nhin_store_id} AND ${sales_tx_tp.tx_tp_patient_tp_link_id} = ${eps_tp_link.tp_link_id} AND ${sales_tx_tp.source_system_id} = ${eps_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: eps_card {
    fields: [-ALL_FIELDS*, eps_card.sales_transmit_queue_card_dimension_candidate_list*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${eps_tp_link.chain_id} = ${eps_card.chain_id} AND ${eps_tp_link.nhin_store_id} = ${eps_card.nhin_store_id} AND ${eps_tp_link.card_id} = ${eps_card.card_id} AND ${eps_tp_link.source_system_id} = ${eps_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: eps_plan {
    #[ERXLPS-1618] - explore_sales_candidate_list set is used in other explore where store_plan_phone_number is not exposed. dimension added directly at join level until other explores are depricated.
    fields: [explore_sales_candidate_list*, store_plan_phone_number]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_card.chain_id} = ${eps_plan.chain_id} AND ${eps_card.nhin_store_id} = ${eps_plan.nhin_store_id} AND ${eps_card.plan_id} = ${eps_plan.plan_id} AND ${eps_card.source_system_id} = ${eps_plan.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: eps_plan_transmit {
    fields: [explore_sales_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_plan.chain_id} = ${eps_plan_transmit.chain_id} AND ${eps_plan.nhin_store_id} = ${eps_plan_transmit.nhin_store_id} AND ${eps_plan.plan_id} = ${eps_plan_transmit.plan_id} AND ${eps_plan.source_system_id} = ${eps_plan_transmit.source_system_id} AND ${eps_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

# ERXDWPS-5430 Changes
  join: chain_pbm_network_crosswalk {
    view_label: "PBM Network Crosswalk"
    type: left_outer
    sql_on: ${eps_plan_transmit.chain_id} = ${chain_pbm_network_crosswalk.chain_id} AND NVL(${eps_plan_transmit.store_plan_transmit_bin_number},'NULL') = NVL(${chain_pbm_network_crosswalk.bin},'NULL') AND NVL(${eps_plan_transmit.store_plan_transmit_processor_control_number},'NULL') = NVL(${chain_pbm_network_crosswalk.pcn},'NULL') AND NVL(${eps_card.store_card_group_code},'NULL') = NVL(${chain_pbm_network_crosswalk.group},'NULL') ;;  # for paper claims, it is possible not to have a BIN and PCN as online claims are only mandated to have a BIN and PCN
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: eps_plan_phone {
    from: eps_phone
    fields: [-ALL_FIELDS*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${eps_plan.chain_id} = ${eps_plan_phone.chain_id} AND ${eps_plan.nhin_store_id} = ${eps_plan_phone.nhin_store_id} AND to_char(${eps_plan.store_plan_phone_id}) = to_char(${eps_plan_phone.phone_id}) AND ${eps_plan.source_system_id} = ${eps_plan_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: primary_payer_tx_tp {
    from: sales_tx_tp
    fields: [-ALL_FIELDS*]
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales.chain_id} = ${primary_payer_tx_tp.chain_id} AND ${sales.nhin_store_id} = ${primary_payer_tx_tp.nhin_store_id} AND ${sales.rx_tx_id} = ${primary_payer_tx_tp.rx_tx_id} AND ${primary_payer_tx_tp.tx_tp_counter} = 0 AND ${sales.source_system_id} = ${primary_payer_tx_tp.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
  }

  join: primary_tp_link {
    from: eps_tp_link
    fields: [-ALL_FIELDS*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${primary_payer_tx_tp.chain_id} = ${primary_tp_link.chain_id} AND ${primary_payer_tx_tp.nhin_store_id} = ${primary_tp_link.nhin_store_id} AND ${primary_payer_tx_tp.tx_tp_patient_tp_link_id} = ${primary_tp_link.tp_link_id} AND ${primary_payer_tx_tp.source_system_id} = ${primary_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: primary_payer_card {
    from: eps_card
    fields: [-ALL_FIELDS*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${primary_tp_link.chain_id} = ${primary_payer_card.chain_id} AND ${primary_tp_link.nhin_store_id} = ${primary_payer_card.nhin_store_id} AND ${primary_tp_link.card_id} = ${primary_payer_card.card_id} AND ${primary_tp_link.source_system_id} = ${primary_payer_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: primary_payer_plan {
    from: eps_plan
    fields: [explore_sales_primary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_card.chain_id} = ${primary_payer_plan.chain_id} AND ${primary_payer_card.nhin_store_id} = ${primary_payer_plan.nhin_store_id} AND ${primary_payer_card.plan_id} = ${primary_payer_plan.plan_id} AND ${primary_payer_card.source_system_id} = ${primary_payer_plan.source_system_id};; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: primary_payer_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_primary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_plan.chain_id} = ${primary_payer_plan_transmit.chain_id} AND ${primary_payer_plan.nhin_store_id} = ${primary_payer_plan_transmit.nhin_store_id} AND ${primary_payer_plan.plan_id} = ${primary_payer_plan_transmit.plan_id} AND ${primary_payer_plan.source_system_id} = ${primary_payer_plan_transmit.source_system_id} AND ${primary_payer_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: primary_payer_plan_phone {
    from: eps_phone
    fields: [-ALL_FIELDS*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${primary_payer_plan.chain_id} = ${primary_payer_plan_phone.chain_id} AND ${primary_payer_plan.nhin_store_id} = ${primary_payer_plan_phone.nhin_store_id} AND to_char(${primary_payer_plan.store_plan_phone_id}) = to_char(${primary_payer_plan_phone.phone_id}) AND ${primary_payer_plan.source_system_id} = ${primary_payer_plan_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  #[ERXLPS-1618]
  join: secondary_payer_tx_tp {
    from: sales_tx_tp
    fields: [-ALL_FIELDS*]
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales.chain_id} = ${secondary_payer_tx_tp.chain_id} AND ${sales.nhin_store_id} = ${secondary_payer_tx_tp.nhin_store_id} AND ${sales.rx_tx_id} = ${secondary_payer_tx_tp.rx_tx_id} AND ${secondary_payer_tx_tp.tx_tp_counter} = 1  AND ${sales.source_system_id} = ${secondary_payer_tx_tp.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
  }

  join: secondary_tp_link {
    from: eps_tp_link
    fields: [-ALL_FIELDS*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${secondary_payer_tx_tp.chain_id} = ${secondary_tp_link.chain_id} AND ${secondary_payer_tx_tp.nhin_store_id} = ${secondary_tp_link.nhin_store_id} AND ${secondary_payer_tx_tp.tx_tp_patient_tp_link_id} = ${secondary_tp_link.tp_link_id} AND ${secondary_payer_tx_tp.source_system_id} = ${secondary_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: many_to_one
  }

  join: secondary_payer_card {
    from: eps_card
    fields: [-ALL_FIELDS*]
    view_label: "Claim Card"
    type: left_outer
    sql_on: ${secondary_tp_link.chain_id} = ${secondary_payer_card.chain_id} AND ${secondary_tp_link.nhin_store_id} = ${secondary_payer_card.nhin_store_id} AND ${secondary_tp_link.card_id} = ${secondary_payer_card.card_id} AND ${secondary_tp_link.source_system_id} = ${secondary_payer_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: secondary_payer_plan {
    from: eps_plan
    fields: [explore_sales_secondary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_card.chain_id} = ${secondary_payer_plan.chain_id} AND ${secondary_payer_card.nhin_store_id} = ${secondary_payer_plan.nhin_store_id} AND ${secondary_payer_card.plan_id} = ${secondary_payer_plan.plan_id} AND ${secondary_payer_card.source_system_id} = ${secondary_payer_plan.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: secondary_payer_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_secondary_payer_candidate_list*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_plan.chain_id} = ${secondary_payer_plan_transmit.chain_id} AND ${secondary_payer_plan.nhin_store_id} = ${secondary_payer_plan_transmit.nhin_store_id} AND ${secondary_payer_plan.plan_id} = ${secondary_payer_plan_transmit.plan_id} AND ${secondary_payer_plan.source_system_id} = ${secondary_payer_plan_transmit.source_system_id} AND ${secondary_payer_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: secondary_payer_plan_phone {
    from: eps_phone
    fields: [-ALL_FIELDS*]
    view_label: "Claim Plan"
    type: left_outer
    sql_on: ${secondary_payer_plan.chain_id} = ${secondary_payer_plan_phone.chain_id} AND ${secondary_payer_plan.nhin_store_id} = ${secondary_payer_plan_phone.nhin_store_id} AND to_char(${secondary_payer_plan.store_plan_phone_id}) = to_char(${secondary_payer_plan_phone.phone_id}) AND ${secondary_payer_plan.source_system_id} = ${secondary_payer_plan_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

#[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: eps_patient {
    from: sales_store_patient #[ERXLPS-6331] Create new view for sales explore and joined.
    view_label: "Patient - Store"
    #fields: [-ALL_FIELDS*]
    type: left_outer
    sql_on: ${sales.chain_id} = ${eps_patient.chain_id} AND ${sales.nhin_store_id} = ${eps_patient.nhin_store_id} AND ${sales.rx_patient_id} = ${eps_patient.patient_id} AND ${eps_patient.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
  }
  #[ERX-3541] Integration of EPS patient address subejct area Start
  join: eps_patient_address_link {
    view_label: "EPS Patient Address"
    fields: [-ALL_FIELDS*]
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${eps_patient_address_link.chain_id} AND ${eps_patient.nhin_store_id} = ${eps_patient_address_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${eps_patient_address_link.patient_id}) AND ${eps_patient.source_system_id} = ${eps_patient_address_link.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_many
  }

  #[ERXLPS-1024][ERXLPS-2420] - Renamed eps_patient_address_extension_hist view name to store_patient_address_extension_hist
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: store_patient_address_extension_hist {
    view_label: "Pharmarcy Patient Address History"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_patient_address_extension_hist.chain_id} AND ${sales.nhin_store_id} = ${store_patient_address_extension_hist.nhin_store_id} AND ${sales.rx_tx_id} = ${store_patient_address_extension_hist.rx_tx_id} AND ${sales.source_system_id} = ${store_patient_address_extension_hist.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  #ERXDWPS-5115
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: store_patient_address_fill_time {
    view_label: "Patient Address - At time of Fill"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_patient_address_fill_time.chain_id} AND ${sales.nhin_store_id} = ${store_patient_address_fill_time.nhin_store_id} AND ${sales.rx_tx_id} = ${store_patient_address_fill_time.rx_tx_id} AND ${sales.source_system_id} = ${store_patient_address_fill_time.source_system_id};;
    relationship: many_to_many
  }

  #[ERX-3541] Integration of EPS patient address subejct area End

  #[ERXLPS-1024][ERXLPS-2420] - Store Patient Address information added to Sales Explore.
  join: store_patient_address {
    view_label: "Patient Address - Store"
    type: left_outer
    sql_on: ${eps_patient_address_link.chain_id} = ${store_patient_address.chain_id} AND ${eps_patient_address_link.nhin_store_id} = ${store_patient_address.nhin_store_id} AND ${eps_patient_address_link.address_id} = ${store_patient_address.address_id} AND ${eps_patient_address_link.source_system_id} = ${store_patient_address.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_address_extension {
    view_label: "Patient Address - Store"
    type: left_outer
    sql_on: ${store_patient_address.chain_id} = ${store_patient_address_extension.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_address_extension.nhin_store_id} AND ${store_patient_address.address_id} = ${store_patient_address_extension.address_id} AND ${store_patient_address.source_system_id} = ${store_patient_address_extension.source_system_id} ;;
    relationship: one_to_one
  }

  join: store_patient_home_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_home_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_home_phone.nhin_store_id} AND ${store_patient_address.address_home_phone_id} = ${store_patient_home_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_home_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_work_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_address.chain_id} = ${store_patient_work_phone.chain_id} AND ${store_patient_address.nhin_store_id} = ${store_patient_work_phone.nhin_store_id} AND ${store_patient_address.address_work_phone_id} = ${store_patient_work_phone.phone_id} AND ${store_patient_address.source_system_id} = ${store_patient_work_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_mobile_phone {
    from: eps_phone
    view_label: "Patient Phone - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${eps_patient.chain_id} = ${store_patient_mobile_phone.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_mobile_phone.nhin_store_id} AND ${eps_patient.patient_mobile_phone_id} = ${store_patient_mobile_phone.phone_id} AND ${eps_patient.source_system_id} = ${store_patient_mobile_phone.source_system_id} ;; #[ERXDWPS-5137]
    relationship: many_to_one
  }

  join: store_patient_zip_code {
    type: left_outer
    view_label: "Patient Address - Store"
    sql_on: ${store_patient_address.address_postal_code} = ${store_patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: store_patient_disease {
    view_label: "Patient Disease - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_disease.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_disease.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_disease.patient_id} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-6304] - Store Patient Disease ICD9 join to get description.
  join: store_patient_icd9 {
    from: store_icd9
    view_label: "Patient Disease - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_disease.chain_id} = ${store_patient_icd9.chain_id}
        AND ${store_patient_disease.nhin_store_id} = ${store_patient_icd9.nhin_store_id}
        AND ${store_patient_disease.store_patient_disease_icd9} = ${store_patient_icd9.store_icd9_code}
        AND ${store_patient_disease.store_patient_disease_icd9_type_reference} = ${store_patient_icd9.store_icd9_prefix_reference};;
    relationship: many_to_one
  }

  join: store_patient_email {
    view_label: "Patient Email - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_email.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_email.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_email.patient_id} ;;
    relationship: one_to_many
  }

  #[ERX-3488] joined payment SA tables
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: eps_rx_tx_payment {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${sales.chain_id} = ${eps_rx_tx_payment.chain_id} AND ${sales.nhin_store_id} = ${eps_rx_tx_payment.nhin_store_id} AND ${sales.rx_tx_id} = ${eps_rx_tx_payment.rx_tx_id} ;;
    relationship: many_to_many
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: eps_payment_group_line_item_link {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${sales.chain_id} = ${eps_payment_group_line_item_link.chain_id} AND ${sales.nhin_store_id} = ${eps_payment_group_line_item_link.nhin_store_id} AND ${sales.rx_tx_id} = ${eps_payment_group_line_item_link.line_item_id} ;;
    relationship: many_to_many
  }

  join: eps_payment_group {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${eps_payment_group_line_item_link.chain_id} = ${eps_payment_group.chain_id} AND ${eps_payment_group_line_item_link.nhin_store_id} = ${eps_payment_group.nhin_store_id} AND ${eps_payment_group_line_item_link.payment_group_id} = ${eps_payment_group.payment_group_id} ;;
    relationship: many_to_one
  }

  join: eps_payment {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${eps_payment_group.chain_id} = ${eps_payment.chain_id} AND ${eps_payment_group.nhin_store_id} = ${eps_payment.nhin_store_id} AND ${eps_payment_group.payment_group_id} = ${eps_payment.payment_group_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_adjustment {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${eps_payment.chain_id} = ${eps_payment_adjustment.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_payment_adjustment.nhin_store_id} AND ${eps_payment.payment_id} = ${eps_payment_adjustment.payment_id} ;;
    relationship: one_to_many
  }

  join: eps_payment_type {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${eps_payment.chain_id} = ${eps_payment_type.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_payment_type.nhin_store_id} AND ${eps_payment.payment_type_id} = ${eps_payment_type.payment_type_id} ;;
    relationship: many_to_one
  }

  join: eps_credit_card {
    view_label: "Payment"
    type:  left_outer
    sql_on: ${eps_payment.chain_id} = ${eps_credit_card.chain_id} AND ${eps_payment.nhin_store_id} = ${eps_credit_card.nhin_store_id} AND ${eps_payment.credit_card_id} = ${eps_credit_card.credit_card_id} ;;
    relationship: many_to_one
  }

  join: patient {
    from:  sales_patient #[ERXLPS-6331] Create new view for sales explore and joined.
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient.chain_id} AND ${eps_patient.rx_com_id} = ${patient.rx_com_id} ;;
    relationship: many_to_one
  }

  join: patient_address {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_address.chain_id} AND ${patient.rx_com_id} = ${patient_address.rx_com_id} AND ${patient_address.deleted} = 'N'  AND ${patient_address.deactivate_date} IS NULL ;;
    relationship: one_to_many #[ERXLPS-910] Corrected the relationship
  }

  join: patient_zip_code {
    type: left_outer
    view_label: "Patient - Central"
    sql_on: ${patient_address.zip_code} = ${patient_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: chain_patient_summary_info {
    view_label: "Patient - Store"
    type: left_outer
    sql_on: ${patient.chain_id} = ${chain_patient_summary_info.chain_id} AND ${patient.rx_com_id} = ${chain_patient_summary_info.rx_com_id} ;;
    relationship: one_to_one
  }

  join: chain_patient_phone_list {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${chain_patient_phone_list.chain_id} AND ${patient.rx_com_id} = ${chain_patient_phone_list.rx_com_id} ;;
    relationship: one_to_one
  }

  join: chain_patient {
    view_label: "Patient - Store"
    type: left_outer
    sql_on: ${patient.chain_id} = ${chain_patient.chain_id} AND ${patient.rx_com_id} = ${chain_patient.rx_com_id} ;;
    relationship: one_to_one
  }

  #[ERXLPS-1002] - Added join to expose patient cell phone information in sales explore.
  join: patient_phone {
    view_label: "Patient - Central"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_phone.chain_id} AND ${patient.rx_com_id} = ${patient_phone.rx_com_id} AND ${patient_phone.deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-7476][ERXDWPS-7987] - PDC flatten view US joins. Start.
  join: pdc_group_gpi_link {
    view_label: "Pharmacy Drug" #[ERXLPS-2101]
    type: left_outer
    sql_on: ${store_drug.gpi_identifier} = ${pdc_group_gpi_link.gpi} AND ${pdc_group_gpi_link.pdc_group_gpi_link_deleted_reference} = 'N' ;;
    relationship: many_to_many #many gpis in store_drug match with many gpis in pdc_group_gpi_link table.
  }

  join: gpi_medical_condition_cross_ref {
    from: pdc_group
    view_label: "Pharmacy Drug" #[ERXLPS-2101]
    type: left_outer
    fields: [medical_condition]
    sql_on: ${pdc_group_gpi_link.pdc_group_id} = ${gpi_medical_condition_cross_ref.pdc_group_id} ;;
    relationship: many_to_one #many pdc_group_id's in pdc_group_gpi_link table match with one pdc_group_id in pdc_group table.
  }

  join: patient_gpi_pdc {
    from: patient_pdc_summary_flatten
    view_label: "Patient PDC"
    type: left_outer
    sql_on: ${patient.chain_id} = ${patient_gpi_pdc.chain_id}
        AND ${patient.rx_com_id} = ${patient_gpi_pdc.rx_com_id}
        AND ${patient_gpi_pdc.pdc_group_id} = ${gpi_medical_condition_cross_ref.pdc_group_id}
        AND (CASE WHEN {% parameter patient_gpi_pdc.latest_snapshot_filter %} = 'Yes' THEN ${patient_gpi_pdc.snapshot_date} = ${patient_gpi_pdc.latest_snapshot_date} ELSE 1 = 1 END);;
    relationship: one_to_many
  }

  join: bi_version_information {
    view_label: "Patient PDC Version"
    type: left_outer
    sql_on: ${patient_gpi_pdc.bi_version_id} = ${bi_version_information.bi_version_id} ;;
    relationship: many_to_one
  }
  #[ERXDWPS-7476][ERXDWPS-7987] - PDC flatten view US joins. End.

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: epr_rx_tx {
    fields: [-ALL_FIELDS*]
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${epr_rx_tx.chain_id} AND ${sales.nhin_store_id}= ${epr_rx_tx.nhin_store_id} AND ${sales.rx_number}= ${epr_rx_tx.rx_number} AND ${sales.rx_tx_tx_number}= ${epr_rx_tx.tx_number} ;;
    relationship: many_to_one
  }

  join: prescriber {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${epr_rx_tx.chain_id} = ${prescriber.chain_id} AND ${epr_rx_tx.prescriber_id} = ${prescriber.id} ;;
    relationship: many_to_one
  }

  join: us_zip_code {
    view_label: "Prescriber"
    type: left_outer
    sql_on: ${prescriber.zip_code} = ${us_zip_code.zip_code} ;;
    relationship: many_to_one
  }

  join: store_drug {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${sales.chain_id} AND ${store_drug.nhin_store_id}= ${sales.nhin_store_id} AND ${store_drug.drug_id} = ${sales.sale_drug_dispensed_id} AND ${store_drug.deleted_reference} = 'N' AND ${store_drug.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here. GPI table information is currently not avalable at store and joined with host gpi view to get drug gpi level information.
  join: pharmacy_gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level1.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,2),'000000000000')  = ${pharmacy_gpi_level1.gpi_identifier}
            AND ${pharmacy_gpi_level1.gpi_level_custom} = 1
            AND ${pharmacy_gpi_level1.source_system_id} = 0 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level2.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,4),'0000000000')  = ${pharmacy_gpi_level2.gpi_identifier}
            AND ${pharmacy_gpi_level2.source_system_id} = 0
            AND ${pharmacy_gpi_level2.gpi_level_custom} = 2 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level3.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,6),'00000000')  = ${pharmacy_gpi_level3.gpi_identifier}
            AND ${pharmacy_gpi_level3.source_system_id} = 0
            AND ${pharmacy_gpi_level3.gpi_level_custom} = 3 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level4.chain_id}
            AND concat(substr(${store_drug.gpi_identifier},1,10),'0000')  = ${pharmacy_gpi_level4.gpi_identifier}
            AND ${pharmacy_gpi_level4.source_system_id} = 0
            AND ${pharmacy_gpi_level4.gpi_level_custom} = 4 ;;
    relationship: many_to_one
  }

  join: pharmacy_gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${pharmacy_gpi_level5.chain_id}
            AND ${store_drug.gpi_identifier} = ${pharmacy_gpi_level5.gpi_identifier}
            AND ${pharmacy_gpi_level5.source_system_id} = 0
            AND ${pharmacy_gpi_level5.gpi_level_custom} = 5 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: store_drug_prescribed {
    from: store_drug
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug_prescribed.chain_id} = ${sales.chain_id} AND ${store_drug_prescribed.nhin_store_id}= ${sales.nhin_store_id} AND ${store_drug_prescribed.drug_id} = ${sales.rx_prescribed_drug_id} AND ${store_drug_prescribed.deleted_reference} = 'N' AND ${store_drug_prescribed.source_system_id} = ${sales.source_system_id} ;; # [ERXLPS-2211]
    relationship: many_to_one
    fields: [prescribed_drug_name]
  }

  #[ERXLPS-946] - join with store_price_code to get Store drug price code information
  #[ERXLPS-2089] - View name renamed to store_drug_price_code. Removed from clause from join.
  join: store_drug_price_code {
    view_label: "Pharmacy Drug"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_price_code.chain_id} AND ${store_drug.nhin_store_id}= ${store_drug_price_code.nhin_store_id} AND ${store_drug.price_code_id} = to_char(${store_drug_price_code.price_code_id}) AND ${store_drug_price_code.price_code_deleted} = 'N' ;;
    relationship: many_to_one
  }

  #[ERXLPS-1254] - Corrected the relationship from one_to_one to one_to_many.
  join: store_drug_cost {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug.chain_id} = ${store_drug_cost.chain_id} AND ${store_drug.nhin_store_id} = ${store_drug_cost.nhin_store_id} AND ${store_drug.drug_id} = to_char(${store_drug_cost.drug_id}) AND ${store_drug_cost.store_drug_cost_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: one_to_many
  }

  #[ERXLPS-1254] - Corrected the relationship from one_to_one to many_to_one. Revised the join condition.
  join: store_drug_cost_type {
    view_label: "Pharmacy Drug Cost Type"
    type: left_outer
    sql_on: ${store_drug_cost.chain_id} = ${store_drug_cost_type.chain_id} AND ${store_drug_cost.nhin_store_id} = ${store_drug_cost_type.nhin_store_id} AND ${store_drug_cost.drug_cost_type_id} = ${store_drug_cost_type.drug_cost_type_id} ;;
    relationship: many_to_one
  }

  join: store_drug_cost_pivot {
    view_label: "Pharmacy Drug Cost"
    type: left_outer
    sql_on: ${store_drug_cost_pivot.chain_id} = ${store_drug.chain_id} AND ${store_drug_cost_pivot.nhin_store_id}= ${store_drug.nhin_store_id} AND to_char(${store_drug_cost_pivot.drug_id}) = ${store_drug.drug_id} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: drug {
    view_label: "NHIN Drug"
    #fields: [explore_rx_drug_candidate_list*]
    type: left_outer
    sql_on: ${sales.rx_tx_dispensed_drug_ndc} = ${drug.drug_ndc} AND ${drug.drug_source_system_id} = 6 AND ${drug.chain_id} = 3000 AND ${drug.drug_deleted_reference} = 'N' ;; #[ERXLPS-2064]
    relationship: many_to_one
  }

  join: gpi_disease_cross_ref {
    view_label: "NHIN Drug"
    fields: [gpi_disease_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_cross_ref.gpi} and ${gpi_disease_cross_ref.gpi_disease_rnk} = 1 AND ${drug.drug_source_system_id} = 6 ;;
    relationship: many_to_one
  }

  join: gpi_disease_duration_cross_ref {
    from: gpi_disease_cross_ref
    view_label: "NHIN Drug"
    fields: [gpi_candidate_list*]
    type: left_outer
    sql_on: ${drug.drug_gpi} = ${gpi_disease_duration_cross_ref.gpi} and ${gpi_disease_duration_cross_ref.gpi_rnk} = 1 ;;
    relationship: many_to_one
  }

  join: gpi {
    fields: [gpi_identifier, gpi_description, gpi_level, gpi_level_variance_flag] #[ERXLPS-1065] Added gpi_level_variance_flag #[ERXLPS-1942] Removed medical_condition
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi.chain_id} AND ${drug.drug_gpi} = ${gpi.gpi_identifier} AND ${gpi.source_system_id} = 6 AND ${gpi.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. Start here.
  join: gpi_level1 {
    from: gpi
    fields: [gpi_drug_group_level1,gpi_key_drug_group_level1]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level1.chain_id}
            AND concat(substr(${drug.drug_gpi},1,2),'000000000000')  = ${gpi_level1.gpi_identifier}
            AND ${gpi_level1.gpi_level_custom} = 1
            AND ${gpi_level1.source_system_id} = 6
            AND ${gpi_level1.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level2 {
    from: gpi
    fields: [gpi_drug_class_level2,gpi_key_drug_class_level2]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level2.chain_id}
            AND concat(substr(${drug.drug_gpi},1,4),'0000000000')  = ${gpi_level2.gpi_identifier}
            AND ${gpi_level2.source_system_id} = 6
            AND ${gpi_level2.gpi_level_custom} = 2
            AND ${gpi_level2.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level3 {
    from: gpi
    fields: [gpi_drug_subclass_level3,gpi_key_drug_subclass_level3]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level3.chain_id}
            AND concat(substr(${drug.drug_gpi},1,6),'00000000')  = ${gpi_level3.gpi_identifier}
            AND ${gpi_level3.source_system_id} = 6
            AND ${gpi_level3.gpi_level_custom} = 3
            AND ${gpi_level3.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level4 {
    from: gpi
    fields: [gpi_drug_name_level4,gpi_key_drug_name_level4]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level4.chain_id}
            AND concat(substr(${drug.drug_gpi},1,10),'0000')  = ${gpi_level4.gpi_identifier}
            AND ${gpi_level4.source_system_id} = 6
            AND ${gpi_level4.gpi_level_custom} = 4
            AND ${gpi_level4.chain_id} = 3000 ;;
    relationship: many_to_one
  }

  join: gpi_level5 {
    from: gpi
    fields: [gpi_drug_strength_level5,gpi_key_drug_strength_level5]
    view_label: "NHIN Drug"
    type: left_outer
    sql_on: ${drug.chain_id} = ${gpi_level5.chain_id}
            AND ${drug.drug_gpi} = ${gpi_level5.gpi_identifier}
            AND ${gpi_level5.source_system_id} = 6
            AND ${gpi_level5.gpi_level_custom} = 5
            AND ${gpi_level5.chain_id} = 3000 ;;
    relationship: many_to_one
  }
  #[ERXDWPS-1454] - Drug GPI Classification based on Medispan file information. End here.

  join: drug_cost_pivot {
    view_label: "NHIN Drug Cost"
    type: left_outer
    sql_on: ${drug.chain_id} = ${drug_cost_pivot.chain_id} AND ${drug.drug_ndc} = ${drug_cost_pivot.ndc} AND ${drug_cost_pivot.source_system_id} = 6 AND ${drug_cost_pivot.chain_id} = 3000 AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost_pivot.drug_cost_region}) ;;
    relationship: one_to_many #[ERXLPS-1925] Added drug_cost_region to drug_cost_pivot view.
  }

  join: drug_cost {
    view_label: "NHIN Drug Cost"
    type: left_outer
    #[ERXLPS-2064] Added cost_type and region in joins. Source is store_drug and we need to join store_drug region and store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug.chain_id} = ${drug_cost.chain_id} AND ${drug.drug_ndc} = ${drug_cost.ndc} AND ${drug_cost.source_system_id} = 6 AND ${drug_cost.chain_id} = 3000 AND ${drug_cost.deleted_reference} = 'N' AND ${drug_cost.cost_type} = ${store_drug_cost_type.store_drug_cost_type} AND to_char(${store_drug_cost_region.store_setting_value}) = to_char(${drug_cost.region}) ;;
    relationship: one_to_many #[ERXLPS-1282] changed relationship from one_to_one to one_to_many
  }

  join: drug_cost_type {
    view_label: "NHIN Drug Cost Type"
    type: left_outer
    #[ERXLPS-2064] Added store_drug cost_type in join. Source is store_drug and we need to join store_drug cost_type to produce correct results for host to pharmacy comparison.
    sql_on: ${drug_cost.chain_id} = ${drug_cost_type.chain_id} AND ${drug_cost.cost_type} = ${drug_cost_type.cost_type} AND ${drug_cost_type.source_system_id} = 6 AND ${drug_cost_type.chain_id} = 3000 AND ${drug_cost_type.cost_type_deleted_reference} = 'N' AND ${drug_cost_type.cost_type} = ${store_drug_cost_type.store_drug_cost_type} ;; #[ERXLPS-1285] Added chain column to join
    relationship: many_to_one
  }

  #[ERXLPS-1246] - Removed join from DEVQA model and added to base explore
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  #[ERXDWPS-7176] - Join moved to below/after report_global_calendar join. Report_global_calendar view used in rx_tx_store_drug_cost_hist logic and expecting the calendar join to be made prior to this.
  join: rx_tx_store_drug_cost_hist {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${rx_tx_store_drug_cost_hist.chain_id} AND ${sales.nhin_store_id} = ${rx_tx_store_drug_cost_hist.nhin_store_id} AND ${sales.rx_tx_id} = ${rx_tx_store_drug_cost_hist.rx_tx_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1055] - RxTx integration into sales explore. Addition of measures from rx_tx_drug_cost_hist view
  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  #[ERXDWPS-7176] - Join moved to below/after report_global_calendar join. Report_global_calendar view used in rx_tx_drug_cost_hist logic and expecting the calendar join to be made prior to this.
  join: rx_tx_drug_cost_hist {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${rx_tx_drug_cost_hist.chain_id} AND ${sales.nhin_store_id} = ${rx_tx_drug_cost_hist.nhin_store_id} AND ${sales.rx_tx_id} = ${rx_tx_drug_cost_hist.rx_tx_id} ;;
    relationship: many_to_one
  }

  #ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker
  join: medispan_rx_tx_drug_cost_hist {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${medispan_rx_tx_drug_cost_hist.chain_id} AND ${sales.nhin_store_id} = ${medispan_rx_tx_drug_cost_hist.nhin_store_id} AND ${sales.rx_tx_id} = ${medispan_rx_tx_drug_cost_hist.rx_tx_id} ;;
    relationship: many_to_one
  }

  join: store_budget {
    view_label: "Prescription Transaction"
    type: left_outer
    relationship: many_to_one
    sql_on: ${store_budget.chain_id} = ${report_calendar_global.chain_id} AND ${report_calendar_global.report_date} = ${store_budget.report_date} AND ${store_budget.nhin_store_id} = ${sales.nhin_store_id} ;;
  }

  join: filled_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ( (    ${filled_timeframes.calendar_date} =
         ( CASE WHEN (    {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                      AND {% parameter sales.date_to_use_filter %} = 'FILLED') THEN ${report_calendar_global.report_date} ELSE ${sales.rpt_cal_filled_date} END )
    AND ${filled_timeframes.chain_id} = ${sales.chain_id}
   )
 )
 ;;
    relationship: many_to_one
  }

  join: sold_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ( (    ${sold_timeframes.calendar_date} =
        ( CASE WHEN ({% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
    AND {% parameter sales.date_to_use_filter %} = 'SOLD') THEN ${report_calendar_global.report_date} ELSE ${sales.rpt_cal_sold_date} END )
   AND ${sold_timeframes.chain_id} = ${sales.chain_id}
  )
)
 ;;
    relationship: many_to_one
  }

  join: rpt_sales_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ( (    ${rpt_sales_timeframes.calendar_date} =
        ( CASE WHEN (    {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                     AND {% parameter sales.date_to_use_filter %} = 'REPORTABLE SALES') THEN ${report_calendar_global.report_date} ELSE ${sales.rpt_cal_report_sales_date} END)
   AND ${rpt_sales_timeframes.chain_id} = ${sales.chain_id}
  )
)
 ;;
    relationship: many_to_one
  }

  join: returned_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ( (    ${returned_timeframes.calendar_date} =
        ( CASE WHEN (    {% parameter report_calendar_global.this_year_last_year_filter %} = 'Yes'
                     AND {% parameter sales.date_to_use_filter %} = 'RETURNED') THEN ${report_calendar_global.report_date} ELSE ${sales.rpt_cal_returned_date} END)
   AND ${returned_timeframes.chain_id} = ${sales.chain_id}
  )
)
 ;;
    relationship: many_to_one
  }

  join: will_call_arrival_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (  ${will_call_arrival_timeframes.calendar_date} = ${sales.will_call_arrival_date}
               AND ${will_call_arrival_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rtn_stock_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rtn_stock_timeframes.calendar_date} = ${sales.rx_tx_return_to_stock_date}
               AND ${rtn_stock_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: written_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${written_timeframes.calendar_date} = ${sales.rx_tx_written_date}
               AND ${written_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: next_refill_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${next_refill_timeframes.calendar_date} = ${sales.rx_tx_next_refill_date}
               AND ${next_refill_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: file_buy_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${file_buy_timeframes.calendar_date} = ${sales.rx_file_buy_date}
               AND ${file_buy_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  #[ERXLPS-1055] date columsn from sales_eps_rx_tx(F_RX_TX_LINK) for remaining date columns. Start here...
  join: rx_tx_pos_sold_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_pos_sold_timeframes.calendar_date} = ${sales.rx_tx_pos_sold_date}
               AND ${rx_tx_pos_sold_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_custom_reported_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_custom_reported_timeframes.calendar_date} = ${sales.rx_tx_custom_reported_date}
               AND ${rx_tx_custom_reported_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_dob_override_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_dob_override_timeframes.calendar_date} = ${sales.rx_tx_dob_override_date}
               AND ${rx_tx_dob_override_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_last_epr_synch_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_last_epr_synch_timeframes.calendar_date} = ${sales.rx_tx_last_epr_synch_date}
               AND ${rx_tx_last_epr_synch_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_missing_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_missing_timeframes.calendar_date} = ${sales.rx_tx_missing_date}
               AND ${rx_tx_missing_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_pc_ready_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_pc_ready_timeframes.calendar_date} = ${sales.rx_tx_pc_ready_date}
               AND ${rx_tx_pc_ready_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_replace_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_replace_timeframes.calendar_date} = ${sales.rx_tx_replace_date}
               AND ${rx_tx_replace_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_central_fill_cutoff_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_central_fill_cutoff_timeframes.calendar_date} = ${sales.rx_tx_central_fill_cutoff_date}
               AND ${rx_tx_central_fill_cutoff_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_drug_expiration_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_drug_expiration_timeframes.calendar_date} = ${sales.rx_tx_drug_expiration_date}
               AND ${rx_tx_drug_expiration_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_drug_image_start_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_drug_image_start_timeframes.calendar_date} = ${sales.rx_tx_drug_image_start_date}
               AND ${rx_tx_drug_image_start_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_follow_up_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_follow_up_timeframes.calendar_date} = ${sales.rx_tx_follow_up_date}
               AND ${rx_tx_follow_up_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_host_retrieval_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_host_retrieval_timeframes.calendar_date} = ${sales.rx_tx_host_retrieval_date}
               AND ${rx_tx_host_retrieval_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_photo_id_birth_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_photo_id_birth_timeframes.calendar_date} = ${sales.rx_tx_photo_id_birth_date}
               AND ${rx_tx_photo_id_birth_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_photo_id_expire_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_photo_id_expire_timeframes.calendar_date} = ${sales.rx_tx_photo_id_expire_date}
               AND ${rx_tx_photo_id_expire_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_stop_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_stop_timeframes.calendar_date} = ${sales.rx_tx_stop_date}
               AND ${rx_tx_stop_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_tx_source_create_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_tx_source_create_timeframes.calendar_date} = ${sales.rx_tx_source_create_date}
               AND ${rx_tx_source_create_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }
  #[ERXLPS-1055] date columsn from sales_eps_rx_tx(F_RX_TX_LINK) for remaining columns. End here...
  #[ERXLPS-1055] date columsn from sales_eps_rx(F_RX) for remaining columns. Start here...
  join: rx_merged_to_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_merged_to_timeframes.calendar_date} = ${sales.rx_merged_to_date}
               AND ${rx_merged_to_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_autofill_enable_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_autofill_enable_timeframes.calendar_date} = ${sales.rx_autofill_enable_date}
               AND ${rx_autofill_enable_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_received_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_received_timeframes.calendar_date} = ${sales.rx_received_date}
               AND ${rx_received_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_last_refill_reminder_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_last_refill_reminder_timeframes.calendar_date} = ${sales.rx_last_refill_reminder_date}
               AND ${rx_last_refill_reminder_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_short_fill_sent_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_short_fill_sent_timeframes.calendar_date} = ${sales.rx_short_fill_sent_date}
               AND ${rx_short_fill_sent_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_chain_first_filled_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_chain_first_filled_timeframes.calendar_date} = ${sales.rx_chain_first_filled_date}
               AND ${rx_chain_first_filled_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_expiration_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_expiration_timeframes.calendar_date} = ${sales.rx_expiration_date}
               AND ${rx_expiration_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_first_filled_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_first_filled_timeframes.calendar_date} = ${sales.rx_first_filled_date}
               AND ${rx_first_filled_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_original_written_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_original_written_timeframes.calendar_date} = ${sales.rx_original_written_date}
               AND ${rx_original_written_timeframes.chain_id} = ${sales.chain_id} --[ERXLPS-1229] Removed decode condition for Fiscal check.
              )
               ;;
    relationship: many_to_one
  }

  join: rx_start_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_start_timeframes.calendar_date} = ${sales.rx_start_date}
               AND ${rx_start_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_sync_script_enrollment_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_sync_script_enrollment_timeframes.calendar_date} = ${sales.rx_sync_script_enrollment_date}
               AND ${rx_sync_script_enrollment_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: rx_source_create_timeframes {
    from: timeframes
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: (    ${rx_source_create_timeframes.calendar_date} = ${sales.rx_source_create_date}
               AND ${rx_source_create_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }
  #[ERXLPS-1055] date columsn from sales_eps_rx(F_RX) for remaining columns. End here...
  #[ERXLPS-1845] - Added deleted check in join.
  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.


  #ERXLPS-2455
  join: sales_eps_tx_tp_transmit_queue_latest_yesno {
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${sales_eps_tx_tp_transmit_queue_latest_yesno.chain_id} = ${eps_tx_tp_transmit_queue.chain_id} AND ${sales_eps_tx_tp_transmit_queue_latest_yesno.nhin_store_id} = ${eps_tx_tp_transmit_queue.nhin_store_id} AND ${sales_eps_tx_tp_transmit_queue_latest_yesno.tx_tp_transmit_queue_id} = ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} ;;
    relationship: one_to_one
  }

  #[ERX-8] Added Tx TP SA tables as a part of 4.13.000
  join: eps_tx_tp_transmit_reject {
    from: sales_eps_tx_tp_transmit_reject
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_transmit_reject.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_transmit_reject.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_transmit_reject.tx_tp_transmit_queue_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1385] - replaced eps_tx_tp with sales_tx_tp
  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_other_payer {
    from: sales_eps_tx_tp_other_payer
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_other_payer.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_other_payer.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_other_payer.tx_tp_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_other_payer_reject {
    from: sales_eps_tx_tp_other_payer_reject
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${eps_tx_tp_other_payer.chain_id} = ${eps_tx_tp_other_payer_reject.chain_id} AND ${eps_tx_tp_other_payer.nhin_store_id} = ${eps_tx_tp_other_payer_reject.nhin_store_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_id} = ${eps_tx_tp_other_payer_reject.tx_tp_other_payer_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_other_payer_amount {
    from: sales_eps_tx_tp_other_payer_amount
    view_label: "Other Payer"
    type: left_outer
    sql_on: ${eps_tx_tp_other_payer.chain_id} = ${eps_tx_tp_other_payer_amount.chain_id} AND ${eps_tx_tp_other_payer.nhin_store_id} = ${eps_tx_tp_other_payer_amount.nhin_store_id} AND ${eps_tx_tp_other_payer.tx_tp_other_payer_id} = ${eps_tx_tp_other_payer_amount.tx_tp_other_payer_id} AND ${eps_tx_tp_other_payer_amount.tx_tp_other_payer_amount_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXLPS-1385] - replaced eps_tx_tp view with sales_tx_tp
  join: eps_tx_tp_dur {
    from: sales_eps_tx_tp_dur
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_dur.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_dur.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_dur.tx_tp_id} ;;
    relationship: one_to_many
  }

  #[ERXLPS-1385] - replaced eps_tx_tp with sales_tx_tp
  #[ERXLPS-1845] - Added deleted check in join.
  join: eps_tx_tp_denial_clarification {
    from: sales_eps_tx_tp_denial_clarification
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${eps_tx_tp_denial_clarification.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${eps_tx_tp_denial_clarification.nhin_store_id} AND ${sales_tx_tp.tx_tp_id} = ${eps_tx_tp_denial_clarification.tx_tp_id} AND ${eps_tx_tp_denial_clarification.tx_tp_denial_clarification_deleted_reference} = 'N' ;;
    relationship: one_to_many
  }

  join: transmit_queue_submission_timeframes {
    from: timeframes
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: (    ${transmit_queue_submission_timeframes.calendar_date} = ${sales.tx_tp_transmit_queue_submission_date}
               AND ${transmit_queue_submission_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: transmit_queue_response_timeframes {
    from: timeframes
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: (    ${transmit_queue_response_timeframes.calendar_date} = ${sales.tx_tp_transmit_queue_response_date}
               AND ${transmit_queue_response_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: transmit_queue_original_submit_timeframes {
    from: timeframes
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: (    ${transmit_queue_original_submit_timeframes.calendar_date} = ${sales.tx_tp_transmit_queue_original_submit_date}
               AND ${transmit_queue_original_submit_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: transmit_queue_fill_override_timeframes {
    from: timeframes
    view_label: "TP Transmit Queue"
    type: left_outer
    sql_on: (    ${transmit_queue_fill_override_timeframes.calendar_date} = ${sales.tx_tp_transmit_queue_fill_override_date}
               AND ${transmit_queue_fill_override_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: store_tp_link_begin_timeframes {
    from: timeframes
    view_label: "Claim Card"
    type: left_outer
    sql_on: (    ${store_tp_link_begin_timeframes.calendar_date} = ${sales.store_tp_link_begin_date}
               AND ${store_tp_link_begin_timeframes.chain_id} = ${sales.chain_id} --[ERXLPS-1229] Removed decode condition for Fiscal check.
              )
               ;;
    relationship: many_to_one
  }

  join: store_tp_link_store_last_used_timeframes {
    from: timeframes
    view_label: "Claim Card"
    type: left_outer
    sql_on: (    ${store_tp_link_store_last_used_timeframes.calendar_date} = ${sales.store_tp_link_store_last_used_date}
               AND ${store_tp_link_store_last_used_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: store_card_deactivate_timeframes {
    from: timeframes
    view_label: "Claim Card"
    type: left_outer
    sql_on: (    ${store_card_deactivate_timeframes.calendar_date} = ${sales.store_card_deactivate_date}
               AND ${store_card_deactivate_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: store_card_end_timeframes {
    from: timeframes
    view_label: "Claim Card"
    type: left_outer
    sql_on: (    ${store_card_end_timeframes.calendar_date} = ${sales.store_card_end_date}
               AND ${store_card_end_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }
  #[ERXLPS-794] added timeframe join
  join: patient_last_filled_timeframes {
    from: timeframes
    view_label: "Patient - Store"
    type: left_outer
    sql_on: (    ${patient_last_filled_timeframes.calendar_date} = ${sales.last_filled_date}
               AND ${patient_last_filled_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: patient_first_fill_timeframes {
    from: timeframes
    view_label: "Patient - Store"
    type: left_outer
    sql_on: (    ${patient_first_fill_timeframes.calendar_date} = ${sales.first_fill_date}
               AND ${patient_first_fill_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: patient_source_create_timeframes {
    from: timeframes
    view_label: "Patient - Store"
    type: left_outer
    sql_on: (    ${patient_source_create_timeframes.calendar_date} = ${sales.patient_source_create_date}
               AND ${patient_source_create_timeframes.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: store_compound {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound.chain_id} = ${store_drug.chain_id}  AND ${store_compound.nhin_store_id} = ${store_drug.nhin_store_id} AND to_char(${store_compound.compound_id}) = ${store_drug.drug_id} AND ${store_compound.compound_deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: store_compound_ingredient {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient.chain_id} = ${store_compound.chain_id}  AND ${store_compound_ingredient.nhin_store_id} = ${store_compound.nhin_store_id} AND ${store_compound_ingredient.compound_id} = ${store_compound.compound_id} AND ${store_compound_ingredient.compound_ingredient_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: store_compound_ingredient_modifier {
    type: left_outer
    view_label: "Compound"
    sql_on: ${store_compound_ingredient_modifier.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_modifier.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_modifier.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_modifier.compound_ingredient_modifier_deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: store_compound_ingredient_tx {
    type: left_outer
    view_label: "Compound Transaction"
    fields: [explore_rx_store_compound_ingredient_tx_sales_4_10_candidate_list*]
    sql_on: ${store_compound_ingredient_tx.chain_id} = ${store_compound_ingredient.chain_id}  AND ${store_compound_ingredient_tx.nhin_store_id} = ${store_compound_ingredient.nhin_store_id} AND ${store_compound_ingredient_tx.compound_ingredient_id} = ${store_compound_ingredient.compound_ingredient_id} AND ${store_compound_ingredient_tx.compound_ingredient_tx_deleted} = 'N' AND ${store_compound_ingredient_tx.chain_id} = ${sales.chain_id} AND ${store_compound_ingredient_tx.nhin_store_id} = ${sales.nhin_store_id} AND ${store_compound_ingredient_tx.rx_tx_id} = ${sales.rx_tx_id} ;;
    relationship: many_to_many
  }

  join: store_compound_ingredient_tx_lot {
    type: left_outer
    view_label: "Compound Transaction"
    sql_on: ${store_compound_ingredient_tx_lot.chain_id} = ${store_compound_ingredient_tx.chain_id}  AND ${store_compound_ingredient_tx_lot.nhin_store_id} = ${store_compound_ingredient_tx.nhin_store_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_id} = ${store_compound_ingredient_tx.compound_ingredient_tx_id} AND ${store_compound_ingredient_tx_lot.compound_ingredient_tx_lot_deleted} = 'N' ;;
    relationship: one_to_many
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: sales_rx_tx_transfer {
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${sales.chain_id}
              AND ${sales_rx_tx_transfer.nhin_store_id} = ${sales.nhin_store_id}
              AND ${sales_rx_tx_transfer.rx_id} = ${sales.rx_id}
              AND coalesce(${sales_rx_tx_transfer.rx_tx_id}, ${sales.rx_tx_id}) = ${sales.rx_tx_id}
               ;;
    relationship: many_to_many
  }

  join: sales_rx_tx_transfer_prior_fill_dates {
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${sales_rx_tx_transfer_prior_fill_dates.chain_id} AND ${sales_rx_tx_transfer.nhin_store_id} = ${sales_rx_tx_transfer_prior_fill_dates.nhin_store_id} AND ${sales_rx_tx_transfer.transfer_id} = ${sales_rx_tx_transfer_prior_fill_dates.transfer_id} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-6382] - Looker: Sales explore - Modify applicable joins which are utilizing eps_rx or eps_rx_tx view files to use Sales View file
  join: sales_rx_tx_transfer_request_queue {
    view_label: "Transfers"
    type: left_outer
    sql_on: ${sales_rx_tx_transfer_request_queue.chain_id} = ${sales.chain_id}
              AND ${sales_rx_tx_transfer_request_queue.nhin_store_id} = ${sales.nhin_store_id}
              AND nvl(${sales_rx_tx_transfer_request_queue.transfer_request_receiving_rx_summary_id}, ${sales_rx_tx_transfer_request_queue.transfer_request_sending_rx_number})
              =  nvl2(${sales_rx_tx_transfer_request_queue.transfer_request_receiving_rx_summary_id}, ${sales.rx_id}, ${sales.rx_number})
               ;;
    relationship: many_to_many
  }

  #[ERXLPS-1535]
  join: sales_rx_tx_transfer_pharmacy {
    from: eps_pharmacy
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy.chain_id} = ${sales_rx_tx_transfer.chain_id}
              AND ${sales_rx_tx_transfer_pharmacy.nhin_store_id} = ${sales_rx_tx_transfer.nhin_store_id}
              AND ${sales_rx_tx_transfer_pharmacy.pharmacy_id} = ${sales_rx_tx_transfer.pharmacy_id} ;;
    relationship: many_to_one
  }

  join: sales_rx_tx_transfer_pharmacy_address {
    from: eps_address
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy_address.chain_id} = ${sales_rx_tx_transfer_pharmacy.chain_id}
              AND ${sales_rx_tx_transfer_pharmacy_address.nhin_store_id} = ${sales_rx_tx_transfer_pharmacy.nhin_store_id}
              AND to_char(${sales_rx_tx_transfer_pharmacy_address.address_id}) = to_char(${sales_rx_tx_transfer_pharmacy.pharmacy_address_id})
              AND ${sales_rx_tx_transfer_pharmacy_address.source_system_id} = ${sales_rx_tx_transfer_pharmacy.source_system_id} ;; #[ERXDWPS-5137] Added to_char on both sides to avoid issues with before and after datatype conversions.
    relationship: one_to_one
  }

  #[ERXLPS-1553] - Adding Other Pharmacy Phone Number for Transfer script
  join: sales_rx_tx_transfer_pharmacy_phone {
    from: eps_phone
    view_label: "Transfers"
    type:  left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer_pharmacy_phone.chain_id} = ${sales_rx_tx_transfer_pharmacy.chain_id}
              AND ${sales_rx_tx_transfer_pharmacy_phone.nhin_store_id} = ${sales_rx_tx_transfer_pharmacy.nhin_store_id}
              AND to_char(${sales_rx_tx_transfer_pharmacy_phone.phone_id}) = to_char(${sales_rx_tx_transfer_pharmacy.pharmacy_phone_id})
              AND ${sales_rx_tx_transfer_pharmacy_phone.source_system_id} = ${sales_rx_tx_transfer_pharmacy.source_system_id} ;; #[ERXDWPS-5137]
    relationship: one_to_one
  }

  #[ERXLPS-2599]
  join: store_transfer_reason {
    view_label: "Transfers"
    type: left_outer
    fields: []
    sql_on: ${sales_rx_tx_transfer.chain_id} = ${store_transfer_reason.chain_id}
              AND ${sales_rx_tx_transfer.nhin_store_id} = ${store_transfer_reason.nhin_store_id}
              AND ${sales_rx_tx_transfer.transfer_reason_id} = ${store_transfer_reason.transfer_reason_id}
               ;;
    relationship: one_to_one
  }

  #[ERXLPS-726] - tx_tp_response_detail and detail_amount integration to Sales explore
  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.
  join: eps_tx_tp_response_detail {
    from: sales_eps_tx_tp_response_detail
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_transmit_queue.chain_id} = ${eps_tx_tp_response_detail.chain_id} AND ${eps_tx_tp_transmit_queue.nhin_store_id} = ${eps_tx_tp_response_detail.nhin_store_id} AND ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_id} = ${eps_tx_tp_response_detail.tx_tp_response_detail_id} ;;
    relationship: one_to_one
  }

  #[ERXDWPS-7020] - Removed fileds: [sets] definition from joins. View cleaned up for Sales explore.
  join: eps_tx_tp_response_detail_amount {
    from: sales_eps_tx_tp_response_detail_amount
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_response_detail_amount.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_response_detail_amount.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_response_detail_amount.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  #[ERX-8] added Tx Tp SA tables as a part of 4.13.000 release
  join: eps_tx_tp_resp_approval_message {
    from: sales_eps_tx_tp_resp_approval_message
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_resp_approval_message.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_resp_approval_message.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_resp_approval_message.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_resp_additional_message {
    from: sales_eps_tx_tp_resp_additional_message
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_resp_additional_message.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_resp_additional_message.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_resp_additional_message.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }

  join: eps_tx_tp_response_preferred_product {
    from: sales_eps_tx_tp_response_preferred_product
    view_label: "Response Detail"
    type: left_outer
    sql_on: ${eps_tx_tp_response_detail.chain_id} = ${eps_tx_tp_response_preferred_product.chain_id} AND ${eps_tx_tp_response_detail.nhin_store_id} = ${eps_tx_tp_response_preferred_product.nhin_store_id} AND ${eps_tx_tp_response_detail.tx_tp_response_detail_id} = ${eps_tx_tp_response_preferred_product.tx_tp_response_detail_id} ;;
    relationship: one_to_many
  }



  join: tx_tp_response_detail_service_timeframe {
    from: timeframes
    view_label: "Response Detail"
    type: left_outer
    sql_on: (    ${tx_tp_response_detail_service_timeframe.calendar_date} = ${sales.tx_tp_response_detail_service_date}
               AND ${tx_tp_response_detail_service_timeframe.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: tx_tp_submit_detail_service_timeframe {
    from: timeframes
    view_label: "Submit Detail"
    type: left_outer
    sql_on: (    ${tx_tp_submit_detail_service_timeframe.calendar_date} = ${sales.tx_tp_submit_detail_service_date}
               AND ${tx_tp_submit_detail_service_timeframe.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: tx_tp_submit_detail_patient_birth_timeframe {
    from: timeframes
    view_label: "Submit Detail"
    type: left_outer
    sql_on: (    ${tx_tp_submit_detail_patient_birth_timeframe.calendar_date} = ${sales.tx_tp_submit_detail_patient_birth_date}
               AND ${tx_tp_submit_detail_patient_birth_timeframe.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  join: tx_tp_submit_detail_workers_comp_injury_timeframe {
    from: timeframes
    view_label: "Submit Detail"
    type: left_outer
    sql_on: (    ${tx_tp_submit_detail_workers_comp_injury_timeframe.calendar_date} = ${sales.tx_tp_submit_detail_workers_comp_injury_date}
               AND ${tx_tp_submit_detail_workers_comp_injury_timeframe.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  #[ERXLPS-1020] tx_tp_denial_date financial calendar timeframes
  join: tx_tp_denial_timeframe {
    from: timeframes
    view_label: "Claim"
    type: left_outer
    sql_on: (    ${tx_tp_denial_timeframe.calendar_date} = ${sales.tx_tp_denial_date}
               AND ${tx_tp_denial_timeframe.chain_id} = ${sales.chain_id}
              )
               ;;
    relationship: many_to_one
  }

  #[ERXLPS-1599]
  join: eps_shipment {
    from: sales_eps_shipment
    view_label: "Shipment - Store"
    type: left_outer
    sql_on: ${eps_shipment.chain_id} = ${sales.chain_id} AND ${eps_shipment.nhin_store_id} = ${sales.nhin_store_id} AND ${eps_shipment.shipment_id} = ${sales.shipment_id} ;;
    relationship: many_to_one
  }

  #[ERXLPS-1438] - Patient Card Details
  join: patient_eps_tp_link {
    from: eps_tp_link
    view_label: "Patient Card - Store"
    fields: [sales_patient_tp_link_candidate_list*] #[ERXLPS-2383] Updated set name.
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${patient_eps_tp_link.chain_id} AND ${eps_patient.nhin_store_id} = ${patient_eps_tp_link.nhin_store_id} AND ${eps_patient.patient_id} = to_char(${patient_eps_tp_link.patient_id}) AND ${eps_patient.source_system_id} = ${patient_eps_tp_link.source_system_id} ;; #[ERXDWPS-1532]
    relationship: one_to_many
  }

  join: patient_eps_card {
    from: eps_card
    fields: [eps_card_dates_menu_candidate_list*]
    view_label: "Patient Card - Store"
    type: left_outer
    sql_on: ${patient_eps_tp_link.chain_id} = ${patient_eps_card.chain_id} AND ${patient_eps_tp_link.nhin_store_id} = ${patient_eps_card.nhin_store_id} AND ${patient_eps_tp_link.card_id} = ${patient_eps_card.card_id} AND ${patient_eps_tp_link.source_system_id} = ${patient_eps_card.source_system_id} ;; #[ERXDWPS-1530]
    relationship: many_to_one
  }

  join: patient_eps_plan {
    from: eps_plan
    fields: [explore_sales_patient_plan_candidate_list*]
    view_label: "Patient Plan - Store"
    type: left_outer
    sql_on: ${patient_eps_card.chain_id} = ${patient_eps_plan.chain_id} AND ${patient_eps_card.nhin_store_id} = ${patient_eps_plan.nhin_store_id} AND ${patient_eps_card.plan_id} = ${patient_eps_plan.plan_id} AND ${patient_eps_card.source_system_id} = ${patient_eps_plan.source_system_id} ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  join: patient_eps_plan_transmit {
    from: eps_plan_transmit
    fields: [explore_sales_patient_plan_candidate_list*]
    view_label: "Patient Plan - Store"
    type: left_outer
    sql_on: ${patient_eps_plan.chain_id} = ${patient_eps_plan_transmit.chain_id} AND ${patient_eps_plan.nhin_store_id} = ${patient_eps_plan_transmit.nhin_store_id} AND ${patient_eps_plan.plan_id} = ${patient_eps_plan_transmit.plan_id} AND ${patient_eps_plan.source_system_id} = ${patient_eps_plan_transmit.source_system_id} AND ${patient_eps_plan_transmit.store_plan_transmit_deleted} = 'N' ;; #ERXDWPS-5124
    relationship: many_to_one
  }

  #ERXLPS-2505
  join: store_rx_tx_barcode_scan_current_state {
    from: store_rx_tx_barcode_scan_history
    view_label: "Barcode Scan"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_rx_tx_barcode_scan_current_state.chain_id} AND ${sales.nhin_store_id} = ${store_rx_tx_barcode_scan_current_state.nhin_store_id} AND ${sales.rx_tx_id} = ${store_rx_tx_barcode_scan_current_state.rx_tx_id} AND ${store_rx_tx_barcode_scan_current_state.barcode_scan_rnk} = 1 ;;
    relationship: many_to_one
    fields: [sales_barcode_scan_current_list*]
  }

  #[ERXLPS-2321]
  join: sales_primary_payer_cost {
    view_label: "Claim"
    type: left_outer
    sql_on: ${sales_tx_tp.chain_id} = ${sales_primary_payer_cost.chain_id} AND ${sales_tx_tp.nhin_store_id} = ${sales_primary_payer_cost.nhin_store_id} AND ${sales_tx_tp.rx_tx_id} = ${sales_primary_payer_cost.rx_tx_id} ;;
    relationship: many_to_one
  }

  #ERXLPS-1349 #ERXLPS-1383
  join: sales_store_central_fill {
    view_label: "Central Fill - Store"
    type: left_outer
    sql_on: ${sales_store_central_fill.chain_id}         = ${sales.chain_id}
        and ${sales_store_central_fill.nhin_store_id}    = ${sales.nhin_store_id}
        and ${sales_store_central_fill.source_system_id} = ${sales.source_system_id}
        and ${sales_store_central_fill.central_fill_id}  = ${sales.rx_tx_id} ;;
    relationship: many_to_one
  }

  #ERXLPS-1349 #ERXLPS-1383
  join: sales_store_package_information {
    view_label: "Package Information - Store"
    type: left_outer
    sql_on: ${sales_store_package_information.chain_id}                     = ${sales_store_central_fill.chain_id}
        and ${sales_store_package_information.nhin_store_id}                = ${sales_store_central_fill.nhin_store_id}
        and ${sales_store_package_information.source_system_id}             = ${sales_store_central_fill.source_system_id}
        and ${sales_store_package_information.store_package_information_id} = ${sales_store_central_fill.package_information_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-5091] - Store Price Code at Fill
  join: store_price_code_hist_listagg {
    view_label: "Prescription Transaction"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_price_code_hist_listagg.chain_id}
        and ${sales.nhin_store_id} = ${store_price_code_hist_listagg.nhin_store_id}
        and ${sales.rx_tx_price_code_id} = ${store_price_code_hist_listagg.price_code_id}
        and ${sales.source_system_id} = ${store_price_code_hist_listagg.source_system_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-6304] - Store Patient Diagnosis information exposed in Sales Explore. After discussing with Joe, we decided to expose Diagnosis (contains ICD10 information) info as ICD9 information was already exposed.
  join: store_patient_diagnosis {
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    sql_on: ${eps_patient.chain_id} = ${store_patient_diagnosis.chain_id} AND ${eps_patient.nhin_store_id} = ${store_patient_diagnosis.nhin_store_id} AND ${eps_patient.patient_id} = ${store_patient_diagnosis.patient_id} ;; #[ERXDWPS-5137] Removed to_char from eps_patient.patient_id.
    relationship: one_to_many
  }

  join: store_patient_icd10 {
    from: store_icd10
    view_label: "Patient Diagnosis - Store"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_patient_diagnosis.chain_id} = ${store_patient_icd10.chain_id}
        AND ${store_patient_diagnosis.nhin_store_id} = ${store_patient_icd10.nhin_store_id}
        AND ${store_patient_diagnosis.store_patient_diagnosis_icd10_code} = ${store_patient_icd10.store_icd10_code} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-6304] - RX TX ICD9 join to get description.
  join: sales_rx_tx_icd9 {
    from: store_icd9
    view_label: "Prescription Transaction"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${sales.chain_id} = ${sales_rx_tx_icd9.chain_id}
        AND ${sales.nhin_store_id} = ${sales_rx_tx_icd9.nhin_store_id}
        AND ${sales.rx_tx_icd9_code} = ${sales_rx_tx_icd9.store_icd9_code}
        AND ${sales.rx_tx_icd9_type_reference} = ${sales_rx_tx_icd9.store_icd9_prefix_reference};;
    relationship: many_to_many
  }

  #[ERXDWPS-6304] - Store rx_tx diagnosis code information
  join: store_rx_tx_diagnosis_code {
    from: sales_store_rx_tx_diagnosis_code
    view_label: "Prescription Transaction Diagnosis"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_rx_tx_diagnosis_code.chain_id}
        AND ${sales.nhin_store_id} = ${store_rx_tx_diagnosis_code.nhin_store_id}
        AND ${sales.rx_tx_id} = ${store_rx_tx_diagnosis_code.rx_tx_id}
        AND ${sales.source_system_id} = ${store_rx_tx_diagnosis_code.source_system_id} ;;
    relationship: one_to_many
  }

  #[ERXDWPS-6304] - RX TX ICD9 join to get description.
  join: sales_rx_tx_diagnosis_code_icd9 {
    from: store_icd9
    view_label: "Prescription Transaction Diagnosis"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_rx_tx_diagnosis_code.chain_id} = ${sales_rx_tx_diagnosis_code_icd9.chain_id}
        AND ${store_rx_tx_diagnosis_code.nhin_store_id} = ${sales_rx_tx_diagnosis_code_icd9.nhin_store_id}
        AND ${store_rx_tx_diagnosis_code.store_rx_tx_diagnosis_code_qualifier} IS NULL
        AND ${store_rx_tx_diagnosis_code.store_rx_tx_diagnosis_code} = ${sales_rx_tx_diagnosis_code_icd9.store_icd9_code}
        AND ${store_rx_tx_diagnosis_code.store_rx_tx_diagnosis_code_prefix_reference} = ${sales_rx_tx_diagnosis_code_icd9.store_icd9_prefix_reference};;
    relationship: many_to_many
  }

  #[ERXDWPS-6304] - RX TX ICD10 join to get description.
  join: sales_rx_tx_diagnosis_code_icd10 {
    from: store_icd10
    view_label: "Prescription Transaction Diagnosis"
    type: left_outer
    fields: [-ALL_FIELDS*]
    sql_on: ${store_rx_tx_diagnosis_code.chain_id} = ${sales_rx_tx_diagnosis_code_icd10.chain_id}
        AND ${store_rx_tx_diagnosis_code.nhin_store_id} = ${sales_rx_tx_diagnosis_code_icd10.nhin_store_id}
        AND ${store_rx_tx_diagnosis_code.store_rx_tx_diagnosis_code_qualifier} = '1'
        AND ${store_rx_tx_diagnosis_code.store_rx_tx_diagnosis_code} = ${sales_rx_tx_diagnosis_code_icd10.store_icd10_code} ;;
    relationship: many_to_many
  }

  #[ERXDWPS-6197]
  join: store_rx_tx_tp_detail_flatten {
    from: sales_store_rx_tx_tp_detail_flatten
    view_label: "Prescription Transaction Claim Detail Flatten"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_rx_tx_tp_detail_flatten.chain_id}
        AND ${sales.nhin_store_id} = ${store_rx_tx_tp_detail_flatten.nhin_store_id}
        AND ${sales.rx_tx_id} = ${store_rx_tx_tp_detail_flatten.rx_tx_id}
        AND ${sales.source_system_id} = ${store_rx_tx_tp_detail_flatten.source_system_id} ;;
    relationship: many_to_one
  }

  #[ERXDWPS-8260] COSTCO SOW - Moving Average Cost - Sales Looker Dimensions and Measures
  join: store_rx_tx_detail_flatten {
    view_label: "Prescription Transaction Detail Flatten"
    type: left_outer
    sql_on: ${sales.chain_id} = ${store_rx_tx_detail_flatten.chain_id}
        AND ${sales.nhin_store_id} = ${store_rx_tx_detail_flatten.nhin_store_id}
        AND ${sales.rx_tx_id} = ${store_rx_tx_detail_flatten.rx_tx_id}
        AND ${sales.source_system_id} = ${store_rx_tx_detail_flatten.source_system_id} ;;
    relationship: many_to_one
  }

}

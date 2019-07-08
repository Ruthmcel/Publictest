- dashboard: edx_tmpl_chain_pdc_overview
  title: Dashboard - PDC Overview
  layout: newspaper
  elements:
  - name: 'Sales: PDC - Patient Counts by Pharmacy and PDC Medical Condition'
    title: 'Sales: PDC - Patient Counts by Pharmacy and PDC Medical Condition'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - patient.patient_count
    - gpi_medical_condition_cross_ref.medical_condition
    pivots:
    - gpi_medical_condition_cross_ref.medical_condition
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 3 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store.store_number: ''
      eps_plan_transmit.store_plan_transmit_bin_number: "-NULL"
      sales.file_buy_flag: 'No'
    sorts:
    - store.store_number
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: patient_count
      label: Patient Count %
      expression: "${patient.patient_count}/${patient.patient_count:row_total}"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 23
    col: 0
    width: 24
    height: 8
  - name: 'Sales: PDC Score by Medical Condition'
    title: 'Sales: PDC Score by Medical Condition'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient_gpi_pdc.avg_at_least_one_pdc_score_180
    - patient_gpi_pdc.avg_at_least_one_pdc_score_365
    - patient_gpi_pdc.avg_at_least_one_pdc_score_730
    - gpi_medical_condition_cross_ref.medical_condition
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      gpi_medical_condition_cross_ref.medical_condition: "-NULL"
      sales.file_buy_flag: 'No'
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 8
    col: 0
    width: 24
    height: 7
  - name: 'Sales: PDC Score by Plan BIN'
    title: 'Sales: PDC Score by Plan BIN'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - eps_plan_transmit.store_plan_transmit_bin_number
    - sales.count
    - sales.sum_net_sales
    - patient_gpi_pdc.avg_at_least_one_pdc_score_180
    - patient_gpi_pdc.avg_at_least_one_pdc_score_365
    - patient_gpi_pdc.avg_at_least_one_pdc_score_730
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      eps_plan_transmit.store_plan_transmit_bin_number: "-NULL"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 20
    column_limit: 50
    row: 15
    col: 0
    width: 24
    height: 8
  - name: 'Sales: PDC Score 6 Month Patient Distribution by Pharmacy'
    title: 'Sales: PDC Score 6 Month Patient Distribution by Pharmacy'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - patient_gpi_pdc.patient_all_score_180_tier
    - patient.patient_count
    pivots:
    - patient_gpi_pdc.patient_all_score_180_tier
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      eps_plan_transmit.store_plan_transmit_bin_number: "-NULL"
      sales.file_buy_flag: 'No'
      store.store_number: ''
    sorts:
    - patient.patient_count desc 0
    - patient_gpi_pdc.patient_all_score_180_tier 0
    - store.store_number
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: patient_count
      label: Patient Count %
      expression: "${patient.patient_count}/${patient.patient_count:row_total}"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    row: 0
    col: 0
    width: 24
    height: 8
  - name: "============================= Dashboard End ============================="
    type: text
    title_text: "============================= Dashboard End ============================="
    row: 31
    col: 0
    width: 24
    height: 2

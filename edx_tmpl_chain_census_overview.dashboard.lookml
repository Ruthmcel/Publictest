- dashboard: edx_tmpl_chain_census_overview
  title: Dashboard - Census Overview
  layout: newspaper
  elements:
  - name: 'Sales: Census Analysis - Pharmacy Patients vs Census Total Data'
    title: 'Sales: Census Analysis - Pharmacy Patients vs Census Total Data'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - store_alignment.pharmacy_short_name
    - patient.patient_count
    - store_state_location.store_zip_code_population_count_100
    - store_state_location.store_zip_code_estimated_population
    - store_state_location.state_abbreviation
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 quarters
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      patient.sex: "-UNKNOWN"
    sorts:
    - store.store_number
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: census_population
      label: Census Population %
      expression: "${patient.patient_count}/${store_state_location.store_zip_code_population_count_100}"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
    - table_calculation: irs_estimated_population
      label: IRS Estimated Population %
      expression: "${patient.patient_count}/${store_state_location.store_zip_code_estimated_population}"
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
  - name: 'Sales: Census Analysis - Pharmacy Patients vs Census Gender Data'
    title: 'Sales: Census Analysis - Pharmacy Patients vs Census Gender Data'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - store_alignment.pharmacy_short_name
    - patient.patient_count
    - store_state_location.state_abbreviation
    - patient.sex
    - store_state_location.store_zip_code_female_population
    - store_state_location.store_zip_code_male_population
    pivots:
    - patient.sex
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 quarters
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      patient.sex: "-UNKNOWN"
    sorts:
    - store.store_number
    - patient.sex
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: census_population
      label: Census Population %
      expression: if(${patient.sex} = "MALE",${patient.patient_count}/${store_state_location.store_zip_code_male_population},${patient.patient_count}/${store_state_location.store_zip_code_female_population})
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
    hidden_fields:
    - store_state_location.store_zip_code_female_population
    - store_state_location.store_zip_code_male_population
    row: 8
    col: 0
    width: 24
    height: 8
  - name: Inventory - Dead Inventory (no movement in >= 8 months)
    title: Inventory - Dead Inventory (no movement in >= 8 months)
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - store.store_name
    - store.store_number
    - store_drug.ndc
    - store_drug.drug_name
    - store_drug_local_setting.drug_local_setting_manufacturer
    - store_drug_local_setting.drug_local_setting_last_fill_date
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_reorder.sum_drug_reorder_order_point
    - store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    - store_drug_local_setting.sum_drug_local_setting_on_hand
    filters:
      store_drug_local_setting.drug_local_setting_on_hand_filter: ">0"
      store_drug.ndc: "-C%"
      store.store_number: "-NULL"
      store_drug_reorder.sum_drug_reorder_order_point: ">0"
    sorts:
    - store_drug_local_setting.sum_drug_local_setting_on_hand desc
    - store_drug_local_setting.drug_local_setting_last_fill_date desc
    limit: 500
    column_limit: 50
    total: true
    filter_expression: " if(is_null(${store_drug_local_setting.drug_local_setting_last_fill_date})\
      \ AND is_null(${store_drug_reorder.drug_reorder_last_order_date}),yes,if(diff_days(now(),\
      \ ${store_drug_local_setting.drug_local_setting_last_fill_date}) > 240 AND diff_days(now(),${store_drug_reorder.drug_reorder_last_order_date})>\
      \ 90,yes,no ))\n  \n  \n  \n  "
    query_timezone: America/Chicago
    hidden_fields:
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_local_setting.drug_local_setting_last_fill_date
    row: 16
    col: 0
    width: 24
    height: 8

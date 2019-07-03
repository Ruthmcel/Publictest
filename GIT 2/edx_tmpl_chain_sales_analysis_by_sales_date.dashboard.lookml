- dashboard: edx_tmpl_chain_sales_analysis_by_sales_date
  title: Dashboard - Sales Analysis by Sales Date {SASD}
  layout: newspaper
  elements:
  - name: 'Sales: SASD - Script Detail {Last Week}'
    title: 'Sales: SASD - Script Detail {Last Week}'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - eps_plan.store_plan_carrier_code
    - sales_tx_tp.tx_tp_counter_description
    - sales.financial_category
    - sales.rx_tx_tx_number
    - sales.reportable_sales_date
    - sales.sum_price
    - sales.sum_tax
    - sales.sum_discount
    - sales.sum_net_sales
    - sales.sum_write_off
    - sales.sum_final_copay
    - sales.copay_override_amount
    - sales.sum_net_due
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: DETAIL
    sorts:
    - eps_plan.store_plan_carrier_code
    - sales_tx_tp.tx_tp_counter_description
    - sales.financial_category
    - sales.reportable_sales_date
    limit: 5000
    column_limit: 50
    query_timezone: America/Chicago
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: store.chain_id
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 16
    col: 0
    width: 24
    height: 8
  - name: 'Sales: SASD - Third Party Scripts {Last Week}'
    title: 'Sales: SASD - Third Party Scripts {Last Week}'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.financial_category
    - sales.count
    - sales.sum_acquisition_cost
    - sales.sum_price
    - sales.sum_gross_margin
    - sales.sum_tax
    - sales.sum_discount
    - sales.sum_net_sales
    - sales.sum_net_gross_margin
    - sales.sum_write_off
    - sales.sum_final_copay
    - sales.copay_override_amount
    - sales.sum_net_due
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: T/P - CREDIT,T/P - FILLED
    sorts:
    - sales.count desc
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: store.chain_id
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 0
    col: 0
    width: 24
    height: 4
  - name: 'Sales: SASD - Plan Carrier Code Summary {Last Week}'
    title: 'Sales: SASD - Plan Carrier Code Summary {Last Week}'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.financial_category
    - eps_plan.store_plan_carrier_code
    - sales.count
    - sales.sum_acquisition_cost
    - sales.sum_price
    - sales.sum_gross_margin
    - sales.sum_tax
    - sales.sum_discount
    - sales.sum_net_sales
    - sales.sum_net_gross_margin
    - sales.sum_write_off
    - sales.sum_final_copay
    - sales.copay_override_amount
    - sales.sum_net_due
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
    sorts:
    - sales.financial_category
    - eps_plan.store_plan_carrier_code
    limit: 5000
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: store.chain_id
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 8
    col: 0
    width: 24
    height: 8
  - name: 'Sales: SASD - Cash Scripts {Last Week}'
    title: 'Sales: SASD - Cash Scripts {Last Week}'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.financial_category
    - sales.count
    - sales.sum_acquisition_cost
    - sales.sum_price
    - sales.sum_gross_margin
    - sales.sum_tax
    - sales.sum_discount
    - sales.sum_net_sales
    - sales.sum_net_gross_margin
    - sales.sum_write_off
    - sales.sum_final_copay
    - sales.copay_override_amount
    - sales.sum_net_due
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: CASH - FILLED,CASH - CREDIT
    sorts:
    - sales.count desc
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: store.chain_id
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 4
    col: 0
    width: 24
    height: 4
  filters:
  - name: Pharmacy Number
    title: Pharmacy Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store.store_number
  - name: Chain ID
    title: Chain ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: store.chain_id
  - name: Date to Use
    title: Date to Use
    type: field_filter
    default_value: REPORTABLE SALES
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: sales.date_to_use_filter
  - name: Report Period
    title: Report Period
    type: field_filter
    default_value: 1 weeks ago for 1 weeks
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: report_calendar_global.report_period_filter
  - name: Report Period - Analysis Calendar
    title: Report Period - Analysis Calendar
    type: field_filter
    default_value: Fiscal - Week
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: report_calendar_global.analysis_calendar_filter

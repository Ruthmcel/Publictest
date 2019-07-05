- dashboard: edx_tmpl_chain_flash_report_week
  title: Dashboard - Flash Report - Week
  layout: newspaper
  elements:
  - name: Chain Name
    title: Chain Name
    model: PDX_CUSTOMER_DSS
    explore: store
    type: single_value
    fields:
    - chain.chain_name
    sorts:
    - chain.chain_name
    limit: 500
    column_limit: 50
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    custom_color_enabled: false
    custom_color: forestgreen
    listen:
      Chain ID: chain.chain_id
    row: 0
    col: 0
    width: 6
    height: 5
  - name: 'Sales: Flash Report - Average Script Net Sale - Week'
    title: 'Sales: Flash Report - Average Script Net Sale - Week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.date_to_use
    - sales.report_date
    - sales.report_period_day_of_week
    - sales.avg_net_sales
    - sales.avg_net_sales_ly
    - sales.avg_net_sales_variance
    - drug.drug_brand_generic
    pivots:
    - drug.drug_brand_generic
    fill_fields:
    - drug.drug_brand_generic
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
    sorts:
    - sales.report_date
    - drug.drug_brand_generic
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: false
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
    - sales.date_to_use
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    listen:
      Pharmacy Division: store_alignment.division
      Pharmacy Region: store_alignment.region
      Pharmacy District: store_alignment.district
      Pharmacy Number: store.store_number
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
      File Buy Flag (Yes/No): sales.file_buy_flag
      Financial Category: sales.financial_category
      Chain ID: chain.chain_id
    row: 11
    col: 6
    width: 18
    height: 7
  - name: 'Sales: Flash Report - Net Sales & Margin - Week'
    title: 'Sales: Flash Report - Net Sales & Margin - Week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.date_to_use
    - sales.report_date
    - sales.report_period_day_of_week
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - sales.sum_net_sales_variance
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    - sales.sum_net_gross_margin_variance
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
    sorts:
    - sales.report_date
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: false
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
    - sales.date_to_use
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    listen:
      Pharmacy Division: store_alignment.division
      Pharmacy Region: store_alignment.region
      Pharmacy District: store_alignment.district
      Pharmacy Number: store.store_number
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
      File Buy Flag (Yes/No): sales.file_buy_flag
      Financial Category: sales.financial_category
      Chain ID: chain.chain_id
    row: 0
    col: 6
    width: 18
    height: 6
  - name: 'Sales: Flash Report - Script Counts - Week'
    title: 'Sales: Flash Report - Script Counts - Week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - sales.date_to_use
    - sales.report_date
    - sales.report_period_day_of_week
    - sales.count
    - sales.count_ly
    - sales.count_variance_number
    - sales.count_variance
    filters:
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
    sorts:
    - sales.report_date
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: false
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
    - sales.date_to_use
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    listen:
      Pharmacy Division: store_alignment.division
      Pharmacy Region: store_alignment.region
      Pharmacy District: store_alignment.district
      Pharmacy Number: store.store_number
      Date to Use: sales.date_to_use_filter
      Report Period: report_calendar_global.report_period_filter
      Report Period - Analysis Calendar: report_calendar_global.analysis_calendar_filter
      File Buy Flag (Yes/No): sales.file_buy_flag
      Financial Category: sales.financial_category
      Chain ID: chain.chain_id
    row: 6
    col: 6
    width: 18
    height: 5
  - name: 'Sales: Report Range Label'
    title: 'Sales: Report Range Label'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: single_value
    fields:
    - report_calendar_global.report_range
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 weeks ago for 1 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - report_calendar_global.report_range
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    fontSize: '50'
    font_size: medium
    font: verdana
    hidden_fields:
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    single_value_title: Report Range
    listen:
      Chain ID: chain.chain_id
    row: 5
    col: 0
    width: 6
    height: 5
  - name: 'Sales: Date Used Label'
    title: 'Sales: Date Used Label'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: single_value
    fields:
    - sales.date_to_use
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 weeks ago for 1 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.date_to_use
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    fontSize: '50'
    font_size: medium
    font: verdana
    hidden_fields:
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    single_value_title: Date Used
    listen:
      Chain ID: chain.chain_id
    row: 10
    col: 0
    width: 6
    height: 4
  - name: 'Sales: Flash Report - Script Count by Pharmacy District - Week'
    title: 'Sales: Flash Report - Script Count by Pharmacy District - Week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_bar
    fields:
    - sales.date_to_use
    - report_calendar_global.report_range
    - sales.count
    - sales.count_ly
    - store_alignment.district
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 weeks ago for 1 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
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
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - sales.date_to_use
    - report_calendar_global.report_range
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    label_color:
    - Black
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '[>=1000000] $#,##0.0,,"M";[>0] $#,##0.0,"K";General'
      series:
      - id: sales.count
        name: Scripts
      - id: sales.count_ly
        name: LY Scripts
    listen:
      Chain ID: chain.chain_id
    row: 18
    col: 12
    width: 12
    height: 15
  - name: End of Dashboard
    type: text
    title_text: End of Dashboard
    row: 33
    col: 0
    width: 24
    height: 2
  - name: 'Sales: Flash Report - Net Sales by Pharmacy Division - Week'
    title: 'Sales: Flash Report - Net Sales by Pharmacy Division - Week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_bar
    fields:
    - sales.date_to_use
    - report_calendar_global.report_range
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - store_alignment.district
    - store_alignment.division
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 weeks ago for 1 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.sum_net_sales desc
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
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
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - sales.date_to_use
    - report_calendar_global.report_range
    - store_alignment.district
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    label_color:
    - black
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '[>=1000000] $#,##0.0,,"M";[>0] $#,##0.0,"K";General'
      series:
      - id: sales.sum_net_sales
        name: Net Sales
      - id: sales.sum_net_sales_ly
        name: LY Net Sales
    label_value_format: '[>=1000000] $#,##0.0,,"M";[>0] $#,##0.0,"K";General'
    listen:
      Chain ID: chain.chain_id
    row: 18
    col: 0
    width: 12
    height: 15
  filters:
  - name: Pharmacy Division
    title: Pharmacy Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store_alignment.division
  - name: Pharmacy Region
    title: Pharmacy Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store_alignment.region
  - name: Pharmacy District
    title: Pharmacy District
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store_alignment.district
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
  - name: Date to Use
    title: Date to Use
    type: field_filter
    default_value: SOLD
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
  - name: File Buy Flag (Yes/No)
    title: File Buy Flag (Yes/No)
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: sales.file_buy_flag
  - name: Financial Category
    title: Financial Category
    type: field_filter
    default_value: "-%PARTIAL%"
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: sales.financial_category
  - name: Chain ID
    title: Chain ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: chain.chain_id

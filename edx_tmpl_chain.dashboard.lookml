- dashboard: edx_tmpl_chain
  title: Dashboard - Chain
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
    width: 24
    height: 2
  - name: "============================== SALES Review =============================="
    type: text
    title_text: "============================== SALES Review =============================="
    row: 11
    col: 0
    width: 24
    height: 2
  - name: "============================== Scripts Review =============================="
    type: text
    title_text: "============================== Scripts Review =============================="
    row: 30
    col: 0
    width: 24
    height: 2
  - name: "============================== Unfavorable Business Impacts =============================="
    type: text
    title_text: "============================== Unfavorable Business Impacts =============================="
    row: 40
    col: 0
    width: 24
    height: 2
  - name: "============================== Compliance =============================="
    type: text
    title_text: "============================== Compliance =============================="
    row: 60
    col: 0
    width: 24
    height: 2
  - name: Pharmacy System Type Counts
    title: Pharmacy System Type Counts
    model: PDX_CUSTOMER_DSS
    explore: store
    type: table
    fields:
    - store.store_category
    - store.count
    filters:
      store.deactivated_date: 'No'
      store.store_category: Live-EPS,Live-PDX,Pending,Unknown
    sorts:
    - store.count desc
    limit: 500
    total: true
    show_view_names: false
    limit_displayed_rows: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    value_labels: legend
    label_type: labPer
    point_style: circle
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    color_palette: Looker Classic
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
    font_size: '12'
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    listen:
      Chain ID: chain.chain_id
    row: 2
    col: 0
    width: 6
    height: 4
  - name: Pharmacy Location Map
    title: Pharmacy Location Map
    model: PDX_CUSTOMER_DSS
    explore: store
    type: looker_map
    fields:
    - store_state_location.store_location
    - store.store_category
    - store.count
    pivots:
    - store.store_category
    filters:
      store.deactivated_date: 'No'
      store.store_category: Live-EPS,Live-PDX,Pending,Unknown
      store_state_location.store_location: "-null"
    sorts:
    - store.count desc 0
    - store.store_category
    limit: 500
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: imperial
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: fixed
    map_marker_units: pixels
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    map_latitude: 34.397844946449865
    map_longitude: -91.82373046875
    map_zoom: 5
    map_marker_radius_fixed: 2
    map_marker_color:
    - blue
    - green
    - red
    - yellow
    listen:
      Chain ID: chain.chain_id
    row: 2
    col: 6
    width: 9
    height: 9
  - name: 'Sales: 3 Month Patient Age Distribution'
    title: 'Sales: 3 Month Patient Age Distribution'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - chain.master_chain_name
    - patient.patient_age_tier
    - patient.patient_count
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 90 days ago for 90 days
      report_calendar_global.analysis_calendar_filter: Fiscal - Day
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
      sales.rx_tx_tx_status: NORMAL
      patient.patient_age_tier: "-Undefined"
    sorts:
    - patient.patient_age_tier
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: patient
      label: Patient %
      expression: "${patient.patient_count}/${patient.patient_count:total}"
      value_format:
      value_format_name: percent_2
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - patient.patient_count
    - chain.master_chain_name
    colors:
    - 'palette: Santa Cruz'
    series_colors: {}
    listen:
      Chain ID: chain.chain_id
    row: 2
    col: 15
    width: 9
    height: 9
  - name: 'Sales: Controlled Drug Dispensing - Last 6 Months - Top 10 Stores'
    title: 'Sales: Controlled Drug Dispensing - Last 6 Months - Top 10 Stores'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - chain.master_chain_name
    - store.store_number
    - sales.count
    - drug.drug_schedule_category
    pivots:
    - drug.drug_schedule_category
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 6 months ago for 6 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      drug.drug_schedule_category: CONTROL,LEGEND
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - drug.drug_schedule_category 0
    - dispensing_percent desc 0
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: total_script_count
      label: Total Script Count
      expression: sum(pivot_row(${sales.count}))
      value_format:
      value_format_name: decimal_0
    - table_calculation: dispensing_percent
      label: Dispensing Percent
      expression: "${sales.count}/sum(pivot_row(${sales.count}))"
      value_format:
      value_format_name: percent_2
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_fields:
    - chain.master_chain_name
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
    row: 62
    col: 12
    width: 12
    height: 8
  - name: 'Sales: Script Dispensing - by Drug Category'
    title: 'Sales: Script Dispensing - by Drug Category'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_donut_multiples
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_year
    - sales.count
    - drug.drug_schedule_category
    pivots:
    - drug.drug_schedule_category
    fill_fields:
    - drug.drug_schedule_category
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 24 months ago for 24 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - drug.drug_schedule_category 0
    - sales.report_period_year
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: dispensing_percent
      label: Dispensing Percent
      expression: "${sales.count}/sum(pivot_row(${sales.count}))"
      value_format:
      value_format_name: percent_2
    - table_calculation: total_script_count
      label: Total Script Count
      expression: sum(pivot_row(${sales.count}))
      value_format:
      value_format_name: decimal_0
    show_value_labels: true
    font_size: 12
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_fields:
    - chain.master_chain_name
    - dispensing_percent
    - total_script_count
    - sales.date_to_use
    series_types: {}
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
    row: 62
    col: 0
    width: 12
    height: 8
  - name: 'Sales: TY vs LY Rx Sales - by Sold Month'
    title: 'Sales: TY vs LY Rx Sales - by Sold Month'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
    font_size: 9px
    label_rotation: -60
    label_value_format: '[>=1000000] $#,##0.0,,"M";[>0] $#,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: Net Sales
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat: '[>=1000000] $#,##0.0,,"M";[>0] $#,##0.0,"K";General'
      series:
      - id: sales.sum_net_sales
        name: TY Net Sales
      - id: sales.sum_net_sales_ly
        name: LY Net Sales
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 13
    col: 0
    width: 13
    height: 9
  - name: 'Sales: Margin Percent Review'
    title: 'Sales: Margin Percent Review'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - sales.sum_net_gross_margin_pct
    - sales.sum_net_gross_margin_pct_ly
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    - sales.count
    - sales.count_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: margin_per_script
      label: Margin per Script
      expression: "${sales.sum_net_gross_margin}/${sales.count}"
      value_format:
      value_format_name: usd
    - table_calculation: ly_margin_per_script
      label: LY Margin per Script
      expression: "${sales.sum_net_gross_margin_ly}/${sales.count_ly}"
      value_format:
      value_format_name: usd
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    - sales.count
    - sales.count_ly
    - margin_per_script
    - ly_margin_per_script
    series_types:
      margin_per_script: line
      ly_margin_per_script: line
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
    font_size: 9px
    label_rotation: 0
    label_value_format: ''
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: sales.sum_net_gross_margin_pct
        name: Net Margin %
      - id: sales.sum_net_gross_margin_pct_ly
        name: LY Net Margin %
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat: ''
      series:
      - id: margin_per_script
        name: Margin per Script
      - id: ly_margin_per_script
        name: LY Margin per Script
    series_colors:
      margin_per_script: "#4e2bd9"
      ly_margin_per_script: "#09ab49"
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 22
    col: 0
    width: 13
    height: 8
  - name: 'Sales: Margin Dollars Per Script Review'
    title: 'Sales: Margin Dollars Per Script Review'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - sales.sum_net_gross_margin_pct
    - sales.sum_net_gross_margin_pct_ly
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    - sales.count
    - sales.count_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: margin_per_script
      label: Margin per Script
      expression: "${sales.sum_net_gross_margin}/${sales.count}"
      value_format:
      value_format_name: usd
    - table_calculation: ly_margin_per_script
      label: LY Margin per Script
      expression: "${sales.sum_net_gross_margin_ly}/${sales.count_ly}"
      value_format:
      value_format_name: usd
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.sum_net_sales
    - sales.sum_net_sales_ly
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    - sales.count
    - sales.count_ly
    - sales.sum_net_gross_margin_pct
    - sales.sum_net_gross_margin_pct_ly
    series_types:
      margin_per_script: line
      ly_margin_per_script: line
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      margin_per_script: TY Margin Per Script
    font_size: 9px
    label_rotation: 0
    label_value_format: ''
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: true
      valueFormat: ''
      series:
      - id: margin_per_script
        name: Margin per Script
      - id: ly_margin_per_script
        name: LY Margin per Script
    series_colors:
      margin_per_script: "#4e2bd9"
      ly_margin_per_script: "#09ab49"
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 22
    col: 13
    width: 11
    height: 8
  - name: 'Sales: TY vs LY Rx Scripts - by Sold Month'
    title: 'Sales: TY vs LY Rx Scripts - by Sold Month'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.count
    - sales.count_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_null_points: false
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
    font_size: 9px
    label_rotation: -60
    label_value_format: '[>=1000000] #,##0.0,,"M";[>0] #,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 77
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: sales.count
        name: TY Scripts
      - id: sales.count_ly
        name: LY Scripts
    series_colors:
      sales.count: "#2554cc"
      sales.count_ly: "#75ad0c"
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 32
    col: 0
    width: 14
    height: 8
  - name: 'Sales: Rx Scripts Breakdown'
    title: 'Sales: Rx Scripts Breakdown'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_donut_multiples
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.count
    - sales.report_period_year
    - sales.rx_tx_tp_bill
    - drug.drug_brand_generic
    pivots:
    - sales.rx_tx_tp_bill
    - drug.drug_brand_generic
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 2 years
      report_calendar_global.analysis_calendar_filter: Fiscal - Year
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc 0
    - sales.rx_tx_tp_bill
    - drug.drug_brand_generic
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 9px
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
      CHARGED TO TP - Brand|FIELD|0 - sales.count: T/P - Brand
      CHARGED TO TP - Generic|FIELD|1 - sales.count: T/P - Generic
      NO CHARGE TO TP - Brand|FIELD|0 - sales.count: Cash - Brand
      NO CHARGE TO TP - Generic|FIELD|1 - sales.count: Cash - Generic
    label_rotation: -60
    label_value_format: '[>=1000000] #,##0.0,,"M";[>0] #,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 77
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: sales.count
        name: TY Scripts
      - id: sales.count_ly
        name: LY Scripts
    series_colors:
      CHARGED TO TP - Brand|FIELD|0 - sales.count: gold
      CHARGED TO TP - Generic|FIELD|1 - sales.count: deepskyblue
      NO CHARGE TO TP - Brand|FIELD|0 - sales.count: yellow
      NO CHARGE TO TP - Generic|FIELD|1 - sales.count: lightblue
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    - gold
    - yellow
    - lightblue
    - deepskyblue
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
    row: 32
    col: 14
    width: 10
    height: 8
  - name: 'Sales: Top 10 Disease States by Margin Dollars'
    title: 'Sales: Top 10 Disease States by Margin Dollars'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_pie
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - gpi_disease_duration_cross_ref.gpi_disease_code_description
    - sales.count
    - sales.sum_net_sales
    - sales.sum_net_gross_margin
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.sum_net_gross_margin desc
    limit: 10
    column_limit: 50
    value_labels: labels
    label_type: labPer
    show_value_labels: true
    font_size: 9px
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.count
    - sales.sum_net_sales
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
      CHARGED TO TP - Brand|FIELD|0 - sales.count: T/P - Brand
      CHARGED TO TP - Generic|FIELD|1 - sales.count: T/P - Generic
      NO CHARGE TO TP - Brand|FIELD|0 - sales.count: Cash - Brand
      NO CHARGE TO TP - Generic|FIELD|1 - sales.count: Cash - Generic
    label_rotation: -60
    label_value_format: '[>=1000000] #,##0.0,,"M";[>0] #,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 77
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: sales.count
        name: TY Scripts
      - id: sales.count_ly
        name: LY Scripts
    series_colors: {}
    colors: 'palette: Mixed Dark'
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 13
    col: 13
    width: 11
    height: 9
  - name: 'Sales: Below Cost Report (Net Margin) by Chain'
    title: 'Sales: Below Cost Report (Net Margin) by Chain'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.sum_net_gross_margin
    - sales.sum_net_gross_margin_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      sales.net_gross_margin_filter: "<0"
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
    font_size: 9px
    label_rotation: -60
    label_value_format: '[<=1000000] $#,##0.0,,"M";[<0] $#,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat: '[<=1000000] $#,##0.0,,"M";[<0] $#,##0.0,"K";General'
      series:
      - id: sales.sum_net_gross_margin
        name: Net Margin $
      - id: sales.sum_net_gross_margin_ly
        name: LY Net Margin $
    series_colors:
      sales.count: "#2554cc"
      sales.count_ly: "#75ad0c"
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 42
    col: 0
    width: 11
    height: 10
  - name: 'Sales: Below Cost Report (Net Margin) by Division'
    title: 'Sales: Below Cost Report (Net Margin) by Division'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - sales.report_period_month
    - sales.sum_net_gross_margin
    - store_alignment.division
    pivots:
    - store_alignment.division
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      sales.net_gross_margin_filter: "<0"
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    - store_alignment.division
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - chain.master_chain_name
    - sales.date_to_use
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
    font_size: 9px
    label_rotation: -60
    label_value_format: '[<=1000000] $#,##0.0,,"M";[<0] $#,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 15
    x_padding_right: 15
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat: '[<=1000000] $#,##0.0,,"M";[<0] $#,##0.0,"K";General'
      series:
      - id: sales.sum_net_gross_margin
        name: Net Margin $
      - id: sales.sum_net_gross_margin_ly
        name: LY Net Margin $
    series_colors:
      sales.count: "#2554cc"
      sales.count_ly: "#75ad0c"
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
      Report Period: report_calendar_global.report_period_filter
      Report Calendar: report_calendar_global.analysis_calendar_filter
    row: 42
    col: 11
    width: 13
    height: 10
  - name: 'Sales: Claims with Negative TP Balance Due (Most Likely Copay Card)'
    title: 'Sales: Claims with Negative TP Balance Due (Most Likely Copay Card)'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - store.store_number
    - eps_tx_tp_transmit_queue.tx_tp_transmit_queue_plan_transmit_bin_number
    - eps_tx_tp_transmit_queue.tx_tp_transmit_queue_plan_pcn_number
    - sales.rx_tx_dispensed_drug_ndc
    - store_drug.drug_name
    - sales.rx_tx_tx_number
    - sales.report_date
    - sales.rx_tx_days_supply
    - sales.rx_tx_fill_quantity
    - sales.sum_net_due
    - sales.sum_final_copay
    - sales.sum_net_gross_margin
    - sales.sum_acquisition_cost_ty
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 1 months ago for 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      eps_tx_tp_transmit_queue.tx_tp_transmit_queue_paid_status: PAID IN FULL,PARTLY
        PAID,LOW PAY,DUPLICATE OF PAID CLAIM
      sales.sum_net_due: "<0"
      sales.rx_tx_tx_status: NORMAL
    sorts:
    - sales.sum_net_due
    limit: 50
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
    listen:
      Chain ID: chain.chain_id
      Scripts Converted Flag: sales.scripts_converted
    row: 52
    col: 0
    width: 24
    height: 8
  - name: "=============================== END of Dashboard ==============================="
    type: text
    title_text: "=============================== END of Dashboard ==============================="
    row: 70
    col: 0
    width: 24
    height: 2
  - name: Workflow - Time to Will Call
    title: Workflow - Time to Will Call
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: gauge
    fields:
    - eps_rx_tx.will_call_arrival_date
    - eps_rx_tx.median_fill_duration
    fill_fields:
    - eps_rx_tx.will_call_arrival_date
    filters:
      eps_rx_tx.rx_tx_fill_location: ACS System,Local Pharmacy
      eps_rx_tx.rx_tx_tx_status: NORMAL
      eps_rx_tx.will_call_arrival_date: 1 days ago for 1 days
    sorts:
    - eps_rx_tx.will_call_arrival_date
    limit: 500
    column_limit: 50
    row_total: right
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
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
    series_types: {}
    hidden_fields: []
    maximum: 60
    colorTransitions:
    - '50'
    - '80'
    colorRange:
    - green
    - yellow
    - red
    majorTicks: 6
    minimum:
    listen:
      Chain ID: chain.chain_id
      Order Entry Pickup Tye: eps_order_entry.order_entry_pickup_type_id
    row: 6
    col: 0
    width: 6
    height: 5
  filters:
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
  - name: Order Entry Pickup Tye
    title: Order Entry Pickup Tye
    type: field_filter
    default_value: WAITING,URGENT
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    listens_to_filters: []
    field: eps_order_entry.order_entry_pickup_type_id
  - name: Scripts Converted Flag
    title: Scripts Converted Flag
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: sales.scripts_converted
  - name: Report Period
    title: Report Period
    type: field_filter
    default_value: 12 months
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: report_calendar_global.report_period_filter
  - name: Report Calendar
    title: Report Calendar
    type: field_filter
    default_value: Fiscal - Month
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: report_calendar_global.analysis_calendar_filter

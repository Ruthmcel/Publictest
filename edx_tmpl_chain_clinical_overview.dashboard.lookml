- dashboard: edx_tmpl_chain_clinical_overview
  title: Dashboard - Clinical Overview
  layout: newspaper
  elements:
  - name: 'Sales: Disease States (Inferred) - Top 10 last 12 months'
    title: 'Sales: Disease States (Inferred) - Top 10 last 12 months'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_pie
    fields:
    - sales.count
    - gpi_disease_duration_cross_ref.gpi_disease_code_description
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 12 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      gpi_disease_duration_cross_ref.gpi_disease_code_description: "-NULL"
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 10
    column_limit: 50
    query_timezone: America/Chicago
    value_labels: labels
    label_type: labPer
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
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors: 'palette: Santa Cruz'
    series_colors: {}
    row: 0
    col: 0
    width: 11
    height: 8
  - name: 'Sales: Flu Shots - TY/LY Script Count'
    title: 'Sales: Flu Shots - TY/LY Script Count'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - sales.count
    - sales.count_ly
    - sales.report_period_month
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_drug.drug_flu_immunization_indicator: 'Yes'
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 50
    column_limit: 50
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: false
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
    value_labels: labels
    label_type: labPer
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Report Period: report_calendar_global.report_period_filter
      Report Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 8
    col: 0
    width: 12
    height: 8
  - name: 'Sales: Immunizations (Non-FLu) - TY/LY Script Count'
    title: 'Sales: Immunizations (Non-FLu) - TY/LY Script Count'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_column
    fields:
    - sales.count
    - sales.count_ly
    - sales.report_period_month
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_drug.drug_flu_immunization_indicator: 'No'
      store_drug.drug_immunization_indicator: 'Yes'
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 50
    column_limit: 50
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: false
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
    value_labels: labels
    label_type: labPer
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    listen:
      Report Period: report_calendar_global.report_period_filter
      Report Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 8
    col: 12
    width: 12
    height: 8
  - name: 'Sales: Immunization Margin per Script'
    title: 'Sales: Immunization Margin per Script'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - sales.report_period_month
    - sales.count
    - sales.sum_net_gross_margin
    - sales.count_ly
    - sales.sum_net_gross_margin_ly
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
      store_drug.drug_immunization_indicator: 'Yes'
    sorts:
    - sales.report_period_month
    limit: 50
    column_limit: 50
    dynamic_fields:
    - table_calculation: ty_net_margin_per_script
      label: TY Net Margin per Script
      expression: "${sales.sum_net_gross_margin}/${sales.count}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
    - table_calculation: ly_net_margin_per_script
      label: LY Net Margin per Script
      expression: "${sales.sum_net_gross_margin_ly}/${sales.count_ly}"
      value_format:
      value_format_name: usd
      _kind_hint: measure
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
    show_null_points: true
    point_style: circle_outline
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labPer
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
    - sales.count
    - sales.sum_net_gross_margin
    - sales.count_ly
    - sales.sum_net_gross_margin_ly
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: ty_net_margin_per_script
        name: TY Net Margin per Script
      - id: ly_net_margin_per_script
        name: LY Net Margin per Script
    listen:
      Report Period: report_calendar_global.report_period_filter
      Report Analysis Calendar: report_calendar_global.analysis_calendar_filter
    row: 0
    col: 11
    width: 13
    height: 8
  - name: "=================================== END of DASHBOARD ==================================="
    type: text
    title_text: "=================================== END of DASHBOARD ==================================="
    row: 23
    col: 0
    width: 24
    height: 2
  - name: 'Sales: FLU Medications Map - 9 months ago'
    title: 'Sales: FLU Medications Map - 9 months ago'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_geo_coordinates
    fields:
    - sales.count
    - store_state_location.store_location
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 9 months ago for 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_drug.drug_name: TAMIFLU%,RELENZA%,RAPIVAB%,OSELTAMIVIR%
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 5000
    column_limit: 50
    query_timezone: America/Chicago
    map: usa
    map_projection: ''
    show_view_names: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    value_labels: labels
    label_type: labPer
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    point_color: red
    map_color: ''
    outer_border_color: black
    inner_border_color: black
    point_radius: 2
    row: 16
    col: 0
    width: 8
    height: 7
  - name: 'Sales: FLU Medications Map - 1 complete month ago'
    title: 'Sales: FLU Medications Map - 1 complete month ago'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_geo_coordinates
    fields:
    - sales.count
    - store_state_location.store_location
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 months ago for 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_drug.drug_name: TAMIFLU%,RELENZA%,RAPIVAB%,OSELTAMIVIR%
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 5000
    column_limit: 50
    query_timezone: America/Chicago
    map: usa
    map_projection: ''
    show_view_names: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    value_labels: labels
    label_type: labPer
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    point_color: red
    map_color: ''
    outer_border_color: black
    inner_border_color: black
    point_radius: 2
    row: 16
    col: 16
    width: 8
    height: 7
  - name: 'Sales: FLU Medications Map - 3 months ago'
    title: 'Sales: FLU Medications Map - 3 months ago'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_geo_coordinates
    fields:
    - sales.count
    - store_state_location.store_location
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 3 months ago for 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_drug.drug_name: TAMIFLU%,RELENZA%,RAPIVAB%,OSELTAMIVIR%
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 5000
    column_limit: 50
    query_timezone: America/Chicago
    map: usa
    map_projection: ''
    show_view_names: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    value_labels: labels
    label_type: labPer
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    series_labels:
      sales.sum_net_sales_after_sold_variance: TY/LY Sales Variance %
      sales.sum_net_gross_margin_variance: TY/LY Net Margin Variance %
      sales.sum_net_gross_margin_after_sold: Net Margin $
      sales.sum_net_gross_margin_after_sold_ly: LY Net Margin $
      sales.sum_net_gross_margin_after_sold_variance: TY/LY Net Margin Variance %
    series_types: {}
    colors:
    - 'palette: Looker Classic'
    series_colors: {}
    point_color: red
    map_color: ''
    outer_border_color: black
    inner_border_color: black
    point_radius: 2
    row: 16
    col: 8
    width: 8
    height: 7
  filters:
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
  - name: Report Analysis Calendar
    title: Report Analysis Calendar
    type: field_filter
    default_value: Fiscal - Month
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: sales
    listens_to_filters: []
    field: report_calendar_global.analysis_calendar_filter

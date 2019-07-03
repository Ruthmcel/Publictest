- dashboard: edx_tmpl_chain_pharmacy_customer_experience_overview
  title: Dashboard - Pharmacy Customer Experience Overview
  layout: newspaper
  elements:
  - name: Pharmacy Counts - EPS Only - by State
    title: Pharmacy Counts - EPS Only - by State
    model: PDX_CUSTOMER_DSS
    explore: store
    type: table
    fields:
    - store_state_location.state_abbreviation
    - store.store_category
    - store.count
    filters:
      store.store_category: Live-EPS
      store.deactivated_date: 'No'
    sorts:
    - store_state_location.state_abbreviation
    limit: 500
    column_limit: 50
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
    hide_totals: false
    hide_row_totals: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Chain ID: chain.chain_id
    row: 0
    col: 0
    width: 6
    height: 6
  - name: 'Workflow: % Filled ON Time  (Last 4 Weeks)'
    title: 'Workflow: % Filled ON Time  (Last 4 Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: single_value
    fields:
    - chain.chain_name
    - eps_rx_tx.is_on_time
    - eps_rx_tx.count
    filters:
      eps_order_entry.order_entry_pickup_type_id: "-NOT SPECIFIED"
      store.store_number: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.will_call_arrival_date: 4 weeks ago for 4 weeks
    sorts:
    - eps_rx_tx.is_on_time
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: on_time
      label: On Time %
      expression: "(${eps_rx_tx.count})/sum(${eps_rx_tx.count})"
      value_format:
      value_format_name: percent_2
    query_timezone: America/Chicago
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    map_plot_mode: points
    heatmap_gridlines: false
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
    hidden_fields:
    - eps_rx_tx.count
    - total
    series_types: {}
    listen:
      Chain ID: chain.chain_id
    row: 0
    col: 6
    width: 8
    height: 2
  - name: 'Workflow: Waiters - % ON Time Goal Achieved (Last 4 Weeks)'
    title: 'Workflow: Waiters - % ON Time Goal Achieved (Last 4 Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: single_value
    fields:
    - chain.chain_name
    - eps_rx_tx.is_on_time_fifteen
    - eps_rx_tx.active_count
    filters:
      eps_order_entry.order_entry_pickup_type_id: WAITING,URGENT
      store.store_number: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.will_call_arrival_date: 4 weeks ago for 4 weeks
    sorts:
    - eps_rx_tx.is_on_time_fifteen
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: waiters_delivered_on_time
      label: "% Waiters Delivered On Time"
      expression: "${eps_rx_tx.active_count}/sum(${eps_rx_tx.active_count})"
      value_format:
      value_format_name: percent_2
    query_timezone: America/Chicago
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_value_labels: true
    font_size: 12
    show_view_names: true
    value_labels: legend
    label_type: labPer
    series_types: {}
    series_colors: {}
    colors:
    - "#FFCD00"
    - "#84BD00"
    - "#005EB8"
    hidden_fields:
    - eps_rx_tx.active_count
    listen:
      Chain ID: chain.chain_id
    row: 2
    col: 6
    width: 8
    height: 2
  - name: 'Sales: RX Source Review (Last 4 Weeks)'
    title: 'Sales: RX Source Review (Last 4 Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_bar
    fields:
    - sales.rx_source
    - sales.count
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 4 weeks ago for 4 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store.store_number: ''
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
      sales.rx_source: "-Blank"
    sorts:
    - total desc
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: total
      label: "% Total"
      expression: "${sales.count}/${sales.count:total}"
      value_format:
      value_format_name: percent_2
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: true
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
    enable_conditional_formatting: true
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    map_plot_mode: points
    heatmap_gridlines: false
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
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: circle
    series_types: {}
    y_axis_reversed: false
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: sales.count
        name: Scripts
    - label:
      maxValue:
      minValue:
      orientation: bottom
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: total
        name: "% Total"
    hidden_fields: []
    conditional_formatting:
    - type: less than
      value: '0'
      background_color:
      font_color: "#ff0000"
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '5'
    hidden_series:
    - sales.count
    listen:
      Chain ID: chain.chain_id
    row: 14
    col: 0
    width: 11
    height: 6
  - name: 'Workflow: Return to Stock (Last 4 Weeks)'
    title: 'Workflow: Return to Stock (Last 4 Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_line
    fields:
    - eps_rx_tx.return_to_stock_count
    - eps_rx_tx.active_count
    - eps_rx_tx.return_to_stock_sales
    - eps_rx_tx.sum_price
    - chain.chain_name
    - store.count
    - eps_rx_tx.count
    - eps_rx_tx.rx_tx_reportable_sales_week
    filters:
      store.store_number: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.rx_tx_reportable_sales_date: 4 weeks ago for 4 weeks
    sorts:
    - eps_rx_tx.rx_tx_reportable_sales_week desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: return_to_stock_of_active_fills
      label: Return to Stock % of Active Fills
      expression: "${eps_rx_tx.return_to_stock_count}/${eps_rx_tx.active_count}"
      value_format:
      value_format_name: percent_2
      selected: true
    - table_calculation: return_to_stock_of_sales
      label: Return to Stock % of Sales
      expression: "${eps_rx_tx.return_to_stock_sales}/${eps_rx_tx.sum_price}"
      value_format:
      value_format_name: percent_2
      selected: true
    query_timezone: America/Chicago
    stacking: normal
    show_value_labels: true
    label_density: 24
    legend_position: center
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 6
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: false
    point_style: circle_outline
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    showComparison: false
    maxValue: 100
    minValue: 0
    circleThickness: 0.05
    circleGap: 0.05
    circleColor: "#8B7DA8"
    waveHeight: 0.05
    waveCount: 1
    waveRiseTime: 1000
    waveAnimateTime: 1800
    waveRise: true
    waveHeightScaling: true
    waveAnimate: true
    waveColor: "#64518A"
    waveOffset: 0
    textVertPosition: 0.5
    textSize: 1
    valueCountUp: true
    displayPercent: true
    textColor: "#000000"
    waveTextColor: "#FFFFFF"
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    font_size: '12'
    ordering: none
    show_null_labels: false
    hidden_fields:
    - chain.chain_name
    - store.count
    - eps_rx_tx.return_to_stock_count
    - eps_rx_tx.active_count
    - eps_rx_tx.return_to_stock_sales
    - eps_rx_tx.sum_price
    - bi_demo_store.count
    - bi_demo_chain.chain_name
    - eps_rx_tx.count
    y_axis_labels:
    - Percent Scripts
    - Percent Sales
    colors:
    - 'palette: Looker Classic'
    y_axis_orientation:
    - left
    - right
    y_axis_value_format: 0.00%
    y_axis_min: []
    y_axis_max: []
    x_padding_left: 40
    x_padding_right: 40
    y_axis_unpin: true
    trend_lines: []
    reference_lines: []
    focus_on_hover: true
    y_axes:
    - label: "% Scripts"
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: false
      tickDensity: default
      tickDensityCustom: 6
      type: linear
      unpinAxis: true
      valueFormat: 0.00%
      series:
      - id: return_to_stock_of_active_fills
        name: Return to Stock % of Active Fills
      - id: return_to_stock_of_sales
        name: Return to Stock % of Sales
    x_axis_label: Fiscal Period Begin Week Date
    series_types: {}
    x_axis_datetime_label: "%b - %d"
    listen:
      Chain ID: chain.chain_id
    row: 20
    col: 0
    width: 11
    height: 9
  - name: 'Sales: Patient Counts and Scripts (Last 13 months)'
    title: 'Sales: Patient Counts and Scripts (Last 13 months)'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - sales.report_period_month
    - patient.patient_count
    - sales.count
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 13 months ago for 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store.store_number: ''
      sales.file_buy_flag: 'No'
    sorts:
    - sales.report_period_month
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: avg_scripts_per_patient
      label: Avg Scripts per Patient
      expression: "${sales.count}/${patient.patient_count}"
      value_format:
      value_format_name: decimal_2
    stacking: ''
    show_value_labels: true
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
    show_null_points: true
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
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
    series_types: {}
    hide_legend: false
    series_labels:
      Yes - sales.count: File Buy Patients
      No - sales.count: Pharmacy Patients
      No - patient.patient_count: fred's Patient Count
      Yes - patient.patient_count: File Buy Patient Count
      sales.count: Scripts
      patient.patient_count: Patient Count
    reference_lines: []
    trend_lines: []
    x_axis_label: Fiscal Period Month/Yr
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
      - id: patient.patient_count
        name: Patient Patient Count
      - id: sales.count
        name: Prescription Transaction Scripts
      - id: avg_scripts_per_patient
        name: Avg Scripts per Patient
    hidden_fields:
    series_colors:
      avg_scripts_per_patient: "#323ae6"
    listen:
      Chain ID: chain.chain_id
    row: 6
    col: 0
    width: 24
    height: 8
  - name: 'Workflow: Waiters - Median Script Time (minutes) to Will Call (Last 5 Weeks)'
    title: 'Workflow: Waiters - Median Script Time (minutes) to Will Call (Last 5
      Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: single_value
    fields:
    - chain.chain_name
    - eps_rx_tx.median_fill_duration
    filters:
      eps_order_entry.order_entry_pickup_type_id: URGENT,WAITING
      store.store_number: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.will_call_arrival_date: 5 weeks ago for 5 weeks
    sorts:
    - eps_rx_tx.median_fill_duration desc
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
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: darkmatter
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    value_labels: legend
    label_type: labPer
    stacking: normal
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
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields: []
    map_latitude: 34.08451582325239
    map_longitude: -86.87511599999999
    map_zoom: 5
    map_value_scale_clamp_min: 0
    listen:
      Chain ID: chain.chain_id
    row: 4
    col: 6
    width: 8
    height: 2
  - name: 'Sales: Patient Age & Avg Scripts Distribution (Last 5 Weeks)'
    title: 'Sales: Patient Age & Avg Scripts Distribution (Last 5 Weeks)'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_scatter
    fields:
    - chain.master_chain_name
    - patient.patient_age_tier
    - patient.patient_count
    - sales.count
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 5 weeks ago for 5 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
      sales.rx_tx_tx_status: NORMAL
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
    - table_calculation: avg_scripts_per_patient
      label: Avg Scripts per Patient
      expression: "${sales.count}/${patient.patient_count}"
      value_format:
      value_format_name: decimal_2
    stacking: ''
    show_value_labels: true
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
    show_null_points: true
    point_style: circle
    font_size: '12'
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
    - sales.count
    colors:
    - 'palette: Santa Cruz'
    series_colors: {}
    listen:
      Chain ID: chain.chain_id
    row: 0
    col: 14
    width: 10
    height: 6
  - name: 'Sales: Prescriber Top 10 by Script Count'
    title: 'Sales: Prescriber Top 10 by Script Count'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - prescriber.last_name
    - prescriber.npi_number
    - us_zip_code.state_abbreviation
    - sales.count
    - sales.count_ly
    - sales.count_variance_number
    - sales.count_variance
    - sales.sum_net_sales
    filters:
      sales.date_to_use_filter: REPORTABLE SALES
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 13 weeks ago for 13 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store.store_number: ''
      prescriber.name: "-NULL"
      sales.financial_category: "-%PARTIAL%"
      sales.file_buy_flag: 'No'
    sorts:
    - sales.count desc
    limit: 10
    column_limit: 50
    total: true
    row_total: left
    dynamic_fields:
    - table_calculation: of_total
      label: "% of Total"
      expression: "${sales.count}/${sales.count:total}"
      value_format:
      value_format_name: percent_2
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '5'
    series_labels:
      adj_script_variance: Adjusted New Rx Variance
    conditional_formatting:
    - type: less than
      value: '0'
      background_color:
      font_color: "#ff0000"
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
    listen:
      Chain ID: chain.chain_id
    row: 14
    col: 11
    width: 13
    height: 6
  - name: "================================ End of Dashboard ================================"
    type: text
    title_text: "================================ End of Dashboard ================================"
    row: 29
    col: 0
    width: 24
    height: 2
  - name: 'Sales: Partial Fills (Out of Stock) Trend'
    title: 'Sales: Partial Fills (Out of Stock) Trend'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: looker_line
    fields:
    - chain.master_chain_name
    - sales.date_to_use
    - store_alignment.division
    - sales.report_period_month
    - sales.count
    - sales.count_non_parital
    - sales.count_ly
    - sales.count_non_parital_ly
    pivots:
    - store_alignment.division
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 years
      report_calendar_global.analysis_calendar_filter: Fiscal - Year
      report_calendar_global.this_year_last_year_filter: 'Yes'
      sales.show_after_sold_measure_values: 'NO'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.financial_category: ''
      sales.file_buy_flag: 'No'
    sorts:
    - store_alignment.division
    - sales.report_period_month
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: ty_partial_scripts
      label: TY Partial Scripts
      expression: "${sales.count}-${sales.count_non_parital}"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
    - table_calculation: ly_partial_scripts
      label: LY Partial Scripts
      expression: "${sales.count_ly}-${sales.count_non_parital_ly}"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
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
    - sales.count
    - sales.count_non_parital
    - sales.count_ly
    - sales.count_non_parital_ly
    series_types: {}
    series_labels:
      sales.sum_net_sales: TY Net Sales
      sales.sum_net_sales_ly: LY Net Sales
      sales.count: TY Scripts
    font_size: 9px
    label_rotation: -60
    label_value_format: '[>=1000000] #,##0.0,,"M";[>0] #,##0.0,"K";General'
    x_axis_label: Sold Month
    x_padding_left: 1
    x_padding_right: 1
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
      - id: COD - TY Partial Scripts
        name: COD - TY Partial Scripts
      - id: COL - TY Partial Scripts
        name: COL - TY Partial Scripts
      - id: POD - TY Partial Scripts
        name: POD - TY Partial Scripts
      - id: SPE - TY Partial Scripts
        name: SPE - TY Partial Scripts
      - id: COD - LY Partial Scripts
        name: COD - LY Partial Scripts
      - id: COL - LY Partial Scripts
        name: COL - LY Partial Scripts
      - id: POD - LY Partial Scripts
        name: POD - LY Partial Scripts
      - id: SPE - LY Partial Scripts
        name: SPE - LY Partial Scripts
    series_colors: {}
    colors:
    - 'palette: Santa Cruz'
    listen:
      Chain ID: chain.chain_id
    row: 20
    col: 11
    width: 13
    height: 9
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

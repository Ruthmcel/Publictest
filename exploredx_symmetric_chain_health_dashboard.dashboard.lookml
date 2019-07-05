- dashboard: exploredx_symmetric_chain_health_dashboard
  title: Symmetric Chain Health Dashboard
  layout: newspaper
  refresh: 15 minutes
  elements:
  - name: Symmetric Offline vs Non Offline Store Statistics in the Past 1 Day
    title: Symmetric Offline vs Non Offline Store Statistics in the Past 1 Day
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: table
    fields:
    - symmetric_node_status_snapshot.chain_name
    - symmetric_node_status_snapshot.avg_stores
    - symmetric_node_status_snapshot.snapshot_hour
    - symmetric_node_status_snapshot.offline_category
    pivots:
    - symmetric_node_status_snapshot.snapshot_hour
    - symmetric_node_status_snapshot.offline_category
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'No'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.avg_stores desc 0
    - symmetric_node_status_snapshot.snapshot_hour
    - symmetric_node_status_snapshot.offline_category
    limit: 5000
    total: true
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: true
    label_density: 23
    font_size: '9'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    hidden_series:
    - DATA LAG - symmetric_node_status_snapshot.count_stores
    - HEALTHY - symmetric_node_status_snapshot.count_stores
    y_axes:
    - label:
      orientation: left
      series:
      - id: symmetric_node_status_snapshot.sum_batches_to_send_cnt
        name: Batches to Send - Total
        axisId: symmetric_node_status_snapshot.sum_batches_to_send_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    - label:
      orientation: right
      series:
      - id: symmetric_node_status_snapshot.sum_batches_in_error_cnt
        name: Batches in Error - Total
        axisId: symmetric_node_status_snapshot.sum_batches_in_error_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    swap_axes: false
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    refresh: 15 minutes
    row: 21
    col: 0
    width: 24
    height: 14
  - name: Symmetric Latest Batch Statistics
    title: Symmetric Latest Batch Statistics
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: looker_column
    fields:
    - symmetric_node_status_snapshot.chain_name
    - symmetric_node_status_snapshot.sum_batches_in_error_cnt
    - symmetric_node_status_snapshot.sum_batches_to_send_cnt
    - symmetric_node_status_snapshot.count_stores
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'Yes'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.sum_batches_in_error_cnt desc
    limit: 5000
    total: true
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: 23
    font_size: '9'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types:
      symmetric_node_status_snapshot.sum_batches_in_error_cnt: line
    limit_displayed_rows: false
    hidden_series:
    - DATA LAG - symmetric_node_status_snapshot.count_stores
    - HEALTHY - symmetric_node_status_snapshot.count_stores
    y_axes:
    - label:
      orientation: top
      series:
      - id: symmetric_node_status_snapshot.sum_batches_in_error_cnt
        name: Batches in Error - Total
        axisId: symmetric_node_status_snapshot.sum_batches_in_error_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: log
    - label:
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.sum_batches_to_send_cnt
        name: Batches to Send - Total
        axisId: symmetric_node_status_snapshot.sum_batches_to_send_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    - label: ''
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.count_stores
        name: Stores - Total
        axisId: symmetric_node_status_snapshot.count_stores
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen: {}
    refresh: 15 minutes
    row: 6
    col: 0
    width: 24
    height: 8
  - name: Symmetric Latest Health Statistics
    title: Symmetric Latest Health Statistics
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: looker_pie
    fields:
    - symmetric_node_status_snapshot.count_stores
    - symmetric_node_status_snapshot.status
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'Yes'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.status
    limit: 5000
    total: true
    query_timezone: America/Chicago
    value_labels: labels
    label_type: labPer
    colors:
    - "#84bd00"
    - "#005eb8"
    - "#ffcd00"
    - "#67cdf2"
    - "#00395d"
    - "#001c33"
    - "#cde29e"
    - "#405812"
    - "#ffed45"
    - "#af8912"
    series_colors: {}
    show_value_labels: true
    font_size: 0
    hide_legend: false
    stacking: ''
    label_density: 23
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - DATA LAG - symmetric_node_status_snapshot.count_stores
    - HEALTHY - symmetric_node_status_snapshot.count_stores
    - symmetric_node_status_snapshot.count_stores
    y_axes:
    - label:
      orientation: top
      series:
      - id: symmetric_node_status_snapshot.sum_batches_in_error_cnt
        name: Batches in Error - Total
        axisId: symmetric_node_status_snapshot.sum_batches_in_error_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: log
    - label:
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.sum_batches_to_send_cnt
        name: Batches to Send - Total
        axisId: symmetric_node_status_snapshot.sum_batches_to_send_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    - label: ''
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.count_stores
        name: Stores - Total
        axisId: symmetric_node_status_snapshot.count_stores
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen: {}
    refresh: 15 minutes
    row: 14
    col: 0
    width: 12
    height: 7
  - name: Symmetric Health Statistics in the Past 1 Day
    title: Symmetric Health Statistics in the Past 1 Day
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: looker_line
    fields:
    - symmetric_node_status_snapshot.snapshot_time
    - symmetric_node_status_snapshot.sum_batches_to_send_cnt
    - symmetric_node_status_snapshot.sum_batches_in_error_cnt
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'No'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.snapshot_time desc
    limit: 500
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: 21
    font_size: '9'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: symmetric_node_status_snapshot.sum_batches_to_send_cnt
        name: Batches to Send - Total
        axisId: symmetric_node_status_snapshot.sum_batches_to_send_cnt
      - id: symmetric_node_status_snapshot.sum_batches_in_error_cnt
        name: Batches in Error - Total
        axisId: symmetric_node_status_snapshot.sum_batches_in_error_cnt
      showLabels: true
      showValues: true
      unpinAxis: true
      tickDensity: default
      type: log
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    swap_axes: false
    show_null_points: true
    interpolation: monotone
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    refresh: 15 minutes
    row: 14
    col: 12
    width: 12
    height: 7
  - name: Symmetric Offline vs Non Offline Store Statistics Trend in the Past 1 Day
      based on Snapshots
    title: Symmetric Offline vs Non Offline Store Statistics Trend in the Past 1
      Day based on Snapshots
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: looker_line
    fields:
    - symmetric_node_status_snapshot.snapshot_time
    - symmetric_node_status_snapshot.count_stores
    - symmetric_node_status_snapshot.offline_category
    pivots:
    - symmetric_node_status_snapshot.offline_category
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'No'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.snapshot_time desc
    - symmetric_node_status_snapshot.offline_category
    limit: 5000
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: 21
    font_size: '9'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: NON-OFFLINE - symmetric_node_status_snapshot.count_stores
        name: NON-OFFLINE
        axisId: symmetric_node_status_snapshot.count_stores
      - id: OFFLINE - symmetric_node_status_snapshot.count_stores
        name: OFFLINE
        axisId: symmetric_node_status_snapshot.count_stores
      showLabels: true
      showValues: true
      unpinAxis: true
      tickDensity: custom
      tickDensityCustom: 8
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    swap_axes: false
    show_null_points: true
    interpolation: monotone
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    refresh: 15 minutes
    row: 0
    col: 5
    width: 19
    height: 6
  - name: Total Symmetric Enabled Stores
    title: Total Symmetric Enabled Stores
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: single_value
    fields:
    - symmetric_node_status_snapshot.count_stores
    filters:
      symmetric_node_status_snapshot.latest_snapshot_filter: 'Yes'
      symmetric_node_status_snapshot.snapshot_date: 1 days
    limit: 5000
    query_timezone: America/Chicago
    custom_color_enabled: true
    custom_color: "#22458b"
    show_single_value_title: true
    single_value_title: Total Symmetric Enabled Stores
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    value_labels: labels
    label_type: labPer
    colors:
    - "#84bd00"
    - "#005eb8"
    - "#ffcd00"
    - "#67cdf2"
    - "#00395d"
    - "#001c33"
    - "#cde29e"
    - "#405812"
    - "#ffed45"
    - "#af8912"
    series_colors: {}
    show_value_labels: true
    font_size: 0
    hide_legend: false
    stacking: ''
    label_density: 23
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - DATA LAG - symmetric_node_status_snapshot.count_stores
    - HEALTHY - symmetric_node_status_snapshot.count_stores
    - symmetric_node_status_snapshot.count_stores
    y_axes:
    - label:
      orientation: top
      series:
      - id: symmetric_node_status_snapshot.sum_batches_in_error_cnt
        name: Batches in Error - Total
        axisId: symmetric_node_status_snapshot.sum_batches_in_error_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: log
    - label:
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.sum_batches_to_send_cnt
        name: Batches to Send - Total
        axisId: symmetric_node_status_snapshot.sum_batches_to_send_cnt
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    - label: ''
      orientation: bottom
      series:
      - id: symmetric_node_status_snapshot.count_stores
        name: Stores - Total
        axisId: symmetric_node_status_snapshot.count_stores
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    swap_axes: false
    show_null_points: true
    interpolation: linear
    listen: {}
    refresh: 15 minutes
    row: 0
    col: 0
    width: 5
    height: 4
  - title: Untitled
    name: Untitled
    model: PDX_SF
    explore: symmetric_node_status_snapshot
    type: single_value
    fields:
    - symmetric_node_status_snapshot.snapshot_time
    filters:
      symmetric_node_status_snapshot.snapshot_date: 1 days
    sorts:
    - symmetric_node_status_snapshot.snapshot_time desc
    limit: 500
    custom_color_enabled: true
    custom_color: "#22398b"
    show_single_value_title: true
    single_value_title: Last Snapshot Time
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
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '1'
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen: {}
    refresh: 15 minutes
    row: 4
    col: 0
    width: 5
    height: 2

- dashboard: edx_tmpl_chain_workflow_productivity_and_load_balancing
  title: Dashboard - Workflow Productivity and Load Balancing
  layout: newspaper
  elements:
  - name: 'Workflow: Productivity - Top 100 Team Members PutBack Percent'
    title: 'Workflow: Productivity - Top 100 Team Members PutBack Percent'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - store_alignment.district
    - eps_task_history.task_history_user_employee_number
    - eps_task_history.count
    filters:
      store_alignment.division: ''
      store.store_number: ''
      store_alignment.region: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_task_history.Human_Task: 'YES'
      eps_task_history.task_history_task_action: PUTBACK
      eps_task_history.task_history_action_current_date: 1 weeks ago for 1 weeks
    sorts:
    - eps_task_history.count desc
    limit: 100
    column_limit: 20
    dynamic_fields:
    - table_calculation: of_top_100
      label: "% of Top 100"
      expression: "${eps_task_history.count}/sum(${eps_task_history.count})"
      value_format:
      value_format_name: percent_2
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
    fontSize: '50'
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
    show_null_points: true
    point_style: none
    interpolation: monotone
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    series_types: {}
    series_labels:
      eps_task_history.count: Putback's
      eps_task_history.task_history_user_employee_number: Employee Number
      store_alignment.district: District
    listen:
      Chain ID: chain.chain_id
    row: 10
    col: 0
    width: 24
    height: 8
  - name: 'Workflow: Productivity - Load Balancing Utilization % and Avg Task Times
      - By Task'
    title: 'Workflow: Productivity - Load Balancing Utilization % and Avg Task Times
      - By Task'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_task_history.task_history_task_name
    - eps_task_history_task_time.avg_task_time
    - eps_workflow_token.count
    - eps_task_history.on_site_alt_site
    pivots:
    - eps_task_history.on_site_alt_site
    filters:
      store_alignment.division: ''
      store.store_number: ''
      store_alignment.region: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: 1 weeks ago for 1 weeks
      eps_task_history.task_history_task_name: DATA^_ENTRY,DATA^_VERIFICATION,ESCRIPT^_DATA^_ENTRY
    sorts:
    - eps_task_history.on_site_alt_site
    - eps_task_history_task_time.avg_task_time desc 0
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: completed_remotely
      label: Completed Remotely %
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_workflow_token.count})/sum(pivot_row(${eps_workflow_token.count})),
        0)
      value_format:
      value_format_name: percent_2
    - table_calculation: avg_seconds_on_site
      label: Avg Seconds (On Site)
      expression: pivot_where(${eps_task_history.on_site_alt_site}="YES", ${eps_task_history_task_time.avg_task_time})
      value_format:
      value_format_name: decimal_2
    - table_calculation: avg_seconds_off_site
      label: Avg Seconds (Off Site)
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_task_history_task_time.avg_task_time}), 0)
      value_format:
      value_format_name: decimal_2
    - table_calculation: off_site_variance_seconds
      label: Off Site Variance (Seconds)
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_task_history_task_time.avg_task_time}), 0)-coalesce(pivot_where(${eps_task_history.on_site_alt_site}="YES",
        ${eps_task_history_task_time.avg_task_time}), 0)
      value_format:
      value_format_name: decimal_2
    - table_calculation: time_variance
      label: Time Variance %
      expression: coalesce(coalesce(${off_site_variance_seconds}, 0)/coalesce(${avg_seconds_off_site},
        0), 0)
      value_format:
      value_format_name: percent_2
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
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
    show_null_points: true
    point_style: circle
    font_size: 12
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    hidden_fields:
    - eps_task_history_task_time.avg_task_time
    series_types: {}
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Chain ID: chain.chain_id
    row: 5
    col: 0
    width: 24
    height: 5
  - name: 'Workflow: Productivity - Load Balancing Utilization % and Avg Task Times
      - By Division'
    title: 'Workflow: Productivity - Load Balancing Utilization % and Avg Task Times
      - By Division'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_task_history_task_time.avg_task_time
    - eps_workflow_token.count
    - eps_task_history.on_site_alt_site
    - store_alignment.division
    pivots:
    - eps_task_history.on_site_alt_site
    filters:
      store_alignment.division: ''
      store.store_number: ''
      store_alignment.region: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: 1 weeks ago for 1 weeks
      eps_task_history.task_history_task_name: DATA^_ENTRY,DATA^_VERIFICATION,ESCRIPT^_DATA^_ENTRY
    sorts:
    - eps_task_history.on_site_alt_site
    - eps_task_history_task_time.avg_task_time desc 0
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: completed_remotely
      label: Completed Remotely %
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_workflow_token.count})/sum(pivot_row(${eps_workflow_token.count})),
        0)
      value_format:
      value_format_name: percent_2
    - table_calculation: avg_seconds_on_site
      label: Avg Seconds (On Site)
      expression: pivot_where(${eps_task_history.on_site_alt_site}="YES", ${eps_task_history_task_time.avg_task_time})
      value_format:
      value_format_name: decimal_2
    - table_calculation: avg_seconds_off_site
      label: Avg Seconds (Off Site)
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_task_history_task_time.avg_task_time}), 0)
      value_format:
      value_format_name: decimal_2
    - table_calculation: off_site_variance_seconds
      label: Off Site Variance (Seconds)
      expression: coalesce(pivot_where(${eps_task_history.on_site_alt_site}="NO",
        ${eps_task_history_task_time.avg_task_time}), 0)-coalesce(pivot_where(${eps_task_history.on_site_alt_site}="YES",
        ${eps_task_history_task_time.avg_task_time}), 0)
      value_format:
      value_format_name: decimal_2
    - table_calculation: time_variance
      label: Time Variance %
      expression: coalesce(coalesce(${off_site_variance_seconds}, 0)/coalesce(${avg_seconds_off_site},
        0), 0)
      value_format:
      value_format_name: percent_2
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
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
    show_null_points: true
    point_style: circle
    font_size: 12
    value_labels: legend
    label_type: labPer
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    interpolation: linear
    hidden_fields:
    - eps_task_history_task_time.avg_task_time
    series_types: {}
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Chain ID: chain.chain_id
    row: 0
    col: 0
    width: 24
    height: 5
  - name: "================================ END of Dashboard ================================"
    type: text
    title_text: "================================ END of Dashboard ================================"
    row: 18
    col: 0
    width: 24
    height: 2
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

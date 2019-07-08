- dashboard: exploredx_chain_usage_dashboard
  title: Chain Usage
  layout: newspaper
  elements:
  - title: WTD - User Activity
    name: WTD - User Activity
    model: i__looker
    explore: history
    type: table
    fields:
    - user.name
    - history.approximate_usage_in_minutes
    - history.query_run_count
    - history.created_week_of_year
    pivots:
    - history.created_week_of_year
    filters:
      history.created_date: 2 weeks
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
    sorts:
    - history.approximate_usage_in_minutes desc 0
    - history.created_week_of_year
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      history.approximate_usage_in_minutes: Web Usage(m)
      history.query_run_count: Query Count
      history.created_week_of_year: Week of Year
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_scale: auto
    x_axis_label_rotation: -45
    listen:
      Customer: role.name
    row: 18
    col: 0
    width: 7
    height: 6
  - title: Schedule Activity
    name: Schedule Activity
    model: i__looker
    explore: scheduled_plan
    type: table
    fields:
    - scheduled_plan.id
    - user.name
    - scheduled_job.name
    - scheduled_plan.cron_schedule
    - scheduled_plan.content_link
    - scheduled_plan.look_id
    - scheduled_plan.lookml_dashboard_id
    - scheduled_plan.dashboard_id
    - scheduled_job.scheduled_plan_id
    - scheduled_job.count
    - scheduled_job.status
    pivots:
    - scheduled_job.status
    filters:
      scheduled_job_stage.stage: execute
      user.is_looker: 'No'
      scheduled_job.created_time: 1 weeks ago for 1 weeks
      scheduled_plan.run_once: 'no'
    sorts:
    - scheduled_job.count desc 2
    - scheduled_job.status 0
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - scheduled_plan.lookml_dashboard_id
    - scheduled_plan.look_id
    - scheduled_plan.dashboard_id
    - scheduled_job.scheduled_plan_id
    - scheduled_plan.id
    - scheduled_plan.content_link
    listen:
      Customer: user.email
    row: 24
    col: 7
    width: 9
    height: 6
  - title: User Breakdown
    name: User Breakdown
    model: i__looker
    explore: user
    type: looker_single_record
    fields:
    - user.count
    - role.name
    pivots:
    - role.name
    filters:
      user.is_disabled: 'No'
      user.is_looker: 'No'
      user.email: "-%pdxinc.com%,-%test%,-%hostedrx.com%"
    sorts:
    - user.count desc 0
    - role.name
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: user_type
      label: User Type
      expression: if((contains(${role.name},"External User")),"Power","View")
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: string
    query_timezone: America/Chicago
    show_view_names: false
    limit_displayed_rows: false
    show_row_numbers: false
    truncate_column_names: false
    table_theme: gray
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
    hide_totals: false
    hide_row_totals: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_fields:
    - user_type
    listen:
      Customer: role.name
    row: 0
    col: 9
    width: 5
    height: 4
  - title: Top Looks last 90 Days
    name: Top Looks last 90 Days
    model: i__looker
    explore: history
    type: table
    fields:
    - look.created_date
    - look.title
    - history.query_run_count
    - look.id
    filters:
      look.created_date: "-null"
      user.name: "-NULL"
      history.created_date: 90 days
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
    sorts:
    - history.query_run_count desc
    limit: 10
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 207
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 202
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields:
    - look.id
    series_types: {}
    listen:
      Customer: role.name
    row: 18
    col: 7
    width: 9
    height: 6
  - name: <b><font color="344b5d" size="+4">Looker Usage Details</font></b>
    type: text
    title_text: <b><font color="344b5d" size="+4">Looker Usage Details</font></b>
    subtitle_text: ''
    body_text: ''
    row: 4
    col: 0
    width: 24
    height: 2
  - name: <b><font color="344b5d" size="+4">Snowflake Usage Details</font></b>
    type: text
    title_text: <b><font color="344b5d" size="+4">Snowflake Usage Details</font></b>
    row: 30
    col: 0
    width: 24
    height: 2
  - title: MTD - Queries by Hour
    name: MTD - Queries by Hour
    model: i__looker
    explore: history
    type: looker_column
    fields:
    - history.created_hour_of_day
    - history.query_run_count
    fill_fields:
    - history.created_hour_of_day
    filters:
      history.created_date: 1 months
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
    sorts:
    - history.created_hour_of_day
    limit: 25
    column_limit: 50
    stacking: ''
    colors:
    - "#344b5d"
    - "#D98541"
    - "#C53DCC"
    - "#33992E"
    - "#36B38D"
    - "#A2BF39"
    - "#5A3DCC"
    - "#8a0f3d"
    - "#ff7aa3"
    - "#2d89bd"
    - "#8f09b0"
    - "#d94141"
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types:
      history.query_run_count: area
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Hour of Day (CST)
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_label_rotation: -45
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Customer: role.name
    row: 12
    col: 0
    width: 12
    height: 6
  - title: 6 Month Trend
    name: 6 Month Trend
    model: i__looker
    explore: history
    type: looker_line
    fields:
    - history.query_run_count
    - history.created_month
    - history.approximate_usage_in_minutes
    filters:
      history.created_date: 6 months
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
    sorts:
    - history.created_month
    limit: 25
    column_limit: 50
    stacking: ''
    colors:
    - "#344b5d"
    - "#6897bb"
    - "#C53DCC"
    - "#33992E"
    - "#36B38D"
    - "#A2BF39"
    - "#5A3DCC"
    - "#8a0f3d"
    - "#ff7aa3"
    - "#2d89bd"
    - "#8f09b0"
    - "#d94141"
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_label_rotation: -45
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    listen:
      Customer: role.name
    row: 6
    col: 12
    width: 12
    height: 6
  - title: Top Dashboards last 90 days
    name: Top Dashboards last 90 days
    model: i__looker
    explore: history
    type: table
    fields:
    - dashboard.title
    - history.query_run_count
    - history.real_dash_id
    filters:
      dashboard.title: "-NULL"
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
      history.created_date: 90 days
    sorts:
    - history.query_run_count desc
    limit: 10
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
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
    hidden_fields:
    - history.real_dash_id
    listen:
      Customer: role.name
    row: 18
    col: 16
    width: 8
    height: 6
  - title: YTD Web Usage(m)
    name: YTD Web Usage(m)
    model: i__looker
    explore: history
    type: looker_column
    fields:
    - history.approximate_usage_in_minutes
    - history.created_month_name
    filters:
      history.created_date: 1 years
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%hostedrx%,-%test%,-%pdxinc%"
    sorts:
    - history.created_month_name
    limit: 25
    column_limit: 50
    stacking: ''
    colors:
    - "#344b5d"
    - "#5a1038"
    - "#ff947c"
    - "#1f6b62"
    - "#764173"
    - "#910303"
    - "#b2947c"
    - "#192d54"
    - "#a31e67"
    - "#a16154"
    - "#0f544b"
    - "#ffd9ba"
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: Minutes
      orientation: left
      series:
      - id: history.approximate_usage_in_minutes
        name: Approximate Web Usage in Minutes
        axisId: history.approximate_usage_in_minutes
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 481
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 9
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 478
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    x_axis_label_rotation: -45
    ordering: none
    show_null_labels: false
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: "#360e8a"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      Customer: role.name
    row: 6
    col: 0
    width: 12
    height: 6
  - title: Looker Summary
    name: Looker Summary
    model: i__looker
    explore: history
    type: looker_single_record
    fields:
    - history.created_year
    - history.created_month_num
    - history.approximate_usage_in_minutes
    filters:
      history.created_date: 1 years
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc.com%,-%test%,-%hostedrx%"
    sorts:
    - history.created_year desc
    - history.created_month_num
    limit: 25
    column_limit: 50
    dynamic_fields:
    - table_calculation: year_to_date_usagem
      label: Year to Date Usage(m)
      expression: sum(${history.approximate_usage_in_minutes})
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: last_month_usagem
      label: Last Month Usage(m)
      expression: "sum(\n    if(${history.created_month_num} \n        = (if(extract_months(now())\
        \ = 1, \n              12, \n              extract_months(now()))-1\n    \
        \      )\n       AND \n       (extract_years(${history.created_year}) \n \
        \         = (if(extract_months(now()) = 1, \n                extract_years(now())-1,\
        \ \n                extract_years(now()) \n                ) \n          \
        \  ) \n       )\n       ,\n       ${history.approximate_usage_in_minutes},\n\
        \       0\n      )\n   )"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: month_to_date_usagem
      label: Month to Date Usage(m)
      expression: sum(if(${history.created_month_num}=extract_months(now()),${history.approximate_usage_in_minutes},0))
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 581
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 576
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    colors:
    - "#294987"
    - "#5a1038"
    - "#ff947c"
    - "#1f6b62"
    - "#764173"
    - "#910303"
    - "#b2947c"
    - "#192d54"
    - "#a31e67"
    - "#a16154"
    - "#0f544b"
    - "#ffd9ba"
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_colors: {}
    series_types: {}
    y_axes:
    - label: Minutes
      orientation: left
      series:
      - id: history.approximate_usage_in_minutes
        name: Approximate Web Usage in Minutes
        axisId: history.approximate_usage_in_minutes
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 618
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 9
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 615
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    x_axis_label_rotation: -45
    ordering: none
    show_null_labels: false
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    custom_color: "#360e8a"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields:
    - history.approximate_usage_in_minutes
    - history.created_month_num
    - history.created_year
    listen:
      Customer: role.name
    row: 0
    col: 14
    width: 5
    height: 4
  - title: MTD Explorer Usage
    name: MTD Explorer Usage
    model: i__looker
    explore: history
    type: looker_column
    fields:
    - query.view
    - history.approximate_usage_in_minutes
    filters:
      history.created_date: 1 months
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
    sorts:
    - history.approximate_usage_in_minutes desc
    limit: 25
    column_limit: 50
    dynamic_fields:
    - table_calculation: explorer_name
      label: Explorer Name
      expression: |-
        if(${query.view}="sales","Sales",
          if(${query.view}="prescriber","Prescriber",
            if(${query.view}="patient","Patient",
              if(${query.view}="eps_workflow_order_entry_rx_tx","Workflow",
                if(${query.view}="eps_tx_tp_transmit_queue","TP Transmit Queue",
                  if(${query.view}="drug","Drug",
                    if(${query.view}="inventory","Inventory",
                      if(${query.view}="compound","Compound",
                        if(${query.view}="eps_prescriber_edi","eScript",
                          if(${query.view}="plan","Plan",
                            if(${query.view}="patient_activity_snapshot","Patient Activity",
                              if(${query.view}="store","Pharmacy",
                                if(${query.view}="ar_transaction_status","AR Transaction",null)))))))))))))
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    stacking: ''
    colors:
    - "#344b5d"
    - "#5a1038"
    - "#ff947c"
    - "#1f6b62"
    - "#764173"
    - "#910303"
    - "#b2947c"
    - "#192d54"
    - "#a31e67"
    - "#a16154"
    - "#0f544b"
    - "#ffd9ba"
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_labels:
      history.approximate_usage_in_minutes: Web Usage(m)
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: Web Usage(m)
      orientation: left
      series:
      - id: history.approximate_usage_in_minutes
        name: Web Usage(m)
        axisId: history.approximate_usage_in_minutes
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 735
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 732
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Explorer's
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_label_rotation: -45
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - "#344b5d"
    smoothedBars: true
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    hidden_fields:
    - query.view
    listen:
      Customer: role.name
    row: 12
    col: 12
    width: 12
    height: 6
  - title: Snowflake Looker Usage
    name: Snowflake Looker Usage
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_single_record
    fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.warehouse_name
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 years
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: year_to_date_usagem
      label: Year to Date Usage(m)
      expression: sum(${snowflake_account_usage_warehouse_metering_history.sum_credits_used})
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: last_month_usagem
      label: Last Month Usage(m)
      expression: "sum(\n    if(${snowflake_account_usage_warehouse_metering_history.start_month_num}\
        \ \n        = (if(extract_months(now()) = 1, \n              12, \n      \
        \        extract_months(now()))-1\n          )\n       AND \n       (extract_years(${snowflake_account_usage_warehouse_metering_history.start_year})\
        \ \n          = (if(extract_months(now()) = 1, \n                extract_years(now())-1,\
        \ \n                extract_years(now()) \n                ) \n          \
        \  ) \n       )\n       ,\n       ${snowflake_account_usage_warehouse_metering_history.sum_credits_used},\n\
        \       0\n      )\n   )"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: month_to_date_usagem
      label: Month to Date Usage(m)
      expression: sum(if(${snowflake_account_usage_warehouse_metering_history.start_month_num}=extract_months(now()),${snowflake_account_usage_warehouse_metering_history.sum_credits_used},0))
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Chicago
    show_view_names: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    font_size: medium
    font: verdana
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    show_value_labels: false
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
    stacking: ''
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
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 34
    col: 0
    width: 12
    height: 4
  - title: Snowflake Direct Usage
    name: Snowflake Direct Usage
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_single_record
    fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.warehouse_name
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 years
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "-%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: year_to_date_usagem
      label: Year to Date Usage(m)
      expression: sum(${snowflake_account_usage_warehouse_metering_history.sum_credits_used})
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: last_month_usagem
      label: Last Month Usage(m)
      expression: "sum(\n    if(${snowflake_account_usage_warehouse_metering_history.start_month_num}\
        \ \n        = (if(extract_months(now()) = 1, \n              12, \n      \
        \        extract_months(now()))-1\n          )\n       AND \n       (extract_years(${snowflake_account_usage_warehouse_metering_history.start_year})\
        \ \n          = (if(extract_months(now()) = 1, \n                extract_years(now())-1,\
        \ \n                extract_years(now()) \n                ) \n          \
        \  ) \n       )\n       ,\n       ${snowflake_account_usage_warehouse_metering_history.sum_credits_used},\n\
        \       0\n      )\n   )"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: month_to_date_usagem
      label: Month to Date Usage(m)
      expression: sum(if(${snowflake_account_usage_warehouse_metering_history.start_month_num}=extract_months(now()),${snowflake_account_usage_warehouse_metering_history.sum_credits_used},0))
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Chicago
    show_view_names: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    font_size: medium
    font: verdana
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    show_value_labels: false
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
    stacking: ''
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
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 34
    col: 12
    width: 12
    height: 4
  - title: Snowflake Summary
    name: Snowflake Summary
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_single_record
    fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 years
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: year_to_date_usagem
      label: Year to Date Usage(m)
      expression: sum(${snowflake_account_usage_warehouse_metering_history.sum_credits_used})
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: last_month_usagem
      label: Last Month Usage(m)
      expression: "sum(\n    if(${snowflake_account_usage_warehouse_metering_history.start_month_num}\
        \ \n        = (if(extract_months(now()) = 1, \n              12, \n      \
        \        extract_months(now()))-1\n          )\n       AND \n       (extract_years(${snowflake_account_usage_warehouse_metering_history.start_year})\
        \ \n          = (if(extract_months(now()) = 1, \n                extract_years(now())-1,\
        \ \n                extract_years(now()) \n                ) \n          \
        \  ) \n       )\n       ,\n       ${snowflake_account_usage_warehouse_metering_history.sum_credits_used},\n\
        \       0\n      )\n   )"
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: month_to_date_usagem
      label: Month to Date Usage(m)
      expression: sum(if(${snowflake_account_usage_warehouse_metering_history.start_month_num}=extract_months(now()),${snowflake_account_usage_warehouse_metering_history.sum_credits_used},0))
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      _type_hint: number
    query_timezone: America/Chicago
    show_view_names: false
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    font_size: medium
    font: verdana
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
    show_value_labels: false
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
    stacking: ''
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
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.start_year
    - snowflake_account_usage_warehouse_metering_history.start_month_num
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 0
    col: 19
    width: 5
    height: 4
  - title: MTD Direct - Usage by Hour(m)
    name: MTD Direct - Usage by Hour(m)
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_area
    fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    fill_fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 months
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "-%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day 0
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: cst
      label: CST
      expression: if(${snowflake_account_usage_warehouse_metering_history.start_hour_of_day}<6,24-${snowflake_account_usage_warehouse_metering_history.start_hour_of_day},${snowflake_account_usage_warehouse_metering_history.start_hour_of_day}-6)
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    query_timezone: America/Chicago
    stacking: ''
    colors:
    - 'palette: Random'
    show_value_labels: true
    label_density: 25
    font_size: '11'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_labels:
      snowflake_account_usage_warehouse_metering_history.start_hour_of_day: '" "'
      snowflake_account_usage_warehouse_metering_history.start_date: Activity Date
      snowflake_account_usage_warehouse_metering_history.sum_dollars_spent_per_credit: Dollars
        Spent
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    y_axes:
    - label: Credits Used
      orientation: left
      series:
      - id: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        name: Total Warehouse Credits Billed/Used
        axisId: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1185
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      valueFormat:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1182
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Hour of Day(CST)
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: true
    value_labels: legend
    label_type: labPer
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
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    show_dropoff: false
    inner_radius: 0
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
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1253
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1248
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 44
    col: 12
    width: 12
    height: 6
  - title: MTD Looker - Usage by Hour(m)
    name: MTD Looker - Usage by Hour(m)
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_area
    fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    fill_fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 months
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day 0
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: cst
      label: CST
      expression: if(${snowflake_account_usage_warehouse_metering_history.start_hour_of_day}<6,24-${snowflake_account_usage_warehouse_metering_history.start_hour_of_day},${snowflake_account_usage_warehouse_metering_history.start_hour_of_day}-6)
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    query_timezone: America/Chicago
    stacking: ''
    colors:
    - 'palette: Random'
    show_value_labels: true
    label_density: 25
    font_size: '11'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_labels:
      snowflake_account_usage_warehouse_metering_history.start_hour_of_day: '" "'
      snowflake_account_usage_warehouse_metering_history.start_date: Activity Date
      snowflake_account_usage_warehouse_metering_history.sum_dollars_spent_per_credit: Dollars
        Spent
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    y_axes:
    - label: Credits Used
      orientation: left
      series:
      - id: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        name: Total Warehouse Credits Billed/Used
        axisId: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1325
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      valueFormat:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1322
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Hour of Day(CST)
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: true
    value_labels: legend
    label_type: labPer
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
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.start_hour_of_day
    show_dropoff: false
    inner_radius: 0
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
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1393
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1388
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 44
    col: 0
    width: 12
    height: 6
  - title: YTD Looker - Usage by Month(m)
    name: YTD Looker - Usage by Month(m)
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_column
    fields:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    - snowflake_account_usage_warehouse_metering_history.start_month_name
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 years
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_month_name
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    query_timezone: America/Chicago
    stacking: ''
    colors:
    - 'palette: Random'
    show_value_labels: true
    label_density: 25
    font_size: '11'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_labels:
      snowflake_account_usage_warehouse_metering_history.start_hour_of_day: '" "'
      snowflake_account_usage_warehouse_metering_history.start_date: Activity Date
      snowflake_account_usage_warehouse_metering_history.sum_dollars_spent_per_credit: Dollars
        Spent
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    y_axes:
    - label: Credits Used
      orientation: left
      series:
      - id: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        name: Total Warehouse Credits Billed/Used
        axisId: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1455
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      valueFormat:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1452
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Month
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: true
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
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
    hidden_fields: []
    inner_radius: 0
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
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1522
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1517
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 38
    col: 0
    width: 12
    height: 6
  - title: YTD Direct - Usage by Month(m)
    name: YTD Direct - Usage by Month(m)
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: looker_column
    fields:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    - snowflake_account_usage_warehouse_metering_history.start_month_name
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 years
      snowflake_account_usage_warehouse_metering_history.product_name: ''
      snowflake_account_usage_warehouse_metering_history.environment: "-SNOWFLAKE\
        \ SUPPORT"
      snowflake_account_usage_warehouse_metering_history.warehouse_name: "-%^_RPT%"
    sorts:
    - snowflake_account_usage_warehouse_metering_history.start_month_name
    limit: 500
    column_limit: 50
    total: true
    row_total: right
    query_timezone: America/Chicago
    stacking: ''
    colors:
    - 'palette: Random'
    show_value_labels: true
    label_density: 25
    font_size: '11'
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors: {}
    series_labels:
      snowflake_account_usage_warehouse_metering_history.start_hour_of_day: '" "'
      snowflake_account_usage_warehouse_metering_history.start_date: Activity Date
      snowflake_account_usage_warehouse_metering_history.sum_dollars_spent_per_credit: Dollars
        Spent
    series_types: {}
    limit_displayed_rows: false
    hidden_series:
    - snowflake_account_usage_warehouse_metering_history.sum_credits_used
    y_axes:
    - label: Credits Used
      orientation: left
      series:
      - id: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        name: Total Warehouse Credits Billed/Used
        axisId: snowflake_account_usage_warehouse_metering_history.sum_credits_used
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1584
      showLabels: true
      showValues: true
      maxValue:
      minValue:
      valueFormat:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1581
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Hour of Day(UTC)
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trend_lines: []
    ordering: none
    show_null_labels: true
    show_dropoff: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labPer
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
    hidden_fields: []
    inner_radius: 0
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
        __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
        __LINE_NUM: 1651
      bold: false
      italic: false
      strikethrough: false
      fields:
      __FILE: pdx_dss/exploredx_chain_usage_dashboard.dashboard.lookml
      __LINE_NUM: 1646
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 38
    col: 12
    width: 12
    height: 6
  - name: <b><font color="344b5d" size="+1">Report Usage</font></b>
    type: text
    title_text: <b><font color="344b5d" size="+1">Report Usage</font></b>
    row: 32
    col: 0
    width: 12
    height: 2
  - name: <b><font color="344b5d" size="+1">Direct Usage</font></b>
    type: text
    title_text: <b><font color="344b5d" size="+1">Direct Usage</font></b>
    row: 32
    col: 12
    width: 12
    height: 2
  - title: User - No Activity last 30 days
    name: User - No Activity last 30 days
    model: i__looker
    explore: history
    type: table
    fields:
    - user.name
    - history.approximate_usage_in_minutes
    - history.query_run_count
    filters:
      history.created_date: 30 days
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
      history.approximate_usage_in_minutes: '0'
    sorts:
    - history.approximate_usage_in_minutes desc
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      history.approximate_usage_in_minutes: Web Usage(m)
      history.query_run_count: Query Count
      history.created_week_of_year: Week of Year
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_scale: auto
    x_axis_label_rotation: -45
    listen:
      Customer: role.name
    row: 24
    col: 16
    width: 8
    height: 6
  - title: YTD - User Activity
    name: YTD - User Activity
    model: i__looker
    explore: history
    type: table
    fields:
    - user.name
    - history.approximate_usage_in_minutes
    - history.query_run_count
    filters:
      history.created_date: 1 years
      history.source: "-'scheduled_task'"
      user.is_looker: 'No'
      user.email: "-%pdxinc%,-%test%,-%hostedrx%"
    sorts:
    - history.approximate_usage_in_minutes desc
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      history.approximate_usage_in_minutes: Web Usage(m)
      history.query_run_count: Query Count
      history.created_week_of_year: Week of Year
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_scale: auto
    x_axis_label_rotation: -45
    listen:
      Customer: role.name
    row: 24
    col: 0
    width: 7
    height: 6
  - title: Untitled
    name: Untitled
    model: PDX_SF
    explore: snowflake_account_usage_warehouse_metering_history
    type: single_value
    fields:
    - snowflake_account_usage_warehouse_metering_history.chain_name
    filters:
      snowflake_account_usage_warehouse_metering_history.start_time: 1 months
    sorts:
    - snowflake_account_usage_warehouse_metering_history.chain_name
    limit: 500
    dynamic_fields:
    - table_calculation: customer
      label: Customer
      expression: replace(${snowflake_account_usage_warehouse_metering_history.chain_name},"_RPT","")
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    custom_color_enabled: true
    custom_color: "#344b5d"
    show_single_value_title: false
    single_value_title: ''
    value_format: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - snowflake_account_usage_warehouse_metering_history.chain_name
    note_state: collapsed
    note_display: below
    note_text: This is informational only and not meant to be an invoice.
    listen:
      Customer: snowflake_account_usage_warehouse_metering_history.chain_name
    row: 0
    col: 0
    width: 9
    height: 4
  filters:
  - name: Customer
    title: Customer
    type: string_filter
    default_value: "%BI%"
    allow_multiple_values: true
    required: false

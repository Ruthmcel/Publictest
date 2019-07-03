- dashboard: ardss_aging_dashboard
  title: Aging Dashboard
  layout: newspaper
  embed_style:
    background_color: "#18731f"
    show_title: true
    title_color: "#3a4245"
    show_filters_bar: true
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Aging Distribution
    name: Aging Distribution
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: looker_column
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_transaction_status.age_tier]
    fill_fields: [ar_transaction_status.age_tier]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_transaction_status.transaction_status_id_mc: OPEN
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
    sorts: [ar_transaction_status.age_tier]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    stacking: ''
    color_application:
      collection_id: legacy
      palette_id: looker_classic
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 48
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      ar_transaction_status.sum_transaction_status_amount_due: "#33a02c"
      percent_of_total: "#9fc190"
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
    series_types: {}
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    y_axes: [{label: '', orientation: left, series: [{id: percent_of_total, name: Percent
              of Total, axisId: percent_of_total, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
            __LINE_NUM: 73}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
        __LINE_NUM: 70}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 114}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 109}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ar_transaction_status.sum_transaction_status_amount_due]
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 5
    col: 0
    width: 16
    height: 7
  - title: Aging By Plan Type
    name: Aging By Plan Type
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: looker_pie
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_plan.plan_type_id_mc]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_transaction_status.transaction_status_id_mc: OPEN
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    value_labels: legend
    label_type: labVal
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 170
    series_colors: {}
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 195}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 192}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 236}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 231}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ar_transaction_status.sum_transaction_status_amount_due]
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 12
    col: 0
    width: 8
    height: 8
  - title: Top Plans By Aging
    name: Top Plans By Aging
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: table
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_plan.plan_name]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_transaction_status.transaction_status_id_mc: OPEN
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 290
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: gray
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '25'
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 316}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 311}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 340}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 337}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 12
    col: 8
    width: 8
    height: 8
  - name: Aging Dashboard
    type: text
    title_text: <img src="https://absolutercm.nhin.com/emerald/images/AAR%20Header%20Logo22.png"
      width="400" height="60"/>
    subtitle_text: <font color="white" size="6">Aging Dashboard</font>
    body_text: ''
    row: 0
    col: 0
    width: 8
    height: 3
  - title: Aging Total
    name: Aging Total
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.sum_transaction_status_amount_due]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    query_timezone: America/Chicago
    color_application:
      collection_id: ed5756e2-1ba8-4233-97d2-d565e309c03b
      palette_id: ff31218a-4f9d-493c-ade2-22266f5934b8
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 424
    custom_color_enabled: true
    custom_color: "#3cb050"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 457}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 452}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 481}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 478}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 3
    col: 0
    width: 8
    height: 2
  - title: Aging Total > 360 Days
    name: Aging Total > 360 Days
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.sum_transaction_status_amount_due]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ">=360"
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    query_timezone: America/Chicago
    color_application:
      collection_id: ed5756e2-1ba8-4233-97d2-d565e309c03b
      palette_id: ff31218a-4f9d-493c-ade2-22266f5934b8
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 555
    custom_color_enabled: true
    custom_color: "#b0471c"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 588}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 583}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 612}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 609}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 3
    col: 16
    width: 8
    height: 2
  - title: Aging Total > 90 Days
    name: Aging Total > 90 Days
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.sum_transaction_status_amount_due]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ">=90"
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    query_timezone: America/Chicago
    color_application:
      collection_id: ed5756e2-1ba8-4233-97d2-d565e309c03b
      palette_id: ff31218a-4f9d-493c-ade2-22266f5934b8
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 686
    custom_color_enabled: true
    custom_color: "#b0ab24"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 719}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 714}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 743}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 740}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 3
    col: 8
    width: 8
    height: 2
  - title: Untitled
    name: Untitled
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_chain.chain_name]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
    limit: 500
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: Customer
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    series_types: {}
    listen: {}
    row: 0
    col: 16
    width: 8
    height: 3
  - title: Top Stores By Aging
    name: Top Stores By Aging
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: table
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_store.store_number]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_transaction_status.transaction_status_id_mc: OPEN
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 843
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: gray
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 869}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 864}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 893}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 890}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 12
    col: 16
    width: 8
    height: 8
  - title: Average Aging Days
    name: Average Aging Days
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.average_aging_days, ar_chain.chain_id]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ''
    sorts: [average_aging_days desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: true,
        _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33
      palette_id: 3bf25341-a039-432e-ae77-85ed5a8d2450
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 968
    custom_color_enabled: true
    custom_color: "#000000"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    colorRange: [green, yellow, red]
    colorTransitions: ['30', '60']
    maximum: 90
    majorTicks: 10
    minorTicks: 10
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: true
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, options: {steps: 5, reverse: true,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1014},
          __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1011},
        bold: false, italic: false, strikethrough: false, fields: !!null '', __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
        __LINE_NUM: 1006}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1038}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1035}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 20
    col: 6
    width: 6
    height: 2
  - title: Aging Breakdown
    name: Aging Breakdown
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: looker_pie
    fields: [ar_transaction_status.transaction_status_transaction_type_id_mc, ar_transaction_status.sum_transaction_status_amount_due]
    filters:
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_transaction_status.transaction_status_id_mc: OPEN
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    value_labels: legend
    label_type: labVal
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 1113
    series_colors: {}
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_types: {}
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1138}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1135}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    enable_conditional_formatting: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
          __LINE_NUM: 1179}, bold: false, italic: false, strikethrough: false, fields: !!null '',
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1174}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: [ar_transaction_status.sum_transaction_status_amount_due]
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 5
    col: 16
    width: 8
    height: 7
  - title: Highest Receivable
    name: Highest Receivable
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_transaction_status.transaction_id]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: true,
        _kind_hint: measure, _type_hint: number}, {table_calculation: highest_receivable,
        label: Highest Receivable, expression: 'max(${ar_transaction_status.sum_transaction_status_amount_due})',
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33
      palette_id: 3bf25341-a039-432e-ae77-85ed5a8d2450
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 1242
    custom_color_enabled: true
    custom_color: "#84bd00"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    colorRange: [green, yellow, red]
    colorTransitions: ['30', '60']
    maximum: 90
    majorTicks: 10
    minorTicks: 10
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: true
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, options: {steps: 5, reverse: true,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1288},
          __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1285},
        bold: false, italic: false, strikethrough: false, fields: !!null '', __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
        __LINE_NUM: 1280}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1312}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1309}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 20
    col: 12
    width: 6
    height: 2
  - title: Highest Aging Day
    name: Highest Aging Day
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_chain.chain_id, ar_transaction_status.highest_aging_day]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ''
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: true,
        _kind_hint: dimension, _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33
      palette_id: 3bf25341-a039-432e-ae77-85ed5a8d2450
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 1385
    custom_color_enabled: true
    custom_color: "#000000"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    colorRange: [green, yellow, red]
    colorTransitions: ['30', '60']
    maximum: 90
    majorTicks: 10
    minorTicks: 10
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: true
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, options: {steps: 5, reverse: true,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1431},
          __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1428},
        bold: false, italic: false, strikethrough: false, fields: !!null '', __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
        __LINE_NUM: 1423}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1455}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1452}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 20
    col: 0
    width: 6
    height: 2
  - title: Average Receivable
    name: Average Receivable
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: single_value
    fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_transaction_status.claim_count,
      ar_chain.chain_id]
    filters:
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter: ''
      ar_report_calendar_global.report_period_filter: ''
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Month
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.transaction_status_id_mc: OPEN
      ar_transaction_status.aging_days: ''
    sorts: [ar_transaction_status.sum_transaction_status_amount_due desc]
    limit: 700
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: percent_of_total, label: Percent of Total,
        expression: "${ar_transaction_status.sum_transaction_status_amount_due}/${ar_transaction_status.sum_transaction_status_amount_due:total}",
        value_format: !!null '', value_format_name: percent_0, is_disabled: true,
        _kind_hint: measure, _type_hint: number}, {table_calculation: highest_receivable,
        label: Highest Receivable, expression: 'max(${ar_transaction_status.sum_transaction_status_amount_due})',
        value_format: !!null '', value_format_name: usd, is_disabled: true, _kind_hint: measure,
        _type_hint: number}, {table_calculation: average_receivable, label: Average
          Receivable, expression: "${ar_transaction_status.sum_transaction_status_amount_due:total}/${ar_transaction_status.claim_count:total}",
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Chicago
    color_application:
      collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33
      palette_id: 3bf25341-a039-432e-ae77-85ed5a8d2450
      options:
        steps: 5
        __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml
        __LINE_NUM: 1546
    custom_color_enabled: true
    custom_color: "#84bd00"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    colorRange: [green, yellow, red]
    colorTransitions: ['30', '60']
    maximum: 90
    majorTicks: 10
    minorTicks: 10
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: true
    hide_row_totals: false
    series_labels:
      ar_plan_aging.plan_processord_identifier_aging: Payer Id
      ar_plan.carrier_code: Carrier Code
      " ": UNASSIGNED
      ar_transaction_status.sum_transaction_status_amount_due: Total
      percent_of_total: Percent
    table_theme: transparent
    limit_displayed_rows: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 43d84376-e7aa-4ffd-ab08-5ee098894e33,
          palette_id: b521fd5e-c363-4694-868b-7d9ff3fc3158, options: {steps: 5, reverse: true,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1592},
          __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1589},
        bold: false, italic: false, strikethrough: false, fields: !!null '', __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml,
        __LINE_NUM: 1584}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    value_labels: legend
    label_type: labVal
    series_colors: {}
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: left
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: ar_transaction_status.sum_transaction_status_amount_due,
            name: Net Due, axisId: ar_transaction_status.sum_transaction_status_amount_due,
            __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1616}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear, __FILE: pdx_dss/ardss_aging_dashboard.dashboard.lookml, __LINE_NUM: 1613}]
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
    trend_lines: []
    ordering: none
    show_null_labels: true
    column_spacing_ratio: 0
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [ar_transaction_status.sum_transaction_status_amount_due, ar_transaction_status.claim_count]
    listen:
      Claim Status: ar_transaction_status.transaction_status_transaction_type_id_mc
      Plan Type: ar_plan.plan_type_id_mc
      Government Plan: ar_plan.plan_government_plan_flag
      Store: ar_store.store_number
      Division: ar_store.store_division
      Aging Bucket: ar_transaction_status.age_tier
    row: 20
    col: 18
    width: 6
    height: 2
  - name: ''
    type: text
    title_text: ''
    body_text: "<body></body>"
    row: 0
    col: 8
    width: 8
    height: 3
  filters:
  - name: Claim Status
    title: Claim Status
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: [Plan Type, Government Plan]
    field: ar_transaction_status.transaction_status_transaction_type_id_mc
  - name: Plan Type
    title: Plan Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: [Government Plan]
    field: ar_plan.plan_type_id_mc
  - name: Government Plan
    title: Government Plan
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: []
    field: ar_plan.plan_government_plan_flag
  - name: Store
    title: Store
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: []
    field: ar_store.store_number
  - name: Division
    title: Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: []
    field: ar_store.store_division
  - name: Aging Bucket
    title: Aging Bucket
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    listens_to_filters: []
    field: ar_transaction_status.age_tier

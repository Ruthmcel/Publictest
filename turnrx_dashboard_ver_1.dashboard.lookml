- dashboard: turnrx_dashboard_ver_1
  title: TurnRx Dashboard
  layout: newspaper
  refresh: 4 hours
  embed_style:
    show_title: false
    show_filters_bar: false
  elements:
  - title: Cost of Goods Sold vs Cost of Goods Purchased
    name: Cost of Goods Sold vs Cost of Goods Purchased
    model: CIS
    explore: turnrx_inventory_store_kpi
    type: looker_column
    fields: [turnrx_inventory_store_kpi.reportable_month, turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty,
      turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty, turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty]
    filters:
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
    sorts: [turnrx_inventory_store_kpi.reportable_month]
    limit: 500
    query_timezone: America/Chicago
    stacking: ''
    trellis: ''
    colors: ["#84bd00", "#005eb8", "#ffcd00", "#67cdf2", "#00395d", "#001c33", "#cde29e",
      "#405812", "#ffed45", "#af8912"]
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors:
      turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty: "#e64848"
      turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty: "#929292"
      turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty: "#CCDEE9"
    series_labels: {}
    series_types:
      turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty: line
    limit_displayed_rows: false
    y_axes: [{label: "$ Cost", orientation: left, series: [{id: turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty,
            name: Cost of Goods Sold Amount, axisId: turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty},
          {id: turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty, name: Cost
              of Goods Purchase Amount, axisId: turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty}],
        showLabels: true, showValues: true, valueFormat: "$#,##0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: "# Annualized\
          \ Turns", orientation: right, series: [{id: turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty,
            name: Annualized Turns - Period, axisId: turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty}],
        showLabels: true, showValues: true, valueFormat: "#,##0.00", unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: ''
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: "$#,##0"
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    note_state: collapsed
    note_display: hover
    note_text: Cost of Goods Sold vs Cost of Goods Purchase Amount
    listen: {}
    row: 9
    col: 0
    width: 24
    height: 10
  - title: RTS Autofill vs RTS Non-Autofill
    name: RTS Autofill vs RTS Non-Autofill
    model: CIS
    explore: turnrx_inventory_store_kpi
    type: looker_column
    fields: [turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty,
      turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty,
      turnrx_inventory_store_kpi.sum_will_call_return_to_stock_count_ty, turnrx_inventory_store_kpi.reportable_month]
    filters:
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
    sorts: [turnrx_inventory_store_kpi.reportable_month]
    limit: 500
    query_timezone: America/Chicago
    stacking: normal
    colors: ['palette: Santa Cruz']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty: "#00588f"
      turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty: "#CCDEE9"
    limit_displayed_rows: false
    y_axes: [{label: "# of Transactions", orientation: left, series: [{id: turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty,
            name: Pharmacy Inventory KPI Autofill Return To Stock Count, axisId: turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty},
          {id: turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty,
            name: Pharmacy Inventory KPI Non Autofill Return To Stock Count, axisId: turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty}],
        showLabels: true, showValues: true, valueFormat: "#,##0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    label_value_format: "#,##0"
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [turnrx_inventory_store_kpi.sum_will_call_return_to_stock_count_ty]
    note_state: collapsed
    note_display: hover
    note_text: Return to Stock Autofill vs Return to Stock Non-Autofill
    listen: {}
    row: 0
    col: 12
    width: 12
    height: 9
  - name: Partial Fill vs Out of Stock
    title: Partial Fill vs Out of Stock
    merged_queries:
    - model: CIS
      explore: sales
      type: table
      fields: [sales.report_period_week_end_date, sales.trx_scripts_count]
      filters:
        sales.history_filter: 'YES'
        report_calendar_global.report_period_filter: 14 weeks
        report_calendar_global.analysis_calendar_filter: Fiscal - Week
        report_calendar_global.this_year_last_year_filter: 'No'
        sales.date_to_use_filter: REPORTABLE SALES
        sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
        sales.show_after_sold_measure_values: 'NO'
        sales.active_archive_filter: '"Active Tables – Current and Past 2 complete
          years'' data"'
        chain.chain_id: ''
        sales.financial_category: PARTIAL - FILLED,PARTIAL - CREDIT
        store.nhin_store_id: ''
      sorts: [sales.report_period_week_end_date]
      limit: 500
      query_timezone: America/Chicago
      join_fields: []
    - model: CIS
      explore: sales
      type: table
      fields: [sales.report_period_week_end_date, sales.trx_scripts_count]
      filters:
        sales.history_filter: 'NO'
        report_calendar_global.report_period_filter: 14 weeks
        report_calendar_global.analysis_calendar_filter: Fiscal - Week
        report_calendar_global.this_year_last_year_filter: 'No'
        sales.date_to_use_filter: FILLED
        sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
        sales.show_after_sold_measure_values: 'NO'
        sales.active_archive_filter: '"Active Tables – Current and Past 2 complete
          years'' data"'
        chain.chain_id: ''
        store_reject_reason_cause.reject_reason_cause: OUT OF STOCK
        store.nhin_store_id: ''
      sorts: [sales.report_period_week_end_date]
      limit: 500
      column_limit: 50
      join_fields:
      - source_field_name: sales.report_period_week_end_date
        field_name: sales.report_period_week_end_date
    stacking: normal
    trellis: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      sales.trx_scripts_count: "#FC9200"
      q1_sales.trx_scripts_count: "#929292"
    series_labels:
      sales.trx_scripts_count: Partial Fill
      q1_sales.trx_scripts_count: Out of Stock
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_datetime_label: "%b %d"
    x_axis_scale: ordinal
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
    type: looker_column
    sorts: [sales.report_period_week_end_date]
    row: 0
    col: 0
    width: 12
    height: 9

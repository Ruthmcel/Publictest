- dashboard: turnrx_dashboard
  title: Turn Rx Dashboard
  layout: newspaper
  refresh: 4 hour
  elements:
  - name: Cost of Goods Sold vs Cost of Goods Purchased
    title: Cost of Goods Sold vs Cost of Goods Purchased
    model: CIS
    explore: turnrx_inventory_store_kpi
    type: looker_column
    fields:
    - turnrx_inventory_store_kpi.reportable_month
    - turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty
    - turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty
    - turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty
    filters:
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
    sorts:
    - turnrx_inventory_store_kpi.reportable_month
    limit: 500
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle
    series_colors:
      turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty: "#929292"
      turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty: "#CCDEE9"
      turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty: "#e64848"
    series_labels: {}
    series_types:
      turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty: line
    limit_displayed_rows: false
    y_axes:
    - label: "$ Cost"
      orientation: left
      series:
      - id: turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty
        name: Cost of Goods Sold Amount
        axisId: turnrx_inventory_store_kpi.sum_cost_of_goods_sold_amount_ty
      - id: turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty
        name: Cost of Goods Purchase Amount
        axisId: turnrx_inventory_store_kpi.sum_cost_of_goods_purchase_amount_ty
      showLabels: true
      showValues: true
      valueFormat: "$#,##0"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label: "# Annualized Turns"
      orientation: right
      series:
      - id: turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty
        name: Annualized Turns - Period
        axisId: turnrx_inventory_store_kpi.store_kpi_period_annualized_turns_ty
      showLabels: true
      showValues: true
      valueFormat: "#,##0.00"
      unpinAxis: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
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
    row: 0
    col: 0
    width: 12
    height: 9
  - name: RTS Autofill vs RTS Non-Autofill
    title: RTS Autofill vs RTS Non-Autofill
    model: CIS
    explore: turnrx_inventory_store_kpi
    type: looker_column
    fields:
    - turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty
    - turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty
    - turnrx_inventory_store_kpi.sum_will_call_return_to_stock_count_ty
    - turnrx_inventory_store_kpi.reportable_month
    filters:
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
    sorts:
    - turnrx_inventory_store_kpi.reportable_month
    limit: 500
    query_timezone: America/Chicago
    stacking: normal
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    label_value_format: "#,##0"
    y_axes:
    - label: "# of Transactions"
      orientation: left
      series:
      - id: turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty
        name: Pharmacy Inventory KPI Autofill Return To Stock Count
        axisId: turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty
      - id: turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty
        name: Pharmacy Inventory KPI Non Autofill Return To Stock Count
        axisId: turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty
      showLabels: true
      showValues: true
      valueFormat: "#,##0"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    hidden_fields:
    - turnrx_inventory_store_kpi.sum_will_call_return_to_stock_count_ty
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      turnrx_inventory_store_kpi.sum_will_call_autofill_return_to_stock_count_ty: "#00588f"
      turnrx_inventory_store_kpi.sum_will_call_non_autofill_return_to_stock_count_ty: "#CCDEE9"
    note_state: collapsed
    note_display: hover
    note_text: Return to Stock Autofill vs Return to Stock Non-Autofill
    row: 0
    col: 12
    width: 12
    height: 9

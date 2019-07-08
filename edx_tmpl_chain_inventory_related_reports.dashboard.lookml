- dashboard: edx_tmpl_chain_inventory_related_reports
  title: Dashboard - Inventory Related Reports
  layout: newspaper
  elements:
  - name: Inventory - Dead Inventory (no movement in >= 8 months)
    title: Inventory - Dead Inventory (no movement in >= 8 months)
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - store.store_name
    - store.store_number
    - store_drug.ndc
    - store_drug.drug_name
    - store_drug_local_setting.drug_local_setting_manufacturer
    - store_drug_local_setting.drug_local_setting_last_fill_date
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_reorder.sum_drug_reorder_order_point
    - store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    - store_drug_local_setting.sum_drug_local_setting_on_hand
    filters:
      store_drug_local_setting.drug_local_setting_on_hand_filter: ">0"
      store_drug.ndc: "-C%"
      store.store_number: "-NULL"
      store_drug_reorder.sum_drug_reorder_order_point: ">0"
    sorts:
    - store_drug_local_setting.sum_drug_local_setting_on_hand desc
    - store_drug_local_setting.drug_local_setting_last_fill_date desc
    limit: 500
    column_limit: 50
    total: true
    filter_expression: " if(is_null(${store_drug_local_setting.drug_local_setting_last_fill_date})\
      \ AND is_null(${store_drug_reorder.drug_reorder_last_order_date}),yes,if(diff_days(now(),\
      \ ${store_drug_local_setting.drug_local_setting_last_fill_date}) > 240 AND diff_days(now(),${store_drug_reorder.drug_reorder_last_order_date})>\
      \ 90,yes,no ))\n  \n  \n  \n  "
    query_timezone: America/Chicago
    hidden_fields:
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_local_setting.drug_local_setting_last_fill_date
    row: 8
    col: 0
    width: 24
    height: 8
  - name: Inventory - OOS by Pharmacy
    title: Inventory - OOS by Pharmacy
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - store_alignment.division
    - store_alignment.region
    - store_alignment.district
    - store.store_name
    - store.store_number
    - store_drug.drug_name
    - store_drug.ndc
    - store_drug_local_setting.sum_drug_local_setting_on_hand
    - eps_line_item.sum_line_item_oe_fill_quantity
    filters:
      eps_line_item.line_item_out_of_stock_hold_until_date_date: after 0 days ago
      eps_rx_tx.rx_tx_will_call_picked_up: 'No'
    sorts:
    - store.store_name
    - store_drug.drug_name
    limit: 5000
    column_limit: 50
    dynamic_fields:
    - table_calculation: fill_qty
      label: Fill Qty
      expression: "${eps_line_item.sum_line_item_oe_fill_quantity}"
      value_format:
      value_format_name: decimal_0
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    hidden_fields:
    - eps_line_item.sum_line_item_oe_fill_quantity
    series_types: {}
    row: 16
    col: 0
    width: 24
    height: 8
  - name: Inventory - Slow Inventory (no movement in >= 3 months)
    title: Inventory - Slow Inventory (no movement in >= 3 months)
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - store.store_name
    - store.store_number
    - store_drug.ndc
    - store_drug.drug_name
    - store_drug_local_setting.drug_local_setting_manufacturer
    - store_drug_local_setting.drug_local_setting_last_fill_date
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_reorder.sum_drug_reorder_order_point
    - store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    - store_drug_local_setting.sum_drug_local_setting_on_hand
    filters:
      store_drug_local_setting.drug_local_setting_on_hand_filter: ">0"
      store_drug.ndc: "-C%"
      store.store_number: "-NULL"
      store_drug_reorder.sum_drug_reorder_order_point: ">0"
    sorts:
    - store_drug_local_setting.sum_drug_local_setting_on_hand desc
    - store_drug_local_setting.drug_local_setting_last_fill_date desc
    limit: 500
    column_limit: 50
    total: true
    filter_expression: " if(is_null(${store_drug_local_setting.drug_local_setting_last_fill_date})\
      \ AND is_null(${store_drug_reorder.drug_reorder_last_order_date}),yes,if(diff_days(now(),\
      \ ${store_drug_local_setting.drug_local_setting_last_fill_date}) > 90 AND diff_days(now(),${store_drug_reorder.drug_reorder_last_order_date})>\
      \ 90,yes,no ))\n  \n  \n  \n  "
    query_timezone: America/Chicago
    hidden_fields:
    - store_drug_reorder.drug_reorder_last_order_date
    - store_drug_local_setting.drug_local_setting_last_fill_date
    row: 24
    col: 0
    width: 24
    height: 8
  - name: Inventory - Number of Unique Products (NDC9) on Shelf
    title: Inventory - Number of Unique Products (NDC9) on Shelf
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - chain.chain_name
    - store_drug.drug_name
    - store_drug.drug_schedule
    - store_drug.drug_ndc_9
    - store_drug_local_setting.sum_drug_local_setting_on_hand
    - store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    - store_drug.count
    filters:
      store.store_number: "-NULL"
      store_drug_local_setting.sum_drug_local_setting_on_hand: ">0"
    sorts:
    - store_drug.drug_name
    limit: 5000
    column_limit: 50
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: editable
    limit_displayed_rows: false
    series_types: {}
    row: 0
    col: 0
    width: 24
    height: 8
  - name: "============================ END Of Dashboard ============================"
    type: text
    title_text: "============================ END Of Dashboard ============================"
    row: 80
    col: 0
    width: 24
    height: 2
  - name: Inventory - Host Vs Store - Drug Cost Comparison
    title: Inventory - Host Vs Store - Drug Cost Comparison
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - store.store_number
    - drug_cost_pivot.drug_cost_region
    - drug.drug_ndc
    - drug.drug_name
    - store_drug.drug_name
    - drug_cost_pivot.acq_cost_amount
    - store_drug_cost_pivot.acq_cost_amount
    - drug_cost_pivot.awp_cost_amount
    - store_drug_cost_pivot.awp_cost_amount
    - drug_cost_pivot.dp_cost_amount
    - store_drug_cost_pivot.dp_cost_amount
    - drug_cost_pivot.mac_cost_amount
    - store_drug_cost_pivot.mac_cost_amount
    - drug_cost_pivot.reg_cost_amount
    - store_drug_cost_pivot.reg_cost_amount
    - drug_cost_pivot.wel_cost_amount
    - store_drug_cost_pivot.wel_cost_amount
    - drug_cost_pivot.wac_cost_amount
    - store_drug_cost_pivot.wac_cost_amount
    filters:
      drug_cost_pivot.drug_cost_region: NOT NULL
      host_vs_pharmacy_comp.drug_acq_cost_different_flag: Y
      store.store_number: ''
    sorts:
    - store.store_number
    - drug_cost_pivot.drug_cost_region
    - drug.drug_name
    limit: 500
    column_limit: 50
    show_view_names: true
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
    row: 32
    col: 0
    width: 24
    height: 8
  - name: Inventory - Host Vs Store - ANY Flag different comparison
    title: Inventory - Host Vs Store - ANY Flag different comparison
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: looker_column
    fields:
    - store.store_number
    - drug.count
    filters:
      drug_cost.region: "-NULL"
      store.store_number: ''
    sorts:
    - drug.count desc
    limit: 500
    column_limit: 50
    filter_expression: |-
      ${host_vs_pharmacy_comp.drug_cost_file_any_flag_different}="Y"
      OR ${host_vs_pharmacy_comp.drug_file_any_flag_different}="Y"
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
    row: 40
    col: 0
    width: 24
    height: 8
  - name: Inventory - Host vs Store Drug ACQ Cost Amount Different by NDC with Store
      Count
    title: Inventory - Host vs Store Drug ACQ Cost Amount Different by NDC with Store
      Count
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - drug_cost.region
    - store.count
    - drug.drug_ndc
    - drug.drug_name
    filters:
      drug_cost.region: "-NULL"
      host_vs_pharmacy_comp.drug_acq_cost_different_flag: Y
    sorts:
    - store.count desc
    limit: 500
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
    row: 48
    col: 0
    width: 24
    height: 8
  - name: Sales - Inventory - Host vs Store Drug NDC with Dispensed Scripts ACQ Cost
      Difference
    title: Sales - Inventory - Host vs Store Drug NDC with Dispensed Scripts ACQ Cost
      Difference
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - drug_cost.region
    - store.count
    - drug.drug_ndc
    - drug.drug_name
    filters:
      drug_cost.region: "-NULL"
      host_vs_pharmacy_comp.drug_acq_cost_different_flag: Y
      sales.history_filter: 'YES'
      report_calendar_global.report_period_filter: 1 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.date_to_use_filter: REPORTABLE SALES
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.show_after_sold_measure_values: 'NO'
    sorts:
    - store.count desc
    limit: 500
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
    row: 56
    col: 0
    width: 24
    height: 8
  - name: Inventory - Host vs Store ACQ Cost Difference > 10% variance  detail
    title: Inventory - Host vs Store ACQ Cost Difference > 10% variance  detail
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: table
    fields:
    - drug.drug_name
    - drug.drug_ndc
    - drug_cost.region
    - drug_cost_pivot.acq_cost_amount
    - store_drug_cost_pivot.acq_cost_amount
    - store_drug.drug_full_name
    - store_drug.ndc
    - store.count
    filters:
      drug_cost.region: "-NULL"
      host_vs_pharmacy_comp.drug_acq_cost_different_flag: Y
    sorts:
    - store.count desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: variance_store_vs_host
      label: Variance - store vs host
      expression: "${store_drug_cost_pivot.acq_cost_amount}-${drug_cost_pivot.acq_cost_amount}"
      value_format:
      value_format_name: usd
      _kind_hint: dimension
    filter_expression: "(abs(${store_drug_cost_pivot.acq_cost_amount}-${drug_cost_pivot.acq_cost_amount}))/${drug_cost_pivot.acq_cost_amount}\
      \ > 0.1"
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
    series_types: {}
    row: 64
    col: 0
    width: 24
    height: 8
  - name: Inventory - Host vs Store - Data Difference Flag Grid by Drug NDC
    title: Inventory - Host vs Store - Data Difference Flag Grid by Drug NDC
    model: PDX_CUSTOMER_DSS
    explore: inventory
    type: looker_column
    fields:
    - drug.drug_name
    - drug.drug_ndc
    - drug_cost.region
    - store.count
    - host_vs_pharmacy_comp.drug_name_different_flag
    - host_vs_pharmacy_comp.drug_package_size_different_flag
    - host_vs_pharmacy_comp.drug_integer_pack_different_flag
    - host_vs_pharmacy_comp.drug_ind_container_pack_different_flag
    - host_vs_pharmacy_comp.drug_packs_per_container_different_flag
    - host_vs_pharmacy_comp.drug_discontinue_date_different_flag
    - host_vs_pharmacy_comp.drug_immunization_flag_different_flag
    - host_vs_pharmacy_comp.drug_acq_cost_different_flag
    - host_vs_pharmacy_comp.drug_awp_cost_different_flag
    - host_vs_pharmacy_comp.drug_wac_cost_different_flag
    - host_vs_pharmacy_comp.drug_mac_cost_different_flag
    - host_vs_pharmacy_comp.drug_reg_cost_different_flag
    - host_vs_pharmacy_comp.drug_wel_cost_different_flag
    - host_vs_pharmacy_comp.drug_340b_cost_different_flag
    - host_vs_pharmacy_comp.drug_dp_cost_different_flag
    filters:
      drug_cost.region: "-NULL"
      host_vs_pharmacy_comp.drug_acq_cost_different_flag: Y
    sorts:
    - store.count desc
    limit: 500
    column_limit: 50
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
    row: 72
    col: 0
    width: 24
    height: 8

- dashboard: edx_tmpl_chain_workflow_time_measurements
  title: Dashboard- Workflow Time Measurements
  layout: newspaper
  elements:
  - name: 'Workflow: Timings: Prescription Time to WC Arrival (Same Day Scripts) -
      TY/LY Last 13 Weeks'
    title: 'Workflow: Timings: Prescription Time to WC Arrival (Same Day Scripts)
      - TY/LY Last 13 Weeks'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_rx_tx.median_fill_duration
    - eps_rx_tx.min_fill_duration
    - eps_rx_tx.avg_fill_duration
    - eps_rx_tx.max_fill_duration
    - eps_rx_tx.will_call_arrival_year
    - store_alignment.division
    pivots:
    - eps_rx_tx.will_call_arrival_year
    fill_fields:
    - eps_rx_tx.will_call_arrival_year
    filters:
      eps_rx_tx.rx_tx_fill_location: Local Pharmacy
      eps_rx_tx.will_call_arrival_date: 13 weeks ago for 13 weeks, 75 weeks ago for
        13 weeks
    sorts:
    - eps_rx_tx.will_call_arrival_year desc 0
    - store_alignment.division
    limit: 500
    column_limit: 50
    filter_expression: "(${eps_rx_tx.rx_tx_reportable_sales_date} = ${eps_rx_refill_received_to_will_call.rx_refill_wc_arrival_date})"
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
      Pharmacy Number: store.store_number
    row: 5
    col: 0
    width: 24
    height: 5
  - name: 'Workflow: Timings: Prescription Time Spent in WC (Same Day Processed Scripts)
      - TY/LY Last 13 Weeks'
    title: 'Workflow: Timings: Prescription Time Spent in WC (Same Day Processed Scripts)
      - TY/LY Last 13 Weeks'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_rx_tx.will_call_arrival_year
    - eps_rx_tx.median_time_in_will_call
    - eps_rx_tx.min_time_in_will_call
    - eps_rx_tx.avg_time_in_will_call
    - eps_rx_tx.max_time_in_will_call
    - store_alignment.division
    pivots:
    - eps_rx_tx.will_call_arrival_year
    fill_fields:
    - eps_rx_tx.will_call_arrival_year
    filters:
      eps_rx_tx.rx_tx_fill_location: Local Pharmacy
      eps_rx_tx.will_call_arrival_date: 13 weeks ago for 13 weeks, 75 weeks ago for
        13 weeks
    sorts:
    - eps_rx_tx.will_call_arrival_year desc 0
    - store_alignment.division
    limit: 500
    column_limit: 50
    filter_expression: "(${eps_rx_tx.rx_tx_reportable_sales_date} = ${eps_rx_refill_received_to_will_call.rx_refill_wc_arrival_date})"
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
      Pharmacy Number: store.store_number
    row: 10
    col: 0
    width: 24
    height: 5
  - name: 'Workflow: Timings: Task History Time (Same Day Scripts) - TY/LY Last 13
      Weeks'
    title: 'Workflow: Timings: Task History Time (Same Day Scripts) - TY/LY Last 13
      Weeks'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_task_history_task_time.median_task_time
    - eps_task_history_task_time.min_task_time
    - eps_task_history_task_time.avg_task_time
    - eps_task_history_task_time.max_task_time
    - eps_rx_tx.will_call_arrival_year
    - store_alignment.division
    pivots:
    - eps_rx_tx.will_call_arrival_year
    fill_fields:
    - eps_rx_tx.will_call_arrival_year
    filters:
      eps_rx_tx.rx_tx_fill_location: Local Pharmacy
      eps_rx_tx.will_call_arrival_date: 13 weeks ago for 13 weeks, 75 weeks ago for
        13 weeks
    sorts:
    - eps_rx_tx.will_call_arrival_year desc 0
    - store_alignment.division
    limit: 500
    column_limit: 50
    filter_expression: "(${eps_rx_tx.rx_tx_reportable_sales_date} = ${eps_rx_refill_received_to_will_call.rx_refill_wc_arrival_date})"
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
      Pharmacy Number: store.store_number
    row: 15
    col: 0
    width: 24
    height: 5
  - name: 'Workflow: Timings: GAP Time Core Tasks (Same Day Scripts) - TY/LY Last
      13 Weeks'
    title: 'Workflow: Timings: GAP Time Core Tasks (Same Day Scripts) - TY/LY Last
      13 Weeks'
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_rx_tx.will_call_arrival_year
    - eps_task_history_gap_time_per_refill.avg_de_dv_gap_time
    - eps_task_history_gap_time_per_refill.avg_dv_fill_gap_time
    - eps_task_history_gap_time_per_refill.avg_fill_pv_gap_time
    - eps_task_history_gap_time_per_refill.avg_oe_de_gap_time
    - store_alignment.division
    pivots:
    - eps_rx_tx.will_call_arrival_year
    fill_fields:
    - eps_rx_tx.will_call_arrival_year
    filters:
      eps_rx_tx.rx_tx_fill_location: Local Pharmacy
      eps_rx_tx.will_call_arrival_date: 13 weeks ago for 13 weeks, 75 weeks ago for
        13 weeks
    sorts:
    - eps_rx_tx.will_call_arrival_year desc
    limit: 500
    column_limit: 50
    filter_expression: "(${eps_rx_tx.rx_tx_reportable_sales_date} = ${eps_rx_refill_received_to_will_call.rx_refill_wc_arrival_date})"
    show_view_names: false
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
      Pharmacy Number: store.store_number
    row: 0
    col: 0
    width: 24
    height: 5
  filters:
  - name: Pharmacy Number
    title: Pharmacy Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store.store_number

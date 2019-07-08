- dashboard: edx_tmpl_chain_workflow
  title: Dashboard - Workflow
  layout: newspaper
  elements:
  - name: Workflow - Will Call Bin Report - Chain (EPS Only)
    title: Workflow - Will Call Bin Report - Chain (EPS Only)
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: table
    fields:
    - eps_rx_tx.active_count
    - eps_rx_tx.sum_price
    - store.count
    - chain.chain_name
    filters:
      eps_rx_tx.rx_tx_active: 'Yes'
      eps_rx_tx.start_date: ''
      eps_rx_tx.will_call_arrival: 'Yes'
      eps_rx_tx.rx_tx_will_call_picked_up: 'No'
    sorts:
    - eps_rx_tx.active_count desc
    limit: 5000
    column_limit: 50
    dynamic_fields:
    - table_calculation: avg_scripts_in_will_call
      label: Avg Scripts in Will Call
      expression: "${eps_rx_tx.active_count}/${store.count}"
      value_format:
      value_format_name: decimal_0
    - table_calculation: avg_price_per_script_in_will_call
      label: Avg Price per Script in Will Call
      expression: "${eps_rx_tx.sum_price}/${eps_rx_tx.active_count}"
      value_format:
      value_format_name: usd_0
    query_timezone: America/Chicago
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    note_state: collapsed
    note_display: below
    note_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Workflow - PV Tasks per Hour Single Day
    title: Workflow - PV Tasks per Hour Single Day
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    - eps_task_history.count
    pivots:
    - eps_task_history.task_history_user_employee_number
    filters:
      eps_line_item.line_item_type: "-AUTO TRANSFER"
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: ''
      eps_task_history.task_history_task_action: COMPLETE
      eps_task_history.task_history_action_current_date: 1 days ago for 1 days
      eps_task_history.task_history_task_name: PRODUCT^_VERIFICATION
    sorts:
    - eps_task_history.task_history_demo_user_employee_number
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    limit: 500
    column_limit: 50
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - bi_demo_region.district
    - bi_demo_store.store_number
    - eps_task_history.task_history_demo_user_employee_number
    series_labels:
      2961a8655ded6767da169325182a4ee1cf54ab6704b13dd312d446ac23799ad9 - Task History Task History Count: RPH
        2
      a22686aa786bc90eb6af496a1750216062b3842ad4882dc5efcb48ab272f2c56 - Task History Task History Count: RPH
        4
      bb5d1a3cb1cf30b4ead18cc7c04c3a22eaabbefedf810ab0a8d46de6d263deaf - Task History Task History Count: RPH
        5
      1ca043968320b0da0fc6bb0cbdeb9c8a15f427918c0d3415b1baff02e217cbc5 - Task History Task History Count: RPH
        1
      716439e16a9b6562961bfb3063a8e4828392da9eb7193aaed9633a595e813e03 - Task History Task History Count: RPH
        3
      cc47f6ed9cb9a3e5d46e9c3397d05ef91b81ac7bc1b43541647258f0a220f1fd - Task History Task History Count: RPH
        1
    y_axis_unpin: false
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 14
    col: 12
    width: 12
    height: 6
  - name: Workflow - DV Tasks per Hour Single Day
    title: Workflow - DV Tasks per Hour Single Day
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.count
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    pivots:
    - eps_task_history.task_history_user_employee_number
    filters:
      eps_line_item.line_item_type: "-AUTO TRANSFER"
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: ''
      eps_task_history.task_history_task_action: COMPLETE
      eps_task_history.task_history_action_current_date: 1 days ago for 1 days
      eps_task_history.task_history_task_name: DATA^_VERIFICATION
    sorts:
    - eps_task_history.task_history_demo_user_employee_number
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    limit: 500
    column_limit: 50
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - bi_demo_region.district
    - bi_demo_store.store_number
    - eps_task_history.task_history_demo_user_employee_number
    series_labels:
      2961a8655ded6767da169325182a4ee1cf54ab6704b13dd312d446ac23799ad9 - Task History Task History Count: RPH
        2
      a22686aa786bc90eb6af496a1750216062b3842ad4882dc5efcb48ab272f2c56 - Task History Task History Count: RPH
        4
      bb5d1a3cb1cf30b4ead18cc7c04c3a22eaabbefedf810ab0a8d46de6d263deaf - Task History Task History Count: RPH
        5
      1ca043968320b0da0fc6bb0cbdeb9c8a15f427918c0d3415b1baff02e217cbc5 - Task History Task History Count: RPH
        1
      716439e16a9b6562961bfb3063a8e4828392da9eb7193aaed9633a595e813e03 - Task History Task History Count: RPH
        3
      cc47f6ed9cb9a3e5d46e9c3397d05ef91b81ac7bc1b43541647258f0a220f1fd - Task History Task History Count: RPH
        1
    y_axis_unpin: false
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 14
    col: 0
    width: 12
    height: 6
  - name: Workflow - RPH Counseling Tasks per Hour Single Day
    title: Workflow - RPH Counseling Tasks per Hour Single Day
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.count
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    pivots:
    - eps_task_history.task_history_user_employee_number
    filters:
      eps_line_item.line_item_type: "-AUTO TRANSFER"
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: ''
      eps_task_history.task_history_task_action: COMPLETE
      eps_task_history.task_history_action_current_date: 1 days ago for 1 days
      eps_task_history.task_history_task_name: RPH^_COUNSELING
    sorts:
    - eps_task_history.task_history_demo_user_employee_number
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    limit: 500
    column_limit: 50
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - bi_demo_region.district
    - bi_demo_store.store_number
    - eps_task_history.task_history_demo_user_employee_number
    series_labels:
      2961a8655ded6767da169325182a4ee1cf54ab6704b13dd312d446ac23799ad9 - Task History Task History Count: RPH
        2
      a22686aa786bc90eb6af496a1750216062b3842ad4882dc5efcb48ab272f2c56 - Task History Task History Count: RPH
        4
      bb5d1a3cb1cf30b4ead18cc7c04c3a22eaabbefedf810ab0a8d46de6d263deaf - Task History Task History Count: RPH
        5
      1ca043968320b0da0fc6bb0cbdeb9c8a15f427918c0d3415b1baff02e217cbc5 - Task History Task History Count: RPH
        1
      716439e16a9b6562961bfb3063a8e4828392da9eb7193aaed9633a595e813e03 - Task History Task History Count: RPH
        3
      '013184f6bfd0409d2aa5245c03afe20d3fd4758db787531ad1a5184c542dc3fb - Task History Task History Count': RPH
        1
      5b2b2fa70f08903dd64ef25acbc1cff2edeafc942f6161a38bf568ffa0c9b907 - Task History Task History Count: RPH
        2
      961152ea664bd93afbd586759b14ae843505031cedf1acaf92fde3f195cf2566 - Task History Task History Count: RPH
        2
    y_axis_unpin: false
    hidden_series: []
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 27
    col: 0
    width: 24
    height: 12
  - name: Workflow - Return to Stock from Will Call - Last 90 Days
    title: Workflow - Return to Stock from Will Call - Last 90 Days
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_line
    fields:
    - eps_rx_tx.return_to_stock_count
    - eps_rx_tx.active_count
    - eps_rx_tx.return_to_stock_sales
    - eps_rx_tx.sum_price
    - eps_rx_tx.rx_tx_fill_month
    - chain.chain_name
    - store.count
    filters:
      eps_rx_tx.rx_tx_fill_date: 90 days
      eps_rx_tx.start_date: ''
      eps_rx_tx.rx_tx_fill_location: ''
    sorts:
    - eps_rx_tx.rx_tx_fill_month desc
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
    hidden_fields:
    - chain.chain_name
    - store.count
    - eps_rx_tx.return_to_stock_count
    - eps_rx_tx.active_count
    - eps_rx_tx.return_to_stock_sales
    - eps_rx_tx.sum_price
    - bi_demo_store.count
    - bi_demo_chain.chain_name
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 6
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    y_axis_labels:
    - Percent Scripts
    - Percent Sales
    colors:
    - 'palette: Looker Classic'
    limit_displayed_rows: false
    y_axis_orientation:
    - left
    - right
    y_axis_value_format: 0.00%
    y_axis_min: []
    y_axis_max: []
    x_padding_left: 40
    x_padding_right: 40
    y_axis_unpin: true
    hidden_series:
    - return_to_stock_of_sales
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 9
    col: 0
    width: 12
    height: 5
  - name: Workflow - Average Task Duration - Last 60 days (EPS Only)
    title: Workflow - Average Task Duration - Last 60 days (EPS Only)
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.task_history_task_name
    - eps_task_history_task_time.avg_task_time
    - eps_task_history_task_time.median_task_time
    filters:
      eps_rx_tx.start_date: 60 days
      eps_rx_tx.rx_tx_tx_status: ''
      eps_task_history.task_history_task_name: DATA^_ENTRY,DATA^_VERIFICATION,FILL,PRODUCT^_VERIFICATION,WILL^_CALL
    sorts:
    - eps_task_history.task_history_task_name
    - eps_rx_tx.rx_tx_tx_status__sort_
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    hidden_fields: []
    show_x_axis_label: true
    show_x_axis_ticks: true
    show_view_names: false
    show_value_labels: true
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    note_state: collapsed
    note_display: hover
    note_text: ''
    row: 2
    col: 0
    width: 12
    height: 7
  - name: Workflow - DE Tasks per Hour Single Day
    title: Workflow - DE Tasks per Hour Single Day
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.count
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    pivots:
    - eps_task_history.task_history_user_employee_number
    filters:
      eps_line_item.line_item_type: "-AUTO TRANSFER"
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: ''
      eps_task_history.task_history_task_action: COMPLETE
      eps_task_history.task_history_action_current_date: 1 days ago for 1 days
      eps_task_history.task_history_task_name: DATA^_ENTRY,ESCRIPT^_DATA^_ENTRY
    sorts:
    - eps_task_history.task_history_demo_user_employee_number
    - eps_task_history.task_history_action_current_hour_of_day
    - eps_task_history.task_history_user_employee_number
    limit: 500
    column_limit: 50
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - eps_task_history.task_history_demo_user_employee_number
    series_labels:
      2961a8655ded6767da169325182a4ee1cf54ab6704b13dd312d446ac23799ad9 - Task History Task History Count: RPH
        2
      a22686aa786bc90eb6af496a1750216062b3842ad4882dc5efcb48ab272f2c56 - Task History Task History Count: RPH
        4
      bb5d1a3cb1cf30b4ead18cc7c04c3a22eaabbefedf810ab0a8d46de6d263deaf - Task History Task History Count: RPH
        5
      1ca043968320b0da0fc6bb0cbdeb9c8a15f427918c0d3415b1baff02e217cbc5 - Task History Task History Count: RPH
        1
      716439e16a9b6562961bfb3063a8e4828392da9eb7193aaed9633a595e813e03 - Task History Task History Count: RPH
        3
      cc47f6ed9cb9a3e5d46e9c3397d05ef91b81ac7bc1b43541647258f0a220f1fd - Task History Task History Count: RPH
        1
      '013184f6bfd0409d2aa5245c03afe20d3fd4758db787531ad1a5184c542dc3fb - Task History Task History Count': Tech
        1
      5b2b2fa70f08903dd64ef25acbc1cff2edeafc942f6161a38bf568ffa0c9b907 - Task History Task History Count: Tech
        2
      9adbd2868b335702c9e3de91fbb4e346dc1c1695904a68a723ff7bf023133644 - Task History Task History Count: Tech
        3
    y_axis_unpin: false
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 20
    col: 0
    width: 24
    height: 7
  - name: Workflow - DV Efficiency - Outliers
    title: Workflow - DV Efficiency - Outliers
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_column
    fields:
    - eps_task_history.count
    - eps_rx_tx.count
    - store.store_number
    filters:
      store.store_number: ''
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.start_date: 1 months
      eps_task_history.task_history_task_name: DATA^_VERIFICATION
      eps_task_history.task_history_status: NULL,COMPLETE
    sorts:
    - dv_outlier desc 0
    - dv_per_fill desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: dv_per_fill
      label: DV per Fill
      expression: "${eps_task_history.count}/${eps_rx_tx.count}"
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
    - table_calculation: sd
      label: SD
      expression: stddev_samp(${dv_per_fill})
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
    - table_calculation: dv_outlier
      label: DV Outlier
      expression: "(abs(${dv_per_fill} - median(${dv_per_fill}))) > (${sd} *2)"
      value_format:
      value_format_name:
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
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: circle
    series_types: {}
    hidden_fields:
    - eps_task_history.count
    - eps_rx_tx.count
    - chain.chain_name
    - sd
    - dv_outlier
    hidden_series: []
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_points_if_no:
    - dv_outlier
    listen:
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 9
    col: 12
    width: 12
    height: 5
  - name: Workflow - Prescription Volume Distribution By Pick Up Type - Last 90 days
    title: Workflow - Prescription Volume Distribution By Pick Up Type - Last 90 days
    model: PDX_CUSTOMER_DSS
    explore: eps_workflow_order_entry_rx_tx
    type: looker_bar
    fields:
    - eps_order_entry.order_entry_pickup_type_id
    - chain.chain_name
    - eps_rx_tx.active_count
    pivots:
    - eps_order_entry.order_entry_pickup_type_id
    filters:
      eps_order_entry.order_entry_pickup_type_id: "-NOT SPECIFIED"
      eps_rx_tx.rx_tx_fill_location: ''
      eps_rx_tx.rx_tx_will_call_picked_up_date: 90 days
    sorts:
    - chain.chain_name
    - eps_order_entry.order_entry_pickup_type_id
    - eps_order_entry.order_entry_pickup_type_id__sort_
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: of_fill
      label: "% of Fill"
      expression: "(${eps_rx_tx.active_count})/sum(pivot_row(${eps_rx_tx.active_count}))"
      value_format:
      value_format_name: percent_2
    - table_calculation: total_fill_count
      label: Total Fill Count
      expression: sum(pivot_row(${eps_rx_tx.active_count}))
      value_format:
      value_format_name: decimal_0
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    hidden_fields:
    - total_fill_count
    - eps_rx_tx.active_count
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 2
    col: 12
    width: 12
    height: 7
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
    listen:
      Pharmacy Number: store.store_number
      Chain ID: chain.chain_id
      Workflow Enabled: store.workflow_enabled_flag
    row: 39
    col: 0
    width: 24
    height: 8
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
  - name: Workflow Enabled
    title: Workflow Enabled
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: PDX_CUSTOMER_DSS
    explore: store
    listens_to_filters: []
    field: store.workflow_enabled_flag

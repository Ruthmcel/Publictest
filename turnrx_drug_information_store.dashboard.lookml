- dashboard: turnrx_drug_information_store
  title: TurnRx Drug Information Store
  layout: newspaper
  embed_style:
    background_color: "#f6f8fa"
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Drug Information (Store)
    name: Drug Information (Store)
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    type: looker_line
    fields: [turnrx_store_drug_inventory_mvmnt_snapshot.activity_date, turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity,
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_ending_on_hand,
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_reorder_primary_level_order_point]
    fill_fields: [turnrx_store_drug_inventory_mvmnt_snapshot.activity_date]
    filters:
      turnrx_store_drug_inventory_mvmnt_snapshot.activity_date: 126 days ago for 126
        days
      chain.chain_id: ''
    sorts: [turnrx_store_drug_inventory_mvmnt_snapshot.activity_date desc]
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity: "#929292"
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_reorder_primary_level_order_point: "#00588f"
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_ending_on_hand: "#a2dcf3"
    series_labels:
      turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity: Net
        Fill Quantity
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_ending_on_hand: Quantity
        On Hand
      turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_reorder_primary_level_order_point: Order
        Point
    series_types:
      turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity: column
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity,
            name: Fill Quantity, axisId: turnrx_store_drug_inventory_mvmnt_snapshot.net_store_drug_inventory_fill_quantity},
          {id: turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_ending_on_hand,
            name: Quantity On Hand, axisId: turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_ending_on_hand},
          {id: turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_reorder_primary_level_order_point,
            name: Order Point, axisId: turnrx_store_drug_inventory_mvmnt_snapshot.sum_store_drug_inventory_reorder_primary_level_order_point}],
        showLabels: true, showValues: true, valueFormat: "#,##0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      nhin_store_id: store.nhin_store_id
      NDC: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc
    row: 2
    col: 0
    width: 24
    height: 7
  - title: Drug Name
    name: Drug Name
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    type: single_value
    fields: [turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_inventory_drug_unique_name]
    filters:
      turnrx_store_drug_inventory_mvmnt_snapshot.activity_date: 126 days ago for 126
        days
      chain.chain_id: ''
    sorts: [turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_inventory_drug_unique_name]
    limit: 500
    custom_color_enabled: true
    custom_color: "#00588f"
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      nhin_store_id: store.nhin_store_id
      NDC: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc
    row: 0
    col: 0
    width: 24
    height: 1
  filters:
  - name: nhin_store_id
    title: nhin_store_id
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    listens_to_filters: [NDC]
    field: store.nhin_store_id
  - name: NDC
    title: NDC
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    listens_to_filters: [nhin_store_id]
    field: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc

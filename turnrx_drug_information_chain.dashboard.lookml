- dashboard: turnrx_drug_information_chain
  title: TurnRx Drug Information Chain
  layout: newspaper
  embed_style:
    background_color: ''
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Drug Information Chain
    name: Drug Information Chain
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    type: looker_line
    fields:
    - turnrx_store_drug_inventory_mvmnt_snapshot.activity_week
    - turnrx_store_drug_inventory_mvmnt_snapshot.dispensed_acq_cost
    - turnrx_store_drug_inventory_mvmnt_snapshot.week_ending_inventory_value
    fill_fields:
    - turnrx_store_drug_inventory_mvmnt_snapshot.activity_week
    filters:
      turnrx_store_drug_inventory_mvmnt_snapshot.activity_date: 18 weeks ago for 18
        weeks
    sorts:
    - turnrx_store_drug_inventory_mvmnt_snapshot.activity_week
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
      turnrx_store_drug_inventory_mvmnt_snapshot.dispensed_acq_cost: "#00588F"
      turnrx_store_drug_inventory_mvmnt_snapshot.week_ending_inventory_value: "#FABA8B"
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: turnrx_store_drug_inventory_mvmnt_snapshot.dispensed_acq_cost
        name: Dispensed Acquisition Cost
        axisId: turnrx_store_drug_inventory_mvmnt_snapshot.dispensed_acq_cost
      showLabels: false
      showValues: true
      valueFormat: "$#,##0"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
    - label:
      orientation: right
      showLabels: false
      showValues: true
      valueFormat: "#,##0"
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
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
    x_axis_label_rotation: -45
    show_null_points: true
    interpolation: linear
    listen:
      NDC: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc
    title_hidden: true
    row: 2
    col: 0
    width: 24
    height: 7
  - title: Drug Name
    name: Drug Name
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    type: single_value
    fields:
    - turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_inventory_drug_unique_name
    filters:
      turnrx_store_drug_inventory_mvmnt_snapshot.activity_date: 126 days ago for 126
        days
    sorts:
    - turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_inventory_drug_unique_name
    limit: 500
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: "#00588f"
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: 'true'
    series_types: {}
    listen:
      NDC: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc
    row: 0
    col: 0
    width: 24
    height: 1
  filters:
  - name: NDC
    title: NDC
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: CIS
    explore: turnrx_store_drug_inventory_mvmnt_snapshot
    listens_to_filters: []
    field: turnrx_store_drug_inventory_mvmnt_snapshot.store_drug_ndc

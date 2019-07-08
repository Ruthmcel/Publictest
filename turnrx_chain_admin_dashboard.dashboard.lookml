- dashboard: chain_admin_dashboard
  title: Chain Admin Dashboard
  layout: newspaper
  embed_style:
    background_color: ''
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Transfers Received by Category
    name: Transfers Received by Category
    model: CIS
    explore: turnrx_transfer_store_to_store_task
    type: looker_area
    fields: [turnrx_transfer_store_to_store_task.sending_store_transfer_initiated_reason,
      turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount, turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date]
    pivots: [turnrx_transfer_store_to_store_task.sending_store_transfer_initiated_reason]
    filters:
      chain.chain_id: ''
      turnrx_transfer_invoice.transfer_invoice_receiving_store_received_timestamp_date: NOT
        NULL
      turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT NULL
      turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_week: 14 weeks
    sorts: [turnrx_transfer_store_to_store_task.sending_store_transfer_initiated_reason
        0, turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date]
    limit: 500
    column_limit: 50
    stacking: ''
    trellis: ''
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      custom:
        id: 0d54e2f6-7106-e9e6-2806-a5c68188a1b1
        label: Custom
        type: discrete
        colors:
        - "#38b7e0"
        - "#a2dcf3"
        - "#1f78b4"
        - "#00588f"
        - "#e2e2e2"
        - "#929292"
        - "#a3a3a3"
        - "#ffd943"
        - "#28c6de"
        - "#008272"
        - "#faba8b"
        - "#b74d51"
        - "#5f4728"
        - "#ff9498"
        - "#fc9200"
      options:
        steps: 5
        reverse: false
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_colors:
      DEAD INVENTORY - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#00588f"
      FRAGMENTED - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#fc9200"
      OVERSTOCK - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#b84c4e"
    series_types:
      DEAD INVENTORY - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: line
      OVERSTOCK - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: line
    series_point_styles: {}
    limit_displayed_rows: false
    hidden_series: []
    y_axes: [{label: '', orientation: left, series: [{id: DEAD INVENTORY - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: DEAD INVENTORY, axisId: turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount},
          {id: FRAGMENTED - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: FRAGMENTED, axisId: turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount},
          {id: OVERSTOCK - turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: OVERSTOCK, axisId: turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount}],
        showLabels: true, showValues: true, valueFormat: "$#,##0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Report Period Week End
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_label_rotation: -45
    show_null_points: true
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labPer
    listen: {}
    row: 0
    col: 0
    width: 12
    height: 9
  - name: Transfers Invoice Value - Created vs Received Trend
    title: Transfers Invoice Value - Created vs Received Trend
    merged_queries:
    - model: CIS
      explore: turnrx_transfer_store_to_store_task
      type: table
      fields: [turnrx_transfer_invoice.edw_last_update_week_end_date, turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount]
      filters:
        turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT
          NULL
        turnrx_transfer_invoice.transfer_invoice_status: PENDING,SHIPPED
        turnrx_transfer_invoice.edw_last_update_week_end_date: 14 weeks
      sorts: [turnrx_transfer_invoice.edw_last_update_week_end_date]
      limit: 500
      query_timezone: America/Chicago
      join_fields: []
    - model: CIS
      explore: turnrx_transfer_store_to_store_task
      type: table
      fields: [turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
        turnrx_transfer_invoice.edw_last_update_week_end_date]
      filters:
        turnrx_transfer_invoice.transfer_invoice_status: DECLINED,EXPIRED
        turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT
          NULL
        turnrx_transfer_invoice.edw_last_update_week_end_date: 14 weeks
      sorts: [turnrx_transfer_invoice.edw_last_update_week_end_date]
      limit: 500
      query_timezone: America/Chicago
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      subtotals_at_bottom: false
      hide_totals: false
      hide_row_totals: false
      series_labels:
        turnrx_transfer_invoice.edw_last_update_week_end_date: Report Period Week
          End Date
      table_theme: editable
      limit_displayed_rows: false
      enable_conditional_formatting: false
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false
      join_fields:
      - source_field_name: turnrx_transfer_invoice.edw_last_update_week_end_date
        field_name: turnrx_transfer_invoice.edw_last_update_week_end_date
    - model: CIS
      explore: turnrx_transfer_store_to_store_task
      type: table
      fields: [turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date,
        turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount]
      filters:
        turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT
          NULL
        turnrx_transfer_invoice.transfer_invoice_status: RECEIVED,DISPUTED
        turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date: 14
          weeks
      sorts: [turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date]
      limit: 500
      query_timezone: America/Chicago
      join_fields:
      - source_field_name: turnrx_transfer_invoice.edw_last_update_week_end_date
        field_name: turnrx_transfer_invoice.transfer_invoice_receiving_store_received_week_end_date
    stacking: ''
    trellis: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: circle_outline
    series_colors:
      turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#A3A3A3"
      q2_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#FFD943"
      q1_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: "#00588F"
    series_labels:
      turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: Transfers
        Pending or Shipping
      q1_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: Transfers
        Declined or Expired
      q2_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: Transfers
        Received
    series_types:
      turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: line
      q1_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: line
      q2_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount: line
    limit_displayed_rows: false
    y_axes: [{label: Total Transfer Invoice Drug Dollar Amount, orientation: left,
        series: [{id: turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: Transfers Declined or Expired, axisId: turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount},
          {id: q1_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: Transfers Pending or Shipping, axisId: q1_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount},
          {id: q2_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount,
            name: Transfers Received, axisId: q2_turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount}],
        showLabels: true, showValues: true, valueFormat: "$#,##0", unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Report Period Week End Date
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
    type: looker_area
    sorts: [turnrx_transfer_invoice.edw_last_update_week_end_date]
    row: 0
    col: 12
    width: 12
    height: 9
  - title: Transfers Declined or Expired - Top 10 Retail Pharmacies
    name: Transfers Declined or Expired - Top 10 Retail Pharmacies
    model: CIS
    explore: turnrx_transfer_store_to_store_task
    type: looker_bar
    fields: [sending_store_alignment.store_number, turnrx_transfer_invoice.count]
    filters:
      turnrx_transfer_invoice.edw_last_update_timestamp_date: 126 days
      turnrx_transfer_invoice.transfer_invoice_status: DECLINED,EXPIRED
      turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT NULL
      chain.chain_id: ''
    sorts: [turnrx_transfer_invoice.count desc]
    limit: 10
    column_limit: 50
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 11add396-e3fd-4f12-88f0-96af217167ef
      custom:
        id: 742a01fb-b067-ea17-02cf-9b8df32cc883
        label: Custom
        type: discrete
        colors:
        - "#38b7e0"
        - "#a2dcf3"
        - "#1f78b4"
        - "#00588f"
        - "#e2e2e2"
        - "#929292"
        - "#a3a3a3"
        - "#FFD943"
        - "#28C6DE"
        - "#008272"
        - "#FABA8B"
        - "#B74D51"
        - "#5F4728"
        - "#FF9498"
        - "#FC9200"
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      turnrx_transfer_invoice.count: "#00588f"
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Store Number
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
    listen: {}
    row: 9
    col: 0
    width: 12
    height: 9
  - title: Transfers Received w/ Dispute - Top 10 Retail Pharmacies
    name: Transfers Received w/ Dispute - Top 10 Retail Pharmacies
    model: CIS
    explore: turnrx_transfer_store_to_store_task
    type: looker_bar
    fields: [receiving_store_alignment.store_number, turnrx_transfer_invoice.count]
    filters:
      chain.chain_id: ''
      turnrx_transfer_invoice.edw_last_update_timestamp_date: 126 days
      turnrx_transfer_invoice.transfer_invoice_status: DISPUTED
      turnrx_transfer_invoice.transfer_invoice_receiving_store_received_timestamp_date: NOT
        NULL
      turnrx_transfer_invoice.transfer_invoice_sent_to_store_timestamp_date: NOT NULL
    sorts: [turnrx_transfer_invoice.count desc]
    limit: 10
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 11add396-e3fd-4f12-88f0-96af217167ef
      custom:
        id: 38bbb325-9644-8a08-4c6e-71c5d83eb404
        label: Custom
        type: discrete
        colors:
        - "#38b7e0"
        - "#a2dcf3"
        - "#1f78b4"
        - "#00588f"
        - "#e2e2e2"
        - "#929292"
        - "#a3a3a3"
        - "#FFD943"
        - "#28C6DE"
        - "#008272"
        - "#FABA8B"
        - "#B74D51"
        - "#5F4728"
        - "#FF9498"
        - "#FC9200"
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      turnrx_transfer_invoice.count: "#FABA8B"
    series_types: {}
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: bottom, series: [{id: turnrx_transfer_invoice.count,
            name: Total Transfer Invoice Count, axisId: turnrx_transfer_invoice.count}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 13, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Store Number
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
    listen: {}
    row: 9
    col: 12
    width: 12
    height: 9

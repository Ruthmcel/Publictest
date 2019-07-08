- dashboard: ar_business_mix_dashboard
  title: Business Mix Dashboard
  layout: newspaper
  elements:
  - name: BUSINESS MIX PERFORMANCE
    type: text
    title_text: BUSINESS MIX PERFORMANCE
    subtitle_text: ''
    body_text: This is a dashboard to measure PBM Performance based on business mix
      for the period selected.
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Customer (copy)
    title: Customer (copy)
    model: ABSOLUTE_AR
    explore: ar_store
    type: single_value
    fields:
    - ar_chain.chain_name
    sorts:
    - ar_chain.chain_name
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    custom_color_enabled: true
    custom_color: "#22668b"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
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
    series_labels: {}
    comparison_label: Customer
    single_value_title: Customer
    listen: {}
    row: 2
    col: 0
    width: 9
    height: 4
  - name: Contract Coverage % (copy 4)
    title: Contract Coverage % (copy 4)
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: single_value
    fields:
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_claim_with_network_name
    - ar_carrier_performance.contract_rate_network_name
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
    sorts:
    - ar_carrier_performance.sum_claim desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: contract_coverage
      label: Contract Coverage %
      expression: sum(${ar_carrier_performance.sum_claim_with_network_name})/sum(${ar_carrier_performance.sum_claim})
      value_format:
      value_format_name: percent_2
    query_timezone: America/Chicago
    custom_color_enabled: true
    custom_color: red
    show_single_value_title: true
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
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.contract_rate_network_name
    - ar_carrier_performance.sum_claim_with_network_name
    single_value_title: ''
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 2
    col: 9
    width: 6
    height: 4
  - name: Business Mix - Total Claims by Plan Type
    title: Business Mix - Total Claims by Plan Type
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.plan_type
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_carrier
    - ar_carrier_performance.sum_plan
    - ar_carrier_performance.sum_tot_paid
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
    sorts:
    - ar_carrier_performance.sum_claim desc
    limit: 5000
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: business_mix
      label: Business Mix %
      expression: "(${ar_carrier_performance.sum_claim}/${ar_carrier_performance.sum_claim:total})"
      value_format:
      value_format_name: percent_2
    - table_calculation: plan_type
      label: Plan Type
      expression: if(${ar_carrier_performance.plan_type}= " ","UNKNOWN",${ar_carrier_performance.plan_type})
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: log
    show_null_points: true
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    font_size: '9'
    value_labels: legend
    label_type: labPer
    series_types: {}
    hidden_fields:
    - ar_carrier_performance.sum_carrier
    - ar_carrier_performance.sum_plan
    - ar_carrier_performance.plan_type
    colors: 'palette: Santa Cruz'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series: []
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 2
    col: 15
    width: 9
    height: 4
  - name: Business Mix by State
    title: Business Mix by State
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.plan_type
    - ar_carrier_performance.sum_tot_paid
    - ar_carrier_performance.sum_claim
    - store_state_location.state_abbreviation
    pivots:
    - store_state_location.state_abbreviation
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
      ar_chain.chain_id: ''
    sorts:
    - ar_carrier_performance.sum_tot_paid desc 0
    - ar_carrier_performance.plan_type
    - store_state_location.state_abbreviation
    limit: 5000
    column_limit: 50
    total: true
    row_total: right
    dynamic_fields:
    - table_calculation: asp
      label: ASP
      expression: "(${ar_carrier_performance.sum_tot_paid}/${ar_carrier_performance.sum_claim})"
      value_format:
      value_format_name: usd
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: log
    show_null_points: true
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    font_size: '9'
    value_labels: legend
    label_type: labPer
    series_types: {}
    hidden_fields: []
    colors: 'palette: Santa Cruz'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series: []
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 6
    col: 0
    width: 14
    height: 7
  - name: Business Mix by Division
    title: Business Mix by Division
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.plan_type
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_carrier
    - ar_carrier_performance.sum_plan
    - ar_carrier_performance.sum_tot_paid
    - ar_carrier_performance.store_division
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
    sorts:
    - ar_carrier_performance.sum_claim desc
    limit: 5000
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: business_mix
      label: Business Mix %
      expression: "(${ar_carrier_performance.sum_claim}/${ar_carrier_performance.sum_claim:total})"
      value_format:
      value_format_name: percent_2
    - table_calculation: plan_type
      label: Plan Type
      expression: if(${ar_carrier_performance.plan_type}= " ","UNKNOWN",${ar_carrier_performance.plan_type})
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: log
    show_null_points: true
    point_style: circle
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    font_size: '9'
    value_labels: legend
    label_type: labPer
    series_types: {}
    hidden_fields:
    - ar_carrier_performance.sum_carrier
    - ar_carrier_performance.sum_plan
    - ar_carrier_performance.plan_type
    colors: 'palette: Santa Cruz'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series: []
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 6
    col: 14
    width: 10
    height: 7
  - name: Store Division Business Mix Summary
    title: Store Division Business Mix Summary
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.store_division
    - ar_carrier_performance.store_id
    - ar_carrier_performance.bin_number
    - ar_carrier_performance.pcn_number
    - ar_carrier_performance.plan_type
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_acq_cost
    - ar_carrier_performance.sum_ingredient_cost_paid
    - ar_carrier_performance.sum_tot_paid
    - ar_carrier_performance.sum_tp_paid
    - ar_carrier_performance.sum_copay_collected
    - ar_carrier_performance.sum_gross_profit
    - ar_carrier_performance.sum_gross_profit_percentage
    - ar_carrier_performance.sum_awp_price
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
    sorts:
    - ar_carrier_performance.sum_tot_paid desc
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: effective_rate
      label: Effective Rate %
      expression: concat(round((((${ar_carrier_performance.sum_ingredient_cost_paid}/${ar_carrier_performance.sum_awp_price})*100)-100),2),"%")
      value_format:
      value_format_name:
      _kind_hint: measure
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: log
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    font_size: '9'
    value_labels: legend
    label_type: labPer
    series_types: {}
    hidden_fields:
    - ar_carrier_performance.sum_awp_price
    colors: 'palette: Mixed Dark'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series:
    - ar_carrier_performance.sum_gross_profit_percentage
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 13
    col: 0
    width: 24
    height: 8
  - name: Carrier Performance Detail Analysis
    title: Carrier Performance Detail Analysis
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.transaction_id
    - ar_carrier_performance.store_id
    - ar_carrier_performance.store_division
    - ar_carrier_performance.nabp_num
    - ar_carrier_performance.store_npi
    - ar_carrier_performance.contract_name
    - ar_carrier_performance.contract_rate_network_name
    - ar_carrier_performance.processor_id
    - ar_carrier_performance.plan_type
    - ar_carrier_performance.carrier_code
    - ar_carrier_performance.carrier_name
    - ar_carrier_performance.plan_code
    - ar_carrier_performance.group_code
    - ar_carrier_performance.network_reimb_id
    - ar_carrier_performance.bin_number
    - ar_carrier_performance.pcn_number
    - ar_carrier_performance.rx_number
    - ar_carrier_performance.tx_number
    - ar_carrier_performance.filled_date
    - ar_carrier_performance.sold_date
    - ar_carrier_performance.drug_name
    - ar_carrier_performance.drug_ndc
    - ar_carrier_performance.gpi
    - ar_carrier_performance.bg_desc
    - ar_carrier_performance.msdesc
    - ar_carrier_performance.sum_dispensed_qty
    - ar_carrier_performance.days_supply_max
    - ar_carrier_performance.split_desc
    - ar_carrier_performance.sum_acq_cost
    - ar_carrier_performance.sum_uc_price
    - ar_carrier_performance.sum_awp_price
    - ar_carrier_performance.sum_wac_price
    - ar_carrier_performance.drug_effective_start
    - ar_carrier_performance.sum_tp_paid
    - ar_carrier_performance.sum_copay_collected
    - ar_carrier_performance.sum_tot_paid
    - ar_carrier_performance.sum_ingredient_cost_paid
    - ar_carrier_performance.sum_dispd_fee_paid
    - ar_carrier_performance.sum_tax_amount
    - ar_carrier_performance.sum_awp_discount
    - ar_carrier_performance.sum_wac_discount
    - ar_carrier_performance.sum_gross_profit
    - ar_carrier_performance.basis_of_reimb
    - ar_carrier_performance.sum_ingredient_cost_paid_per_unit
    - ar_carrier_performance.type_desc
    filters:
      ar_carrier_performance.bin_filter: ''
      ar_carrier_performance.carrier_filter: ''
      ar_carrier_performance.days_supply_filter: ''
      ar_carrier_performance.drug_gpi_filter: ''
      ar_carrier_performance.drug_ndc_filter: ''
      ar_carrier_performance.drug_name_filter: ''
      ar_carrier_performance.fill_date_filter: ''
      ar_carrier_performance.group_filter: ''
      ar_carrier_performance.network_filter: ''
      ar_carrier_performance.pcn_filter: ''
      ar_carrier_performance.plan_filter: ''
      ar_carrier_performance.store_filter: ''
      ar_chain.chain_id: ''
    sorts:
    - ar_carrier_performance.carrier_code
    - ar_carrier_performance.plan_code
    - ar_carrier_performance.group_code
    - ar_carrier_performance.transaction_id
    - ar_carrier_performance.drug_effective_start
    limit: 5
    column_limit: 50
    query_timezone: America/Chicago
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
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Claim ID: ar_carrier_performance.transaction_id
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Fill Date: ar_carrier_performance.filled_date
      Sold Date: ar_carrier_performance.sold_date
      Paid Amount: ar_carrier_performance.paid_amount_filter
      Brand/Generic: ar_carrier_performance.brand_generic_filter
      Days Supply: ar_carrier_performance.days_supply
      Drug NDC: ar_carrier_performance.drug_ndc
      Drug Name: ar_carrier_performance.drug_name
      Drug GPI: ar_carrier_performance.gpi
      Exclude $0 Claims: ar_carrier_performance.exclude_zero_dollar_claim_filter
      Exclude Credit Returns: ar_carrier_performance.exclude_credit_returns_filter
      Include Split Bills: ar_carrier_performance.include_split_bill_filter
    row: 21
    col: 0
    width: 24
    height: 8
  filters:
  - name: Claim ID
    title: Claim ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.transaction_id
  - name: Store
    title: Store
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Store Division
    field: ar_carrier_performance.store_id
  - name: Store Division
    title: Store Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Store
    field: ar_carrier_performance.store_division
  - name: Carrier
    title: Carrier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Plan
    - Group
    - Network ID
    - BIN
    - PCN
    field: ar_carrier_performance.carrier_code
  - name: Plan
    title: Plan
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Carrier
    - Group
    - Network ID
    - BIN
    - PCN
    field: ar_carrier_performance.plan_code
  - name: Group
    title: Group
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Carrier
    - Plan
    - Network ID
    - BIN
    - PCN
    field: ar_carrier_performance.group_code
  - name: Network ID
    title: Network ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Carrier
    - Plan
    - Group
    - BIN
    - PCN
    field: ar_carrier_performance.network_reimb_id
  - name: BIN
    title: BIN
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Carrier
    - Plan
    - Group
    - Network ID
    - PCN
    field: ar_carrier_performance.bin_number
  - name: PCN
    title: PCN
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    - Carrier
    - Plan
    - Group
    - Network ID
    - BIN
    field: ar_carrier_performance.pcn_number
  - name: Fill Date
    title: Fill Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.filled_date
  - name: Sold Date
    title: Sold Date
    type: field_filter
    default_value: 1 months ago for 1 months
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.sold_date
  - name: Paid Amount
    title: Paid Amount
    type: field_filter
    default_value: Adjudicated Amount
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.paid_amount_filter
  - name: Brand/Generic
    title: Brand/Generic
    type: field_filter
    default_value: All
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.brand_generic_filter
  - name: Days Supply
    title: Days Supply
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.days_supply
  - name: Drug NDC
    title: Drug NDC
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.drug_ndc
  - name: Drug Name
    title: Drug Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.drug_name
  - name: Drug GPI
    title: Drug GPI
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.gpi
  - name: Exclude $0 Claims
    title: Exclude $0 Claims
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.exclude_zero_dollar_claim_filter
  - name: Exclude Credit Returns
    title: Exclude Credit Returns
    type: field_filter
    default_value: 'YES'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.exclude_credit_returns_filter
  - name: Include Split Bills
    title: Include Split Bills
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Chain ID
    field: ar_carrier_performance.include_split_bill_filter

- dashboard: ar_cpr_dashboard
  title: Carrier Performance Dashboard
  layout: newspaper
  elements:
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
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 17
    col: 12
    width: 12
    height: 7
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
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 32
    col: 0
    width: 24
    height: 10
  - name: Contract Coverage %
    title: Contract Coverage %
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
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 2
    col: 9
    width: 8
    height: 2
  - name: Paid Below Acquisition Cost AND Paid At U&C Claims
    title: Paid Below Acquisition Cost AND Paid At U&C Claims
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: looker_column
    fields:
    - ar_carrier_performance.bg_desc
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_tot_paid
    - ar_carrier_performance.sum_claim_paid_at_uc_price
    - ar_carrier_performance.sum_tot_paid_at_uc_price
    - ar_carrier_performance.sum_claim_paid_below_acq_cost
    - ar_carrier_performance.sum_tot_paid_below_acq_cost
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
    - ar_carrier_performance.bg_desc
    - ar_carrier_performance.sum_claim desc
    limit: 500
    column_limit: 50
    total: true
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    series_types: {}
    hidden_fields:
    colors: 'palette: Mixed Dark'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series: []
    series_labels:
      ar_carrier_performance.sum_claim_paid_at_uc_price: Pd @ U&C
      ar_carrier_performance.sum_claim_paid_below_acq_cost: PbAC
      ar_carrier_performance.sum_tot_paid_at_uc_price: Pd@U&C $
      ar_carrier_performance.sum_tot_paid_below_acq_cost: PbAC $ Diff
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 24
    col: 0
    width: 24
    height: 8
  - name: Carrier Performance Grid View
    title: Carrier Performance Grid View
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: table
    fields:
    - ar_carrier_performance.bg_desc
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_carrier
    - ar_carrier_performance.sum_plan
    - ar_carrier_performance.sum_group
    - ar_carrier_performance.sum_acq_cost
    - ar_carrier_performance.sum_dispd_fee_paid
    - ar_carrier_performance.sum_ingredient_cost_paid
    - ar_carrier_performance.sum_awp_price
    - ar_carrier_performance.sum_revenue
    - ar_carrier_performance.sum_gross_profit
    - ar_carrier_performance.sum_gross_profit_percentage
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
    - ar_carrier_performance.bg_desc
    - ar_carrier_performance.sum_claim desc
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields:
    - table_calculation: effective_rate
      label: Effective Rate %
      expression: concat(round((((${ar_carrier_performance.sum_ingredient_cost_paid}/${ar_carrier_performance.sum_awp_price})*100)-100),2),"%")
      value_format:
      value_format_name:
    - table_calculation: dispense_rate
      label: Dispense Rate %
      expression: "${ar_carrier_performance.sum_claim}/sum(${ar_carrier_performance.sum_claim})"
      value_format:
      value_format_name: percent_2
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
    colors: 'palette: Mixed Dark'
    series_colors: {}
    label_color:
    - black
    label_rotation: -60
    x_axis_reversed: false
    hidden_series:
    - ar_carrier_performance.sum_gross_profit_percentage
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 14
    col: 0
    width: 24
    height: 3
  - name: Customer
    title: Customer
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
    row: 2
    col: 0
    width: 9
    height: 2
  - name: Top 10 Master Contracts by Gross Profit & Revenue
    title: Top 10 Master Contracts by Gross Profit & Revenue
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: looker_column
    fields:
    - ar_carrier_performance.sum_claim
    - ar_carrier_performance.sum_revenue
    - ar_carrier_performance.sum_gross_profit
    - ar_carrier_performance.contract_name
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
    - ar_carrier_performance.sum_gross_profit desc
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    stacking: ''
    show_value_labels: true
    label_density: '25'
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: true
    y_axis_combined: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: log
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
    series_types:
      ar_carrier_performance.sum_claim: line
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    hidden_series:
    - ar_carrier_performance.sum_revenue
    font_size: '9'
    label_color:
    - black
    label_rotation:
    series_colors:
      ar_carrier_performance.sum_claim: "#336e8e"
      ar_carrier_performance.sum_revenue: "#929292"
      ar_carrier_performance.sum_gross_profit: "#a9c574"
    x_axis_datetime_label: ''
    x_axis_label_rotation: -50
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 4
    col: 0
    width: 24
    height: 10
  - name: Top 10 NDC Paid Below Acquisition Cost
    title: Top 10 NDC Paid Below Acquisition Cost
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: looker_pie
    fields:
    - ar_carrier_performance.sum_claim_paid_below_acq_cost
    - ar_carrier_performance.sum_tot_paid_below_acq_cost
    - ar_carrier_performance.drug_name
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
      ar_carrier_performance.paid_below_acq_cost: Y
    sorts:
    - ar_carrier_performance.sum_tot_paid_below_acq_cost
    limit: 10
    column_limit: 50
    query_timezone: America/Chicago
    value_labels: legend
    label_type: labPer
    show_view_names: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: true
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
    - ar_carrier_performance.sum_claim_paid_below_acq_cost
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    series_types: {}
    colors: 'palette: Looker Classic'
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 17
    col: 0
    width: 12
    height: 7
  - name: Total Unique Networks
    title: Total Unique Networks
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    type: single_value
    fields:
    - ar_carrier_performance.sum_networks
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
    - ar_carrier_performance.sum_networks desc
    limit: 500
    column_limit: 50
    query_timezone: America/Chicago
    custom_color_enabled: false
    custom_color: forestgreen
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
    listen:
      Master Contract Name: ar_carrier_performance.contract_name
      Rate/Network Name: ar_carrier_performance.contract_rate_network_name
      Store: ar_carrier_performance.store_id
      Store Division: ar_carrier_performance.store_division
      Claim ID: ar_carrier_performance.transaction_id
      Network ID: ar_carrier_performance.network_reimb_id
      BIN: ar_carrier_performance.bin_number
      PCN: ar_carrier_performance.pcn_number
      Carrier: ar_carrier_performance.carrier_code
      Plan: ar_carrier_performance.plan_code
      Group: ar_carrier_performance.group_code
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
      Claim Type: ar_carrier_performance.type_desc
    row: 2
    col: 17
    width: 7
    height: 2
  - name: CARRIER PERFORMANCE
    type: text
    title_text: CARRIER PERFORMANCE
    subtitle_text: ''
    body_text: This is a dashboard to measure Carrier Performance for the period selected
    row: 0
    col: 0
    width: 24
    height: 2
  filters:
  - name: Master Contract Name
    title: Master Contract Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.contract_name
  - name: Rate/Network Name
    title: Rate/Network Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.contract_rate_network_name
  - name: Store
    title: Store
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_store
    listens_to_filters: []
    field: ar_store.store_number
  - name: Store Division
    title: Store Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_store
    listens_to_filters: []
    field: ar_store.store_division
  - name: Claim ID
    title: Claim ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.transaction_id
  - name: Network ID
    title: Network ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - BIN
    - PCN
    - Carrier
    - Plan
    - Group
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
    - Network ID
    - PCN
    - Carrier
    - Plan
    - Group
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
    - Network ID
    - BIN
    - Carrier
    - Plan
    - Group
    field: ar_carrier_performance.pcn_number
  - name: Carrier
    title: Carrier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters:
    - Network ID
    - BIN
    - PCN
    - Plan
    - Group
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
    - Network ID
    - BIN
    - PCN
    - Carrier
    - Group
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
    - Network ID
    - BIN
    - PCN
    - Carrier
    - Plan
    field: ar_carrier_performance.group_code
  - name: Fill Date
    title: Fill Date
    type: field_filter
    default_value: 1 months ago for 1 months
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.filled_date
  - name: Sold Date
    title: Sold Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.sold_date
  - name: Paid Amount
    title: Paid Amount
    type: field_filter
    default_value: Adjudicated Amount
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.paid_amount_filter
  - name: Brand/Generic
    title: Brand/Generic
    type: field_filter
    default_value: All
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.brand_generic_filter
  - name: Days Supply
    title: Days Supply
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.days_supply_max
  - name: Drug NDC
    title: Drug NDC
    type: field_filter
    default_value:
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.drug_ndc
  - name: Drug Name
    title: Drug Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.drug_name
  - name: Drug GPI
    title: Drug GPI
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.gpi
  - name: Exclude $0 Claims
    title: Exclude $0 Claims
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.exclude_zero_dollar_claim_filter
  - name: Exclude Credit Returns
    title: Exclude Credit Returns
    type: field_filter
    default_value: 'YES'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.exclude_credit_returns_filter
  - name: Include Split Bills
    title: Include Split Bills
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.include_split_bill_filter
  - name: Claim Type
    title: Claim Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_carrier_performance
    listens_to_filters: []
    field: ar_carrier_performance.type_desc

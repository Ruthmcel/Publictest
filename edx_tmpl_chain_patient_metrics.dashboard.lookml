- dashboard: edx_tmpl_chain_patient_metrics
  title: Dashboard - Patient Metrics
  layout: newspaper
  elements:
  - title: 'Sales: Patient New to Therapy - last week'
    name: 'Sales: Patient New to Therapy - last week'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient.first_name
    - patient.last_name
    - patient.sex
    - chain_patient_summary_info.pat_last_visited_store_id
    - chain_patient_phone_list.home_phone_list
    - chain_patient_phone_list.work_phone_list
    - chain_patient_summary_info.first_fill_date
    - sales.sum_net_gross_margin_ty_ttm
    - chain_patient_summary_info.pat_new_therapy_drug_with_filldate
    - chain_patient_summary_info.target_indication_list
    - report_calendar_global.report_range
    pivots:
    - report_calendar_global.report_range
    filters:
      chain_patient_summary_info.pat_new_to_therapy_date_period: 1 week ago for 1
        week
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      chain_patient_summary_info.pat_new_therapy_flag: 'YES'
      store_alignment.district: ''
      store_alignment.division: ''
      store_alignment.region: ''
      store_state_location.store_state_name: ''
      sales.rx_tx_tx_status: NORMAL
      sales.show_after_sold_measure_values: 'NO'
    sorts:
    - report_calendar_global.report_range 0
    - sales.sum_net_gross_margin_ty_ttm desc 0
    limit: 5000
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
    listen:
      Chain ID: chain.chain_id
      Pharmacy Number: store.store_number
    row: 14
    col: 0
    width: 24
    height: 6
  - title: 'Sales: Patients - Top list by TTM Net Margin'
    name: 'Sales: Patients - Top list by TTM Net Margin'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient.first_name
    - patient.last_name
    - patient.sex
    - chain_patient_summary_info.pat_last_visited_store_id
    - sales.first_fill_date
    - sales.last_filled_date
    - sales.sum_net_gross_margin_ty_ttm
    - sales.count_ty_ttm
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_alignment.district: ''
      store_alignment.division: ''
      store_alignment.region: ''
      store_state_location.store_state_name: ''
      sales.rx_tx_tx_status: NORMAL
      sales.show_after_sold_measure_values: 'NO'
      patient.last_name: "-NULL"
    sorts:
    - sales.sum_net_gross_margin_ty_ttm desc
    limit: 50
    column_limit: 50
    row_total: right
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    listen:
      Chain ID: chain.chain_id
      Pharmacy Number: store.store_number
    row: 0
    col: 0
    width: 24
    height: 7
  - title: 'Sales: Patients Potentially Lost'
    name: 'Sales: Patients Potentially Lost'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient.last_name
    - patient.first_name
    - patient.sex
    - patient.patient_age
    - chain_patient_summary_info.pat_last_visited_store_id
    - sales.sum_net_gross_margin_ty_ttm
    - sales.count_ty_ttm
    - chain_patient_summary_info.days_since_last_activity
    - chain_patient_summary_info.medication_list
    - chain_patient_phone_list.home_phone_list
    - chain_patient_phone_list.work_phone_list
    - sales.first_fill_date
    - sales.last_filled_date
    filters:
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.date_to_use_filter: REPORTABLE SALES
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.show_after_sold_measure_values: 'NO'
      chain_patient_summary_info.aggregated_medication_name: '3'
      patient.deactivate: 'No'
      patient.deceased: 'No'
      chain_patient_summary_info.days_since_last_activity: "[100, 180]"
      sales.rx_tx_tx_status: NORMAL
    sorts:
    - sales.sum_net_gross_margin_ty_ttm desc
    limit: 500
    query_timezone: America/Chicago
    listen:
      Chain ID: chain.chain_id
      Pharmacy Number: store.store_number
    row: 7
    col: 0
    width: 24
    height: 7
  - title: 'Sales: Patient List by TTM Control Script Count'
    name: 'Sales: Patient List by TTM Control Script Count'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient.first_name
    - patient.last_name
    - patient.sex
    - chain_patient_summary_info.pat_last_visited_store_id
    - sales.count_ty_ttm
    - sales.sum_net_gross_margin_ty_ttm
    - store_drug.drug_schedule_category
    pivots:
    - store_drug.drug_schedule_category
    fill_fields:
    - store_drug.drug_schedule_category
    filters:
      sales.date_to_use_filter: SOLD
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 13 months
      report_calendar_global.analysis_calendar_filter: Fiscal - Month
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      store_alignment.district: ''
      store_alignment.division: ''
      store_alignment.region: ''
      store_state_location.store_state_name: ''
      sales.rx_tx_tx_status: NORMAL
      sales.show_after_sold_measure_values: 'NO'
      patient.last_name: "-NULL"
    sorts:
    - sales.count_ty_ttm desc 0
    - store_drug.drug_schedule_category
    limit: 50
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: control_script_count
      label: "% Control Script Count"
      expression: pivot_where(${store_drug.drug_schedule_category}="CONTROL",${sales.count_ty_ttm}/${sales.count_ty_ttm:row_total})
      value_format:
      value_format_name: percent_2
      _kind_hint: supermeasure
      _type_hint: number
    query_timezone: America/Chicago
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '20'
    listen:
      Chain ID: chain.chain_id
      Pharmacy Number: store.store_number
    row: 26
    col: 0
    width: 24
    height: 7
  - name: "<<<<<<<<<<<<<<<<<< END OF REPORT >>>>>>>>>>>>>>>>>>>>>"
    type: text
    title_text: "<<<<<<<<<<<<<<<<<< END OF REPORT >>>>>>>>>>>>>>>>>>>>>"
    row: 33
    col: 0
    width: 24
    height: 2
  - title: 'Sales: Patients New to Pharmacy'
    name: 'Sales: Patients New to Pharmacy'
    model: PDX_CUSTOMER_DSS
    explore: sales
    type: table
    fields:
    - patient.last_name
    - patient.first_name
    - patient.sex
    - patient.patient_age
    - chain_patient_summary_info.pat_last_visited_store_id
    - sales.first_fill_date
    - sales.last_filled_date
    - sales.sum_net_gross_margin
    - sales.count
    - chain_patient_summary_info.medication_list
    - chain_patient_phone_list.home_phone_list
    - report_calendar_global.report_range
    pivots:
    - report_calendar_global.report_range
    filters:
      sales.history_filter: 'NO'
      report_calendar_global.report_period_filter: 1 weeks ago for 1 weeks
      report_calendar_global.analysis_calendar_filter: Fiscal - Week
      report_calendar_global.this_year_last_year_filter: 'No'
      sales.date_to_use_filter: REPORTABLE SALES
      sales.sales_rxtx_payor_summary_detail_analysis: SUMMARY
      sales.show_after_sold_measure_values: 'NO'
      chain_patient_summary_info.aggregated_medication_name: '3'
      patient.deactivate: 'No'
      patient.deceased: 'No'
      sales.rx_tx_tx_status: NORMAL
      sales.first_fill_date: 1 weeks ago for 1 weeks
    sorts:
    - report_calendar_global.report_range 0
    - sales.sum_net_gross_margin desc 0
    limit: 50
    column_limit: 50
    query_timezone: America/Chicago
    listen:
      Chain ID: chain.chain_id
      Pharmacy Number: store.store_number
    row: 20
    col: 0
    width: 24
    height: 6
  filters:
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

- dashboard: carerxdss_survey_session_dashboard
  title: CareRx Survey Session Dashboard
  layout: newspaper
  elements:
  - title: Programs - Total Session Count
    name: Programs - Total Session Count
    model: CARERX_DSS_EMBED
    explore: carerx_clinical_session_patient_interview
    type: looker_bar
    fields: [carerx_clinical_session_patient_interview.program_name, carerx_clinical_session_patient_interview.patient_count,
      carerx_clinical_session_patient_interview.session_count]
    sorts: [carerx_clinical_session_patient_interview.patient_count desc]
    limit: 500
    query_timezone: America/Chicago
    series_types: {}
    row: 2
    col: 0
    width: 11
    height: 8
  - title: Untitled
    name: Untitled
    model: CARERX_DSS_EMBED
    explore: carerx_clinical_session_patient_interview
    type: single_value
    fields: [chain.chain_name]
    sorts: [chain.chain_name]
    limit: 500
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: "#ff8833"
    show_single_value_title: true
    single_value_title: Customer
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Session Status
    name: Session Status
    model: CARERX_DSS_EMBED
    explore: carerx_clinical_session_patient_interview
    type: looker_column
    fields: [carerx_clinical_session_patient_interview.mtm_session_status, carerx_clinical_session_patient_interview.session_count,
      carerx_clinical_session_patient_interview.patient_count, carerx_clinical_session_patient_interview.patient_program_count]
    sorts: [carerx_clinical_session_patient_interview.session_count desc]
    limit: 500
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 1297ec12-86a5-4ae0-9dfc-82de70b3806a
      palette_id: 93f8aeb4-3f4a-4cd7-8fee-88c3417516a1
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_types: {}
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
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 2
    col: 11
    width: 13
    height: 8

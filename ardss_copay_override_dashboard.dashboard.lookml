- dashboard: ardss_copay_override_dashboard
  title: Copay Override Report
  layout: newspaper
  elements:
  - title: Copay Override Report
    name: Copay Override Report
    model: ABSOLUTE_AR_DSS
    explore: ar_transaction_status
    type: table
    fields:
    - ar_chain.chain_id
    - ar_chain.chain_name
    - ar_store.store_number
    - ar_plan.carrier_code
    - ar_transaction_status.transaction_id
    - ar_transaction_info.transaction_info_copay_override_flag
    - ar_transaction_info.sum_transaction_info_copay_amount
    - ar_transaction_info.sum_transaction_info_received_copay
    filters:
      ar_report_calendar_global.report_period_filter: 1 weeks
      ar_report_calendar_global.analysis_calendar_filter: Fiscal - Week
      ar_report_calendar_global.this_year_last_year_filter: 'No'
      ar_transaction_status.date_to_use_filter: REPORTABLE SALES
      ar_chain.chain_id: '128'
      ar_transaction_info.transaction_info_copay_override_flag: Y
    sorts:
    - ar_transaction_info.sum_transaction_info_copay_amount desc
    limit: 500
    query_timezone: America/Chicago
    listen: {}
    row: 0
    col: 8
    width: 8
    height: 6

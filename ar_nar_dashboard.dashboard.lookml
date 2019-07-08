- dashboard: ar_nar_dashboard
  title: Network Analysis Dashboard
  layout: newspaper
  elements:
  - name: Network Analysis Report - Detail All
    title: Network Analysis Report - Detail All
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    type: table
    fields:
    - ar_network_analysis.transaction_id
    - ar_network_analysis.transaction_type
    - ar_network_analysis.tp_ref_num
    - ar_network_analysis.paidAtUC
    - ar_network_analysis.paid_less_than_acq_cost
    - ar_network_analysis.store_id
    - ar_network_analysis.nabp_num
    - ar_network_analysis.store_npi
    - ar_network_analysis.contract_rate_network_name
    - ar_network_analysis.processor_id
    - ar_network_analysis.carrier_code
    - ar_network_analysis.plan_code
    - ar_network_analysis.group_code
    - ar_network_analysis.carrier_name
    - ar_network_analysis.bin_number
    - ar_network_analysis.pcn_number
    - ar_network_analysis.network_reimb_id
    - ar_network_analysis.rx_number
    - ar_network_analysis.tx_number
    - ar_network_analysis.filled_date
    - ar_network_analysis.drug_name
    - ar_network_analysis.drug_ndc
    - ar_network_analysis.gpi
    - ar_network_analysis.drug_brand_generic
    - ar_network_analysis.store_brand_generic
    - ar_network_analysis.days_supply
    - ar_network_analysis.split_bill_opt
    - ar_network_analysis.contract_state
    - ar_network_analysis.store_state
    - ar_network_analysis.daw
    - ar_network_analysis.note
    - ar_network_analysis.note_category
    - ar_network_analysis.progress_status
    - ar_network_analysis.costbase
    - ar_network_analysis.effective_start_date_date
    - ar_network_analysis.baseAmt
    - ar_network_analysis.awp_discount
    - ar_network_analysis.dispd_qty
    - ar_network_analysis.acq_cost
    - ar_network_analysis.uc_price
    - ar_network_analysis.ingredCostExpected
    - ar_network_analysis.ingredCostPaid
    - ar_network_analysis.ingredCostDifference
    - ar_network_analysis.dispFeeExpected
    - ar_network_analysis.dispFeePaid
    - ar_network_analysis.dispFeeDifference
    - ar_network_analysis.tax_amt
    - ar_network_analysis.thirdPartyPaidAmt
    - ar_network_analysis.copay_amt
    - ar_network_analysis.expectedPayment
    - ar_network_analysis.totalPaidAmt
    - ar_network_analysis.difference
    - ar_network_analysis.basis_of_reimb
    - ar_network_analysis.acqCostPerUnit
    - ar_network_analysis.ingredCostExpectedPerUnit
    - ar_network_analysis.ingredCostPaidPerUnit
    - ar_network_analysis.expectedPaymentPerUnit
    - ar_network_analysis.totalPaidPerUnit
    filters:
      ar_network_analysis.carrier_filter: ''
      ar_network_analysis.detail_level_filter: Detail- All
      ar_network_analysis.group_filter: ''
      ar_network_analysis.master_contract_filter: ''
      ar_network_analysis.plan_filter: ''
      ar_network_analysis.rate_network_name_filter: ''
      ar_network_analysis.store_filter: ''
    sorts:
    - ar_network_analysis.baseAmt
    limit: 10
    column_limit: 50
    total: true
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
      Store: ar_store.store_number
      Master Contract: ar_network_analysis.contract_name
      Rate/Network Name: ar_network_analysis.contract_rate_network_name
      Network ID: ar_network_analysis.network_reimb_id
      BIN: ar_network_analysis.bin_number
      PCN: ar_network_analysis.pcn_number
      Carrier: ar_network_analysis.carrier_code
      Plan: ar_network_analysis.plan_code
      Group Code: ar_network_analysis.group_code
      Paid Amount: ar_network_analysis.paid_amount_filter
      Fill date: ar_network_analysis.fill_date_filter
      Include Split Bills: ar_network_analysis.include_split_bill_filter
      Include Copay In Total Paid: ar_network_analysis.include_copay_amount_in_tot_amt_paid
      Exclude $0 Claims: ar_network_analysis.exclude_zero_dollar_claim_filter
      Claim Type: ar_network_analysis.transaction_type
      Claim ID: ar_network_analysis.transaction_id
    row: 32
    col: 0
    width: 24
    height: 8
  - name: Network Analysis Report - Detail Exceptions
    title: Network Analysis Report - Detail Exceptions
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    type: table
    fields:
    - ar_network_analysis.transaction_id
    - ar_network_analysis.paidAtUC
    - ar_network_analysis.paid_less_than_acq_cost
    - ar_network_analysis.store_id
    - ar_network_analysis.nabp_num
    - ar_network_analysis.store_npi
    - ar_network_analysis.contract_name
    - ar_network_analysis.contract_rate_network_name
    - ar_network_analysis.processor_id
    - ar_network_analysis.network_reimb_id
    - ar_network_analysis.bin_number
    - ar_network_analysis.pcn_number
    - ar_network_analysis.carrier_code
    - ar_network_analysis.carrier_name
    - ar_network_analysis.plan_code
    - ar_network_analysis.group_code
    - ar_network_analysis.rx_number
    - ar_network_analysis.tx_number
    - ar_network_analysis.filled_date
    - ar_network_analysis.drug_name
    - ar_network_analysis.drug_ndc
    - ar_network_analysis.gpi
    - ar_network_analysis.drug_brand_generic
    - ar_network_analysis.store_brand_generic
    - ar_network_analysis.contract_state
    - ar_network_analysis.store_state
    - ar_network_analysis.split_bill_opt
    - ar_network_analysis.transaction_type
    - ar_network_analysis.daw
    - ar_network_analysis.days_supply
    - ar_network_analysis.costbase
    - ar_network_analysis.effective_start_date_date
    - ar_network_analysis.baseAmt
    - ar_network_analysis.dispd_qty
    - ar_network_analysis.acq_cost
    - ar_network_analysis.uc_price
    - ar_network_analysis.ingredCostExpected
    - ar_network_analysis.ingredCostPaid
    - ar_network_analysis.ingredCostDifference
    - ar_network_analysis.dispFeeExpected
    - ar_network_analysis.dispFeePaid
    - ar_network_analysis.dispFeeDifference
    - ar_network_analysis.tax_amt
    - ar_network_analysis.thirdPartyPaidAmt
    - ar_network_analysis.copay_amt
    - ar_network_analysis.expectedPayment
    - ar_network_analysis.totalPaidAmt
    - ar_network_analysis.difference
    - ar_network_analysis.awp_discount
    - ar_network_analysis.basis_of_reimb
    filters:
      ar_network_analysis.carrier_filter: ''
      ar_network_analysis.detail_level_filter: Detail- Exceptions
      ar_network_analysis.group_filter: ''
      ar_network_analysis.master_contract_filter: ''
      ar_network_analysis.plan_filter: ''
      ar_network_analysis.rate_network_name_filter: ''
      ar_network_analysis.store_filter: ''
    sorts:
    - ar_network_analysis.baseAmt
    limit: 10
    column_limit: 50
    total: true
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
      Store: ar_store.store_number
      Master Contract: ar_network_analysis.contract_name
      Rate/Network Name: ar_network_analysis.contract_rate_network_name
      Network ID: ar_network_analysis.network_reimb_id
      BIN: ar_network_analysis.bin_number
      PCN: ar_network_analysis.pcn_number
      Carrier: ar_network_analysis.carrier_code
      Plan: ar_network_analysis.plan_code
      Group Code: ar_network_analysis.group_code
      Paid Amount: ar_network_analysis.paid_amount_filter
      Fill date: ar_network_analysis.fill_date_filter
      Include Split Bills: ar_network_analysis.include_split_bill_filter
      Include Copay In Total Paid: ar_network_analysis.include_copay_amount_in_tot_amt_paid
      Exclude $0 Claims: ar_network_analysis.exclude_zero_dollar_claim_filter
      Claim Type: ar_network_analysis.transaction_type
      Claim ID: ar_network_analysis.transaction_id
    row: 8
    col: 0
    width: 24
    height: 8
  - name: Network Analysis Report - Summary
    title: Network Analysis Report - Summary
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    type: table
    fields:
    - ar_network_analysis.contract_rate_network_name
    - ar_network_analysis.state
    - ar_network_analysis.brand_or_generic
    - ar_network_analysis.days_supply_range
    - ar_network_analysis.wi_contract_pct
    - ar_network_analysis.wi_contract_count
    - ar_network_analysis.exceptions_pct
    - ar_network_analysis.exception_count
    - ar_network_analysis.exceptions_amount
    - ar_network_analysis.not_paid_at_all_pct
    - ar_network_analysis.not_paid_count
    - ar_network_analysis.total_count
    - ar_network_analysis.disp_fee_exception_count
    - ar_network_analysis.dispensing_fee_exceptions_amount
    - ar_network_analysis.ingrd_cost_exception_count
    - ar_network_analysis.ingredient_cost_exceptions_amount
    filters:
      ar_network_analysis.store_filter: ''
      ar_network_analysis.master_contract_filter: ''
      ar_network_analysis.rate_network_name_filter: ''
      ar_network_analysis.carrier_filter: ''
      ar_network_analysis.plan_filter: ''
      ar_network_analysis.group_filter: ''
      ar_network_analysis.detail_level_filter: Summary
    limit: 500
    column_limit: 50
    total: true
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
      Store: ar_store.store_number
      Master Contract: ar_network_analysis.contract_name
      Rate/Network Name: ar_network_analysis.contract_rate_network_name
      Network ID: ar_network_analysis.network_reimb_id
      BIN: ar_network_analysis.bin_number
      PCN: ar_network_analysis.pcn_number
      Carrier: ar_network_analysis.carrier_code
      Plan: ar_network_analysis.plan_code
      Group Code: ar_network_analysis.group_code
      Paid Amount: ar_network_analysis.paid_amount_filter
      Fill date: ar_network_analysis.fill_date_filter
      Include Split Bills: ar_network_analysis.include_split_bill_filter
      Include Copay In Total Paid: ar_network_analysis.include_copay_amount_in_tot_amt_paid
      Exclude $0 Claims: ar_network_analysis.exclude_zero_dollar_claim_filter
      Claim Type: ar_network_analysis.transaction_type
      Claim ID: ar_network_analysis.transaction_id
    row: 0
    col: 0
    width: 24
    height: 8
  filters:
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
  - name: Master Contract
    title: Master Contract
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.contract_name
  - name: Rate/Network Name
    title: Rate/Network Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.contract_rate_network_name
  - name: Network ID
    title: Network ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.network_reimb_id
  - name: BIN
    title: BIN
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.bin_number
  - name: PCN
    title: PCN
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.pcn_number
  - name: Carrier
    title: Carrier
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.carrier_code
  - name: Plan
    title: Plan
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.plan_code
  - name: Group Code
    title: Group Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.group_code
  - name: Paid Amount
    title: Paid Amount
    type: field_filter
    default_value: Adjudicated Amount
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.paid_amount_filter
  - name: Fill date
    title: Fill date
    type: field_filter
    default_value: 1 months ago for 1 months
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.fill_date_filter
  - name: Include Split Bills
    title: Include Split Bills
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.include_split_bill_filter
  - name: Include Copay In Total Paid
    title: Include Copay In Total Paid
    type: field_filter
    default_value: 'YES'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.include_copay_amount_in_tot_amt_paid
  - name: Exclude $0 Claims
    title: Exclude $0 Claims
    type: field_filter
    default_value: 'NO'
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.exclude_zero_dollar_claim_filter
  - name: Claim Type
    title: Claim Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.transaction_type
  - name: Claim ID
    title: Claim ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: ABSOLUTE_AR
    explore: ar_network_analysis
    listens_to_filters: []
    field: ar_network_analysis.transaction_id

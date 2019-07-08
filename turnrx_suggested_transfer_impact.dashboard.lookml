- dashboard: suggested_transfer_impact
  title: Suggested Transfer Impact
  layout: newspaper
  embed_style:
    background_color: "#f6f8fa"
    show_title: false
    title_color: "#3a4245"
    show_filters_bar: false
    tile_text_color: "#3a4245"
    text_tile_text_color: ''
  elements:
  - title: Suggested Transfer Impact
    name: Suggested Transfer Impact
    model: CIS
    explore: turnrx_transfer_store_to_store_task_no_cache
    type: looker_pie
    fields: [turnrx_transfer_store_to_store_task.sending_store_transfer_initiated_reason,
      turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount]
    filters:
      turnrx_transfer_invoice_drug.transfer_invoice_drug_status: ACTIVE,COMPLETED
      chain.chain_id: ''
    sorts: [turnrx_transfer_invoice_drug.total_transfer_invoice_drug_dollar_amount
        desc]
    limit: 500
    value_labels: labels
    label_type: labPer
    series_colors:
      DEAD INVENTORY: "#00588f"
      FRAGMENTED: "#fc9200"
      OVERSTOCK: "#b84c4e"
    series_types: {}
    title_hidden: false
    listen:
      event_id: turnrx_transfer_store_to_store_task.event_id
    row: 0
    col: 0
    width: 24
    height: 9
  filters:
  - name: event_id
    title: event_id
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: CIS
    explore: turnrx_transfer_store_to_store_task_no_cache
    listens_to_filters: []
    field: turnrx_transfer_store_to_store_task.event_id

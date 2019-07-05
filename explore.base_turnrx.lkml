view: explore_base_turnrx_lookml {}

############################################## Business & Technical Implementation Considerations ##################################################################################################################
##### 1.  This base explore will used to access all views that are currently accessing Inventory related tables in Snowflake
##### 2.  Evey explore under this master lookml has to be extended so it could be re-used across other lookml models that connects to Snowflake instance
##### 3.  ALL_FIELDS* are primarily used to pull all the fields from base view and used often in conjunction with main explore and its associated child views but not with the master view
###################################################################################################################################################################################################################

########################################################### Inventory Movement Detail Snapshot [ERXDWPS-5100] ############################################################################################
explore: turnrx_store_drug_inventory_mvmnt_snapshot_base {
  extension: required
  label: "Inventory Movement Snapshot"
  view_label: "Inventory Movement Snapshot"
  description: "Perform analytics pertaining to Pharmacy Drug Inventory Movement and daily activity based reconciliation, starting and ending Inventory levels, Purchase Order, Drug Orders, Reorders, Return And Adjustment, and other Drug Movement analytics."
  view_name: turnrx_store_drug_inventory_mvmnt_snapshot

  fields: [
    ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment, #ERXDWPS-8224
    -store.dea_number #[ERXDWPS-9281]
  ]

  always_filter: {
    filters: {
      field: activity_date
      value: "1 days ago for 1 days"
    }
  }

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed
    ]
    type: inner
    sql_on: ${turnrx_store_drug_inventory_mvmnt_snapshot.chain_id} = ${chain.chain_id}
      AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    view_label: "Pharmacy - Central"
    #fields: [store_number, store_name, deactivated_date, count, nhin_store_id]
    type: inner
    sql_on: ${turnrx_store_drug_inventory_mvmnt_snapshot.chain_id}      = ${store.chain_id}
        AND ${turnrx_store_drug_inventory_mvmnt_snapshot.nhin_store_id} = ${store.nhin_store_id}
        AND ${store.source_system_id} = 5 ;;
#         AND ${store.store_client_version} is not null
#         AND ${store.store_registration_status} = 'REGISTERED' ;;
    relationship: many_to_one
  }

  join: store_alignment {
    view_label: "Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${store.chain_id}      = ${store_alignment.chain_id}
      AND  ${store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_setting_phone_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number_area_code.nhin_store_id} AND upper(${store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number_area_code {
    from: store_setting
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number_area_code.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number_area_code.nhin_store_id} AND upper(${store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_fax_number {
    from: store_setting
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_fax_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_fax_number.nhin_store_id} AND upper(${store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: store_setting_phone_number {
    from: store_setting
    view_label: "Pharmacy - Central"
    type: left_outer
    sql_on: ${store.chain_id} = ${store_setting_phone_number.chain_id} AND  ${store.nhin_store_id} = ${store_setting_phone_number.nhin_store_id} AND upper(${store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }
}

############################################## Business & Technical Implementation Considerations ##################################################################################################################
##### 1.  This base explore will used to access all views that are currently accessing Inventory related tables in Snowflake
##### 2.  Evey explore under this master lookml has to be extended so it could be re-used across other lookml models that connects to Snowflake instance
##### 3.  ALL_FIELDS* are primarily used to pull all the fields from base view and used often in conjunction with main explore and its associated child views but not with the master view
###################################################################################################################################################################################################################

########################################################### Inventory Transfer [TRX-5349] ############################################################################################
explore: turnrx_transfer_store_to_store_task_base {
  extension: required
  label: "Inventory Transfer"
  view_label: "Inventory Transfer"
  description: "Perform analytics pertaining to Inventory like Dead, fragmented, overstocked inventory"
  view_name: turnrx_transfer_store_to_store_task

  join: chain {
    view_label: "Pharmacy - Central"
    fields: [chain_id, chain_name, master_chain_name, chain_deactivated_date, chain_open_or_closed]
    type: inner
    sql_on: ${turnrx_transfer_store_to_store_task.chain_id} = ${chain.chain_id}
        AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

#### SENDING STORE JOIN START ####

  join: sending_store {
    from: store
    view_label: "Sending Pharmacy - Central"
    fields: [store_number, store_name, deactivated_date, nhin_store_id]
    type: inner
    sql_on: ${turnrx_transfer_store_to_store_task.chain_id}         = ${sending_store.chain_id}
        AND ${turnrx_transfer_store_to_store_task.sending_store_id} = ${sending_store.nhin_store_id}
        AND ${sending_store.source_system_id} = 5 ;;
      relationship: many_to_one
    }

    join: sending_store_alignment {
      from: store_alignment
      view_label: "Sending Pharmacy - Store Alignment"
      type: left_outer
      sql_on: ${sending_store.chain_id}      = ${sending_store_alignment.chain_id}
          AND ${sending_store.nhin_store_id} = ${sending_store_alignment.nhin_store_id} ;;
      relationship: one_to_one
      fields: [store_number,district,division,region]
    }

    join: sending_store_setting_phone_number_area_code {
      from: store_setting
      view_label: "Sending Pharmacy - Central"
      type: left_outer
      sql_on: ${sending_store.chain_id}      = ${sending_store_setting_phone_number_area_code.chain_id}
          AND ${sending_store.nhin_store_id} = ${sending_store_setting_phone_number_area_code.nhin_store_id}
          AND upper(${sending_store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: sending_store_setting_fax_number_area_code {
      from: store_setting
      view_label: "Sending Pharmacy - Central"
      type: left_outer
      sql_on: ${sending_store.chain_id}      = ${sending_store_setting_fax_number_area_code.chain_id}
          AND ${sending_store.nhin_store_id} = ${sending_store_setting_fax_number_area_code.nhin_store_id}
          AND upper(${sending_store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: sending_store_setting_fax_number {
      from: store_setting
      view_label: "Sending Pharmacy - Central"
      type: left_outer
      sql_on: ${sending_store.chain_id} = ${sending_store_setting_fax_number.chain_id}
          AND ${sending_store.nhin_store_id} = ${sending_store_setting_fax_number.nhin_store_id}
          AND upper(${sending_store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
      relationship: one_to_one
      fields: [ ]
    }

    join: sending_store_setting_phone_number {
      from: store_setting
      view_label: "Sending Pharmacy - Central"
      type: left_outer
      sql_on: ${sending_store.chain_id} = ${sending_store_setting_phone_number.chain_id}
          AND ${sending_store.nhin_store_id} = ${sending_store_setting_phone_number.nhin_store_id}
          AND upper(${sending_store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
      relationship: one_to_one
      fields: [ ]
    }

#### SENDING STORE JOIN END ####

#### RECEIVING STORE JOIN START ####


  join: receiving_store {
    from: store
    view_label: "Receiving Pharmacy - Central"
    fields: [store_number, store_name, deactivated_date, nhin_store_id]
    type: inner
    sql_on: ${turnrx_transfer_store_to_store_task.chain_id}         = ${receiving_store.chain_id}
        AND ${turnrx_transfer_store_to_store_task.receiving_store_id} = ${receiving_store.nhin_store_id}
        AND ${receiving_store.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: receiving_store_alignment {
    from: store_alignment
    view_label: "Receiving Pharmacy - Store Alignment"
    type: left_outer
    sql_on: ${receiving_store.chain_id}      = ${receiving_store_alignment.chain_id}
      AND ${receiving_store.nhin_store_id} = ${receiving_store_alignment.nhin_store_id} ;;
    relationship: one_to_one
    fields: [store_number,district,division,region]
  }

  join: receiving_store_setting_phone_number_area_code {
    from: store_setting
    view_label: "Receiving Pharmacy - Central"
    type: left_outer
    sql_on: ${receiving_store.chain_id}      = ${receiving_store_setting_phone_number_area_code.chain_id}
          AND ${receiving_store.nhin_store_id} = ${receiving_store_setting_phone_number_area_code.nhin_store_id}
          AND upper(${receiving_store_setting_phone_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: receiving_store_setting_fax_number_area_code {
    from: store_setting
    view_label: "Receiving Pharmacy - Central"
    type: left_outer
    sql_on: ${receiving_store.chain_id}      = ${receiving_store_setting_fax_number_area_code.chain_id}
          AND ${receiving_store.nhin_store_id} = ${receiving_store_setting_fax_number_area_code.nhin_store_id}
          AND upper(${receiving_store_setting_fax_number_area_code.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.AREACODE'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: receiving_store_setting_fax_number {
    from: store_setting
    view_label: "Receiving Pharmacy - Central"
    type: left_outer
    sql_on: ${receiving_store.chain_id} = ${receiving_store_setting_fax_number.chain_id}
          AND ${receiving_store.nhin_store_id} = ${receiving_store_setting_fax_number.nhin_store_id}
          AND upper(${receiving_store_setting_fax_number.store_setting_name}) = 'STOREDESCRIPTION.FAXNUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

  join: receiving_store_setting_phone_number {
    from: store_setting
    view_label: "Receiving Pharmacy - Central"
    type: left_outer
    sql_on: ${receiving_store.chain_id} = ${receiving_store_setting_phone_number.chain_id}
          AND ${receiving_store.nhin_store_id} = ${receiving_store_setting_phone_number.nhin_store_id}
          AND upper(${receiving_store_setting_phone_number.store_setting_name}) = 'STOREDESCRIPTION.ALTERNATEPHONENUMBER.NUMBER'  ;;
    relationship: one_to_one
    fields: [ ]
  }

#### RECEIVING STORE JOIN END ####

  join: turnrx_transfer_invoice_drug {
    view_label: "Inventory Transfer Invoice Drug"
    type: left_outer
    sql_on: ${turnrx_transfer_store_to_store_task.chain_id}          = ${turnrx_transfer_invoice_drug.chain_id}
        AND ${turnrx_transfer_store_to_store_task.invoice_number}    = ${turnrx_transfer_invoice_drug.invoice_number}
        AND ${turnrx_transfer_store_to_store_task.transfer_drug_ndc} = ${turnrx_transfer_invoice_drug.transfer_drug_ndc} ;;
    relationship: one_to_one
  }

  join: turnrx_transfer_task_event {
    view_label: "Inventory Transfer Event"
    type: inner
    sql_on: ${turnrx_transfer_store_to_store_task.chain_id} = ${turnrx_transfer_task_event.chain_id}
        AND ${turnrx_transfer_store_to_store_task.event_id} = ${turnrx_transfer_task_event.event_id} ;;
    relationship: many_to_one
  }

  join: turnrx_transfer_invoice {
    view_label: "Inventory Transfer Invoice"
    type: inner
    sql_on: ${turnrx_transfer_invoice_drug.chain_id}       = ${turnrx_transfer_invoice.chain_id}
        AND ${turnrx_transfer_invoice_drug.invoice_number} = ${turnrx_transfer_invoice.invoice_number} ;;
    relationship: many_to_one
  }

  join: turnrx_transfer_adjustment_reason {
    view_label: "Inventory Transfer Invoice"
    fields: [turnrx_transfer_adjustment_reason.turn_rx_adjustment_reason_invoice_candidate_list*]
    type: left_outer
    sql_on: ${turnrx_transfer_invoice.transfer_adjustment_reason_id} = ${turnrx_transfer_adjustment_reason.transfer_adjustment_reason_id} ;;
    relationship: many_to_one
  }

  join: turnrx_transfer_adjustment_reason1 {
    from: turnrx_transfer_adjustment_reason
    view_label: "Inventory Transfer Invoice Drug"
    fields: [turnrx_transfer_adjustment_reason1.turn_rx_adjustment_reason_invoice_drug_candidate_list*]
    type: left_outer
    sql_on: ${turnrx_transfer_invoice_drug.transfer_adjustment_reason_id} = ${turnrx_transfer_adjustment_reason1.transfer_adjustment_reason_id} ;;
    relationship: many_to_one
  }
}
#############################################################################################################################################################################

#[ERXLPS-6257] - New base explore created for AR Decision Support System.
view: explore_base_ar_dss_lookml {}

explore: ar_transaction_status_base {
  view_name: ar_transaction_status
  extension: required
  label: "Transaction/Claim"
  fields: [ALL_FIELDS*,-drug.drug_brand_generic, -ar_plan.plan_processord_identifier_aging]
  description: "Displays transaction claims"

  ## ENFORCING INNER JOIN ALWAYS - UNTIL AR TEAM IS ABLE TO CLEAN UP INCORRECT DATA IN SOURCE SYSTEM THAT HAS MISS MATCHED CHAIN_ID AND NHIN_STORE_ID
  always_join: [ar_store]
  sql_always_where: ${ar_transaction_status.transaction_status_deleted} = 'N' ;;

  always_filter: {
    filters: {
      field: ar_report_calendar_global.report_period_filter
      value: "Last 1 Month"
    }

    filters: {
      field: ar_report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Month"
    }

    filters: {
      field: ar_report_calendar_global.this_year_last_year_filter
      value: "No"
    }

    filters: {
      field: date_to_use_filter
      value: "REPORTABLE SALES"
    }
  }

  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_transaction_status.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_transaction_status.chain_id} = ${ar_store.chain_id} AND ${ar_transaction_status.nhin_store_id} = ${ar_store.nhin_store_id} AND ${ar_store.source_system_id} = 8 and ${ar_store.store_ar_activity_flag} ;; ## activity flag yesno evaluates to = Y
    relationship: many_to_one
  }

  join: store_alignment {
    fields: [store_alignment.ar_pharmacy_specialty_retail]
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.chain_id} = ${store_alignment.chain_id} AND  ${ar_store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 8 ;;
    relationship: one_to_one
  }

  join: ar_transaction_info {
    view_label: "Transaction Info"
    type: inner
    sql_on: ${ar_transaction_status.chain_id} = ${ar_transaction_info.chain_id} AND ${ar_transaction_status.transaction_id} = ${ar_transaction_info.transaction_id}  ;;
    relationship: one_to_one
  }

# ERXDWPS-6213 - expose new table
  join: ar_transaction_note {
    view_label: "Transaction Note"
    type: inner
    sql_on: ${ar_transaction_status.chain_id} = ${ar_transaction_note.chain_id} AND ${ar_transaction_status.transaction_id} = ${ar_transaction_note.transaction_id} and ${ar_transaction_note.transaction_note_deleted} = 'N';;
    relationship: one_to_many
  }

# ERXDWPS-? ARL-61 - expose table
  join: ar_transaction_patient {
    view_label: "Transaction Patient"
    type: inner
    sql_on: ${ar_transaction_status.chain_id} = ${ar_transaction_patient.chain_id} AND ${ar_transaction_status.transaction_id} = ${ar_transaction_patient.transaction_id}  ;;
    relationship: one_to_one
  }

# ERXDWPS-5430 Changes
  join: chain_pbm_network_crosswalk {
    view_label: "PBM Network Crosswalk"
    type: left_outer
    sql_on: ${ar_transaction_info.chain_id} = ${chain_pbm_network_crosswalk.chain_id} AND NVL(${ar_transaction_info.transaction_info_bin_number},'NULL') = NVL(${chain_pbm_network_crosswalk.bin},'NULL') AND NVL(${ar_transaction_info.transaction_info_pcn_number},'NULL') = NVL(${chain_pbm_network_crosswalk.pcn},'NULL') AND NVL(${ar_transaction_info.transaction_info_group_code},'NULL') = NVL(${chain_pbm_network_crosswalk.group},'NULL') ;; # for paper claims, it is possible not to have a BIN and PCN as online claims are only mandated to have a BIN and PCN
    relationship: many_to_one
  }

  join: ar_processor {
    view_label: "Payer Info"
    type: left_outer
    sql_on: ${ar_transaction_status.processor_id} = ${ar_processor.processor_id}  ;;
    relationship: many_to_one
  }

  ## Uniqueness of Non Contract Rate DIR table includes Days Supply
  ## PER AR TEAM, IF THE GROUP CODE IN THE NON CONTRACT RATE TABLE IS NULL IT SHOULD MATCH ALL BIN PCNs
  join: ar_non_contract_rate_dir {
    view_label: "Non Contract Rate DIR"
    type: left_outer
    sql_on: ( ${ar_transaction_info.chain_id} = ${ar_non_contract_rate_dir.chain_id}
                    AND ${ar_transaction_info.transaction_info_bin_number} = ${ar_non_contract_rate_dir.bin}
                    AND ${ar_transaction_info.transaction_info_pcn_number} = ${ar_non_contract_rate_dir.pcn}
                    AND (CASE WHEN ${ar_non_contract_rate_dir.group_code} IS NULL THEN (1 = 1) ELSE ${ar_transaction_info.transaction_info_group_code} = ${ar_non_contract_rate_dir.group_code} END)
                    AND ${ar_transaction_info.transaction_info_drug_brand_generic_reference} = ${ar_non_contract_rate_dir.brand_generic}
                    AND ${ar_transaction_info.transaction_info_days_supply_dim} >= ${ar_non_contract_rate_dir.days_supply_start}
                    AND ${ar_transaction_info.transaction_info_days_supply_dim} <= ${ar_non_contract_rate_dir.days_supply_end}
                    AND NVL(${ar_transaction_info.transaction_info_network_reimbursement_id},'NULL') = NVL(${ar_non_contract_rate_dir.network_id},'NULL') )  ;; #ERXDWPS-6327 Changes
    relationship: many_to_one
  }

  ######################################################## Transaction (INCLUDES SALES, PAYMENT, SUBMIT, etc) & PAYMENT Event, CHECK HEADER & REMIT CHARGE Details #############################################

  join: ar_transaction_event {
    view_label: "Transaction Event"
    type: left_outer
    sql_on: ${ar_transaction_status.chain_id} = ${ar_transaction_event.chain_id} AND ${ar_transaction_status.transaction_id} = ${ar_transaction_event.transaction_id}  ;;
    relationship: one_to_many
  }

  join: ar_transaction_event_latest {
    view_label: "Transaction Event"
    type: left_outer
    fields: [transaction_event_current_state]
    sql_on: ${ar_transaction_event.chain_id} = ${ar_transaction_event_latest.chain_id} AND ${ar_transaction_event.transaction_event_id} = ${ar_transaction_event_latest.transaction_event_id}  ;;
    relationship: one_to_one
  }

  join: ar_payment_event {
    view_label: "Payment Event"
    type: left_outer
    sql_on: ${ar_transaction_event.chain_id} = ${ar_payment_event.chain_id} AND ${ar_transaction_event.transaction_event_id} = ${ar_payment_event.payment_event_id} and ${ar_payment_event.deleted} = 'N' ;;
    relationship: one_to_one
  }

  join: ar_write_off_event {
    view_label: "Write Off Event"
    type: left_outer
    sql_on: ${ar_transaction_event.chain_id} = ${ar_write_off_event.chain_id} AND ${ar_transaction_event.transaction_event_id} = ${ar_write_off_event.write_off_event_id} ;;
    relationship: one_to_one
  }

  join: ar_check_header {
    view_label: "NHIN Check Header"
    type: left_outer
    sql_on: ${ar_payment_event.chain_id} = ${ar_check_header.chain_id} AND ${ar_payment_event.nhin_check_number} = ${ar_check_header.nhin_check_number} and ${ar_check_header.deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: ar_remit_charge {
    view_label: "Remit Charge"
    type: left_outer
    sql_on: ${ar_check_header.chain_id} = ${ar_remit_charge.chain_id} AND ${ar_check_header.nhin_check_number} = ${ar_remit_charge.nhin_check_number} and ${ar_store.chain_id} = ${ar_remit_charge.chain_id} AND ${ar_store.nhin_store_id} = ${ar_remit_charge.nhin_store_id} and ${ar_remit_charge.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: ar_remit_charge_detail {
    view_label: "Remit Charge"
    type: left_outer
    sql_on: ${ar_check_header.chain_id} = ${ar_remit_charge_detail.chain_id} AND ${ar_check_header.nhin_check_number} = ${ar_remit_charge_detail.nhin_check_number} and ${ar_store.chain_id} = ${ar_remit_charge_detail.chain_id} AND ${ar_store.nhin_store_id} = ${ar_remit_charge_detail.nhin_store_id} and ${ar_remit_charge.deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: ar_remit_charge_description {
    view_label: "Remit Charge"
    type: left_outer
    sql_on: ${ar_check_header.processor_id} = ${ar_remit_charge_description.processor_id} AND ${ar_remit_charge_detail.plb_code} = ${ar_remit_charge_description.plb_code} ;;
    relationship: many_to_one
  }

  join: ar_end_period {
    view_label: "Week End Period"
    type: left_outer
    sql_on: ${ar_transaction_event.chain_id} = ${ar_end_period.chain_id} AND ${ar_transaction_event.nhin_store_id} = ${ar_end_period.nhin_store_id} AND ${ar_transaction_event.transaction_event_week_end_date} = ${ar_end_period.week_end_date} AND ${ar_transaction_event.plan_id} = ${ar_end_period.plan_id}  ;;
    relationship: many_to_one
  }

  join: ar_chain_last_week_end_date {
    view_label: "Production Cycle"
    type: inner
    sql_on: ${ar_chain.chain_id} = ${ar_chain_last_week_end_date.chain_id} ;;
    relationship: one_to_one
  }

  join: ar_production_cycle_tracking {
    view_label: "Production Cycle"
    type: left_outer
    sql_on: ${ar_transaction_event.chain_id} = ${ar_production_cycle_tracking.chain_id} AND ${ar_transaction_event.transaction_event_week_end_date} = ${ar_production_cycle_tracking.production_cycle_week_end_date} AND ${ar_production_cycle_tracking.deleted} = 'N' ;;
    relationship: many_to_one
  }

  ######################################################## CONTRACT RATE, THIRD PARTY/PRICING, CLAIM TO CONTRACT RATE and CONTRACT RATE DIR Details #############################################

  join: ar_claim_to_contract_rate {
    view_label: "Contract Rate"
    type: left_outer
    sql_on: ${ar_transaction_status.chain_id} = ${ar_claim_to_contract_rate.chain_id} AND ${ar_transaction_status.transaction_id} = ${ar_claim_to_contract_rate.transaction_id} ;;
    relationship: one_to_one
  }

  join: ar_third_party_contract {
    view_label: "Third Party Contract"
    type: left_outer
    sql_on: ${ar_claim_to_contract_rate.chain_id} = ${ar_third_party_contract.chain_id} and ${ar_claim_to_contract_rate.third_party_contract_id} = ${ar_third_party_contract.third_party_contract_id} and ${ar_third_party_contract.third_party_contract_deleted} = 'N' ;;
    relationship: many_to_one
  }

  join: ar_contract_rate_pricing {
    view_label: "Contract Rate Pricing"
    type: left_outer
    sql_on: ${ar_claim_to_contract_rate.chain_id} = ${ar_contract_rate_pricing.chain_id} and ${ar_claim_to_contract_rate.contract_rate_id} = ${ar_contract_rate_pricing.contract_rate_id} and ${ar_contract_rate_pricing.contract_rate_pricing_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: ar_contract_rate {
    view_label: "Contract Rate"
    type: left_outer
    sql_on: ${ar_claim_to_contract_rate.chain_id} = ${ar_contract_rate.chain_id} and ${ar_claim_to_contract_rate.contract_rate_id} = ${ar_contract_rate.contract_rate_id} and ${ar_claim_to_contract_rate.third_party_contract_id} = ${ar_contract_rate.third_party_contract_id} and ${ar_contract_rate.contract_rate_deleted} = 'N' ;;
    relationship: many_to_one
  }

  ## RELATIONSHIP IS ONE TO ONE NOW BASED ON DERIVED VIEW
  join: ar_contract_rate_dir_latest {
    view_label: "Contract Rate DIR"
    type: left_outer
    sql_on: ${ar_contract_rate.chain_id} = ${ar_contract_rate_dir_latest.chain_id} and ${ar_contract_rate.contract_rate_id} = ${ar_contract_rate_dir_latest.contract_rate_id} ;;
    relationship: one_to_one
  }

  join: ar_plan {
    view_label: "Plan"
    type: inner
    sql_on: ${ar_transaction_status.plan_id} = ${ar_plan.plan_id} AND ${ar_plan.chain_id} = 3000 and ${ar_plan.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_plan_aging {
    from: ar_plan
    view_label: "Plan"
    type: inner
    fields: [plan_processord_identifier_aging]
    sql_on: ${ar_plan.chain_id} = ${ar_plan_aging.chain_id} AND ${ar_plan.source_system_id} = ${ar_plan_aging.source_system_id} and ${ar_plan.plan_carrier_id} = ${ar_plan_aging.plan_id} ;;
    relationship: many_to_one
  }

  join: ar_drug_cost_hist_awp {
    from: ar_drug_cost_hist
    view_label: "Drug Cost History - AWP"
    type: left_outer
    sql_on: ${ar_transaction_info.drug_ndc} = ${ar_drug_cost_hist_awp.drug_ndc} AND ${ar_transaction_status.transaction_status_fill_date} between ${ar_drug_cost_hist_awp.drug_cost_effective_start_date} and ${ar_drug_cost_hist_awp.drug_cost_effective_end_date} and  ${ar_drug_cost_hist_awp.drug_cost_type} = 'AWP MS';;
    relationship: many_to_one
  }

  join: ar_drug_cost_hist_wac {
    from: ar_drug_cost_hist
    view_label: "Drug Cost History - WAC"
    type: left_outer
    sql_on: ${ar_transaction_info.drug_ndc} = ${ar_drug_cost_hist_wac.drug_ndc} AND ${ar_transaction_status.transaction_status_fill_date} between ${ar_drug_cost_hist_wac.drug_cost_effective_start_date} and ${ar_drug_cost_hist_wac.drug_cost_effective_end_date} and  ${ar_drug_cost_hist_wac.drug_cost_type} = 'WAC MS';;
    relationship: many_to_one
  }

  join: drug {
    from:  ar_drug
    view_label: "Drug"
    type: left_outer
    sql_on: ${ar_transaction_info.drug_ndc} = ${drug.drug_ndc} and ${drug.drug_source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: actualrx_drug_exclusion {
    from:  ar_actualrx_drug_exclusion
    view_label: "ActualRx Drug Exclusion"
    type: left_outer
    sql_on: ${ar_transaction_info.chain_id} = ${actualrx_drug_exclusion.chain_id} and case when ${actualrx_drug_exclusion.actualrx_drug_exclusion_drug_ndc} is not null then ${ar_transaction_info.drug_ndc} = ${actualrx_drug_exclusion.actualrx_drug_exclusion_drug_ndc}
                 else ${drug.drug_gpi} = ${actualrx_drug_exclusion.actualrx_drug_exclusion_gpi}
            end ;;
    relationship: many_to_one
  }

  join: suspended_tx_info {
    from:  ar_suspended_tx_info
    view_label: "Suspended Tx Info"
    type: left_outer
    sql_on: ${ar_transaction_info.chain_id} = ${suspended_tx_info.chain_id} and ${ar_transaction_info.transaction_id} = ${suspended_tx_info.transaction_id} ;;
    relationship: many_to_one
  }
######################################################## Report Calendar Global Integration (Fiscal Calendar Implementation #############################################

  ##### Only Transaction Satus Sold Date (Reportable Sales) and Transaction Event Week End Date currently ties to fiscal calendar ####
  join: ar_report_calendar_global {
    fields: [global_calendar_candidate_list*]
    view_label: "Transaction/Claim"
    type: inner
    relationship: many_to_one
    sql_on:  CASE WHEN {% parameter ar_transaction_status.date_to_use_filter %} = 'REPORTABLE SALES' THEN ${ar_transaction_status.chain_id} ELSE ${ar_transaction_event.chain_id} END = ${ar_report_calendar_global.chain_id}
      and CASE WHEN {% parameter ar_transaction_status.date_to_use_filter %} = 'REPORTABLE SALES' THEN ${ar_transaction_status.reportable_sales_date} ELSE ${ar_transaction_event.transaction_event_week_end_date} END = ${ar_report_calendar_global.calendar_date} ;;
  }

  join: report_period_timeframes {
    from: ar_timeframes
    view_label: "Transaction/Claim"
    type: inner
    sql_on: ${report_period_timeframes.calendar_date} = ${ar_report_calendar_global.report_date} AND ${report_period_timeframes.chain_id} = ${ar_report_calendar_global.chain_id} ;;
    relationship: many_to_one
  }

  join: rpt_sales_timeframes {
    from: ar_timeframes
    view_label: "Transaction/Claim"
    type: left_outer
    sql_on: ( (    ${rpt_sales_timeframes.calendar_date} =
              ( CASE WHEN (    {% parameter ar_report_calendar_global.this_year_last_year_filter %} = 'Yes'
              AND {% parameter ar_transaction_status.date_to_use_filter %} = 'REPORTABLE SALES') THEN ${ar_report_calendar_global.report_date} ELSE ${ar_transaction_status.reportable_sales_date} END)
              AND ${rpt_sales_timeframes.chain_id} = ${ar_transaction_status.chain_id}
              )
              ) ;;
    relationship: many_to_one
  }

  join: rpt_transaction_week_end_timeframes {
    from: ar_timeframes
    view_label: "Transaction Event"
    type: left_outer
    sql_on: ( (    ${rpt_transaction_week_end_timeframes.calendar_date} =
              ( CASE WHEN (    {% parameter ar_report_calendar_global.this_year_last_year_filter %} = 'Yes'
              AND {% parameter ar_transaction_status.date_to_use_filter %} = 'TRANSACTION EVENT WEEK END') THEN ${ar_report_calendar_global.report_date} ELSE ${ar_transaction_event.transaction_event_week_end_date} END)
              AND ${rpt_transaction_week_end_timeframes.chain_id} = ${ar_transaction_event.chain_id}
              )
              ) ;;
    relationship: many_to_one
  }
}

#[ARL-100] - Expose AUDIT_EVENT in Looker (SP/CC) - Added new base explore
explore: ar_audit_event_base {
  view_name: ar_audit_event
  extension: required
  label: "AuditRx"
  fields: [ALL_FIELDS*]
  description: "Displays audit related data based on audit notices received from your third party payer"

  sql_always_where: ${ar_audit_event.audit_event_deleted} = 'N' ;;

  always_filter: {
    filters: {
      field: ar_audit_event.date_to_use_filter
      value: "AUDIT DATE"
    }

    filters: {
      field: ar_report_calendar_global.report_period_filter
      value: "Last 1 Month"
    }

    filters: {
      field: ar_report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Month"
    }

    filters: {
      field: ar_report_calendar_global.this_year_last_year_filter
      value: "No"
    }
  }

  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_audit_event.chain_id} = ${ar_chain.chain_id} AND ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_audit_event_notes {
    view_label: "Audit Event Notes"
    type: left_outer
    sql_on: ${ar_audit_event.chain_id} = ${ar_audit_event_notes.chain_id} AND ${ar_audit_event.audit_event_audit_event_id} = ${ar_audit_event_notes.audit_event_notes_audit_event_id} and ${ar_audit_event_notes.audit_event_notes_deleted} = 'N';;
    relationship: one_to_many
  }

  ######################################################## Report Calendar Global Integration (Fiscal Calendar Implementation #############################################
  join: ar_report_calendar_global {
    fields: [global_calendar_candidate_list*]
    view_label: "AuditRx"
    type: inner
    relationship: many_to_one
    sql_on:  ${ar_audit_event.chain_id} = ${ar_report_calendar_global.chain_id}
    AND CASE WHEN {% parameter ar_audit_event.date_to_use_filter %} = 'AUDIT DATE' THEN ${ar_audit_event.audit_event_audit_date} ELSE
    CASE WHEN {% parameter ar_audit_event.date_to_use_filter %} = 'AUDIT DUE DATE' THEN ${ar_audit_event.audit_event_audit_due_date} ELSE
    ${ar_audit_event.audit_event_follow_up_date} END END = ${ar_report_calendar_global.calendar_date} ;;
    }

  join: report_period_timeframes {
    from: ar_timeframes
    view_label: "AuditRx"
    type: inner
    sql_on: ${report_period_timeframes.calendar_date} = ${ar_report_calendar_global.report_date}
      AND ${report_period_timeframes.chain_id} = ${ar_report_calendar_global.chain_id} ;;
    relationship: many_to_one
  }

  join: report_timeframes {
    from: ar_timeframes
    view_label: "AuditRx"
    type: left_outer
    sql_on: ${report_timeframes.calendar_date} = ${ar_audit_event.report_date}
      AND ${report_timeframes.chain_id} = ${ar_audit_event.chain_id} ;;
    relationship: many_to_one
  }
}

#[ARL-9] - Expose Payment explore within Looker(GD/AA) - Added new base explore
explore: ar_payment_base {
  view_name: ar_check_header
  extension: required
  label: "Payments"
  fields: [ALL_FIELDS*]
  description: "Displays payment related data based on payments received from your third party payer"

  sql_always_where: ${ar_check_header.deleted} = 'N' ;;

  always_filter: {
    filters: {
      field: ar_check_header.date_to_use_filter
      value: "CHECK DATE"
    }

    filters: {
      field: ar_report_calendar_global.report_period_filter
      value: "Last 1 Month"
    }

    filters: {
      field: ar_report_calendar_global.analysis_calendar_filter
      value: "Fiscal - Month"
    }

    filters: {
      field: ar_report_calendar_global.this_year_last_year_filter
      value: "No"
    }
  }

  access_filter: {
    field: ar_chain.chain_id
    user_attribute: allowed_absolute_ar_chain
  }

  join: ar_chain {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_check_header.chain_id} = ${ar_chain.chain_id}  AND  ${ar_chain.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_store {
    view_label: "Pharmacy"
    type: inner
    sql_on: ${ar_unapplied_cash.chain_id} = ${ar_store.chain_id} AND ${ar_unapplied_cash.nhin_store_id}=${ar_store.nhin_store_id}  AND ${ar_store.source_system_id} = 8 and ${ar_store.store_ar_activity_flag} ;; ## activity flag yesno evaluates to = Y
    relationship: many_to_one
  }

  join: store_alignment {
    fields: [store_alignment.ar_pharmacy_specialty_retail]
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.chain_id} = ${store_alignment.chain_id} AND  ${ar_store.nhin_store_id} = ${store_alignment.nhin_store_id} ;;
    relationship: one_to_one
  }

  join: store_state_location {
    view_label: "Pharmacy"
    type: left_outer
    sql_on: ${ar_store.store_id} = ${store_state_location.contact_info_store_id} AND ${store_state_location.source_system_id} = 8 ;;
    relationship: one_to_one
  }

  join: ar_plan {
    view_label: "Plan"
    type: inner
    fields: [plan_name,carrier_code,plan_processord_identifier,plan_true_payer_code]
    sql_on: ${ar_check_header.plan_id} = ${ar_plan.plan_id} AND ${ar_plan.chain_id} = 3000 AND ${ar_plan.source_system_id} = 8 ;;
    relationship: many_to_one
  }

  join: ar_chain_last_week_end_date {
    view_label: "Production Cycle"
    type: inner
    sql_on: ${ar_chain.chain_id} = ${ar_chain_last_week_end_date.chain_id} ;;
    relationship: one_to_one
  }

  join: ar_production_cycle_tracking {
    view_label: "Production Cycle"
    type: left_outer
    sql_on: ${ar_check_header.chain_id} = ${ar_production_cycle_tracking.chain_id} AND
    ${ar_check_header.check_header_week_end} = ${ar_production_cycle_tracking.production_cycle_current_week_end_yes_no} AND
    ${ar_production_cycle_tracking.deleted} = 'N' ;;
    relationship: many_to_one
  }

  # join: ar_check_header_note {
   #  view_label: "Audit Event Note"
   #  type: left_outer
   #  sql_on: ${ar_check_header.chain_id} = ${ar_check_header_note.chain_id} AND ${ar_check_header.nhin_check_number} = ${ar_check_header_note.nhin_check_number} and ${ar_check_header_note.check_header_note_deleted} = 'N';;
    # relationship: one_to_many
 #  }

  join: ar_unapplied_cash {
    view_label: "Unapplied Cash"
    type: left_outer
    sql_on:${ar_check_header.chain_id} = ${ar_unapplied_cash.chain_id} AND
    ${ar_check_header.nhin_check_number} = ${ar_unapplied_cash.nhin_check_number} AND
    ${ar_unapplied_cash.unapplied_cash_deleted} = 'N' ;;
    relationship: one_to_many
  }

  join: ar_unapplied_cash_notes {
    view_label: "Unapplied Cash Notes"
    type: left_outer
    sql_on:${ar_unapplied_cash.chain_id} = ${ar_unapplied_cash_notes.chain_id} AND ${ar_unapplied_cash.unapplied_cash_id} = ${ar_unapplied_cash_notes.unapplied_cash_id} AND ${ar_unapplied_cash_notes.unapplied_cash_note_deleted} = 'N' ;;
    relationship: one_to_many
  }

  ######################################################## Report Calendar Global Integration (Fiscal Calendar Implementation #############################################
  join: ar_report_calendar_global {
    fields: [global_calendar_candidate_list*]
    view_label: "Payments"
    type: inner
    relationship: many_to_one
    sql_on:  ${ar_check_header.chain_id} = ${ar_report_calendar_global.chain_id}
          AND CASE WHEN {% parameter ar_check_header.date_to_use_filter %} = 'CHECK DATE' THEN ${ar_check_header.check_header_check_date} ELSE
          CASE WHEN {% parameter ar_check_header.date_to_use_filter %} = 'NHIN WEEKEND DATE' THEN ${ar_check_header.check_header_week_end_date} ELSE
          CASE WHEN {% parameter ar_check_header.date_to_use_filter %} = 'UNAPPLIED CASH FILL DATE' THEN ${ar_unapplied_cash.unapplied_cash_fill_date} ELSE
          CASE WHEN {% parameter ar_check_header.date_to_use_filter %} = 'UNAPPLIED CASH STATUS DATE' THEN ${ar_unapplied_cash.unapplied_cash_status_date} ELSE
          ${ar_check_header.check_header_customer_week_end_date} END  END END END = ${ar_report_calendar_global.calendar_date} ;;
  }

  join: report_period_timeframes {
    from: ar_timeframes
    view_label: "Payments"
    type: inner
    sql_on: ${report_period_timeframes.calendar_date} = ${ar_report_calendar_global.report_date}
      AND ${report_period_timeframes.chain_id} = ${ar_report_calendar_global.chain_id} ;;
    relationship: many_to_one
  }

  join: report_timeframes {
    from: ar_timeframes
    view_label: "Payments"
    type: left_outer
    sql_on: ${report_timeframes.calendar_date} = ${ar_check_header.report_date}
      AND ${report_timeframes.chain_id} = ${ar_check_header.chain_id} ;;
    relationship: many_to_one
  }

}

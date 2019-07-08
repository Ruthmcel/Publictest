view: explore_base_cs_lookml {}

############################################## Business & Technical Implementation Considerations ##################################################################################################################
##### 1.  This base explore will used to access all views that are currently accessing Central Services Tables in Oracle
##### 2.  Evey explorer under this master lookml has to be extended so it could be re-used across other lookml models that connects to Oracle instance
##### 3.  ALL_FIELDS* are primarily used to pull all the fields from base view and used often in conjunction with main explore and its associated child views but not with the master view
###################################################################################################################################################################################################################

########################################################### Audit Access Log ############################################################################################
explore: epr_audit_access_log_cs_base {
  extension: required
  label: "Audit Access Log"
  view_label: "Audit Access Log"

  always_filter: {
    filters: {
      field: audit_date
      value: "last 24 hours"
    }
  }

  # EPR Service Types (Master Record)
  join: epr_service_types_cs_edw {
    type: inner
    sql_on: ${epr_audit_access_log_cs.service} = ${epr_service_types_cs_edw.service} ;;
    relationship: many_to_one
  }

  join: ars_chain_cs {
    type: inner
    sql_on: ${epr_audit_access_log_cs.chain_id} = ${ars_chain_cs.chain_id} ;;
    relationship: many_to_one
  }

  join: ars_store_cs {
    type: inner
    sql_on: ${epr_audit_access_log_cs.nhin_store_id} = ${ars_store_cs.nhin_store_id} ;;
    relationship: many_to_one
  }

  join: ars_contact_info_cs {
    type: left_outer
    sql_on: ${ars_store_cs.store_id} = ${ars_contact_info_cs.contact_info_id} ;;
    relationship: one_to_one
  }
}

#############################################################################################################################################################################


########################################################### Automatic Workload Repository (Oracle) - RAC  ############################################################################################
# Notes:
# 1. Explore added as a part of ERXLPS-90 change
explore: awr_report_base {
  extension: required
  label: "Oracle Automatic Workload Repository"
  view_name: awr_report
  view_label: "AWR"

  always_filter: {
    filters: {
      field: end_interval_date
      value: "last 24 hours"
    }
  }

  join: awr_foreground_wait_class {
    type: inner
    sql_on: ${awr_report.awr_rpt_id} = ${awr_foreground_wait_class.awr_rpt_id} ;;
    relationship: one_to_one
  }

  join: awr_foreground_wait_cl_unpivot {
    type: inner
    sql_on: ${awr_report.awr_rpt_id} = ${awr_foreground_wait_cl_unpivot.awr_rpt_id} ;;
    relationship: one_to_many
  }

  join: awr_global_cache_enqueue {
    type: inner
    sql_on: ${awr_report.awr_rpt_id} = ${awr_global_cache_enqueue.awr_rpt_id} ;;
    relationship: one_to_many
  }

  join: awr_cpu_statistic {
    type: inner
    sql_on: ${awr_global_cache_enqueue.awr_rpt_id} = ${awr_cpu_statistic.awr_rpt_id} AND ${awr_global_cache_enqueue.instance} = ${awr_cpu_statistic.instance} ;;
    relationship: one_to_many
  }

  join: awr_global_block {
    type: inner
    sql_on: ${awr_global_cache_enqueue.awr_rpt_id} = ${awr_global_block.awr_rpt_id} AND ${awr_global_cache_enqueue.instance} = ${awr_global_block.instance} ;;
    relationship: one_to_many
  }

  join: awr_io_statistic {
    type: inner
    sql_on: ${awr_global_cache_enqueue.awr_rpt_id} = ${awr_io_statistic.awr_rpt_id} AND ${awr_global_cache_enqueue.instance} = ${awr_io_statistic.instance} ;;
    relationship: one_to_many
  }

  join: awr_ping_latency {
    #   There could be one or zero ping latency pertaining to a AWR
    type: left_outer
    sql_on: ${awr_report.awr_rpt_id} = ${awr_ping_latency.awr_rpt_id} ;;
    relationship: one_to_one
  }
}

################################################################################################################################################################

########################################################### Care RX - Patient ############################################################################################
## -- Care Rx Oracle connection -- ##
explore: carerx_patient_base {
  extension: required
  label: "Patient"
  view_name: carerx_patient
  description: "The Patient Explore displays information about Care Rx Patients regardless of whether they are linked to an active Programs or Sessions."

  join: carerx_patient_link {
    type: left_outer
    sql_on: ${carerx_patient.id} = ${carerx_patient_link.current_patient_id} ;;
    relationship: many_to_one
  }

  join: carerx_chain_patient_data {
    type: left_outer
    sql_on: ${carerx_patient_link.original_patient_id} = ${carerx_chain_patient_data.original_patient_id} ;;
    relationship: one_to_many
  }
}

########################################################### Care RX - Patient Third Party ############################################################################################
## -- Care Rx Oracle connection -- ##
explore: carerx_patient_third_party_base {
  extension: required
  label: "Patient Third Party"
  view_name: carerx_patient_tp
  view_label: "Third Party"
  description: "The Patient Third Party Explore displays information about Care Rx Patients, their Third Party information, Cardholder information, and stored Payer information."

  join: carerx_third_party {
    view_label: "Third Party Payer"
    type: inner
    sql_on: ${carerx_patient_tp.third_party_id} = ${carerx_third_party.id} ;;
    relationship: many_to_one
  }

  join: carerx_patient_link {
    type: inner
    sql_on: ${carerx_patient_tp.original_patient_id} = ${carerx_patient_link.original_patient_id} ;;
    relationship: many_to_one
  }

  join: carerx_patient {
    view_label: "Patient"
    type: inner
    sql_on: ${carerx_patient_link.current_patient_id} = ${carerx_patient.id} ;;
    relationship: many_to_one
  }

  join: carerx_chain_patient_data {
    view_label: "Patient"
    type: left_outer
    sql_on: ${carerx_patient_link.original_patient_id} = ${carerx_chain_patient_data.original_patient_id} ;;
    relationship: one_to_many
  }

  join: carerx_chain {
    view_label: "Chain"
    type: inner
    sql_on: ${carerx_chain_patient_data.chain_id} = ${carerx_chain.chain_id} ;;
    relationship: many_to_one
  }
}

#############################################################################################################################################################################

########################################################### Care RX - Patient Program Session ############################################################################################
## -- Care Rx Oracle connection -- ##
explore: carerx_patient_program_session_base {
  extension: required
  label: "Patient Program Session"
  view_name: carerx_patient_program_link
  view_label: "Patient Program"
  description: "The Patient Program Session Explore displays information about Care Rx Programs and Patient's activity as it pertains to Care Rx Sessions in related Programs."

  #ERXLPS-1891 Changes
  join: carerx_mtm_session {
    view_label: "Session"
    type: left_outer
    sql_on: ${carerx_patient_program_link.id} = ${carerx_mtm_session.patient_program_link_id} ;;
    relationship: one_to_many
  }

  join: carerx_prgrm_deactivate_reason {
    view_label: "Patient Program"
    type: inner
    sql_on: ${carerx_patient_program_link.program_deactivate_reason_id} = ${carerx_prgrm_deactivate_reason.id} ;;
    relationship: many_to_one
  }

  join: carerx_program {
    view_label: "Program"
    type: inner
    sql_on: ${carerx_patient_program_link.program_id} = ${carerx_program.id} ;;
    relationship: many_to_one
  }

  join: carerx_chain {
    view_label: "Chain"
    type: inner
    sql_on: ${carerx_program.chain_id} = ${carerx_chain.id} ;;
    relationship: many_to_one
  }

  join: carerx_patient_link {
    type: inner
    sql_on: ${carerx_patient_program_link.original_patient_id} = ${carerx_patient_link.original_patient_id} ;;
    relationship: many_to_one
  }

  join: carerx_patient {
    view_label: "Patient"
    type: inner
    sql_on: ${carerx_patient_link.current_patient_id} = ${carerx_patient.id} ;;
    relationship: many_to_one
  }

  join: carerx_chain_patient_data {
    view_label: "Patient"
    type: left_outer
    sql_on: ${carerx_patient_link.original_patient_id} = ${carerx_chain_patient_data.original_patient_id} ;;
    ## Due to the UK on CHAIN ID and ORIGINAL PATIENT ID in the Chain Patient Data table. Is as if CareRx is planning to have the same patient at a different chain
    relationship: one_to_many
  }
}

#############################################################################################################################################################################

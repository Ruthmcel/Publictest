view: explore_base_carerx_dss_lookml {}

############################################## Business & Technical Implementation Considerations ##################################################################################################################
##### 1.  This base explore will used to access all views that are currently accessing CareRx related tables in Snowflake
##### 2.  Evey explore under this master lookml has to be extended so it could be re-used across other lookml models that connects to Snowflake instance
##### 3.  ALL_FIELDS* are primarily used to pull all the fields from base view and used often in conjunction with main explore and its associated child views but not with the master view
###################################################################################################################################################################################################################

########################################################### Inventory Movement Detail Snapshot [ERXDWPS-5100] ############################################################################################
explore: carerx_clinical_session_patient_interview_base {
  extension: required
  label: "Clinical Session Patient Interview"
  view_label: "Clinical Session Patient Interview"
  description: "The Clinical Session Patient Interview Explore displays Care Rx clinical patient activity from clinical programs"
  view_name: carerx_clinical_session_patient_interview

  fields: [
    ALL_FIELDS*,
    -store_alignment.exist_in_store_alignment #ERXDWPS-8224
  ]

  access_filter: {
    field: chain.chain_id
    user_attribute: allowed_carerx_chain
  }

#   always_filter: {
#     filters: {
#       field: activity_date
#       value: "1 days ago for 1 days"
#     }
#   }

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
    sql_on: ${carerx_clinical_session_patient_interview.chain_id} = ${chain.chain_id}
      AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: store {
    fields: [ALL_FIELDS*,-store.phone_number,-store.fax_number]
    view_label: "Pharmacy - Central"
    #fields: [store_number, store_name, deactivated_date, count, nhin_store_id]
    type: inner
    sql_on: ${carerx_clinical_session_patient_interview.chain_id}      = ${store.chain_id}
        AND ${carerx_clinical_session_patient_interview.mtm_session_completed_nhin_store_id} = ${store.nhin_store_id}
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

  }

#############################################################################################################################################################################

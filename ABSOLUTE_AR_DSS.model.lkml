connection: "thelook"

# include the base lookml file if not a view file
include: "explore.base_ar_dss"

# included only ar_* views and other views which are used in base explore joins
include: "ar_*.view"
include: "store_alignment.view"
include: "store_state_location.view"
#include: "drug.view" - [ERXDWPS-6310] ARL-35 Removing this becuase we have added new ar_drug view.
include: "fiscal_calendar_grain.view"
include: "chain_pbm_network_crosswalk.view"   # ERXDWPS-5430 Changes

# include all dashboards in this project
include: "ardss_*.dashboard"

label: "Absolute AR Decision Support System"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

#ARL-41 - Making changes for testing purpose.
persist_with: ar_customer_cache_info

datagroup: ar_customer_cache_info {
  sql_trigger: SELECT MAX(ev.event_begin_date) FROM etl_manager.event ev INNER JOIN etl_manager.EVENT_JOB ej ON ev.event_id = ej.event_id WHERE ev.event_type = 'STAGE TO EDW ETL' AND ev.refresh_frequency = 'D' AND ej. job_name like 'JOB_AR_%' and ej. job_name not like 'JOB_ARS_%' ;;
  max_cache_age: "25 hours"
}

#[ERXLPS-6257] - extending from base explore.
explore: ar_transaction_status {
  extends: [ar_transaction_status_base]

  #[ERXDWPS-5064] - Join added to utlize new filter to schedule reports based on fiscal calendar start and end month/quarter/year.
  join: fiscal_calendar_grain {
    view_label: "Transaction Status"
    type: inner
    fields: [fiscal_calendar_schedule_with_delayed_filter]
    sql_on: ${ar_transaction_status.chain_id} = ${fiscal_calendar_grain.chain_id} AND ${fiscal_calendar_grain.model_name} = 'ABSOLUTE_AR_DSS' AND ${fiscal_calendar_grain.calendar_grain} = {% parameter fiscal_calendar_grain.fiscal_calendar_schedule_with_delayed_filter %} ;;
    relationship: many_to_one
  }
}

#[ARL-100] - Expose AUDIT_EVENT in Looker (SP/CC) - Extending from Base explore.
explore: ar_audit_event {
  extends: [ar_audit_event_base]
}

#[ARL-9] - Payment explore within Looker - Extending from Base explore.
explore: ar_check_header {
  extends: [ar_payment_base]
}

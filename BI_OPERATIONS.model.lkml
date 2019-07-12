label: "Business Intelligence Operations"

connection: "thelook"

# include all views in this project
include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
include: "exploredx_chain_usage*.dashboard"

#persist_for: "6 hours" #[ERXLPS-6431]

#[ERXLPS-6431]
persist_with: etl_cache_info

datagroup: etl_cache_info {
  sql_trigger: SELECT MAX(event_id) FROM etl_manager.event ;; # for every new ETL run the cache would get expired and come from DB irrespective of Explore
  max_cache_age: "25 hours"
}


# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

explore: etl_manager_event {
  label: "ETL/Data Load"
  view_label: "Event"
  #   sql_always_where: ${etl_manager_event_job.job_name} NOT IN  ('MASTER_CONTROLLER' ,'SP_MASTER_CONTROLLER')   This logic is explicitly applied to the individual reports to list different event types....
  always_filter: {
    filters: {
      field: event_begin_date
      value: "last 30 days"
    }

    filters: {
      field: status
      value: "Success"
    }

    filters: {
      field: load_type
      value: "Regular"
    }

    filters: {
      field: refresh_frequency
      value: "Daily,Hourly"
    }
  }

  description: "Displays information pertaining to ETL/job processing"

  join: chain {
    view_label: "Pharmacy"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      chain_deactivated_date,
      chain_open_or_closed,
      count
    ]
    type: inner
    sql_on: ${etl_manager_event.chain_id} = ${chain.chain_id} AND ${chain.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: etl_manager_event_job {
    view_label: "Event Job"
    type: left_outer
    sql_on: ${etl_manager_event.event_id} = ${etl_manager_event_job.event_id} ;;
    relationship: one_to_many
  }

  join: etl_manager_event_job_chain {
    view_label: "Event Job Chain"
    type: left_outer
    sql_on: ${etl_manager_event_job.event_id} = ${etl_manager_event_job_chain.event_id} and ${etl_manager_event_job.job_name} = ${etl_manager_event_job_chain.job_name};;
    relationship: one_to_many
  }

  join: etl_manager_event_job_chain_description {
    from:  chain
    view_label: "Event Job Chain Description"
    fields: [
      chain_id,
      chain_name,
      master_chain_name,
      count
    ]
    type: left_outer
    sql_on: ${etl_manager_event_job_chain.chain_id} = ${etl_manager_event_job_chain_description.chain_id} AND ${etl_manager_event_job_chain_description.source_system_id} = 5 ;;
    relationship: many_to_one
  }

  join: etl_manager_event_warehouse {
    view_label: "Event"
    type: left_outer
    sql_on: ${etl_manager_event.event_id} = ${etl_manager_event_warehouse.event_id} ;;
    relationship: one_to_one
  }

  join: etl_manager_event_job_log {
    view_label: "Event Job Log"
    type: left_outer
    sql_on: ${etl_manager_event_job.event_id} = ${etl_manager_event_job_log.event_id} AND ${etl_manager_event_job.job_name} = ${etl_manager_event_job_log.job_name} ;;
    relationship: one_to_many
  }

  join: etl_manager_event_job_error_log {
    view_label: "Event Job Error Log"
    type: left_outer
    sql_on: ${etl_manager_event_job.event_id} = ${etl_manager_event_job_error_log.event_id} AND ${etl_manager_event_job.job_name} = ${etl_manager_event_job_error_log.job_name} ;;
    relationship: one_to_many
  }
}

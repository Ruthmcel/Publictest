#[ERXLPS-507] This view is created to get EPS source system lag for each store at the time of STAGE LOAD ETL successful run. Used TASK_HISTORY table To get max(source_timestamp) for each store.
view: sync_lag_eps {
  derived_table: {
    sql: with
      latest_eps_stage_load
      as (select job_begin_date
            from etl_manager.event_job
           where job_name = 'JOB_EPS_TASK_HISTORY_STAGE'
             and status = 'S'
           order by event_id desc
             limit 1 -- to get latest STAGE LOAD ETL start time. This will be used across all stores as EPS Stage load time
         ),
      eps_task_history
      as (select 'TASK_HISTORY' eps_table,
                 d.chain_id,
                 d.meta_nhin_store_id nhin_store_id,
                 max(d.source_timestamp) latest_eps_store_timestamp,
                 l.job_begin_date last_eps_stage_load_utc
            from eps_stage.task_history_stage d,
                 latest_eps_stage_load l
           group by d.chain_id,
                    d.meta_nhin_store_id,
                    l.job_begin_date
         )
      select *
        from eps_task_history
       ;;
  }

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.chain_id ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.nhin_store_id ;;
  }

  dimension_group: latest_timestamp_from_eps_store {
    label: "EPS Stage Latest Source Timestamp"
    description: "Latest timestamp, in local store timezone, on data received from EPS-Symmetric"
    type: time
    timeframes: [time]
    sql: ${TABLE}.latest_eps_store_timestamp ;;
  }

  dimension_group: latest_UTC_timestamp_from_eps_store {
    label: "EPS Stage Latest Source Timestamp UTC"
    description: "Latest timestamp, converted to UTC, on data received from EPS-Symmetric"
    type: time
    timeframes: [time]
    sql: convert_timezone(nvl(${store_to_time_zone_cross_ref.time_zone}, 'UTC'), 'UTC', ${TABLE}.latest_eps_store_timestamp) ;;
  }

  dimension_group: last_eps_stage_load_utc {
    type: time
    label: "Last EPS Stage Load"
    description: "Last EPS Stage load time, in UTC"
    timeframes: [time]
    sql: ${TABLE}.last_eps_stage_load_utc ;;
  }

  dimension: eps_lag_minutes {
    label: "EPS Stage Data Lag (Minutes)"
    description: "EPS Sync lag as of last stage load (Minutes). Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of store"
    type: number
    sql: round(timestampdiff('minute', ${latest_UTC_timestamp_from_eps_store_time}, ${last_eps_stage_load_utc_time}),0) ;;
  }

  dimension: eps_lag {
    label: "EPS Stage Data Lag"
    description: "EPS Sync lag as of last stage load. Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of store. Time in minutes when less than 60 mins, in hours if between 1 hour and 24 hours and  in days if greater than or equal to 24 hours"
    type: string
    sql: case when ${eps_lag_minutes} > (24*60) then round(${eps_lag_minutes}/60/24, 1) || ' Days'
           when ${eps_lag_minutes} > 60 then round(${eps_lag_minutes}/60, 1) || ' Hours'
           else ${eps_lag_minutes} || ' Minutes'
      end
       ;;
    html: {% if {{sync_lag_eps.eps_lag_minutes._value}} >= 1440 %}
        <b><div style="color: white; background-color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% elsif {{sync_lag_eps.eps_lag_minutes._value}} >= 180 %}
        <b><div style="color: white; background-color: orange; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% else %}
        <b><div style="color: white; background-color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% endif %}
      ;;
  }

  dimension: lag_across_sources_minutes {
    label: "Stage Data Lag Across Source Systems (Minutes)"
    description: "Max sync lag across source systems (Minutes). NHIN Source system will not be considered for calculation of max sync lag. "
    view_label: "Source Systems"
    type: number
    sql: greatest(nvl(${sync_lag_eps.eps_lag_minutes}, 0), nvl(${sync_lag_epr.epr_lag_minutes}, 0), nvl(${sync_lag_host.host_lag_minutes}, 0)) ;;
  }

  filter: relevent_source_system_filter {
    label: "Source System Relevant for Current Analysis"
    view_label: "Source Systems"
    description: "Use this to select the source system you are interested in analysing"
    type: string
    default_value: "All"
    suggestions: ["All", "EPS", "EPR", "Host"]
  }

  dimension: relevent_lag {
    label: "Stage Data Lag Relevant for Current Analysis"
    description: "Stage data lag relevant for current analysis"
    view_label: "Source Systems"
    type: number
    sql: case {% parameter sync_lag_eps.relevent_source_system_filter %}
        when null then nvl(${sync_lag_eps.eps_lag_minutes}, 0)
        when 'EPS' then nvl(${sync_lag_eps.eps_lag_minutes}, 0)
        when 'EPR' then nvl(${sync_lag_epr.epr_lag_minutes}, 0)
        when 'Host' then nvl(${sync_lag_host.host_lag_minutes}, 0)
        when 'All' then greatest(nvl(${sync_lag_eps.eps_lag_minutes}, 0), nvl(${sync_lag_epr.epr_lag_minutes}, 0), nvl(${sync_lag_host.host_lag_minutes}, 0))
      end
       ;;
  }
}

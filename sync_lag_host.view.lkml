#[ERXLPS-507] This view is created to get HOST source system lag for each store at the time of STAGE LOAD ETL successful run. Used DRUG_COST table To get max(source_timestamp) for each store.
view: sync_lag_host {
  derived_table: {
    sql: with
      latest_host_stage_load
      as (select *
            from (select chain_id,
                         event_begin_date,
                         row_number() over(partition by chain_id order by event_id desc) rnk
                    from etl_manager.event
                   where event_type = 'HOST CDC STAGE LOAD - HOST'
                     and status = 'S'
                 )
           where rnk = 1 -- to get latest STAGE LOAD ETL start time.
         ),
      host_drug_cost
      as (select 'DRUG_COST' host_table,
                 d.chain_id,
                 max(d.source_timestamp) latest_host_store_timestamp,
                 l.event_begin_date last_host_stage_load_utc
            from host_cdc_stage.drug_cost d,
                 latest_host_stage_load l
           where l.chain_id = d.chain_id
             and d.source_system_id = 0
           group by d.chain_id,
                    l.event_begin_date
         )
      select *
        from host_drug_cost
       ;;
  }

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.chain_id ;;
  }

  dimension_group: latest_timestamp_from_host {
    label: "Host Stage Latest Source Timestamp"
    description: "Latest timestamp on data received from Host"
    type: time
    timeframes: [time]
    sql: ${TABLE}.latest_host_store_timestamp ;;
  }

  dimension_group: last_host_stage_load_utc {
    type: time
    label: "Last Host Stage Load"
    description: "Last Host Stage load time"
    timeframes: [time]
    sql: ${TABLE}.last_host_stage_load_utc ;;
  }

  dimension: host_lag_minutes {
    label: "Host Stage Data Lag (Minutes)"
    description: "Host Sync lag as of last stage load (Minutes). Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of chain"
    type: number
    sql: round(timestampdiff('minute', ${latest_timestamp_from_host_time}, ${last_host_stage_load_utc_time}),0) ;;
  }

  dimension: host_lag {
    label: "Host Stage Data Lag"
    description: "Host Sync lag as of last stage load. Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of chain. Time in minutes when less than 60 mins, in hours if between 1 hour and 24 hours and  in days if greater than or equal to 24 hours"
    type: string
    sql: case when ${host_lag_minutes} > (24*60) then round(${host_lag_minutes}/60/24, 1) || ' Days'
           when ${host_lag_minutes} > 60 then round(${host_lag_minutes}/60, 1) || ' Hours'
           else ${host_lag_minutes} || ' Minutes'
      end
       ;;
    html: {% if {{sync_lag_host.host_lag_minutes._value}} >= 2880 %}
        <b><div style="color: white; background-color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% elsif {{sync_lag_host.host_lag_minutes._value}} >= 1440 %}
        <b><div style="color: white; background-color: orange; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% else %}
        <b><div style="color: white; background-color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% endif %}
      ;;
  }
}

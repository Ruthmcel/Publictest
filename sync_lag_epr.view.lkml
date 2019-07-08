#[ERXLPS-507] This view is created to get EPR source system lag for each store at the time of STAGE LOAD ETL successful run. Used RX_TX table To get max(source_timestamp) for each store.
view: sync_lag_epr {
  derived_table: {
    sql: with
      latest_epr_stage_load
      as (select job_begin_date
            from etl_manager.event_job
           where job_name = 'JOB_EPR_RX_TX_STAGE'
             and status = 'S'
           order by event_id desc
             limit 1  -- to get latest STAGE LOAD ETL start time. This will be used across all stores as EPR Stage load time
         ),
      epr_rx_tx
      as (select 'RX_TX' epr_table,
                 d.chain_id,
                 d.nhin_id nhin_store_id,
                 max(d.source_timestamp) latest_epr_store_timestamp,
                 l.job_begin_date last_epr_stage_load_utc
            from epr_stage.rx_tx_stage d,
                 latest_epr_stage_load l
           group by d.chain_id,
                    d.nhin_id,
                    l.job_begin_date
         )
      select *
        from epr_rx_tx
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

  dimension_group: latest_timestamp_from_epr_store {
    label: "EPR Stage Latest Source Timestamp"
    description: "Latest timestamp on data received from EPR-Golden Gate"
    type: time
    timeframes: [time]
    sql: ${TABLE}.latest_epr_store_timestamp ;;
  }

  dimension_group: last_epr_stage_load_utc {
    type: time
    label: "Last EPR Stage Load"
    description: "Last EPR Stage load time"
    timeframes: [time]
    sql: ${TABLE}.last_epr_stage_load_utc ;;
  }

  dimension: epr_lag_minutes {
    label: "EPR Stage Data Lag (Minutes)"
    description: "EPR Sync Lag as of last stage load (Minutes). Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of store"
    type: number
    sql: round(timestampdiff('minute', ${latest_timestamp_from_epr_store_time}, ${last_epr_stage_load_utc_time}),0) ;;
  }

  dimension: epr_lag {
    label: "EPR Stage Data Lag"
    description: "EPR Sync lag as of last stage load. Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of store. Time in minutes when less than 60 mins, in hours if between 1 hour and 24 hours and  in days if greater than or equal to 24 hours"
    type: string
    sql: case when ${epr_lag_minutes} > (24*60) then round(${epr_lag_minutes}/60/24, 1) || ' Days'
           when ${epr_lag_minutes} > 60 then round(${epr_lag_minutes}/60, 1) || ' Hours'
           else ${epr_lag_minutes} || ' Minutes'
      end
       ;;
    html: {% if {{sync_lag_epr.epr_lag_minutes._value}} >= 2880 %}
        <b><div style="color: white; background-color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% elsif {{sync_lag_epr.epr_lag_minutes._value}} >= 1440 %}
        <b><div style="color: white; background-color: orange; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% else %}
        <b><div style="color: white; background-color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% endif %}
      ;;
  }
}

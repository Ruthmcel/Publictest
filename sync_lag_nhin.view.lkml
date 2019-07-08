#[ERXLPS-507] This view is created to get NHIN source system lag for each store at the time of STAGE LOAD ETL successful run. Used DRUG_COST table To get max(source_timestamp) for each store.
view: sync_lag_nhin {
  derived_table: {
    sql: with
      latest_nhin_stage_load
      as (select event_begin_date
            from etl_manager.event
           where event_type = 'HOST CDC STAGE LOAD - NHIN'
             and status = 'S'
           order by event_id desc
           limit 1 -- to get latest STAGE LOAD ETL start time.
         ),
      nhin_drug_cost
      as (select 'DRUG_COST' nhin_table,
                 d.chain_id,
                 max(d.source_timestamp) latest_nhin_store_timestamp,
                 l.event_begin_date last_nhin_stage_load_utc
            from host_cdc_stage.drug_cost d,
                 latest_nhin_stage_load l
           where d.source_system_id = 6
           group by d.chain_id,
                    l.event_begin_date
         )
      select *
        from nhin_drug_cost
       ;;
  }

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.chain_id ;;
  }

  dimension_group: latest_timestamp_from_nhin {
    label: "NHIN Stage Latest Source Timestamp"
    description: "Latest timestamp on data received from NHIN"
    type: time
    timeframes: [time]
    sql: ${TABLE}.latest_nhin_store_timestamp ;;
  }

  dimension_group: last_nhin_stage_load_utc {
    type: time
    label: "Last NHIN Stage Load"
    description: "Last NHIN Stage load time"
    timeframes: [time]
    sql: ${TABLE}.last_nhin_stage_load_utc ;;
  }

  dimension: nhin_lag_minutes {
    label: "NHIN Stage Data Lag (Minutes)"
    description: "NHIN Sync lag as of last stage load (Minutes). Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of chain 3000"
    type: number
    sql: round(timestampdiff('minute', ${latest_timestamp_from_nhin_time}, ${last_nhin_stage_load_utc_time}),0) ;;
  }

  dimension: nhin_lag {
    label: "NHIN Stage Data Lag"
    description: "NHIN Sync lag as of last stage load. Time difference between latest successful STAGE LOAD ETL run to maximum source timestamp of chain 3000. Time in minutes when less than 60 mins, in hours if between 1 hour and 24 hours and  in days if greater than or equal to 24 hours"
    type: string
    sql: case when ${nhin_lag_minutes} > (24*60) then round(${nhin_lag_minutes}/60/24, 1) || ' Days'
           when ${nhin_lag_minutes} > 60 then round(${nhin_lag_minutes}/60, 1) || ' Hours'
           else ${nhin_lag_minutes} || ' Minutes'
      end
       ;;
    html: {% if {{sync_lag_nhin.nhin_lag_minutes._value}} >= 2880 %}
        <b><div style="color: white; background-color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% elsif {{sync_lag_nhin.nhin_lag_minutes._value}} >= 1440 %}
        <b><div style="color: white; background-color: orange; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% else %}
        <b><div style="color: white; background-color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</div></b>
      {% endif %}
      ;;
  }
}

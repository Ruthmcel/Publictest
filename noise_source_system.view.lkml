view: noise_source_system {
  derived_table: {
    sql: with data as
      (
      select
          CASE WHEN LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%INSERTED%')
             THEN TRIM(SUBSTR(LOG_MESSAGE,position('=',LOG_MESSAGE,0)+1)) ELSE NULL END AS INSERT_COUNT,
          CASE WHEN LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%COPY%')
             THEN TRIM(SUBSTR(LOG_MESSAGE,position('=',LOG_MESSAGE,0)+1)) ELSE NULL END AS COPY_COUNT,
              job_name
        from
          (

          select row_number () over (partition by job_name order by log_date asc) rnk,*
            from etl_manager.event_job_log
           where event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE LOAD')
          --and job_name='JOB_EPS_TX_TP_STAGE'
            and LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%COPY%')
          )
        where rnk=1
      ),
       data1 as
       (
          select
            CASE WHEN LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%INSERTED%')
               THEN TRIM(SUBSTR(LOG_MESSAGE,position('=',LOG_MESSAGE,0)+1)) ELSE NULL END AS INSERT_COUNT,
            CASE WHEN LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%COPY%')
               THEN TRIM(SUBSTR(LOG_MESSAGE,position('=',LOG_MESSAGE,0)+1)) ELSE NULL END AS COPY_COUNT,
                job_name
          from
          (

          select row_number () over (partition by job_name order by log_date asc) rnk,*
            from etl_manager.event_job_log
           where event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE LOAD')
          --and job_name='JOB_EPS_TX_TP_STAGE'
             and LOG_MESSAGE LIKE '%=%' AND (UPPER(LOG_MESSAGE) LIKE '%INSERTED%')
          )
          where rnk=1
      )
      select data.copy_count,
             data1.insert_count,
             data.job_name,
             data.copy_count-data1.insert_count as noise,
             case when data.copy_count=0 then 0
             else (data.copy_count-data1.insert_count)/data.copy_count end as percentage
      from data, data1
      where data.job_name=data1.job_name
      order by noise desc
       ;;
  }

  ################################################################################################## Dimensions ################################################################################################


  dimension: copy_count {
    label: "Data loaded by files in _INC Tables"
    description: "Copy Count"
    type: number
    sql: ${TABLE}.copy_count ;;
  }

  dimension: insert_count {
    label: "Data Loaded by Deduplication process in _STAGE tables"
    description: "Insert Count"
    type: number
    sql: ${TABLE}.insert_count ;;
  }

  dimension: job_name {
    label: "ETL Job Name"
    description: "Job Name"
    type: string
    sql: ${TABLE}.job_name ;;
  }

  dimension: noise {
    label: "NOISE"
    description: "noise"
    type: number
    sql: ${TABLE}.noise ;;
  }

  dimension: percentage {
    label: "Percentage Noise"
    description: "Percentage Noise"
    value_format: "00.00%"
    type: number
    sql: ${TABLE}.percentage ;;
  }
}

################################################################################################## End of Dimensions ##########################

view: etl_manager_stage_jobs_history {
  derived_table: {
    sql: with event
      as (select event_id
            from (
                  select event_id,
                         refresh_frequency,
                         row_number() over(order by event_id desc) rnk
                    from etl_manager.event
                   where event_id <= to_number(nvl(case {% parameter etl_manager_stage_jobs_history.event_filter %}
                                                     when '' then null
                                                     else {% parameter etl_manager_stage_jobs_history.event_filter %}
                                                   end
                                               , event_id))
                     and event_type = nvl({% parameter etl_manager_stage_jobs_history.event_type_filter %}, 'STAGE LOAD')
                     and load_type = 'R'
                 )
           where (refresh_frequency = 'D' and rnk <= 31)
              or (refresh_frequency = 'H' and rnk <= (31*24))
      ),
      job_run_time
      as (select j.event_id,
                 job_name,
                 job_begin_date,
                 job_end_date,
                 round(timestampdiff('minute', job_begin_date, job_end_date), 2) run_time
            from etl_manager.event_job j,
                 event e
           where j.event_id = e.event_id
             and j.status = 'S'
         ),
      job_records_processed
      as (select event_id,
                 job_name,
                 records_loaded_by_copy,
                 records_inserted_into_stage,
                 records_inserted + records_updated records_processed,
                 records_deleted
            from (
                  select l.event_id,
                         job_name,
                         round(max(case when log_message like '%Total records loaded by COPY%'
                                        then substr(log_message, regexp_instr(log_message, '=')+1)
                                        else 0
                                   end
                                  ), 0) records_loaded_by_copy,
                         round(max(case when log_message like '%Total records inserted into%_STAGE=%'
                                       then substr(log_message, regexp_instr(log_message, '=')+1)
                                       else 0
                                   end
                                  ), 0) records_inserted_into_stage,
                         round(max(case when log_message like '%Total records inserted%' and log_message not like '%Total records inserted into%_STAGE=%'
                                        then substr(log_message, regexp_instr(log_message, '=')+1)
                                        else 0
                                   end
                                  ), 0) records_inserted,
                         round(max(case when log_message like '%Total records updated%'
                                        then substr(log_message, regexp_instr(log_message, '=')+1)
                                        else 0
                                   end
                                  ), 0) records_updated,
                         round(max(case when log_message like '%Total records deleted%'
                                        then substr(log_message, regexp_instr(log_message, '=')+1)
                                        else 0
                                   end
                                  ), 0) records_deleted
                    from etl_manager.event_job_log l,
                         event e
                   where l.event_id = e.event_id
                     and log_message like '%Total records%'
                   group by l.event_id,
                            job_name
                 )
         ),
      all_job_stats
      as (select t.event_id,
                 t.job_name,
                 t.run_time,
                 r.records_loaded_by_copy,
                 r.records_inserted_into_stage,
                 r.records_processed,
                 row_number() over(partition by t.job_name order by t.event_id desc) rnk
            from job_run_time t,
                 job_records_processed r
           where t.event_id = r.event_id(+)
             and t.job_name = r.job_name(+)
         )
      select job_name,
             case when rnk != 1 then run_time end run_time,
             case when rnk = 1 then run_time end latest_run_time,
             case when rnk != 1 then records_loaded_by_copy end records_loaded_by_copy,
             case when rnk = 1 then records_loaded_by_copy end latest_records_loaded_by_copy,
             case when rnk != 1 then records_inserted_into_stage end records_inserted_into_stage,
             case when rnk = 1 then records_inserted_into_stage end latest_records_inserted_into_stage,
             case when rnk !=1 then records_processed end records_processed,
             case when rnk =1 then records_processed end latest_records_processed
        from all_job_stats
       ;;
  }

  filter: event_filter {
    label: "Event To Be Analyzed"
    type: string
  }

  filter: event_type_filter {
    label: "Event Type To Be Analyzed"
    type: string
    suggestions: ["STAGE LOAD", "STAGE TO EDW ETL"]
  }

  dimension: job_name {
    type: string
    sql: regexp_replace(${TABLE}.job_name, '^JOB_|_STAGE$|_EDW$') ;;
  }

  measure: avg_run_time {
    label: "Average Job Run Time"
    description: "Last 30 Days Average Job Run Time"
    type: average
    value_format: "00.00"
    sql: (${TABLE}.run_time) ;;
  }

  measure: latest_run_time {
    label: "Latest Job Run Time"
    description: "Run time of the most recent job execution"
    type: max
    ##.##
    #X# Invalid LookML inside "measure": {"value_format":null}
    sql: ${TABLE}.latest_run_time ;;
  }

  measure: run_time_deviation {
    label: "Average Vs Latest Run Time Difference"
    type: number
    ##.##
    #X# Invalid LookML inside "measure": {"value_format":null}
    sql: abs(${latest_run_time} -  ${avg_run_time}) ;;
  }

  measure: avg_records_loaded_by_copy {
    label: "Average Records Loaded From Files"
    description: "Last 30 days average number of records loaded from files into _INC table"
    type: average
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: (${TABLE}.records_loaded_by_copy) ;;
  }

  measure: latest_records_loaded_by_copy {
    label: "Latest Records Loaded From Files"
    description: "Number of records loaded from files into stage by the most recent job execution"
    type: max
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: ${TABLE}.latest_records_loaded_by_copy ;;
  }

  measure: records_loaded_by_copy_deviation {
    label: "Average Vs Latest Number Of Records Loaded Difference"
    type: number
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: abs(${latest_records_loaded_by_copy} - ${avg_records_loaded_by_copy}) ;;
  }

  measure: avg_records_inserted_into_stage {
    label: "Average Records Inserted Into Stage"
    description: "Last 30 days average number of records inserted from _INC to _STAGE table"
    type: average
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: (${TABLE}.records_inserted_into_stage) ;;
  }

  measure: latest_records_inserted_into_stage {
    label: "Latest Records Inserted Into Stage"
    description: "Number of records inserted from _INC to _STAGE table by the most recent job execution"
    type: max
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: ${TABLE}.latest_records_inserted_into_stage ;;
  }

  measure: records_inserted_into_stage_deviation {
    label: "Average Vs Latest Number Of Records Inserted Difference"
    type: number
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: abs(${latest_records_inserted_into_stage} - ${avg_records_inserted_into_stage}) ;;
  }

  measure: file_load_vs_stage_insert_deviation {
    label: "File Load Vs Stage Insert Records Differece"
    type: number
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: abs(${avg_records_inserted_into_stage} - ${avg_records_loaded_by_copy}) ;;
  }

  measure: avg_records_processed_to_edw {
    label: "Average Records Processed in EDW ETL"
    description: "Last 30 days average number of records processed in the EDW ETL"
    type: average
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: (${TABLE}.records_processed) ;;
  }

  measure: latest_records_processed_to_edw {
    label: "Latest Records Processed in EDW ETL"
    description: "Number of records processed in the EDW ETL by the most recent job execution"
    type: max
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: ${TABLE}.latest_records_processed ;;
  }

  measure: records_processed_deviation {
    label: "Average Vs Latest Number Of Records Processed in EDW ETL"
    type: number
    value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";000"
    sql: abs(${latest_records_processed_to_edw} - ${avg_records_processed_to_edw}) ;;
  }
}

view: file_xfer_history {
  derived_table: {
    sql: with file_history as
        (
        select file_name,
               closed_by_gg,
               closed_by_gg_hh,
               closed_by_gg_day,
               picked_up_by_transfer_process,
               datediff('minute', closed_by_gg, picked_up_by_transfer_process) time_between_gg_close_and_transfer,
               case when closed_by_gg_hh in (6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23) then dateadd('day', 1, to_timestamp_ntz(to_char(closed_by_gg_day, 'yyyy-mm-dd') || ' 06:05:00'))
                    when closed_by_gg_hh in (0,1,2,3,4,5) then to_timestamp_ntz(to_char(closed_by_gg_day, 'yyyy-mm-dd') || ' 06:05:00')
               end expected_stage_load
          from (
                select file_size,
                       file_name,
                       to_timestamp_ntz(last_modified_date || ' ' || last_modified_time) picked_up_by_transfer_process,
                       to_timestamp_ntz(substr(file_name, regexp_instr(file_name, ':', 1, 3) + 1, 19), 'yyyy-mm-dd_hh24-mi-ss') opened_by_gg,
                       dateadd('hour', 1, to_timestamp_ntz(substr(file_name, regexp_instr(file_name, ':', 1, 3) + 1, 19), 'yyyy-mm-dd_hh24-mi-ss')) closed_by_gg,
                       date_trunc('day', dateadd('hour', 1, to_timestamp_ntz(substr(file_name, regexp_instr(file_name, ':', 1, 3) + 1, 19), 'yyyy-mm-dd_hh24-mi-ss'))) closed_by_gg_day,
                       to_number(to_char(dateadd('hour', 1, to_timestamp_ntz(substr(file_name, regexp_instr(file_name, ':', 1, 3) + 1, 19), 'yyyy-mm-dd_hh24-mi-ss')), 'hh')) closed_by_gg_hh
                  from etl_manager.fls_files_hist_stage
                 where substr(file_name, 1, 5) = 'nhinp'
                   and file_name like 'nhinp:EPS:RX_TX:%'
                )
           where closed_by_gg > dateadd('day', -15, current_timestamp)
           )
select f.file_name,
       f.closed_by_gg,
       f.picked_up_by_transfer_process,
       f.time_between_gg_close_and_transfer,
       f.expected_stage_load,
       l.last_load_time actual_stage_load,
       datediff('minute', f.expected_stage_load, l.last_load_time) time_between_expected_and_actual_load
  from file_history f,
       etl_manager.prod_load_history l
 where l.schema_name(+) = 'EPR_STAGE'
   and l.table_name(+) = 'RX_TX_INC'
   and l.file_name(+) like '%' || f.file_name
 ;;
  }

  dimension: file_name {
    label: "File Name"
    description: "file name"
    type: string
    sql: ${TABLE}.file_name ;;
  }

  dimension_group: closed_by_gg {
    label: "File Write (Estimated)"
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.closed_by_gg ;;
  }

  dimension_group: picked_up_by_transfer_process {
    label: "Transfer Start"
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.picked_up_by_transfer_process ;;
  }

  measure: time_between_gg_close_and_transfer {
    label: "Time Between File Write and Transfer Start (Minutes)"
    type: sum
    ####
    #X# Invalid LookML inside "measure": {"value_format":null}
    sql: ${TABLE}.time_between_gg_close_and_transfer ;;
  }

  dimension_group: expected_stage_load {
    label: "Expected Stage Load"
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.expected_stage_load ;;
  }

  dimension_group: actual_stage_load {
    label: "Actual Stage Load"
    type: time
    timeframes: [time, date]
    sql: ${TABLE}.actual_stage_load ;;
  }

  measure: time_between_expected_and_actual_load {
    label: "Time Between Excpected and Actual load (Minutes)"
    type: sum
    ####
    #X# Invalid LookML inside "measure": {"value_format":null}
    sql: ${TABLE}.time_between_expected_and_actual_load ;;
  }
}

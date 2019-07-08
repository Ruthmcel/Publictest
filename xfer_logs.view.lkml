view: xfer_logs {
  derived_table: {
    sql: select log_file,
       process_start_time,
       process_end_time,
       datediff('minutes', process_start_time, process_end_time) duration,
       case when size = 87 then 'Aborted as eariler run was not complete' else null end comment
from (
  select file_size size,
         to_timestamp_ntz(last_modified_date || ' ' || last_modified_time) process_end_time,
         file_name log_file,
         to_timestamp_ntz(substr(file_name, 30, 19), 'yyyy-mm-dd_hh24:mi:ss') process_start_time
    from etl_manager.xfer_log_hist_stage
     )
 ;;
  }

  dimension: log_file {
    description: "log file name"
    type: string
    sql: ${TABLE}.log_file ;;
  }

  dimension_group: process_start {
    label: "Process Start"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.process_start_time ;;
  }

  dimension_group: process_end {
    label: "Process End"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.process_end_time ;;
  }

  measure: duration {
    label: "Process Duration (Minutes)"
    type: sum
    ####
    #X# Invalid LookML inside "measure": {"value_format":null}
    sql: ${TABLE}.duration ;;
  }
}

view: snowflake_warehouse_usage_history {
  derived_table: {
    sql: -- derived sql to determine Snowflake warehouse utilization for users connected via Looker
       with warehouse_credit_dollars_per_hour as
        (
        select 'X-Small' as warehouse_size,CAST(1 AS NUMBER) as credit,CAST(2.65 AS NUMBER(7,3)) as dollars_per_hour,CAST(2.65 AS NUMBER(7,3))/60/60 as dollars_per_second
        union
        select 'Small' as warehouse_size,CAST(2 AS NUMBER) as credit,CAST(5.30 AS NUMBER(7,3)) as dollars_per_hour,CAST(5.30 AS NUMBER(7,3))/60/60 as dollars_per_second
        union
        select 'Medium' as warehouse_size,CAST(4 AS NUMBER) as credit,CAST(10.60 AS NUMBER(7,3)) as dollars_per_hour,CAST(10.60 AS NUMBER(7,3))/60/60 as dollars_per_second
        union
        select 'Large' as warehouse_size,CAST(8 AS NUMBER) as credit,CAST(21.20 AS NUMBER(7,3)) as dollars_per_hour,CAST(21.20 AS NUMBER(7,3))/60/60 as dollars_per_second
        union
        select 'X-Large' as warehouse_size,CAST(16 AS NUMBER) as credit,CAST(42.40 AS NUMBER(7,3)) as dollars_per_hour,CAST(42.40 AS NUMBER(7,3))/60/60 as dollars_per_second
        )
        ,days_tbl as
        (
        select calendar_date as calendar_date, to_timestamp(last_day(calendar_date))as max_calendar_date, to_timestamp(DATEADD(day,1,last_day(DATEADD( month,-1,calendar_date )))) as min_calendar_date

        from EDW.D_DATE where calendar_date >= {% date_start snowflake_warehouse_usage_history.warehouse_usage_date_time %}
        and calendar_date <=(
        select max(end_time) from  "ETL_MANAGER"."QUERY_HISTORY" where
         start_time>= {% date_start snowflake_warehouse_usage_history.warehouse_usage_date_time %} --to_timestamp('2017/12/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
         and start_time< {% date_end snowflake_warehouse_usage_history.warehouse_usage_date_time %} -- to_timestamp('2018/01/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
                            )
        )


        ,time_hrs as
        (
        select  timeadd('hours',6,to_time( '00:00:00')) as EDW_INSERT_TIMESTAMP, 0 as hours
        union
        select  timeadd('hours',6,to_time( '01:00:00')) ,1
        union
        select  timeadd('hours',6,to_time( '02:00:00')),2
        union
        select  timeadd('hours',6,to_time( '03:00:00')),3
        union
        select  timeadd('hours',6,to_time( '04:00:00')),4
        union
        select  timeadd('hours',6,to_time( '05:00:00')),5
        union
        select  timeadd('hours',6,to_time( '06:00:00')),6
        union
        select  timeadd('hours',6,to_time( '07:00:00')),7
        union
        select  timeadd('hours',6,to_time( '08:00:00')),8
        union
        select  timeadd('hours',6,to_time( '09:00:00')),9
        union
        select  timeadd('hours',6,to_time( '10:00:00')),10
        union
        select  timeadd('hours',6,to_time( '11:00:00')),11
        union
        select  timeadd('hours',6,to_time( '12:00:00')),12
        union
        select  timeadd('hours',6,to_time( '13:00:00')),13
        union
        select  timeadd('hours',6,to_time( '14:00:00')),14
        union
        select  timeadd('hours',6,to_time( '15:00:00')),15
        union
        select  timeadd('hours',6,to_time( '16:00:00')),16
        union
        select  timeadd('hours',6,to_time( '17:00:00')),17
        union
        select  timeadd('hours',6,to_time( '18:00:00')),18
        union
        select  timeadd('hours',6,to_time( '19:00:00')),19
        union
        select  timeadd('hours',6,to_time( '20:00:00')),20
        union
        select  timeadd('hours',6,to_time( '21:00:00')),21
        union
        select  timeadd('hours',6,to_time( '22:00:00')),22
        union
        select  timeadd('hours',6,to_time( '23:00:00')),23
        )
        ,
        days_time as (
        select
        calendar_date,hours,to_timestamp(calendar_date||' '||hours||':00:00') as calendar_date_hours,min_calendar_date,max_calendar_date
          from
          days_tbl,time_hrs

        )


        ,same_day_queries  as (
        select
          case when upper(query_text) like '%EDW.F_TRANSACTION_INFO%' then 'ABSOLUTE-AR'
          else warehouse_name
          end warehouse_name,warehouse_size,calendar_date,calendar_date_hours
        ,case when start_time>=calendar_date_hours then start_time else calendar_date_hours  end as start_time_calc

        ,case when END_TIME > DATEADD( hour,1,calendar_date_hours) then
        DATEADD( hour,1,calendar_date_hours)
        else END_TIME end  end_time_calc

        from    "ETL_MANAGER"."QUERY_HISTORY",days_time  where
        hours between substr(start_time,12,2) and substr(end_time,12,2)
        and   to_timestamp(calendar_date) between min_calendar_date and end_time
        and substr(start_time,9,2) =substr(end_time,9,2) --This will ensure only the queries that ran and completed on the same day
        and substr(start_time,1,10) =substr(calendar_Date,1,10)
        --and  query_id in ('b88fb962-ecb6-4f42-9f3b-aff0c1f31f2d','dab76323-4e1e-4403-80dc-45f0efce414c')
        -- and 1=2

        )


        ,multiple_day_queries as (

        select  case when upper(query_text) like '%EDW.F_TRANSACTION_INFO%' then 'ABSOLUTE-AR'
          else warehouse_name
          end warehouse_name,warehouse_size,calendar_date,calendar_date_hours

        ,case when start_time>=calendar_date_hours then start_time else calendar_date_hours  end as start_time_calc

        ,case when END_TIME > DATEADD( hour,1,calendar_date_hours) then
        DATEADD( hour,1,calendar_date_hours)
        else END_TIME end  end_time_calc


        from    "ETL_MANAGER"."QUERY_HISTORY",days_time  where
        hours between (case when calendar_Date =substr(start_time,1,10) then substr(start_time,12,2) else 0   end)  and
         (case when calendar_Date =substr(start_time,1,10)
         then 23
        when calendar_Date =substr(end_time,1,10)
         then
         substr(end_time,12,2)
        else
         23
        end)

        and
        calendar_date between to_datE(substr(start_time,1,10)) and to_datE(substr(end_time,1,10))
        --and   to_timestamp(calendar_date) between START_TIME and end_time
        --and start_time>=to_timestamp('2017/11/01 00:00:00','yyyy/mm/dd hh24:mi:ss') and start_time<to_timestamp('2017/12/01 00:00:00','yyyy/mm/dd hh24:mi:ss')

        and substr(start_time,9,2) <>substr(end_time,9,2) --This will ensure only the queries that ran and completed not on the same day
        --and query_id in ('b88fb962-ecb6-4f42-9f3b-aff0c1f31f2d','dab76323-4e1e-4403-80dc-45f0efce414c')
        --group by warehouse_name,warehouse_size,query_id,calendar_date_hours,start_time,end_time,calendar_date
        )


        ,all_day_queries as (

        select
        warehouse_name,warehouse_size,calendar_date,calendar_date_hours,
        case when
        timediff('seconds',min(start_time_calc),max(end_time_calc))=0 then 1
        else
        timediff('seconds',min(start_time_calc),max(end_time_calc))
        end  t1
        from same_day_queries
        group by warehouse_name,warehouse_size,calendar_date,calendar_date_hours


        union


        select
        warehouse_name,warehouse_size,calendar_date,calendar_date_hours,
        case when
        timediff('seconds',min(start_time_calc),max(end_time_calc))=0 then 1
        else
        timediff('seconds',min(start_time_calc),max(end_time_calc))
        end
        from multiple_day_queries
        group by warehouse_name,warehouse_size,calendar_date,calendar_date_hours
        )
        select warehouse_name,temp.warehouse_size,calendar_date_hours as warehouse_usage_date,max_seconds_used as warehouse_usage_time_in_seconds,
        case when wcdph.warehouse_size = temp.warehouse_size then temp.max_seconds_used * wcdph.dollars_per_second
        end as dollars_spent
        from
        (
        select
        warehouse_name,warehouse_size,calendar_date,calendar_date_hours
        ,max(t1) over(partition by warehouse_name,warehouse_size,calendar_date,calendar_date_hours order by t1  rows between current row AND 1  following         ) max_seconds_used
        ,row_number() over(partition by warehouse_name,warehouse_size,calendar_date,calendar_date_hours  order by warehouse_name,warehouse_size,calendar_date,calendar_date_hours ) as RNK
        from
        all_day_queries
        )temp
        join warehouse_credit_dollars_per_hour wcdph
        on wcdph.warehouse_size = temp.warehouse_size
        where temp.RNK=1
       ;;
  }

# warehouse_name,warehouse_size,calendar_date,warehouse_usage_time_in_seconds, dollars_per_second
  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${warehouse_name} ||'@'|| ${warehouse_size} ||'@'|| ${warehouse_usage_date_time};;
  }

  dimension: warehouse_name {
    label: "Warehouse Name"
    description: "Name of the Warehouse"
    type: string
    sql: ${TABLE}.WAREHOUSE_NAME ;;
  }

  dimension: warehouse_size {
    label: "Warehouse Size"
    description: "Size of the Warehouse being used"
    type: string
    sql: ${TABLE}.WAREHOUSE_SIZE ;;
  }

  dimension_group: warehouse_usage_date {
    label: "Warehouse Usage"
    description: "Date/Time warehouse was used"
    type: time
    timeframes: []
    sql: CONVERT_TIMEZONE('America/Chicago',${TABLE}.WAREHOUSE_USAGE_DATE) ;;
  }

  measure: warehouse_usage_time_in_seconds {
    label: "Warehouse Usage Time (In Seconds)"
    description: "The total time Spent by the Warehouse in a Given hour (In Seconds)"
    type: sum
    sql: ${TABLE}.WAREHOUSE_USAGE_TIME_IN_SECONDS ;;
  }

  measure: warehouse_usage_time_in_minutes {
    label: "Warehouse Usage Time (In Minutes)"
    description: "The total time Spent by the Warehouse in a Given hour (In Minutes)"
    type: sum
    sql: ${TABLE}.WAREHOUSE_USAGE_TIME_IN_SECONDS/60 ;;
    value_format: "#,##0;($#,##0)"
  }

  measure: dollars_spent {
    label: "Dollars Spent"
    description: "Dollars Spent in a Given Hour"
    type: sum
    sql: ${TABLE}.DOLLARS_SPENT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }
}

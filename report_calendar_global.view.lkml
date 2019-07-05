view: report_calendar_global {
  derived_table: {
    sql: with
      input_parameters
      as (select rpt_start_date,
                 rpt_end_date,
                 analysis_calendar_filter,
                 case when {% date_end report_calendar_global.report_period_filter %} is null then duration + 1
                      else duration
                 end duration,
                 offset,
                 date_range_end
            from (select rpt_start_date,
                         rpt_end_date,
                         analysis_calendar_filter,
                         case analysis_calendar_filter
                           when 'Year' then datediff('Year', rpt_start_date, rpt_end_date)
                           when 'Quarter' then datediff('Quarter', rpt_start_date, rpt_end_date)
                           when 'Month' then datediff('Month', rpt_start_date, rpt_end_date)
                           when 'Week' then datediff('Week', rpt_start_date, rpt_end_date)
                           when 'Day' then datediff('Day', rpt_start_date, rpt_end_date)
                         end duration,
                         case analysis_calendar_filter
                           when 'Year' then datediff('Year', dateadd('day', -1, rpt_end_date), current_date())
                           when 'Quarter' then datediff('Quarter', dateadd('day', -1, rpt_end_date), current_date())
                           when 'Month' then datediff('Month', dateadd('day', -1, rpt_end_date), current_date())
                           when 'Week' then datediff('Week', dateadd('day', -1, rpt_end_date), current_date())
                           when 'Day' then datediff('Day', dateadd('day', -1, rpt_end_date), current_date())
                         end offset,
                         dateadd('day', -1, rpt_end_date) date_range_end
                    from (select nvl({% date_start report_calendar_global.report_period_filter %},
                                     to_date('1900-01-01')) rpt_start_date,
                                 nvl({% date_end report_calendar_global.report_period_filter %},
                                 dateadd('day', 1, current_date())) rpt_end_date,
                                 replace(replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day'), 'Specific Year', 'Year') analysis_calendar_filter
                         )
                   where rpt_start_date <= current_date()
                 )
         ),
      fiscal_calendar_full
      as (select fiscal_date.*,
                 count(fiscal_date.chain_id||fiscal_date.fiscal_budget_period_identifier) over (partition by fiscal_date.chain_id,fiscal_date.fiscal_budget_period_identifier) days_in_budget_identifier,
                 max(fiscal_date.fiscal_month_of_year) over(partition by fiscal_date.chain_id, fiscal_date.fiscal_year) fiscal_months_in_year,
                 max(fiscal_date.fiscal_quarter_of_year) over(partition by fiscal_date.chain_id, fiscal_date.fiscal_year) fiscal_quarters_in_year,
                 max(fiscal_date.fiscal_day_of_week) over(partition by fiscal_date.chain_id, fiscal_date.fiscal_year, fiscal_date.fiscal_week_of_year) fiscal_days_in_week
            from (select fiscal_date.chain_id calendar_owner_chain_id,
                         fiscal_date.chain_id,
                         fiscal_date.calendar_date,
                         fiscal_date.source_system_id,
                         case when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                              then fiscal_date.fiscal_year_of_week
                              else fiscal_date.fiscal_year
                         end fiscal_year,
                         fiscal_date.fiscal_day_of_week,
                         fiscal_date.fiscal_week_begin_date,
                         fiscal_date.fiscal_week_end_date,
                         fiscal_date.fiscal_week_of_year,
                         fiscal_date.fiscal_week_of_month,
                         fiscal_date.fiscal_week_of_quarter,
                         fiscal_date.fiscal_month_begin_date,
                         fiscal_date.fiscal_month_end_date,
                         fiscal_date.fiscal_month_of_year,
                         fiscal_date.fiscal_total_weeks_in_month,
                         fiscal_date.fiscal_quarter_begin_date,
                         fiscal_date.fiscal_quarter_end_date,
                         fiscal_date.fiscal_quarter_of_year,
                         fiscal_date.fiscal_total_weeks_in_quarter,
                         fiscal_date.fiscal_year_begin_date,
                         fiscal_date.fiscal_year_end_date,
                         fiscal_date.fiscal_total_weeks_in_year,
                         fiscal_date.fiscal_leap_year_flag,
                         fiscal_date.fiscal_budget_period_identifier,
                         fiscal_date.fiscal_day_of_month,
                         fiscal_date.fiscal_day_of_quarter,
                         fiscal_date.fiscal_day_of_year,
                         fiscal_date.calendar_type
                    from edw.d_fiscal_date fiscal_date
                   where {% condition chain.fiscal_chain_id %} fiscal_date.chain_id {% endcondition %}
                     and upper(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), ' - .*')) = fiscal_date.calendar_type
                ) fiscal_date
         ),
      fiscal_calendar
      as (select *
            from fiscal_calendar_full
           where fiscal_calendar_full.calendar_date <= current_date()
         ),
      current_fiscal_date
      as (select *
            from fiscal_calendar
           where calendar_date = current_date()
             and {% condition chain.fiscal_chain_id %} fiscal_calendar.chain_id {% endcondition %}
         ),
      base_fiscal_date
      as (select fiscal_calendar.*,
                 input_parameters.duration,
                 input_parameters.date_range_end,
                 case when input_parameters.offset = 0 then 'N' else 'Y' end offset_flag
            from fiscal_calendar,
                 input_parameters,
                 current_fiscal_date
           where current_fiscal_date.chain_id = fiscal_calendar.chain_id
             and 1 = case when     input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Specific Year'
                               and input_parameters.duration = 1
                               and fiscal_calendar.fiscal_year = year(input_parameters.rpt_end_date)-1
                               and fiscal_calendar.calendar_date = fiscal_calendar.fiscal_year_end_date
                          then 1
                          when     input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Year'
                               and fiscal_calendar.fiscal_year = current_fiscal_date.fiscal_year - input_parameters.offset
                               and fiscal_calendar.calendar_date = fiscal_calendar.fiscal_year_end_date
                          then 1
                          when     input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                               and ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + fiscal_calendar.fiscal_quarter_of_year) =
                                    (((current_fiscal_date.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + current_fiscal_date.fiscal_quarter_of_year) - input_parameters.offset )
                               and fiscal_calendar.calendar_date = fiscal_calendar.fiscal_quarter_end_date
                          then 1
                          when     input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                               and ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_months_in_year) + fiscal_calendar.fiscal_month_of_year) =
                                     (((current_fiscal_date.fiscal_year * fiscal_calendar.fiscal_months_in_year) + current_fiscal_date.fiscal_month_of_year) - input_parameters.offset)
                               and fiscal_calendar.calendar_date = fiscal_calendar.fiscal_month_end_date
                          then 1
                          when     input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                               and fiscal_calendar.calendar_date = dateadd('day', -(input_parameters.offset * fiscal_calendar.fiscal_days_in_week), current_fiscal_date.fiscal_week_end_date)
                           then 1
                          when     replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                               and input_parameters.date_range_end < current_fiscal_date.calendar_date
                               and fiscal_calendar.calendar_date = dateadd('day', -(input_parameters.offset), current_fiscal_date.calendar_date)
                          then 1
                          when input_parameters.date_range_end >= current_fiscal_date.calendar_date
                               and fiscal_calendar.calendar_date = current_fiscal_date.calendar_date
                          then 1
                          else 0
                     end
         ),
      fiscal_ty_calendar
      as (select fiscal_calendar.*,
                 fiscal_calendar.calendar_date report_date,
                 'TY' type,
                 offset_flag,
                 dense_rank() over (partition by fiscal_calendar.chain_id order by fiscal_calendar.fiscal_year desc,fiscal_calendar.fiscal_month_of_year desc) rnk_mnth,
                 dense_rank() over (partition by fiscal_calendar.chain_id order by fiscal_calendar.fiscal_year desc,fiscal_calendar.fiscal_quarter_of_year desc) rnk_qtr,
                 dense_rank() over (partition by fiscal_calendar.chain_id order by fiscal_calendar.fiscal_year desc,fiscal_calendar.fiscal_week_of_year desc) rnk_week,
                 dense_rank() over (partition by fiscal_calendar.chain_id order by fiscal_calendar.fiscal_year desc) rnk_year,
                 count(*) over (partition by fiscal_calendar.chain_id, fiscal_calendar.fiscal_year, fiscal_calendar.fiscal_month_of_year) fiscal_month_days,
                 count(*) over (partition by fiscal_calendar.chain_id, fiscal_calendar.fiscal_year, fiscal_calendar.fiscal_quarter_of_year) fiscal_quarter_days,
                 decode(fiscal_calendar.calendar_date, (last_value(fiscal_calendar.calendar_date) over(partition by fiscal_calendar.chain_id, fiscal_calendar.fiscal_year, fiscal_calendar.fiscal_month_of_year order by fiscal_calendar.calendar_date asc)),'Y','N') last_day_of_month_flag,
                 decode(fiscal_calendar.calendar_date, (last_value(fiscal_calendar.calendar_date) over(partition by fiscal_calendar.chain_id, fiscal_calendar.fiscal_year, fiscal_calendar.fiscal_quarter_of_year order by fiscal_calendar.calendar_date asc)),'Y','N') last_day_of_quarter_flag
            from fiscal_calendar,
                 base_fiscal_date
           where fiscal_calendar.chain_id = base_fiscal_date.chain_id
             and 1 = case when     replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Specific Year', 'Year') = 'Year'
                               and fiscal_calendar.fiscal_year >= base_fiscal_date.fiscal_year - (duration - 1)
                               and fiscal_calendar.calendar_date < (dateadd('day', 1, base_fiscal_date.calendar_date))
                          then 1
                          when     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                               and ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + fiscal_calendar.fiscal_quarter_of_year) <= ((base_fiscal_date.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + base_fiscal_date.fiscal_quarter_of_year)
                               and (((base_fiscal_date.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + base_fiscal_date.fiscal_quarter_of_year) - ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_quarters_in_year) + fiscal_calendar.fiscal_quarter_of_year)) <= (duration - 1)
                               and fiscal_calendar.calendar_date < (dateadd('day', 1, base_fiscal_date.calendar_date))
                          then 1
                          when     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                               and ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_months_in_year) + fiscal_calendar.fiscal_month_of_year) <= ((base_fiscal_date.fiscal_year * fiscal_calendar.fiscal_months_in_year) + base_fiscal_date.fiscal_month_of_year)
                               and (((base_fiscal_date.fiscal_year * fiscal_calendar.fiscal_months_in_year) + base_fiscal_date.fiscal_month_of_year) - ((fiscal_calendar.fiscal_year * fiscal_calendar.fiscal_months_in_year) + fiscal_calendar.fiscal_month_of_year)) <= (duration - 1)
                               and fiscal_calendar.calendar_date < (dateadd('day', 1, base_fiscal_date.calendar_date))
                          then 1
                          when     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                               and fiscal_calendar.calendar_date >= (dateadd('day', -((duration * fiscal_calendar.fiscal_days_in_week)-1), base_fiscal_date.fiscal_week_end_date))
                               and fiscal_calendar.calendar_date < (dateadd('day', 1, base_fiscal_date.calendar_date))
                          then 1
                          when     replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                               and fiscal_calendar.calendar_date >= (dateadd('day', -(duration-1), base_fiscal_date.calendar_date))
                               and fiscal_calendar.calendar_date < (dateadd('day', 1, base_fiscal_date.calendar_date))
                          then 1
                          else 0
                     end
         ),
      fiscal_ly_range
      as (select distinct
                 fiscal_ty_calendar.chain_id,
                 fiscal_ty_calendar.calendar_type,
                 fiscal_ty_calendar.fiscal_year - 1 fiscal_ly_year,
                 case when replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Specific Year', 'Year') = 'Year'
                      then null
                      when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                      then to_char(fiscal_ty_calendar.fiscal_quarter_of_year, '00')
                      when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                      then to_char(fiscal_ty_calendar.fiscal_month_of_year, '00')
                      when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                      then to_char(fiscal_ty_calendar.fiscal_week_of_year, '00')
                      when replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                      then null
                  end join_key
            from fiscal_ty_calendar
           where initcap({% parameter report_calendar_global.this_year_last_year_filter %}) = 'Yes'
      ),
      fiscal_ly_calendar
      as (select ly_fiscal_calendar.*,
                 count(ly_fiscal_calendar.chain_id||ly_fiscal_calendar.fiscal_budget_period_identifier) over (partition by ly_fiscal_calendar.chain_id,ly_fiscal_calendar.fiscal_budget_period_identifier) days_in_budget_identifier,
                 max(ly_fiscal_calendar.fiscal_month_of_year) over(partition by ly_fiscal_calendar.chain_id, ly_fiscal_calendar.fiscal_year) fiscal_months_in_year,
                 max(ly_fiscal_calendar.fiscal_quarter_of_year) over(partition by ly_fiscal_calendar.chain_id, ly_fiscal_calendar.fiscal_year) fiscal_quarters_in_year,
                 max(ly_fiscal_calendar.fiscal_day_of_week) over(partition by ly_fiscal_calendar.chain_id, ly_fiscal_calendar.fiscal_year, ly_fiscal_calendar.fiscal_week_of_year) fiscal_days_in_week
            from (select ly_fiscal_calendar.chain_id calendar_owner_chain_id,
                         ly_fiscal_calendar.chain_id,
                         ly_fiscal_calendar.calendar_date,
                         ly_fiscal_calendar.source_system_id,
                         case when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                              then ly_fiscal_calendar.last_year_fiscal_year_of_week
                              else ly_fiscal_calendar.last_year_fiscal_year
                         end fiscal_year,
                         ly_fiscal_calendar.last_year_fiscal_day_of_week fiscal_day_of_week,
                         ly_fiscal_calendar.last_year_fiscal_week_begin_date fiscal_week_begin_date,
                         ly_fiscal_calendar.last_year_fiscal_week_end_date fiscal_week_end_date,
                         ly_fiscal_calendar.last_year_fiscal_week_of_year fiscal_week_of_year,
                         ly_fiscal_calendar.last_year_fiscal_week_of_month fiscal_week_of_month,
                         ly_fiscal_calendar.last_year_fiscal_week_of_quarter fiscal_week_of_quarter,
                         ly_fiscal_calendar.last_year_fiscal_month_begin_date fiscal_month_begin_date,
                         ly_fiscal_calendar.last_year_fiscal_month_end_date fiscal_month_end_date,
                         ly_fiscal_calendar.last_year_fiscal_month_of_year fiscal_month_of_year,
                         ly_fiscal_calendar.last_year_fiscal_total_weeks_in_month fiscal_total_weeks_in_month,
                         ly_fiscal_calendar.last_year_fiscal_quarter_begin_date fiscal_quarter_begin_date,
                         ly_fiscal_calendar.last_year_fiscal_quarter_end_date fiscal_quarter_end_date,
                         ly_fiscal_calendar.last_year_fiscal_quarter_of_year fiscal_quarter_of_year,
                         ly_fiscal_calendar.last_year_fiscal_total_weeks_in_quarter fiscal_total_weeks_in_quarter,
                         ly_fiscal_calendar.last_year_fiscal_year_begin_date fiscal_year_begin_date,
                         ly_fiscal_calendar.last_year_fiscal_year_end_date fiscal_year_end_date,
                         ly_fiscal_calendar.last_year_fiscal_total_weeks_in_year fiscal_total_weeks_in_year,
                         ly_fiscal_calendar.last_year_fiscal_leap_year_flag fiscal_leap_year_flag,
                         ly_fiscal_calendar.last_year_fiscal_budget_period_identifier fiscal_budget_period_identifier,
                         ly_fiscal_calendar.last_year_fiscal_day_of_month fiscal_day_of_month,
                         ly_fiscal_calendar.last_year_fiscal_day_of_quarter fiscal_day_of_quarter,
                         ly_fiscal_calendar.last_year_fiscal_day_of_year fiscal_day_of_year,
                         ly_fiscal_calendar.calendar_type,
                         'LY' type,
                         fiscal_ly_range.fiscal_ly_year fiscal_ly_range_fiscal_ly_year
                    from edw.d_last_year_fiscal_date ly_fiscal_calendar,
                         fiscal_ly_range
                   where ly_fiscal_calendar.chain_id = fiscal_ly_range.chain_id
                     and ly_fiscal_calendar.calendar_type = fiscal_ly_range.calendar_type
                     and (   (    replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Specific Year', 'Year') = 'Year'
                              and 1 = 1
                             )
                          or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                              and ly_fiscal_calendar.last_year_fiscal_quarter_of_year = fiscal_ly_range.join_key
                             )
                          or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                              and ly_fiscal_calendar.last_year_fiscal_month_of_year = fiscal_ly_range.join_key
                             )
                          or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                              and ly_fiscal_calendar.last_year_fiscal_week_of_year = fiscal_ly_range.join_key
                             )
                          or (    replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                              and 1 = 1
                             )
                         )
                     and initcap({% parameter report_calendar_global.this_year_last_year_filter %}) = 'Yes'
                 ) ly_fiscal_calendar
           where ly_fiscal_calendar.fiscal_year = ly_fiscal_calendar.fiscal_ly_range_fiscal_ly_year
          ),
      fiscal_ly_calendar_with_report_date
      as (select fiscal_ly_calendar.calendar_owner_chain_id,
                 fiscal_ly_calendar.chain_id,
                 fiscal_ly_calendar.calendar_date,
                 case when fiscal_ty_calendar.calendar_date is null
                      then max(fiscal_ty_calendar.calendar_date) over(partition by case when replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Specific Year', 'Year') = 'Year'
                                                                                        then fiscal_ly_calendar.fiscal_year
                                                                                        when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                                                                                        then fiscal_ly_calendar.fiscal_year || fiscal_ly_calendar.fiscal_quarter_of_year
                                                                                        when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                                                                                        then fiscal_ly_calendar.fiscal_year || fiscal_ly_calendar.fiscal_month_of_year
                                                                                        when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                                                                                        then fiscal_ly_calendar.fiscal_year || fiscal_ly_calendar.fiscal_week_of_year
                                                                                        when replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                                                                                        then fiscal_ly_calendar.fiscal_year || fiscal_ly_calendar.fiscal_day_of_year
                                                                                   end
                                                                     )
                      else fiscal_ty_calendar.calendar_date
                 end report_date,
                 fiscal_ly_calendar.type,
                 fiscal_ty_calendar.offset_flag,
                 fiscal_ly_calendar.fiscal_year,
                 fiscal_ly_calendar.fiscal_day_of_week,
                 fiscal_ly_calendar.fiscal_week_of_year,
                 fiscal_ly_calendar.fiscal_month_of_year,
                 fiscal_ly_calendar.fiscal_quarter_of_year,
                 fiscal_ly_calendar.fiscal_day_of_month,
                 fiscal_ly_calendar.fiscal_day_of_quarter,
                 fiscal_ly_calendar.fiscal_day_of_year,
                 fiscal_ly_calendar.fiscal_budget_period_identifier,
                 fiscal_ly_calendar.days_in_budget_identifier,
                 fiscal_ly_calendar.fiscal_week_begin_date,
                 fiscal_ly_calendar.fiscal_week_end_date,
                 fiscal_ly_calendar.calendar_type,
                 dense_rank() over (partition by fiscal_ly_calendar.chain_id order by fiscal_ly_calendar.fiscal_year desc,fiscal_ly_calendar.fiscal_month_of_year desc) rnk_mnth,
                 dense_rank() over (partition by fiscal_ly_calendar.chain_id order by fiscal_ly_calendar.fiscal_year desc,fiscal_ly_calendar.fiscal_quarter_of_year desc) rnk_qtr,
                 dense_rank() over (partition by fiscal_ly_calendar.chain_id order by fiscal_ly_calendar.fiscal_year desc,fiscal_ly_calendar.fiscal_week_of_year desc) rnk_week,
                 dense_rank() over (partition by fiscal_ly_calendar.chain_id order by fiscal_ly_calendar.fiscal_year desc) rnk_year,
                 count(*) over (partition by fiscal_ly_calendar.chain_id, fiscal_ly_calendar.fiscal_year, fiscal_ly_calendar.fiscal_month_of_year) fiscal_month_days,
                 count(*) over (partition by fiscal_ly_calendar.chain_id, fiscal_ly_calendar.fiscal_year, fiscal_ly_calendar.fiscal_quarter_of_year) fiscal_quarter_days,
                 decode(fiscal_ly_calendar.calendar_date, (last_value(fiscal_ly_calendar.calendar_date) over(partition by fiscal_ly_calendar.chain_id, fiscal_ly_calendar.fiscal_year, fiscal_ly_calendar.fiscal_month_of_year order by fiscal_ly_calendar.calendar_date asc)),'Y','N') last_day_of_month_flag,
                 decode(fiscal_ly_calendar.calendar_date, (last_value(fiscal_ly_calendar.calendar_date) over(partition by fiscal_ly_calendar.chain_id, fiscal_ly_calendar.fiscal_year, fiscal_ly_calendar.fiscal_quarter_of_year order by fiscal_ly_calendar.calendar_date asc)),'Y','N') last_day_of_quarter_flag
            from fiscal_ty_calendar
            right outer join fiscal_ly_calendar
              on fiscal_ty_calendar.chain_id = fiscal_ly_calendar.chain_id
             and fiscal_ty_calendar.calendar_type = fiscal_ly_calendar.calendar_type
             and (    fiscal_ty_calendar.fiscal_year - 1 = fiscal_ly_calendar.fiscal_year
                  and (   (    replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Specific Year', 'Year') = 'Year'
                           and fiscal_ty_calendar.fiscal_day_of_year = fiscal_ly_calendar.fiscal_day_of_year
                          )
                       or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                           and fiscal_ty_calendar.fiscal_quarter_of_year = fiscal_ly_calendar.fiscal_quarter_of_year
                           and fiscal_ty_calendar.fiscal_day_of_quarter = fiscal_ly_calendar.fiscal_day_of_quarter
                          )
                       or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                           and fiscal_ty_calendar.fiscal_month_of_year = fiscal_ly_calendar.fiscal_month_of_year
                           and fiscal_ty_calendar.fiscal_day_of_month = fiscal_ly_calendar.fiscal_day_of_month
                          )
                       or (    regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                           and fiscal_ty_calendar.fiscal_week_of_year = fiscal_ly_calendar.fiscal_week_of_year
                           and fiscal_ty_calendar.fiscal_day_of_week = fiscal_ly_calendar.fiscal_day_of_week
                          )
                       or (    replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                           and fiscal_ty_calendar.fiscal_day_of_year = fiscal_ly_calendar.fiscal_day_of_year
                          )
                       )
                 )
           where initcap({% parameter report_calendar_global.this_year_last_year_filter %}) = 'Yes'
             and case when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Year' then
                       case when (    offset_flag = 'N'
                                  and (fiscal_ty_calendar.fiscal_year - 1) >= fiscal_ly_calendar.fiscal_year
                                  and fiscal_ty_calendar.fiscal_month_of_year = fiscal_ly_calendar.fiscal_month_of_year
                                 ) then 1
                            when offset_flag = 'Y' then 1
                            else 0
                        end
                       when regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter' then
                        case when (    offset_flag = 'N'
                                   and (fiscal_ty_calendar.fiscal_year - 1) >= fiscal_ly_calendar.fiscal_year
                                   and fiscal_ty_calendar.fiscal_quarter_of_year = fiscal_ly_calendar.fiscal_quarter_of_year
                                   and fiscal_ty_calendar.fiscal_month_of_year = fiscal_ly_calendar.fiscal_month_of_year
                                  ) then 1
                             when offset_flag = 'Y' then 1
                             else 0
                         end
                       when replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day' then
                        case when fiscal_ty_calendar.report_date is null  then 0
                             else 1
                         end
                      else 1
                  end = 1
         )
      select calendar_type, calendar_owner_chain_id, chain_id, calendar_date, report_date, type,
             fiscal_year as year,fiscal_day_of_week as day_of_week,fiscal_week_of_year as week_of_year,
             fiscal_month_of_year as month_of_year,fiscal_quarter_of_year as quarter_of_year,
             fiscal_day_of_month as day_of_month,
             fiscal_day_of_quarter as day_of_quarter,fiscal_day_of_year as day_of_year,
             case when rnk_mnth = 1 then 'Y' else 'N' end MTD,
             case when rnk_qtr = 1 then 'Y' else 'N' end QTD,
             case when rnk_week = 1 then 'Y' else 'N' end WTD,
             case when rnk_year = 1 then 'Y' else 'N' end YTD,
             case when rnk_mnth = 2 then 'Y' else 'N' end Mnth,
             case when rnk_qtr = 2 then 'Y' else 'N' end Qtr,
             case when rnk_week = 2 then 'Y' else 'N' end Wk,
             case when rnk_year = 2 then 'Y' else 'N' end Yr,
             case when rnk_week <= 13 then 'Y' else 'N' end rolling_13_week,
             case when rnk_mnth >= 2 and rnk_mnth <= 13 then 'Y' else 'N' end TTM,
             fiscal_budget_period_identifier as budget_period_identifier,
             days_in_budget_identifier,
             last_value(report_date) over(partition by chain_id order by report_date asc) max_date,
             first_value(report_date) over(partition by chain_id order by report_date asc) min_date,
             count(distinct(calendar_date)) over(partition by chain_id) number_of_days,
             count(distinct(fiscal_year||fiscal_week_of_year)) over(partition by chain_id) number_of_weeks,
             count(distinct(fiscal_year||fiscal_month_of_year)) over(partition by chain_id) number_of_months,
             fiscal_month_days,
             fiscal_quarter_days,
             last_day_of_month_flag,
             last_day_of_quarter_flag,
             fiscal_week_begin_date,
             fiscal_week_end_date,
             case when calendar_date between dateadd('day',-7,(last_value(fiscal_week_begin_date) over(partition by chain_id order by report_date asc)))
                                         and dateadd('day',-7,(last_value(fiscal_week_end_date) over(partition by chain_id order by report_date asc)))
                  then 'Y' else 'N' end one_week_ago_flag,
             case when calendar_date between dateadd('day',-14,(last_value(fiscal_week_begin_date) over(partition by chain_id order by report_date asc)))
                                        and dateadd('day',-14,(last_value(fiscal_week_end_date) over(partition by chain_id order by report_date asc)))
                  then 'Y' else 'N' end two_week_ago_flag
        from fiscal_ty_calendar
       union all
      select ly.calendar_type, ly.calendar_owner_chain_id, ly.chain_id, ly.calendar_date, ly.report_date, type,
             ly.fiscal_year as year,ly.fiscal_day_of_week as day_of_week,ly.fiscal_week_of_year as week_of_year,
             ly.fiscal_month_of_year as month_of_year,ly.fiscal_quarter_of_year as quarter_of_year,
             ly.fiscal_day_of_month as day_of_month,
             ly.fiscal_day_of_quarter as day_of_quarter,ly.fiscal_day_of_year as day_of_year,
             case when rnk_mnth = 1 then 'Y' else 'N' end MTD,
             case when rnk_qtr = 1 then 'Y' else 'N' end QTD,
             case when rnk_week = 1 then 'Y' else 'N' end WTD,
             case when rnk_year = 1 then 'Y' else 'N' end YTD,
             case when rnk_mnth = 2 then 'Y' else 'N' end Mnth,
             case when rnk_qtr = 2 then 'Y' else 'N' end Qtr,
             case when rnk_week = 2 then 'Y' else 'N' end Wk,
             case when rnk_year = 2 then 'Y' else 'N' end Yr,
             case when rnk_week <= 13 then 'Y' else 'N' end rolling_13_week,
             case when rnk_mnth >= 2 and rnk_mnth <= 13 then 'Y' else 'N' end TTM,
             ly.fiscal_budget_period_identifier as budget_period_identifier,
             ly.days_in_budget_identifier,
             last_value(ly.report_date) over(partition by ly.chain_id order by ly.report_date asc) max_date,
             first_value(ly.report_date) over(partition by ly.chain_id order by ly.report_date asc) min_date,
             count(distinct(ly.calendar_date)) over(partition by ly.chain_id) number_of_days,
             count(distinct(ly.fiscal_year||ly.fiscal_week_of_year)) over(partition by ly.chain_id) number_of_weeks,
             count(distinct(ly.fiscal_year||ly.fiscal_month_of_year)) over(partition by ly.chain_id) number_of_months,
             fiscal_month_days,
             fiscal_quarter_days,
             last_day_of_month_flag,
             last_day_of_quarter_flag,
             ly.fiscal_week_begin_date,
             ly.fiscal_week_end_date,
             case when ly.calendar_date between dateadd('day',-7,(last_value(ly.fiscal_week_begin_date) over(partition by ly.chain_id order by ly.report_date asc)))
                                            and dateadd('day',-7,(last_value(ly.fiscal_week_end_date) over(partition by ly.chain_id order by ly.report_date asc)))
                  then 'Y' else 'N'
             end one_week_ago_flag,
             case when ly.calendar_date between dateadd('day',-14,(last_value(ly.fiscal_week_begin_date) over(partition by ly.chain_id order by ly.report_date asc)))
                                            and dateadd('day',-14,(last_value(ly.fiscal_week_end_date) over(partition by ly.chain_id order by ly.report_date asc)))
                  then 'Y' else 'N'
             end two_week_ago_flag
        from fiscal_ly_calendar_with_report_date ly,
             current_fiscal_date cf
       where ly.chain_id = cf.chain_id
         and ly.calendar_type = cf.calendar_type
         and case when (    ly.offset_flag = 'N'
                        and ly.calendar_owner_chain_id = cf.calendar_owner_chain_id
                        and (   (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                                  and ly.rnk_qtr = 1
                                  and ly.fiscal_day_of_quarter <= cf.fiscal_day_of_quarter
                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                                  and ly.rnk_mnth = 1
                                  and ly.fiscal_day_of_month <= cf.fiscal_day_of_month
                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                                  and ly.rnk_week = 1
                                  and ly.fiscal_day_of_week <= cf.fiscal_day_of_week
                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Year'
                                  and ly.rnk_year = 1
                                  and ly.fiscal_day_of_year <= cf.fiscal_day_of_year
                                )
                             OR (     replace(regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - '), 'Date Range', 'Day') = 'Day'
                                  and ly.report_date is not null
                                )
                            )
                        ) then 1
                      when (    ly.offset_flag = 'N'
                        and ly.calendar_owner_chain_id = cf.calendar_owner_chain_id
                        and (   (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Quarter'
                                  and ly.rnk_qtr != 1
                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Month'
                                  and ly.rnk_mnth != 1

                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Week'
                                  and ly.rnk_week != 1
                                )
                             OR (     regexp_replace(initcap({% parameter report_calendar_global.analysis_calendar_filter %}), '.* - ') = 'Year'
                                  and ly.rnk_year != 1
                                )
                            )
                        ) then 1
                        when ly.offset_flag = 'Y' then 1
                        else 0
                        end = 1
         ----and report_date is not null --this is applicable only for 'Day' grain
       ;;
  }

  dimension: calendar_date {
    #     hidden: true    # used only for join purpose
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: calendar_owner_chain_id {
    type: number
    # used only for join purpose
    hidden: yes
    sql: ${TABLE}.calendar_owner_chain_id ;;
  }

  dimension: chain_id {
    type: number
    # used only for join purpose
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: calendar_type {
    type: string
    # used only for join purpose
    hidden: yes
    sql: ${TABLE}.calendar_type ;;
  }

  dimension: mtd_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.MTD ;;
  }

  dimension: qtd_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.QTD ;;
  }

  dimension: wtd_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.WTD ;;
  }

  dimension: ytd_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.YTD ;;
  }

  dimension: mnth_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.Mnth ;;
  }

  dimension: qtr_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.Qtr ;;
  }

  dimension: wk_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.Wk ;;
  }

  dimension: yr_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.Yr ;;
  }

  dimension: rolling_13_week_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.rolling_13_week ;;
  }

  dimension: ttm_flag {
    type: string
    #     hidden: true
    sql: ${TABLE}.TTM ;;
  }

  dimension: budget_period_identifier {
    type: string
    #     hidden: true
    sql: ${TABLE}.BUDGET_PERIOD_IDENTIFIER ;;
  }

  dimension: days_in_budget_identifier {
    type: number
    #     hidden: true
    sql: ${TABLE}.DAYS_IN_BUDGET_IDENTIFIER ;;
  }

  dimension: one_week_ago {
    type: string
    #     hidden: true
    sql: ${TABLE}.ONE_WEEK_AGO_FLAG ;;
  }

  dimension: two_week_ago {
    type: string
    #     hidden: true
    sql: ${TABLE}.TWO_WEEK_AGO_FLAG ;;
  }

  ################################################################################### Dimensions ########################################################################
  dimension: type {
    #     hidden: true    # used only for Report Calculation purpose but not as a dimension to be exposed in explore
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  dimension_group: report {
    #     hidden: true    # used only for Report Calculation purpose but not as a dimension to be exposed in explore
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
    sql: ${TABLE}.REPORT_DATE ;;
  }

  dimension: report_range {
    label: "Report Period Date Range"
    type: string
    sql: ${TABLE}.MIN_DATE || ' to ' || ${TABLE}.MAX_DATE ;;
    group_label: "Report Period Date"
  }

  #TRX-3593 Begin
  dimension: last_day_of_month {
    type: string
    hidden: yes
    label: "Last day of the Month"
    description: "Flag determining whether this is the last day of the month"
    sql: ${TABLE}.last_day_of_month_flag ;;
  }

  dimension: last_day_of_quarter {
    type: string
    hidden: yes
    label: "Last Day of the Quarter"
    description: "Flag determining whether this is the last day of the quarter"
    sql: ${TABLE}.last_day_of_quarter_flag ;;
  }
  #TRX-3593 END

  ################################################################################### Templated Filter ########################################################################

  filter: report_period_filter {
    label: "REPORT PERIOD"
    description: "Starting and ending dates for the range of records you want to include"
    type: date
  }

  filter: analysis_calendar_filter {
    label: "REPORT PERIOD - Analysis Calendar"
    description: "Analysis done as per Standard ISO Calendar or Fiscal Calendar"
    type: string
    suggestions: [
      "Fiscal - Year",
      "Fiscal - Specific Year",
      "Fiscal - Quarter",
      "Fiscal - Month",
      "Fiscal - Week",
      "Fiscal - Day",
      "Fiscal - Date Range",
      "Standard - Year",
      "Standard - Specific Year",
      "Standard - Quarter",
      "Standard - Month",
      "Standard - Week",
      "Standard - Day",
      "Standard - Date Range"
    ]
  }

  filter: this_year_last_year_filter {
    label: "REPORT PERIOD - TY/LY Analysis (Yes/No)"
    description: "Flag that indicates if LY vs. TY Analysis is required. By Default a value of 'No' would be selected"
    type: string
    suggestions: ["No", "Yes"]
  }

  ################################################################################### Measures ########################################################################
  measure: ty_number_of_days {
    hidden: yes
    type: number
    label: "Number of Days"
    description: "Total number of days in this year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'TY' THEN ${TABLE}.NUMBER_OF_DAYS END) ;;
    value_format: "#,##0"
  }

  measure: ly_number_of_days {
    hidden: yes
    type: number
    label: "LY Number of Days"
    description: "Total number of days in last year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'LY' THEN ${TABLE}.NUMBER_OF_DAYS END) ;;
    value_format: "#,##0"
  }

  measure: ty_number_of_weeks {
    #hidden: true
    type: number
    label: "Number of Weeks"
    group_label: "Number of Weeks/Months"
    description: "Total number of weeks in this year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'TY' THEN ${TABLE}.NUMBER_OF_WEEKS END) ;;
    value_format: "#,##0"
  }

  measure: ly_number_of_weeks {
    #hidden: true
    type: number
    label: "LY Number of Weeks"
    group_label: "Number of Weeks/Months"
    description: "Total number of weeks in last year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'LY' THEN ${TABLE}.NUMBER_OF_WEEKS END) ;;
    value_format: "#,##0"
  }

  measure: ty_number_of_months {
    #hidden: true
    type: number
    label: "Number of Months"
    group_label: "Number of Weeks/Months"
    description: "Total number of months in this year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'TY' THEN ${TABLE}.NUMBER_OF_MONTHS END) ;;
    value_format: "#,##0"
  }

  measure: ly_number_of_months {
    #hidden: true
    type: number
    label: "LY Number of Months"
    group_label: "Number of Weeks/Months"
    description: "Total number of months in last year, based on the reporting period"
    sql: MAX(CASE WHEN ${TABLE}.TYPE = 'LY' THEN ${TABLE}.NUMBER_OF_MONTHS END) ;;
    value_format: "#,##0"
  }

#TRX-3593 BEGIN
  measure: ty_fiscal_month_days {
    hidden: yes
    type: average
    label: "Number of Days in Month"
    description: "Number of Days in Month"
    sql: CASE WHEN ${TABLE}.TYPE = 'TY' THEN ${TABLE}.fiscal_month_days END ;;
  }

  measure: ly_fiscal_month_days {
    hidden: yes
    type: average
    label: "Number of Days in Month"
    description: "Number of Days in Month"
    sql: CASE WHEN ${TABLE}.TYPE = 'LY' THEN ${TABLE}.fiscal_month_days END ;;
  }

  measure: ty_fiscal_quarter_days {
    hidden: yes
    type: average
    label: "Number of Days in Quarter"
    description: "Number of Days in Quarter"
    sql: CASE WHEN ${TABLE}.TYPE = 'TY' THEN ${TABLE}.fiscal_quarter_days END ;;
  }

  measure: ly_fiscal_quarter_days {
    hidden: yes
    type: average
    label: "Number of Days in Quarter"
    description: "Number of Days in Quarter"
    sql: CASE WHEN ${TABLE}.TYPE = 'LY' THEN ${TABLE}.fiscal_quarter_days END ;;
  }
#TRX-3593 END
  ###################################################### sets #########################################

  set: global_calendar_candidate_list {
    fields: [
      analysis_calendar_filter,
      report_period_filter,
      this_year_last_year_filter,
      report_range,
      ty_number_of_days,
      ly_number_of_days,
      ty_number_of_weeks,
      ly_number_of_weeks,
      ty_number_of_months,
      ly_number_of_months
    ]
  }
}

view: ar_timeframes {
  derived_table: {
    sql: select chain_id calendar_owner_chain_id,
                chain_id,
                calendar_date,
                case dayname(calendar_date) --ERXLPS-4338 - Removed hardcoded logic and used snowflake's dayname function to get day names
                  when 'Sun' then 'Sunday'
                  when 'Mon' then 'Monday'
                  when 'Tue' then 'Tuesday'
                  when 'Wed' then 'Wednesday'
                  when 'Thu' then 'Thursday'
                  when 'Fri' then 'Friday'
                  when 'Sat' then 'Saturday'
                end day_of_week_full_name,
                fiscal_day_of_month day_of_month,
                fiscal_week_of_year week_of_year,
                fiscal_month_of_year month_num,
                ('Q'|| fiscal_quarter_of_year) as quarter_of_year,
                fiscal_year year,
                fiscal_day_of_week week_index,
                fiscal_week_begin_date week_begin_date,
                --new timeframes addition
                fiscal_week_end_date week_end_date,
                fiscal_week_of_quarter week_of_quarter,
                fiscal_month_begin_date month_begin_date,
                fiscal_month_end_date month_end_date,
                fiscal_total_weeks_in_month weeks_in_month,
                fiscal_quarter_begin_date quarter_begin_date,
                fiscal_quarter_end_date quarter_end_date,
                fiscal_total_weeks_in_quarter weeks_in_quarter,
                fiscal_year_begin_date year_begin_date,
                fiscal_year_end_date year_end_date,
                fiscal_total_weeks_in_year weeks_in_year,
                fiscal_leap_year_flag leap_year_flag,
                fiscal_day_of_quarter day_of_quarter,
                fiscal_day_of_year day_of_year
           from edw.d_fiscal_date fiscal_date
          where {% condition ar_chain.chain_id %} fiscal_date.chain_id {% endcondition %}
           and upper(regexp_replace(initcap({% parameter ar_report_calendar_global.analysis_calendar_filter %}), ' - .*')) = fiscal_date.calendar_type
       ;;
  }

  dimension: calendar_date {
    type: date
    hidden: yes
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: calendar_owner_chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CALENDAR_OWNER_CHAIN_ID ;;
  }

  dimension: day_of_week {
    type: string
    hidden: yes
    sql: ${TABLE}.DAY_OF_WEEK_FULL_NAME ;;
  }

  dimension: day_of_month {
    type: number
    hidden: yes
    sql: ${TABLE}.DAY_OF_MONTH ;;
  }

  dimension: week_of_year {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEK_OF_YEAR ;;
  }

  dimension: month_num {
    type: number
    hidden: yes
    sql: ${TABLE}.MONTH_NUM ;;
  }

  dimension: month {
    type: string
    hidden: yes
    sql: ${TABLE}.YEAR || '-' || to_char(${TABLE}.MONTH_NUM,'00') ;;
  }

  dimension: quarter_of_year {
    type: string
    hidden: yes
    sql: ${TABLE}.QUARTER_OF_YEAR ;;
  }

  dimension: quarter {
    type: string
    hidden: yes
    sql: ${TABLE}.YEAR || '-' || ${TABLE}.QUARTER_OF_YEAR ;;
  }

  dimension: year {
    type: number
    hidden: yes
    sql: ${TABLE}.YEAR ;;
  }

  dimension: day_of_week_index {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEK_INDEX ;;
  }

  dimension: week_begin_date {
    type: date
    hidden: yes
    sql: ${TABLE}.WEEK_BEGIN_DATE ;;
  }

  #[ERXLPS-1229] - Added remaining time components from fiscal calendar
  dimension: week_end_date {
    type: date
    hidden: yes
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

  dimension: week_of_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEK_OF_QUARTER ;;
  }

  dimension: month_begin_date {
    type: date
    hidden: yes
    sql: ${TABLE}.MONTH_BEGIN_DATE ;;
  }

  dimension: month_end_date {
    type: date
    hidden: yes
    sql: ${TABLE}.MONTH_END_DATE ;;
  }

  dimension: weeks_in_month {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEKS_IN_MONTH ;;
  }

  dimension: quarter_begin_date {
    type: date
    hidden: yes
    sql: ${TABLE}.QUARTER_BEGIN_DATE ;;
  }

  dimension: quarter_end_date {
    type: date
    hidden: yes
    sql: ${TABLE}.QUARTER_END_DATE ;;
  }

  dimension: weeks_in_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEKS_IN_QUARTER ;;
  }

  dimension: year_begin_date {
    type: date
    hidden: yes
    sql: ${TABLE}.YEAR_BEGIN_DATE ;;
  }

  dimension: year_end_date {
    type: date
    hidden: yes
    sql: ${TABLE}.YEAR_END_DATE ;;
  }

  dimension: weeks_in_year {
    type: number
    hidden: yes
    sql: ${TABLE}.WEEKS_IN_YEAR ;;
  }

  dimension: leap_year_flag {
    type: string
    hidden: yes
    sql: ${TABLE}.LEAP_YEAR_FLAG ;;
  }

  dimension: day_of_quarter {
    type: number
    hidden: yes
    sql: ${TABLE}.DAY_OF_QUARTER ;;
  }

  dimension: day_of_year {
    type: number
    hidden: yes
    sql: ${TABLE}.DAY_OF_YEAR ;;
  }
}

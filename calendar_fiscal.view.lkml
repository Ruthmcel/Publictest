view: calendar_fiscal {
  derived_table: {
    sql: with customer_chain_fiscal_calendar
           as (select fiscal_date.chain_id calendar_owner_chain_id,
                      fiscal_date.chain_id,
                      fiscal_date.calendar_date ,
                      fiscal_date.fiscal_year,
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
                      fiscal_date.fiscal_day_of_year
                 from edw.d_fiscal_date fiscal_date
                where {% condition chain.chain_id %} fiscal_date.chain_id {% endcondition %}
                  and fiscal_date.chain_id != 3000
                  and fiscal_date.calendar_type = 'FISCAL'
              ),
           enterprise_default_fiscal_calendar
           as (select fiscal_date.chain_id calendar_owner_chain_id,
                      d_chain.chain_id,
                      fiscal_date.calendar_date,
                      fiscal_date.fiscal_year,
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
                      fiscal_date.fiscal_day_of_year
                 from edw.d_fiscal_date fiscal_date,
                      edw.d_chain
                where fiscal_date.chain_id = 3000
                  and {% condition chain.chain_id %} d_chain.chain_id {% endcondition %}
                  and d_chain.source_system_id = 5
                  and fiscal_date.calendar_type = 'FISCAL'
              ),
           fiscal_calendar
           as (select *
                 from customer_chain_fiscal_calendar
               union all
               select enterprise_default_fiscal_calendar.*
                 from enterprise_default_fiscal_calendar
                where not exists (select 1
                                    from customer_chain_fiscal_calendar
                                   where enterprise_default_fiscal_calendar.chain_id = customer_chain_fiscal_calendar.chain_id
                                 )
              )
              select fiscal_calendar.*
                from fiscal_calendar
       ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
    value_format: "######"
  }

  dimension: calendar_date {
    label: "Calendar Date"
    type: date
    hidden: yes
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: fiscal_year {
    label: "Year"
    type: number
    sql: ${TABLE}.FISCAL_YEAR ;;
    group_label: "Year"
    value_format: "######"
  }

  dimension: fiscal_day_of_week {
    label: "Week Index"
    type: number
    sql: ${TABLE}.FISCAL_DAY_OF_WEEK ;;
    group_label: "Week"
    value_format: "######"
    description: "Day number of the week"
  }

  dimension: fiscal_week_begin_date {
    label: "Week Begin Date"
    type: date
    sql: ${TABLE}.FISCAL_WEEK_BEGIN_DATE ;;
    group_label: "Week"
    description: "Start date of the week"
  }

  dimension: fiscal_week_end_date {
    label: "Week End Date"
    type: date
    sql: ${TABLE}.FISCAL_WEEK_END_DATE ;;
    group_label: "Week"
    description: "End date of the week"
  }

  dimension: fiscal_week_of_year {
    label: "Week Of Year"
    type: number
    sql: ${TABLE}.FISCAL_WEEK_OF_YEAR ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the year"
  }

  dimension: fiscal_week_of_month {
    label: "Week Of Month"
    type: number
    sql: ${TABLE}.FISCAL_WEEK_OF_MONTH ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the month"
  }

  dimension: fiscal_week_of_quarter {
    label: "Week Of Quarter"
    type: number
    sql: ${TABLE}.FISCAL_WEEK_OF_QUARTER ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the quarter"
  }

  dimension: fiscal_month_begin_date {
    label: "Month Begin Date"
    type: date
    sql: ${TABLE}.FISCAL_MONTH_BEGIN_DATE ;;
    group_label: "Month"
    description: "Start date of the month"
  }

  dimension: fiscal_month_end_date {
    label: "Month End Date"
    type: date
    sql: ${TABLE}.FISCAL_MONTH_END_DATE ;;
    group_label: "Month"
    description: "End date of the month"
  }

  dimension: fiscal_month_of_year {
    label: "Month Of Year"
    type: number
    sql: ${TABLE}.FISCAL_MONTH_OF_YEAR ;;
    group_label: "Month"
    value_format: "######"
    description: "Month number of the year"
  }

  dimension: fiscal_total_weeks_in_month {
    label: "Total Weeks In Month"
    type: number
    sql: ${TABLE}.FISCAL_TOTAL_WEEKS_IN_MONTH ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the month"
  }

  dimension: fiscal_quarter_begin_date {
    label: "Quarter Begin Date"
    type: date
    sql: ${TABLE}.FISCAL_QUARTER_BEGIN_DATE ;;
    group_label: "Quarter"
    description: "Start date of the quarter"
  }

  dimension: fiscal_quarter_end_date {
    label: "Quarter End Date"
    type: date
    sql: ${TABLE}.FISCAL_QUARTER_END_DATE ;;
    group_label: "Quarter"
    description: "End date of the quarter"
  }

  dimension: fiscal_quarter_of_year {
    label: "Quarter Of Year"
    type: number
    sql: ${TABLE}.FISCAL_QUARTER_OF_YEAR ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Quarter number of the year"
  }

  dimension: fiscal_total_weeks_in_quarter {
    label: "Total Weeks In Quarter"
    type: number
    sql: ${TABLE}.FISCAL_TOTAL_WEEKS_IN_QUARTER ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the quarter"
  }

  dimension: fiscal_year_begin_date {
    label: "Year Begin Date"
    type: date
    sql: ${TABLE}.FISCAL_YEAR_BEGIN_DATE ;;
    group_label: "Year"
    description: "Start date of the year"
  }

  dimension: fiscal_year_end_date {
    label: "Year End Date"
    type: date
    sql: ${TABLE}.FISCAL_YEAR_END_DATE ;;
    group_label: "Year"
    description: "End date of the year"
  }

  dimension: fiscal_total_weeks_in_year {
    label: "Total Weeks In Year"
    type: number
    sql: ${TABLE}.FISCAL_TOTAL_WEEKS_IN_YEAR ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the year"
  }

  dimension: fiscal_leap_year_flag {
    label: "Leap Year"
    type: yesno
    sql: ${TABLE}.FISCAL_LEAP_YEAR_FLAG ='Y' ;;
    group_label: "Year"
    description: "Flag indicates that Year is leap year"
  }

  dimension: fiscal_budget_period_identifier {
    label: "Budget Period Identifier"
    type: string
    sql: ${TABLE}.FISCAL_BUDGET_PERIOD_IDENTIFIER ;;
    group_label: "Year"
    description: "Customer's budget period identifier"
  }

  dimension: fiscal_day_of_month {
    label: "Day Of Month"
    type: number
    sql: ${TABLE}.FISCAL_DAY_OF_MONTH ;;
    group_label: "Month"
    value_format: "######"
    description: "Day number of the month"
  }

  dimension: fiscal_day_of_quarter {
    label: "Day Of Quarter"
    type: number
    sql: ${TABLE}.FISCAL_DAY_OF_QUARTER ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Day number of the quarter"
  }

  dimension: fiscal_day_of_year {
    label: "Day Of Year"
    type: number
    sql: ${TABLE}.FISCAL_DAY_OF_YEAR ;;
    value_format: "######"
    group_label: "Year"
    description: "Day number of the year"
  }
}

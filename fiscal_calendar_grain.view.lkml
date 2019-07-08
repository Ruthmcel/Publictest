view: fiscal_calendar_grain {
  #[ERXDWPS-5064] Derived view added to get the information about whether the current day is start of the month/quarter/year and end of the month/quarter/year.
  # For PDX_CUSTOMER_MODEL Start/end of the month/quarter/year are calculated based on current_date.
  # For ABSOLUTE_AR_DSS Start/end of the month/quarter/year are calculated based on current_date- 6 days. AR Team want to run the reports for start of the month/quarter/year after 6 days of completion of month/quarter/year.
  derived_table: {
    sql: with calendar_grain as
          (select chain_id,
                  calendar_date,
                  current_date() as current_day,
                  case when calendar_date = current_date() and calendar_date = fiscal_month_begin_date then 'FIRST DAY OF FISCAL MONTH' end as start_of_month,
                  case when calendar_date = current_date() and calendar_date = fiscal_month_end_date then 'LAST DAY OF FISCAL MONTH' end as end_of_month,
                  case when calendar_date = current_date() and calendar_date = fiscal_quarter_begin_date then 'FIRST DAY OF FISCAL QUARTER' end as start_of_quarter,
                  case when calendar_date = current_date() and calendar_date = fiscal_quarter_end_date then 'LAST DAY OF FISCAL QUARTER' end as end_of_quarter,
                  case when calendar_date = current_date() and calendar_date = fiscal_year_begin_date then 'FIRST DAY OF FISCAL YEAR' end as start_of_year,
                  case when calendar_date = current_date() and calendar_date = fiscal_year_end_date then 'LAST DAY OF FISCAL YEAR' end as end_of_year,
                  case when calendar_date <> current_date() and calendar_date = fiscal_month_begin_date then 'DELAYED FIRST DAY OF FISCAL MONTH' end as delayed_start_of_month,
                  case when calendar_date <> current_date() and calendar_date = fiscal_month_end_date then 'DELAYED LAST DAY OF FISCAL MONTH' end as delayed_end_of_month,
                  case when calendar_date <> current_date() and calendar_date = fiscal_quarter_begin_date then 'DELAYED FIRST DAY OF FISCAL QUARTER' end as delayed_start_of_quarter,
                  case when calendar_date <> current_date() and calendar_date = fiscal_quarter_end_date then 'DELAYED LAST DAY OF FISCAL QUARTER' end as delayed_end_of_quarter,
                  case when calendar_date <> current_date() and calendar_date = fiscal_year_begin_date then 'DELAYED FIRST DAY OF FISCAL YEAR' end as delayed_start_of_year,
                  case when calendar_date <> current_date() and calendar_date = fiscal_year_end_date then 'DELAYED LAST DAY OF FISCAL YEAR' end as delayed_end_of_year
            from edw.d_fiscal_date
            where calendar_date in (to_date(current_date()), dateadd('day', -6, current_date()))
              and calendar_type = 'FISCAL'
          ),
          calendar_grain_detail as
          (
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, start_of_month as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, end_of_month as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, start_of_quarter as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, end_of_quarter as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, start_of_year as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'PDX_CUSTOMER_DSS' as model_name, calendar_date, end_of_year as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, start_of_month as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, end_of_month as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, start_of_quarter as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, end_of_quarter as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, start_of_year as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, end_of_year as grain from calendar_grain where calendar_date = current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_start_of_month as grain from calendar_grain where calendar_date <> current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_end_of_month as grain from calendar_grain where calendar_date <> current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_start_of_quarter as grain from calendar_grain where calendar_date <> current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_end_of_quarter as grain from calendar_grain where calendar_date <> current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_start_of_year as grain from calendar_grain where calendar_date <> current_day union
          select chain_id, 'ABSOLUTE_AR_DSS' as model_name, calendar_date, delayed_end_of_year as grain from calendar_grain where calendar_date <> current_day
          )
          select chain_id, model_name, calendar_date, NVL(grain, 'NONE') as calendar_grain from calendar_grain_detail ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type:  string
    sql: ${chain_id}||'@'||${model_name}||'@'||${calendar_date}||'@'||${calendar_grain} ;;
  }

  #################################################################################################### Foreign Key References #####################################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: calendar_date {
    hidden: yes
    #timeframes: [date]
    type: date
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: model_name {
    hidden: yes
    type: string
    sql: ${TABLE}.MODEL_NAME ;;
  }

  dimension: calendar_grain {
    hidden: yes
    type: string
    sql: ${TABLE}.CALENDAR_GRAIN ;;
  }

  filter: fiscal_calendar_schedule_filter {
    label: "Schedule Frequency (Fiscal Calendar)*"
    description: "This is a report level filter with two outcomes; It either returns all report results, or does not return any results. The filter is purposed to schedule reports based on your Fiscal Calendar. The options for the filter are; FIRST DAY OF THE FISCAL MONTH/QUARTER/YEAR, or LAST DAY OF THE FISCAL MONTH/QUARTER/YEAR. The chosen option will be compared to the current day. For example, if today's date is the FIRST DAY OF THE FISCAL MONTH, results will be returned. If it is not, no results will be returned."
    type: string
    suggestions: ["FIRST DAY OF FISCAL MONTH",
                  "LAST DAY OF FISCAL MONTH",
                  "FIRST DAY OF FISCAL QUARTER",
                  "LAST DAY OF FISCAL QUARTER",
                  "FIRST DAY OF FISCAL YEAR",
                  "LAST DAY OF FISCAL YEAR"]
  }

  filter: fiscal_calendar_schedule_with_delayed_filter {
    label: "Schedule Frequency (Fiscal Calendar)*"
    description: "This is a report level filter with two outcomes; It either returns all report results, or does not return any results. The filter is purposed to schedule reports based on your Fiscal Calendar. The options for the filter are; FIRST DAY OF THE FISCAL MONTH/QUARTER/YEAR, LAST DAY OF THE FISCAL MONTH/QUARTER/YEAR, DELAYED FIRST DAY OF THE FISCAL MONTH/QUARTER/YEAR, or DELAYED LAST DAY OF THE FISCAL MONTH/QUARTER/YEAR. The chosen FISCAL option will be compared to the current day. For example, if today's date is the FIRST DAY OF THE FISCAL MONTH, results will be returned. If it is not, no results will be returned. The chosen DELAYED FISCAL option will be compared to the current day offset to 6 days. For example, if 6 days back from today's date is the FIRST DAY OF THE FISCAL MONTH, results will be returned today. If it is not, no results will be returned."
    type: string
    suggestions: ["FIRST DAY OF FISCAL MONTH",
                  "LAST DAY OF FISCAL MONTH",
                  "FIRST DAY OF FISCAL QUARTER",
                  "LAST DAY OF FISCAL QUARTER",
                  "FIRST DAY OF FISCAL YEAR",
                  "LAST DAY OF FISCAL YEAR",
                  "DELAYED FIRST DAY OF FISCAL MONTH",
                  "DELAYED LAST DAY OF FISCAL MONTH",
                  "DELAYED FIRST DAY OF FISCAL QUARTER",
                  "DELAYED LAST DAY OF FISCAL QUARTER",
                  "DELAYED FIRST DAY OF FISCAL YEAR",
                  "DELAYED LAST DAY OF FISCAL YEAR"]
  }
}

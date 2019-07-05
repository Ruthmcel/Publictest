view: calendar_standard {
  sql_table_name: EDW.D_DATE ;;

  dimension: calendar_date {
    label: "Date"
    type: date
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: day_of_week_us_standard {
    label: "Week Index - US"
    type: number
    sql: ${TABLE}.DAY_OF_WEEK_US_STANDARD ;;
    group_label: "Week"
    description: "Day number of the week where week starts on Sunday"
    value_format: "######"
  }

  dimension: day_of_week_full_name {
    label: "Day Of Week"
    type: string
    sql: ${TABLE}.DAY_OF_WEEK_FULL_NAME ;;
    group_label: "Week"
    description: "Day of the week"
  }

  dimension: day_of_week_short_name {
    label: "Day Of Week - Abbreviate"
    type: string
    sql: ${TABLE}.DAY_OF_WEEK_SHORT_NAME ;;
    group_label: "Week"
    description: "Abbreviation of day of the week"
  }

  dimension: day_of_month {
    label: "Day Of Month"
    type: number
    sql: ${TABLE}.DAY_OF_MONTH ;;
    group_label: "Month"
    value_format: "######"
    description: "Day number of the month"
  }

  dimension: total_days_in_month {
    label: "Total Days In Month"
    type: number
    sql: ${TABLE}.TOTAL_DAYS_IN_MONTH ;;
    group_label: "Month"
    value_format: "######"
    description: "Total number of days of in the month "
  }

  dimension: days_remaining_in_month {
    label: "Days Remaining In Month"
    type: number
    sql: ${TABLE}.DAYS_REMAINING_IN_MONTH ;;
    group_label: "Month"
    value_format: "######"
    description: "Number of days remaining in the month"
  }

  dimension: day_of_quarter {
    label: "Day Of Quarter"
    type: number
    sql: ${TABLE}.DAY_OF_QUARTER ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Day number of the quarter"
  }

  dimension: total_days_in_quarter {
    label: "Total Days In Quarter"
    type: number
    sql: ${TABLE}.TOTAL_DAYS_IN_QUARTER ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Total number of days in the quarter"
  }

  dimension: days_remaining_in_quarter {
    label: "Days Remaining In Quarter"
    type: number
    sql: ${TABLE}.DAYS_REMAINING_IN_QUARTER ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Number of days remaining in the quarter"
  }

  dimension: day_of_year {
    label: "Day Of Year"
    type: number
    sql: ${TABLE}.DAY_OF_YEAR ;;
    group_label: "Year"
    value_format: "######"
    description: "Day number of the year"
  }

  dimension: total_days_in_year {
    label: "Total Days In Year"
    type: number
    sql: ${TABLE}.TOTAL_DAYS_IN_YEAR ;;
    group_label: "Year"
    value_format: "######"
    description: "Total number of days in the year"
  }

  dimension: days_remaining_in_year {
    label: "Days Remaining In Year"
    type: number
    sql: ${TABLE}.DAYS_REMAINING_IN_YEAR ;;
    group_label: "Year"
    value_format: "######"
    description: "Number of days remaining in the year"
  }

  dimension: week_of_month_us_standard {
    label: "Week Of Month - US"
    type: number
    sql: ${TABLE}.WEEK_OF_MONTH_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the month where week starts on Sunday"
  }

  dimension: week_of_year_iso_standard {
    label: "Week Of Year - ISO"
    type: number
    sql: ${TABLE}.WEEK_OF_YEAR_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the Year where week starts on Monday"
  }

  dimension: month_of_quarter {
    label: "Month Of Quarter"
    type: number
    sql: ${TABLE}.MONTH_OF_QUARTER ;;
    group_label: "Month"
    value_format: "######"
    description: "Month number of the quarter"
  }

  dimension: month_of_year {
    label: "Month Num"
    type: number
    sql: ${TABLE}.MONTH_OF_YEAR ;;
    group_label: "Month"
    value_format: "######"
    description: "Month number of the year"
  }

  dimension: month_of_year_full_name {
    label: "Month Of Year"
    type: string
    sql: ${TABLE}.MONTH_OF_YEAR_FULL_NAME ;;
    group_label: "Month"
    description: "Month of the year"
  }

  dimension: month_of_year_short_name {
    label: "Month Of Year - Abbreviate"
    type: string
    sql: ${TABLE}.MONTH_OF_YEAR_SHORT_NAME ;;
    group_label: "Month"
    description: "Abbreviation of month of the year"
  }

  dimension: quarter_of_year {
    label: "Quarter Num"
    type: number
    sql: ${TABLE}.QUARTER_OF_YEAR ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Quarter number of the year"
  }

  dimension: quarter_of_year_name {
    label: "Quarter Of Year"
    type: string
    sql: ${TABLE}.QUARTER_OF_YEAR_NAME ;;
    group_label: "Quarter"
    description: "Quarter of the year"
  }

  dimension: year {
    label: "Year"
    type: number
    sql: ${TABLE}.YEAR ;;
    group_label: "Year"
    value_format: "######"
  }

  dimension: year_month_of_year {
    label: "Year - Month"
    type: number
    sql: ${TABLE}.YEAR_MONTH_OF_YEAR ;;
    group_label: "Month"
    value_format: "######"
    description: "Concated value of Year & Month"
  }

  dimension: year_quarter_of_year {
    label: "Year - Quarter"
    type: number
    sql: ${TABLE}.YEAR_QUARTER_OF_YEAR ;;
    group_label: "Quarter"
    value_format: "######"
    description: "Concated value of Year & Quarter"
  }

  dimension: day_of_week_iso_standard {
    label: "Week Index - ISO"
    type: number
    sql: ${TABLE}.DAY_OF_WEEK_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Day number of the week where week starts on Monday"
  }

  dimension: week_begin_date_iso_standard {
    label: "Week Begin Date - ISO"
    type: date
    sql: ${TABLE}.WEEK_BEGIN_DATE_ISO_STANDARD ;;
    group_label: "Week"
    description: "Week begin date where week starts on Monday"
  }

  dimension: week_end_date_iso_standard {
    label: "Week End Date - ISO"
    type: date
    sql: ${TABLE}.WEEK_END_DATE_ISO_STANDARD ;;
    group_label: "Week"
    description: "Week end date where week starts on Monday"
  }

  dimension: week_begin_date_us_standard {
    label: "Week Begin Date - US"
    type: date
    sql: ${TABLE}.WEEK_BEGIN_DATE_US_STANDARD ;;
    group_label: "Week"
    description: "Week begin date where week starts on Sunday"
  }

  dimension: week_end_date_us_standard {
    label: "Week End Date - US"
    type: date
    sql: ${TABLE}.WEEK_END_DATE_US_STANDARD ;;
    group_label: "Week"
    description: "Week end date where week starts on Sunday"
  }

  dimension: week_of_month_iso_standard {
    label: "Week Of Month - ISO"
    type: number
    sql: ${TABLE}.WEEK_OF_MONTH_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the month where week starts on Monday"
  }

  dimension: week_of_quarter_iso_standard {
    label: "Week Of Quarter - ISO"
    type: number
    sql: ${TABLE}.WEEK_OF_QUARTER_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the quarter where week starts on Monday"
  }

  dimension: week_of_quarter_us_standard {
    label: "Week Of Quarter - US"
    type: number
    sql: ${TABLE}.WEEK_OF_QUARTER_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the quarter where week starts on Sunday"
  }

  dimension: week_of_year_us_standard {
    label: "Week Of Year - US"
    type: number
    sql: ${TABLE}.WEEK_OF_YEAR_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Week number of the year where week starts on Sunday"
  }

  dimension: month_begin_date {
    label: "Month Begin Date"
    type: date
    sql: ${TABLE}.MONTH_BEGIN_DATE ;;
    group_label: "Month"
    description: "Start date of the Month"
  }

  dimension: month_end_date {
    label: "Month End Date"
    type: date
    sql: ${TABLE}.MONTH_END_DATE ;;
    group_label: "Month"
    description: "End date of the Month"
  }

  dimension: total_weeks_in_month_us_standard {
    label: "Total Weeks In Month - US"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_MONTH_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the year where week starts on Sunday"
  }

  dimension: total_weeks_in_month_iso_standard {
    label: "Total Weeks In Month - ISO"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_MONTH_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the month where week starts on Monday"
  }

  dimension: quarter_begin_date {
    label: "Quarter Begin Date"
    type: date
    sql: ${TABLE}.QUARTER_BEGIN_DATE ;;
    group_label: "Quarter"
    description: "Start date of the Quarter"
  }

  dimension: quarter_end_date {
    label: "Quarter End Date"
    type: date
    sql: ${TABLE}.QUARTER_END_DATE ;;
    group_label: "Quarter"
    description: "End date of the Quarter"
  }

  dimension: total_weeks_in_quarter_us_standard {
    label: "Total Weeks In Quarter - US"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_QUARTER_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the quarter where week starts on Sunday"
  }

  dimension: total_weeks_in_quarter_iso_standard {
    label: "Total Weeks In Quarter - ISO"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_QUARTER_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the quarter where week starts on Monday"
  }

  dimension: year_begin_date {
    label: "Year Begin Date"
    type: date
    sql: ${TABLE}.YEAR_BEGIN_DATE ;;
    group_label: "Year"
    description: "Start date of the Year"
  }

  dimension: year_end_date {
    label: "Year End Date"
    type: date
    sql: ${TABLE}.YEAR_END_DATE ;;
    group_label: "Year"
    description: "End date of the Year"
  }

  dimension: total_weeks_in_year_us_standard {
    label: "Total Weeks In Year - US"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_YEAR_US_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the year where week starts on Sunday"
  }

  dimension: total_weeks_in_year_iso_standard {
    label: "Total Weeks In Year - ISO"
    type: number
    sql: ${TABLE}.TOTAL_WEEKS_IN_YEAR_ISO_STANDARD ;;
    group_label: "Week"
    value_format: "######"
    description: "Total number of weeks in the year where week starts on Monday"
  }

  dimension: leap_year_flag {
    label: "Leap Year"
    type: yesno
    sql: ${TABLE}.LEAP_YEAR_FLAG = 'Y' ;;
    group_label: "Year"
    description: "Flag indicates that Year is leap year"
  }

  dimension: julian_date {
    label: "Julian Date"
    type: number
    sql: ${TABLE}.JULIAN_DATE ;;
    value_format: "######"
  }

  dimension: calendar_date_yyyymmdd {
    label: "Date YYYYMMDD"
    type: number
    hidden: yes
    sql: ${TABLE}.CALENDAR_DATE_YYYYMMDD ;;
    value_format: "######"
  }
}

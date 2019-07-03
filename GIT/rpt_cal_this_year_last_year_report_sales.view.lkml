view: rpt_cal_this_year_last_year_report_sales {
  derived_table: {
    sql: SELECT
      CALENDAR_DATE AS REPORT_DATE,(CASE WHEN TO_CHAR(CALENDAR_DATE,'MM-DD') = '02-29' THEN NULL ELSE DATEADD(YEAR,-1,CALENDAR_DATE) END)  AS CALENDAR_DATE, 'LY' AS TYPE
      FROM ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2010-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE FROM TABLE(GENERATOR(rowCount => 5113)) )
      WHERE {% condition rx_tx.this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}     -- Will ensure records are fetched from report calendar only when LY analysis is performed on the Reportable Sales Date
      AND {% condition rx_tx.reportable_sales_date_filter %} CALENDAR_DATE {% endcondition %}

      UNION ALL

      SELECT CALENDAR_DATE AS CAL,CALENDAR_DATE AS CALENDAR_DATE, 'TY' AS TYPE
      FROM ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2010-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE FROM TABLE(GENERATOR(rowCount => 5113)) )
      WHERE {% condition rx_tx.this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}     -- Will ensure records are fetched from report calendar only when LY analysis is performed on the Reportable Sales Date
      AND {% condition rx_tx.reportable_sales_date_filter %} CALENDAR_DATE {% endcondition %}
       ;;
  }

  dimension_group: report {
    # used only for Report Calculation purpose but not as a dimension to be exposed in explore
    hidden: yes
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

  dimension: calendar_date {
    # used only for join purpose
    hidden: yes
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: type {
    # used only for Report Calculation purpose but not as a dimension to be exposed in explore
    hidden: yes
    type: string
    sql: ${TABLE}.TYPE ;;
  }
}

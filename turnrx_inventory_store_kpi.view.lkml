view: turnrx_inventory_store_kpi {
  label: "Pharmacy Inventory KPI"
  sql_table_name: EDW.F_INVENTORY_STORE_KPI ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${activity_date} || '@' || ${event_type} || '@' || ${report_calendar_global.type} || '@' || ${report_calendar_global.report_date} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: activity_date {
    label: "Activity Date"
    type: date
    hidden: yes
    sql: ${TABLE}.ACTIVITY_DATE ;;
  }

  dimension: event_type {
    label: "Event Type"
    type: string
    hidden: yes
    sql: ${TABLE}.EVENT_TYPE ;;
  }

  ############################################################ END OF PK/FK References ############################################################

  dimension: store_kpi_script_count {
    label: "script count"
    description: "Count of non-credited sales records minus the total number of credited sales records that fall within each financial date range"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_SCRIPT_COUNT ;;
  }

  dimension: store_kpi_sales_amount {
    label: "Sales Amount"
    description: "Sum of sales for all sales records included in the script count"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_SALES_AMOUNT ;;
  }

  dimension: store_kpi_will_call_return_to_stock_count {
    label: "Will Call Return To Stock Count"
    description: "Count of scripts that have been returned to stock"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_RETURN_TO_STOCK_COUNT ;;
  }

  dimension: store_kpi_cost_of_goods_sold_amount {
    label: "Cost Of Goods Sold Amount"
    description: "Sum of the acquisition cost for all sales records included in the script count"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_COST_OF_GOODS_SOLD_AMOUNT ;;
  }

  dimension: store_kpi_cost_of_goods_purchase_amount {
    label: "Cost Of Goods Purchase Amount"
    description: "Sum of the cost on drug order records where the applied to inventory date falls within each financial date range"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_COST_OF_GOODS_PURCHASE_AMOUNT ;;
  }

  dimension: store_kpi_return_and_adjustment_amount {
    label: "Return And Adjustment Amount"
    description: "Sum of the cost from the return and adjustment records where the return and adjustment applied date falls within each financial date range"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_RETURN_AND_ADJUSTMENT_AMOUNT ;;
  }

  dimension: store_kpi_inventory_amount {
    label: "Inventory Amount"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_INVENTORY_AMOUNT ;;
  }

  dimension: store_kpi_goal_inventory_amount {
    label: "Goal Inventory Amount"
    description: "Inventory dollar goal as established by the chain"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_GOAL_INVENTORY_AMOUNT ;;
  }

  dimension: store_kpi_goal_turn_per_period {
    label: "Goal Turn Per Period"
    description: ""
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_GOAL_TURN_PER_PERIOD ;;
  }

  dimension: store_kpi_autofill_count {
    label: "Autofill Count"
    description: "Count of transactions which were filled from autofill (refill source = 2)"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_AUTOFILL_COUNT ;;
  }

  dimension: store_kpi_non_autofill_count {
    label: "Non Autofill Count"
    description: "Count of transactions which were not filled from autofill (refill source !=2)"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_NON_AUTOFILL_COUNT ;;
  }

  dimension: store_kpi_will_call_autofill_return_to_stock_count {
    label: "Will Call Autofill Return To Stock Count"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_AUTOFILL_RETURN_TO_STOCK_COUNT ;;
  }

  dimension: store_kpi_will_call_non_autofill_return_to_stock_count {
    label: "Will Call Non Autofill Return To Stock Count"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_NON_AUTOFILL_RETURN_TO_STOCK_COUNT ;;
  }

  dimension: store_kpi_will_call_return_to_stock_past_due_count {
    label: "Will Call Return To Stock Past Due Count"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_RETURN_TO_STOCK_PAST_DUE_COUNT ;;
  }

  dimension: store_kpi_will_call_past_due_count {
    label: "Will Call Past Due Count"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_PAST_DUE_COUNT ;;
  }

  dimension: store_kpi_cycle_count_task_received_count {
    label: "Cycle Count Task Received Count"
    description: "Count of cycle count tasks received by the stores"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_CYCLE_COUNT_TASK_RECEIVED_COUNT ;;
  }

  dimension: store_kpi_cycle_count_task_complete_count {
    label: "Cycle Count Task Complete Count"
    description: "Count of cycle count tasks completed by the stores"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_CYCLE_COUNT_TASK_COMPLETE_COUNT ;;
  }

  dimension: store_kpi_cycle_count_task_accurate_count {
    label: "Cycle Count Task Accurate Count"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_CYCLE_COUNT_TASK_ACCURATE_COUNT ;;
  }

  dimension: store_kpi_cycle_count_task_expire_count {
    label: "Cycle Count Task Expire Count"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_CYCLE_COUNT_TASK_EXPIRE_COUNT ;;
  }

  dimension: store_kpi_will_call_arrival_count {
    label: "Will Call Arrival Count"
    description: "Count of transactions in the script count which arrived in will call"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_ARRIVAL_COUNT ;;
  }

  dimension: store_kpi_will_call_autofill_arrival_count {
    label: "Will Call Autofill Arrival Count"
    description: "Count of transactions which were filled from autofill and arrived in will call"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_AUTOFILL_ARRIVAL_COUNT ;;
  }

  dimension: store_kpi_will_call_non_autofill_arrival_count {
    label: "Will Call Non Autofill Arrival Count"
    description: "Count of transactions which were not filled from autofill and arrived in will call"
    type: number
    hidden:yes
    sql: ${TABLE}.STORE_KPI_WILL_CALL_NON_AUTOFILL_ARRIVAL_COUNT ;;
  }

  ############################################################ Date Fields Begin ############################################################

  dimension_group: report {
    type: time
    label: "KPI Report Period"
    timeframes: [date]
    description: "Report Period Date. Example output '2017-01-13'"
    sql: ${report_calendar_global.report_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_calendar_date {
    label: "Reportable KPI Activity Date"
    description: "KPI Activity Date"
    type: date
    hidden: yes
    sql: ${timeframes.calendar_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_chain_id {
    label: "Reportable KPI Chain ID"
    description: "Prescription Activity Date Chain ID"
    type: number
    hidden: yes
    sql: ${timeframes.chain_id} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_calendar_owner_chain_id {
    label: "Reportable KPI Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${timeframes.calendar_owner_chain_id} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_day_of_week {
    label: "Reportable KPI Day Of Week"
    description: "Reportable KPI Day Of Week Full Name. Example output 'Monday'"
    type: string
    sql: ${timeframes.day_of_week} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_day_of_month {
    label: "Reportable KPI Day Of Period"
    description: "Reportable KPI Day Of Period. Example output '1'"
    type: number
    sql: ${timeframes.day_of_month} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_week_of_year {
    label: "Reportable KPI Week Of Year"
    description: "Reportable KPI Week Of Year. Example output '1'"
    type: number
    sql: ${timeframes.week_of_year} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_month_num {
    label: "Reportable KPI Period Num"
    description: "Reportable KPI Period Of Year. Example output '1'"
    type: number
    sql: ${timeframes.month_num} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_month {
    label: "Reportable KPI Period"
    description: "Reportable KPI Period. Example output '2017-01'"
    type: string
    sql: ${timeframes.month} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_quarter_of_year {
    label: "Reportable KPI Quarter Of Year"
    description: "Reportable KPI Quarter Of Year. Example output 'Q1'"
    type: string
    sql: ${timeframes.quarter_of_year} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_quarter {
    label: "Reportable KPI Quarter"
    description: "Reportable KPI Quarter. Example output '2017-Q1'"
    type: string
    sql: ${timeframes.quarter} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_year {
    label: "Reportable KPI Year"
    description: "Reportable KPI Year. Example output '2017'"
    type: number
    sql: ${timeframes.year} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_day_of_week_index {
    label: "Reportable KPI day Of Week Index"
    description: "Reportable KPI Day Of Week Index. Example output '1'"
    type: number
    sql: ${timeframes.day_of_week_index} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_week_begin_date {
    label: "Reportable KPI Week Begin Date"
    description: "Reportable KPI Week Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${timeframes.week_begin_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_week_end_date {
    label: "Reportable KPI Week End Date"
    description: "Reportable KPI Week End Date. Example output '2017-01-19'"
    type: date
    sql: ${timeframes.week_end_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_week_of_quarter {
    label: "Reportable KPI Week Of Quarter"
    description: "Reportable KPI Week of Quarter. Example output '1'"
    type: number
    sql: ${timeframes.week_of_quarter} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_month_begin_date {
    label: "Reportable KPI Period Begin Date"
    description: "Reportable KPI Period Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${timeframes.month_begin_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_month_end_date {
    label: "Reportable KPI Period End Date"
    description: "Reportable KPI Period End Date. Example output '2017-01-31'"
    type: date
    sql: ${timeframes.month_end_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_weeks_in_month {
    label: "Reportable KPI Weeks In Period"
    description: "Reportable KPI Weeks In Period. Example output '4'"
    type: number
    sql: ${timeframes.weeks_in_month} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_quarter_begin_date {
    label: "Reportable KPI Quarter Begin Date"
    description: "Reportable KPI Quarter Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${timeframes.quarter_begin_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_quarter_end_date {
    label: "Reportable KPI Quarter End Date"
    description: "Reportable KPI Quarter End Date. Example output '2017-03-31'"
    type: date
    sql: ${timeframes.quarter_end_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_weeks_in_quarter {
    label: "Reportable KPI Weeks In Quarter"
    description: "Reportable KPI Weeks In Quarter. Example output '13'"
    type: number
    sql: ${timeframes.weeks_in_quarter} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_year_begin_date {
    label: "Reportable KPI Year Begin Date"
    description: "Reportable KPI Year Begin Date. Example output '2017-01-13'"
    type: date
    sql: ${timeframes.year_begin_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_year_end_date {
    label: "Reportable KPI Year End Date"
    description: "Reportable KPI Year End Date. Example output '2017-12-31'"
    type: date
    sql: ${timeframes.year_end_date} ;;
    group_label: "Reportable KPI Date"
    allow_fill: no
  }

  dimension: reportable_weeks_in_year {
    label: "Reportable KPI Weeks In Year"
    description: "Reportable KPI Weeks In Year. Example output '52'"
    type: number
    sql: ${timeframes.weeks_in_year} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_leap_year_flag {
    label: "Reportable KPI Leap Year Flag"
    description: "Reportable KPI Leap Year Flag. Example output 'N'"
    type: string
    sql: ${timeframes.leap_year_flag} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_day_of_quarter {
    label: "Reportable KPI Day Of Quarter"
    description: "Reportable KPI Day of Quarter. Example output '1'"
    type: number
    sql: ${timeframes.day_of_quarter} ;;
    group_label: "Reportable KPI Date"
  }

  dimension: reportable_day_of_year {
    label: "Reportable KPI Day Of Year"
    description: "Reportable KPI Day of Year. Example output '1'"
    type: number
    sql: ${timeframes.day_of_year} ;;
    group_label: "Reportable KPI Date"
  }

  ############################################################ Date Fields Begin ############################################################

  ############################################################ END OF DIMENSIONS ############################################################

  measure: sum_script_count_ty {
    label: "Script Count"
    description: "Count of transactions sold less the count of transactions credit returned for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty]
  }

  measure: sum_script_count_ly {
    label: "LY Script Count"
    description: "Count of transactions sold less the count of transactions credit returned for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly]
  }

  measure: sum_script_count_ty_wtd {
    label: "Script Count - WTD"
    description: "Count of transactions sold less the count of transactions credit returned for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_wtd]
  }

  measure: sum_script_count_ly_wtd {
    label: "LY Script Count - WTD"
    description: "Count of transactions sold less the count of transactions credit returned for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_wtd]
  }

  measure: sum_script_count_ty_wk {
    label: "Script Count - Complete Week"
    description: "Count of transactions sold less the count of transactions credit returned for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_wk]
  }

  measure: sum_script_count_ly_wk {
    label: "LY Script Count - Complete Week"
    description: "Count of transactions sold less the count of transactions credit returned for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_wk]
  }

  measure: sum_script_count_ty_ptd {
    label: "Script Count - PTD"
    description: "Count of transactions sold less the count of transactions credit returned for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_ptd]
  }

  measure: sum_script_count_ly_ptd {
    label: "LY Script Count - PTD"
    description: "Count of transactions sold less the count of transactions credit returned for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_ptd]
  }

  measure: sum_script_count_ty_pd {
    label: "Script Count - Complete Period"
    description: "Count of transactions sold less the count of transactions credit returned for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_pd]
  }

  measure: sum_script_count_ly_pd {
    label: "LY Script Count - Complete Period"
    description: "Count of transactions sold less the count of transactions credit returned for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_pd]
  }

  measure: sum_script_count_ty_qtd {
    label: "Script Count - QTD"
    description: "Count of transactions sold less the count of transactions credit returned for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_qtd]
  }

  measure: sum_script_count_ly_qtd {
    label: "LY Script Count - QTD"
    description: "Count of transactions sold less the count of transactions credit returned for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_qtd]
  }

  measure: sum_script_count_ty_qtr {
    label: "Script Count - Complete Quarter"
    description: "Count of transactions sold less the count of transactions credit returned for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_qtr]
  }

  measure: sum_script_count_ly_qtr {
    label: "LY Script Count - Complete Quarter"
    description: "Count of transactions sold less the count of transactions credit returned for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_qtr]
  }

  measure: sum_script_count_ty_ytd {
    label: "Script Count - YTD"
    description: "Count of transactions sold less the count of transactions credit returned for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_ytd]
  }

  measure: sum_script_count_ly_ytd {
    label: "LY Script Count - YTD"
    description: "Count of transactions sold less the count of transactions credit returned for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_ytd]
  }

  measure: sum_script_count_ty_yr {
    label: "Script Count - Complete Year"
    description: "Count of transactions sold less the count of transactions credit returned for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_yr]
  }

  measure: sum_script_count_ly_yr {
    label: "LY Script Count - Complete Year"
    description: "Count of transactions sold less the count of transactions credit returned for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_yr]
  }

  measure: sum_script_count_ty_ttm {
    label: "Script Count - TTM"
    description: "Count of transactions sold less the count of transactions credit returned for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_ttm]
  }

  measure: sum_script_count_ly_ttm {
    label: "LY Script Count - TTM"
    description: "Count of transactions sold less the count of transactions credit returned for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_ttm]
  }

  measure: sum_script_count_ty_rolling_13_week {
    label: "Script Count - Rolling 13 Week"
    description: "Count of transactions sold less the count of transactions credit returned for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ty_rolling_13_week]
  }

  measure: sum_script_count_ly_rolling_13_week {
    label: "LY Script Count - Rolling 13 Week"
    description: "Count of transactions sold less the count of transactions credit returned for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_script_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_script_count_ly_rolling_13_week]
  }

  measure: sum_sales_amount_ty {
    label: "Sales Amount"
    description: "Sum of sales amount for the transactions included in the script count for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty]
  }

  measure: sum_sales_amount_ly {
    label: "LY Sales Amount"
    description: "Sum of sales amount for the transactions included in the script count for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly]
  }

  measure: sum_sales_amount_ty_wtd {
    label: "Sales Amount - WTD"
    description: "Sum of sales amount for the transactions included in the script count for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_wtd]
  }

  measure: sum_sales_amount_ly_wtd {
    label: "LY Sales Amount - WTD"
    description: "Sum of sales amount for the transactions included in the script count for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_wtd]
  }

  measure: sum_sales_amount_ty_wk {
    label: "Sales Amount - Complete Week"
    description: "Sum of sales amount for the transactions included in the script count for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_wk]
  }

  measure: sum_sales_amount_ly_wk {
    label: "LY Sales Amount - Complete Week"
    description: "Sum of sales amount for the transactions included in the script count for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_wk]
  }

  measure: sum_sales_amount_ty_ptd {
    label: "Sales Amount - PTD"
    description: "Sum of sales amount for the transactions included in the script count for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_ptd]
  }

  measure: sum_sales_amount_ly_ptd {
    label: "LY Sales Amount - PTD"
    description: "Sum of sales amount for the transactions included in the script count for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_ptd]
  }

  measure: sum_sales_amount_ty_pd {
    label: "Sales Amount - Complete Period"
    description: "Sum of sales amount for the transactions included in the script count for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_pd]
  }

  measure: sum_sales_amount_ly_pd {
    label: "LY Sales Amount - Complete Period"
    description: "Sum of sales amount for the transactions included in the script count for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_pd]
  }

  measure: sum_sales_amount_ty_qtd {
    label: "Sales Amount - QTD"
    description: "Sum of sales amount for the transactions included in the script count for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_qtd]
  }

  measure: sum_sales_amount_ly_qtd {
    label: "LY Sales Amount - QTD"
    description: "Sum of sales amount for the transactions included in the script count for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_qtd]
  }

  measure: sum_sales_amount_ty_qtr {
    label: "Sales Amount - Complete Quarter"
    description: "Sum of sales amount for the transactions included in the script count for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_qtr]
  }

  measure: sum_sales_amount_ly_qtr {
    label: "LY Sales Amount - Complete Quarter"
    description: "Sum of sales amount for the transactions included in the script count for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_qtr]
  }

  measure: sum_sales_amount_ty_ytd {
    label: "Sales Amount - YTD"
    description: "Sum of sales amount for the transactions included in the script count for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_ytd]
  }

  measure: sum_sales_amount_ly_ytd {
    label: "LY Sales Amount - YTD"
    description: "Sum of sales amount for the transactions included in the script count for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_ytd]
  }

  measure: sum_sales_amount_ty_yr {
    label: "Sales Amount - Complete Year"
    description: "Sum of sales amount for the transactions included in the script count for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_yr]
  }

  measure: sum_sales_amount_ly_yr {
    label: "LY Sales Amount - Complete Year"
    description: "Sum of sales amount for the transactions included in the script count for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_yr]
  }

  measure: sum_sales_amount_ty_ttm {
    label: "Sales Amount - TTM"
    description: "Sum of sales amount for the transactions included in the script count for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_ttm]
  }

  measure: sum_sales_amount_ly_ttm {
    label: "LY Sales Amount - TTM"
    description: "Sum of sales amount for the transactions included in the script count for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_ttm]
  }

  measure: sum_sales_amount_ty_rolling_13_week {
    label: "Sales Amount - Rolling 13 Week"
    description: "Sum of sales amount for the transactions included in the script count for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ty_rolling_13_week]
  }

  measure: sum_sales_amount_ly_rolling_13_week {
    label: "LY Sales Amount - Rolling 13 Week"
    description: "Sum of sales amount for the transactions included in the script count for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_sales_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_sales_amount_ly_rolling_13_week]
  }

  measure: sum_will_call_return_to_stock_count_ty {
    label: "Return To Stock Count"
    description: "Count of transactions which were returned to stock after arriving in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty]
  }

  measure: sum_will_call_return_to_stock_count_ly {
    label: "LY Return To Stock Count"
    description: "Count of transactions which were returned to stock after arriving in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly]
  }

  measure: sum_will_call_return_to_stock_count_ty_wtd {
    label: "Return To Stock Count - WTD"
    description: "Count of transactions which were returned to stock after arriving in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_wtd]
  }

  measure: sum_will_call_return_to_stock_count_ly_wtd {
    label: "LY Return To Stock Count - WTD"
    description: "Count of transactions which were returned to stock after arriving in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_wtd]
  }

  measure: sum_will_call_return_to_stock_count_ty_wk {
    label: "Return To Stock Count - Complete Week"
    description: "Count of transactions which were returned to stock after arriving in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_wk]
  }

  measure: sum_will_call_return_to_stock_count_ly_wk {
    label: "LY Return To Stock Count - Complete Week"
    description: "Count of transactions which were returned to stock after arriving in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_wk]
  }

  measure: sum_will_call_return_to_stock_count_ty_ptd {
    label: "Return To Stock Count - PTD"
    description: "Count of transactions which were returned to stock after arriving in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_ptd]
  }

  measure: sum_will_call_return_to_stock_count_ly_ptd {
    label: "LY Return To Stock Count - PTD"
    description: "Count of transactions which were returned to stock after arriving in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_ptd]
  }

  measure: sum_will_call_return_to_stock_count_ty_pd {
    label: "Return To Stock Count - Complete Period"
    description: "Count of transactions which were returned to stock after arriving in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_pd]
  }

  measure: sum_will_call_return_to_stock_count_ly_pd {
    label: "LY Return To Stock Count - Complete Period"
    description: "Count of transactions which were returned to stock after arriving in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_pd]
  }

  measure: sum_will_call_return_to_stock_count_ty_qtd {
    label: "Return To Stock Count - QTD"
    description: "Count of transactions which were returned to stock after arriving in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_qtd]
  }

  measure: sum_will_call_return_to_stock_count_ly_qtd {
    label: "LY Return To Stock Count - QTD"
    description: "Count of transactions which were returned to stock after arriving in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_qtd]
  }

  measure: sum_will_call_return_to_stock_count_ty_qtr {
    label: "Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were returned to stock after arriving in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_qtr]
  }

  measure: sum_will_call_return_to_stock_count_ly_qtr {
    label: "LY Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were returned to stock after arriving in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_qtr]
  }

  measure: sum_will_call_return_to_stock_count_ty_ytd {
    label: "Return To Stock Count - YTD"
    description: "Count of transactions which were returned to stock after arriving in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_ytd]
  }

  measure: sum_will_call_return_to_stock_count_ly_ytd {
    label: "LY Return To Stock Count - YTD"
    description: "Count of transactions which were returned to stock after arriving in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_ytd]
  }

  measure: sum_will_call_return_to_stock_count_ty_yr {
    label: "Return To Stock Count - Complete Year"
    description: "Count of transactions which were returned to stock after arriving in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_yr]
  }

  measure: sum_will_call_return_to_stock_count_ly_yr {
    label: "LY Return To Stock Count - Complete Year"
    description: "Count of transactions which were returned to stock after arriving in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_yr]
  }

  measure: sum_will_call_return_to_stock_count_ty_ttm {
    label: "Return To Stock Count - TTM"
    description: "Count of transactions which were returned to stock after arriving in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_ttm]
  }

  measure: sum_will_call_return_to_stock_count_ly_ttm {
    label: "LY Return To Stock Count - TTM"
    description: "Count of transactions which were returned to stock after arriving in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_ttm]
  }

  measure: sum_will_call_return_to_stock_count_ty_rolling_13_week {
    label: "Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were returned to stock after arriving in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ty_rolling_13_week]
  }

  measure: sum_will_call_return_to_stock_count_ly_rolling_13_week {
    label: "LY Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were returned to stock after arriving in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_count_ly_rolling_13_week]
  }

  measure: sum_cost_of_goods_sold_amount_ty {
    label: "Cost of Goods Sold Amount"
    description: "Sum of the acquisition cost from transactions included in the script count for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty]
  }

  measure: sum_cost_of_goods_sold_amount_ly {
    label: "LY Cost of Goods Sold Amount"
    description: "Sum of the acquisition cost from transactions included in the script count for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly]
  }

  measure: sum_cost_of_goods_sold_amount_ty_wtd {
    label: "Cost of Goods Sold Amount - WTD"
    description: "Sum of the acquisition cost from transactions included in the script count for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_wtd]
  }

  measure: sum_cost_of_goods_sold_amount_ly_wtd {
    label: "LY Cost of Goods Sold Amount - WTD"
    description: "Sum of the acquisition cost from transactions included in the script count for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_wtd]
  }

  measure: sum_cost_of_goods_sold_amount_ty_wk {
    label: "Cost of Goods Sold Amount - Complete Week"
    description: "Sum of the acquisition cost from transactions included in the script count for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_wk]
  }

  measure: sum_cost_of_goods_sold_amount_ly_wk {
    label: "LY Cost of Goods Sold Amount - Complete Week"
    description: "Sum of the acquisition cost from transactions included in the script count for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_wk]
  }

  measure: sum_cost_of_goods_sold_amount_ty_ptd {
    label: "Cost of Goods Sold Amount - PTD"
    description: "Sum of the acquisition cost from transactions included in the script count for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_ptd]
  }

  measure: sum_cost_of_goods_sold_amount_ly_ptd {
    label: "LY Cost of Goods Sold Amount - PTD"
    description: "Sum of the acquisition cost from transactions included in the script count for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_ptd]
  }

  measure: sum_cost_of_goods_sold_amount_ty_pd {
    label: "Cost of Goods Sold Amount - Complete Period"
    description: "Sum of the acquisition cost from transactions included in the script count for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_pd]
  }

  measure: sum_cost_of_goods_sold_amount_ly_pd {
    label: "LY Cost of Goods Sold Amount - Complete Period"
    description: "Sum of the acquisition cost from transactions included in the script count for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_pd]
  }

  measure: sum_cost_of_goods_sold_amount_ty_qtd {
    label: "Cost of Goods Sold Amount - QTD"
    description: "Sum of the acquisition cost from transactions included in the script count for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_qtd]
  }

  measure: sum_cost_of_goods_sold_amount_ly_qtd {
    label: "LY Cost of Goods Sold Amount - QTD"
    description: "Sum of the acquisition cost from transactions included in the script count for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_qtd]
  }

  measure: sum_cost_of_goods_sold_amount_ty_qtr {
    label: "Cost of Goods Sold Amount - Complete Quarter"
    description: "Sum of the acquisition cost from transactions included in the script count for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_qtr]
  }

  measure: sum_cost_of_goods_sold_amount_ly_qtr {
    label: "LY Cost of Goods Sold Amount - Complete Quarter"
    description: "Sum of the acquisition cost from transactions included in the script count for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_qtr]
  }

  measure: sum_cost_of_goods_sold_amount_ty_ytd {
    label: "Cost of Goods Sold Amount - YTD"
    description: "Sum of the acquisition cost from transactions included in the script count for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_ytd]
  }

  measure: sum_cost_of_goods_sold_amount_ly_ytd {
    label: "LY Cost of Goods Sold Amount - YTD"
    description: "Sum of the acquisition cost from transactions included in the script count for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_ytd]
  }

  measure: sum_cost_of_goods_sold_amount_ty_yr {
    label: "Cost of Goods Sold Amount - Complete Year"
    description: "Sum of the acquisition cost from transactions included in the script count for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_yr]
  }

  measure: sum_cost_of_goods_sold_amount_ly_yr {
    label: "LY Cost of Goods Sold Amount - Complete Year"
    description: "Sum of the acquisition cost from transactions included in the script count for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_yr]
  }

  measure: sum_cost_of_goods_sold_amount_ty_ttm {
    label: "Cost of Goods Sold Amount - TTM"
    description: "Sum of the acquisition cost from transactions included in the script count for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_ttm]
  }

  measure: sum_cost_of_goods_sold_amount_ly_ttm {
    label: "LY Cost of Goods Sold Amount - TTM"
    description: "Sum of the acquisition cost from transactions included in the script count for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_ttm]
  }

  measure: sum_cost_of_goods_sold_amount_ty_rolling_13_week {
    label: "Cost of Goods Sold Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from transactions included in the script count for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ty_rolling_13_week]
  }

  measure: sum_cost_of_goods_sold_amount_ly_rolling_13_week {
    label: "LY Cost of Goods Sold Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from transactions included in the script count for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cost_of_goods_sold_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_sold_amount_ly_rolling_13_week]
  }

  measure: sum_cost_of_goods_purchase_amount_ty {
    label: "Cost of Goods Purchase Amount"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty]
  }

  measure: sum_cost_of_goods_purchase_amount_ly {
    label: "LY Cost of Goods Purchase Amount"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_wtd {
    label: "Cost of Goods Purchase Amount - WTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_wtd]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_wtd {
    label: "LY Cost of Goods Purchase Amount - WTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_wtd]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_wk {
    label: "Cost of Goods Purchase Amount - Complete Week"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_wk]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_wk {
    label: "LY Cost of Goods Purchase Amount - Complete Week"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_wk]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_ptd {
    label: "Cost of Goods Purchase Amount - PTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_ptd]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_ptd {
    label: "LY Cost of Goods Purchase Amount - PTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_ptd]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_pd {
    label: "Cost of Goods Purchase Amount - Complete Period"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_pd]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_pd {
    label: "LY Cost of Goods Purchase Amount - Complete Period"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_pd]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_qtd {
    label: "Cost of Goods Purchase Amount - QTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_qtd]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_qtd {
    label: "LY Cost of Goods Purchase Amount - QTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_qtd]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_qtr {
    label: "Cost of Goods Purchase Amount - Complete Quarter"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_qtr]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_qtr {
    label: "LY Cost of Goods Purchase Amount - Complete Quarter"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_qtr]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_ytd {
    label: "Cost of Goods Purchase Amount - YTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_ytd]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_ytd {
    label: "LY Cost of Goods Purchase Amount - YTD"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_ytd]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_yr {
    label: "Cost of Goods Purchase Amount - Complete Year"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_yr]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_yr {
    label: "LY Cost of Goods Purchase Amount - Complete Year"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_yr]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_ttm {
    label: "Cost of Goods Purchase Amount - TTM"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_ttm]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_ttm {
    label: "LY Cost of Goods Purchase Amount - TTM"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_ttm]
  }

  measure: sum_cost_of_goods_purchase_amount_ty_rolling_13_week {
    label: "Cost of Goods Purchase Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ty_rolling_13_week]
  }

  measure: sum_cost_of_goods_purchase_amount_ly_rolling_13_week {
    label: "LY Cost of Goods Purchase Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from drug orders with an applied date which meets the financial date criteria for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cost_of_goods_purchase_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_cost_of_goods_purchase_amount_ly_rolling_13_week]
  }

  measure: sum_return_and_adjustment_amount_ty {
    label: "Return And Adjustment Amount"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly {
    label: "LY Return And Adjustment Amount"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_wtd {
    label: "Return And Adjustment Amount - WTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_wtd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_wtd {
    label: "LY Return And Adjustment Amount - WTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_wtd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_wk {
    label: "Return And Adjustment Amount - Complete Week"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_wk]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_wk {
    label: "LY Return And Adjustment Amount - Complete Week"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_wk]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_ptd {
    label: "Return And Adjustment Amount - PTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_ptd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_ptd {
    label: "LY Return And Adjustment Amount - PTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_ptd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_pd {
    label: "Return And Adjustment Amount - Complete Period"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_pd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_pd {
    label: "LY Return And Adjustment Amount - Complete Period"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_pd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_qtd {
    label: "Return And Adjustment Amount - QTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_qtd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_qtd {
    label: "LY Return And Adjustment Amount - QTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_qtd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_qtr {
    label: "Return And Adjustment Amount - Complete Quarter"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_qtr]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_qtr {
    label: "LY Return And Adjustment Amount - Complete Quarter"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_qtr]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_ytd {
    label: "Return And Adjustment Amount - YTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_ytd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_ytd {
    label: "LY Return And Adjustment Amount - YTD"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_ytd]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_yr {
    label: "Return And Adjustment Amount - Complete Year"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_yr]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_yr {
    label: "LY Return And Adjustment Amount - Complete Year"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_yr]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_ttm {
    label: "Return And Adjustment Amount - TTM"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_ttm]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_ttm {
    label: "LY Return And Adjustment Amount - TTM"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_ttm]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ty_rolling_13_week {
    label: "Return And Adjustment Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ty_rolling_13_week]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

  measure: sum_return_and_adjustment_amount_ly_rolling_13_week {
    label: "LY Return And Adjustment Amount - Rolling 13 Week"
    description: "Sum of the acquisition cost from return and adjustment records which meet the financial date criteria for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_return_and_adjustment_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_return_and_adjustment_amount_ly_rolling_13_week]
    html: {% if value < 0 %}
          <font color="red">{{ rendered_value }}
          {% else %}
          <font color="grey">{{ rendered_value }}
          {% endif %}
          ;;
  }

#TRX-3593 Begin
  measure: sum_inventory_month_amount_ty {
    label: "Inventory Month Amount"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' and ${report_calendar_global.last_day_of_month} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_inventory_month_amount_ly {
    label: "LY Inventory Month Amount"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' and ${report_calendar_global.last_day_of_month} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_inventory_quarter_amount_ty {
    label: "Inventory Quarter Amount"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' and ${report_calendar_global.last_day_of_quarter} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_inventory_quarter_amount_ly {
    label: "LY Inventory Quarter Amount"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' and ${report_calendar_global.last_day_of_quarter} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_inventory_amount_ty_ttm {
    label: "Inventory Amount - TTM"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for trailing twelve months, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' and ${report_calendar_global.last_day_of_month} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_inventory_amount_ty_ttm]
  }

  measure: sum_inventory_amount_ly_ttm {
    label: "LY Inventory Amount - TTM"
    description: "Sum of the current acquisition cost for all NDC's with a positive on-hand amount for trailing twelve months, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' and  ${report_calendar_global.last_day_of_month} = 'Y' THEN ${store_kpi_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_inventory_amount_ly_ttm]
  }
#TRX-3593 End

#store_kpi_goal_inventory_amount related measures is currently not in use. Will need to change/update when this is worked on.
  measure: sum_goal_inventory_amount_ty {
    label: "Goal Inventory Amount"
    description: "Inventory dollar goal as established by the chain for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty]
  }

  measure: sum_goal_inventory_amount_ly {
    label: "LY Goal Inventory Amount"
    description: "Inventory dollar goal as established by the chain for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly]
  }

  measure: sum_goal_inventory_amount_ty_wtd {
    label: "Goal Inventory Amount - WTD"
    description: "Inventory dollar goal as established by the chain for week to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_wtd]
  }

  measure: sum_goal_inventory_amount_ly_wtd {
    label: "LY Goal Inventory Amount - WTD"
    description: "Inventory dollar goal as established by the chain for week to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_wtd]
  }

  measure: sum_goal_inventory_amount_ty_wk {
    label: "Goal Inventory Amount - Complete Week"
    description: "Inventory dollar goal as established by the chain for complete week, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_wk]
  }

  measure: sum_goal_inventory_amount_ly_wk {
    label: "LY Goal Inventory Amount - Complete Week"
    description: "Inventory dollar goal as established by the chain for complete week, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_wk]
  }

  measure: sum_goal_inventory_amount_ty_ptd {
    label: "Goal Inventory Amount - PTD"
    description: "Inventory dollar goal as established by the chain for period to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_ptd]
  }

  measure: sum_goal_inventory_amount_ly_ptd {
    label: "LY Goal Inventory Amount - PTD"
    description: "Inventory dollar goal as established by the chain for period to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_ptd]
  }

  measure: sum_goal_inventory_amount_ty_pd {
    label: "Goal Inventory Amount - Complete Period"
    description: "Inventory dollar goal as established by the chain for complete period, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_pd]
  }

  measure: sum_goal_inventory_amount_ly_pd {
    label: "LY Goal Inventory Amount - Complete Period"
    description: "Inventory dollar goal as established by the chain for complete period, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_pd]
  }

  measure: sum_goal_inventory_amount_ty_qtd {
    label: "Goal Inventory Amount - QTD"
    description: "Inventory dollar goal as established by the chain for quarter to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_qtd]
  }

  measure: sum_goal_inventory_amount_ly_qtd {
    label: "LY Goal Inventory Amount - QTD"
    description: "Inventory dollar goal as established by the chain for quarter to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_qtd]
  }

  measure: sum_goal_inventory_amount_ty_qtr {
    label: "Goal Inventory Amount - Complete Quarter"
    description: "Inventory dollar goal as established by the chain for complete quarter, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_qtr]
  }

  measure: sum_goal_inventory_amount_ly_qtr {
    label: "LY Goal Inventory Amount - Complete Quarter"
    description: "Inventory dollar goal as established by the chain for complete quarter, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_qtr]
  }

  measure: sum_goal_inventory_amount_ty_ytd {
    label: "Goal Inventory Amount - YTD"
    description: "Inventory dollar goal as established by the chain for year to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_ytd]
  }

  measure: sum_goal_inventory_amount_ly_ytd {
    label: "LY Goal Inventory Amount - YTD"
    description: "Inventory dollar goal as established by the chain for year to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_ytd]
  }

  measure: sum_goal_inventory_amount_ty_yr {
    label: "Goal Inventory Amount - Complete Year"
    description: "Inventory dollar goal as established by the chain for complete year, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_yr]
  }

  measure: sum_goal_inventory_amount_ly_yr {
    label: "LY Goal Inventory Amount - Complete Year"
    description: "Inventory dollar goal as established by the chain for complete year, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_yr]
  }

  measure: sum_goal_inventory_amount_ty_ttm {
    label: "Goal Inventory Amount - TTM"
    description: "Inventory dollar goal as established by the chain for trailing twelve months, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_ttm]
  }

  measure: sum_goal_inventory_amount_ly_ttm {
    label: "LY Goal Inventory Amount - TTM"
    description: "Inventory dollar goal as established by the chain for trailing twelve months, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_ttm]
  }

  measure: sum_goal_inventory_amount_ty_rolling_13_week {
    label: "Goal Inventory Amount - Rolling 13 Week"
    description: "Inventory dollar goal as established by the chain for rolling 13 week, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ty_rolling_13_week]
  }

  measure: sum_goal_inventory_amount_ly_rolling_13_week {
    label: "LY Goal Inventory Amount - Rolling 13 Week"
    description: "Inventory dollar goal as established by the chain for rolling 13 week, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_goal_inventory_amount} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_inventory_amount_ly_rolling_13_week]
  }

#store_kpi_goal_turn_per_period related measures is currently not in use. Will need to change/update when this is worked on.
  measure: sum_goal_turn_per_period_ty {
    label: "Goal Turn Per Period"
    description: " for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty]
  }

  measure: sum_goal_turn_per_period_ly {
    label: "LY Goal Turn Per Period"
    description: " for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly]
  }

  measure: sum_goal_turn_per_period_ty_wtd {
    label: "Goal Turn Per Period - WTD"
    description: " for week to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_wtd]
  }

  measure: sum_goal_turn_per_period_ly_wtd {
    label: "LY Goal Turn Per Period - WTD"
    description: " for week to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_wtd]
  }

  measure: sum_goal_turn_per_period_ty_wk {
    label: "Goal Turn Per Period - Complete Week"
    description: " for complete week, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_wk]
  }

  measure: sum_goal_turn_per_period_ly_wk {
    label: "LY Goal Turn Per Period - Complete Week"
    description: " for complete week, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_wk]
  }

  measure: sum_goal_turn_per_period_ty_ptd {
    label: "Goal Turn Per Period - PTD"
    description: " for period to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_ptd]
  }

  measure: sum_goal_turn_per_period_ly_ptd {
    label: "LY Goal Turn Per Period - PTD"
    description: " for period to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_ptd]
  }

  measure: sum_goal_turn_per_period_ty_pd {
    label: "Goal Turn Per Period - Complete Period"
    description: " for complete period, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_pd]
  }

  measure: sum_goal_turn_per_period_ly_pd {
    label: "LY Goal Turn Per Period - Complete Period"
    description: " for complete period, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_pd]
  }

  measure: sum_goal_turn_per_period_ty_qtd {
    label: "Goal Turn Per Period - QTD"
    description: " for quarter to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_qtd]
  }

  measure: sum_goal_turn_per_period_ly_qtd {
    label: "LY Goal Turn Per Period - QTD"
    description: " for quarter to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_qtd]
  }

  measure: sum_goal_turn_per_period_ty_qtr {
    label: "Goal Turn Per Period - Complete Quarter"
    description: " for complete quarter, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_qtr]
  }

  measure: sum_goal_turn_per_period_ly_qtr {
    label: "LY Goal Turn Per Period - Complete Quarter"
    description: " for complete quarter, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_qtr]
  }

  measure: sum_goal_turn_per_period_ty_ytd {
    label: "Goal Turn Per Period - YTD"
    description: " for year to date, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_ytd]
  }

  measure: sum_goal_turn_per_period_ly_ytd {
    label: "LY Goal Turn Per Period - YTD"
    description: " for year to date, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_ytd]
  }

  measure: sum_goal_turn_per_period_ty_yr {
    label: "Goal Turn Per Period - Complete Year"
    description: " for complete year, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_yr]
  }

  measure: sum_goal_turn_per_period_ly_yr {
    label: "LY Goal Turn Per Period - Complete Year"
    description: " for complete year, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_yr]
  }

  measure: sum_goal_turn_per_period_ty_ttm {
    label: "Goal Turn Per Period - TTM"
    description: " for trailing twelve months, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_ttm]
  }

  measure: sum_goal_turn_per_period_ly_ttm {
    label: "LY Goal Turn Per Period - TTM"
    description: " for trailing twelve months, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_ttm]
  }

  measure: sum_goal_turn_per_period_ty_rolling_13_week {
    label: "Goal Turn Per Period - Rolling 13 Week"
    description: " for rolling 13 week, for this year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ty_rolling_13_week]
  }

  measure: sum_goal_turn_per_period_ly_rolling_13_week {
    label: "LY Goal Turn Per Period - Rolling 13 Week"
    description: " for rolling 13 week, for last year"
    type: sum
    hidden: yes
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_goal_turn_per_period} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_goal_turn_per_period_ly_rolling_13_week]
  }

  measure: sum_autofill_count_ty {
    label: "Autofill Count"
    description: "Count of transactions which were filled from autofill (refill source = 2) for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty]
  }

  measure: sum_autofill_count_ly {
    label: "LY Autofill Count"
    description: "Count of transactions which were filled from autofill (refill source = 2) for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly]
  }

  measure: sum_autofill_count_ty_wtd {
    label: "Autofill Count - WTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_wtd]
  }

  measure: sum_autofill_count_ly_wtd {
    label: "LY Autofill Count - WTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_wtd]
  }

  measure: sum_autofill_count_ty_wk {
    label: "Autofill Count - Complete Week"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_wk]
  }

  measure: sum_autofill_count_ly_wk {
    label: "LY Autofill Count - Complete Week"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_wk]
  }

  measure: sum_autofill_count_ty_ptd {
    label: "Autofill Count - PTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_ptd]
  }

  measure: sum_autofill_count_ly_ptd {
    label: "LY Autofill Count - PTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_ptd]
  }

  measure: sum_autofill_count_ty_pd {
    label: "Autofill Count - Complete Period"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_pd]
  }

  measure: sum_autofill_count_ly_pd {
    label: "LY Autofill Count - Complete Period"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_pd]
  }

  measure: sum_autofill_count_ty_qtd {
    label: "Autofill Count - QTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_qtd]
  }

  measure: sum_autofill_count_ly_qtd {
    label: "LY Autofill Count - QTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_qtd]
  }

  measure: sum_autofill_count_ty_qtr {
    label: "Autofill Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_qtr]
  }

  measure: sum_autofill_count_ly_qtr {
    label: "LY Autofill Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_qtr]
  }

  measure: sum_autofill_count_ty_ytd {
    label: "Autofill Count - YTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_ytd]
  }

  measure: sum_autofill_count_ly_ytd {
    label: "LY Autofill Count - YTD"
    description: "Count of transactions which were filled from autofill (refill source = 2) for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_ytd]
  }

  measure: sum_autofill_count_ty_yr {
    label: "Autofill Count - Complete Year"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_yr]
  }

  measure: sum_autofill_count_ly_yr {
    label: "LY Autofill Count - Complete Year"
    description: "Count of transactions which were filled from autofill (refill source = 2) for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_yr]
  }

  measure: sum_autofill_count_ty_ttm {
    label: "Autofill Count - TTM"
    description: "Count of transactions which were filled from autofill (refill source = 2) for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_ttm]
  }

  measure: sum_autofill_count_ly_ttm {
    label: "LY Autofill Count - TTM"
    description: "Count of transactions which were filled from autofill (refill source = 2) for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_ttm]
  }

  measure: sum_autofill_count_ty_rolling_13_week {
    label: "Autofill Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill (refill source = 2) for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ty_rolling_13_week]
  }

  measure: sum_autofill_count_ly_rolling_13_week {
    label: "LY Autofill Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill (refill source = 2) for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_autofill_count_ly_rolling_13_week]
  }

  measure: sum_non_autofill_count_ty {
    label: "Non Autofill Count"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty]
  }

  measure: sum_non_autofill_count_ly {
    label: "LY Non Autofill Count"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly]
  }

  measure: sum_non_autofill_count_ty_wtd {
    label: "Non Autofill Count - WTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_wtd]
  }

  measure: sum_non_autofill_count_ly_wtd {
    label: "LY Non Autofill Count - WTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_wtd]
  }

  measure: sum_non_autofill_count_ty_wk {
    label: "Non Autofill Count - Complete Week"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_wk]
  }

  measure: sum_non_autofill_count_ly_wk {
    label: "LY Non Autofill Count - Complete Week"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_wk]
  }

  measure: sum_non_autofill_count_ty_ptd {
    label: "Non Autofill Count - PTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_ptd]
  }

  measure: sum_non_autofill_count_ly_ptd {
    label: "LY Non Autofill Count - PTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_ptd]
  }

  measure: sum_non_autofill_count_ty_pd {
    label: "Non Autofill Count - Complete Period"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_pd]
  }

  measure: sum_non_autofill_count_ly_pd {
    label: "LY Non Autofill Count - Complete Period"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_pd]
  }

  measure: sum_non_autofill_count_ty_qtd {
    label: "Non Autofill Count - QTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_qtd]
  }

  measure: sum_non_autofill_count_ly_qtd {
    label: "LY Non Autofill Count - QTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_qtd]
  }

  measure: sum_non_autofill_count_ty_qtr {
    label: "Non Autofill Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_qtr]
  }

  measure: sum_non_autofill_count_ly_qtr {
    label: "LY Non Autofill Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_qtr]
  }

  measure: sum_non_autofill_count_ty_ytd {
    label: "Non Autofill Count - YTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_ytd]
  }

  measure: sum_non_autofill_count_ly_ytd {
    label: "LY Non Autofill Count - YTD"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_ytd]
  }

  measure: sum_non_autofill_count_ty_yr {
    label: "Non Autofill Count - Complete Year"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_yr]
  }

  measure: sum_non_autofill_count_ly_yr {
    label: "LY Non Autofill Count - Complete Year"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_yr]
  }

  measure: sum_non_autofill_count_ty_ttm {
    label: "Non Autofill Count - TTM"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_ttm]
  }

  measure: sum_non_autofill_count_ly_ttm {
    label: "LY Non Autofill Count - TTM"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_ttm]
  }

  measure: sum_non_autofill_count_ty_rolling_13_week {
    label: "Non Autofill Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ty_rolling_13_week]
  }

  measure: sum_non_autofill_count_ly_rolling_13_week {
    label: "LY Non Autofill Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill (refill source !=2) for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_non_autofill_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_non_autofill_count_ly_rolling_13_week]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty {
    label: "Autofill Return To Stock Count"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly {
    label: "LY Autofill Return To Stock Count"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_wtd {
    label: "Autofill Return To Stock Count - WTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_wtd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_wtd {
    label: "LY Autofill Return To Stock Count - WTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_wtd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_wk {
    label: "Autofill Return To Stock Count - Complete Week"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_wk]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_wk {
    label: "LY Autofill Return To Stock Count - Complete Week"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_wk]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_ptd {
    label: "Autofill Return To Stock Count - PTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_ptd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_ptd {
    label: "LY Autofill Return To Stock Count - PTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_ptd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_pd {
    label: "Autofill Return To Stock Count - Complete Period"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_pd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_pd {
    label: "LY Autofill Return To Stock Count - Complete Period"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_pd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_qtd {
    label: "Autofill Return To Stock Count - QTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_qtd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_qtd {
    label: "LY Autofill Return To Stock Count - QTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_qtd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_qtr {
    label: "Autofill Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_qtr]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_qtr {
    label: "LY Autofill Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_qtr]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_ytd {
    label: "Autofill Return To Stock Count - YTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_ytd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_ytd {
    label: "LY Autofill Return To Stock Count - YTD"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_ytd]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_yr {
    label: "Autofill Return To Stock Count - Complete Year"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_yr]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_yr {
    label: "LY Autofill Return To Stock Count - Complete Year"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_yr]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_ttm {
    label: "Autofill Return To Stock Count - TTM"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_ttm]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_ttm {
    label: "LY Autofill Return To Stock Count - TTM"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_ttm]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ty_rolling_13_week {
    label: "Autofill Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ty_rolling_13_week]
  }

  measure: sum_will_call_autofill_return_to_stock_count_ly_rolling_13_week {
    label: "LY Autofill Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill and were returned to stock after arriving in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_return_to_stock_count_ly_rolling_13_week]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty {
    label: "Non Autofill Return To Stock Count"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly {
    label: "LY Non Autofill Return To Stock Count"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_wtd {
    label: "Non Autofill Return To Stock Count - WTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_wtd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_wtd {
    label: "LY Non Autofill Return To Stock Count - WTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_wtd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_wk {
    label: "Non Autofill Return To Stock Count - Complete Week"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_wk]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_wk {
    label: "LY Non Autofill Return To Stock Count - Complete Week"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_wk]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_ptd {
    label: "Non Autofill Return To Stock Count - PTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_ptd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_ptd {
    label: "LY Non Autofill Return To Stock Count - PTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_ptd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_pd {
    label: "Non Autofill Return To Stock Count - Complete Period"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_pd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_pd {
    label: "LY Non Autofill Return To Stock Count - Complete Period"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_pd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_qtd {
    label: "Non Autofill Return To Stock Count - QTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_qtd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_qtd {
    label: "LY Non Autofill Return To Stock Count - QTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_qtd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_qtr {
    label: "Non Autofill Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_qtr]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_qtr {
    label: "LY Non Autofill Return To Stock Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_qtr]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_ytd {
    label: "Non Autofill Return To Stock Count - YTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_ytd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_ytd {
    label: "LY Non Autofill Return To Stock Count - YTD"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_ytd]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_yr {
    label: "Non Autofill Return To Stock Count - Complete Year"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_yr]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_yr {
    label: "LY Non Autofill Return To Stock Count - Complete Year"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_yr]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_ttm {
    label: "Non Autofill Return To Stock Count - TTM"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_ttm]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_ttm {
    label: "LY Non Autofill Return To Stock Count - TTM"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_ttm]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ty_rolling_13_week {
    label: "Non Autofill Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ty_rolling_13_week]
  }

  measure: sum_will_call_non_autofill_return_to_stock_count_ly_rolling_13_week {
    label: "LY Non Autofill Return To Stock Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill and were returned to stock after arriving in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_return_to_stock_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_return_to_stock_count_ly_rolling_13_week]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty {
    label: "Will Call Return To Stock Past Due Count"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly {
    label: "LY Will Call Return To Stock Past Due Count"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_wtd {
    label: "Will Call Return To Stock Past Due Count - WTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_wtd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_wtd {
    label: "LY Will Call Return To Stock Past Due Count - WTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_wtd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_wk {
    label: "Will Call Return To Stock Past Due Count - Complete Week"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_wk]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_wk {
    label: "LY Will Call Return To Stock Past Due Count - Complete Week"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_wk]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_ptd {
    label: "Will Call Return To Stock Past Due Count - PTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_ptd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_ptd {
    label: "LY Will Call Return To Stock Past Due Count - PTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_ptd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_pd {
    label: "Will Call Return To Stock Past Due Count - Complete Period"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_pd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_pd {
    label: "LY Will Call Return To Stock Past Due Count - Complete Period"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_pd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_qtd {
    label: "Will Call Return To Stock Past Due Count - QTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_qtd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_qtd {
    label: "LY Will Call Return To Stock Past Due Count - QTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_qtd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_qtr {
    label: "Will Call Return To Stock Past Due Count - Complete Quarter"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_qtr]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_qtr {
    label: "LY Will Call Return To Stock Past Due Count - Complete Quarter"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_qtr]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_ytd {
    label: "Will Call Return To Stock Past Due Count - YTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_ytd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_ytd {
    label: "LY Will Call Return To Stock Past Due Count - YTD"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_ytd]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_yr {
    label: "Will Call Return To Stock Past Due Count - Complete Year"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_yr]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_yr {
    label: "LY Will Call Return To Stock Past Due Count - Complete Year"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_yr]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_ttm {
    label: "Will Call Return To Stock Past Due Count - TTM"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_ttm]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_ttm {
    label: "LY Will Call Return To Stock Past Due Count - TTM"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_ttm]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ty_rolling_13_week {
    label: "Will Call Return To Stock Past Due Count - Rolling 13 Week"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ty_rolling_13_week]
  }

  measure: sum_will_call_return_to_stock_past_due_count_ly_rolling_13_week {
    label: "LY Will Call Return To Stock Past Due Count - Rolling 13 Week"
    description: "Count of transactions which were returned to stock after the chain specified return to stock date for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_return_to_stock_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_return_to_stock_past_due_count_ly_rolling_13_week]
  }

  measure: sum_will_call_past_due_count_ty {
    label: "Will Call Past Due Count"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty]
  }

  measure: sum_will_call_past_due_count_ly {
    label: "LY Will Call Past Due Count"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly]
  }

  measure: sum_will_call_past_due_count_ty_wtd {
    label: "Will Call Past Due Count - WTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_wtd]
  }

  measure: sum_will_call_past_due_count_ly_wtd {
    label: "LY Will Call Past Due Count - WTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_wtd]
  }

  measure: sum_will_call_past_due_count_ty_wk {
    label: "Will Call Past Due Count - Complete Week"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_wk]
  }

  measure: sum_will_call_past_due_count_ly_wk {
    label: "LY Will Call Past Due Count - Complete Week"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_wk]
  }

  measure: sum_will_call_past_due_count_ty_ptd {
    label: "Will Call Past Due Count - PTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_ptd]
  }

  measure: sum_will_call_past_due_count_ly_ptd {
    label: "LY Will Call Past Due Count - PTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_ptd]
  }

  measure: sum_will_call_past_due_count_ty_pd {
    label: "Will Call Past Due Count - Complete Period"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_pd]
  }

  measure: sum_will_call_past_due_count_ly_pd {
    label: "LY Will Call Past Due Count - Complete Period"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_pd]
  }

  measure: sum_will_call_past_due_count_ty_qtd {
    label: "Will Call Past Due Count - QTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_qtd]
  }

  measure: sum_will_call_past_due_count_ly_qtd {
    label: "LY Will Call Past Due Count - QTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_qtd]
  }

  measure: sum_will_call_past_due_count_ty_qtr {
    label: "Will Call Past Due Count - Complete Quarter"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_qtr]
  }

  measure: sum_will_call_past_due_count_ly_qtr {
    label: "LY Will Call Past Due Count - Complete Quarter"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_qtr]
  }

  measure: sum_will_call_past_due_count_ty_ytd {
    label: "Will Call Past Due Count - YTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_ytd]
  }

  measure: sum_will_call_past_due_count_ly_ytd {
    label: "LY Will Call Past Due Count - YTD"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_ytd]
  }

  measure: sum_will_call_past_due_count_ty_yr {
    label: "Will Call Past Due Count - Complete Year"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_yr]
  }

  measure: sum_will_call_past_due_count_ly_yr {
    label: "LY Will Call Past Due Count - Complete Year"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_yr]
  }

  measure: sum_will_call_past_due_count_ty_ttm {
    label: "Will Call Past Due Count - TTM"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_ttm]
  }

  measure: sum_will_call_past_due_count_ly_ttm {
    label: "LY Will Call Past Due Count - TTM"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_ttm]
  }

  measure: sum_will_call_past_due_count_ty_rolling_13_week {
    label: "Will Call Past Due Count - Rolling 13 Week"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ty_rolling_13_week]
  }

  measure: sum_will_call_past_due_count_ly_rolling_13_week {
    label: "LY Will Call Past Due Count - Rolling 13 Week"
    description: "Count of transactions which are past due to be returned to stock based on the chain specified return to stock date for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_past_due_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_past_due_count_ly_rolling_13_week]
  }

  measure: sum_cycle_count_task_received_count_ty {
    label: "Cycle Count Received Count"
    description: "Count of cycle count tasks received by the stores for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty]
  }

  measure: sum_cycle_count_task_received_count_ly {
    label: "LY Cycle Count Received Count"
    description: "Count of cycle count tasks received by the stores for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly]
  }

  measure: sum_cycle_count_task_received_count_ty_wtd {
    label: "Cycle Count Received Count - WTD"
    description: "Count of cycle count tasks received by the stores for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_wtd]
  }

  measure: sum_cycle_count_task_received_count_ly_wtd {
    label: "LY Cycle Count Received Count - WTD"
    description: "Count of cycle count tasks received by the stores for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_wtd]
  }

  measure: sum_cycle_count_task_received_count_ty_wk {
    label: "Cycle Count Received Count - Complete Week"
    description: "Count of cycle count tasks received by the stores for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_wk]
  }

  measure: sum_cycle_count_task_received_count_ly_wk {
    label: "LY Cycle Count Received Count - Complete Week"
    description: "Count of cycle count tasks received by the stores for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_wk]
  }

  measure: sum_cycle_count_task_received_count_ty_ptd {
    label: "Cycle Count Received Count - PTD"
    description: "Count of cycle count tasks received by the stores for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_ptd]
  }

  measure: sum_cycle_count_task_received_count_ly_ptd {
    label: "LY Cycle Count Received Count - PTD"
    description: "Count of cycle count tasks received by the stores for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_ptd]
  }

  measure: sum_cycle_count_task_received_count_ty_pd {
    label: "Cycle Count Received Count - Complete Period"
    description: "Count of cycle count tasks received by the stores for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_pd]
  }

  measure: sum_cycle_count_task_received_count_ly_pd {
    label: "LY Cycle Count Received Count - Complete Period"
    description: "Count of cycle count tasks received by the stores for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_pd]
  }

  measure: sum_cycle_count_task_received_count_ty_qtd {
    label: "Cycle Count Received Count - QTD"
    description: "Count of cycle count tasks received by the stores for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_qtd]
  }

  measure: sum_cycle_count_task_received_count_ly_qtd {
    label: "LY Cycle Count Received Count - QTD"
    description: "Count of cycle count tasks received by the stores for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_qtd]
  }

  measure: sum_cycle_count_task_received_count_ty_qtr {
    label: "Cycle Count Received Count - Complete Quarter"
    description: "Count of cycle count tasks received by the stores for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_qtr]
  }

  measure: sum_cycle_count_task_received_count_ly_qtr {
    label: "LY Cycle Count Received Count - Complete Quarter"
    description: "Count of cycle count tasks received by the stores for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_qtr]
  }

  measure: sum_cycle_count_task_received_count_ty_ytd {
    label: "Cycle Count Received Count - YTD"
    description: "Count of cycle count tasks received by the stores for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_ytd]
  }

  measure: sum_cycle_count_task_received_count_ly_ytd {
    label: "LY Cycle Count Received Count - YTD"
    description: "Count of cycle count tasks received by the stores for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_ytd]
  }

  measure: sum_cycle_count_task_received_count_ty_yr {
    label: "Cycle Count Received Count - Complete Year"
    description: "Count of cycle count tasks received by the stores for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_yr]
  }

  measure: sum_cycle_count_task_received_count_ly_yr {
    label: "LY Cycle Count Received Count - Complete Year"
    description: "Count of cycle count tasks received by the stores for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_yr]
  }

  measure: sum_cycle_count_task_received_count_ty_ttm {
    label: "Cycle Count Received Count - TTM"
    description: "Count of cycle count tasks received by the stores for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_ttm]
  }

  measure: sum_cycle_count_task_received_count_ly_ttm {
    label: "LY Cycle Count Received Count - TTM"
    description: "Count of cycle count tasks received by the stores for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_ttm]
  }

  measure: sum_cycle_count_task_received_count_ty_rolling_13_week {
    label: "Cycle Count Received Count - Rolling 13 Week"
    description: "Count of cycle count tasks received by the stores for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ty_rolling_13_week]
  }

  measure: sum_cycle_count_task_received_count_ly_rolling_13_week {
    label: "LY Cycle Count Received Count - Rolling 13 Week"
    description: "Count of cycle count tasks received by the stores for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_received_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_received_count_ly_rolling_13_week]
  }

  measure: sum_cycle_count_task_complete_count_ty {
    label: "Cycle Count Complete Count"
    description: "Count of cycle count tasks completed by the stores for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty]
  }

  measure: sum_cycle_count_task_complete_count_ly {
    label: "LY Cycle Count Complete Count"
    description: "Count of cycle count tasks completed by the stores for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly]
  }

  measure: sum_cycle_count_task_complete_count_ty_wtd {
    label: "Cycle Count Complete Count - WTD"
    description: "Count of cycle count tasks completed by the stores for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_wtd]
  }

  measure: sum_cycle_count_task_complete_count_ly_wtd {
    label: "LY Cycle Count Complete Count - WTD"
    description: "Count of cycle count tasks completed by the stores for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_wtd]
  }

  measure: sum_cycle_count_task_complete_count_ty_wk {
    label: "Cycle Count Complete Count - Complete Week"
    description: "Count of cycle count tasks completed by the stores for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_wk]
  }

  measure: sum_cycle_count_task_complete_count_ly_wk {
    label: "LY Cycle Count Complete Count - Complete Week"
    description: "Count of cycle count tasks completed by the stores for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_wk]
  }

  measure: sum_cycle_count_task_complete_count_ty_ptd {
    label: "Cycle Count Complete Count - PTD"
    description: "Count of cycle count tasks completed by the stores for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_ptd]
  }

  measure: sum_cycle_count_task_complete_count_ly_ptd {
    label: "LY Cycle Count Complete Count - PTD"
    description: "Count of cycle count tasks completed by the stores for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_ptd]
  }

  measure: sum_cycle_count_task_complete_count_ty_pd {
    label: "Cycle Count Complete Count - Complete Period"
    description: "Count of cycle count tasks completed by the stores for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_pd]
  }

  measure: sum_cycle_count_task_complete_count_ly_pd {
    label: "LY Cycle Count Complete Count - Complete Period"
    description: "Count of cycle count tasks completed by the stores for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_pd]
  }

  measure: sum_cycle_count_task_complete_count_ty_qtd {
    label: "Cycle Count Complete Count - QTD"
    description: "Count of cycle count tasks completed by the stores for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_qtd]
  }

  measure: sum_cycle_count_task_complete_count_ly_qtd {
    label: "LY Cycle Count Complete Count - QTD"
    description: "Count of cycle count tasks completed by the stores for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_qtd]
  }

  measure: sum_cycle_count_task_complete_count_ty_qtr {
    label: "Cycle Count Complete Count - Complete Quarter"
    description: "Count of cycle count tasks completed by the stores for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_qtr]
  }

  measure: sum_cycle_count_task_complete_count_ly_qtr {
    label: "LY Cycle Count Complete Count - Complete Quarter"
    description: "Count of cycle count tasks completed by the stores for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_qtr]
  }

  measure: sum_cycle_count_task_complete_count_ty_ytd {
    label: "Cycle Count Complete Count - YTD"
    description: "Count of cycle count tasks completed by the stores for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_ytd]
  }

  measure: sum_cycle_count_task_complete_count_ly_ytd {
    label: "LY Cycle Count Complete Count - YTD"
    description: "Count of cycle count tasks completed by the stores for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_ytd]
  }

  measure: sum_cycle_count_task_complete_count_ty_yr {
    label: "Cycle Count Complete Count - Complete Year"
    description: "Count of cycle count tasks completed by the stores for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_yr]
  }

  measure: sum_cycle_count_task_complete_count_ly_yr {
    label: "LY Cycle Count Complete Count - Complete Year"
    description: "Count of cycle count tasks completed by the stores for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_yr]
  }

  measure: sum_cycle_count_task_complete_count_ty_ttm {
    label: "Cycle Count Complete Count - TTM"
    description: "Count of cycle count tasks completed by the stores for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_ttm]
  }

  measure: sum_cycle_count_task_complete_count_ly_ttm {
    label: "LY Cycle Count Complete Count - TTM"
    description: "Count of cycle count tasks completed by the stores for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_ttm]
  }

  measure: sum_cycle_count_task_complete_count_ty_rolling_13_week {
    label: "Cycle Count Complete Count - Rolling 13 Week"
    description: "Count of cycle count tasks completed by the stores for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ty_rolling_13_week]
  }

  measure: sum_cycle_count_task_complete_count_ly_rolling_13_week {
    label: "LY Cycle Count Complete Count - Rolling 13 Week"
    description: "Count of cycle count tasks completed by the stores for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_complete_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_complete_count_ly_rolling_13_week]
  }

  measure: sum_cycle_count_task_accurate_count_ty {
    label: "Cycle Count Accurate Count"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty]
  }

  measure: sum_cycle_count_task_accurate_count_ly {
    label: "LY Cycle Count Accurate Count"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly]
  }

  measure: sum_cycle_count_task_accurate_count_ty_wtd {
    label: "Cycle Count Accurate Count - WTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_wtd]
  }

  measure: sum_cycle_count_task_accurate_count_ly_wtd {
    label: "LY Cycle Count Accurate Count - WTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_wtd]
  }

  measure: sum_cycle_count_task_accurate_count_ty_wk {
    label: "Cycle Count Accurate Count - Complete Week"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_wk]
  }

  measure: sum_cycle_count_task_accurate_count_ly_wk {
    label: "LY Cycle Count Accurate Count - Complete Week"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_wk]
  }

  measure: sum_cycle_count_task_accurate_count_ty_ptd {
    label: "Cycle Count Accurate Count - PTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_ptd]
  }

  measure: sum_cycle_count_task_accurate_count_ly_ptd {
    label: "LY Cycle Count Accurate Count - PTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_ptd]
  }

  measure: sum_cycle_count_task_accurate_count_ty_pd {
    label: "Cycle Count Accurate Count - Complete Period"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_pd]
  }

  measure: sum_cycle_count_task_accurate_count_ly_pd {
    label: "LY Cycle Count Accurate Count - Complete Period"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_pd]
  }

  measure: sum_cycle_count_task_accurate_count_ty_qtd {
    label: "Cycle Count Accurate Count - QTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_qtd]
  }

  measure: sum_cycle_count_task_accurate_count_ly_qtd {
    label: "LY Cycle Count Accurate Count - QTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_qtd]
  }

  measure: sum_cycle_count_task_accurate_count_ty_qtr {
    label: "Cycle Count Accurate Count - Complete Quarter"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_qtr]
  }

  measure: sum_cycle_count_task_accurate_count_ly_qtr {
    label: "LY Cycle Count Accurate Count - Complete Quarter"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_qtr]
  }

  measure: sum_cycle_count_task_accurate_count_ty_ytd {
    label: "Cycle Count Accurate Count - YTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_ytd]
  }

  measure: sum_cycle_count_task_accurate_count_ly_ytd {
    label: "LY Cycle Count Accurate Count - YTD"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_ytd]
  }

  measure: sum_cycle_count_task_accurate_count_ty_yr {
    label: "Cycle Count Accurate Count - Complete Year"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_yr]
  }

  measure: sum_cycle_count_task_accurate_count_ly_yr {
    label: "LY Cycle Count Accurate Count - Complete Year"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_yr]
  }

  measure: sum_cycle_count_task_accurate_count_ty_ttm {
    label: "Cycle Count Accurate Count - TTM"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_ttm]
  }

  measure: sum_cycle_count_task_accurate_count_ly_ttm {
    label: "LY Cycle Count Accurate Count - TTM"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_ttm]
  }

  measure: sum_cycle_count_task_accurate_count_ty_rolling_13_week {
    label: "Cycle Count Accurate Count - Rolling 13 Week"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ty_rolling_13_week]
  }

  measure: sum_cycle_count_task_accurate_count_ly_rolling_13_week {
    label: "LY Cycle Count Accurate Count - Rolling 13 Week"
    description: "Count of cycle count tasks completed by the stores and the store on-hand value was accurate for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_accurate_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_accurate_count_ly_rolling_13_week]
  }

  measure: sum_cycle_count_task_expire_count_ty {
    label: "Cycle Count Expire Count"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty]
  }

  measure: sum_cycle_count_task_expire_count_ly {
    label: "LY Cycle Count Expire Count"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly]
  }

  measure: sum_cycle_count_task_expire_count_ty_wtd {
    label: "Cycle Count Expire Count - WTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_wtd]
  }

  measure: sum_cycle_count_task_expire_count_ly_wtd {
    label: "LY Cycle Count Expire Count - WTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_wtd]
  }

  measure: sum_cycle_count_task_expire_count_ty_wk {
    label: "Cycle Count Expire Count - Complete Week"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_wk]
  }

  measure: sum_cycle_count_task_expire_count_ly_wk {
    label: "LY Cycle Count Expire Count - Complete Week"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_wk]
  }

  measure: sum_cycle_count_task_expire_count_ty_ptd {
    label: "Cycle Count Expire Count - PTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_ptd]
  }

  measure: sum_cycle_count_task_expire_count_ly_ptd {
    label: "LY Cycle Count Expire Count - PTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_ptd]
  }

  measure: sum_cycle_count_task_expire_count_ty_pd {
    label: "Cycle Count Expire Count - Complete Period"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_pd]
  }

  measure: sum_cycle_count_task_expire_count_ly_pd {
    label: "LY Cycle Count Expire Count - Complete Period"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_pd]
  }

  measure: sum_cycle_count_task_expire_count_ty_qtd {
    label: "Cycle Count Expire Count - QTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_qtd]
  }

  measure: sum_cycle_count_task_expire_count_ly_qtd {
    label: "LY Cycle Count Expire Count - QTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_qtd]
  }

  measure: sum_cycle_count_task_expire_count_ty_qtr {
    label: "Cycle Count Expire Count - Complete Quarter"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_qtr]
  }

  measure: sum_cycle_count_task_expire_count_ly_qtr {
    label: "LY Cycle Count Expire Count - Complete Quarter"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_qtr]
  }

  measure: sum_cycle_count_task_expire_count_ty_ytd {
    label: "Cycle Count Expire Count - YTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_ytd]
  }

  measure: sum_cycle_count_task_expire_count_ly_ytd {
    label: "LY Cycle Count Expire Count - YTD"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_ytd]
  }

  measure: sum_cycle_count_task_expire_count_ty_yr {
    label: "Cycle Count Expire Count - Complete Year"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_yr]
  }

  measure: sum_cycle_count_task_expire_count_ly_yr {
    label: "LY Cycle Count Expire Count - Complete Year"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_yr]
  }

  measure: sum_cycle_count_task_expire_count_ty_ttm {
    label: "Cycle Count Expire Count - TTM"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_ttm]
  }

  measure: sum_cycle_count_task_expire_count_ly_ttm {
    label: "LY Cycle Count Expire Count - TTM"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_ttm]
  }

  measure: sum_cycle_count_task_expire_count_ty_rolling_13_week {
    label: "Cycle Count Expire Count - Rolling 13 Week"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ty_rolling_13_week]
  }

  measure: sum_cycle_count_task_expire_count_ly_rolling_13_week {
    label: "LY Cycle Count Expire Count - Rolling 13 Week"
    description: "Count of cycle count tasks received by the stores which expired prior to being completed for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_cycle_count_task_expire_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_cycle_count_task_expire_count_ly_rolling_13_week]
  }

  measure: sum_will_call_arrival_count_ty {
    label: "Will Call Arrival Count"
    description: "Count of transactions in the script count which arrived in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty]
  }

  measure: sum_will_call_arrival_count_ly {
    label: "LY Will Call Arrival Count"
    description: "Count of transactions in the script count which arrived in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly]
  }

  measure: sum_will_call_arrival_count_ty_wtd {
    label: "Will Call Arrival Count - WTD"
    description: "Count of transactions in the script count which arrived in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_wtd]
  }

  measure: sum_will_call_arrival_count_ly_wtd {
    label: "LY Will Call Arrival Count - WTD"
    description: "Count of transactions in the script count which arrived in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_wtd]
  }

  measure: sum_will_call_arrival_count_ty_wk {
    label: "Will Call Arrival Count - Complete Week"
    description: "Count of transactions in the script count which arrived in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_wk]
  }

  measure: sum_will_call_arrival_count_ly_wk {
    label: "LY Will Call Arrival Count - Complete Week"
    description: "Count of transactions in the script count which arrived in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_wk]
  }

  measure: sum_will_call_arrival_count_ty_ptd {
    label: "Will Call Arrival Count - PTD"
    description: "Count of transactions in the script count which arrived in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_ptd]
  }

  measure: sum_will_call_arrival_count_ly_ptd {
    label: "LY Will Call Arrival Count - PTD"
    description: "Count of transactions in the script count which arrived in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_ptd]
  }

  measure: sum_will_call_arrival_count_ty_pd {
    label: "Will Call Arrival Count - Complete Period"
    description: "Count of transactions in the script count which arrived in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_pd]
  }

  measure: sum_will_call_arrival_count_ly_pd {
    label: "LY Will Call Arrival Count - Complete Period"
    description: "Count of transactions in the script count which arrived in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_pd]
  }

  measure: sum_will_call_arrival_count_ty_qtd {
    label: "Will Call Arrival Count - QTD"
    description: "Count of transactions in the script count which arrived in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_qtd]
  }

  measure: sum_will_call_arrival_count_ly_qtd {
    label: "LY Will Call Arrival Count - QTD"
    description: "Count of transactions in the script count which arrived in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_qtd]
  }

  measure: sum_will_call_arrival_count_ty_qtr {
    label: "Will Call Arrival Count - Complete Quarter"
    description: "Count of transactions in the script count which arrived in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_qtr]
  }

  measure: sum_will_call_arrival_count_ly_qtr {
    label: "LY Will Call Arrival Count - Complete Quarter"
    description: "Count of transactions in the script count which arrived in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_qtr]
  }

  measure: sum_will_call_arrival_count_ty_ytd {
    label: "Will Call Arrival Count - YTD"
    description: "Count of transactions in the script count which arrived in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_ytd]
  }

  measure: sum_will_call_arrival_count_ly_ytd {
    label: "LY Will Call Arrival Count - YTD"
    description: "Count of transactions in the script count which arrived in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_ytd]
  }

  measure: sum_will_call_arrival_count_ty_yr {
    label: "Will Call Arrival Count - Complete Year"
    description: "Count of transactions in the script count which arrived in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_yr]
  }

  measure: sum_will_call_arrival_count_ly_yr {
    label: "LY Will Call Arrival Count - Complete Year"
    description: "Count of transactions in the script count which arrived in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_yr]
  }

  measure: sum_will_call_arrival_count_ty_ttm {
    label: "Will Call Arrival Count - TTM"
    description: "Count of transactions in the script count which arrived in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_ttm]
  }

  measure: sum_will_call_arrival_count_ly_ttm {
    label: "LY Will Call Arrival Count - TTM"
    description: "Count of transactions in the script count which arrived in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_ttm]
  }

  measure: sum_will_call_arrival_count_ty_rolling_13_week {
    label: "Will Call Arrival Count - Rolling 13 Week"
    description: "Count of transactions in the script count which arrived in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ty_rolling_13_week]
  }

  measure: sum_will_call_arrival_count_ly_rolling_13_week {
    label: "LY Will Call Arrival Count - Rolling 13 Week"
    description: "Count of transactions in the script count which arrived in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_arrival_count_ly_rolling_13_week]
  }

  measure: sum_will_call_autofill_arrival_count_ty {
    label: "Autofill Arrival Count"
    description: "Count of transactions which were filled from autofill and arrived in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty]
  }

  measure: sum_will_call_autofill_arrival_count_ly {
    label: "LY Autofill Arrival Count"
    description: "Count of transactions which were filled from autofill and arrived in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly]
  }

  measure: sum_will_call_autofill_arrival_count_ty_wtd {
    label: "Autofill Arrival Count - WTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_wtd]
  }

  measure: sum_will_call_autofill_arrival_count_ly_wtd {
    label: "LY Autofill Arrival Count - WTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_wtd]
  }

  measure: sum_will_call_autofill_arrival_count_ty_wk {
    label: "Autofill Arrival Count - Complete Week"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_wk]
  }

  measure: sum_will_call_autofill_arrival_count_ly_wk {
    label: "LY Autofill Arrival Count - Complete Week"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_wk]
  }

  measure: sum_will_call_autofill_arrival_count_ty_ptd {
    label: "Autofill Arrival Count - PTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_ptd]
  }

  measure: sum_will_call_autofill_arrival_count_ly_ptd {
    label: "LY Autofill Arrival Count - PTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_ptd]
  }

  measure: sum_will_call_autofill_arrival_count_ty_pd {
    label: "Autofill Arrival Count - Complete Period"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_pd]
  }

  measure: sum_will_call_autofill_arrival_count_ly_pd {
    label: "LY Autofill Arrival Count - Complete Period"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_pd]
  }

  measure: sum_will_call_autofill_arrival_count_ty_qtd {
    label: "Autofill Arrival Count - QTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_qtd]
  }

  measure: sum_will_call_autofill_arrival_count_ly_qtd {
    label: "LY Autofill Arrival Count - QTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_qtd]
  }

  measure: sum_will_call_autofill_arrival_count_ty_qtr {
    label: "Autofill Arrival Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_qtr]
  }

  measure: sum_will_call_autofill_arrival_count_ly_qtr {
    label: "LY Autofill Arrival Count - Complete Quarter"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_qtr]
  }

  measure: sum_will_call_autofill_arrival_count_ty_ytd {
    label: "Autofill Arrival Count - YTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_ytd]
  }

  measure: sum_will_call_autofill_arrival_count_ly_ytd {
    label: "LY Autofill Arrival Count - YTD"
    description: "Count of transactions which were filled from autofill and arrived in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_ytd]
  }

  measure: sum_will_call_autofill_arrival_count_ty_yr {
    label: "Autofill Arrival Count - Complete Year"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_yr]
  }

  measure: sum_will_call_autofill_arrival_count_ly_yr {
    label: "LY Autofill Arrival Count - Complete Year"
    description: "Count of transactions which were filled from autofill and arrived in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_yr]
  }

  measure: sum_will_call_autofill_arrival_count_ty_ttm {
    label: "Autofill Arrival Count - TTM"
    description: "Count of transactions which were filled from autofill and arrived in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_ttm]
  }

  measure: sum_will_call_autofill_arrival_count_ly_ttm {
    label: "LY Autofill Arrival Count - TTM"
    description: "Count of transactions which were filled from autofill and arrived in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_ttm]
  }

  measure: sum_will_call_autofill_arrival_count_ty_rolling_13_week {
    label: "Autofill Arrival Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill and arrived in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ty_rolling_13_week]
  }

  measure: sum_will_call_autofill_arrival_count_ly_rolling_13_week {
    label: "LY Autofill Arrival Count - Rolling 13 Week"
    description: "Count of transactions which were filled from autofill and arrived in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_autofill_arrival_count_ly_rolling_13_week]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty {
    label: "Non Autofill Arrival Count"
    description: "Count of transactions which were not filled from autofill and arrived in will call for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly {
    label: "LY Non Autofill Arrival Count"
    description: "Count of transactions which were not filled from autofill and arrived in will call for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_wtd {
    label: "Non Autofill Arrival Count - WTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for week to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_wtd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_wtd {
    label: "LY Non Autofill Arrival Count - WTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for week to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_wtd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_wk {
    label: "Non Autofill Arrival Count - Complete Week"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_wk]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_wk {
    label: "LY Non Autofill Arrival Count - Complete Week"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.wk_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_wk]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_ptd {
    label: "Non Autofill Arrival Count - PTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for period to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_ptd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_ptd {
    label: "LY Non Autofill Arrival Count - PTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for period to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_ptd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_pd {
    label: "Non Autofill Arrival Count - Complete Period"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete period, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_pd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_pd {
    label: "LY Non Autofill Arrival Count - Complete Period"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete period, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.mnth_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_pd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_qtd {
    label: "Non Autofill Arrival Count - QTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for quarter to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_qtd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_qtd {
    label: "LY Non Autofill Arrival Count - QTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for quarter to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_qtd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_qtr {
    label: "Non Autofill Arrival Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete quarter, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_qtr]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_qtr {
    label: "LY Non Autofill Arrival Count - Complete Quarter"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete quarter, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.qtr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_qtr]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_ytd {
    label: "Non Autofill Arrival Count - YTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for year to date, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_ytd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_ytd {
    label: "LY Non Autofill Arrival Count - YTD"
    description: "Count of transactions which were not filled from autofill and arrived in will call for year to date, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ytd_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_ytd]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_yr {
    label: "Non Autofill Arrival Count - Complete Year"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete year, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_yr]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_yr {
    label: "LY Non Autofill Arrival Count - Complete Year"
    description: "Count of transactions which were not filled from autofill and arrived in will call for complete year, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.yr_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_yr]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_ttm {
    label: "Non Autofill Arrival Count - TTM"
    description: "Count of transactions which were not filled from autofill and arrived in will call for trailing twelve months, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_ttm]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_ttm {
    label: "LY Non Autofill Arrival Count - TTM"
    description: "Count of transactions which were not filled from autofill and arrived in will call for trailing twelve months, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.ttm_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_ttm]
  }

  measure: sum_will_call_non_autofill_arrival_count_ty_rolling_13_week {
    label: "Non Autofill Arrival Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill and arrived in will call for rolling 13 week, for this year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'TY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ty_rolling_13_week]
  }

  measure: sum_will_call_non_autofill_arrival_count_ly_rolling_13_week {
    label: "LY Non Autofill Arrival Count - Rolling 13 Week"
    description: "Count of transactions which were not filled from autofill and arrived in will call for rolling 13 week, for last year"
    type: sum
    sql: CASE WHEN ${report_calendar_global.type} = 'LY' AND ${report_calendar_global.rolling_13_week_flag} = 'Y' THEN ${store_kpi_will_call_non_autofill_arrival_count} END ;;
    value_format: "#,##0;(#,##0)"
    drill_fields: [inventory_kpi_drill_path*,sum_will_call_non_autofill_arrival_count_ly_rolling_13_week]
  }

#TRX-3593 Begin
  measure: store_kpi_period_annualized_turns_ty {
    label: "Annualized Turns - Period"
    description: "Annualized value of inventory turns by period, for this year"
    type: number
    sql: (${sum_cost_of_goods_sold_amount_ty} * (365/${report_calendar_global.ty_fiscal_month_days}))/nullif(${sum_inventory_month_amount_ty}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_period_annualized_turns_ty]
  }

  measure: store_kpi_period_annualized_turns_ly {
    label: "LY Annualized Turns - Period"
    description: "Annualized value of inventory turns by period, for last year"
    type: number
    sql: (${sum_cost_of_goods_sold_amount_ly} * (365/${report_calendar_global.ly_fiscal_month_days}))/nullif(${sum_inventory_month_amount_ly}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_period_annualized_turns_ly]
  }

  measure: store_kpi_quarter_annualized_turns_ty {
    label: "Annualized Turns - Quarter"
    description: "Annualized value of inventory turns by quarter, for this year"
    type: number
    sql: ${sum_cost_of_goods_sold_amount_ty} * (365/${report_calendar_global.ty_fiscal_quarter_days})/nullif(${sum_inventory_quarter_amount_ty}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_quarter_annualized_turns_ty]
  }

  measure: store_kpi_quarter_annualized_turns_ly {
    label: "LY Annualized Turns - Quarter"
    description: "Annualized value of inventory turns by quarter, for last year"
    type: number
    sql: ${sum_cost_of_goods_sold_amount_ly} * (365/${report_calendar_global.ly_fiscal_quarter_days})/nullif(${sum_inventory_quarter_amount_ly}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_quarter_annualized_turns_ly]
  }

  measure: store_kpi_ttm_annualized_turns_ty {
    label: "Annualized Turns - TTM"
    description: "Annualized value of inventory turns for a trailing twelve months, for this year"
    type: number
    sql: ${sum_cost_of_goods_sold_amount_ty} * (365/${report_calendar_global.ty_fiscal_month_days})/nullif(${sum_inventory_month_amount_ty}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_ttm_annualized_turns_ty]
  }

  measure: store_kpi_ttm_annualized_turns_ly {
    label: "LY Annualized Turns - TTM"
    description: "Annualized value of inventory turns for a trailing twelve months, for last year"
    type: number
    sql: ${sum_cost_of_goods_sold_amount_ly} * (365/${report_calendar_global.ly_fiscal_month_days})/nullif(${sum_inventory_month_amount_ly}, 0) ;;
    value_format : "#,##0.00;(#,##0.00)"
    drill_fields: [inventory_kpi_drill_path*,store_kpi_ttm_annualized_turns_ly]
  }

  #TRX-3593 END

  ############################################################ END OF MEASURES ############################################################

  measure: pct_store_kpi_will_call_return_to_stock_count_ty {
    label: "Return To Stock %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty}/NULLIF(${sum_will_call_arrival_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly {
    label: "LY Return To Stock %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly}/NULLIF(${sum_will_call_arrival_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_wtd {
    label: "Return To Stock - WTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for week to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_wtd}/NULLIF(${sum_will_call_arrival_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_wtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_wtd {
    label: "LY Return To Stock - WTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for week to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_wtd}/NULLIF(${sum_will_call_arrival_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_wtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_wk {
    label: "Return To Stock - Complete Week %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete week, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_wk}/NULLIF(${sum_will_call_arrival_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_wk]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_wk {
    label: "LY Return To Stock - Complete Week %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete week, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_wk}/NULLIF(${sum_will_call_arrival_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_wk]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_ptd {
    label: "Return To Stock - PTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for period to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_ptd}/NULLIF(${sum_will_call_arrival_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_ptd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_ptd {
    label: "LY Return To Stock - PTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for period to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_ptd}/NULLIF(${sum_will_call_arrival_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_ptd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_pd {
    label: "Return To Stock - Complete Period %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete period, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_pd}/NULLIF(${sum_will_call_arrival_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_pd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_pd {
    label: "LY Return To Stock - Complete Period %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete period, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_pd}/NULLIF(${sum_will_call_arrival_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_pd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_qtd {
    label: "Return To Stock - QTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for quarter to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_qtd}/NULLIF(${sum_will_call_arrival_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_qtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_qtd {
    label: "LY Return To Stock - QTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for quarter to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_qtd}/NULLIF(${sum_will_call_arrival_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_qtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_qtr {
    label: "Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete quarter, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_qtr}/NULLIF(${sum_will_call_arrival_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_qtr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_qtr {
    label: "LY Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete quarter, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_qtr}/NULLIF(${sum_will_call_arrival_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_qtr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_ytd {
    label: "Return To Stock - YTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for year to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_ytd}/NULLIF(${sum_will_call_arrival_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_ytd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_ytd {
    label: "LY Return To Stock - YTD %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for year to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_ytd}/NULLIF(${sum_will_call_arrival_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_ytd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_yr {
    label: "Return To Stock - Complete Year %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete year, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_yr}/NULLIF(${sum_will_call_arrival_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_yr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_yr {
    label: "LY Return To Stock - Complete Year %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for complete year, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_yr}/NULLIF(${sum_will_call_arrival_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_yr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_ttm {
    label: "Return To Stock - TTM %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for trailing twelve months, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_ttm}/NULLIF(${sum_will_call_arrival_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_ttm]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_ttm {
    label: "LY Return To Stock - TTM %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for trailing twelve months, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_ttm}/NULLIF(${sum_will_call_arrival_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_ttm]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ty_rolling_13_week {
    label: "Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for rolling 13 week, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ty_rolling_13_week}/NULLIF(${sum_will_call_arrival_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_return_to_stock_count_ly_rolling_13_week {
    label: "LY Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were returned to stock after arriving in will call for rolling 13 week, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_count_ly_rolling_13_week}/NULLIF(${sum_will_call_arrival_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_autofill_count_ty {
    label: "Autofill %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for this year"
    type: number
    sql: (${sum_autofill_count_ty}/NULLIF(${sum_script_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty]
  }

  measure: pct_store_kpi_autofill_count_ly {
    label: "LY Autofill %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for last year"
    type: number
    sql: (${sum_autofill_count_ly}/NULLIF(${sum_script_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly]
  }

  measure: pct_store_kpi_autofill_count_ty_wtd {
    label: "Autofill - WTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for week to date, for this year"
    type: number
    sql: (${sum_autofill_count_ty_wtd}/NULLIF(${sum_script_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_wtd]
  }

  measure: pct_store_kpi_autofill_count_ly_wtd {
    label: "LY Autofill - WTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for week to date, for last year"
    type: number
    sql: (${sum_autofill_count_ly_wtd}/NULLIF(${sum_script_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_wtd]
  }

  measure: pct_store_kpi_autofill_count_ty_wk {
    label: "Autofill - Complete Week %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete week, for this year"
    type: number
    sql: (${sum_autofill_count_ty_wk}/NULLIF(${sum_script_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_wk]
  }

  measure: pct_store_kpi_autofill_count_ly_wk {
    label: "LY Autofill - Complete Week %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete week, for last year"
    type: number
    sql: (${sum_autofill_count_ly_wk}/NULLIF(${sum_script_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_wk]
  }

  measure: pct_store_kpi_autofill_count_ty_ptd {
    label: "Autofill - PTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for period to date, for this year"
    type: number
    sql: (${sum_autofill_count_ty_ptd}/NULLIF(${sum_script_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_ptd]
  }

  measure: pct_store_kpi_autofill_count_ly_ptd {
    label: "LY Autofill - PTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for period to date, for last year"
    type: number
    sql: (${sum_autofill_count_ly_ptd}/NULLIF(${sum_script_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_ptd]
  }

  measure: pct_store_kpi_autofill_count_ty_pd {
    label: "Autofill - Complete Period %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete period, for this year"
    type: number
    sql: (${sum_autofill_count_ty_pd}/NULLIF(${sum_script_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_pd]
  }

  measure: pct_store_kpi_autofill_count_ly_pd {
    label: "LY Autofill - Complete Period %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete period, for last year"
    type: number
    sql: (${sum_autofill_count_ly_pd}/NULLIF(${sum_script_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_pd]
  }

  measure: pct_store_kpi_autofill_count_ty_qtd {
    label: "Autofill - QTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for quarter to date, for this year"
    type: number
    sql: (${sum_autofill_count_ty_qtd}/NULLIF(${sum_script_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_qtd]
  }

  measure: pct_store_kpi_autofill_count_ly_qtd {
    label: "LY Autofill - QTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for quarter to date, for last year"
    type: number
    sql: (${sum_autofill_count_ly_qtd}/NULLIF(${sum_script_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_qtd]
  }

  measure: pct_store_kpi_autofill_count_ty_qtr {
    label: "Autofill - Complete Quarter %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete quarter, for this year"
    type: number
    sql: (${sum_autofill_count_ty_qtr}/NULLIF(${sum_script_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_qtr]
  }

  measure: pct_store_kpi_autofill_count_ly_qtr {
    label: "LY Autofill - Complete Quarter %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete quarter, for last year"
    type: number
    sql: (${sum_autofill_count_ly_qtr}/NULLIF(${sum_script_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_qtr]
  }

  measure: pct_store_kpi_autofill_count_ty_ytd {
    label: "Autofill - YTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for year to date, for this year"
    type: number
    sql: (${sum_autofill_count_ty_ytd}/NULLIF(${sum_script_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_ytd]
  }

  measure: pct_store_kpi_autofill_count_ly_ytd {
    label: "LY Autofill - YTD %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for year to date, for last year"
    type: number
    sql: (${sum_autofill_count_ly_ytd}/NULLIF(${sum_script_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_ytd]
  }

  measure: pct_store_kpi_autofill_count_ty_yr {
    label: "Autofill - Complete Year %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete year, for this year"
    type: number
    sql: (${sum_autofill_count_ty_yr}/NULLIF(${sum_script_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_yr]
  }

  measure: pct_store_kpi_autofill_count_ly_yr {
    label: "LY Autofill - Complete Year %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for complete year, for last year"
    type: number
    sql: (${sum_autofill_count_ly_yr}/NULLIF(${sum_script_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_yr]
  }

  measure: pct_store_kpi_autofill_count_ty_ttm {
    label: "Autofill - TTM %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for trailing twelve months, for this year"
    type: number
    sql: (${sum_autofill_count_ty_ttm}/NULLIF(${sum_script_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_ttm]
  }

  measure: pct_store_kpi_autofill_count_ly_ttm {
    label: "LY Autofill - TTM %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for trailing twelve months, for last year"
    type: number
    sql: (${sum_autofill_count_ly_ttm}/NULLIF(${sum_script_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_ttm]
  }

  measure: pct_store_kpi_autofill_count_ty_rolling_13_week {
    label: "Autofill - Rolling 13 Week %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for rolling 13 week, for this year"
    type: number
    sql: (${sum_autofill_count_ty_rolling_13_week}/NULLIF(${sum_script_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_autofill_count_ly_rolling_13_week {
    label: "LY Autofill - Rolling 13 Week %"
    description: "Percentage of transactions which were filled from autofill (refill source = 2) for rolling 13 week, for last year"
    type: number
    sql: (${sum_autofill_count_ly_rolling_13_week}/NULLIF(${sum_script_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_autofill_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty {
    label: "Autofill Return To Stock %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty}/NULLIF(${sum_will_call_autofill_arrival_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly {
    label: "LY Autofill Return To Stock %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly}/NULLIF(${sum_will_call_autofill_arrival_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_wtd {
    label: "Autofill Return To Stock - WTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for week to date, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_wtd}/NULLIF(${sum_will_call_autofill_arrival_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_wtd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_wtd {
    label: "LY Autofill Return To Stock - WTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for week to date, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_wtd}/NULLIF(${sum_will_call_autofill_arrival_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_wtd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_wk {
    label: "Autofill Return To Stock - Complete Week %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete week, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_wk}/NULLIF(${sum_will_call_autofill_arrival_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_wk]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_wk {
    label: "LY Autofill Return To Stock - Complete Week %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete week, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_wk}/NULLIF(${sum_will_call_autofill_arrival_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_wk]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ptd {
    label: "Autofill Return To Stock - PTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for period to date, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_ptd}/NULLIF(${sum_will_call_autofill_arrival_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ptd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ptd {
    label: "LY Autofill Return To Stock - PTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for period to date, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_ptd}/NULLIF(${sum_will_call_autofill_arrival_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ptd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_pd {
    label: "Autofill Return To Stock - Complete Period %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete period, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_pd}/NULLIF(${sum_will_call_autofill_arrival_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_pd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_pd {
    label: "LY Autofill Return To Stock - Complete Period %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete period, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_pd}/NULLIF(${sum_will_call_autofill_arrival_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_pd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_qtd {
    label: "Autofill Return To Stock - QTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for quarter to date, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_qtd}/NULLIF(${sum_will_call_autofill_arrival_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_qtd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_qtd {
    label: "LY Autofill Return To Stock - QTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for quarter to date, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_qtd}/NULLIF(${sum_will_call_autofill_arrival_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_qtd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_qtr {
    label: "Autofill Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete quarter, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_qtr}/NULLIF(${sum_will_call_autofill_arrival_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_qtr]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_qtr {
    label: "LY Autofill Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete quarter, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_qtr}/NULLIF(${sum_will_call_autofill_arrival_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_qtr]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ytd {
    label: "Autofill Return To Stock - YTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for year to date, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_ytd}/NULLIF(${sum_will_call_autofill_arrival_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ytd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ytd {
    label: "LY Autofill Return To Stock - YTD %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for year to date, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_ytd}/NULLIF(${sum_will_call_autofill_arrival_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ytd]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_yr {
    label: "Autofill Return To Stock - Complete Year %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete year, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_yr}/NULLIF(${sum_will_call_autofill_arrival_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_yr]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_yr {
    label: "LY Autofill Return To Stock - Complete Year %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for complete year, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_yr}/NULLIF(${sum_will_call_autofill_arrival_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_yr]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ttm {
    label: "Autofill Return To Stock - TTM %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for trailing twelve months, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_ttm}/NULLIF(${sum_will_call_autofill_arrival_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_ttm]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ttm {
    label: "LY Autofill Return To Stock - TTM %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for trailing twelve months, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_ttm}/NULLIF(${sum_will_call_autofill_arrival_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_ttm]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ty_rolling_13_week {
    label: "Autofill Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for rolling 13 week, for this year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ty_rolling_13_week}/NULLIF(${sum_will_call_autofill_arrival_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_autofill_return_to_stock_count_ly_rolling_13_week {
    label: "LY Autofill Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were filled from autofill and were returned to stock for rolling 13 week, for last year"
    type: number
    sql: (${sum_will_call_autofill_return_to_stock_count_ly_rolling_13_week}/NULLIF(${sum_will_call_autofill_arrival_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_autofill_return_to_stock_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty {
    label: "Cycle Task Complete %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty}/NULLIF(${sum_cycle_count_task_received_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly {
    label: "LY Cycle Task Complete %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly}/NULLIF(${sum_cycle_count_task_received_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_wtd {
    label: "Cycle Task Complete - WTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for week to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_wtd}/NULLIF(${sum_cycle_count_task_received_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_wtd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_wtd {
    label: "LY Cycle Task Complete - WTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for week to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_wtd}/NULLIF(${sum_cycle_count_task_received_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_wtd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_wk {
    label: "Cycle Task Complete - Complete Week %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete week, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_wk}/NULLIF(${sum_cycle_count_task_received_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_wk]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_wk {
    label: "LY Cycle Task Complete - Complete Week %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete week, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_wk}/NULLIF(${sum_cycle_count_task_received_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_wk]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_ptd {
    label: "Cycle Task Complete - PTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for period to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_ptd}/NULLIF(${sum_cycle_count_task_received_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_ptd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_ptd {
    label: "LY Cycle Task Complete - PTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for period to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_ptd}/NULLIF(${sum_cycle_count_task_received_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_ptd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_pd {
    label: "Cycle Task Complete - Complete Period %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete period, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_pd}/NULLIF(${sum_cycle_count_task_received_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_pd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_pd {
    label: "LY Cycle Task Complete - Complete Period %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete period, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_pd}/NULLIF(${sum_cycle_count_task_received_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_pd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_qtd {
    label: "Cycle Task Complete - QTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for quarter to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_qtd}/NULLIF(${sum_cycle_count_task_received_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_qtd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_qtd {
    label: "LY Cycle Task Complete - QTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for quarter to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_qtd}/NULLIF(${sum_cycle_count_task_received_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_qtd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_qtr {
    label: "Cycle Task Complete - Complete Quarter %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete quarter, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_qtr}/NULLIF(${sum_cycle_count_task_received_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_qtr]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_qtr {
    label: "LY Cycle Task Complete - Complete Quarter %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete quarter, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_qtr}/NULLIF(${sum_cycle_count_task_received_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_qtr]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_ytd {
    label: "Cycle Task Complete - YTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for year to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_ytd}/NULLIF(${sum_cycle_count_task_received_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_ytd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_ytd {
    label: "LY Cycle Task Complete - YTD %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for year to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_ytd}/NULLIF(${sum_cycle_count_task_received_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_ytd]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_yr {
    label: "Cycle Task Complete - Complete Year %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete year, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_yr}/NULLIF(${sum_cycle_count_task_received_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_yr]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_yr {
    label: "LY Cycle Task Complete - Complete Year %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for complete year, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_yr}/NULLIF(${sum_cycle_count_task_received_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_yr]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_ttm {
    label: "Cycle Task Complete - TTM %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for trailing twelve months, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_ttm}/NULLIF(${sum_cycle_count_task_received_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_ttm]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_ttm {
    label: "LY Cycle Task Complete - TTM %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for trailing twelve months, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_ttm}/NULLIF(${sum_cycle_count_task_received_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_ttm]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ty_rolling_13_week {
    label: "Cycle Task Complete - Rolling 13 Week %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for rolling 13 week, for this year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ty_rolling_13_week}/NULLIF(${sum_cycle_count_task_received_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_cycle_count_task_complete_count_ly_rolling_13_week {
    label: "LY Cycle Task Complete - Rolling 13 Week %"
    description: "Percentage of completed cycle count tasks based on the received cycle count tasks for rolling 13 week, for last year"
    type: number
    sql: (${sum_cycle_count_task_complete_count_ly_rolling_13_week}/NULLIF(${sum_cycle_count_task_received_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_complete_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty {
    label: "Cycle Task Accurate %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty}/NULLIF(${sum_cycle_count_task_complete_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly {
    label: "LY Cycle Task Accurate %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly}/NULLIF(${sum_cycle_count_task_complete_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_wtd {
    label: "Cycle Task Accurate - WTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for week to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_wtd}/NULLIF(${sum_cycle_count_task_complete_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_wtd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_wtd {
    label: "LY Cycle Task Accurate - WTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for week to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_wtd}/NULLIF(${sum_cycle_count_task_complete_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_wtd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_wk {
    label: "Cycle Task Accurate - Complete Week %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete week, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_wk}/NULLIF(${sum_cycle_count_task_complete_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_wk]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_wk {
    label: "LY Cycle Task Accurate - Complete Week %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete week, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_wk}/NULLIF(${sum_cycle_count_task_complete_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_wk]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_ptd {
    label: "Cycle Task Accurate - PTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for period to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_ptd}/NULLIF(${sum_cycle_count_task_complete_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_ptd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_ptd {
    label: "LY Cycle Task Accurate - PTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for period to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_ptd}/NULLIF(${sum_cycle_count_task_complete_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_ptd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_pd {
    label: "Cycle Task Accurate - Complete Period %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete period, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_pd}/NULLIF(${sum_cycle_count_task_complete_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_pd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_pd {
    label: "LY Cycle Task Accurate - Complete Period %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete period, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_pd}/NULLIF(${sum_cycle_count_task_complete_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_pd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_qtd {
    label: "Cycle Task Accurate - QTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for quarter to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_qtd}/NULLIF(${sum_cycle_count_task_complete_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_qtd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_qtd {
    label: "LY Cycle Task Accurate - QTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for quarter to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_qtd}/NULLIF(${sum_cycle_count_task_complete_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_qtd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_qtr {
    label: "Cycle Task Accurate - Complete Quarter %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete quarter, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_qtr}/NULLIF(${sum_cycle_count_task_complete_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_qtr]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_qtr {
    label: "LY Cycle Task Accurate - Complete Quarter %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete quarter, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_qtr}/NULLIF(${sum_cycle_count_task_complete_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_qtr]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_ytd {
    label: "Cycle Task Accurate - YTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for year to date, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_ytd}/NULLIF(${sum_cycle_count_task_complete_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_ytd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_ytd {
    label: "LY Cycle Task Accurate - YTD %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for year to date, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_ytd}/NULLIF(${sum_cycle_count_task_complete_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_ytd]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_yr {
    label: "Cycle Task Accurate - Complete Year %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete year, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_yr}/NULLIF(${sum_cycle_count_task_complete_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_yr]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_yr {
    label: "LY Cycle Task Accurate - Complete Year %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for complete year, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_yr}/NULLIF(${sum_cycle_count_task_complete_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_yr]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_ttm {
    label: "Cycle Task Accurate - TTM %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for trailing twelve months, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_ttm}/NULLIF(${sum_cycle_count_task_complete_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_ttm]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_ttm {
    label: "LY Cycle Task Accurate - TTM %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for trailing twelve months, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_ttm}/NULLIF(${sum_cycle_count_task_complete_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_ttm]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ty_rolling_13_week {
    label: "Cycle Task Accurate - Rolling 13 Week %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for rolling 13 week, for this year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ty_rolling_13_week}/NULLIF(${sum_cycle_count_task_complete_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_cycle_count_task_accurate_count_ly_rolling_13_week {
    label: "LY Cycle Task Accurate - Rolling 13 Week %"
    description: "Percentage of completed cycle count tasks which had an accurate on-hand count for rolling 13 week, for last year"
    type: number
    sql: (${sum_cycle_count_task_accurate_count_ly_rolling_13_week}/NULLIF(${sum_cycle_count_task_complete_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_cycle_count_task_accurate_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty {
    label: "Non Autofill Return To Stock %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly {
    label: "LY Non Autofill Return To Stock %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_wtd {
    label: "Non Autofill Return To Stock - WTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for week to date, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_wtd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_wtd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_wtd {
    label: "LY Non Autofill Return To Stock - WTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for week to date, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_wtd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_wtd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_wk {
    label: "Non Autofill Return To Stock - Complete Week %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete week, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_wk}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_wk]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_wk {
    label: "LY Non Autofill Return To Stock - Complete Week %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete week, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_wk}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_wk]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ptd {
    label: "Non Autofill Return To Stock - PTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for period to date, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_ptd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ptd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ptd {
    label: "LY Non Autofill Return To Stock - PTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for period to date, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_ptd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ptd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_pd {
    label: "Non Autofill Return To Stock - Complete Period %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete period, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_pd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_pd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_pd {
    label: "LY Non Autofill Return To Stock - Complete Period %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete period, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_pd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_pd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_qtd {
    label: "Non Autofill Return To Stock - QTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for quarter to date, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_qtd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_qtd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_qtd {
    label: "LY Non Autofill Return To Stock - QTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for quarter to date, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_qtd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_qtd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_qtr {
    label: "Non Autofill Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete quarter, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_qtr}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_qtr]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_qtr {
    label: "LY Non Autofill Return To Stock - Complete Quarter %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete quarter, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_qtr}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_qtr]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ytd {
    label: "Non Autofill Return To Stock - YTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for year to date, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_ytd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ytd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ytd {
    label: "LY Non Autofill Return To Stock - YTD %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for year to date, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_ytd}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ytd]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_yr {
    label: "Non Autofill Return To Stock - Complete Year %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete year, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_yr}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_yr]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_yr {
    label: "LY Non Autofill Return To Stock - Complete Year %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for complete year, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_yr}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_yr]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ttm {
    label: "Non Autofill Return To Stock - TTM %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for trailing twelve months, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_ttm}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_ttm]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ttm {
    label: "LY Non Autofill Return To Stock - TTM %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for trailing twelve months, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_ttm}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_ttm]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_rolling_13_week {
    label: "Non Autofill Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for rolling 13 week, for this year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ty_rolling_13_week}/NULLIF(${sum_will_call_non_autofill_arrival_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_rolling_13_week {
    label: "LY Non Autofill Return To Stock - Rolling 13 Week %"
    description: "Percentage of transactions which were not filled from autofill and were returned to stock for rolling 13 week, for last year"
    type: number
    sql: (${sum_will_call_non_autofill_return_to_stock_count_ly_rolling_13_week}/NULLIF(${sum_will_call_non_autofill_arrival_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_non_autofill_return_to_stock_count_ly_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty {
    label: "Return To Stock Past Due %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty}/NULLIF(${sum_will_call_return_to_stock_count_ty},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly {
    label: "LY Return To Stock Past Due %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly}/NULLIF(${sum_will_call_return_to_stock_count_ly},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_wtd {
    label: "Return To Stock Past Due - WTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for week to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_wtd}/NULLIF(${sum_will_call_return_to_stock_count_ty_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_wtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_wtd {
    label: "LY Return To Stock Past Due - WTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for week to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_wtd}/NULLIF(${sum_will_call_return_to_stock_count_ly_wtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_wtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_wk {
    label: "Return To Stock Past Due - Complete Week %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete week, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_wk}/NULLIF(${sum_will_call_return_to_stock_count_ty_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_wk]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_wk {
    label: "LY Return To Stock Past Due - Complete Week %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete week, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_wk}/NULLIF(${sum_will_call_return_to_stock_count_ly_wk},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_wk]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ptd {
    label: "Return To Stock Past Due - PTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for period to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_ptd}/NULLIF(${sum_will_call_return_to_stock_count_ty_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ptd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ptd {
    label: "LY Return To Stock Past Due - PTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for period to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_ptd}/NULLIF(${sum_will_call_return_to_stock_count_ly_ptd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ptd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_pd {
    label: "Return To Stock Past Due - Complete Period %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete period, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_pd}/NULLIF(${sum_will_call_return_to_stock_count_ty_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_pd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_pd {
    label: "LY Return To Stock Past Due - Complete Period %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete period, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_pd}/NULLIF(${sum_will_call_return_to_stock_count_ly_pd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_pd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_qtd {
    label: "Return To Stock Past Due - QTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for quarter to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_qtd}/NULLIF(${sum_will_call_return_to_stock_count_ty_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_qtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_qtd {
    label: "LY Return To Stock Past Due - QTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for quarter to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_qtd}/NULLIF(${sum_will_call_return_to_stock_count_ly_qtd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_qtd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_qtr {
    label: "Return To Stock Past Due - Complete Quarter %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete quarter, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_qtr}/NULLIF(${sum_will_call_return_to_stock_count_ty_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_qtr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_qtr {
    label: "LY Return To Stock Past Due - Complete Quarter %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete quarter, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_qtr}/NULLIF(${sum_will_call_return_to_stock_count_ly_qtr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_qtr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ytd {
    label: "Return To Stock Past Due - YTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for year to date, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_ytd}/NULLIF(${sum_will_call_return_to_stock_count_ty_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ytd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ytd {
    label: "LY Return To Stock Past Due - YTD %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for year to date, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_ytd}/NULLIF(${sum_will_call_return_to_stock_count_ly_ytd},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ytd]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_yr {
    label: "Return To Stock Past Due - Complete Year %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete year, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_yr}/NULLIF(${sum_will_call_return_to_stock_count_ty_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_yr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_yr {
    label: "LY Return To Stock Past Due - Complete Year %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for complete year, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_yr}/NULLIF(${sum_will_call_return_to_stock_count_ly_yr},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_yr]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ttm {
    label: "Return To Stock Past Due - TTM %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for trailing twelve months, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_ttm}/NULLIF(${sum_will_call_return_to_stock_count_ty_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_ttm]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ttm {
    label: "LY Return To Stock Past Due - TTM %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for trailing twelve months, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_ttm}/NULLIF(${sum_will_call_return_to_stock_count_ly_ttm},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_ttm]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ty_rolling_13_week {
    label: "Return To Stock Past Due - Rolling 13 Week %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for rolling 13 week, for this year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ty_rolling_13_week}/NULLIF(${sum_will_call_return_to_stock_count_ty_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ty_rolling_13_week]
  }

  measure: pct_store_kpi_will_call_return_to_stock_past_due_count_ly_rolling_13_week {
    label: "LY Return To Stock Past Due - Rolling 13 Week %"
    description: "Percentage of transactions which were not returned to stock by the chain's specified return to stock date for rolling 13 week, for last year"
    type: number
    sql: (${sum_will_call_return_to_stock_past_due_count_ly_rolling_13_week}/NULLIF(${sum_will_call_return_to_stock_count_ly_rolling_13_week},0)) ;;
    value_format: "00.00%"
    drill_fields: [inventory_kpi_drill_path*,pct_store_kpi_will_call_return_to_stock_past_due_count_ly_rolling_13_week]
  }

  ############################################################ END OF PERCENT MEASURES ############################################################

  set: inventory_kpi_drill_path {
    fields: [
      store_alignment.division,
      store_alignment.region,
      store_alignment.district,
      store.store_number
    ]
  }

}

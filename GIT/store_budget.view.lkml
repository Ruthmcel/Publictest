view: store_budget {
  label: "Store Budget"

  derived_table: {
    sql: With daily_budget_cal as
             (Select bg.nhin_store_id,
                     bg.fiscal_budget_period_identifier,
                     bg.pharmacy_scripts_budget,
                     bg.pharmacy_sales_budget,
                     bg.store_sales_budget,
                     bg.margin,
                     bg.pharmacy_brand_scripts_budget, --#ERX-3509
                     bg.pharmacy_generic_scripts_budget,
                     bg.pharmacy_brand_sales_budget,
                     bg.pharmacy_generic_sales_budget, --#ERX-3509
                     bg.store_pharmacy_number,
                    (bg.pharmacy_scripts_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_scripts_budget,
                    (bg.pharmacy_sales_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_sales_budget,
                    (bg.store_sales_budget/nullif(cal.days_in_budget_identifier,0)) daily_store_sales_budget,
                    (bg.margin/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_margin_budget,
                    (bg.pharmacy_brand_scripts_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_brand_scripts_budget, --#ERX-3509
                    (bg.pharmacy_brand_sales_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_brand_sales_budget,
                    (bg.pharmacy_generic_scripts_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_generic_scripts_budget,
                    (bg.pharmacy_generic_sales_budget/nullif(cal.days_in_budget_identifier,0)) daily_pharmacy_generic_sales_budget, --#ERX-3509
                    cal.*
               from edw.d_budget bg,
                    ${report_calendar_global.SQL_TABLE_NAME} AS cal
              where cal.chain_id = bg.chain_id
                and cal.budget_period_identifier = bg.fiscal_budget_period_identifier
                and cal.type = 'TY' ------- We are not considering LY because budget is required only for TY
             )
             Select calendar_date,
                    chain_id,
                    nhin_store_id,
                    fiscal_budget_period_identifier,
                    daily_pharmacy_scripts_budget,
                    daily_pharmacy_sales_budget,
                    daily_store_sales_budget,
                    daily_pharmacy_margin_budget,
                    daily_pharmacy_brand_scripts_budget,--#ERX-3509
                    daily_pharmacy_brand_sales_budget,
                    daily_pharmacy_generic_scripts_budget,
                    daily_pharmacy_generic_sales_budget,--#ERX-3509
                    pharmacy_scripts_budget,
                    pharmacy_sales_budget,
                    store_sales_budget,
                    margin,
                    pharmacy_brand_scripts_budget, --#ERX-3509
                    pharmacy_generic_scripts_budget,
                    pharmacy_brand_sales_budget,
                    pharmacy_generic_sales_budget, --#ERX-3509
                    days_in_budget_identifier,
                    report_date,
                    store_pharmacy_number,
                    type,
                    year,
                    month_of_year,
                    quarter_of_year,
                    week_of_year,
                    sum(daily_pharmacy_scripts_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_scripts_budget,
                    sum(daily_pharmacy_scripts_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_scripts_budget,
                    sum(daily_pharmacy_scripts_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_scripts_budget,
                    sum(daily_pharmacy_scripts_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_scripts_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_scripts_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_scripts_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_scripts_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_scripts_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_scripts_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_scripts_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_scripts_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_scripts_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_scripts_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_scripts_budget,
                    sum(daily_pharmacy_sales_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_sales_budget,
                    sum(daily_pharmacy_sales_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_sales_budget,
                    sum(daily_pharmacy_sales_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_sales_budget,
                    sum(daily_pharmacy_sales_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_sales_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_sales_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_sales_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_sales_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_sales_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_sales_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_sales_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_sales_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_sales_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_sales_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_sales_budget,
                    sum(daily_pharmacy_margin_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_margin_budget,
                    sum(daily_pharmacy_margin_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_margin_budget,
                    sum(daily_pharmacy_margin_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_margin_budget,
                    sum(daily_pharmacy_margin_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_margin_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_margin_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_margin_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_margin_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_margin_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_margin_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_margin_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_margin_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_margin_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_margin_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_margin_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_margin_budget,
                    --#ERX-3509
                    sum(daily_pharmacy_brand_scripts_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_brand_scripts_budget,
                    sum(daily_pharmacy_brand_scripts_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_brand_scripts_budget,
                    sum(daily_pharmacy_brand_scripts_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_brand_scripts_budget,
                    sum(daily_pharmacy_brand_scripts_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_brand_scripts_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_brand_scripts_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_brand_scripts_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_brand_scripts_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_brand_scripts_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_brand_scripts_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_brand_scripts_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_brand_scripts_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_brand_scripts_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_brand_scripts_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_brand_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_brand_scripts_budget,
                    sum(daily_pharmacy_generic_scripts_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_generic_scripts_budget,
                    sum(daily_pharmacy_generic_scripts_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_generic_scripts_budget,
                    sum(daily_pharmacy_generic_scripts_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_generic_scripts_budget,
                    sum(daily_pharmacy_generic_scripts_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_generic_scripts_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_generic_scripts_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_generic_scripts_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_generic_scripts_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_generic_scripts_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_generic_scripts_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_generic_scripts_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_generic_scripts_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_generic_scripts_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_generic_scripts_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_generic_scripts_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_generic_scripts_budget,
                    sum(daily_pharmacy_brand_sales_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_brand_sales_budget,
                    sum(daily_pharmacy_brand_sales_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_brand_sales_budget,
                    sum(daily_pharmacy_brand_sales_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_brand_sales_budget,
                    sum(daily_pharmacy_brand_sales_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_brand_sales_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_brand_sales_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_brand_sales_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_brand_sales_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_brand_sales_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_brand_sales_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_brand_sales_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_brand_sales_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_brand_sales_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_brand_sales_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_brand_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_brand_sales_budget,
                    sum(daily_pharmacy_generic_sales_budget) over (partition by chain_id ,nhin_store_id,year,month_of_year,type) monthly_pharmacy_generic_sales_budget,
                    sum(daily_pharmacy_generic_sales_budget) over (partition by chain_id ,nhin_store_id,year,quarter_of_year,type) quarterly_pharmacy_generic_sales_budget,
                    sum(daily_pharmacy_generic_sales_budget) over (partition by chain_id ,nhin_store_id,year,week_of_year,type) weekly_pharmacy_generic_sales_budget,
                    sum(daily_pharmacy_generic_sales_budget) over (partition by chain_id ,nhin_store_id,year,type) yearly_pharmacy_generic_sales_budget,
                    sum(case when mtd = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mtd) mtd_pharmacy_generic_sales_budget,
                    sum(case when qtd = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtd) qtd_pharmacy_generic_sales_budget,
                    sum(case when wtd = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wtd) wtd_pharmacy_generic_sales_budget,
                    sum(case when ytd = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ytd) ytd_pharmacy_generic_sales_budget,
                    sum(case when mnth = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,mnth) mnth_pharmacy_generic_sales_budget,
                    sum(case when qtr = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,qtr) qtr_pharmacy_generic_sales_budget,
                    sum(case when wk = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,wk) wk_pharmacy_generic_sales_budget,
                    sum(case when yr = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,yr) yr_pharmacy_generic_sales_budget,
                    sum(case when rolling_13_week = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,rolling_13_week) roll_week_pharmacy_generic_sales_budget,
                    sum(case when ttm = 'Y' then daily_pharmacy_generic_sales_budget  end) over (partition by chain_id,nhin_store_id,type,ttm) ttm_pharmacy_generic_sales_budget
                    --#ERX-3509
               from daily_budget_cal
       ;;
  }

  ################################################################################################## Dimensions ###############################################################################################

  dimension: calendar_date {
    label: "Calendar Date"
    type: date
    hidden: yes
    sql: ${TABLE}.calendar_date ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    type: number
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store Id"
    type: number
    hidden: yes
    sql: ${TABLE}.nhin_store_id ;;
  }

  dimension: fiscal_budget_period_identifier {
    label: "Budget Period Identifier"
    description: "Budget period number"
    type: string
    sql: ${TABLE}.fiscal_budget_period_identifier ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.calendar_date ;; #ERXLPS-1649
  }

  ### column not available in report_temp.d_budget table  , when refernce table is changed then made this dimension available
  dimension: store_pharmacy_number {
    label: "Store Pharmacy Number"
    description: "Pharmacy where the patient allergy record was entered"
    type: string
    #hidden: yes
    sql: ${TABLE}.STORE_PHARMACY_NUMBER ;;
  }

  dimension: daily_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Daily"
    description: "Total number of scripts as per budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_scripts_budget  END ;;
  }

  #value_format: "#,##0;(#,##0)"

  dimension: daily_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Daily"
    description: "Total pharmacy sales budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: daily_store_sales_budget {
    label: "Daily Store Sales Budget"
    description: "Total sales amount for the store for the day"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_store_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.calendar_date ;; #ERXLPS-1649
  }

  dimension: daily_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Daily"
    description: "Total pharmacy margin budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_margin_budget  END ;;
  }
  #ERX-3509 : added dimensions and measures for brand and generic scripts and sales
  dimension: daily_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Daily"
    description: "Total number of brand scripts as per budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_brand_scripts_budget  END ;;
  }

  dimension: daily_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Daily"
    description: "Total pharmacy brand sales budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_brand_sales_budget  END ;;
  }

  dimension: daily_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Daily"
    description: "Total number of generic scripts as per budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_generic_scripts_budget  END ;;
  }

  dimension: daily_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Daily"
    description: "Total pharmacy generic sales budget for the day"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.daily_pharmacy_generic_sales_budget  END ;;
  }

  #value_format: "$#,##0.00;($#,##0.00)"

  measure: pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget"
    group_label: "Other Budget"
    description: "Total number of scripts for the budget period"
    type: sum_distinct
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_scripts_budget  END ;;
    value_format: "#,##0;(#,##0)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: pharmacy_sales_budget {
    label: "Pharmacy Sales Budget"
    group_label: "Other Budget"
    description: "Total pharmacy sales amount for the budget period"
    type: sum_distinct
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: store_sales_budget {
    label: "Store Sales Budget"
    group_label: "Other Budget"
    description: "Total store sales amount for the budget period"
    type: sum_distinct
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.store_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: pharmacy_margin_budget {
    label: "Pharmacy Margin Budget"
    group_label: "Other Budget"
    description: "Total pharmacy margin amount for the budget period"
    type: sum_distinct
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.margin  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  #ERX-3509 : added dimensions and measures for brand and generic scripts and sales
  measure: pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget"
    group_label: "Other Budget"
    description: "Total number of brand scripts for the budget period"
    type: sum_distinct
    hidden:  yes #[ERXLPS-2055] - Hiding from store_budget. Similar measure exposed from sales view.
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;(#,##0)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget"
    group_label: "Other Budget"
    description: "Total pharmacy brand sales amount for the budget period"
    type: sum_distinct
    hidden:  yes #[ERXLPS-2055] - Hiding from store_budget. Similar measure exposed from sales view.
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_brand_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget"
    group_label: "Other Budget"
    description: "Total number of generic scripts for the budget period"
    type: sum_distinct
    hidden:  yes #[ERXLPS-2055] - Hiding from store_budget. Similar measure exposed from sales view.
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;(#,##0)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  measure: pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget"
    group_label: "Other Budget"
    description: "Total pharmacy generic sales amount for the budget period"
    type: sum_distinct
    hidden:  yes #[ERXLPS-2055] - Hiding from store_budget. Similar measure exposed from sales view.
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.pharmacy_generic_sales_budget  END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${fiscal_budget_period_identifier} ;; #ERXLPS-1649
  }

  dimension: days_in_budget_identifier {
    label: "Days In Budget Identifier"
    description: "Number of days which has same budget identifier value"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.days_in_budget_identifier  END ;;
  }

  dimension: report_date {
    label: "Report Date"
    type: date
    hidden: yes
    sql: ${TABLE}.report_date ;;
  }

  dimension: type {
    label: "Type"
    type: string
    hidden: yes
    sql: ${TABLE}.type ;;
  }

  measure: monthly_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Monthly"
    description: "Total number of scripts as per budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Quarterly"
    description: "Total number of scripts as per budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Weekly"
    description: "Total number of scripts as per budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Yearly"
    description: "Total number of scripts as per budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - MTD"
    description: "Total number of scripts as per budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtd_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - QTD"
    description: "Total number of scripts as per budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wtd_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - WTD\""
    description: "Total number of scripts as per budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ytd_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - YTD"
    description: "Total number of scripts as per budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: mnth_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Complete Month"
    description: "Total number of scripts as per budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtr_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Complete Quarter"
    description: "Total number of scripts as per budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wk_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Complete Week"
    description: "Total number of scripts as per budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: yr_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Complete Year"
    description: "Total number of scripts as per budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: roll_week_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - Rolling 13 Week"
    description: "Total number of scripts as per budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ttm_pharmacy_scripts_budget {
    label: "Pharmacy Scripts Budget - TTM"
    description: "Total number of scripts as per budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  measure: monthly_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Monthly"
    description: "Total pharmacy sales budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Quarterly"
    description: "Total pharmacy sales budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Weekly"
    description: "Total pharmacy sales budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Yearly"
    description: "Total pharmacy sales budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - MTD"
    description: "Total pharmacy sales budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtd_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - QTD"
    description: "Total pharmacy sales budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wtd_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - WTD"
    description: "Total pharmacy sales budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ytd_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - YTD"
    description: "Total pharmacy sales budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: mnth_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Complete Month"
    description: "Total pharmacy sales budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtr_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Complete Quarter"
    description: "Total pharmacy sales budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wk_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Complete Week"
    description: "Total pharmacy sales budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: yr_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Complete Year"
    description: "Total pharmacy sales budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: roll_week_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - Rolling 13 Week"
    description: "Total pharmacy sales budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ttm_pharmacy_sales_budget {
    label: "Pharmacy Sales Budget - TTM"
    description: "Total pharmacy sales budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  measure: monthly_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Monthly"
    description: "Total pharmacy margin budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Quarterly"
    description: "Total pharmacy margin budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Weekly"
    description: "Total pharmacy margin budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Yearly"
    description: "Total pharmacy margin budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - MTD"
    description: "Total pharmacy margin budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtd_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - QTD"
    description: "Total pharmacy margin budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wtd_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - WTD"
    description: "Total pharmacy margin budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ytd_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - YTD"
    description: "Total pharmacy margin budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: mnth_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Complete Month"
    description: "Total pharmacy margin budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtr_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Complete Quarter"
    description: "Total pharmacy margin budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wk_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Complete Week"
    description: "Total pharmacy margin budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: yr_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Complete Year"
    description: "Total pharmacy margin budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: roll_week_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - Rolling 13 Week"
    description: "Total pharmacy margin budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ttm_pharmacy_margin_budget {
    label: "Pharmacy Margin Budget - TTM"
    description: "Total pharmacy margin budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_margin_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  #ERX-3509 : added dimensions and measures for brand and generic scripts and sales
  measure: monthly_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Monthly"
    description: "Total number of brand scripts as per budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Quarterly"
    description: "Total number of brand scripts as per budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Weekly"
    description: "Total number of brand scripts as per budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Yearly"
    description: "Total number of brand scripts as per budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - MTD"
    description: "Total number of brand scripts as per budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_brand_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtd_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - QTD"
    description: "Total number of brand scripts as per budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wtd_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - WTD\""
    description: "Total number of brand scripts as per budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ytd_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - YTD"
    description: "Total number of brand scripts as per budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: mnth_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Complete Month"
    description: "Total number of brand scripts as per budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtr_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Complete Quarter"
    description: "Total number of brand scripts as per budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wk_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Complete Week"
    description: "Total number of brand scripts as per budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: yr_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Complete Year"
    description: "Total number of brand scripts as per budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: roll_week_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - Rolling 13 Week"
    description: "Total number of brand scripts as per budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ttm_pharmacy_brand_scripts_budget {
    label: "Pharmacy Brand Scripts Budget - TTM"
    description: "Total number of brand scripts as per budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_brand_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  measure: monthly_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Monthly"
    description: "Total pharmacy brand sales budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Quarterly"
    description: "Total pharmacy brand sales budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Weekly"
    description: "Total pharmacy brand sales budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Yearly"
    description: "Total pharmacy brand sales budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - MTD"
    description: "Total pharmacy brand sales budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtd_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - QTD"
    description: "Total pharmacy brand sales budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wtd_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - WTD"
    description: "Total pharmacy brand sales budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ytd_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - YTD"
    description: "Total pharmacy brand sales budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: mnth_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Complete Month"
    description: "Total pharmacy brand sales budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtr_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Complete Quarter"
    description: "Total pharmacy brand sales budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wk_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Complete Week"
    description: "Total pharmacy brand sales budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: yr_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Complete Year"
    description: "Total pharmacy brand sales budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: roll_week_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - Rolling 13 Week"
    description: "Total pharmacy brand sales budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ttm_pharmacy_brand_sales_budget {
    label: "Pharmacy Brand Sales Budget - TTM"
    description: "Total pharmacy brand sales budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_brand_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  measure: monthly_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Monthly"
    description: "Total number of generic scripts as per budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Quarterly"
    description: "Total number of generic scripts as per budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Weekly"
    description: "Total number of generic scripts as per budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Yearly"
    description: "Total number of generic scripts as per budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - MTD"
    description: "Total number of generic scripts as per budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_generic_scripts_budget  END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtd_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - QTD"
    description: "Total number of generic scripts as per budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wtd_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - WTD\""
    description: "Total number of generic scripts as per budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ytd_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - YTD"
    description: "Total number of generic scripts as per budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: mnth_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Complete Month"
    description: "Total number of generic scripts as per budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: qtr_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Complete Quarter"
    description: "Total number of generic scripts as per budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: wk_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Complete Week"
    description: "Total number of generic scripts as per budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: yr_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Complete Year"
    description: "Total number of generic scripts as per budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: roll_week_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - Rolling 13 Week"
    description: "Total number of generic scripts as per budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  dimension: ttm_pharmacy_generic_scripts_budget {
    label: "Pharmacy Generic Scripts Budget - TTM"
    description: "Total number of generic scripts as per budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_generic_scripts_budget END ;;
    value_format: "#,##0;#,##0"
  }

  measure: monthly_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Monthly"
    description: "Total pharmacy generic sales budget for the month"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.monthly_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.month_of_year ;; #ERXLPS-1649
  }

  measure: quarterly_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Quarterly"
    description: "Total pharmacy generic sales budget for the quarter"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.quarterly_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.quarter_of_year ;; #ERXLPS-1649
  }

  measure: weekly_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Weekly"
    description: "Total pharmacy generic sales budget for the week"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.weekly_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ||'@'|| ${TABLE}.week_of_year ;; #ERXLPS-1649
  }

  measure: yearly_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Yearly"
    description: "Total pharmacy generic sales budget for the year"
    type: sum_distinct
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yearly_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
    sql_distinct_key: ${TABLE}.chain_id ||'@'|| ${TABLE}.nhin_store_id ||'@'|| ${TABLE}.year ;; #ERXLPS-1649
  }

  dimension: mtd_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - MTD"
    description: "Total pharmacy generic sales budget for MTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mtd_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtd_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - QTD"
    description: "Total pharmacy generic sales budget for QTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtd_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wtd_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - WTD"
    description: "Total pharmacy generic sales budget for WTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wtd_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ytd_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - YTD"
    description: "Total pharmacy generic sales budget for YTD"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ytd_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: mnth_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Complete Month"
    description: "Total pharmacy generic sales budget for complete month"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.mnth_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: qtr_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Complete Quarter"
    description: "Total pharmacy generic sales budget for complete quarter"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.qtr_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: wk_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Complete Week"
    description: "Total pharmacy generic sales budget for complete week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.wk_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: yr_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Complete Year"
    description: "Total pharmacy generic sales budget for complete year"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.yr_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: roll_week_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - Rolling 13 Week"
    description: "Total pharmacy generic sales budget for rolling 13 week"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.roll_week_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }

  dimension: ttm_pharmacy_generic_sales_budget {
    label: "Pharmacy Generic Sales Budget - TTM"
    description: "Total pharmacy generic sales budget for TTM"
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.type = 'TY' then ${TABLE}.ttm_pharmacy_generic_sales_budget END ;;
    value_format: "$#,##0.00;$#,##0.00"
  }
  #end of ERX-3509 : added dimensions and measures for brand and generic scripts and sales

  ################################################################################################## End of dimensions ##################################################################################################

  set: looker_prod_1_6_009_deployment_budget_candidate_list {
    fields: [fiscal_budget_period_identifier, pharmacy_sales_budget, pharmacy_scripts_budget, store_sales_budget, pharmacy_margin_budget]
  }
}

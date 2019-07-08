view: ar_chain_last_week_end_date {

  ## Due to requirements for AR reports, including the Aging report, a dimension that has the last production cycle WEEK END DATE is required. The value must be present on all rows, to be available to compare with all dates.
  ## Joining the production cycle table on MAX date to the EVENT table does not allow the value to be present on all rows, only the rows that the event date matches the Max WEEK_END_DATE from the Productionu Cycle Table

  derived_table: {
     sql:
          select chain_id
            , max(week_end_date) production_cycle_last_week_end_date
          from edw.f_production_cycle_tracking
          where production_cycle_tracking_production_finish_date is not null
            and production_cycle_tracking_deleted = 'N'
            and {% condition ar_chain.chain_id %} CHAIN_ID {% endcondition %}
          group by chain_id

       ;;
  }

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Unique ID number identifying a customer in the AR system."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

################################################################################################# Dimensions ##############################################################################################################

  dimension_group: production_cycle_last_week_end {
    label: "Last Production Cycle Week End"
    description: "The Last (Max) Date on which Customer’s week ends (end of accounting week), previous to the current date."
    type: time
    sql: ${TABLE}.PRODUCTION_CYCLE_LAST_WEEK_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

}

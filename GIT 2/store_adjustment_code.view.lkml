view: store_adjustment_code {
  sql_table_name: EDW.D_ADJUSTMENT_CODE ;;

  dimension: adjustment_code_id {
    type: number
    hidden: yes
    label: "Adjustment Code ID"
    sql: ${TABLE}.ADJUSTMENT_CODE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${adjustment_code_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Adjustment Code Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Adjustment Code NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################

  dimension: adjustment_code {
    type: string
    label: "Adjustment Code"
    description: "A three character code that represents a particular return and adjustment type"
    sql: ${TABLE}.ADJUSTMENT_CODE ;;
  }

  dimension: adjustment_code_description {
    type: string
    label: "Adjustment Code Description"
    description: "The description of the adjustment type being performed"
    sql: ${TABLE}.ADJUSTMENT_CODE_DESCRIPTION ;;
  }

  dimension: adjustment_code_display_name {
    type: string
    label: "Adjustment Code Display Name"
    description: "The alternate description of the adjustment code that will be shown in the UI"
    sql: ${TABLE}.ADJUSTMENT_CODE_DISPLAY_NAME ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: adjustment_code_deactivate {
    label: "Adjustment Code Deactivate"
    description: "Date the Adjustment Code was deactivated"
    type: time
    timeframes: [
    date,
    day_of_month,
    day_of_week,
    day_of_week_index,
    hour,
    hour_of_day,
    minute,
    month,
    month_num,
    quarter,
    quarter_of_year,
    time,
    time_of_day,
    week,
    week_of_year,
    year,
    day_of_year,
    month_name
    ]
    sql: ${TABLE}.ADJUSTMENT_CODE_DEACTIVATE_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: adjustment_code_exclude_from_c2_tracking {
    label: "Adjustment Code Exclude From C2 Tracking"
    description: "Yes/No Flag indicating if this Adjustment Code should be excluded from the CII tracking windows"
    type: yesno
    sql: ${TABLE}.ADJUSTMENT_CODE_EXCLUDE_FROM_C2_TRACKING = 'Y' ;;
  }

  dimension: adjustment_code_exclude_from_on_hand_change {
    label: "Adjustment Code Exclude From On Hand Change"
    description: "Yes/No Flag indicating if this Adjustment Code should be excluded from the On Hand Changes windows"
    type: yesno
    sql: ${TABLE}.ADJUSTMENT_CODE_EXCLUDE_FROM_ON_HAND_CHANGE = 'Y' ;;
  }

  dimension: adjustment_code_exclude_from_returns_and_adjustments {
    label: "Adjustment Code Exclude From Returns And Adjustments"
    description: "Yes/No Flag indicating if this Adjustment Code should be excluded from the Returns/Adjustments windows"
    type: yesno
    sql: ${TABLE}.ADJUSTMENT_CODE_EXCLUDE_FROM_RETURNS_AND_ADJUSTMENTS = 'Y' ;;
  }

  dimension: adjustment_code_hide_from_report_list {
    label: "Adjustment Code Hide From Report List"
    description: "Yes/No Flag indicating  if this Adjustment Code should be excluded from the Report List"
    type: yesno
    sql: ${TABLE}.ADJUSTMENT_CODE_HIDE_FROM_REPORT_LIST = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: adjustment_code_change_on_hand {
    type: string
    label: "Adjustment Code On Hand Type"
    description: "Type of inventory adjustment (INCREASE, DECREASE, RESET) of the corresponding adjustment code"

    case: {
      when: {
        sql: ${TABLE}.ADJUSTMENT_CODE_CHANGE_ON_HAND = '+' ;;
        label: "INCREASE"
      }

      when: {
        sql: ${TABLE}.ADJUSTMENT_CODE_CHANGE_ON_HAND = '-' ;;
        label: "DECREASE"
      }

      when: {
        sql: ${TABLE}.ADJUSTMENT_CODE_CHANGE_ON_HAND = '=' ;;
        label: "RESET"
      }
    }
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################
  measure: count {
    label: "Total Adjustment Codes"
    type: count
    value_format: "#,##0"
  }


####################################################################################################### End of Measures #################################################################################################################
####################################################################### Sets ############################################################

set: explore_rx_store_adjustment_code_4_11_candidate_list {
  fields: [
    adjustment_code,
    adjustment_code_description,
    adjustment_code_display_name,
    adjustment_code_exclude_from_c2_tracking,
    adjustment_code_exclude_from_on_hand_change,
    adjustment_code_exclude_from_returns_and_adjustments,
    adjustment_code_hide_from_report_list,
    adjustment_code_change_on_hand,
    count,
    adjustment_code_deactivate_date,
    adjustment_code_deactivate_day_of_month,
    adjustment_code_deactivate_day_of_week,
    adjustment_code_deactivate_day_of_week_index,
    adjustment_code_deactivate_day_of_year,
    adjustment_code_deactivate_month_name,
    adjustment_code_deactivate_hour,
    adjustment_code_deactivate_hour_of_day,
    adjustment_code_deactivate_minute,
    adjustment_code_deactivate_month,
    adjustment_code_deactivate_month_num,
    adjustment_code_deactivate_quarter,
    adjustment_code_deactivate_quarter_of_year,
    adjustment_code_deactivate_time,
    adjustment_code_deactivate_time_of_day,
    adjustment_code_deactivate_week,
    adjustment_code_deactivate_week_of_year,
    adjustment_code_deactivate_year
  ]
}
}

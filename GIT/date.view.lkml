view: date {
  sql_table_name: EDW.D_DATE ;;

  dimension: date_id {
    primary_key: yes
    sql: ${TABLE}.DATE_ID ;;
  }

  dimension_group: calendar {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.CALENDAR_DATE ;;
  }

  dimension: day_of_month {
    sql: ${TABLE}.DAY_OF_MONTH ;;
  }

  dimension: day_of_quarter {
    sql: ${TABLE}.DAY_OF_QUARTER ;;
  }

  dimension: day_of_week {
    sql: ${TABLE}.DAY_OF_WEEK ;;
  }

  dimension: day_of_week_full_name {
    sql: ${TABLE}.DAY_OF_WEEK_FULL_NAME ;;
  }

  dimension: day_of_week_short_name {
    sql: ${TABLE}.DAY_OF_WEEK_SHORT_NAME ;;
  }

  dimension: day_of_year {
    sql: ${TABLE}.DAY_OF_YEAR ;;
  }

  dimension: days_remaining_in_month {
    sql: ${TABLE}.DAYS_REMAINING_IN_MONTH ;;
  }

  dimension: days_remaining_in_quarter {
    sql: ${TABLE}.DAYS_REMAINING_IN_QUARTER ;;
  }

  dimension: days_remaining_in_year {
    sql: ${TABLE}.DAYS_REMAINING_IN_YEAR ;;
  }

  dimension: edw_insert_timestamp {
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension: edw_last_update_timestamp {
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }

  dimension: event_id {
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension: month_of_quarter {
    sql: ${TABLE}.MONTH_OF_QUARTER ;;
  }

  dimension: month_of_year {
    sql: ${TABLE}.MONTH_OF_YEAR ;;
  }

  dimension: month_of_year_full_name {
    sql: ${TABLE}.MONTH_OF_YEAR_FULL_NAME ;;
  }

  dimension: month_of_year_short_name {
    sql: ${TABLE}.MONTH_OF_YEAR_SHORT_NAME ;;
  }

  dimension: quarter_of_year {
    sql: ${TABLE}.QUARTER_OF_YEAR ;;
  }

  dimension: quarter_of_year_name {
    sql: ${TABLE}.QUARTER_OF_YEAR_NAME ;;
  }

  dimension: total_days_in_month {
    sql: ${TABLE}.TOTAL_DAYS_IN_MONTH ;;
  }

  dimension: total_days_in_quarter {
    sql: ${TABLE}.TOTAL_DAYS_IN_QUARTER ;;
  }

  dimension: total_days_in_year {
    sql: ${TABLE}.TOTAL_DAYS_IN_YEAR ;;
  }

  dimension: week_of_month {
    sql: ${TABLE}.WEEK_OF_MONTH ;;
  }

  dimension: week_of_year {
    sql: ${TABLE}.WEEK_OF_YEAR ;;
  }

  dimension: year {
    sql: ${TABLE}.YEAR ;;
  }

  dimension: year_month_of_year {
    sql: ${TABLE}.YEAR_MONTH_OF_YEAR ;;
  }

  dimension: year_quarter_of_year {
    sql: ${TABLE}.YEAR_QUARTER_OF_YEAR ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      date_id,
      day_of_week_full_name,
      day_of_week_short_name,
      month_of_year_full_name,
      month_of_year_short_name,
      quarter_of_year_name,
      alt_prescriber.count,
      card.count,
      chain.count,
      drug.count,
      drug_cost.count,
      drug_cost_hist.count,
      drug_cost_type.count,
      drug_hist.count,
      gpi.count,
      patient.count,
      patient_address.count,
      patient_address_hist.count,
      patient_allergy.count,
      patient_allergy_hist.count,
      patient_disease.count,
      patient_disease_hist.count,
      patient_email.count,
      patient_hist.count,
      patient_medical_condition.count,
      patient_medical_cond_hist.count,
      patient_mtm_eligibility.count,
      patient_mtm_eligibility_hist.count,
      patient_phone.count,
      plan.count,
      prescriber.count,
      source_system.count,
      store.count,
      store_address.count,
      store_address_hist.count,
      store_hist.count,
      tp_link.count,
      rx_tx.count,
      rx_tx_cred.count,
      rx_tx_cred_hist.count,
      rx_tx_diagnosis_code.count,
      rx_tx_hist.count,
      tx_tp.count,
      tx_tp_hist.count
    ]
  }
}

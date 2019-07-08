#[ERXDWPS-7476][ERXDWPS-7987]
view: patient_pdc_summary_flatten {
  sql_table_name: EDW.D_PATIENT_PDC_SUMMARY_FLATTEN_SNAPSHOT ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${pdc_group_id} ||'@'|| ${snapshot_date} ||'@'|| ${bi_version_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    label: "Patient RX COM ID"
    description: "Patient unique identifier"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: pdc_group_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PDC_GROUP_ID ;;
  }

  dimension: bi_version_id {
    hidden: yes
    type: number
    sql: ${TABLE}.BI_VERSION_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: medical_condition {
    type: string
    hidden: yes
    label: "Medical Condition"
    description: "Medical Condition is the Therapy Class, which is the set of GPI's that make up a drug Therapy Class for which the PDC is calculated"
    sql: ${TABLE}.MEDICAL_CONDITION ;;
  }

  dimension: at_least_one_pdc_non_adherence_code_180 {
    type: string
    group_label: "At Least One Methodology"
    label: "At Least One Medication Adherence (6 Months) Flag"
    description: "Patients' adherence status to At least One medication on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_180_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  dimension: at_least_one_pdc_non_adherence_code_365 {
    type: string
    group_label: "At Least One Methodology"
    label: "At Least One Medication Adherence (1 Year) Flag"
    description: "Patients' adherence status to At least One medication on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_365_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  dimension: at_least_one_pdc_non_adherence_code_730 {
    type: string
    group_label: "At Least One Methodology"
    label: "At Least One Medication Adherence (2 Years) Flag"
    description: "Patients' adherence status to At least One medication on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE_730_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  #sql: ${TABLE}.AT_LEAST_ONE_PDC_NON_ADHERENCE_CODE

  dimension: patient_atleast_one_score_180_tier {
    label: "PDC - At Least One (6 Months) Distribution"
    description: "At least One PDC Score group distribution for 6 Months"
    type: tier
    group_label: "At Least One Methodology"
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  dimension: patient_atleast_one_score_365_tier {
    label: "PDC - At Least One (1 Year) Distribution"
    description: "At least One PDC Score group distribution for 1 Year"
    type: tier
    group_label: "At Least One Methodology"
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  dimension: patient_atleast_one_score_730_tier {
    label: "PDC - At Least One (2 Years) Distribution"
    description: "At least One PDC Score group distribution for 2 Years"
    type: tier
    group_label: "At Least One Methodology"
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  dimension: all_pdc_non_adherence_code_180 {
    type: string
    group_label: "All Or None Methodology"
    label: "All Medication Adherence (6 Months) Flag"
    description: "Patients' adherence status to All medications on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_180_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  dimension: all_pdc_non_adherence_code_365 {
    type: string
    group_label: "All Or None Methodology"
    label: "All Medication Adherence (1 Year) Flag"
    description: "Patients' adherence status to All medications on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_365_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  dimension: all_pdc_non_adherence_code_730 {
    type: string
    group_label: "All Or None Methodology"
    label: "All Medication Adherence (2 Years) Flag"
    description: "Patients' adherence status to All medications on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE_730_DAYS = 'S' ;;
        label: "DISCONTINUED MEDICATION"
      }

      when: {
        sql: true ;;
        label: "NO SCORE AVAILABLE"
      }
    }
  }

  #sql: ${TABLE}.ALL_PDC_NON_ADHERENCE_CODE

  dimension: patient_all_score_180_tier {
    label: "PDC - All Or None (6 Months) Distribution"
    description: "All Or None PDC Score group distribution for 6 Months"
    type: tier
    group_label: "All Or None Methodology"
    sql: ${TABLE}.ALL_PDC_SCORE_180_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  dimension: patient_all_score_365_tier {
    label: "PDC - All Or None (1 Year) Distribution"
    description: "All Or None PDC Score group distribution for 1 Year"
    type: tier
    group_label: "All Or None Methodology"
    sql: ${TABLE}.ALL_PDC_SCORE_365_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  dimension: patient_all_score_730_tier {
    label: "PDC - All Or None (2 Years) Distribution"
    description: "All Or None PDC Score group distribution for 2 Years"
    type: tier
    group_label: "All Or None Methodology"
    sql: ${TABLE}.ALL_PDC_SCORE_730_DAYS ;;
    # Distribution is based on population by Census under Zip Code view file. This would be used for demographical analysis
    tiers: [
      0,
      20,
      40,
      60,
      80,
      100
    ]
    style: integer
  }

  #################################################################################################### DATE/TIME fields ###############################################################################################
  dimension_group: pdc_measurement_180_days_begin {
    label: "PDC Measurement 180 Day Begin"
    description: "First measurable day in measurement window which is 180 days older from the day when PDC score is computed"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_BEGIN_DATE_180_DAYS ;;
  }

  dimension_group: pdc_measurement_180_day_end {
    label: "PDC Measurement 180 Day End"
    description: "Day before the day of the Snapshot day. Last measurable day"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_END_DATE_180_DAYS ;;
  }

  dimension_group: pdc_measurement_365_days_begin {
    label: "PDC Measurement 365 Day Begin"
    description: "First measurable day in measurement window which is 365 days older from the day when PDC score is computed"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_BEGIN_DATE_365_DAYS ;;
  }

  dimension_group: pdc_measurement_365_day_end {
    label: "PDC Measurement 365 Day End"
    description: "Day before the day of the Snapshot day. Last measurable day"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_END_DATE_365_DAYS ;;
  }

  dimension_group: pdc_measurement_730_days_begin {
    label: "PDC Measurement 730 Day Begin"
    description: "First measurable day in measurement window which is 730 days older from the day when PDC score is computed"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_BEGIN_DATE_730_DAYS ;;
  }

  dimension_group: pdc_measurement_730_day_end {
    label: "PDC Measurement 730 Day End"
    description: "Day before the day of the Snapshot day. Last measurable day"
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.PDC_MEASUREMENT_END_DATE_730_DAYS ;;
  }

  dimension_group: snapshot {
    label: "Snapshot"
    description: "Date the PDC score was registered in EDW. PDC score computation first started from 04-Apr-2017 and hence pdc data will be always displayed with snapshot date greater than 04-Apr-2017."
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.SNAPSHOT_DATE ;;
  }

  dimension_group: latest_snapshot {
    label: "Latest Snapshot"
    description: "Latest snapshot date the PDC score was registered in EDW. PDC score computation first started from 04-Apr-2017 and hence pdc data will be always displayed with snapshot date greater than 04-Apr-2017."
    type: time
    hidden: yes
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: SELECT MAX(SNAPSHOT_DATE) FROM EDW.D_PATIENT_PDC_SUMMARY_FLATTEN_SNAPSHOT ;;
  }

  #################################################################################################### filters ###############################################################################################
  dimension: at_least_one_pdc_score_180 {
    label: "PDC - At Least One (6 Months)"
    description: "PDC score for patients' medical conditions based on 'At Least One' methodology"
    type: number
    group_label: "At Least One Methodology"
    hidden: yes
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180_DAYS ;;
  }

  filter: at_least_one_pdc_score_180_filter {
    label: "At Least One PDC Score For 6 Months \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'At Least 1' methodology calculated for last 6 months. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: {% condition at_least_one_pdc_score_180_filter %} ${at_least_one_pdc_score_180} {% endcondition %}
      ;;
  }

  dimension: at_least_one_pdc_score_365 {
    label: "Patient Medical Condition - At Least One PDC Score For 1 Year"
    description: "PDC calculation for Medical Condition (Therapy Class) based on the 'At Least 1' methodology. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden: yes
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365_DAYS ;;
  }

  filter: at_least_one_pdc_score_365_filter {
    label: "At Least One PDC Score For 1 Year \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'At Least 1' methodology calculated for last 1 year. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: {% condition at_least_one_pdc_score_365_filter %} ${at_least_one_pdc_score_365} {% endcondition %}
      ;;
  }

  dimension: at_least_one_pdc_score_730 {
    label: "Patient Medical Condition - At Least One PDC Score For 2 Year"
    description: "PDC calculation for Medical Condition (Therapy Class) based on the 'At Least 1' methodology. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden: yes
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730_DAYS ;;
  }

  filter: at_least_one_pdc_score_730_filter {
    label: "At Least One PDC Score For 2 Year \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'At Least 1' methodology calculated for last 2 year. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: {% condition at_least_one_pdc_score_730_filter %} ${at_least_one_pdc_score_730} {% endcondition %}
      ;;
  }

  dimension: all_pdc_score_180 {
    label: "Patient Medical Condition - All Or None PDC Score For 6 Months"
    description: "PDC calculation for Medical Condition (Therapy Class) based on the 'All Or None' methodology. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden: yes
    sql: ${TABLE}.ALL_PDC_SCORE_180_DAYS ;;
  }

  filter: all_pdc_score_180_filter {
    label: "All Or None PDC Score For 6 Months \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'All Or None' methodology calculated for last 6 months. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: {% condition all_pdc_score_180_filter %} ${all_pdc_score_180} {% endcondition %}
      ;;
  }

  dimension: all_pdc_score_365 {
    label: "Patient Medical Condition - All Or None PDC Score For 1 Year"
    description: "PDC calculation for Medical Condition (Therapy Class) based on the 'All Or None' methodology. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden: yes
    sql: ${TABLE}.ALL_PDC_SCORE_365_DAYS ;;
  }

  filter: all_pdc_score_365_filter {
    label: "All Or None PDC Score For 1 Year \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'All Or None' methodology calculated for last 1 year. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: {% condition all_pdc_score_365_filter %} ${all_pdc_score_365} {% endcondition %}
      ;;
  }

  dimension: all_pdc_score_730 {
    label: "Patient Medical Condition - All Or None PDC Score For 2 Year"
    description: "PDC calculation for Medical Condition (Therapy Class) based on the 'All Or None' methodology. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden: yes
    sql: ${TABLE}.ALL_PDC_SCORE_730_DAYS ;;
  }

  filter: all_pdc_score_730_filter {
    label: "All Or None PDC Score For 2 Year \"Filter Only\""
    description: "PDC Score for Patient/Medication (Therapy Class) based on the 'All Or None' methodology calculated for last 2 year. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: {% condition all_pdc_score_730_filter %} ${all_pdc_score_730} {% endcondition %}
      ;;
  }

  filter: latest_snapshot_filter {
    label: "Latest Snapshot Date"
    description: "Yes/No Flag whether to consider latest snapshot date or all days for PDC Calculation. Default value: Yes"
    type: string
    suggestions: ["Yes","No"]
    default_value: "Yes"
  }

  ################################################################################################## End of filters #################################################################################################

  ####################################################################################################### Measures ####################################################################################################
  #{ERXDWPS-8219} - Average measures type changed from number to average. sum_distinct logic is needed in Sales Explore to get the correct results. Based on PK and joins, sum_distinct will be applied in Sales explore.
  measure: avg_at_least_one_pdc_score_180 {
    label: "Avg PDC - At Least One (6 Months)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 6 months"
    type: average
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180_DAYS end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_at_least_one_pdc_score_180 {
    label: "Median Patient Medical Condition - At Least One PDC Score For 6 Months"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'At Least 1' methodology calculated for last 6 months. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_180_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_at_least_one_pdc_score_365 {
    label: "Avg PDC - At Least One (1 Year)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 1 year"
    type: average
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365_DAYS end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_at_least_one_pdc_score_365 {
    label: "Median Patient Medical Condition - At Least One PDC Score For 1 Year"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'At Least 1' methodology for last 1 year. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_365_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_at_least_one_pdc_score_730 {
    label: "Avg PDC - At Least One (2 Year)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 2 years"
    type: average
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730_DAYS end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_at_least_one_pdc_score_730 {
    label: "Median Patient Medical Condition - At Least One PDC Score For 2 Year"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'At Least 1' methodology for last 2 year. The Patient must have at least one medication available on a given day, to be adherent"
    type: number
    group_label: "At Least One Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_730_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_180 {
    label: "Avg PDC - All Or None (6 Months)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 6 months"
    type: average
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_180_DAYS end
                  else ${TABLE}.ALL_PDC_SCORE_180_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_all_pdc_score_180 {
    label: "Median Patient Medical Condition - All Or None PDC Score For 6 Months"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'All Or None' methodology calculated for last 6 months. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_180_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_365 {
    label: "Avg PDC - All Or None (1 Year)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 1 year"
    type: average
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_365_DAYS end
                  else ${TABLE}.ALL_PDC_SCORE_365_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_all_pdc_score_365 {
    label: "Median Patient Medical Condition - All Or None PDC Score For 1 Year"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'All Or None' methodology for last 1 year. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_365_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_730 {
    label: "Avg PDC - All Or None (2 Years)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 2 years"
    type: average
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: (case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_730_DAYS end
                  else ${TABLE}.ALL_PDC_SCORE_730_DAYS
             end) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: median_all_pdc_score_730 {
    label: "Median Patient Medical Condition - All Or None PDC Score For 2 Year"
    description: "Median PDC Score for Medical Condition (Therapy Class) based on the 'All Or None' methodology for last 2 year. The Patient must have All medication available on a given day, to be adherent"
    type: number
    group_label: "All Or None Methodology"
    hidden:  yes
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_730_DAYS) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  ################################################################################################## End of Measures #################################################################################################
  ################################################################################################## Set for Patient detail #################################################################################################

  #[ERXDWPS-7476][ERXDWPS-7987] - patient_detail set updated with rx_com_id_deidentifier and patient_age_tier dimensions.
  #[ERXDWPS-7476][ERXDWPS-7987] - patient_gpi_pdc will view file referenced in demo model sales explore and only rx_com_id_deidentified and patient_age_tier exposed in demo model drill fields. Other firlds are restircted at patient view join in demo model sales explore,
  #[ERXDWPS-7476][ERXDWPS-7987] - All fields other than rx_com_id_deidentified will be exposed in othe model drill fields.
  set: patient_detail {
    fields: [
      chain_id,
      patient.rx_com_id,
      patient.first_name,
      patient.last_name,
      patient.middle_name,
      patient.patient_age,
      patient.rx_com_id_deidentified,
      patient.patient_age_tier
    ]
  }

  #[ERXDWPS-] - Removed hidden dimensions and filters.
  set: pdc_candidate_list {
    fields: [
      medical_condition,
      at_least_one_pdc_non_adherence_code_180,
      at_least_one_pdc_non_adherence_code_365,
      at_least_one_pdc_non_adherence_code_730,
      patient_atleast_one_score_180_tier,
      patient_atleast_one_score_365_tier,
      patient_atleast_one_score_730_tier,
      all_pdc_non_adherence_code_180,
      all_pdc_non_adherence_code_365,
      all_pdc_non_adherence_code_730,
      patient_all_score_180_tier,
      patient_all_score_365_tier,
      patient_all_score_730_tier,
      avg_at_least_one_pdc_score_180,
      median_at_least_one_pdc_score_180,
      avg_at_least_one_pdc_score_365,
      median_at_least_one_pdc_score_365,
      avg_at_least_one_pdc_score_730,
      median_at_least_one_pdc_score_730,
      avg_all_pdc_score_180,
      median_all_pdc_score_180,
      avg_all_pdc_score_365,
      median_all_pdc_score_365,
      avg_all_pdc_score_730,
      median_all_pdc_score_730,
      snapshot,
      snapshot_date,
      snapshot_week,
      snapshot_month,
      snapshot_month_num,
      snapshot_year,
      snapshot_quarter,
      snapshot_quarter_of_year,
      snapshot_hour_of_day,
      snapshot_day_of_week,
      snapshot_day_of_month,
      snapshot_week_of_year,
      snapshot_day_of_week_index
    ]
  }
}

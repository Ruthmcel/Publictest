view: patient_gpi_pdc {
  ## Get PDC score of each patient in a chain, for all three duration on each calendar date
  ## Made the changes to this view file as a part of [ERXLPS-911]
  # [ERXLPS-1517] - PDT Implementation Changes.
  derived_table: {
    sql:
      select chain_id,
             rx_com_id,
             medical_condition,
             gpi,
             snapshot_date,
             max(case when duration_days = 180 then at_least_one_pdc_score end) at_least_one_pdc_score_180,
             max(case when duration_days = 365 then at_least_one_pdc_score end) at_least_one_pdc_score_365,
             max(case when duration_days = 730 then at_least_one_pdc_score end) at_least_one_pdc_score_730,
             max(case when duration_days = 180 then at_least_one_pdc_non_adherence_code end) at_least_one_pdc_non_adherence_code_180,
             max(case when duration_days = 365 then at_least_one_pdc_non_adherence_code end) at_least_one_pdc_non_adherence_code_365,
             max(case when duration_days = 730 then at_least_one_pdc_non_adherence_code end) at_least_one_pdc_non_adherence_code_730,
             max(case when duration_days = 180 then all_pdc_score end) all_pdc_score_180,
             max(case when duration_days = 365 then all_pdc_score end) all_pdc_score_365,
             max(case when duration_days = 730 then all_pdc_score end) all_pdc_score_730,
             max(case when duration_days = 180 then all_pdc_non_adherence_code end) all_pdc_non_adherence_code_180,
             max(case when duration_days = 365 then all_pdc_non_adherence_code end) all_pdc_non_adherence_code_365,
             max(case when duration_days = 730 then all_pdc_non_adherence_code end) all_pdc_non_adherence_code_730
        from edw.d_patient_gpi_pdc
        where {% condition chain.chain_id %} CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
          and {% condition gpi_medical_condition_cross_ref.medical_condition %} medical_condition {% endcondition %}
        group by chain_id,rx_com_id,medical_condition,gpi,snapshot_date
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${medical_condition} ||'@'|| ${gpi} ||'@'|| ${snapshot_date} ;; #ERXLPS-1649
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

  dimension: gpi {
    type: string
    hidden: yes #[ERXDWPS-7824]
    label: "GPI Identifier"
    description: "Generic Product Identifier"
    sql: ${TABLE}.GPI ;;
  }

  #[ERXLPS-1942]
  dimension: medical_condition {
    type: string
    label: "Medical Condition"
    description: "Medical Condition is the Therapy Class, which is the set of GPI's that make up a drug Therapy Class for which the PDC is calculated"
    hidden: yes
    sql: ${TABLE}.MEDICAL_CONDITION ;;
  }

  dimension: at_least_one_pdc_non_adherence_code_180 {
    type: string
    group_label: "At Least One Methodology"
    label: "At Least One Medication Adherence (6 Months) Flag"
    description: "Patients' adherence status to At least One medication on the snapshot date"

    case: {
      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_180 = 'S' ;;
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
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_365 = 'S' ;;
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
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.at_least_one_pdc_non_adherence_code_730 = 'S' ;;
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
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180 ;;
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
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365 ;;
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
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730 ;;
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
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_180 = 'S' ;;
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
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_365 = 'S' ;;
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
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'I' ;;
        label: "PATIENT DEACTIVATED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'D' ;;
        label: "PATIENT DECEASED"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'R' ;;
        label: "PATIENT HAS LESS THAN 1 FILL"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'N' ;;
        label: "NO GAP"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'Y' ;;
        label: "YES - GAP EXISTS"
      }

      when: {
        sql: ${TABLE}.all_pdc_non_adherence_code_730 = 'S' ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_180 ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_365 ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_730 ;;
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
  dimension_group: pdc_measurement_begin {
    label: "PDC Measurement Begin"
    description: "First measurable day in measurement window which is either 180 (for duration 6 Months) or 365 (for duration 1 Year) or 730 (for duration 2 Years) days older from the day when PDC score is computed"
    #We are hiding this to avoid confusion and just exposed snapshot date. Measurement period will always be rolling 365 days based on snapshot date
    hidden: yes
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
    sql: ${TABLE}.PDC_MEASUREMENT_BEGIN_DATE ;;
  }

  dimension_group: pdc_measurement_end {
    label: "PDC Measurement End"
    description: "Day before the day of the ETL operation. Last measurable day"
    #We are hiding this to avoid confusion and just exposed snapshot date. Measurement period will always be rolling 365 days based on snapshot date
    hidden: yes
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
    sql: ${TABLE}.PDC_MEASUREMENT_END_DATE ;;
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
    sql: SELECT MAX(SNAPSHOT_DATE) FROM EDW.D_PATIENT_GPI_PDC ;;
  }

  #################################################################################################### filters ###############################################################################################
  dimension: at_least_one_pdc_score_180 {
    label: "PDC - At Least One (6 Months)"
    description: "PDC score for patients' medical conditions based on 'At Least One' methodology"
    type: number
    group_label: "At Least One Methodology"
    hidden: yes
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180 ;;
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
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365 ;;
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
    sql: ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730 ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_180 ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_365 ;;
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
    sql: ${TABLE}.ALL_PDC_SCORE_730 ;;
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

  measure: avg_at_least_one_pdc_score_180 {
    label: "Avg PDC - At Least One (6 Months)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 6 months"
    type: number
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180 end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_180
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
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_180) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_at_least_one_pdc_score_365 {
    label: "Avg PDC - At Least One (1 Year)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 1 year"
    type: number
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365 end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_365
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
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_365) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_at_least_one_pdc_score_730 {
    label: "Avg PDC - At Least One (2 Year)"
    description: "Average PDC score for patients' medical condition based on 'At Least 1' methodology calculated for last 2 years"
    type: number
    group_label: "At Least One Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730 end
                  else ${TABLE}.AT_LEAST_ONE_PDC_SCORE_730
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
    sql: MEDIAN(${TABLE}.AT_LEAST_ONE_PDC_SCORE_730) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_180 {
    label: "Avg PDC - All Or None (6 Months)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 6 months"
    type: number
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_180 end
                  else ${TABLE}.ALL_PDC_SCORE_180
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
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_180) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_365 {
    label: "Avg PDC - All Or None (1 Year)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 1 year"
    type: number
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_365 end
                  else ${TABLE}.ALL_PDC_SCORE_365
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
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_365) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  measure: avg_all_pdc_score_730 {
    label: "Avg PDC - All Or None (2 Years)"
    description: "Average PDC score for patients' medical condition based on 'All Or None' methodology calculated for last 2 years"
    type: number
    group_label: "All Or None Methodology"
    #Getting latest snapshot date by querieing the table directly (comes from SF metadata). This logic can be added to derived sql. But not added as we have plans to get rid of derived sql for view.
    sql: AVG(case when {% condition latest_snapshot_filter %} 'Yes' {% endcondition %}
                  then case when ${snapshot_date} = ${latest_snapshot_date} then ${TABLE}.ALL_PDC_SCORE_730 end
                  else ${TABLE}.ALL_PDC_SCORE_730
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
    sql: MEDIAN(${TABLE}.ALL_PDC_SCORE_730) ;;
    drill_fields: [patient_detail*]
    value_format: "###0.00"
  }

  ################################################################################################## End of Measures #################################################################################################
  ################################################################################################## Set for Patient detail #################################################################################################

  set: patient_detail {
    fields: [
      chain_id,
      patient.rx_com_id,
      patient.first_name,
      patient.last_name,
      patient.middle_name,
      patient.patient_age
    ]
  }

  set: pdc_candidate_list {
    fields: [
      gpi,
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

      #- at_least_one_pdc_non_adherence_code_filter
      at_least_one_pdc_score_180_filter,
      at_least_one_pdc_score_365_filter,
      at_least_one_pdc_score_730_filter,

      #- medical_condition_filter
      #- all_pdc_non_adherence_code_filter
      all_pdc_score_180_filter,
      all_pdc_score_365_filter,
      all_pdc_score_730_filter,
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
      pdc_measurement_begin,
      pdc_measurement_begin_date,
      pdc_measurement_begin_week,
      pdc_measurement_begin_month,
      pdc_measurement_begin_month_num,
      pdc_measurement_begin_year,
      pdc_measurement_begin_quarter,
      pdc_measurement_begin_quarter_of_year,
      pdc_measurement_begin_hour_of_day,
      pdc_measurement_begin_day_of_week,
      pdc_measurement_begin_day_of_month,
      pdc_measurement_begin_week_of_year,
      pdc_measurement_begin_day_of_week_index,
      pdc_measurement_end,
      pdc_measurement_end_date,
      pdc_measurement_end_week,
      pdc_measurement_end_month,
      pdc_measurement_end_month_num,
      pdc_measurement_end_year,
      pdc_measurement_end_quarter,
      pdc_measurement_end_quarter_of_year,
      pdc_measurement_end_hour_of_day,
      pdc_measurement_end_day_of_week,
      pdc_measurement_end_day_of_month,
      pdc_measurement_end_week_of_year,
      pdc_measurement_end_day_of_week_index,
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

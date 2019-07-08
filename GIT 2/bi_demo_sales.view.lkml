view: bi_demo_sales {

  sql_table_name: EDW.F_SALE ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} || '@' || nvl(${sales_tx_tp.tx_tp_id},0);;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_ID ;;
  }

  #[ERXLPS-2055] - Start
  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_drug_multi_source_reference {
    type: string
    hidden: yes
    sql: NVL(${store_drug.drug_multi_source},'Y') ;;
  }

  filter: drug_brand_generic_measures_classification_filter {
    label: "Drug Brand/Generic Measures Source \"Filter Only\""
    description: "Determines how to classify the scripts (using 'MULTI SOURCE' or 'DRUG DISPENSED') for Brand and Generic measures. For EPS stores, by default 'DRUG DISPENSED' is used to define brand and generic scripts. For EPS Stores user has an option to choose 'MULTI SOURCE' or 'DRUG DISPENSED'"
    type: string
    suggestions: ["DRUG DISPENSED", "MULTI SOURCE"]
    default_value: "DRUG DISPENSED"
  }
  #[ERXLPS-2055] - End

  dimension: financial_category {
    type: string
    label: "Financial Category"
    description: "Indicates the different type of Financial buckets such as 'Cash - Filled','T/P - Filled','Partial - Filled','Cash - Credit', 'T/P - Credit', 'Partial - Credit'"
    sql: ${TABLE}.SALE_FINANCIAL_CATEGORY ;;
  }

  dimension: adjudicated_flg {
    type: string
#     hidden: yes
    label: "Adjudicated Flag"
    description: "Y/N Flag indicating if the transaction is adjudicated/returned for reporting period selected"
    sql: CASE WHEN {% condition date_to_use_filter %} 'SOLD' {% endcondition %}
      THEN 'N' ELSE  ${TABLE}.SALE_REPORTABLE_SALES_HISTORY_FLAG END ;;
  }

  dimension: sold_flg {
    type: string
#     hidden: yes
    label: "Sold Flag"
    description: "Y/N Flag indicating if the transaction is sold/returned & picked up by patient for reporting period selected"
    sql: CASE WHEN  {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %}
      THEN 'N' ELSE ${TABLE}.SALE_SOLD_HISTORY_FLAG END ;;
  }

  dimension: after_adjudicated_flg {
    type: string
#     hidden: yes
    label: "After Adjudicated Flag"
    description: "Y/N Flag indicating if the transaction is adjudicated/returned for reporting period selected, irrespective of date filter"
    sql: CASE WHEN {% condition show_after_sold_measure_values %} 'YES' {% endcondition %} THEN ${TABLE}.SALE_AFTER_ADJUDICATED_FLAG ELSE 'N' END ;;
  }

  dimension: after_sold_flg {
    type: string
#     hidden: yes
    label: "After Sold Flag"
    description: "Y/N Flag indicating if the transaction is sold/returned & picked up by patient for reporting period selected, irrespective of date filter"
    sql: CASE WHEN {% condition show_after_sold_measure_values %} 'YES' {% endcondition %} THEN ${TABLE}.SALE_AFTER_SOLD_FLAG ELSE 'N' END  ;;
  }


  #[ERXLPS-1159] - New Dimension for DATE TO USE to use in Sales report.
  dimension: date_to_use {
    label: "DATE TO USE"
    description: "Value selected for DATE TO USE filter"
    type: string
    can_filter: no
    sql: CASE WHEN {% condition date_to_use_filter %} 'REPORTABLE SALES' {% endcondition %} THEN 'REPORTABLE SALES'
                WHEN {% condition date_to_use_filter %} 'SOLD' {% endcondition %} THEN 'SOLD'
                WHEN {% condition date_to_use_filter %} 'FILLED' {% endcondition %} THEN 'FILLED'
                WHEN {% condition date_to_use_filter %} 'RETURNED' {% endcondition %} THEN 'RETURNED'
           END;;
  }

  #[ERXLPS-1055] - Derived columns integration from prescription transaction explore.
  dimension: fill_time {
    label: "Prescription Fill Time"
    description: "Time taken to fill a prescription transaction. Calculation Used: SOLD_DATE - FILLED_DATE"
    type: number
    sql: DATEDIFF(MIN,${filled_date},${sold_date}) ;;
  }

  dimension: patient_age {
    label: "Central Patient Age at the Time of Fill"
    description: "Patient's Age based on when the transaction was filled"
    type: number
    sql: (DATEDIFF('DAY',${patient.patient_birth_date},${filled_date})/365.25) ;;
  }

  dimension: 100_percent_copay {
    label: "Prescription Paid At 100% Copay"
    description: "Yes/No flag indicating if the transaction was entirely paid at the patient copay amount"
    type: yesno
    sql: ${price} = ${final_copay} ;;
  }

  #[ERXLPS-1070] added will_call_days dimension
  dimension: will_call_days_in_bin {
    label: "Prescription Will Call Days"
    description: "Days for which will call remains in bin. Calculation Used: Sold Date - Will Call Arrival Date OR Current Date - Will Call Arrival Date OR Returned Date - Will Call Arrival Date, depends upon the status of the prescription in the workflow"
    type: number
    sql: CASE WHEN     ${will_call_arrival_date} IS NOT NULL
                   AND ${sold_date} IS NOT NULL
              THEN DATEDIFF(Day,${will_call_arrival_date},${sold_date})
              WHEN     ${will_call_arrival_date} IS NOT NULL
                   AND ${sold_date} IS NULL
                   AND ${returned_date} IS NULL
              THEN DATEDIFF(Day,${will_call_arrival_date},current_date())
              WHEN     ${will_call_arrival_date} IS NOT NULL
                   AND ${sold_date} IS  NULL
                   AND ${returned_date} IS NOT NULL
              THEN DATEDIFF(Day,${will_call_arrival_date},${returned_date})
          END ;;

    }

    dimension_group: reportable_sales {
      label: "Reportable Sales"
      description: "Used to record the Date/Time when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
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
      sql: ${TABLE}.SALE_REPORTABLE_SALES_DATE ;;
    }

    dimension_group: sold {
      label: "Sold"
      description: "Date/Time prescription was sold. This is based on the Will Call Picked Up Date in EPS"
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
      sql: ${TABLE}.SALE_WILL_CALL_PICKED_UP_DATE ;;
    }

    dimension_group: returned {
      label: "Returned"
      description: "Date/Time Credit Return on the transaction is performed"
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
      sql: ${TABLE}.SALE_RETURNED_DATE ;;
    }

    dimension_group: filled {
      label: "Filled"
      description: "Date/Time prescription was filled"
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
      sql: ${TABLE}.SALE_FILL_DATE ;;
    }

    measure: last_filled {
      label: "Last Filled Date"
      group_label: "Other Measures"
      description: "Date prescription was last filled"
      type: string
      sql: MAX(${filled_date}) ;;
    }

    dimension_group: will_call_arrival {
      label: "Will Call Arrival"
      description: "Date/time that a prescription enters Will Call"
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
      sql: ${TABLE}.SALE_WILL_CALL_ARRIVAL_DATE ;;
    }

    dimension_group: rx_tx_return_to_stock {
      label: "Return To Stock"
      description: "Date prescription was returned to stock. The returned to stock date can be populated by a (1) Sold/Picked Up Credit Return, (2) a Will Call/Not Picked Up Return to Stock, or (3) a return from the RTS Utility. This field is EPS only!!!"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_RETURN_TO_STOCK_DATE ;;
    }

    dimension_group: rx_tx_written {
      label: "Prescription Written"
      description: "Date the doctor wrote the prescription. User entered"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_WRITTEN_DATE ;;
    }

    dimension_group: rx_tx_next_refill {
      label: "Next Refill"
      description: "Date prescription can be refilled, based on the days supply. Calculation Used: Filled Date + Days Supply"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${rx_tx_next_refill_reference} ;;
    }

    dimension_group: rx_file_buy {
      label: "Prescription File Buy"
      description: "Date that identifies if a patient or script was imported into EPS as part of a file buy"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_file_buy_reference} ;;
    }

    dimension: rpt_cal_filled_date {
      hidden: yes
      sql: TO_DATE(${TABLE}.SALE_FILL_DATE) ;;
    }

    dimension: rpt_cal_sold_date {
      hidden: yes
      sql: TO_DATE(${TABLE}.SALE_WILL_CALL_PICKED_UP_DATE) ;;
    }

    dimension: rpt_cal_report_sales_date {
      hidden: yes
      sql: TO_DATE(${TABLE}.SALE_REPORTABLE_SALES_DATE) ;;
    }

    dimension: rpt_cal_returned_date {
      hidden: yes
      sql: TO_DATE(${TABLE}.SALE_RETURNED_DATE) ;;
    }

    #[ERXLPS-1055] - Date dimensions for remaining columns from F_RX_TX_LINK table. Start here...
    dimension_group: rx_tx_pos_sold {
      label: "Prescription Transaction POS Sold"
      description: "Date/Time the transaction was sold from the POS system. It is set upon the receipt of a POSSoldRequest from the POS system. This field is EPS only!!!"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_POS_SOLD_DATE ;;
    }

    dimension_group: rx_tx_custom_reported {
      label: "Prescription Transaction Custom Reported"
      description: "Date/time the record was reported on the Meijer Sales Report"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_CUSTOM_REPORTED_DATE ;;
    }

    dimension_group: rx_tx_dob_override {
      label: "Prescription Transaction DOB Override"
      description: "Date/time that the Override of the DOB was completed during DOB verification prompted at will call screen"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_DOB_OVERRIDE_TIME ;;
    }

    dimension_group: rx_tx_last_epr_synch {
      label: "Prescription Transaction Last EPR Synch"
      description: "Date/time when the EPS SYNC occurs and EPR sends a successful response"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx_tx.rx_tx_last_epr_synch_reference} ;;
    }

    dimension_group: rx_tx_missing {
      label: "Prescription Transaction Missing"
      description: "Date/time when the user reported that prescription missing"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_MISSING_DATE ;;
    }

    dimension_group: rx_tx_pc_ready {
      label: "Prescription Transaction PC Ready"
      description: "Date/time of when the prescription was marked as Patient Accepted Counseling"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_PC_READY_DATE ;;
    }

    dimension_group: rx_tx_replace {
      label: "Prescription Transaction Replace"
      description: "Date application replaced missing/stolen prescription filling"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_REPLACE_DATE ;;
    }

    dimension_group: rx_tx_central_fill_cutoff {
      label: "Prescription Transaction Central Fill Cutoff"
      description: "The cut-off date that the prescription must be transmitted to the fulfillment site by so that the prescription can be delivered by the promised date. System generated depending upon time and date of prescription"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_CENTRAL_FILL_CUTOFF_DATE ;;
    }

    dimension_group: rx_tx_drug_expiration {
      label: "Prescription Transaction Drug Expiration"
      description: "Dispensed drug's expiration date. system generated or user entered"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_DRUG_EXPIRATION_DATE ;;
    }

    dimension_group: rx_tx_drug_image_start {
      label: "Prescription Transaction Drug Image Start"
      description: "Date the drug image was added to the Medi-Span database. Medi-Span DIB"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx_tx.rx_tx_drug_image_start_reference} ;;
    }

    dimension_group: rx_tx_follow_up {
      label: "Prescription Transaction Follow Up"
      description: "Date of prescription follow-up. System Generated"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_FOLLOW_UP_DATE ;;
    }

    dimension_group: rx_tx_host_retrieval {
      label: "Prescription Transaction Host Retrieval"
      description: "Date Host retrieved the transaction record. System Generated when transaction record is retrieved"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx_tx.rx_tx_host_retrieval_reference} ;;
    }

    dimension_group: rx_tx_photo_id_birth {
      label: "Prescription Transaction Photo Identifier Birth"
      description: "Date of birth of the person dropping off or picking up the prescription. User input"
      type: time
      hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx_tx.rx_tx_photo_id_birth_reference} ;;
    }

    dimension_group: rx_tx_photo_id_expire {
      label: "Prescription Transaction Photo Identifier Expire"
      description: "The expiration date on photographic identification card, which was presented at drop off or pick up. User entered"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx_tx.rx_tx_photo_id_expire_reference} ;;
    }

    dimension_group: rx_tx_stop {
      label: "Prescription Transaction Stop"
      description: "Nursing home or institutional stop date. (The date that the patient should stop receiving medication)"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SALE_STOP_DATE ;;
    }

    dimension_group: rx_tx_source_create {
      label: "Prescription Transaction Source Create"
      description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    }
    #[ERXLPS-1055] - Date dimensions for remaining columns from F_RX_TX_LINK table. End here...
    #[ERXLPS-1055] - Date dimensions for remaining columns from F_RX table. Start here...
    dimension_group: rx_merged_to {
      label: "Prescription Merged To"
      description: "Date the patient was changed on this prescription due to a single-prescription merge"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_merged_to_reference} ;;
    }

    dimension_group: rx_autofill_enable {
      label: "Prescription Autofill Enabled"
      description: "Date/Time the prescription was set up for auto-fill. This field is EPS only!!!"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_autofill_enable_reference} ;;
    }

    dimension_group: rx_received {
      label: "Prescription Received"
      description: "Date/Time that a prescription was presented to the pharmacy for filling. Set either by the user upon receipt of the Rx (or) when a new escript Rx is received in the store (or) populated by the auto transfer response with the received date sent in the auto transfer message. This field is EPS only!!!"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_received_reference} ;;
    }

    dimension_group: rx_last_refill_reminder {
      label: "Prescription Last Refill Reminder"
      description: "Date/Time last time the prescription was triggered for a refill reminder notification"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_last_refill_reminder_reference} ;;
    }

    dimension_group: rx_short_fill_sent {
      label: "Prescription Short Fill Sent"
      description: "Date/Time used to identify when a SyncScript Short-Fill Request form was printed for the Prescription"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_short_fill_sent_reference} ;;
    }

    dimension_group: rx_chain_first_filled {
      label: "Prescription Chain First Filled"
      description: "Original first fill date used to populate SGHC and other.  System generated"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_chain_first_filled_reference} ;;
    }

    dimension_group: rx_expiration {
      label: "Prescription Expiration"
      description: "Date the prescription expires. Generated by client or entered by user"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_expiration_reference} ;;
    }

    dimension_group: rx_first_filled {
      label: "Prescription First Filled"
      description: "Original date the system filled and added the prescription to the patient's prescription profile. System generated"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_first_filled_reference} ;;
    }

    dimension_group: rx_original_written {
      label: "Prescription Original Written"
      description: "Date the physician originally wrote the prescription. User entered"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_original_written_reference} ;;
    }

    dimension_group: rx_start {
      label: "Prescription Start"
      description: "Effective Date or the Earliest Fill Date in which the pharmacy may fill a prescription. Can be set from an incoming escript record or set when Data entry is performed on the prescription"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_start_reference} ;;
    }

    dimension_group: rx_sync_script_enrollment {
      label: "Prescription Sync Script Enrollment"
      description: "Source of prescription enrollment in SyncScript program. System generated"
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_sync_script_enrollment_reference} ;;
    }

    dimension_group: rx_source_create {
      label: "Prescription Source Create"
      description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database."
      type: time
      #can_filter: no #[ERXLPS-1245] - Filter option enabled on date columns.
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
      sql: ${eps_rx.rx_source_create_reference} ;;
    }
    #[ERXLPS-1055] - Date dimensions for remaining columns from F_RX table. End here...


    dimension_group: tx_tp_transmit_queue_submission {
      label: "Transmit Queue Submission"
      description: "Date/Time a third party transmit queue record was submitted to the third party. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_submission_reference}) ;;
      view_label: "TP Transmit Queue"
    }

    dimension_group: tx_tp_transmit_queue_response {
      label: "Transmit Queue Response"
      description: "Date/Time a response for a  third party transmit queue record was received from  the third party. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_response_reference}) ;;
      view_label: "TP Transmit Queue"
    }

    dimension_group: tx_tp_transmit_queue_original_submit {
      label: "Transmit Queue Original Submit"
      description: "Date/Time a third party transmit queue record was originally submitted to the third party. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_original_submit_reference}) ;;
      view_label: "TP Transmit Queue"
    }

    dimension_group: tx_tp_transmit_queue_fill_override {
      label: "Transmit Queue Fill Override"
      description: "Fill date used when transmitting the claim. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_fill_override_reference}) ;;
      view_label: "TP Transmit Queue"
    }

    dimension_group: store_tp_link_begin {
      label: "Effective"
      description: "Date this patient third party link record become effective. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tp_link.store_tp_link_begin_reference}) ;;
      view_label: "Card"
    }

    dimension_group: store_tp_link_store_last_used {
      label: "Last Used"
      description: "Date a patient third party link record was last used. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tp_link.store_tp_link_store_last_used_reference}) ;;
      view_label: "Card"
    }

    dimension_group: store_card_deactivate {
      label: "Card Deactivate"
      description: "Date record was deactivated. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_card.store_card_deactivate_reference}) ;;
      view_label: "Card"
    }

    dimension_group: store_card_end {
      label: "Card End"
      description: "Date a card record expires. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_card.store_card_end_reference}) ;;
      view_label: "Card"
    }

    #[ERXLPS-726] - Date columns from Response Detail and Submit Detail. Start here
    dimension_group: tx_tp_response_detail_service {
      label: "Response Detail Service"
      description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_response_detail.tx_tp_response_detail_service_reference}) ;;
      view_label: "Response Detail"
    }

    dimension_group: tx_tp_submit_detail_service {
      label: "Submit Detail Service"
      description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
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
      sql: TO_DATE(${eps_tx_tp_submit_detail.tx_tp_submit_detail_service_reference}) ;;
      view_label: "Submit Detail"
    }

    dimension_group: tx_tp_submit_detail_patient_birth {
      label: "Submit Detail Patient Birth"
      description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
      type: time
      hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.
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
      sql: TO_DATE(${eps_tx_tp_submit_detail.tx_tp_submit_detail_patient_birth_reference}) ;;
      view_label: "Submit Detail"
    }

    dimension_group: tx_tp_submit_detail_workers_comp_injury {
      label: "Submit Detail Workers Comp Injury"
      description: "Date/Time the prescription was filled or professional service rendered or subsequent payer began coverage following Part A expiration in a long-term care setting only. This field is EPS only!!!"
      type: time
      hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.
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
      sql: TO_DATE(${eps_tx_tp_submit_detail.tx_tp_submit_detail_workers_comp_injury_reference}) ;;
      view_label: "Submit Detail"
    }

    #[ERXLPS-1020] - tx_tp_denial_date reference
    dimension_group: tx_tp_denial {
      label: "Claim Denial"
      description: "Date/Time a claim was denied by the third party"
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
      sql: TO_DATE(${eps_tx_tp.tx_tp_denial_reference}) ;;
      view_label: "Claim"
    }

#    #[ERXLPS-794] - Date Columns from chain_patient_summary_info
#    dimension_group: last_filled {
#      label: "Patient Last Filled"
#      description: "Date/Time prescription was last filled"
#      type: time
#      timeframes: [
#      time,
#      date,
#      week,
#      month,
#      month_num,
#      year,
#      quarter,
#      quarter_of_year,
#      hour_of_day,
#      time_of_day,
#      hour2,
#      minute15,
#      day_of_week,
#      week_of_year,
#      day_of_week_index,
#      day_of_month
#    ]
#      sql: TO_DATE(${chain_patient_summary_info.last_filled_reference}) ;;
#      view_label: "Patient"
#    }

#    dimension_group: first_fill {
#      label: "Patient First Filled"
#      description: "Date/Time prescription was first filled"
#      type: time
#      timeframes: [
#      time,
#      date,
#      week,
#      month,
#      month_num,
#      year,
#      quarter,
#      quarter_of_year,
#      yesno,
#      hour_of_day,
#      time_of_day,
#      hour2,
#      minute15,
#      day_of_week,
#      week_of_year,
#      day_of_week_index,
#      day_of_month
#    ]
#      sql: TO_DATE(${chain_patient_summary_info.first_fill_reference}) ;;
#      view_label: "Patient"
#    }

    dimension_group: patient_source_create {
      label: "Store Patient Pharmacy Add"
      description: "Date/Time patient was added to pharmacy"
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
      sql: TO_DATE(${eps_patient.patient_source_create_reference}) ;;
      view_label: "Patient - Store"
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    dimension: rx_tx_fill_quantity {
      label: "Prescription Fill Quantity"
      description: "Quantity (number of units) of the drug dispensed. (This field should only be used for grouping or filtering. Example: if you want to see Transaction Disp by Qty 30, 60, etc... )"
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') THEN ${TABLE}.SALE_FILL_QUANTITY END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
    }

    #[ERXLPS-1060] - THis dimension is not used any where,
    #dimension: rx_tx_price {
    #  label: "Sales"
    #  description: "Price of prescription for Active transactions. (This field should only be used for grouping or filtering. Example: if you want to see the price of Prescriptions Sales $25, $35, etc ... )"
    #  type: number
    #  hidden: yes
    #  sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${TABLE}.rx_tx_price END ;;
    #  value_format: "$#,##0.00;($#,##0.00)"
    #}

    dimension: rx_tx_uc_price {
      label: "Prescription U & C Price"
      description: "Usual & Customary pricing of the Prescription Transaction. (This field should only be used for grouping or filtering. Example: if you want to see U&C pricing of $50, $100,etc... )"
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${TABLE}.SALE_UC_PRICE END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXDWPS-5191] - Looker - Albertsons Dispensed Quantity dimensions / measures not using same Partial Logic as Financial Category | Start
    dimension: rx_tx_partial_fill_bill_type_reference {
      label: "Prescription Transaction Partial Fill Bill Type Reference"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE ;;
    }

    dimension: partial_fill_with_completion_flag {
      label: "Partial Fill With Active Completion Fill (Yes/No)"
      description: "Y/N Flag Indicates if an active partial fill has successful active completion fill. This is applicable only for active partial fill transactions, for other transactions it shows Not Applicable"
      type: string
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                 AND ${TABLE}.SALE_PARTIAL_FILL_STATUS = 'P'
                 AND (   (${rx_tx_partial_fill_status_reference} = 'P' and ${rx_tx_partial_fill_bill_type_reference} = 'C')
                      OR (${rx_tx_partial_fill_status_reference} = 'C' and ${rx_tx_partial_fill_bill_type_reference} = 'P')
                     )
                 AND ${TABLE}.SALE_TX_STATUS = 'Y'
                THEN CASE WHEN ${eps_rx_tx_active_completion_fill.rx_tx_id} IS NOT NULL
                          THEN 'YES'
                          WHEN ${eps_rx_tx_active_completion_fill.rx_tx_id} IS NULL
                          THEN 'NO'
                      END
                ELSE 'NOT APPLICABLE'
            END ;;
      suggestions: ["YES", "NO", "NOT APPLICABLE"]
    }
    #[ERXDWPS-5191] - Looker - Albertsons Dispensed Quantity dimensions / measures not using same Partial Logic as Financial Category | End

    #[ERXLPS-994] - Removed COALESCE to utilize this dimension in flag columns.
    dimension: rx_tx_uc_price_reference {
      hidden: yes
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${TABLE}.SALE_UC_PRICE
            END ;;
    }


    dimension: acquisition_cost {
      label: "Acquisition Cost"
      description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
      type: number
      hidden: yes
      sql: NVL(CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                    THEN ${TABLE}.SALE_ACQUISITION_COST
                END,0)  ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXDWPS-7024] Add Unit ACQ as a Dimension to Sales Explore. Updated value_format to match with EPS precision. Added logic to show -ve values for credits.
    dimension: acquisition_cost_per_unit {
      label: "Tx Acquisition Cost Per Unit"
      description: "Represents the per unit acquisition cost of filled drug used on the prescription transaction record"
      type: number
      sql: CASE WHEN ${financial_category} IN ('CASH - FILLED', 'PARTIAL - FILLED', 'T/P - FILLED')
                  THEN COALESCE(${acquisition_cost}/NULLIF(${TABLE}.SALE_FILL_QUANTITY,0) ,0)
                  WHEN ${financial_category} IN ('CASH - CREDIT', 'PARTIAL - CREDIT', 'T/P - CREDIT')
                  THEN COALESCE(${acquisition_cost}/NULLIF(${TABLE}.SALE_FILL_QUANTITY,0) ,0)*-1
            END ;;
      value_format: "$#,##0.0000000;($#,##0.0000000)"
    }

    dimension: acquisition_cost_after_sold {
      label: "Acquisition Cost After Sold"
      description: "Represents the total acquisition cost(after Sold) of filled drug used on the prescription transaction record"
      type: number
      hidden: yes
      sql: NVL(CASE WHEN ${after_adjudicated_flg} = 'Y' AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1 THEN ${TABLE}.SALE_ACQUISITION_COST END,0)  ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: overridden_price_amount {
      label: "Prescription Overridden Price Amount"
      description: "Original Prescription price amount before the price override was performed"
      type: number
      hidden: yes
      sql: NVL(CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                        THEN ${TABLE}.SALE_OVERRIDDEN_PRICE_AMOUNT
                  END,0)  ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: net_sales {
      label: "Net Sales"
      description: "Net Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: number
      hidden: yes
      sql: CASE WHEN    (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                           AND ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','PARTIAL - FILLED', 'PARTIAL - CREDIT')
                           AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                      THEN (${TABLE}.SALE_PRICE - ${TABLE}.SALE_DISCOUNT_AMOUNT)
                      WHEN     (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                           AND ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                      THEN ((${sales_tx_tp.net_due} + ${final_copay}) - ${sales_tx_tp.final_tax})
                  END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXLPS-2337]
    #[ERXDWPS-1639] - Updated net_sales_filter to use tx_net_sales dimension instead of net_sales. Net sales filter should consider tx net sales value to filter the records.
    filter: net_sales_filter {
      label: "Net Sales \"Filter Only\""
      description: "Net Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: number
      sql: {% condition net_sales_filter %} ${tx_net_sales} {% endcondition %} ;;
    }

    #[ERXDWPS-1639] - New dimension added for transaction level net sales.
    dimension: tx_net_sales {
      label: "Net Sales at TX Level"
      description: "Net Sales of prescription Transaction. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: number
      hidden: yes
      sql: CASE WHEN    (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                              AND ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','PARTIAL - FILLED', 'PARTIAL - CREDIT')
                              AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                          THEN (${TABLE}.SALE_PRICE - nvl(${TABLE}.SALE_DISCOUNT_AMOUNT,0))
                          WHEN    (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                              AND ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                          THEN ${sales_tx_tp.tx_net_sales}
                      END
                        ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: net_sales_after_sold {
      label: "Net Sales After Sold"
      description: "Net Sales of prescription after sold. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net T/P Due + Final Copay After Sold - Tax)"
      type: number
      hidden: yes
      sql: CASE WHEN     ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','PARTIAL - FILLED', 'PARTIAL - CREDIT')
                                 AND ${after_sold_flg} = 'Y'
                                 AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                            THEN (${TABLE}.SALE_PRICE - ${TABLE}.SALE_DISCOUNT_AMOUNT)
                            WHEN ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                            THEN CASE WHEN ${after_adjudicated_flg} = 'Y'
                                      THEN ${sales_tx_tp.net_due} - ${sales_tx_tp.final_tax}
                                      ELSE 0
                                  END +
                                 CASE WHEN ${after_sold_flg} = 'Y'
                                      THEN ${final_copay}
                                      ELSE 0
                                  END
                   END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: price {
      label: "Price"
      description: "Total Price of prescription"
      type: number
      #hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                THEN CASE WHEN {% condition sales_rxtx_payor_summary_detail_analysis %} 'SUMMARY' {% endcondition %} AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1 THEN ${TABLE}.SALE_PRICE
                          WHEN {% condition sales_rxtx_payor_summary_detail_analysis %} 'DETAIL' {% endcondition %}
                          THEN CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                                    THEN ${TABLE}.SALE_PRICE
                                    WHEN ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                                    THEN ${sales_tx_tp.final_price}
                                END
                      END
                 ELSE 0
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: price_after_sold {
      label: "Price After Sold"
      description: "Total Price of prescription after Sold"
      type: number
      hidden: yes
      sql: CASE WHEN {% condition sales_rxtx_payor_summary_detail_analysis %} 'SUMMARY' {% endcondition %} AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1 THEN ${TABLE}.SALE_PRICE
                WHEN {% condition sales_rxtx_payor_summary_detail_analysis %} 'DETAIL' {% endcondition %}
                THEN CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                          THEN ${TABLE}.SALE_PRICE
                          WHEN ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                          THEN ${sales_tx_tp.final_price}
                      END
            END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: gross_margin {
      label: "Gross Margin"
      description: "Gross Margin of prescription. Calculation Used: Price of the Prescription - Acquisition Cost"
      type: number
      hidden: yes
      #[ERXLPS-2512] - Removed SUMMARY/DETAIL check. Same logic for SUMMARY/DETAIL and display gross margin only for Primary payer.
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN (${TABLE}.SALE_PRICE - ${TABLE}.SALE_ACQUISITION_COST)
                ELSE 0
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXLPS-1433]
    filter: gross_margin_filter {
      label: "Gross Margin $ \"Filter Only\""
      description: "Gross Margin of prescription. Calculation Used: Price of the Prescription - Acquisition Cost"
      type: number
      sql: {% condition gross_margin_filter %} ${gross_margin} {% endcondition %} ;;
    }

    dimension: gross_margin_after_sold {
      label: "Gross Margin After Sold"
      description: "Gross Margin of prescription after sold. Calculation Used: Price of the Prescription After Sold - Acquisition Cost After Sold"
      type: number
      hidden: yes
      sql: CASE WHEN ${sold_flg} = 'Y' THEN ${gross_margin} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: final_copay {
      label: "Final Copay"
      group_label: "Claim"
      description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
      type: number
      hidden: yes
      sql: CASE WHEN {% condition sales_rxtx_payor_summary_detail_analysis %} 'SUMMARY' {% endcondition %}
                          OR (     {% condition sales_rxtx_payor_summary_detail_analysis %} 'DETAIL' {% endcondition %}
                              AND ${financial_category} IN ('CASH - CREDIT','CASH - FILLED')
                             )
                        THEN ${sales_tx_tp.last_counter_final_copay}
                        ELSE ${sales_tx_tp.final_copay}
                   END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: count_adjusted_reference {
      label: "Adjusted Scripts"
      description: "Total script volume based on adjustment done on Days Supply (i.e. when Days Supply >= 84, the script count is increased by 3 for each script)"
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                             THEN ${TABLE}.SALE_SCRIPT_COUNT
                           + COALESCE((CASE WHEN abs(${TABLE}.SALE_DAYS_SUPPLY) >= 84
                                            THEN ${TABLE}.SALE_SCRIPT_COUNT
                                            END * 2),0)
                   END   ;;
      value_format: "#,##0;(#,##0)"
    }

    dimension: count_reference {
      label: "Scripts"
      description: "Total script volume without any adjustment"
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                        THEN ${TABLE}.SALE_SCRIPT_COUNT
                    END   ;;
      value_format: "#,##0;(#,##0)"
    }

    dimension: count_reference_after_sold {
      label: "Scripts After Sold"
      description: "Total script(After Sold) volume without any adjustment"
      type: number
      hidden: yes
      #[ERXLPS-1499] - Corrected logic to exclude CASH Scripts with NULL SOLD Date.
      sql: CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','PARTIAL - FILLED', 'PARTIAL - CREDIT') AND ${after_sold_flg} = 'Y' AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${TABLE}.SALE_SCRIPT_COUNT
                WHEN ${financial_category} IN ('T/P - CREDIT','T/P - FILLED') AND (${after_adjudicated_flg} = 'Y' or ${after_sold_flg} = 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${TABLE}.SALE_SCRIPT_COUNT
           END ;;
      value_format: "#,##0;(#,##0)"
    }

    dimension: file_buy_flag {
      label: "Prescription File Buy"
      description: "Y/N Flag Indicating if a prescription/transaction came via File Buy"
      type: yesno
      sql: (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${rx_file_buy_date} IS NOT NULL AND ${filled_time} <= ${eps_rx.rx_file_buy_date_time} ;;
    }

    #[ERXLPS-994] Removed NVL transformation from the below 3 flag columns. Added financial_category check for rx-Tx_uc_price_reference as price and net_sales alerady have that check.
    dimension: uc_price_equals_price_flag {
      label: "U&C Price equals Price (Yes/No)"
      description: "Yes/No Flag indicating if the U&C Price is equal to the Price of the transaction"
      type: string
      sql: CASE WHEN ${TABLE}.SALE_UC_PRICE = ${price} THEN 'Yes'
        WHEN ${TABLE}.SALE_UC_PRICE != ${price} THEN 'No' END  ;;
      suggestions: ["Yes","No"]
    }

    dimension: uc_price_equals_net_sales_flag {
      label: "U&C Price equals Net Sales (Yes/No)"
      description: "Yes/No Flag indicating if the U&C Price is equal to the Net Sales of the transaction"
      type: string
      sql: CASE WHEN ${TABLE}.SALE_UC_PRICE = ${net_sales} THEN 'Yes'
        WHEN ${TABLE}.SALE_UC_PRICE != ${net_sales} THEN 'No' END  ;;
      suggestions: ["Yes","No"]
    }

    #[ERXLPS-1929] - Add new comparision dimension for uc price and net sales
    dimension: uc_price_greater_than_net_sales {
      label: "U&C Price greater than Net Sales (Yes/No)"
      description: "Yes/No Flag indicating if the U&C Price is greater than the Net Sales of the transaction"
      type: string
      sql: CASE WHEN ${TABLE}.SALE_UC_PRICE > ${net_sales} THEN 'Yes'
        WHEN ${TABLE}.SALE_UC_PRICE <= ${net_sales} THEN 'No' END  ;;
      suggestions: ["Yes","No"]
    }

    dimension: transmit_queue_submit_equals_received_price_flag {
      label: "Transmit Queue Submit equals Received Price (Yes/No)"
      view_label: "TP Transmit Queue"
      description: "Yes/No Flag indicating if Transmit Queue submit price equals to received price"
      type: string
      sql: CASE WHEN ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_submit_price_reference} = ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_received_price_reference} THEN 'Yes'
        WHEN ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_submit_price_reference} <> ${eps_tx_tp_transmit_queue.tx_tp_transmit_queue_received_price_reference} THEN 'No' END;;
      suggestions: ["Yes","No"]
    }

    #[ERXLPS-934] - Store_plan_plan_type_reference dimension created in eps_plan to reference in cash_bill_flag dimension. This is required as currently SF doesn't support sub-queires in where clause. Once SF fixes SF#8384 bug, Store_plan_plan_type_reference can be replaced with store_plan_plan_type.
    dimension: cash_bill_flag {
      label: "Cash Bill (Yes/No)"
      description: "Yes/No Flag indicating if a prescription transaction is CASH FILLED/CASH PLAN"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_TP_BILL = 'Y' or ${eps_plan.store_plan_plan_type_reference} = '8' ;;
          label: "Yes"
        }

        when: {
          sql: true ;;
          label: "No"
        }
      }
    }

    #[ERXLPS-2017]
    dimension: script_type {
      label: "Script Type"
      description: "Indicates if the script is adjusted script (Days Supply >= 84) or unadjusted script (Days Supply < 84)"
      type: string
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND abs(${TABLE}.SALE_DAYS_SUPPLY) >= 84 THEN 'Adjusted Script' ELSE 'Unadjusted Script'  END ;;
      suggestions: ["Adjusted Script","Unadjusted Script"]
    }

#[ERXLPS-1560] dimension is added to find out if the transaction is auto filled enable during fill time.

    dimension: transaction_autoFilled_flag {
      label: "Transaction Autofilled"
      description: "Yes/No flag indicating if this transaction has autofill enabled at the time of fill"
      type: yesno
      sql: ${TABLE}.SALE_REFILL_SOURCE = '2' ;; #[ERXLPS-1807]
    }

    measure: avg_acquisition_cost {
      label: "Avg Acquisition Cost"
      group_label: "Acquisition Cost"
      description: "Average acquisition cost of filled drug. Calculation Used: Acquisition Cost/Total no. of scripts"
      type: number
      sql: COALESCE(${sum_acquisition_cost}/NULLIF(${count},0),0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_acquisition_cost {
      label: "Acquisition Cost"
      group_label: "Acquisition Cost"
      type: sum
      description: "Represents the total acquisition cost, for this year, of the filled drug used on the prescription transaction record"
      sql: ${acquisition_cost}  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_price {
      label: "Price"
      group_label: "Price"
      description: "Total price of prescription"
      type: sum
      sql: ${price} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_price_brand {
      label: "Brand Price *"
      group_label: "Other Price"
      description: "Total Brand Price of prescription. For EPS Stores, by default brand price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${price} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_price_generic {
      label: "Generic Price *"
      group_label: "Other Price"
      description: "Total Generic Price of prescription. For EPS Stores, by default generic price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${price} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_price_compound {
      label: "Compound Price"
      group_label: "Other Price"
      description: "Total Compound Price of prescription"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_DRUG_DISPENSED = 'C' THEN ${price} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_price_tp {
      label: "T/P Price"
      group_label: "Other Price"
      description: "Total T/P Price of prescription"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'Y' THEN ${price} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_price_cash {
      label: "Cash Price"
      group_label: "Other Price"
      description: "Total Cash Price of prescription"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'N' THEN ${price} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_price_after_sold {
      label: "Price After Sold"
      group_label: "Price After Sold"
      description: "Total Price of prescription after Sold"
      type: sum
      hidden: yes #[ERXLPS-1454] - hiding RNAC and Price After Sold measures in Sales explore.
      sql: CASE WHEN  (${after_adjudicated_flg} = 'Y' or ${after_sold_flg} = 'Y') THEN ${price_after_sold} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_cash_price_after_sold {
      label: "Cash Price After Sold"
      group_label: "Price After Sold"
      description: "Total Cash Price of prescription after Sold"
      type: sum
      sql: CASE WHEN   ${after_sold_flg} = 'Y' AND ${TABLE}.SALE_TP_BILL = 'N' THEN ${price_after_sold} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tp_price_after_sold {
      label: "T/P Price After Sold"
      group_label: "Price After Sold"
      description: "Total T/P Price of prescription after Sold"
      type: sum
      hidden: yes #[ERXLPS-1454] - hiding RNAC and Price After Sold measures in Sales explore.
      sql: CASE WHEN  ${after_adjudicated_flg} = 'Y'  AND ${TABLE}.SALE_TP_BILL = 'Y' THEN ${price_after_sold} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_price {
      label: "Avg Price (per script)"
      group_label: "Average Price (per script)"
      description: "Average Price of prescription. Calculation Used: Total Price of the Prescription/Total no. of scripts"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg price for credit return scripts.
      sql: COALESCE(${sum_price}/(CASE WHEN NULLIF(${count},0) < 0 THEN ABS(NULLIF(${count},0)) ELSE NULLIF(${count},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_gross_margin {
      label: "Gross Margin"
      group_label: "Gross Margin"
      description: "Gross Margin of prescription. Calculation Used: Price of the Prescription - Acquisition Cost"
      type: sum
      sql: ${gross_margin} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_gross_margin_after_sold {
      label: "Gross Margin After Sold"
      group_label: "Gross Margin"
      description: "Gross Margin of prescription after sold. Calculation Used: Price of the Prescription - Acquisition Cost"
      type: sum
      hidden: yes
      sql: ${gross_margin_after_sold} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_gross_margin {
      label: "Avg Gross Margin"
      group_label: "Gross Margin"
      description: "Average Gross Margin of prescription. Calculation Used: (Total Price of the Prescription - Total Acquisition Cost)/Total no. of scripts"
      type: number
      sql: ${sum_gross_margin}/NULLIF(${count},0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_gross_margin_pct {
      label: "Gross Margin %"
      group_label: "Gross Margin"
      description: "Gross Margin % of prescription. Calculation Used: (Price of the Prescription - Acquisition Cost)/Price of the Prescription"
      type: number
      sql: ${sum_gross_margin}/NULLIF(${sum_price},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_discount {
      label: "Discount"
      group_label: "Discount"
      description: "Total Discount of prescription"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                        THEN  ${TABLE}.SALE_DISCOUNT_AMOUNT
                    END   ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tax {
      label: "Tax"
      group_label: "Tax"
      description: "Total Tax of prescription. For Cash transaction: tax is directly reported using the information present in transaction table. For TP transaction tax is reported using the information final tax information present in the  claim table"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
                        THEN CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED')
                                  THEN ${TABLE}.SALE_TAX_AMOUNT
                                  WHEN ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
                                  THEN ${sales_tx_tp.final_tax}
                              END
                    END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales {
      label: "Net Sales"
      group_label: "Net Sales"
      description: "Total Net Sales of prescription. Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax"
      type: sum
      sql: ${net_sales} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_net_sales_brand {
      label: "Net Brand Sales *"
      group_label: "Net Brand Sales"
      description: "Net Brand Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax). For EPS Stores, by default net brand sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${net_sales} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${net_sales}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${net_sales}
          END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }


    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_net_sales_generic {
      label: "Net Generic Sales *"
      group_label: "Net Generic Sales"
      description: "Net Generic Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax). For EPS Stores, by default net generic sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                      THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${net_sales} END
                      WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
                      THEN ${net_sales}
                      WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
                      THEN ${net_sales}
                 END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales_compound {
      label: "Net Compound Sales"
      group_label: "Net Compound Sales"
      description: "Net Compound Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_DRUG_DISPENSED = 'C' THEN ${net_sales} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales_tp {
      label: "Net T/P Sales"
      group_label: "Net T/P Sales"
      description: "Net T/P Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'Y' THEN ${net_sales} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales_cash {
      label: "Net Cash Sales"
      group_label: "Net Cash Sales"
      description: "Net Cash Sales of prescription. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'N' THEN ${net_sales} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales_after_sold {
      label: "Net Sales After Sold"
      group_label: "Net Sales After Sold"
      description: "Total Net Sales of prescription after sold. (Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net T/P Due + Final Copay After Sold - Tax)"
      type: sum
      sql: ${net_sales_after_sold} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_net_sales {
      label: "Avg Net Sales (per script)"
      group_label: "Average Net Sales (per script)"
      description: "Average Net Sales of prescription. Calculation Used: Total Net Sales of the Prescription/Total no. of scripts"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales}/(CASE WHEN NULLIF(${count},0) < 0 THEN ABS(NULLIF(${count},0)) ELSE NULLIF(${count},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }
    measure: avg_net_sales_brand {
      label: "Avg Net Brand Sales (per script) *"
      group_label: "Average Net Brand Sales (per script)"
      description: "Average Net Brand Sales of prescription. Calculation Used: Total Net Brand Sales of the Prescription/Total no. of brand scripts. For EPS Stores, by default net brand sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales_brand}/(CASE WHEN NULLIF(${count_brand},0) < 0 THEN ABS(NULLIF(${count_brand},0)) ELSE NULLIF(${count_brand},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: avg_net_sales_generic {
      label: "Avg Net Generic Sales (per script) *"
      group_label: "Average Net Generic Sales (per script)"
      description: "Average Net Generic Sales of prescription. Calculation Used: Average Net Generic Sales of the Prescription/Total no. of generic scripts. For EPS Stores, by default net generic sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales_generic}/(CASE WHEN NULLIF(${count_generic},0) < 0 THEN ABS(NULLIF(${count_generic},0)) ELSE NULLIF(${count_generic},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }


    measure: avg_net_sales_after_sold {
      label: "Avg Net Sales After Sold (per script)"
      group_label: "Average Net Sales After Sold (per script)"
      description: "Average Net Sales of prescription. Calculation Used: Net Sales of the Prescription After Sold/Total no. of scripts"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales_after_sold}/(CASE WHEN NULLIF(${count_after_sold},0) < 0 THEN ABS(NULLIF(${count_after_sold},0)) ELSE NULLIF(${count_after_sold},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    #[ERXDWPS-5132]
    measure: net_sales_per_unit {
      label: "Net Sales (per unit of fill qty)"
      description: "Net Sales of prescription per unit of fill quantity. This does not account for transactions with partial fills. Calculation Used: Net Sales/Prescription Fill Quantity"
      group_label: "Net Sales"
      type:  number
      sql: COALESCE(${sum_net_sales}/NULLIF(ABS(${sum_sales_rx_tx_fill_quantity}),0) ,0) ;;
      value_format: "$#,##0.0000;($#,##0.0000)"
      html: {% if value < 0 %}
                          <font color="red">{{ rendered_value }}
                        {% else %}
                          <font color="grey">{{ rendered_value }}
                        {% endif %}
                        ;;
    }

    #[ERXLPS-1433]
    dimension: net_gross_margin {
      label: "Net Margin $"
      hidden:  yes #used in templated filter
      group_label: "Net Margin $"
      description: "Net Margin of prescription, based on Net Sales. Calculation Used: Net Sales of the Prescription - Acquisition Cost"
      type: number
      sql: ${net_sales} -  ${acquisition_cost} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1433]
    filter: net_gross_margin_filter {
      label: "Net Margin $ \"Filter Only\""
      description: "Net Margin of prescription, based on Net Sales. Calculation Used: Net Sales of the Prescription - Acquisition Cost"
      type: number
      sql: {% condition net_gross_margin_filter %} ${net_gross_margin} {% endcondition %} ;;
    }

    measure: sum_net_gross_margin {
      label: "Net Margin $"
      group_label: "Net Margin $"
      description: "Net Margin of prescription, based on Net Sales. Calculation Used: Net Sales of the Prescription - Acquisition Cost"
      type: sum
      sql: ${net_gross_margin} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-6290] - Avg Net Margin measure added.
    measure: avg_net_gross_margin {
      label: "Avg Net Margin $"
      group_label: "Average Net Margin"
      description: "Average Net Margin of prescription, based on Net Sales. Calculation Used: Net Margin/Total no. of scripts."
      type: number
      sql: COALESCE(${sum_net_gross_margin}/NULLIF(${count},0),0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
      html: {% if value < 0 %}
                  <font color="red">{{ rendered_value }}
                  {% else %}
                  <font color="grey">{{ rendered_value }}
                  {% endif %}
                  ;;
    }

    measure: sum_net_gross_margin_after_sold {
      label: "RNAC $"
      group_label: "RNAC $"
      description: "Net Margin of prescription, based on Net Sales After Sold. Calculation Used: Net Sales After Sold - Acquisition Cost After Sold"
      type: sum
      hidden: yes #[ERXLPS-1454] - hiding RNAC and Price After Sold measures in Sales explore.
      sql: ( ${net_sales_after_sold} -  ${acquisition_cost_after_sold} )  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-2690] - Renamed avg_net_gross_margin to avg_net_gross_margin_after_sold.
    measure: avg_net_gross_margin_after_sold {
      label: "Avg Net Margin After Sold"
      group_label: "Other Measures"
      hidden: yes
      description: "Net Margin of prescription, based on Net Sales after sold. Calculation Used: (Net Sales After Sold - Acquisition Cost After Sold)/Total no. of scripts"
      type: number
      sql: ${sum_net_gross_margin_after_sold}/NULLIF(${count},0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_net_gross_margin_pct {
      label: "Net Margin %"
      group_label: "Net Margin %"
      description: "Net % Margin of prescription, based on Net Sales. Calculation Used: ( (Net Sales of the Prescription - Acquisition Cost)/Net Sales of the Prescription )"
      type: number
      sql: CAST((${sum_net_sales} -  ${sum_acquisition_cost}) AS DECIMAL(17,4))/NULLIF(${sum_net_sales},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_acquisition_cost_after_sold_ty {
      label: "Acquisition Cost After Sold"
      group_label: "Acquisition Cost After Sold"
      description: "Represents the total acquisition cost after sold, for this year, of the filled drug used on the prescription transaction record"
      type: sum
      hidden: yes
      sql: ${acquisition_cost_after_sold} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_after_sold_pct {
      label: "RNAC %"
      group_label: "RNAC %"
      description: "Net % Margin of prescription, based on Net Sales After Sold. Calculation Used: ( (Net Sales of the Prescription - Acquisition Cost)/Net Sales of the Prescription )"
      type: number
      hidden: yes #[ERXLPS-1454] - hiding RNAC and Price After Sold measures in Sales explore.
      sql: CAST((${sum_net_sales_after_sold} -  ${sum_acquisition_cost_after_sold_ty}) AS DECIMAL(17,4))/NULLIF(${sum_net_sales_after_sold},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_write_off {
      label: "Write Off Amount"
      group_label: "Claim"
      description: "Difference between the submitted amount and the received balance plus the patient copay"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') THEN ${sales_tx_tp.write_off} END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_due {
      label: "Balance Due from TP"
      group_label: "Claim"
      description: "Amount owed by a third party"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') THEN ${sales_tx_tp.net_due} END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_final_copay {
      label: "Final Copay"
      group_label: "Claim"
      description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${final_copay} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_final_copay_after_sold {
      label: "Final Copay After Sold"
      group_label: "Claim"
      description: "Final transaction third party patient copay. If the copay is overridden, this is the new amount as stated by the user. The third party copay is then populated"
      type: sum
      sql: CASE WHEN  ${after_sold_flg} = 'Y' THEN ${final_copay} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-876] - Modified label name from Copay Overridden Amount to Copay Override Amount
    measure: copay_override_amount {
      label: "Copay Override Amount"
      group_label: "Claim"
      description: "Copay Override Amount. Calculation Used: Final Copay - Overridden Copay Amount of TP"
      type: sum
      sql: CASE WHEN  (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') THEN ${sales_tx_tp.copay_override_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-876] - Copay Overridden Script measures
    measure: count_copay_overridden_scripts{
      label: "Copay Overridden Scripts"
      group_label: "Claim"
      description: "Total script (Copay Overridden) volume without any adjustment"
      type: sum
      sql:  CASE WHEN  ${sales_tx_tp.copay_override_flag} = 'Yes' THEN ${count_reference} END;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-876] - copay_overridden_amount measures
    measure: copay_overridden_amount {
      label: "Copay Overridden Amount (PRIOR TO OVERRIDE)"
      group_label: "Claim"
      description: "Total original copay amount, which is populated if the user overrides the copay with a new amount"
      type: sum
      sql: CASE WHEN  (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${sales_tx_tp.copay_override_flag} = 'Yes' THEN ${sales_tx_tp.copay_overridden_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    ## [ERXLPS-1028] Copay Overridden Scripts % of ALL scripts Measures , to keep consitent with other override measures
    measure: count_overridden_scripts_pcnt {
      label: "Copay Overridden Scripts %"
      group_label: "Claim"
      description: "The Copay Overridden Scripts percentage of ALL scripts"
      type: number
      sql: COALESCE(CAST((${count_copay_overridden_scripts}) AS DECIMAL(17,4))/NULLIF(${count},0), 0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1028] - New Custom Copay Override Amount Measures that work with the "Custom Copay Override Filter (Carrier Code)"
    measure: custom_copay_override_amount {
      label: "Custom Copay Override Amount *"
      group_label: "Claim"
      description: "The amount of the override. Calculation Used: Final Copay - Overridden Copay Amount of TP (Carrier Code input from the Custom Copay filter determines what transactions are considered)"
      type: sum
      sql: CASE WHEN  (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND (CASE WHEN {% parameter custom_copay_override_filter %} = '' THEN 1 = 1 ELSE {% condition custom_copay_override_filter %} ${eps_plan.store_plan_carrier_code} {% endcondition %} END) THEN ${sales_tx_tp.copay_override_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1028] - New Custom Copay Overridden Scripts Measures that work with the "Custom Copay Override Filter (Carrier Code)"
    measure: custom_count_copay_overridden_scripts{
      label: "Custom Copay Overridden Scripts *"
      group_label: "Claim"
      description: "Total script (Copay Overridden) volume without any adjustment (Carrier Code input from the Custom Copay filter determines what transactions are considered)"
      type: sum
      sql:  CASE WHEN  ${sales_tx_tp.copay_override_flag} = 'Yes' AND (CASE WHEN {% parameter custom_copay_override_filter %} = '' THEN 1 = 1 ELSE {% condition custom_copay_override_filter %} ${eps_plan.store_plan_carrier_code} {% endcondition %} END) THEN ${count_reference} END;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1028] - New Custom Copay Overridden Amount Measures that work with the "Custom Copay Override Filter (Carrier Code)"
    measure: custom_copay_overridden_amount {
      label: "Custom Copay Overridden Amount (PRIOR to Override) *"
      group_label: "Claim"
      description: "The original copay amount before the copay override was performed (Carrier Code input from the Custom Copay filter determines what transactions are considered)"
      type: sum
      sql: CASE WHEN  (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${sales_tx_tp.copay_override_flag} = 'Yes' AND (CASE WHEN {% parameter custom_copay_override_filter %} = '' THEN 1 = 1 ELSE {% condition custom_copay_override_filter %} ${eps_plan.store_plan_carrier_code} {% endcondition %} END) THEN ${sales_tx_tp.copay_overridden_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    ## [ERXLPS-1028] New Custom Copay Overridden Scripts % of ALL scripts Measures that work with the "Custom Copay Override Filter (Carrier Code)"
    measure: custom_count_overridden_scripts_pcnt {
      label: "Custom Copay Overridden Scripts % *"
      group_label: "Claim"
      description: "The Copay Overridden Scripts percentage of ALL scripts (Carrier Code input from the Custom Copay filter determines what transactions are considered)"
      type: number
      sql: COALESCE(CAST((${custom_count_copay_overridden_scripts}) AS DECIMAL(17,4))/NULLIF(${count},0), 0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

#################################################################################

    measure: count_after_sold {
      label: "Scripts After Sold"
      group_label: "Scripts"
      description: "Total script(after sold) volume without any adjustment"
      hidden: yes
      type: sum
      sql: ${count_reference_after_sold} ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count {
      label: "Scripts"
      group_label: "Scripts"
      description: "Total script volume without any adjustment"
      type: sum
      sql: ${count_reference} ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_adjusted {
      label: "Adjusted Scripts"
      group_label: "Adjusted Scripts"
      description: "Total script volume based on adjustment done on Days Supply i.e. when Days Supply >= 84, the script count is increased by 3 for each script"
      type: sum
      sql: ${count_adjusted_reference} ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_new {
      label: "New Scripts"
      group_label: "Other Scripts"
      description: "Total New script volume without any adjustment"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_FILL_STATUS = 'N' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_new_pct {
      label: "New Scripts %"
      group_label: "Other Scripts"
      description: "Percentage of the New Scripts in comparison to the Total Unadjusted Scripts"
      type: number
      sql: CAST((${count_new}) AS DECIMAL (17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_refill {
      label: "Refill Scripts"
      group_label: "Other Scripts"
      description: "Total Refill script volume without any adjustment"
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_FILL_STATUS = 'R' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_refill_pct {
      label: "Refill Scripts %"
      group_label: "Other Scripts"
      description: "Percentage of the Refill Scripts in comparison to the Total Unadjusted Scripts"
      type: number
      sql: cast((${count_refill}) as decimal(17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_cash {
      label: "Cash Scripts"
      group_label: "Other Scripts"
      description: "Total Cash script volume without any adjustment"
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_TP_BILL = 'N' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_cash_pct {
      label: "Cash Scripts %"
      group_label: "Other Scripts"
      description: "Percentage of the Cash Scripts in comparison to the Total Unadjusted Scripts"
      type: number
      sql: CAST((${count_cash}) AS DECIMAL (17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_tp {
      label: "T/P Scripts"
      group_label: "Other Scripts"
      description: "Total T/P script volume without any adjustment"
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_TP_BILL = 'Y' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_tp_pct {
      label: "T/P Scripts %"
      group_label: "Other Scripts"
      description: "Percentage of the T/P Scripts in comparison to the Total Unadjusted Scripts"
      type: number
      sql: CAST((${count_tp}) AS DECIMAL (17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-2055] - Update logic to use MULTI SOURCE/DRUG DISPENSED based on filter value.
    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: count_brand {
      label: "Brand Scripts *"
      group_label: "Other Scripts"
      description: "Total Brand script volume without any adjustment. For EPS Stores, by default Brand scripts is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${count_reference} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${count_reference}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${count_reference}
                END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_brand_pct {
      label: "Brand Scripts % *"
      group_label: "Other Scripts"
      description: "Percentage of the Brand Scripts in comparison to the Total Unadjusted Scripts. For EPS Stores, by default Brand scripts is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: CAST((${count_brand}) AS DECIMAL (17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: count_generic {
      label: "Generic Scripts *"
      group_label: "Other Scripts"
      description: "Total Generic script volume without any adjustment. For EPS Stores, by default Generic scripts is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                    THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${count_reference} END
                    WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
                    THEN ${count_reference}
                    WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
                    THEN ${count_reference}
               END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_generic_pct {
      label: "Generic Scripts % *"
      group_label: "Other Scripts"
      description: "Percentage of the Generic Scripts in comparison to the Total Unadjusted Scripts. For EPS Stores, by default Generic scripts is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: CAST((${count_generic}) AS DECIMAL(17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }
# [ERX-3509] - Added these generic scripts measures which will be used in corresponding budget generic script variance measures computation [end]

    measure: count_compound {
      label: "Compound Scripts"
      group_label: "Other Scripts"
      description: "Total Compound script volume without any adjustment"
      type: sum
      sql: CASE WHEN  ${TABLE}.SALE_DRUG_DISPENSED = 'C' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_compound_pct {
      label: "Compound Scripts %"
      group_label: "Other Scripts"
      description: "Percentage of the Compound Scripts in comparison to the Total Unadjusted Scripts"
      type: number
      sql: CAST((${count_compound}) AS DECIMAL (17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1231] - New measures added for Non-partial Script count
    measure: count_non_parital {
      label: "Scripts (No Partials)"
      group_label: "Other Scripts"
      description: "Total script volume without partial fill status as PARTIAL"
      type: sum
      sql: COALESCE(CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','T/P - CREDIT','T/P - FILLED') THEN ${count_reference} END,0) ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: return_to_stock_count {
      label: "Return to Stock Count*"
      group_label: "Return to Stock"
      description: "The number of scripts returned to stock. Return to Stock date is used to calculate the number of scripts returned to stock. This measure should be used with DATE TO USE as FILLED. Increase REPORT Period duration to broader range (Ex: 1 year or 2 year) to include all the possible transactions."
      type: sum
      sql: CASE WHEN ${financial_category} IN ('CASH - CREDIT','T/P - CREDIT','PARTIAL - CREDIT') AND ${return_to_stock_yesno} = 'Yes' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: return_to_stock_sales {
      label: "Return to Stock Sales*"
      group_label: "Return to Stock"
      description: "The total sales or the original prescription price of scripts which are returned to stock. Return to Stock date is used to calculate the sales of scripts returned to stock. This measure should be used with DATE TO USE as FILLED. Increase REPORT Period duration to broader range (Ex: 1 year or 2 year) to include all the possible transactions."
      type: sum
      sql: CASE WHEN  (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT','T/P - CREDIT','PARTIAL - CREDIT') AND ${return_to_stock_yesno} = 'Yes' AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1 THEN ${TABLE}.SALE_PRICE END  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1023] - New average measures added for adjusted scripts
    measure: avg_net_sales_adjusted_scripts {
      label: "Avg Net Sales (Per Adjusted Script)"
      group_label: "Avg Net Sales (Per Adjusted Script)"
      description: "Average Net Sales of adjusted prescription. Calculation Used: Total Net Sales of Adjusted Prescription/Total no. of adjusted scripts"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales}/(CASE WHEN NULLIF(${count_adjusted},0) < 0 THEN ABS(NULLIF(${count_adjusted},0)) ELSE NULLIF(${count_adjusted},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_net_sales_specialty {
      label: "Net Specialty Sales"
      group_label: "Specialty Sales"
      description: "Net Specialty Sales of prescription.(Calculation Used: For Cash: Net Sales = Price - Discount, For TP: Net Sales = Net Due + Final Copay - Tax)"
      type: sum
      sql: CASE WHEN  ${store_drug.drug_specialty} = 'Y' THEN ${net_sales} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_sales_specialty_pct {
      label: "Net Specialty Sales %"
      group_label: "Specialty Sales"
      description: "The Specialty Prescription Net Sales Percentage of Total Prescription Net Sales.(Calculation Used: Total Net Specialty Sales / Total Net Sales)"
      type: number
      sql: CAST((${sum_net_sales_specialty}) AS DECIMAL(17,4))/NULLIF(${sum_net_sales},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_specialty {
      label: "Specialty Scripts"
      group_label: "Specialty Scripts"
      description: "Total Specialty script volume without any adjustment"
      type: sum
      sql: CASE WHEN  ${store_drug.drug_specialty} = 'Y' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_specialty_pct {
      label: "Specialty Scripts %"
      group_label: "Specialty Scripts"
      description: "Specialty Scripts percentage of total scripts, without any adjustment.(Calculation Used: Specialty Scripts/Total Scripts)"
      type: number
      sql: CAST((${count_specialty}) AS DECIMAL(17,4))/NULLIF(${count},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_specialty_gross_margin {
      label: "Net Specialty Margin $"
      group_label: "Specialty Margin"
      description: "Net Specialty Margin of prescription, based on Net Sales.(Calculation Used: Net Sales of the Prescription - Acquisition Cost)"
      type: sum
      sql: CASE WHEN   ${store_drug.drug_specialty} = 'Y' THEN ${net_sales} -  ${acquisition_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_net_sales_specialty {
      label: "Avg Net Specialty Sales (per script)"
      group_label: "Specialty Sales"
      description: "Average Net Specialty Sales, per prescription.(Calculation Used: Total Net Specialty Sales / Total number of Specialty scripts)"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg net sales for credit return scripts.
      sql: COALESCE(${sum_net_sales_specialty}/(CASE WHEN NULLIF(${count_specialty},0) < 0 THEN ABS(NULLIF(${count_specialty},0)) ELSE NULLIF(${count_specialty},0) END) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_cash_margin {
      label: "Cash Margin $"
      group_label: "Margin $"
      description: "Cash Margin of prescription. Calculation Used: Cash Price of the Prescription - Acquisition Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'N' THEN ${price} - ${acquisition_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_cash_margin_pct {
      label: "Cash Gross Margin %"
      group_label: "Other Margin %"
      description: "Cash Margin % of prescription. Calculation Used: (Cash Price of the Prescription - Acquisition Cost)/Cash Price of the Prescription"
      type: number
      sql: ${sum_cash_margin}/NULLIF(${sum_price_cash},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tp_margin {
      label: "T/P Margin $"
      group_label: "Margin $"
      description: "Third Party Margin of prescription. Calculation Used: Third Party Price of the Prescription - Acquisition Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'Y' THEN ${price} - ${acquisition_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tp_margin_pct {
      label: "T/P Gross Margin %"
      group_label: "Other Margin %"
      description: "Third Party Margin % of prescription. Calculation Used: (Third Party Price of the Prescription - Acquisition Cost)/Third Party Price of the Prescription"
      type: number
      sql: ${sum_tp_margin}/NULLIF(${sum_price_tp},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_generic_margin {
      label: "Generic Margin $"
      group_label: "Margin $"
      description: "Generic Margin of prescription. Calculation Used: Generic Price of the Prescription - Acquisition Cost. For EPS Stores, by default generic price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${price} - ${acquisition_cost} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price} - ${acquisition_cost}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price} - ${acquisition_cost}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_generic_margin_pct {
      label: "Generic Gross Margin % *"
      group_label: "Other Margin %"
      description: "Generic Margin % of prescription. Calculation Used: (Generic Price of the Prescription - Acquisition Cost)/Generic Price of the Prescription.  For EPS Stores, by default generic price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_generic_margin}/NULLIF(${sum_price_generic},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-2055] - Logic update to calculate measures using MULTI SOURCE /DRUG DISPENSED
    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    measure: sum_brand_margin {
      label: "Brand Margin $"
      group_label: "Margin $"
      description: "Brand Margin of prescription. Calculation Used: Brand Price of the Prescription - Acquisition Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${price} - ${acquisition_cost} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price} - ${acquisition_cost}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price} - ${acquisition_cost}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_brnad_margin_pct {
      label: "Brand Gross Margin % *"
      group_label: "Other Margin %"
      description: "Brand Margin % of prescription. Calculation Used: (Brand Price of the Prescription - Acquisition Cost)/Brand Price of the Prescription. For EPS Stores, by default brand price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_brand_margin}/NULLIF(${sum_price_brand},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-2055] - Adding Brand Net Margin % and Generic Net Margin %
    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    dimension: net_gross_margin_brand_reference {
      label: "Brand Net Gross Margin $"
      description: "Brand Net Margin of prescription, based on brand Net Sales. Calculation Used: Brand Net Sales of the Prescription - Acquisition Cost. For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
              THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${net_sales} - ${acquisition_cost} END
              WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
              THEN ${net_sales} - ${acquisition_cost}
              WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
              THEN ${net_sales} - ${acquisition_cost}
         END ;;
    }
    #ERXDWPS-5130 exposed as part of this US
    measure: sum_net_gross_margin_brand {
      label: "Brand Net Margin $ *"
      group_label: "Margin $"
      description: "Brand Net Margin of prescription, based on Brand Net Sales. Calculation Used: Brand Net Sales of the Prescription - Acquisition Cost. For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: ${net_gross_margin_brand_reference} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_brand_pct {
      label: "Brand Net Margin % *"
      group_label: "Other Margin %"
      description: "Brand Net % Margin of prescription, based on Brand Net Sales. Calculation Used: ( (Brand Net Sales of the Prescription - Acquisition Cost)/Brand Net Sales of the Prescription ). For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_net_gross_margin_brand}/NULLIF(${sum_net_sales_brand},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5671] - Corrected source_system_id value for Classic logic.
    dimension: net_gross_margin_generic_reference {
      label: "Generic Net Gross Margin $"
      description: "Generic Net Margin of prescription, based on Generic Net Sales. Calculation Used: Generic Net Sales of the Prescription - Acquisition Cost. For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
              THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${net_sales} - ${acquisition_cost} END
              WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
              THEN ${net_sales} - ${acquisition_cost}
              WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
              THEN ${net_sales} - ${acquisition_cost}
             END ;;
    }
    #ERXDWPS-5130 exposed as part of this US
    measure: sum_net_gross_margin_generic {
      label: "Generic Net Margin $ *"
      group_label: "Margin $"
      description: "Generic Net Margin of prescription, based on Generic Net Sales. Calculation Used: Generic Net Sales of the Prescription - Acquisition Cost. For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: ${net_gross_margin_generic_reference} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_generic_pct {
      label: "Generic Net Margin % *"
      group_label: "Other Margin %"
      description: "Generic Net % Margin of prescription, based on Generic Net Sales. Calculation Used: ( (Generic Net Sales of the Prescription - Acquisition Cost)/Generic Net Sales of the Prescription ). For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_net_gross_margin_generic}/NULLIF(${sum_net_sales_generic},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_rx_tx_price_override {
      label: "Price Overridden Cash Scripts"
      group_label: "Price Override"
      description: "Total number of cash prescriptions that an override was performed on the price amount"
      type: sum
      sql: CASE WHEN  ${rx_tx_price_override_yesno} = 'YES' AND ${TABLE}.SALE_TP_BILL = 'N' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_rx_tx_price_override_pcnt {
      label: "Price Overridden Cash Scripts %"
      group_label: "Price Override"
      description: "The Overridden Cash Scripts percentage of ALL scripts. Overriden Scripts had an override performed on the price amount"
      type: number
      sql: COALESCE(CAST((${count_rx_tx_price_override}) AS DECIMAL(17,4))/NULLIF(${count},0), 0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-876] - New measures for Price Overridden added here. Start...
    measure: count_rx_tx_price_override_cash_tp {
      label: "Price Overridden Scripts"
      group_label: "Price Override"
      description: "Total number of scripts that an override was performed on the price amount"
      type: sum
      sql: CASE WHEN  ${rx_tx_price_override_yesno} = 'YES' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: count_rx_tx_price_override_cash_tp_pcnt {
      label: "Price Overridden Scripts %"
      group_label: "Price Override"
      description: "The Overridden Scripts percentage of ALL scripts. Overriden Scripts had an override performed on the price amount"
      type: number
      sql: COALESCE(CAST((${count_rx_tx_price_override_cash_tp}) AS DECIMAL(17,4))/NULLIF(${count},0), 0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_rx_tx_overridden_price_amount_cash_tp {
      label: "Total Prescription Overridden Price Amount"
      group_label: "Price Override"
      description: "The total original prescription price amount of cash and third party transactions before the price override was performed"
      type: sum
      sql: CASE WHEN  ${rx_tx_price_override_yesno} = 'YES' THEN ${overridden_price_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_rx_tx_overridden_price_amount_cash_tp {
      label: "Avg Prescription Overridden Price Amount"
      group_label: "Price Override"
      description: "The average original prescription price amount of cash and third party transactions before the price override was performed. Calculation Used: Total Prescription Overridden Price Amount/Price Overridden Scripts"
      type: number
      sql: COALESCE(${sum_rx_tx_overridden_price_amount_cash_tp} / NULLIF(${count_rx_tx_price_override_cash_tp}, 0), 0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }
    #[ERXLPS-876] - New measures for Price Overridden added here. End...

    measure: sum_rx_tx_overridden_price_amount {
      label: "Total Cash Prescription Overridden Price Amount"
      group_label: "Price Override"
      description: "The total original Cash Prescription price amount before the price override was performed"
      type: sum
      sql: CASE WHEN  ${rx_tx_price_override_yesno} = 'YES' AND ${TABLE}.SALE_TP_BILL = 'N' THEN ${overridden_price_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    ## [ERXLPS-1028] Adding Override Amount (Amount that was discounted) measures to be consistent with other override measures
    measure: sum_rx_tx_cash_override_price_amount {
      label: "Total Cash Prescription Override Price Amount"
      group_label: "Price Override"
      description: "The amount of the cash override (Calculation Used: Cash Price - Total Cash Prescription Overridden Price Amount)."
      type: sum
      sql: CASE WHEN  ${rx_tx_price_override_yesno} = 'YES' AND ${TABLE}.SALE_TP_BILL = 'N' THEN ${price} - ${overridden_price_amount} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_rx_tx_overridden_price_amount {
      label: "Avg Cash Prescription Overridden Price Amount"
      group_label: "Price Override"
      description: "The average original Cash Prescription price amount before the price override was performed. Calculation Used: Total Cash Prescription Overridden Price Amount/Price Overridden Cash Scripts"
      type: number
      sql: COALESCE(${sum_rx_tx_overridden_price_amount} / NULLIF(${count_rx_tx_price_override}, 0), 0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_rx_tx_uc_price {
      label: "Total Prescription U&C Price"
      group_label: "Other Price"
      description: "The Total Usual & Customary pricing of the Prescription Transaction"
      type: sum
      sql: ${rx_tx_uc_price_reference} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1994]
    measure: sum_net_sales_vs_uc_price_variance {
      label: "Net Sales vs. U&C Price Variance $"
      description: "Total Dollar Increase/Decrease of Net Sales compared with U&C Price of the transaction. Calculation = Net Sales - Total Prescription U&C Price"
      type: number
      sql: ${sum_net_sales} - ${sum_rx_tx_uc_price} ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_net_sales_vs_uc_price_variance_pct {
      label: "Net Sales vs. U&C Price Variance %"
      description: "Total Percentage Increase/Decrease of Net Sales compared with U&C price of the transaction. Calculation = Net Sales - Total Prescription U&C Price / Total Prescription U&C Price"
      type: number
      sql: CAST((${sum_net_sales} - ${sum_rx_tx_uc_price}) AS DECIMAL(17,4))/NULLIF(ABS(${sum_rx_tx_uc_price}),0) ;; #[ERXLPS-2105] - Added ABS function in denominator to produce correct results for -ve values.
      value_format: "00.00%"
    }

    ## [ERXLPS-1028] Updating Expected Revenue to include new override measures
    ## NOTE: The description of the "Expected Revenue After Sold w/o Override" measures state that we are adding to Net Sales, but the logic shows that we are subtracting. This is purposeful. It is because the Override measures have negative values when
    ##          we should add, so to "ADD" the values a negative value must be used to cancel the two negatives and "ADD" the value to Net Sales
    measure: sum_expected_revenue {
      label: "Expected Revenue After Sold w/o Override"
      group_label: "Price Override"
      description: "The Expected Revenue that would be collected if no Override was performed. (Calculation Used: Net Sales After Sold + Copay Override Amount + Cash Price Override Amount)"
      type: number
      sql:  (${sum_net_sales_after_sold} - ${copay_override_amount} - ${sum_rx_tx_cash_override_price_amount}) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_lost_revenue {
      label: "Expected Revenue After Sold Override Sales Variance $"
      group_label: "Price Override"
      description: "The Revenue difference between the Expected Revenue if no override is performed, and Net Sales After Sold. (Calculation Used: Expected Revenue - Net Sales After Sold)."
      type: number
      sql: (${sum_net_sales_after_sold} - ${sum_expected_revenue})   ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_lost_revenue_pcnt {
      label: "Expected Revenue After Sold Override Sales Variance %"
      group_label: "Price Override"
      description: "Percentage Increase/Decrease of the total Expected Revenue if no override is performed, compared to Net Sales After Sold"
      type: number
      sql: COALESCE(CAST((${sum_lost_revenue}) AS DECIMAL(17,4))/NULLIF(ABS(${sum_expected_revenue}),0), 0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_compound_ingredient_tx_quantity_used {
      label: "Total Compound Ingredient Tx Quantity Used"
      description: "Total Amount of ingredient used to make the compound"
      type: sum_distinct
      sql_distinct_key: ${store_compound_ingredient_tx.chain_id} ||'@'|| ${store_compound_ingredient_tx.nhin_store_id} ||'@'|| ${store_compound_ingredient_tx.compound_ingredient_tx_id} ;; #ERXLPS-1649
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${store_compound_ingredient_tx.compound_ingredient_tx_quantity_used} END ;;
      value_format: "#,##0.00"
    }

    measure: sum_compound_ingredient_tx_base_cost {
      label: "Total Compound Ingredient Tx Base Cost"
      description: "The total base cost of this ingredient for this transaction at the time it was priced"
      type: sum_distinct
      sql_distinct_key: ${store_compound_ingredient_tx.chain_id} ||'@'|| ${store_compound_ingredient_tx.nhin_store_id} ||'@'|| ${store_compound_ingredient_tx.compound_ingredient_tx_id} ;; #ERXLPS-1649
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${store_compound_ingredient_tx.compound_ingredient_tx_base_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_compound_ingredient_tx_acquisition_cost {
      label: "Total Compound Ingredient Tx Acquisition Cost"
      description: "The ACQ cost of this ingredient for this transaction at the time it was priced"
      type: sum_distinct
      sql_distinct_key: ${store_compound_ingredient_tx.chain_id} ||'@'|| ${store_compound_ingredient_tx.nhin_store_id} ||'@'|| ${store_compound_ingredient_tx.compound_ingredient_tx_id} ;; #ERXLPS-1649
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')  THEN ${store_compound_ingredient_tx.compound_ingredient_tx_acquisition_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: count_transfer_pct {
      type: number
      label: "Transfer Script %"
      description: "Percentage of the Transfer Scripts in comparison to the Total Unadjusted Scripts"
      sql: ${sales_rx_tx_transfer.count_transfer}/NULLIF(${count},0) ;;
      value_format: "00.00%"
    }

    filter: history_filter {
      label: "HISTORY"
      description: "Includes both the sale and credit transaction for qualified transactions that have been cancelled or credit returned, when 'YES' is selected and default filter for this explore is set to show HISTORY. When 'NO' is selected, the report will only show the current information for the transaction"
      type: string
      suggestions: ["YES", "NO"]
      full_suggestions: yes
    }

    filter: sales_rxtx_payor_summary_detail_analysis {
      label: "SUMMARY/DETAIL"
      description: "When SUMMARY is selected, the 'Net Sales' and 'Final Copay' would be based on the prescription price and copay of the final payor. If DETAIL is selected, the 'Net Sales' and 'Final Copay' would be based on the TP Final Price and copay of each individual payor, unless the cash transaction would have a $0 copay from TP. Use 'DETAIL' as the filter when analyzing the transaction numbers and carriers, all added to the same line item"
      type: string
      suggestions: ["SUMMARY", "DETAIL"]
      full_suggestions: yes
    }

    filter: date_to_use_filter {
      label: "DATE TO USE"
      description: "The DATE TO USE field determines what DATE FIELD is used to aggregate data, based on the time window specified. When using HISTORY = YES, REPORTABLE SALES and SOLD will also return results if the RETURNED date falls in the time window specified. FILLED and RETURNED only work with HISTORY = NO."
      type: string
      suggestions: ["REPORTABLE SALES", "SOLD", "FILLED", "RETURNED"]
      bypass_suggest_restrictions: yes
    }

    #[ERXLPS-895] - New filter added to restrict after sold transactions
    filter: show_after_sold_measure_values {
      label: "SHOW AFTER SOLD MEASURE VALUES"
      description: "Show actual values for 'After Sold ***' measures when 'YES' is chosen as the filter value. Displays 0 against all 'After Sold ***' measures when 'NO' is chosen. Default value is NO"
      suggestions: ["YES", "NO"]
    }

    filter: report_period_filter {
      label: "REPORT PERIOD"
      description: "Starting and ending dates for the range of records you want to include"
      type: date
      sql:        ((     {% parameter history_filter %} = 'YES'
                   and {% condition report_period_filter %} ${sale_activity_date} {% endcondition %}
                   and ${sale_current_state_flg} = 'N'
                   and (case when {% parameter date_to_use_filter %} = 'REPORTABLE SALES' then 1
                             when {% parameter date_to_use_filter %} = 'SOLD' then 1
                             when {% parameter date_to_use_filter %} = 'FILLED' then 2
                             when {% parameter date_to_use_filter %} = 'RETURNED' then 2
                             end
                        ) = 1
                   and (   (   {% condition show_after_sold_measure_values %} 'NO' {% endcondition %}
                            and (case when {% parameter date_to_use_filter %} = 'REPORTABLE SALES' then ${adjudicated_flg_from_table}
                                      when {% parameter date_to_use_filter %} = 'SOLD' then ${sold_flg_from_table}
                                  end
                                ) = 'Y'
                           )
                         or (    {% condition show_after_sold_measure_values %} 'YES' {% endcondition %}
                            )

                       )
                  )
                  or
                  (    {% parameter history_filter %} = 'NO'
                   and ${sale_current_state_flg} = 'Y'
                   and {% condition report_period_filter %}  (case when {% parameter date_to_use_filter %} = 'REPORTABLE SALES' then ${rpt_cal_report_sales_date}
                                                                       when {% parameter date_to_use_filter %} = 'SOLD' then ${rpt_cal_sold_date}
                                                                       when {% parameter date_to_use_filter %} = 'FILLED' then ${rpt_cal_filled_date}
                                                                       when {% parameter date_to_use_filter %} = 'RETURNED' then ${rpt_cal_returned_date}
                                                                   end
                                                                 ) {% endcondition %}
                  )) ;;
    }


    #[ERXLPS-1028] - New filter to utilize Custom Copay Override Measures
    filter: custom_copay_override_filter {
      label: "Custom Copay Override Filter (Carrier Code) *"
      description: "Enter the Carrier Code. For Example 'CPLAN'. Input from this filter is used in the 'Custom Copay Override' measures. If filter is not used, or if the filter is NULL, all Carrier codes will be considered"
      #suggestions: ["FPPP"]
    }

    #[ERXLPS-2231] - Suggestions and default values are not required.
    filter: cash_plan_carrier_codes_filter {
      label: "Cash Plan Carrier Codes \"Filter Only\""
      description: "This filter is the required input for the 'Cash or Cash Plans (Yes/No)' dimension; which is a Yes/No Flag that evaluates transactions based on whether they are Cash transactions, or a Cash Plan (TP) transactions. Input required is the Carrier Code."
      type: string
    }

    dimension: cash_or_cash_plan {
      label: "Cash or Cash Plan (Yes/No) *"
      description: "Yes/No Flag indicating if the transaction was a Cash transaction, or a Cash TP Plan transaction. The Cash TP Plan transactions are determined based on the Carrier codes that are input in the 'Cash Plan Carrier Codes Filter Only' field. If no Carrier Code's were entered in the Cash Plan Filter Only field; i.e. it is Null, only Cash transactions will be evaluated in the dimension."
      type: string
      sql: CASE WHEN ${financial_category} IN ('CASH - CREDIT','CASH - FILLED') THEN 'Yes'
                  WHEN {% condition cash_plan_carrier_codes_filter %} ${eps_plan.store_plan_carrier_code} {% endcondition %} THEN 'Yes'
                  ELSE 'No' END ;;
    }

    #[ERXLPS-1152] - Include "Scripts Converted" Yes/No Dimension in Sales Explore
    dimension_group: conversion_service_run {
      label: "Conversion Service Run"
      description: "Used to record the date when a pharmacy is converted from a previous pharmacy system to EPS. This flag does not work with DATE TO USE of FILLED."
      type: time
      can_filter: no
      timeframes: [time]
      sql: to_timestamp(${store_setting_conversionservice_run_date.store_setting_value}, 'mm/dd/yy hh24:mi:ss') ;;
    }

    #[ERXLPS-1152] - Include "Scripts Converted" Yes/No Dimension in Sales Explore
    dimension: scripts_converted {
      label: "Scripts Converted"
      description: "Yes/No flag indicating if the script has a reportable sales date before the pharmacy was converted from a previous pharmacy system to EPS"
      type: yesno
      sql: ${rx_tx_reportable_sales_reference} < to_timestamp(${store_setting_conversionservice_run_date.store_setting_value}, 'mm/dd/yy hh24:mi:ss') ;;
    }
################################################################# new sale related dimensions and measures ######################################################

    dimension_group: sale_activity {
      type: time
      timeframes: [date]
      hidden: yes
      sql: ${TABLE}.SALE_ACTIVITY_DATE ;;
    }

    dimension: sale_event_type {
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_EVENT_TYPE ;;
    }

    dimension: sale_current_state_flg {
      type: string
#     hidden: yes
      label: "Current State Flag"
      description: "Y/N Flag indicating if the transaction is Current State"
      sql: ${TABLE}.SALE_CURRENT_STATE_FLAG ;;
    }

    dimension: sale_drug_dispensed_id {
      label: "Prescription Transaction Drug ID"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_DISPENSED_ID ;;
    }

    dimension: return_to_stock_yesno {
      label: "Prescription Transaction Return to Stock"
      description: " Yes/No field indicating if the transaction made it to 'Will Call' after PV was completed, then are credit returned/cancelled"
      type: yesno
      sql: ${rx_tx_return_to_stock_date} IS NOT NULL ;;
    }

    dimension: adjudicated_flg_from_table {
      type: string
      hidden: yes
      label: "Adjudicated Flag From Table"
      description: "Y/N Flag indicating if the transaction is adjudicated/returned for reporting period selected"
      sql: ${TABLE}.SALE_REPORTABLE_SALES_HISTORY_FLAG ;;
    }

    dimension: sold_flg_from_table {
      type: string
      hidden: yes
      label: "Sold Flag From Table"
      description: "Y/N Flag indicating if the transaction is sold/returned & picked up by patient for reporting period selected"
      sql: ${TABLE}.SALE_SOLD_HISTORY_FLAG ;;
    }

##################################################################### dimensions and measures added from sales_eps_rx_tx_fiscal view file into sales_fiscal_view file ###########################################################################

    dimension: rx_tx_basecost_id {
      label: "Prescription Basecost ID"
      description: "Unique ID number identifying an Basecost record within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_BASECOST_ID ;;
    }

    dimension: rx_tx_completion_rx_tx_id {
      label: "Prescription Transaction Completion Fill ID"
      description: "Unique Prescription Transaction ID number identifying an completion fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_COMPLETION_RX_TX_ID ;;
    }

    dimension: rx_tx_partial_rx_tx_id {
      label: "Prescription Transaction Partial Fill ID"
      description: "Unique Prescription Transaction ID number of the partial fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_PARTIAL_RX_TX_ID ;;
    }

    dimension: rx_tx_compound_id {
      label: "Prescription Transaction Compound ID"
      description: "Unique ID that links this record to a specific COMPOUND record, if this prescription is filled for a compound within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_COMPOUND_ID ;;
    }

    dimension: rx_tx_discount_id {
      label: "Prescription Transaction Discount ID"
      description: "Unique ID of the Discount Code that was used during pricing this transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_DISCOUNT_ID ;;
    }

    dimension: rx_tx_drug_brand_id {
      label: "Prescription Transanction Drug Brand ID"
      description: "Unique ID that links this record to a specific DRUG record, which identifies the Brand drug selected for this transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_BRAND_ID ;;
    }

    dimension: rx_tx_drug_generic_id {
      label: "Prescription Transanction Drug Generic ID"
      description: "Unique ID that links this record to a specific DRUG record, which identifies the Generic drug selected for this transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_GENERIC_ID ;;
    }

    dimension: rx_tx_reference_brand_id {
      label: "Prescription Transaction Reference Brand ID"
      description: "Unique ID of the brand drug record used when Brand % Pricing is used to price the transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_REFERENCE_BRAND_ID ;;
    }

    # used to join store drug table
    dimension: rx_tx_drug_id {
      label: "Prescription Transaction Drug ID"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_DISPENSED_ID ;;
    }

# [ERX-2586] created this dimension for join with Hist tables
    dimension: rx_tx_drug_id_hist {
      label: "Prescription Transaction Drug ID"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_DISPENSED_ID ;;
    }

    dimension: rx_tx_drug_cost_type_id {
      label: "Prescription Transaction Drug Cost Type ID"
      description: "Unique ID that links this transaction to a specific DRUG COST TYPE  record within a pharmacy chain.  This is the Cost Base that pricing used to price this transaction"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_DRUG_COST_TYPE_ID ;;
    }

    dimension: rx_tx_tax_id {
      label: "Prescription Transaction Tax ID"
      description: "Unique ID that links this record to a specific TAX record within a pharmacy chain"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_TAX_ID ;;
    }

    dimension: rx_tx_returned_user_id {
      label: "Prescription Transaction Returned User ID"
      description: "Unique ID that links this record to the specific USER record, indicating the user who performed a credit return on this transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_RETURNED_USER_ID ;;
    }

    #[ERXDWPS-6203] - Exposing the dimension in Sales Explore. This dimensions will be used to merge results between different explore to get USER information.
    #[ERXDWPS-6203] - Modified type to string to utilize the dimension for merge results with store_user.user_id dimension. Merge can be performed only when the dimensions type is same.
    #[ERXDWPS-6203] - Using SALE_OVERRIDE_USER_ID in joins will still consider database column type which is number.
    dimension: rx_tx_override_user_id {
      label: "Prescription Transaction Override User ID"
      description: "Unique ID that links this record to the specific USER record, indicating the person who performed a price override on this transaction within a pharmacy chain"
      type: string
      sql: ${TABLE}.SALE_OVERRIDE_USER_ID ;;
    }

    dimension: rx_tx_price_code_id {
      label: "Prescription Transaction Price Code ID"
      description: "Unique ID number identifying an prescription record within a pharmacy chain"
      type: string
      hidden: yes
      sql: ${TABLE}.PRICE_CODE_ID ;;
    }

    dimension: rx_tx_ltc_facility_id {
      label: "Prescription Transaction LTC Facility ID"
      description: "Unique ID number identifying the Long Term Care Facility that the patient was assigned to at the time of the transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_LTC_FACILITY_ID ;;
    }

    dimension: rx_tx_price_override_note_id {
      label: "Prescription Transaction Override Notes ID"
      description: "Unique ID that links this transaction to a specific NOTE record, textually describing the reason that the user chose to override the price of this transaction within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_PRICE_OVERRIDE_NOTE_ID ;;
    }

    dimension: rx_tx_rph_counsel_notes_id {
      label: "Prescription Transaction Counsel Notes ID"
      description: "Unique ID that identifies notes that were saved from the Tools --> Pharmacist Counsel screen. Used to document any additional notes during the required counseling of a patient within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SALE_RPH_COUNSEL_NOTES_ID ;;
    }

    dimension: shipment_id {
      label: "Prescription Transaction Shipment ID"
      description: "Unique ID indicating the ID of the Shipment (from the Shipment table) that the Prescription was included in within a pharmacy chain"
      type: number
      hidden: yes
      sql: ${TABLE}.SHIPMENT_ID ;;
    }

    dimension: rx_tx_patient_disease_id {
      label: "Prescription Transaction Patient Disease ID"
      description: "Unique ID that links this record to a specific PATIENT DISEASE record for this transanction within a pharmacy chain"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_PATIENT_DISEASE_ID ;;
    }

    dimension: rx_tx_sup_presc_clinic_link_id {
      label: "Prescription Transaction Supervising Prescriber Clinic Link ID"
      description: "Unique ID that links this record to a specific PRESCRIBER CLINIC LINK record, which identifies the Supervising Prescriber for this transaction within a pharmacy chain"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_SUPERVISOR_PRESCRIBER_CLINIC_LINK_ID ;;
    }

    dimension: rx_tx_presc_clinic_link_id {
      label: "Prescription Transaction Clinic Link ID"
      description: "Unique ID that links this record to a specific PRESCRIBER_CLINIC_LINK record, which identifies the Prescriber for this transaction for this transaction within a pharmacy chain"
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_PRESCRIBER_CLINIC_LINK_ID ;;
    }

    #[ERXLPS-743] Dimensions referenced in other views. Currently referenced in sales view.
    dimension: rx_tx_tx_status_reference {
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_TX_STATUS ;;
    }

    dimension: rx_tx_partial_fill_status_reference {
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_PARTIAL_FILL_STATUS ;;
    }

    ################################################################################################# End of Foreign Key References #####################################################################################
    ########################################################################################################## Dimensions ##############################################################################################

    dimension: rx_tx_tx_number {
      label: "Prescription TX Number"
      description: "Transaction number"
      type: number
      sql: ${TABLE}.SALE_TX_NUMBER ;;
      value_format: "######"
    }

    dimension: rx_tx_refill_number {
      label: "Prescription Refill Number"
      description: "Refill number of the transaction"
      type: number
      sql: ${TABLE}.SALE_REFILL_NUMBER ;;
      value_format: "#,##0"
    }

    dimension: rx_tx_counseling_rph_initials {
      label: "Prescription Counseling Rph Initials"
      description: "Pharmacist of Record initials on POS system"
      type: string
      sql: ${TABLE}.SALE_COUNSELING_RPH_INITIALS ;;
    }

    dimension: rx_tx_ddid_used_by_drug_selection {
      label: "Prescription DDID Used By Drug Selection"
      description: "DDID used by automatic drug selection for a particular fill"
      type: number
      sql: ${TABLE}.SALE_DDID_USED_BY_DRUG_SELECTION ;;
      value_format: "######"
    }

    dimension: rx_tx_de_initials {
      label: "Prescription DE Initials"
      description: "Initials of the user who performed Data Entry on this transaction"
      type: string
      sql: ${TABLE}.SALE_DE_INITIALS ;;
    }

    dimension: rx_tx_dob_override_reason_id {
      label: "Prescription DOB Override Reason ID"
      description: "ID for the reason of the Override of the DOB during DOB verification prompted at will call screen"
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_DOB_OVERRIDE_REASON_ID ;;
    }

    dimension: rx_tx_dv_initials {
      label: "Prescription DV Initials"
      description: "Initials of the user who performed Data Verification on this transaction"
      type: string
      sql: ${TABLE}.SALE_DV_INITIALS ;;
    }

    dimension: rx_tx_gpi_used_by_drug_selection {
      label: "Prescription GPI Used By Drug Selection"
      description: "Prescribed Drug GPI used by automatic drug selection for a particular fill"
      type: string
      sql: ${TABLE}.SALE_GPI_USED_BY_DRUG_SELECTION ;;
    }

    dimension: rx_tx_pos_invoice_number {
      label: "Prescription POS Invoice Number"
      description: "The invoice number from the POS system"
      type: number
      sql: ${TABLE}.SALE_POS_INVOICE_NUMBER ;;
      value_format: "######"
    }

    ###################################################################################################End of Dimensions ################################################################################################

    ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################
    dimension: rx_tx_active {
      label: "Prescription Transaction Active"
      description: "Yes/No Flag indicating if the transaction is active"
      type: yesno
      sql: NVL(${TABLE}.SALE_TX_STATUS,'Y') = 'Y' AND  DECODE(${TABLE}.SALE_RETURNED_DATE,NULL,SALE_ACQUISITION_COST,0) IS NOT NULL AND ${TABLE}.SALE_FILL_STATUS IS NOT NULL AND ${TABLE}.SALE_FILL_QUANTITY IS NOT NULL AND DECODE(${TABLE}.SALE_RETURNED_DATE,NULL,SALE_PRICE,NVL(${TABLE}.SALE_ORIGINAL_PRICE,0)) IS NOT NULL ;;
    }

    dimension: rx_tx_tx_status {
      label: "Prescription Transaction Status"
      description: "Status of the Transaction. Normal, Cancelled, Credit Returned, Hold, and Replacement"
      type: string

      case: {
        when: {
          sql: NVL(${TABLE}.SALE_TX_STATUS,'Y') = 'Y' ;;
          label: "NORMAL"
        }

        when: {
          sql: ${TABLE}.SALE_TX_STATUS = 'N' ;;
          label: "CANCELLED"
        }

        when: {
          sql: ${TABLE}.SALE_TX_STATUS = 'C' ;;
          label: "CREDIT RETURNED"
        }

        when: {
          sql: ${TABLE}.SALE_TX_STATUS = 'H' ;;
          label: "HOLD"
        }

        when: {
          sql: ${TABLE}.SALE_TX_STATUS = 'R' ;;
          label: "REPLACEMENT"
        }
      }
    }

    dimension: rx_tx_fill_status {
      label: "Prescription Fill Status"
      description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_FILL_STATUS = 'N' ;;
          label: "NEW PRESCRIPTION"
        }

        when: {
          sql: ${TABLE}.SALE_FILL_STATUS = 'R' ;;
          label: "REFILL"
        }

        when: {
          sql: ${TABLE}.SALE_FILL_STATUS = 'F' ;;
          label: "NON FILLED COGNITIVE"
        }

        when: {
          sql: true ;;
          label: "NOT SPECIFIED"
        }
      }
    }

    dimension: rx_tx_drug_dispensed {
      label: "Prescription Drug Dispensed"
      description: "Indicates the type of drug dispensed. Brand, Generic, Compound. This field is derived from either automated or manual drug selection."
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_DRUG_DISPENSED = 'B' ;;
          label: "BRAND"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_DISPENSED = 'G' ;;
          label: "GENERIC"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_DISPENSED = 'C' ;;
          label: "COMPOUND"
        }

        when: {
          sql: true ;;
          label: "NOT SPECIFIED"
        }
      }
    }

    dimension: rx_tx_admin_rebilled {
      label: "Prescription Admin Rebilled"
      description: "Yes/No flag indicating if the prescription has been admin rebilled"
      type: yesno
      sql: ${TABLE}.SALE_ADMIN_REBILLED = 'Y' ;;
    }

    dimension: rx_tx_allow_price_override {
      label: "Prescription Allow Price Override"
      description: "Yes/No flag indicating if a price override can be performed on this transaction"
      type: yesno
      sql: NVL(${TABLE}.SALE_ALLOW_PRICE_OVERRIDE,'Y') = 'Y' ;;
    }

    dimension: rx_tx_brand_manually_selected {
      label: "Precription Brand Manually Selected"
      description: "Yes/No flag indicating if the Brand drug was manually selected rather than being selected through auto drug selection"
      type: yesno
      sql: ${TABLE}.SALE_BRAND_MANUALLY_SELECTED = 'Y' ;;
    }

    dimension: rx_tx_competitive_priced {
      label: "Prescription Competitive Priced"
      description: "Yes/No flag indicating if the competitive pricing was used when transaction was priced"
      type: yesno
      sql: ${TABLE}.SALE_COMPETITIVE_PRICED = 'Y' ;;
    }

    dimension: rx_tx_controlled_substance_escript {
      label: "Prescription Controlled Substance Escript"
      description: "Yes/No flag indicating if prescription was generated from a controlled substance escript. Used to identify prescriptions for auditing and prescription edits requirements"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_CONTROLLED_SUBSTANCE_ESCRIPT = 'N' ;;
          label: "Not Controlled Substance"
        }

        when: {
          sql: true ;;
          label: "Yes"
        }
      }
    }

    dimension: rx_tx_different_generic {
      label: "Prescription Different Generic"
      description: "Yes/No flag indicating if a different generic drug was used for this fill from the previous fill"
      type: yesno
      sql: ${TABLE}.SALE_DIFFERENT_GENERIC = 'Y' ;;
    }

    dimension: rx_tx_fill_location {
      label: "Prescription Fill Location"
      description: "Flag that identifies where this transaction was filled"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_FILL_LOCATION = 'A' ;;
          label: "ACS System"
        }

        when: {
          sql: ${TABLE}.SALE_FILL_LOCATION = 'L' ;;
          label: "Local Pharmacy"
        }

        when: {
          sql: ${TABLE}.SALE_FILL_LOCATION = 'M' ;;
          label: "Mail Order"
        }

        when: {
          sql: ${TABLE}.SALE_FILL_LOCATION = 'C' ;;
          label: "Central Fill"
        }

        when: {
          sql: true ;;
          label: "Unknown"
        }
      }
    }

    dimension: rx_tx_generic_manually_selected {
      label: "Prescription Generic Manually Selected"
      description: "Yes/No flag indicating if the Generic drug was manually selected rather than being selected through auto drug selection"
      type: yesno
      sql: ${TABLE}.SALE_GENERIC_MANUALLY_SELECTED = 'Y' ;;
    }

    dimension: rx_tx_keep_same_drug {
      label: "Prescription Keep Same Drug"
      description: "Yes/No flag indicating if the same drug should be used for each refill of a prescription"
      type: yesno
      sql: ${TABLE}.SALE_KEEP_SAME_DRUG = 'Y' ;;
    }

    dimension: rx_tx_manual_acquisition_drug_dispensed {
      label: "Prescription Manual Acquisition Drug Dispensed"
      description: "Yes/No flag indicating if, at the time the transaction was processed, the Dispensed Drug was identified as a Manual ACQ Drug. This would imply that the ACQ used to price the prescription was manually entered before pricing was done."
      type: yesno
      sql: ${TABLE}.SALE_MANUAL_ACQUISITION_DRUG_DISPENSED = 'Y' ;;
    }

    dimension: rx_tx_medicare_notice {
      label: "Prescription Medicare Notice"
      description: "Yes/No flag indicating if approval code or reject code were received in the response from the PBM and that the patient should be given a Medicare Rights Notice"
      type: yesno
      sql: ${TABLE}.SALE_MEDICARE_NOTICE = 'Y' ;;
    }

    dimension: rx_tx_no_sales_tax {
      label: "Prescription No Sales Tax"
      description: "Yes/No flag indicating if the patient associated with this transaction is flagged as tax exempt"
      type: yesno
      sql: ${TABLE}.SALE_NO_SALES_TAX = 'Y' ;;
    }

    dimension: rx_tx_otc_taxable_indicator {
      label: "Prescription OTC Taxable Indicator"
      description: "Yes/No flag indicating if the OTC drug is taxable"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_OTC_TAXABLE_INDICATOR = 'Y' ;;
          label: "Yes Taxable"
        }

        when: {
          sql: true ;;
          label: "Not Taxable"
        }
      }
    }

    dimension: rx_tx_patient_request_brand_generic {
      label: "Prescription Patient Request Brand Generic"
      description: "Flag to identify that a patient has specifically requested the brand or generic when requesting their prescription be filled"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_PATIENT_REQUEST_BRAND_GENERIC = 'B' ;;
          label: "Brand"
        }

        when: {
          sql: ${TABLE}.SALE_PATIENT_REQUEST_BRAND_GENERIC = 'G' ;;
          label: "Generic"
        }

        when: {
          sql: true ;;
          label: "Not Specified"
        }
      }
    }

    dimension: rx_tx_patient_requested_price {
      label: "Prescription Patient Requested Price"
      description: "Yes/No flag indicating if the patient requested a specific price for this transaction in Order Entry"
      type: yesno
      sql: ${TABLE}.SALE_PATIENT_REQUESTED_PRICE = 'Y' ;;
    }

    dimension: rx_tx_pickup_signature_not_required {
      label: "Prescriber Pickup Signature Not Required"
      description: "flag that marks the transaction as 'Y' Yes, it needs, or 'N', No it does not need a pickup signature due to the plan setting at the time it was sold"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_PICKUP_SIGNATURE_NOT_REQUIRED = 'Y' ;;
          label: "Yes Required"
        }

        when: {
          sql: true ;;
          label: "Not Required"
        }
      }
    }

    dimension: rx_tx_price_override_reason {
      label: "Prescription Price Override Reason"
      description: "Reason that the user chose to override the price of this transaction"
      type: string
      hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.

      case: {
        when: {
          sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON = '0' ;;
          label: "Other"
        }

        when: {
          sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON = '1' ;;
          label: "Match Compete Price"
        }

        when: {
          sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON = '2' ;;
          label: "Match Quote"
        }

        when: {
          sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON = '3' ;;
          label: "Match Previous Fill"
        }

        when: {
          sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON = '4' ;;
          label: "Pricing Error"
        }

        when: {
          sql: true ;;
          label: "Not Performed"
        }
      }
    }

    # ERXLPS-643 - Add yes no flag for price overrides
    dimension: rx_tx_price_override_yesno {
      label: "Prescription Price Override"
      description: "Yes/No Flag indicating if a price override was performed on this transaction"
      type: yesno
      sql: ${TABLE}.SALE_PRICE_OVERRIDE_REASON IS NOT NULL ;;
    }

    dimension: rx_tx_refill_source {
      label: "Prescription Refill Source"
      description: "Flag represents the process that initiated the creation of this Prescription Transaction record"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '0' ;;
          label: "IVR"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '1' ;;
          label: "Fax"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '2' ;;
          label: "Auto-fill"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '3' ;;
          label: "N/H Batch"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '4' ;;
          label: "N/H unit Dose Billing"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '5' ;;
          label: "Call-In(Non_IVR)"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '6' ;;
          label: "Walk-up"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '7' ;;
          label: "Drive-up"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '8' ;;
          label: "Order Entry"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '9' ;;
          label: "eScript"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '10' ;;
          label: "WS EPHARM"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '11' ;;
          label: "WS IVR"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '12' ;;
          label: "ePharm"
        }

        when: {
          sql: ${TABLE}.SALE_REFILL_SOURCE = '13' ;;
          label: "Mobile Service Provider"
        }

        when: {
          sql: true ;;
          label: "Not A Refill"
        }
      }
    }

    dimension: rx_tx_require_relation_to_patient {
      label: "Prescription Require Relation To Patient"
      description: "Flag to identify if the relationship of the person picking up or dropping off the Rx on behalf of the customer still needs to be collected"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_REQUIRE_RELATION_TO_PATIENT = 'Y' ;;
          label: "Yes Need Data"
        }

        when: {
          sql: ${TABLE}.SALE_REQUIRE_RELATION_TO_PATIENT = 'N' ;;
          label: "No Data Not Needed"
        }

        when: {
          sql: ${TABLE}.SALE_REQUIRE_RELATION_TO_PATIENT = 'D' ;;
          label: "Data Acquired"
        }

        when: {
          sql: true ;;
          label: "Not Specified"
        }
      }
    }

    dimension: rx_tx_rx_com_down {
      label: "Prescription RXCOM Down"
      description: "Flag that indicates that the RX_TX record was added while communication to the Central Patient database was down, and a patient select has not occured"
      type: yesno
      sql: ${TABLE}.SALE_RX_COM_DOWN = 'Y' ;;
    }

    dimension: rx_tx_rx_stolen {
      label: "Prescription Stolen"
      description: "Yes/No flag indicating if the prescription has been marked as stolen"
      type: yesno
      sql: ${TABLE}.SALE_RX_STOLEN = 'Y' ;;
    }

    dimension: rx_tx_specialty_pa {
      label: "Prescription Specialty PA"
      description: "Yes/No flag indicating if the drug marked as a specialty drug, is to be used for the specialty prior authorization services"
      type: yesno
      sql: ${TABLE}.SALE_SPECIALTY_PA = 'Y' ;;
    }

    dimension: rx_tx_specialty_pa_status {
      label: "Prescription Specialty PA Status"
      description: "Status used to determine where the order is in the specialty prior authorization communication process, from the time it leaves EPS for billing analysis to the time it comes back to the store for filling"
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_SPECIALTY_PA_STATUS = '1' ;;
          label: "Specialty Sent"
        }

        when: {
          sql: ${TABLE}.SALE_SPECIALTY_PA_STATUS = '2' ;;
          label: "Specialty Received"
        }

        when: {
          sql: ${TABLE}.SALE_SPECIALTY_PA_STATUS = '3' ;;
          label: "Specialty Failed"
        }

        when: {
          sql: ${TABLE}.SALE_SPECIALTY_PA_STATUS = '4' ;;
          label: "Specialty Complete"
        }

        when: {
          sql: true ;;
          label: "Not Specified"
        }
      }
    }

    dimension: rx_tx_tx_user_modified {
      label: "Prescription Transaction User Modified"
      description: "Yes/No flag indicating if the prescription or transaction Modification/Correction was performed at the source system (EPS)"
      type: yesno
      sql: ${TABLE}.SALE_TX_USER_MODIFIED = 'Y' ;;
    }

    dimension: rx_tx_using_compound_plan_pricing {
      label: "Prescription Using Compound Plan Pricing"
      description: "Yes/No flag indicating if the Compound Plan Pricing was used when this transaction was priced"
      type: yesno
      sql: ${TABLE}.SALE_USING_COMPOUND_PLAN_PRICING = 'Y' ;;
    }

    dimension: rx_tx_using_percent_of_brand {
      label: "Prescription Using Percent of Brand"
      description: "Yes/No flag indicating if the generic price was based on a percentage of the brand price"
      type: yesno
      sql: ${TABLE}.SALE_USING_PERCENT_OF_BRAND = 'Y' ;;
    }

    dimension: rx_tx_intended_days_supply {
      label: "Prescription Intended Days Supply"
      description: "The original Days Supply that the customer requested for this transaction"
      type: number
      sql: ${TABLE}.SALE_INTENDED_DAYS_SUPPLY ;;
    }

    dimension: rx_tx_days_supply {
      label: "Prescription Days Supply"
      description: "The Days supply of the transaction, for the drug. The days supply is auto-populated in the client when the fill quantity and the SIG are entered. However, it can be entered manually by a user."
      type: number
      sql: ${TABLE}.SALE_DAYS_SUPPLY ;;
    }

    #####################################################################################End of YES/NO & CASE WHEN fields ###############################################################################################

    #####################  Dimensions Hidden (This view is primarily used for what is required for Workflow/Task History and will be extended for other subjects as it seems fit #############################################################################################
    dimension: rx_tx_is_340_b {
      label: "Prescription 340B"
      description: "Yes/No flag indicating if the transaction is a 340B transaction"
      type: yesno
      sql: ${TABLE}.SALE_IS_340B = 'Y' ;;
    }

    dimension: rx_tx_partial_fill_bill_type {
      label: "Prescription Partial Fill Bill Type"
      description: "Flag that indicates on a partial fill transaction, whether both the partial fill and completion fill are billed to a third party as the entire quantity or as separate quantities"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE = 'B' THEN 'BILLED SEPARATELY'
                WHEN ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE = 'C' THEN 'BILLED WHEN COMPLETION FILL IS FILLED'
                WHEN ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE = 'P' THEN 'BILLED WHEN PARTIAL FILL IS FILLED'
                WHEN ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE IS NULL THEN 'NOT BILLED AS PARTIAL OR COMPLETION'
                ELSE ${TABLE}.SALE_PARTIAL_FILL_BILL_TYPE
           END ;;
      suggestions: ["BILLED SEPARATELY", "BILLED WHEN COMPLETION FILL IS FILLED", "BILLED WHEN PARTIAL FILL IS FILLED", "NOT BILLED AS PARTIAL OR COMPLETION"]
    }

    dimension: rx_tx_partial_fill_status {
      label: "Prescription Partial Fill Status"
      description: "Stores the indicator of 'P' or 'C' for partial(P) /completion(C) fills"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_PARTIAL_FILL_STATUS = 'C' THEN 'COMPLETED PARTIAL'
                WHEN ${TABLE}.SALE_PARTIAL_FILL_STATUS = 'P' THEN 'PARTIAL FILL'
                WHEN NVL(${TABLE}.SALE_PARTIAL_FILL_STATUS, 'N') = 'N' THEN 'NOT A PARTIAL'
                ELSE ${TABLE}.SALE_PARTIAL_FILL_STATUS
           END;;
      suggestions: ["COMPLETED PARTIAL", "PARTIAL FILL", "NOT A PARTIAL"]
    }

    dimension: rx_tx_pos_status {
      label: "Prescription POS Status"
      description: "Status of the transaction with respect to the POS system"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error. Need to correct the EDW.D_MASTER_CODE table to show valus as 'ACQUIRED, POS MULTIPLE ATTEMPTS' instead of 'ACQUIRED, POS MULTIPLE ATTE'.
      sql: CASE WHEN ${TABLE}.SALE_POS_STATUS IS NULL THEN 'NOT SENT'
                WHEN ${TABLE}.SALE_POS_STATUS = 'S' THEN 'SENT'
                WHEN ${TABLE}.SALE_POS_STATUS = 'R' THEN 'REPLACE WHEN SENT'
                WHEN ${TABLE}.SALE_POS_STATUS = 'D' THEN 'TO BE DELETED'
                WHEN ${TABLE}.SALE_POS_STATUS = 'A' THEN 'ALREADY ON POS'
                WHEN ${TABLE}.SALE_POS_STATUS = '1' THEN 'NOT PRESENT'
                WHEN ${TABLE}.SALE_POS_STATUS IN ('2', '5') THEN 'ACQUIRED'
                WHEN ${TABLE}.SALE_POS_STATUS = '3' THEN 'ACQUIRED, POS MULTIPLE ATTEMPTS'
                ELSE ${TABLE}.SALE_POS_STATUS
           END ;;
      suggestions: ["NOT SENT", "SENT", "REPLACE WHEN SENT", "TO BE DELETED", "ALREADY ON POS", "NOT PRESENT", "ACQUIRED", "ACQUIRED, POS MULTIPLE ATTEMPTS"]
    }

    dimension: rx_tx_rx_credit_initiator {
      label: "Prescription Credit Initiator"
      description: " Flag that indicates what function initiated the credit return"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      #[ERXDWPS-5198] - There are some records from Costco with 'y'. Need to add master code entry with lower case y.
      sql: CASE WHEN ${TABLE}.SALE_RX_CREDIT_INITIATOR IN ('', 'N') THEN 'NURSING HOME'
                WHEN ${TABLE}.SALE_RX_CREDIT_INITIATOR IS NULL THEN 'NOT CREDIT RETURNED'
                WHEN ${TABLE}.SALE_RX_CREDIT_INITIATOR IN ('Y', 'y') THEN 'PHARMACY'
                ELSE ${TABLE}.SALE_RX_CREDIT_INITIATOR
           END ;;
      suggestions: ["NURSING HOME", "NOT CREDIT RETURNED", "PHARMACY"]
    }

    dimension: rx_tx_deleted {
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_DELETED ;;
    }

    dimension: rx_tx_tp_bill {
      label: "Prescription TP Bill Status"
      description: "Indicates if this transaction was charged to a third party"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_TP_BILL = 'Y' THEN 'CHARGED TO TP'
                WHEN NVL(${TABLE}.SALE_TP_BILL, 'N') = 'N' THEN 'NO CHARGE TO TP'
                ELSE ${TABLE}.SALE_TP_BILL
           END ;;
      suggestions: ["CHARGED TO TP", "NO CHARGE TO TP"]
    }

    dimension: rx_tx_tx_deleted {
      type: string
      hidden: yes
      sql: ${TABLE}.SALE_TX_DELETED ;;
    }

    ########################################################################################################## End of Dimensions #############################################################################################
    #################### These objects are referenced in sales explore to determine the Brand, Generic - ACQ, PRICE, Discount etc ##########################

    dimension: rx_tx_generic_acquisition_cost {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_GENERIC_ACQUISITION_COST ;;
    }

    dimension: rx_tx_brand_acquisition_cost {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_BRAND_ACQUISITION_COST ;;
    }

    dimension: rx_tx_generic_discount {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_GENERIC_DISCOUNT ;;
    }

    dimension: rx_tx_brand_discount {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_BRAND_DISCOUNT ;;
    }

    dimension: rx_tx_generic_price {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_GENERIC_PRICE ;;
    }

    dimension: rx_tx_tax_amount {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_TAX_AMOUNT ;;
    }

    dimension: rx_tx_brand_price {
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_BRAND_PRICE ;;
    }

    ########################################################################################################## reference dates used in other explores (currently used in sales )#############################################################################################
    ###### reference dates does not have any type as the type is defined in other explores....
    ###### the below objects are used as references in other view files....
    ### [ERXLPS-147]
    ####
    dimension: rx_tx_reportable_sales_reference {
      hidden: yes
      label: "Prescription Reportable Sales"
      description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
      sql: ${TABLE}.SALE_REPORTABLE_SALES_DATE ;;
    }

    dimension: rx_tx_fill_reference {
      hidden: yes
      label: "Prescription Filled"
      description: "Date prescription was filled"
      sql: ${TABLE}.SALE_FILL_DATE ;;
    }

    dimension: rx_tx_will_call_picked_up_reference {
      hidden: yes
      label: "Prescription Will Call PickedUp"
      description: "Date/time that a prescription was sold out of Will Call by a user or by a POS system "
      sql: ${TABLE}.SALE_WILL_CALL_PICKED_UP_DATE ;;
    }

    dimension: will_call_arrival_reference {
      hidden: yes
      label: "Prescription Will Call Arrival"
      description: "Date/time that a prescription enters Will Call"
      sql: ${TABLE}.SALE_WILL_CALL_ARRIVAL_DATE ;;
    }

    #[ERXLPS-645] Adding dimension to refere in Sales date
    dimension: rx_tx_written_reference {
      hidden: yes
      label: "Prescription Written Date"
      description: "Date the doctor wrote the prescription. User entered"
      sql: ${TABLE}.SALE_WRITTEN_DATE ;;
    }

    #[ERXLPS-645] Adding dimension to refere in Sales date
    dimension: rx_tx_next_refill_reference {
      hidden: yes
      label: "Next Refill Date"
      description: "Date prescription can be refilled, based on the days supply. Calculation Used: Filled Date + Days Supply"
      sql: DATEADD(DAY,${TABLE}.SALE_DAYS_SUPPLY,TO_DATE(${TABLE}.SALE_FILL_DATE)) ;;
    }

    dimension: rx_tx_drug_dispensed_reference {
      hidden: yes
      label: "Prescription Drug Dispensed"
      description: "Indicates the type of drug dispensed. Brand, Generic, Compound"
      type: string
      sql: ${TABLE}.SALE_DRUG_DISPENSED ;;
    }

    dimension: rx_tx_fill_status_reference {
      hidden: yes
      label: "Prescription Fill Status"
      description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
      type: string
      sql: ${TABLE}.SALE_FILL_STATUS ;;
    }

    dimension: rx_tx_tp_bill_reference {
      hidden: yes
      label: "Prescription T/P Bill Status"
      description: "Indicates if this transaction was charged to a third party"
      type: string
      sql: ${TABLE}.SALE_TP_BILL ;;
    }

    dimension: rx_tx_custom_reported_reference {
      hidden: yes
      label: "Prescription Transaction Custom Reported"
      description: "Date/time the record was reported on the Meijer Sales Report"
      sql: ${TABLE}.SALE_CUSTOM_REPORTED_DATE ;;
    }

    dimension: rx_tx_central_fill_cutoff_reference {
      hidden: yes
      label: "Prescription Transaction Central Fill Cutoff"
      description: "The cut-off date that the prescription must be transmitted to the fulfillment site by so that the prescription can be delivered by the promised date. System generated depending upon time and date of prescription"
      sql: ${TABLE}.SALE_CENTRAL_FILL_CUTOFF_DATE ;;
    }

    dimension: rx_tx_drug_expiration_reference {
      hidden: yes
      label: "Prescription Transaction Drug Expiration"
      description: "Dispensed drug's expiration date. system generated or user entered"
      sql: ${TABLE}.SALE_DRUG_EXPIRATION_DATE ;;
    }

    dimension: rx_tx_follow_up_reference {
      hidden: yes
      label: "Prescription Transaction Follow Up"
      description: "Date of prescription follow-up. System Generated"
      sql: ${TABLE}.SALE_FOLLOW_UP_DATE ;;
    }

    dimension: rx_tx_stop_reference {
      hidden: yes
      label: "Prescription Transaction Stop"
      description: "Nursing home or institutional stop date. (The date that the patient should stop receiving medication)"
      sql: ${TABLE}.SALE_STOP_DATE ;;
    }

    dimension: rx_tx_source_create_reference {
      hidden: yes
      label: "Prescription Transaction Source Create"
      description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database"
      sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    }
    #[ERXLPS-1055] Date reference dimensions for the remaining F_RX_TX_LINK date columns. End here...
    #[ERX-326]/[ERX-1624]
    ########################################################################################################## 4.8.000 New columns start #############################################################################################
    ## FK Columns

    dimension: rx_tx_new_rx_tx_id {
      description: "Unique ID that identifies the reassigned RXTX record that was generated from this record. System generated"
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_NEW_RX_TX_ID ;;
      value_format: "######"
    }

    dimension: rx_tx_old_rx_tx_id {
      description: "Unique ID that identifies the previous RXTX record that this record was generated from. System generated"
      hidden: yes
      type: number
      sql: ${TABLE}.SALE_OLD_RX_TX_ID ;;
      value_format: "######"
    }

    ########################################################################################################## Dimensions #############################################################################################

    #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
    dimension: rx_tx_group_code_deidentified {
      label: "Prescription Group Code"
      description: "Group code for this prescription"
      type: string
      # sha2 by default uses 256 as the message digest size.
      sql: SHA2(${TABLE}.SALE_GROUP_CODE) ;;
    }

    dimension: rx_tx_icd9_code {
      label: "Prescription ICD9 Code"
      description: "ICD9 code selected during data entry. User selected"
      type: string
      sql: ${TABLE}.SALE_ICD9_CODE ;;
    }

    dimension: rx_tx_pos_barcode_number {
      label: "Prescription POS Barcode Number"
      description: "Barcode identifier required by the POS system"
      type: number
      sql: ${TABLE}.SALE_POS_BARCODE_NUMBER ;;
      value_format: "######"
    }

    dimension: rx_tx_pv_initials {
      label: "Prescription PV Initials"
      description: "Initials of the user who performed Product Verification on this transaction. Entered by user, and system generated when transaction is created"
      type: string
      sql: ${TABLE}.SALE_PV_INITIALS ;;
    }

    dimension: rx_tx_rems_dispensing {
      label: "Prescription REMS Dispensing"
      description: "Yes/No flag indicating if the dispensed is a Risk Evaluation and Mitigation Strategy drug"
      type: yesno
      sql: ${TABLE}.SALE_REMS_DISPENSING = 'Y' ;;
    }

    dimension: rx_tx_route_of_administration_id {
      label: "Prescription Route Of Administration Identifier"
      description: "ID of the Route of Administration record linked to this RX_TX record. SNOMED code provided in the nhinclin file from NHIN. Must exist in the Route of Administration table"
      type: number
      sql: ${TABLE}.SALE_ROUTE_OF_ADMINISTRATION_ID ;;
      value_format: "######"
    }

    #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
    dimension: rx_tx_submitted_prescriber_dea_deidentified {
      label: "Prescription Submitted Prescriber DEA"
      description: "Most recent DEA number of the prescriber that was submitted for PMP reporting for the RX_TX record"
      type: string
      # sha2 by default uses 256 as the message digest size.
      sql: SHA2(${TABLE}.SALE_SUBMITTED_PRESCRIBER_DEA) ;;
    }

    #[ERXLPS-1436] - Deidentified dimension to use in DEMO Model
    dimension: rx_tx_submitted_prescriber_npi_deidentified {
      label: "Prescription Submitted Prescriber NPI"
      description: "Most recent NPI number of the prescriber that was submitted for PMP reporting for the RX_TX record"
      type: string
      # sha2 by default uses 256 as the message digest size.
      sql: SHA2(${TABLE}.SALE_SUBMITTED_PRESCRIBER_NPI) ;;
    }

    #[ERXLPS-2333] - Dimension added to use it in report filters.
    dimension: rx_tx_prescribed_quantity {
      label: "Prescription Prescribed Quantity"
      description: "Number of units (quantity) of the drug the doctor ordered"
      type: number
      sql: ${TABLE}.SALE_PRESCRIBED_QUANTITY ;;
      value_format: "#,##0.00;(#,##0.00)"
    }

    #[ERXDWPS-5091] - Price Code at Fill dimension. No results will populate for Price Code, if information not available in D_STORE_PRICE_CODE_HIST at the time of fill.
    dimension: rx_tx_price_code_at_fill {
      label: "Prescription Transaction Price Code at Fill"
      description: "Price Code information provided at the time of fill. This field is EPS only!!!"
      type:  string
      sql: etl_manager.fn_get_value_as_of_date(${store_price_code_hist_listagg.price_code_hist}, date_part(epoch_nanosecond, ${TABLE}.SALE_FILL_DATE),'N') ;;
    }

    ########################################################################################################## End of Dimensions #############################################################################################
    ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

    dimension: rx_tx_charge {
      label: "Prescription Charge"
      description: "Yes/No flag indicating if you charged the transaction to accounts receivable. System generated when charged"
      type: yesno
      sql: ${TABLE}.SALE_CHARGE_FLAG = 'Y' ;;
    }

    dimension: rx_tx_counseling_choice {
      label: "Prescription Counseling Choice"
      description: "Indicates if Patient Counseling was Required, Accepted, or Refused for the transaction"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_COUNSELING_CHOICE = 'A' THEN 'ACCEPTED'
                WHEN ${TABLE}.SALE_COUNSELING_CHOICE = 'R' THEN 'REFUSED'
                WHEN ${TABLE}.SALE_COUNSELING_CHOICE = 'Q' THEN 'REQUIRED'
                WHEN ${TABLE}.SALE_COUNSELING_CHOICE IS NULL THEN 'NOT REQUIRED'
                ELSE ${TABLE}.SALE_COUNSELING_CHOICE
           END ;;
      suggestions: ["ACCEPTED", "REFUSED", "REQUIRED", "NOT REQUIRED"]
    }

    dimension: rx_tx_days_supply_basis {
      label: "Prescription Days Supply Basis"
      description: "Basis of days supply. User selected"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN NVL(${TABLE}.SALE_DAYS_SUPPLY_BASIS, '0') = '0' THEN 'NOT SPECIFIED'
                WHEN ${TABLE}.SALE_DAYS_SUPPLY_BASIS = '1' THEN 'EXPLICIT DIRECTIONS'
                WHEN ${TABLE}.SALE_DAYS_SUPPLY_BASIS = '2' THEN 'PRN DIRECTIONS'
                WHEN ${TABLE}.SALE_DAYS_SUPPLY_BASIS = '3' THEN 'AS DIRECTED BY PRESCRIBER'
                ELSE ${TABLE}.SALE_DAYS_SUPPLY_BASIS
           END ;;
      suggestions: ["NOT SPECIFIED", "EXPLICIT DIRECTIONS", "PRN DIRECTIONS", "AS DIRECTED BY PRESCRIBER"]
    }

    dimension: rx_tx_drug_schedule {
      label: "Drug Schedule"
      description: "The U.S. Drug Schedule."
      type: string

      case: {
        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 1 ;;
          label: "SCHEDULE I DRUGS"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 2 ;;
          label: "SCHEDULE II DRUGS"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 3 ;;
          label: "SCHEDULE III DRUGS"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 4 ;;
          label: "SCHEDULE IV DRUGS"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 5 ;;
          label: "SCHEDULE V DRUGS"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 6 ;;
          label: "LEGEND"
        }

        when: {
          sql: ${TABLE}.SALE_DRUG_SCHEDULE = 8 ;;
          label: "OTC"
        }

        when: {
          sql: true ;;
          label: "UNKNOWN"
        }
      }
    }

    ## [ERXLPS-418] ## - This is part of the rx_tx_drug_schedule dimension, it was replaced by sql_case: Due to the naming format being different for the Drug Schedule on the transaction, and the Master code change having to be done through a seperate release, commented out Master Code subquery until release of Master Code change in 4.8.002
    #     sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION)
    #             FROM EDW.D_MASTER_CODE MC
    #             WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.SALE_DRUG_SCHEDULE AS VARCHAR),'NULL')
    #             AND MC.EDW_COLUMN_NAME = 'SALE_DRUG_SCHEDULE'
    #             AND MC.SOURCE_SYSTEM = 'EPS')
    #    suggestions: ['SCHEDULE I DRUGS', 'SCHEDULE II DRUGS','SCHEDULE III DRUGS','SCHEDULE IV DRUGS','SCHEDULE V DRUGS','LEGEND DRUGS','OTC DRUGS','UNKNOWN']

    dimension: rx_tx_exclude_from_batch_fill {
      label: "Prescription Exclude From Batch"
      description: "Yes/No flag indicating if the prescription is to be excluded from the batch fill process. Input by the user on various DE and DV screens"
      type: yesno
      sql: ${TABLE}.SALE_EXCLUDE_FROM_BATCH_FILL_FLAG = 'Y' ;;
    }

    dimension: rx_tx_exclude_from_mar {
      label: "Prescription Exclude From MAR"
      description: "Yes/No flag indicating if the prescription is to be excluded from the MAR's report. Input by the user on various DE and DV screens"
      type: yesno
      sql: ${TABLE}.SALE_EXCLUDE_FROM_MAR_FLAG = 'Y' ;;
    }

    dimension: rx_tx_exclude_from_prescriber_order {
      label: "Prescription Exclude From Prescriber Order"
      description: "Yes/No flag indicating if the prescription is to be excluded from the Physician's Orders report. Input by the user on various DE and DV screens"
      type: yesno
      sql: ${TABLE}.SALE_EXCLUDE_FROM_PRESCRIBER_ORDER_FLAG = 'Y' ;;
    }

    dimension: rx_tx_icd9_type {
      label: "Prescription ICD9 Type"
      description: "ICD9 type. User Selected"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_ICD9_TYPE IS NULL THEN 'ICD9'
                WHEN ${TABLE}.SALE_ICD9_TYPE = 'E' THEN 'EXTERNAL CAUSE'
                WHEN ${TABLE}.SALE_ICD9_TYPE = 'V' THEN 'FACTORS'
                WHEN ${TABLE}.SALE_ICD9_TYPE = 'M' THEN 'MORPHOLOGY'
                WHEN ${TABLE}.SALE_ICD9_TYPE = 'B' THEN 'ODB'
                ELSE ${TABLE}.SALE_ICD9_TYPE
           END ;;
      suggestions: ["ICD9", "EXTERNAL CAUSE", "FACTORS", "MORPHOLOGY", "ODB"]
    }

    dimension: rx_tx_sig_language {
      label: "Prescription SIG Language"
      description: "Indicates the SIG language. User selected"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_SIG_LANGUAGE = 'en' THEN 'ENGLISH'
                WHEN ${TABLE}.SALE_SIG_LANGUAGE = 'es' THEN 'SPANISH'
                WHEN ${TABLE}.SALE_SIG_LANGUAGE = 'fr' THEN 'FRENCH'
                WHEN ${TABLE}.SALE_SIG_LANGUAGE = 'de' THEN 'GERMAN'
                ELSE ${TABLE}.SALE_SIG_LANGUAGE
           END ;;
      suggestions: ["ENGLISH", "SPANISH", "FRENCH", "GERMAN"]
    }

    dimension: rx_tx_ncpdp_daw {
      label: "Prescription NCPDP DAW"
      description: "Indicates which DAW code was assigned during data entry. User Entered"
      type: string
      case: {
        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '0' ;;
          label: "0 - NO SELECTION"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '1' ;;
          label: "1 - DISPENSE AS WRITTEN"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '2' ;;
          label: "2 - BRAND - PATIENT CHOICE"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '3' ;;
          label: "3 - BRAND - PHARMACIST CHOICE"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '4' ;;
          label: "4 - BRAND - GENERIC OUT OF STOCK"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '5' ;;
          label: "5 - BRAND - DISPENSED AS GENERIC"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '6' ;;
          label: "6 - OVERRIDE"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '7' ;;
          label: "7 - BRAND - MANDATED BY LAW"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '8' ;;
          label: "8 - BRAND - GENERIC UNAVAILABLE"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW = '9' ;;
          label: "9 - OTHER"
        }

        when: {
          sql: ${TABLE}.SALE_NCPDP_DAW IS NULL ;;
          label: "NOT SPECIFIED"
        }
      }
      suggestions: [
        "0 - NO SELECTION",
        "1 - DISPENSE AS WRITTEN",
        "2 - BRAND - PATIENT CHOICE",
        "3 - BRAND - PHARMACIST CHOICE",
        "4 - BRAND - GENERIC OUT OF STOCK",
        "5 - BRAND - DISPENSED AS GENERIC",
        "6 - OVERRIDE",
        "7 - BRAND - MANDATED BY LAW",
        "8 - BRAND - GENERIC UNAVAILABLE",
        "9 - OTHER",
        "NOT SPECIFIED"
      ]
    }

    dimension: rx_tx_off_site {
      label: "Prescription Off Site Flag"
      description: "Yes/No flag indicating that the Single Drug Batch transaction was processed outside of the pharmacy. User Defined"
      type: yesno
      sql: ${TABLE}.SALE_OFF_SITE_FLAG = 'Y' ;;
    }

    dimension: rx_tx_pac_med {
      label: "Prescription PAC Med Flag"
      description: "Yes/No flag indicating whether the prescription was filled with a PacMed system. System Generated when pac med selection is made"
      type: yesno
      sql: ${TABLE}.SALE_PAC_MED_FLAG = 'Y' ;;
    }

    dimension: rx_tx_prescriber_transmitted {
      label: "Prescription Prescriber Transmitted"
      description: "Display whether the supervising prescriber or the actual prescriber was transmitted to the third party during adjudication. Used to determine what should be sent on refills during the transition. Written at time of dispensing"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_PRESCRIBER_TRANSMITTED IS NULL THEN 'FILLED PRIOR TO CHANGE'
                WHEN ${TABLE}.SALE_PRESCRIBER_TRANSMITTED = 'S' THEN 'SUPERVISING PRESCRIBER'
                WHEN ${TABLE}.SALE_PRESCRIBER_TRANSMITTED = 'P' THEN 'PRESCRIBER'
                ELSE ${TABLE}.SALE_PRESCRIBER_TRANSMITTED
           END ;;
      suggestions: ["FILLED PRIOR TO CHANGE", "SUPERVISING PRESCRIBER", "PRESCRIBER"]
    }

    dimension: rx_tx_safety_cap {
      label: "Prescription Safety Cap"
      description: "Yes/No Flag indicating if a safety cap was used on the prescription bottle for this transaction. User entered in EPS client"
      type: yesno
      sql: ${TABLE}.SALE_SAFETY_CAP_FLAG = 'Y' ;;
    }

    dimension: rx_tx_sig_prn {
      label: "Prescription SIG PRN"
      description: "Indicates if the SIG code for the transaction is PRN (as needed). System generated based on the SIG code associated with the prescription. Can be modified from the HOA's screen"
      type: string
      #[ERXDWPS-5198] - Modified logic to use CASE WHEN instead of SELECT MAX sql. The change is done as work around to avoid SF internal error.
      sql: CASE WHEN ${TABLE}.SALE_SIG_PRN_FLAG = 'Y' THEN 'SIG PRN'
                WHEN NVL(${TABLE}.SALE_SIG_PRN_FLAG, 'N') = 'N' THEN 'ROUTINE MED'
                WHEN ${TABLE}.SALE_SIG_PRN_FLAG = 'A' THEN 'ACTIVITY OF DAILY LIVING (ADL)'
                WHEN ${TABLE}.SALE_SIG_PRN_FLAG = 'T' THEN 'TREATMENT'
                ELSE ${TABLE}.SALE_SIG_PRN_FLAG
           END ;;
      suggestions: ["SIG PRN", "ROUTINE MED", "ACTIVITY OF DAILY LIVING (ADL)", "TREATMENT"]
    }

    dimension: rx_tx_usual {
      label: "Prescription Usual"
      description: "Yes/No flag indicating if this transaction used usual and customary pricing. System Generated if usual and customary price = price sold"
      type: yesno
      sql: ${TABLE}.SALE_USUAL_FLAG = 'Y' ;;
    }

    dimension: rx_tx_partial_fill_approved {
      label: "Prescription Partial Fill Approved"
      description: "Yes/No flag indicating record if a successful response has been sentback from the patient for a partial fill request"
      type: yesno
      sql: ${TABLE}.SALE_PARTIAL_FILL_APPROVED_FLAG = 'Y' ;;
    }

    ########################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

    ####################################################################################################### Measures ####################################################################################################


    # Aggregation of these measures should be done on rx_tx_id. Earlier these measures were sourced from sales_eps_rx_tx but now as these columns are moved into
    # f_sales so these measures are defined here with sql_distinct_key without considering tx_tp_id
    measure: sum_sales_rx_tx_manual_acquisition_cost {
      label: "Total Prescription Manual Acquisition Cost"
      group_label: "Acquisition Cost"
      description: "Total prescription manual acquisition cost"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_manual_acquisition_cost END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_sales_rx_tx_manual_acquisition_cost {
      label: "Avg Prescription Manual Acquisition Cost"
      group_label: "Acquisition Cost"
      description: "Average prescription manual acquisition cost"
      type: average_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN COALESCE(${TABLE}.sale_manual_acquisition_cost,0) END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_sales_rx_tx_professional_fee {
      label: "Prescription Total Professional Fee"
      group_label: "Other Measures"
      description: "Total of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_professional_fee END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_sales_rx_tx_professional_fee {
      label: "Prescription Average Professional Fee"
      group_label: "Other Measures"
      description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
      type: average_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN COALESCE(${TABLE}.sale_professional_fee,0) END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_intended_quantity {
      label: "Prescription Intended Quantity"
      group_label: "Quantity"
      description: "The original quantity that the customer requested for this transaction"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_intended_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_original_quantity {
      label: "Prescription Original Quantity"
      group_label: "Quantity"
      description: "Original quantity on the transaction before credit return"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_original_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_prescribed_quantity {
      label: "Prescription Prescribed Quantity"
      group_label: "Quantity"
      description: "Number of units (quantity) of the drug the doctor ordered"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_prescribed_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_requested_price_to_quantity {
      label: "Prescription Requested Price To Quantity"
      group_label: "Quantity"
      description: "The requested dollar amount of the prescription that the patient would like to purchase"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_requested_price_to_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_pos_overridden_net_paid {
      label: "Prescription POS Overridden Net Paid"
      group_label: "Price Override"
      description: "Total overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_pos_overridden_net_paid END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_sales_rx_tx_pos_overridden_net_paid {
      label: "Avg Prescription POS Overridden Net Paid"
      group_label: "Price Override"
      description: "Average overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
      type: average_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN COALESCE(${TABLE}.sale_pos_overridden_net_paid,0) END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_fill_quantity {
      label: "Prescription Fill Quantity"
      group_label: "Quantity"
      description: "Total Quantity (number of units) of the drug dispensed"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.SALE_FILL_QUANTITY END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_fill_quantity_tp {
      label: "T/P Prescription Fill Quantity"
      group_label: "Quantity"
      description: "Total Fill Quantity of the T/P Prescription Transaction"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.SALE_FILL_QUANTITY END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_fill_quantity_cash {
      label: "Cash Prescription Fill Quantity"
      group_label: "Quantity"
      description: "Total Fill Quantity of the Cash Prescription Transaction"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.SALE_FILL_QUANTITY END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_original_price {
      label: "Prescription Original Price"
      group_label: "Other Price"
      description: "Total Original Price of the Prescription Transaction"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.SALE_ORIGINAL_PRICE END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_base_cost {
      label: "Prescription Total Base Cost"
      group_label: "Other Measures"
      description: "Total dollar amount the cost base was for this transaction of the drug filled. System Generated"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.SALE_BASE_COST END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_compound_fee {
      label: "Prescription Total Compound Fee"
      group_label: "Other Measures"
      description: "Total compound preparation charges. User entered. Compound rate multiplied by compound time"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.SALE_COMPOUND_FEE END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_up_charge {
      label: "Prescription Total Up Charge"
      group_label: "Other Measures"
      description: "Total amount by which the cost base (for the drug filled) was adjusted by a base cost table (third party prescription only). System Generated"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_up_charge END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_sales_rx_tx_owed_quantity {
      label: "Prescription Total Owed Quantity"
      group_label: "Quantity"
      description: "Total number of units (quantity) of the drug that are owed to the patient. Auto-calculated via client"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  THEN ${TABLE}.sale_owed_quantity END ;;
      value_format: "#,##0.00"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_prescribed_quantity_tp {
      label: "T/P Prescription Prescribed Quantity"
      group_label: "Quantity"
      description: "Number of units (quantity) of the drug the doctor ordered for Third Party transactions"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.sale_prescribed_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-1055] - modified value format precision from 4 to 2.
    measure: sum_sales_rx_tx_prescribed_quantity_cash {
      label: "Cash Prescription Prescribed Quantity"
      group_label: "Quantity"
      description: "Number of units (quantity) of the drug the doctor ordered for Cash transactions"
      type: sum_distinct
      sql_distinct_key:  ${chain_id}|| '@' ||${nhin_store_id} || '@' || ${rx_tx_id} || '@' || ${sold_flg} || '@' || ${adjudicated_flg} || '@' || ${sale_event_type} ;;
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.sale_prescribed_quantity END ;;
      value_format: "#,##0.00;(#,##0.00)" #[ERXLPS-2190]
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXLPS-2295]
    ############################################################################### Drug Cost At time of Fill measures ###############################################################
    #Pharmacy Drug Cost at time of fill
    dimension: drug_awp_cost_per_unit_amount_store_reference {
      hidden: yes
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.drug_awp_cost_per_unit_amount_reference})*-1
                WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.drug_awp_cost_per_unit_amount_reference}
           END ;;
    }

    #[ERXDWPS-7024] - Pharmacy Drug ACQ per unit amount dimension exposed.
    dimension: drug_acq_cost_per_unit_amount_store {
      label: "Drug ACQ Cost Per Unit Amount At Fill - Pharmacy"
      description: "Represents the Acquisition Cost of the Pharmacy Drug Per Unit Amount at the time of fill. (Calculation Used: Pharmacy Drug ACQ Amount/Decimal Pack Size). This field is EPS only!!!"
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.drug_acq_cost_per_unit_amount_reference})*-1
                 WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.drug_acq_cost_per_unit_amount_reference}
          END ;;
      value_format: "$#,##0.0000000;($#,##0.0000000)"
    }

    #[ERXDWPS-7020] - Reference dimensions created.
    dimension: drug_awp_cost_amount_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.drug_awp_cost_amount_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.drug_awp_cost_amount_reference}
               END ;;
    }

    dimension: rx_tx_awp_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_awp_cost_amount_at_fill_reference})*-1
                  WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_awp_cost_amount_at_fill_reference}
             END ;;
    }

    dimension: rx_tx_wac_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_wac_cost_amount_at_fill_reference})*-1
                  WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_wac_cost_amount_at_fill_reference}
             END ;;
    }

    dimension: rx_tx_acq_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_acq_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_acq_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_reg_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_reg_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_reg_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_mac_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_mac_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_mac_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_std_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_std_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_std_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_dp_cost_amount_at_fill_store_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_store_drug_cost_hist.rx_tx_dp_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_store_drug_cost_hist.rx_tx_dp_cost_amount_at_fill_reference}
               END ;;
    }

    measure: sum_drug_awp_cost_amount_store {
      label: "Total Pharmacy Drug AWP Amount"
      description: "Represents the Average Wholesale Price of the Pharmacy Drug at the time of fill. This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      sql: ${drug_awp_cost_amount_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_drug_awp_cost_per_unit_amount_store {
      label: "Total Pharmacy Drug AWP Per Unit Amount"
      description: "Represents the Average Wholesale Price of the Pharmacy Drug Per Unit Amount at the time of fill. (Calculation Used: Pharmacy Drug AWP Amount/Decimal Pack Size). This field is EPS only!!!"
      type: number
      #[ERXLPS-1347] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
      sql: ( SUM(DISTINCT (CAST(FLOOR(${drug_awp_cost_per_unit_amount_store_reference}*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${drug_awp_cost_per_unit_amount_store_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${drug_awp_cost_per_unit_amount_store_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
      # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
      value_format: "$#,##0.0000000;($#,##0.0000000)"
    }

    measure: sum_rx_tx_awp_cost_amount_at_fill_store {
      label: "Total AWP Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug AWP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_awp_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_wac_cost_amount_at_fill_store {
      label: "Total WAC Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Wholesaler Acquisition Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug WAC Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_wac_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_acq_cost_amount_at_fill_store {
      label: "Total ACQ Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Acquisition Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug ACQ Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_acq_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_reg_cost_amount_at_fill_store {
      label: "Total REG Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Regular Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug REG Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_reg_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_mac_cost_amount_at_fill_store {
      label: "Total MAC Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Maximum Allowable Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug MAC Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_mac_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_std_cost_amount_at_fill_store {
      label: "Total STD Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Standard Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug STD Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_std_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_dp_cost_amount_at_fill_store {
      label: "Total DP Amount At Fill - Pharmacy"
      description: "Represents the Pharmacy Direct Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill. (Calculation Used: ((Pharmacy Drug DP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_dp_cost_amount_at_fill_store_reference} ;;
      sql_distinct_key: ${rx_tx_store_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    #Host Drug Cost at time of fill
    dimension: drug_awp_cost_per_unit_amount_host_reference {
      hidden: yes
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.drug_awp_cost_per_unit_amount_reference})*-1
                WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.drug_awp_cost_per_unit_amount_reference}
             END ;;
    }

    #[ERXDWPS-7020] - Reference dimensions created.
    dimension: drug_awp_cost_amount_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.drug_awp_cost_amount_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.drug_awp_cost_amount_reference}
               END ;;
    }

    dimension: rx_tx_awp_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_awp_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_awp_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_wac_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_wac_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_wac_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_acq_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_acq_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_acq_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_reg_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_reg_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_reg_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_mac_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_mac_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_mac_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_std_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_std_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_std_cost_amount_at_fill_reference}
               END ;;
    }

    dimension: rx_tx_dp_cost_amount_at_fill_host_reference {
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT') THEN (${rx_tx_drug_cost_hist.rx_tx_dp_cost_amount_at_fill_reference})*-1
                    WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED') THEN ${rx_tx_drug_cost_hist.rx_tx_dp_cost_amount_at_fill_reference}
               END ;;
    }

    measure: sum_drug_awp_cost_amount_host {
      label: "Total HOST Drug AWP Amount"
      description: "Represents the Average Wholesale Price of the HOST Drug at the time of fill. This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      sql: ${drug_awp_cost_amount_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_drug_awp_cost_per_unit_amount_host {
      label: "Total HOST Drug AWP Per Unit Amount"
      description: "Represents the Average Wholesale Price of the HOST Drug Per Unit Amount at the time of fill. (Calculation Used: HOST Drug AWP Amount/Decimal Pack Size). This field is EPS only!!!"
      type: number
      #[ERXLPS-1347] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
      sql: ( SUM(DISTINCT (CAST(FLOOR(${drug_awp_cost_per_unit_amount_host_reference}*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${drug_awp_cost_per_unit_amount_host_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${drug_awp_cost_per_unit_amount_host_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
      # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
      value_format: "$#,##0.0000000;($#,##0.0000000)"
    }

    measure: sum_rx_tx_awp_cost_amount_at_fill_host {
      label: "Total AWP Amount At Fill - HOST"
      description: "Represents the Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug AWP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_awp_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_wac_cost_amount_at_fill_host {
      label: "Total WAC Amount At Fill - HOST"
      description: "Represents the Wholesaler Acquisition Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug WAC Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_wac_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_acq_cost_amount_at_fill_host {
      label: "Total ACQ Amount At Fill - HOST"
      description: "Represents the Acquisition Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug ACQ Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_acq_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_reg_cost_amount_at_fill_host {
      label: "Total REG Amount At Fill - HOST"
      description: "Represents the Regular Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug REG Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_mac_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_mac_cost_amount_at_fill_host {
      label: "Total MAC Amount At Fill - HOST"
      description: "Represents the Maximum Allowable Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug MAC Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_mac_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_std_cost_amount_at_fill_host {
      label: "Total STD Amount At Fill - HOST"
      description: "Represents the Standard Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug STD Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_std_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: sum_rx_tx_dp_cost_amount_at_fill_host {
      label: "Total DP Amount At Fill - HOST"
      description: "Represents the Direct Price of the Prescription Transaction based on the Fill Quantity and the Drug Cost at the time of fill wrt HOST Drug. (Calculation Used: ((HOST Drug DP Amount/Decimal Pack Size) * Prescription Transaction Fill Quantity). This field is EPS only!!!"
      type: sum_distinct #[ERXDWPS-5207]
      group_label: "Drug Cost at Fill"
      sql: ${rx_tx_dp_cost_amount_at_fill_host_reference} ;;
      sql_distinct_key: ${rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;; #[ERXLPS-4343][ERXDWPS-7728]
      value_format: "$#,##0.00;($#,##0.00)"
    }

    ############################################################################### Drug Cost At time of Fill measures ###############################################################

#ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker | Start



  dimension: rx_tx_aawp_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_aawp_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_aawp_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_acf_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_acf_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_acf_cost_at_fill_reference}
           END ;;
  }

  dimension: medispan_drug_awp_cost_unit_amount_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.medispan_drug_awp_cost_unit_amount_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.medispan_drug_awp_cost_unit_amount_reference}
           END ;;
  }

  dimension: rx_tx_awp_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_awp_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_awp_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_dp_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_dp_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_dp_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_geap_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_geap_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_geap_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_mac_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_mac_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_mac_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_nadc_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_nadc_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_nadc_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_nadg_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_nadg_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_nadg_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_nadi_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_nadi_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_nadi_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_nads_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_nads_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_nads_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_waa_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_waa_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_waa_cost_at_fill_reference}
           END ;;
  }

  dimension: rx_tx_wac_cost_at_fill_medispan_reference {
    hidden: yes
    type: number
    sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT', 'T/P - CREDIT', 'PARTIAL - CREDIT')
              THEN (${medispan_rx_tx_drug_cost_hist.rx_tx_wac_cost_at_fill_reference}) * -1
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - FILLED', 'T/P - FILLED', 'PARTIAL - FILLED')
              THEN ${medispan_rx_tx_drug_cost_hist.rx_tx_wac_cost_at_fill_reference}
           END ;;
  }

  measure: sum_rx_tx_aawp_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total AAWP Amount At Fill - Medi-Span"
    description: "Represents the Average Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug AAWP Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_aawp_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_acf_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total ACF Amount At Fill - Medi-Span"
    description: "Represents the Affordable Care Act of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug ACF Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_acf_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_medispan_drug_awp_cost_unit_amount_medispan {
    label: "Total Medi-Span Drug AWP Per Unit Amount"
    description: "Represents the Average Wholesale Price of the Medi-Span Drug Per Unit Amount at the time of fill"
    type: number
    #[ERXLPS-1347] SF behavior for division of two integers. Result default to 3 decimals and truncate value(do not round). Due to this we are missing 4th decimal. Applied workaround as SF suggested in SF#20683.
    sql: ( SUM(DISTINCT (CAST(FLOOR(${medispan_drug_awp_cost_unit_amount_medispan_reference}*(1000000*1.0)) AS DECIMAL(38,0))) + (CASE WHEN ${medispan_drug_awp_cost_unit_amount_medispan_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0) ) - SUM(DISTINCT (CASE WHEN ${medispan_drug_awp_cost_unit_amount_medispan_reference} IS NOT NULL THEN MD5_NUMBER(${chain_id} ||'@'||${nhin_store_id} ||'@'||${rx_tx_id}||'@'||${financial_category} ) ELSE 0 END % 1.0e27)::NUMERIC(38,0)) ) :: NUMBER(38,7) / (1000000*1.0) ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_rx_tx_awp_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total AWP Amount At Fill - Medi-Span"
    description: "Represents the Average Wholesale Price of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug AWP Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_awp_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_dp_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total DP Amount At Fill - Medi-Span"
    description: "Represents the Direct Price of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug DP Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_dp_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_geap_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total GEAP Amount At Fill - Medi-Span"
    description: "Represents the Generic Equivalent Average Price of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug GEAP Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_geap_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_mac_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total MAC Amount At Fill - Medi-Span"
    description: "Represents the Maximum Allowable Cost of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug MAC Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_mac_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_nadc_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total NADC Amount At Fill - Medi-Span"
    description: "Represents the National Average Drug Acquisition Cost Chain of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug NADC Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_nadc_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_nadg_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total NADG Amount At Fill - Medi-Span"
    description: "Represents the National Average Drug Acquisition Cost Generic of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug NADG Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_nadg_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_nadi_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total NADI Amount At Fill - Medi-Span"
    description: "Represents the National Average Drug Acquisition Cost Independent of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug NADI Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_nadi_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_nads_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total NADS Amount At Fill - Medi-Span"
    description: "Represents the National Average Drug Acquisition Cost Specialty of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug NADS Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_nads_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_waa_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total WAA Amount At Fill - Medi-Span"
    description: "Represents the Weighted Average - Average Manufacturer Cost of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug WAA Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_waa_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_wac_cost_at_fill_medispan {
    type: sum_distinct
    label: "Total WAC Amount At Fill - Medi-Span"
    description: "Represents the Wholesale Acquisition Cost of the Prescription Transaction based on the Fill Quantity and the Medi-Span Drug Cost at the time of fill wrt Medi-Span Drug. (Calculation Used: Medi-Span Drug WAC Unit Amount *  Prescription Transaction Fill Quantity)"
    group_label: "Medi-Span Drug Cost at Fill"
    sql: ${rx_tx_wac_cost_at_fill_medispan_reference} ;;
    sql_distinct_key: ${medispan_rx_tx_drug_cost_hist.unique_key}||'@'||${financial_category} ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXDWPS-7020] - Medispan drug cost related dimensions
  dimension: awp_ingredient_cost_pct_medispan {
    label: "AWP Ingredient Cost % - Medi-Span"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Medi-Span. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - Medi-Span )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_awp_cost_at_fill_medispan_reference},0),6) ;;
    value_format: "00.0000%"
  }

  dimension: wac_ingredient_cost_pct_medispan {
    label: "WAC Ingredient Cost % - Medi-Span"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Medi-Span. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - Medi-Span )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_wac_cost_at_fill_medispan_reference},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_awp_ingredient_cost_pct_medispan {
    label: "AWP Ingredient Cost % - Medi-Span"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Medi-Span. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - Medi-Span )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_awp_cost_at_fill_medispan},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_wac_ingredient_cost_pct_medispan {
    label: "WAC Ingredient Cost % - Medi-Span"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Medi-Span. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - Medi-Span )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_wac_cost_at_fill_medispan},0),6) ;;
    value_format: "00.0000%"
  }

#ERXDWPS-7019 - Albertsons - Expose Medispan Drug Cost in Looker | End

#[ERXLPS-2282] - New measures added for Avg Final Copay (Per Script)
    measure: avg_final_copay {
      label: "Avg Final Copay (per script)"
      group_label: "Average Final Copay (per script)"
      description: "Average Final Copay of prescription. Calculation Used: Total Final Copay of the Prescription/Total no. of scripts"
      type: number
      #[ERXLPS-1163] - Corrected the logic to handle avg price for credit return scripts.
      sql: COALESCE(${sum_final_copay}/NULLIF(ABS(${count}),0) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                    <font color="red">{{ rendered_value }}
                  {% else %}
                    <font color="grey">{{ rendered_value }}
                  {% endif %}
                  ;;
    }

    #[ERXLPS-2282] - New measure Avg Copay Overridden Amount added.
    measure: avg_copay_override_amount {
      label: "Avg Copay Override Amount (per script)"
      group_label: "Claim"
      description: "Average Copay Override Amount. Calculation Used: Copay Override Amount/Total no. of scripts"
      type: number
      sql: COALESCE(${copay_override_amount}/NULLIF(ABS(${count}),0),0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    #[ERXLPS-2282] - New measures added for Avg Copay Overridden Amount.
    measure: avg_copay_overridden_amount {
      label: "Avg Copay Overridden Amount (per script PRIOR to Override)"
      group_label: "Claim"
      description: "Average Copay Overridden Amount. Calculation Used: Copay Overridden Amount/Total no. of scripts"
      type: number
      sql: COALESCE(${copay_overridden_amount}/NULLIF(ABS(${count}),0),0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    #[ERXDWPS-5148]
    measure: sum_count_daw_0 {
      label: "Scripts (DAW 0)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW 0."
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_NCPDP_DAW = '0' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_count_daw_1 {
      label: "Scripts (DAW 1)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW 1."
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_NCPDP_DAW = '1' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_count_daw_2 {
      label: "Scripts (DAW 2)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW 2."
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_NCPDP_DAW = '2' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_count_daw_5 {
      label: "Scripts (DAW 5)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW 5."
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_NCPDP_DAW = '5' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_count_daw_9 {
      label: "Scripts (DAW 9)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW 9."
      type: sum
      sql: CASE WHEN ${TABLE}.SALE_NCPDP_DAW = '9' THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_count_daw_others {
      label: "Scripts (DAW Others)"
      group_label: "Scripts"
      description: "Total script volume without any adjustment for the prescription written as DAW other than 0,1,2,5,9."
      type: sum
      sql: CASE WHEN NVL(${TABLE}.SALE_NCPDP_DAW,'X') NOT IN ('0','1','2','5','9') THEN ${count_reference} END ;;
      value_format: "#,##0;(#,##0)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    #[ERXDWPS-5366]
    measure: sum_rx_tx_days_supply {
      label: "Prescription Days Supply"
      description: "The Days supply of the transaction, for the drug. The days supply is auto-populated in the client when the fill quantity and the SIG are entered. However, it can be entered manually by a user."
      type: sum
      sql: ${rx_tx_days_supply} ;;
      value_format: "#,##0;(#,##0)"
    }

    measure: avg_net_sales_per_days_supply {
      label: "Avg Net Sales (per Days Supply)"
      group_label: "Average Net Sales (per Days Supply)"
      description: "Average Net Sales per Prescription Days Supply. Calculation Used: Net Sales/Prescription Days Supply"
      type: number
      sql: COALESCE(${sum_net_sales}/NULLIF(ABS(${sum_rx_tx_days_supply}),0) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                          <font color="red">{{ rendered_value }}
                        {% else %}
                          <font color="grey">{{ rendered_value }}
                        {% endif %}
                        ;;
    }

    measure: avg_days_supply_per_script {
      label: "Days Supply per Script Count"
      description: "Average Days Supply per Script Count. Calculation Used: Prescription Days Supply/Scripts"
      type: number
      sql: COALESCE(${sum_rx_tx_days_supply}/NULLIF(ABS(${count}),0) ,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                          <font color="red">{{ rendered_value }}
                        {% else %}
                          <font color="grey">{{ rendered_value }}
                        {% endif %}
                        ;;
    }

    #ERXDWPS-5339 - Shopko: DOS Report: Request to create additional dimensions | Start
    dimension: rx_tx_days_supply_grouping {
      label: "Prescription Days of Supply Grouping"
      description: "Prescription Days of Supply grouped into buckets : below-30, 30, 31-59, 60, 61-83, 84-89, 90 and above 90"
      type: string
      sql: case when ${rx_tx_days_supply} < 30 THEN '<30'
                     when ${rx_tx_days_supply} = 30 THEN '30'
                     when ${rx_tx_days_supply} > 30 and ${rx_tx_days_supply} < 60 THEN '31-59'
                     when ${rx_tx_days_supply} = 60 THEN '60'
                     when ${rx_tx_days_supply} > 60 and ${rx_tx_days_supply} < 84 THEN '61-83'
                     when ${rx_tx_days_supply} > 83 and ${rx_tx_days_supply} < 90 THEN '84-89'
                     when ${rx_tx_days_supply} = 90 THEN '90'
                     when ${rx_tx_days_supply} > 90 THEN '>90'
                 end ;;
    }

    #[ERXDWPS-6716] New measure for net tx sales fully attributed to the primary plan
    measure: net_sales_rolled_up {
      label: "Net Sales Rolled Up"
      description: "Total net sales amount for a prescription transaction, fully attributed to the primary plan for third party claims or for cash transactions. This measure will be displayed only on primary payer, all others will display as $0.00"
      type: sum
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('CASH - CREDIT','CASH - FILLED','PARTIAL - FILLED', 'PARTIAL - CREDIT')
               AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
              THEN (${TABLE}.SALE_PRICE - nvl(${TABLE}.SALE_DISCOUNT_AMOUNT,0))
              WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y')
               AND ${financial_category} IN ('T/P - CREDIT','T/P - FILLED')
               AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
              THEN ${sales_tx_tp.tx_net_sales}
          END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

  #ERXDWPS-7510 - Sync EPS RX_TX_LINK,RX_SUMMARY changes to EDW F_SALE and F_SALE_ARCHIVE | Start
  dimension: sale_rx_tx_dispensing_rules_state {
    label:"Prescription Transaction Dispensing Rules State"
    description:"Stores the code of the state where the prescription will be delivered to the patient."
    type: string
    sql: ${TABLE}.SALE_RX_TX_DISPENSING_RULES_STATE ;;
  }

  dimension: sale_rx_tx_prescriber_license_state {
    label:"Prescription Transaction Prescriber License State"
    description:"In order to assist the pharmacies in case of audit, this field stores the prescriber license state at the transaction level so if a customer is audited they will know the license used at the time of filling."
    type: string
    sql: ${TABLE}.SALE_RX_TX_PRESCRIBER_LICENSE_STATE ;;
  }

  dimension: sale_rx_tx_prescriber_license_number {
    label:"Prescription Transaction Prescriber License Number"
    description:"In order to assist the pharmacies in case of audit,  this field stores the prescriber license number at the transaction level so if a customer is audited they will know the license used at the time of filling."
    type: string
    sql: sha2(${TABLE}.SALE_RX_TX_PRESCRIBER_LICENSE_NUMBER) ;;
  }

  dimension: sale_rx_tx_wait_for_pa_sale_rx_tx_id {
    label:"Prescription Transaction Wait For Pa Rx Tx Id"
    type: number
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_WAIT_FOR_PA_SALE_RX_TX_ID ;;
  }

  dimension: sale_rx_tx_cii_partial_dispensed_count {
    label:"Prescription Transaction CII Partial Dispensed Count"
    description:"This column will be used only in case of C-II drug. The value of this column will be incremented when a prescription is partially dispensed (ie Fill quantity is less than prescribed quantity) for a CII drug.
    In case of new fill for C-II drug, If Fill quantity = Prescribed quantity then CII Partial Dispensed Count = 0. If Fill quantity < Prescribed quantity CII Partial Dispensed Count = 1.
    In case of second fill for C-II drug If Fill quantity = Prescribed quantity CII Partial Dispensed Count = copy value of CII Partial Dispensed Count for the last RX_TX. If Fill quantity < Prescribed quantity CII Partial Dispensed Count = Increment one to the value CII Partial Dispensed Count for the last RX_TX"
    type: number
    sql: ${TABLE}.SALE_RX_TX_CII_PARTIAL_DISPENSED_COUNT ;;
  }

  dimension: sale_rx_tx_alignment_fill_days_supply {
    label:"Prescription Transaction Alignment Fill Days Supply"
    description:"It signifies the days supply of standard fill received in alignment request from Care Rx. If prescription is filled for days supply different than it then patient medications will not be aligned."
    type: number
    sql: ${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_DAYS_SUPPLY ;;
  }

  dimension: sale_rx_tx_alignment_fill_type_reference {
    label:"Prescription Transaction Alignment Fill Type"
    description:"It identifies type of alignment fill transactions"
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_TYPE ;;
  }

  dimension: sale_rx_tx_alignment_fill_type {
    label:"Prescription Transaction Alignment Fill Type"
    description:"It identifies type of alignment fill transactions"
    type: string
    sql: CASE WHEN to_char(${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_TYPE) IS NULL THEN 'NULL - UNKNOWN'
              WHEN to_char(${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_TYPE) = '1' THEN '1 - STORT FILL TRANSACTION'
              WHEN to_char(${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_TYPE) = '2' THEN '2 - LONG FILL TRANSACTION'
              WHEN to_char(${TABLE}.SALE_RX_TX_ALIGNMENT_FILL_TYPE) = '3' THEN '3 - STANDARD FILL TRANSACTION'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "1 - STORT FILL TRANSACTION", "2 - LONG FILL TRANSACTION", "3 - STANDARD FILL TRANSACTION"]
    suggest_persist_for: "24 hours"
    drill_fields: [sale_rx_tx_alignment_fill_type_reference]
  }

  dimension: sale_rx_tx_is_alignment_fill_request {
    label:"Prescription Transaction Is Alignment Fill Request"
    description:"Yes/No flag indicating if transaction is created as result of alignment fill request from Care Rx"
    type: yesno
    sql: ${TABLE}.SALE_RX_TX_IS_ALIGNMENT_FILL_REQUEST_FLAG = 'Y' ;;
  }

  dimension: sale_rx_tx_immunization_share_flag_reference {
    label:"Prescription Transaction Immunization Share Flag"
    description:"Flag indicating if the Immunization should be shared with the Immunization Registry."
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_IMMUNIZATION_SHARE_FLAG ;;
  }

  dimension: sale_rx_tx_immunization_share_flag {
    label:"Prescription Transaction Immunization Share Flag"
    description:"Flag indicating if the Immunization should be shared with the Immunization Registry."
    type: string
    sql: CASE WHEN ${TABLE}.SALE_RX_TX_IMMUNIZATION_SHARE_FLAG IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.SALE_RX_TX_IMMUNIZATION_SHARE_FLAG = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.SALE_RX_TX_IMMUNIZATION_SHARE_FLAG = 'N' THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [sale_rx_tx_immunization_share_flag_reference]
  }

  dimension: sale_rx_tx_pmp_opioid_treatment_type_reference {
    label:"Prescription Transaction Pmp Opioid Treatment Type"
    description:"This field indicates that the prescription is for opioid dependency treatment or not."
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE ;;
  }

  dimension: sale_rx_tx_pmp_opioid_treatment_type {
    label:"Prescription Transaction Pmp Opioid Treatment Type"
    description:"This field indicates that the prescription is for opioid dependency treatment or not."
    type: string
    sql: CASE WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '01' THEN  '01 - NOT USED FOR OPIOID DEPENDENCY TREATMENT'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '02' THEN  '02 - USED FOR OPIOID DEPENDENCY TREATMENT'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '03' THEN  '03 - PAIN ASSOCIATED WITH ACTIVE AND AFTERCARE CANCER TREATMENT'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '04' THEN  '04 - PALLIATIVE CARE IN CONJUNCTION WITH A SERIOUS ILLNESS'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '05' THEN  '05 - END-OF-LIFE AND HOSPICE CARE'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '06' THEN  '06 - A PREGNANT INDIVIDUAL WITH A PRE-EXISTING PRESCRIPTION FOR OPIOIDS'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '07' THEN  '07 - ACUTE PAIN FOR AN INDIVIDUAL WITH AN EXISTING OPIOID PRESCRIPTION FOR CHRONIC PAIN'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '08' THEN  '08 - INDIVIDUALS PURSUING AN ACTIVE TAPER OF OPIOID MEDICATIONS'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '09' THEN  '09 - PATIENT IS PARTICIPATING IN A PAIN MANAGEMENT CONTRACT'
              WHEN ${TABLE}.SALE_RX_TX_PMP_OPIOID_TREATMENT_TYPE = '99' THEN  '99 - OTHER (TRADING PARTNER AGREED UPON REASON)'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "01 - NOT USED FOR OPIOID DEPENDENCY TREATMENT", "02 - USED FOR OPIOID DEPENDENCY TREATMENT", "03 - PAIN ASSOCIATED WITH ACTIVE AND AFTERCARE CANCER TREATMENT", "04 - PALLIATIVE CARE IN CONJUNCTION WITH A SERIOUS ILLNESS", "05 - END-OF-LIFE AND HOSPICE CARE", "06 - A PREGNANT INDIVIDUAL WITH A PRE-EXISTING PRESCRIPTION FOR OPIOIDS", "07 - ACUTE PAIN FOR AN INDIVIDUAL WITH AN EXISTING OPIOID PRESCRIPTION FOR CHRONIC PAIN", "08 - INDIVIDUALS PURSUING AN ACTIVE TAPER OF OPIOID MEDICATIONS", "09 - PATIENT IS PARTICIPATING IN A PAIN MANAGEMENT CONTRACT", "99 - OTHER (TRADING PARTNER AGREED UPON REASON)"]
    suggest_persist_for: "24 hours"
    drill_fields: [sale_rx_tx_pmp_opioid_treatment_type_reference]
  }

  dimension: sale_rx_tx_require_id_pickup_dropoff_qualifier_reference {
    label:"Prescription Transaction Require Id Pickup Dropoff Qualifier"
    description:"Flag to identify if the pick up /drop off qualifier is a mandatory field."
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER ;;
  }

  dimension: sale_rx_tx_require_id_pickup_dropoff_qualifier {
    label:"Prescription Transaction Require Id Pickup Dropoff Qualifier"
    description:"Flag to identify if the pick up /drop off qualifier is a mandatory field."
    type: string
    sql: CASE WHEN ${TABLE}.SALE_RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.SALE_RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'Y' THEN 'Y - HAVE TO GET THE PICKUP INFO'
              WHEN ${TABLE}.SALE_RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'N' THEN 'N - DO NOT NEED THE PICKUP INFO'
              WHEN ${TABLE}.SALE_RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'D' THEN 'D - DONE WITH THE PICKUP INFO COLLECTION'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - HAVE TO GET THE PICKUP INFO", "N - DO NOT NEED THE PICKUP INFO", "D - DONE WITH THE PICKUP INFO COLLECTION"]
    suggest_persist_for: "24 hours"
    drill_fields: [sale_rx_tx_require_id_pickup_dropoff_qualifier_reference]
  }

  dimension: sale_rx_tx_pv_double_count_performed {
    label:"Prescription Transaction PV Double Count Performed"
    description:"Prescription Transaction PV Double Count Performed"
    type: string
    sql: ${TABLE}.SALE_RX_TX_PV_DOUBLE_COUNT_PERFORMED ;;
  }

  dimension_group: sale_rx_tx_counseling_completion {
    label:"Prescription Transaction Counseling Completion"
    description:"Date/Time when the counseling is completed on a particular transaction."
    type: time
    sql: ${TABLE}.SALE_RX_TX_COUNSELING_COMPLETION_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: sale_rx_tx_change_billing  {
    label:"Prescription Transaction Change Billing"
    description:"Prescription Transaction Change Billing. 'Y' signifies change billing was performed at will call.'N' Signifies change billing was performed at will call -> adjudication failed -> user chose 'Use Original Billing'. No situation tracks successful/unsuccessful adjudication. If 'Use Original Billing' is used, then corresponding rx_tx_id will get the value as 'Y' and this ID will get deactivated. The original RX_TX_ID will get the value as 'N' that will signify that change billing was performed at will call -> adjudication failed -> user chose 'Use Original Billing'. NULL value stands for Change Billing hasn’t been done/attempted"
    type: string
    sql: ${TABLE}.SALE_RX_TX_CHANGE_BILLING ;;
  }

  dimension: sale_rx_tx_last_foreground_rph_employee_number {
    label:"Prescription Transaction Last Foreground Rph Employee Number"
    description:"Inserted by code and is populated only when a transaction has completed data verification (In work flow) or fulfillment/RPh verification (In Rapid fill) in background."
    type: string
    sql: sha2(${TABLE}.SALE_RX_TX_LAST_FOREGROUND_RPH_EMPLOYEE_NUMBER) ;;
  }

  dimension: sale_rx_tx_ship_to_provider_address_only {
    label:"Prescription Transaction Ship To Provider Address Only"
    description:"Prescription Transaction Ship To Provider Address Only"
    type: string
    sql: ${TABLE}.SALE_RX_TX_SHIP_TO_PROVIDER_ADDRESS_ONLY ;;
  }

  dimension: sale_rx_tx_tax_code_id {
    label:"Prescription Transaction Tax Code Id"
    hidden: yes
    type: number
    sql: ${TABLE}.SALE_RX_TX_TAX_CODE_ID ;;
  }

  dimension: sale_rx_tx_initial_sale_rx_tx_id {
    label:"Prescription Transaction Initial Rx Tx Id"
    hidden: yes
    type: number
    sql: ${TABLE}.SALE_RX_TX_INITIAL_SALE_RX_TX_ID ;;
  }

  dimension: sale_rx_tx_subsequent_sale_rx_tx_id {
    label:"Prescription Transaction Subsequent Rx Tx Id"
    hidden: yes
    type: number
    sql: ${TABLE}.SALE_RX_TX_SUBSEQUENT_SALE_RX_TX_ID ;;
  }

  dimension: sale_rx_tx_used_in_insulin_pump_reference {
    label:"Prescription Transaction Used In Insulin Pump"
    description:"Prescription Transaction Used In Insulin Pump. Set when using rx edit#23"
    type: string
    hidden: yes
    sql: ${TABLE}.SALE_RX_TX_USED_IN_INSULIN_PUMP ;;
  }

  dimension: sale_rx_tx_used_in_insulin_pump {
    label:"Prescription Transaction Used In Insulin Pump"
    description:"Prescription Transaction Used In Insulin Pump. Set when using rx edit#23"
    type: string
    sql: CASE WHEN ${TABLE}.SALE_RX_TX_USED_IN_INSULIN_PUMP IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.SALE_RX_TX_USED_IN_INSULIN_PUMP = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.SALE_RX_TX_USED_IN_INSULIN_PUMP = 'N' THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [sale_rx_tx_used_in_insulin_pump_reference]
  }

  measure: sum_sale_rx_tx_patient_pay_amount {
    label:"Prescription Transaction Patient Pay Amount"
    description:"Holds the final amount a patient owes to the pharmacy. If the rx has been priced to a tp, the value in this field will exactly match with tx_tp.received_copay. This is the NCPDP 505-F5 patient pay/patient net pay/balance due from patient value. for a cash rx, the value stored here will be calculated as generic_price - generic_discount + tax_amount. For brand or compound the value stored here will be calculated as rx_tx.brand_price – rx_tx.brand_discount + rx_tx.tax_amount"
    type: sum
    sql: NVL(CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${TABLE}.SALE_RX_TX_PATIENT_PAY_AMOUNT
            END,0)  ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: sale_rx_tx_network_plan_bill {
    label:"Prescription Transaction Network Plan Bill"
    description:"Date/Time of Prescription Transaction Network Plan Bill"
    type: time
    sql: ${TABLE}.SALE_RX_TX_NETWORK_PLAN_BILL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  measure: sum_sale_rx_tx_expected_completion_patient_pay_amount {
    label:"Prescription Transaction Expected Completion Patient Pay Amount"
    description:"Estimated Patient pay for total fill on partial fill."
    type: sum
    sql: NVL(CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${TABLE}.SALE_RX_TX_EXPECTED_COMPLETION_PATIENT_PAY_AMOUNT
            END,0)  ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: sale_rx_alignment_start_date {
    label: "Alignment Start"
    description: "Prescription alignment start date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SALE_RX_ALIGNMENT_START_DATE ;;
  }

  dimension: sale_rx_is_patient_auto_selected {
    label: "Patient Auto Selected"
    description: "Yes/No flag indicating whether the patient was auto selected"
    type: yesno
    sql: ${TABLE}.SALE_RX_IS_PATIENT_AUTO_SELECTED = 'Y' ;;
  }

  dimension_group: sale_rx_sync_script_refused_date {
    label: "Sync Script Refused"
    description: "Prescription sync script refused date"
    type: time
    timeframes: [time,date,week,day_of_week,day_of_week_index,month,month_num,month_name,day_of_month,quarter,quarter_of_year,year,day_of_year,week_of_year]
    sql: ${TABLE}.SALE_RX_SYNC_SCRIPT_REFUSED_DATE ;;
  }
  #ERXDWPS-7510 - Sync EPS RX_TX_LINK,RX_SUMMARY changes to EDW F_SALE and F_SALE_ARCHIVE | End

  #[ERXDWPS-7020] - Pharmacy drug cost related dimensions
  dimension: awp_ingredient_cost_pct_store {
    label: "AWP Ingredient Cost % - Pharmacy"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Pharmacy. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - Pharmacy )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_awp_cost_amount_at_fill_store_reference},0),6) ;;
    value_format: "00.0000%"
  }

  dimension: wac_ingredient_cost_pct_store {
    label: "WAC Ingredient Cost % - Pharmacy"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Pharmacy. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - Pharmacy )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_wac_cost_amount_at_fill_store_reference},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_awp_ingredient_cost_pct_store {
    label: "AWP Ingredient Cost % - Pharmacy"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Pharmacy. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - Pharmacy )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_awp_cost_amount_at_fill_store},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_wac_ingredient_cost_pct_store {
    label: "WAC Ingredient Cost % - Pharmacy"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Pharmacy. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - Pharmacy )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_wac_cost_amount_at_fill_store},0),6) ;;
    value_format: "00.0000%"
  }

  #[ERXDWPS-7020] - Host drug cost related dimensions
  dimension: awp_ingredient_cost_pct_host {
    label: "AWP Ingredient Cost % - HOST"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Host. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - HOST )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_awp_cost_amount_at_fill_host_reference},0),6) ;;
    value_format: "00.0000%"
  }

  dimension: wac_ingredient_cost_pct_host {
    label: "WAC Ingredient Cost % - HOST"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Host. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - HOST )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${rx_tx_wac_cost_amount_at_fill_host_reference},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_awp_ingredient_cost_pct_host {
    label: "AWP Ingredient Cost % - HOST"
    description: "Ingredient Cost percentage based on AWP Cost at the time of fill at Host. Calculation Used: ( Response Detail Ingredient Amount / AWP at time of fill - HOST )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_awp_cost_amount_at_fill_host},0),6) ;;
    value_format: "00.0000%"
  }

  measure: sum_wac_ingredient_cost_pct_host {
    label: "WAC Ingredient Cost % - HOST"
    description: "Ingredient Cost percentage based on WAC Cost at the time of fill at Host. Calculation Used: ( Response Detail Ingredient Amount / WAC at time of fill - HOST )"
    type: number
    sql: ROUND(${eps_tx_tp_response_detail.sum_sales_tx_tp_response_detail_ingredient_amount}/NULLIF(${sum_rx_tx_wac_cost_amount_at_fill_host},0),6) ;;
    value_format: "00.0000%"
  }

  #################################################################################################################
  #           [ERXDWPS-8260] COSTCO SOW - Moving Average Cost - Sales Looker Dimensions and Measures              #
  #                        START MVAC based dimensions, measures and filters                                      #
  #################################################################################################################

    dimension: moving_average_cost {
      label: "Moving Average Cost"
      description: "Represents the total Moving Average Cost (MVAC) at fill date, of filled drug used on the prescription transaction record"
      type: number
      hidden: yes
      sql: NVL(CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                    THEN
                         CASE WHEN ${financial_category} IN ('CASH - FILLED', 'PARTIAL - FILLED', 'T/P - FILLED')
                              THEN ${store_rx_tx_detail_flatten.rx_tx_total_moving_average_cost_at_fill_date}
                              WHEN ${financial_category} IN ('CASH - CREDIT', 'PARTIAL - CREDIT', 'T/P - CREDIT')
                              THEN ${store_rx_tx_detail_flatten.rx_tx_total_moving_average_cost_at_fill_date}*-1
                         END
                END,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: moving_average_cost_per_unit {
      label: "Tx Moving Average Cost Per Unit"
      description: "Represents the per unit Moving Average Cost (MVAC) at fill date, of filled drug used on the prescription transaction record"
      type: number
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                THEN ${store_rx_tx_detail_flatten.rx_tx_moving_average_cost_per_unit_at_fill_date}
           END ;;
      value_format: "$#,##0.0000000;($#,##0.0000000)"
    }

    dimension: moving_average_cost_after_sold {
      label: "Moving Average Cost After Sold"
      description: "Represents the total Moving Average Cost (MVAC)(after Sold) of filled drug used on the prescription transaction record"
      type: number
      hidden: yes
      sql: NVL(CASE WHEN ${after_adjudicated_flg} = 'Y' AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
                    THEN
                         CASE WHEN ${financial_category} IN ('CASH - FILLED', 'PARTIAL - FILLED', 'T/P - FILLED')
                              THEN ${store_rx_tx_detail_flatten.rx_tx_total_moving_average_cost_at_fill_date}
                              WHEN ${financial_category} IN ('CASH - CREDIT', 'PARTIAL - CREDIT', 'T/P - CREDIT')
                              THEN ${store_rx_tx_detail_flatten.rx_tx_total_moving_average_cost_at_fill_date}*-1
                         END
               END,0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    dimension: gross_margin_mvac {
      label: "Gross Margin (MVAC)"
      description: "Gross Margin (MVAC) of prescription. MVAC Calculation Used: Price of the Prescription - Moving Average Cost"
      type: number
      hidden: yes
      sql: CASE WHEN (${adjudicated_flg} = 'Y' or ${sold_flg}= 'Y') AND NVL(${sales_tx_tp.tx_tp_first_counter},1) = 1
             THEN (${TABLE}.SALE_PRICE - ${moving_average_cost})
             ELSE 0
        END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    filter: gross_margin_filter_mvac {
      label: "Gross Margin $ (MVAC) \"Filter Only\""
      description: "Gross Margin (MVAC) of prescription. MVAC Calculation Used: Price of the Prescription - Moving Average Cost"
      type: number
      sql: {% condition gross_margin_filter_mvac %} ${gross_margin} {% endcondition %} ;;
    }

    dimension: gross_margin_after_sold_mvac {
      label: "Gross Margin After Sold (MVAC)"
      description: "Gross Margin (MVAC) of prescription after sold. MVAC Calculation Used: Price of the Prescription After Sold - Moving Average Cost After Sold"
      type: number
      hidden: yes
      sql: CASE WHEN ${sold_flg} = 'Y' THEN ${gross_margin} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

    measure: avg_moving_average_cost {
      label: "Avg Moving Average Cost"
      group_label: "Moving Average Cost"
      description: "Average Moving Average Cost (MVAC) of filled drug. MVAC Calculation Used: Moving Average Cost/Total no. of scripts"
      type: number
      sql: COALESCE(${sum_moving_average_cost}/NULLIF(${count},0),0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_moving_average_cost {
      label: "Moving Average Cost"
      group_label: "Moving Average Cost"
      type: sum
      description: "Represents the total Moving Average Cost (MVAC), for this year, of the filled drug used on the prescription transaction record"
      sql: ${moving_average_cost}  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_gross_margin_mvac {
      label: "Gross Margin (MVAC)"
      group_label: "Gross Margin"
      description: "Gross Margin (MVAC) of prescription. MVAC Calculation Used: Price of the Prescription - Moving Average Cost"
      type: sum
      sql: ${gross_margin} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_gross_margin_after_sold_mvac {
      label: "Gross Margin After Sold (MVAC)"
      group_label: "Gross Margin"
      description: "Gross Margin (MVAC) of prescription after sold. MVAC Calculation Used: Price of the Prescription - Moving Average Cost"
      type: sum
      hidden: yes
      sql: ${gross_margin_after_sold} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_gross_margin_mvac {
      label: "Avg Gross Margin (MVAC)"
      group_label: "Gross Margin"
      description: "Average Gross Margin (MVAC) of prescription. MVAC Calculation Used: (Total Price of the Prescription - Total Moving Average Cost)/Total no. of scripts"
      type: number
      sql: ${sum_gross_margin}/NULLIF(${count},0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_gross_margin_pct_mvac {
      label: "Gross Margin % (MVAC)"
      group_label: "Gross Margin"
      description: "Gross Margin % (MVAC) of prescription. MVAC Calculation Used: (Price of the Prescription - Moving Average Cost)/Price of the Prescription"
      type: number
      sql: ${sum_gross_margin}/NULLIF(${sum_price},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    dimension: net_gross_margin_mvac {
      label: "Net Margin $ (MVAC)"
      hidden:  yes #used in templated filter
      group_label: "Net Margin $"
      description: "Net Margin (MVAC) of prescription, based on Net Sales. MVAC Calculation Used: Net Sales of the Prescription - Moving Average Cost"
      type: number
      sql: ${net_sales} -  ${moving_average_cost} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    filter: net_gross_margin_filter_mvac {
      label: "Net Margin $ (MVAC) \"Filter Only\""
      description: "Net Margin (MVAC) of prescription, based on Net Sales. MVAC Calculation Used: Net Sales of the Prescription - Moving Average Cost"
      type: number
      sql: {% condition net_gross_margin_filter_mvac %} ${net_gross_margin} {% endcondition %} ;;
    }

    measure: sum_net_gross_margin_mvac {
      label: "Net Margin $ (MVAC)"
      group_label: "Net Margin $"
      description: "Net Margin (MVAC) of prescription, based on Net Sales. MVAC Calculation Used: Net Sales of the Prescription - Moving Average Cost"
      type: sum
      sql: ${net_gross_margin} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_after_sold_mvac {
      label: "RNAC $ (MVAC)"
      group_label: "RNAC $"
      description: "Net Margin (MVAC) of prescription, based on Net Sales After Sold. MVAC Calculation Used: Net Sales After Sold - Moving Average Cost After Sold"
      type: sum
      hidden: yes
      sql: ( ${net_sales_after_sold} -  ${moving_average_cost_after_sold} )  ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: avg_net_gross_margin_after_sold_mvac {
      label: "Avg Net Margin After Sold (MVAC)"
      group_label: "Other Measures"
      hidden: yes
      description: "Net Margin (MVAC) of prescription, based on Net Sales after sold. MVAC Calculation Used: (Net Sales After Sold - Moving Average Cost After Sold)/Total no. of scripts"
      type: number
      sql: ${sum_net_gross_margin_after_sold}/NULLIF(${count},0) ;;
      value_format: "$#,##0.00;($#,##0.00)"
      html: {% if value < 0 %}
                      <font color="red">{{ rendered_value }}
                    {% else %}
                      <font color="grey">{{ rendered_value }}
                    {% endif %}
                    ;;
    }

    measure: sum_net_gross_margin_pct_mvac {
      label: "Net Margin % (MVAC)"
      group_label: "Net Margin %"
      description: "Net % Margin (MVAC) of prescription, based on Net Sales. MVAC Calculation Used: ( (Net Sales of the Prescription - Moving Average Cost)/Net Sales of the Prescription )"
      type: number
      sql: CAST((${sum_net_sales} -  ${sum_moving_average_cost}) AS DECIMAL(17,4))/NULLIF(${sum_net_sales},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_moving_average_cost_after_sold_ty {
      label: "Moving Average Cost After Sold"
      group_label: "Moving Average Cost After Sold"
      description: "Represents the total Moving Average Cost (MVAC) after sold, for this year, of the filled drug used on the prescription transaction record"
      type: sum
      hidden: yes
      sql: ${moving_average_cost_after_sold} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_after_sold_pct_mvac {
      label: "RNAC % (MVAC)"
      group_label: "RNAC %"
      description: "Net % Margin (MVAC) of prescription, based on Net Sales After Sold. MVAC Calculation Used: ( (Net Sales of the Prescription - Moving Average Cost)/Net Sales of the Prescription )"
      type: number
      hidden: yes
      sql: CAST((${sum_net_sales_after_sold} -  ${sum_moving_average_cost_after_sold_ty}) AS DECIMAL(17,4))/NULLIF(${sum_net_sales_after_sold},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_specialty_gross_margin_mvac {
      label: "Net Specialty Margin $ (MVAC)"
      group_label: "Specialty Margin"
      description: "Net Specialty Margin (MVAC) of prescription, based on Net Sales.(MVAC Calculation Used: Net Sales of the Prescription - Moving Average Cost)"
      type: sum
      sql: CASE WHEN   ${store_drug.drug_specialty} = 'Y' THEN ${net_sales} -  ${moving_average_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_cash_margin_mvac {
      label: "Cash Margin $ (MVAC)"
      group_label: "Margin $"
      description: "Cash Margin (MVAC) of prescription. MVAC Calculation Used: Cash Price of the Prescription - Moving Average Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'N' THEN ${price} - ${moving_average_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_cash_margin_pct_mvac {
      label: "Cash Gross Margin % (MVAC)"
      group_label: "Other Margin %"
      description: "Cash Margin % (MVAC) of prescription. MVAC Calculation Used: (Cash Price of the Prescription - Moving Average Cost)/Cash Price of the Prescription"
      type: number
      sql: ${sum_cash_margin}/NULLIF(${sum_price_cash},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tp_margin_mvac {
      label: "T/P Margin $ (MVAC)"
      group_label: "Margin $"
      description: "Third Party Margin (MVAC) of prescription. MVAC Calculation Used: Third Party Price of the Prescription - Moving Average Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN  ${TABLE}.SALE_TP_BILL = 'Y' THEN ${price} - ${moving_average_cost} END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_tp_margin_pct_mvac {
      label: "T/P Gross Margin % (MVAC)"
      group_label: "Other Margin %"
      description: "Third Party Margin % (MVAC) of prescription. MVAC Calculation Used: (Third Party Price of the Prescription - Moving Average Cost)/Third Party Price of the Prescription"
      type: number
      sql: ${sum_tp_margin}/NULLIF(${sum_price_tp},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_generic_margin_mvac {
      label: "Generic Margin $ (MVAC)"
      group_label: "Margin $"
      description: "Generic Margin (MVAC) of prescription. MVAC Calculation Used: Generic Price of the Prescription - Moving Average Cost. For EPS Stores, by default generic price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${price} - ${moving_average_cost} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price} - ${moving_average_cost}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
                THEN ${price} - ${moving_average_cost}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_generic_margin_pct_mvac {
      label: "Generic Gross Margin % (MVAC)*"
      group_label: "Other Margin %"
      description: "Generic Margin % (MVAC) of prescription. MVAC Calculation Used: (Generic Price of the Prescription - Moving Average Cost)/Generic Price of the Prescription.  For EPS Stores, by default generic price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_generic_margin}/NULLIF(${sum_price_generic},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_brand_margin_mvac {
      label: "Brand Margin $ (MVAC)"
      group_label: "Margin $"
      description: "Brand Margin (MVAC) of prescription. MVAC Calculation Used: Brand Price of the Prescription - Moving Average Cost"
      type: sum
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
                THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${price} - ${moving_average_cost} END
                WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price} - ${moving_average_cost}
                WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
                THEN ${price} - ${moving_average_cost}
           END ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_brand_margin_pct_mvac {
      label: "Brand Gross Margin % (MVAC)*"
      group_label: "Other Margin %"
      description: "Brand Margin % (MVAC) of prescription. MVAC Calculation Used: (Brand Price of the Prescription - Moving Average Cost)/Brand Price of the Prescription. For EPS Stores, by default brand price is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_brand_margin}/NULLIF(${sum_price_brand},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    dimension: net_gross_margin_brand_reference_mvac {
      label: "Brand Net Gross Margin $ (MVAC)"
      description: "Brand Net Margin (MVAC) of prescription, based on brand Net Sales. MVAC Calculation Used: Brand Net Sales of the Prescription - Moving Average Cost. For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
              THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'B' THEN ${net_sales} - ${moving_average_cost} END
              WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} <> 'Y'
              THEN ${net_sales} - ${moving_average_cost}
              WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} <> 'Y'
              THEN ${net_sales} - ${moving_average_cost}
         END ;;
    }

    measure: sum_net_gross_margin_brand_mvac {
      label: "Brand Net Margin $ (MVAC)*"
      group_label: "Margin $"
      description: "Brand Net Margin (MVAC) of prescription, based on Brand Net Sales. MVAC Calculation Used: Brand Net Sales of the Prescription - Moving Average Cost. For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: ${net_gross_margin_brand_reference} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_brand_pct_mvac {
      label: "Brand Net Margin % (MVAC)*"
      group_label: "Other Margin %"
      description: "Brand Net % Margin (MVAC) of prescription, based on Brand Net Sales. MVAC Calculation Used: ( (Brand Net Sales of the Prescription - Moving Average Cost)/Brand Net Sales of the Prescription ). For EPS Stores, by default brand net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_net_gross_margin_brand}/NULLIF(${sum_net_sales_brand},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    dimension: net_gross_margin_generic_reference_mvac {
      label: "Generic Net Gross Margin $ (MVAC)"
      description: "Generic Net Margin (MVAC) of prescription, based on Generic Net Sales. MVAC Calculation Used: Generic Net Sales of the Prescription - Moving Average Cost. For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      hidden: yes
      sql: CASE WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'DRUG DISPENSED' {% endcondition %}
              THEN CASE WHEN ${TABLE}.SALE_DRUG_DISPENSED = 'G' THEN ${net_sales} - ${moving_average_cost} END
              WHEN ${source_system_id} = 4 AND {% condition drug_brand_generic_measures_classification_filter %} 'MULTI SOURCE' {% endcondition %} AND ${store_drug_multi_source_reference} = 'Y'
              THEN ${net_sales} - ${moving_average_cost}
              WHEN ${source_system_id} = 11 AND ${store_drug_multi_source_reference} = 'Y'
              THEN ${net_sales} - ${moving_average_cost}
             END ;;
    }

    measure: sum_net_gross_margin_generic_mvac {
      label: "Generic Net Margin $ (MVAC)*"
      group_label: "Margin $"
      description: "Generic Net Margin (MVAC) of prescription, based on Generic Net Sales. MVAC Calculation Used: Generic Net Sales of the Prescription - Moving Average Cost. For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: sum
      sql: ${net_gross_margin_generic_reference} ;;
      value_format: "$#,##0.00;($#,##0.00)"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    measure: sum_net_gross_margin_generic_pct_mvac {
      label: "Generic Net Margin % (MVAC)*"
      group_label: "Other Margin %"
      description: "Generic Net % Margin (MVAC) of prescription, based on Generic Net Sales. MVAC Calculation Used: ( (Generic Net Sales of the Prescription - Moving Average Cost)/Generic Net Sales of the Prescription ). For EPS Stores, by default generic net sales is calculated based on DRUG DISPENSED (BRAND/GENERIC/COMPOUND). Users can choose MULTI SOURCE or DRUG DISPENSED for EPS Stores using Drug Brand/Generic Measures Source filter."
      type: number
      sql: ${sum_net_gross_margin_generic}/NULLIF(${sum_net_sales_generic},0) ;;
      value_format: "00.00%"
      drill_fields: [sales_transaction_level_drill_path*]
    }

    # moving_average_cost_per_unit is already explosed above. so this one is not needed.
    #dimension: drug_mvac_per_unit_amount_store {
    #  label: "Drug Moving Average Cost Per Unit Amount At Fill - Pharmacy"
    #  description: "Represents the Moving Average Cost (MVAC) of the Pharmacy Drug Per Unit Amount at the time of fill. MVAC Calculation Used: Pharmacy Drug Moving Average Cost Amount/Decimal Pack Size. This field is EPS only!!!"
    #  type: number
    #  sql: ${moving_average_cost_per_unit} ;;
    #  value_format: "$#,##0.0000000;($#,##0.0000000)"
    #}

    measure: sum_rx_tx_mvac_amount_at_fill_store {
      label: "Total Moving Average Cost Amount At Fill"
      description: "Represents the Pharmacy Moving Average Cost (MVAC) of the Prescription Transaction based on the Fill Quantity and the Drug Moving Average Cost at the time of fill. MVAC Calculation Used: Pharmacy Drug Moving Average Cost Per Unit * Prescription Transaction Fill Quantity. This field is EPS only!!!"
      type: sum
      group_label: "Drug Cost at Fill"
      sql: ${moving_average_cost} ;;
      value_format: "$#,##0.00;($#,##0.00)"
    }

  #################################################################################################################
  #           [ERXDWPS-8260] COSTCO SOW - Moving Average Cost - Sales Looker Dimensions and Measures              #
  #                          END MVAC based dimensions, measures and filters                                      #
  #################################################################################################################

    set: sales_transaction_level_drill_path {
      fields: [
        chain.chain_name,
        store_alignment.division,
        store_alignment.region,
        store_alignment.district,
        store.store_number,
        eps_rx.rx_number,
        rx_tx_tx_number,
        financial_category,
        rx_tx_tx_status,
        rx_tx_fill_status,
        reportable_sales_date,
        filled_date,
        sold_date,
        returned_date,
        store_drug.drug_name,
        store_drug.ndc,
        sum_final_copay,
        sum_net_due,
        sum_rx_tx_uc_price,
        sum_price,
        sum_acquisition_cost,
        sum_gross_margin,
        sum_net_sales
      ]
    }

    set: explore_rx_measure_4_10_candidate_list {
      fields: [
        sum_compound_ingredient_tx_quantity_used,
        sum_compound_ingredient_tx_base_cost,
        sum_compound_ingredient_tx_acquisition_cost,
        #count_transfer_pct
      ]
    }
  }

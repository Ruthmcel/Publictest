view: mds_store {
  sql_table_name: EDW.D_STORE ;;

  dimension: chain_id {
    # This field is not exposed at this time, is being exposed by ARS. Use this in Join.
    hidden: yes
    label: "MDS Pharmacy Chain ID"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    # This field is not exposed at this time, is being exposed by ARS. Use this in Join.
    hidden: yes
    label: "MDS Pharmacy NHIN Store ID"
    type: number
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################

  ## CHAIN_ID is also a foreign Key, but also part of the primary key.

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  dimension_group: last_ndc_request {
    label: "Pharmacy Last NDC Request"
    description: "Date/time indicating when this Pharmacy last requested NDC's from MDS. Pulled NDC's from MDS are linked to PDX-MS Programs"
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
    sql: ${TABLE}.STORE_LAST_NDC_REQUEST_DATE ;;
  }

  dimension_group: last_icu_request {
    label: "Pharmacy Last ICU Request"
    description: "Date/time indicating when this Pharmacy last requested Independent Cost Updates from MDS"
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
    sql: ${TABLE}.STORE_LAST_ICU_PULL_DATE ;;
  }

  dimension_group: last_medguide_request {
    label: "Pharmacy Last MedGuide Request"
    description: "Date/time indicating when this Pharmacy last requested an update for MedGuides from MDS"
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
    sql: ${TABLE}.STORE_LAST_MEDGUIDE_PULL_DATE ;;
  }

  dimension_group: last_mds_request {
    label: "Pharmacy Last MDS Request"
    description: "Date/time indicating when this Pharmacy last requested an update from MDS. The requested update could have been for NDC's or Medguides"
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
    sql: ${TABLE}.STORE_LAST_MDS_PULL_DATE ;;
  }

  dimension_group: last_inventory_adjustment_request {
    label: "Pharmacy Last Inventory Adjustment Request"
    description: "Date/time indicating when this Pharmacy last requested an update for Inventory Adjustment from MDS"
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
    sql: ${TABLE}.STORE_LAST_INVENTORY_ADJUSTMENT_PULL_DATE ;;
  }

  dimension_group: last_reorder_request {
    label: "Pharmacy Last ReOrder Request"
    description: "Date/time indicating when this Pharmacy last requested an update for ReOrder from MDS"
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
    sql: ${TABLE}.STORE_LAST_REORDER_PULL_DATE ;;
  }

  dimension_group: last_login_alert_request {
    label: "Pharmacy Last Login Alert Request"
    description: "Date/time indicating when this Pharmacy last requested an update for Login Alert from MDS"
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
    sql: ${TABLE}.STORE_LAST_LOGIN_ALERT_PULL_DATE ;;
  }

  dimension_group: last_alert_notify_request {
    label: "Pharmacy Last Alert Notify Request"
    description: "Date/time indicating when this Pharmacy last requested an update for Alert Notify from MDS"
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
    sql: ${TABLE}.STORE_LAST_ALERT_NOTIFY_REQUEST_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: mds_registered {
    label: "Pharmacy MDS Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for MDS"
    type: yesno
    sql: ${TABLE}.STORE_MDS_REGISTERED = 'Y' ;;
  }

  dimension: icu_registered {
    label: "Pharmacy ICU Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for Independent Cost Updates from MDS"
    type: yesno
    sql: ${TABLE}.STORE_ICU_REGISTERED = 'Y' ;;
  }

  dimension: medguide_registered {
    label: "Pharmacy MedGuide Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for MedGuides from MDS via Medispan"
    type: yesno
    sql: ${TABLE}.STORE_MEDGUIDE_REGISTERED = 'Y' ;;
  }

  dimension: mds_audit_log_enabled {
    label: "Pharmacy MDS Audit Log Enabled"
    description: "Yes/No flag indicating if the Pharmacy is enabled for the MDS Audit Log"
    type: yesno
    sql: ${TABLE}.STORE_AUDIT_LOG_ENABLED = 'Y' ;;
  }

  dimension: inventory_adjustment_registered {
    label: "Pharmacy Inventory Adjustment Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for Inventory Adjustment. Used by KP"
    type: yesno
    sql: ${TABLE}.STORE_INVENTORY_ADJUSTMENT_REGISTERED = 'Y' ;;
  }

  dimension: patient_education_registered {
    label: "Pharmacy Patient Education Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for Patient Education"
    type: yesno
    sql: ${TABLE}.STORE_PATIENTED_REGISTERED = 'Y' ;;
  }

  dimension: reorder_registered {
    label: "Pharmacy Reorder Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for Reorder"
    type: yesno
    sql: ${TABLE}.STORE_REORDER_REGISTERED = 'Y' ;;
  }

  dimension: store_login_alert_registered {
    label: "Pharmacy Login Alert Registered"
    description: "Yes/No flag indicating if the Pharmacy is registered for the Store Login Alert"
    type: yesno
    sql: ${TABLE}.STORE_LOGIN_ALERT_REGISTERED = 'Y' ;;
  }

  dimension: patient_status_registered {
    label: "Pharmacy Patient Status Registered"
    description: "Yes/No flag indicating if the Pharmacy is Registered for the Patient Status service"
    type: yesno
    sql: ${TABLE}.STORE_PATIENT_STATUS_REGISTERED = 'Y' ;;
  }
}

################################################################################################## End of Dimensions #################################################################################################

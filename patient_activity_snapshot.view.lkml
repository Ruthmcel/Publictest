view: patient_activity_snapshot {
  # Added Liquid Variable logic to choose table based on user report. Removed chain_id condition check from below sql_table_name logic. Chain_id filter will be added to customer reports by defaults based on chain_id access filter.
  # Only required columns are added in unique_key dimension. patient_activity_grain is used to filter the records at join level and not required in PK dimension.
  # Activity type is a dimension which will be utilized in filters when we expose this view in Sales explore. Currently SOLD is the only activity and do not required to add it to PK dimension.
  # Customer calendar will be FISCAL/STANDARD. So Period_type is not required as part of PK dimension.
  # Period_grain/period/period_begin_date one of these will uniquely identify record. Adding one of them to PK dimension will be sufficient.

  sql_table_name:
    {% if patient_activity_snapshot.rx_com_id._in_query %}
      EDW.F_PATIENT_ACTIVITY_DETAIL_SNAPSHOT
    {% else %}
      EDW.F_PATIENT_ACTIVITY_SUMMARY_SNAPSHOT
    {% endif %}
    ;;

    dimension: unique_key {
      hidden: yes
      primary_key: yes
      type: string
      #Add Liquid Variable logic to choose primary_key.
      sql: ${chain_id} ||'@'||
           {% if patient_activity_snapshot.rx_com_id._in_query %} ${rx_com_id} {% else %} '1' {% endif %} ||'@'||
           ${patient_activity_grain}  ||'@'||
           ${patient_activity_grain_identifier} ||'@'||
           ${activity_type} ||'@'||
           ${period_type} ||'@'||
           ${period_grain} ||'@'||
           ${period} ||'@'||
           ${period_begin_date} ;;
    }

    dimension: chain_id {
      hidden: yes
      type: number
      sql: ${TABLE}.CHAIN_ID ;;
    }

    dimension: rx_com_id {
      label: "Central Patient RX COM ID"
      description: "Patient unique identifier"
      hidden: yes
      type: number
      #No extra logic required. Whenever user select rx_com_id it should change to DETAIL table.
      sql: ${TABLE}.RX_COM_ID ;;
    }

    dimension: patient_activity_grain {
      label: "Patient Activity Grain*"
      description: "CHAIN/STORE based on report. When a user runs a report using Pharmacy Number or NHIN Store ID, the Patient Activity Grain is 'STORE'. When a report is run without Pharmacy Number or NHIN Store ID, the report grain is 'CHAIN'. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: string
      hidden: yes
      sql: ${TABLE}.PATIENT_ACTIVITY_GRAIN ;;
    }

    dimension: patient_activity_grain_identifier {
      label: "Patient Activity Grain Identifier*"
      description: "CHAIN/NHIN Store ID information based on report grain. When a user runs a report using Pharmacy Number or NHIN Store ID, the grain identifier is NHIN Store ID. When a report is run without Pharmacy Number or NHIN Store ID, the grain identifier is CHAIN ID. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: string
      hidden: yes
      sql: ${TABLE}.PATIENT_ACTIVITY_GRAIN_IDENTIFIER ;;
    }

    dimension: activity_type {
      label: "Activity Type*"
      description: "Information about what date is used as driver to calculate Patient Activity informtion. Ex: SOLD/REPORTABLE SALES/FILLED/RETURNED. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: string
      hidden: yes
      sql: ${TABLE}.ACTIVITY_TYPE ;;
    }

    dimension: period_type {
      label: "Period Type*"
      description: "Customer calendar information. Ex: FISCAL/STANDARD. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: string
      hidden: yes
      sql: ${TABLE}.PERIOD_TYPE ;;
    }

    dimension: period_grain {
      label: "Period Grain*"
      description: "Grain of the customer calendar. Ex: MONTH, WEEK. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      hidden: yes
      type: string
      sql: ${TABLE}.PERIOD_GRAIN ;;
    }

    #[ERXDWPS-6272] Exposed in Patient Activity Explore. (Remvoed hidden: yes).
    dimension: period {
      label: "Period*"
      description: "Customer calendar period grain unique identifier. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: number
      sql: ${TABLE}.PERIOD ;;
      value_format: "0"
    }

    dimension_group: period_begin {
      label: "Period Begin*"
      description: "Begin date of the customer calendar period grain identifier. This dimension must be used in conjunction with Patient Activity view label measure(s)."
      type: time
      timeframes: [date] #[ERXDWPS-6272] Removed Month timeframe.
      sql: ${TABLE}.PERIOD_BEGIN_DATE ;;
    }

    dimension: source_system_id {
      label: "Source System ID"
      hidden: yes
      type: number
      sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
    }

    dimension: patient_activity_pharmacy_division {
      label: "Patient Activity Pharmacy Division*"
      description: "Display Pharmacy Division associated with Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). Patient counts may be inflated over chain patient counts because of patient visiting multiple stores."
      type: string
      sql: CASE WHEN ${patient_activity_grain} = 'STORE' THEN ${TABLE}.PHARMACY_DIVISION END ;;
    }

    dimension: patient_activity_pharmacy_region {
      label: "Patient Activity Pharmacy Region*"
      description: "Display Pharmacy Region associated with Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). Patient counts may be inflated over chain patient counts because of patient visiting multiple stores."
      type: string
      sql: CASE WHEN ${patient_activity_grain} = 'STORE' THEN ${TABLE}.PHARMACY_REGION END ;;
    }

    dimension: patient_activity_pharmacy_district {
      label: "Patient Activity Pharmacy District*"
      description: "Display Pharmacy District associated with Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). Patient counts may be inflated over chain patient counts because of patient visiting multiple stores."
      type: string
      sql: CASE WHEN ${patient_activity_grain} = 'STORE' THEN ${TABLE}.PHARMACY_DISTRICT END ;;
    }

    dimension: patient_activity_pharmacy_state {
      label: "Patient Activity Pharmacy State*"
      description: "Display Pharmacy State associated with Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). Patient counts may be inflated over chain patient counts because of patient visiting multiple stores."
      type: string
      sql: CASE WHEN ${patient_activity_grain} = 'STORE' THEN ${TABLE}.PHARMACY_STATE END ;;
    }

    dimension: patient_updated_by_store_number {
      label: "Patient Last Activity Pharmacy Number*"
      description: "Display Pharmacy Number where the patient had last purchase for CHAIN grain reports with patient selected. Display Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). This dimension is informational."
      type:  string
      hidden: yes #Not exposed as part of Phase 1 . More analysis required.
      sql: ${TABLE}.PHARMACY_NUMBER ;;
    }

    dimension: patient_updated_by_nhin_store_id {
      label: "Patient Last Activity NHIN Store ID*"
      description: "Display Pharmacy NHIN Store ID where the patient had last purchase for CHAIN grain reports with patient selected. Display Pharmacy NHIN Store ID associated with Pharmacy Number for STORE grain reports. This dimension must be used in conjunction with Patient Activity view label measure(s). This dimension is informational."
      type:  number
      hidden: yes #Not exposed as part of Phase 1 . More analysis required.
      sql: ${TABLE}.NHIN_STORE_ID ;;
    }

    measure: active_patient_count {
      label: "Active Patient Count*"
      description: "Total number of active patients. Patients with purchases within the last 4 complete months. This measure must be used in conjunction with the Period and/or Period Begin Date dimensions within the report."
      type: sum
      sql: ${TABLE}.ACTIVE_PATIENT_COUNT ;;
    }

    measure: inactive_patient_count {
      label: "Inactive Patient Count*"
      description: "Total number of inactive patients. Patients with no purchases within the last 4 complete months, but purchases within the last 12 complete months. This measure must be used in conjunction with the Period and/or Period Begin Date dimensions within the report."
      type: sum
      sql: ${TABLE}.INACTIVE_PATIENT_COUNT ;;
    }

    measure: new_patient_count {
      label: "New Patient Count*"
      description: "Total number of new patients. Patients with purchases within the last complete month, but no purchases 11 complete months prior to last complete month. This measure must be used in conjunction with the Period and/or Period Begin Date dimensions within the report."
      type: sum
      sql: ${TABLE}.NEW_PATIENT_COUNT ;;
    }

    measure: newly_inactive_patient_count {
      label: "Newly Inactive Patient Count*"
      description: "Total number of newly inactive patients. Patients with no purchases in the last 4 complete months, but purchases 5 months ago. This measure must be used in conjunction with the Period and/or Period Begin Date dimensions within the report."
      type: sum
      sql: ${TABLE}.NEWLY_INACTIVE_PATIENT_COUNT ;;
    }

    measure: returning_patient_count {
      label: "Returning Patient Count*"
      description: "Total number of returning patients. Patients with purchases in the last complete month, but no purchases in the prior 4 complete months and historically had purchases i.e, 5 months ago. This measure must be used in conjunction with the Period and/or Period Begin Date dimensions within the report."
      type: sum
      sql: ${TABLE}.RETURNING_PATIENT_COUNT ;;
    }
  }

#[ERXDWPS-7476][ERXDWPS-7987]
view: bi_version_information {
  sql_table_name: EDW.D_BI_VERSION_INFORMATION ;;

  dimension: unique_key {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}."BI_VERSION_ID" ;;
  }

  dimension: bi_version_id {
    label: "BI Version ID"
    description: "Unique ID number identifying a BI version number"
    type: string
    sql: ${TABLE}."BI_VERSION_ID" ;;
  }

  dimension: bi_version_on_target_table {
    label: "BI Version On Target Table"
    description: "Indicates the EDW/Source table for which this version record has been created"
    type: string
    sql: ${TABLE}."BI_VERSION_ON_TARGET_TABLE" ;;
  }

  dimension: bi_version_description {
    label: "BI Version Description"
    description: "Brief information about what all logic is updated as a part of this version upgrade, to populate corresponding EDW table."
    type: string
    sql: ${TABLE}."BI_VERSION_DESCRIPTION" ;;
  }

  dimension_group: bi_version_roll_out {
    label: "BI Version Roll Out"
    description: "Date/Time this version of code/logic is available"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."BI_VERSION_ROLL_OUT_DATE" ;;
  }

  dimension_group: bi_version_applied_begin {
    label: "BI Version Applied Begin"
    description: "Date/Time from which data with this logic is available in this target table."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."BI_VERSION_APPLIED_BEGIN_DATE" ;;
  }

  dimension_group: bi_version_applied_end {
    label: "BI Version Applied End"
    description: "End Date/Time till the logic is available. 2999-12-31 00:00:00.000 will be populated for the currently applicable logic."
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."BI_VERSION_APPLIED_END_DATE" ;;
  }

  dimension_group: edw_insert_timestamp {
    label: "EDW Insert"
    description: "The time at which the record is inserted to EDW."
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_INSERT_TIMESTAMP" ;;
  }

  dimension_group: edw_last_update_timestamp {
    label: "EDW Last Update"
    description: "The time at which the record is updated to EDW."
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."EDW_LAST_UPDATE_TIMESTAMP" ;;
  }
}

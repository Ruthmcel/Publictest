view: carerx_program {
  sql_table_name: MTM_CLINICAL.PROGRAM ;;
  ## ======= The following MTM_CLINICAL.PROGRAM Database Objects were not exposed in this view ======= ##
  ## OVERVIEW   -- This is a CLOB Data Type

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "The CareRx unique database ID of the chain that the Care Rx patient is linked to. This is NOT the Chain NHIN ID assigned by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: sponsor_id {
    hidden: yes
    label: "Sponsor ID"
    description: "The unique database ID of the sponsor that the program is associated with"
    type: number
    sql: ${TABLE}.SPONSOR_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: program_name {
    label: "Program Name"
    description: "The name of the program"
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: program_created_by_user {
    label: "UserName Created Program"
    description: "The username of person that created the program"
    type: string
    sql: ${TABLE}.CREATED_BY ;;
  }

  dimension: session_estimated_duration {
    label: "Program Session Estimated Duration (Min)"
    description: "The estimated length of time (in minutes) that it will take a clinician to complete one session of the program with a patient"
    type: number
    sql: ${TABLE}.ESTIMATED_DURATION ;;
  }

  dimension: program_category_type {
    label: "Program Category Type"
    description: "The type or category of the program"
    type: string
    sql: ${TABLE}.TYPE ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: program_start {
    label: "Program Start"
    description: "The date that the program starts"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.START_DATE ;;
  }

  dimension_group: program_create {
    label: "Program Created"
    description: "The date that the program was created"
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
    sql: ${TABLE}.CREATE_DATE ;;
  }

  dimension_group: program_expire {
    label: "Program Expire"
    description: "The last date that the program is available before it expires"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.EXPIRE_DATE ;;
  }

  dimension_group: program_deactivate {
    label: "Program Deactivated"
    description: "The date that the program was deactivated"
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
    sql: ${TABLE}.DEACTIVATE_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: program_count {
    label: "Program Count"
    description: "A count of Programs"
    type: count
    drill_fields: [program_count_detail*]
  }

  ################################################################################################## SETS #################################################################################################

  set: program_count_detail {
    fields: [
      program_name,

      ## Chain Demographic Information May be of value here
      program_category_type,
      session_estimated_duration,
      program_create_time,
      program_start_date,
      program_expire_date,
      program_deactivate_time
    ]
  }
}

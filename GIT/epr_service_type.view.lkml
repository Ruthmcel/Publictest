view: epr_service_type {
  label: "Audit Access Log"
  sql_table_name: edw.D_SERVICE_TYPE ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${service_id} ||'@'|| ${source_system_id} ;; #ERXLPS-1649
  }

################################################################## Foreign Key references ##############################
  dimension: service_id {
    label: "Service Id"
    type: number
    description: "Unique Id number identifying each service provided by EPR."
    hidden: yes
    sql: ${TABLE}.service_id ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying a BI source system."
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }
################################################################## Dimensions ##############################
  dimension: service_name {
    label: "Service Name"
    description: "Name of the service provided by EPR."
    type: string
    sql: ${TABLE}.SERVICE_NAME ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
    hidden: yes
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ################################################################## Sets ##############################
  set: explore_rx_service_type_4_13_candidate_list {
    fields: [
      service_name
    ]
  }
  }

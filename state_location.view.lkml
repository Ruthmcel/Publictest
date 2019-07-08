view: state_location {
  sql_table_name: REPORT_TEMP.STATE_LOCATION_MAPPING ;;

  dimension: location {
    description: "Latitude/Longitude, precise to approximately 1 mile radius"
    type: location
    sql_latitude: ${TABLE}.LATITUDE ;;
    sql_longitude: ${TABLE}.LONGITUDE ;;
  }

  dimension: state_abbreviation {
    primary_key: yes
    description: "U.S. State Abbreviation"
    sql: ${TABLE}.STATE_ABBREVIATION ;;
  }
}

view: us_state_county_fips {
  sql_table_name: REPORT_TEMP.US_STATE_COUNTY_FIPS ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${state}  ||'@'|| ${county_name} ;;
  }

  dimension: state_county_fips_code {
    type: string
    map_layer_name: us_counties_fips
    sql: ${state_fips_code}  || ${county_fips_code} ;;
  }

  dimension: county_fips_code {
    hidden:  yes
    type: string
    sql: ${TABLE}.COUNTY_FIPS_CODE ;;
  }

  dimension: county_name {
    hidden:  yes
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: fips_class_code {
    hidden:  yes
    type: string
    sql: ${TABLE}.FIPS_CLASS_CODE ;;
  }

  dimension: state {
    hidden:  yes
    type: string
    sql: ${TABLE}.STATE ;;
  }

  dimension: state_fips_code {
    hidden:  yes
    type: string
    sql: ${TABLE}.STATE_FIPS_CODE ;;
  }

}

view: store_patient_zip_code {
  sql_table_name: REPORT_TEMP.US_ZIP_CODE_MAPPING ;;

  dimension: zip_code {
    primary_key: yes
    label: "Store Patient Zip Code"
    group_label: "Store Patient Address Info"
    description: "ZIP Code"
    type: zipcode
    sql: ${TABLE}.ZIP_CODE ;;
  }

  dimension: location {
    group_label: "Store Patient Address Info"
    label: "Store Patient location"
    description: "Latitude/Longitude, precise to approximately 1 mile radius"
    type: location
    sql_latitude: ${TABLE}.PRECISE_LATITUDE + .000001 ;;
    sql_longitude: ${TABLE}.PRECISE_LONGITUDE + .000001 ;;
  }

  dimension: distance_from_store {
    group_label: "Store Patient Address Info"
    label: "Store Patient Distance from Pharmacy"
    description: "Paient's distance from pharmacy"
    type: distance
    start_location_field: patient_zip_code.location
    end_location_field: store_state_location.store_location
    units: miles
  }

  dimension: state_abbreviation {
    group_label: "Store Patient Address Info"
    label: "Store Patient State Abbreviation"
    description: "U.S. State Abbreviation"
    sql: ${TABLE}.STATE_ABBREVIATION ;;
  }

  dimension: county {
    group_label: "Store Patient Address Info"
    label: "Store Patient County"
    description: "County within State"
    sql: ${TABLE}.COUNTY ;;
  }

  dimension: zip_code_type {
    group_label: "Store Patient Address Info"
    label: "Store Patient Zip Code Type"
    description: "Military, PO Box, Standard, or Unique"
    type: string
    suggestions: ["MILITARY", "PO BOX", "STANDARD", "UNIQUE"]
    sql: ${TABLE}.TYPE ;;
  }

  dimension: zip_code_primary_city {
    group_label: "Store Patient Address Info"
    label: "Store Patient City  (US Postal Info)" #[ERXLPS-1969]
    description: "Primary City of ZIP Code"
    type: string
    sql: ${TABLE}.PRIMARY_CITY ;;
  }

  dimension: zip_code_world_region {
    # as we currently have only NA (North America)
    hidden: yes
    group_label: "Store Patient Address Info"
    label: "Store Patient World Region"
    description: "World Region"
    type: string
    sql: ${TABLE}.WORLD_REGION ;;
  }

  dimension: zip_code_country {
    group_label: "Store Patient Address Info"
    label: "Store Patient Country"
    description: "Alpha-2 Country Code"
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: zip_code_decomissioned {
    group_label: "Store Patient Address Info"
    label: "Store Patient Zip Code Decommissioned"
    description: "Y/N flag indicating if this zip has been decommissioned"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DECOMMISSIONED = 1 ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  measure: zip_code_estimated_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Estimated Population"
    description: "Estimated population using IRS data"
    type: sum_distinct
    sql: ${TABLE}.ESTIMATED_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_area_land {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Land Area"
    description: "Land area in square meters (divide by 2589988.110336 for square miles)"
    type: sum_distinct
    sql: ${TABLE}.AREA_LAND ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_count_100 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Census Population"
    description: "Total population count using Census data"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_COUNT_100 ;;
    value_format: "#,##0"
  }

  measure: zip_code_housing_unit_count_100 {
    #   do not see much value at this point. Will be exposed if required
    hidden: yes
    group_label: "Store Patient Address Info"
    label: "Store Patient Zip Code Housing Unit"
    description: "Number of housing units"
    type: sum_distinct
    sql: ${TABLE}.HOUSING_UNIT_COUNT_100 ;;
    value_format: "#,##0"
  }

  measure: zip_code_white_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code White Population"
    description: "White Population"
    type: sum_distinct
    sql: ${TABLE}.WHITE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_black_or_african_american_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Black or African American population"
    description: "Black or African American population"
    type: sum_distinct
    sql: ${TABLE}.BLACK_OR_AFRICAN_AMERICAN_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_indian_or_alaskan_native_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code American Indian population"
    description: "American Indian population"
    type: sum_distinct
    sql: ${TABLE}.AMERICAN_INDIAN_OR_ALASKAN_NATIVE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_asian_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Asian population"
    description: "Asian population"
    type: sum_distinct
    sql: ${TABLE}.ASIAN_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_native_hawaiian_and_other_pacific_islander_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Native Hawaiian population"
    description: "Native Hawaiian population"
    type: sum_distinct
    sql: ${TABLE}.NATIVE_HAWAIIAN_AND_OTHER_PACIFIC_ISLANDER_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_other_race_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Other race population"
    description: "Other race population"
    type: sum_distinct
    sql: ${TABLE}.OTHER_RACE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_two_or_more_races_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Two or more race population"
    description: "Two or more race population"
    type: sum_distinct
    sql: ${TABLE}.TWO_OR_MORE_RACES_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_male_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Male Population"
    description: "Male population"
    type: sum_distinct
    sql: ${TABLE}.TOTAL_MALE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_female_population {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code Female Population"
    description: "Female Population"
    type: sum_distinct
    sql: ${TABLE}.TOTAL_FEMALE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_under_10 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code under 10 years old Population"
    description: "Population under 10 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_UNDER_10 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_10_to_19 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 10 to 19 years old Population"
    description: "Population 10 to 19 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_10_TO_19 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_20_to_29 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 20 to 29 years old Population"
    description: "Population 20 to 29 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_20_TO_29 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_30_to_39 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 30 to 39 years old Population"
    description: "Population 30 to 39 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_30_TO_39 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_40_to_49 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 40 to 49 years old Population"
    description: "Population 40 to 49 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_40_TO_49 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_50_to_59 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 50 to 59 years old Population"
    description: "Population 50 to 59 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_50_TO_59 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_60_to_69 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 60 to 69 years old Population"
    description: "Population 60 to 69 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_60_TO_69 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_70_to_79 {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 70 to 79 years old Population"
    description: "Population 70 to 79 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_70_TO_79 ;;
    value_format: "#,##0"
  }

  measure: zip_code_population_80_plus {
    group_label: "Zip Code Census Info"
    label: "Store Patient Zip Code 80 years or older Population"
    description: "Population 80 years or older"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_80_PLUS ;;
    value_format: "#,##0"
  }
}

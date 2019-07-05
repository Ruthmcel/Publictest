view: bi_demo_store_state_location {
  # 06302016 - KR - This View is specifically used for BI Demo to join to all Pharmacy Related entities (primarily the store zip_code residing in contact information table)
  # 06302016 - KR - All mapping information is handled under REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING which has the scrambeled zip code information and acts as the cross reference table
  # 06302016 - KR - The ZIP_CODE from REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING will be used to join to pharmacy to get the actual pharmacy location zip codes but when the data is exposed the scrambeled zip codes are used.

  derived_table: {
    sql: SELECT
      SCI.CONTACT_INFO_ID AS CONTACT_INFO_STORE_ID,
      SLM.STATE_ABBREVIATION AS STATE_ABBREVIATION,
      SLM.STATE AS STORE_STATE_NAME,
      ZC.PRECISE_LATITUDE,
      ZC.PRECISE_LONGITUDE,
      ZC.ZIP_CODE,
      ZC.TYPE,
      ZC.PRIMARY_CITY,
      ZC.WORLD_REGION,
      ZC.COUNTRY,
      ZC.DECOMMISSIONED,
      ZC.ESTIMATED_POPULATION,
      ZC.NOTES,
      ZC.AREA_LAND,
      ZC.POPULATION_COUNT_100,
      ZC.HOUSING_UNIT_COUNT_100,
      ZC.WHITE_POPULATION,
      ZC.BLACK_OR_AFRICAN_AMERICAN_POPULATION,
      ZC.AMERICAN_INDIAN_OR_ALASKAN_NATIVE_POPULATION,
      ZC.ASIAN_POPULATION,
      ZC.NATIVE_HAWAIIAN_AND_OTHER_PACIFIC_ISLANDER_POPULATION,
      ZC.OTHER_RACE_POPULATION,
      ZC.TWO_OR_MORE_RACES_POPULATION,
      ZC.TOTAL_MALE_POPULATION,
      ZC.TOTAL_FEMALE_POPULATION,
      ZC.POPULATION_UNDER_10,
      ZC.POPULATION_10_TO_19,
      ZC.POPULATION_20_TO_29,
      ZC.POPULATION_30_TO_39,
      ZC.POPULATION_40_TO_49,
      ZC.POPULATION_50_TO_59,
      ZC.POPULATION_60_TO_69,
      ZC.POPULATION_70_TO_79,
      ZC.POPULATION_80_PLUS
      FROM REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING BIDEMOZC
      RIGHT OUTER JOIN EDW.D_CONTACT_INFORMATION SCI
      ON SCI.CONTACT_INFO_ZIP_CODE = BIDEMOZC.ZIP_CODE
      INNER JOIN REPORT_TEMP.US_ZIP_CODE_MAPPING ZC
      ON BIDEMOZC.ZIP_CODE_BI_DEMO_MAPPING = ZC.ZIP_CODE
      INNER JOIN REPORT_TEMP.STATE_LOCATION_MAPPING SLM
      ON SCI.CONTACT_INFO_STATE = SLM.STATE_ABBREVIATION
       ;;
  }

  dimension: contact_info_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CONTACT_INFO_STORE_ID ;;
  }

  dimension: zip_code {
    primary_key: yes
    label: "Pharmacy Zip Code (US Post Info - Central)"
    description: "Pharmacy Zip Code"
    type: zipcode
    sql: ${TABLE}.zip_code ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.precise_latitude + .000001 ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.precise_longitude + .000001 ;;
  }

  dimension: store_location {
    label: "Pharmacy Location (US Post Info - Central)"
    description: "Latitude/Longitude, precise to approximately 1 mile radius of Pharmacy's Zipcode"
    type: location
    #sql_latitude: ${latitude} ;;
    #sql_longitude: ${longitude} ;;
    #Fixed below two measures while testing ERXLPS-1430
    sql_latitude: ${TABLE}.precise_latitude + .000001 ;;
    sql_longitude: ${TABLE}.precise_longitude + .000001 ;;

  }

  dimension: state_abbreviation {
    label: "Pharmacy State Abbreviation (US Post Info - Central)"
    type: string
    sql: ${TABLE}.state_abbreviation ;;
  }

  dimension: store_state_name {
    label: "Pharmacy State Name (US Post Info - Central)"
    type: string
    sql: ${TABLE}.STORE_STATE_NAME ;;
  }

  dimension: store_zip_code_type {
    label: "Pharmacy Zip Code Type (US Post Info - Central)"
    description: "Military, PO Box, Standard, or Unique"
    type: string
    suggestions: ["MILITARY", "PO BOX", "STANDARD", "UNIQUE"]
    sql: ${TABLE}.TYPE ;;
  }

  dimension: store_zip_code_primary_city {
    label: "Pharmacy City (US Post Info - Central)" #[ERXLPS-1969]
    description: "Primary City of ZIP Code"
    type: string
    sql: ${TABLE}.PRIMARY_CITY ;;
  }

  dimension: store_zip_code_world_region {
    # We currently have only NA (North America)
    hidden: yes
    label: "Pharmacy World Region"
    description: "World Region"
    type: string
    sql: ${TABLE}.WORLD_REGION ;;
  }

  dimension: store_zip_code_country {
    label: "Pharmacy Country (US Post Info - Central)"
    description: "Alpha-2 Country Code"
    type: string
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: store_zip_code_decomissioned {
    label: "Pharmacy Zip Code Decomissioned (US Post Info - Central)"
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

  measure: store_zip_code_estimated_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Estimated Population"
    description: "Estimated population using IRS data"
    type: sum_distinct
    sql: ${TABLE}.ESTIMATED_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_area_land {
    label: "Pharmacy Zip Code Land Area"
    description: "Land area in square meters (divide by 2589988.110336 for square miles)"
    type: sum_distinct
    sql: ${TABLE}.AREA_LAND ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_count_100 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Census Population"
    description: "Total population count using Census data"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_COUNT_100 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_housing_unit_count_100 {
    label: "Pharmacy Zip Code Housing Unit"
    description: "Number of housing units"
    type: sum_distinct
    sql: ${TABLE}.HOUSING_UNIT_COUNT_100 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_white_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code White Population"
    description: "White Population"
    type: sum_distinct
    sql: ${TABLE}.WHITE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_black_or_african_american_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Black or African American population"
    description: "Black or African American population"
    type: sum_distinct
    sql: ${TABLE}.BLACK_OR_AFRICAN_AMERICAN_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_indian_or_alaskan_native_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code American Indian population"
    description: "American Indian population"
    type: sum_distinct
    sql: ${TABLE}.AMERICAN_INDIAN_OR_ALASKAN_NATIVE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_asian_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Asian population"
    description: "Asian population"
    type: sum_distinct
    sql: ${TABLE}.ASIAN_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_native_hawaiian_and_other_pacific_islander_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Native Hawaiian population"
    description: "Native Hawaiian population"
    type: sum_distinct
    sql: ${TABLE}.NATIVE_HAWAIIAN_AND_OTHER_PACIFIC_ISLANDER_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_other_race_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Other race population"
    description: "Other race population"
    type: sum_distinct
    sql: ${TABLE}.OTHER_RACE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_two_or_more_races_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Two or more race population"
    description: "Two or more race population"
    type: sum_distinct
    sql: ${TABLE}.TWO_OR_MORE_RACES_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_male_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Male Population"
    description: "Male population"
    type: sum_distinct
    sql: ${TABLE}.TOTAL_MALE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_female_population {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code Female Population"
    description: "Female Population"
    type: sum_distinct
    sql: ${TABLE}.TOTAL_FEMALE_POPULATION ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_under_10 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code under 10 years old Population"
    description: "Population under 10 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_UNDER_10 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_10_to_19 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 10 to 19 years old Population"
    description: "Population 10 to 19 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_10_TO_19 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_20_to_29 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 20 to 29 years old Population"
    description: "Population 20 to 29 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_20_TO_29 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_30_to_39 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 30 to 39 years old Population"
    description: "Population 30 to 39 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_30_TO_39 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_40_to_49 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 40 to 49 years old Population"
    description: "Population 40 to 49 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_40_TO_49 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_50_to_59 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 50 to 59 years oldPopulation"
    description: "Population 50 to 59 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_50_TO_59 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_60_to_69 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 60 to 69 years oldPopulation"
    description: "Population 60 to 69 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_60_TO_69 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_70_to_79 {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 70 to 79 years old Population"
    description: "Population 70 to 79 years old"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_70_TO_79 ;;
    value_format: "#,##0"
  }

  measure: store_zip_code_population_80_plus {
    group_label: "Zip Code Census Info"
    label: "Pharmacy Zip Code 80 years or older Population"
    description: "Population 80 years or older"
    type: sum_distinct
    sql: ${TABLE}.POPULATION_80_PLUS ;;
    value_format: "#,##0"
  }
}

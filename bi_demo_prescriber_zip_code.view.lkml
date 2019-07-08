view: bi_demo_prescriber_zip_code {
  # 06302016 - KR - This View is specificall used for BI Demo to join to all Prescriber Related entities (primarily the prescriber.zip_code)
  # 06302016 - KR - All mapping information is handled under REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING which has the scrambeled zip code information and acts as the cross reference table
  # 06302016 - KR - The ZIP_CODE from REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING will be used to join to prescriber to get the actual prescriber location zip codes but when the data is exposed the scrambeled zip codes are used.

  sql_table_name: REPORT_TEMP.BI_DEMO_US_ZIP_CODE_MAPPING ;;

  dimension: zip_code_bi_demo_mapping {
    hidden: yes
    primary_key: yes
    description: "ZIP Code BI Demo Mapping"
    type: zipcode
    sql: ${TABLE}.ZIP_CODE_BI_DEMO_MAPPING ;;
  }

  dimension: zip_code {
    hidden: yes
    description: "ZIP Code"
    type: zipcode
    sql: ${TABLE}.ZIP_CODE ;;
  }
}

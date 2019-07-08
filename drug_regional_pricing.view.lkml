view: drug_regional_pricing {
  #[ERXLPS-2089] - Price Code, Drug Preferred Brand(Yes/No), Drug Preferred Generic(Yes/No) and Drug Store Generic(Yes/No) dimension are exposed along with source_create and source_timestamp. Other dimensions are not added may not have information for all drugs.
  sql_table_name: EDW.D_DRUG_REGIONAL_PRICING ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    # source_system_id is not included as it is handled at the join level, where only record from one source system will be joined based on the view selected
    #################################################################################################### Foreign Key References #####################################################################################################
    sql: ${chain_id} ||'@'|| ${drug_regional_pricing_region} '@'|| ${drug_ndc} '@'|| ${source_system_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    hidden: yes
    type: number
    label: "Drug Chain ID"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: drug_regional_pricing_region {
    type: number
    label: "Drug Region"
    description: "Drug region to be viewed for this drug pricing."
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_REGION ;;
  }

  dimension: drug_ndc {
    type: string
    hidden: yes
    label: "Drug NDC"
    description: "National Drug Code that represents the drug."
    sql: ${TABLE}.NDC ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################### Dimension ############################################################################################################
  dimension: drug_regional_pricing_price_code {
    type: string
    label: "Drug Price Code"
    description: "Drug price code."
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_PRICE_CODE ;;
  }

  dimension: drug_regional_pricing_preferred_brand_flag {
    type: yesno
    label: "Drug Preferred Brand"
    description: "Yes/No Flag indicating if the system includes the Pref. Brand flag from the drug."
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_PREFERRED_BRAND_FLAG = 'Y' ;;
  }

  dimension: drug_regional_pricing_preferred_generic_flag {
    type: yesno
    label: "Drug Preferred Generic"
    description: "Yes/No Flag indicating if the system includes the Pref. Gen flag from the drug record."
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_PREFERRED_GENERIC_FLAG = 'Y' ;;
  }

  dimension: drug_regional_pricing_store_generic_flag {
    type: yesno
    label: "Drug Store Generic"
    description: "Yes/No Flag indicating if the Pharmacy System treats the brand drug as a generic."
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_STORE_GENERIC_FLAG = 'Y' ;;
  }

  dimension: drug_regional_pricing_deleted_reference {
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_REGIONAL_PRICING_DELETED ;;
  }

  ############################################# Date dimensions ##########################################
  dimension_group: drug_regional_pricing_source_timestamp {
    label: "Drug Price Code Source Timestamp"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application."
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}

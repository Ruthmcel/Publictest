view: store_alignment {
  sql_table_name: edw.d_store_alignment ;;
  # 07252016 - KR - This View is specificall used for Mapping HQ -> Division -> Region -> District -> Store "
  # [ERXLPS-6307] - Added "(Align)" key word in all dimensions. Removed group_label from all dimensions.

  dimension: chain_id {
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: pharmacy_number {
    label: "Pharmacy Number (Align)"
    type: string
    description: "Pharmacy number assigned by the customer that identifies the pharmacy within its store"
    sql: ${TABLE}.STORE_PHARMACY_NUMBER ;;
  }

  dimension: store_number {
    label: "Store Number (Align)"
    type: string
    description: "Store number assigned by the customer that identifies the store within its chain"
    sql: ${TABLE}.CUSTOMER_STORE_IDENTIFIER ;;
  }

  dimension: divisional_manager {
    type: string
    label: "Divisional Manager (Align)"
    description: "Manager assigned for division"
    sql: DIVISIONAL_MANAGER ;;
    full_suggestions: yes
  }

  dimension: regional_manager {
    type: string
    label: "Regional Manager (Align)"
    description: "Manager assigned for region"
    sql: REGIONAL_MANAGER ;;
    full_suggestions: yes
  }

  dimension: district_manager {
    type: string
    label: "District Manager (Align)"
    description: "Manager assigned for district"
    sql: DISTRICT_MANAGER ;;
    full_suggestions: yes
  }

  dimension: division {
    type: string
    label: "Pharmacy Division (Align)"
    description: "Pharmacy Division"
    sql: NVL(${TABLE}.PHARMACY_DIVISION,'N/A') ;;
    drill_fields: [chain.chain_name, region, district, store.store_number]
    full_suggestions: yes
  }

  dimension: ar_pharmacy_specialty_retail {
    type: string
    label: "Pharmacy Specialty/Retail (Align)"
    description: "Pharmacy Specialty/Retail"
    sql: UPPER(NVL(${TABLE}.PHARMACY_DIVISION,'N/A')) ;;
    full_suggestions: yes
  }

  dimension: region {
    type: string
    label: "Pharmacy Region (Align)"
    description: "Pharmacy Region"
    sql: ${TABLE}.PHARMACY_REGION ;;
    drill_fields: [chain.chain_name, division, district, store.store_number]
    full_suggestions: yes
  }

  dimension: district {
    type: string
    label: "Pharmacy District (Align)"
    description: "Pharmacy District"
    sql: ${TABLE}.PHARMACY_DISTRICT ;;
    drill_fields: [chain.chain_name, division, region, store.store_number]
    full_suggestions: yes
  }

  dimension: store_division {
    type: string
    label: "Store Division (Align)"
    description: "Store Division"
    sql: NVL(${TABLE}.STORE_DIVISION,'N/A') ;;
    drill_fields: [chain.chain_name, store_region, store_district, store.store_number]
    full_suggestions: yes
  }

  dimension: store_region {
    type: string
    label: "Store Region (Align)"
    description: "Store Region"
    sql: ${TABLE}.STORE_REGION ;;
    drill_fields: [chain.chain_name, store_division, store_district, store.store_number]
    full_suggestions: yes
  }

  dimension: store_district {
    type: string
    label: "Store District (Align)"
    description: "Store District"
    sql: ${TABLE}.STORE_DISTRICT ;;
    drill_fields: [chain.chain_name, store_division, store_region, store.store_number]
    full_suggestions: yes
  }

  dimension: pharmacy_address {
    label: "Pharmacy Address (Align)"
    description: "Address of the Pharmacy"
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: pharmacy_city {
    label: "Pharmacy City (Align)"
    description: "City of the Pharmacy"
    sql: ${TABLE}.CITY ;;
  }

  dimension: pharmacy_state {
    label: "Pharmacy State (Align)"
    description: "State of the Pharmacy"
    sql: ${TABLE}.STATE ;;
  }

  dimension: pharmacy_time_zone {
    label: "Pharmacy Time Zone (Align)"
    description: "Pharmacy Server timezone"
    sql: ${TABLE}.TIME_ZONE ;;
  }

  #[ERXLPS-4]
  dimension: store_close_date {
    label: "Store Close Date (Align)"
    description: "Store Close Date"
    type: date
    sql: ${TABLE}.STORE_CLOSE_DATE ;;
  }

  #[ERXLPS-1164]
  dimension: pharmacy_close_date {
    label: "Pharmacy Close Date (Align)"
    description: "Pharmacy Close Date"
    type: date
    sql: ${TABLE}.PHARMACY_CLOSE_DATE ;;
  }

  dimension: pharmacy_open_date {
    label: "Pharmacy Open Date (Align)"
    description: "Pharmacy Open Date"
    type: date
    sql: ${TABLE}.PHARMACY_OPEN_DATE ;;
  }

  dimension: pharmacy_comparable_date {
    label: "Pharmacy Comparable Date (Align)"
    description: "Pharmacy Comparable Date"
    type: date
    sql: ${TABLE}.PHARMACY_COMPARABLE_DATE ;;
  }

  #[ERXLPS-1452]
  dimension: pharmacy_non_comparable_date {
    label: "Pharmacy Non Comparable Date (Align)"
    description: "Pharmacy Non Comparable Date"
    type: date
    sql: ${TABLE}.PHARMACY_NON_COMPARABLE_DATE ;;
  }

  dimension: pharmacy_comparable_flag {
    label: "Pharmacy Comparable Flag (Align)"
    description: "Used for comparison with other pharmacy"
    sql: ${TABLE}.PHARMACY_COMPARABLE_FLAG ;;
  }

  dimension: store_open_date {
    label: "Store Open Date (Align)"
    description: "Store Open Date"
    type: date
    sql: ${TABLE}.STORE_OPEN_DATE ;;
  }

  dimension: store_comparable_date {
    label: "Store Comparable Date (Align)"
    description: "Store Comparable Date"
    type: date
    sql: ${TABLE}.STORE_COMPARABLE_DATE ;;
  }

  dimension: store_comparable_flag {
    type: string
    label: "Store Comparable Flag (Align)"
    description: "Used for comparison with other stores"
    sql: ${TABLE}.STORE_COMPARABLE_FLAG ;;
  }

  #[ERXLPS-955] - Following dimensions are created to use in user_attributes. Please do not delete. Start...
  dimension: division_access_filter {
    type: string
    hidden: yes
    label: "Pharmacy Division"
    description: "Pharmacy Division"
    sql: NVL(TRIM(${TABLE}.PHARMACY_DIVISION),'') ;;
  }

  dimension: region_access_filter {
    type: string
    hidden: yes
    label: "Pharmacy Region"
    description: "Pharmacy Region"
    sql: NVL(TRIM(${TABLE}.PHARMACY_REGION),'') ;;
  }

  dimension: district_access_filter {
    type: string
    hidden: yes
    label: "Pharmacy District"
    description: "Pharmacy District"
    sql: NVL(TRIM(${TABLE}.PHARMACY_DISTRICT),'') ;;
  }

  dimension: pharmacy_number_access_filter {
    type: string
    hidden: yes
    label: "Pharmacy Number"
    description: "Pharmacy number assigned by the customer that identifies the pharmacy within its store"
    sql: NVL(TRIM(${TABLE}.STORE_PHARMACY_NUMBER),'') ;;
  }
  #[ERXLPS-955] - End...

  #[ERXLPS-670]
  dimension: pharmacy_short_name {
    type:  string
    label: "Pharmacy Short Name (Align)"
    description: "Pharmacy Short Name"
    sql: ${TABLE}.LOCATION_SHORT_NAME ;;
  }

#ERXDWPS-8224- Fix Logic for the 'Pharmacy Exists in Store Alignment Table (Yes/No)' object
  dimension: exist_in_store_alignment {
    label: "Pharmacy Exists in Store Alignment Table and ARS store"
    view_label: "Pharmacy - Central"
    description: "Yes/No Flag indicating if the store information is present in the STORE_ALIGNMENT table as well as in ARS store"
    type: yesno
    sql: ${store_alignment.nhin_store_id} = ${store.nhin_store_id} ;;
  }
}

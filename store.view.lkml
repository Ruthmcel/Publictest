view: store {
  # 08222016 - VW_STORE view replaced by derived_table as shown below. This gives felxibility for every member who has lookML access to look at the code
  # 09042016  - Performance Improvement Changes for Derived View
  #           - Chain Access Filter will also be applied to this derived table, if Row Level Security is enforced which would be the default behavior if any elements from this view is included in Customer DSS Model
  #           - filter Applied on Chain & NHIN STORE ID by default so if a specific chain or store is selected, only the specific chain and store would be selected instead of reading data for ALL CHAINS, STORES. Note: Access filter Will Still be applied if enforced.
  #             For example: If Chain 70 and 168 is selected, only 70 will be extracted at the end, if view is used in Customer DSS Model. If Chain 70 and NHIN_STORE_ID 109638 is selected, then only those records pertaining to chain 70 and the store 109638 would be selected even if there are records for other chain or store in this table.
  #           - The templated filters are not explicitly defined as the filter parameter as the field picker "Pharmacy NHIN Store ID" in the explore would correctly handle the store being selected
  # 0926207  - Enabling Persistence Derived table to build STORE every single day
  # [ERXLPS-1517] - PDT Implementation Changes.
  # [ERXLPS-6307] - Added central key word in all dimensions and meausres.
  derived_table: {
    sql: SELECT  STR.CHAIN_ID,
      STR.NHIN_STORE_ID,
      STR.SOURCE_SYSTEM_ID,
      STR.STORE_ID,
      STR.STORE_NUMBER,
      STR.STORE_NAME,
      STR.STORE_NCPDP_NUMBER,
      STR.STORE_NPI_NUMBER,
      STR.STORE_DEACTIVATED_DATE,
      STR.STORE_WORKFLOW_ENABLED_FLAG,
      STR_ADDR.STORE_ADDRESS AS STORE_ADDRESS,
      STR_ADDR.STORE_ADDRESS_CITY AS STORE_CITY,
      STR_ADDR.STORE_ADDRESS_STATE AS STORE_STATE,
      STR_ADDR.STORE_ADDRESS_TIME_ZONE AS STORE_SERVER_TIME_ZONE,
      NVL(STR_ADDR.STORE_ADDRESS_DELETED_FLAG,'N') AS STORE_ADDRESS_DELETED_FLAG,
      STR_ADDR.STORE_SUPPORT_NOTES AS STORE_SUPPORT_NOTES,
      STR.STORE_REGISTRATION_STATUS AS STORE_ARS_REGISTRATION_STATUS,
      STR_ADDR.STORE_ADDRESS_REG_STATUS AS STORE_EPR_REGISTRATION_STATUS,
      STR.STORE_TLS_COMPLIANT_FLAG,
      STR.STORE_CLIENT_TYPE,
      STR.STORE_CLIENT_VERSION AS STORE_CLIENT_VERSION,
      STR.STORE_CATEGORY,
      STR.STORE_SORT_ORDER
      FROM EDW.D_STORE STR
      LEFT OUTER JOIN EDW.D_STORE_ADDRESS STR_ADDR
      ON STR.CHAIN_ID = STR_ADDR.CHAIN_ID AND STR.NHIN_STORE_ID = STR_ADDR.NHIN_STORE_ID
      WHERE (upper(STR.STORE_NAME) NOT LIKE '%WEBSERVICE%' AND upper(STR.STORE_NAME) NOT LIKE '%WEB SERVICE%'
          AND upper(STR.STORE_NAME) NOT LIKE '%CARERX%' AND upper(STR.STORE_NAME) NOT LIKE '%CARE RX%'
              AND upper(STR.STORE_NAME) NOT LIKE '%EMONITOR%' AND upper(STR.STORE_NAME) NOT LIKE '%E MONITOR%'
          )
      AND STR.NHIN_STORE_ID > 10000
      AND STR.SOURCE_SYSTEM_ID = 5
      ORDER BY STR.CHAIN_ID,STR.NHIN_STORE_ID;;
    sql_trigger_value: SELECT MAX(EDW_LAST_UPDATE_TIMESTAMP) FROM EDW.D_STORE;;
  }

  #             AND {% condition chain.chain_id %} STR.CHAIN_ID {% endcondition %}
  #             AND {% condition store.nhin_store_id %} STR.NHIN_STORE_ID {% endcondition %}

  dimension: chain_id {
    label: "Pharmacy Chain ID (Central)"
    description: "Identification number assinged to a Chain by NHIN, for which is specific to each customer chain"
    hidden: yes #[ERXLPS-2045] chiain_id exposed from chain view
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Pharmacy NHIN Store ID (Central)"
    type: number
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_id {
    hidden: yes
    type: number
    description: "Unique store id in ARS system. Auto-Assigned by the ARS system"
    sql: ${TABLE}.STORE_ID ;;
  }

  dimension: primary_key {
    # This field is not exposed but used in the view to avoid running into symmetric aggregate issue as chain+nhin_store_id requires uniqueness
    hidden: yes
    type: number
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ;; #ERXLPS-1649
  }

  #[ERXLPS-2215] - New dimension added to use for sorting
  dimension: store_sort_order {
    hidden: yes
    description: "Derived based on ASCII value of Store pharmacy number which would help to sort the data."
    type: string
    sql: ${TABLE}.STORE_SORT_ORDER ;;
  }

  dimension: store_number {
    type: string
    label: "Pharmacy Number (Central)"
    description: "Pharmacy/Store number assigned by the customer that identifies the store within its chain"
    sql: ${TABLE}.STORE_NUMBER ;;
    order_by_field: store_sort_order #[ERXLPS-2215]
  }

  dimension: store_name {
    label: "Pharmacy Name (Central)"
    description: "The name of the pharmacy/store"
    sql: ${TABLE}.STORE_NAME ;;
  }

  dimension: ncpdp_number {
    label: "Pharmacy NCPDP Number (Central)"
    description: "National Council for Prescription Drug Programs (NCPDP) number assigned to the Pharmacy"
    sql: ${TABLE}.STORE_NCPDP_NUMBER ;;
  }

  dimension: npi_number {
    label: "Pharmacy NPI Number (Central)"
    description: "National Provider Identifier number assigned to the pharmacy"
    sql: ${TABLE}.STORE_NPI_NUMBER ;;
  }

  dimension: store_client_type_reference {
    label: "Pharmacy Client Type Code (Central)"
    description: "Specifies the type of pharmacy this record exists for"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CLIENT_TYPE ;;
  }

  #[ERXDWPS-6493] - Removed suggestions. Added default value UNKNOWN. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_client_type {
    label: "Pharmacy Client Type (Central)"
    description: "Specifies the type of pharmacy this record exists for"
    type: string
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_CLIENT_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_CLIENT_TYPE') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [store_client_type_reference]
  }

  dimension: store_client_version {
    label: "Pharmacy Client Version (Central)"
    description: "The current software version that the store's pharmacy application is using"
    sql: ${TABLE}.STORE_CLIENT_VERSION ;;
  }

  dimension: store_category_reference {
    label: "Pharmacy Category (Central)"
    description: "Indicates the different buckets (Live-EPS, Live-PDX, Closed-EPR, Closed-ARS, Lookup-EPS, Lookup-PDX, Pending) a store falls-in "
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_CATEGORY ;;
  }

  #[ERXDWPS-6493] - Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value. Master code table has 'Unknown' defined for NULL value. Hence defined default value as Unknown to mimic with master code value.
  dimension: store_category {
    label: "Pharmacy Category (Central)"
    description: "Indicates the different buckets (Live-EPS, Live-PDX, Closed-EPR, Closed-ARS, Lookup-EPS, Lookup-PDX, Pending) a store falls-in "
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'Unknown') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_CATEGORY AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_CATEGORY') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [store_category_reference]
  }

  dimension: store_tls_compliant_reference {
    type: string
    hidden: yes
    label: "Pharmacy TLS Compliant (Central)"
    description: "Y/N Flag indicating if the pharmacy is TLS 1.2 compliant or not"
    sql: ${TABLE}.STORE_TLS_COMPLIANT_FLAG ;;
  }

  #[ERXDWPS-6493] - Reaplced CASE WHEN statements with SELECT MAX logic. Removed suggestions. Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_tls_compliant {
    type: string
    label: "Pharmacy TLS Compliant (Central)"
    description: "Y/N Flag indicating if the pharmacy is TLS 1.2 compliant or not"
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_TLS_COMPLIANT_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_TLS_COMPLIANT_FLAG') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [store_tls_compliant_reference]
  }

  dimension_group: deactivated_date {
    label: "Pharmacy Deactivated (Central)"
    description: "Date/time indicating when this store record was deactivated"
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
      hour_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.STORE_DEACTIVATED_DATE ;;
  }

  dimension: workflow_enabled_flag_reference {
    label: "Pharmacy Workflow Enabled Code (Central)"
    description: "Flag indicating if this store is enabled for WORKFLOW"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_WORKFLOW_ENABLED_FLAG ;;
  }

  dimension: workflow_enabled_flag {
    label: "Pharmacy Workflow Enabled (Central)"
    description: "Flag indicating if this store is enabled for WORKFLOW"
    type: string
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_WORKFLOW_ENABLED_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_WORKFLOW_ENABLED_FLAG') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [workflow_enabled_flag_reference]
  }
# [ERXLPS-6344] Looker - Replace ARS Address info with SEC_ADMIN address info in Looker views and explores
#   dimension: store_address {
#     label: "Pharmacy Address (Central)"
#     description: "The first line of the store's address"
#     sql: ${TABLE}.STORE_ADDRESS ;;
#   }
#
#   dimension: store_city {
#     label: "Pharmacy City (Central)"
#     description: "The City in which the Pharmacy is physically located"
#     sql: ${TABLE}.STORE_CITY ;;
#   }
#
#   dimension: store_state {
#     label: "Pharmacy State (Central)"
#     description: "The State in which the Pharmacy is physically located"
#     hidden: yes
#     sql: ${TABLE}.STORE_STATE ;;
#   }

  #   - dimension: pharmacy_google_link
  #     label: 'Pharmacy Map Location'
  # #     links:
  # #     - label: Pharmacy Location
  # #       url: https://www.google.com/maps/place/{{value}}
  # #       icon_url: http://icons.iconarchive.com/icons/alecive/flatwoken/512/Apps-Google-Maps-icon.png
  #     sql: CONCAT(CONCAT(CONCAT(CONCAT(${TABLE}.STORE_ADDRESS,', '),${TABLE}.STORE_CITY),', '),${TABLE}.STORE_STATE)
  #     html: |
  #       <a href="https://www.google.com/maps/place/{{value}}" target="_blank">
  #       <img src="http://icons.iconarchive.com/icons/alecive/flatwoken/512/Apps-Google-Maps-icon.png" height=16></a>

  dimension: store_server_time_zone {
    label: "Pharmacy Time Zone (Central)"
    description: "Pharmacy Server Time Zone"
    sql: ${TABLE}.STORE_SERVER_TIME_ZONE ;;
  }

  dimension: store_address_deleted_flag {
    hidden: yes
    label: "Pharmacy Address Deleted Flag (Central)"
    description: "Y/N flag indicating whether or not the pharmacy has been marked as deleted"
    sql: ${TABLE}.STORE_ADDRESS_DELETED_FLAG ;;
  }

  dimension: store_registration_status {
    label: "Pharmacy Registration Status (Central)"
    description: "Registration Status of the pharmacy/store"
    sql: ${TABLE}.STORE_EPR_REGISTRATION_STATUS ;;
  }

  dimension: support_notes {
    label: "Pharmacy Support Notes (Central)"
    description: "Notes entered by the PDX support person"
    sql: ${TABLE}.STORE_SUPPORT_NOTES ;;
  }

  dimension: source_system_id {
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXLPS-753]
  dimension: phone_number {
    label: "Pharmacy Alternate Phone Number (Store)"
    description: "Pharmacy alternate contact phone number from Store Settings."
    sql: '('||${store_setting_phone_number_area_code.store_setting_value}||') '
            ||case when substr(${store_setting_phone_number.store_setting_value},4,1) = '-'
                   then ${store_setting_phone_number.store_setting_value}
                   else substr(${store_setting_phone_number.store_setting_value},1,3)||'-'||substr(${store_setting_phone_number.store_setting_value},4,4)
              end ;;
  }

  dimension: fax_number {
    label: "Pharmacy Fax Number (Store)"
    description: "Pharmacy fax number from Store Settings."
    sql: '('||${store_setting_fax_number_area_code.store_setting_value}||') '
            ||case when substr(${store_setting_fax_number.store_setting_value},4,1) = '-'
                   then ${store_setting_fax_number.store_setting_value}
                   else substr(${store_setting_fax_number.store_setting_value},1,3)||'-'||substr(${store_setting_fax_number.store_setting_value},4,4)
              end ;;
  }

  #[ERXDWPS-9281] - Pharmacy DEA information from Store Setting table.
  dimension: dea_number {
    label: "Pharmacy DEA Number (Store)"
    description: "Pharmacy DEA Number information from Store Settings."
    sql: ${store_setting_dea_number.store_setting_value} ;;
  }

  measure: count {
    label: "Pharmacy Count (Central)"
    description: "Total Pharmacies"
    type: count
    value_format: "#,##0"
    drill_fields: [store_information_drill_path*]
  }

  #[ERXLPS-717]
  set: store_information_drill_path {
    fields: [
      nhin_store_id,
      store_number,
      store_name,
      rx_tx.count,
      store_client_type,
      store_client_version,
      store_category,
      store_tls_compliant,
      #store_address,
      #store_city,
      #store_state,
      workflow_enabled_flag,
      store_server_time_zone,
      store_registration_status,
      store_alignment.division,
      store_alignment.region,
      store_alignment.district,
      store_alignment.pharmacy_open_date,
      store_alignment.pharmacy_close_date
     ]
  }
}

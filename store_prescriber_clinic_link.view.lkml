view: store_prescriber_clinic_link {
  label: "Store Prescriber Clinic Link"
  sql_table_name: EDW.D_STORE_PRESCRIBER_CLINIC_LINK ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_prescriber_clinic_link_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_prescriber_clinic_link_id {
    label: "Store Prescriber Clinic Link Id"
    description: "Unique Id number identifying this record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_prescriber_clinic_link_dea_number {
    label: "Store Prescriber Clinic Link Dea Number"
    description: "ID assigned to a Prescriber by the Drug Enforcement Agency (DEA) and is unique to a prescriber within a specific state in which they prescribe. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DEA_NUMBER ;;
  }

  dimension: store_prescriber_clinic_link_federal_tax_number {
    label: "Store Prescriber Clinic Link Federal Tax Number"
    description: "Federal Tax ID Number for the prescriber/clinic for which this Prescriber_Clinic_Link record exists. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_FEDERAL_TAX_NUMBER ;;
  }

  dimension: store_prescriber_clinic_link_health_industry_number {
    label: "Store Prescriber Clinic Link Health Industry Number"
    description: "Identifier assigned by HIBCC to uniquely identify health care facilities,their locations,and departments within them. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_HEALTH_INDUSTRY_NUMBER ;;
  }

  dimension_group: store_prescriber_clinic_link_deactivate {
    label: "Store Prescriber Clinic Link Deactivate"
    description: "Date/Time a prescriber clinic link record was or should be deactivated. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATE_DATE ;;
  }

  dimension: store_prescriber_clinic_link_primary_clinic_flag {
    label: "Store Prescriber Clinic Link Primary Clinic Flag"
    description: "Flag indicating if the Clinic for which this Prescriber Clinic Link record exists is the primary clinic for the associated prescriber. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG = 'N' THEN 'N - NO'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_PRIMARY_CLINIC_FLAG)
         END ;;
  }

  dimension: store_prescriber_clinic_link_location {
    label: "Store Prescriber Clinic Link Location"
    description: "HCID Location Code for this Prescriber/Clinic record assigned by the National Provider System (NPS). EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_LOCATION ;;
  }

  dimension: store_prescriber_clinic_link_central_prescriber_identifier {
    label: "Store Prescriber Clinic Link Central Prescriber Identifier"
    description: "Unique ID assigned by the vendor providing the Central prescriber database service. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_IDENTIFIER ;;
  }

  dimension_group: store_prescriber_clinic_link_central_prescriber_poll {
    label: "Store Prescriber Clinic Link Central Prescriber Poll"
    description: "The date and time the EPS application last received an update for a prescriber from the Rx.com Central Prescriber Service (RCPS). EPS Table: PRESCRIBER_CLINIC_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_POLL_DATE ;;
  }

  dimension: store_prescriber_clinic_link_central_prescriber_vendor_code {
    label: "Store Prescriber Clinic Link Central Prescriber Vendor Code"
    description: "Coded value that represents the Rx.com Central Prescriber Services (RCPS) Vendor. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_VENDOR_CODE = '1' THEN '1 - HDS'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_VENDOR_CODE is null THEN 'NOT APPLICABLE'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_VENDOR_CODE = '2' THEN '2 - HMS'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_CENTRAL_PRESCRIBER_VENDOR_CODE)
         END ;;
  }

  dimension: store_prescriber_clinic_link_do_not_verify_code {
    label: "Store Prescriber Clinic Link Do Not Verify Code"
    description: "Flag that indicates if the information associated with this prescibers clinis will be verified with the central prescriber database. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DO_NOT_VERIFY_CODE is null THEN 'NEVER CHECKED - WILL BE VERIFIED'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DO_NOT_VERIFY_CODE = 'Y' THEN 'Y - CLINIC WILL NOT BE VERIFIED'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DO_NOT_VERIFY_CODE = 'N' THEN 'N - CLINIC HAS BEEN VERIFIED'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DO_NOT_VERIFY_CODE)
         END ;;
  }

  dimension: store_prescriber_clinic_link_deactivated_by_rcps_flag {
    label: "Store Prescriber Clinic Link Deactivated By Rcps Flag"
    description: "Flag Indicating whether a prescriber was deactivated by Rx.com Central Prescriber Services (RCPS). EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATED_BY_RCPS_FLAG = 'Y' THEN 'Y - DEACTIVATED'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATED_BY_RCPS_FLAG = 'N' THEN 'N - ACTIVE'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DEACTIVATED_BY_RCPS_FLAG)
         END ;;
  }

  dimension: store_prescriber_clinic_link_prescriber_location_identifier {
    label: "Store Prescriber Clinic Link Prescriber Location Identifier"
    description: "A prescriber's clinic location ID that is provided by a third party (such as Emdeon) through the escript interface. Similar to the third party's version of a prescriber NPI number. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_PRESCRIBER_LOCATION_IDENTIFIER ;;
  }

  dimension: store_prescriber_clinic_link_disallow_prescriber_location_id_override_flag {
    label: "Store Prescriber Clinic Link Disallow Prescriber Location Id Override Flag"
    description: "A flag on the P-C-L table to indicate when a customer does not want the Prescriber Location ID for that prescriber overwritten during the Escript filling process. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DISALLOW_PRESCRIBER_LOCATION_ID_OVERRIDE_FLAG = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DISALLOW_PRESCRIBER_LOCATION_ID_OVERRIDE_FLAG = 'N' THEN 'N - NO'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_DISALLOW_PRESCRIBER_LOCATION_ID_OVERRIDE_FLAG)
         END ;;
  }

  dimension: store_prescriber_id {
    label: "Store Prescriber Id"
    description: "ID representing the prescriber record associated with a prescriber clinic link record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_ID ;;
  }

  dimension: clinic_id {
    label: "Clinic Id"
    description: "ID representing the clinic record associated with a prescriber clinic link record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_ID ;;
  }

  dimension: store_prescriber_clinic_link_merged_to_id {
    label: "Store Prescriber Clinic Link Merged To Id"
    description: "Prescriber Clinic Link ID of the surviving prescriber created after a prescriber merge has taken place. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_MERGED_TO_ID ;;
  }

  dimension: store_prescriber_clinic_link_supervising_prescriber_id {
    label: "Store Prescriber Clinic Link Supervising Prescriber Id"
    description: "The unique identifier for the supervising prescriber for the prescriber associated with this prescriber/clinic record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_SUPERVISING_PRESCRIBER_ID ;;
  }

  dimension: store_prescriber_clinic_link_office_phone_id {
    label: "Store Prescriber Clinic Link Office Phone Id"
    description: "The unique identifier of the phone number Phone record for this prescriber/clinic record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_OFFICE_PHONE_ID ;;
  }

  dimension: store_prescriber_clinic_link_fax_phone_id {
    label: "Store Prescriber Clinic Link Fax Phone Id"
    description: "The unique identifier for this fax number Phone record for this prescriber/clinic record. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_CLINIC_LINK_FAX_PHONE_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Prescriber Clinic Link Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Prescriber Clinic Link Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PRESCRIBER_CLINIC_LINK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

view: store_clinical_track {
  label: "Store Clinical Track"
  sql_table_name: EDW.D_STORE_CLINICAL_TRACK ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${clinical_track_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CLINICAL_TRACK"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CLINICAL_TRACK"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: clinical_track_id {
    label: "Clinical Track Id"
    description: "Unique ID number identifying a Clinical track record. EPS Table: CLINICAL_TRACK"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINICAL_TRACK_ID ;;
  }

  dimension: clinical_track_name {
    label: "Clinical Track Name"
    description: "Name for the Clinical Track. EPS Table: CLINICAL_TRACK"
    type: string
    sql: ${TABLE}.CLINICAL_TRACK_NAME ;;
  }

  dimension: clinical_track_description {
    label: "Clinical Track Description"
    description: "Detailed description for a Clinical Track. EPS Table: CLINICAL_TRACK"
    type: string
    sql: ${TABLE}.CLINICAL_TRACK_DESCRIPTION ;;
  }

  dimension: clinical_track_alternate_site_flag {
    label: "Clinical Track Alternate Site Flag"
    description: "Flag indicating whether tasks for this clinical track should be made available for a remote (alternate site) user. EPS Table: CLINICAL_TRACK"
    type: string
    sql: CASE WHEN ${TABLE}.CLINICAL_TRACK_ALTERNATE_SITE_FLAG = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.CLINICAL_TRACK_ALTERNATE_SITE_FLAG = 'N' THEN 'N - NO'
              ELSE TO_CHAR(${TABLE}.CLINICAL_TRACK_ALTERNATE_SITE_FLAG)
         END ;;
  }

  dimension_group: clinical_track_deactivate {
    label: "Clinical Track Deactivate"
    description: "Deactivation date/Time set when a clinical track is deactivated. EPS Table: CLINICAL_TRACK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.CLINICAL_TRACK_DEACTIVATE_DATE ;;
  }

  dimension_group: source_timestamp {
    label: "Clinical Track Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: CLINICAL_TRACK"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}

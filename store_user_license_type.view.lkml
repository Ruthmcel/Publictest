view: store_user_license_type {
  label: "User License Type"
  sql_table_name: EDW.D_USER_LICENSE_TYPE ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${user_license_type_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assigned to each customer chain by NHIN. EPS Table: LICENSE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "Identification number assigned to a store by SYMMETRIC via NODE_ID which is the NHIN_ID from NHIN under each customer chain. EPS Table: LICENSE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: user_license_type_id {
    label: "User License Type Id"
    description: "USER_ID is the FK to the USER table,records are linked through this table for one or more USERS records to a GROUP record. EPS Table: LICENSE_TYPE"
    type: number
    hidden: yes
    sql: ${TABLE}.USER_LICENSE_TYPE_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: user_license_type {
    label: "User License Type"
    description: "EPS user license type. EPS Table: LICENSE_TYPE"
    type: string
    sql: ${TABLE}.USER_LICENSE_TYPE ;;
  }

  dimension: user_license_type_description {
    label: "User License Type Description"
    description: "Describes EPS user license type. Example - Certified Pharmacy Technician License. EPS Table: LICENSE_TYPE"
    type: string
    sql: ${TABLE}.USER_LICENSE_TYPE_DESCRIPTION ;;
  }

  dimension_group: user_license_deactivate {
    label: "User License Type Deactivate"
    description: "Date/Time when the license type was deactivated by a user in ECC. EPS Table: LICENSE_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.USER_LICENSE_DEACTIVATE_DATE ;;
  }

  dimension: user_license_version_number {
    label: "User License Type Version Number"
    description: "This is used internally by the application to be able to keep EPS store in sync with the most recent change to the record in ECC. EPS Table: LICENSE_TYPE"
    type: number
    sql: ${TABLE}.USER_LICENSE_VERSION_NUMBER ;;
  }

  dimension_group: source_create_timestamp {
    label: "User License Type Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: LICENSE_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "User License Type Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: LICENSE_TYPE"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ############################################# measures #################################################
  measure: count {
    label: "User License Type Count"
    description: "Total User License Type count."
    type: count
    value_format: "#,##0"
    drill_fields: [store_user_license_type_drill_path*]
  }

  measure: bi_demo_count {
    label: "User License Type Count"
    description: "Total User License Type count."
    type: count
    value_format: "#,##0"
    drill_fields: [bi_demo_store_user_license_type_drill_path*]
  }



  ############################################# Sets #####################################################
  set: store_user_license_type_drill_path {
    fields: [
      chain.chain_name,
      store.nhin_store_id,
      store.store_number,
      store_user.store_user_employee_number,
      store_user.store_user_login,
      store_user.store_user_first_name,
      store_user.store_user_last_name,
      store_user_license_type.user_license_type
    ]
  }

  set: bi_demo_store_user_license_type_drill_path {
    fields: [
      bi_demo_chain.chain_name,
      bi_demo_store.bi_demo_nhin_store_id,
      bi_demo_store.store_number,
      bi_demo_store_user.store_user_employee_number,
      bi_demo_store_user.store_user_login,
      bi_demo_store_user.store_user_first_name,
      bi_demo_store_user.store_user_last_name,
      store_user_license_type.user_license_type
    ]
  }
}

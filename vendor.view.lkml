view: vendor {
  sql_table_name: EDW.D_VENDOR ;;

  dimension: vendor_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.VENDOR_ID ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: vendor_source_system_id {
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ######################################################################################################## Dimensions ####################################################################################

  dimension: vendor_name {
    label: "Vendor Name"
    description: "MDS Programs Vendor Name"
    type: string
    sql: ${TABLE}.VENDOR_NAME ;;
    full_suggestions: yes
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension: vendor_full_name {
    label: "Vendor Full Name"
    description: "NHIN Vendor Full Name"
    type: string
    hidden: yes
    sql: ${TABLE}.VENDOR_FULL_NAME ;;
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension: vendor_ncpdp_number {
    label: "Vendor NCPDP Number"
    description: "The NCPDP number that is assigned to the Vendor"
    type: string
    hidden: yes
    sql: ${TABLE}.VENDOR_NCPDP_NUMBER ;;
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension: vendor_npi_number {
    label: "Vendor NPI Number"
    description: "The NPI number assigned to the Vendor"
    type: string
    hidden: yes
    sql: ${TABLE}.VENDOR_NPI_NUMBER ;;
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension: nhin_vendor_id {
    label: "NHIN Vendor ID"
    description: "Unique number assigned to PDX Inc. Accounting to identify a Vendor"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_VENDOR_ID ;;
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension_group: vendor_disabled {
    type: time
    hidden: yes
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Vendor Disabled"
    description: "Date the vendor was set to disabled"
    sql: ${TABLE}.VENDOR_DISABLED_DATE ;;
  }

  #       This =column has all values null (as of 21st May 2019) for MDS source system. Vendor view file is currently used only in MDS explore and dimension marked as hidden. Please make sure the dimension is hidden in MDS explore until no data availalbe.
  dimension_group: vendor_deleted {
    type: time
    hidden: yes
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Vendor Deleted"
    description: "Date the vendor was set to deleted"
    sql: ${TABLE}.VENDOR_DELETED_DATE ;;
  }

  ######################################################################################################## Measures ####################################################################################

  measure: count {
    label: "Vendor Count"
    description: "Total Vendor"
    type: count
    drill_fields: [vendor_name, vendor_full_name]
  }
}

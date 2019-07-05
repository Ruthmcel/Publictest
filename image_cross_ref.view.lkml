view: image_cross_ref {
  sql_table_name: EDW.F_IMAGE_CROSS_REF ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${image_cross_ref_id} ;; #ERXLPS-1649
  }

  dimension: chain_id {
    type: number
    hidden: yes
    label: "Chain Id"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: image_cross_ref_id {
    type: number
    hidden: yes
    label: "Image Cross Ref Id"
    description: "Unique ID number identifying each record in this table, Image ID Number"
    sql: ${TABLE}.IMAGE_CROSS_REF_ID ;;
  }

  dimension: image_cross_ref_page_number {
    type: number
    label: "Page Number"
    description: "Page Number for > 1 page"
    sql: ${TABLE}.IMAGE_CROSS_REF_PAGE_NUMBER ;;
  }

  dimension: image_cross_ref_sequence_number {
    type: number
    label: "Sequence Number"
    description: "Sequence Number for > 1 page"
    sql: ${TABLE}.IMAGE_CROSS_REF_SEQUENCE_NUMBER ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: image_cross_ref_image_type_code {
    type: string
    label: "Image Type Code"
    description: "Image Type"

    case: {
      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 0 ;;
        label: "PRESCRIPTION"
      }

      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 1 ;;
        label: "PATIENT INFORMATION SHEET"
      }

      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 2 ;;
        label: "THIRD PARTY ID CARD"
      }

      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 3 ;;
        label: "SIGNATURE CAPTURE"
      }

      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 4 ;;
        label: "NO SAFETY CAPS"
      }

      when: {
        sql: ${TABLE}.image_cross_ref_image_type_code = 5 ;;
        label: "OTHER IMAGE"
      }
    }
  }

  dimension: image_cross_ref_path_identifier {
    type: number
    label: "Path Identifier"
    description: "Reference to Disk Path Record"
    sql: ${TABLE}.IMAGE_CROSS_REF_PATH_IDENTIFIER ;;
  }

  dimension: image_cross_ref_user_code {
    type: string
    label: "User Code"
    description: "User ID who scanned the record"
    sql: ${TABLE}.IMAGE_CROSS_REF_USER_CODE ;;
  }

  dimension: image_cross_ref_user_initials {
    type: string
    label: "User Initials"
    description: "User Initials who added the record"
    sql: ${TABLE}.IMAGE_CROSS_REF_USER_INITIALS ;;
  }

  dimension_group: image_cross_ref_added_timestamp {
    label: "Added"
    description: "Date/Time image was created"
    type: time
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.IMAGE_CROSS_REF_ADDED_TIMESTAMP ;;
  }

  dimension_group: image_cross_ref_deactivate_date {
    type: time
    label: "Deactivate"
    description: "Date/Time image was deactivated"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.IMAGE_CROSS_REF_DEACTIVATE_DATE ;;
  }

  dimension: image_cross_ref_deactivate_user_initials {
    type: string
    label: "Deactivate User Initials"
    description: "User initials who deactivated image"
    sql: ${TABLE}.IMAGE_CROSS_REF_DEACTIVATE_USER_INITIALS ;;
  }

  dimension_group: image_cross_ref_reactivate_date {
    type: time
    label: "Reactivate"
    description: "Date/Time image was reactivated"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.IMAGE_CROSS_REF_REACTIVATE_DATE ;;
  }

  dimension: image_cross_ref_reactivate_user_initials {
    type: string
    label: "Reactivate User Initials"
    description: "User initials who reactivated image"
    sql: ${TABLE}.IMAGE_CROSS_REF_REACTIVATE_USER_INITIALS ;;
  }

  dimension: image_cross_ref_pointer1 {
    type: string
    label: "Pointer1"
    description: "First key part to get to corresponding data record.If imagetype = 0, then rx number; imagetype = 1 then patient code; imagetype = 2, then carrier id; imagetype = 3, then is order etc"
    sql: ${TABLE}.IMAGE_CROSS_REF_POINTER1 ;;
  }

  dimension: image_cross_ref_pointer2 {
    type: string
    label: "Pointer2"
    description: "Second key part; imagetype = 0, then blank; imagetype = 1, then blank; imagetype = 2, then plan; imagetype = 3, then pickup signatures etc"
    sql: ${TABLE}.IMAGE_CROSS_REF_POINTER2 ;;
  }

  dimension: image_cross_ref_pointer3 {
    type: string
    label: "Pointer3"
    description: "Third key part; imagetype = 0, then blank; imagetype = 1, then blank; imagetype = 2, then group; imagetype = 3, then document signatures etc"
    sql: ${TABLE}.IMAGE_CROSS_REF_POINTER3 ;;
  }

  dimension: image_cross_ref_pointer4 {
    type: string
    label: "Pointer4"
    description: "Fourth key part; imagetype = 0, then blank; imagetype = 1, then blank; imagetype = 2, then card id; imagetype = 3, addnote structure for notes on pointer 2 & 3 etc"
    sql: ${TABLE}.IMAGE_CROSS_REF_POINTER4 ;;
  }

  dimension: image_cross_ref_inactive_flag {
    type: yesno
    label: "Inactive"
    description: "Yes/No flag indicating record is active"
    sql: ${TABLE}.IMAGE_CROSS_REF_INACTIVE_FLAG = 'Y' ;;
  }

  dimension: image_cross_ref_origin_device_code {
    type: string
    label: "Origin Device"
    description: "Device from which image is originated"

    case: {
      when: {
        sql: ${TABLE}.IMAGE_CROSS_REF_ORIGIN_DEVICE_CODE = 0 ;;
        label: "UNKNOWN"
      }

      when: {
        sql: ${TABLE}.IMAGE_CROSS_REF_ORIGIN_DEVICE_CODE = 1 ;;
        label: "CAPTURE PAD"
      }

      when: {
        sql: ${TABLE}.IMAGE_CROSS_REF_ORIGIN_DEVICE_CODE = 2 ;;
        label: "SCANNER"
      }
    }
  }

  dimension: image_cross_ref_pickup_scan_flag {
    type: yesno
    label: "Pickup Scan"
    description: "Yes/No flag indicating if image was scanned at pickup signatures tab"
    sql: ${TABLE}.IMAGE_CROSS_REF_PICKUP_SCAN_FLAG = 'Y' ;;
  }

  dimension: image_cross_ref_has_vector_graphic_flag {
    type: yesno
    label: "Has Vector Graphic Flag"
    description: "Yes/No flag indicating if the record has associated vector graphic"
    sql: ${TABLE}.IMAGE_CROSS_REF_HAS_VECTOR_GRAPHIC_FLAG = 'Y' ;;
  }

  dimension: image_cross_ref_phone_doctor_queue_id {
    type: number
    hidden: yes
    label: "Phone Doctor Queue Id"
    description: "doctor queue id"
    sql: ${TABLE}.IMAGE_CROSS_REF_PHONE_DOCTOR_QUEUE_ID ;;
  }

  measure: sum_image_cross_ref_quantity_owed {
    type: sum
    label: "Quantity Owed"
    description: "Quantity owed from 'Owed' split at Fill Station"
    sql: ${TABLE}.IMAGE_CROSS_REF_QUANTITY_OWED ;;
    value_format: "#,##0.00"
  }
}

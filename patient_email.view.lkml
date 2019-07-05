view: patient_email {
  sql_table_name: EDW.D_PATIENT_EMAIL ;;

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    label: "Central Patient RX COM ID"
    description: "Patient unique identifier"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: email_address {
    group_label: "Central Patient Email Info"
    label: "Central Patient Email Address"
    description: "Patient's email address. Contains both the Email Address and Mobile Service communication information of the patient."
    type: string
    sql: ${TABLE}.PATIENT_EMAIL_ADDRESS ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${email_address} ;; #ERXLPS-1649
  }

  dimension: deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.PATIENT_EMAIL_DELETED ;;
  }

  dimension: inactive {
    group_label: "Central Patient Email Info"
    label: "Central Patient Email Inactive"
    description: "Y/N Flag that determines if email record is active"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_EMAIL_INACTIVE = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: location_type {
    group_label: "Central Patient Email Info"
    label: "Central Patient Email Type"
    description: "Value that represents the type of email record"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_EMAIL_LOCATION_TYPE = 1 ;;
        label: "HOME"
      }

      when: {
        sql: ${TABLE}.PATIENT_EMAIL_LOCATION_TYPE = 2 ;;
        label: "WORK"
      }

      when: {
        sql: ${TABLE}.PATIENT_EMAIL_LOCATION_TYPE = 4 ;;
        label: "SCHOOL"
      }

      when: {
        sql: ${TABLE}.PATIENT_EMAIL_LOCATION_TYPE = 0 ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: sms_indicator {
    group_label: "Central Patient Email Info"
    label: "Central Patient Email SMS Indicator"
    description: "Y/N Flag that determines if email record is active"
    type: string

    case: {
      # Derived using the following logic on the ETL side: CASE WHEN AUTH_CODE IS NOT NULL AND TERMS_OF_SERVICE_DATE IS NOT NULL THEN 'Y' ELSE 'N' END
      when: {
        sql: ${TABLE}.PATIENT_EMAIL_SMS_INDICATOR = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: patient_email_count {
    label: "Central Patient Email Count"
    type: count
  }
}

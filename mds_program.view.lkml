view: mds_program {
  sql_table_name: EDW.D_PROGRAM ;;

  dimension: program_code {
    primary_key: yes
    label: "Program Code"
    description: "Stores the Program Name"
    type: string
    sql: ${TABLE}.PROGRAM_CODE ;;
  }

  dimension: program_description {
    type: string
    label: "Program Description"
    description: "Contains the user created description for this program"
    sql: ${TABLE}.PROGRAM_DESCRIPTION ;;
  }

  dimension: program_service_type {
    label: "Program Service Type"
    description: "Correlates to the type of program created in the document portal"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 0 ;;
        label: "DOCUMENT"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 1 ;;
        label: "EDIT MESSAGE"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 2 ;;
        label: "ICU"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 3 ;;
        label: "MEDICATION GUIDES"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 4 ;;
        label: "30 TO 90"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 5 ;;
        label: "PATIENT PRIVACY"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 7 ;;
        label: "PATIENT EDUCATION"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 9 ;;
        label: "LOGIN ALERT"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_TYPE = 10 ;;
        label: "PATIENT STATUS UPDATE"
      }

      when: {
        sql: true ;;
        label: "None of the Above"
      }
    }
  }

  dimension: program_service_class {
    type: string
    label: "Program Service Class"

    case: {
      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_CLASS = 0 ;;
        label: "NONE"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_CLASS = 1 ;;
        label: "PREFILL"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_CLASS = 2 ;;
        label: "POSTFILL"
      }

      when: {
        sql: ${TABLE}.PROGRAM_SERVICE_CLASS = 3 ;;
        label: "PATIENT PRIVACY"
      }
    }
  }

  dimension: program_program_type {
    label: "Program Type"
    description: "Generally references the 'NDC or GPI' field, but also represents some non-displayed values"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PROGRAM_PROGRAM_TYPE = 0 ;;
        label: "NDC"
      }

      when: {
        sql: ${TABLE}.PROGRAM_PROGRAM_TYPE = 1 ;;
        label: "GPI"
      }

      when: {
        sql: ${TABLE}.PROGRAM_PROGRAM_TYPE = 2 ;;
        label: "LOGIN ALERT"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: program_sow {
    label: "Program SOW"
    description: "Statement Of Work Identifier"
    type: string
    sql: ${TABLE}.PROGRAM_SOW ;;
  }

  dimension: program_maximum_number_transactions {
    type: number
    sql: ${TABLE}.PROGRAM_MAXIMUM_NUMBER_TRANSACTIONS ;;
  }

  dimension_group: program_publish {
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Program Publish"
    description: "Contains the date when the program is published and available for general audience"
    sql: ${TABLE}.PROGRAM_PUBLISH_DATE ;;
  }

  dimension_group: program_start {
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Program Start"
    description: "Contains the date the program begins being effective"
    sql: ${TABLE}.PROGRAM_START_DATE ;;
  }

  dimension_group: program_end {
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Program End"
    description: "Contains the date when the program expires or should no longer be utilized at the client"
    sql: ${TABLE}.PROGRAM_END_DATE ;;
  }

  dimension_group: program_deactivated {
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Program Deactivated"
    description: "Indicates when the program was deactivated"
    sql: ${TABLE}.PROGRAM_DEACTIVATED_DATE ;;
  }

  dimension: program_user_type {
    #       This column has all values null (as of 21st May 2019)
    hidden: yes
    label: "Program User Type"
    description: "Contains for which type of user this alert message should display"
    type: number
    sql: ${TABLE}.PROGRAM_USER_TYPE ;;
  }

  dimension: program_alert_type {
    #       This column has all values null (as of 21st May 2019)
    hidden: yes
    label: "Program Alert Type"
    description: "Filters alert messages based on FDA MANDATED, NEW PRODUCT ANNOUNCEMENT, DRUG RECALL, MISCELLANEOUS, etc"
    type: number
    sql: ${TABLE}.PROGRAM_ALERT_TYPE ;;
  }

  dimension: program_message {
    #       This column has all values null (as of 21st May 2019)
    hidden: yes
    label: "Program Message"
    description: "Holds the customized alert message to display to the use"
    type: string
    sql: ${TABLE}.PROGRAM_MESSAGE ;;
  }

  dimension: program_reoccurrence {
    #       This column has all values null (as of 21st May 2019)
    hidden: yes
    label: "Program Reoccurrence"
    description: "Stores a value representing if and how often an alert should redisplay"
    type: number
    sql: ${TABLE}.PROGRAM_REOCCURRENCE ;;
  }

  dimension: program_id {
    hidden: yes
    type: string
    sql: ${TABLE}.PROGRAM_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXDWPS-8402][ERXDWPS-1677]
  dimension: sponsor_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SPONSOR_ID ;;
  }

  measure: count {
    label: "Program Count"
    type: count
    value_format: "#,##0"
    drill_fields: [
      mds_program.program_code,
      mds_program.program_description,
      mds_transaction.transaction_request_time,
      drug.drug_ndc,
      drug.drug_full_name,
      drug.drug_manufacturer,
      mds_transaction.count
    ]
  }

  measure: program_pdx_fee {
    label: "Program PDX fee"
    description: "PDX fee tied to the Program"
    type: sum
    sql: ${TABLE}.PROGRAM_PDX_FEE ;;
  }

  measure: program_pharmacy_fee {
    label: "Program Pharmacy fee"
    description: "Pharmacy fee tied to the Program"
    type: sum
    sql: ${TABLE}.PROGRAM_PHARMACY_FEE ;;
  }

  measure: program_manufacturer_bill_amount {
    label: "Program Manufacturer Bill Amount"
    description: "Manufacturer Bill Amount tied to the Program"
    type: sum
    sql: ${TABLE}.PROGRAM_MANUFACTURER_BILL_AMOUNT ;;
  }
}

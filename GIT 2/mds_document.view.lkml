view: mds_document {
  sql_table_name: EDW.D_DOCUMENT ;;

  dimension: document_identifier {
    primary_key: yes
    label: "Document Identifier"
    description: "Unique ID assigned to a Document. Documents could be located using this document identifer"
    type: string
    sql: ${TABLE}.DOCUMENT_IDENTIFIER ;;
  }

  dimension: document_description {
    label: "Document Description"
    description: "Contains the description for this document"
    type: string
    sql: ${TABLE}.DOCUMENT_DESCRIPTION ;;
  }

  dimension: document_age_max {
    label: "Document Age - Max"
    description: "Optional filter criteria for the program printing. It is the maximum age of the patient to still return a PRINT=Y in the PrintDocumentResponse"
    type: number
    sql: ${TABLE}.DOCUMENT_AGE_MAX ;;
  }

  dimension: document_age_min {
    label: "Document Age - Min"
    description: "Optional filter criteria for the program printing. It is the minimum age of the patient to still return a PRINT=Y in the PrintDocumentResponse"
    type: number
    sql: ${TABLE}.DOCUMENT_AGE_MIN ;;
  }

  dimension: document_gender {
    label: "Document Patient Gender"
    description: "Gender (Male/Female) of the patient must match the DOCUMENTS.GENDER for MDS to return a PRINT=Y"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_GENDER = 'M' ;;
        label: "MALE"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_GENDER = 'F' ;;
        label: "FEMALE"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: document_bin_list_function {
    label: "Document BIN List Function"
    description: "Represents whether you INCLUDE/EXCLUDE a certain set of TPs (BIN, PCN, GROUPs) from returning a PRINT=Y"
    type: string
    sql: ${TABLE}.DOCUMENT_BIN_LIST_FUNCTION ;;
    suggestions: ["INCLUDE", "EXCLUDE"]
  }

  dimension: document_check_sum {
    label: "Document CHECKSUM"
    description: "Stores the value for the executable command 'chksum' which provides a check value for a file. This check sum can be check before and after transmission to verify document integrity"
    type: string
    sql: ${TABLE}.DOCUMENT_CHECK_SUM ;;
  }

  dimension: document_days_between {
    label: "Document Days Between"
    description: "Minimum number of days that must occur before MDS will return another PRINT=Y"
    type: number
    sql: ${TABLE}.DOCUMENT_DAYS_BETWEEN ;;
  }

  dimension: document_days_supply_end {
    label: "Document Days Supply End"
    description: "Maximum prescription transaction Days Supply required in the PrintDocumentRequest to return a PRINT=Y"
    type: number
    sql: ${TABLE}.DOCUMENT_DAYS_SUPPLY_END ;;
  }

  dimension: document_days_supply_start {
    label: "Document Days Supply Start"
    description: "Minimum prescription transaction Days Supply required in the printDocumentRequest to return a PRINT=Y"
    type: number
    sql: ${TABLE}.DOCUMENT_DAYS_SUPPLY_START ;;
  }

  dimension_group: document_deactivated {
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
    label: "Document Deactivated"
    description: "Indicates when the document was deactivated"
    sql: ${TABLE}.DOCUMENT_DEACTIVATED_DATE ;;
  }

  dimension: document_edit_location {
    label: "Document Edit Location"
    description: "Stores where a preEdit message should display at the store"
    type: string
    sql: ${TABLE}.DOCUMENT_EDIT_LOCATION ;;
  }

  dimension: document_fill_filter {
    label: "Document Fill Filter"
    description: "Specifies whether a PRINT=Y should be returned for a NEW or a REFILL prescription"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_FILL_FILTER = 1 ;;
        label: "NEW ONLY"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_FILL_FILTER = 2 ;;
        label: "REFILLS ONLY"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_FILL_FILTER = 0 ;;
        label: "ALL"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: document_max_between {
    label: "Max per Days Between"
    description: "The transaction (since the previous) must fall within the MAX_BETWEEN value for MDS to return a PRINT=Y"
    type: number
    sql: ${TABLE}.DOCUMENT_MAX_BETWEEN ;;
  }

  dimension: document_restrict_incentives_plan {
    label: "Document Restrict Incentives Plan"
    description: "Correlates to the Incentives TP filter criteria. If any of the Patient's TP plans are marked as 'Govenrment Plans', MDS will return the appropriate PRINT response"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_RESTRICT_INCENTIVES_PLAN = 0 ;;
        label: "ALLOW"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_RESTRICT_INCENTIVES_PLAN = 1 ;;
        label: "DISALLOW"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: document_restrict_workers_comp {
    label: "Document Restrict Workers Comp"
    description: "Correlates to the Workers Comp TP filter criteria. If any of the Patient's TP plans are marked as 'Workers Compensation Plans', MDS will return the appropriate PRINT response"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_RESTRICT_WORKERS_COMP = 0 ;;
        label: "ALLOW"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_RESTRICT_WORKERS_COMP = 1 ;;
        label: "DISALLOW"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: document_multisource {
    label: "Document Multisource"
    description: "Flag is used to determine whether a program should apply to GENERIC or NON-GENERIC drugs"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_MULTISOURCE = '1' ;;
        label: "GENERIC"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_MULTISOURCE = '2' ;;
        label: "NON-GENERIC"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: document_print_serial_number {
    label: "Document Print Serial Number"
    description: "YES/NO Flag is used to determine whether a program should apply to GENERIC or NON-GENERIC drugs"
    type: string

    case: {
      when: {
        sql: ${TABLE}.DOCUMENT_PRINT_SERIAL_NUMBER = 1 ;;
        label: "YES"
      }

      when: {
        sql: ${TABLE}.DOCUMENT_PRINT_SERIAL_NUMBER = 0 ;;
        label: "NO"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: program_code {
    # foreign key tied to the MDS program view.
    hidden: yes
    type: string
    sql: ${TABLE}.PROGRAM_CODE ;;
  }

  dimension: document_deleted {
    # this field will be used in the LookML file to exclude programs that have been deleted.
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_DELETED ;;
  }

  dimension: document_tcs_sheet {
    # Need to determine the usage of this field before exposing in the Explore.
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_TCS_SHEET ;;
  }

  dimension: document_priority {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: number
    sql: ${TABLE}.DOCUMENT_PRIORITY ;;
  }

  dimension: document_fills_remaining {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_FILLS_REMAINING ;;
  }

  dimension: document_fill_number {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_FILL_NUMBER ;;
  }

  dimension: document_confirmation_gpi {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_CONFIRMATION_GPI ;;
  }

  dimension: document_state_list_function {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_STATE_LIST_FUNCTION ;;
  }

  dimension: document_zip_code_list_function {
    #       This column has all values null (as of 16th May 2016)
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_ZIP_CODE_LIST_FUNCTION ;;
  }

  dimension: document_id {
    hidden: yes
    type: number
    sql: ${TABLE}.DOCUMENT_ID ;;
  }

  dimension: document_program_id {
    hidden: yes
    type: number
    sql: ${TABLE}.DOCUMENT_PROGRAM_ID ;;
  }

  dimension: document_ndc_update_id {
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_NDC_UPDATE_ID ;;
  }

  dimension: document_lcr_id {
    hidden: yes
    type: number
    sql: ${TABLE}.DOCUMENT_LCR_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: count {
    label: "Document Count"
    type: count
    drill_fields: [
      mds_program.program_code,
      mds_program.program_description,
      document_identifier,
      document_description,
      document_age_max,
      document_age_min,
      document_max_between,
      document_days_supply_start,
      document_days_supply_end,
      document_days_between,
      document_edit_location,
      document_fill_filter,
      document_multisource
    ]
  }
}

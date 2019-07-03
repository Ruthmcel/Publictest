view: bi_demo_sales_eps_tx_tp_other_payer {
  sql_table_name: EDW.F_TX_TP_OTHER_PAYER ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number. This field is EPS only!!!"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_other_payer_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg}  ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Other Payer Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Other Payer NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. This field is EPS only!!!"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_other_payer_id {
    type: number
    hidden: yes
    label: "Other Payer ID"
    sql: ${TABLE}.TX_TP_OTHER_PAYER_ID ;;
  }

  dimension: tx_tp_id {
    type: number
    label: "Transaction Third Party ID"
    hidden: yes
    description: "Transaction Third Party ID associated with the other payer record. This field is EPS only!!!"
    sql: ${TABLE}.TX_TP_ID ;;
  }

  ########################################################################################### End of Foreign Key References #####################################################################################################

  ######################################################################################################### Dimension ############################################################################################################

  dimension: tx_tp_other_payer_number {
    label: "Other Payer Number"
    description: "Unique sequence number for the other payer. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.TX_TP_OTHER_PAYER_NUMBER ;;
    value_format: "######"
  }

  dimension: tx_tp_other_payer_coverage_type {
    label: "Other Payer Coverage Type"
    description: "Code identifying the type of 'Other Payer ID' (34Ø-7C). NCPDP field 338-5C. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '01' ;;
        label: "Primary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '02' ;;
        label: " Secondary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '03' ;;
        label:"Tertiary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '04' ;;
        label:"Quaternary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '05' ;;
        label:"Quinary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '06' ;;
        label:" Senary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '07' ;;
        label:" Septenary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '08' ;;
        label:" Octonary"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_COVERAGE_TYPE = '09' ;;
        label:"Nonary"
      }

      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_other_payer_identifier {
    label: "Other Payer Identifier"
    description: "Identifies the 'OTHER PAYER' NCPDP field 34Ø-7C. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER ;;
  }

  dimension: tx_tp_other_payer_identifier_qualifier {
    label: "Other Payer Identifier Qualifier"
    description: "Code qualifying the 'Other Payer ID' (34Ø-7C). NCPDP field 339-6C. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '01' ;;
        label: "National Payer ID"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '1C' ;;
        label: "Medicare Number"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '1D' ;;
        label:"Medicaid Number"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '02' ;;
        label:"Health Industry Number (HIN)"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '03' ;;
        label:"Bank Information Number(BIN)"
      }

      when: {
          sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '04' ;;
        label:"National Association Of Insurance Commissioners(NAIC)"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '05' ;;
        label:"Medicare Carrier Number"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '09' ;;
        label:"Coupon"
      }

      when: {
        sql: ${TABLE}.TX_TP_OTHER_PAYER_IDENTIFIER_QUALIFIER = '99' ;;
        label:"Other"
      }

      when: {
        sql: true ;;
        label:"NOT SPECIFIED"
      }
    }
  }

  dimension: tx_tp_other_payer_deleted {
    label: "Other Payer Deleted"
    description: "Yes/No flag indicating the record has been deleted in the source table. This field is EPS only!!!"
    hidden: yes
    type: yesno
    sql: ${TABLE}.TX_TP_OTHER_PAYER_DELETED = 'Y' ;;
  }

  #[ERXLPS-1845] Reference dimension added to use in joins.
  dimension: tx_tp_other_payer_deleted_reference {
    label: "Other Payer Deleted"
    description: "Y/N Flag indicating soft delete of record in the source table. This field is EPS only!!!"
    hidden: yes
    type: string
    sql: ${TABLE}.TX_TP_OTHER_PAYER_DELETED ;;
  }

  ####################################################################################################### End of Dimension #################################################################################################################


  ########################################################################################################## Date/Time Dimensions #############################################################################################

  dimension_group: tx_tp_other_payer {
    label: "Other Payer"
    description: "Date/Time payment or denial of the claim submitted to the other payer. NCPDP field 443-E8. This field is EPS only!!!"
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
    sql: ${TABLE}.TX_TP_OTHER_PAYER_DATE ;;
  }

  ################################################################################################### End of Date/Time Dimensions #############################################################################################
}

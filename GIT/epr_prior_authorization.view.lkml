view: epr_prior_authorization {
  label: "Prior Authorization"
  sql_table_name: EDW.F_PRIOR_AUTHORIZATION ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${prior_authorization_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "ID number for chain. EPR Table: PA_NUM"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: prior_authorization_id {
    label: "Prior Authorization Id"
    description: "Unique ID number identifying a prescriber record. EPR Table: PA_NUM"
    type: number
    hidden: yes
    sql: ${TABLE}.PRIOR_AUTHORIZATION_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN_ID is the unique ID number assigned by NHIN for the store associated to this RX_TX record. EPR Table: PA_NUM"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: prior_auth_number {
    label: "Prior Auth Number"
    description: "Prior authorization number. EPR Table: PA_NUM"
    type: string
    sql: ${TABLE}.PRIOR_AUTH_NUMBER ;;
  }

  dimension: prior_auth_counter {
    label: "Prior Auth Counter"
    description: "Value indicating if a transaction third party record is for the primary,secondary,tertiary etc third party. EPR Table: PA_NUM"
    type: string
    sql: CASE WHEN ${TABLE}.PRIOR_AUTH_COUNTER is null THEN 'PRIMARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '0' THEN '0 - PRIMARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '1' THEN '1 - SECONDARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '2' THEN '2 - TERTIARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '3' THEN '3 - QUATERNARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '4' THEN '4 - QUINARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '5' THEN '5 - SENARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '6' THEN '6 - SEPTENARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '7' THEN '7 - OCTONARY'
              WHEN ${TABLE}.PRIOR_AUTH_COUNTER = '8' THEN '8 - NONARY'
              ELSE TO_CHAR(${TABLE}.PRIOR_AUTH_COUNTER)
         END ;;
  }

  dimension: prior_auth_type {
    label: "Prior Auth Type"
    description: "Flag that indicates what type of prior authorization this record represents. EPR Table: PA_NUM"
    type: string
    sql: CASE WHEN ${TABLE}.PRIOR_AUTH_TYPE is null THEN 'NONE'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '0' THEN '0 - UNKNOWN'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '1' THEN '1 - PRIOR AUTH'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '2' THEN '2 - MEDICAL CERTIFIED'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '3' THEN '3 - EPSDT'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '4' THEN '4 - NO COPAY'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '5' THEN '5 - NO RX LIMITS'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '6' THEN '6 - FAMILY PLANNING'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '7' THEN '7 - AFDC AID'
              WHEN ${TABLE}.PRIOR_AUTH_TYPE = '8' THEN '8 - PAYOR EXEMPTION'
              ELSE TO_CHAR(${TABLE}.PRIOR_AUTH_TYPE)
         END ;;
  }

  dimension: prior_auth_rx_amount {
    label: "Prior Auth Rx Amount"
    description: "Accumulated dollar amount used for this prior authorization. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_RX_AMOUNT ;;
  }

  dimension: prior_auth_amount {
    label: "Prior Auth Amount"
    description: "Maximum dollar amount this authorization allows. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_AMOUNT ;;
  }

  dimension_group: prior_auth_effective {
    label: "Prior Auth Effective"
    description: "Date/Time the authorization is effective. EPR Table: PA_NUM"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.PRIOR_AUTH_EFFECTIVE_DATE ;;
  }

  dimension_group: prior_auth_expiration {
    label: "Prior Auth Expiration"
    description: "Date/Time the authorization expires. EPR Table: PA_NUM"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.PRIOR_AUTH_EXPIRATION_DATE ;;
  }

  dimension: prior_auth_fills {
    label: "Prior Auth Fills"
    description: "Number of times you can fill this prescription under this authorization. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_FILLS ;;
  }

  dimension: prior_auth_fill_number {
    label: "Prior Auth Fill Number"
    description: "Number of fills for which this prior authorization has previously been used. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_FILL_NUMBER ;;
  }

  dimension_group: prior_auth_processed {
    label: "Prior Auth Processed"
    description: "Date/Time the authorization was processed or entered. EPR Table: PA_NUM"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.PRIOR_AUTH_PROCESSED_DATE ;;
  }

  dimension: prior_auth_quantity {
    label: "Prior Auth Quantity"
    description: "Authorized quantity that has been dispensed. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_QUANTITY ;;
  }

  dimension: prior_auth_total_quantity {
    label: "Prior Auth Total Quantity"
    description: "Total authorized quantity. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_TOTAL_QUANTITY ;;
  }

  dimension: prior_auth_repeat {
    label: "Prior Auth Repeat"
    description: "Flag that determines which fill of the prescription this authorization covers. EPR Table: PA_NUM"
    type: string
    sql: CASE WHEN ${TABLE}.PRIOR_AUTH_REPEAT is null THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.PRIOR_AUTH_REPEAT = '0' THEN '0 - THIS FILL ONLY'
              WHEN ${TABLE}.PRIOR_AUTH_REPEAT = '1' THEN '1 - ALL FILLS OF RX'
              WHEN ${TABLE}.PRIOR_AUTH_REPEAT = '2' THEN '2 - ALL FILLS AND REASSIGN'
              ELSE TO_CHAR(${TABLE}.PRIOR_AUTH_REPEAT)
         END ;;
  }

  dimension: prior_auth_tx_number {
    label: "Prior Auth Tx Number"
    description: "Number identifying the TX (transaction) of the prescription. EPR Table: PA_NUM"
    type: number
    sql: ${TABLE}.PRIOR_AUTH_TX_NUMBER ;;
  }

  dimension: tx_tp_id {
    label: "Tx Tp Id"
    description: "Unique ID number identifying this EPR Third Party record. EPR Table: PA_NUM"
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: prior_auth_deleted {
    label: "Prior Auth Deleted"
    description: "Flag that indicates whether this prior auth has been deleted in the source system. EPR Table: PA_NUM"
    type: string
    sql: CASE WHEN ${TABLE}.PRIOR_AUTH_DELETED = 'N' THEN 'N - NO'
              WHEN ${TABLE}.PRIOR_AUTH_DELETED = 'Y' THEN 'Y - YES'
              ELSE TO_CHAR(${TABLE}.PRIOR_AUTH_DELETED)
         END ;;
  }

  dimension_group: source_timestamp {
    label: "Prior Auth Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PA_NUM"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension: prior_auth_lcr_id {
    label: "Prior Auth Lcr Id"
    description: "Unique ID populated during the data load process that identifies the record. EPR Table: PA_NUM"
    type: number
    hidden: yes
    sql: ${TABLE}.PRIOR_AUTH_LCR_ID ;;
  }

}

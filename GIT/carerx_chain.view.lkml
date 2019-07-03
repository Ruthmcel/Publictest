view: carerx_chain {
  sql_table_name: MTM_CLINICAL.CHAIN ;;
  ## ======= The following MTM_CLINICAL.CHAIN Database Objects were not exposed in this view ======= ##
  ##  ADDRESS_LINE1
  ##  CITY
  ##  STATE
  ##  POSTAL_CODE

  # used for joining with other tables in the MTM_CLINICAL schema
  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Identification number assigned to each customer Chain by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_NHIN_ID ;;
  }

  dimension: chain_carerx_nhin_id {
    label: "Chain CareRx NHIN ID"
    description: "NHIN ID of the chain as assigned by Care Rx (CHN). The Care Rx NHIN ID is used within the Care Rx Application. This is not the Chain NHIN ID that is assigned by NHIN."
    type: number
    sql: ${TABLE}.CARERX_NHIN_ID ;;
  }

  ################################################################################################## Dimensions #################################################################################################

  dimension: chain_name {
    label: "Chain Name"
    description: "Name of the Chain"
    type: string
    sql: TRIM(REGEXP_REPLACE(REGEXP_REPLACE(TRIM(UPPER(${TABLE}.NAME)), '^(Z?[-_]?CLOSED[ ]*[-]?)*', ' '),'([-]?[ ]*Z?[-_]?CLOSED)*$', '')) ;;
  }

  dimension: chain_is_closed {
    label: "Chain is Closed"
    description: "Yes / No Flag that indicates if a chain is open or closed. All closed chains will hold a deactivated date"
    type: yesno
    sql: ${TABLE}.DEACTIVATED_DATE IS NOT NULL ;;
  }

  dimension: chain_fed_tax_id {
    label: "Chain Federal Tax ID"
    description: "The Federal Tax Identification Number assigned to the chain, which is used to nationally identify the business entity"
    type: string
    sql: ${TABLE}.EMPLOYER_ID_NUMBER ;;
  }

  dimension: chain_identity_provider_url {
    label: "Chain Identity Provider URL"
    description: "The login URL of the Identity Provider (IDP) for the chain"
    hidden: yes
    type: string
    sql: ${TABLE}.IDP_URL ;;
  }

  dimension: carerx_customer_yesno {
    label: "Chain Signed up for CareRx"
    description: "Indicates if the Chain or Chains has signed up for Care Rx and has been issued a CareRx NHIN ID. This does not indicate if they are actively using CareRx today"
    type: yesno
    sql: ${TABLE}.CARERX_NHIN_ID IS NOT NULL ;;
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: chain_deactivated {
    type: time
    timeframes: [
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    label: "Chain Deactivated"
    description: "The date/time that the chain was deactivated"
    sql: ${TABLE}.DEACTIVATED_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: count {
    label: "Chain Count"
    type: count
    value_format: "#,##0"
    drill_fields: [chain_information*]
  }

  ################################################################################################## DELETED #################################################################################################

  dimension: chain_deleted {
    label: "Chain Deleted Flag"
    description: "The database flag that indicates a record has been logically deleted"
    type: string
    sql: ${TABLE}.DELETED ;;
  }

  ################################################################################################## SETS #################################################################################################

  set: chain_information {
    fields: [chain_name, chain_id, chain_carerx_nhin_id, chain_deactivated_date]
  }
}

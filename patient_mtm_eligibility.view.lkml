view: patient_mtm_eligibility {
  sql_table_name: EDW.D_PATIENT_MTM_ELIGIBILITY ;;

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

  dimension: id {
    hidden: yes
    description: "Unique ID identifying a patient mtm record on the Rx.com network"
    type: number
    sql: ${TABLE}.PATIENT_MTM_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${rx_com_id} ||'@'|| ${id} ;; #ERXLPS-1649
  }

  dimension_group: delivery_service_date {
    label: "Central Patient MTM Delivery Service"
    description: "Date/Time the patient's last comprehensive medical review was conducted by the pharmacist"
    type: time
    # time component is not included as the data in EPR is always set to 12 noon
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
      day_of_month
    ]
    sql: ${TABLE}.PATIENT_MTM_DELIVERY_SVC_DATE ;;
  }

  dimension: vendor_identifier {
    label: "Central Patient MTM Service Vendor Identifier"
    description: "Identity of the vendor of the MTM services the patient is receiving"
    type: string
    sql: ${TABLE}.PATIENT_MTM_VENDOR_IDENTIFIER ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  measure: patient_mtm_eligibility_count {
    label: "Central Patient MTM Eligibility Count"
    type: count
  }
}

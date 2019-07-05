view: eps_pharmacy {

  label: "Pharmacy"
  sql_table_name: EDW.D_PHARMACY ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'||${nhin_store_id} ||'@'||${pharmacy_id} ;;
  }

  ######################################################### Primary / Foreign Key References #########################################################

  dimension: chain_id {
    label: "Chain ID"
    description: "Chain Identifier. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID"
    description: "NHIN Store ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: pharmacy_id {
    label: "Pharmacy ID"
    description: "Pharmacy ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: pharmacy_notes_id {
    label: "Pharmacy Notes ID"
    description: "Row ID of the note that is attacted to the pharmacy table. Foreign key to the Notes table. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_NOTES_ID ;;
  }

  dimension: pharmacy_address_id {
    label: "Pharmacy Address ID"
    description: "Row ID of the Address table for the pharmacy address - foreign key to the Address table. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_ADDRESS_ID ;;
  }
  dimension: pharmacy_phone_id {
    label: "Pharmacy Phone ID"
    description: "Row ID for the record in the phone table the corresponds to the Pharmacy's phone number. Foreign key to the Phone table. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_PHONE_ID ;;
  }
  dimension: pharmacy_fax_phone_id {
    label: "Pharmacy Fax Phone ID"
    description: "Row ID for the record in the phone table the corresponds to the Pharmacy's fax number. Foreign key to the Phone table. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.PHARMACY_FAX_PHONE_ID ;;
  }

  ######################################################### End Primary / Foreign Key References #####################################################

  #################################################################### Dimensions ####################################################################

  dimension: pharmacy_nhin_store_id {
    label: "Pharmacy NHIN Store ID"
    description: "Pharmacy NHIN Store ID. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.PHARMACY_NHIN_STORE_ID ;;
  }

  dimension: pharmacy_name {
    label: "Pharmacy Name"
    description: "Pharmacy Name. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PHARMACY_NAME ;;
  }

  dimension: pharmacy_store_number {
    label: "Pharmacy NHIN Store Number"
    description: "Pharmacy Store Number. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PHARMACY_STORE_NUMBER ;;
  }

  dimension: pharmacy_dea_number {
    label: "Pharmacy DEA Number"
    description: "Pharmacy federal DEA Number. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PHARMACY_DEA_NUMBER ;;
  }

  dimension: pharmacy_npi_number {
    label: "Pharmacy NPI Number"
    description: "National Provider ID for the Pharmacy. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PHARMACY_NPI_NUMBER ;;
  }

  dimension: pharmacy_contact {
    label: "Pharmacy Contact"
    description: "Name of pharmacy contact person. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.PHARMACY_CONTACT ;;
  }

  dimension_group: pharmacy_deactivate {
    label: "Pharmacy Deactivate"
    description: "Date the pharmacy record is no longer active. This field is EPS only!!!"
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
    sql: ${TABLE}.PHARMACY_DEACTIVATE_DATE ;;
  }
}

view: eps_patient_address_hist {
  derived_table: {
    sql: with eps_rx_tx
         as (select r.chain_id,
                    r.nhin_store_id,
                    r.rx_id,
                    r.rx_patient_id,
                    l.rx_tx_id,
                    l.rx_tx_fill_date,
                    l.source_system_id
               from edw.f_rx_tx_link l,
                    edw.f_rx r
              where l.chain_id = r.chain_id
                and l.nhin_store_id = r.nhin_store_id
                and l.rx_id = r.rx_id
                and r.source_system_id = l.source_system_id
                and {% condition chain.chain_id %} r.chain_id {% endcondition %}
                and {% condition store.nhin_store_id %} r.nhin_store_id {% endcondition %}
                -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                and r.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                          where source_system_id = 5
                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                            and {% condition store.store_number %} store_number {% endcondition %})
                and {% condition chain.chain_id %} l.chain_id {% endcondition %}
                and {% condition store.nhin_store_id %} l.nhin_store_id {% endcondition %}
                -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                and l.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                          where source_system_id = 5
                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                            and {% condition store.store_number %} store_number {% endcondition %})
                and r.source_system_id = 4
                and l.source_system_id = 4
            ),
         address_hist
         as (select p.chain_id,
                    p.nhin_store_id,
                    p.patient_id,
                    a.address_id,
                    a.source_system_id,
                    a.address_line_1,
                    a.address_line_2,
                    a.address_city,
                    a.address_state,
                    a.address_postal_code,
                    a.address_src_postal_code,
                    a.address_country,
                    a.address_po_box_flag,
                    a.address_do_not_verify_flag,
                    a.address_validated_flag,
                    a.address_home_phone_id,
                    a.address_work_phone_id,
                    a.source_create_timestamp,
                    a.source_timestamp
              from edw.d_store_patient p,
                   edw.d_address_hist a,
                   edw.d_patient_address_link pal
             where p.chain_id = pal.chain_id
               and p.nhin_store_id = pal.nhin_store_id
               and p.patient_id = to_char(pal.patient_id)
               and p.source_system_id = pal.source_system_id
               and a.chain_id = pal.chain_id
               and a.nhin_store_id = pal.nhin_store_id
               and a.address_id = pal.address_id
               and a.source_system_id = pal.source_system_id
               and {% condition chain.chain_id %} p.chain_id {% endcondition %}
               and {% condition store.nhin_store_id %} p.nhin_store_id {% endcondition %}
               -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
               and p.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                        where source_system_id = 5
                                          and {% condition chain.chain_id %} chain_id {% endcondition %}
                                          and {% condition store.store_number %} store_number {% endcondition %})
               and p.source_system_id = 4
            )
         select *
          from (select a.*,
                       tx.rx_tx_id,
                       tx.rx_tx_fill_date,
                       row_number() over(partition by tx.chain_id, tx.nhin_store_id, tx.rx_tx_id, tx.source_system_id order by a.source_timestamp desc) rnk
                  from eps_rx_tx tx,
                       address_hist a
                 where tx.chain_id = a.chain_id
                   and tx.nhin_store_id = a.nhin_store_id
                   and tx.rx_patient_id = a.patient_id
                   and tx.source_system_id =a.source_system_id
                   and a.source_timestamp <= tx.rx_tx_fill_date
               ) s
         where s.rnk = 1
       ;;
  }



  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'||${source_system_id} ;; #ERXLPS-1649  #ERXDWPS-5137
  }

  ################################################################## Foreign Key references##############################

  dimension: chain_id {
    label: "Chain ID - History"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "NHIN Store ID - History"
    description: "Unique ID number assigned by NHIN for the store associated to this record"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: address_id {
    label: "Address Id - History"
    type: string  #ERXDWPS-5137
    description: "Unique ID of the Address record"
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: patient_id {
    label: "Store Patient Id - History"
    type: string
    description: "Unique ID of the Patient record"
    #hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID - History"
    type: number
    description: "Unique ID number identifying an BI source sytem"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: address_home_phone_id {
    label: "Store Patient Address Home Phone ID - History"
    description: "Id from the phone table for the home phone for the associated address"
    type: string  #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_HOME_PHONE_ID ;;
  }

  dimension: address_work_phone_id {
    label: "Store Patient Address Work Phone ID - History"
    description: "Id from the phone table for the work phone for the associated address."
    type: string #ERXDWPS-5137
    hidden: yes
    sql: ${TABLE}.ADDRESS_WORK_PHONE_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
    #hidden: yes
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ################################################### DIMENSIONS ################################

  dimension: address_line1 {
    group_label: "Store Patient Address Info"
    label: "Store Patient Address Line 1 - History"
    description: "First line of the address not including City, State, Country, PO Box, or Zip Code."
    type: string
    sql: ${TABLE}.ADDRESS_LINE_1 ;;
  }

  dimension: address_line2 {
    group_label: "Store Patient Address Info"
    label: "Store Patient Address Line 2 - History"
    description: "Second line of the address not including City, State, Country, PO Box, or Zip Code."
    type: string
    sql: ${TABLE}.ADDRESS_LINE_2 ;;
  }

  dimension: address_city {
    group_label: "Store Patient Address Info"
    label: "Store Patient City - History"
    description: "Patient's City"
    type: string
    sql: ${TABLE}.ADDRESS_CITY ;;
  }

  dimension: address_state {
    group_label: "Store Patient Address Info"
    label: "Store Patient State - History"
    description: "Patient's State"
    type: string
    sql: ${TABLE}.ADDRESS_STATE ;;
  }

  dimension: address_postal_code {
    group_label: "Store Patient Address Info"
    label: "Store Patient Zip Code - History"
    description: "In care of name listed for patient address record"
    type: string
    sql: ${TABLE}.ADDRESS_POSTAL_CODE ;;
  }

  dimension: address_src_postal_code {
    group_label: "Store Patient Address Info"
    label: "Store Patient Zip Code in source system - History"
    hidden: yes
    description: "In care of name listed for patient address record"
    type: string
    sql: ${TABLE}.ADDRESS_SRC_POSTAL_CODE ;;
  }

  dimension: address_country {
    group_label: "Store Patient Address Info"
    label: "Store Patient Country - History"
    description: "Patient's Country Code"
    type: string
    sql: ${TABLE}.ADDRESS_COUNTRY ;;
  }

  dimension: address_po_box {
    label: "Address PO Box - History"
    description: "Yes/No flag indicating if this address is a post office box"
    type: yesno
    sql: ${TABLE}.ADDRESS_PO_BOX_FLAG = 'Y' ;;
  }

  dimension: address_do_not_verify {
    label: "Address Do Not Verify - History"
    description: "Yes/No flag indicating that this address record does not need to be verified by Rx.com"
    type: yesno
    sql: ${TABLE}.ADDRESS_DO_NOT_VERIFY_FLAG = 'Y' ;;
  }

  dimension: address_validated {
    label: "Address Validated - History"
    description: "Yes/No flag indicating that Rx.com has successfully validated an address record"
    type: yesno
    sql: ${TABLE}.ADDRESS_VALIDATED_FLAG = 'Y' ;;
  }

  dimension_group: source_create_timestamp {
    label: "Source Create Timestamp"
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
    hidden: yes
    description: "This is the date and time that the record was created in source table"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ################################################### SETS###################################################
  set: explore_patient_address_hist_4_14_fields {
    fields: [address_line1,
      address_line2,
      address_city,
      address_state,
      address_country,
      address_postal_code,
      address_src_postal_code,
      address_po_box,
      address_do_not_verify,
      address_validated
    ]
  }
}

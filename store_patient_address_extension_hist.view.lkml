view: store_patient_address_extension_hist {
  #[ERXLPS-1024][ERXLPS-2420] - Renamed eps_patient_address_extension_hist view name to store_patient_address_extension_hist.
  derived_table: {
    sql: with eps_rx_tx
         as (select r.chain_id,
                    r.nhin_store_id,
                    r.rx_id,
                    r.rx_patient_id,
                    l.rx_tx_id,
                    l.rx_tx_fill_date,
                    l.source_system_id
               from {% if _explore._name == 'sales' %}
                      {% assign active_archive_filter_input_value = sales.active_archive_filter_input._sql | slice: 1,7 | downcase %}
                      {% if active_archive_filter_input_value == 'archive'  %}
                        edw.f_rx_tx_link_archive l,
                        edw.f_rx_archive r
                      {% else %}
                        edw.f_rx_tx_link l,
                        edw.f_rx r
                      {% endif %}
                    {% else %}
                        edw.f_rx_tx_link l,
                        edw.f_rx r
                    {% endif %}
              where l.chain_id = r.chain_id
                and l.nhin_store_id = r.nhin_store_id
                and l.rx_id = r.rx_id
                and l.source_system_id = r.source_system_id
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
         address_ext_hist
         as (select p.chain_id,
                    p.nhin_store_id,
                    p.patient_id,
                    ae.address_id,
                    ae.source_system_id,
                    ae.patient_address_extension_primary_flag,
                    ae.patient_address_extension_billing_flag,
                    ae.patient_address_extension_shipping_flag,
                    ae.patient_address_extension_type_code,
                    ae.patient_address_extension_deactivate_date,
                    ae.patient_address_extension_start_date,
                    ae.patient_address_extension_end_date,
                    ae.patient_address_extension_clean_flag,
                    ae.patient_address_extension_note_id,
                    ae.patient_address_extension_address_identifier,
                    ae.patient_address_extension_default_delivery_site_code,
                    ae.patient_address_extension_default_address_flag,
                    ae.source_create_timestamp,
                    ae.source_timestamp
              from edw.d_store_patient p,
                   edw.d_patient_address_extension_hist ae,
                   edw.d_patient_address_link pal
             where p.chain_id = pal.chain_id
               and p.nhin_store_id = pal.nhin_store_id
               and p.patient_id = to_char(pal.patient_id)
               and p.source_system_id = pal.source_system_id
               and ae.address_id = pal.address_id
               and ae.chain_id = pal.chain_id
               and ae.nhin_store_id = pal.nhin_store_id
               and ae.source_system_id = pal.source_system_id
               and ae.patient_address_extension_primary_flag = 'Y'
               and {% condition chain.chain_id %} p.chain_id {% endcondition %}
               and {% condition store.nhin_store_id %} p.nhin_store_id {% endcondition %}
               -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
               and p.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                        where source_system_id = 5
                                          and {% condition chain.chain_id %} chain_id {% endcondition %}
                                          and {% condition store.store_number %} store_number {% endcondition %})
               and p.source_system_id = 4
            ),
         fill_time_primary_flag
         as (select *
               from (select a.*,
                            tx.rx_tx_id,
                            tx.rx_tx_fill_date,
                            row_number() over(partition by tx.chain_id, tx.nhin_store_id, tx.rx_tx_id,tx.source_system_id order by a.source_timestamp desc) rnk
                       from eps_rx_tx tx,
                            address_ext_hist a
                      where tx.chain_id = a.chain_id
                        and tx.nhin_store_id = a.nhin_store_id
                        and tx.rx_patient_id = a.patient_id
                        and tx.source_system_id = a.source_system_id
                        and a.source_timestamp <= tx.rx_tx_fill_date
                    ) s
              where s.rnk = 1
           )
          select *
            from (select ae.*,
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
                         a.source_timestamp as source_timestamp_add_hist,
                         row_number() over(partition by ae.chain_id, ae.nhin_store_id, ae.rx_tx_id, ae.source_system_id order by a.source_timestamp desc) rnk_add
                    from fill_time_primary_flag ae,
                         edw.d_address_hist a
                    where ae.chain_id = a.chain_id
                      and ae.nhin_store_id = a.nhin_store_id
                      and ae.address_id = a.address_id
                      and ae.source_system_id = a.source_system_id
                      and a.source_timestamp <= ae.rx_tx_fill_date
                 )
          where rnk_add = 1
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
    label: "Chain Id - History"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id - History"
    type: number
    description: "NHIN account number which uniquely identifies the store with NHIN"
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
    type: string
    description: "Unique ID of the Address record"
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: patient_id {
    label: "Store Patient Id - History"
    type: string
    description: "Unique ID of the Patient record"
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id - History"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Store Patient address extention hist Source Timestamp"
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
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ############################################################## Dimensions ######################################################
  dimension: patient_address_extension_primary {
    label: "Store Patient Primary Address - History"
    description: "Yes/No flag indicating the address is the patient's primary address"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_PRIMARY_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_billing {
    label: "Store Patient Address Extension Billing - History"
    description: "Yes/No flag indicating if the associated address is used for billing purpose"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_BILLING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_shipping {
    label: "Store Patient Address Extension Shipping - History"
    description: "Yes/No flag indicating if the associated address is used for shipping purpose"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_SHIPPING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_type_code {
    label: "Store Patient Address Extension Type Code - History"
    description: "Defines whether or not the address is Not Defined, a home, Second Home, work, vacation home, or temporary."
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'PATIENT_ADDRESS_EXTENSION_TYPE_CODE') ;;
    suggestions: ["UNKNOWN", "HOME", "SECOND HOME", "WORK", "VACATION", "TEMPORARY", "SCHOOL"]
  }

  dimension_group: patient_address_extension_deactivate {
    label: "History - Patient Address Extension Deactivate"
    description: "Date/Time address was discontinued"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEACTIVATE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_start {
    label: "History - Patient Address Extension Start"
    description: "Date/Time address initiated by the patient"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_end {
    label: "History - Patient Address Extension End"
    description: "Date/Time the patient will no longer be living at the address"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: patient_address_extension_clean {
    label: "Store Patient Address Extension Clean - History"
    description: "Yes/No flag indicating if address has been standardized to USPS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_CLEAN_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_note_id {
    label: "Store Patient Address Extension Note ID - History"
    description: "User entered free format note for the address.Foreign key to notes table"
    type: number
    hidden: yes
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_NOTE_ID ;;
  }

  dimension: patient_address_extension_address_identifier {
    label: "Store Patient Address Extension Address Identifier - History"
    description: "Used to uniquely identify a patient's address.IVR request ID used to determine the shipping address of the patient for the order."
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_ADDRESS_IDENTIFIER ;;
  }

  dimension: patient_address_extension_default_delivery_site_code {
    label: "Store Patient Address Extension Default Delivery Site Code - History"
    description: "Used to track the default delivery site/center that services this patient address record.Used to set the new ORDER_ENTRY.DELIVERY_SITE column"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_DELIVERY_SITE_CODE ;;
  }

  dimension: patient_address_extension_default_address {
    label: "Store Patient Address Extension Default Address - History"
    description: "Yes/No flag popualted from EPR ,indicating if the default address is defined or not"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_ADDRESS_FLAG = 'Y' ;;

  }

  dimension: address_line1 {
    label: "Store Patient Address Line 1 - History"
    description: "First line of the address not including City, State, Country, PO Box, or Zip Code."
    type: string
    sql: ${TABLE}.ADDRESS_LINE_1 ;;
  }

  dimension: address_line2 {
    label: "Store Patient Address Line 2 - History"
    description: "Second line of the address not including City, State, Country, PO Box, or Zip Code."
    type: string
    sql: ${TABLE}.ADDRESS_LINE_2 ;;
  }

  dimension: address_city {
    label: "Store Patient City - History"
    description: "Patient's City"
    type: string
    sql: ${TABLE}.ADDRESS_CITY ;;
  }

  dimension: address_state {
    label: "Store Patient State - History"
    description: "Patient's State"
    type: string
    sql: ${TABLE}.ADDRESS_STATE ;;
  }

  dimension: address_postal_code {
    label: "Store Patient Zip Code - History"
    description: "In care of name listed for patient address record"
    type: string
    sql: ${TABLE}.ADDRESS_POSTAL_CODE ;;
  }

  dimension: address_src_postal_code {
    label: "Store Patient Zip Code in source system - History"
    hidden: yes
    description: "In care of name listed for patient address record"
    type: string
    sql: ${TABLE}.ADDRESS_SRC_POSTAL_CODE ;;
  }

  dimension: address_country {
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

  dimension_group: source_timestamp_add_hist {
    label: "Store Patient address extention hist Source Timestamp"
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
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP_ADD_HIST ;;
  }

############################################# Sets #####################################################

  set: explore_patient_address_extension_hist_4_14_candidate_list {
    fields: [
      patient_address_extension_primary,
      patient_address_extension_billing,
      patient_address_extension_shipping,
      patient_address_extension_type_code,
      patient_address_extension_deactivate_time,
      patient_address_extension_deactivate_date,
      patient_address_extension_deactivate_week,
      patient_address_extension_deactivate_month,
      patient_address_extension_deactivate_month_num,
      patient_address_extension_deactivate_year,
      patient_address_extension_deactivate_quarter,
      patient_address_extension_deactivate_quarter_of_year,
      patient_address_extension_deactivate_hour_of_day,
      patient_address_extension_deactivate_time_of_day,
      patient_address_extension_deactivate_hour2,
      patient_address_extension_deactivate_minute15,
      patient_address_extension_deactivate_day_of_week,
      patient_address_extension_deactivate_day_of_month,
      patient_address_extension_start_time,
      patient_address_extension_start_date,
      patient_address_extension_start_week,
      patient_address_extension_start_month,
      patient_address_extension_start_month_num,
      patient_address_extension_start_year,
      patient_address_extension_start_quarter,
      patient_address_extension_start_quarter_of_year,
      patient_address_extension_start_hour_of_day,
      patient_address_extension_start_time_of_day,
      patient_address_extension_start_hour2,
      patient_address_extension_start_minute15,
      patient_address_extension_start_day_of_week,
      patient_address_extension_start_day_of_month,
      patient_address_extension_end_time,
      patient_address_extension_end_date,
      patient_address_extension_end_week,
      patient_address_extension_end_month,
      patient_address_extension_end_month_num,
      patient_address_extension_end_year,
      patient_address_extension_end_quarter,
      patient_address_extension_end_quarter_of_year,
      patient_address_extension_end_hour_of_day,
      patient_address_extension_end_time_of_day,
      patient_address_extension_end_hour2,
      patient_address_extension_end_minute15,
      patient_address_extension_end_day_of_week,
      patient_address_extension_end_day_of_month,
      patient_address_extension_clean,
      patient_address_extension_address_identifier,
      patient_address_extension_default_delivery_site_code,
      patient_address_extension_default_address,
      address_line1,
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

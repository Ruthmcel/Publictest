view: store_patient_address_fill_time {
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
            ),
         patient_address_link_at_fill_time
         as (select *
             from (select pal.chain_id,
                          pal.nhin_store_id,
                          pal.patient_address_link_id,
                          pal.source_system_id,
                          pal.patient_id,
                          pal.address_id,
                          pal.source_create_timestamp as source_create_timestamp_link,
                          pal.source_timestamp source_timestamp_link,
                          tx.rx_tx_id,
                          tx.rx_tx_fill_date,
                          row_number() over(partition by tx.chain_id, tx.nhin_store_id, tx.rx_tx_id, pal.patient_address_link_id, pal.source_system_id order by pal.source_timestamp desc) rnk_link
                     from edw.d_patient_address_link_hist pal,
                          eps_rx_tx tx
                    where pal.chain_id = tx.chain_id
                      and pal.nhin_store_id = tx.nhin_store_id
                      and to_char(pal.patient_id) = tx.rx_patient_id
                      and pal.source_system_id = tx.source_system_id
                      and pal.source_timestamp <= tx.rx_tx_fill_date
             )
             where rnk_link = 1
            ),
         address_ext_hist_at_fill_time
         as (select *
                   from (select pal.*,
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
                                ae.source_create_timestamp source_create_timestamp_ext,
                                ae.source_timestamp source_timestamp_ext,
                                row_number() over(partition by pal.chain_id, pal.nhin_store_id, pal.rx_tx_id, pal.address_id, pal.patient_id, pal.source_system_id order by ae.source_timestamp desc) rnk_ext
                           from patient_address_link_at_fill_time pal
                           left outer join edw.d_patient_address_extension_hist ae
                             on ae.chain_id = pal.chain_id
                            and ae.nhin_store_id = pal.nhin_store_id
                            and ae.address_id = pal.address_id
                            and ae.source_system_id = pal.source_system_id
                            and ae.source_timestamp <= pal.rx_tx_fill_date
                        )
              where rnk_ext = 1
            )
            select *
              from (select pal.chain_id,
                           pal.nhin_store_id,
                           pal.rx_tx_id,
                           pal.source_system_id,
                           pal.address_id,
                           pal.patient_id,
                           pal.source_create_timestamp_link,
                           pal.source_timestamp_link,
                           pal.patient_address_extension_primary_flag,
                           pal.patient_address_extension_billing_flag,
                           pal.patient_address_extension_shipping_flag,
                           pal.patient_address_extension_type_code,
                           pal.patient_address_extension_deactivate_date,
                           pal.patient_address_extension_start_date,
                           pal.patient_address_extension_end_date,
                           pal.patient_address_extension_clean_flag,
                           pal.patient_address_extension_note_id,
                           pal.patient_address_extension_address_identifier,
                           pal.patient_address_extension_default_delivery_site_code,
                           pal.patient_address_extension_default_address_flag,
                           pal.source_create_timestamp_ext,
                           pal.source_timestamp_ext,
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
                           a.source_create_timestamp source_create_timestamp_add,
                           a.source_timestamp as source_timestamp_add,
                           row_number() over(partition by pal.chain_id, pal.nhin_store_id, pal.rx_tx_id, pal.address_id, pal.patient_id, pal.source_system_id order by a.source_timestamp desc) rnk_add
                      from address_ext_hist_at_fill_time pal
                      left outer join edw.d_address_hist a
                        on a.chain_id = pal.chain_id
                       and a.nhin_store_id = pal.nhin_store_id
                       and a.address_id = pal.address_id
                       and a.source_system_id = pal.source_system_id
                       and a.source_timestamp <= pal.rx_tx_fill_date
                   )
            where rnk_add = 1
       ;;
  }


  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${address_id} ||'@'|| ${patient_id} ||'@'|| ${source_system_id} ;;
  }

  ################################################################## Foreign Key references  ##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assigned to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
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

  dimension: source_system_id {
    label: "Source System ID"
    description: "Source System ID. This field is EPS only!!!"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: address_id {
    label: "Address Id"
    type: number
    description: "Unique ID of the Address record"
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: patient_id {
    #label: "Store Patient Id"
    type: string
    description: "Unique ID of the Patient record"
    hidden: yes
    sql: ${TABLE}.PATIENT_ID ;;
  }

  ############################################################## Dimensions ######################################################
  dimension: patient_address_extension_primary {
    label: "Store Patient Address Primary (At time of fill)"
    description: "Yes/No flag indicating the address is the patient's primary address. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_PRIMARY_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_billing {
    label: "Store Patient Address Billing (At time of fill)"
    description: "Yes/No flag indicating if the associated address is used for billing purpose. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_BILLING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_shipping {
    label: "Store Patient Address Shipping (At time of fill)"
    description: "Yes/No flag indicating if the associated address is used for shipping purpose. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_SHIPPING_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_type_code {
    label: "Store Patient Address Type Code (At time of fill)"
    description: "Defines whether or not the address is not defined, home, second home, work, vacation, temporary or school. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: string
    sql: CASE WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '0' THEN 'UNKNOWN'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '1' THEN 'HOME'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '2' THEN 'SECOND HOME'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '3' THEN 'WORK'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '4' THEN 'VACATION'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '5' THEN 'TEMPORARY'
              WHEN ${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE = '6' THEN 'SCHOOL'
              ELSE TO_CHAR(${TABLE}.PATIENT_ADDRESS_EXTENSION_TYPE_CODE)
         END ;;
    suggestions: ["UNKNOWN", "HOME", "SECOND HOME", "WORK", "VACATION", "TEMPORARY", "SCHOOL"]
  }

  dimension_group: patient_address_extension_deactivate {
    label: "Store Patient Address Deactivate (At time of fill)"
    description: "Date/Time address was discontinued. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEACTIVATE_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_start {
    label: "Store Patient Address Start (At time of fill)"
    description: "Date/Time address initiated by the patient. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: patient_address_extension_end {
    label: "Store Patient Address End (At time of fill)"
    description: "Date/Time the patient will no longer be living at the address. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: time
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: patient_address_extension_clean {
    label: "Store Patient Address Clean (At time of fill)"
    description: "Yes/No flag indicating if address has been standardized to USPS. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_CLEAN_FLAG = 'Y' ;;

  }

  dimension: patient_address_extension_note_id {
    label: "Store Patient Address Note ID (At time of fill)"
    description: "User entered free format note for the address.Foreign key to notes table. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: number
    hidden: yes
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_NOTE_ID ;;
  }

  dimension: patient_address_extension_address_identifier {
    label: "Store Patient Address Identifier (At time of fill)"
    description: "Used to uniquely identify a patient's address.IVR request ID used to determine the shipping address of the patient for the order. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_ADDRESS_IDENTIFIER ;;
  }

  dimension: patient_address_extension_default_delivery_site_code {
    label: "Store Patient Address Default Delivery Site Code (At time of fill)"
    description: "Used to track the default delivery site/center that services this patient address record.Used to set the new ORDER_ENTRY.DELIVERY_SITE column. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_DELIVERY_SITE_CODE ;;
  }

  dimension: patient_address_extension_default_address {
    label: "Store Patient Address Default Address (At time of fill)"
    description: "Yes/No flag populated from EPR ,indicating if the default address is defined or not. Fill date is used to determine address at the time of fill. EPS Table: PATIENT_ADDRESS_EXT, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.PATIENT_ADDRESS_EXTENSION_DEFAULT_ADDRESS_FLAG = 'Y' ;;

  }

  dimension: address_line1 {
    label: "Store Patient Address Line 1 (At time of fill)"
    description: "First line of the address not including City, State, Country, PO Box, or Zip Code. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_LINE_1 ;;
  }

  dimension: address_line2 {
    label: "Store Patient Address Line 2 (At time of fill)"
    description: "Second line of the address not including City, State, Country, PO Box, or Zip Code. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_LINE_2 ;;
  }

  dimension: address_city {
    label: "Store Patient Address City (At time of fill)"
    description: "Patient's City. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_CITY ;;
  }

  dimension: address_state {
    label: "Store Patient Address State (At time of fill)"
    description: "Patient's State. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_STATE ;;
  }

  dimension: address_postal_code {
    label: "Store Patient Address Postal Code (At time of fill)"
    description: "Zip or postal code. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_POSTAL_CODE ;;
  }

  dimension: address_src_postal_code {
    label: "Store Patient Address Source Postal Code (At time of fill)"
    hidden: yes
    description: "Zip or postal code. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_SRC_POSTAL_CODE ;;
  }

  dimension: address_country {
    label: "Store Patient Address Country (At time of fill)"
    description: "Patient's Country Code. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: string
    sql: ${TABLE}.ADDRESS_COUNTRY ;;
  }

  dimension: address_po_box {
    label: "Store Patient Address PO Box (At time of fill)"
    description: "Yes/No flag indicating if this address is a post office box. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_PO_BOX_FLAG = 'Y' ;;
  }

  dimension: address_do_not_verify {
    label: "Store Patient Address Do Not Verify (At time of fill)"
    description: "Yes/No flag indicating that this address record does not need to be verified by Rx.com. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_DO_NOT_VERIFY_FLAG = 'Y' ;;
  }

  dimension: address_validated {
    label: "Store Patient Address Validated (At time of fill)"
    description: "Yes/No flag indicating that Rx.com has successfully validated an address record. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: yesno
    sql: ${TABLE}.ADDRESS_VALIDATED_FLAG = 'Y' ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Patient Address Create (At time of fill)"
    description: "Date/Time at which the record was created in the source application. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP_ADD ;;
  }

  dimension_group: source_timestamp {
    label: "Store Patient Address Last Update (At time of fill)"
    description: "Date/Time at which the record was last updated in the source application. Fill date is used to determine address at the time of fill. EPS Table: ADDRESS, PDX Table: PATADDRESS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP_ADD ;;
  }

}

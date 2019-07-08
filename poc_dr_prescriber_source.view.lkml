view: poc_dr_prescriber_source {
  derived_table: {
    sql:
        select nvl(sp.store_prescriber_npi_number,'NA') as prescriber_npi_number,
               nvl(sp.store_prescriber_dea_number,'NA') as prescriber_dea_number,
               UPPER(trim(sp.store_prescriber_first_name)) prescriber_first_name,
               UPPER(trim(sp.store_prescriber_last_name)) prescriber_last_name,
               sa.store_address_state as prescriber_State,
               sa.store_address_city as prescriber_city,
               sa.store_address_time_zone as prescriber_timezone
        from (
              select sp.store_prescriber_npi_number,
                     sp.store_prescriber_dea_number,
                     sp.store_prescriber_first_name,
                     sp.store_prescriber_last_name,
                     c.chain_id, c.nhin_store_id,
                     row_number() over(partition by sp.store_prescriber_npi_number, sp.store_prescriber_dea_number,
                                                    sp.store_prescriber_first_name, sp.store_prescriber_last_name order by c.source_timestamp desc) rnk
              from edw.d_store_prescriber_clinic_link spcl
              inner join edw.d_store_prescriber sp
              on spcl.chain_id = sp.chain_id and spcl.nhin_store_id = sp.nhin_store_id and to_char(spcl.store_prescriber_id) = to_char(sp.store_prescriber_id) and spcl.source_system_id = 4 and sp.source_system_id = 4--4518
              inner join edw.f_rx_tx_link rtl
              on spcl.chain_id = rtl.chain_id and spcl.nhin_store_id = rtl.nhin_store_id and spcl.store_prescriber_clinic_link_id = rtl.rx_tx_presc_clinic_link_id and spcl.source_system_id = 4 and rtl.source_system_id = 4  --532305
              inner join edw.d_clinic c
              on spcl.chain_id = c.chain_id and spcl.nhin_store_id = c.nhin_store_id and to_char(spcl.clinic_id) = to_char(c.clinic_id) and spcl.source_system_id = 4 and c.source_system_id = 4 --4518
              where rtl.rx_tx_fill_date >= dateadd('YEAR', -2,date_trunc('YEAR',current_date()))
              and rtl.rx_tx_fill_date < date_trunc('YEAR',current_date())
              and rtl.rx_tx_fill_status is not null
             ) sp
        left outer join edw.d_store_address sa
        on sp.chain_id = sa.chain_id and sp.nhin_store_id = sa.nhin_store_id and sa.store_address_deleted_flag = 'N'
        where sp.rnk = 1 ;;
  }

  dimension: primary_key {
    type: string
    hidden: yes
    sql: ${prescriber_npi_number}||'@'||${prescriber_dea_number}||'@'||${prescriber_first_name}||'@'||${prescriber_last_name} ;;
  }

  dimension: prescriber_npi_number {
    type: string
    hidden: yes
    label: "Prescriber NPI Number"
    description: "Prescriber NPI Number"
    sql: ${TABLE}.PRESCRIBER_NPI_NUMBER ;;
  }

  dimension: prescriber_dea_number {
    type: string
    hidden: yes
    label: "Prescriber DEA Number"
    description: "Prescriber DEA Number"
    sql: ${TABLE}.PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: prescriber_first_name {
    type: string
    hidden: yes
    label: "Prescriber First Name"
    description: "Prescriber First Name"
    sql: ${TABLE}.PRESCRIBER_FIRST_NAME ;;
  }

  dimension: prescriber_last_name {
    type: string
    hidden: yes
    label: "Prescriber Last Name"
    description: "Prescriber Last Name"
    sql: ${TABLE}.PRESCRIBER_LAST_NAME ;;
  }

  dimension: prescriber_State {
    type: string
    label: "Prescriber State"
    description: "Prescriber State"
    sql: ${TABLE}.PRESCRIBER_STATE;;
  }

  dimension: prescriber_city {
    type: string
    label: "Prescriber City"
    description: "Prescriber City"
    sql: ${TABLE}.PRESCRIBER_CITY ;;
  }

  dimension: prescriber_timezone {
    type: string
    label: "Prescriber TimeZone"
    description: "Prescriber TimeZone"
    sql: ${TABLE}.PRESCRIBER_TIMEZONE;;
  }
}

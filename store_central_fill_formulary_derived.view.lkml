view: store_central_fill_formulary_derived {
# ERXDWPS-6802 - Meijer - Expose additional EPS Central Fill data (Facility / Formulary / Delivery Schedule)
# and source_system_id = 4 --Only EPS data available now. We can remove the joins when PDX Store data available and tested.
# d_store_central_fill_formulary table has more than one record for ndc with same effective and deactivated date. Applied rank and pulled only latest records based on source_timestamp.
  derived_table: {
    sql: select *
           from (select t.chain_id,
                        t.nhin_store_id,
                        t.rx_tx_id,
                        t.source_system_id,
                        f.store_central_fill_formulary_ndc formulary_ndc,
                        f.store_central_fill_formulary_effective_date formulary_effective_date,
                        f.store_central_fill_formulary_deactivate_date formulary_deactivated_date,
                        row_number() over(partition by t.chain_id, t.nhin_store_id, t.rx_tx_id, t.rx_tx_dispensed_drug_ndc, t.source_system_id order by f.store_central_fill_formulary_effective_date desc, f.source_timestamp desc) as rnk
                 from edw.f_rx_tx_link t,
                      edw.d_store_central_fill_formulary f
                 where t.chain_id = f.chain_id
                   and t.nhin_store_id = f.nhin_store_id
                   and t.source_system_id = f.source_system_id
                   and t.rx_tx_dispensed_drug_ndc = f.store_central_fill_formulary_ndc
                   and f.store_central_fill_formulary_effective_date <= t.rx_tx_reportable_sales_date
                   and decode(f.store_central_fill_formulary_deactivate_date,null,to_timestamp('2099-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss'),f.store_central_fill_formulary_deactivate_date) > t.rx_tx_reportable_sales_date
                   and t.rx_tx_fill_location = f.store_central_fill_formulary_type --consider formulary_type based on tx fill_location.
                   and {% condition chain.chain_id %} t.chain_id {% endcondition %}
                   and {% condition store.nhin_store_id %} t.nhin_store_id {% endcondition %}
                   and t.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                            where source_system_id = 5
                                              and {% condition chain.chain_id %} chain_id {% endcondition %}
                                              and {% condition store.store_number %} store_number {% endcondition %})
               )
           where rnk = 1
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${source_system_id} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_tx_id {
    type: string
    hidden: yes
    sql: ${TABLE}.rx_tx_id ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: formulary_ndc {
    label: "Formulary NDC"
    description: "Formaulary NDC"
    type: string
    hidden: yes
    sql: ${TABLE}.formulary_ndc ;;
  }

  dimension_group: formulary_effective {
    label: "Formulary Effective"
    description: "Formulary effective date"
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
    sql: ${TABLE}.formulary_effective_date ;;
  }

  dimension_group: formulary_deactivated {
    label: "Formulary Deactivate"
    description: "Formulary deactivate date"
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
    sql: ${TABLE}.formulary_deactivated_date ;;
  }


  #Derived dimension based on SQL attached in ERXDWPS-6802.
  dimension: ndc_tx_cf_eligible_flag {
    label:"NDC Transaction Central Fill Eligible"
    description:"NDC Transaction Central Fill Eligible"
    type: string
    sql:  case when ${formulary_ndc} is not null
                 and ${eps_line_item.line_item_source_create_time} >= ${formulary_effective_time}
                 and ${eps_line_item.line_item_source_create_time} < decode(${formulary_deactivated_time},null,to_timestamp('2099-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss'),${formulary_deactivated_time})
                then 'Y'
                else 'N'
          end ;;
  }
}

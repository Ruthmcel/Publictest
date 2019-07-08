view: store_drug_mac {
  #sql_table_name: EDW.F_STORE_DRUG_MAC ;;
  derived_table: {
    sql: select *
           from (select calendar_date as snapshot_date,
                        sdm.*,
                        row_number() over(partition by chain_id,nhin_store_id,store_drug_id,d.calendar_date order by sdm.activity_date desc) rnk
                   from edw.d_date d
                        left outer join edw.f_store_drug_mac sdm
                        on ( to_date(sdm.activity_date) <= d.calendar_date )
                  where {% condition chain.chain_id %} sdm.CHAIN_ID {% endcondition %}
                    and {% condition store.nhin_store_id %} sdm.NHIN_STORE_ID {% endcondition %}
                    -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                    and sdm.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                where source_system_id = 5
                                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                  and {% condition store.store_number %} store_number {% endcondition %})
                    and d.calendar_date >= to_date('2017-11-21','YYYY-MM-DD')
                    and d.calendar_date <= to_date('2017-12-05','YYYY-MM-DD')
                    and sdm.activity_type = 'DRUG ONHAND QTY'
                 ) daily_setting
          where  daily_setting.rnk = 1
           ;;
  }

  dimension: drug_id {
    type: string
    hidden: yes
    label: "Drug ID"
    sql: ${TABLE}.STORE_DRUG_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_id}|| ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Drug Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Drug NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### Dimensions ###########################################################################
  dimension: ndc {
    type: string
    hidden: yes
    label: "Drug NDC"
    description: "National Drug Code Identifier"
    sql: ${TABLE}.STORE_DRUG_NDC ;;
  }

  dimension: drug_name {
    type: string
    hidden: yes
    label: "Dispensed Drug Name"
    description: "Shorter Dispensed Drug Name"
    sql: ${TABLE}.STORE_DRUG_NAME ;;
  }

  dimension: activity_type {
    type: string
    hidden: yes
    label: "Activity Type"
    description: "Type of activity for the drug. DRUG ORDER/DRUG ONHAND QTY/DISPENSED/RECAL MAC"
    sql: ${TABLE}.ACTIVITY_TYPE ;;
  }

  dimension: drug_quantity {
    label: "Drug Onhand Quantity"
    description: "Immediate Drug Onhand Quantity after the drug purchase order."
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_DRUG_QUANTITY ;;
    value_format: "#,##0"
  }

  dimension: drug_acq_cost_per_unit {
    type: number
    label: "Drug Acquisition Cost Per Unit"
    description: "Drug Acquisition Cost Per Unit."
    sql: ${TABLE}.ACQ_PER_UNIT ;;
  }

  dimension_group: snapshot{
    type: time
    label: "Snapshot"
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
    description: "Snapshot Date"
    sql: ${TABLE}.SNAPSHOT_DATE ;;
  }


  ##################################################################################### measures ###################################################################
  measure: sum_drug_quantity {
    label: "Drug Onhand Quantity"
    description: "Immediate Drug Onhand Quantity after the drug purchase order."
    type: sum
    sql: ${TABLE}.STORE_DRUG_QUANTITY ;;
    value_format: "#,##0"
  }

  measure: sum_drug_acq_cost_per_unit {
    label: "Total Drug ACQ Per Unit Amount"
    description: "Represents the Aquisition Cost of the Drug Per Unit Amount."
    type: sum
    sql: ${TABLE}.ACQ_PER_UNIT ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_drug_acq_cost {
    label: "Total ACQ Cost Amount"
    description: "Represents the Acquisition Cost of Drug"
    type: sum
    sql: ${TABLE}.ACQ_COST_VALUE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_moving_acq_cost_per_unit {
    label: "Total Drug Moving ACQ Per Unit Amount"
    description: "Represents the moving acquisition cost  per unit of the Drug based on Drug onhand Qty available after the drug order."
    type: sum
    sql: ${TABLE}.MAC_PER_UNIT ;;
    # extended to 7 decimal places (to match with store value) because some generics will be really low cost.
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: sum_drug_moving_acq_cost {
    label: "Total Drug Moving ACQ Cost Amount"
    description: "Represents the moving acquisition cost of the Drug based on Drug onhand Qty available after the drug order."
    type: sum
    sql: ${TABLE}.MAC_COST_VALUE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

}

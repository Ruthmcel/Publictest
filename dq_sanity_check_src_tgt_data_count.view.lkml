view: dq_sanity_check_src_tgt_data_count {
  derived_table: {
    sql: SELECT
      src.source_table,
      src.target_table,
      src.chain_id,
      src.nhin_store_id,
      src.source_system_id,
      src.event_id,
      src.process_data_begin_date,
      src.process_data_end_date,
      COUNT(src.*) AS total_source_records_to_process,
      COUNT(tgt.*) AS total_target_records_processed
      FROM
      (select
          'SHIPMENT' AS source_table,
          'F_SHIPMENT' AS target_table,
          chain_id,
              nhin_store_id,
              id,
              event_id,
              process_data_begin_date,
              process_data_end_date,
              nvl(data_feed_last_update_date, to_timestamp('1900-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS')) source_timestamp,
              4 source_system_id
         from (select q.chain_id,
                      q.nhin_store_id,
                      ejc.event_id,
                      ejc.process_data_begin_date,
                      ejc.process_data_end_date,
                      id,
                      data_feed_last_update_date,
                      row_number() over(partition by q.chain_id,nhin_store_id,id  order by nvl(data_feed_last_update_date, TO_TIMESTAMP('1900-01-01 12:00:00.0')) desc) rnk
                 from eps_stage.shipment_stage q,
                      etl_manager.event_job_chain ejc
                  WHERE ejc.chain_id = q.chain_id
                    and q.process_timestamp >=  ejc.process_data_begin_date
                    and q.process_timestamp < ejc.process_data_end_date
                    and ejc.job_name = 'JOB_EPS_SHIPMENT_EDW'
                    and ejc.event_id = 1946078434
                    and q.dml_operation_type IN ('I','U')
              )
        where rnk = 1
      )src
      LEFT OUTER JOIN
      ( SELECT
        chain_id,
        nhin_store_id,
        shipment_id,
        source_timestamp
       FROM EDW.F_SHIPMENT
      WHERE event_id = 1946078434
      ) tgt
      ON src.chain_id = tgt.chain_id AND src.nhin_store_id = tgt.nhin_store_id AND src.id = tgt.shipment_id
      AND src.source_timestamp >= tgt.source_timestamp
      GROUP BY 1,2,3,4,5,6,7,8
       ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.EVENT_ID ;;
  }

  #####################################################################################################################################################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: process_data_begin {
    label: "Process Data Begin"
    #     description: 'Date record was inserted/updated in source'
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
    sql: ${TABLE}.PROCESS_DATA_BEGIN_DATE ;;
  }

  dimension_group: process_data_end {
    label: "Process Data End"
    #     description: 'Date record was unloaded and processed into BI system'
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
    sql: ${TABLE}.PROCESS_DATA_END_DATE ;;
  }

  dimension: source_table {
    label: "Source Table"
    #     description: 'EDW Table which has missing records'
    type: string
    sql: ${TABLE}.SOURCE_TABLE ;;
  }

  dimension: target_table {
    label: "EDW Target Table"
    #     description: 'EDW Table which has missing records'
    type: string
    sql: ${TABLE}.TARGET_TABLE ;;
  }

  ################################################################################################### Measures ############################################################

  measure: sum_source_records_to_process {
    label: "Source Records to Process"
    type: sum
    sql: ${TABLE}.TOTAL_SOURCE_RECORDS_TO_PROCESS ;;
    value_format: "#,###"
  }

  measure: sum_target_records_processed {
    label: "Target Records Processed"
    type: sum
    sql: ${TABLE}.TOTAL_TARGET_RECORDS_PROCESSED ;;
    value_format: "#,###"
  }

  measure: sum_records_processed {
    label: "% of Records Processed"
    type: sum
    sql: ${TABLE}.TOTAL_TARGET_RECORDS_PROCESSED/NULLIF(TOTAL_SOURCE_RECORDS_TO_PROCESS,0) ;;
    value_format: "00.00%"
  }
}

################################################################################### End of Measures ################################################################################

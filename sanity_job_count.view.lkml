view: sanity_job_count {
  derived_table: {
    sql: SELECT * FROM (
      WITH src AS
      (
       select *
       from
        (select   chain_id,
                  fee_schedule_id,
                  8 source_system_id,
                  fee_schedule_name,
                  drug_descriptor_qualifier,
                  user_added,
                  last_user_upd,
                  case when dml_operation_type = 'D' then 'Y' else 'N' end fee_schedule_deleted,
                  lcr_id,
                  source_timestamp
           from (select q.*,
                  row_number() over (partition by q.chain_id, q.fee_schedule_id order by lcr_id desc) rnk
               from ar_stage.actualrx_fee_schedule_stage q,
                  etl_manager.etl_job_high_water_mark hwm,
                  etl_manager.etl_job_chain_refresh_frequency rf
              where q.chain_id =hwm.chain_id
                and q.process_timestamp >=  hwm.process_data_begin_date
                and q.process_timestamp < hwm.process_data_end_date
                and hwm.chain_id = q.chain_id
                and hwm.job_name = 'JOB_AR_ACTUALRX_FEE_SCHEDULE_EDW'
                and hwm.load_type = 'R'
                and rf.chain_id = hwm.chain_id
                and rf.job_name = hwm.job_name
                and rf.refresh_frequency = 'D'
                and rf.active = 'Y'
                and not exists (select null
                        from edw.d_restore_status rs,
                           edw.d_restore_content rc
                         where rs.restore_id = rc.restore_id
                         and rs.chain_id = q.chain_id
                         and rc.table_name = 'ACTUALRX_FEE_SCHEDULE'
                         and q.source_timestamp >= rs.restore_status_restore_window_start_date
                         and q.source_timestamp <= rs.restore_status_restore_window_end_date
                       )
               )
        where rnk = 1
        )Q
        WHERE NOT EXISTS
          (
            SELECT NULL
             FROM edw.d_actualrx_fee_schedule t
            WHERE q.chain_id=t.chain_id
              AND q.fee_schedule_id=t.actualrx_fee_schedule_id
              AND q.source_timestamp<t.source_timestamp
              AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
             -- AND  {% condition event_id_filter %} event_id {% endcondition %}
          )
      ),
      tgt AS(select   chain_id,
                      actualrx_fee_schedule_id,
                      source_system_id,
                      actualrx_fee_schedule_name,
                      actualrx_fee_schedule_drug_descriptor_qualifier_id,
                      actualrx_fee_schedule_added_user_identifer,
                      actualrx_fee_schedule_last_update_user_identifier,
                      actualrx_fee_schedule_deleted,
                      actualrx_fee_schedule_lcr_id,
                      source_timestamp
          from edw.d_actualrx_fee_schedule
          where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
          ),
           src_minus_tgt AS(SELECT count(*) cnt_src
                  FROM (SELECT * FROM src
                          MINUS
                          SELECT * FROM tgt
                       ) diff
                  ),
         tgt_minus_src AS(SELECT count(*) cnt_tgt
                  FROM (SELECT * FROM tgt
                         MINUS
                        SELECT * FROM src
                       )
                 ),
          event_table as (
                            select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                          ),
          src_table_count as (
                               select count(*) as src_cnt from src
                             ),
           target_table_count as(
                                 select count(*) as tgt_cnt from tgt
                                )
      SELECT d1.cnt_src as source_minus_target,
           d2.cnt_tgt as  target_minus_source,
           upper('d_actualrx_fee_schedule') table_name,
           e.event_id,
           stc.src_cnt,
           ttc.tgt_cnt,
           case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                   when ttc.tgt_cnt=0 then 0
                   when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
        FROM src_minus_tgt d1,
           tgt_minus_src d2,
           event_table e,
           src_table_count stc,
           target_table_count ttc
        )
        UNION ALL
            SELECT * FROM (
        WITH src AS
        (
         select *
         from
          (select chain_id,
        contract_rate_id,
        contract_rate_carrier_id,
        8 source_system_id,
        case when dml_operation_type = 'D' then 'Y' else 'N' end contract_rate_carrier_link_deleted,
        lcr_id,
        source_timestamp
             from (select q.*,
                    row_number() over (partition by q.chain_id, q.contract_rate_id, q.contract_rate_carrier_id order by lcr_id desc) rnk
                 from ar_stage.contract_rate_carrier_xref_stage q,
                    etl_manager.etl_job_high_water_mark hwm,
                    etl_manager.etl_job_chain_refresh_frequency rf
                where q.chain_id =hwm.chain_id
                  and q.process_timestamp >=  hwm.process_data_begin_date
                  and q.process_timestamp < hwm.process_data_end_date
                  and hwm.chain_id = q.chain_id
                  and hwm.job_name = 'JOB_AR_CONTRACT_RATE_CARRIER_LINK_EDW'
                  and hwm.load_type = 'R'
                  and rf.chain_id = hwm.chain_id
                  and rf.job_name = hwm.job_name
                  and rf.refresh_frequency = 'D'
                  and rf.active = 'Y'
                  and not exists (select null
                from edw.d_restore_status rs,
                   edw.d_restore_content rc
                 where rs.restore_id = rc.restore_id
                 and rs.chain_id = q.chain_id
                 and rc.table_name = 'CONTRACT_RATE_CARRIER_XREF'
                 and q.source_timestamp >= rs.restore_status_restore_window_start_date
                 and q.source_timestamp <= rs.restore_status_restore_window_end_date
               )
               )
          where rnk = 1
          )Q
          WHERE NOT EXISTS
            (
              SELECT NULL
       FROM edw.d_contract_rate_carrier_link t
      WHERE q.chain_id=t.chain_id
        AND q.contract_rate_id=t.contract_rate_id
        AND q.contract_rate_carrier_id=t.contract_rate_carrier_id
        AND q.source_timestamp<t.source_timestamp
                  AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               -- AND  {% condition event_id_filter %} event_id {% endcondition %}
            )
        ),
        tgt AS(SELECT   chain_id,
          contract_rate_id,
          contract_rate_carrier_id,
          source_system_id,
          contract_rate_carrier_link_deleted,
          contract_rate_carrier_link_lcr_id,
          source_timestamp
      FROM edw.d_contract_rate_carrier_link
               where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
            ),
             src_minus_tgt AS(SELECT count(*) cnt_src
                    FROM (SELECT * FROM src
                            MINUS
                            SELECT * FROM tgt
                         ) diff
                    ),
           tgt_minus_src AS(SELECT count(*) cnt_tgt
                    FROM (SELECT * FROM tgt
                           MINUS
                          SELECT * FROM src
                         )
                   ),
            event_table as (
                              select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                            ),
            src_table_count as (
                                 select count(*) as src_cnt from src
                               ),
             target_table_count as(
                                   select count(*) as tgt_cnt from tgt
                                  )
        SELECT d1.cnt_src as source_minus_target,
             d2.cnt_tgt as  target_minus_source,
             upper('d_contract_rate_carrier_link') table_name,
             e.event_id,
             stc.src_cnt,
             ttc.tgt_cnt,
              case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                   when ttc.tgt_cnt=0 then 0
              else (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
          FROM src_minus_tgt d1,
             tgt_minus_src d2,
             event_table e,
             src_table_count stc,
             target_table_count ttc
          )
      UNION ALL
              SELECT * FROM (
        WITH src AS
        (
         select *
         from
          (select   chain_id,
        contract_rate_id,
        cost_base,
        mac_list_id,
        '8' source_system_id,
        pricing_type,
        percentage_adjustment,
        add_perc_adjustment,
        dispensing_fee,
        user_added,
        last_usr_upd,
        case when dml_operation_type='D' then 'Y' else 'N' end dml_operation_type,
        lcr_id,
        source_timestamp
             from (select q.*,
                    row_number() over (partition by q.chain_id,contract_rate_id,cost_base,mac_list_id order by lcr_id desc) rnk
                 from ar_stage.contract_rate_pricing_stage q,
                    etl_manager.etl_job_high_water_mark hwm,
                    etl_manager.etl_job_chain_refresh_frequency rf
                where q.chain_id =hwm.chain_id
                  and q.process_timestamp >=  hwm.process_data_begin_date
                  and q.process_timestamp < hwm.process_data_end_date
                  and hwm.chain_id = q.chain_id
                  and hwm.job_name = 'JOB_AR_CONTRACT_RATE_PRICING_EDW'
                  and hwm.load_type = 'R'
                  and rf.chain_id = hwm.chain_id
                  and rf.job_name = hwm.job_name
                  and rf.refresh_frequency = 'D'
                  and rf.active = 'Y'
                  and not exists (select null
                from edw.d_restore_status rs,
                   edw.d_restore_content rc
                 where rs.restore_id = rc.restore_id
                 and rs.chain_id = q.chain_id
                 and rc.table_name = 'CONTRACT_RATE_PRICING'
                 and q.source_timestamp >= rs.restore_status_restore_window_start_date
                 and q.source_timestamp <= rs.restore_status_restore_window_end_date
               )
           )
          where rnk = 1
          )Q
          WHERE NOT EXISTS
            (
              SELECT NULL
               FROM edw.d_contract_rate_pricing t
                WHERE q.chain_id=t.chain_id
                  AND q.contract_rate_id=t.contract_rate_id
                  AND q.cost_base=t.contract_rate_pricing_cost_base_type_id
                  AND q.mac_list_id=t.contract_rate_pricing_mac_list_id
                  AND q.source_timestamp<t.source_timestamp
                            AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                         -- AND  {% condition event_id_filter %} event_id {% endcondition %}
                      )
        ),
        tgt AS(select   chain_id,
          contract_rate_id,
          contract_rate_pricing_cost_base_type_id,
          contract_rate_pricing_mac_list_id,
          source_system_id,
          contract_rate_pricing_type_id,
          contract_rate_pricing_percentage_adjustment,
          contract_rate_pricing_percentage_adjustment_type_id,
          contract_rate_pricing_dispensing_fee,
          contract_rate_pricing_added_user_identifer,
          contract_rate_pricing_last_update_user_identifier,
          contract_rate_pricing_deleted,
          contract_rate_pricing_lcr_id,
          source_timestamp
      from edw.d_contract_rate_pricing
               where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               ),
             src_minus_tgt AS(SELECT count(*) cnt_src
                    FROM (SELECT * FROM src
                            MINUS
                            SELECT * FROM tgt
                         ) diff
                    ),
           tgt_minus_src AS(SELECT count(*) cnt_tgt
                    FROM (SELECT * FROM tgt
                           MINUS
                          SELECT * FROM src
                         )
                   ),
            event_table as (
                              select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                            ),
            src_table_count as (
                                 select count(*) as src_cnt from src
                               ),
             target_table_count as(
                                   select count(*) as tgt_cnt from tgt
                                  )
        SELECT d1.cnt_src as source_minus_target,
             d2.cnt_tgt as  target_minus_source,
             upper('d_contract_rate_pricing') table_name,
             e.event_id,
             stc.src_cnt,
             ttc.tgt_cnt,
             case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                   when ttc.tgt_cnt=0 then 0
                   when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
              --else (stc.src_cnt/ttc.tgt_cnt)*100 end as sanity_load_percentage
          FROM src_minus_tgt d1,
             tgt_minus_src d2,
             event_table e,
             src_table_count stc,
             target_table_count ttc
          )
        UNION ALL
        SELECT * FROM (
        WITH src AS
        (
         select *
         from
          (select   '3000' chain_id,
          upper(abbr) abbr,
        upper(type_desc) type_desc,
        lcr_id,
        source_timestamp,
        source_system_id
             from (select q.*,'8' source_system_id,
                    row_number() over (partition by upper(q.abbr) order by lcr_id desc) rnk
                 from ar_stage.nhin_type_stage q,
                      etl_manager.event_job_chain ejc
                where q.process_timestamp >=  ejc.process_data_begin_date
                  and q.process_timestamp < ejc.process_data_end_date
                  and ejc.event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                  and q.dml_operation_type in ('I','U')
        and ejc.job_name='JOB_AR_DRUG_COST_TYPE_EDW'

        )
          where rnk = 1
          )Q
          WHERE NOT EXISTS
            (
              SELECT NULL
       FROM edw.d_drug_cost_type t
      WHERE q.chain_id=t.chain_id
        AND q.abbr=t.drug_cost_type
        AND q.source_system_id=t.source_system_id
        AND q.source_timestamp<t.source_timestamp
                  AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               -- AND  {% condition event_id_filter %} event_id {% endcondition %}
            )
        ),
        tgt AS(SELECT   chain_id,
          drug_cost_type,
          drug_cost_type_description,
          drug_cost_type_lcr_id,
          source_timestamp,
          source_system_id
       FROM edw.d_drug_cost_type
                where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               ),
             src_minus_tgt AS(SELECT count(*) cnt_src
                    FROM (SELECT * FROM src
                            MINUS
                            SELECT * FROM tgt
                         ) diff
                    ),
           tgt_minus_src AS(SELECT count(*) cnt_tgt
                    FROM (SELECT * FROM tgt
                           MINUS
                          SELECT * FROM src
                         )
                   ),
            event_table as (
                              select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                            ),
            src_table_count as (
                                 select count(*) as src_cnt from src
                               ),
             target_table_count as(
                                   select count(*) as tgt_cnt from tgt
                                  )
        SELECT d1.cnt_src as source_minus_target,
             d2.cnt_tgt as  target_minus_source,
             upper('d_drug_cost_type') table_name,
             e.event_id,
             stc.src_cnt,
             ttc.tgt_cnt,
           case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                   when ttc.tgt_cnt=0 then 0
                   when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
          FROM src_minus_tgt d1,
             tgt_minus_src d2,
             event_table e,
             src_table_count stc,
             target_table_count ttc
          )
        UNION ALL
        SELECT * FROM (
        WITH src AS
        (
         select *
         from
          (select   cust_id,
        restore_id,
        source_system_id,
        restore_window_start_date,
        restore_window_end_date,
        restore_type,
        explore_rx_completion_date,
        user_added,
        last_usr_upd,
        lcr_id,
        source_timestamp
             from (select q.*,'8' source_system_id,
                    row_number() over (partition by q.cust_id,q.restore_id ORDER BY q.lcr_id desc) rnk
                 from ar_stage.restore_status_stage q,
                      etl_manager.event_job_chain ejc
                where q.process_timestamp >=  ejc.process_data_begin_date
                  and q.process_timestamp < ejc.process_data_end_date
                 and ejc.event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                  and q.dml_operation_type in ('I','U')
        and ejc.job_name='JOB_AR_RESTORE_STATUS_EDW'

        )
          where rnk = 1
          )Q
          WHERE NOT EXISTS
            (
              SELECT NULL
       FROM edw.d_restore_status t
      WHERE q.cust_id=t.chain_id
        AND q.restore_id=t.restore_id
        AND q.source_timestamp<t.source_timestamp
                  AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               -- AND  {% condition event_id_filter %} event_id {% endcondition %}
            )
        ),
        tgt AS(SELECT   chain_id,
          restore_id,
          source_system_id,
          restore_status_restore_window_start_date,
          restore_status_restore_window_end_date,
          restore_status_restore_type,
          restore_status_explore_rx_completion_date,
          restore_status_added_user_identifer,
          restore_status_last_update_user_identifier,
          restore_status_lcr_id,
          source_timestamp
       FROM edw.d_restore_status
                where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               ),
             src_minus_tgt AS(SELECT count(*) cnt_src
                    FROM (SELECT * FROM src
                            MINUS
                            SELECT * FROM tgt
                         ) diff
                    ),
           tgt_minus_src AS(SELECT count(*) cnt_tgt
                    FROM (SELECT * FROM tgt
                           MINUS
                          SELECT * FROM src
                         )
                   ),
            event_table as (
                              select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                            ),
            src_table_count as (
                                 select count(*) as src_cnt from src
                               ),
             target_table_count as(
                                   select count(*) as tgt_cnt from tgt
                                  )
        SELECT d1.cnt_src as source_minus_target,
             d2.cnt_tgt as  target_minus_source,
             upper('d_restore_status') table_name,
             e.event_id,
             stc.src_cnt,
             ttc.tgt_cnt,
             case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
       when ttc.tgt_cnt=0 then 0
       when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
          FROM src_minus_tgt d1,
             tgt_minus_src d2,
             event_table e,
             src_table_count stc,
             target_table_count ttc
          )
         UNION ALL
          SELECT * FROM (
            WITH src AS
            (
             select *
             from
              (select  chain_id,
                transaction_id,
                seq_num,
                source_system_id,
                note,
                note_category,
                user_added,
                last_user_upd,
                progress_status,
                dml_operation_type,
                lcr_id,
                source_timestamp
                 from (select q.*,'8' source_system_id,
                        row_number() over (partition by q.chain_id,q.transaction_id,q.seq_num ORDER BY q.lcr_id desc) rnk
                     from ar_stage.transaction_notes_stage q,
                        etl_manager.etl_job_high_water_mark hwm,
                        etl_manager.etl_job_chain_refresh_frequency rf
                    where q.chain_id =hwm.chain_id
                      and q.process_timestamp >=  hwm.process_data_begin_date
                      and q.process_timestamp < hwm.process_data_end_date
                      and hwm.chain_id = q.chain_id
                      and hwm.job_name = 'JOB_AR_TRANSACTION_NOTE_EDW'
                      and hwm.load_type = 'R'
                      and rf.chain_id = hwm.chain_id
                      and rf.job_name = hwm.job_name
                      and rf.refresh_frequency = 'D'
                      and rf.active = 'Y'
                      and not exists (select null
                          from edw.d_restore_status rs,
                           edw.d_restore_content rc
                           where rs.restore_id = rc.restore_id
                           and rs.chain_id = q.chain_id
                           and rc.table_name = 'CONTRACT_RATE_PRICING'
                           and q.source_timestamp >= rs.restore_status_restore_window_start_date
                           and q.source_timestamp <= rs.restore_status_restore_window_end_date
                   )
               )
              where rnk = 1
              )Q
              WHERE NOT EXISTS
                (
                    SELECT NULL
                     FROM edw.f_transaction_note t
                    WHERE q.chain_id=t.chain_id
                      AND q.transaction_id=t.transaction_id
                      AND q.seq_num=t.transaction_note_sequence_number
                      AND q.source_timestamp<t.source_timestamp
                                AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                             -- AND  1=1 -- no filter on 'sanity_job_count.event_id_filter'

                          )
            ),
            tgt AS(select  chain_id,
                  transaction_id,
                  transaction_note_sequence_number,
                  source_system_id,
                  transaction_note,
                  transaction_note_category_type_id,
                  transaction_note_added_user_identifer,
                  transaction_note_last_update_user_identifier,
                  transaction_note_progress_status_type_id,
                  transaction_note_deleted,
                  transaction_note_lcr_id,
                  source_timestamp
               from edw.f_transaction_note
                   where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                   ),
                 src_minus_tgt AS(SELECT count(*) cnt_src
                        FROM (SELECT * FROM src
                                MINUS
                                SELECT * FROM tgt
                             ) diff
                        ),
               tgt_minus_src AS(SELECT count(*) cnt_tgt
                        FROM (SELECT * FROM tgt
                               MINUS
                              SELECT * FROM src
                             )
                       ),
                event_table as (
                                  select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                                ),
                src_table_count as (
                                     select count(*) as src_cnt from src
                                   ),
                 target_table_count as(
                                       select count(*) as tgt_cnt from tgt
                                      )
            SELECT d1.cnt_src as source_minus_target,
                 d2.cnt_tgt as  target_minus_source,
                 upper('f_transaction_note') table_name,
                 e.event_id,
                 stc.src_cnt,
                 ttc.tgt_cnt,
                 case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                       when ttc.tgt_cnt=0 then 0
                       when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
                  --else (stc.src_cnt/ttc.tgt_cnt)*100 end as sanity_load_percentage
              FROM src_minus_tgt d1,
                 tgt_minus_src d2,
                 event_table e,
                 src_table_count stc,
                 target_table_count ttc
              )
           UNION ALL
            SELECT * FROM (
              WITH src AS
              (
               select *
               from
                (select  chain_id,
                    tp_contract_id,
                    8 source_system_id,
                    contract_name,
                    company_name,
                    carrier_code,
                    plan_code,
                    group_code,
                    addr_line1,
                    addr_line2,
                    city,
                    state,
                    substr(zip_code,1,5) zip_code,
                    zip_code src_zip_code,
                    phone_num,
                    fax_num,
                    website_addr,
                    date_signed,
                    signed_by_whom,
                    termination_material_breach,
                    termination_without_cause,
                    termination_written_obj,
                    termination_fail_to_pay,
                    termination_license_revoke,
                    termination_fraud,
                    termination_neglect,
                    termination_bankruptcy,
                    termination_refuse_service,
                    termination_dea,
                    termination_member_harm,
                    termination_criminal,
                    termination_endangerment,
                    amendment_modify,
                    amendment_amend_agreement,
                    contract_status,
                    deactivate_date,
                    contract_start_date,
                    contract_end_date,
                    user_added,
                    last_user_upd,
                    case when dml_operation_type = 'D' then 'Y' else 'N' end third_party_contract_deleted,
                    lcr_id,
                    source_timestamp
                   from (select q.*,'8' source_system_id,
                          row_number() over (partition by q.chain_id, q.tp_contract_id order by lcr_id desc) rnk
                       from ar_stage.third_party_contract_stage q,
                          etl_manager.etl_job_high_water_mark hwm,
                          etl_manager.etl_job_chain_refresh_frequency rf
                      where q.chain_id =hwm.chain_id
                        and q.process_timestamp >=  hwm.process_data_begin_date
                        and q.process_timestamp < hwm.process_data_end_date
                        and hwm.chain_id = q.chain_id
                        and hwm.job_name = 'JOB_AR_THIRD_PARTY_CONTRACT_EDW'
                        and hwm.load_type = 'R'
                        and rf.chain_id = hwm.chain_id
                        and rf.job_name = hwm.job_name
                        and rf.refresh_frequency = 'D'
                        and rf.active = 'Y'
                        and not exists (select null
                            from edw.d_restore_status rs,
                             edw.d_restore_content rc
                             where rs.restore_id = rc.restore_id
                             and rs.chain_id = q.chain_id
                             and rc.table_name = 'THIRD_PARTY_CONTRACT'
                             and q.source_timestamp >= rs.restore_status_restore_window_start_date
                             and q.source_timestamp <= rs.restore_status_restore_window_end_date
                     )
                 )
                where rnk = 1
                )Q
                WHERE NOT EXISTS
                  (
                      SELECT NULL
                       FROM edw.d_third_party_contract t
                      WHERE q.chain_id=t.chain_id
                        AND q.tp_contract_id=t.third_party_contract_id
                        AND q.source_timestamp<t.source_timestamp
                        AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                        -- AND  1=1 -- no filter on 'sanity_job_count.event_id_filter'

                            )
              ),
            tgt AS(select   chain_id,
                    third_party_contract_id,
                    source_system_id,
                    third_party_contract_name,
                    third_party_contract_company_name,
                    third_party_contract_carrier_code,
                    third_party_contract_plan_code,
                    third_party_contract_group_code,
                    third_party_contract_address_line1,
                    third_party_contract_address_line2,
                    third_party_contract_city,
                    third_party_contract_state,
                    third_party_contract_zip_code,
                    third_party_contract_src_zip_code,
                    third_party_contract_phone_number,
                    third_party_contract_fax_number,
                    third_party_contract_website_address,
                    third_party_contract_date_signed,
                    third_party_contract_signed_by_whom,
                    third_party_contract_termination_material_breach_type_id,
                    third_party_contract_termination_without_cause_type_id,
                    third_party_contract_termination_written_objection_type_id,
                    third_party_contract_termination_fail_to_pay_type_id,
                    third_party_contract_termination_license_revoke_type_id,
                    third_party_contract_termination_fraud_type_id,
                    third_party_contract_termination_neglect_type_id,
                    third_party_contract_termination_bankruptcy_type_id,
                    third_party_contract_termination_refuse_service_type_id,
                    third_party_contract_termination_dea_type_id,
                    third_party_contract_termination_member_harm_type_id,
                    third_party_contract_termination_criminal_type_id,
                    third_party_contract_termination_endangerment_type_id,
                    third_party_contract_amendment_modify_type_id,
                    third_party_contract_amendment_amend_agreement_type_id,
                    third_party_contract_contract_status_type_id,
                    third_party_contract_deactivate_date,
                    third_party_contract_start_date,
                    third_party_contract_end_date,
                    third_party_contract_added_user_identifer,
                    third_party_contract_last_update_user_identifier,
                    third_party_contract_deleted,
                    third_party_contract_lcr_id,
                    source_timestamp
                  from  edw.d_third_party_contract
                     where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                     ),
                   src_minus_tgt AS(SELECT count(*) cnt_src
                          FROM (SELECT * FROM src
                                  MINUS
                                  SELECT * FROM tgt
                               ) diff
                          ),
                 tgt_minus_src AS(SELECT count(*) cnt_tgt
                          FROM (SELECT * FROM tgt
                                 MINUS
                                SELECT * FROM src
                               )
                         ),
                  event_table as (
                                    select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                                  ),
                  src_table_count as (
                                       select count(*) as src_cnt from src
                                     ),
                   target_table_count as(
                                         select count(*) as tgt_cnt from tgt
                                        )
              SELECT d1.cnt_src as source_minus_target,
                   d2.cnt_tgt as  target_minus_source,
                   upper('d_third_party_contract') table_name,
                   e.event_id,
                   stc.src_cnt,
                   ttc.tgt_cnt,
                   case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                         when ttc.tgt_cnt=0 then 0
                         when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
                    --else (stc.src_cnt/ttc.tgt_cnt)*100 end as sanity_load_percentage
                FROM src_minus_tgt d1,
                   tgt_minus_src d2,
                   event_table e,
                   src_table_count stc,
                   target_table_count ttc
                )
           UNION ALL
           SELECT * FROM (
                  WITH src AS
                  (
                   select *
                   from
                    (select  nhin_type,
                   source_system_id,
                   nhin_category,
                   upper(type_desc) type_desc,
                   upper(abbr) abbr,
                   notes,
                   last_user_upd,
                   case when dml_operation_type = 'D' then 'Y' else 'N' end dml_operation_type,
                   lcr_id,
                   source_timestamp
                       from (select q.*,'8' source_system_id,
                              row_number() over (partition by q.nhin_type ORDER BY q.lcr_id desc) rnk
                           from ar_stage.nhin_type_stage q,
                                etl_manager.event_job_chain ejc
                          where q.process_timestamp >=  ejc.process_data_begin_date
                            and q.process_timestamp < ejc.process_data_end_date
                  and ejc.job_name='JOB_AR_NHIN_TYPE_EDW'
                            and ejc.event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')

                  )
                    where rnk = 1
                    )Q
                    WHERE NOT EXISTS
                      (
                        SELECT NULL
                 FROM edw.d_nhin_type t
                WHERE q.nhin_type=t.nhin_type_id
                  AND q.source_timestamp<t.source_timestamp
                            AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                         -- AND  {% condition event_id_filter %} event_id {% endcondition %}
                      )
                  ),
                  tgt AS(SELECT   nhin_type_id,
                    source_system_id,
                    nhin_category_id,
                    nhin_type_description,
                    nhin_type_abbreviation,
                    nhin_type_notes,
                    nhin_type_last_update_user_identifier,
                    nhin_type_deleted,
                    nhin_type_lcr_id,
                    source_timestamp
                 FROM edw.d_nhin_type
                          where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                         ),
                       src_minus_tgt AS(SELECT count(*) cnt_src
                              FROM (SELECT * FROM src
                                      MINUS
                                      SELECT * FROM tgt
                                   ) diff
                              ),
                     tgt_minus_src AS(SELECT count(*) cnt_tgt
                              FROM (SELECT * FROM tgt
                                     MINUS
                                    SELECT * FROM src
                                   )
                             ),
                      event_table as (
                                        select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                                      ),
                      src_table_count as (
                                           select count(*) as src_cnt from src
                                         ),
                       target_table_count as(
                                             select count(*) as tgt_cnt from tgt
                                            )
                  SELECT d1.cnt_src as source_minus_target,
                       d2.cnt_tgt as  target_minus_source,
                       upper('d_nhin_type') table_name,
                       e.event_id,
                       stc.src_cnt,
                       ttc.tgt_cnt,
                       case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                 when ttc.tgt_cnt=0 then 0
                 when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
                    FROM src_minus_tgt d1,
                       tgt_minus_src d2,
                       event_table e,
                       src_table_count stc,
                       target_table_count ttc
                    )
             UNION ALL
             SELECT * FROM (
                        WITH src AS
                        (
                         select *
                         from
                          (select   cust_id,
                        nhin_id,
                        store_id,
                        store_name,
                        nhin_type_description,
                        store_npi,
                        nabp_num,
                        nhin_id nhin_store_id,
                        lcr_id,
                        source_timestamp,
                        store_type,
                        version_opt,
                        product_opt,
                        elig_opt,
                        store_region,
                        store_dist,
                        store_div,
                        store_dea,
                        state_lic_num,
                        city_lic_num,
                        comm_region,
                        store_tax_id,
                        skip_mdy_flag,
                        hst_version,
                        closed_day,
                        dm_recv_opt,
                        open_date,
                        close_date,
                        ar_activity_flag,
                        erx_flag,
                        last_user_upd,
                        use_rx_store_xref,
                        exclude_checks_from_era,
                        store_dea_exp,
                        state_lic_exp,
                        contr_sub_lic_num,
                        contr_sub_lic_exp,
                        med_ptan_flu,
                        med_ptan_railroad,
                        med_ptan_dmepos,
                        '8' source_system_id
                             from (select   q.cust_id,
                            q.nhin_id,
                            q.store_id,
                            q.store_name,
                            q.product_opt,
                            substr(trim(nt.nhin_type_description),1,8) nhin_type_description,
                            q.store_npi,
                            q.nabp_num,
                            q.lcr_id,
                            q.date_added last_upd,
                            q.source_timestamp,
                            q.store_type,
                            q.version_opt,
                            q.elig_opt,
                            q.store_region,
                            q.store_dist,
                            q.store_div,
                            q.store_dea,
                            q.state_lic_num,
                            q.city_lic_num,
                            q.comm_region,
                            q.store_tax_id,
                            NVL(q.skip_mdy_flag,'N') skip_mdy_flag,
                            q.hst_version,
                            q.closed_day,
                            q.dm_recv_opt,
                            q.open_date,
                            q.close_date,
                            q.ar_activity_flag,
                            q.erx_flag,
                            q.last_user_upd,
                            NVL(q.use_rx_store_xref,'N') use_rx_store_xref,
                            NVL(q.exclude_checks_from_era,'N') exclude_checks_from_era,
                            q.store_dea_exp,
                            q.state_lic_exp,
                            q.contr_sub_lic_num,
                            q.contr_sub_lic_exp,
                            q.med_ptan_flu,
                            q.med_ptan_railroad,
                            q.med_ptan_dmepos,
                            ROW_NUMBER() OVER(PARTITION BY q.cust_id,q.nhin_id ORDER BY q.lcr_id desc) rnk
                                 from ar_stage.store_stage q,
                                      etl_manager.event_job_chain ejc,
                          edw.d_nhin_type nt
                                where q.process_timestamp >=  ejc.process_data_begin_date
                                  and q.process_timestamp < ejc.process_data_end_date
                        and ejc.job_name='JOB_AR_STORE_EDW'
                        and ejc.event_id=(select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                        and q.product_opt=nt.nhin_type_id (+)
                          and nt.source_system_id (+) =8
                        )
                          where rnk = 1
                          )Q
                          WHERE NOT EXISTS
                            (
                              SELECT NULL
                       FROM edw.d_store t
                      WHERE q.cust_id=t.chain_id
                        AND q.nhin_id=t.nhin_store_id
                        AND q.source_system_id=t.source_system_id
                        AND q.source_timestamp<t.source_timestamp
                                  AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                               -- AND  {% condition event_id_filter %} event_id {% endcondition %}
                            )
                        ),
                        tgt AS(SELECT   chain_id,
                          nhin_store_id,
                          store_number,
                          store_name,
                          store_client_type,
                          store_npi_number,
                          store_ncpdp_number,
                          store_id,
                          store_lcr_id,
                          source_timestamp,
                          store_type_id,
                          store_ar_version_type_id,
                          store_product_type_id,
                          store_eligibility_type_id,
                          store_region,
                          store_district,
                          store_division,
                          store_dea_number,
                          store_state_license_number,
                          store_city_license_number,
                          store_comm_region,
                          store_tax_id,
                          store_skip_missing_day_flag,
                          store_host_version_type_id,
                          store_closed_day_type_id,
                          store_dm_recv_type_id,
                          store_open_date,
                          store_close_date,
                          store_ar_activity_flag,
                          store_erx_flag,
                          store_last_update_user_identifier,
                          store_use_rx_store_xref_flag,
                          store_exclude_checks_from_era_flag,
                          store_dea_expiration_date,
                          store_state_license_expiration_date,
                          store_controlled_substance_license_number,
                          store_controlled_substance_license_expiration_date,
                          store_medicare_ptan_number_flu,
                          store_medicare_ptan_number_railroad_workers,
                          store_medicare_ptan_number_dmepos,
                          source_system_id
                       FROM edw.d_store
                                where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                      and source_system_id=8
                               ),
                             src_minus_tgt AS(SELECT count(*) cnt_src
                                    FROM (SELECT * FROM src
                                            MINUS
                                            SELECT * FROM tgt
                                         ) diff
                                    ),
                           tgt_minus_src AS(SELECT count(*) cnt_tgt
                                    FROM (SELECT * FROM tgt
                                           MINUS
                                          SELECT * FROM src
                                         )
                                   ),
                            event_table as (
                                              select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                                            ),
                            src_table_count as (
                                                 select count(*) as src_cnt from src
                                               ),
                             target_table_count as(
                                                   select count(*) as tgt_cnt from tgt
                                                  )
                        SELECT d1.cnt_src as source_minus_target,
                             d2.cnt_tgt as  target_minus_source,
                             upper('d_store') table_name,
                             e.event_id,
                             stc.src_cnt,
                             ttc.tgt_cnt,
                             case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                       when ttc.tgt_cnt=0 then 0
                       when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
                          FROM src_minus_tgt d1,
                             tgt_minus_src d2,
                             event_table e,
                             src_table_count stc,
                             target_table_count ttc
                          )
                UNION ALL
                         SELECT * FROM (
      WITH src AS
      (
       select *
       from
      (select chain_id,
          nhin_store_id,
          id,
          source_system_id,
          carrier_code,
          plan,
          group_code,
          plan_name,
          eligible,
          tp_error_override,
          price_override,
          format_card,
          check_card,
          format_group,
          check_group,
          require_group,
          gender,
          require_birth,
          require_address,
          injury,
          plan_type,
          require_patient_relationship,
          no_dependent,
          age_halt,
          depend_age,
          student_age,
          adc_age,
          require_coverage_code,
          require_card_begin_date,
          require_card_end_date,
          desi3,
          desi4,
          desi5,
          restrict_otc,
          inject,
          drug_tp_date,
          therapeutic_maintenance,
          therapeutic_mac,
          therapeutic_mac_carrier_id,
          require_drug_tp,
          host_drug_tp,
          ignore_default_drug_tp,
          drug_tp_code,
          require_vendor_tp,
          require_prescriber_phone,
          require_prescriber_tp,
          refill_halt_type,
          both_refill_edits,
          set_expire,
          set_max,
          refill_days_limit,
          maximum_num_refills,
          sched_num_refill,
          num_days,
          pct_days,
          disallow_qty_changes,
          qty_halt_type,
          pass_both_regular_limits,
          pass_both_maint_limits,
          qty_limit_type,
          maximum_qty,
          maximum_days_supply,
          minimum_days_supply,
          max_qty_maint,
          max_maint_days_supply,
          min_maint_days_supply,
          maximum_ml_qty,
          maximum_ml_maint_qty,
          maximum_ml_packs,
          maximum_single_packs,
          maximum_gram_qty,
          maximum_gram_maint_qty,
          maximum_gram_packs,
          initial_fill_max_days,
          round_up,
          max_halt,
          num_override,
          num_rx_depend,
          max_dollar_depend,
          max_dollar_rx,
          max_dollar_card,
          require_generic,
          require_daw,
          require_prior_auth_num,
          low_cost,
          use_discount,
          cost_pct,
          maximum_allowable_cost,
          ignore_mac,
          generic_fee_calc_type,
          taxable,
          transmit_excludes_tax,
          compare_uc,
          uc_price,
          base_sig_dose,
          bubble,
          compound_rate,
          compound_add,
          copay_basis,
          tot_depend,
          diff_amt,
          copay_dollar_limit,
          max_reimburse,
          how_max,
          copay_flag,
          split_copay,
          price_compare,
          copay_uc_compare,
          cash_bill,
          adc_first,
          otc_accumulator,
          disable_cardholder_copay,
          disable_drug_tp_copay,
          disable_ther_restriction_copay,
          sig_on_file,
          pharmacy_xmit_id_type,
          print_dependent_num,
          total_by,
          sort_by,
          split,
          nhin_process,
          transfer_to_acct,
          print_balance,
          num_rebill,
          basis,
          allow_change_price,
          xmit_31,
          service,
          no_paper,
          compound_paper,
          recon_dollar,
          recon_pct,
          card_layout_help_1,
          card_layout_help_2,
          card_layout_help_3,
          card_layout_help_4,
          card_layout_help_5,
          card_layout_help_6,
          plan_text,
          contact,
          begin_coverage_date,
          end_coverage_date,
          require_patient_tp_begin_date,
          require_patient_tp_end_date,
          state_formulary_last,
          no_compound_daw,
          pharmacy_provider_id_qualifier,
          pharmacist_id_qualifier,
          prescriber_xmit_id_qualifier,
          non_complete,
          low_based_acq,
          prescriber_paper_alt_id_type,
          default_prescriber_id,
          prescriber_xmit_alt_id_qual,
          auto_denial,
          software_vendor_id,
          require_depend_num_halt_type,
          require_depend_num,
          ignore_tax,
          card_help,
          plan_select_help,
          require_prescriber_dea_num,
          require_prescriber_state_id,
          require_prescriber_tp_num,
          require_prescriber_ptp_num,
          require_prescriber_alt_num,
          require_prior_auth_type,
          drug_cost_type_id,
          basecost_id,
          tax_id,
          batch_claim_format,
          provider_id,
          display_extra_info_page,
          alt_drug_cost_type_id,
          prescriber_paper_id_type,
          drug_id_type,
          pharmacist_name,
          reversal_days,
          submitter_id,
          uc_fee_id,
          last_host_update_date,
          last_nhin_update_date,
          last_used_date,
          allow_reference_pricing,
          pad_icd9_code,
          check_eligibility,
          allow_partial_fill,
          require_rx_origin,
          do_not_submit_until,
          disallow_autofill,
          mail_required,
          state,
          alt_state,
          mail_days_supply,
          block_other_coverage_code,
          phone_id,
          fax_phone_id,
          host_transmit,
          no_otc_daw,
          adjudicate,
          disallow_workers_comp,
          require_split_intervention,
          require_patient_location,
          use_submit_amount_split_bill,
          send_deductible_copay,
          prev_pharmacy_provider_id_qual,
          prev_pharmacy_provider_id_date,
          require_form_serial_number,
          disallow_faxed_rx_requests,
          minimum_patient_age,
          minimum_patient_age_halt_type,
          disallow_subsequent_billing,
          check_other_coverage_codes,
          days_from_written_schedule_3_5,
          days_from_written_non_schedule,
          require_pickup_relation,
          default_prescriber_id_qual,
          assignment_not_accepted,
          allow_assignment_choice,
          send_both_cob_amounts,
          place_of_service,
          residence,
          send_only_patient_pay_amount,
          require_prescriber_npi_num,
          pharmacy_service_type,
          disallow_direct_marketing,
          require_patient_residence,
          pickup_sig_not_required,
          no_incentives,
          use_price_code_and_plan_fees,
          use_drug_price_code,
          discount_plan,
          group_validation,
          coupon_plan,
          source_timestamp
         from (select q.chain_id,
              q.nhin_store_id,
              q.id,
              q.carrier_code,
              q.plan,
              q.group_code,
              q.plan_name,
              q.eligible,
              q.price_override,
              q.format_card,
              q.format_group,
              q.depend_age,
              q.student_age,
              q.adc_age,
              q.therapeutic_maintenance,
              q.therapeutic_mac,
              q.therapeutic_mac_carrier_id,
              q.refill_days_limit,
              q.maximum_num_refills,
              q.sched_num_refill,
              q.num_days,
              q.pct_days,
              q.pass_both_regular_limits,
              q.pass_both_maint_limits,
              q.qty_limit_type,
              q.maximum_qty,
              q.maximum_days_supply,
              q.minimum_days_supply,
              q.max_qty_maint,
              q.max_maint_days_supply,
              q.min_maint_days_supply,
              q.maximum_ml_qty,
              q.maximum_ml_maint_qty,
              q.maximum_ml_packs,
              q.maximum_gram_qty,
              q.maximum_gram_maint_qty,
              q.maximum_gram_packs,
              q.initial_fill_max_days,
              q.num_rx_depend,
              q.max_dollar_depend,
              q.max_dollar_rx,
              q.max_dollar_card,
              q.cost_pct,
              q.bubble,
              q.compound_rate,
              q.copay_basis,
              q.diff_amt,
              q.copay_dollar_limit,
              q.max_reimburse,
              q.copay_flag,
              q.sig_on_file,
              q.total_by,
              q.sort_by,
              q.num_rebill,
              q.basis,
              q.allow_change_price,
              q.recon_dollar,
              q.recon_pct,
              q.card_layout_help_1,
              q.card_layout_help_2,
              q.card_layout_help_3,
              q.card_layout_help_4,
              q.card_layout_help_5,
              q.card_layout_help_6,
              q.plan_text,
              q.contact,
              q.begin_coverage_date,
              q.end_coverage_date,
              q.state_formulary_last,
              q.pharmacy_provider_id_qualifier,
              q.pharmacist_id_qualifier,
              q.prescriber_xmit_id_qualifier,
              q.prescriber_paper_alt_id_type,
              q.default_prescriber_id,
              q.prescriber_xmit_alt_id_qual,
              q.software_vendor_id,
              q.card_help,
              q.plan_select_help,
              q.drug_cost_type_id,
              q.basecost_id,
              q.tax_id,
              q.batch_claim_format,
              q.provider_id,
              q.alt_drug_cost_type_id,
              q.prescriber_paper_id_type,
              q.drug_id_type,
              q.pharmacist_name,
              q.reversal_days,
              q.submitter_id,
              q.uc_fee_id,
              q.last_host_update_date,
              q.last_nhin_update_date,
              q.last_used_date,
              q.require_rx_origin,
              q.do_not_submit_until,
              q.disallow_autofill,
              q.state,
              q.alt_state,
              q.mail_days_supply,
              q.phone_id,
              q.fax_phone_id,
              q.use_submit_amount_split_bill,
              q.prev_pharmacy_provider_id_qual,
              q.prev_pharmacy_provider_id_date,
              q.require_form_serial_number,
              q.disallow_faxed_rx_requests,
              q.minimum_patient_age,
              q.minimum_patient_age_halt_type,
              q.days_from_written_schedule_3_5,
              q.days_from_written_non_schedule,
              q.default_prescriber_id_qual,
              q.place_of_service,
              q.residence,
              q.require_prescriber_npi_num,
              q.pharmacy_service_type,
              q.no_incentives,
              q.discount_plan,
              q.group_validation,
              q.coupon_plan,
              --q.pharmacy_submit_id_type,
              nvl(q.TP_ERROR_OVERRIDE,'N') TP_ERROR_OVERRIDE,
              nvl(q.CHECK_CARD,'N') CHECK_CARD,
              nvl(q.CHECK_GROUP,'N') CHECK_GROUP,
              nvl(q.REQUIRE_GROUP,'N') REQUIRE_GROUP,
              nvl(q.GENDER,'N') GENDER,
              nvl(q.REQUIRE_BIRTH,'N') REQUIRE_BIRTH,
              nvl(q.REQUIRE_ADDRESS,'N') REQUIRE_ADDRESS,
              nvl(q.INJURY,'N') INJURY,
              nvl(q.PLAN_TYPE,'0') PLAN_TYPE,
              nvl(q.REQUIRE_PATIENT_RELATIONSHIP,'N') REQUIRE_PATIENT_RELATIONSHIP,
              nvl(q.NO_DEPENDENT,'N') NO_DEPENDENT,
              nvl(q.AGE_HALT,'N') AGE_HALT,
              nvl(q.REQUIRE_COVERAGE_CODE,'N') REQUIRE_COVERAGE_CODE,
              nvl(q.REQUIRE_CARD_BEGIN_DATE,'N') REQUIRE_CARD_BEGIN_DATE,
              nvl(q.REQUIRE_CARD_END_DATE,'N') REQUIRE_CARD_END_DATE,
              nvl(q.DESI3,'N') DESI3,
              nvl(q.DESI4,'N') DESI4,
              nvl(q.DESI5,'N') DESI5,
              nvl(q.RESTRICT_OTC,'N') RESTRICT_OTC,
              nvl(q.INJECT,'N') INJECT,
              nvl(q.DRUG_TP_DATE,'W') DRUG_TP_DATE,
              nvl(q.REQUIRE_DRUG_TP,'N') REQUIRE_DRUG_TP,
              nvl(q.HOST_DRUG_TP,'N') HOST_DRUG_TP,
              nvl(q.IGNORE_DEFAULT_DRUG_TP,'N') IGNORE_DEFAULT_DRUG_TP,
              nvl(q.DRUG_TP_CODE,'N') DRUG_TP_CODE,
              nvl(q.REQUIRE_VENDOR_TP,'N') REQUIRE_VENDOR_TP,
              nvl(q.REQUIRE_PRESCRIBER_PHONE,'N') REQUIRE_PRESCRIBER_PHONE,
              nvl(q.REQUIRE_PRESCRIBER_TP,'N') REQUIRE_PRESCRIBER_TP,
              nvl(q.REFILL_HALT_TYPE,'N') REFILL_HALT_TYPE,
              nvl(q.BOTH_REFILL_EDITS,'N') BOTH_REFILL_EDITS,
              nvl(q.SET_EXPIRE,'N') SET_EXPIRE,
              nvl(q.SET_MAX,'N') SET_MAX,
              nvl(q.DISALLOW_QTY_CHANGES,'N') DISALLOW_QTY_CHANGES,
              nvl(q.QTY_HALT_TYPE,'N') QTY_HALT_TYPE,
              nvl(q.MAXIMUM_SINGLE_PACKS,'N') MAXIMUM_SINGLE_PACKS,
              nvl(q.ROUND_UP,'N') ROUND_UP,
              nvl(q.MAX_HALT,'N') MAX_HALT,
              nvl(q.NUM_OVERRIDE,'N') NUM_OVERRIDE,
              nvl(q.REQUIRE_GENERIC,'N') REQUIRE_GENERIC,
              nvl(q.REQUIRE_DAW,'N') REQUIRE_DAW,
              nvl(q.REQUIRE_PRIOR_AUTH_NUM,'N') REQUIRE_PRIOR_AUTH_NUM,
              nvl(q.LOW_COST,'N') LOW_COST,
              nvl(q.USE_DISCOUNT,'N') USE_DISCOUNT,
              nvl(q.MAXIMUM_ALLOWABLE_COST,'N') MAXIMUM_ALLOWABLE_COST,
              nvl(q.IGNORE_MAC,'N') IGNORE_MAC,
              nvl(q.GENERIC_FEE_CALC_TYPE,'N') GENERIC_FEE_CALC_TYPE,
              nvl(q.TAXABLE,'N') TAXABLE,
              nvl(q.TRANSMIT_EXCLUDES_TAX,'N') TRANSMIT_EXCLUDES_TAX,
              nvl(q.COMPARE_UC,'N') COMPARE_UC,
              nvl(q.UC_PRICE,'N') UC_PRICE,
              nvl(q.BASE_SIG_DOSE,'N') BASE_SIG_DOSE,
              nvl(q.COMPOUND_ADD,'N') COMPOUND_ADD,
              nvl(q.TOT_DEPEND,'N') TOT_DEPEND,
              nvl(q.HOW_MAX,'N') HOW_MAX,
              nvl(q.SPLIT_COPAY,'N') SPLIT_COPAY,
              nvl(q.PRICE_COMPARE,'N') PRICE_COMPARE,
              nvl(q.COPAY_UC_COMPARE,'N') COPAY_UC_COMPARE,
              nvl(q.CASH_BILL,'N') CASH_BILL,
              nvl(q.ADC_FIRST,'N') ADC_FIRST,
              nvl(q.OTC_ACCUMULATOR,'N') OTC_ACCUMULATOR,
              nvl(q.DISABLE_CARDHOLDER_COPAY,'N') DISABLE_CARDHOLDER_COPAY,
              nvl(q.DISABLE_DRUG_TP_COPAY,'N') DISABLE_DRUG_TP_COPAY,
              nvl(q.DISABLE_THER_RESTRICTION_COPAY,'N') DISABLE_THER_RESTRICTION_COPAY,
              nvl(q.PHARMACY_XMIT_ID_TYPE,'1') PHARMACY_XMIT_ID_TYPE,
              nvl(q.PRINT_DEPENDENT_NUM,'N') PRINT_DEPENDENT_NUM,
              nvl(q.SPLIT,'N') SPLIT,
              nvl(q.NHIN_PROCESS,'N') NHIN_PROCESS,
              nvl(q.TRANSFER_TO_ACCT,'N') TRANSFER_TO_ACCT,
              nvl(q.PRINT_BALANCE,'N') PRINT_BALANCE,
              nvl(q.XMIT_31,'N') XMIT_31,
              nvl(q.SERVICE,'N') SERVICE,
              nvl(q.NO_PAPER,'N') NO_PAPER,
              nvl(q.COMPOUND_PAPER,'N') COMPOUND_PAPER,
              nvl(q.REQUIRE_PATIENT_TP_BEGIN_DATE,'N') REQUIRE_PATIENT_TP_BEGIN_DATE,
              nvl(q.REQUIRE_PATIENT_TP_END_DATE,'N') REQUIRE_PATIENT_TP_END_DATE,
              nvl(q.NO_COMPOUND_DAW,'N') NO_COMPOUND_DAW,
              nvl(q.NON_COMPLETE,'N') NON_COMPLETE,
              nvl(q.LOW_BASED_ACQ,'N') LOW_BASED_ACQ,
              nvl(q.AUTO_DENIAL,'N') AUTO_DENIAL,
              nvl(q.REQUIRE_DEPEND_NUM_HALT_TYPE,'N') REQUIRE_DEPEND_NUM_HALT_TYPE,
              nvl(q.REQUIRE_DEPEND_NUM,'N') REQUIRE_DEPEND_NUM,
              nvl(q.IGNORE_TAX,'N') IGNORE_TAX,
              nvl(q.REQUIRE_PRESCRIBER_DEA_NUM,'N') REQUIRE_PRESCRIBER_DEA_NUM,
              nvl(q.REQUIRE_PRESCRIBER_STATE_ID,'N') REQUIRE_PRESCRIBER_STATE_ID,
              nvl(q.REQUIRE_PRESCRIBER_TP_NUM,'N') REQUIRE_PRESCRIBER_TP_NUM,
              nvl(q.REQUIRE_PRESCRIBER_PTP_NUM,'N') REQUIRE_PRESCRIBER_PTP_NUM,
              nvl(q.REQUIRE_PRESCRIBER_ALT_NUM,'N') REQUIRE_PRESCRIBER_ALT_NUM,
              nvl(q.REQUIRE_PRIOR_AUTH_TYPE,'N') REQUIRE_PRIOR_AUTH_TYPE,
              nvl(q.DISPLAY_EXTRA_INFO_PAGE,'N') DISPLAY_EXTRA_INFO_PAGE,
              nvl(q.ALLOW_REFERENCE_PRICING,'N') ALLOW_REFERENCE_PRICING,
              nvl(q.PAD_ICD9_CODE,'N') PAD_ICD9_CODE,
              nvl(q.CHECK_ELIGIBILITY,'N') CHECK_ELIGIBILITY,
              nvl(q.ALLOW_PARTIAL_FILL,'N') ALLOW_PARTIAL_FILL,
              nvl(q.MAIL_REQUIRED,'N') MAIL_REQUIRED,
              nvl(q.BLOCK_OTHER_COVERAGE_CODE,'N') BLOCK_OTHER_COVERAGE_CODE,
              nvl(q.HOST_TRANSMIT,'N') HOST_TRANSMIT,
              nvl(q.NO_OTC_DAW,'N') NO_OTC_DAW,
              nvl(q.ADJUDICATE,'N') ADJUDICATE,
              nvl(q.DISALLOW_WORKERS_COMP,'N') DISALLOW_WORKERS_COMP,
              nvl(q.REQUIRE_SPLIT_INTERVENTION,'N') REQUIRE_SPLIT_INTERVENTION,
              nvl(q.REQUIRE_PATIENT_LOCATION,'N') REQUIRE_PATIENT_LOCATION,
              nvl(q.SEND_DEDUCTIBLE_COPAY,'N') SEND_DEDUCTIBLE_COPAY,
              nvl(q.DISALLOW_SUBSEQUENT_BILLING,'N') DISALLOW_SUBSEQUENT_BILLING,
              nvl(q.CHECK_OTHER_COVERAGE_CODES,'N') CHECK_OTHER_COVERAGE_CODES,
              nvl(q.REQUIRE_PICKUP_RELATION,'N') REQUIRE_PICKUP_RELATION,
              nvl(q.ASSIGNMENT_NOT_ACCEPTED,'N') ASSIGNMENT_NOT_ACCEPTED,
              nvl(q.ALLOW_ASSIGNMENT_CHOICE,'N') ALLOW_ASSIGNMENT_CHOICE,
              nvl(q.SEND_BOTH_COB_AMOUNTS,'N') SEND_BOTH_COB_AMOUNTS,
              nvl(q.SEND_ONLY_PATIENT_PAY_AMOUNT,'N') SEND_ONLY_PATIENT_PAY_AMOUNT,
              nvl(q.DISALLOW_DIRECT_MARKETING,'N') DISALLOW_DIRECT_MARKETING,
              nvl(q.REQUIRE_PATIENT_RESIDENCE,'N') REQUIRE_PATIENT_RESIDENCE,
              nvl(q.PICKUP_SIG_NOT_REQUIRED,'N') PICKUP_SIG_NOT_REQUIRED,
              nvl(q.USE_PRICE_CODE_AND_PLAN_FEES,'N') USE_PRICE_CODE_AND_PLAN_FEES,
              nvl(q.USE_DRUG_PRICE_CODE,'N') USE_DRUG_PRICE_CODE,
              nvl(q.DATA_FEED_LAST_UPDATE_DATE,to_TIMESTAMP_NTZ('1900-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS')) source_timestamp,
              '4' source_system_id,
              ROW_NUMBER() OVER(PARTITION BY q.chain_id,q.nhin_store_id,q.id ORDER BY nvl(q.DATA_FEED_LAST_UPDATE_DATE,to_TIMESTAMP_NTZ('1900-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS')) desc) rnk
           from eps_stage.plan_stage q,
            etl_manager.etl_job_high_water_mark hwm,
            etl_manager.etl_job_chain_refresh_frequency rf
          where q.chain_id =hwm.chain_id
          and q.process_timestamp >=  hwm.process_data_begin_date
          and q.process_timestamp < hwm.process_data_end_date
          and hwm.chain_id = q.chain_id
          and hwm.job_name = 'JOB_EPS_STORE_PLAN_EDW'
          and hwm.load_type = 'R'
          and rf.chain_id = hwm.chain_id
          and rf.job_name = hwm.job_name
          and rf.refresh_frequency = 'D'
          and rf.active = 'Y'
       )
      where rnk = 1
      )Q
      WHERE NOT EXISTS
        (
              SELECT NULL
               FROM edw.d_store_plan t
              WHERE q.chain_id=t.chain_id
                AND q.nhin_store_id=t.nhin_store_id
                AND q.id=t.plan_id
                AND q.source_timestamp<t.source_timestamp
                AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               -- AND  1=1 -- no filter on 'sanity_job_count.event_id_filter'

            )
      ),
          tgt AS(select   chain_id,
                  nhin_store_id,
                  plan_id,
                  source_system_id,
                  store_plan_carrier_code,
                  store_plan_plan,
                  store_plan_group_code,
                  store_plan_plan_name,
                  store_plan_eligible_flag,
                  store_plan_tp_error_override_flag,
                  store_plan_price_override_flag,
                  store_plan_format_card,
                  store_plan_check_card_flag,
                  store_plan_format_group,
                  store_plan_check_group_flag,
                  store_plan_require_group_flag,
                  store_plan_gender_flag,
                  store_plan_require_birth_flag,
                  store_plan_require_address_flag,
                  store_plan_injury_flag,
                  store_plan_plan_type,
                  store_plan_require_patient_relationship_flag,
                  store_plan_no_dependent_flag,
                  store_plan_age_halt_flag,
                  store_plan_depend_age,
                  store_plan_student_age,
                  store_plan_adc_age,
                  store_plan_require_coverage_code,
                  store_plan_require_card_begin_date_flag,
                  store_plan_require_card_end_date_flag,
                  store_plan_desi3_flag,
                  store_plan_desi4_flag,
                  store_plan_desi5_flag,
                  store_plan_restrict_otc_flag,
                  store_plan_injectable_flag,
                  store_plan_drug_tp_date_flag,
                  store_plan_therapeutic_maintenance_flag,
                  store_plan_therapeutic_mac_flag,
                  store_plan_therapeutic_mac_carrier_id,
                  store_plan_require_drug_tp_flag,
                  store_plan_host_drug_tp_flag,
                  store_plan_ignore_default_drug_tp_flag,
                  store_plan_drug_tp_code,
                  store_plan_require_vendor_tp_flag,
                  store_plan_require_prescriber_phone_flag,
                  store_plan_require_prescriber_tp_flag,
                  store_plan_refill_halt_type,
                  store_plan_both_refill_edits_flag,
                  store_plan_set_expire_flag,
                  store_plan_set_max_flag,
                  store_plan_refill_days_limit,
                  store_plan_maximum_number_refills,
                  store_plan_schedule_number_refill,
                  store_plan_number_days,
                  store_plan_percent_days,
                  store_plan_disallow_quantity_changes_flag,
                  store_plan_quantity_halt_type,
                  store_plan_pass_both_regular_limits_flag,
                  store_plan_pass_both_maintenance_limits_flag,
                  store_plan_quantity_limit_type,
                  store_plan_maximum_quantity,
                  store_plan_maximum_days_supply,
                  store_plan_minimum_days_supply,
                  store_plan_max_quantity_maintenance,
                  store_plan_max_maintenance_days_supply,
                  store_plan_minimum_maintenance_days_supply,
                  store_plan_maximum_ml_quantity,
                  store_plan_maximum_ml_maintenance_quantity,
                  store_plan_maximum_ml_packs,
                  store_plan_maximum_single_packs,
                  store_plan_maximum_gram_quantity,
                  store_plan_maximum_gram_maintenance_quantity,
                  store_plan_maximum_gram_packs,
                  store_plan_initial_fill_max_days,
                  store_plan_round_up_flag,
                  store_plan_max_halt_code,
                  store_plan_number_override_flag,
                  store_plan_number_rx_dependecy,
                  store_plan_max_dollar_dependecy,
                  store_plan_max_dollar_rx,
                  store_plan_max_dollar_card,
                  store_plan_require_generic_flag,
                  store_plan_require_daw_flag,
                  store_plan_require_prior_auth_number_flag,
                  store_plan_low_cost_flag,
                  store_plan_use_discount_flag,
                  store_plan_cost_percent,
                  store_plan_maximum_allowable_cost_flag,
                  store_plan_ignore_mac_flag,
                  store_plan_generic_fee_calculation_type,
                  store_plan_taxable_flag,
                  store_plan_transmit_excludes_tax_flag,
                  store_plan_compare_uc_flag,
                  store_plan_uc_price_flag,
                  store_plan_base_sig_dose_flag,
                  store_plan_bubble,
                  store_plan_compound_rate,
                  store_plan_add_compound_flag,
                  store_plan_copay_basis,
                  store_plan_total_dependable_flag,
                  store_plan_difference_amount,
                  store_plan_copay_dollar_limit,
                  store_plan_max_reimburse,
                  store_plan_how_max_flag,
                  store_plan_copay_flag,
                  store_plan_split_copay_flag,
                  store_plan_price_compare_flag,
                  store_plan_copay_uc_compare_flag,
                  store_plan_cash_bill_flag,
                  store_plan_adc_first_flag,
                  store_plan_otc_accumulator_flag,
                  store_plan_disable_cardholder_copay_flag,
                  store_plan_disable_drug_tp_copay_flag,
                  store_plan_disable_therapuetic_restriction_copay_flag,
                  store_plan_sig_on_file_flag,
                  store_plan_pharmacy_transmit_id_type,
                  store_plan_print_dependent_number_flag,
                  store_plan_total_by_flag,
                  store_plan_sort_by_flag,
                  store_plan_split_flag,
                  store_plan_nhin_process_code,
                  store_plan_transfer_to_account_flag,
                  store_plan_print_balance_flag,
                  store_plan_number_rebill,
                  store_plan_basis,
                  store_plan_allow_change_price_flag,
                  store_plan_transmit_31_flag,
                  store_plan_service_flag,
                  store_plan_no_paper_flag,
                  store_plan_compound_paper_flag,
                  store_plan_recon_dollar,
                  store_plan_recon_percent,
                  store_plan_card_layout_help_1,
                  store_plan_card_layout_help_2,
                  store_plan_card_layout_help_3,
                  store_plan_card_layout_help_4,
                  store_plan_card_layout_help_5,
                  store_plan_card_layout_help_6,
                  store_plan_plan_text,
                  store_plan_contact,
                  store_plan_begin_coverage_date,
                  store_plan_end_coverage_date,
                  store_plan_require_patient_tp_begin_date_flag,
                  store_plan_require_patient_tp_end_date_flag,
                  store_plan_state_formulary_last,
                  store_plan_no_compound_daw_flag,
                  store_plan_pharmacy_provider_id_qualifier,
                  store_plan_pharmacist_id_qualifier,
                  store_plan_prescriber_transmit_id_qualifier,
                  store_plan_non_complete_flag,
                  store_plan_low_based_acquisition_flag,
                  store_plan_prescriber_paper_alt_id_type,
                  store_plan_default_prescriber_id,
                  store_plan_prescriber_transmit_alt_id_qualifier,
                  store_plan_auto_denial_flag,
                  store_plan_software_vendor_id,
                  store_plan_require_dependent_number_halt_type,
                  store_plan_require_dependent_number_flag,
                  store_plan_ignore_tax_flag,
                  store_plan_card_help,
                  store_plan_plan_select_help,
                  store_plan_require_prescriber_dea_number_flag,
                  store_plan_require_prescriber_state_id_flag,
                  store_plan_require_prescriber_tp_number_flag,
                  store_plan_require_prescriber_ptp_number_flag,
                  store_plan_require_prescriber_alternate_number_flag,
                  store_plan_require_prior_auth_type_flag,
                  store_plan_drug_cost_type_id,
                  store_plan_basecost_id,
                  store_plan_tax_id,
                  store_plan_batch_claim_format,
                  store_plan_provider_id,
                  store_plan_display_extra_info_page_flag,
                  store_plan_alternate_drug_cost_type_id,
                  store_plan_prescriber_paper_id_type,
                  store_plan_drug_id_type,
                  store_plan_pharmacist_name,
                  store_plan_reversal_days,
                  store_plan_submitter_id,
                  store_plan_uc_fee_id,
                  store_plan_last_host_update_date,
                  store_plan_last_nhin_update_date,
                  store_plan_last_used_date,
                  store_plan_allow_reference_pricing_flag,
                  store_plan_pad_icd9_code,
                  store_plan_check_eligibility_flag,
                  store_plan_allow_partial_fill_flag,
                  store_plan_require_rx_origin_flag,
                  store_plan_do_not_submit_until,
                  store_plan_disallow_autofill_flag,
                  store_plan_mail_required_flag,
                  store_plan_state,
                  store_plan_alternate_state,
                  store_plan_mail_days_supply,
                  store_plan_block_other_coverage_code_flag,
                  store_plan_phone_id,
                  store_plan_fax_phone_id,
                  store_plan_host_transmit_flag,
                  store_plan_no_otc_daw_flag,
                  store_plan_adjudicate_flag,
                  store_plan_disallow_workers_comp_flag,
                  store_plan_require_split_intervention_flag,
                  store_plan_require_patient_location_flag,
                  store_plan_use_submit_amount_split_bill_flag,
                  store_plan_send_deductible_copay_flag,
                  store_plan_previous_pharmacy_provider_id_qualifier,
                  store_plan_previous_pharmacy_provider_id_date,
                  store_plan_require_form_serial_number_flag,
                  store_plan_disallow_faxed_rx_requests_flag,
                  store_plan_minimum_patient_age,
                  store_plan_minimum_patient_age_halt_type,
                  store_plan_disallow_subsequent_billing_flag,
                  store_plan_check_other_coverage_codes_flag,
                  store_plan_days_from_written_schedule_3_5,
                  store_plan_days_from_written_non_schedule,
                  store_plan_require_pickup_relation_flag,
                  store_plan_default_prescriber_id_qualifier,
                  store_plan_assignment_not_accepted_flag,
                  store_plan_allow_assignment_choice_flag,
                  store_plan_send_both_cob_amounts_flag,
                  store_plan_place_of_service,
                  store_plan_residence,
                  store_plan_send_only_patient_pay_amount_flag,
                  store_plan_require_prescriber_npi_number,
                  store_plan_pharmacy_service_type,
                  store_plan_disallow_direct_marketing_flag,
                  store_plan_require_patient_residence_flag,
                  store_plan_pickup_signature_not_required_flag,
                  store_plan_no_incentives,
                  store_plan_use_price_code_and_plan_fees_flag,
                  store_plan_use_drug_price_code_flag,
                  store_plan_discount_plan,
                  store_plan_group_validation,
                  store_plan_coupon_plan,
                  source_timestamp
                from  edw.d_store_plan
               where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               ),
               src_minus_tgt AS(SELECT count(*) cnt_src
                  FROM (SELECT * FROM src
                      MINUS
                      SELECT * FROM tgt
                     ) diff
                  ),
             tgt_minus_src AS(SELECT count(*) cnt_tgt
                  FROM (SELECT * FROM tgt
                     MINUS
                    SELECT * FROM src
                     )
                 ),
              event_table as (
                      select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                      ),
              src_table_count as (
                         select count(*) as src_cnt from src
                       ),
               target_table_count as(
                         select count(*) as tgt_cnt from tgt
                        )
            SELECT d1.cnt_src as source_minus_target,
               d2.cnt_tgt as  target_minus_source,
               upper('d_store_plan') table_name,
               e.event_id,
               stc.src_cnt,
               ttc.tgt_cnt,
               case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                 when ttc.tgt_cnt=0 then 0
                 when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
              --else (stc.src_cnt/ttc.tgt_cnt)*100 end as sanity_load_percentage
            FROM src_minus_tgt d1,
               tgt_minus_src d2,
               event_table e,
               src_table_count stc,
               target_table_count ttc
            )

            UNION ALL
            SELECT * FROM (
            WITH src AS
            (
             select *
             from
            (select chain_id,
                nhin_store_id,
                id,
                source_system_id,
                bin_number,
                version_number,
                transaction_code,
                processor_control_number,
                service_provider_id_qual,
                service_provider_ident,
                date_of_service,
                patient_first_name,
                patient_last_name,
                patient_dob,
                place_of_service,
                patient_pregnancy_ind,
                patient_residence,
                pharmacy_provider_id_qual,
                pharmacy_provider_ident,
                prescriber_id_qual,
                prescriber_ident,
                cardholder_ident,
                cardholder_first_name,
                cardholder_last_name,
                person_code,
                patient_relation_code,
                elig_clarification_code,
                home_plan,
                plan_ident,
                group_ident,
                wc_date_of_injury,
                wc_employer_name,
                product_id_qual,
                product_ident,
                quantity_dispensed,
                days_supply,
                other_coverage_code,
                pharmacy_service_type,
                level_of_service,
                prior_auth_type_code,
                prior_auth_number,
                uc_charge,
                gross_amount_due,
                basis_of_cost_determination,
                ingredient_cost,
                patient_paid_amount,
                flat_sales_tax_amount,
                percent_sales_tax_amount,
                percent_sales_tax_rate,
                percent_sales_tax_basis,
                source_timestamp
               from (select q.chain_id,
                    q.nhin_store_id,
                    q.id,
                    q.bin_number,
                    q.version_number,
                    q.transaction_code,
                    q.processor_control_number,
                    q.service_provider_id_qual,
                    q.service_provider_ident,
                    q.date_of_service,
                    q.patient_first_name,
                    q.patient_last_name,
                    q.patient_dob,
                    q.place_of_service,
                    CASE WHEN q.patient_pregnancy_ind = '2' THEN 'Y' ELSE 'N' END patient_pregnancy_ind,
                    q.patient_residence,
                    q.pharmacy_provider_id_qual,
                    q.pharmacy_provider_ident,
                    q.prescriber_id_qual,
                    q.prescriber_ident,
                    q.cardholder_ident,
                    q.cardholder_first_name,
                    q.cardholder_last_name,
                    q.person_code,
                    q.patient_relation_code,
                    q.elig_clarification_code,
                    q.home_plan,
                    q.plan_ident,
                    q.group_ident,
                    q.wc_date_of_injury,
                    q.wc_employer_name,
                    q.product_id_qual,
                    q.product_ident,
                    q.quantity_dispensed,
                    q.days_supply,
                    q.other_coverage_code,
                    q.pharmacy_service_type,
                    q.level_of_service,
                    q.prior_auth_type_code,
                    q.prior_auth_number,
                    q.uc_charge,
                    q.gross_amount_due,
                    q.basis_of_cost_determination,
                    q.ingredient_cost,
                    q.patient_paid_amount,
                    q.flat_sales_tax_amount,
                    q.percent_sales_tax_amount,
                    q.percent_sales_tax_rate,
                    q.percent_sales_tax_basis,
                    q.source_timestamp,
                    '4' source_system_id,
                    ROW_NUMBER() OVER(PARTITION BY q.chain_id,q.nhin_store_id,q.id ORDER BY q.source_timestamp DESC,q.process_timestamp desc) rnk
                 from eps_stage.tp_submit_claim_detail_stage q,
                  etl_manager.etl_job_high_water_mark hwm,
                  etl_manager.etl_job_chain_refresh_frequency rf
                where q.chain_id =hwm.chain_id
                and q.process_timestamp >=  hwm.process_data_begin_date
                and q.process_timestamp < hwm.process_data_end_date
                and hwm.chain_id = q.chain_id
                and hwm.job_name = 'JOB_EPS_TX_TP_SUBMIT_DETAIL_EDW'
                and hwm.load_type = 'R'
                AND q.dml_operation_type in ('I','U')
                and rf.chain_id = hwm.chain_id
                and rf.job_name = hwm.job_name
                and rf.refresh_frequency = 'D'
                and rf.active = 'Y'
             )
            where rnk = 1
            )Q
            WHERE NOT EXISTS
              (
                    SELECT NULL
                     FROM edw.f_tx_tp_submit_detail t
                    WHERE q.chain_id=t.chain_id
                      AND q.nhin_store_id=t.nhin_store_id
                      AND q.id=t.tx_tp_submit_detail_id
                      AND q.source_timestamp<t.source_timestamp
                      AND t.event_id!= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
                     -- AND  1=1 -- no filter on 'sanity_job_count.event_id_filter'

                  )
            ),
          tgt AS(select   chain_id,
                  nhin_store_id,
                  tx_tp_submit_detail_id,
                  source_system_id,
                  tx_tp_submit_detail_bin_number,
                  tx_tp_submit_detail_version_number,
                  tx_tp_submit_detail_transaction_code,
                  tx_tp_submit_detail_processor_control_number,
                  tx_tp_submit_detail_service_provider_id_qualifier,
                  tx_tp_submit_detail_service_provider_identifier,
                  tx_tp_submit_detail_date_of_service,
                  tx_tp_submit_detail_patient_first_name,
                  tx_tp_submit_detail_patient_last_name,
                  tx_tp_submit_detail_patient_dob,
                  tx_tp_submit_detail_place_of_service,
                  tx_tp_submit_detail_patient_pregnancy_flag,
                  tx_tp_submit_detail_patient_residence,
                  tx_tp_submit_detail_pharmacy_provider_id_qualifier,
                  tx_tp_submit_detail_pharmacy_provider_identifier,
                  tx_tp_submit_detail_prescriber_id_qualifier,
                  tx_tp_submit_detail_prescriber_identifier,
                  tx_tp_submit_detail_cardholder_identifier,
                  tx_tp_submit_detail_cardholder_first_name,
                  tx_tp_submit_detail_cardholder_last_name,
                  tx_tp_submit_detail_person_code,
                  tx_tp_submit_detail_patient_relation_code,
                  tx_tp_submit_detail_eligible_clarification_code,
                  tx_tp_submit_detail_home_plan,
                  tx_tp_submit_detail_plan_identifier,
                  tx_tp_submit_detail_group_identifier,
                  tx_tp_submit_detail_workers_comp_date_of_injury,
                  tx_tp_submit_detail_workers_comp_employer_name,
                  tx_tp_submit_detail_product_id_qualifier,
                  tx_tp_submit_detail_product_identifier,
                  tx_tp_submit_detail_quantity_dispensed,
                  tx_tp_submit_detail_days_supply,
                  tx_tp_submit_detail_other_coverage_code,
                  tx_tp_submit_detail_pharmacy_service_type,
                  tx_tp_submit_detail_level_of_service,
                  tx_tp_submit_detail_prior_auth_type_code,
                  tx_tp_submit_detail_prior_auth_number,
                  tx_tp_submit_detail_uc_charge,
                  tx_tp_submit_detail_gross_amount_due,
                  tx_tp_submit_detail_basis_of_cost_determination,
                  tx_tp_submit_detail_ingredient_cost,
                  tx_tp_submit_detail_patient_paid_amount,
                  tx_tp_submit_detail_flat_sales_tax_amount,
                  tx_tp_submit_detail_percent_sales_tax_amount,
                  tx_tp_submit_detail_percent_sales_tax_rate,
                  tx_tp_submit_detail_percent_sales_tax_basis,
                  source_timestamp
                from  edw.f_tx_tp_submit_detail
               where event_id= (select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL')
               ),
               src_minus_tgt AS(SELECT count(*) cnt_src
                  FROM (SELECT * FROM src
                      MINUS
                      SELECT * FROM tgt
                     ) diff
                  ),
             tgt_minus_src AS(SELECT count(*) cnt_tgt
                  FROM (SELECT * FROM tgt
                     MINUS
                    SELECT * FROM src
                     )
                 ),
              event_table as (
                      select max(event_id) as event_id from etl_manager.event where event_type='STAGE TO EDW ETL'
                      ),
              src_table_count as (
                         select count(*) as src_cnt from src
                       ),
               target_table_count as(
                         select count(*) as tgt_cnt from tgt
                        )
            SELECT d1.cnt_src as source_minus_target,
               d2.cnt_tgt as  target_minus_source,
               upper('f_tx_tp_submit_detail') table_name,
               e.event_id,
               stc.src_cnt,
               ttc.tgt_cnt,
               case when ttc.tgt_cnt = 0 and stc.src_cnt=0 then 1
                 when ttc.tgt_cnt=0 then 0
                 when ttc.tgt_cnt!=0 then (stc.src_cnt/ttc.tgt_cnt)*1 end as sanity_load_percentage
              --else (stc.src_cnt/ttc.tgt_cnt)*100 end as sanity_load_percentage
            FROM src_minus_tgt d1,
               tgt_minus_src d2,
               event_table e,
               src_table_count stc,
               target_table_count ttc
            )
       ;;
  }

  ################################################################################################## Dimensions ################################################################################################


  dimension: source_minus_target {
    label: "SOURCE MINUS TARGET COUNT"
    description: "SOURCE MINUS TARGET COUNT"
    type: number
    sql: ${TABLE}.source_minus_target ;;
  }

  dimension: target_minus_source {
    label: "TARGET MINUS SOURCE COUNT"
    description: "TARGET MINUS SOURCE COUNT"
    type: number
    sql: ${TABLE}.target_minus_source ;;
  }

  dimension: table_name {
    label: "Table Name"
    description: "Table Name"
    type: string
    sql: ${TABLE}.table_name ;;
  }

  dimension: event_id {
    label: "Event ID"
    ##hidden: true
    description: "Event ID"
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: src_cnt {
    label: "Source Table Count"
    description: "Source Table Count"
    type: number
    sql: ${TABLE}.src_cnt ;;
  }

  dimension: tgt_cnt {
    label: "Target Table Count"
    description: "Target Table Count"
    type: number
    sql: ${TABLE}.tgt_cnt ;;
  }

  dimension: sanity_load_percentage {
    label: "Sanity load percentage"
    description: "Sanity load percentage"
    value_format: "00.00%"
    type: number
    sql: ${TABLE}.sanity_load_percentage ;;
  }

  ################################################################################################## End of Dimensions #########################################################################################

  filter: event_id_filter {
    label: "Please provide event id for count validation "
    description: "Event id for count validation"
    type: number
    sql: {% condition event_id_filter %} ${event_id} {% endcondition %}
      ;;
  }
}
